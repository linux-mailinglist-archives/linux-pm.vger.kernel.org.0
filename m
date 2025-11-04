Return-Path: <linux-pm+bounces-37392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D30C33012
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 22:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6248D34AC7F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6351E89C;
	Tue,  4 Nov 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPZcmR9v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E77D27E
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290579; cv=none; b=XfimYs26rA1sou+avryPtdgItSFVfjAmOGaykRNhOuFvbcQv4+eqiqTR8IebFHoaBH5g7l05WWWQWQyMxojgQvsf6ub8o/NnDJSEkdTw3GO5nbx97ZcnCGkndNcSYvzrsL/PmU7/EFwFX+q5Ns+3sflpFLGz7yBbTFUKyAvQr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290579; c=relaxed/simple;
	bh=e2WTpmQG7WCmNMuKRQtaccCgfg3ks/9390GyLPFWLTk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGJp0VeISG1T0xC/+FQO38WTZ18055Q3SQTVPQaLQaA2cIax4tA/tJ9IgFcBvvDjjRSBha+Dr3TFuVayzSP8pd2JXk0ZKcqCbwTGnqOviCsyp3PzabHL7Q6LFEQfFN3TVXiXEQzg8i2Tst2SvWtVn/hDMl6hTfJtjnb5gYgSuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPZcmR9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C85DC19422
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762290579;
	bh=e2WTpmQG7WCmNMuKRQtaccCgfg3ks/9390GyLPFWLTk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XPZcmR9vpcXt3YA9/nTaw9YgjcUMgGhdMxTfxDxhMTDM244r06RcbfMvvjE1M9TF5
	 Z6LO1KhBqGLC/t6em1/xcxOVcSjf47WALaWySf0F7wJtxd12tZzXCeHn/ExamM8/us
	 dNY900dn6RkCJBKEvuovhbgfz+F3kUocuJFOFiT3hH2slkqxq4ixiP+I3m9ctW1xpT
	 BbdDOIX+HJb44vHknEUdFhJo10KUgGEMNUZW8YfuHQTEzy8hQa/CRVUKw1a2H4mIPF
	 IDjMzBc+HfupqPgA+a96gLFqFgl83OB+5TJtR+wps+aDcnzcORBto9HCvcmi6C9+xM
	 dBfNTIxCKyl4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 04264C433E1; Tue,  4 Nov 2025 21:09:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 21:09:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220715-137361-GcGb97Kem1@https.bugzilla.kernel.org/>
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

--- Comment #21 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308892
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308892&action=3Dedit
dmesg-6.17-SUCCESS-online-cpu.txt

Successful boot with amd-pstate + nosmt=3Dforce with the following patches
applied:
1. arch/x86/kernel/acpi/cppc.c (amd_detect_prefcore):
   for_each_present_cpu =E2=86=92 for_each_online_cpu

2. drivers/acpi/cppc_acpi.c (acpi_cpc_valid):
   for_each_present_cpu =E2=86=92 for_each_online_cpu

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

