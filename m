Return-Path: <linux-pm+bounces-6154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398EF89EB5C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B5DB24FF2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8613C831;
	Wed, 10 Apr 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS4EJk7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEA31758
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732556; cv=none; b=jFma0RSBqlveN+Ph3iRDQ/1w8tOlEnNXXT70zvPrvVcfOoyPYOmXzN1AJNE4tfx8Woo9hRGwofOjgVP7553f0O41hLWG1jNYTCi8BJ8/vwm8ZqZz61y2FRMqKzdi31tGn+L/vnVhNa5t2LXvj0Tb/n+PI/GYFIgGAmPGx869JgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732556; c=relaxed/simple;
	bh=LHK1fKga/bQuPIZfi1Sueduuyqez7Yr403/IHgg5jSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cK0ksQBfsP0akyyA96JtWy9D/4s349Q+Ae3dXd1zh/Dx5s72xr9I+WV/V+gEmF4eCGZrbyh7n9OCIgiAMxmuQEtCbVZ94vXz2/94qRfQH2XhGmxcYaxAkOmmFyNfuVbVlvgndSuFRU8msZnRbX2KauuhTpFaiPkDBb8/+O9WaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS4EJk7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E0AAC433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712732556;
	bh=LHK1fKga/bQuPIZfi1Sueduuyqez7Yr403/IHgg5jSU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HS4EJk7iierUc+GdHIVYHFoCF33trzYYRF6gZCm37bOxSNFt1C9I5BiqQvzMw5UrS
	 hMWdTeAUwyOARoHa/VaT7JmHY4C3YLnB2eN7Hl9Hh6yXSfgJGiu8Hmb8psmSqcjfQU
	 Kckgrl0/rRRZtLY1KDcWm7Oo+aovogf3fxhSpoty8hfwstX84i42uXWQ0f84VqEpty
	 QE/k+MoL6SJar4iifPplowWWxgYp48wtvs6RSP47RaoKcpAceXcDsjIIFQCAjUvqXL
	 U5HN2JXWewM0VJisaT/FsHZS3561UwrLoJsAlVe//5neQEPH2oYxWLlIsch7YCuJLT
	 LEumNrXs+tbwA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E059EC53BD3; Wed, 10 Apr 2024 07:02:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 07:02:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-yidRVo18VO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #19 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #18)
> I guess all the OEMs should provide the option to users,
> just need to find it.
> How about this path?
> Advanced-> AMD CBS -> NBIO Common options -> SMU Common Options-> CPPC

No, they just don't provide it, you can take a look of this picture.

https://www.notebookcheck.pl/fileadmin/_processed_/f/9/csm_bios_3_2616b186e=
4.jpg

original post here:

https://www.notebookcheck.pl/Recenzja-Asus-ROG-Zephyrus-M-GM501GS.299168.0.=
html

Though my BIOS is slightly different from that, but they still don't provide
that option.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

