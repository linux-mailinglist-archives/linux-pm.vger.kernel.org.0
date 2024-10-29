Return-Path: <linux-pm+bounces-16631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CE9B3FEF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 02:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C793B21B54
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6274431;
	Tue, 29 Oct 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeHlHESj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865251426C
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166608; cv=none; b=vBggZb6Da/Q5+VAylzU54PL1ihjH9lObuGTbn8TcAJ0i75gXh9ZtT0Xpxyf/8bgEM6wvUSKk6Zv0y+hBJcLzGaVUJAMUjQTKLDeFl6JHLwj0AZa30IMW7xWCrxpxSh/cJZqqemBrJpn7lsJ5MvjzPvOWBmgD1FhFsV3mi+kTi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166608; c=relaxed/simple;
	bh=0pBYehrEilOQ3CtAailqTF+pvvCn5AMohjr0EYCijXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1QZULN7Zs87ZkWq/jo6MoIG5fyd1CbVQpAb0b6oc4ewJpKbMZ5ZB29re/WUOOF4UY5yKMpdcZ92YK0ttC8nNkT6pa1GMpVeFHchqsMfhvXM2vu6Ir4j06Q7LnPrSvzQto9vMg9UaLcovyhJqeupE7h/7GVLgvJuaP8N9s3L7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeHlHESj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04FA0C4CECD
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730166608;
	bh=0pBYehrEilOQ3CtAailqTF+pvvCn5AMohjr0EYCijXs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZeHlHESj3XvgVC8c1SU6BvNsZBXHiD3OZ/e3rVYMbuzveSCV1wyoDi5S1mvADJY0x
	 y3iBOm62zXy7N8KiiokPunq5Rs2SRHa0FYwNyX8g8Lahrqfi4bwWKhvks5auptooAP
	 XQ4xUqcA0mA2vv+rWNsYvZudCHeVFEp520MGGrYP797DkjMJKd4vRTVo5gvXGZoxmm
	 1lW6Xfuhf6hE2aNmDp2X4zZys6v0hBT2zTX1NwJ/sEm+R6krAQPt3Mzme4yc8JIAE1
	 lnQTju7UCdCQT6992bIDC+1e0HwEStdX6RGwKexUTcWkVohpgXLqSPjlG3IOjUJtPn
	 lK+bdzoRfHkSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E557DC53BC7; Tue, 29 Oct 2024 01:50:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 01:50:07 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-gbpZiSZOOa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #14 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 307084
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307084&action=3Dedit
possible patch (v1)

Here's a potential patch.  This helps on the system I can reproduce this is=
sue,
please see if helps you too.

Also if it does help, would you mind if I used your email address in the co=
mmit
message for the Reported-and-tested-by tag?  I can get it from Bugzilla, bu=
t I
would like your permission first.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

