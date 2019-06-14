Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFB45AEE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfFNKwW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 06:52:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33267 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNKwW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 06:52:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so2057303wru.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vwrk+AgrEhYlE80M3+MGdcU7iUcY3uN9bVr59vASP0=;
        b=Viq4BvGdowF1J5eJcqGDhNe6hoIU2YzXZua720oX7YMhb83Dfr0dSktGPGVma6nIVa
         rovFdaZM5CiklG3z0VpthS94btRCRUmi0KjvriE+vDi3DUWwRLvxZJ84qBlfXcHPNi/g
         ipvaA864SZADzLVdyv9rD2Q2H+nkljmucwelQzb/6gHWvY8ssR3CkFDKoOtbLG5cf2ew
         4yUbHAK69zumdcN5pxTujDZpRmm3skEucXr2ZP8xZdpTzcFHcZE66NVhXYH13lRKx7d8
         qtLJeezSKeWL10JoCzqoPifvI/MhUtcb6wz2J+wK0XUaIBmzfxC/GmDMmEKPq71ux4Pr
         wNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+vwrk+AgrEhYlE80M3+MGdcU7iUcY3uN9bVr59vASP0=;
        b=I7zOM9uWmbNKsvgU1UQKnVzH9vecrpX9c2e08JH7d6hm5r33IVbFNNuEYxFfPr0XTq
         QX0ZH9k46agWjUdBUSCuMvDz65v9zPNEwyhG1TcY8yV2n6FNU1zgFsIQy9VkpYQNH7Qr
         8ATvA+dXnazfgUAlzogHxHdR1EGX9z1iB0OiFApX1NdVz8t8YcWqnGwKxdA1R6JMpA0e
         0dr17t3y5k5DZ0j/ZnkttTU4IpeH0oarnJNWmVLJNjMJ0kH9pQ12IaAM1KoceaxUM981
         aq3pbNCK9fSpHda3s64nFNKRlVbcHWhAgN3ihknjL/J+wXVwEUTIE/NgH0jybido+mIq
         dEMg==
X-Gm-Message-State: APjAAAUT6tRrfR0HVlT4hHb7z0UBrMpZEzt9Vy7/GMOyY1AVfUk1Ajti
        aN4h7Mnlln4Q6g4JH5pT5FTBNw==
X-Google-Smtp-Source: APXvYqw1S3/O1d0sqNf14VVfEd1n0a/IXQOLeDdJXieMrTyT3NdvFieJMT/Pt7d/4PbCr7O6cb+8wA==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr16811884wrn.168.1560509539430;
        Fri, 14 Jun 2019 03:52:19 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r3sm4220947wrr.61.2019.06.14.03.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 03:52:18 -0700 (PDT)
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
To:     Nathan Huckleberry <nhuck@google.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
References: <20190613211228.34092-1-nhuck@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
Date:   Fri, 14 Jun 2019 12:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613211228.34092-1-nhuck@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Nathan,

On 13/06/2019 23:12, Nathan Huckleberry wrote:
> Clang produces the following warning
> 
> vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a negative
> signed value is undefined [-Wshift-negative-value] / (ptat[0] - ptat[2])) +
> FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~ drivers/thermal/rcar_gen3_thermal.c:126:29
> note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x) <<
> FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18: warning:
> shifting a negative signed value is undefined [-Wshift-negative-value]
> tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> 
> Upon further investigating it looks like there is no real reason for
> TJ_3 to be -41. Usages subtract -41, code would be cleaner to just add.

All the code seems broken regarding the negative value shifting as the
macros pass an integer:

eg.
        tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
                                 tsc->tj_t - FIXPT_INT(ths_tj_1));

thcode[1] is always < than thcode[0],

thcode[1] - thcode[0] < 0

FIXPT_INT(thcode[1] - thcode[0]) is undefined


Is it done on purpose FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]) ?

Try developing the macro with the coef.a2 computation ...

The code quality of this driver could be better, it deserves a rework
IMHO ...

I suggest to revert:

4eb39f79ef443fa566d36bd43f1f578d5c140305
bdc4480a669d476814061b4da6bb006f7048c8e5
6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144

Rework the coefficient computation and re-introduce what was reverted in
a nicer way.


> Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of Tj_1")
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/531
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index a56463308694..f4b4558c08e9 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -131,7 +131,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
>  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
>  
>  /* no idea where these constants come from */
> -#define TJ_3 -41
> +#define TJ_3 41
>  
>  static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
>  					 int *ptat, const int *thcode,
> @@ -144,11 +144,11 @@ static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
>  	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
>  	 */
>  	tsc->tj_t = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> -		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> +		     / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
>  
>  	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> -				 tsc->tj_t - FIXPT_INT(TJ_3));
> -	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
> +				 tsc->tj_t + FIXPT_INT(TJ_3));
> +	tsc->coef.b1 = FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
>  
>  	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
>  				 tsc->tj_t - FIXPT_INT(ths_tj_1));
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

