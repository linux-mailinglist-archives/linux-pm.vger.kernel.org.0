Return-Path: <linux-pm+bounces-149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96F7F6C78
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 07:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD2FB20B9A
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42F7F7;
	Fri, 24 Nov 2023 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwuEFCPO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F491441A
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 06:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91943C433CB
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700808473;
	bh=hy7YaayjKhofduZ5HlvdRKkFaQMZo9EgwqG7XCho8bc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bwuEFCPO3FK+ZqCLD6MQOlDvGsISgirX9pBCYAdrd9iPTsYddPme+DHLH9biN+lwc
	 sPf+s+r30Re+WHFhTAj2LeRgK82BcC4nVjl2QonNaD1J/4CgSveGyfgHdf4Fy9TC0p
	 VaQxiLyrDCqFRn9ZjFeQHRcamaqqCRWZqxVESxwlX5PGZp7RcwIqNgPCBFyYK+AIIS
	 uFWG1uTFCPmCCt+aNMMpXWQ2nsMea09nfYtbonK47CMe7FXgi3Mm3us1bWI/FtTaBV
	 RaSaqVdBqcetpY8uUsPw8oqN1n+VBSx8ik5vGztnQtNhua/u7IQD6xpcCskc8cSB9e
	 ZpApU+tCalsyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7BDD8C53BD3; Fri, 24 Nov 2023 06:47:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 213115] Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date: Fri, 24 Nov 2023 06:47:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213115-137361-LIleJTLWcm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213115-137361@https.bugzilla.kernel.org/>
References: <bug-213115-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213115

xiaojian.du@amd.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xiaojian.du@amd.com

--- Comment #4 from xiaojian.du@amd.com ---
I think it is expected that 2 threads will get higher average loading than 4
threads, then it makes the cpu freq stay at one higher level.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

