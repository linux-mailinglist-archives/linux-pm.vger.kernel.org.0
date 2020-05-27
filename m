Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15251E445D
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbgE0Nty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbgE0Ntu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 09:49:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB21C08C5C2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2020 06:49:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so28165383ejb.10
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2020 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=++foOLm8XCp/vzZg1vNHQX18MozqLm2xHnvVgSzZ15k=;
        b=ZQ039xQ6Ytn70l5fJFrT9eGp4ft8CCo2lngDIHXIc1pvVceMXDKpE8p7RkRDFWzjlq
         xEdHqHqScBluUCFxRuBw/LIscKvogY4mPssJ4CdzX7ABdVu+iRxDKGPujNbPilVdbfjy
         9BSBIyFrLVZ3kNfrXTRdpTqph2pqBUPfEX1suptbNWbHNZDvkgAGiw9y5YBNuyulO70H
         yQokCKUt/gam3wK7H2Cr3RZ6m9jKgj8BKvHzmeBgLOm0Jz1godHXh2xq6sdyH7ELqHsn
         m7OQlmRM3k5lQvh/fnk2fwYCFs1jZ/uYVOpWTHP8BblXR3v1Ht2n2Sy535b3mX0eMKVY
         S4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++foOLm8XCp/vzZg1vNHQX18MozqLm2xHnvVgSzZ15k=;
        b=ryKZ5LQxg9I4n+b+bvhG4Mt4DAfWKv/8/waFbHnTWyezwhlxbtkhu/AD0ue4K4rva3
         BAxQ42OgQ6OsDKLMiLLiVIoYP7AZ1gbvo3/5yQBmUnZ0lAaAlvdTgqf3uTKVSivTt+TA
         0VhCJ9v7h86IHcf5T3uJ8yiEUx3MnFo3aZwCnhk7jtROC4GqRVsQBnJ/OekAcYPx8hKw
         owY1u0P0UFInEt+KOPktAs62EyTPFhAdlbCAZ58f0ox0oP+mLUQSTn77kbgq3RdbUbRF
         KF5ceJdSSVm1K4164M3k/ZjTzODcTbn4AR33uW8FnJ8D82k3Gz/lYHlc+ZYiDqxEqcjx
         okvQ==
X-Gm-Message-State: AOAM532IKbxsz7amGhNHH/3KGG02EEru46DgYjwcCpP8MTMBatxQbS/R
        trmnGG3HVZP43i3fNuUDqzu8NQ==
X-Google-Smtp-Source: ABdhPJwbNxhh5un0+914l8MgigNqf2Xve3x7buMO4RSJFwdLmnL1CjIbVHZfCJQ1D0Z8lULmY+x1hg==
X-Received: by 2002:a17:906:2b14:: with SMTP id a20mr6598593ejg.387.1590587388384;
        Wed, 27 May 2020 06:49:48 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id nj6sm2889467ejb.99.2020.05.27.06.49.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 06:49:47 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] interconnect: Support Samsung Exynos use-case
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <CGME20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21@eucas1p2.samsung.com>
 <20200521122841.8867-1-s.nawrocki@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <edf16797-4c1d-5b92-fbe2-28557c2fcdf0@linaro.org>
Date:   Wed, 27 May 2020 16:49:44 +0300
MIME-Version: 1.0
In-Reply-To: <20200521122841.8867-1-s.nawrocki@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

Thank you for re-sending these!

On 5/21/20 15:28, Sylwester Nawrocki wrote:
> Hi All,
> 
> This is a continuation of Artur's efforts to add interconnect and PM QoS
> support for Exynos SoCs. Previous version of the patch set can be found 
> at [1]. The only change comparing to v4 is an addition of missing 'static
> inline' qualifier to the of_icc_get_from_provider() function stub, i.e.
> addresing Georgi's review comments.
> 
> The patches have been tested on Odroid U3 (Exynos4412 SoC). 
> 
> Below is detailed description of the patch set as in v3.
> 
>                               ---------
> Previously posted as a part of a larger RFC [2].

The patches look good to me and i am planning to apply them for v5.9,
but what happened to the devfreq patches, which will make use of this?
Are they posted separately?

Thanks,
Georgi
