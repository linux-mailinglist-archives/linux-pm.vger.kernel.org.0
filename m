Return-Path: <linux-pm+bounces-108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F47F59A4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427F61C208DF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F218051;
	Thu, 23 Nov 2023 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5/TcOwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D818642
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 07:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99ACCC433C9
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700726227;
	bh=lQbAQGTUU482se3DS9TOQN5wKWe09zhRkMW/S/TdP8M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H5/TcOwAvG2x+fOg5ZN8EGqSwZlffivKpfVQ2AFqPGfet5d3t5JrgCydNBiYhSlVY
	 rTxm0I0uvmmrCBzi2LSUdYo73U5r8937WQfGW77SKXjmBjptgznjgjeeacjyFL9Vy+
	 t15UayxH6DBmkzA4ZRlxCy1fEos4veOQeJ6dLprZ7sze6p3iP7H9VIEUzY7rvgRalT
	 YJW/3gLYFjaR/AZe+sHuFlVV7HBounaEdpcljmLj2djtDUdnCXpHmWjKQEM7/TxSh/
	 q5m+aloluZ5Gs7BPJTS78rEj1P7v+WSh1ubxa+wJ5ulHOK+lvAhBn/oKemM8nHQgmg
	 Ntymn7pJHXiqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7B890C53BC6; Thu, 23 Nov 2023 07:57:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 23 Nov 2023 07:57:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-O3GtBJnqr9@https.bugzilla.kernel.org/>
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

--- Comment #12 from Gino Badouri (badouri.g@gmail.com) ---
Thanks, if there is any other information I can provide or if you'd like me=
 to
try/test something then please let me know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

