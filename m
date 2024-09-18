Return-Path: <linux-pm+bounces-14391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0DE97B8C4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9100028381A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76810166F1A;
	Wed, 18 Sep 2024 07:48:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7655C1514C6
	for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645683; cv=none; b=YN/UvnxM0U0SnaxtHUKhoCA+xaMC0F6FM5aWK/pgX0+J/qepIcAu7bz8s4K+pbpO0D6yGM5prsmLVtyRyahU9OnQwuXtIA7ArQBw5heceyen+EF3vqnmeAdA1b24ueXJk0YhNN0BR8nAhDwlYkwfAZ8uYlAFVZAtKLT4qitLgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645683; c=relaxed/simple;
	bh=7VZLkZdphgXKqxJSek9eYrgdx8KXrXJxDSlgmyS0bXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7cbYTQdd0OvOYNSjqwqSbfy/+O0MPnCkqfqyZOdpBIuLapsgl/MGax0rHU8NwXsUClftAzoHqzELmHqCrn0wUv98G/Xp+dTB/W8MSdO9/wX9CK06Kqq9c9DC7TYG+nv28Qd3soSzGyJgTWYKAA87Gw1mNumv+bvXT1XoNwVMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53F4FEC;
	Wed, 18 Sep 2024 00:48:26 -0700 (PDT)
Received: from [10.57.51.157] (unknown [10.57.51.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83E1A3F66E;
	Wed, 18 Sep 2024 00:47:56 -0700 (PDT)
Message-ID: <a2ca883e-122e-43a1-b377-c43956b5b3be@arm.com>
Date: Wed, 18 Sep 2024 08:48:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
 ondemand Governor
To: "chenshuo@eswincomputing.com" <chenshuo@eswincomputing.com>
Cc: linux-pm <linux-pm@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <202409101046414978042@eswincomputing.com>
 <f4478146-88d3-445c-8676-7246bf477c50@arm.com>
 <202409101831099346787@eswincomputing.com>
 <202409181441135658871@eswincomputing.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202409181441135658871@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 9/18/24 07:41, chenshuo@eswincomputing.com wrote:
>>> On 9/10/24 03:46, chenshuo@eswincomputing.com wrote:
>>>> Hi Rafael,
>>>   
>>> (+CC Lukasz)
>>>   
>>>>
>>>> I am encountering an issue related to the Energy Model (EM) when using cpufreq with the ondemand governor. Below is a detailed description:
>>>>
>>>> 1. Problem Description:
>>>>     When using cpufreq with the ondemand governor and enabling the energy model (EM), the CPU OPP table is configured with frequencies and voltages for each frequency point. Additionally, the `dynamic-power-coefficient` is configured in the DTS under the CPU node. However, I observe abnormal dynamic frequency scaling, where the CPU frequency always stays at the highest frequency point in the OPP table. Below is an example of the DTS configuration:
>>>> ```
>>>> cpu0: cpu@0
>>>> {
>>>> ...
>>>> operating-points-v2 = <&d0_cpu_opp_table>;
>>>   
>>> Do you mind sharing <&d0_cpu_opp_table>?
>>>   
>> Of course, the entire DTS file is inconvenient to copy, the main useful segments I have are:
>> ```
>> d0_cpu_opp_table: opp-table0 {
>> compatible = "operating-points-v2";
>> opp-shared;
>>
>> opp-24000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_24M>;
>> opp-microvolt = <800000>;

The voltage is constant in your OPP table, for all frequencies.
That's the main problem.

>> clock-latency-ns = <70000>;
>> };
>> opp-100000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_100M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-200000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_200M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-400000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_400M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-500000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_500M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-600000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_600M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-700000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_700M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-800000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_800M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-900000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_900M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-1000000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_1000M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-1200000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_1200M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-1300000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_1300M>;
>> opp-microvolt = <800000>;
>> clock-latency-ns = <70000>;
>> };
>> opp-1400000000 {
>> opp-hz = /bits/ 64 <CLK_FREQ_1400M>;
>> opp-microvolt = <800000>;

Even for the fmax here.

<snip>

>> Despite this, under an ondemand policy based on DVFS, the software might not know the real power consumption, and can only use the formula P=C*V^2*f*usage_rate.
>> Additionally, this at least ensures that the thermal framework using the IPA strategy can properly cool down.
> Regarding this problem, are there any errors or omissions in my settings? If not, do you have any better solutions? Looking forward to your reply!

The EM framework works correctly. It cannot do much, when all voltages
are the same for all OPPs.

It's hard to say if this is a real voltage that is needed for
that silicon to operate. You will have to figure this out and maybe
change them. Although, this is dangerous operation and if you don't
have documentation for the chip or HW engineer support, I would
recommend you to NOT do this.

If that voltage is set to your HW, then the real power will
driven by this voltage, so you have inefficient OPPs.

If you think that this voltage is not the final set to the HW,
e.g. due to FW controlling final values, then you can
try a workaround...

The other option for you to workaround the const. voltage
information problem is to add 'opp-microwatt' values to your
OPP table. This is much safer and it will be used by the
EM and other related subsystems.
Please check this doc links:

https://elixir.bootlin.com/linux/v6.11/source/Documentation/power/energy-model.rst#L145

https://elixir.bootlin.com/linux/v6.11/source/Documentation/devicetree/bindings/opp/opp-v2-base.yaml#L104

In this case you can add power values for each OPP, to make sure
they are efficient.

Regards,
Lukasz

