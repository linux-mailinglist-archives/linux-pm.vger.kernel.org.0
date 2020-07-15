Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19C2209E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGOKW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 06:22:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15423 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgGOKW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 06:22:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ed8c80000>; Wed, 15 Jul 2020 03:22:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 03:22:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jul 2020 03:22:58 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 10:22:51 +0000
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 1/4] dt-bindings: arm: Add NVIDIA
 Tegra194 CPU Complex binding
To:     Rob Herring <robh@kernel.org>
CC:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <mirq-linux@rere.qmqm.pl>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <CAL_JsqL1CuumdT1CZiofEZw9j+3gsir8JwSrZVfcxFxEB=bavQ@mail.gmail.com>
 <1594742870-19957-1-git-send-email-sumitg@nvidia.com>
 <20200714204742.GA2875540@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <a5b83dc3-63b9-9140-a7fe-52841d079141@nvidia.com>
Date:   Wed, 15 Jul 2020 15:52:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714204742.GA2875540@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594808520; bh=yKUyW+CknpzoQCQidsJMAoY5rvG/iaJnlvE4IRnqLV4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z2qKm0LSpfvnHREtzkU2lOvqF8Gz4OH+wAHdBZihmJADIHhV6KcfoWt7S96f5nhPN
         eZ4Cp/J1KjKebsBr8xrKsPzK12Y3/w1zFPNmQ1PPey6Lsf391z11bPFmrBh8PFon8L
         wnZeQzqIDeoMz+74p0q+1N76leIfRT96ccQsV9QFnAsYfMNnuZRERPkBsz5h76bcvG
         S+etb2C9E5EoW9f4gLtjBEIXgHJoF+FS+/4rKKD+3fVyHJUs0XgQ9tb+uvO3gjs1bA
         6zNH7WE3KEe31w2VmMO+O2AeP5ljH/77dR6RxIkyJdx4ej6p9H89W5pUv4uFlwetfN
         Ts06A0XyMTDpQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you for the review.

>> Add device-tree binding documentation to represent Tegra194
>> CPU Complex with compatible string under 'cpus' node. This
>> can be used by drivers like cpufreq which don't have their
>> node or CPU Complex node to bind to. Also, documenting
>> 'nvidia,bpmp' property which points to BPMP device.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 106 +++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
>> new file mode 100644
>> index 0000000..06dbdaa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
>> @@ -0,0 +1,106 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license please.
> 
Ok.

>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/nvidia,tegra194-ccplex.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra194 CPU Complex device tree bindings
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jonathan Hunter <jonathanh@nvidia.com>
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +
>> +description: |+
>> +  Tegra194 SOC has homogeneous architecture where each cluster has two
>> +  symmetric cores. Compatible string in "cpus" node represents the CPU
>> +  Complex having all clusters.
>> +
>> +properties:
> 
> $nodename:
>    const: cpus
> 
Ok.

>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-ccplex
>> +
>> +  nvidia,bpmp:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description: |
>> +      Specifies the bpmp node that needs to be queried to get
>> +      operating point data for all CPUs.
>> +
>> +      Optional for systems that have a "compatible"
>> +      property value of "nvidia,tegra194-ccplex".
> 
> The schema says this already.
> 
Removed this text from here.

>> +
>> +  "#address-cells":
>> +    const: 1
> 
> This is wrong. The binding says it's 2 cells on aarch64 cpus though we
> don't enforce that.
>Removed.

>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +dependencies:
>> +  nvidia,bpmp: [compatible]
> 
> This is kind of redundant as 'compatible' is required in order to apply
> the schema.
>
Removed this as well.

>> +
>> +examples:
>> +  - |
>> +    cpus {
>> +      compatible = "nvidia,tegra194-ccplex";
>> +      nvidia,bpmp = <&bpmp>;
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      cpu0_0: cpu@0 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x0>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu0_1: cpu@1 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x001>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu1_0: cpu@100 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x100>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu1_1: cpu@101 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x101>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu2_0: cpu@200 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x200>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu2_1: cpu@201 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x201>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu3_0: cpu@300 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x300>;
>> +        enable-method = "psci";
>> +      };
>> +
>> +      cpu3_1: cpu@301 {
>> +        compatible = "nvidia,tegra194-carmel";
>> +        device_type = "cpu";
>> +        reg = <0x301>;
>> +        enable-method = "psci";
>> +       };
> 
> Not really that useful describing all these cpus.
> 
Ok. Kept first four cpu nodes only.

>> +    };
>> +...
>> --
>> 2.7.4
>>
