Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBD2B17B9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 10:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKMJC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 04:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgKMJCz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 04:02:55 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C7C0617A7
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 01:02:54 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so7678659wmd.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bmUY6Kp74K5Ij/4smj86c/RTyrs44yAD4fruaZc3KA=;
        b=pDDWkNn0TeXo5z90NFuoJvq2kV5VaMikvF9jxmOGClX7VaxG8mxX5VFdpZqSUIvsAs
         3EVBY6l+duHR/n9izPYtnwYXaPftS5PAdSH+fjxkT5Fa/Nip4oqBGm4PNZz6/gU9CLux
         puvn0DIIyp927eDu3GLpmKbSMND6yTLhffst4y4SdzMVzUYTeMAs/6lnU59UmeyHYsRc
         x5GbX6UU6Ey7EiBXpjs3mKZWXOtKwmJoztIhvOr4GRJE1cEdy7O35KnH4z6BEqq8t5G1
         u3mIRu8KU37HtpTIt4dVwRvo5fH8sJJE2FHuJPLpsmhzcxklXAwVjVInr4qIjx79S21k
         7z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bmUY6Kp74K5Ij/4smj86c/RTyrs44yAD4fruaZc3KA=;
        b=U8MxfTMPrtz0bR/9yXQUOymcs2Ey18Yyc2UrrwVYsxbmQxxkIuyxiHvaqzkGdSfVLG
         jvW/DxwC1gBd85xdfU/LeAPAJd2OZPSfm9s/PiItmtCehEgbulo92GPX+2NWueNENpsf
         v1vEHqE0gu6yA1oRa3udI19ByeA+ThiwawDfprGhlcBgVsNFiUe3ZAL+CBe5xjXobA1p
         CIfXm7E0a8tnMLiBRA0zC+9IGC7f0YNenEYNbbbCxivSgiKnqED4zaHrujjNVXxiKjPd
         Gn77pKs2bGCD500ElZNQ+Soy6vGvuN7HPYztlHIXlmZqS7OZid1h3YMDOpy8v4HiGs6z
         agUQ==
X-Gm-Message-State: AOAM532cF1Znk1gomFFuN9bmXpXwX6C+Era6mcHsYrAE/DGwDDcGWKI+
        Q7Gss3ZfzdXTnXzInfBCAEihgw==
X-Google-Smtp-Source: ABdhPJwSbcq1bUG1zWvt0QbTZk9J8eL0sU/+70vAG7k2ZGq6kZadpkOZCstRHBv3TvALxO3BrxsKqQ==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr1455712wmc.181.1605258173178;
        Fri, 13 Nov 2020 01:02:53 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u16sm10041915wrn.55.2020.11.13.01.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 01:02:52 -0800 (PST)
Subject: Re: [PATCH v9 0/5] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20201112141041eucas1p1a29130955afd4ec1d5d94cf17183920c@eucas1p1.samsung.com>
 <20201112140931.31139-1-s.nawrocki@samsung.com>
 <b0a8e994-06d2-e04a-579c-40580b71f760@linaro.org>
 <9cb7e3a6-2a3f-8f46-2bf1-d6d8ea01613b@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <a5fbc409-1af6-1c9a-f648-910baeb191d6@linaro.org>
Date:   Fri, 13 Nov 2020 11:02:51 +0200
MIME-Version: 1.0
In-Reply-To: <9cb7e3a6-2a3f-8f46-2bf1-d6d8ea01613b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/13/20 11:07, Chanwoo Choi wrote:
> On 11/13/20 5:48 PM, Georgi Djakov wrote:
>> On 11/12/20 16:09, Sylwester Nawrocki wrote:
>>>
>>> This patchset adds interconnect API support for the Exynos SoC "samsung,
>>> exynos-bus" compatible devices, which already have their corresponding
>>> exynos-bus driver in the devfreq subsystem.  Complementing the devfreq
>>> driver with an interconnect functionality allows to ensure the QoS
>>> requirements of devices accessing the system memory (e.g. video processing
>>> devices) are fulfilled and allows to avoid issues like the one discussed
>>> in thread [1].
>>>
>>> This patch series adds implementation of the interconnect provider per each
>>> "samsung,exynos-bus" compatible DT node, with one interconnect node per
>>> provider.  The interconnect code which was previously added as a part of
>>> the devfreq driver has been converted to a separate platform driver.
>>> In the devfreq a corresponding virtual child platform device is registered.
>>> Integration of devfreq and interconnect frameworks is achieved through
>>> the PM QoS API.
>>>
>>> A sample interconnect consumer for exynos-mixer is added in patch 5/5,
>>> it is currently added only for exynos4412 and allows to address the
>>> mixer DMA underrun error issues [1].
>>
>> Good work Sylwester! Thank you and all the reviewers! What would be the merge
>> path for this patchset? Looks like there is no build dependency between patches.
>> Should i take just patches 2,3 or also patch 1? Chanwoo?
> 
> Hi Georgi,
> 
> If you take the patch 2,3, I'll apply patch 1,4 to devfreq.git.

Ok, sounds good! Thanks for clarifying!

BR,
Georgi
