Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908BC14A685
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgA0OuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 09:50:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgA0OuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 09:50:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 97E1C293CA5
Subject: Re: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200124231834.63628-1-pmalani@chromium.org>
 <20200124231834.63628-3-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <495e2427-7233-cb4d-0128-f6926969fb8a@collabora.com>
Date:   Mon, 27 Jan 2020 15:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200124231834.63628-3-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prashant,

On 25/1/20 0:18, Prashant Malani wrote:
> Add a check to ensure there is indeed an EC device tree entry before
> adding the cros-usbpd-notify device. This covers configs where both
> CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
> using device tree and not in ACPI.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

With this change, an playing with different CONFIG_ACPI + CONFIG_OF combinations
I don't see anymore the problem where the driver is registered twice on
CONFIG_ACPI side. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Maybe it requires a fixes tag if Lee already picked the other patch?

Fixes: 4602dce0361e ("mfd: cros_ec: Add cros-usbpd-notify subdevice")

> ---
> 
> Changes in v8:
> - Patch first introduced in v8 of the series.
> 
>  drivers/mfd/cros_ec_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d0c28a4c10ad0..411e80fc9a066 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	 * explicitly added on platforms that don't have the PD notifier ACPI
>  	 * device entry defined.
>  	 */
> -	if (IS_ENABLED(CONFIG_OF)) {
> +	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
>  		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
>  			retval = mfd_add_hotplug_devices(ec->dev,
>  					cros_usbpd_notify_cells,
> 
