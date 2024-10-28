Return-Path: <linux-pm+bounces-16588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526269B357A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14531F2234F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F41DE880;
	Mon, 28 Oct 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdsK3FVI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5F1DE4F6
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130988; cv=none; b=AsQ3ukXY6/IFGSfGmW5UTuKo8dBeKPB9+iRWrx8JdEpEBdq26wnVmlSlTxoMbRcysB+xwDA+KGb7Ud3aAeuYxj3bYMu70VC5qpiYVB+kUzCMzPVTdq4kZL2Lo1qr2pZC51Ep+hffm+Z6w15oBTgXSHpUMKq0NKhX9XpRF67dZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130988; c=relaxed/simple;
	bh=dIZ4QdsKhD0jBwN8qawRiIjygad4OYbJYCnVVb7X+GA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QsE3NOJCDIJyLg7oI/uUaagZvKi6bQVY2+GwJNMExWsVgPjekZRqA71C3GcgrgyChusjhFhOiCbozrJxhmE9JEk0xyz/7/wUlWNxFWLXx5ztcxhrxO4odPyIAERKn0w6PmcTf6oP4HpbBMkwc62Mg/quQFy9IX52HI92UFlSoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdsK3FVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59EF4C4CEE4
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730130986;
	bh=dIZ4QdsKhD0jBwN8qawRiIjygad4OYbJYCnVVb7X+GA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tdsK3FVIfDJZPiYebeyXl8ibEM9lgUXTlndRAuDVA0bVx1U0U3/lYhEdX2ETmUGZT
	 VP7gqu6HnPmfigLmx9+dm3C90gPqFZF2jdroaPZs/A+3EgBOzPr4Ywr+k504/Qx34k
	 RFQ1SBBk/+vPAU/vnFxjQw9cY+YhuN4Sgi35gVtOwyPy077NKWcSIFCKZ/NC0pifyx
	 VL9uCgwT/0N3Ct3W8jajw3PD27RX9h6a+/oNiPYXMkhtDK34lTm+pcYIba7ArvH+WZ
	 5xYTTcatuK7IrQg59d6ierxAxjvVIg4zrkg0jcU9efNoyebrGhx1dh2bML4bypSA1L
	 ZDzVoFmDoO3UA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44DA0C53BBF; Mon, 28 Oct 2024 15:56:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 15:56:26 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-iCF1UvM7xd@https.bugzilla.kernel.org/>
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

--- Comment #6 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
Created attachment 307080
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307080&action=3Dedit
acpidump, 5950X, ASUS Pro WS X570-ACE

I'm experiencing this issue too. Attaching acpidump output for 5950X and AS=
US
Pro WS X570-ACE motherboard with BIOS version 4805.

The latest BIOS for my M/B is 4902, but I haven't got a chance to update ju=
st
yet.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

