Return-Path: <linux-pm+bounces-17485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14F9C7599
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C3928806F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704D13D53F;
	Wed, 13 Nov 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="e3NTgin0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666C171C9;
	Wed, 13 Nov 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510467; cv=none; b=bi0GWxrSX1zQr/fWEuCN9xP2J714O7lJPWfF0ZgwjBloy9Pa1lsC/0081KruV2NFhBCBieGhUNkGl0NN527K7nnZS3LlqY6VHwTKJ4GqtADS3FNKoJrxu9nb9aDLny7lD3E+C8T7GxfsEWYormbqEQWD4O0leuvkEnv2gLplmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510467; c=relaxed/simple;
	bh=H0yGji2iT1spJG+9g1OpFuNEiQisUHAdfC779LlT0VA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mHbkvvqUzat0aII8AnvmT8AcB9yqtK/cjqiUVcZN+zFM546sBEoDf3+1YnrVifE/fz1TzUX77Wk4Cc/EnZSzm9feHy3TD+eVctTxrzJOupJa7vEQTACKfRO5ZmnV79m5W0TPJ/zHJqJRrj1T1FHXNOivG6DXYOhW0vGhc2LX3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=e3NTgin0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 3D162E44EA;
	Wed, 13 Nov 2024 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8i3R/fzkAitpNlgR9VCp3wgJnOJj83cQ/N61OxxoCI=;
	b=e3NTgin0MdZk+2iF9LFvZSTdFD+Cj6xa7NXhKQiHgDCUG+gFClvXqf6tNgWoA6bWegiIZz
	bl0bMhUmLqKx0vKGd8nWviW2yWsJ366M8UL12hhzJ+AJICKmtWuCagVeclX1sAMU27+3L1
	gSVmvLvyD2hHJW0vvZSfWzISHuAVmldIeoHG5Rd7H56+SdWmhUgBV7Kuw465eVNk+ERzTj
	tDmBOseoinxGdVcpVHj8snBzfha4fZtVtWf90QsnShJxQflzla5xTCLotgmkM0T05iezcC
	XNEZvQDV0YC3BAHSIbO0JxGO6gKiLhSwjVoGjVBKX1iV2e1ioARXqt69ZR0KYw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 16:07:43 +0100
From: barnabas.czeman@mainlining.org
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz
 Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
In-Reply-To: <ZzRtEHsC4MROxN3v@linaro.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
 <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>
 <ZzOQEgLLhkH-IymV@linaro.org>
 <0dae1cea420bd335be591e4b1be3d07c@mainlining.org>
 <ZzRtEHsC4MROxN3v@linaro.org>
Message-ID: <4415406af1e9bc066a048b9729a0c592@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-13 10:10, Stephan Gerhold wrote:
> On Tue, Nov 12, 2024 at 07:49:18PM +0100, 
> barnabas.czeman@mainlining.org wrote:
>> On 2024-11-12 18:27, Stephan Gerhold wrote:
>> > On Tue, Nov 12, 2024 at 04:49:38PM +0100, Barnabás Czémán wrote:
>> > > From: Otto Pflüger <otto.pflueger@abscue.de>
>> > >
>> > > Add initial support for MSM8917 SoC.
>> > >
>> > > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> > > [reword commit, rebase, fix schema errors]
>> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> > > ---
>> > >  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1974
>> > > +++++++++++++++++++++++++++++++++
>> > >  1 file changed, 1974 insertions(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> > > b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> > > new file mode 100644
>> > > index 0000000000000000000000000000000000000000..cf0a0eec1141e11faca0ee9705d6348ab32a0f50
>> > > --- /dev/null
>> > > +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> > > @@ -0,0 +1,1974 @@
>> > > [...]
>> > > +		domain-idle-states {
>> > > +			cluster_sleep_0: cluster-sleep-0 {
>> > > +				compatible = "domain-idle-state";
>> > > +				arm,psci-suspend-param = <0x41000023>;
>> > > +				entry-latency-us = <700>;
>> > > +				exit-latency-us = <650>;
>> > > +				min-residency-us = <1972>;
>> > > +			};
>> > > +
>> > > +			cluster_sleep_1: cluster-sleep-1 {
>> > > +				compatible = "domain-idle-state";
>> > > +				arm,psci-suspend-param = <0x41000043>;
>> > > +				entry-latency-us = <240>;
>> > > +				exit-latency-us = <280>;
>> > > +				min-residency-us = <806>;
>> > > +			};
>> >
>> > I think my comment here is still open:
>> >
>> > This is strange, the deeper sleep state has lower timings than the
>> > previous one?
>> I was reordering based on Konrad comments when i have renamed the 
>> nodes
>> maybe it is not correct then.
>> I am searching for how to validate these levels, i have find these
>> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/arch/arm64/boot/dts/qcom/msm8917-pm.dtsi#L45-91
> 
> I think you translated them correctly. It feels like downstream is 
> weird
> or even wrong here. Usually a higher psci-mode (retention = 2, gdhs = 
> 4)
> also implies a deeper idle state. But at some point the
> perf-l2-retention and perf-l2-gdhs state were swapped downstream:
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/dea262a17a9e80dacb86b7c2f269bcc7b4df3a13
> 
> I don't know if this is intended or just an oversight. If no one can
> clarify why this change was done I guess we can just choose between the
> following two options:
> 
>  1. Describe it exactly like it was done downstream. In that case I
>     would suggest swapping the node order back to what you had in v1.
>     Even if that means that a lower idle state has the higher psci-mode
>     (arm,psci-suspend-param). That should match what downstream did.
> 
> OR
> 
>  2. Omit cluster-sleep-0 and cluster-sleep-1. I doubt anyone will 
> notice
>     the minor difference in power consumption. The most important idle
>     state is the deepest "power collapse" (PC) state.
> 
> @Konrad: Do you have any opinion here?
> 
>> Do you know where can i find psci-suspend-param-s?
> 
> You need to translate it like in this code here:
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/drivers/cpuidle/lpm-levels.c#L1337-1340
> 
> Roughly described:
>  - Set BIT(30) if the CPU state has qcom,is-reset
>  - Affinity level is the hierarchy level that goes idle.
>    In your case: CPU = 0, L2 cache/cluster = 1.
>    Shift that to bit 24 (1 << 24 for cache/cluster)
>  - For the state itself you need to combine the qcom,psci-cpu-mode and
>    qcom,psci-mode according to the qcom,psci-mode-shift.
> 
> E.g. for the "perf-l2-pc" state, combined with the deepest CPU state
> ("pc"):
> 
>  - BIT(30) is set because of qcom,is-reset
>  - (1 << 24) because it's a L2 cache/cluster idle state
>  - (qcom,psci-cpu-mode = <3>) << (qcom,psci-mode-shift = <0>) = (3 << 
> 0)
>  - (qcom,psci-mode = <5>) << (qcom,psci-mode-shift = <4>) = (5 << 4)
> 
> All that combined: BIT(30) | (1 << 24) | (3 << 0) | (5 << 4)
>   = 0x41000053
> 
Thanks a lot this is a very useful description.
> Which is what you have for cluster-sleep-2. The ones you have look
> correct to me. :-)
> 
>> Should I also add wfi level?
> 
> I think we usually omit those for the CPU at least. Not sure about the
> cache/cluster one. As I mentioned, at the end the most important idle
> state to have is the deepest ones. Those will get used during suspend
> and when you don't use the device. The others are more minor
> optimization for light usage, which will be less noticeable.
> 
> Thanks,
> Stephan

