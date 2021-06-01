Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD40396BB4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhFAC7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhFAC7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:59:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261FFC061574;
        Mon, 31 May 2021 19:57:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a4so10476541ljq.9;
        Mon, 31 May 2021 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6bOV0m6bSjQMs9q5FTLo+p3ePrCrQFEL1VNEEZU4fPo=;
        b=GUPERjIbHS3D7MX08jzX2BDddBEcJ4Ya+keANzt9dkaR5SZRsIWM0U7iEZ+MF6+S80
         UQu8apb/tJPzN7IUrx48FeR6bqfYApZ1uRbcFH2Jjt+kb6RncNMPoWzxnXBSkMQOXWmM
         sBvO+BMKTaRMKNkiZp3tYPk5XON/cG+jKLGjsUlOyoiJjzxvCxrDRdFdl0/m8d8yJE5W
         oB80wAY4E3FQb67qY6eo/ah2Wkg/t568VTtp3640CbH+rRtRXFwQfUHAwX3qjZO7KQ6+
         XNiS3Ec9s4WF8G+cc4zhVEMa3h8+PtJ7xXszvFQbBFaRtaP/goGUFyJ8snO2E5BncwOz
         SOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6bOV0m6bSjQMs9q5FTLo+p3ePrCrQFEL1VNEEZU4fPo=;
        b=raX+skxXjGFzAnEXUHwzRp4IKzHnLelH9oKTN5ptYfaANMN7zcBGZoNrRo2JM0nddE
         Pjjrpr1/7phpiaDEugwqMOruKj3Lx9ySdTkiQeOKE90AwgkzzGFG7cfnzR4h8LTTzN4X
         99FWImeq7/mTLnzH+5Z//zuaAdW0uydHdOhJsI1eKO+oXmrekDd4v/dlFaB8g8FgKCtP
         2fwym2tBnlYbdXEG3mAIjkEyDr5ir24S/9BDJApfgIhm0tcIQcqBvQcuFTw3vg+FpGnM
         xX37oP+otDVxrRGFZqEGaUN2ALExOry9nMgVrYMGUFUb26P5vH0lYAPabSxOdXARgbix
         dAyQ==
X-Gm-Message-State: AOAM532UoKLcNHkuPFl0l5RaVvsYXiVR0+1MlyhsfE/aoj9W2W46/dpi
        g3d3GrqSmHN6O8jFChSxbhu1kljz8fQ=
X-Google-Smtp-Source: ABdhPJxb1vITG1iHfDRYnxSrmsnpr+JAGM/ttvgJyF8OrUfmvOdhTugOUmcbJoLwvrEw56BKoH+ZjQ==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr18899000lji.126.1622516256884;
        Mon, 31 May 2021 19:57:36 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id n1sm656492lfi.208.2021.05.31.19.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:57:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210601022319.17938-1-digetx@gmail.com>
 <CGME20210601022420epcas1p3bc087871724a7a9e7cc1569daa2631ab@epcas1p3.samsung.com>
 <20210601022319.17938-2-digetx@gmail.com>
 <6bfdbc0c-bda0-3d43-e103-4d0611966b47@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b7fecb2c-c59a-52ce-1cdf-ae71ee509132@gmail.com>
Date:   Tue, 1 Jun 2021 05:57:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6bfdbc0c-bda0-3d43-e103-4d0611966b47@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 05:55, Chanwoo Choi пишет:
> On 6/1/21 11:23 AM, Dmitry Osipenko wrote:
>> Convert NVIDIA Tegra ACTMON binding to schema.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
>>  .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
>>  2 files changed, 121 insertions(+), 57 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>> deleted file mode 100644
>> index 897eedfa2bc8..000000000000
>> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>> +++ /dev/null
>> @@ -1,57 +0,0 @@
>> -NVIDIA Tegra Activity Monitor
>> -
>> -The activity monitor block collects statistics about the behaviour of other
>> -components in the system. This information can be used to derive the rate at
>> -which the external memory needs to be clocked in order to serve all requests
>> -from the monitored clients.
>> -
>> -Required properties:
>> -- compatible: should be "nvidia,tegra<chip>-actmon"
>> -- reg: offset and length of the register set for the device
>> -- interrupts: standard interrupt property
>> -- clocks: Must contain a phandle and clock specifier pair for each entry in
>> -clock-names. See ../../clock/clock-bindings.txt for details.
>> -- clock-names: Must include the following entries:
>> -  - actmon
>> -  - emc
>> -- resets: Must contain an entry for each entry in reset-names. See
>> -../../reset/reset.txt for details.
>> -- reset-names: Must include the following entries:
>> -  - actmon
>> -- operating-points-v2: See ../bindings/opp/opp.txt for details.
>> -- interconnects: Should contain entries for memory clients sitting on
>> -                 MC->EMC memory interconnect path.
>> -- interconnect-names: Should include name of the interconnect path for each
>> -                      interconnect entry. Consult TRM documentation for
>> -                      information about available memory clients, see MEMORY
>> -                      CONTROLLER section.
>> -
>> -For each opp entry in 'operating-points-v2' table:
>> -- opp-supported-hw: bitfield indicating SoC speedo ID mask
>> -- opp-peak-kBps: peak bandwidth of the memory channel
>> -
>> -Example:
>> -	dfs_opp_table: opp-table {
>> -		compatible = "operating-points-v2";
>> -
>> -		opp@12750000 {
>> -			opp-hz = /bits/ 64 <12750000>;
>> -			opp-supported-hw = <0x000F>;
>> -			opp-peak-kBps = <51000>;
>> -		};
>> -		...
>> -	};
>> -
>> -	actmon@6000c800 {
>> -		compatible = "nvidia,tegra124-actmon";
>> -		reg = <0x0 0x6000c800 0x0 0x400>;
>> -		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>> -		clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
>> -			 <&tegra_car TEGRA124_CLK_EMC>;
>> -		clock-names = "actmon", "emc";
>> -		resets = <&tegra_car 119>;
>> -		reset-names = "actmon";
>> -		operating-points-v2 = <&dfs_opp_table>;
>> -		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
>> -		interconnect-names = "cpu";
>> -	};
>> diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
>> new file mode 100644
>> index 000000000000..ba938eed28ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
>> @@ -0,0 +1,121 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=c852e9c6-97c9d0fb-c8536289-0cc47a31309a-748d620b8cc48f8b&q=1&e=c1b6a671-e53d-468c-81f5-3e23bd2e67d9&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdevfreq%2Fnvidia%2Ctegra30-actmon.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=1abc12fa-45272bc7-1abd99b5-0cc47a31309a-ca738d567d90525e&q=1&e=c1b6a671-e53d-468c-81f5-3e23bd2e67d9&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: NVIDIA Tegra30 Activity Monitor
>> +
>> +maintainers:
>> +  - Dmitry Osipenko <digetx@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +description: |
>> +  The activity monitor block collects statistics about the behaviour of other
>> +  components in the system. This information can be used to derive the rate at
>> +  which the external memory needs to be clocked in order to serve all requests
>> +  from the monitored clients.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra30-actmon
>> +      - nvidia,tegra114-actmon
>> +      - nvidia,tegra124-actmon
>> +      - nvidia,tegra210-actmon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: actmon
>> +      - const: emc
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: actmon
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interconnects:
>> +    minItems: 1
>> +    maxItems: 12
>> +
>> +  interconnect-names:
>> +    minItems: 1
>> +    maxItems: 12
>> +    description:
>> +      Should include name of the interconnect path for each interconnect
>> +      entry. Consult TRM documentation for information about available
>> +      memory clients, see MEMORY CONTROLLER and ACTIVITY MONITOR sections.
>> +
>> +  operating-points-v2:
>> +    description:
>> +      Should contain freqs and voltages and opp-supported-hw property, which
>> +      is a bitfield indicating SoC speedo ID mask.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - interrupts
>> +  - interconnects
>> +  - interconnect-names
>> +  - operating-points-v2
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/memory/tegra30-mc.h>
>> +
>> +    mc: memory-controller@7000f000 {
>> +        compatible = "nvidia,tegra30-mc";
>> +        reg = <0x7000f000 0x400>;
>> +        clocks = <&clk 32>;
>> +        clock-names = "mc";
>> +
>> +        interrupts = <0 77 4>;
>> +
>> +        #iommu-cells = <1>;
>> +        #reset-cells = <1>;
>> +        #interconnect-cells = <1>;
>> +    };
>> +
>> +    emc: external-memory-controller@7000f400 {
>> +        compatible = "nvidia,tegra30-emc";
>> +        reg = <0x7000f400 0x400>;
>> +        interrupts = <0 78 4>;
>> +        clocks = <&clk 57>;
>> +
>> +        nvidia,memory-controller = <&mc>;
>> +        operating-points-v2 = <&dvfs_opp_table>;
>> +        power-domains = <&domain>;
>> +
>> +        #interconnect-cells = <0>;
>> +    };
>> +
>> +    actmon@6000c800 {
>> +        compatible = "nvidia,tegra30-actmon";
>> +        reg = <0x6000c800 0x400>;
>> +        interrupts = <0 45 4>;
>> +        clocks = <&clk 119>, <&clk 57>;
>> +        clock-names = "actmon", "emc";
>> +        resets = <&rst 119>;
>> +        reset-names = "actmon";
>> +        operating-points-v2 = <&dvfs_opp_table>;
>> +        interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
>> +        interconnect-names = "cpu-read";
>> +    };
>>
> 
> If tegra maintainer confirms this patch, I'll take it.

Okay, thank you.

