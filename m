Return-Path: <linux-pm+bounces-41254-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI0eH5lXcWkNEwAAu9opvQ
	(envelope-from <linux-pm+bounces-41254-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 23:47:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B85F035
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 23:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A0796CAACE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C343DA53;
	Wed, 21 Jan 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEDfCYP6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579B421EF8
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035368; cv=none; b=c8H4PnMBQVj+aAWYV2VRKWs5Jbt+uZQqgu0+wky1pG2IaOfXDrUpldbYolnxwYwphuB2ip7JSNzmV5taVsF26gDFi2XNSK185CIz4qyXLlWvAMZKQ9tdvYWICMHzPI5QKHWLew2hzW+7be4G/IsEibZUY/AEAlS1CdZVwyiE0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035368; c=relaxed/simple;
	bh=U6fShtmhIXf5CpxJy9U31Hce1Rv3cRFIffJOmgUeStc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX/Nuge8LktXX6PgK4yhLDU7v4VoC6LSMQL7W5NpgLznb3f9I9/Iqtr62EjVTGAq2TS7YsdAw769XplNduGrTi9lKTrYwawA1HEaVvo2RPJM7hiAMCDnBeLGhgOpf2GPVa7U7sinIM6bxoQ2udhGY2AQQZygc0tvY/s9HiHYxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEDfCYP6; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649523de905so269593d50.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769035364; x=1769640164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+ln0rGFbK/VgHbdF/l62LCNQSo7NQ85BPmeaRzBnWY=;
        b=fEDfCYP6cmWcjV4vztUeZsVpzzE4REt7MDjpNDO6TVFps9wtdK3gvoyh1h2OwHuyG9
         9HPc9HpDGVEACEbY6O3x1r9Xba6E/G7QDe1GupG9GplF0csKn/lIUR18ZCyByLqjuMbc
         +U6VARoOgEEQrBYRyp64ze3nw8sHFqv6J6JZvuGDS+nGnkpsGwCvL5O5TYyfx3Jy4USe
         9LfKmnF0RI4SncbIq7EpXfuMdC08GhzXkAdgXQuyOjT/8tJs7kSXdqSJsmC9ajqIYGKG
         UUHLol6WTadF0gxUM/Gn57nXFBE6P6hcpLeWVg8OcpDe27Ucr2V8B4BT15zC1npY04MD
         gpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769035364; x=1769640164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+ln0rGFbK/VgHbdF/l62LCNQSo7NQ85BPmeaRzBnWY=;
        b=qzQCRAaa+UtlfNmOBj9ix6J5Ztf354uUgIxfLzUlDkzi2UlhbaMo99XFintT3WEl1q
         XcqGB8Hh+P6CZCUrzmP0x5RPC8C/46gfUQ1a9CwEBsSUUPVqbODH7nnt7q+ZyCsdz6Ql
         7Ywh//nMlPNlZl3/BAgsn2E4Gq11SP26pZlElXWGgGUoCp99+1A9gW8cOPAqAX90rsPg
         J9t22AsPITiXjPu1liWUKn4geylyT7ggk9dZ9eiDoi9D/kOYSIM/LL0kesz4QPIStXSA
         Z2ITHDZ0LkUjAEqdd+EDiQYqsYwAvCfcPC7l5KX7IxZzaFugngjbtQrMX/SY+7E6JqKr
         Qn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXihr6Usw2KYC476MDpY9wPPltE/mDQA/DWaZc25qh7xr+3C+fS5V49+63rj5LDdfnwp4onAcec1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8C+hbPxojJkR8+LUkppAsKl6reo5OCImT4g7uXpsJ+G5HBiA
	pepiql/5RNwSxStmXtZK24M8LvskoXNp/w5v+kV2HFqItUpzeT6qxsCi
X-Gm-Gg: AZuq6aKAmuUKB4M8hHXphHPLH7kCIvtPSbMcHf0IDQ7c0E1l/tX/sk2eUc6VakrQ+48
	F0XfIu0jxlZ/eU4xby+Ph8LB1UBisiIxGjqcZ7dpXCuIBQmv6Upc//LnjmWQjr4+JxMUPiiPL4+
	drRHXuAR+7DeA4zujA5Thj6pKifSBf15AHnH3h7gxmFg9u7a7RvQ3t7XGszcdiejEzOmvsy/xCd
	+Y2RO9fI9pzBjoHrXrXOup8HZTKtBmbzu73ubA0g41qBgPGIFrjV4g7T08ubUeDIMIgBJkxs5TU
	sb4n9ligTF0++SOGQYz0M7bkWVUBNaaeY4LFRfJB1GLwCdH1Lef+oTmpBbq66C6uDYRIHB2hvZm
	kL6QEWlZfCvGZw7oRtpSVfwjbZnhrKrs+7h31FbtAvyC6ghBGANcp2V0NHiZXEqSQ2/a+ZwBKpj
	4SlmUEm7cfdKZ4Q/nHyi1UZ/ATXbg=
X-Received: by 2002:a05:690e:42cf:b0:649:3875:920f with SMTP id 956f58d0204a3-64951339da9mr723857d50.23.1769035364127;
        Wed, 21 Jan 2026 14:42:44 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm8446107d50.13.2026.01.21.14.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 14:42:43 -0800 (PST)
Message-ID: <a716c51c-05ab-429a-9be1-915a401a2197@gmail.com>
Date: Wed, 21 Jan 2026 16:42:41 -0600
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
 christian.loehle@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120211725.124349-1-sunlightlinux@gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20260120211725.124349-1-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41254-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[yahoo.com,linaro.org,arm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yumpusamongus@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 685B85F035
X-Rspamd-Action: no action

On 1/20/26 3:17 PM, Ionut Nechita (Sunlight Linux) wrote:
> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Hi,
> 
> This patch addresses a performance regression in the menu cpuidle governor
> affecting modern Intel server platforms (Sapphire Rapids, Granite Rapids,
> and newer).
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
> 
> == Solution ==
> 
> Instead of using next_timer_ns directly (100% timer-based), add a 25%
> safety margin to the prediction and clamp to next_timer_ns:
> 
>     predicted_ns = min(predicted_ns + (predicted_ns >> 2), data->next_timer_ns);
> 
> This provides:
> - Conservative prediction (avoids too-shallow states)
> - Protection against excessively deep states (clamped to timer)
> - Platform-agnostic solution (no hardcoded thresholds)
> - Minimal overhead (one shift, one add, one min)
> 
> The 25% margin (>> 2 = divide by 4) was chosen as a balance between:
> - Too small (10%): Insufficient protection on high-latency platforms
> - Too large (50%): Overly conservative, may hurt power efficiency
> 
> == Results ==
> 
> Testing on Sapphire Rapids with qperf tcp_lat:
> - Before: 151us average latency
> - After:   ~30us average latency
> - Improvement: 5x latency reduction
> 
> Testing on Ice Lake and Skylake shows minimal impact:
> - Ice Lake: 12us → 12us (no regression)
> - Skylake: 21us → 21us (no regression)
> 
> Power efficiency testing shows <1% difference in package power consumption
> during mixed workloads, well within measurement noise.
> 
> == Examples ==
> 
> Short prediction (500us), timer at 10ms:
> - Before: predicted_ns = 10ms → selects PC6 → 151us wakeup
> - After:  predicted_ns = min(625us, 10ms) = 625us → selects C1E → 15us wakeup
> 
> Long prediction (1800us), timer at 2ms:
> - Before: predicted_ns = 2ms → selects C6
> - After:  predicted_ns = min(2250us, 2ms) = 2ms → selects C6 (same state)
> 
> The algorithm naturally adapts to workload characteristics without
> platform-specific tuning.
> 
> Ionut Nechita (1):
>   cpuidle: menu: Add 25% safety margin to short predictions when tick is
>     stopped
> 
>  drivers/cpuidle/governors/menu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> --
> 2.52.0

Rafael's patch [1] from a few hours before yours might address the same
problem, it looks like?  Maybe try and see.

[1] https://lore.kernel.org/all/5959091.DvuYhMxLoT@rafael.j.wysocki/



