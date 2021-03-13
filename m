Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB8339A86
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 01:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCMAv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 19:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCMAvE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 19:51:04 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA78C061574;
        Fri, 12 Mar 2021 16:51:04 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f12so5288865qtq.4;
        Fri, 12 Mar 2021 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqkOJbjc4ShDJZz4xQlPOgfRqqwngCwRaRwv5C7LuXQ=;
        b=pB8aHpZYEVeWVXNE0CdMl7enaQE2Z1k9X+4AsTrTTtPMqaOTpwWaDh8t5xyQ111Na3
         LgPJunAlaurkWymsl0nEcZgS516wRzj/pWuWFr2cRjNFL4daOjkjKENakf/lrwX8oR3z
         LgMnma2I/SKBExgDOCA60AHHDx7m/V0oUpHjfA1PTdRDDuONbKN/+2CzLFj9w3o28EVe
         Yr4SztD2eTd2RTRgK4TfeFAgZk+3wel56DjmCDcRfFIbe1XmXUoqerVRhxheHJNbyMIb
         XlF2raohLoEoFJvEtHofGN0VzgtC5FW5gielGROWVA6UaYDKQkceQV0BSgLpVY8JBrR9
         G+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BqkOJbjc4ShDJZz4xQlPOgfRqqwngCwRaRwv5C7LuXQ=;
        b=HnxsT/MVC/L7SRwE4LJjy/RLggc9ZmCewR8VfeiMAdHdu2zKEaS5sY/j9SiNlPyfaT
         surDO1ZKe4ajKpxwfq2YRkxjMTJ/ajnaOqRroFg0u5gVd/3XMPJk1UDiaUMFKsDwgjlt
         6SbSUMyvFKgsL1L61oLf6ZyZmKHKZzNHnwXioJvSRno56nzRcbMFBmIX1Cb5Rjfr/B3f
         uPYGJWYyA6/8BCcKmmK6s+liwE+iGwCss6OrlviOESgjl0id+fTv44V+cz+cFbU0uEF4
         +dKxSc+HasGAvAtdrlFR/D6KHYyjM4YegqzB+CNGHMqRnIVeiGmFz65uDtEgS75OTtcZ
         Y2MQ==
X-Gm-Message-State: AOAM533hm3rNBGavrFxU5tytWbvrWr9zARqnQr1kvtGozDZztLTelSTR
        SJJ5S/7bNdx36kJ/8D1gkGw=
X-Google-Smtp-Source: ABdhPJz+6/l2eEuP8hrYd0JXsFKx/Rrjf+6R1/fDkPgfpueAay75ecFiHsQpZ/HCo9Sua+aQN+koww==
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr7807541qti.237.1615596663179;
        Fri, 12 Mar 2021 16:51:03 -0800 (PST)
Received: from Gentoo ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id p17sm2403768qtx.71.2021.03.12.16.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 16:51:02 -0800 (PST)
Date:   Sat, 13 Mar 2021 06:20:52 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V2] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <YEwMbGm83aRRxnuR@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tom Saeger <tom.saeger@oracle.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210312232621.2083-1-unixbhaskar@gmail.com>
 <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N8iabx18Syr6BGZC"
Content-Disposition: inline
In-Reply-To: <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--N8iabx18Syr6BGZC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 17:16 Fri 12 Mar 2021, Tom Saeger wrote:
>On Sat, Mar 13, 2021 at 04:56:21AM +0530, Bhaskar Chowdhury wrote:
>
>sent a few additional typo fixes to your V1, can you add those to your patch?
>
>Regards,
>
>--Tom

Thanks, I have already sent out a V2 in public...I might make a V3 with your
changes too...did you sent it to ???

--N8iabx18Syr6BGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBMDGsACgkQsjqdtxFL
KRUKdwgAihT47tmOIvl4J6BFocHQNdg/D+g7cwpKlBb16JKX4W9Pqnf27/4vXLTq
IFu6qXZWmf5hkAesZJNLXmQDsGQ9/5jxTCiY5txx0xMj+nz7/1NNp1KJm3OMG8Nn
eT31gg8Gvd9iuxutE0ZWA3GcMbRc7TrXfgOn7HRdZR5xvT/UH6+fsjVcAGQTcOCz
C/Injb7o6Ow56d6vGLZGxYJDTeFw2TuQ5nAjgNvhuO5X/FNtmt6F5hK8OrldZ2Jt
sCZ+J3fJsJSaNzU4OQKsaWxvjjaNUHc5Ob+gyMbHjtxRiWb0z2FsHD32NkmUF9iU
CC7E7s5+TuNVKYnfn4305cGwAavQbQ==
=4K+h
-----END PGP SIGNATURE-----

--N8iabx18Syr6BGZC--
