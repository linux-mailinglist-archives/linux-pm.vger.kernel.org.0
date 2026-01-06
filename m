Return-Path: <linux-pm+bounces-40262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE8CF6D63
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE813017F19
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C12EBBAF;
	Tue,  6 Jan 2026 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nalDx1NN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114812C0284
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679195; cv=none; b=FGQ2EOkdrI4zx/J2mhBbZFboWGMOZtiuk3mXZDO6ss8+Bt1Nu2h6yS09NIgAsZYNEiZDUSqrtaronf02JoWjXqVAThcDxuPxES6p1I6DEKJk9FenjEU4Lpv2rg8Sb1XApNG6R/FOJv3WuVUWq9LBg9sWqCP8cyoSvaiwZKJYF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679195; c=relaxed/simple;
	bh=0uCabCrEuD5gLKTnlNH5GcfzKN3W86y7OFjxOeDvLrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GW5j0Kbn1q7V7lxoX3a8YQzDpGCRvsbs6w+VjTwJnCk3qIqySrPg6mtUdMMDANnpSbUEc7Kmo3HsAJfaoLsyl5xE/8vRUKzjUbO0F/0E97Yp5oeumnC25apw5+omjuSTfqKcp+2L56J3FFb6KgefC3LQb3vwfu0feYY3LcjKiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nalDx1NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 919DAC116C6
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767679194;
	bh=0uCabCrEuD5gLKTnlNH5GcfzKN3W86y7OFjxOeDvLrM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nalDx1NN6Tpjs4NPvPYGRVNAqlh+/YVLnq5ehpmdzNHsmMHPKbJqxGO1BEwdMFWFy
	 LgJ8K1A0YukJh8ODKDASBK8RxAk75+tFWFuOYTdotdoCn5oGwEh0YXdr+Lnx7kLHDF
	 RGTjtBrLpj4TNc72g7QibjlMyzI2drelgJRkQrAtOzS5c6Npmjc2FXw7GpaXb2735v
	 ZP6pEVjIHlVImhT8FvJcFpxWgs3mpFeoFvrbzmPsyYt8gYGHdctBzP40s6fUWQ5k3G
	 +SALWu9OmIUdCEdU+apYnFQYGTazSDRj/m8do2LcvHgFnl540xDQVjrBCDzJMc0mtA
	 3ZyR8EOhrmQsg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83F9EC41612; Tue,  6 Jan 2026 05:59:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 05:59:54 +0000
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
Message-ID: <bug-220946-137361-eRPdsdCQvX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220946-137361@https.bugzilla.kernel.org/>
References: <bug-220946-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Two things that can help figure out what's going on.

1) Can you please boot the kernel with dynamic debugging enabled for amd-ps=
tate
and share the logs?
2) Can you please share an acpidump for your system

Also; I notice a really really old BIOS:=20

[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X570M Pro=
4,
BIOS P3.10 10/26/2020

By chance anything newer you can apply?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

