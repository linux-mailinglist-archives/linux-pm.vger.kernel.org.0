Return-Path: <linux-pm+bounces-4814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2A87777F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E75528205D
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20442374D1;
	Sun, 10 Mar 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbFuYLzJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40222618
	for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710084795; cv=none; b=uj7DPQ5iHT0VLjIKb6n5eSNCCcfwJzYu0kfPQS09ZbT/KVpemqXUtu9GLcdRPCUS0O69Re/WMlRaKyZiJlv/tg+GJwTKBIkdW77eb70mXTDDczkf63UZILAqy6sqfPj2T9ZkTjjoX8cMFbadjm+7eo0KYlGNapMmv1KAsWt2eAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710084795; c=relaxed/simple;
	bh=OXfDOaw05wCDN3RwbK0FTmatV1N8wRVQipDT9Ftn4so=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRnGIR5ipYm1jLisAk3gnbWp3BblSD9v47oESeflBp4FceDqSYIngxq+AVwA3NTI7Z8dVhL/7CK/QTh4rOPmg2HZ3eAoOC3+2X2/9RxzATK+O8YyNKi9Cfm6p+HCLFbQvbStWMBsMyoynNiEXIbfzd0e/QhdGLJJ6QS/lhvr4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbFuYLzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CBD0C433B1
	for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710084794;
	bh=OXfDOaw05wCDN3RwbK0FTmatV1N8wRVQipDT9Ftn4so=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UbFuYLzJujbANAtLOGotLFKsZEA34gGe8uHjEvohCYAX2UrDRIeJT/N/5Sd6OxKWd
	 FByzElVO/HsllqC2axJtZ30UAuIdvslOcpaueRs4CaJ86CxKxZRa2x5n13ZupfFfri
	 9H6kZyoe1zkFWE2afLxYEYE6c8w3wMqG409EZeh89uJpd86GRiksNvP4cW8w9B07fo
	 UhZs+p3LD5heQaIFkIf4UYbSJAxIAfv/Ji0wJBk2LKioI0Kqj0slmpanp1e2CJC0dK
	 3IxvJMZNUe03bUUssYIis2q8m7E8Lj7Ywd3Pke23JVbcGNFk3CaiAmiApeWk617sST
	 dPAQmWkXd+1tQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4D065C53BD2; Sun, 10 Mar 2024 15:33:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Sun, 10 Mar 2024 15:33:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vishalrao@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-8nASCd0NPa@https.bugzilla.kernel.org/>
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

--- Comment #45 from Vishal Rao (vishalrao@gmail.com) ---
Hello,

Is this the right place to request this bugfix be backported to the 6.8 ser=
ies?

Phoronix says it's coming to 6.9 here:
https://www.phoronix.com/news/AMD-P-State-TRX40-Linux-6.9

I've filed a wishlist bug report to ubuntu for the 24.04 LTS release which =
will
carry 6.8 to start with, apparently:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2056686

Regards.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

