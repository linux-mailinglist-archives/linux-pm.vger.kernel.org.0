Return-Path: <linux-pm+bounces-2359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A88323C3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 04:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7FC1F22744
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BE17C9;
	Fri, 19 Jan 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqrecafR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FC3C28
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635072; cv=none; b=T7JQf9lOXQBzQRwHzJnteclHWHc4/fJwpV7pZY+G5D3JttZt96VvxB3PTmSQ1YTMB1oHyKWSfP/kkidK+oh9J3bUANPdTqXLuaXUDTUm1Sc8NXzU5M54wcG9Zce16I3R3GrTD9Ef2icdEel84lnuuGNlp2U+s+dq5onzbPtjpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635072; c=relaxed/simple;
	bh=4CjmDcAfuQA+pdODKgDNmVq/jrF+sn9OoUE/9x9Lw/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVIt9KKl2CgmlZVddOqSrHDnUzjRayR/p32TF7R1YRhWxVLOJO2Q5LGa1hlSHzWCoH0bwEPoOzIWV4QjI1oF1gI+znP5XASSNzQudRmBVwzzQXSMT4EUsKNoD+dR/xgXIMlDyRyW010SBUV+Pbb62ywu4eTLvVcy7Peqxeqy2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqrecafR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA18C43390
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 03:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705635072;
	bh=4CjmDcAfuQA+pdODKgDNmVq/jrF+sn9OoUE/9x9Lw/M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UqrecafRN2ZXPqhMcdmYPVJvbkhy2Cz3CIzIEZFjH+abZl1Ymb8NnLuejdfUSt+Dq
	 DS0uJzZA0At9xcjRQrGJPKmLZHAtKEQ3Kbw1pSS8hep6MMdPq47124mo+htBLiNPbQ
	 +2WG5zusMyTJ5VV5LRyhoyDolDYKyDGrfzBoFAUVtgDCROwHHr/v7BW91HL2fwiHoL
	 5Z2SVkSkkV72deXgI1CwM6MWrlQEYmmgAwH9rdY6GXXMk15ph7xHVip4p9Dh0dUPB2
	 wWfZSTZNUjGt/FuY7AHKIIsl6SE7InX8xA8en+1/fZDxHSirZyfn5H9w+mH4+RbXtu
	 pqojlcApNktuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DD48C4332E; Fri, 19 Jan 2024 03:31:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 03:31:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-8ITE1aKvxX@https.bugzilla.kernel.org/>
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

--- Comment #28 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
Created attachment 305727
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305727&action=3Dedit
sysfs, ryzenadj and cpupower output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

