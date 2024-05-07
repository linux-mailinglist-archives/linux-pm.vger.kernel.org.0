Return-Path: <linux-pm+bounces-7566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F48BDD42
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929A52841B9
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED214D447;
	Tue,  7 May 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXrsfgSP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394814D43E
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071248; cv=none; b=rlRKswnlbSk2kt3h17kR6naPbHJnWSfjsl8w3rI2mIwYO+NdE6WgrRmd1oeR1ew/yK0hkhefdr+f3IzpbDPyMvumPPQinsPRj4pJGv3NXdd5kjVcztpA95zToieZT+4761iMOfGBRIjyJ9YcvFvAcAjDu5hB97bvvmU36xyVe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071248; c=relaxed/simple;
	bh=/zcRFkAZSqHbQa2DUjY2CSvoae1AaBm9yEjiSUEkUnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swZNaOfXrFCYBE9+J7GnuSy2rgYTE1rwdu+8mOmOX/0JzEu/3VaxCCZy1CR7eJVOWHi0kvo3qyWQCK8AeNjqmNhfx1P/m2tlbjar0p6RAz1btea8RWf9X3myYU+GHgrGRwJvDdIDU8cvaukZuuRmHoToVxNl9kmzrnzhHOj6OI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXrsfgSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58336C4DDE3
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715071248;
	bh=/zcRFkAZSqHbQa2DUjY2CSvoae1AaBm9yEjiSUEkUnU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gXrsfgSPMec27t3mfyT9+r3gDbhbaEkGbJ9QCFEfldsYiFlioSdm53IP1pBbYVZ5j
	 b8ZcN4fwwnCwy9Vqddooo910GzmXLfE+J2GOet+cYjttNKpAtL172vUdXMNfg0vsLv
	 1ygQMQek2SpE5NnlAwKg5UA01PbtixvfK0goe5Hsy4elrNLXiGu1ohaoq1f4JKEOWj
	 y91hks0MrQ/6xGkU+a0eeHpQFsXJnuNBvgViQbNjwaYVuTpkuT/ZSADQ+ol788tKn3
	 NFfrjs3UxqMCtwd6d4Q5v2S+dzjLSSonG7/aEVhi3Rp+sY2/kT58hs4bpZrbiQFKfn
	 wMg4We24U7D+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46490C53B6F; Tue,  7 May 2024 08:40:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Tue, 07 May 2024 08:40:47 +0000
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
Message-ID: <bug-218705-137361-HL9YYVahya@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #27 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi, Please try this patchset for the issue

https://lore.kernel.org/lkml/cover.1715065568.git.perry.yuan@amd.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

