Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461EE639D5C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiK0VgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiK0VgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:12 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0621FD2F2
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:12 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 80B528400F;
        Sun, 27 Nov 2022 22:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584970;
        bh=qMYW/xrR1ezYvEAi6pcUjmuLG3pWKeKIi/bHKw6+iMY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fMPlgu9N5QSOzMJLMGtmSPWENPwzSX1L72SRZEw+Fblkgwhy9nZ4WtTGkfshR8dlQ
         O6q2OUE487I3ctWR4eWGy33XtMsDBVfGwLdPg03+p6SYMWColmhc6yLISi9IbbU36w
         k6csvDydpuP4yYGTduHDqDCk5uCaabc9LqUPj3+xAnW0HBIJ6FDbwZoLr9yGG9JcVv
         2FpNlyWbwiNldKPo58nJwYipt1PE5J3ABgB8wtLtzQWOAZkyxZcl5XNKMuhZwfYwIw
         654U3U1zYChmtG+G+N/p/+AuGe04nerilT6iZutXxHs4UeniIaPVbihHybkTCKbPDp
         ++fiOxgn/+EzA==
Message-ID: <d2f2fe8f-9463-d496-dc4f-e3f27dd84526@denx.de>
Date:   Sun, 27 Nov 2022 22:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 10/10] power: supply: bq25890: Add new
 linux,iinlim-percentage property
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-11-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-11-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/27/22 19:02, Hans de Goede wrote:
> Some devices, such as the Lenovo Yoga Tab 3 Pro (YT3-X90F) have
> multiple batteries with a separate bq25890 charger for each battery.
> 
> This requires the maximum current the external power-supply can deliver
> to be divided over the chargers. The Android vendor kernel shipped
> on the YT3-X90F divides this current with a 40/60 percent split so that
> batteries are done charging at approx. the same time if both were fully
> empty at the start.
> 
> Add support for a new "linux,iinlim-percentage" percentage property which
> can be set to indicate that a bq25890 charger should only use that
> percentage of the external power-supply's maximum current.
> 
> So far this new property is only used on x86/ACPI (non devicetree) devs,
> IOW it is not used in actual devicetree files. The devicetree-bindings
> maintainers have requested properties like these to not be added to the
> devicetree-bindings, so the new property is deliberately not added
> to the existing devicetree-bindings.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/power/supply/bq25890_charger.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index b0d07ff24ace..2bd7721b969f 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -126,6 +126,7 @@ struct bq25890_device {
>   	bool read_back_init_data;
>   	bool force_hiz;
>   	u32 pump_express_vbus_max;
> +	u32 iinlim_percentage;

If this is percentage, u8 should be enough, right ?

>   	enum bq25890_chip_version chip_version;
>   	struct bq25890_init_data init_data;
>   	struct bq25890_state state;
> @@ -727,6 +728,18 @@ static int bq25890_power_supply_property_is_writeable(struct power_supply *psy,
>   	}
>   }
>   
> +/*
> + * If there are multiple chargers the maximum current the external power-supply
> + * can deliver needs to be divided over the chargers. This is done according
> + * to the bq->iinlim_percentage setting.
> + */
> +static int bq25890_charger_get_scaled_iinlim_regval(struct bq25890_device *bq,
> +						    int iinlim_ua)
> +{
> +	iinlim_ua = iinlim_ua * bq->iinlim_percentage / 100;

Can this ever add up to value above 100 ?
Should this use some clamp() ?

> +	return bq25890_find_idx(iinlim_ua, TBL_IINLIM);
> +}
> +
>   /* On the BQ25892 try to get charger-type info from our supplier */
>   static void bq25890_charger_external_power_changed(struct power_supply *psy)
>   {

[...]
