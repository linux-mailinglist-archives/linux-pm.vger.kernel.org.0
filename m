Return-Path: <linux-pm+bounces-16663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2409B4BC3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196E71F24494
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B969206E81;
	Tue, 29 Oct 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVMjn9+g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615A21345
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211039; cv=none; b=isGtFWzsRK4YMNWzn5W7ay4wU/+DLgWc6qQHV3rqv6oq1glDbdueTeAMIajFLWDEV2oNI8C83FZvkfGyIfIiV4ThduoYf4FT7I7SEMz/HPSmqcxePZo3HOzoCq/2A3v8WaAvlGSZ1fzszpPlCt1ng0EpA2uxaEkZjJsZa95WMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211039; c=relaxed/simple;
	bh=uYqNNsDkRXyiUggeRT1b6Qmqm+n43pjO4W39Gc7y7mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mF//d8WtIBjfEhK6oQcyreoTv4jkxWzisg3rrJLhJe8X+IfazGlro+dOGnKcHUrf98n1oHVhTJ3tT61tRiaQLv/gRY/SS8OXCnEcduvwRMNr1GC4PThhMZlwmBT6fB9j4Dp/OcJtMOY8SKypEPs0IsFBUuo06VBnUMe4Go3FNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVMjn9+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1149C4CECD
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730211039;
	bh=uYqNNsDkRXyiUggeRT1b6Qmqm+n43pjO4W39Gc7y7mg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JVMjn9+gOmhduOg/N57qopvhrSpwiHgrAmjBH/2AXmz7/BknZldaR93Mc66f1WbiK
	 ICqp1+w8JO9/kglNWd4wyiTmml8tzrwW9RXN5Ez7BxkonpmsZtBgqc8cpeILI5pk8z
	 0XtXRclo/M7ZAoDiVafEXaenSAOQ9CyYITkvGlzhgD+eyQ0NVEJgN3Yyywlq4JNUvw
	 C/E7ZCc7uslxv0KFYfLMHxtVb6AowD61XwzwJjSwsyZwAbG92tSYzgxIl/WS52+ZKO
	 5dyC/giBpSb208G6kLd2X/oj7PmV3cW6p26EOgW/GjlWNLPPyP4oCl2h7DB+UDOdip
	 A86k4bA4DuHBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E5717C53BC8; Tue, 29 Oct 2024 14:10:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 14:10:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandr@natalenko.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-5Ak3XdlcTc@https.bugzilla.kernel.org/>
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

--- Comment #18 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
> you can check whether the CPU cores are reporting correct maximum
> frequencies.

In `amd_pstate_max_freq` it's 5084000 on all cores. Running `turbostat`
parallel to `xmrig` I see ~4.4 GHz on all cores under heavy load. In this
regard, for my setup, nothing changed comparing to an unpatched kernel, I
guess.

> Can I use your email when I post it?

Sure.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

