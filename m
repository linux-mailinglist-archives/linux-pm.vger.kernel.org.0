Return-Path: <linux-pm+bounces-2343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61194831DE6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031A11F24674
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669122C1BB;
	Thu, 18 Jan 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPusZKQ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E12C1B1
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596850; cv=none; b=EMwGaod3ka3vPDlc4lGtWqMzNj84j1cowigMVe/sqPEKMEnTeQivUfxZSHCbF/yxAICSSWFBD960tVFZuVmG55K1/a+HgZcfPg8+rGgvmtRoKFkdFa3La4kGNi4rO5+6Q+n67ues/seFVTKOyXIF2/c8R8CxhPhbq82CgrI24Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596850; c=relaxed/simple;
	bh=FRDUC/x/UfDwKlgvn8+hTL2jUQ+eaHa3Xd9/8S/XG7g=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=OluULUZZHP/QZUqjLmyJ74NVmkp3TNDjOlrctRPCdatkq4UznRPH2KkkQ8SwAgPFL2eCYJ1NgbC8KpRnyModILjAUEgRGLVJdVQH1niEirX3vuiTPreFD6fKG7WJJlqG3Z+7yG03ZVsKwsI/V8xlhiLQSeoG17lpJIefVgdE2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPusZKQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1447C433A6
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596849;
	bh=FRDUC/x/UfDwKlgvn8+hTL2jUQ+eaHa3Xd9/8S/XG7g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dPusZKQ8J46gmmy7lt1cAK8ZHRI6onJ9nyfut/JmneHnmOZtUt8B03EbASB8ZQtDm
	 f/nDxsnAR0ATRfu8IaAZ3p+7OYezxKh5/61XVZGBN/X937FeJH2MDXsdAMx+28I6WA
	 iBSL0ffs3LwwOIMn5Fw5rgQFqlTS0VnRFfq66kKcQNTRElzy3mRCudpIQ/S2SB2pJA
	 Q7Zr+SugwwOFzLxUFINaiRGIPl1DZ7/q8X9owlww/DGTuq/t10mYyREzBE8DY70uJZ
	 cm+18+KRQlqLsYuBpJesgEn+2ODWu8tvBj0Yve/UzWmbq0nGZBzngH/DR5lOOOz8Z3
	 6fEnB7zOHqeRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 95ACAC4332E; Thu, 18 Jan 2024 16:54:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 16:54:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-A2OUnmOzPS@https.bugzilla.kernel.org/>
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

--- Comment #19 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Mario Limonciello (AMD) from comment #18)
> I was meaning #14/#15.  I want to see if they're finding the same thing as
> you.  Looking for a pattern.

The amd-pstate driver doesn't allow to set any frequency limits, so I'm not
sure how people here have achieved this.

And I'm not using acpi-cpufreq any longer. I like amd-pstate more since it
shows CPU cores frequency better/more precisely.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

