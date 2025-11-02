Return-Path: <linux-pm+bounces-37251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9605C289DC
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA2347E86
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 05:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC81DED42;
	Sun,  2 Nov 2025 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msqB9aaS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D54DDC3
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762061242; cv=none; b=gphP34sRZ011lDNmB+8fM/a/vB+jIRcOwd/ElUhRjG/plRo6V07RZhPUEN+qFbl9RcH2zVYYWoTi8wMkQrdayp6tFhYgKi6ilzsHbESw/z3Wq91Ysm+Q01bPH1y1O5YBsyPYCDISetcz7/O5OMF3GMk1CPyFLpUscfSLpnzTKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762061242; c=relaxed/simple;
	bh=82bDcGjoYQYx67bqguq9z3hz78PwWHx4KVnmWKvq0Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Thln9RDNQbBpSbkvbb0DWtg1wCA6DUCKAaM+KYnc3IVbbPzbHmGxjPXDlnrbFdSlNoAVE/vuAtMWONCKMNNTlAgUWZoXG5bpKfLlXbAE6CLZfy7noDHUvSiQuV0WkyCd89z8QDY8REbhNlLlUbaNa+nVsqLOqkLTqbo84lE2SR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msqB9aaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC8CEC116B1
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 05:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762061241;
	bh=82bDcGjoYQYx67bqguq9z3hz78PwWHx4KVnmWKvq0Po=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=msqB9aaSHvX3Rbd5lbYz06aEvxUTbFXcrIsgkUN/fqh0nqA4QKMaSupTUrRa1S8Fb
	 D0TbM6xoUJTuI0XYE4sgxH65sHZCbiIKJBtbgfOxB57/XLb67ksujUi8Fi4jh6gzdY
	 qO07uf9M8Fzj2LTnKgRTXvVedNDEENAz9mJSDc4796XKYuctxyXTwPoquuRdfYVGHP
	 b4RM1Rr90M6itOqK8kLRUsY/PQGnknqBVBNfFlgn4KyGyrO8G9zPpxfqqwtqIaRDnr
	 XXFdup4bZ0q4p6p6GFSXZ5IU1BLWPuFZrlVByhOYqLkvo23duxEH4xeSaw+zcCfWda
	 ceRkMCkSG6DXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AEFE5C41616; Sun,  2 Nov 2025 05:27:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 05:27:21 +0000
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
Message-ID: <bug-220715-137361-TkYmr2cX7Z@https.bugzilla.kernel.org/>
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

--- Comment #7 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
3) Does this help?

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8ad..6da278e398943 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -460,7 +460,7 @@ bool acpi_cpc_valid(void)
        if (acpi_disabled)
                return false;

-       for_each_present_cpu(cpu) {
+       for_each_enabled_cpu(cpu) {
                cpc_ptr =3D per_cpu(cpc_desc_ptr, cpu);
                if (!cpc_ptr)
                        return false;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

