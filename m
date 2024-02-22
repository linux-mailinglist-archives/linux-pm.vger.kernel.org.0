Return-Path: <linux-pm+bounces-4282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25785FD17
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2381F2169A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138614E2EE;
	Thu, 22 Feb 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzeRbzYQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB239FC7
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617161; cv=none; b=Wlpl1L1rdP3EiO9lCpbVK0TJzRIZTquK8mJK+a6lQavkEpgdkLTD5ttBLBhfJ0J4STsYFMC/r/hLQTDHyLKc/4xRaTLFPfqfF9c6Q8wdLCiQ9hgcQkReF/VdqyRcId2MtiBMcIWTY6dtknFoRiOX/bOCjK1QTbm0EO4rPD9Ue2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617161; c=relaxed/simple;
	bh=MS18MXrqafvbjY/H+3H1R6O1z/hhN2V8G5YjgVKYAho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9ibW9s2YaUBbyx8bxOV8ePA74KOs25v/JgIt84no9Ycx8zinDaglG+PFH0pEw5UR+AOsm6wSURBaqvZOSrlrZ1Pg9P7ZVwRV8qAZqEaN4Xa08TktNgh+X7cFmBsp52Lbz0HHhSGQyhokdPQBYgobn39IYKYlM2tPPL4h69+dBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzeRbzYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B26B7C433F1
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708617160;
	bh=MS18MXrqafvbjY/H+3H1R6O1z/hhN2V8G5YjgVKYAho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uzeRbzYQ3FrvEAt2NvNB/6V2ZZpIL2/Wr6v6/F4NJa+8FaoJogMqEDYecmZp5mLLe
	 LYuuMN5L/uvmMFICq5KJq279IRkbIg1hH6+QSNn1t9k3o/+bj2OW/1Kp5qiLa/ljqh
	 xmDGY4MHEc1m3F/W0gV7u1tAfbuhBt8tuBYxf/ns+ZZ9aK3JWeZaehYcxgI2vg2Q8O
	 7DUOUWpXQ4bBzFk5wq6b/ewpB0qc4VbGuE90DWKqPekGyWdpHAKj8/EvX0lDiDfOn3
	 2Ev5++4bYrEUZF/OZbt6xBqE+Xy1+tVeDPv2kMuHJscjjtdBPn2yIh/O9PUitiql1l
	 wLoPzg+UCFkFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1D24C53BC6; Thu, 22 Feb 2024 15:52:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date: Thu, 22 Feb 2024 15:52:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tnifc@protonmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218041-137361-zj7VEJif53@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

tnifc@protonmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #7 from tnifc@protonmail.com ---
Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

