Return-Path: <linux-pm+bounces-2316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78573830EBA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 22:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5AA1C221CE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79425576;
	Wed, 17 Jan 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdnfE9U/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7F25573
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527747; cv=none; b=sDRLXyOJHRog5yrppN0UwEG6n/ZHbP7xFEh9otWv8XdODIGJKzx3+r2Xyd55tNGQKv/60NRjKcoYGNyolGxqMOmqF+CgDgwT65WddYbIcTmpiEN+k8N+K8EKswj40HHXHV+G1w+gi8hyXtgOHlc2bRfaTF3biULh3quUZJqYId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527747; c=relaxed/simple;
	bh=ztdu1sJyfHMC1ebf0aKOQeZuPDlfELctSlVMLN9YgPs=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=mr0I6Nqx2dlrDewYr6EWO9/Z9qozRMeBLxoQO56vpJ8qw8G0DQgIRdmyXi76XzXVfYA1KL3yZrrlRWrA6Ni9LU4RN51x4UTvStpp0k4d/WF5FpVefwGyTOJmOxRXsJNMVVLmMrL4CJYFfjDBw60Sj8EipwMdYksgzZkJN59X0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdnfE9U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99F48C43399
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705527746;
	bh=ztdu1sJyfHMC1ebf0aKOQeZuPDlfELctSlVMLN9YgPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mdnfE9U/06HUz7tgERXhJvqt4XRt7aIUibR1HLT5lj1rrEYy+FH4hhRV0mZLuTbJ6
	 Nk1HLD6PqdmnJ2IDlK7SzKWAuP1D1MMGXLVRs7bHzvprb4/awufx6n19K7iYOhuB/n
	 aO799oewvlQ3l1Ofci7kDM7d00KNiFH0e/V2KDngysHx5AFcZpp7S7WbqKcOrn3hBU
	 vQDEbZb6ktzqz1JJ5JrRqxA3U4JZ0fSKVfelFf6Mu9TWlpRCl69/mgstS++w/fOJWq
	 ozltDTzq3UuDOs78LDzy14eDuTij7wf/5q+ExXHGovHyS7amCrQC+3upCAEPcPAGd7
	 AaOFXINISJBLQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83FC3C53BD0; Wed, 17 Jan 2024 21:42:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 17 Jan 2024 21:42:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-GSP54rYXPp@https.bugzilla.kernel.org/>
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

--- Comment #28 from Gino Badouri (badouri.g@gmail.com) ---
An update regarding my Asus ROG Zenith II Extreme motherboard.

I've opened up a support case at Asus.
In order to do so I had to register my motherboard's serial number which is=
 a
bit cumbersome if you don't have the original box as it's written on the
motherboard itself and you cannot get it from the bios info.

So in my report I've described the issue where I have CPPC and CPPC Preferr=
ed
Core enabled and the amd-pstate driver not loading due to missing _CPC obje=
cts
inside the ACPI tables.

They got back to me and asked me to record a video of the problem.
So I sent them a short video, showing that I have the options enabled in the
bios, booting the Linux OS and finally logging in using SSH and showing the
amd-pstate error message.

Yesterday I got a message that they are working together with AMD to find a
solution.

I don't have high expectations that this problem gets sorted out, given that
they've updated the bios several times (last update is 6 months old), witho=
ut
even trying to ship the latest AGESA.

But as they are at least talking with AMD, I urge everybody to open a suppo=
rt
case at their motherboard vendor.
The more reports, the greater the chance that either your vendor and/or AMD=
 is
going to take it serious.

Just my 2cents.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

