Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0D41711B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbhIXLrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 07:47:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56118
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343584AbhIXLrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 07:47:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C05993F226
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632483931;
        bh=Rktmb+c/jmGGJpbEWYmUQWQyyChLN+sZ5YGx4agFeyU=;
        h=To:References:From:Cc:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NRTEA4ywWWGsXNWP4NMGiOwi6Wc92KV3+3Vd1RKb55JSV42MHbhiqvLRHyjjSFTqY
         gYEKocCR3QPN5qfsMyAnQFY3bDOOnsCWdz3s8/mWhJtzMpbfjmWlSQj/z2AnAW6s49
         Vm194o/UxmFPyOHovoQT9KU1ers7uBynlWeur4aKxBUkizcrm4wusSIPC/HBaol7px
         Vc81uMBu6OmOuYY8C63DghgYGBmuU7fb7K39Y/Y3WDjAiQ+tZTL6u1zi43IgWddxGL
         isIEEpxkLykt8KpzdWQ7TYdaFNMlrh/yfdUZJHpBp4ma/2+6IicQ+BE+afhiPOBKCG
         WVdzcmbRco0CA==
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so7793301wrp.16
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 04:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rktmb+c/jmGGJpbEWYmUQWQyyChLN+sZ5YGx4agFeyU=;
        b=R7rNEy0oW8vVRYauJsJTCzLeR0Dy9aWbffqmBi7MW/aNAtSLoEj087cAumfWRD0vO3
         oX/2jFppSp41cnTbFOVgbhGoEuLdyDRMxwcqIseCY3WN/xOjGQb9e8IRoB9Gfk65J4z3
         PvO2wVWO+eT5DBYN5yKG0HW+vNpgIBHkvdXs6kVZPbzEP7eZABtuXVcMZmLNHs9TvtqS
         pnuDcmEtfKMcWSTq+hNSrplekYUGFi+5znFOpRviG3nNCaKanT2js9zzgJ4I+GmKGe7I
         ZFCKlQEMU6e4sxYtbubwKI74QIM62hCoWQR2H0TuhBiIRrNAjzyN/DmrVIjfbQ4oPFV8
         LeCg==
X-Gm-Message-State: AOAM533Fxmi5XOzfcU80hnAMnnR+frxCynNx7IKwm/zOfCHqIZBXuWEN
        agdSA+hqC64f6udWxKaQ8jfCskuaI6n6fADTo4Ag0Im4Zy6fIPQDWveyXkzlxwRdPQHT6PKSaNF
        niHTiaGXW51qawbj1JZCOXSUoBaBR2s9E2Oqj
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr1573618wmj.183.1632483931094;
        Fri, 24 Sep 2021 04:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkYUFV3B7g5xCWZDPrK8dWvrpcRvuqDvM2ibYLLbikrHkDphlAXQgkW94Kg0w3tSgaQ5hzLQ==
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr1573604wmj.183.1632483930884;
        Fri, 24 Sep 2021 04:45:30 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h15sm7741993wrc.19.2021.09.24.04.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 04:45:30 -0700 (PDT)
To:     Henrik Grimler <henrik@grimler.se>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for
 capacity when no rsns
Message-ID: <17ba5aaa-c456-2bb9-1680-ff0a302b412f@canonical.com>
Date:   Fri, 24 Sep 2021 13:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919200735.142862-2-henrik@grimler.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2021 22:07, Henrik Grimler wrote:
> On Galaxy S3 (i9300/i9305), which has the max17047 fuel gauge and no
> current sense resistor (rsns), the RepSOC register does not provide an
> accurate state of charge value. The reported value is wrong, and does
> not change over time. VFSOC however, which uses the voltage fuel gauge
> to determine the state of charge, always shows an accurate value.
> 
> At least one max170xx driver, found in Asus' Z00D kernel [1], chooses
> how to get the capacity based on if current sense is available or not.
> Lets change the mainline driver to match the Asus Z00D driver's
> behaviour and thereby fix so that correct state of charge values are
> obtained on Galaxy S3.
> 
> [1] https://github.com/LineageOS/android_kernel_asus_Z00D/blob/c7ab0e3ec5b5/drivers/power/max17042_battery.c#L1103-L1105
> 
> Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  drivers/power/supply/max17042_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 622bdae6182c..7233670978d0 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -317,7 +317,10 @@ static int max17042_get_property(struct power_supply *psy,
>  		val->intval = data * 625 / 8;
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		ret = regmap_read(map, MAX17042_RepSOC, &data);
> +		if (chip->pdata->enable_current_sense)
> +			ret = regmap_read(map, MAX17042_RepSOC, &data);
> +		else
> +			ret = regmap_read(map, MAX17042_VFSOC, &data);

Thanks for the patch. I found also my comments to Wolfgang's patch in
2016, which you resolve here but I have more. :)

I think my previous message about current sense are not correct. What is
important is whether ModelGauge is being used/configured. For example
none of DT platforms support it but ACPI might.

There is incoming patch around it:
https://lore.kernel.org/lkml/5702731.UytLkSCjyO@pliszka/

If you switch to VSSoc, I think you need to modify the SOC Alert Config
in MiscCFG register (bits 0:1 to 0x1). Otherwise the alerts will be
generated on different value.

Different topic:
When touching Exynos-based boards (like Galaxy S3), please Cc me as
well, even if I don't pop up in the maintainers.

For max17042 we need to Cc broader group of users, for example using it
in ACPI platforms. The best is to pick the contributors.

Best regards,
Krzysztof
