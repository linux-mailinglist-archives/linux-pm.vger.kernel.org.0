Return-Path: <linux-pm+bounces-110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1977F5A00
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 09:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5551C20AC4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09146B0;
	Thu, 23 Nov 2023 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puem4rl9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45F1C6B8
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D518FC433CA
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700728209;
	bh=nVP1s9nKn1853OpbrLrctEaMRm7jgev1Xg7lkCKr6xs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=puem4rl9zHNGL8lbgy+YPthHOxSDmCBG0l7Men+5aGGevg7y3oWLyTWhZpL9SKKQ9
	 2GR1WxnH7UNyeaEkoThIC/vkBRpgik8FHk3wp6BseNmrA1CeaooFSJNDLR5EqphmlS
	 Qggm0zqs15YIAQgGEBpNq5J2agaGTiqoDrGuNBZa2XfUJPxU7jAzGOb5NEYpm50A7r
	 jieqvKsoGmiK5ZTo/5YZxEofi6aEP84EiXNCj4z3nWNk2OMkhqTYm1drC081O31Qdg
	 YxVlx2ahsvq37fPS0ViltsD4b3M4oWkCFZmd+WMrAir5nafQU2IH13SJ68xnPlCPRQ
	 HY/NmLsDbr8HQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEEA8C53BD5; Thu, 23 Nov 2023 08:30:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 213115] Unable to set the lowest frequency of AMD CPUs via
 cpupower - while kernel 5.12.4 (or 5.3.18) is booted with "nosmt"
Date: Thu, 23 Nov 2023 08:30:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213115-137361-jqbPJAT9hP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213115-137361@https.bugzilla.kernel.org/>
References: <bug-213115-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213115

--- Comment #3 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi Johnny

looks like you are using acpi_cpufreq driver instead of amd_pstate or
amd_pstate_epp.

localhost:~ # cpupower frequency-info
analyzing CPU 0:
  driver: acpi-cpufreq

Could you provide the output of "lscpu -ae" ?
It will show the frequency for min/max

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

