Return-Path: <linux-pm+bounces-24847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBFEA7CC70
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 03:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C87A59B8
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C4E573;
	Sun,  6 Apr 2025 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma+Je+HP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2476ADD
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903221; cv=none; b=LymDrOwsQF4/6l8oFjrO7Q6Cx392DcUt1KM5soD3ac8fs6vqfq900hAkfLrJaycDP9KyQ0IIq9dbI36LBW/cbZ3jG2gWPN75l7LNuhjAEVkDZXXJXrNo6O7L+oWatp2QoeWXlF0r1B2hZQkxxVHOPcUA3qmRcp5RXMWzyvDuAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903221; c=relaxed/simple;
	bh=943FX8zY4HoLgts6Ufk6dBx64jWCuUlTFbzoEJJTWUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cucnhIrpjn2PAiV8GHHr17lQ6EWr07GBOpblzTWF4fTxfNYTZnWNWwzao5X6UBGxy/tPl4gLTwNnFcW//T4Uads9EN41uHo2ELvz4MFAjEECNK/JK0TEIzu7BGFxf/wwdiTdmE/HRkEvTXolvIETF8xMH5QIwE2QKxfiBVxrZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma+Je+HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D8A7C4CEE8
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 01:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743903220;
	bh=943FX8zY4HoLgts6Ufk6dBx64jWCuUlTFbzoEJJTWUg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ma+Je+HPcSP7AaDGDTN14JqqHLlzxV6SKFGpnk5AVh/ztuNyPGp2dPueCCVBeQpBM
	 gvhX9OeFoyLpPEVTvOT5qM5KrQ/7vRsWeEoLob/svZUagaeCEh79DCOQ/bKLqYG1aJ
	 a7AK2XClIzPXJDtEnBhSDrA5VolCgLunIf1yFtPH6lClkBW7q/PZbc4um6J5MQaTgD
	 7ZOlEr0cH+j+3i89XKwg6daf/a/xJxbG02XLvMl7tnDEfOUWSo+cKsuO8pBe5Epscn
	 997jYm554XiP+QALcVbzNkjW7cnoyWOJK05LyRMG+fcH9qmrVc4XOowilayWEITKnv
	 GWWrAgyAaPRng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2AE30C41612; Sun,  6 Apr 2025 01:33:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219981] Regression on amd-pstate suspend/remove
Date: Sun, 06 Apr 2025 01:33:39 +0000
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
Message-ID: <bug-219981-137361-pm7nuud1mS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219981-137361@https.bugzilla.kernel.org/>
References: <bug-219981-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219981

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
What kernel are you testing with? Does it happen with 6.15rc1 or at least a
hash near it with the AMD pstate 6.15rc1 content (at the time of my comment
6.15rc1 not yet posted)

If you can reproduce on 6.15 rc1 please capture a report using this script =
both
at boot up and after resuming from suspend.

https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools=
.git/tree/amd_pstate.py

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

