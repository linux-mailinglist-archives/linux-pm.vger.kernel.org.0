Return-Path: <linux-pm+bounces-14902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191AB9895C8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB11C20CA0
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73841EA6F;
	Sun, 29 Sep 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBdti3GR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CF33F6
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727617851; cv=none; b=acl1nhedfmmfi26kIWbnwSlvqWz2wPC0CHnfyYOJWuRMpMUDtqw7oeTWIluNgmcexx90aYKAxOVfPm387LckBBL+GeImDt82OX09KeT5GnF71merGBK8YmMW/EIyN6NzeA0Q++pwYUBvW+LPZBNTgPQ+jSxm+F6pH6Kme43WyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727617851; c=relaxed/simple;
	bh=AexTVQfhaKNIAzUTfgWG6UMtkojcuD/s1NIsSM9zvrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKqI8yxDh3JGaui6Ohz20eI8IVbYyCdDUQramc9WBAQd1hB2Mup5/4QQwq0POyFtxtrnx3HglXtLRJApxrhD4r6PukWwxnBVz3s5f10fIHkfS1F+byO+H0IrRLt63gUfaplFZ1bjg8lU6Au2AV+i7y0rigcv15Dl8+04NJ0YYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBdti3GR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30254C4CEC6
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727617851;
	bh=AexTVQfhaKNIAzUTfgWG6UMtkojcuD/s1NIsSM9zvrg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tBdti3GRM6USlAsXArj5SiKSrrCCMnWHFlhKUNswE2czDEFnJ8q/dOYOvuNr3pDKz
	 g2TnQ+rsrhGNmN9MCb3bkYgae0LCTTDiVbOpYVMP+npV5722Y8PBa1b1ioQEY4lZHC
	 pr2LnAg3JCZWockHegauRzNixQUh1hwh6SyaUXhj/GBtS9Ad9HpqhXi1lTW5+ytDI/
	 aMJ9WaQGnJC7V+KokLBXRfW3UBqOrcn5R/1XMeJEiZpawFXZKJpcurYrioavGwSOHn
	 J2cDmOeirNHTD8ua0HShFP5EEXCnVKtjTG1E85RI5dLGkEB/BLhaV8tQ2S2eBiq89I
	 KaouGA6IA2S+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F0783C53BC7; Sun, 29 Sep 2024 13:50:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Sun, 29 Sep 2024 13:50:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-Ta9kxQ0cDm@https.bugzilla.kernel.org/>
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

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Lastly,

https://docs.kernel.org/admin-guide/pm/amd-pstate.html

Doesn't specify how the driver can be completely disabled.

I'm now using initcall_blacklist=3Damd_pstate_init amd_pstate.enable=3D0 bu=
t I'm
not sure if that's correct.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

