Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A662299690
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792720AbgJZTOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 15:14:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46850 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367921AbgJZTOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 15:14:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id c21so11469335ljn.13;
        Mon, 26 Oct 2020 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dq2PzuCzxyYXjp7izV7Nz4V/toYcZjqA2m1mpqmQcWc=;
        b=a4A23VompEg7ZU78ZOB4AepZ1yz/UI086hDid7oIuoPSEr3Rt0l3y4puzGzQzMnB7E
         ulmHkfUh0H5mSv+9leZPOZ0nCacUo7tB6u3bFl0Vqr1CjPOVLLkYjGN0miH+IvFUdvI3
         QuTJG/Ut1u1hi4MxUWew1UOC9uB3rZni6HYQA/+d34UJNcEYVBQd2umMR2OcvF+v/L20
         6mYjK3YorWbMAXCk0Z/1+BfGaUW8D1h6sxfupIFpwxeHaYZv6fZhmAIoqomkNeM/9fdD
         9Qd8F9HXHVGAHJp1rV4zcj4BCeVTU5c+rcujkUM1tE0dsIdSkv2ElWLBn0QWyLbRQDyB
         FbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dq2PzuCzxyYXjp7izV7Nz4V/toYcZjqA2m1mpqmQcWc=;
        b=FUFnwc+PFEt8sM9zqzf7AP2aDjnsLhLE4ppASgEvXGIFxhME1fFe2VVF+vF9ZjhXkE
         0ld9MuvZdAYv6j9t1Zo9IyEUtufH3ZMDlcIhLDorUWDWgiZ//xI9oRxo/LVAcC1dy+p6
         yhWUUhu2axMwtxQYwPmh8ORtEbVm7yNOv4nq549gUYmqhxYYsc9APd28H8ylsQ5qcNb8
         XcTACbrwec48XK8uMu834N1miQyNlTMX9DV3Sl6tVh7RK7sft0W8JhocJ9a28ve62ByZ
         NTTZZ31WwzcQsEQJMI8YlW/VrmEEOcPG7TuITssGTVGGmA9KvR3KqpQ0mfvDcYYzpAOp
         GsOQ==
X-Gm-Message-State: AOAM532qiDOFUyIgxZq4xXd8kYKbV61VVWrScmd4hb+bqEb8wLiIZV72
        IthCPVbj/9/Vjr45yp0WiV96J3A5iSc=
X-Google-Smtp-Source: ABdhPJyD0NDjbABoCatjn1w/Ey9Ef6HeuvvsweZ+aBXUAru5GebuoxfPUOebSAQ0Ivmfhv7NpHeadw==
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr6129956ljk.352.1603739652647;
        Mon, 26 Oct 2020 12:14:12 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id r19sm1280779ljn.73.2020.10.26.12.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 12:14:11 -0700 (PDT)
Subject: Re: [PATCH v6 00/52] Introduce memory interconnect for NVIDIA Tegra
 SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <48a5cfdd-c170-f6d3-001a-2d343ecb2c5e@gmail.com>
Date:   Mon, 26 Oct 2020 22:14:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026150845.GA87050@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.10.2020 18:08, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:16:43AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series brings initial support for memory interconnect to Tegra20,
>> Tegra30 and Tegra124 SoCs.
>>
>> For the starter only display controllers and devfreq devices are getting
>> interconnect API support, others could be supported later on. The display
>> controllers have the biggest demand for interconnect API right now because
>> dynamic memory frequency scaling can't be done safely without taking into
>> account bandwidth requirement from the displays. In particular this series
>> fixes distorted display output on T30 Ouya and T124 TK1 devices.
> 
> Hi,
> 
> You introduced in v6 multiple new patches. Could you describe the
> dependencies, if any?

Hello,

The v6 dropped some older patches and replaced them with the new
patches. Previously I wanted to postpone the more complex changes for
later times, like supporting OPP tables and DVFS, but then the review
started to take more time than was expected and there was enough time to
complete those features.

There are five basic sets of patches:

	1. DT bindings
	2. DT changes
	3. SoC, clk and memory
	4. devfreq
	5. DRM

Each set could be applied separately.

Memory patches have a build dependency on the SoC and clk patches.

The "tegra-mc: Add interconnect framework" and "Add and use
devm_tegra_get_memory_controller()" are the root build dependencies for
all memory/ patches. Other patches are grouped per SoC generation
(Tegra20/30/124), patches within a SoC-gen group are interdependent.

I suppose the best variant would be to merge the whole series via
tegra-tree in order to preserve logical order of the patches. Although,
merging each set of patches separately also should be okay to do.
