Return-Path: <linux-pm+bounces-31469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA7B1388F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77278188FC4F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9224678A;
	Mon, 28 Jul 2025 10:04:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84A256C7C;
	Mon, 28 Jul 2025 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697092; cv=none; b=snfn4vg5Ncn0a82p/m7X7hszntPIC1921a9wFV1CIaKuUg1/pMBgoh9aavbyQbwFtiFWgcrzWpDEeJggc/z0SVOvvNuuMy5p0mpqLYHGBswOFs4tLblEshUx5w/lyMpbiru+XQ57tvZ6WCHT6pSrrtKnTXvrkdZuuunuK/ee/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697092; c=relaxed/simple;
	bh=mZFkLsSRXzfeOfa1CSIoSetZrzFEWXnOUpdRR/PLapg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4cMNwAcG+qrG3vhAlbHNxRhJj0w73C6hHxFtvEoJLkjWRSafM4aVXie+tAUxWWb4n9ao0jSPYGEdMlEkZdp43if+2tzZyn6rmJNV+wLjmuaf4wwWknp/CKm/VywdxlEFmlWFlURZ8xFWH9pl5PyiO5v8JFgjZ5B6yOmEY0+U+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBAF51515;
	Mon, 28 Jul 2025 03:04:41 -0700 (PDT)
Received: from [10.57.71.150] (unknown [10.57.71.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 730B43F673;
	Mon, 28 Jul 2025 03:04:48 -0700 (PDT)
Message-ID: <842e4029-e941-4024-9a1e-59bf8c8f1b18@arm.com>
Date: Mon, 28 Jul 2025 11:04:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: menu: find the typical interval by a heuristic
 classification method
To: =?UTF-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>,
 "rafael@kernel.org" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "quic_zhonhan@quicinc.com" <quic_zhonhan@quicinc.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fa1c6faa96344fa9803675b179d7a329@xiaomi.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <fa1c6faa96344fa9803675b179d7a329@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/25 11:11, 朱恺乾 wrote:
> The iterations of deviation calculation gives too less predictions on
> the idle interval by trying to find a single repeating pattern from the
> whole history. This is not always the case when the workload is flowing.
> 
> This algorithm assumes there're multiple repeating patterns heuristically,
> and tries to determine which is the most promising one from the averages
> of different idle states. It also takes the occurrence sequence into
> consideration, and gives the prediction close to the recent idle.
> 
> This increased the shallow idle states detected, but the difference in deep
> sleep time didn't change a lot. The performance on my platform, as
> expected, has improved.
> 
> Before:
> Multi-Core Score              7279
> Overall    above   under
>   34107    0.00    2.75
>    8200   59.90    7.02
>   29881   57.06    0.00
> 
> After:
> Multi-Core Score              7365
> Overall    above   under
>   49913    0.00    6.43
>    7881   44.51   18.08
>   23108   52.38    0.00
> 
> There's another re-classification method, which, instead of looking for the
> repeating-interval, tends to find the repeating state. It gives a better result
> on performance gain, but may hurt the power consumption.
> 
> if (best_state == drv->state_count - 1 || state_avg[best_state] == 0) {
> adj_weight[best_state] += weights[i];
> adj_avg[best_state] += value;
> adj_hit[best_state]++;
> } else if (best_diff < state_avg[best_state] * 2) {
> adj_weight[best_state] += weights[i];
> adj_avg[best_state] += value;
> adj_hit[best_state]++;
> } else {
> adj_weight[best_state + 1] += weights[i];
> adj_avg[best_state + 1] += value;
> adj_hit[best_state + 1]++;
> }
> 
> Repeating State:
> Multi-Core Score              7421
> Overall    above   under
>   60857    0.00    8.30
>    3838   29.88   18.42
>   15318   39.05    0.00
> 
> 

Would be nice to have statistical significance on those (I'm assuming Geekbench)
scores and a description of the systems idle state and maybe a comparison to
shallowest (only WFI enabled) and deepest (only max idle state enabled).


