Return-Path: <linux-pm+bounces-666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49028802D23
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 09:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BC2280B98
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DE320E;
	Mon,  4 Dec 2023 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mutOpQUW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAFF9C8
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66170C433C9
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701678639;
	bh=bxmp7wrT5DET+In7hamOE1Lm4mT7eHVJ+Blt/nbzers=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mutOpQUW1+IC6tcRfWOfuNd51a/trNdLaP1FZDfFZfFo8oNaXw4G1f2nUuKPUGOY7
	 lO7soBQgnbEvFKa5sMBmWG19dyBcV/j4dTr2Sfs42Ie64BkdiNhgYBgpSdCmHMBVj0
	 kfB5NPt4QB3ivx64Coxb8Cz/IzeHivTNpFPfDJ7ZU/rG5bD+5TVksPV5ivXQ2CUaPz
	 6SHyiiFB+1nEmFDomQkxldopnEmF/raHhqUH2MOKigZERxT8Qt3x1JkkIFmiRTf9MY
	 k5d+tGzPjoB9a7PCJenRuUHYUEc9QvOvrq1CQnncCcX3WkeQPnznktHi/nR6wK1QQL
	 Eem9ri+DORoQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4CCDBC53BD2; Mon,  4 Dec 2023 08:30:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 04 Dec 2023 08:30:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-zDctqBntw5@https.bugzilla.kernel.org/>
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

--- Comment #16 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Yes, I understand that there are some different vendors shipping the same C=
PU
model, however the BIOS releases are from those vendors support, I confirmed
that the CPPC spec mentioned the CPU can support CPPC interface, and it dep=
ends
on those board vendors feature scopes as well.

from Gino:=20
> I have the following in: Advanced > AMD CBS > NBIO Common Options > SMU
> Common Options
>=20
> CPPC (Auto / Enabled / Disabled): Enabled
> CPPC Preferred Cores: Enabled

Gino said that he can see the CPPC options in the BIOS setting, I would say=
 it
is very probably a BIOS issue need to be fixed by vendors.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

