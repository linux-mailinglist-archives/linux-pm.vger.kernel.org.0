Return-Path: <linux-pm+bounces-13915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9ED972624
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 02:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A1284CE2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 00:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889333D8;
	Tue, 10 Sep 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OysG6TQx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD22FB6
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927694; cv=none; b=qw9q6uIY6qj8++z21gm1d5ryQYzN9N7EjKrF8uSnt+A+D7Nl28sLeEFDwTsrL0Yy74yax+JIPGrUdCzktj5ZyZvmTOsLVJWhFfggiIMxQYV0XFTN+uqqqmUQ68wQz/DA/huJGLmqkjJLW4/m8GU5eM17rcWGzjT+1xckBd5kb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927694; c=relaxed/simple;
	bh=6UsJF/yKl1eEar/4l3J7/mdS1zDrpqaYBG1QWgo7BEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqTzjR3DlKSUz6TYELGW7bz63H94EdHyEJBNBEvn0yKXtDG6X6PyD1Geff7tzd37+dMGGDm1yNTignGk0iceXh/LKZwdFM+bNUIILbIWe/1fdaLfvFsu0ytWSx7ILY87Bpdlsvq11yDZMXI1fsouSJxWcAoHjOp375y0U4EGtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OysG6TQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F5C6C4CECF
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725927694;
	bh=6UsJF/yKl1eEar/4l3J7/mdS1zDrpqaYBG1QWgo7BEY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OysG6TQxzdKDlOUrDxHwGUyeeTghbJjXlKspYlTC+hXqrrWPXwDNHrBBIYtTEtnZt
	 kJIiqluHFNoZraBGY9SHuz2KH+LVwypuTxMHDed78ECPRmJt8XSD7ypheeHg/aOWnz
	 iHbMINjYSj9CuwrPaKnDvbInQ40yrlWFRsLqkIcg+896tabLWJRUvZSBghZbV2qOiw
	 ixHMhRdHsSdVYsKXexGTWASv6mGkJ4HdzbqOV7vu+1npYciUbA3URLceChmEKNpBAf
	 aK+1rh0cp/9oQyaISVrjol2D5lmfSWl2Mxos8Mn4O5GBO7byxFpcCel3fzB6xXqy6e
	 EchBp5uwGEvVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 28E76C53BC4; Tue, 10 Sep 2024 00:21:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 10 Sep 2024 00:21:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-D5Z6IM0MLG@https.bugzilla.kernel.org/>
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

--- Comment #92 from al0uette@outlook.com ---
(In reply to Mario Limonciello (AMD) from comment #87)
> Created attachment 306842 [details]
> opt EPP register writes from FFH (v2)
>=20
> Sorry, posted the wrong version.  Use this one.

v2 doesn't work, it shows "Bad address", testing v3 now

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

