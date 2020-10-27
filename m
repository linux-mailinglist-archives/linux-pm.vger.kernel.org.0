Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5929C8B8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371909AbgJ0TUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:20:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42911 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829597AbgJ0TRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:17:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id h20so3063242lji.9;
        Tue, 27 Oct 2020 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ifIWTd3Ns3z5oJhEjPKk2k9PCzO7a2NWGp66DijjkQk=;
        b=Qijb1sXa3G16lZSKA+nEkMxTIFLBrOUy5Rr9ZwMWzohV066o4tDSKTy574Ssd2HZZh
         E2Fya2EazJhBeeVSaKb/aoec4Xjb3Sg/S4tal9lKtluK/G1J06H5EFvkpePIUcIIQP2g
         7U2rOnrH/qSw85t6v9OUvCjIUIQ04tUXCftdChd+osjOsMgsnvfxh4itMs3zC+xHgGvX
         gGzBF7NcJIdI8YEIfWlQDa//AsReWvaZGwbaNR+GAJoMmtu1Z14PmNoJrw8Oxw2vehJv
         M/QQl1LS3HTPuzC/JaB3lNxk9IX1y2oJeYxSq5skCG1eaUleaZv24CBcN51vTntgmiUu
         PvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifIWTd3Ns3z5oJhEjPKk2k9PCzO7a2NWGp66DijjkQk=;
        b=aCmUr2F2aLYFFKhR5if3uAZ2KQiJZ6WbOEPxSuxUzn7bfaFIBwEcWBy2IMbpJa6o1q
         /cN+WvfXQXxrr+5GM8YwwrUpzlgSif4pqxYeaPdMv8mlCNAfqV9cs2RCtAmU1xdPeBFG
         AA9+MzqbhR0SeeZw0bLvMoyhGSVMWIstqyrMhtEEJRQzHQyhyqZSl2rOUO0dDRnTfOWX
         3KQwjg2ZmXi6J6EjM+BTsBbDxKC34FxVHaXCDTHDF2Dam8OX8ipA+rn2wsOfMEnG/gyJ
         hH96dsW9BoXqr/HmH3qx6ul/0GBwBazL7BRTADJNg4h0HhWyc2KAnGB+hzZ4hcgihONX
         HOuA==
X-Gm-Message-State: AOAM530SIIGxJFvfCALY97PnHWCTaB/7blCWSnt3Hl98oDJgnv4P0Omk
        KST1e7noGTji3KawL8cypTSomxBN/ho=
X-Google-Smtp-Source: ABdhPJyPI9JpflgVqg2iXiOFHiXQeJRvyXlDI/bHczUvMHXIiq4h5JDmIqgByTyJAgr+vMgcI23YaA==
X-Received: by 2002:a2e:8985:: with SMTP id c5mr1866622lji.406.1603826269920;
        Tue, 27 Oct 2020 12:17:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id y7sm151668lff.153.2020.10.27.12.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:17:49 -0700 (PDT)
Subject: Re: [PATCH v6 05/52] dt-bindings: memory: tegra20: mc: Document new
 interconnect property
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
 <20201025221735.3062-6-digetx@gmail.com> <20201027085548.GE4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <abf1df6c-3e45-209c-244e-356d88b454aa@gmail.com>
Date:   Tue, 27 Oct 2020 22:17:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027085548.GE4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 11:55, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:16:48AM +0300, Dmitry Osipenko wrote:
>> Memory controller is interconnected with memory clients and with the
>> External Memory Controller. Document new interconnect property which
>> turns memory controller into interconnect provider.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
>> index e55328237df4..739b7c6f2e26 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
>> @@ -16,6 +16,8 @@ Required properties:
>>    IOMMU specifier needed to encode an address. GART supports only a single
>>    address space that is shared by all devices, therefore no additional
>>    information needed for the address encoding.
>> +- #interconnect-cells : Should be 1. This cell represents memory client.
>> +  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.
> 
> This is a list of required properties so you break the ABI. All existing
> DTBs will be affected.

This is optional property for the older DTBs, but for newer DTs it's
mandatory. IIUC, it should be defined as a required property in the
binding.

Please see tegra_mc_interconnect_setup() in "memory: tegra-mc: Add
interconnect framework", which check presence of the ICC DT property.
