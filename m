Return-Path: <linux-pm+bounces-16589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F038F9B3582
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4761C21E52
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC41DE8A4;
	Mon, 28 Oct 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnPfqPfM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB371DE4E0
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131060; cv=none; b=LeUmW8EqJi08c5Yck1kf0//1c+m4hXXWCcf0MiA4BiYnAIw7kICnls9hj/Kvg0EQwm4aI2dqXI9uWlj1zBwlwTUydPRvfxM3CBaZH5W/YgPkXZH946sy4hoq563ujGcnulYJq246YKfsQ4PqIXrcj2I0Ng33ovFzKL4IRF82WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131060; c=relaxed/simple;
	bh=+K1cFeTf85OZTF/+sFE2yJZZOFG5JFUHsKRUnyftOXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHKNpuxiy9ywFVOBYHor9QO7S8viONyUakWlz+Cp6UoSbYfzfwHI453kPNwPQKYIg9hBC1RSM3kZcL7fPSdQwVaa8TFdtGopGhJT4Ro6Po/a6E8TAt4m8A9dIIPZcU4852cgqrMrpSHms+yWcpV9wU1ldUPRpQS6jrfJQdyhPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnPfqPfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9574EC4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730131059;
	bh=+K1cFeTf85OZTF/+sFE2yJZZOFG5JFUHsKRUnyftOXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SnPfqPfMjv9bXrBVJR+mhb4qv460rc3hVAfRBNJRZ/RTTjPshyJvF+fWB5aba+diT
	 CJpe2X6fuBhjew8NMobA6wnRVd2h13xBptHlIGpcXyURCc9QOT6lJzea45wC5+/Vhr
	 pz2cWh6qRJAgTxwu7JCMTVk8H33yzvrUa4hlIU3TCu1df7R3Qj+7WuSZekV74Khuua
	 0hZ+YFurEcnwaf6TT9u/S/r0IziH37h8iV0BhHyMwoayKvLGs2HVv6Xp1Wzjo14yzG
	 +w0dHfJ5QHeKmaW7oYkngpC2BqbsnkzN4Izr3ImxqdX4F+Rf/xMUbux42oy/afynOM
	 WUh/u/cW6VDRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FCE6C53BC7; Mon, 28 Oct 2024 15:57:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 15:57:39 +0000
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
Message-ID: <bug-219431-137361-hlmtk2srm9@https.bugzilla.kernel.org/>
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

--- Comment #7 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Please also share the same dyndbg output.  Let's make sure we're talking ab=
out
the same thing.

Are you guys seeing any functional issues you can elaborate upon?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

