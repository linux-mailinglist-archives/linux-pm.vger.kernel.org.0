Return-Path: <linux-pm+bounces-32785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBFB2F2DC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498F9188D34A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80D2EB850;
	Thu, 21 Aug 2025 08:49:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDE12EBDF2;
	Thu, 21 Aug 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766180; cv=none; b=OYe6mOShC4Y+LW6FlkRwleRvWjE7Q5/bGtNOZJ+x0yytDp7TwIhXcABX1J7lV3S+TW49lJOixNLM6iRM85p5WF4VXBO1E6ogaId0ScmyeogjzbcjxyC8pBtbA0N+bCsoo+Bfb+Z1z0sb2/PvrzbxChGzp3PoFvXRrKnOnvTyQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766180; c=relaxed/simple;
	bh=/uHmHhKxYlq+fxaWsGuUmxJWh36N61W88YagYGHZ0C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9WLvWsodoGoC3i2KHpz611OuxKyy6T+y75kVPCMDNMO4wvuzoHhtWmPGU1V6GoaLRrWh71Q5fay9H7G+pVWjhBK5ejsUNLuIfPOzha4obAIFUEViJz4sOw+xST9EUL/dPf+PavDTaIEtrORUpUgi20PbVcXOmF/didJlALYkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD04168F;
	Thu, 21 Aug 2025 01:49:27 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA33F3F63F;
	Thu, 21 Aug 2025 01:49:34 -0700 (PDT)
Message-ID: <9fd90f29-72c4-42b7-bd28-08e2cbc9a472@arm.com>
Date: Thu, 21 Aug 2025 09:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: menu: find the typical interval by a
 heuristic classification method
To: =?UTF-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>,
 "rafael@kernel.org" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "quic_zhonhan@quicinc.com" <quic_zhonhan@quicinc.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ec528693bdf84a61829427c4988bfa85@xiaomi.com>
 <f2bab6677d4b4fe585f7e01b1e490717@xiaomi.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <f2bab6677d4b4fe585f7e01b1e490717@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/25 02:54, 朱恺乾 wrote:
> Menu governor relies on get_typical_interval() to find the repeating
> idle interval from the history, but it can not handle the case when
> there're two or more repeating patterns. The calculation of deviation
> always leads to a single closely connected intervals.
> 
> In order to find all the possible repeating intervals and choose the
> most promising one for the next idle. This algorithm is classifying
> the idle histories heuristically by the state it is in. It changes
> the behavior of the function to look for the repeating state actually,
> but it still meets the goal of choosing an idle state.
> 
> The occurrence of each state is counted and their average is calculated.
> The average value of each state would be taken as a repeating pattern.
> To find the one most likely to happen, weights are added to the
> histories by the order of time, so the state has the highest weight, or
> occurs most often in the recent history, is selected, and it's average
> is returned as the typical interval.
> 
> Considering the fact that some idle intervals may be very close to another
> state, the algorithm calculates the distance to each average, and do the
> re-classification once by putting the history into the state closer to it.
> It makes the state average possible to derive an average under or above the
> state residency.
> 
> Comparing with the deviation calculation, this method
> 1) can find multiple patterns from the history and choose from them
> 2) can be more sensitive to the changing workload as the threshold is
> lowered
> 3) puts time into consideration, so prediction won't stuck in the stale
> histories
> 
> Signed-off-by: Kaiqian Zhu <zhukaiqian@xiaomi.com>
> ---
>  drivers/cpuidle/governors/menu.c | 172 ++++++++++++++++---------------
>  1 file changed, 89 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 81306612a5c6..5b279ae07b16 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -107,109 +107,115 @@ static void menu_update_intervals(struct menu_device *data, unsigned int interva
> 
>  static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
> 
> +static int get_actual_state(struct cpuidle_driver *drv,
> +    struct cpuidle_device *dev,
> +    int duration_us)
> +{
> +int actual;
> +
> +for (int i = 0; i < drv->state_count; i++) {
> +if (duration_us < drv->states[i].target_residency)
> +break;
> +
> +actual = i;
> +}
> +
> +return actual;
> +}
> +

FYI Something went wrong witch the patch here...

