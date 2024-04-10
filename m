Return-Path: <linux-pm+bounces-6150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8289EB45
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD61C20C83
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0C1D6A8;
	Wed, 10 Apr 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj5F3qq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF728C15
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731794; cv=none; b=p92FCMXvih8GsjKZr9z5LHKuQZ9KXNXv5MxNAV0Kr13FPdCEE2FSp5hsjVcMjfrCIX2vnoSwy8Mnw0CMtvhE4MsJiGJBteoqWN+aeSJCOQQnZ23qWrPL+KaLY0xYvpLVcoVCIMq37VKcjOLQ1gG5ftaJk6wCx59pQt4Lada/hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731794; c=relaxed/simple;
	bh=84W0Xhc05d5JA0fPFijD0X6aHiuLzhvWNU7ZdUXyeco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AgfchdfpUn8SULRhG/roQoupYGjerMjPb72JvVOQsGSF9mbm7EmYnv8bkxXgwgoEFVTGiCYCq1D9KpUfTDMwXz+QiCS9cL+hZVhKeO6wOA/DiUvo7tN+To3uhPc38kjSw/DsJfVpH4qJI8QSvfwuoPFlHNQPM98Pu8XVtpcZHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj5F3qq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90B1CC433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731794;
	bh=84W0Xhc05d5JA0fPFijD0X6aHiuLzhvWNU7ZdUXyeco=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nj5F3qq3Eg3U3M+oLOURL4fW3l1LVAsVbkv9MvkPiFEQiIb6mhanswIHQnzRLcazF
	 CbFMSwbc9YPB55OsXIkqpzCn8XtzKEVLFRapgFy2tgv62o88JNnOHeMBoo+ZPbc+Jw
	 lX4LFtg8epc+NBC7k+oWQohnm4hduCOBboEpQkL4y8xZozvdT8gwkRyEaCXSh1ukdr
	 7v26YI/qZKiKzr+i4RYt/IW7Y+YpD/tv3ZPHWLlUz+z9vDUX79HE019sBs3mJEdwwz
	 5q9wKkkrSRxvKLldz3Y4Ti9kE+5+1KCClDGpGwtc0nl+5IMARfogGRh9FSc9ExNLdT
	 Goqb5m1ZDudlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85F88C53BD9; Wed, 10 Apr 2024 06:49:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:49:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-5bFHsuO4Gn@https.bugzilla.kernel.org/>
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

--- Comment #16 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #15)
> Could you check the BIOS setting for the CPPC enablement?
>=20
> 1. boot into BIOS
> 2. turn on the CPPC "CBS =E2=80=94 SMU Feature =E2=80=94 Enable CPPC"

Asus don't provide that option in BIOS, I guess I can only do that via
Smokeless UMAF? But it's not officially supported.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

