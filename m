Return-Path: <linux-pm+bounces-7041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD578B1816
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 02:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEB0288EC4
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25880C;
	Thu, 25 Apr 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQlGGR4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761D7EF
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005543; cv=none; b=DInFGRkzUIe82rQgfbE3YqmelEU2KEkrU3iMpfIUJwGIMUiveBpw+tF8vzEzbZBLQujTDDd3a/PT3nJ7nGloapG1s9G09r4JQEyPkAbBALUykFPppZIWPNmqxxUZonbtdCvX4cbUEBhEd1LzSPmsJGW8rOKDa5cmGpOn8eDKPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005543; c=relaxed/simple;
	bh=a29RRBv9PmTQ9KtSncA/a2ScQFQhLd789/PVeLhdM4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uw9h3LOHU9hE5UIqWZqX1uMx3vYe15ZKtHJp6vOF0lzs7KZB5SSz8qcZVH2s3pSqa2Jz+CkGUA6/Vl3H3TRM/XXJPwAiU1OYvt9kD0dQWh3ZCP4SS/S5/sfgpaJmEQK4BLOzyCmCtX92YT1dZNkZvsvX7q8kOeMj6UoViGBrJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQlGGR4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFD03C113CD
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005543;
	bh=a29RRBv9PmTQ9KtSncA/a2ScQFQhLd789/PVeLhdM4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qQlGGR4R9O84C7tQy1g76QPYLi4x8ca/KzSEViq6zvSGtiuX9zLFCJsundtMXSxMC
	 LiptMK8LCm6z24WL6enyuvubichaWHsvOdC9Ny/0U3ADWYbjrMDqHoZRwyFcQ6S5ra
	 E5AXbh1/ClBsdxyQqAuhnKd9Op3djE/0IStNcWhmBncO3zt15d0bOuZhq19xa9S1r7
	 36aiSQiePLtkYqNf0LwEa6U8JhNraDC/aMqLoO8riM3n8wZadktlh5geoIcIp2weF1
	 HJCGTlRJZ2GD/kZrI5X6m8Tzx+Rb4nufg232ycgvzFP8huOsBvbh+IfWAED6tcPbhm
	 sFAf9kgtnRAmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E4158C433E5; Thu, 25 Apr 2024 00:39:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 00:39:02 +0000
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
Message-ID: <bug-218759-137361-us2Fa8ImLW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #5 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Gaha from comment #4)
> Anything else i could do that might help pinpoint or reproduce the issue ?

Hi Gaha,=20

Sorry to reply late,
could you please try the below two patchset ?

1. https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.com/
2. https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/

then switch to amd pstate EPP driver mode, then provide "lscpu -ae" output =
with
"tbench -t 100 2"

then we could see what it changed.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

