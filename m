Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EA2AEEB3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 11:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKKKZj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 05:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKKKZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 05:25:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F4C0613D1;
        Wed, 11 Nov 2020 02:25:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r9so2421177lfn.11;
        Wed, 11 Nov 2020 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YDPQOCu1Q0bKCPL6C42R2nt86MKzHJcXkgJe5Eo+/zI=;
        b=nHudV4l+RFcBpr3axrfNNEScRTyu6drP6JREhMmAoVRKbdS57PvlkXk9toKfclED2s
         5G/GJ7KJRJsFYOl4i6+hz5/nD17g2tiqobNLOl91ANza33Te94/voQb5CZ0zp8lD2BIl
         PU7rMO+1CqahgPqwQycUOiQXXBNmJQk5SzllsR4JSzuOTWV21BW2AOMl66pxwuXjhOh/
         Vjvfq/UE6EkhNOnrClbk3roh6SxJVnCQ9D2Ww2U+TE3x7kVzsAdfFNebF1olzKADUOvJ
         t9JGDbP2u/DDS6t4RZ6L5CjtUW62hY2Z2f/G4Lmf7wPuz8IPXZquX5zg6jtdtLe8EzzV
         WHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YDPQOCu1Q0bKCPL6C42R2nt86MKzHJcXkgJe5Eo+/zI=;
        b=m76ZrIGuZ980yAWKz1yFwTgrCiIPxwEMyEVEb17o+Ta4y/Y/bmkjAB9DOM+m/ZEzsJ
         XKZDkMmGy4ryp5nCp8cOYROit8neLzq5xu9NxjgOMeRdw4AVrjiJgGIKSVs/pTMrgoV5
         PlUMgLZFKfxF5XDo3nXTiJgvj5myQX+yJ85LjH/LRvXdqGhO58Gzf5WRrwAVM3ELmx4z
         I41LRsYIk4fquZa6xg5VAnhSm/g2aQVEZ8k4VfEFgtIWoKGdJYutHA6Iaw83b3BS5Xcc
         5RWLCtdT5Sr1mDGqmGgyQ3c2oGAZ4P5Ni6w2DAX4TKoXzTG1DbaPjN3r9lsuo3p5Kmzc
         BxwQ==
X-Gm-Message-State: AOAM530PAsYMwTQ+eij4Y/U+nFhhflS6JtV4d8rabMZx6d68uUtV8xUN
        aRwxSM5mudlnEKXO6GgRfoQ=
X-Google-Smtp-Source: ABdhPJzTv9Jyb7R3JTGhtKOKkgm12/bRzXfaFk0KiQNWX12jN9WFCPB0iS0jN9FOqsksEXFAwAJolg==
X-Received: by 2002:ac2:53a1:: with SMTP id j1mr8775060lfh.236.1605090336653;
        Wed, 11 Nov 2020 02:25:36 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id t13sm62578lfl.294.2020.11.11.02.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 02:25:35 -0800 (PST)
Subject: Re: [PATCH v8 11/26] memory: tegra124-emc: Make driver modular
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a75e72b9-273a-4492-09e6-d02a5ea58482@gmail.com>
Date:   Wed, 11 Nov 2020 13:25:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111092619.GD4050@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 12:26, Krzysztof Kozlowski пишет:
>> 11.11.2020 12:04, Krzysztof Kozlowski пишет:
>>>> -obj-$(CONFIG_TEGRA124_EMC)		+= clk-tegra124-emc.o
>>>> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-emc.o
>>>> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124-emc.o
>>> How is it related to modularization? It looks like different issue is
>>> fixed here.
>> The CONFIG_TEGRA124_EMC now could be 'm', while the clock code must be
>> built-in. The TEGRA124 EMC driver is used by T124 and T132 SoCs.\
> Mhmm,  the CONFIG_TEGRA124_EMC depends on ARCH_TEGRA_124_SOC so on the
> config !ARCH_TEGRA_124_SOC && ARCH_TEGRA_132_SOC this was not
> selected. Now it will be selected.
> 

The driver isn't exposed on ARM64 probably because nobody bothered to do
it so far. But it's not also the memory driver which depends on
clk-tegra124-emc.o, it's also the main clk/tegra/clk-tegra124.c driver
itself, which is also used by both T124/132.
