Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8803AE84B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFULqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFULqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 07:46:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78EC061574;
        Mon, 21 Jun 2021 04:44:21 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u20so5001398ljl.13;
        Mon, 21 Jun 2021 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TvnTnGnSvT/wzcRtCIQ6B7dOOoTU5ysPY7rP65LBPcY=;
        b=NXGg0c7craxUcqNhRaT+jQw2x5ROQqdt5x2dBCqXs2jNFOEy/YGap3LnXP1YwcUAjM
         5G01dyQKmz25sWNdAzoECLk94HKhYL3CSlwl8Sb8Cr9/Z0uIcXA+uKLE2DXZ7xzJGgCh
         LpexwTncTGfEFCD0q83Dbcor+Aao2Jhbtym/jCGzjruRUIg3QuWH5NboNFiUrYIoVAwS
         QALcOuU0LGWRYtO5ZSu1YTuK0vb0SsavpdHeIWe3owroU6nnG93Oc0/DWQ1hga5vuhod
         NU/eTkw/kA3mLYrsFDCJqSfxEQNpeBZEQpZwvqyDS/vaIJtMJ+IuIpl0bSd4qj0nex/T
         JDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvnTnGnSvT/wzcRtCIQ6B7dOOoTU5ysPY7rP65LBPcY=;
        b=QWYmaQInwfwqnhYUSyvdH5YTcd7RzvpRypRU83/jrktqfGAjeu6Aibx9GrlCt9izfy
         C0W6TjUwAl7Ok6vlN+kQFEi2XkSNVuUrJsZmidQhqza+/6SfygshwlYqMmyThT68H6z1
         3qbax7qlU1HNTTWLZQP554jP3KTs5YfFNWBawXWIoWS5OLPrSNdufBMVYdCHAAIEF8ZW
         gR41LVgdwNyiHZfL3vSGtFfELW8vDiz7dXMrMbn5hDKdmnTyTh1w5clNdfCXyEc5Vvhg
         YQZAeOH9wg8UpyJneOTI3WoCq4unfB2dcm1aventCnGstIyQavgiDWFPwL2AvMgJqoL+
         UE4A==
X-Gm-Message-State: AOAM532F4mwuf/q9+sN/0fGV7dQF9JI56wwORmrhAmRx4F/ex6REPfe0
        b6FbXMbGYGMy2pyVTeG6twY=
X-Google-Smtp-Source: ABdhPJzZqNE1v82IJt68up+rW8SvYARB7SxPKZ+9ubQvwMGy0eOKEOsPIa0ETY98RpNKHEL+/717Ng==
X-Received: by 2002:a05:651c:236:: with SMTP id z22mr5920364ljn.106.1624275859324;
        Mon, 21 Jun 2021 04:44:19 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id z4sm2085643lji.61.2021.06.21.04.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:44:19 -0700 (PDT)
Subject: Re: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20210601042108.1942-1-digetx@gmail.com>
 <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
 <50912a57-aa43-58b0-02d2-6928578d6286@gmail.com>
 <YNBxiFXMS9rfT93c@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <af058fc3-8696-a8f9-b52d-8e1b2ee760c3@gmail.com>
Date:   Mon, 21 Jun 2021 14:43:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNBxiFXMS9rfT93c@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 14:01, Thierry Reding пишет:
> On Mon, Jun 21, 2021 at 07:19:15AM +0300, Dmitry Osipenko wrote:
>> 07.06.2021 01:40, Dmitry Osipenko пишет:
>>> 01.06.2021 07:21, Dmitry Osipenko пишет:
>>>> This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
>>>> which is done using interconnect framework. It fixes display corruption that
>>>> happens due to insufficient memory bandwidth.
>>>>
>>>> Changelog:
>>>>
>>>> v18: - Moved total peak bandwidth from CRTC state to plane state and removed
>>>>        dummy plane bandwidth state initialization from T186+ plane hub. This
>>>>        was suggested by Thierry Reding to v17.
>>>>
>>>>      - I haven't done anything about the cursor's plane bandwidth which
>>>>        doesn't contribute to overlapping bandwidths for a small sized
>>>>        window because it works okay as-is.
>>>
>>> Thierry, will you take these patches for 5.14?
>>>
>>
>> The display controller does _NOT_WORK_ properly without bandwidth
>> management.
> 
> That's surprising. So either it has never worked before (which I think
> I'd know) or something has caused this regression recently. In the
> latter case we need to identify what that was and revert (or fix) it.

The problem is caused by the support of dynamic memory frequency scaling
which does a good job at keeping memory in a low power state during idle
time. So display controller may not get enough bandwidth at the start of
scanout if it won't request BW beforehand. This problem existed for many
years on T124 and now T20/30 are also affected. The DC of T20 is the
least tolerant to memory bandwidth troubles.

This problem is not critical, but it hurts user experience since high
resolution modes may not work at all and display output may become
distorted, requiring a DC reset.

>> Can we get this patch into 5.14? What is the problem?
> 
> There was not enough time to review and test this, so I didn't feel
> comfortable picking it up so close to the -rc6 cut-off. I plan to pick
> this up early in the v5.14 release cycle and target v5.15.

Thank you for the explanation! It's not uncommon to forget about
patches, so the silence worries me. I hoped that both the dynamic freq
scaling and display BW support would be merged around the same time, but
apparently we got a disconnect here.
