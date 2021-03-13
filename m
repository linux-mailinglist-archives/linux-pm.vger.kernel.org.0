Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB266339BA2
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 05:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCMDxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 22:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDxJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 22:53:09 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C94C061574;
        Fri, 12 Mar 2021 19:53:09 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r14so5495848qtt.7;
        Fri, 12 Mar 2021 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QraB9bWqBwaRfdaAHd9TP7juSVV+VrzqGfgXh3fvUB4=;
        b=MAtwS5ggXYnpwdw65oaI1eOjU0ftvk3agawvtiIUjymM9U/KPNJjVsQieX4wDNeiQL
         tOnKv2u06TG6CLyK9IUmrPP8SSB1VwHJ+ha1MNe0a2b+nz5Vk7ap/rNcAXNVaJGcYMI7
         hIy4GH0H1ATKWE4kMizqqAyywSBo+/+oIAP89F1aUH6Wo9wjW6uioPuplM6qRszqqvGZ
         7SmpvHXuFZzhgYhwnm0Upe28xMZRFg+n6jOVp1fCoL1XypE/YTW1sJpKeY+p0zSyAwU+
         tlbJoqXQHPCKsPONm/tm//7vm03pr06ea615Bcwp6T9VgEAFkqj7Hxp5cW/9Us2mIG9X
         9nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QraB9bWqBwaRfdaAHd9TP7juSVV+VrzqGfgXh3fvUB4=;
        b=cMU0ya6b9QolsgvpcYmNO/9kVuWEWJsqMibiz0n3hF84pewrR0a+yCX++m2qC+Qc/J
         qQH21/74My6H0hkOh1Y/CAdn1yla3KbQhwfdoDpwVKi8X+yx03h3+Djpo0Tz8+ZbSEIy
         2UG6qg2J7+PZ1Lp1gt9zAd1n+wi/ZI0QhoTKzjbg3/el0jcZ/cgAkb3mWraWd51YCZy3
         l78cueTKsz1Y0vmFCwbZrF7twqjh8PBrFa3TBBKUk3128cXYoCNTI8xweqKwPD9a3FS/
         9t8L3dLy1mcMi9bg5kYPtqGN3ut5uhtY0J39NNzCfR5rfxeIZonJWoMI3CB/+ZTiaWnl
         ftWQ==
X-Gm-Message-State: AOAM5334FOg34wQYRUmoVVPomP12znmByzxohvTyRehNSND2GRsVPU4O
        f9BRL6mBinAcv6el+M02iempo4uNEFsJEBY/
X-Google-Smtp-Source: ABdhPJz6INZQNHoeJioz5bsrnJ/zEll/v3uf+bJZOtBvhOy1KPa33Zw6lhdcZFJoj3UqqMvpIOkf5w==
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr11308333qta.201.1615607588498;
        Fri, 12 Mar 2021 19:53:08 -0800 (PST)
Received: from Gentoo ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id s24sm5861058qks.127.2021.03.12.19.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 19:53:07 -0800 (PST)
Date:   Sat, 13 Mar 2021 09:22:57 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <YEw3GQ3jfDRgNRXF@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210312232621.2083-1-unixbhaskar@gmail.com>
 <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
 <YEwMbGm83aRRxnuR@Gentoo>
 <db71b3a5-c45c-0d5a-3593-c96bb3fc4318@infradead.org>
 <20210313025907.jhpbj22gfudzx4ta@brm-x62-17.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vGHLcGldKC60cE3R"
Content-Disposition: inline
In-Reply-To: <20210313025907.jhpbj22gfudzx4ta@brm-x62-17.us.oracle.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vGHLcGldKC60cE3R
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 19:59 Fri 12 Mar 2021, Tom Saeger wrote:
>On Fri, Mar 12, 2021 at 04:57:07PM -0800, Randy Dunlap wrote:
>> On 3/12/21 4:50 PM, Bhaskar Chowdhury wrote:
>> > On 17:16 Fri 12 Mar 2021, Tom Saeger wrote:
>> >> On Sat, Mar 13, 2021 at 04:56:21AM +0530, Bhaskar Chowdhury wrote:
>> >>
>> >> sent a few additional typo fixes to your V1, can you add those to your patch?
>> >>
>> >> Regards,
>> >>
>> >> --Tom
>> >
>> > Thanks, I have already sent out a V2 in public...I might make a V3 with your
>> > changes too...did you sent it to ???
>>
>> It was just a reply to your v1 patch.
>>
>> --
>> ~Randy
>>
>
>Bhaskar,
>
>Here you go...
>
>V2 additions:
>
>diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
>index af1ac3f6e4b8..73110b005716 100644
>--- a/drivers/cpufreq/s5pv210-cpufreq.c
>+++ b/drivers/cpufreq/s5pv210-cpufreq.c
>@@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
> /* Use 800MHz when entering sleep mode */
> #define SLEEP_FREQ     (800 * 1000)
>
>-/* Tracks if cpu freqency can be updated anymore */
>+/* Tracks if cpu frequency can be updated anymore */
> static bool no_cpufreq_access;
>
> /*
>@@ -190,7 +190,7 @@ static u32 clkdiv_val[5][11] = {
>
> /*
>  * This function set DRAM refresh counter
>- * accoriding to operating frequency of DRAM
>+ * according to operating frequency of DRAM
>  * ch: DMC port number 0 or 1
>  * freq: Operating frequency of DRAM(KHz)
>  */
>@@ -320,7 +320,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>
>                /*
>                 * 3. DMC1 refresh count for 133Mhz if (index == L4) is
>-                * true refresh counter is already programed in upper
>+                * true refresh counter is already programmed in upper
>                 * code. 0x287@83Mhz
>                 */
>                if (!bus_speed_changing)
>

Tom,

I sent out an V3 incorporated with your findings.

Thanks,
Bhaskar

--vGHLcGldKC60cE3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBMNxQACgkQsjqdtxFL
KRU8aAf7BshhQwCLxpVA8BXBvYEkFyrqZcYaqBx6YqXwgsoeWOTcOUyVQnPUgueV
Lu1b2mkdmWMetYo6ac2f25lQgfitLl/Ccc/7PEfgkx/+YVwBxhzwUj63oSir43/r
oEXwApW/q1dNkMZ5RAaJJlwK3nYhyQHwaFKhYfgAEsduNXz/mMUNR69/dnf87t8m
Z/AYxUo+dgirrwUkPsasELi0xJik6KXRUS4+UFUZDEQQ/fNy0kVLVIDseIaAmtiB
fXgxfjoWWALJm+9KxjdUHWC4a8eORkZCmkQAFYk+aDj6rtqswRGluk4C4c84ZpEf
QO2QR0gV+xOe55BcctmOa7IYf2I5xg==
=e4xO
-----END PGP SIGNATURE-----

--vGHLcGldKC60cE3R--
