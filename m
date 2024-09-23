Return-Path: <linux-pm+bounces-14576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58C97EE9C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF130280FC8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A10F19C56A;
	Mon, 23 Sep 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRJIDL6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5879F5
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107053; cv=none; b=As2Ca+gBuGGLhrYkGTZ9jACEBFWcUMdR96yZIRlt94mAD31D1pUMK1OMdwKGV2O7Gq5rWmjrYpFxE37dML7mIa9eXm3zl/syflIGtB9noN1k8Z3C3aDYlQMEudkfbQmZUYwpPF/I8ymfxVMIIhwpiVTd/ouWZF/tc86Zb3xk1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107053; c=relaxed/simple;
	bh=xqZGYgrNHxEvgJYG5NDIAl5zuzxHGbdgeEAxPv1Zu9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n44pz4kQlb5ZvFN7QC2W7n38xIqgJh7svD4edJ73HCqXRFrj2iM1+YgG2lU3TXM/yateVgt2nQ1zLNfdJ3pEwihpjSyH293t6Byu0P1APJQKvqP0wNP/KG+L0JPxHoNB3uf9M3tCBnsXErgQgQvQI22h/9KKybqPnMGVWH+xH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRJIDL6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD4A2C4CED4
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727107052;
	bh=xqZGYgrNHxEvgJYG5NDIAl5zuzxHGbdgeEAxPv1Zu9A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sRJIDL6LdPBouGZIRxeOpxzsgacbjd0AhSh/oIoflPPgcBz5/qP6VPANZE+vHqpnI
	 yEIsHj+VMvfFZ3G+KKhJNxhr+5yZ0Tmu6Vsx4mld2VGprzo1RklO5u9tCjWdCmHWnB
	 PA2XMc7r8G0BfCsn3tCvlEk1sFuxXKFuVPhHk4V0xFkAZHacGFymST/LFGvJss8jxk
	 TtJBjJC9p+iNOY5Neb4X2Bpdb8D8oBfyyujS/eve6Xot5C0fiI6Z6b3sUPRpdP0M6t
	 4wAo0FEQ07NzFqQaJi1qspGGRtCzN41/C842+4cdiQ911pCrrRc/OV6JuRrtlxflwO
	 5+G5MrWut7sUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C5002C53BC8; Mon, 23 Sep 2024 15:57:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 23 Sep 2024 15:57:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zyldragoon@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-PO9WNJUyMQ@https.bugzilla.kernel.org/>
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

Len Zhang (zyldragoon@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |zyldragoon@gmail.com

--- Comment #98 from Len Zhang (zyldragoon@gmail.com) ---
(In reply to al0uette from comment #95)
> (In reply to al0uette from comment #94)
> > (In reply to Mario Limonciello (AMD) from comment #88)
> > > Created attachment 306844 [details]
> > > opt EPP register writes from FFH (v3)
> > >=20
> > > I'll re-open this bug to see if we come up with something that is
> > > upstreamable.
> > >=20
> > > Someone did some testing on another bug report and found a problem.
> > > Here is an updated version.
> > >=20
> > > Can you please share the kernel log with this in place as well as the
> > > cpupower output?
> >=20
> > v3 doesn't work for me either, it shows device or resource busy
>=20
> Sorry, I made a mistake, it works fine, the reason it didn't work is that=
 I
> mistakenly switched scaling_governor to performance

Thank you for all the work, is there a reason why it got error at performan=
ce
governor but not at powersave?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

