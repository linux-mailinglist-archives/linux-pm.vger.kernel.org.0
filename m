Return-Path: <linux-pm+bounces-30795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC67B03EC7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243AF7A9AB7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE39247295;
	Mon, 14 Jul 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Psz4i85h"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BF1DBB0C;
	Mon, 14 Jul 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496404; cv=none; b=d2mMkbb1kIEUWecbofP78j/UVUXzLzaNeyaTN01X7Ci7fuGJOwQ6i1SxrF1L2EBpSa+HdkZ6vm0JHKNn6G0PWcA3fPPxsLdlhHI+ooMe/y6E/rFuCeRVYulzIQCPxqqrfRRUcMjUNvR5TPzbc/yNvZDV7U/qbs1jdn+k2AqFQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496404; c=relaxed/simple;
	bh=4irWIhJ4mRp4qA3am0X7ku6qyTiSX9hhxAXsieMpu28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d066PF11SZTd+N/xCLaU0aBdiJwnFbfE6cRAJrChpBvPBh2LHhz2srH0bVkIw3ozzzqcv+EtSLkXv3J1AGaaSTyC9ciY/SFXW94Dz/vQwwBhMWofnaJMJy+alRsAWOw9M5WL8ZyfExEBIrWOrhlZjN4Zu4ex3/2AX5f+zk/VOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Psz4i85h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752496400;
	bh=4irWIhJ4mRp4qA3am0X7ku6qyTiSX9hhxAXsieMpu28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Psz4i85hVOvV3ihew+dZZNJAlptx1OOddZmXypsKodmHlA/Enmv9mzxl522aySVWy
	 asOcdKWO/byCjjuDkcEVL75xfHVALfoxyt0dZCpk7FPcMHNKFDjjWgEFZXpB9/aQ2W
	 +KBL96Yq5FpMWFbNKVATPyqRI0cOUuGN4TmAjC72ahzLMpcHMNYdoOz6rSPjFCzGiJ
	 7BO5+8deLtqNwTmV/wMwKKBqF3yq0RPb72NbjG3gBMtF6NCVWOoGJWe/yNMvQI+M2f
	 dI7jPbBfKYLTo0qLlzEUQgDd9HxIhIyBXdotVepf9ZqBTtDx23yeE6ZnjmIIgIXFYn
	 csVbFyUqx1riA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E55717E05F0;
	Mon, 14 Jul 2025 14:33:19 +0200 (CEST)
Message-ID: <190c5ddd-b89b-427f-abfe-b8ccccb75c3f@collabora.com>
Date: Mon, 14 Jul 2025 14:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: mfd: syscon: Add mt8196 fdvfs syscons
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
 <20250711-mt8196-cpufreq-v1-1-e1b0a3b4ac61@collabora.com>
 <4537173f-7f79-4629-a2ef-cbf1edd2ed81@collabora.com>
 <2866261.BEx9A2HvPv@workhorse>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2866261.BEx9A2HvPv@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/07/25 13:58, Nicolas Frattaroli ha scritto:
> On Monday, 14 July 2025 10:47:32 Central European Summer Time AngeloGioacchino Del Regno wrote:
>> Il 11/07/25 16:57, Nicolas Frattaroli ha scritto:
>>> The MT8196 SoC uses two syscon ranges for CPU DVFS that are separate
>>> from each other. One, mt8196-fdvfs-config, is used to check for a magic
>>> number at that memory address to verify that fdvfs should be used. The
>>> other, mt8196-fdvfs, is used to configure the desired frequency for the
>>> DVFS controller for each CPU core.
>>>
>>
>> What is the reason why you're using syscons here?
>>
>> Can't we simply assign the FDVFS MMIO to the cpufreq-hw node?
> 
> That would require refactoring the driver way more since it currently
> gets the number of performance domains from the number of regs. If
> you want me to do that, I'll need to know how we should disambiguate
> performance domains from misc things like fdvfs. Stuff like string
> comparisons on reg-names seems very ugly for the driver to do, but
> adding a property to explicitly specify the number of performance
> domains would then put into question what the existing binding did
> by just assuming this information is something that implementations
> can get without any ambiguity.
> 
> Even if we forget that Linux is the only kernel that cares about this
> device tree, I'm not totally on board with having the smattering of
> dozens of different tiny register ranges in every DT node on mediatek
> like the vendor kernel does it. And not to forget, it'd change the
> binding even more, to the point where I'd probably have to create a
> new binding for mt8196.
> 

The problem that I see with having a syscon for this is that I can foresee
future SoCs using the same cpufreq-hybrid IP, which means that we'd surely
be cluttering the dt-bindings/mfd/syscon.yaml with a huge list of MediaTek
SoCs (x2, because it's two syscons, even) without having a really-really
valid reason to do so.


>> Or is there any reason why we can't declare it as mmio-sram? ...because I'm not
>> entirely sure but the FDVFS space should effectively be a [c]SRAM memory range...
> 
> mmio-sram is fairly useless for the purposes of having something as
> a fixed set of registers, hence why nobody else does it. From my
> research, it appears to mainly be used if you want to actually treat
> it like a pool of memory from which to then dynamically allocate
> things.
> 
> To use it like a syscon, which is what we're doing, you'll have to
> specify your mmio-sram node, then add a child node as a reserved range
> for the "syscon-like" area, and then specify in ranges that you want
> that child node's address translated into the global address space as
> expected. Then in the driver, you can't just do a single function call
> to get some regmap to write into, you have to follow a phandle in your
> vendor property pointing to said sram range, then get its address,
> translate said address to the global SoC address space, and then iomap
> it. And the cleanup for error paths/driver remove isn't fun either.
> 
> Besides, we don't actually know whether this is an sram range, or how
> large it is. The only confirmed sram range was the csram_sys thing at
> like 0x11bc00 which is not used because it turned out to be useless,
> and dealing with the kernel's sram interface to use it as a reserved
> range just to read 4 bytes from it was a wasted afternoon. And that's
> not even the real starting address of that sram area, that's just a
> part we know is used because downstream uses 5 KiB there for a codepath
> that's dead when fdvfs is present (except the one thing where it installs
> a panic handler to shove something into a register to make it stop dvfs
> logging if the kernel is in the process of crashing).
> 
> I can be convinced to go through the pain of making this mmio-sram if
> I have documentation of the whole memory map of the SoC that shows me
> where and how large each area of sram is, so that I don't need to come
> up with my own starting addresses and offsets based on whatever random
> stuff I can infer from downstream DT.
> 
> Really, every writable syscon is probably implemented as "sram" in
> hardware. But an sram cell that is not general use memory but is
> treated by the hardware as having some meaning is not mmio-sram. We
> can't ever use it in any way other than as a syscon, and telling
> implementations that they can except then slapping a huge reserved
> range into it just makes them have to implement syscons twice, once
> as syscons and once as syscons-except-it's-a-reserved-sram-mmio-range.
> 

I understand. That's a valid reason, it's ok.

I'm not sure though why you're talking about huge restructuring of the MediaTek
cpufreq driver to add the FDVFS registers in the reg list?

There are only two MMIOs that we care about here, right? FDVFS and FDVFS-CONFIG.

Imagine the devicetree node being like this:

performance-controller@1234 {
   compatible = "mediatek,mt8196-cpufreq-hw";
   reg = <0 0xdomain1 0 0xsz>, <0 0xdomain2 0 0xsz>, <0xdomainN 0 0xsz> ...
         <0 0xfdvfs 0 0xsz>, <0 0xfdvfsconfig 0 0xsz>;
   #performance-domain-cells = <1>;
};

If you want, you can even do without having reg-names (though that might be better
for readability), because:

   1. This is a MT8196-specific binding (and node); this means that you can safely
      assume that:
      - There are three clusters (ignorable)
      - There is FDVFS support (not ignorable)
   2. No other SoC will ever use the MT8196 binding without being compatible with it
      and anyway newer socs will need something like
      compatible = "mediatek,mt1234-cpufreq-hw", "mediatek,mt8196-cpufreq-hw";
      - This means that N.1 still stands for new SoCs

So I do see two solutions here, of which I kinda prefer the one without reg-names.

With reg-names:
  1. Check all MMIOs named "domain%u" (domain0, domain1, domain2): this kind-of
     reflects the naming of the cpufreq policies (policy0...N), which even keeps
     things consistent between both hardware names and cpufreq software names (but
     of course - as long as HW is described in bindings, we don't care about any
     software defined names);
     - This gives you the number of performance domains, 3 in the specific case
       of the MT8196 SoC (and some future others for sure!)
  2. Get reg by name: "fdvfs-base", "fdvfs-config"

Without reg-names:
  1. Define the following in the dt-bindings for the cpufreq with fdvfs:
     reg:
       - description: FDVFS Performance State (or voltage?) setting region
       - description: FDVFS Configuration region
       - description: Cluster 0 OPP tables and Performance State setting region
       - description: Cluster 1 OPP tables and ...
       - description: Cluster 2 OPP tables and ...
       (new socs) - description: Cluster 3 ... etc etc etc
  2. Add the MT8196 conditionals and exclusions:
     if: (blahblah) mediatek,mt8196-cpufreq-hw
     then: reg:   minItems: 5    maxItems: 5
  3. Modify the driver like so:
     - Add platform data for MT8196, and set a "uses_fdvfs = true" (or something
       like that, anyway, your call about the naming)
     - Get the FDVFS regions:
         fdvfs_base = devm_platform_ioremap_resource(pdev, 0);
         error_checking_here();
         fdvfs_config = devm_platform_ioremap_resource(pdev, 1);
         error_checking_here();

         static int mtk_cpu_resources_init(.....)
         {
           .....code......
           index = args.args[0]; /* performance-domains number after parsing */

           if (pdata->uses_fdvfs)
             index += 2;

           ...code... (no further modification required)
         }
   4. Profit!

Now, if you're thinking about *guaranteeing* that FDVFS is always the first two
MMIOs in the node... just do not care.

You are already enforcing that with devicetree bindings, so that's how you are
guaranteeing that.

Anyway - If you want to make an entirely new binding named
            mediatek,mt8196-cpufreq-hw.yaml
noone prevents you from doing that.

If the binding describes the same hardware, it is WRONG to create a new one, but
in this case it would be describing *new hardware* that is incompatible with the
previous version, so that's RIGHT to do.

You don't need to have two drivers for two bindings, either.

You can have one driver with two different bindings, as long as it makes sense to
have that (as in, if the two are incompatible in the binding, but in the actual
code it still makes sense to have both in the same driver, that's ok).

Cheers!
Angelo

>>
>> Cheers,
>> Angelo
>>
> 
> Kind regards,
> Nicolas Frattaroli
> 
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>>    Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..5ee49d2ba0cdb72dd697a0fd71c8416ad4fd2c1e 100644
>>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> @@ -88,6 +88,8 @@ select:
>>>              - mediatek,mt8135-pctl-a-syscfg
>>>              - mediatek,mt8135-pctl-b-syscfg
>>>              - mediatek,mt8173-pctl-a-syscfg
>>> +          - mediatek,mt8196-fdvfs
>>> +          - mediatek,mt8196-fdvfs-config
>>>              - mediatek,mt8365-syscfg
>>>              - microchip,lan966x-cpu-syscon
>>>              - microchip,mpfs-sysreg-scb
>>> @@ -194,6 +196,8 @@ properties:
>>>              - mediatek,mt8135-pctl-a-syscfg
>>>              - mediatek,mt8135-pctl-b-syscfg
>>>              - mediatek,mt8173-pctl-a-syscfg
>>> +          - mediatek,mt8196-fdvfs
>>> +          - mediatek,mt8196-fdvfs-config
>>>              - mediatek,mt8365-infracfg-nao
>>>              - mediatek,mt8365-syscfg
>>>              - microchip,lan966x-cpu-syscon
>>>
>>
>>
>>
> 
> 
> 
> 

