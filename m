Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58C63399EF
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 00:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhCLXQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 18:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbhCLXQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 18:16:32 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F86C061574;
        Fri, 12 Mar 2021 15:16:31 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c6so5152771qtc.1;
        Fri, 12 Mar 2021 15:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVJkcSjjxe945bjRaf3/DZ5ob3yC2me2EmxXrb0K5JE=;
        b=g/LAnkm3rVhqupxVCmJ8IWcq33cORsOmN4qkvPEwO8I/Zd2xL/Ul2OFOuYFHllED96
         DU+lVXOWPjHJ/RjKt81t5lcm6hf6BATgtp4m3DLWJwFzdf0CnlSZuDnxTYIG03u6fp4K
         a8b3Ks/bAsjESI/Zl/dvfgwrqqex0/2bp5lq1S3h5twaxb+M7f2Ef1/k0zQlWqz1ILst
         SecpQHQgazilB3dHfljYJ2a9Kh4H6gUnPaRCmoJor7TSR+KpeaEf/i4pIfZtT21wC6lU
         Oxr8uS+KObQ+d/GOyKOsYqNw8iWsee4MKpVkqf2UQ3YWx0Xl4FuO7V+ISDZxaA7Linxq
         2pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IVJkcSjjxe945bjRaf3/DZ5ob3yC2me2EmxXrb0K5JE=;
        b=pZSHXmbbxWWyTOYNZkTDiJ79OBs2NPDw68AmkJ5Nshr/lEa5/vlFafwuimi/27IOqX
         1tHSEdv7KKZDlWZghumWrJmknLxF5s5umjF3gZ2k9bdFEYRozIvTfzppzXDghj/bZ3p5
         tfO/1Es0lc/c3/Nq1xbNnPeT7PaFd2pdl39aZuJC7UUvns5diNKx7rZBBYcCP8pqJSll
         NXjkzb7BpqVYIv7F2STffYqDtOy6LoAMV6UcL8EqGmqX0PCj1QFvIwVvT0SAo1Vt5p1T
         O8ic0sH+vq8S5sJ8j3ecN0+eiVZkFXO88DrYBx/hbW9v5xxl0SSGytDiQOJtDcn4FDAC
         52vg==
X-Gm-Message-State: AOAM530RniMSzwb5s/PG4tBBSCgZbs+vxW9XPBH7Ba+eldovZni/w9Sv
        LZhrhj0U6Hi1TiTlVNLfTW8=
X-Google-Smtp-Source: ABdhPJx71AdxgPjOi30uPe6oODNqkoD9dD2HCFDDvI42z3CtxECF3j1cIQMUDCr5FTpl1kia+L0zcQ==
X-Received: by 2002:aed:20a8:: with SMTP id 37mr13685755qtb.170.1615590990890;
        Fri, 12 Mar 2021 15:16:30 -0800 (PST)
Received: from Gentoo ([156.146.54.3])
        by smtp.gmail.com with ESMTPSA id p1sm5485922qkj.73.2021.03.12.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 15:16:29 -0800 (PST)
Date:   Sat, 13 Mar 2021 04:46:20 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <YEv2RDAdeJEU75ib@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210312120817.12604-1-unixbhaskar@gmail.com>
 <4c0c0738-72c3-7704-500a-28cb1a068aa1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RJNsnmoOYLEO93ur"
Content-Disposition: inline
In-Reply-To: <4c0c0738-72c3-7704-500a-28cb1a068aa1@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RJNsnmoOYLEO93ur
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 15:01 Fri 12 Mar 2021, Krzysztof Kozlowski wrote:
>On 12/03/2021 13:08, Bhaskar Chowdhury wrote:
>>
>> s/untile/until/
>> s/souce/source/
>> s/divier/divider/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
>> index bed496cf8d24..1cfea5339beb 100644
>> --- a/drivers/cpufreq/s5pv210-cpufreq.c
>> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
>> @@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>>  		/*
>>  		 * 6. Turn on APLL
>>  		 * 6-1. Set PMS values
>> -		 * 6-2. Wait untile the PLL is locked
>> +		 * 6-2. Wait until the PLL is locked
>>  		 */
>>  		if (index == L0)
>>  			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
>> @@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>>  		} while (!(reg & (0x1 << 29)));
>>
>>  		/*
>> -		 * 7. Change souce clock from SCLKMPLL(667Mhz)
>> +		 * 7. Change source clock from SCLKMPLL(667Mhz)
>>  		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
>>  		 * (667/4=166)->(200/4=50)Mhz
>>  		 */
>> @@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>>  	}
>>
>>  	/*
>> -	 * L4 level need to change memory bus speed, hence onedram clock divier
>> +	 * L4 level need to change memory bus speed, hence onedram clock divider
>
>Also grammar fix: need/needs.
>
Hmmm ...good catch...V2 on the way...

>Best regards,
>Krzysztof

--RJNsnmoOYLEO93ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBL9kAACgkQsjqdtxFL
KRXfgwgAj9MS+zQZM0/LWmsaYBUzHsKvjQAmubXCv8z04y6vPO2JrDikuqh7K6jD
qLjk4IHuUA58LscAixWxGt61ZkZvnKb/Fc3sakBezcfstJFbgoee+OJ4gGYPf0qi
CbDtkzS8y5X7dcsbMYM4Sug18VZr5uT6NntlDB2fn5cOluDPQ+g/JAs0twSOo56o
I1aWOrY6TQGnLaHC65j0LKYRJw2NpLAdc4t0BEup+QRsWqcXMx7bAQaTUuLfnGr1
bxWqYHw9Xom1i42d9igmJmJlEZ9LvpRNg78fLqlMFY4aTO/4Zd/03xR3bEGSn23f
w2EkC/P1E1G9ALPIXDvzjR7ITJ1PSQ==
=q+mc
-----END PGP SIGNATURE-----

--RJNsnmoOYLEO93ur--
