Return-Path: <linux-pm+bounces-28725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC3ADA32F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 21:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618E016C46A
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA78262FC3;
	Sun, 15 Jun 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vACugf2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512226157D
	for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750016212; cv=none; b=X+e27aAvPEePby9zuv7DO4pc9dOE1OlPnIKay3EmUZROqM7ebuzn6KCV8YXl+mAR1O1V2zJj10DqPGKaPBgfDGEBVFthTcXxqnPhM6Vcs+aMdLJ2JUtm7Dty+FEZqLczg8KlBtAIQF4wUrTAu8irDAyPZSQjNCCgdTj5brzjajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750016212; c=relaxed/simple;
	bh=DCuvz64nCgjM2i3zQU6wrUUw2S+nGe/AFz3cvWUEyDc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MEKRvySGg6HidDI3MRWeTxxHe7Tgfv3XRoTK07PwbTXGEw8+BrY5Jbk9JPynx1V9SYxmvpG5uUAVFGGlvm9endiunSSr7ZOeGXtFEq8kDQlgDKZEtqAk/mlX9oiLZhxZZfnkZT4Uw/M8cF+PxX96aL23ZN+dd3Yo3W7D17pWPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vACugf2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0189C4CEF2
	for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750016211;
	bh=DCuvz64nCgjM2i3zQU6wrUUw2S+nGe/AFz3cvWUEyDc=;
	h=From:To:Subject:Date:From;
	b=vACugf2k2kiv0YvyaGAp6ZAFTLm296ZUboLZNrQ/fxbpsRtwoVCwOwTlpRjKFwnAk
	 RaZArBBDnEut2tz03RDzcgDawYXNjg0ML/x9/vCA0dLtivQkfny+MDB/cEu8Tviqeb
	 4x0EG96TGWLdDWwA7+wtA0teHUlNHOV2lNIeKHiJ6xM1+w+GOpByk0GFNWJabXGLO4
	 ZriS3TgFK5l4PDf4dy92IGbAmIKzycw4k1FI/Q/AxKDoj5ymOqsyMAp6gQfpmJlc21
	 /voj9VFQxP2dR2aFA8cBoLEpAVBrZB9kIOGX3tNAu+516dA4jWUOtEWxZZ552AcV7V
	 +ulU0p57P2oKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BFEADC433E1; Sun, 15 Jun 2025 19:36:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220235] New: WARNING: modpost: EXPORT symbol
 "cpufreq_frequency_table_verify" [vmlinux] version generation failed, symbol
 will not be versioned.
Date: Sun, 15 Jun 2025 19:36:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220235-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220235

            Bug ID: 220235
           Summary: WARNING: modpost: EXPORT symbol
                    "cpufreq_frequency_table_verify" [vmlinux] version
                    generation failed, symbol will not be versioned.
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: enhancement
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

WARNING: modpost: EXPORT symbol "cpufreq_frequency_table_verify" [vmlinux]
version generation failed, symbol will not be versioned.
Is "cpufreq_frequency_table_verify" prototyped in <asm/asm-prototypes.h>?

Kernel: 6.15.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

