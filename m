Return-Path: <linux-pm+bounces-37391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACEC3300C
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 22:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35383A4DD5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD112E92D2;
	Tue,  4 Nov 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGH8DB/A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BD19D07E
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290401; cv=none; b=q/ToNUlKeutLQH8FHQsVNCoxyxY1SaeP/y5BG6vylD2Yh0jYlzbr13n36GAh/r05arvNTMzYvF1+zMliFAg3n5enGvRBo3KyUP3bhIbIeb4SYxsgoDVEL3yLI8iZlXQ8bYp+yJaSl1w2VrfOC8JsKUGGNqpd4IOkAmBdNR0rBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290401; c=relaxed/simple;
	bh=c23t9mXD6gO0+CuXt3jjJrM+4G3R/CC6pOl7pU0JeUU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDeLg10XNGn0W6JkUVGpKSnKtn3m/TWq4ht3Ourdo2B+yxMojb+n3H1le+5X9tTuyZAZQhcJbmq8U/wO8zrU8PeNmkPQF+/VTX9jYr/J1Oh88WC3gLF9BmdPfDHZFoJfvO4gdzwaAUBSAynxV2r7zg7sHNL9T+HEJnw8euyKLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGH8DB/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37591C4CEF7
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762290401;
	bh=c23t9mXD6gO0+CuXt3jjJrM+4G3R/CC6pOl7pU0JeUU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kGH8DB/AA6uiZJRuuF//h301M4wobHfHdK0KoLmubU2BWXWjRdp+X7mDvpBtm8HZL
	 Mkuk0pj/PjSv4yUMDTJO8JaXG1gWK2vC/p+1++WUwBbkpy9ZuLR5Qrl1C0iIZi4RH8
	 bYe7VUTQppiVCJVd/uwcIINhFh+NBxqD/LIZI1HEaWVnCXOOC1txUIuKsIvij17wXu
	 Q1icwyc60KWyfYjEo3y66pH1Z4UadIs4enqu8dNnpvRD7rzZ02ccN6Avm1M7Kjn+1r
	 UO/HifO9E3DjXhwMvhibxiXgRztwYRRFxo1auYKw1h3rMPDBAP5cGRwtB/70D6UIMK
	 +JcgCxHTML1aw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E6A0C53BC7; Tue,  4 Nov 2025 21:06:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 21:06:40 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-LId4ImNRfc@https.bugzilla.kernel.org/>
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

--- Comment #20 from Chris Harris (chris.harris79@gmail.com) ---
SUCCESS on kernel v6.17 with Gautham's patch combined with Mario's most rec=
ent
patch:

1. arch/x86/kernel/acpi/cppc.c (amd_detect_prefcore):
   for_each_present_cpu =E2=86=92 for_each_online_cpu

2. drivers/acpi/cppc_acpi.c (acpi_cpc_valid):
   for_each_present_cpu =E2=86=92 for_each_online_cpu

- Driver: amd-pstate (working correctly)
- Message: "AMD CPPC MSR based functionality is supported"
- nosmt=3Dforce active, SMT disabled (1 thread/core)

Full dmesg attached: dmesg-6.17-SUCCESS-online-cpu.txt

I imagine this fix will be included in the kernel in the future (that would=
 be
very nice).  Please let me know if you'd like anything further from my side=
.=20=20

Thanks again for all your efforts!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

