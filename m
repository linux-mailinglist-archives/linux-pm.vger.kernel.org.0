Return-Path: <linux-pm+bounces-7223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053E8B4490
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D170C1F212C8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Apr 2024 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B94086F;
	Sat, 27 Apr 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC/pjH/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493F4086A
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199928; cv=none; b=PTwoMmp6cA3+C7ElGxSXU4ZWBa2CMZmYY6Fth+E11SIleYtnwLs/F5iYSD1N5wvoAQ/dL1Wq1vTZtXyLjSVBXcB+IwpMwVOZhaPQjOgYjLg24Eo0j7EU9Nxo8Der6ohUYkFwLTqm/nDjEuHCcQAetsy6vxCTpHY2noslm0xOc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199928; c=relaxed/simple;
	bh=4hwQ/ZwrJax3qDmsiig+pe2jRei4qM0QL92eLmVsDuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWzmDyWVw5J60iclUYGm9fb9P5PkvXfUShxQDqpXwKCYTuoKacS5vXvlU0SgEIaoycwjzd8TJFlwMv7BrGhkAvBA1qU/tSVvrnUB97Oz6pYNaWjpyhDAgkFcTEpLcftA6Nm+jhpXc7w8F8w+8KyKSGoTOEf+QlSf+AhcC47XI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC/pjH/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B067FC2BD10
	for <linux-pm@vger.kernel.org>; Sat, 27 Apr 2024 06:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714199927;
	bh=4hwQ/ZwrJax3qDmsiig+pe2jRei4qM0QL92eLmVsDuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nC/pjH/Uz4b6m6nO3tscrnM71r5QOT30B+tIMkwld3y753I30Bu/p+9gURPnkStnW
	 20F7pbFboyNT4/aj2FujHqDeFxhFYISjHz8rEzP5x8XENV++OMgb29LBJAZNQEp121
	 6X5G8gJb3eKOR4upu6ONyjcOvYELfrc9kWeupBTs5wriHtfwfXWpJ6lktCF7SFqyaq
	 8S4NXONLN72J7264YyIAou21ereGsezKyad8eKaqrL8mPjTT3bvjKN9jCNZBXMoOG6
	 /sNvFsPwHWAP3wuAyhrd/qapCzcu9wtOb4sHZvGEMunvHTrqskjGcvOk0T3Y2u1I+o
	 hn4EU1NAA5OIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4B69C433E2; Sat, 27 Apr 2024 06:38:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Sat, 27 Apr 2024 06:38:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-jeDV7FENsN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #23 from Andrei Amuraritei (andamu@posteo.net) ---
Hi Perry,

The driver loads when manually specifying amd_pstate kernel param. My issue=
 is
that it does not get automatically enabled for the system, as stated in the
first message.

The issue is why is not enabled automatically, if the hardware support is
there?

Thanks.
Andrei Amuraritei

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

