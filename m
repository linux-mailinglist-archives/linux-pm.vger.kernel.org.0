Return-Path: <linux-pm+bounces-1681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892582037D
	for <lists+linux-pm@lfdr.de>; Sat, 30 Dec 2023 04:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911C91F2225A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Dec 2023 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5510F7;
	Sat, 30 Dec 2023 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdM5eDz6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611D10EB
	for <linux-pm@vger.kernel.org>; Sat, 30 Dec 2023 03:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7550DC433C7
	for <linux-pm@vger.kernel.org>; Sat, 30 Dec 2023 03:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703906903;
	bh=Sc6/wQUjRbDjuGliFFH0/YsXd3ySUnSKHlprGgtZlqQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qdM5eDz6BygDCdgPpriH+HYCbtM5H25lZcI9Ff4XiO8BSg0yBc+cQzkbKbpglsM+X
	 UHspXcej1bGAqg4Q9mqHYvN1vwSiOO6btxMreAGOZ8yur8rvEXbi+rXBkAEjFG8ENH
	 yT1FIgv4Oa6NgiwxWgxvmUjuJ02yWzAB0vqU9Do4S+154oxOf0zv4Zj5SiM4jfJoFg
	 x14YE72itnh3qggBJfJrfGFn/mo8knVu37d49wo+N9uKIh2dILhJypxnKnSwpIDuJ6
	 E8X2MVGsocZRt+sngHtMTiKF6VRUswPyJLlC2JT/KCc8OgLT16oSd5LGZ898oFbTlM
	 tG9TuqILNfnKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6062DC53BD0; Sat, 30 Dec 2023 03:28:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Sat, 30 Dec 2023 03:28:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pnascimento@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-QhKAoCteL2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #22 from Pedro Nascimento (pnascimento@gmail.com) ---
Created attachment 305671
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305671&action=3Dedit
ACPI dump for Gigabyte TRX40 AORUS PRO WIFI with a 3970X TR

Here's mine. Note that this is a Gigabyte mobo.

Machine:
Type: Desktop System: Gigabyte product: TRX40 AORUS PRO WIFI v: -CF serial:=
 N/A
Mobo: Gigabyte model: TRX40 AORUS PRO WIFI serial: N/A UEFI: American
Megatrends LLC. v: F6
date: 09/07/2022
CPU:
Info: 32-core model: AMD Ryzen Threadripper 3970X bits: 64 type: MT MCP cac=
he:
L2: 16 MiB

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

