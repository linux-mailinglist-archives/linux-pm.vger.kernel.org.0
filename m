Return-Path: <linux-pm+bounces-11723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224394236C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3DEB23801
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8318E02B;
	Tue, 30 Jul 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVNDBITx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A914A635
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382458; cv=none; b=gKSnruXjrZL5wmDoJ/uO19W1IgZiDwwTHST8LGeHA3v5C8Rm1Pe9BES/p3kTdZ04xuJ1ViwT6/3mmAhnC4UzyEx9ZS299W/Wkxm4FhPFPXccig8CgJlgfyNsDIOFgmyWRrje7rlgzX9+139XUK9gZSxrJOF3McRdO5Ddg3dKk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382458; c=relaxed/simple;
	bh=LFnReYvV3zaUDENp+F4+phpdLwCT3MSUkNj280JhDN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pa9O1/gg7ECLuVzOmpEQEWWRvq1CC+E9MsJFsaOsCkwTySZywSPUpBQMQX3tEY1S1SIfKJ3wDD54whPxLsG1f1qbS+N10yrKC+ZAs9egjmMxc5lsTmHuDz5IkfUrXtFMe1ZDR2IGQtY0A8BOEbmPpKMhbLgU0k+nxrbxSisn1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVNDBITx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADD4C4AF10
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 23:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722382457;
	bh=LFnReYvV3zaUDENp+F4+phpdLwCT3MSUkNj280JhDN0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XVNDBITxBcYL8qn5Zm6diWZF9ESw/uGbANJkJQnQUwQ0BwRHB8xAyuJFrhtUY1x1b
	 ie98BIs8pnJEY2C6AhAIlQI/LlYLTzeJTHEToFRXHWdjKerq1niVE0oQkRjZLWu/au
	 1JkCRFabiv/Mk1l0ItLos+wO+bYOExzlciAy1iV2tk1DWtGNOBLLM4jMR+SHRKPyGv
	 v9M0xCQth17iAL0Iql5D69DLQvzlcyXtoPFrtKjsdjGZwlXUAEOUqXlHY4Gaz93tfu
	 S1SEIDaFW4OUGJ9AeIOW35VeqriGIdJ2vYSsZL/POr3Gfp6S5t+cXZ8sMiVlKudawu
	 4ffu/hqrbR5uw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 63882C53B50; Tue, 30 Jul 2024 23:34:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 30 Jul 2024 23:34:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-SNkEAus1TU@https.bugzilla.kernel.org/>
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

Chema (chemasanchezgarabito@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chemasanchezgarabito@gmail.
                   |                            |com

--- Comment #60 from Chema (chemasanchezgarabito@gmail.com) ---
I have the same laptop and also the command outputs are the same.

I have updated last week to the last BIOS version, but no changes I have se=
en.

Is there any updates to this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

