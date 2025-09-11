Return-Path: <linux-pm+bounces-34473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091EB533E1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31F2566A56
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0B32A3F2;
	Thu, 11 Sep 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N61BZh3+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06558220F5D;
	Thu, 11 Sep 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597854; cv=none; b=Q4oMx/AmgaHy2tmA4QHAPWQDaowjFHkkP0OKt9UWWHSsA70qM/Wk06fazPaIOhdyh9mhdVpZsqSh6OsZ4l/SEqn4W8QDszzLcsWyY17LTCMSCIDRTfUi5FRyRndIZJD/PZtow7BndM3UZ9kjiWNViafuUbA9UbRQoTHBCkbx/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597854; c=relaxed/simple;
	bh=PR4NVowQFnPBkRHy0PGduBvFocIFZteB1CeNJi0dXM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4aAej4/S0JGD0kYiB2KWoVchmzHpD/ELhSpyNJJ2SKoNzUxH8qO5Xuml0vCZiF+Bomu25sRDZRC0Z2L7li2zbyMYTXUhBZKbi378MjQGwG9/VI1RVsAPBNIkEsJtR+ZsN8NvQP5EIj5GmlKCtQshmZkA9drCiNjIWlAQ3R2g1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N61BZh3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21784C4CEF0;
	Thu, 11 Sep 2025 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597853;
	bh=PR4NVowQFnPBkRHy0PGduBvFocIFZteB1CeNJi0dXM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N61BZh3+209Y4puH/ywilSNnwXa6Z2AsekOz4u5iPEsCD8wBac9idmlbLTWvmNAHL
	 vWbUFzagL/DFujKX+Kz8taQmV8swRGOtLJ1/NPsRL02cmIvPi3YIXeh7IdNLgy/ppN
	 u15dsRPBnOo555hPv3E+wlGtapA8VRx0TKoo0AoBzQF1Xp2yL6g+aNKIvQJkTjwr+U
	 aBAzfoMZbTSTYo1F7KLpviVhkJreaeps1j3WOO7UhE5L/HpXPCSNlxOfPygZKuk7OY
	 SqeVrF3w3giT/HYCxcy6mzBNE1fMwhH6VzfXrTvvXBOGE1uUdWoMTkzvp4EIxeRb13
	 7yktiVmCpm3Ow==
Date: Thu, 11 Sep 2025 15:37:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states
 with too much latency
Message-ID: <aMLQmjKCJ5-hl3iA@localhost.localdomain>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <5043159.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5043159.31r3eYUQgx@rafael.j.wysocki>

Le Wed, Aug 13, 2025 at 12:25:58PM +0200, Rafael J. Wysocki a écrit :
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Occasionally, the exit latency of the idle state selected by the menu
> governor may exceed the PM QoS CPU wakeup latency limit.  Namely, if the
> scheduler tick has been stopped already and predicted_ns is greater than
> the tick period length, the governor may return an idle state whose exit
> latency exceeds latency_req because that decision is made before
> checking the current idle state's exit latency.
> 
> For instance, say that there are 3 idle states, 0, 1, and 2.  For idle
> states 0 and 1, the exit latency is equal to the target residency and
> the values are 0 and 5 us, respectively.  State 2 is deeper and has the
> exit latency and target residency of 200 us and 2 ms (which is greater
> than the tick period length), respectively.
> 
> Say that predicted_ns is equal to TICK_NSEC and the PM QoS latency
> limit is 20 us.  After the first two iterations of the main loop in
> menu_select(), idx becomes 1 and in the third iteration of it the target
> residency of the current state (state 2) is greater than predicted_ns.
> State 2 is not a polling one and predicted_ns is not less than TICK_NSEC,
> so the check on whether or not the tick has been stopped is done.  Say
> that the tick has been stopped already and there are no imminent timers
> (that is, delta_tick is greater than the target residency of state 2).
> In that case, idx becomes 2 and it is returned immediately, but the exit
> latency of state 2 exceeds the latency limit.
> 
> Address this issue by modifying the code to compare the exit latency of
> the current idle state (idle state i) with the latency limit before
> comparing its target residecy with predicted_ns, which allows one
> more exit_latency_ns check that becomes redundant to be dropped.
> 
> However, after the above change, latency_req cannot take the predicted_ns
> value any more, which takes place after commit 38f83090f515 ("cpuidle:
> menu: Remove iowait influence"), because it may cause a polling state
> to be returned prematurely.
> 
> In the context of the previous example say that predicted_ns is 3000 and
> the PM QoS latency limit is still 20 us.  Additionally, say that idle
> state 0 is a polling one.  Moving the exit_latency_ns check before the
> target_residency_ns one causes the loop to terminate in the second
> iteration, before the target_residency_ns check, so idle state 0 will be
> returned even though previously state 1 would be returned if there were
> no imminent timers.
> 
> For this reason, remove the assignment of the predicted_ns value to
> latency_req from the code.
> 
> Fixes: 5ef499cd571c ("cpuidle: menu: Handle stopped tick more aggressively")
> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Too late I guess but meanwhile:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

