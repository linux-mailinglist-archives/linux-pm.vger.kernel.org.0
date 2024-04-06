Return-Path: <linux-pm+bounces-5996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D544889A846
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38304B2251D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8BE4C9F;
	Sat,  6 Apr 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp2pG69k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9233C9
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367824; cv=none; b=lCWqT/i7ZLC2tU1QI36Mka6BLF/ACTz9GXfRDdwqbOTIbG5VYe2Wap2nmRX6ecEsgicwqyKCeEutEKHo99lNspt81TNvzErfbPR/Q4tDqdmWe3tqZTCWUSkMwq9AdOiFypA+fPjH3TqsDJwVX4A0A/Y4LX/lfI3i2bVYBpYGHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367824; c=relaxed/simple;
	bh=QpiehBBXLUyylvuL3QcZDWCxWeDCC8hyWB7hRQNL6AA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAfuk3wYwfibYFf6bQBmVYdgYO5HIT9k68gyyTvhbUkJ2y/2RXNmqYVXrIxzOcJG2PMN4wnUfOmykIALvcZq/8LGKDVCz4X1xeQs9Dl6WqCSw0JLRfIZvq4ZZrnm4F/k4564CNRyfp3zeJlaDj0tYmxubpg1h6QT/YxpOtFrnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp2pG69k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8E23C433A6
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712367823;
	bh=QpiehBBXLUyylvuL3QcZDWCxWeDCC8hyWB7hRQNL6AA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tp2pG69k1N3cFWZIiMdpMewgv6xemi/UNjOg1TX1WfrZCcE060z/PT3lpXxwAuFor
	 IsSNSlHovKjAY3i8zjoos+A7LWhYUk8dzEJlzApSYASLSEG12CVsSsKzHtN0S/Pik/
	 jc6V6BFy1N7OpJv+w/eDHhSBhxL0GLO4bpcnqxo81CCMLmCnOE4TzzEsjEszED/eam
	 lnnNRMGX8tcVq2DOnv51kaYNSCQKYpx4W1laRd9eHYz8vfaxl2dCyF1ZdOeyZArB9w
	 H0JuiE3N+58RxNymmiSXjhJ13seeCJuSMzoJtfwFG3LHyYu+/0iNzf8dyGEafCWP1D
	 fykR2zZN/B82w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CCA2DC53BD9; Sat,  6 Apr 2024 01:43:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 06 Apr 2024 01:43:43 +0000
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
Message-ID: <bug-217931-137361-A3wC2AbC5Y@https.bugzilla.kernel.org/>
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

--- Comment #58 from Artem S. Tashkinov (aros@gmx.com) ---
Thank you, Perry, there's no rush!

Not the last question, here's one more, I wrote about it earlier.

cpuinfo_max_freq is invalid for multiple cores here as it often reports ins=
ane
values:

$ lscpu -ae
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 5137.0000 400.0000  400.0000
  1    0      0    0 0:0:0:0          yes 5137.0000 400.0000 1394.3910
  2    0      0    1 1:1:1:0          yes 6080.0000 400.0000  400.0000
  3    0      0    1 1:1:1:0          yes 6080.0000 400.0000  400.0000
  4    0      0    2 2:2:2:0          yes 5608.0000 400.0000 1396.2390
  5    0      0    2 2:2:2:0          yes 5608.0000 400.0000  400.0000
  6    0      0    3 3:3:3:0          yes 5293.0000 400.0000  400.0000
  7    0      0    3 3:3:3:0          yes 5293.0000 400.0000  400.0000
  8    0      0    4 4:4:4:0          yes 5449.0000 400.0000 1381.5620
  9    0      0    4 4:4:4:0          yes 5449.0000 400.0000 1393.0980
 10    0      0    5 5:5:5:0          yes 6080.0000 400.0000 1383.3900
 11    0      0    5 5:5:5:0          yes 6080.0000 400.0000 1397.3979
 12    0      0    6 6:6:6:0          yes 5764.0000 400.0000 1397.4200
 13    0      0    6 6:6:6:0          yes 5764.0000 400.0000  400.0000
 14    0      0    7 7:7:7:0          yes 5924.0000 400.0000 1396.0959
 15    0      0    7 7:7:7:0          yes 5924.0000 400.0000  400.0000

5137MHz is probably the best my CPU cores can do. No way 6080MHz is possibl=
e. I
wonder if you could fix it. HWiNFO64 reads maximum CPU cores frequencies
correctly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

