Return-Path: <linux-pm+bounces-22231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D2A38C24
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA6F16EABC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D20236A63;
	Mon, 17 Feb 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZfufp2e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4B23644D
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819574; cv=none; b=Bxm/o1LxzA3le1SDPzJGtFAqQS3vCErYaszFsTeYu+XmuKY0f+IbdBKIXe3WeYRoahwUuUQIVGsqQZSbiZA0aRGJ1KHtdCF2jZJWDRxSyd/6/P4hwO6KZwuVHv5N/XLIkvxbBkL0IV/uMjr+EI0JkIAeJUwsxSs9SUOuphhsvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819574; c=relaxed/simple;
	bh=i+OJSnW+SS9nZcSML2OAoDsD7Ipre2DfGGVGNr78NB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ame+y84jxuS9bnRWmBQN0h7mPE5TtbK9NnnW7tiIjonnsgxIMXsNpSqrN/1TDV55sb6kQBE/oTZ1eJoR4JbNDOGv6zyw0xUs4mLAMcgmuJxZCuqz/W9B2Xo3oYSPQkpUpVJV/x/+MtYpKZaXwnBcFCfxjuXYq04BP1A94OWdz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZfufp2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 533C3C4CEEA
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739819573;
	bh=i+OJSnW+SS9nZcSML2OAoDsD7Ipre2DfGGVGNr78NB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SZfufp2efZb8iaHVUUqPPzHjasnOFs9iSk4CYXbfw3mBfYx/VPooe/ig4S8vR/Kbw
	 wV1evPCMSOrU/xWfPN2Q3Sl5loBojga5Zpd8MamGh2pYsU5tZ6igL9WUIWQj1/Vs9/
	 2ymaBsHfrur1eoj4Z3gy9fBUulZ+uF8PsastHf3E1vYRrlNwUchqM/dWi4UaK0PPOH
	 oiozYorB0Dvb4CLxp6Xe+M5bxaJ+oz/kWeVEtbeK1C2KqchX6QWUOK+xhBy5KnG0Zw
	 JCATz13+xdQ8NrbkNuYX7xuiaX0UG1ZqxAU2DoihM9casnrW7w44TZC3k1egwDzStZ
	 Lwqi7eL0WCPcw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4CBEDC41612; Mon, 17 Feb 2025 19:12:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 19:12:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-BKD3btevUx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #73 from Miroslav Pavleski (miroslav@pavleski.net) ---
Created attachment 307679
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307679&action=3Dedit
s2idle reports run with root

Mario, just to be clear, I've run all tests now on unmodified system.=20

Regarding the latest BIOS update, unfortunately, I confirm this is the late=
st
one published by Asus.

This is from my dmidecode:
=3D=3D=3D=3D=3D
BIOS Information
        Vendor: American Megatrends International, LLC.
        Version: GA402RK.319
        Release Date: 06/06/2023
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 32 MB
=3D=3D=3D=3D=20

This is from Asus support site for ROG Zephyrus G14 (2022) GA402:
=3D=3D=3D
BIOS Update for Windows
Version 319
10.22 MB 2023/08/11
=3D=3D=3D

I'm attaching two new s2idle reports run as root. On the second one I've set
manually the /sys/power/pm_debug_messages to 1. Seems the script is reverti=
ng
it to 0 after running.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

