Return-Path: <linux-pm+bounces-16620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F739B3A91
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1092823A7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C404617B516;
	Mon, 28 Oct 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAzvCyW7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3418B03
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144378; cv=none; b=tmcT4PubKhXpiyVWp3MKoucWVxINOGfi8a63LR+VgQx8X7ClAQOSD1O9gISgYRq9zBisvbp9wKq/QKzFwQXmA09V64EdiKLGGAM8EKBDDD9C/19li0lOG2nZSwMmdG0OHlpCWag0Q39CS57A8zbxoL3aVxIXNYt5WdDMXmsN5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144378; c=relaxed/simple;
	bh=wB1qg/oUhgneifVB41+Sy2sTmQVPsdCfRHuct9k2cdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlrF0BujLiTKeL+rZCSKcZ5v/8XoiBqggK39LwxXQlnDbSaIl/6V4eyR7unhCykXZYmI0A29TwRE4wOzJsw0YgQZziqUdjTH8fA/NwA4BNWH+6R8gE/aoSo6tf7QPJY9Lntpr139lCsv77Q52jW5WRvqBUyfxQuXsAN1jJz+m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAzvCyW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28140C4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730144378;
	bh=wB1qg/oUhgneifVB41+Sy2sTmQVPsdCfRHuct9k2cdg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PAzvCyW7TI2SYPt3W6QKsS3UixcV5vaPgi8P++P/aJvLj5mfRrqzNp56fK7cux76Y
	 ZPclCg6X2B8r92E0zg/7b+wNU50d4eXrHA9ymlQJk64I2u1ugb4Sf55nSEn9vABTPr
	 ALVna/0rvTNy1SHr7rrihFLh2e1UbrWmuNbNtI9A8SSoXX/IYXxlWAryGmFWERV3Sz
	 zS3tOdw6qwoXfXKfTcaiQw5LYULwJObS/JfznGh09eiPa0S7kcGZMIVms/PjNeSE5i
	 QR+Gk+//pX6eQGU9DiosgJMQ/F2tKsBCQq5hKC+WzH5SusIpZy8+FSmCrIoKpcVpzI
	 gov29YrOdTGzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1E35AC53BC8; Mon, 28 Oct 2024 19:39:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 19:39:37 +0000
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
Message-ID: <bug-219431-137361-SCugfvBVsx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #11 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
>I assumed that all Zen 3 desktop parts are ACPI CPPC-based rather than
>MSR-based? That's why I mentioned Vermeer in both my original mail and this
>bug report.

Vermeer is a shared memory based design.  All the newer designs are MSR bas=
ed.

> There is also an interesting observation, that at some point *after* this
> warning we get a pr_debug() from the end of amd_detect_prefcore(), which
> indicates that the latter is called again and this error does not happen
> anymore:

Yeah that's why I was wondering if there was a functional issue. It seems l=
ike
this is going to influence some of the frequency invariance code that's set=
 up
earlier on.

> I'm not familiar with control flow in these subsystems, but isn't it poss=
ible
> that we are simply racing with ACPI (and thus CPPC) subsystem initializat=
ion?

acpi_init() calls=20
acpi_bus_init()() calls=20
acpi_bus_osc_negotiate_platform_control()=20
which sets osc_sb_cppc2_support_acked

Here is the more full call path that fails:

acpi_init() calls
acpi_scan_init() calls
acpi_processor_init()=20

which loads "processor" kernel module

From "processor" kernel module:

acpi_processor_driver_init() calls
acpi_soft_cpu_online() calls
__acpi_processor_start() calls=20
acpi_cppc_processor_probe() calls=20
arch_init_invariance_cppc() which is a macro to call=20
init_freq_invariance_cppc().


I'm not sure I understand why CPPC v2 _OSC isn't acked though at the right
time.=20=20

Can you use ftrace or annotate the functions with some printk's to figure it
out perhaps from what I've shared?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

