Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C229C8CB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372104AbgJ0TZy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:25:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33116 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829919AbgJ0TXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:23:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id c21so3125066ljj.0;
        Tue, 27 Oct 2020 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Akjb+zu83Tp/ZWt6kxaaIN1ra2F7kz6LqBZ1oZjBDnM=;
        b=SL0PgTg+pMJCfn1eIJ/PohULVHx02bXVzKYatI3HV5z5DoVBijWPYKwUemWlIAYNtd
         1Ph7/a5JS1XLSdRXrL3yQ9+Qa1qBzV9PM/SR0Y25xm7LytMIqWhEm9PZAyaQ0JjSqeLJ
         7KJvBnth6yqGN+1y1ef8PDRy32pTnp4brNSd1HzVeeZUxoJ3XVieGH3K60904x3BMN7L
         ged4gGaool3vixitGPoD9OcSjQrM6UoZqsA1a0+cIICrGpeqmqtPoGpSczsqMLNc5BqP
         ZvoeniGueCUOzNqwTO0mSOVjY9vzA7V/WL8sULitPMQLEnqIWGVS3hwyF3WZEDZlsQaC
         tkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Akjb+zu83Tp/ZWt6kxaaIN1ra2F7kz6LqBZ1oZjBDnM=;
        b=bGsoGfw2KMtFuHhWG9WyassCOA+Sg+jrdh+RkvG4iRE8ijmb6Mbc4uZfWRyvTr/mh9
         Gi/DUDoeXR2f1cOCcoRnqZ7m6ruW+17G3lAw1NhAZneEPvx3h+9t99wpoaSdAEScg5i3
         Ut45hiV7e8Y/g7RBzUIIJwUTpDXfqzMlQubt/NH2lPoqpa8zyaXuMI/Xn7GhP/MhZMJh
         FvLHhhyqDE3NonwHHQLJCW9NftlzkHpi+QnHDdQ1+GPjGmZmike0+NN8lgh3U88TWHlu
         UqcQYdEFfjFji98NzjfZ/tPpjJqG5W7iS2TWchDiC7ASZ96ynN1MD7ikzRT8IlyZFxue
         LGww==
X-Gm-Message-State: AOAM531DmOtb/IE/pjrPjYrdo+poMJjkpRhYfIZXdEzNrl3hcflsVZD3
        9cXoWFFA0lqJ/ziUWrP1aa9u9M05AeM=
X-Google-Smtp-Source: ABdhPJweAT6nor9dVVTdPqiBE7Dkth/aMi9siRaEEQNJntR0tq0UbWvZ5+KYQAAg3FLULXu6vp6tRg==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1856642lji.443.1603826623643;
        Tue, 27 Oct 2020 12:23:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id x5sm287766lji.78.2020.10.27.12.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:23:43 -0700 (PDT)
Subject: Re: [PATCH v6 22/52] ARM: tegra: Add interconnect properties to
 Tegra30 device-tree
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
 <20201025221735.3062-23-digetx@gmail.com> <20201027091516.GA10762@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f7ac9562-6ba9-dc67-f2d7-cc5c1321f5d0@gmail.com>
Date:   Tue, 27 Oct 2020 22:23:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027091516.GA10762@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 12:15, Krzysztof Kozlowski пишет:
...>> @@ -748,15 +770,18 @@ mc: memory-controller@7000f000 {
>>  
>>  		#iommu-cells = <1>;
>>  		#reset-cells = <1>;
>> +		#interconnect-cells = <1>;
>>  	};
>>  
>> -	memory-controller@7000f400 {
>> +	emc: memory-controller@7000f400 {
>>  		compatible = "nvidia,tegra30-emc";
>>  		reg = <0x7000f400 0x400>;
>>  		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>>  		clocks = <&tegra_car TEGRA30_CLK_EMC>;
>>  
>>  		nvidia,memory-controller = <&mc>;
>> +
> 
> No need for blank line.

It's needed to make MC and EMC nodes look consistent. See the MC node
above which has the blank line.

> 
>> +		#interconnect-cells = <0>;
>>  	};
>>  
>>  	fuse@7000f800 {
