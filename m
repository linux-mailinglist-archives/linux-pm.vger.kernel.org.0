Return-Path: <linux-pm+bounces-13911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D29724B1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 23:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48531F230DF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2718C357;
	Mon,  9 Sep 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmWZWjNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AF18A943
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725918867; cv=none; b=Hw7LD9FBncu1SUGAaeL9XSKuOF2azlFx/P4TlVwlZ0LywFJgT+OTqpLAs29SdG9BaVtsxpOlHnyMsXVh3mOs/dh0+9pYhHecmkeY98vW/soBpgOR0gQNL7EL2vxKL9J4bOQqUl4rNbaunNjKIb/DSXbfdjY9z36wp4ZIggoZstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725918867; c=relaxed/simple;
	bh=tc5vFEk0/ZIqtoEx0ouUbNy3KhLKcXm9ngUz/lRGohg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BB147/OcauC64R1S2JjGfNrl9aT5GFZJtOkQ4XytS5TcGqOjZSEV6a7vLEX/L7IiZQAd/VttxXkU9acQ41dMeIt82+hNZD1JMpWC4E9D8vl90d0K9jmksrG8cEZDGuql/kvhjkFqrAAemUllp/kuYwM8cQ8cN7O4WN1geEPgwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmWZWjNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3284C4CECF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725918867;
	bh=tc5vFEk0/ZIqtoEx0ouUbNy3KhLKcXm9ngUz/lRGohg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lmWZWjNjVPdpUQ7ZWU286NHuwR6CJzG+ZyONJI2clVuX9Pi205lR917EGdcHMJKZm
	 y3dSMJBj5yDKXEhPMwWSK3ftLfiCSV84BljkrdsWhCqyz4ZGfiZvq1D0WNmEXwHLDG
	 YfHu7XMkaRLXzOCwxOQg8xJmq4RVkgnaqTOn0LqDmLy/sXlyoIL53bYee2Q2E9t8a4
	 v+cM0uQXaRtTAjwM1R2WIWuOg7AO+T2hSW6VZgQn2bt/VxIhKZ73oHs/DWI5IqRjiV
	 ixTmhXlAjyTPVn9aslUMootlYTDCKf48ZEZnAPtWIcW16a31czlWnoIlms2koFCxBL
	 AzOUP4gv87hvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EBB97C53BC2; Mon,  9 Sep 2024 21:54:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 21:54:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vderp@icloud.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-P6UjrTx2hT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #90 from derp (vderp@icloud.com) ---
There's no ideal diagnostic tool for that, as for frequencies they are seen=
 as
something like that, but it was probably the same or very close without CPPC

(I wouldn't mind if all of these somehow got to 400Mhz instead of 1400Mhz
though)

cat /proc/cpuinfo|grep MHz|sort
cpu MHz         : 1395.796
cpu MHz         : 1396.448
cpu MHz         : 1397.373
cpu MHz         : 1397.388
cpu MHz         : 1397.403
cpu MHz         : 1397.414
cpu MHz         : 1397.434
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000
cpu MHz         : 400.000

the main difference can be seen in amdgpu_top, which for some reason treats=
 CPU
cores as GPU cores
it can show mW per Core, and even when frequency stays at 1400, the mW power
assigned to these cores is much much smaller, as well as total "GFX" power
which is the total APU power, I guess

"GFX" is now about 700 mW and "SoC" about 400mW when idle

power savings are about 1W for system idle and low-power activities

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

