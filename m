Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B448310BCB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 14:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBEN2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBENPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 08:15:05 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3BC06178B;
        Fri,  5 Feb 2021 05:14:23 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id l27so6718661qki.9;
        Fri, 05 Feb 2021 05:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0L1NyhlUegaQwi5YXJfbhbjPLPGOMMcTEtEqCRMeLQo=;
        b=Ab+mRX7NGUMCa4Ff0RZ9wAQEVJmz39Aic4C7DjIGWf+Op10X6vOxpTxon9x3SXdJXj
         fjx9crJB9YdM8qbo3I/gVE0imVTAwfh04jDdMreOQ/upGurgxRjfOMCCivw6Tmr8Ls+7
         3LHXjp2PnWIb22c21LE4imL38MZLLLjXTZZyV8NfvognUTNbuVLJfPj634ixLa/3lhGk
         C2/WZpvTPGDf+gJt4Y5Pq6Wy5EW4QyPghM5tc6ar32ZZ0b7YsUzdFnjFE+htocBdgAni
         kfx/m2A+SxO1nA+0HCqidSBUlRpGPWkxmasZ90SE1q+tI4LX+33kK+xwoQz53Hu6EE8m
         lM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0L1NyhlUegaQwi5YXJfbhbjPLPGOMMcTEtEqCRMeLQo=;
        b=WT2L8uGVPIBKH4bi5bKwRptae1d9ek1Wmj4b8GpNujIE46YBw7+T6zrfJ0iZc7i3tN
         +pW8+ZDbu6M4Rh07T8dmrUmB5t8HHqw3fVjSKvll1orHuCp+r1bZ0B5aPrJCMX7tx3/c
         vdojxTs1kkwdbp09z1KQFs0lViFE6gDWi9aLG/LVjC91eQtgmIVjE15lLhvov9mUuk9K
         WzsaEEeTpvkzwrXUw/bLvEAnKmcYE+xYq5enjoOnYHKNEumFQNLFrZK9Yv9iaKfgzXOY
         u5jiJcWCi2ILp5Hwz7yTolVo2HyCj+84Tzwk3rTlkyAyAwPu/rhiCpwowmP/0N9NiLfG
         lp9A==
X-Gm-Message-State: AOAM531S1jwp+RA9S20t1hXlC4/ynz/rD207fAuGGMhOkEnlxQO49GNr
        pNIuKFQvXOIvnxmMVrXYXp40xIRnnkddxQiI
X-Google-Smtp-Source: ABdhPJwsWlmB1AiB3jXP9gJrDFQpPd8EOrj7UpGafE8Qio3fMyc9tWm1WM9ooD4Ph7ouerDhxjuUHQ==
X-Received: by 2002:a37:48cd:: with SMTP id v196mr4049717qka.406.1612530862473;
        Fri, 05 Feb 2021 05:14:22 -0800 (PST)
Received: from ArchLinux ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id 75sm8026451qta.68.2021.02.05.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:14:21 -0800 (PST)
Date:   Fri, 5 Feb 2021 18:44:12 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drivers: cpufreq: Change a word with a word , good one
 in the file powernow-k7.c
Message-ID: <YB1EpOafQiNjFkxk@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210205125144.1407032-1-unixbhaskar@gmail.com>
 <CAJZ5v0hokLPQML9wWuo9aqcQGZeMc5k9a+fzPKs4mZe5p11_mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wsikg3gXRHJ+9JAC"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hokLPQML9wWuo9aqcQGZeMc5k9a+fzPKs4mZe5p11_mw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Wsikg3gXRHJ+9JAC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:08 Fri 05 Feb 2021, Rafael J. Wysocki wrote:
>On Fri, Feb 5, 2021 at 1:55 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>>
>>
>>
>> s/fucked/messed/
>
>I wouldn't make the changelog so explicit, just say "Use more
>appropriate language" or similar.
>
okay.
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/cpufreq/powernow-k7.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
>> index 5d515fc34836..2e114fc75e68 100644
>> --- a/drivers/cpufreq/powernow-k7.c
>> +++ b/drivers/cpufreq/powernow-k7.c
>> @@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
>>  }
>>
>>  /*
>> - * Some Athlon laptops have really fucked PST tables.
>> + * Some Athlon laptops have really messed PST tables.
>
>Or even "broken".
>
Alright!
>>   * A BIOS update is all that can save them.
>>   * Mention this, and disable cpufreq.
>>   */
>> --
>> 2.30.0
>>

--Wsikg3gXRHJ+9JAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAdRKQACgkQsjqdtxFL
KRUCqwgAz47dSDxX/xmBdaqHgVSZcjGcwTlm484MyacQh4RFByu/goNkYvoWPxtt
RLn3E9Puy9OUD/JieyVCe3OS8+OO16JeT9belj3YsvOdvTGi7Y6uTq1VdL6porUx
tF4vZgNclHqIHb2JlH/cK2HCDxPKtcrH1zE4XYo/349a8IMWZfWbEzQ2+D7yh+Je
PVGyRYl04jqjnF8OL7LO8ZW5sHJMvg9Axeq5HhU4IL3MiHerFYm1tzQeUVtzeb7s
N6wHPjXY+II2dguf8pN477sTivO/zwCkAr/VVcuHn9xYhpkqjBpZypqPdwhRt9h1
mlgnR1Vog10YZGBZeMvpwCAKFxAH5w==
=FnNl
-----END PGP SIGNATURE-----

--Wsikg3gXRHJ+9JAC--
