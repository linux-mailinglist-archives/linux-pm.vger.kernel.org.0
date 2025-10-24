Return-Path: <linux-pm+bounces-36771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E7C057BA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2E7F50517E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D450530E0F2;
	Fri, 24 Oct 2025 10:05:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29F30E0EE;
	Fri, 24 Oct 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300306; cv=none; b=nOyRqfdA9aE3jGZtTPP27auJWZWu442q4XAX+RUUTTjS/MZYNGIycFXFTyQcEeiKLA7pjej3HESWN5GAYcEJdWEd18Tn28RYsLtkgKNeUrPvsCktmbo3+AYrnxMOsNEhSqh8TapaDZ6PnAVzbBbH0iabKd5HU7bFAZrHpL96krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300306; c=relaxed/simple;
	bh=dI5AB8HEjxOyTVZ3a96bJHToy7Fyf7u2+CVkLhO8nec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4zgAYspRNytM2zaMFPXyIAANZToxG2SrXcYVy4blJDeLWdtulq5LsPf7N4ewAls4L61yywVSWJy5xuGuGNiAokUK/4s+qCzvOLlkaHOCCN5eYzNSOUlct05g84xDQrpgJPc+vuNLr9ForlhETfBBq2PANheM7nFSsMA18rtm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21694175A;
	Fri, 24 Oct 2025 03:04:56 -0700 (PDT)
Received: from [10.1.38.31] (e127648.arm.com [10.1.38.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1023F66E;
	Fri, 24 Oct 2025 03:05:02 -0700 (PDT)
Message-ID: <0fac1725-b1f6-48ea-8aff-182521729502@arm.com>
Date: Fri, 24 Oct 2025 11:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: menu: Select polling state in some
 more cases
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <12786727.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12786727.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 18:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
> governors: menu: Avoid selecting states with too much latency") has been
> reported and it is related to the case when the menu governor checks if
> selecting a proper idle state instead of a polling one makes sense.
> 
> In particular, it is questionable to do so if the exit latency of the
> idle state in question exceeds the predicted idle duration, so add a
> check for that, which is sufficient to make the reported regression go
> away, and update the related code comment accordingly.
> 
> Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
> Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -321,10 +321,13 @@ static int menu_select(struct cpuidle_dr
>  
>  		/*
>  		 * Use a physical idle state, not busy polling, unless a timer
> -		 * is going to trigger soon enough.
> +		 * is going to trigger soon enough or the exit latency of the
> +		 * idle state in question is greater than the predicted idle
> +		 * duration.
>  		 */
>  		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -		    s->target_residency_ns <= data->next_timer_ns) {
> +		    s->target_residency_ns <= data->next_timer_ns &&
> +		    s->exit_latency_ns <= predicted_ns) {
>  			predicted_ns = s->target_residency_ns;
>  			idx = i;
>  			break;
> 
> 
> 

Makes sense to me, sorry I don't have a good testing platform with a
polling state.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

