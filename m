Return-Path: <linux-pm+bounces-3149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF1845223
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 08:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B51A1C21E54
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1413158D6B;
	Thu,  1 Feb 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXp6ZExA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D915A48E
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773204; cv=none; b=Jjbp+2b/W50afk6qFfmlBqFzF7tk+DIHn5TIxtAWaDpo8LVzgfVa4GFx+idnUSQil5RFozYx+eCpLZXny3Euv/jPEUhl9th0ffyjsS2JXdykeijT+phVQibdfPVlzJb9u3I8+JggH691FOuou1/lENbGpbQPgxz1FeQ8xRk69k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773204; c=relaxed/simple;
	bh=Oh2Eq7o0+sqs9PtO/Gw0SBWVfwKKPBjqgRrzV24Rk5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRvs3MgeUGGNqs7HVkjIq4Fx58nQP6V7A6GcQDpctqSyi9l/fmgIc3mXRBLNHN14LFGAvVdqPATK63o5ZP2lQVqm4vOakt3Iyc1HtfvXvhTYluY5mA/vTgNYYFVqOXgGKP5DAiuCmVY+49nDw39b71g616KkFRvumGtwzB+xWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXp6ZExA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55CD9C433B2
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706773203;
	bh=Oh2Eq7o0+sqs9PtO/Gw0SBWVfwKKPBjqgRrzV24Rk5g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CXp6ZExAt20/hzKeJC1Xw+NH93uE73C09BTgXg3FpZZIoAgQmUoAhx9I6HF6FZyKW
	 r50cqS5o93KLsHrF0WgIY7mia10ObvEGdrHK5NAGiF5kSL9637xXf8utuoTTlC/pFK
	 ripVxFG3d+pxMbFCchpXWJT/JCVP2D5VVBlfXgVe5fzKTJQaEYzkIhVJ+VDUWd5VY5
	 B1vqKI4Nm5fsE7fywhNUgAc7P1+3hfoeNtqJhj88TVgCNNtNCjoYyPK/jiswpBxVzm
	 vqb1JUg4wt61zq6ZGtk8ZFv1Kv3EElhx7K2WeREfohDCeFfTkApChdLyyUzzoqjHtd
	 f3iFsXq/xJo5A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3FA57C53BD2; Thu,  1 Feb 2024 07:40:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 07:40:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-DefaSElekE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #42 from Artem S. Tashkinov (aros@gmx.com) ---
So, how does setting the maximum frequency work?

Running 6.7.3 here, Ryzen 7 5800X.

$ grep . /sys/devices/system/cpu/cpu0/cpufreq/*
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_lowest_nonlinear_freq:17520=
00
/sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_max_freq:4929000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:4929000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:550000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferenc=
es:default
performance balance_performance balance_power power=20
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference:performa=
nce
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:performance
powersave
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:550000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:amd-pstate-epp
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:4000000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:550000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>

The CPU happily runs at its maximum frequency despite scaling_max_freq=3D40=
00000.

# echo 4000000 > amd_pstate_max_freq
bash: amd_pstate_max_freq: Permission denied

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

