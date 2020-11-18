Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B162B8089
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKRPa3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgKRPa1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 10:30:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD196C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 07:30:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so3112493wmi.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/SDkP0vkKcya+FIJEA+cPnvkReKH8EFRybVcIu9lk9M=;
        b=D1BytoB6O03jBcACE4ZhAx92rosgf9wYS2rPHzrBHSfzKSQ0rUMTzY3xFt8TEHE9k0
         YIIiPTr94Bc7PUn7zwCH9EE+zMbRYo4nnn12/5TpwUogKdAUXolEut/KGLgjD8p1u9z+
         dAYzFovYhNWO+3rZhx7IoAOF+fVoq+FdKg0mn20a1XWJUdbwnQ20TZzHguw90k+BaASf
         7P+5q6YagtEKTiL9MoxhoA0aKwhwyc39dlKHA6piMdU8eOhplAdHXaNEcJpNvodiG8QL
         JTVWIUvFDbkbxf7qqsJ2NSlEFEvArxEdy8Xn4hO7Lb5vG6HcO7PIrZcevw0aveSWR9kJ
         kERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/SDkP0vkKcya+FIJEA+cPnvkReKH8EFRybVcIu9lk9M=;
        b=jovDWt1XXtNmEDXUmfTu5LHMN6FkU46oB/RJt+cXziBtO/fpaozxnB1YSgyLuTy0+8
         yKVQSpjAmj7i9vBtRThOMuAFMzCXEIi4A9Xu2AbaEItfAOKKQpUApaR+HP9lK1d1wQtA
         2HZnD6dnLdE6Pp8gFFZbPCdV9PHQ34qK1h3ghyfkf+7IjBz5wGjyebuYYGkNZqMBn321
         NWGjhbSaEEL42hJhUzvJWGD4lr53Dp0eBaWBSPNMPcsq4gCWn1P1yC/Z+rMWCZgkdkb/
         zq08YZO/2ntm0fv3o8Tn+TB065W5D6T0HXIIMKZLimokA/JpJUZj6PuDIY89k0YY+0TS
         MgIw==
X-Gm-Message-State: AOAM532w/Gc+X3Q+DKT6NiZIPKuh5pIbbYCo9FeS03c7/F7cUMTjMR6J
        80630Flk6mz+59EsqnqNYbiLGQ==
X-Google-Smtp-Source: ABdhPJzFItfcbj1D5GPsiBo7RkrZes7kt1MjC/X61M/dwKw8ehmZ/XH4IHzsd6fKnSmspZvESraPog==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr560063wme.47.1605713425424;
        Wed, 18 Nov 2020 07:30:25 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id w11sm4405479wmg.36.2020.11.18.07.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:30:24 -0800 (PST)
Subject: Re: [PATCH v9 01/17] memory: tegra30: Support interconnect framework
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201115212922.4390-1-digetx@gmail.com>
 <20201115212922.4390-2-digetx@gmail.com>
 <61e777d9-b730-02c6-cedf-cf0aa1a50fb8@linaro.org>
 <7e484678-43cc-e612-1017-73ed580f9840@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <83a3f33b-3695-2a40-1c2b-5c38d117c1ad@linaro.org>
Date:   Wed, 18 Nov 2020 17:30:22 +0200
MIME-Version: 1.0
In-Reply-To: <7e484678-43cc-e612-1017-73ed580f9840@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.11.20 0:02, Dmitry Osipenko wrote:
> 17.11.2020 23:24, Georgi Djakov пишет:
>> Hi Dmitry,
>>
>> Thank you working on this!
>>
>> On 15.11.20 23:29, Dmitry Osipenko wrote:
>>> Now Internal and External memory controllers are memory interconnection
>>> providers. This allows us to use interconnect API for tuning of memory
>>> configuration. EMC driver now supports OPPs and DVFS. MC driver now
>>> supports tuning of memory arbitration latency, which needs to be done
>>> for ISO memory clients, like a Display client for example.
>>>
>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>    drivers/memory/tegra/Kconfig       |   1 +
>>>    drivers/memory/tegra/tegra30-emc.c | 349 +++++++++++++++++++++++++++--
>>>    drivers/memory/tegra/tegra30.c     | 173 +++++++++++++-
>>>    3 files changed, 501 insertions(+), 22 deletions(-)
>>>
>> [..]> diff --git a/drivers/memory/tegra/tegra30.c
>> b/drivers/memory/tegra/tegra30.c
>>> index d0314f29608d..ea849003014b 100644
>>> --- a/drivers/memory/tegra/tegra30.c
>>> +++ b/drivers/memory/tegra/tegra30.c
>> [..]
>>> +
>>> +static int tegra30_mc_icc_set(struct icc_node *src, struct icc_node
>>> *dst)
>>> +{
>>> +    struct tegra_mc *mc = icc_provider_to_tegra_mc(src->provider);
>>> +    const struct tegra_mc_client *client = &mc->soc->clients[src->id];
>>> +    u64 peak_bandwidth = icc_units_to_bps(src->peak_bw);
>>> +
>>> +    /*
>>> +     * Skip pre-initialization that is done by icc_node_add(), which
>>> sets
>>> +     * bandwidth to maximum for all clients before drivers are loaded.
>>> +     *
>>> +     * This doesn't make sense for us because we don't have drivers
>>> for all
>>> +     * clients and it's okay to keep configuration left from bootloader
>>> +     * during boot, at least for today.
>>> +     */
>>> +    if (src == dst)
>>> +        return 0;
>>
>> Nit: The "proper" way to express this should be to implement the
>> .get_bw() callback to return zero as initial average/peak bandwidth.
>> I'm wondering if this will work here?
>>
>> The rest looks good to me!
> 
> Hello Georgi,
> 
> Returning zeros doesn't allow us to skip the initialization that is done
> by provider->set(node, node) in icc_node_add(). It will reconfigure
> memory latency in accordance to a zero memory bandwidth, which is wrong
> to do.
> 
> It actually should be more preferred to preset bandwidth to a maximum
> before all drivers are synced, but this should be done only once we will
> wire up all drivers to use ICC framework. For now it's safer to keep the
> default hardware configuration untouched.

Ok, thanks for clarifying! Is there a way to read this hardware 
configuration and convert it to initial bandwidth? That's the
idea of the get_bw() callback actually. I am just curious and
trying to get a better understanding how this works and if it
would be useful for Tegra.

Thanks,
Georgi
