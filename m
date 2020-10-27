Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C329CB09
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832128AbgJ0VMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 17:12:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41178 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501973AbgJ0VMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 17:12:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id p15so3391112ljj.8;
        Tue, 27 Oct 2020 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xx452EybhZY/Be3m6ZPFyPAZdRMh+EqfNW2ocWqJUkQ=;
        b=D6Wr3oaM9cb6BAmiXy3RkDD4ypsh2yfV8mv0vEtF5pP1za3dGFHgk3xtjw87AkfiqN
         omzwflvsg5c3541QMlIKkoHT4+D1FIZ2bFGO7nnh7r16tMFPnPouySY0KiZ5B+0yFUzW
         jAwlJz05zfj7nRFVKSs2LqKL7Xkxs0q+w55fq+OEbWp6C83f1YUR5Z4sd8rvoQQiatgt
         sRSC/upzBI+sqHvANT1BPo8HtPkXVjBRc9jwm4rpY3tOGQdLsf0lLSaQL1PLASU1v8qu
         hGfPJkzaUUUVklWeOsK5NV5iT6rRLnCqvMy6tGpA+sbqkn6kkN5iOmAaLWkzt5cdR3/q
         /WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xx452EybhZY/Be3m6ZPFyPAZdRMh+EqfNW2ocWqJUkQ=;
        b=PtAJfyoJHnWE2jZgaC9V9pbcKZMKpbfXSMGq5/mTUisH5l2m9zPGTtPo0f23LR/rTo
         /k++nAyjR5HSFfqcKtjuWyyc3g9RSL8KGfIwwjWExm+DboEu0UiFfuUmeqEaSw3UrZVc
         T9EaMIYH742dKJ3B7Ii0AUqUa2c9hab5DxIG3GiadMiltjQkgOT2uuFVJ2vR/ousl3qO
         D+hRy0mviLpB2Kj013JriS4FrbwwZljySZpRPp7lWz/i3ees1HeiHeGqXYU8PzvZVH1S
         Ad5XwGeq3fVY1Nli8no5Fw3sWvHRNbav36sW8lCt88sUS02ZVNkRmBurM4+DTVq+PfMZ
         gCCw==
X-Gm-Message-State: AOAM5320kx+BqcBWRUILprcglmsjYW+6ewipODSgDJPCEsoKsAtW+xKO
        ooRw6xWLs4HhWE/PdegV2nPEG1F/ZGs=
X-Google-Smtp-Source: ABdhPJwv14XNGp2zM2xoLnCiq9kknsnE1yraNpyVdtEy7elcpP9cB4Kgv07q0csNDEYeh5IGZ093Gg==
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr1768187ljc.52.1603833122475;
        Tue, 27 Oct 2020 14:12:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id i139sm292785lfi.276.2020.10.27.14.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:12:01 -0700 (PDT)
Subject: Re: [PATCH v6 33/52] memory: tegra20: Support interconnect framework
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-34-digetx@gmail.com> <20201027141152.GN1822510@ulmo>
 <713bf4eb-dc5b-9c4b-4ab4-23b36ba4fab1@gmail.com>
Message-ID: <4ff5d718-5e05-fc11-9795-7c3fef4525d3@gmail.com>
Date:   Wed, 28 Oct 2020 00:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <713bf4eb-dc5b-9c4b-4ab4-23b36ba4fab1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 23:22, Dmitry Osipenko пишет:
...
>>> +
>>> +	*agg_avg += avg_bw;
>>> +	*agg_peak = max(*agg_peak, peak_bw);
>>
>> I'm not very familiar with ICC, but shouldn't the aggregated peak value
>> be the sum of the current aggregated peak and the new peak bandwidth?
>> Currently you're selecting the maximum peak bandwidth across all
>> clients, so isn't that going to be too small if for whatever reason
>> multiple clients need peak bandwidth at the same time?

The current variant with max-peak selection should be okay since it
takes into account the competing ISO bandwidths of other devices by
overestimating the bandwidth.

For now we have only display ISO clients and it won't be a problem to
tune the algorithm later on if it won't work well for other ISO clients.
