Return-Path: <linux-pm+bounces-2402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6183305E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 22:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFBAB23BFA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653058AB2;
	Fri, 19 Jan 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2PD9nch"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228458AA9
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700301; cv=none; b=mMu9B1L+JjkXme9IsO+Xc/e1onO6RRGxrDypRI2ykDq+D5u9fb38vKYUNQZTNjiPdRBw3+zzrr3KbO6zUshfHxCVy9nQKuzOQni1Oi0T+eo+ibxqG/X4zFUG3QHBtW5B47il4YaQcFiDOFIAL3VgPFDt0Fy7ayc5+nWn2vRDMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700301; c=relaxed/simple;
	bh=3lt1dcQR6Od3BGJeII6X3O7ggxtd2J4v3l8Q9u7gaCY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gdr03GcyeRDP+6Lrt/0RStLUkvd9Glh7lV43Nvv4+F1jMU3Yku//i3kafpa1F0Xwsd9TFWKmbD6k8IDvGFFHLVHM4aB+19tX3J3kzMfU7wtTP/uWYaumRvW0x40VB0rBV3gQbGKnICFqw/UkFlx9fKCmeT7Sd4wLnY4KRf9ODyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2PD9nch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FE05C433A6
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705700301;
	bh=3lt1dcQR6Od3BGJeII6X3O7ggxtd2J4v3l8Q9u7gaCY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f2PD9nchLzLccEd8e3HhN2VQ4azpj+Xr/HX9i2F+HpTyNqaCB0PTO+w8zdlyH26r+
	 9VTXTWneqFFBLfD0yPfqso9MhYNLR68VVCl1rITxZo89CKjkr+JGVYKymAICPPy7Hy
	 wPV9u/XyE8quGQHFbOqaFQr9nU9kAl1o/dz7kzzADJ4LzH/SjBEbptfZ5KNOD5msm9
	 T4jS0bG9xcBQJf+ppipa6kxPNyz3E+R8cpie2oyDLPBBr79+EYv/HJ6ib1Ftx3GyzC
	 Sjczm9PgpA0MwnFM01mDDH5S72Qfhysu0MCXOKCsLhaaIMaLsU5P7U+fopIm1TsuJQ
	 L7B0BOzwOoFPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DD2BC53BD0; Fri, 19 Jan 2024 21:38:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 21:38:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-B22ByKM7ZM@https.bugzilla.kernel.org/>
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

--- Comment #33 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please try this patch?

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..935376d8861d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1233,9 +1233,9 @@ static void amd_pstate_epp_update_limit(struct
cpufreq_policy *policy)
        min_limit_perf =3D div_u64(policy->min * cpudata->highest_perf,
cpudata->max_freq);

        max_perf =3D clamp_t(unsigned long, max_perf, cpudata->min_limit_pe=
rf,
-                       cpudata->max_limit_perf);
+                       max_limit_perf);
        min_perf =3D clamp_t(unsigned long, min_perf, cpudata->min_limit_pe=
rf,
-                       cpudata->max_limit_perf);
+                       min_limit_perf);

        WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
        WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

