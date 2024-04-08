Return-Path: <linux-pm+bounces-6046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E164A89BB71
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7F1C211C4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF045946;
	Mon,  8 Apr 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVnm8Wq6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3A3B290
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567805; cv=none; b=M42kuvWs00w489pfwWKmu1A2HFbmAG8y+ntmmgwbcbf/bdSMOh1ZE1v08CypsgTluqaSeVdJ1KnW8N8GoNRn1EaUcNQO9364E1aB8w4tdNQ4pAjd5ijmjsx/6FCcfrxbj4dhmRrmm6vPFDEDSj9v3ifN2N2S75w6XLD5zdQs/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567805; c=relaxed/simple;
	bh=L1Fn1pqjpM64JyH8tbtfUBU5bFgp1UKPHYeodosr/DU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tyOQ03IXTzgEIOgVb1MVA29lxcE0U0YgpMEkitqahhSyGuzPf4nlJensXQeo4+Gpu8ltXynWvZkNih838SnFobilx9ppMm0AOp0ITyQlukVNI1e2mCNphLhbMYPj8+jsSpeQv9UjmiKRehrRWeTFBKBziGttdX90afSKPQEJ9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVnm8Wq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5468C43394
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712567804;
	bh=L1Fn1pqjpM64JyH8tbtfUBU5bFgp1UKPHYeodosr/DU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cVnm8Wq6khBC60zAwgZeJOIk0mGpteTW7DNiYhvvJf+p4PjRz6/zoUMlXmAiEeKlo
	 XJPuYYq7LIg63cXjG2T3qNdNyr6pvhcYoImV6cc6LLZR47Hi3KrVE2/0d6oqb7Zyoo
	 2XpT0H5WCQhWYR5r393iQbCZ3NbWycPsx5E16jYfPl8e7ejdF6bD+UwtuIKHmdGlJk
	 nMySrvwjM3Sx19faOZktgwc5FV7uucfGZAmhIALJDgXdk8/hBWJTmOQrGDrf2oGfD0
	 3zoOP2hXHO5H99J1cAyCRyAPk+gVPNZYaLGniHYs/ltzl9cBkC6HzyjasBXnH/4A7Y
	 YW+rinxD42huw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3CFDC53BD3; Mon,  8 Apr 2024 09:16:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Mon, 08 Apr 2024 09:16:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218689-137361-pzuIubfMmq@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|aros@gmx.com                |

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
> if there were* to be a hardware issue^^^

AFAIK you're the _only_ person using Linux who experiences such issues. So =
far
there have been _zero_ reports about complications related to the amd-pstate
driver.

It may not work at all but it doesn't and cannot lead to freezes or sounds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

