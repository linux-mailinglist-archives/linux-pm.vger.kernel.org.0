Return-Path: <linux-pm+bounces-67-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754AD7F40FC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FED281274
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CF3B29C;
	Wed, 22 Nov 2023 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc7Hq/2M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BD2D637
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5B8AC43391
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643712;
	bh=3bjbM8FcZ2EDWHu6iRxkvKxVei32DxldI5Rvc0hmz6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tc7Hq/2MhTiWOB9csQrwyBFTUyfHpoPz060MXZNrj7T8OSMPjUhBPvT3mTdD3+I7g
	 Wcq9ttZgFfljys4vy3zT7HdqLKfrIkOXyg6pxEBq5CTdYalwBE/fGR0x4TrdMrBXGc
	 KvoicbWTkvDUUi0PnZ+BMA+AMzRAre3t9jwvdsXKbFdmrm7rpJUlM2S/NCrqGWu0sx
	 cRjOs0irpeSGMVjPxgBUnndl9FYLfVK3lpX8PaImxufAnNg5ME4AVBlpvv5snfp6jh
	 QP+ZYXl/hC9JYP29IbsRz7T1NmxArvINf02yAiN+4W7U+rCf5sQR9oKJf3N0ZTo/XG
	 mfY9X72XDogqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B7E75C53BCD; Wed, 22 Nov 2023 09:01:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 09:01:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xinglong.yang@cixtech.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-2XDCqNBA53@https.bugzilla.kernel.org/>
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

--- Comment #9 from xinglong.yang@cixtech.com ---
-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: bugzilla-daemon@kernel.org <bugzilla-daemon@ke=
rnel.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B411=E6=9C=8822=E6=97=A5 1=
6:45
=E6=94=B6=E4=BB=B6=E4=BA=BA: linux-pm@vger.kernel.org
=E4=B8=BB=E9=A2=98: [Bug 218171] amd-pstate not loading on zen2 threadrippe=
r 3960x (trx40

[=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=9D=A5=
=E8=87=AA bugzilla-daemon@kernel.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE
https://aka.ms/LearnAboutSenderIdentification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=
=A7=A3=E8=BF=99=E4=B8=80=E7=82=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=
=8D=E8=A6=81]

EXTERNAL EMAIL

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) --- Great, let me
check the ACPI tables.
Could you attache the dump file to this bz?
Test
I cannot access the link to mega.nz.

Perry.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.


This email (including its attachments) is intended only for the person or
entity to which it is addressed and may contain information that is privile=
ged,
confidential or otherwise protected from disclosure. Unauthorized use,
dissemination, distribution or copying of this email or the information her=
ein
or taking any action in reliance on the contents of this email or the
information herein, by anyone other than the intended recipient, or an empl=
oyee
or agent responsible for delivering the message to the intended recipient, =
is
strictly prohibited. If you are not the intended recipient, please do not r=
ead,
copy, use or disclose any part of this e-mail to others. Please notify the
sender immediately and permanently delete this e-mail and any attachments if
you received it in error. Internet communications cannot be guaranteed to be
timely, secure, error-free or virus-free. The sender does not accept liabil=
ity
for any errors or omissions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

