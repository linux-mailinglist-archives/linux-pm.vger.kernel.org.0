Return-Path: <linux-pm+bounces-11918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9616947CE3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5939281B71
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DD13AA45;
	Mon,  5 Aug 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLpHbamU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2D13A3ED
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868368; cv=none; b=PRlxfSE67UVwcnMRyZlVtSTo2acMcgI0x4WGUcXrN6KJ9yeuvnbXrzI6155W5qFpjD4VoXsNGbapQOCaW0H7lqBW40nwZE8vKh0NNS9ZeTSSqAQX3DuxEyRIGGm3uvlnIsXbOLLpAlSlJcUd4fB05K2YZSCbg3KEiyhqJwcjMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868368; c=relaxed/simple;
	bh=zSj49WoL4+qReIkLYycxbPSmyvYPOV7Pus4wC1tqW7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmRp6d2RNhTVjYv7gBheeiJL1N4Uz1yQJADaf+32rx9D4fbLCA6Qe+R2brM4tOViFn7sRVT8dXHXXmA3R1Cke+usb0ShDk+Iob32PETDSuN6YFK1VdwSmYOGQehuK3xSF7CKjpTjiUUp8yZj3cXDRCHlbg84suV46d4SCboTUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLpHbamU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D78C4AF14
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868368;
	bh=zSj49WoL4+qReIkLYycxbPSmyvYPOV7Pus4wC1tqW7E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jLpHbamUTKHb1lYnINhBrcT9yMpkxdkP1V+ucZoEAgTS1e0bATkZLmqrOAeRvCnj2
	 zOZLFzq7bVivlgiJG/NPdOMY/JGcb/OPCPsdUdJcTriCt1FqUV46+icGESVUYcM9Nc
	 AvuYTrps1XS6Pe7WXwjV1hJgIC7NGYJCGsEBxOclOhh7jDplE3gX4iwJQPkJ50TGG6
	 SRaR6E4dsgPUEGSdqQIMMpQM6TK1BEA+kWlxmvFJlGvqDKid/+5c+8LhNjvTpVQL6a
	 BgPFLGOmzIP3ngr+4Tjkgbc2V2rY0/K41KO0zGLAYxVoln9EOQdwGklELRaQDtnXmv
	 vjCsf9LhBxatw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 11BACC53B7F; Mon,  5 Aug 2024 14:32:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 05 Aug 2024 14:32:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-d8myZRMRUG@https.bugzilla.kernel.org/>
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

--- Comment #74 from xiaojian.du@amd.com ---
I checked on my desktop PC, based on Asus B650M mainboard.

"Advanced option-> CPU option -> PSS disable/enable"is the switch option of
CPPC.
Disabling *PSS* option will make Win11 OS switch to generic ACPI processor =
pm
management.

Back to this issue, somehow ASUS has enabled CPPC support in bios,as it sho=
wes
"PSS ENABLED" in this video.=20
 https://bugzilla.kernel.org/attachment.cgi?id=3D306662

But the key CPUID bit of CPPC func enablement still is not written "1" in t=
his
new version BIOS, besides, the dmesg log shows the _cpc obj  in the ACPI ta=
ble
is null,
"ACPI CPPC: _CPC in PCC is not supported".

So the conclusion is, CPPC func is enabled in this new version BIOS and Win=
 OS
is using it, but it doesn't support Linux OS.

Maybe ASUS didn't put too much notice to the user case on linux os?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

