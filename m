Return-Path: <linux-pm+bounces-37335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D6C2F07C
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F454E3002
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B625CC6C;
	Tue,  4 Nov 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgnE4SHz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24FB1FFC6D
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224815; cv=none; b=ZAtFcbAAGG+DEyFtC6m9HhIkGGgvbPKosJSrl+dGINwgXd6VJVIoM16JQ6GlRPs2kYqK1q6dndgBtykExVKK4tRxo4cbWdffGQW/HuOSzeAnf503kty7xxtu87tszkqJklimyUMxP1QKBgZ2fRCdijUwO44VjNNPLtXO4baiLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224815; c=relaxed/simple;
	bh=uu+MdTMRcFKtS7aigUDdX+eCFpsKLhPPGHNqB36gT4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c3HdHIfV/kahjA1QF2AmHxlrDQletJvX37XvEVKP+1zAFU5Kq2SCVLHCpSkKbbSdWIdr39Z6TLs4cvDoZRQwws232HQniwfYdA+FgSAvJzbl2/zFzyC2SQaGhkGf3q01s8ej8YPDH1V5yLwzhxxTV+Uijkw9G70FJ1RxazDeK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgnE4SHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E5F5C116C6
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762224815;
	bh=uu+MdTMRcFKtS7aigUDdX+eCFpsKLhPPGHNqB36gT4w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sgnE4SHzXynn+AC3nRpaO4ZBLiBobb2HnZXpOOxNSQGm6G4k/dAfgHgOeix+WMD9V
	 XS0APYwsjAZBzaxlpAvbEJuEoL/LG7F69aKIkCq6kKS2ATJ/RQDCBA9KIhCWD67GQy
	 o4MkhpK8KsSColVifkJftxDoTnkNDa7Mhj/jFRWpDBM3+36rDbcbXKhRz80WjYFqGz
	 m/jQ99o9DuNRcSUiXDL4sjFRK6mHWIiCPT3slb5dkP3Oj0VTjF4cgBh2QHS2O1hHaz
	 G3x8icrvyWNBdVL/kyRsdqVY3XTT2Z60CBUrCW+ZoqREe9LYceoqhhFXfGcpZP9I2O
	 R3JJJkg26sRdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5C486C3279F; Tue,  4 Nov 2025 02:53:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 02:53:35 +0000
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
Message-ID: <bug-220715-137361-lgpJG4A9yk@https.bugzilla.kernel.org/>
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

--- Comment #13 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308888
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308888&action=3Dedit
dmesg-6.17-patched-full-debug

- Full dmesg output with both acpi/cppc and cpufreq debug enabled
- Shows extensive cpufreq initialization debug messages

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

