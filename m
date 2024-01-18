Return-Path: <linux-pm+bounces-2350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF95832071
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 21:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F8289259
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB41B96A;
	Thu, 18 Jan 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seUKZlKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA32E821
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609369; cv=none; b=ei3rI1FG7oxJzMkY1aq+74lGc/HBIdxCx2Vnl4NwTtiKnNhpeTIS50kGgpIGltQMbDLKg04qwVX5uVxw9BuJgO5GBUBRr8uRa1Mn7zkJHBKQAAoOYPyuXBMTwSamZBegZVzwd9dFesRj5QHvsdP0qQu8DDxRkGbVrABgc+WqHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609369; c=relaxed/simple;
	bh=3oH8XGSHPj5LJw8uDCX9NGnHmmeDkgvuuyokdGzgafU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKac1KRaE8qTF2J6So6iy+yI1RGlq4egdV07bv4PqkBQdYXOflEb/vwSAfWC4BfYNsqDqWuy2yX84FaqIj/+BjUpTHCTS6/fnrn7h+BDgmQdvFY2MJwFuePNWDKlKUjZ+upYT4KmNoXXiRsXKdsjR3684bUaVgFBJS4aOx8B1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seUKZlKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6D0C43394
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 20:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705609368;
	bh=3oH8XGSHPj5LJw8uDCX9NGnHmmeDkgvuuyokdGzgafU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=seUKZlKw5gVGWGeLlp+ttMExM8BQjFb3wRWQsC+CIlxJ53l0uKaLBYMTil8jbN3uM
	 /Tt9X0Rn/36hqrqO2qBf91pAEKdrGSIwxzw6yARwtZJDlA8JKUtB3cge24UEwGDecq
	 rzPerpX5GglFLLjJB409IiJuEhx59kytd244kDwV8Efh02Xn6CKuUu5pefHH/M637Y
	 6jK4k0rRSZXCxjadIkPTjAMRCvsR5jlLYDwIAG3GECVn+7DhzbB87uy9UBAC7awnoS
	 Nnr/y/qcHXKLN4+nOxMbAJGcZ8odhDfyH+eMHgo5EyKZvsVxa92gj7IWttHcXCjMrd
	 Ve/b/ZfmJLwIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0F47C53BD3; Thu, 18 Jan 2024 20:22:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 20:22:48 +0000
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
Message-ID: <bug-217931-137361-IOjzIcRDCD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #25 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Writing scaling_max_freq updates the cpufreq policy (see store_##file_name)=
.=20
That function through a series of events (see freq_qos_update_request()) is
supposed to be calling into amd-pstate to flush it out to hardware.

For passive/guided mode it uses .target() callback for amd-pstate.  For act=
ive
mode it uses ,setpolicy() callback for amd-pstate-epp.

Can you guys try turning on the dynamic debugging for amd-pstate?  It has a
debug line that will confirm when policies are flushed from the core into t=
he
driver.

        pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
                                policy->cpuinfo.max_freq, policy->max);

That can help give a hint if this is a core or driver issue that it's not
working immediately.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

