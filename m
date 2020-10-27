Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4029CA0B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505399AbgJ0USj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:18:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36562 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442444AbgJ0USj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:18:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so4024953lfj.3;
        Tue, 27 Oct 2020 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iG/wxNmrUdXtLSeVT1BtnHJN9pkzBgnU00RG8GJ2snU=;
        b=CE39HJkOpz2gh5sSV++llTcun5s4wsCEeOrpAt219rLrkt/gR+YlD7apWOk00qLXXX
         //xUxQYChPEUJug1xtm8TEyvEqbhx0bvzSOuKPzlvtu6ArUr5qm2Uh6BBF9c6G1dw/tW
         P1PITxHBNTSs2O1kBNSerqAcJ8ohi2wgWGmBS3BmO0k4NCY2cPMLjCnXA4KfwwTyC3CJ
         2Q+unoIRJ9o5M0lqlTQb8gIiGYoRU2ElUMM5fApr/fYcNC52x77V6A7ezZSbG261zc5x
         PQ4ysbeaZvBAkAcRFbkKd5IhHXRnke2+8JNnbJUItIox/ug2zFqx6sTnLHzXc5GtSaXF
         rSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iG/wxNmrUdXtLSeVT1BtnHJN9pkzBgnU00RG8GJ2snU=;
        b=M6+4RMHX5ZsO4L+GF/8T6d5UcpXU3nPuY6Yca5s+M+OeGQnToPqeOG/cF/PRB9OGm3
         qjRPmwLrfruKkk3Fqs1HMhrpaE3kE4+7Z3KqxrrmLb+Vs8nVdxB0nQjjJtO/+FyjW6Ko
         /rgSZ6G7ODLaFLqutSY7RtN2bcZMQzM5+b4woXjVAzjvF3Horvok6cY1qbLm6UYSCQ0m
         X7t9JNyOrPJcNUUCXpcY23n1qUbOx+FIJXSrJj1edVHhhMswe3tOsupndxqa+YoX1nzz
         KH0uoNllSp5vibTBkEmGITtGPWfjV1DipTBc8kYWGV+jLIWvE8ygjyi3PhYOwVUVLq1f
         KtLw==
X-Gm-Message-State: AOAM530uoHTPIyzntJoiiwYwRcPES7QdsSuS8ERoGOvvGTPv61OgjNgD
        t51HBXz2nMK6bMk8cAM6P31py+xudWo=
X-Google-Smtp-Source: ABdhPJw9WJsmI7CULR1MTFdVBn/kaz/1gHvAddqFoYIwlPvZrFmUfk5szzCImECUAzccEo8eqaCT6A==
X-Received: by 2002:a05:6512:32a4:: with SMTP id q4mr1559859lfe.477.1603829915945;
        Tue, 27 Oct 2020 13:18:35 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id y3sm304031ljn.6.2020.10.27.13.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:18:35 -0700 (PDT)
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com> <20201027090212.GG4244@kozik-lap>
 <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
 <20201027194457.GD140636@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ae06bd70-93f5-abe8-64d9-e5e991cd8ff8@gmail.com>
Date:   Tue, 27 Oct 2020 23:18:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027194457.GD140636@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 22:44, Krzysztof Kozlowski пишет:
> On Tue, Oct 27, 2020 at 10:22:19PM +0300, Dmitry Osipenko wrote:
>> 27.10.2020 12:02, Krzysztof Kozlowski пишет:
>>>> @@ -31,17 +32,34 @@ Example:
>>>>  		...
>>>>  	};
>>>>  
>>>> +	emc_bw_dfs_opp_table: emc_opp_table1 {
>>> Hyphens for node name.
>>
>> We already use underscores for the Tegra CPU OPP table.
>>
>> https://elixir.bootlin.com/linux/v5.10-rc1/source/arch/arm/boot/dts/tegra20-cpu-opp.dtsi#L4
>>
>> What makes you think that hyphens will be a better choice? Is it a
>> documented naming convention?
> 
> Unfortunately that's the source of confusion also for me because
> Devicetree spec mentions both of them (and does not specify preferences).
> 
> The choice of dashes/hyphens comes now explicitly from all dtschema
> files.  Previously, the documentation were emails from Rob. :)

Okay, I'll change it in v7. So far I haven't seen warnings about it from
the schema-checker.
