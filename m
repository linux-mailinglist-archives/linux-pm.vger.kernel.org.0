Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1129C881
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829571AbgJ0TR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:17:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33293 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819210AbgJ0TRY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:17:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id c21so3105409ljj.0;
        Tue, 27 Oct 2020 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/C50whZF34pC0udz/P6Ih/pyTCfScHf2ZVRt2NGzvgk=;
        b=Vl3rx+HQClDbLHSYq1a93jwJSQ2tiugR0jBtDlQ8dbID3MyxGvYQMOlXV/+sgmAS2Q
         FelZK1keaJqrIf5PuLjWm3iXvzxeNDzfKb9Yewhfr6Ye5QoJgkiu/GAlBdJZ/+39nvwb
         rv7XlBpzd6S4bnSGOLV93yWM53y0bqiaSj112Ov3FqlhQns/VJ8LCFS8UXO6a9QHpBR2
         LbEzV3nOidQUqqleCL45aDvf203vDVrZX7bJVcO0qcDBafpXfxYDv2MZEPsb47QRPdoI
         UgRe0/5aIsAxFt3iEWw0Xy1NvFysOro6p5VUAwwdjSUI2eu2bT1QAJV4h5ywPrtMVbrD
         4sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/C50whZF34pC0udz/P6Ih/pyTCfScHf2ZVRt2NGzvgk=;
        b=Dg6DHih074HsQ2rNzS+yHDQV03HM1cyTptLgn34oWsevMf3MeYSWwraOmKQnBu/xMx
         2PcFda1Gg5nPRaiYjsHfg8oKnCooohqPCl4fepsFlmSOxSD5eXdp7GsBog0X5L94AVFv
         RQQUWyfZDfw5G2aWcRIcp/FzpOiQTp9awI260xRpOtNfEE/QAX5S+2+pUireqswT6tE3
         E3rofgerS+lt6I7hEKyvsSu1nknhGVO4YDG4jA+GEFHJzgv7OCym4WIm9ZKVjA8OLfJc
         p0yk4L9tfikevDEU2Omcd/MVfFKmPkV4jv1D1bOJrdFuJFRtj84CQ1PJiHbMF8wrG+FM
         dR2Q==
X-Gm-Message-State: AOAM532fDNh+GdzG85uphqaTQtj7pJsYaQHKrjHx8SeQyPmwhb1OBf+g
        n5gay/DpJedJIIsSkNfU8WKi0ODuM4I=
X-Google-Smtp-Source: ABdhPJyJBOp+M2iGeg3Qte4VQ0b2gkUYbeG6b6mkEm81uMaOlTUWkyEjhgm8Hig7JbwI/bRQKxKwWg==
X-Received: by 2002:a2e:3c0b:: with SMTP id j11mr1573379lja.254.1603826241002;
        Tue, 27 Oct 2020 12:17:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id 5sm96298lju.25.2020.10.27.12.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:17:20 -0700 (PDT)
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
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
 <20201025221735.3062-5-digetx@gmail.com> <20201027085417.GD4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <54191034-dcb9-7cab-333b-5bb2553f0ed1@gmail.com>
Date:   Tue, 27 Oct 2020 22:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027085417.GD4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 11:54, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
>> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
>> reprogrammed when memory frequency changes. Tegra Memory Controller sits
>> behind EMC and these controllers are tightly coupled. This patch adds the
>> new phandle property which allows to properly express connection of EMC
>> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
>> par with Tegra30+ EMC bindings, which is handy to have.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>> index 567cffd37f3f..1b0d4417aad8 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
>> @@ -12,6 +12,7 @@ Properties:
>>    irrespective of ram-code configuration.
>>  - interrupts : Should contain EMC General interrupt.
>>  - clocks : Should contain EMC clock.
>> +- nvidia,memory-controller : Phandle of the Memory Controller node.
> 
> It looks like you adding a required property which is an ABI break.
The T20 EMC driver is unused so far in upstream and it will become used
only once this series is applied. Hence it's fine to change the ABI.
