Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4484139684E
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhEaTXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 15:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhEaTXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 15:23:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A73C061574;
        Mon, 31 May 2021 12:21:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so16151372ljn.13;
        Mon, 31 May 2021 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11twWy/ybOBSLZU1GcEMi3/TJsry3p9YUZOb/UBo0SU=;
        b=FimFuoyvHklH+idplyPIxFbedZS0CGARUdeUAptgg6W+bBA3domtm+elGksLYcJnA7
         +QGSeKeTyrcx7HaO4vFOLplb2k/8+HDBO1KnTx4I9et9hdwqVEUkv+5MzYJIaKOz+/DG
         84AR4KRupVSGTonPGKeJ7+Dzs558CZ6HLWqzt5aVoRAIcGh7F0pmcVduA8RKirguS6yz
         Ios+T0OXt7GNT0SluEWNiQZjBYWd/Y8IEy/PMMcJcdxw+9yyEEw6iNuuYRxctDg6vC0k
         lloasmwsi8Z1XCQnxggGgYLw+jL7yKBBW8a2l29CitWECtEBiKV2RIN7s1e32qe5Elzx
         aHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11twWy/ybOBSLZU1GcEMi3/TJsry3p9YUZOb/UBo0SU=;
        b=PaOf7VvDyauTMCq6IcVAL2Rb4nhh4bF8Q93C5444H02cJ0H7lU3DOnC4L9/1fH4vuy
         cV2yvFJBdnVxQBl1bXQYoa5nAvYd9JTXJ6zWzvWj3i2+CweA0v04+PtPs4bu04umv1np
         hPCwrXPN7dfeV5cq5oEImwYNNm20CC/4+m1dzk+LWYTL4pnLd2iNtKa6nn8Oawg2zSnt
         KTY3MFYbOU07Kq5HDX51nXVesBWHtcLQUoDCT3pXlNmk3dxOjjcoMkaVM2/fW1NCRwNj
         jff5JzuL7azogPJSiZRhJDC4UCBfqFV4VBWbvXGH8vy8xaAb2xlH7OGAFz64NQyKxUUC
         22ug==
X-Gm-Message-State: AOAM532wVwTt1KvlgnEwUVp5IzT3PNrtLQO96XleUMWm/IDWQPBI9rY4
        ePgdEOIpa4LMumgVqwI6bc+zhgRWiHk=
X-Google-Smtp-Source: ABdhPJx/kRxSCpofr/cAMAeaupRusSxI0/KdU/jxoRKesHzPj5YkZKWvP41jSRq/xL5vRFLSWEwM2Q==
X-Received: by 2002:a2e:9c4a:: with SMTP id t10mr18329864ljj.307.1622488901523;
        Mon, 31 May 2021 12:21:41 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id j4sm58945lfm.217.2021.05.31.12.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 12:21:41 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210510211008.30300-1-digetx@gmail.com>
 <20210510211008.30300-4-digetx@gmail.com> <YLSuHejkyPg+DJ0Y@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a447f47-4e8b-120b-8fc5-22764740eb8d@gmail.com>
Date:   Mon, 31 May 2021 22:21:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLSuHejkyPg+DJ0Y@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.05.2021 12:36, Thierry Reding пишет:
> On Tue, May 11, 2021 at 12:10:04AM +0300, Dmitry Osipenko wrote:
>> Convert NVIDIA Tegra ACTMON binding to schema.
>>
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
>> index 000000000000..2a940d5d7ab4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
>> @@ -0,0 +1,121 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/devfreq/nvidia,tegra30-actmon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
>> +      memory clients, see ACTIVITY MONITOR section.
> 
> This used to be "see MEMORY CONTROLLER section", so I looked at the TRM
> to see if this was perhaps a fix for an earlier typo, but looking at the
> TRM (v3) I can't find a section named "ACTIVITY MONITOR".
> 
> Should this be changed back to "MEMORY CONTROLLER"?

The "ACTIVITY MONITOR" is documented only in the T124/210 TRMs, the h/w
modules supported by ACTMON are enumerated there. Both "ACTIVITY
MONITOR" and "MEMORY CONTROLLER" could be mentioned for completeness.
