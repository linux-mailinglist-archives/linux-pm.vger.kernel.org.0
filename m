Return-Path: <linux-pm+bounces-13895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CBD971D66
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C311F214F4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C238F179AE;
	Mon,  9 Sep 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBms01zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD91758F
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894159; cv=none; b=EqC7WQpo7g5lA1fszulv9MyNeh9z9wDtIX3nvHJaPdPNkTcmBDGxsqfFpnLtIIiX2XQxXYalV0YFq8eNlR+mSVdhM1gjrVumVKO73VWjqMoL/Fa2w0NmeZhXVr/flEARxPm7iuW2TzIljZnmBMyvURyFxbsg/bdfODO/bJFIlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894159; c=relaxed/simple;
	bh=Yz29kPkQRbnXW07vhkIJUv68Vhxg5c0XiX4aDxmZ9M0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVdZY5JyQ0sxFGmmTK/82kV+CTy9HL4QwrfkfsIVcT1+g3r3NAojPLhN+k8E+DYHVIM5yZhRtKFmmaHQzrXGVed0aUs4vFXV4qfbCbEPEWk8JyahA/EJ1kzVd+TXZSkICiKOW8varq7g6zBZcuR5s13eeA82pBN75GCdXwCYX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBms01zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23F26C4CED1
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894159;
	bh=Yz29kPkQRbnXW07vhkIJUv68Vhxg5c0XiX4aDxmZ9M0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TBms01zztkxFsbbz8lR+Q4ggG574T4TMKMmAiV3JgdIuW5Vb6YX548lJ4Kp5vd6JT
	 I577G9WA4L9QknsQ+lHesNhTD6a11Vz5ks08PrqhIDuj3lNmw591I8TMhSW4Jx2k0x
	 8WskwrAjjsp2hTRidrYtfg3d6t4B2C7jB8TXCd6t+p+wydmYdLL/Xqk1KdgG5TdzxL
	 NP3hc/Rcv7GKcWF5MElbQVaG8ArBW9aYG2aFEf2BVMIVr3wtdy6AFaLNmGkh3AtdX/
	 xgBZ6Oys1VacU1/moXJOOlE8vlI8JoXTkHurXKVzr61uwtCq+Q9R1Hh/njTYkzWUoe
	 riOt07wFcqGNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F715C53BB8; Mon,  9 Sep 2024 15:02:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 15:02:38 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-Y3EOlxoXfl@https.bugzilla.kernel.org/>
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

--- Comment #86 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 306841
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306841&action=3Dedit
opt EPP register writes from FFH

Here try this patch.  If this works, I'll submit it for review.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

