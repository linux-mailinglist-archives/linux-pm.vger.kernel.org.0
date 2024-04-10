Return-Path: <linux-pm+bounces-6225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC089FD6D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C3C28697A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996D17B501;
	Wed, 10 Apr 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJXS6gEN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579316EC19
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767938; cv=none; b=UEwmHIPd3yzz0hjTGFbHhaiFddnFYZriK3wzYpeG8UdH0bOWnHLdmAJYNR88UtuaCF0OxGyKlMh/Kexc1CF7rmTKWJPjREEVKMG5j7D2Rrfpc8iulxIWWwlXEBn7l813J6OqM8F84kFP47lVrD7IbC4RVr7Yd+xgRydC2S99FHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767938; c=relaxed/simple;
	bh=N06ZjcU3Tmw8k7UPM3cuip8jbxBss6eUKXLS3Ji8pu4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nHiDIr/GeUSJQR2mUJDKQbCA709uLfRBlqZPYyMhNLU5qUv0ejLzHLkZPZcbNZQnRaPGobDBbCV6j/KZy21tyWz2Rz8DJhLw3whq7DJ5g9qoOlVwkUFjJJZPexW9W6WMgnDPJIBIO8unVDUG5YfI2PnOolEXyC6SZlDZdqNqh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJXS6gEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B77D7C43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767937;
	bh=N06ZjcU3Tmw8k7UPM3cuip8jbxBss6eUKXLS3Ji8pu4=;
	h=From:To:Subject:Date:From;
	b=YJXS6gENcV2t63g97R24bhj7we0I+3xeGn7tVvojwrHnkxP1ifx658FkkCxgcP6zo
	 2Utga9oMc2HOgaXi7Udfh/70JvV+OfwqXOFj/ObOh3KLJLYYWeUPh6O25RzZQ7QYHr
	 3SrlQnvJ1VYUFa15BtWEv1jqRo5ThtRJHjnuUBSxH6q32cl/Dw3u3QLOE6D8mgAJ5i
	 u8c9I3TIcVL34nE0PNV5qXdV83wadg54qPI3xaHUbl1qZ9G28DkUFLC/Gp1ZLMwA6s
	 VscO2Yz+uhbzcpLOjwauDswhJHjTmLECuIWLNZhISZm5uOFnIG35RvLP2k0zlgaX9S
	 RrVFA82hDj6DQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AB018C53BD3; Wed, 10 Apr 2024 16:52:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] New: amd_pstate fails to load on AMD 5950x with Asus
 ROG CROSSHAIR VIII DARK HERO x570
Date: Wed, 10 Apr 2024 16:52:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218705-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 218705
           Summary: amd_pstate fails to load on AMD 5950x with Asus ROG
                    CROSSHAIR VIII DARK HERO x570
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: andamu@posteo.net
        Regression: No

Hi!

Sorry if the formatting is broken or this is unreadable. Description previe=
w is
broken it seems.

amd_pstate fails to load on this hardware:
CPU: AMD 5950x
Mainboard: Asus ROG CROSSHAIR VIII DARK HERO x570 running UEFI version 4702
OS: Fedora 39 Wayland with kernel Linux 6.8.4-200.fc39.x86_64

amd_pstate does not get automatically enabled. dmesg -T | grep pstate says:=
=20

[Tue Apr  9 17:24:36 2024] amd_pstate: driver load is disabled, boot with
specific mode to enable this

No cppc found in output from lscpu. In UEFI the following are activated:

Advanced > AMD CBS > NBIO Common Options > SMU Common Options

CPPC (Auto / Enabled / Disabled): Enabled
CPPC Preferred Cores: Enabled

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

