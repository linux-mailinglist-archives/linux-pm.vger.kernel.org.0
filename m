Return-Path: <linux-pm+bounces-2517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278518375DA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 23:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA231C2407A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FF482F1;
	Mon, 22 Jan 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ondZYwQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51797482ED
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961349; cv=none; b=pdAZ0mUX0EGATqOULQ5wUGbg/8TpPfxuPBe1YPCZXZGQ35eXJaxReSVnQ6sFcU7gxuhda3au9I40cowhJeoqPYAvbGCqGuza0uCK18Qg+motDyLw6lHh5XJMaM5CHZuenKkIZNKvj6GvYT2VpGZ6hQJYnTEs50Sy4VGE+9ns0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961349; c=relaxed/simple;
	bh=MehpmSM/dt42BovD3aa2tY5K+tKGyuuTzWDr4Nngq1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2nykwyWFOR9+SfkYpynQ+aqpxWedW7awhZ0QcpUODn2j980psVHOfusNcxJGTAa23ACU+9X+4mgVEFsxZ7K5kxhx4E9L3ykw9vAp+U4HeA2o0zsIzoEqizS5a5nSgp+OBa0izBjTYs1p2yUa8fquHXWc0i7r6YwqEDuB7sDNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ondZYwQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B575BC433B1
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961348;
	bh=MehpmSM/dt42BovD3aa2tY5K+tKGyuuTzWDr4Nngq1M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ondZYwQM8/4zDw8Mddi1UZToIieSCL+kCk7FDOokkxB132bBx36a99Pcvn+gV03cA
	 yXHOsbgZfleRlssgUjplw9YvW2NcA8tGhHXR2vv3y3Ahg1kRLj+dg5Lb2ebJ47TN8l
	 HKK4Ref+/SscHk7/qb3TbqUGeKhRsSGX9uS4AeY+1fvRebHDGS2VmrGeFS/aaV2Vby
	 cEwl0nMaapSMR+iktn4kqvFaJKMtXAkqCXSUv05LKCep+hYKbF7hNB0IWtfrjd2CJD
	 DnOCKhTGd6oehZ6dn+Kf1LZJ2drhWaL+yAYwo21uDzmomEkbaNeQ6fc626pyPDJWoN
	 D2huxGkWyCCqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A55B4C53BD3; Mon, 22 Jan 2024 22:09:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 22 Jan 2024 22:09:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alessio.disandro@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-0c6io80vBp@https.bugzilla.kernel.org/>
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

--- Comment #33 from Alessio Di Sandro (alessio.disandro@gmail.com) ---
Created attachment 305746
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305746&action=3Dedit
HWiNFO CPPC order in Windows

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

