Return-Path: <linux-pm+bounces-41224-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCi+N27AcGmKZgAAu9opvQ
	(envelope-from <linux-pm+bounces-41224-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:02:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECEC566F5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D731E9A17BF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803B3BC4F9;
	Wed, 21 Jan 2026 11:49:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC140B6E9;
	Wed, 21 Jan 2026 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996166; cv=none; b=MABMR62+JxmZEVeAYH8T6POOc7lN6pyuNeOHGeU+lKUlyGB7bTDXFfO8UTF2LimjzbJ2jdBsDY1DBsh2jS4tdGaj2EGN2S2yebP+jhdzahsXIufx3Pc7FTnu0lafv2OQfAC1JEKUy/ntYiiWIPvAUQbn9fE3hYSrshmtgvwlNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996166; c=relaxed/simple;
	bh=Lc27ztmcEnikRaDCWQTWkRZuxQ5csSBAt0c3+KnOTuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxJu1lZXcXJzMW4OW6GcfPObQtL2AW4n9PioQblSCu9mjI7X4qozI0CfnUXnlC5ThtwftFba26j1EbAULMsf8R17Rq+Pdj9CBteBEFd/JHVbcLcy9ZH37cR1AYwcN0yKPkYHJM/SPQIghUfcX7VfQYmvvOiRzQGoTGLQvYNaPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77B91476;
	Wed, 21 Jan 2026 03:49:16 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07C443F632;
	Wed, 21 Jan 2026 03:49:21 -0800 (PST)
Message-ID: <eac3541b-f22f-4cd9-a31e-4841e4fad5a1@arm.com>
Date: Wed, 21 Jan 2026 11:49:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] cpuidle: menu: Fix high wakeup latency on modern
 Intel server platforms
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
 rafael@kernel.org
Cc: ionut_n2001@yahoo.com, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120211725.124349-1-sunlightlinux@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260120211725.124349-1-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-41224-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4ECEC566F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 21:17, Ionut Nechita (Sunlight Linux) wrote:
> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Hi,

Hi Ionut,

> 
> This patch addresses a performance regression in the menu cpuidle governor
> affecting modern Intel server platforms (Sapphire Rapids, Granite Rapids,
> and newer).

I'll take a look at the patch later, but just to be clear, this isn't a
performance regression right? There's no kernel version that this behaved
better with, is there?
If there is it needs to be stated and maybe a Fixes tag would be applicable.

> 
> == Problem Description ==
> 
> On Intel server platforms from 2022 onwards, we observe excessive wakeup
> latencies (~150us) in network-sensitive workloads when using the menu
> governor with NOHZ_FULL enabled.
> 
> Measurement with qperf tcp_lat shows:
> - Sapphire Rapids (SPR):    151us latency
> - Ice Lake (ICL):             12us latency
> - Skylake (SKL):              21us latency
> 
> The 12x latency regression on SPR compared to Ice Lake is unacceptable for
> latency-sensitive applications (HPC, real-time, financial trading, etc.).

So just newer generation having higher latency.
TBF the examples you mentioned should really have their latencies in control
themselves and not rely on menu guesstimating what's needed here.

> 
> == Root Cause ==
> 
> The issue stems from menu.c:294-295:
> 
>     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
>         predicted_ns = data->next_timer_ns;
> 
> When the tick is already stopped and the predicted idle duration is short
> (<2ms), the governor switches to using next_timer_ns directly (often
> 10ms+). This causes the selection of very deep package C-states (PC6).
> 
> Modern server platforms have significantly longer C-state exit latencies
> due to architectural changes:
> - Tile-based architecture with per-tile power gating
> - DDR5 power management overhead
> - CXL link restoration
> - Complex mesh interconnect resynchronization
> 
> When a network packet arrives after 500us but the governor selected PC6
> based on a 10ms timer, the 150us exit latency dominates the response time.
> 
> On older platforms (Ice Lake, Skylake) with faster C-state transitions
> (12-21us), this issue was less noticeable, but SPR's tile architecture
> makes it critical.
> [snip]

Can you provide idle state tables with residencies and usage?
Ideally idle misses for both as well?
Thanks!

