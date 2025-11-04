Return-Path: <linux-pm+bounces-37364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF874C31547
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7D3BAB98
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C03329E54;
	Tue,  4 Nov 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjJ9+vF/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E25328B52
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264585; cv=none; b=rxBeW7DheKsCoDBrFde9DR4hovk7LkGZxYrL2FWRyQH7zMlbckfKclwHklHkDVdnzysl/dUc5Um+aR+jZQcxlhy6tArvqrzoDEH4qxI1HGejeqitS2DbnQXkcYxlRlyXiHl1rD2eAnjmizuBQA3wVHpiubmkV+tbseUEP6HnX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264585; c=relaxed/simple;
	bh=ON9Xwwa6YRLAwjqlOjOKf11KP6Gq4UoxydPsFMEQAL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABbHdIM3R6/LtY0Q5Apsz18WtFkp9CvcclvzNh8BU2pbf+JprNkEfuizSO+wcaS1WVXFWNhFLj0qzNBV5A/H2Yu9QIvS6TojmD848nvwg3I7YDawwcSxS8/93YH12SGSHSj59/z1+YO/bG80jXOXMUmqOcA6JJ1p6FGtzQDutXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjJ9+vF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11AD7C19422
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 13:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264585;
	bh=ON9Xwwa6YRLAwjqlOjOKf11KP6Gq4UoxydPsFMEQAL0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YjJ9+vF/jKXBJyKw/MHu0pnAGIdkhc/IGLsju/O9nAg8d+/M2fLI4rJdG/GVYKwEf
	 VHuOVRPQ0UeDK/ud1w7pxv1CiwZZ9Jgb0wlCHyW47x00/+E7lNGOn1syknMbWS1jyE
	 BpIcD7vYJz7b1qbIxeMR2rddrDJdXgxU6oOKKDTYEUfYnCKXZDdziV4DcOwKOWpjpE
	 BA31eFH9s2gz4ariPHQyu9DmhdBm0k+KpNRAOZwswmzP1r+CrtM8ixjN3anWOC6RqK
	 rltHekFfk7FB/UBi7G8kkc9xWp3lg0bFJrsXQXRWZFS+pg6g1SRRV2gpwJmC9zL16h
	 pyv+yVjLfQ+sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0CABDC4160E; Tue,  4 Nov 2025 13:56:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 13:56:24 +0000
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
Message-ID: <bug-220715-137361-eGtBBt2Ti6@https.bugzilla.kernel.org/>
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

--- Comment #19 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I believe there are (at least) two issues leading to the same behavior.  Can
you please try Gautham's patch plus this one on 6.17?

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8ad..6da278e398943 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -460,7 +460,7 @@ bool acpi_cpc_valid(void)
        if (acpi_disabled)
                return false;

-       for_each_present_cpu(cpu) {
+       for_each_online_cpu(cpu) {
                cpc_ptr =3D per_cpu(cpc_desc_ptr, cpu);
                if (!cpc_ptr)
                        return false;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

