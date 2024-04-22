Return-Path: <linux-pm+bounces-6762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B838AC64A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3EB1F2174E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E249E4F898;
	Mon, 22 Apr 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBXkmUaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BD4F88C
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773191; cv=none; b=er2ml8O4qqJ4Y1zMds5F27/FF60oWBjNVmKRymo6mGwyTD/5Z00s7xRpj2fOuI3iz2IKIOclzx5g3sbiihIXxigYA8gQDJjQovtHPR225Etx4zUvmg51tBm/Su7MESuzbSPvmA9+RAG98LD/VWl2etwrn4yqN5PUt/fqs7MRz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773191; c=relaxed/simple;
	bh=CL91UCcRPTdgkg3HNLoAPJPoeNtBnfy38l0u1DW900U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ng3JrcU6ZlUectnYQBOaHcQi6UwNbRxVfxHHoR5O0nnZUasmq40k0IAzVvrUP9w6TspMARUnPxhgjiIDa2it17jYY+SnNW50D6foFMD4CGOhXy5lYXVkxecruVqTm4G4wPokYiXGhqSDW31C4TgyCRtAYqcW4hrc1c52QIpgZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBXkmUaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53FD8C32786
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773191;
	bh=CL91UCcRPTdgkg3HNLoAPJPoeNtBnfy38l0u1DW900U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nBXkmUaFKzmENccZAlhf8nMawT4EYWRcx1dThe59BrgJoOUUBZUGr0k1wZ7L+ZK4V
	 aaE+W+5+uCJEID0m70gZ9pKh9I/sWCI/CKxG4l2OJfq6ULkvLBPAzq7qCDy6SEl9l4
	 rqVRqaefcGmNJjyR09TVQ6lCbiujYsizk/bOciZVP6vAJjz/p1bGBoqL7FPslPgMW9
	 Gad9fRWtfjYheWoVAZgocBJoOuMwYYnBFiLnZVHLBceklY378v4WHaCs5UEOrv+Cb9
	 3+HwdJwnkBqk6E38OVQljLd3DFUQk+OkD55+qYgstbdDLIHE4pVOe1iaRUSRvf6Oa1
	 JF+zqSVh2kD3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 491FCC433E5; Mon, 22 Apr 2024 08:06:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Mon, 22 Apr 2024 08:06:31 +0000
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
Message-ID: <bug-218705-137361-VNPlI2qJLZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #4 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Andrei Amuraritei from comment #0)
> Hi!
>=20
> Sorry if the formatting is broken or this is unreadable. Description prev=
iew
> is broken it seems.
>=20
> amd_pstate fails to load on this hardware:
> CPU: AMD 5950x
> Mainboard: Asus ROG CROSSHAIR VIII DARK HERO x570 running UEFI version 47=
02
> OS: Fedora 39 Wayland with kernel Linux 6.8.4-200.fc39.x86_64
>=20
> amd_pstate does not get automatically enabled. dmesg -T | grep pstate say=
s:=20
>=20
> [Tue Apr  9 17:24:36 2024] amd_pstate: driver load is disabled, boot with
> specific mode to enable this
>=20
> No cppc found in output from lscpu. In UEFI the following are activated:
>=20
> Advanced > AMD CBS > NBIO Common Options > SMU Common Options
>=20
> CPPC (Auto / Enabled / Disabled): Enabled
> CPPC Preferred Cores: Enabled

Hi Andrei
Could you use the script to check the CPPC capabilities=EF=BC=9F
As I know, the 5950x is in the CPPC supported list, I need more information=
 to
check what the system is missing.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

