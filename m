Return-Path: <linux-pm+bounces-103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0997F58D2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2461B20D6B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA35568F;
	Thu, 23 Nov 2023 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDKKODFP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8113FF5
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 07:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F90DC433C7
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700723224;
	bh=Sa9CTpc6DTWQEwBWHIynFMtDeqdpshFnfmKVwKH8IGA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QDKKODFPNi1qVqz9iy/xzhkNMQfndI/N8ZPDH6NISIVxmPNF4dZnnoMiV391dTXZc
	 u1EXUXI7q5mDiKQ5zzDP1fzaV2p7LxRdR2E2X+4V9ujnqq19VhkVNRdtFXywsNb0Fu
	 5quz5EgOz/DY8nrFd1eMcAmqQBmYlb56X/suGxrpYaKNwmxLobQ6mVNVa3aQtkLa8P
	 rNQ+SGpnSakStKkhyv0Kr51jwC85/ogSIT+Wc+HUHzKSNBZ42dZL9ykKlrznmYckIm
	 omMRPKS6QM/bjaK5JLWFLuvgX9r6NXcABQgYhmSHnYLrhnGkxniQNaEVdjjHnqf/lR
	 GttennTMWb7rA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 595EFC53BC6; Thu, 23 Nov 2023 07:07:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218182] CPU stuck at 4.1GHz for amd-pstate on Linux 6.6.1
Date: Thu, 23 Nov 2023 07:07:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-218182-137361-ba7NMHRxpI@https.bugzilla.kernel.org/>
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
     Kernel Version|                            |6.6.1
         Regression|No                          |Yes

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please provide

1. sudo cpupower frequency-info

output for kernels 6.1.62 _and_ 6.6.1 and upload your=20

2. sudo dmesg

for kernel 6.6.1. Upload it as an attachment.

3. lscpu

output under any kernel. Upload it as an attachment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

