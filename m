Return-Path: <linux-pm+bounces-17250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9C9C2C36
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677A4B21D94
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5B1553A1;
	Sat,  9 Nov 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bcu1HUbV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CF13B586;
	Sat,  9 Nov 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152218; cv=none; b=NsM3u2VDwytTBBx36qsqTIqCvfr0G+Wf7mbBPJUvrisezw4ZgHqwkOmBfzJzTI1w8dQ7qdb8bJkpJfJb+xFwe2SPMmRdHqXPakvUEr8XMySv62GggwS2uwZ/2XmVJdqSBf7s8jhmLaX381DTTPS0uW6py6Xjy86df3MZoR/cB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152218; c=relaxed/simple;
	bh=V1UawUSDKQW4GamWm1KN87sxKxsFCibHuJXW0u4nnCQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AIlaJoBR7C2Mff0iPgbkULhxXIHXEzOrEfsGDcfIc81RXco/qLJM4K/tt5DySdJQJ6TzIRKyh0cDBWCClokMPyIed//ZVA/9uZOstiZ5brx/nsMJx52a5fi5APGlhBzG9IbMxTiZus5MyV+pNMmG1IMVdpIYhVQEwZ32BVE+Whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bcu1HUbV; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 2CCDEE45BA;
	Sat,  9 Nov 2024 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731152207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Dx0/KnrxwnvRNW36+xQiAUbPoQ6tYjBRsSRnWhRWk4=;
	b=bcu1HUbVDy9meZVKzU8eCUsjf5urftgsK6KzM/sY+hono5BBF5hWBf8MQVkavPzRbkT7Kh
	TFt4toHg5hETpJEpNcQvFqbdc5Mytha4r+MrNHd4auFZJvgQardAOd7w0XlNSbTdizCNdj
	2SwJ7Q8HgG6VXmMx4ogdMFIb7ljlfJJFaRA5YWj+vLfH3jRtiUwUa86Ly6V43DWJ+Q22X7
	1qu7CqZZSNJqdxgOzSkHl7mnT9JRbDaBDrwEmmBi4dv5ECe1QAfN9QiL1OUR7v8jT66HJu
	wdeFHedKnefqtIIP4/+9MY8iQ7fFrsTTwiSfcUbZWBtl8eYYxFVm2vdbsubJrg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 Nov 2024 12:36:47 +0100
From: barnabas.czeman@mainlining.org
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, =?UTF-8?Q?Otto_Pfl=C3=BCger?=
 <otto.pflueger@abscue.de>
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
In-Reply-To: <0293b1c5-d405-4021-b9c1-205271107350@oss.qualcomm.com>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-12-6ddc5acd978b@mainlining.org>
 <0293b1c5-d405-4021-b9c1-205271107350@oss.qualcomm.com>
Message-ID: <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-08 18:03, Konrad Dybcio wrote:
> On 7.11.2024 6:02 PM, Barnabás Czémán wrote:
>> From: Otto Pflüger <otto.pflueger@abscue.de>
>> 
>> Add initial support for MSM8917 SoC.
>> 
>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> [reword commit, rebase, fix schema errors]
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
> 
> [...]
> 
>> +		domain-idle-states {
>> +			cluster_pwrdn: cluster-gdhs {
> 
> Please rename these to cluster-sleep-<n> and sort from shallowest to
> deepest sleep state, in this case: ret, pwrdn, pc
> 
> [...]
> 
>> +
>> +		l2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +		};
> 
> Please put this under the cpu0 node
> 
> [...]
> 
>> +		restart@4ab000 {
>> +			compatible = "qcom,pshold";
>> +			reg = <0x4ab000 0x4>;
> 
> Please also pad all address parts to 8 hex digits with leading zeroes
> 
> [...]
> 
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-598000000 {
>> +					opp-hz = /bits/ 64 <598000000>;
>> +				};
>> +
>> +				opp-523200000 {
>> +					opp-hz = /bits/ 64 <523200000>;
>> +				};
>> +
>> +				opp-484800000 {
>> +					opp-hz = /bits/ 64 <484800000>;
>> +				};
>> +
>> +				opp-400000000 {
>> +					opp-hz = /bits/ 64 <400000000>;
>> +				};
>> +
>> +				opp-270000000 {
>> +					opp-hz = /bits/ 64 <270000000>;
>> +				};
>> +
>> +				opp-19200000 {
>> +					opp-hz = /bits/ 64 <19200000>;
>> +				};
> 
> Does the GPU actually function at 19.2 MHz? You can check this by 
> removing
> all other entries and starting some gpu workload
Yes
> 
> [...]
> 
>> +		cpuss1-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
> 
> You can remove polling-delay (not -passive), as we have an interrupt
> that fires on threshold crossing
> 
>> +
>> +			thermal-sensors = <&tsens 4>;
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpuss1_alert0>;
>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>> +			trips {
>> +				cpuss1_crit: cpuss1-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +
>> +				cpuss1_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpuss1_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
> 
> Sorting these by temperature, rising would be nice
> 
> Konrad

