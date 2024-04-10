Return-Path: <linux-pm+bounces-6224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31589FC81
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A41C21BB4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D524179205;
	Wed, 10 Apr 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jITIaXDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391951791FB
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765309; cv=none; b=V0IPSaxOpKg4/BQCUa6/VjUZlwD28pUK/cYXJYIG7J/OMG+c6CZYOefKuFCKcJHNiSJwosyPazZAo/G24/ukjXpFDLqxPk5PWx2wbgIyABR2Itmk1AMF6YZ/Kp44J6zO2vIRWeXpg4qSPplQ2YzOYOz0grLXG7JenREjHZCRwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765309; c=relaxed/simple;
	bh=zNa7lfjS6AkDqAPt9OwA/xaeQSvNhTRRdgwk002U0fw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjghGG/+ZgHqpffvLPv9JDbRlCUpJWseXndO7Sma6aqliUaVqqUjpF3FN/LswLG1OiQs1uP1h7cjd6AURTkLQ6zHT+LLClQjq+BmkAbVlwMM5NuqoCTKlcFrGZUG4Nlh6wJp4MnOdJPAPSnjcVtErC48RWQU/jNzG7PtRiLatks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jITIaXDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E56DC43394
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712765309;
	bh=zNa7lfjS6AkDqAPt9OwA/xaeQSvNhTRRdgwk002U0fw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jITIaXDmVq4LyTNh38Au/2dVL21euPUmJ4dYw/C/HUWDLttOwi+hXEZGjAtcFHQwA
	 lA0DZggipHyiK5fYx9yXB3JGWHNCBXW1vxnMOhiNZxsVjZ3Ky9OlV4NuVRFCWvJ4M0
	 yW9HrRLDZyDcbPoGxBwWsM3CxWcz7rWTjpYzF6pXn2yQqWT/kI1VYKK4xiYUc/I8w0
	 IoptIVZ1n/fVvzi3Qpx9yLNmyZ91BBrKCttp/iayAwpYueDeeT5m/0Dimv9sY62sVk
	 cigm9Cqe7XF71+yxyWJQk6s8f3BwymHa43nLJffDWEJaD8VxP2lnztFrBuQZtKaH+Z
	 I+9oBUPU3mqEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 182B4C53BD9; Wed, 10 Apr 2024 16:08:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 16:08:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-218686-137361-Vw4A6VcKJX@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

