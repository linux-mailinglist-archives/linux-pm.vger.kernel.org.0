Return-Path: <linux-pm+bounces-8007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D225D8CA56C
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3CC2825A0
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32F36B;
	Tue, 21 May 2024 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+5AjRbS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7EC138
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716252105; cv=none; b=TUS3ek7eRwyTEJ32n4VzxYenyADPDBKa59FdggV8hndLMykvmgIPDfc4A7kgFuKH5u2cLwPe21A0MvXVtmXaqFfqMJv55f91juNyDz2NC9ILejqAzo4SO2JTvm+QrMwGKdw0H1/KQiqVAYj3sRgBcvx+pgmOutTxUn13STyNG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716252105; c=relaxed/simple;
	bh=ZZzmN+s/Y+8bVY1STB9BrK+OXMMsXDC/qSjpFucoEhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hz45f2LAvPU3NEa8XkbqeFoFGh1L17Wvo/FIjyxYrN07NzEVcUK6LIO4RniQPUzRLAO6H4PhzmR/2XxxSwqzXa5b2zdYjXVpHZOgfXMnBsMNuIINd5Q6FXlw7hDOR0Bv8AwX8H+SR4yvsajHc+2tvtho9g2+lBwb0JNMrKynInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+5AjRbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 922C3C32786
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 00:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716252104;
	bh=ZZzmN+s/Y+8bVY1STB9BrK+OXMMsXDC/qSjpFucoEhc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d+5AjRbSU4DudvpL7EAOrDGJSdwpTpfAOJ2GgU2lUzXxXujScyQvqph4uAK7WmyS9
	 G/zqPQ9iYjKKDbDhen5IWaYJ5c58FGUjy+VWRbX6JOSVoAP6UZF4of1SXvEizm0cHs
	 tImMNOws/dhbFZGp9rxUpoVVwKlbplXJfCHieU2K4b2Z23/A44Uig9pQrtSosB7d+O
	 WoYY9y3xNj/jdUmE4tS5qyBBR9vdy2N0THYLXrcCyJlUIGh/KvjsCSwDZRKfKzEZOP
	 IQSAxBOij11QvWvZCf9UY6qIiQxobAFHGPVKqBqa+hLzBtd92mKFRPzPZg7QTGl4A8
	 4Y0aXlkdqU+Ig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80115C53BB8; Tue, 21 May 2024 00:41:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Tue, 21 May 2024 00:41:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218865-137361-cZyhqmalsC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

--- Comment #1 from Matthew Stapleton (matthew4196@gmail.com) ---
Actually that fix might interfer with the use of amd_pstate_set_driver in
function: amd_pstate_param so perhaps it would be better to retest cppc_sta=
te
for disabled after the call to
amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE) or maybe a test if
current_pstate_driver=3DNULL after the switch statement might be better.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

