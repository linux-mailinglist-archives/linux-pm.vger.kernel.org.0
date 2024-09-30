Return-Path: <linux-pm+bounces-14957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F398A91C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D316EB20989
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D818FDD8;
	Mon, 30 Sep 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkyhiroV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D708189BAC
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711417; cv=none; b=r8jaWZC+c8o0Y3iqdtE/CQE1xPnrcGEVPe2ZglhePy2brb5HoWwc/mNluHhpH/RCciXEBBIPkXC2bUb/Ss6CclK7X3c3b6anfLr3nw5PLI5KlRiaR/ewbsZGxo5onA+WqukM2WBhcTdnp3b3a7nSZ0D24vbz/gd+H0b1Csghdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711417; c=relaxed/simple;
	bh=ReJxlgtP/l/k2GkQkRUJpsis4kHZQLW3D4Zjf/lTbr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iw5Uad0v35ELD2Vfl4hvwBws0T/0OR007g0KuACLgGE0Pz8HYSTPvN3O8gTtZuYurzYbwNTlhwir3vmJJ+jnciPny80EdtexSRZwd3ee8ewyOyvQqg1cmBiqFEGDV29dKvhsoMBc//xWDRC2Ibg7j7N+MP+MuJg0kE/80X/SeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkyhiroV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82FDC4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711416;
	bh=ReJxlgtP/l/k2GkQkRUJpsis4kHZQLW3D4Zjf/lTbr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gkyhiroV0M1aiui2NrN8N/gccQa4K/7XKMl1Fh4aRlpTBzvyDGNfkeB/eLfYLo0oU
	 RGfe+FptEv6QvePg7VF71vE/BrMzqKz/uVxEm0DmNsVQBfCgP9YdpL7oAbCYgZhfyx
	 EMwR+QcrOoPhlR9kWtbKJDZhpwsy7GXm+RiAgweaWPduHhir+l8O2e03/YXkpmMIIG
	 gruKEfpo/OWZON/fmYAYgX5mSsCpRLktnmu0HRwwtAt9cfjsR6gopuDcPNEtxDearG
	 hCLRs15ksLVNC22qlYlPtHb1QwtqOewC3zTJRghI5cc7/mH4MemFhnwwTPWDYqCzU2
	 cMN8IMN8HlorA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3C3DC53BC2; Mon, 30 Sep 2024 15:50:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 15:50:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Dhananjay.Ugwekar@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-j2bnx4Sicj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #8 from Dhananjay Ugwekar (AMD) (Dhananjay.Ugwekar@amd.com) ---
(In reply to Artem S. Tashkinov from comment #7)
> (In reply to Dhananjay Ugwekar (AMD) from comment #6)
> >=20
> > I see from the attachment that you are using performance governor, so y=
ou
> > are limited to only performance EPP hint, trying to write other EPP hin=
ts
> > (power/balance_power/balance_performance) will show the above error.=20
> >=20
> > You'll need to change to powersave governor to use these hints. Please =
let
> > me know if this fixes your issue.
>=20
> That's indeed the case and changing the CPU frequency governor to
> "powersave" has fixed the issue but I wonder if you could log an error
> message in dmesg if the governor is incompatible with what the user has
> requested.

Right, this will be helpful, will put out a patch for this. Also there is an
"energy_performance_available_preferences" file which shows the allowed EPP
hints that can be written to the "energy_performance_preference" sysfs file,
you could incorporate that into your shell script.

>=20
> It still makes my head hurt trying to understand the interaction between
> classic CPU governors and energy_performance_preference modes.
>=20
> From the testing I've done it looks like classic CPU governors are 100%
> useless/have zero effect in the presence of amd-pstate

I guess you are using amd_pstate=3Dactive, in which only performance and
powersave governors are supported and the decision making is mostly in the
hands of platform firmware.

However, if you use amd_pstate=3Dpassive mode, the OS governors (schedutil,
conservative, etc) are responsible for making the frequency decisions.

 in which case I don't
> understand why they are exposed/exist in the first place.

Didnt understand this part, in which scenario were you able to see the
governors, but they were ineffective?

 Is it possible to
> hide them? Make them read only? Just to avoid further useless bug reports.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

