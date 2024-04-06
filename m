Return-Path: <linux-pm+bounces-5995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDD89A845
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50276B2232D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BA33C9;
	Sat,  6 Apr 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDotYO4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CEA2119
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367542; cv=none; b=YpA46B1cvUet9LFuucul3tzB1J3r1QDBIMsrq1+3DUKf04fVy8KWt9MBxYVxGZIHdZvXBK6g2I92G5tLpr+H687bIRRcvUfGm4tvXaqxrZdQLhqtM502sLfOLfPXNILrx+z3jOYV5j+8N574Wins3AFJDv6vAeB5aNQXiJgBmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367542; c=relaxed/simple;
	bh=uqca28Avno2ECKiqFECnHxidyoJHE7IjIGi5DTKgovs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0qMitbEkgdeLwcChNG6tGdXZjCSDmkha0rZXzjn7S2fPaHmdDxK7N1rezApLOm9Bp3suZAlWjDH4nIidDzs+SQjBmR7kn+Zxfc4GRs47f2wETyCddtRDIaCPUMOxrTLsw+GeKTLaPUNj0kQWzVkcuu1+MuWBMqQC1+PsawAP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDotYO4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF74DC43394
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712367542;
	bh=uqca28Avno2ECKiqFECnHxidyoJHE7IjIGi5DTKgovs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RDotYO4Hrh97aoeXvwDNTOMOM0q1Bd30kXzEl5CG3NXQK0R1iB6D8v4Q24T4xm2S0
	 W48uigalr4trJEmpWyNbMKeMF7EQg0qzUUv6l5lM/1BH+w4P7WEz33BZ9uSK12Yjfa
	 g3YML4VV7rcLrlgOyuGE4nvUJKXzV9eDMF8+vTTrzmGXe5XL/oXw5TShW1ayNjM5no
	 vg8v651co/c6GcJGOdCfWfXjyc+2ZFOtpQTjbgPrT2dhKRq5TFgzAzXakF92Zt3iOE
	 wbWj5feXGXRlSL+pxc5ZZoE1G17hw7FB0R8GAS+p8gH/O1/q72ZiQuQa4Bfn5Ks3qs
	 FuJeNXKgR5LPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9762C53BD7; Sat,  6 Apr 2024 01:39:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 06 Apr 2024 01:39:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-UJxJrQ3qAC@https.bugzilla.kernel.org/>
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

--- Comment #57 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
=EF=BB=BF
=EF=BB=BF=EF=BB=BFHello,

Thank you for your message. I am currently out of the office from afternoon
today to 4/8 for Chinese QingMing Festival. response will be delayed.


Best wishes,
Perry Yuan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

