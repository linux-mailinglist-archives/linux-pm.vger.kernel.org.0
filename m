Return-Path: <linux-pm+bounces-34257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A4B4FD64
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E0188B37F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA535335B;
	Tue,  9 Sep 2025 13:32:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AF3451A2;
	Tue,  9 Sep 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424767; cv=none; b=jtd0TaOdX91ssgbLDjyz08wf9ZA7amp6suw8L5ulrja9jTmVzW1QuBViLCsTWX4r2QWtvM+CVnpmSvpXD5qVaaJuEyvaAu5F4DjG6Bjpy28EudYGk/IEZxwEdlBY1aZ9OmpIQT8AtSOKjRUoQaDmgksnZSmXpKTsfWW4FxMAmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424767; c=relaxed/simple;
	bh=PrTTqjOGoh/Uj/1ZKYgZJOsulEODr/59EIbNk0P/j6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utNlNMbA/exTnPIbeDCUAiUR5/giex+LFBKBKghtzhGlpN0xKbjRQgXfBmomEB4DylXGIml1Q1m6AAr7AwZwg/Qv2XGSdcCpgMX+Y6tLxsyEriFLdKadthLJWEZTDOURo20sJsv7SuV2ud+M760tfgnZzlb7wLVwbeo4X2ISf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F2C21424;
	Tue,  9 Sep 2025 06:32:29 -0700 (PDT)
Received: from [10.1.27.127] (unknown [10.1.27.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32A23F694;
	Tue,  9 Sep 2025 06:32:35 -0700 (PDT)
Message-ID: <0b59d09e-a508-4bca-a110-ab2b12c2284a@arm.com>
Date: Tue, 9 Sep 2025 14:32:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpuidle: menu: Add residency threshold for
 non-polling state selection
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: gautam@linux.ibm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250908075443.208570-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250908075443.208570-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 08:54, Aboorva Devarajan wrote:
> On virtualized PowerPC (pseries) systems, where only one polling state
> (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> the predicted idle duration exceeds the target residency of the CEDE
> state can hurt performance. In such cases, the entry/exit overhead of
> CEDE outweighs the power savings, leading to unnecessary state transitions
> and higher latency.
> 
> Menu governor currently contains a special-case rule that prioritizes
> the first non-polling state over polling, even when its target residency
> is much longer than the predicted idle duration. On PowerPC/pseries,
> where the gap between the polling state (Snooze) and the first non-polling
> state (CEDE) is large, this behavior causes performance regressions.
> 
> This patch refines the special case by adding an extra requirement:
> the first non-polling state may only be chosen if its
> target_residency_ns is below the defined RESIDENCY_THRESHOLD_NS. If this
> condition is not met, the non-polling state is not selected, and polling
> state is retained instead.
> 
> This change is limited to the single special-case condition for the first
> non-polling state. The general state selection logic in the menu governor
> remains unchanged.
> 
> Performance improvement observed with pgbench on PowerPC (pseries)
> system:
> +---------------------------+------------+------------+------------+
> | Metric                    | Baseline   | Patched    | Change (%) |
> +---------------------------+------------+------------+------------+
> | Transactions/sec (TPS)    | 495,210    | 536,982    | +8.45%     |
> | Avg latency (ms)          | 0.163      | 0.150      | -7.98%     |
> +---------------------------+------------+------------+------------+
> CPUIdle state usage:
> +--------------+--------------+-------------+
> | Metric       | Baseline     | Patched     |
> +--------------+--------------+-------------+
> | Total usage  | 12,735,820   | 13,918,442  |
> | Above usage  | 11,401,520   | 1,598,210   |
> | Below usage  | 20,145       | 702,395     |
> +--------------+--------------+-------------+
> 
> Above/Total and Below/Total usage percentages which indicates
> mispredictions:
> +------------------------+-----------+---------+
> | Metric                 | Baseline  | Patched |
> +------------------------+-----------+---------+
> | Above % (Above/Total)  | 89.56%    | 11.49%  |
> | Below % (Below/Total)  | 0.16%     | 5.05%   |
> | Total cpuidle miss (%) | 89.72%    | 16.54%  |
> +------------------------+-----------+---------+
> 
> The results show that restricting non-polling state selection to
> cases where its residency is within the threshold reduces mispredictions,
> lowers unnecessary state transitions, and improves overall throughput.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> 
> v2: https://lore.kernel.org/all/20250317060357.29451-1-aboorvad@linux.ibm.com/
> 
> Changes in v2 -> v3:
>   - Modifed the patch following Rafael's feedback, incorporated a residency threshold check
>     (s->target_residency_ns < RESIDENCY_THRESHOLD_NS) as suggested.
>   - Updated commit message accordingly.
> ---
>  drivers/cpuidle/governors/menu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index b2e3d0b0a116..d25b04539109 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -316,11 +316,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  
>  		if (s->target_residency_ns > predicted_ns) {
>  			/*
> -			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger soon enough.
> +			 * Use a physical idle state instead of busy polling
> +			 * if the next timer doesn't expire soon and its
> +			 * target residency is below the residency threshold.
>  			 */
>  			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->target_residency_ns <= data->next_timer_ns) {
> +			    s->target_residency_ns <= data->next_timer_ns &&
> +			    s->target_residency_ns < RESIDENCY_THRESHOLD_NS) {
>  				predicted_ns = s->target_residency_ns;
>  				idx = i;
>  				break;

To me that seems the least intrusive way the issue for your platform.
Rafael, can you live with this?
FWIW
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

