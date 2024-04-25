Return-Path: <linux-pm+bounces-7104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F808B2527
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AC8B2425C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61514B07A;
	Thu, 25 Apr 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl7xkFO8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D514B078
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059197; cv=none; b=gAz9nAnUZFMzVpJG0W8gi+2UufMpe7JiYJOPet1vHCboub4Vh4U0Gw9nQAffPXIf36h1PVbQyomnqhxRz7h6JXRj8X01pI3O7f6zX7ILW6LpbihgHJI2xPbXsZv5e9AplJPIo6ZQCAPazZlV7lODm15psINBSAz0cWIpg5I4PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059197; c=relaxed/simple;
	bh=PDX7AcdgIdQrBPM0j9PFyFerAns4PkrRMT1ZyLO672A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mLwFE5kQsZLjgfVx7KV04CO4bfijj5zmM4jltPe35Jbx/Z6D+9TekCG13wqK6ewqmqm7Lw34kyWAw4PBC7ILcgItVqnVbkhTaEg0r3oyd2gflhji+CeGAKyLx6BmpvQza8h0Fm2zsEGWj/MwBwENd4+tYT1SZ68KAKWTpyJ3ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl7xkFO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6683C2BD11
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059196;
	bh=PDX7AcdgIdQrBPM0j9PFyFerAns4PkrRMT1ZyLO672A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tl7xkFO8x3yrsNvdepD97cSUxTetn/Ac1pw2BTKYwm9JGNbZhhqA4kILEXiWTbbMq
	 Mq7gZLDVO/TUMfCJ/4IwFvY70nDxDe4Fa0EU9G0l5+HlDHryIcm4oGQoQ9nBR5zuig
	 1sWt1pXGqD9lUKHV8mda3hIzF9dK/D2TW6oK3X2eFOARrcDbZJ39EvcurLrjddicpK
	 k92Tjg2kRALo5wjZXsjv4vRiNRSviejLSMBQlxp3L9vvs1pdAD5rk6CgCRtj2o/XxC
	 qW0ra0lwhqwNKYDBxrboMn5Ym4tKM44CBQPL3e0JVSprzPkAxJvMNQfABHNIUF5pxh
	 0Fg8JRCEuZNRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DD5AAC16A72; Thu, 25 Apr 2024 15:33:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:33:16 +0000
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
Message-ID: <bug-218705-137361-uKwTpyJbW9@https.bugzilla.kernel.org/>
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

--- Comment #15 from Andrei Amuraritei (andamu@posteo.net) ---
Hi Perry,

Attached the required output of the commands specified. First files are aft=
er
adding amd_pstate.dyndbg=3D+p but there amd_pstate still did not load
automatically.

Then I also added amd_pstate=3Dactive to the kernel param list and attached=
 the
outputs from commands, with "active" in names.

Kernel when opened the bug was 6.8.4-200.fc39.x86_64 and right now it is
6.8.6-200.fc39.x86_64 as specified in dmesg output.

"Talk" soon.
Andrei Amuraritei

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

