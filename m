Return-Path: <linux-pm+bounces-1676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0A8200FB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Dec 2023 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3627FB21004
	for <lists+linux-pm@lfdr.de>; Fri, 29 Dec 2023 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865D12B7C;
	Fri, 29 Dec 2023 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kILiAllz"
X-Original-To: linux-pm@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAD12B82
	for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2023 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev-mail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev-mail.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id CC48D3200AB7
	for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2023 12:55:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1703872527; x=1703958927; bh=xqsCQW6ihHh/f
	KJsGte3MxAzTm0BfI/Xj8busQRS0LE=; b=kILiAllzaVtEwAo5yGV6kEUuzvgQ8
	ykGIgB0wNLOQUW/1C2ssM70fLMK4nCg/q2CtBozZ5gcYermkbktMYzrvwKI+wONB
	0aTlJ0S39actMTEbdYzeRg1Sm6zn15qQN/eEV6eZxPqZ1NotVYSoEOXlbHUOtbVL
	2Prba+E7Ru/NSXzVfbJttdxmU8T1397FCGw6STnRz79PAyAp48YRwLDFKJorhM6n
	Tcros20kMl+QuoINaCgd5hP+p8kWfSvVNb6U1DeQQ0lhmXmcwgpGdXfbl7aESZuX
	d37nE0+4pW5LzMSGXf3EHhgtS+y3hHhgaiUhQ8FaDenXYzbtAd4X4o5rA==
X-ME-Sender: <xms:DwiPZWUYQeC0DsSqdj2LQ4QtgwaXK8jN3TgVhhUkM8BaoAtOPZQ66w>
    <xme:DwiPZSk9tFJ5KJidMKDJXAPN4tPbcFLuLL0RqKaOQJx-ci68fKlqYzkaNiTHOB7PY
    V5_bC7DyEgpJpc0>
X-ME-Received: <xmr:DwiPZaY43Qzc8WNH9FAGaOtdyEF-l6uX8-SV_BQcnwVyWMlRlbWAfDpbIHhUNXHHGR-QMKccC4x0bnWr8AmnDZX9YsTTPUUHm4OaHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeffedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfrhfhvffutgfgsehtje
    ertddtvdejnecuhfhrohhmpehpghhnugcuoehpghhnugesuggvvhdqmhgrihhlrdhnvght
    qeenucggtffrrghtthgvrhhnpeefveegjedttdetheetffdugeehieeukedugfetvdegud
    dufffguddvudekffffleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhgnhguseguvghvqd
    hmrghilhdrnhgvth
X-ME-Proxy: <xmx:DwiPZdWuAa1TBymuSaew_TRCo2Vhlm18CCX6T-16QKaiSdVHVBQgsA>
    <xmx:DwiPZQmTaku8ic2hQGBIIm4a44slvoEJg0laNR7KE0g9QtAFiUeegA>
    <xmx:DwiPZSdNrbcDFpLUuDkFYzh-4f5rSUaR4Y-Hh47UHWVOfzIhb0mBzA>
    <xmx:DwiPZVyYJ37vrpSoV57uAe--nEs2Xt3iQRSbJu2FLRaIu4cxx95kzA>
Feedback-ID: if6e94526:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-pm@vger.kernel.org>; Fri, 29 Dec 2023 12:55:26 -0500 (EST)
Message-ID: <3829f405-17cf-4036-8a17-6d659031ca2f@dev-mail.net>
Date: Fri, 29 Dec 2023 12:55:26 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: pgnd@dev-mail.net
From: pgnd <pgnd@dev-mail.net>
Content-Language: en-US, fr, de-DE, pl, es-ES
To: linux-pm@vger.kernel.org
Subject: tuning pstate driver for amd ryzen w/ kernel 6.8+: 'amd-pstate' vs
 'amd-pstate-epp'?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

i'm upgrading a number of amd Zen 2/3 Ryzen servers & workstations, for general/mixed edge & developer server use.

kernels are all currently,

	uname -rm
	  6.6.8-200.fc39.x86_64 x86_64

checking 'scaling_driver' and 'scaling_governor' on multiple boxes, they're all over the map.

my inclination is to standardize for an adaptive load, with

	cpupower frequency-set -g  schedutil

and

	"... intel_pstate=disable amd_pstate=guided" on kernel cmdline ..."

here's the result for one,

	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
		amd-pstate

	cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
		schedutil

	cpupower frequency-info
		analyzing CPU 0:
		  driver: amd-pstate
		  CPUs which run at the same hardware frequency: 0
		  CPUs which need to have their frequency coordinated by software: 0
		  maximum transition latency: 20.0 us
		  hardware limits: 400 MHz - 4.46 GHz
		  available cpufreq governors: conservative ondemand userspace powersave performance schedutil
		  current policy: frequency should be within 400 MHz and 4.46 GHz.
		                  The governor "schedutil" may decide which speed to use
		                  within this range.
		  current CPU frequency: Unable to call hardware
		  current CPU frequency: 4.01 GHz (asserted by call to kernel)
		  boost state support:
		    Supported: yes
		    Active: yes
		    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.46 GHz.
		    AMD PSTATE Nominal Performance: 145. Nominal Frequency: 3.90 GHz.
		    AMD PSTATE Lowest Non-linear Performance: 88. Lowest Non-linear Frequency: 2.37 GHz.
		    AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.


for some, before the mods, i see 'amd-pstate-epp' in use; e.g.,

     cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
		amd-pstate-epp

	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
		amd-pstate-epp

	cpupower frequency-info
		analyzing CPU 11:
		  driver: amd-pstate-epp
		  CPUs which run at the same hardware frequency: 11
		  CPUs which need to have their frequency coordinated by software: 11
		  maximum transition latency:  Cannot determine or is not supported.
		  hardware limits: 400 MHz - 4.46 GHz
		  available cpufreq governors: performance powersave
		  current policy: frequency should be within 400 MHz and 4.46 GHz.
		                  The governor "powersave" may decide which speed to use
		                  within this range.
		  current CPU frequency: Unable to call hardware
		  current CPU frequency: 2.96 GHz (asserted by call to kernel)
		  boost state support:
		    Supported: yes
		    Active: yes
		    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.46 GHz.
		    AMD PSTATE Nominal Performance: 145. Nominal Frequency: 3.90 GHz.
		    AMD PSTATE Lowest Non-linear Performance: 88. Lowest Non-linear Frequency: 2.37 GHz.
		    AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.

NOTE
	the similar frequency scales/limits,
and

		  driver: amd-pstate
		  CPUs which run at the same hardware frequency: 0

vs

		  driver: amd-pstate-epp
		  CPUs which run at the same hardware frequency: 11

reading up at,

   amd-pstate CPU Performance Scaling Driver
    https://docs.kernel.org/admin-guide/pm/amd-pstate.html

i can see _what_ some of the differences are.

but don't get from the read what's the "best" driver tuning for these bigger-boxes with variable demand.

for those 2 boxes, e.g., @ driver: amd-pstate

	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
		amd-pstate

shows mixed freqs across CPUs,

	total=$( lscpu | grep "^CPU(s):" | awk '{print $2}')
	for ((i = 0; i < total; ++i))
	do
	 echo "${i}  $( cpupower frequency-info cpu${i} | grep "current CPU.*Hz" )"
	done

		0    current CPU frequency: 3.56 GHz (asserted by call to kernel)
		1    current CPU frequency: 4.45 GHz (asserted by call to kernel)
		2    current CPU frequency: 3.56 GHz (asserted by call to kernel)
		3    current CPU frequency: 4.45 GHz (asserted by call to kernel)
		4    current CPU frequency: 3.61 GHz (asserted by call to kernel)
		5    current CPU frequency: 3.56 GHz (asserted by call to kernel)
		6    current CPU frequency: 3.66 GHz (asserted by call to kernel)
		7    current CPU frequency: 4.45 GHz (asserted by call to kernel)
		8    current CPU frequency: 4.45 GHz (asserted by call to kernel)
		9    current CPU frequency: 3.56 GHz (asserted by call to kernel)
		10    current CPU frequency: 3.93 GHz (asserted by call to kernel)
		11    current CPU frequency: 4.45 GHz (asserted by call to kernel)

same as for @ driver: amd-pstate-epp

	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
		amd-pstate-epp

shows same freqs across CPUs,

	total=$( lscpu | grep "^CPU(s):" | awk '{print $2}')
	for ((i = 0; i < total; ++i))
	do
	 echo "${i}  $( cpupower frequency-info cpu${i} | grep "current CPU.*Hz" )"
	done

		0    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		1    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		2    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		3    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		4    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		5    current CPU frequency: 3.56 GHz (asserted by call to kernel)
		6    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		7    current CPU frequency: 4.44 GHz (asserted by call to kernel)
		8    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		9    current CPU frequency: 3.55 GHz (asserted by call to kernel)
		10    current CPU frequency: 4.44 GHz (asserted by call to kernel)
		11    current CPU frequency: 4.44 GHz (asserted by call to kernel)

looking at these outputs, I don't see the difference/preference.

short of long-term power/preformance benchmarking, what up-front rationale should be used for selecting

		  driver: amd-pstate

vs

		  driver: amd-pstate-epp

?


