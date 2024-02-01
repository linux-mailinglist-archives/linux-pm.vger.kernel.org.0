Return-Path: <linux-pm+bounces-3158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E778456EE
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 13:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ABF1C22348
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E879160870;
	Thu,  1 Feb 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kiaq6h64"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70415F330
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789160; cv=none; b=sQVQaLjsUmpkFjBAUxrXoEiczv0RhBZ8kRPjuPYzR8kkrE0aMuRpy23bXaNq9wPL//cF2OJY4EZyX5rq9TJxUMhm7DAFPmtafXpKEXc+ZFGhkucl3vw2ISWsB+DLoG/rDLtPlGWraGqq14yGMZW51WEW6EB85GZofVbPm7yGQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789160; c=relaxed/simple;
	bh=UyzwoXkgT2uYw2PzWhuQ2amTPi9dBEaRHA3Vx91d//w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddbzHgdcCBP5MSCQwsTstNb/s2SNj9/HhD6QJrHR0ALQoGAuDKKEHvaCPlCh+SSutXucqtjwYlr2cNg4BBLE7TumZvP7XbMsqEUhnGDYPxjh1doqflDJUseLdmTXqq9UoPhkf12/qccK4ZzK18tLwMiWpRlhClU9cuFqYpNWGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kiaq6h64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 641AFC43601
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789158;
	bh=UyzwoXkgT2uYw2PzWhuQ2amTPi9dBEaRHA3Vx91d//w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Kiaq6h64UG/o0WVKaJdyMzenN0rtGnSYdUJyIqXrcsd8OZhXc/LZlApVDx7I+UHGJ
	 knCkFZ5Ifs3OBlo7I9uzBkg8WlNs9KRR4PF3ceGQY+FSJyPseFMYRlowv2fOaTNMti
	 pvqy3cgDdozg9onLHcHR3sm4bmkX4x/Qv2mC7dW7NVNLqlf/yJFj2KVU7Xq3t4VMYj
	 MgNUpHaJfjireja+qzw0UzzlwQHfyQwv4VNW6xu6XMVzUYPO3mYBSiud5gjPtQBdB+
	 WT7u/8u356qPgCQzhVIs4rqzEMA8+0zz3DymMqP2VwOfD+9sPtqxFG7cQW5dPoW5Vg
	 b+S+wX1/Sm2Ww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 564F0C53BD3; Thu,  1 Feb 2024 12:05:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 12:05:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-n4zUH5btOA@https.bugzilla.kernel.org/>
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

--- Comment #50 from Artem S. Tashkinov (aros@gmx.com) ---
And just in case:

$ cat /sys/devices/system/cpu/amd_pstate/status
active

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

