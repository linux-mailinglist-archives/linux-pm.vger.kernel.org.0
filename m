Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4196A1A83DC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgDNP4c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732242AbgDNP4a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 11:56:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F6C061A0C;
        Tue, 14 Apr 2020 08:56:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E875C2A04F7
Subject: Re: [PATCH 1/4] power: supply: core: Constify usb_types
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
 <20200413183853.1088823-2-sebastian.reichel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <04382a4b-d26e-0933-10e7-5d93595de0f2@collabora.com>
Date:   Tue, 14 Apr 2020 17:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413183853.1088823-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 13/4/20 20:38, Sebastian Reichel wrote:
> usb_types is a list of USB types supported by the
> hardware, which does not change at runtime. Let's
> mark it as const for improved security.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  include/linux/power_supply.h              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index f37ad4eae60b..45dafc1820ff 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -78,7 +78,7 @@ static const char * const power_supply_scope_text[] = {
>  };
>  
>  static ssize_t power_supply_show_usb_type(struct device *dev,
> -					  enum power_supply_usb_type *usb_types,
> +					  const enum power_supply_usb_type *usb_types,
>  					  ssize_t num_usb_types,
>  					  union power_supply_propval *value,
>  					  char *buf)
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index dcd5a71e6c67..0392c9cc8f1c 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -223,7 +223,7 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> -	enum power_supply_usb_type *usb_types;
> +	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
>  	enum power_supply_property *properties;
>  	size_t num_properties;
> 
