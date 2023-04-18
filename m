Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D86E57F1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 05:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDRD6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 23:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDRD6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 23:58:11 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37B421B
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 20:58:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VgNoJlQ_1681790286;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgNoJlQ_1681790286)
          by smtp.aliyun-inc.com;
          Tue, 18 Apr 2023 11:58:06 +0800
Message-ID: <cf5ef608-078e-3f46-a6b7-9a8ec2bf8e15@linux.alibaba.com>
Date:   Tue, 18 Apr 2023 11:58:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/6] power: supply: sc27xx: Fix external_power_changed
 race
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <20230415160734.70475-1-hdegoede@redhat.com>
 <20230415160734.70475-5-hdegoede@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230415160734.70475-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/16/2023 12:07 AM, Hans de Goede wrote:
> sc27xx_fgu_external_power_changed() dereferences data->battery,
> which gets sets in ab8500_btemp_probe() like this:
> 
> 	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
>                                                     &fgu_cfg);
> 
> As soon as devm_power_supply_register() has called device_add()
> the external_power_changed callback can get called. So there is a window
> where sc27xx_fgu_external_power_changed() may get called while
> data->battery has not been set yet leading to a NULL pointer dereference.
> 
> Fixing this is easy. The external_power_changed callback gets passed
> the power_supply which will eventually get stored in data->battery,
> so sc27xx_fgu_external_power_changed() can simply directly use
> the passed in psy argument which is always valid.
> 
> After this change sc27xx_fgu_external_power_changed() is reduced to just
> "power_supply_changed(psy);" and it has the same prototype. While at it
> simply replace it with making the external_power_changed callback
> directly point to power_supply_changed.
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Note this has been compile tested only
> ---
>   drivers/power/supply/sc27xx_fuel_gauge.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index 632977f84b95..bd23c4d9fed4 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
>   	return ret;
>   }
>   
> -static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
> -{
> -	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
> -
> -	power_supply_changed(data->battery);
> -}
> -
>   static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
>   					    enum power_supply_property psp)
>   {
> @@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
>   	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
>   	.get_property		= sc27xx_fgu_get_property,
>   	.set_property		= sc27xx_fgu_set_property,
> -	.external_power_changed	= sc27xx_fgu_external_power_changed,
> +	.external_power_changed	= power_supply_changed,
>   	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
>   	.no_thermal		= true,
>   };
