Return-Path: <linux-pm+bounces-7473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62688BAB5D
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 13:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110EAB21190
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 11:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD31514C1;
	Fri,  3 May 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5/51rsH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FBF14EC5E
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734522; cv=none; b=iFmf0SD8SsK3v4fVPdXyDvhp4Xcv4RuuvWnwoVYKv/W6IkYeN1GnKzLXrTyCgWCt7YG1T1rcgRU+GHXmpVZVTC5Ci42I/+FP/SrxDR/1PXdUKhP0qCu4tiwCFlQ8LmnN+rjE1s62Zu3HnmHkIapNKEOJgwnR0uZh06GjcD5RFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734522; c=relaxed/simple;
	bh=xN1renRfqfmDMF0hg5/Fs+0aZnQgi9hYKGqYh6qlG88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MF9ll8UyGXqRl2DUF4L8zIKh4K5LkRjU0Dw4LZLt27D2a6CfxsThd/27H88Tm4S0dX16z7K96wkabS6kDRV43ty2WvkVA71/C/rKkMJOftI7p6lPsYv13lN7vlJBESq+LtH5r4gmPFzhv4RnJlRC33EI9l8dME8Gj2kAM87IClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5/51rsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3848EC4AF18
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714734522;
	bh=xN1renRfqfmDMF0hg5/Fs+0aZnQgi9hYKGqYh6qlG88=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q5/51rsHHy7fRvK8T/AAkcECG499uP7cPvak4efS18ZgGLfWvYboazhlmdY5kDwpr
	 3t4RdjfiXk/LxLR5AaJGh3tRaK/y0/MzHQseHpu7nIwEvEhMQwVQTIhzsbNlo4SfX1
	 9XP162kuyrFvhfCF+1PMv/IngkcOXLJfEIfLQtUlrV9wNn+JRobyujKmoRUbp5Oj8W
	 GTeqK0vHEyaxOEFVFcPfi5bLfjCIHDQxgWPyT9vE/Y+KraOUmKicRTJ97Scv+CNnGp
	 NJXcgq9+1u/e3jxkgp/yp5YTje1r/rACJqSA7C3zSeQNh4977ZK/G9BY6Xg3xhMukE
	 MUEOinflmXk3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 28496C16A72; Fri,  3 May 2024 11:08:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 03 May 2024 11:08:41 +0000
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
Message-ID: <bug-218759-137361-GpLmKWA62Q@https.bugzilla.kernel.org/>
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

--- Comment #17 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Perry is on leave right now for Labor Day so I'll update the status.

The fix is developed but under internal code review at the moment. I don't
expect it to make 6.9 but it's small enough we can aim for it to go to 6.9.=
y.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

