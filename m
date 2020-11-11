Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D62AF00D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 12:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKKLxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 06:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKLxI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 06:53:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827B0C0613D1;
        Wed, 11 Nov 2020 03:53:08 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e27so2772155lfn.7;
        Wed, 11 Nov 2020 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ZZROP0sgrWHXocXnplwQP153jh2UvOQmbtx2+3HJts=;
        b=VDHfOsx5tdF1+TEbA9a+WK+1K/9Tb7pL4h4a0lCdKYC9AvhOD1vNem3XsG1qco/wvO
         0xKNAMrZQtWJ16M27HgiN1ZxuC3w58O6aJ6bNOlWyExcY+HC90ZFuJGsKVtSGBk1pF7+
         3BdhUwuyIUIGw5RSwlLwTdwrG98bLKoJkO/Zwa+tGJkGb+oHhlVZni64NU0YI+jpucTx
         fqqE9Yk3E/N8zSaBoghyH3PPfKznx7gx8jYb3kRPBQ/GGGIUCge6ZLRdNYptenj83Abg
         whPrhOqDaNe8xG3lgtJsgN0b/p8IBPuSnRj4jZ+Zj0zI9TKLSnoD880LA7NJqmCN5Eok
         Cmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ZZROP0sgrWHXocXnplwQP153jh2UvOQmbtx2+3HJts=;
        b=DG3XYIP1n/QQdlBuLdNueQ4vvDEqA/+/MUQgFWT28gyh2ckluHrAkIEsBIyOlxqJvZ
         HGPIoOm11OJe3/z7M3QVnAd2PrWPaSCAiePJi0rcd4i7kbFG6ItDL8FXsiWVr+ExrrcV
         +Df4XIe1q3tMlpBibY4TAjieBqSM3kRF/FdIwI1+sRs3jn53yxI2rEaqfbovu6AvceFW
         8EbNlaDkd0HfxJeNb0YrnrfDake5ziSRMYN+AubeuXx3jJyZNVW2xAVDBzlSadStJhlj
         UPYWiI4ONeKJ1JF0Kj/HC1Hk5j9Efo31LQ7H7AuwjcWAaFh77qn75c6hNmeFBJEK6zhv
         3BSw==
X-Gm-Message-State: AOAM532NgJyXJUGfj7gXbLlDtJcbQIoQIkmgSibpgv2UxyeIASGADcpP
        bjsH3GNQ90xdh1T7k5Wx2iw=
X-Google-Smtp-Source: ABdhPJys5kC2mfxaGiOj4U9JzSI2ZsqED+u2tQRuzy4x85ctO/59VCN+LkZEfQ5NBKjvOOJscwMFxw==
X-Received: by 2002:a19:f510:: with SMTP id j16mr8923883lfb.389.1605095586937;
        Wed, 11 Nov 2020 03:53:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id 3sm208760ljq.96.2020.11.11.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 03:53:06 -0800 (PST)
Subject: Re: [PATCH v8 11/26] memory: tegra124-emc: Make driver modular
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-12-digetx@gmail.com> <20201111090434.GB4050@kozik-lap>
 <f44b64f5-6b08-5f1e-4f9b-a73a1705d493@gmail.com>
 <20201111092619.GD4050@kozik-lap>
 <a75e72b9-273a-4492-09e6-d02a5ea58482@gmail.com>
Message-ID: <79a2f436-93f6-e461-fb12-6d7c8a8cfac5@gmail.com>
Date:   Wed, 11 Nov 2020 14:53:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a75e72b9-273a-4492-09e6-d02a5ea58482@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 13:25, Dmitry Osipenko пишет:
> 11.11.2020 12:26, Krzysztof Kozlowski пишет:
>>> 11.11.2020 12:04, Krzysztof Kozlowski пишет:
>>>>> -obj-$(CONFIG_TEGRA124_EMC)		+= clk-tegra124-emc.o
>>>>> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-emc.o
>>>>> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124-emc.o
>>>> How is it related to modularization? It looks like different issue is
>>>> fixed here.
>>> The CONFIG_TEGRA124_EMC now could be 'm', while the clock code must be
>>> built-in. The TEGRA124 EMC driver is used by T124 and T132 SoCs.\
>> Mhmm,  the CONFIG_TEGRA124_EMC depends on ARCH_TEGRA_124_SOC so on the
>> config !ARCH_TEGRA_124_SOC && ARCH_TEGRA_132_SOC this was not
>> selected. Now it will be selected.
>>
> 
> The driver isn't exposed on ARM64 probably because nobody bothered to do
> it so far. But it's not also the memory driver which depends on
> clk-tegra124-emc.o, it's also the main clk/tegra/clk-tegra124.c driver
> itself, which is also used by both T124/132.
> 

Actually, it shouldn't be difficult to keep the old condition for
clk-tegra124-emc.o by slightly improving the Kconfig. I'll do it in the
next revision.
