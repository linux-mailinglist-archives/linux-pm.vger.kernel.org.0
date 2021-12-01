Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F6946547E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351980AbhLASBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 13:01:20 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47819 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352134AbhLASA7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 13:00:59 -0500
X-Greylist: delayed 28431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 13:00:59 EST
Received: (Authenticated sender: foss@0leil.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E8660C0007;
        Wed,  1 Dec 2021 17:57:31 +0000 (UTC)
Date:   Wed, 1 Dec 2021 18:57:28 +0100
From:   Quentin Schulz <foss@0leil.net>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: [PATCH] power: supply: axp20x_battery: set charging voltage via
 DT
Message-ID: <20211201175728.ja7a5iilm23vyblr@fiqs>
References: <20211119175740.405446-1-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119175740.405446-1-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Evgeny,

On Fri, Nov 19, 2021 at 08:57:40PM +0300, Evgeny Boger wrote:
> The driver should use maximum constant charge voltage property
> from battery description provided by power supply core by default
> instead of fixed 4.2V. This value can be later changed at runtime.
> 
> The battery description is normally set via device tree, as described
> in Documentation/devicetree/bindings/power/supply/battery.yaml
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 18a9db0df4b1..83c5ffa24bd1 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -617,6 +617,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
>  		int vmin = info.voltage_min_design_uv;
>  		int ccc = info.constant_charge_current_max_ua;
> +		int vcv = info.constant_charge_voltage_max_uv;
> +
> +		if (vcv > 0 && axp20x_batt->data->set_max_voltage(axp20x_batt,
> +								  vcv))
> +			dev_err(&pdev->dev,
> +				"couldn't set charge constant voltage from DT");
>  

The issue here is that only specific values are possible. e.g. for
axp20x: 4.1 4.15 4.2V, axp22x 4.1 4.2V, there's nothing in-between.

I don't think the battery node should know what the PMIC is capable of
outputting.

Would it make sense to find the closest value to the one appropriate for
the battery that is supported by the PMIC (lesser or equal to the one
specified by the battery obviously)?

Otherwise, I would imagine this function would fail most of the time
because it's not the exact voltage supported by the PMIC?

Completely off-topic, but I also see that batteries now support
specifying which technology they use so it should be safe to raise the
maximum for some technologies above what we currently support in the
driver. e.g. axp22x supports 4.22 and 4.24V too but they aren't
selectable at the moment.

Cheers,
Quentin
