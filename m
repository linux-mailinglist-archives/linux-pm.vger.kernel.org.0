Return-Path: <linux-pm+bounces-22187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB2A37CA4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E81888355
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80519ABC2;
	Mon, 17 Feb 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awjUdk0m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A942AB4
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779163; cv=none; b=C79ln8iILxCx3erDUFLyyhCFGY7mUyZ/4hzFTQ9ksxribOFVcvzHi1T4a4g7b9bE5w+j1WFQdfcY50dVM0ePj0kGM1kLL5iYb7BDiGXZ9cxVoyljm1T6EjVcU1WFy/8SliYOUBp65uFnDb3dybFM36t0kX7CGECKMKvIfgZoXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779163; c=relaxed/simple;
	bh=r1PW5/JUfL6OXmRQle5TC3BFjUIYxBC2fU4rcaUDFWo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWBQ4dYLAW9G4vGK6ClQazXnkK26sfxWmF2yL0zYATRMNAAUJeUl7nYNC211cmxdM0b8ZkimreNbio36TfaasJx4wQduyD0HdiE8HiGdsuXEzK0tCLQUi8dTbndxIIFl4g/lWgjRkW4tUFcigYpb06pucMJ3MKkH4enOuPrE34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awjUdk0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2571C4CEEA
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739779162;
	bh=r1PW5/JUfL6OXmRQle5TC3BFjUIYxBC2fU4rcaUDFWo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=awjUdk0mSvQR2Lg6br9yZwcI4iDDjtS5wthrJ5obqjXUe69X+vP4RReTG/mu3/2Mq
	 +3bOXaDvpXaKmi0cBLXx12WUOSs5K/1+ZUYMec50/DOMIIuPkULjWKpXoWLbySbRMA
	 POM1Biait5dCf2D5jfhiHDj6iGr8QMWe4JzLHLb9ArS+TSa4fJsejhgdFpLeAz1p6u
	 MiWRKhzFEUx4nYEdMuJinSfLMoQbEOW+iNzBannap7FPS3/nc11UUiffGtO8RmuVfq
	 Fk9sj/YJ2VnGtBggM2QZxkdkAwJH3ldc2xtfICKPybfqENCBE7kSg+tAVRrVAuqm49
	 XSwNNDJ0D0CrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BCB1EC41606; Mon, 17 Feb 2025 07:59:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 07:59:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-OSATmSMoZJ@https.bugzilla.kernel.org/>
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

--- Comment #67 from Miroslav Pavleski (miroslav@pavleski.net) ---
They were there even on 6.13 Arch builds and probably also on older kernel.
Since I've switched to acpi_cpufreq today it seems the machine has not been
this quiet in a long time.

I am speculating, it might be also an issue of the Asus firmware.  There is=
 a
setting in the UEFI called ErP. Behavior is same regardless of that setting.
Currently turned off.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

