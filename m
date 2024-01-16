Return-Path: <linux-pm+bounces-2260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757682FD32
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 23:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7CF1F2A404
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090A01D552;
	Tue, 16 Jan 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clIeEDIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3720327
	for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444417; cv=none; b=TiZ6iaXfF0kF0Pdk2GCn3LYnGCHgMSZ3wFFoUe0p+jq0DuagXdnHwElPKihN7hcX01VQPOI+iAtax6xGnvo4pbROZplyf+JB62ms0rjq7Fu50GAkmuwyvCi8KJc0q3TnCm2ZyZqUYRY6NRhkQTQSwF+5pXS+hPjr3x3xzTcn6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444417; c=relaxed/simple;
	bh=bdf0+zjZGEqKrUGL9QWqro5EVuqZ8E+cIe8uCweJ9Mg=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=WxLuByYMOwW9Tt8yZOnA31mTLsqEnvW4lHq8IRNLLQWQZovFbCIBuMhRM8CtuRs1fF4+oa7jgUNrqrJRBvWCls1E8ZIR1Ako8HbauVEx/QII1Z1JcgIG/P4wVlwSt3QsYKcWoWcVMbFLAbRu+iU90s1wH5rb3k4nYQi9aLQ/bcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clIeEDIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A224C433A6
	for <linux-pm@vger.kernel.org>; Tue, 16 Jan 2024 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705444417;
	bh=bdf0+zjZGEqKrUGL9QWqro5EVuqZ8E+cIe8uCweJ9Mg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=clIeEDIZkJlCW3wsazc22GmvBIOvVJvFYKkX2l8Q8NbgDN6xBaZrYAC7KhOasl7GF
	 nOYck37v/75grJrIApHK7ZjFPh2f9vck3vffSw9fbWeQnPpz2UCJZInafFjCHeu1AS
	 IYZTGGRKEPsNU8tv4LseJSu+NwQsC8EGH/kerXloAcudcZ0YyJCJqr+czXbfWJ0b57
	 9yus6MKJndMa4j7sNYbdjUVoqOyMLp/aptez3RESSciWcPUqnU4q0KtX9kmi+pPSNt
	 vNBNeU9FdU9LgyPPldJZJJt0HrbfE7WFo2ycuxSeRxYnHq2TTSO/sXAPrcLKgWKDXb
	 oB7cKfetoeGlQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38357C53BD4; Tue, 16 Jan 2024 22:33:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 16 Jan 2024 22:33:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alessio.disandro@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.description
Message-ID: <bug-218171-137361-66I2ftGMUe@https.bugzilla.kernel.org/>
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

Alessio Di Sandro (alessio.disandro@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #305722|ACPI tables for TR3970 MSI  |ACPI tables for TR 3970X on
        description|Creator TRX40               |MSI Creator TRX40

--- Comment #25 from Alessio Di Sandro (alessio.disandro@gmail.com) ---
Comment on attachment 305722
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305722
ACPI tables for TR 3970X on MSI Creator TRX40

Same behaviour on a MSI Creator TRX40, TR 3970X, BIOS version 7C59v17 (late=
st),
CPPC options enabled in the BIOS, Linux 6.6.11.

It may very well be the board vendors being lazy, but it seems a bit fishy =
that
ALL of them have the same CPPC problem. With my MSI report, aren't these the
entirety of the TRX40 boards?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

