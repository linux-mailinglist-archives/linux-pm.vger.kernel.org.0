Return-Path: <linux-pm+bounces-37157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1EC233AD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 05:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2661B3A3556
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 04:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA31F5842;
	Fri, 31 Oct 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axC+68zZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308DF50F
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883309; cv=none; b=KZafF29S3aFS4O1A6NuFgPqPPdb5Ng1F+yLUDRXzKLOBq5PVYwR5ONX7ndNJlH+jcmxasgGZtBL63TrQjxqYcmVSiuRl1dnsay2xnBuObR3QE3Bo9jRGzZHrJIh4/9PZjKQfZCNAP22jVJkN8stC/b8kta3nmOWRDTnRMPeFRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883309; c=relaxed/simple;
	bh=pB3nubgErGiwfJWOSDag8giE25KjCt3FsCkN3P3elrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MaLu/5MGeL0rV7A2CYmSUmWkDSgoBgnY6aOdanJPCD0myU5AJYJhs6Ojk1CavV8MC1ZjrBIqapTuzJ0To35vdik0TQy/T+C9cRQWtsU6plbnXC5QJoiRoUsWnEqJGamXYNS4zcC16/PRTCXvWazSR3/LgGp6V1oLfk9n/4oLn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axC+68zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B81A3C4CEFD
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 04:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761883308;
	bh=pB3nubgErGiwfJWOSDag8giE25KjCt3FsCkN3P3elrw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=axC+68zZjVdjXbpeP7sX1wMWAYAwwpyL9SCdfZD7fO+ux1WEjAOInZOH4FH9qZmqS
	 2Ywbs9KPxigqc8ErmyQsqYOjEA3lm7zmSfjARg7VzhKPL1hq1fkUZ5CRFkVFMbM/u5
	 ZnkxZaSsO5z8Cl7nK2KcG+68KHqKxLX4acRiSef2LWJ7gYEBi1Ivw0SzkSdUDZgqLE
	 rdX7iCOsUDySIhdiVSW3O3cG935heX0GmCC/u2AZA2buq6lvKFHDMpVD0ZUX5xhOCu
	 dTOzawFfi6trgUKM0mKm2BxYlKeEwqqt+/OSADEm/xbsHo0L89AtwURBt7AebSGX5I
	 ReXLgWBe8qBPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ABE47C4160E; Fri, 31 Oct 2025 04:01:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Fri, 31 Oct 2025 04:01:48 +0000
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
Message-ID: <bug-220715-137361-WKfNkLh34c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Another thing that may be useful is to turn on dynamic debug statements for
drivers/acpi/cppc_acpi.c at bootup on a current kernel.

The syntax should be something like this on your kernel command line.

dyndbg=3D'file drivers/acpi/cppc_acpi.c +p'

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

