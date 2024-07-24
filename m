Return-Path: <linux-pm+bounces-11355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077393AB76
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA7B22F89
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F359179BD;
	Wed, 24 Jul 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WepmS+8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28038BA4D
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721790065; cv=none; b=bfCj+TJSAOrcZWMHTJi3ptbxKO9s3/5oWwvM85dSWYxXGoNJZCBORUWFK9MHffskae+FTtAk/mMaF2o863fBd3+KPIgNrzFcduhyrv8SXPfJLaNYf7q7/bwFKLdIwQGXxl8VCHRqXCiHXWMkpclHMK8z64sFLp1cno/E0ZIf7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721790065; c=relaxed/simple;
	bh=VPxkRO0YQzoXH+XrYepFXy8bX55gN62k6WiPchaJyfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dr6OXUWZ6boqiaZlWXsF+ekeR0vvL1zF3vNeql3GwQHZ8OMMidkyNv+2IMo5EWKma+VkuNVZNvF9myK+xcsxNJFWnVdGknZkz+valyZfxoM1Ik2MN5J7vXsDHCmY3z0Wn3G2T4eYMqXYWDi8vj0kTilPlFgmqFPZehP2SMiO97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WepmS+8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E90BC4AF0A
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 03:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721790064;
	bh=VPxkRO0YQzoXH+XrYepFXy8bX55gN62k6WiPchaJyfU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WepmS+8l/r5MGWMcWvJz/kP1gM6dzoNXyMRpcG2fsQYOtGG+XVc/caTgkaqjw3imF
	 p+jO8lKmWWv7vgkFp11ZMhNK4SMi77C84snhzw4kQwHjjGFTh+dDu5xG3hkbRacw4t
	 BvhHALy1QWy92vO8G7PwlGGOdBSsn40E86YVFdfjEYoziAz2ZVthkkqG6MN+7y2VSn
	 7NtAlVLBUT8IK9e3UA2Kq0IrFunXCUfcKY1lfCG6Q8gzkKY9ZvCNlMLc0Fc0yadq/P
	 t9uQ2epYSPUCY9A/s4SF+kcyguip/z/RZdxvRyQg0FDFe6p8JhJW5sqoz2VMIdO5ev
	 y8ixuF1IDny6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8B640C53B7E; Wed, 24 Jul 2024 03:01:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Wed, 24 Jul 2024 03:01:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-k8TVCkCuUg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

--- Comment #8 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Catalin from comment #7)
> Update:=20
>=20
> It crashed with amd_pstate=3Ddisable after 15+ hours.
> Also I tried Windows with crash in 4 hours, so it has nothing to to with
> amd_pstate. You can close it. Most likely faulty motherboard. Thanks!

Thanks to hear the feedback.
BTW, You can check if the system fan is spinning normally in case the system
CPU die temperature reach critical point(+84.8 degree).

sensors utility can help to check the die temperature like below.
#sensors
k10temp-pci-00c3
Adapter: PCI adapter
Tctl:         +37.2=C2=B0C


On some AMD CPUs, there is a difference between the die temperature (Tdie) =
and
the reported temperature (Tctl). Tdie is the real measured temperature, and
Tctl is used for fan control. While Tctl is always available as temp1_input,
the driver exports Tdie temperature as temp2_input for those CPUs which sup=
port
it. (Documentation/hwmon/k10temp.rst)

Looks like your system HW/BIOS broken, vendors maybe have solution for your
case.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

