Return-Path: <linux-pm+bounces-6025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7889B3D8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963AC28177B
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734393A1C7;
	Sun,  7 Apr 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZMegXuu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61239FFF
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712518884; cv=none; b=MB5amdlLu4FE3XBu2gdSBbYQdji1IEgBlo5hF5trytjE0k3DZFr1pSJA0WI5ut4i7dXEA5xvJCzbgQm+0ORjIZBJfDTN0+4LGz8LNxjHAYq54GCOmj+c6pl6XWrAd2JjU+gJmmK0AgbVsAcfXcsBeLCMpf5bQ3x8z5YsbGfz/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712518884; c=relaxed/simple;
	bh=pmmz0A+RB1ymGPdvQIzfac8vjixmGGCTiZfDdtLDJq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fX0DHHiLNi2K5B/GNLGpWhiehzeqG6k/kLj+SMFb9RKTMj8DOZvUW1m7Ne2xbXZOjIsDpnLuO/WGcAvc/XyaoxBs36UOESEcPbdfMpGBPZdeJYwgdvY8lF+bdbfqwEFyt9eoAim6jI/VEmjWPDkEwvHWeclvnsVTDJ/J1uEvT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZMegXuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6637C433C7
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712518883;
	bh=pmmz0A+RB1ymGPdvQIzfac8vjixmGGCTiZfDdtLDJq4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CZMegXuu2PFIdSCkpWIpdkfnDS8g+6jOMFjJD46DlbSadWymH/TVJfvXsFtyyL64O
	 i/Pc12Z0aqj3JmuipGgqVC4CdERyywPaVUTRZSDnHNRsmG7NLT1WD3/tN8/DOO+F6x
	 Cyt7haB8eDTEtgGvZLVsJCiFaAl9NGWFbs+F1lde6t2ihE6/E1vI7rvDxubGGzaOfq
	 tJagEVu1eUbUl5u0jVGukzHbYrSxgaS4ZGxdzlXvQ/W57IB9ZtiMHoo/tmCztmoSDC
	 s+OyYOJMSn/YhRSeL/fDxNqKPMuTdHSsyco8IWFwPeiLfdyMWauSyIgvzn3oobyXjd
	 4/AZd9e6RBZew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ABD32C4332E; Sun,  7 Apr 2024 19:41:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 19:41:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbii.chris@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218689-137361-rqpaV5MsV9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218689-137361@https.bugzilla.kernel.org/>
References: <bug-218689-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218689

--- Comment #6 from Christopher Bii (kbii.chris@gmail.com) ---
if there were* to be a hardware issue^^^

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

