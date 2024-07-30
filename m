Return-Path: <linux-pm+bounces-11725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D4942377
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 01:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7F11F2497C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6C1922FB;
	Tue, 30 Jul 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKltvJ2O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A381917F3
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382703; cv=none; b=DmFGURZ6E6cpaGJr1bqYiEKGWC9X/Lwm3q9Coc+wlmmkpXE/gXR00bUJ2uBQFD3UWRkrPCUTc66kDzx6lWjGvRKz1zTyV82uNVwkKz5eJ15Q4879M8VEq4/vF/pIeQ67eSopYPWU1gloRwO51KmdLoxXv9VxYjh4uOLO7u+Y+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382703; c=relaxed/simple;
	bh=NqOgG/LaFSHaaitoTkQlB+zakuO3edoTNDNxL7t39Oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AyiDohgYL1+cOTdOm5wEPB9cPt1dDoRGF+UXcVnxvYF007fl4fv7MN1p2tsPJ5GTNApMNb/ebuSOYDhFb/id65r5e8OQKeID0G1J7U1rj65rNI4yuF+vZEtbj6t0pSAhrmVOKszZJwsCNI9te2fD6f2ENLRL7Vz1CLkvirjYR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKltvJ2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20832C4AF10
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722382703;
	bh=NqOgG/LaFSHaaitoTkQlB+zakuO3edoTNDNxL7t39Oc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bKltvJ2OgNfJa/uRTWT+Z1//c7vgrQyZmoSgw7o47Mw09MrB2fnZGgOSkkj+Nnvdj
	 n8STjRFvy4gMA//dZTSlw92B/N7VhxIMYS5pydUoEWVpn7lfvWyHatIdNnjfq9Kmyv
	 SKUMrCxQ4upiBSm2lfg6gIGos0rFlugBbdziNb4LmOdmKEO3g/+JwrT98/34hzOPCI
	 oG6iqRjvliPQDL9xQ8ZY168NJQTb+EhXmE20xpef1hGRSDKMb2o6VaNhbBLc+rYzOS
	 zzPqIC2AI9aMxQy5khhq4gdDfxsg+I+dm6aOul83PrBwdM5smZkhz+kZiDrCG0A05/
	 6ZOubFCDV+lZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18478C53B73; Tue, 30 Jul 2024 23:38:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 30 Jul 2024 23:38:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-qtzafOrdbD@https.bugzilla.kernel.org/>
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

--- Comment #61 from Chema (chemasanchezgarabito@gmail.com) ---
(In reply to Chema from comment #60)
> I have the same laptop and also the command outputs are the same.
>=20
> I have updated last week to the last BIOS version, but no changes I have
> seen.
>=20
> Is there any updates to this?

Also, if CPPC is working in windows why it cant in linux?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

