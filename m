Return-Path: <linux-pm+bounces-209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD167F88F7
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5E7B21081
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF248C1F;
	Sat, 25 Nov 2023 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8M4+kwT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28263C7
	for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 07:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F78C433C7
	for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700899103;
	bh=VY4eI/Y4JipnLdiW0MjtHpBC77q/DLJVJM+FQEcYBS0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K8M4+kwTmbb8OAqgfJKwDVzw2eFKNRAJlJ+yVph9ZLifhGJEyvcfTAMZ2jUcVLHns
	 IP/2A1wJVJZ1NKp7u0M93Ccs0ASSjjEDBnHNdLFQa+0zzs+cr3jlOp7ADDWCzzQQQN
	 WnHq0TZ9go+rCFxV7qOyysoU1JoJAOiq29AT97p0TPlsr8/klN8qebDdK2ArO6kYFe
	 iw72k10jUPx6NpzgIqMhpbO7WQODZylLaKAv+YRcM+9Lu0bDXIkbOsB4Ldr2QGiuOy
	 SkZsZeQnZjPDjt3oUju6kPnkjgaDVT0xqbn3/8//IfG5Uu0Uwh1ljv1VWDePngAGQo
	 zd0CxFpaQKDPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6F16C53BD0; Sat, 25 Nov 2023 07:58:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218182] CPU stuck at 4.1GHz for amd-pstate on Linux 6.6.1
Date: Sat, 25 Nov 2023 07:58:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218182-137361-6U8vBXLu8f@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218182-137361@https.bugzilla.kernel.org/>
References: <bug-218182-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218182

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Please reopen if you're willing to work on this bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

