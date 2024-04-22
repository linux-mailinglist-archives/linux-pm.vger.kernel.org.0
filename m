Return-Path: <linux-pm+bounces-6791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE728ACBA2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A51628536D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EF14600B;
	Mon, 22 Apr 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhduz1uB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA4145FF9
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784028; cv=none; b=raz2cQDWY8nerLV0of6qlbZSn9Pp+Loyjao9YoePLpUC1Es5eBDYrENGuh/XFGxagMRg5AJROIgqGp+4/Qnal0zRlL6E1hyMAeOmD34C0fMiT9DR3IG/HB9ws+dQPMMMVb8QTa4oKGCJR0aG/KeDg34GJqfw3md6h54LQ4KLef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784028; c=relaxed/simple;
	bh=p/fusGdzKN3CbCTwEzyVTuEo8bGsasqTJe6Q+sp4sAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICVPkgy5moi83ENb3ACoVwBzNn1gy8AXDvMR8fYNnIiqRx2IOQ3yNbl/N43WfQfJUUHwJJhBurRQKIUhdSSgLBUIF2ImMTyR9dZjhWTA6oPFnN2uH9dwlZChfl4918NiJ9aJ0LVXau1t4y+9oljxJxoKhyQlSFCUf5PcDAE4VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhduz1uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE41C32782
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713784027;
	bh=p/fusGdzKN3CbCTwEzyVTuEo8bGsasqTJe6Q+sp4sAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jhduz1uBe07kGmpFgXBnpiUrNSlPbN+mOw7e2bXfMSkR4RR+jjNbn8cigGArmYniY
	 YIjHOaIibLqdzwxy70Vmb87S12zBHALArIa6qmP1h3YyY20iZtYVXFk0xdjXxCdNym
	 FlZfzhJXKr42FBUOnABj/EignKr+LdvVBe4Cop3DM4TloYHRVDg62i75McVXit50CY
	 SQoYUofhbV2GTh7PD88f6iYCs/5J07WhNMBkPvlPdlR9J6MehwKfTBoi6v6oHqNkQO
	 B9IWeTMl8ygI33vBW9sy45YBX2Jy205kos+HX1ziU+LxxjbFz9gNtYJQDVvXRKg/MX
	 zHjgs38sEkG1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F208C433E5; Mon, 22 Apr 2024 11:07:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Mon, 22 Apr 2024 11:07:07 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-kDIJ3V46Zf@https.bugzilla.kernel.org/>
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

--- Comment #5 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306195
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306195&action=3Dedit
values from cppc_attr_values_check.sh script

Hi Perry,

I've attached 20240422-cppc_check.txt with the output from the script.

pstate did not load automatically for me on this system as long as I rememb=
er
(across Debian or Fedora with kernels 6.x).

Let me know what other info you require please.

Thanks,
Andrei Amuraritei

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

