Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643C112F5D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 17:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfLDQBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 11:01:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41260 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDQBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 11:01:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so2825524wrw.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iYb6wN9lQEPhRu0HekmEpVrSJdRJ5ZqElSHZSATtrQ8=;
        b=V96hlkUWGXx4LCz86fpc9LcXLEF/e+TZIlyLFCB/nYc5MqL3qcL2ksCRha1Mk54UrB
         gxItVOrVbZsctkHESw2wWHpFUP9s3UcgHJFuSDLNllOElH9CslAw6QdB4alH3hKmV6GW
         06xpyXMqv6xXaovtkXVIO1PUuqLvx9l74k0Ze0VxLTSviKUN+6sJkN1HuhDdSAHkYFkb
         KAUZUcgxCnIjnFmD0/0svvfYjg2YjiBA5C60afqmsOrvY1fWoc6K90g2kS0F+45zXWrD
         neW7xBvpzvVzNTPe+lzWz4Xkk54F7gZGgLg7Sb5wSnMTPZbJrKK4v/7IzPkQDR6Z0ju6
         m4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iYb6wN9lQEPhRu0HekmEpVrSJdRJ5ZqElSHZSATtrQ8=;
        b=KYFiV68VGIlIEEI5XpFZP7nXQerX3rlxidfiHJLPs2rAtk1GKOKANKlb3yQVCYN4Oc
         t5W8rcGktWeaqZvcj6FItDODpP3f1aPoVLO6ldqiMfH2hnvod4jUzxPcu7XOB/hLXFi3
         CdvhRpPKqW5XCaJllWckc4XR/rpnhD5bhDsqsgoJEP6kEWvwIYya5KJwLrZwxeLiG7GT
         p74UO6ziWOfeWfoILqqptN2xQZ/otDwpXHU3Oyh02btgcRGWh3aKMynCHgIz/p6PLdbH
         MRISVfvj5Gipl1+/Vxd2SULeW2/iaJsNMwATYWYsZVKhaEFFv+gE9kRG9Qd9uMGufCSL
         G/Kw==
X-Gm-Message-State: APjAAAViDPKjA3OSyohgwAmWh82BDD0lJ2j5eD7RGbk2baotfwHS+Q3s
        Ps2vWqQifEIE1USaaep+Z0iNeMqFkBA=
X-Google-Smtp-Source: APXvYqyiDZaXslgJlDsjrFh7hkFMESj8tEUDdA11U9F+g4D94gMt9Q7KOwTakz/hw0Gtk+yN5ug/fw==
X-Received: by 2002:a5d:6b51:: with SMTP id x17mr5057857wrw.148.1575475309429;
        Wed, 04 Dec 2019 08:01:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:d965:ceae:a314:6edb? ([2a01:e34:ed2f:f020:d965:ceae:a314:6edb])
        by smtp.googlemail.com with ESMTPSA id d10sm8547653wrw.64.2019.12.04.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 08:01:48 -0800 (PST)
Subject: Re: [PATCH] thermal: db8500: Depromote debug print
To:     Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
References: <20191119074650.2664-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7a463c01-8fca-894f-ca36-910e5fb7b6cd@linaro.org>
Date:   Wed, 4 Dec 2019 17:01:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119074650.2664-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/11/2019 08:46, Linus Walleij wrote:
> We are not interested in getting this debug print on our
> console all the time.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Fixes: 6c375eccded4 ("thermal: db8500: Rewrite to be a pure OF sensor")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!

> ---
>  drivers/thermal/db8500_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 372dbbaaafb8..21d4d6e6409a 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -152,8 +152,8 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
>  		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
>  					     next_low, next_high);
>  
> -		dev_info(&th->tz->device,
> -			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
> +		dev_dbg(&th->tz->device,
> +			"PRCMU set max %ld, min %ld\n", next_high, next_low);
>  	} else if (idx == num_points - 1)
>  		/* So we roof out 1 degree over the max point */
>  		th->interpolated_temp = db8500_thermal_points[idx] + 1;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

