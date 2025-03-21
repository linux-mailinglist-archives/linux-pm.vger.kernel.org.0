Return-Path: <linux-pm+bounces-24388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E77A6BE7A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD88464D6C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148686321;
	Fri, 21 Mar 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc3QiLTn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89C2AE84
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571853; cv=none; b=jhjdA+jMgCW3EGrdv9vd0skVwoIh3eAoWcWt4LDtTc9PZ/O2BS3DkivDOYQ8mlxdxLGxH/4LP0FTzVH1DlgZMXgssTgzOZg9BmKdz3MdCtD6TDhELcsnwj1iLL6Hl7e+21X9Shyap7yJkgja9NeB4micRkWoWXx19LAwvaNtWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571853; c=relaxed/simple;
	bh=116WygNXi88iNjcZObSUExuEGZ6fuXd3KxO4E0G03Yg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oT4N3fl8J2V/5vRLrlsHCpDAVOu6m3Ol7IBbxBw2Qv8M5i4rc6NRhQsQK47v88hD+VxBcDCWydgwIUgm9ZPwNRrq3S2yLaeJ5wUCIU/L87IX9d3F1Wq7I82fHCwksa108FfqtVC6XeklXW2oygMa0n7Hg2HsPocPrEMQrMzEaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc3QiLTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7380C4CEEA
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742571852;
	bh=116WygNXi88iNjcZObSUExuEGZ6fuXd3KxO4E0G03Yg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hc3QiLTnWs9MlHuG1ALKzON43i7z+eog/pCcYHX/zL0DAC3MMbujqF55Gzzz0mtTd
	 Vjpk6mT0fsIMw20pmIsdXst50to/OJex6WMIRtq02nievuDo6ImR1cOcx5zFX6i9w1
	 TfwBucwiHQ2O3lKZq+SNk8CGJMHIYunT/QB2Yyqg+xoUlG68gWFWJ+E6MdBW8rORX9
	 XdkHSUZukcn7zls/tAe9FECSNXJWdi3fkhCyK09zmssHE2smBYLHugftfaG7sk2lxH
	 1JRasIT6SbrOtNo9h/8jMlqjidZAp4vLPkicUFewlF9U9UzATBCY1avqUulT6u5Uzs
	 sIFHAwmyZcD3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BFC0FC4160E; Fri, 21 Mar 2025 15:44:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 15:44:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-NZ1ualqjtW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #3 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
On 6.14-rc can you please run this script before suspend and after suspend =
and
share the text reports it generates?

https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools=
.git/tree/amd_pstate.py

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

