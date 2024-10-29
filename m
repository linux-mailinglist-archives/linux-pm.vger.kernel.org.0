Return-Path: <linux-pm+bounces-16661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB19B4B97
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 14:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC34C284F7F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7C206955;
	Tue, 29 Oct 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hspioops"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671A206049
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210386; cv=none; b=rpnqjUc+PXFOEIYztbGdLFUuplR1eWilacEiyZr3Juq/lVg3TUUXxXQlB7bHYMdpSb0ROq+Xm73YpMpMoYCnjkaa9VJ2XIv8Av8MQ9iEQpkvzRyhCJkcHmtjpSfpvu5YviNWfHyXdncsHwx/ds8FvuMpwh5eIDFOUnTRFTN/f3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210386; c=relaxed/simple;
	bh=Mj6CJ2BsfrawTHo/6/cHPnuX0QFKQ5EUbjFYjj6k41g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgxH5tvi15OGc4P+b7/LgdMxd5hJYmX6gvfhe0DiaTRxz8gmUUr7KL5YdG7HnHzBt+TR3RT1jmuKuKrHJcyjVMzp1SUIudJZiuzyjd8m8IAVEx8Dqq3YYcG0j7KQBz6FbP0wn/Hv4I461DRm6fIbM6KOSSFedfC2yud70rN/8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hspioops; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 449C7C4CEE5
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210386;
	bh=Mj6CJ2BsfrawTHo/6/cHPnuX0QFKQ5EUbjFYjj6k41g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hspioopsgg9WC5ntnwdEXLmZ/gcJXGJvbij8VBAPBrm3nWQcIS8+EhrpVj1GtI7DG
	 EWhNj79WPlos4MI/PgfdIjxp7szN+GquaNiblE02nUByhVXpSI8RaHe+fSyXyASQYW
	 MZg54OjdyEt2TeS6vQZ4Wf0fNXVJo50krRWsNC3YA3mPy+Kjphuy3Mxy8O9cGK6jUq
	 CCT2UVajF1Oi1akTYXkIWdpEy140fKGP7aIN35jxkAE7qZi6kKgg48mehrW/8TuDnY
	 kGLSmbOemcZUDoggygb1mIaZrnjafbvji2n2wyb9imJVzgdO1W4V6cAT8lSWMGAM6o
	 BcEZNSRYi97Qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 35427C53BBF; Tue, 29 Oct 2024 13:59:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 13:59:46 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-wDHyvxnHFe@https.bugzilla.kernel.org/>
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

--- Comment #17 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Thanks, you can check whether the CPU cores are reporting correct maximum
frequencies.

Can I use your email when I post it?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

