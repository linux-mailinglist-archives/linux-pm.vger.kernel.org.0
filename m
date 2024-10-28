Return-Path: <linux-pm+bounces-16587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C49B3525
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C001C218B8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784B1DE4F3;
	Mon, 28 Oct 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7DG4E8u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361212F585
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130067; cv=none; b=B3YweTFeVCG1E6Z66jt1K9SADgbTsh3Vd33FQiphkJztRWEOgYz9L6QYy6Ab5jdyT7joe9v2ijxJMrhnm0uOXs0BOzbyCZidNJfied2QYm/y6+ik7VF2gL64mCoEQtPQ05F+WxsUeEeAo8vk8wzojIrAdoT94alJIGgio/tbsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130067; c=relaxed/simple;
	bh=AU5qS9birt373A4uPL9+TGQx0rr2nAEBkyZG3JPT0os=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8yWw3KrTZRCkZKnVYu7CxvJvTxRY0MgXktdtxth9ioL3Zwg+UAMtnElbDR0SWDePtWSk+huGIX5gHJJLQbFmQ3oyYbQpP3ro+XwLyLAZiofYquELr/cJpVod6qzTv5fvRSWrs4wHNJMfFMnXGHopal3tyvro2+jd+lzI4nvBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7DG4E8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19C55C4CEE4
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730130067;
	bh=AU5qS9birt373A4uPL9+TGQx0rr2nAEBkyZG3JPT0os=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u7DG4E8ulkuBqYuzl9fOnunRKF0jGYChqgwmHb9MLfWKijD1zJjcjRMac7PrYT8Pf
	 +SBfGt9Ie9CqzcwJST59eJ7wqZ8QCL9E5IP8uLGW+mM7GzOoo2U0Uo3eRTGUNGAXL/
	 HOX9j/vbk5FiRRp/HLgi3hWqaYLrSem9Yo5DvvYSfbu4REXM3NLUckcdY9w9gjfvsF
	 V3RgaTSJv5OlUnqYByTwJf2HykR8+YiKGzUgKqKPaDYMXGBFcFnKFnXgSyVoqlEBw3
	 WffdVHu/gqAzVGKEjSq68v8/nmd60IpuaIXNIv9NGN7YNeZ8H3Z82INNTVIrEPUW73
	 LSeMktYcUvzFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0891CC53BC7; Mon, 28 Oct 2024 15:41:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 15:41:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-46DCrSy4TL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #5 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
It looks like this message is being emitted specifically from the calls in
amd_set_max_freq_ratio().

You system is a shared memory design not a MSR design.
"[  +0.000016] amd_pstate: AMD CPPC shared memory based functionality is
supported"

This looks like the calltrace:
amd_set_max_freq_ratio
->amd_get_boost_ratio_numerator
->->amd_detect_prefcore
->->->amd_get_highest_perf
->->->->cppc_get_highest_perf
->->->->->cppc_get_perf

The first error you see is "No CPC descriptor for CPU:1" which comes from
cppc_get_perf().

Can you please share your acpidump?  It sure seems like a BIOS bug to me.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

