Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7512E337
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 08:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgABHB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 02:01:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46223 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727663AbgABHB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 02:01:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 379972224E;
        Thu,  2 Jan 2020 02:01:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 02:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=p
        HaGh/CRjB9dqX9pcqIa0Cf2JnihMC69wf/6ZnG2fa0=; b=kw8wAxVgtZ/uW2IJY
        L22wbpCDSIcA10lPV9/f+QLyUk4OcfIA89FpmZ4SF8gGunF1447187op+dJHkeAE
        FSCvpqO1VXm4ou3N3zsFZQeQWs3wXZRZEJ7VagT1iot18SUs62bdxorLofh6e02U
        fI5VhPvlYigFrPP/v2JjMHSXaE1diyMmwZM+XsYtv1DBKG4NYL7KZfu7rc98Y9SE
        +pRlDrpyHRmAjTIdmsizqwviw59RPXdmCqE/1ldAqZwFzMR3GmDa845QXHPtKbiZ
        hp7pQvjeVzWxlPX5PQJ2JuIc+xPm00uKLhX68DFobMgUOi6SURgpvuUgAxy8W9r2
        zlY9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=pHaGh/CRjB9dqX9pcqIa0Cf2JnihMC69wf/6ZnG2f
        a0=; b=l0ceP7AMaha/q40dZIfeAIE4RbNSN7DRF0hf3FMaeYzsD6Lw1+cNzD/YK
        p92Fr6IADX70XaCUn9vocbPyp386LeDCLzM7DcG/WCBOYlIfK+jE0V1+165lKXlt
        SbOAMz5InLra16wjjspXLEyYoUO2e6lusA0jpAovSVRS3IuUEQhBr+pOmiB+loU/
        T+ef/0mWb/9KfV2QApWw/TTKr3SBtTUq6BcRF/aa7HMIWAJj/IYDGfeuNdh3JHqB
        QWqAIml5YcXQ1SP4tfzkRC8fqzsDRBjtYsNVKJWFE6jOoFyApXKt/VUpvGstGz2x
        cPHElPe9iJIE4xMJSbA/c7puG3+6Q==
X-ME-Sender: <xms:Y5UNXvYPHrICMWAMK9jXRJN-lnJnt0KgZlM5ubFiNG3ShBPRVuZDNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukf
    hppeejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Y5UNXs7i733FLtMbyJNpTle4Jjo6E5aUR6YNB4kJrWd_DTu_BYXVEw>
    <xmx:Y5UNXoobiiivz6aAZLzSaZomFlVzS14wT_87UCunfH8VeNQXYzw_SA>
    <xmx:Y5UNXkyg-PJ6x175d2g3kmHRZatPKzWPgIvlPy3Gwj_lCFIom46snw>
    <xmx:ZJUNXkOP8FCX6OzU0EFhlxx189decbFKrkuIYdcisFDoU4m35bL3lQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95E6080061;
        Thu,  2 Jan 2020 02:01:55 -0500 (EST)
Subject: Re: [PATCH 1/7] power: supply: axp20x_ac_power: Allow offlining
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200102063633.65388-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0118a2f5-bd7b-e719-06f9-8665912aa553@sholland.org>
Date:   Thu, 2 Jan 2020 01:01:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/2/20 12:36 AM, Samuel Holland wrote:
> AXP803/AXP813 have a flag that enables/disables the AC power supply
> input. Allow control of this flag via the ONLINE property on those
> variants.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> index 0d34a932b6d5..4410e7b89383 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -23,6 +23,8 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
>  
> +#define AXP813_ACIN_PATH_SELECT		BIT(7)
> +
>  #define AXP813_VHOLD_MASK		GENMASK(5, 3)
>  #define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
>  #define AXP813_VHOLD_REG_TO_UV(x)	\
> @@ -143,6 +145,11 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
>  	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
>  
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
> +					  AXP813_ACIN_PATH_SELECT,
> +					  !!val->intval);
> +

Sorry, I failed to use regmap_update_bits properly here and in
patch 5. I'll send a v2 with the value shifted properly.

>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>  		if (val->intval < 4000000 || val->intval > 4700000)
>  			return -EINVAL;
> @@ -169,7 +176,8 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
>  static int axp813_ac_power_prop_writeable(struct power_supply *psy,
>  					  enum power_supply_property psp)
>  {
> -	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +	return psp == POWER_SUPPLY_PROP_ONLINE ||
> +	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
>  	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
>  }
>  
> 

