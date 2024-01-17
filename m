Return-Path: <linux-pm+bounces-2317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB2830EC5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 22:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F137528159F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BC25578;
	Wed, 17 Jan 2024 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2lnNCAK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1542556C
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528191; cv=none; b=F2slztzfxOPdmQsAIuAQEH4kDlbX6vc0z1m+VFFIsX4xvOfUx8EM5Up042fVcUFaXQNxOuDAzpI9e/rAsjZKvVxx31Ii7aIM9T0JGSuHRs5JRoXEwqyJkdUCG58fTDYpOWjfayakevnduWu4Bbs1pqKETp9QFeGLomhgjHqE4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528191; c=relaxed/simple;
	bh=UwU9KoOvMKPncCQ9XB3BUPwZ8hi3DUtwV1xK1x39mH4=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=WW9AnKQCWjIDTijZNhgjm+uIyhXdMrZcGdIsqp0gwRlYhbj0ZXJ6Ob3ARj9MGWmOIZdbAGxBJtgKWV/L3PD6CFsiRE3E/ILXB9zbg50F0FuQQ49MD06NGPAV0qJ4HN9yopwZmi7c96dP0w4zMg9m2NzOv2p5nC2YA4bYTltpdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2lnNCAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E383C43399
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705528191;
	bh=UwU9KoOvMKPncCQ9XB3BUPwZ8hi3DUtwV1xK1x39mH4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A2lnNCAKXzzysiJmMYalcepksYpodXn+OONVBxiQ+erQPA3MtKTD/fSWrJOh/TkSh
	 LvzZKVNrYjPUyYr2IlG130wLCPFRMtd9pK7M+YniuyCO6mRCKS1F2pnm7i3zVWj/UE
	 ++taOyj5Q5mAM5QTfXB6b30dnUYHgtoCZdZ/AGSGtjRgBdCS6YjXNJ/Ob7kPyulPxy
	 Tr73wlrleFOuhIvCIxc7y9uiWgxOxi9+m6p8fagz8REXPdki7PtsbKfpX7UQTKAfza
	 uhALtbADu0X4R4Nmd44mVoWKVDkyzrjqX3uWZZTTSPHGeeDLBlmUC63nPmy7fVrxRA
	 dbanjGaUPscPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5C423C53BC6; Wed, 17 Jan 2024 21:49:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 17 Jan 2024 21:49:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-RzMjZqWfGF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #29 from Gino Badouri (badouri.g@gmail.com) ---
Also in my report to Asus, I've mentioned the URL to this bugzilla page in =
the
and told them it's very important to read it for more technical information.
So if you're going to open a support case to your motherboard vendor, please
mention this URL as well: https://bugzilla.kernel.org/show_bug.cgi?id=3D218=
171

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

