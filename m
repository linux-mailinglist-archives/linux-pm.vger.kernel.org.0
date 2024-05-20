Return-Path: <linux-pm+bounces-7996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BC8C9EC2
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B80C1F21B41
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB61136660;
	Mon, 20 May 2024 14:30:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF441DDEA;
	Mon, 20 May 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215409; cv=none; b=YHnCUA/c4EGnzV0GDJO+3lkln/asq104uB/c22CNu3bPKEqcNiW/JAvxRAFFqtnZuERRrl7WbxddXQQonhpdHfiWpipM55SP8mEm3c8sd4Fjpng35gN26O/H1R2rdLcuQNAeGDz4WN7MHtl1MwHLIQ8e6vkb/gP4kKj+sUOkJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215409; c=relaxed/simple;
	bh=6Tzja16OAKvQ6ptoX13n9YaEl8tO5OPYKtyHTUwrYnU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bXydMZpaEDhKXeSXlqv7YWqCfcpm+wyr7CLaKhTrdBrEyULdGRXBfD0O19FgAMaKiWEEIl2GKWTFwpMwMZ/EcBjzuozjgUG5ORBg0R1XvPdLBl1ekXWn1KNHMeCZ0jj9cBu3bNKTBff+TtS5K356hRYEXeqgqQpSJwLZTyH7ZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF74DA7;
	Mon, 20 May 2024 07:30:30 -0700 (PDT)
Received: from [10.57.2.229] (unknown [10.57.2.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D1783F7D8;
	Mon, 20 May 2024 07:30:04 -0700 (PDT)
Message-ID: <4716b8aa-dfc8-4784-9f5d-6de27c612f47@arm.com>
Date: Mon, 20 May 2024 15:30:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: teo: fix underflow of recent intercepts
From: Christian Loehle <christian.loehle@arm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, kajetan.puchalski@arm.com,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com>
Content-Language: en-US
In-Reply-To: <0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/24 22:03, Christian Loehle wrote:
> The recent counter of each cpuidle state bin reflects the number of
> recent intercepts. It's decremented and incremented accordingly.
> The decrement was never checked for 0, therefore underflowing into a
> value teo cannot easily recover from.
> 
> The underflow lead to deeper idle states being skipped because teo
> assumed interception was likely and it preferring shallower states.
> 
> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 7244f71c59c5..42fb2771e35d 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -290,7 +290,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	if (cpu_data->next_recent_idx >= NR_RECENT)
>  		cpu_data->next_recent_idx = 0;
>  
> -	if (cpu_data->recent_idx[i] >= 0)
> +	if (cpu_data->recent_idx[i] >= 0 &&
> +			cpu_data->state_bins[cpu_data->recent_idx[i]].recent)
>  		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
>  
>  	/*

Anyway, since I'm not sure when I will get around to finishing up a
fully-detailed report.
Rafael, unless I'm missing something, recent is only ever cycled through
the bins and never actually reset to 0, is that missing somewhere?

Maybe like this if my suspicion is correct?
Haven't tested it yet.

[PATCH] cpuidle: teo: Reset recent when cycling bins

recent intercepts value was never actually reset, only
decremented. This patch resets the value when cycling
to a new recent intercept bin.

Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c59c5..a39bef603408 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -291,7 +291,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		cpu_data->next_recent_idx = 0;
 
 	if (cpu_data->recent_idx[i] >= 0)
-		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
+		cpu_data->state_bins[cpu_data->recent_idx[i]].recent = 0;
 
 	/*
 	 * If the deepest state's target residency is below the tick length,
-- 
2.34.1


