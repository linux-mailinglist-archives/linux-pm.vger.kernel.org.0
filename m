Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE0829CA3A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372943AbgJ0Ubh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:31:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45726 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440994AbgJ0Ubg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:31:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id r127so3986399lff.12;
        Tue, 27 Oct 2020 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZzHJ/7NeZExgsunyfO6ZfY1UAlL8FX3D4MJN37d8Kc=;
        b=dkprteH6MJaH2lEYyvuiY+KFy1bIfXVr/+v/dDO8RFt3TYQ15nqUdlrvqtbXlnuQyU
         hk44qbAj7JL7Zj25MKFgvK6wgde3kiQ1Z0XMr2LsTIzLhk6saIQhQ+aIOQslZ0S0Fz99
         Za4L6dgwZsJcGS2ZjIuR4y7JnESEokI6oynHLfsIFpncmk6UEia54Vj3A3ry3Gw9Z/Ts
         iKvVpE/D5/o2kLVRlSseU9x7YpdSXu693y1+NJetFFM+hfg/msVOYo9hrOU6GtiJgYxL
         sjbLmbv03VCbo4NmaDEcnCjDMlbt0KkGKjVxVINaWeGfJjwUdHvTPcT1UilN+vIJvte5
         jLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZzHJ/7NeZExgsunyfO6ZfY1UAlL8FX3D4MJN37d8Kc=;
        b=oo/g0YeBkk6Wp7SVb0jbb2CXGnGV6M3DAIstfcJz6dBxV6E9yy9rxHOTq0CXYxOCcw
         uvaVbwYNF57td9Sxe4JbOkdIUJAML/zXymFW8sTuQea/lOPow8NfXAORbijt9+IA1wHm
         n/rTYc4Baltj3ENQSUqF3xw4Mktx59asq6RwSlGwXW3hcrjrluz2BFvRbAlHDtomoIC/
         fapmaOXjyj26nJephZeMvzH/yODn9BL/MjFBBTxMIUdWM2qB2kutORHTafB4PUSlBwrJ
         J5VUvCmwTny1L3S7gHAh11z/V3tUKtLe+yHNIB4kz5A4+anEE00SeO8/bH2jcEQq3YZu
         qh1A==
X-Gm-Message-State: AOAM532cz/13MY819E4ngV9YwoGtcdK4CDzTd8qpeV/zbNmsuQ1iTZJI
        h8mHS/cDR2KQqo3/LVo9JqZ6r4MlsKs=
X-Google-Smtp-Source: ABdhPJzNMj0LN6XhsMz5QH8AiE+1a+5eBjRU9XoZxefttcRzYbvUWa8NQCOCaELsI3+Laoc3yuReuw==
X-Received: by 2002:a19:cc8f:: with SMTP id c137mr1496095lfg.476.1603830693398;
        Tue, 27 Oct 2020 13:31:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id m26sm284461lfq.296.2020.10.27.13.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:31:32 -0700 (PDT)
Subject: Re: [PATCH v6 00/52] Introduce memory interconnect for NVIDIA Tegra
 SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201026150845.GA87050@kozik-lap>
 <48a5cfdd-c170-f6d3-001a-2d343ecb2c5e@gmail.com>
 <20201027085253.GC4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <42d78289-3438-88a2-ed7a-a8a15c5ea938@gmail.com>
Date:   Tue, 27 Oct 2020 23:31:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027085253.GC4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 11:52, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 10:14:10PM +0300, Dmitry Osipenko wrote:
>> 26.10.2020 18:08, Krzysztof Kozlowski пишет:
>>> On Mon, Oct 26, 2020 at 01:16:43AM +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This series brings initial support for memory interconnect to Tegra20,
>>>> Tegra30 and Tegra124 SoCs.
>>>>
>>>> For the starter only display controllers and devfreq devices are getting
>>>> interconnect API support, others could be supported later on. The display
>>>> controllers have the biggest demand for interconnect API right now because
>>>> dynamic memory frequency scaling can't be done safely without taking into
>>>> account bandwidth requirement from the displays. In particular this series
>>>> fixes distorted display output on T30 Ouya and T124 TK1 devices.
>>>
>>> Hi,
>>>
>>> You introduced in v6 multiple new patches. Could you describe the
>>> dependencies, if any?
>>
>> Hello,
>>
>> The v6 dropped some older patches and replaced them with the new
>> patches. Previously I wanted to postpone the more complex changes for
>> later times, like supporting OPP tables and DVFS, but then the review
>> started to take more time than was expected and there was enough time to
>> complete those features.
>>
>> There are five basic sets of patches:
>>
>> 	1. DT bindings
>> 	2. DT changes
>> 	3. SoC, clk and memory
>> 	4. devfreq
>> 	5. DRM
>>
>> Each set could be applied separately.
>>
>> Memory patches have a build dependency on the SoC and clk patches.
>>
>> The "tegra-mc: Add interconnect framework" and "Add and use
>> devm_tegra_get_memory_controller()" are the root build dependencies for
>> all memory/ patches. Other patches are grouped per SoC generation
>> (Tegra20/30/124), patches within a SoC-gen group are interdependent.
>>
>> I suppose the best variant would be to merge the whole series via
>> tegra-tree in order to preserve logical order of the patches. Although,
>> merging each set of patches separately also should be okay to do.
> 
> Thanks for explanation. I already have three patches for Tegra MC (and
> probably two more will be respun) so this might be conflict-prone. The
> easiest in such case is to provide me soc and clk patches on the branch,
> so I could keep all Tegra MC together.

Okay, but those T210 patches don't touch the same code, neither same
source files. For now there should be no merge conflicts.
