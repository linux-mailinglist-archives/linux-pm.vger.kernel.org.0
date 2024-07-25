Return-Path: <linux-pm+bounces-11403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41F93C57B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C001F25D68
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A919D074;
	Thu, 25 Jul 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbn6+rKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF3F519
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919114; cv=none; b=JZXjb3UG1mbz+axfnkmUYE+OoqNAtmwNghZTLncB2sIhywkt8YddOmckuPtRg2G26Z/ma96A58lyrTsXxLC4x8oCQ/PDEDTwP+PPSJ/I3BckKqOI9elttsrfuc7Bz4jlpitFw8tI9jc7x+v5I3LeZU7hgbTW92+Tpo8nCtQS5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919114; c=relaxed/simple;
	bh=If7MX+hC1UTzZFvgqSHWe9olebrUNRPSttYAloCOLCA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s526XrkfiTd+ZuIr7nttnkZ26yIeMum1pSex694KefkwZOb6RZbdZd68bXOUmNE5iePlXKk6xz183WSaO2JthEWhEjA0uPfCuiZL5N+2WL27iW6WfRQygbNkYhL3yl5DZs/FLPXOGmdPaAZPpqN+j5j21zFERJNB1Wrn55iUx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbn6+rKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 257EAC32782
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919114;
	bh=If7MX+hC1UTzZFvgqSHWe9olebrUNRPSttYAloCOLCA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bbn6+rKf7mnUYB8mFB5ENIn0myuOB64YPnCED5SB0fbf24s0WywBS5W+eltHhIkJl
	 dSd3bmHfxahXdupLXn+YiAmon4MVTf655tlKT2J5N5aa5bJN6IS42rurD2AdmW36Pf
	 M/db1ZZufPGU3kk3Ui/QFroR4YdXs7scEUCHTbb/mxAdLI/ATS7Gmtsgj1UKKx5HqS
	 jaPW3ODrBTFAAHaW9ayzXQFDYZy+RXcnhfZWDgljliNl+RaR01B+BMLbLvsSlYfT/J
	 xKmKIufyALo5zLSrNxPV/elsqbi0oRgwnoY85cX5E3CekCoQcUgqk1/+gX/UMNxB9K
	 GO54Ctqg4uvoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F0A8C53B7F; Thu, 25 Jul 2024 14:51:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Thu, 25 Jul 2024 14:51:53 +0000
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
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219051-137361-e6CWvycHWB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

