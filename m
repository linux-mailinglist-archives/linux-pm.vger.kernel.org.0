Return-Path: <linux-pm+bounces-14964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE998A990
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C801B28B39
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7519341F;
	Mon, 30 Sep 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbQHX5L/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E55192D68
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712708; cv=none; b=sLHdNIPh0vdMhmKUrgBO39t7QtiXuK3GuPLzkwDsyZCbSNmr7gSdMa7Eh76e3Ymt4G8lN+5EZZGPxk6NOy1xlxJ9fZGAfWjZ9oKZuBwRYHCEELpeNPtDletN3i9NizF9WOqoDWmweqd2hXTfCOty3DqADN4LQ9rCEr7dycTd4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712708; c=relaxed/simple;
	bh=ZyCCpQzrqqTQtr5V2iTiKMMhym52ckySL810ZPx6Bzc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7Xg/6f6gov+tFNMeC3esnWgPK9xUXl4RopT2sjMgIxnfVfunRBJs9eiJjoTOqFtxMxpCeWwWl8zUhlDL9WaHD/ZWLvEcRGWUq7fLnVlrj1TbllVJgPxibGhc6Wxkn9PqTEVhH5kdBrgOmPgpsg1G+FuYR8jb6sAvKwI/ti/LCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbQHX5L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE9DC4CED0
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727712708;
	bh=ZyCCpQzrqqTQtr5V2iTiKMMhym52ckySL810ZPx6Bzc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dbQHX5L/LS32XhIxeg43grtjLm24Jsz8b2SpNt3lXJCsyMWxNOpO04zbXmit75qNu
	 vQC39HoKvhIpVKpwmFE3BBSbUsi4fmNOdogD38tCeweYVI6sq5GWbBfi/GNtFC1pOJ
	 UxzjDdbRKgn8E4vGXQxSg+ECYPWO8j6+46XSs2mThTU8SjAJVHS2m8ezcilk1l3hRe
	 YZRUI8+z/b+NAvNv6nx/ZeA9ueUPri/UhS9gN75Excvsg1AN4JFRFfJW5jz2aULtDV
	 ndUR8kMrveo4pSUZy3bCUnP9Mex7icsjcXJJyRcDYBSQRD1A0t4/upyVG7Hj9Z42rz
	 tWR+KWNzEsLzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DBC6C53BC8; Mon, 30 Sep 2024 16:11:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 16:11:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-acuqvw2ePi@https.bugzilla.kernel.org/>
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

--- Comment #9 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> Didnt understand this part, in which scenario were you able to see the
> governors, but they were ineffective?

I'm confused by this too.

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
amd-pstate-epp
$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors
performance powersave
$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
powersave

I don't see any others exposed in active mode.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

