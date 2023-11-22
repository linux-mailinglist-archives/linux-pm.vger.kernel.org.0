Return-Path: <linux-pm+bounces-62-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4557F4078
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0178CB20B20
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657D22079;
	Wed, 22 Nov 2023 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBfsj97u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938B1B278
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C096EC433C9
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700642715;
	bh=L+AhHne4WHIb+SC15bGViG6Ab/lODaha59Fr1ZYi1EM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WBfsj97uOr/MsGtj7VAZXAzmfIf2Kq/s8NQ1FhdxRwbe40tfuEZofuOuOti8CVDO4
	 A6AIZHe6rtIzVEB3cgW1GMorWdknYxM7mDSr1CbpN8mRkKJiainupIkM+wdJToJip7
	 Wgs8yoAbCaa8f1d+Voxlo+hWmKfKFwONtQUqGZbP1oxpiEJGOHtqp+xeYbZSrgMmwq
	 Ah2Bpa0RrVw2s4FA4/Ckr10UBrJrZnq+rRvHqQO6x5AZ53bmqEBsbKrCfsq+1F0HiZ
	 nXBvkgRVesXpKrxm/0H5W5+h1Fr6RL8rvJRZ4vxTC/0w4EVgWFtxs7ge6zIMgM2pWz
	 l70O3nwAmjPzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3939C53BD0; Wed, 22 Nov 2023 08:45:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 08:45:15 +0000
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
Message-ID: <bug-218171-137361-Zyt0du9Y2R@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Great, let me check the ACPI tables.
Could you attache the dump file to this bz?=20
I cannot access the link to mega.nz.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

