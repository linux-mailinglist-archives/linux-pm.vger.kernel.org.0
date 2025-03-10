Return-Path: <linux-pm+bounces-23774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D8AA59A37
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F416B975
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1522DF82;
	Mon, 10 Mar 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVmhpbcV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EB22D7BE
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621313; cv=none; b=X2FCPRy/kmszHgEMZt7nXK/tSCrKimzOtRFn8coOGjKHMbRmLFAKEeaYG+jF1ffH6mN6fWymieqSNpX0J8mL2odoQfjFRm5VL9fpVi7wicyYEnr+5IpyBHDhncH5PCJ98PxDQDe8u5jVhvMuGnU8oztyd4gTc+oxl1tlcJKOeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621313; c=relaxed/simple;
	bh=Y3dVrBlDfD1k8PxVjkFCwHC1pMGINA5lACQS4vrT8r0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJbGHQrbsAR4g2y7riev2wHhngNOJgjCGheQ/Y+jqVWHeGY1JUJizX3iKA3t8vQT268uf60JSVvMJKEXYiNGlpCRZiteEgVJrQTrvrcqessBGJfASI7ZV4XPPz4+omdoI845maRkzHpECl4CzH2vTHeggKF4ChkkAegY8A1b4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVmhpbcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21A8CC4CEEE
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741621312;
	bh=Y3dVrBlDfD1k8PxVjkFCwHC1pMGINA5lACQS4vrT8r0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YVmhpbcV/rMbAi8Yj4fBwHNnvm0VmTTOLwIxfiNMKWcWnq56Fk6cJjXgmVNCroQTD
	 oehcBPMJm7mis8F0W9nP1+/ehHLwIyzPXEDVzN/+sH18eB5xH5c2Bqv6S7HJlFi19c
	 c80cEuPSqWo1oiiy0VGWwpugi/BuQpPNYHJIQ6pnGQ7LY3V7F5v8ncq/q0cr9n7sLq
	 63pwxwSLmPckINxmOHLL3HxrstIXVG0rI7+8SgGwXgEOonB+JX7wJZxSFgxqpbfwmq
	 RoAcdJIkfLSNsnJTZ9oIk+MORApYcRAS4fS+eJdOKngbO3vMlu9tNrFl/nhrSB6aUk
	 QHityJtgzuD0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0AB9FC41613; Mon, 10 Mar 2025 15:41:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Mon, 10 Mar 2025 15:41:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dnaim@cachyos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219851-137361-aCCOJyqbTM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

--- Comment #3 from Eric Naim (dnaim@cachyos.org) ---
(In reply to Dhananjay Ugwekar (AMD) from comment #2)
> Hello Eric,
>=20
Hi Dhananjay,

Unfortunately the user that first reported this issue hasn't reached out to=
 me
since, so for now I'll give you information regarding what I already know.

> 1. Could you please give more details on how to reproduce the issue? which
> governor, amd-pstate mode (when the issue was observed), workload. Are you
> able to reproduce the issue on your machine as well?

No STR was given, from the lack of info I believe it's just a general case,
e.g. if you run `stress-ng -c $(nproc)`, you *should* see the issue (entire=
ly
speculation). This regression only happens with the active driver. Both pas=
sive
and guided mode was reported to behave correctly.

I can't reproduce this either because my laptop is a Zen3 laptop. It is lik=
ely
that it is limited to Zen2.

> 2. Just to confirm, does the user have
> https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/com=
mit/
> ?h=3Damd-pstate-v6.15-2025-03-03&id=3Df6c0b760290951688697d9debbb2b8462c4=
23a48,
> in his tree, it fixed a corner case in the culprit commit that you pointed
> to.

Yes, you can see the related tree
https://github.com/CachyOS/linux/tree/6.14/amd-pstate. It's not 1:1 with
Mario's tree but I diffed both trees and the only difference was commit
34562659110a42276d63f8b5a9d522d2400b2df2 which is from the "Dynamic ITMT co=
re
ranking support" series.

>=20
> Thanks,=20
> Dhananjay

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

