Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0421EF9D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGNLoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 07:44:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17282 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNLoA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 07:44:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0d9a720000>; Tue, 14 Jul 2020 04:43:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 04:43:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 04:43:59 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 11:43:51 +0000
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 1/4] dt-bindings: arm: Add t194 ccplex
 compatible and bpmp property
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
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-2-git-send-email-sumitg@nvidia.com>
 <20200713164214.GA341271@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <70a0a8ee-b79a-2a05-5150-2ee0faaf2730@nvidia.com>
Date:   Tue, 14 Jul 2020 17:13:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200713164214.GA341271@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594727027; bh=UrDpE1YD14GDWCNhmIrtodld5JLaTd22aLzUVIM8f98=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mMHZutoFQHCAIoy3C50Yj8sRZfz8bUZeBCDekvCUEPPE8fsSz4fwzSQExX22vT/cZ
         CflAgHY7F7DJQ0Ib4eEEBXTwMFoxODxAFuZ7sqHypnZdLsr1h4XhH0RpEetY5HUKUq
         dpdSChmaeb86JPmxsDAXX5wUYvBjjNXhm6RcDVwsF0ZUP0UzXoU78qq0SEFs+zR/Ak
         KPnQHXDPepa0yEXM9VUFQMFH/fIJIQfTam+Zy1qhexBLYqL8k6s2t6w8P2vQ65lKZJ
         m67IHksK0pXbcM+jcJ+j556VUZyo8+yLif9IcjmoS32tdNUvZbpy57tu1db+VDf5g0
         mRMvlTySolpVA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Mon, Jul 13, 2020 at 07:36:46PM +0530, Sumit Gupta wrote:
>> To do frequency scaling on all CPUs within T194 CPU Complex, we need
>> to query BPMP for data on valid operating points. Document a compatible
>> string under 'cpus' node to represent the CPU Complex for binding drivers
>> like cpufreq which don't have their node or CPU Complex node to bind to.
>> Also, document a property to point to the BPMP device that can be queried
>> for all CPUs.
> 
> The cpus.yaml binding documents what's in 'cpu' nodes, not 'cpus'
> node. AIUI, the latter is what you want. You should do your own schema
> file here.
> 
Do you mean to change existing file name from 'cpus.yaml' to 'cpu.yaml' 
and create new 'cpus.yaml' file?
I think it's better to incorporate the change in existing 'cpus.yaml' 
file to keep both cpu@X and cpus node details together. Please suggest.

>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/arm/cpus.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
>> index a018147..9b328e3 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>> @@ -162,6 +162,7 @@ properties:
>>         - nvidia,tegra132-denver
>>         - nvidia,tegra186-denver
>>         - nvidia,tegra194-carmel
>> +      - nvidia,tegra194-ccplex
> 
> Tegra194 has 2 different CPUs?
> 
No, T194 SOC has homogeneous architecture with four clusters where each 
cluster has two symmetric cores. 'nvidia,tegra194-carmel' compatible 
string represents each cpu. 'nvidia,tegra194-ccplex' string represents 
the CPU Complex to bind cpufreq driver. The change was done as per 
discussion [1]

>>         - qcom,krait
>>         - qcom,kryo
>>         - qcom,kryo260
>> @@ -255,6 +256,15 @@ properties:
>>
>>         where voltage is in V, frequency is in MHz.
>>
>> +  nvidia,bpmp:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description: |
>> +      Specifies the bpmp node that needs to be queried to get
>> +      operating point data for all CPUs.
>> +
>> +      Optional for systems that have a "compatible"
>> +      property value of "nvidia,tegra194-ccplex".
>> +
>>     power-domains:
>>       $ref: '/schemas/types.yaml#/definitions/phandle-array'
>>       description:
>> @@ -340,6 +350,7 @@ required:
>>
>>   dependencies:
>>     rockchip,pmu: [enable-method]
>> +  nvidia,bpmp: [compatible]
>>
>>   examples:
>>     - |
>> --
>> 2.7.4
>>

[1] https://marc.info/?l=linux-arm-kernel&m=158999171528418&w=2
