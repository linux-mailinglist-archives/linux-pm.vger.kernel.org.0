Return-Path: <linux-pm+bounces-7098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4D8B2507
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDB1C22BE3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28214AD19;
	Thu, 25 Apr 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LotXmztZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EA14A4F7
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058728; cv=none; b=guiCnz2K88XjV2B8MLeFRbySTwp3onNbiRZAdZVQMhfvPiVngdBBYxbtQXIcLDDT365vKNdn+PjXjKpgxA0hMN4xALagbzO9J/KlN2bK99HAuseUjdwB8qDLsoicPFgWbdZ71IZtrsRBjBeEU9eV7rpiuVhO0R/GP6yR8HtqAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058728; c=relaxed/simple;
	bh=kw0OyajsJtkHftb/67jG6AlFbhJmogH1Dzrh+ULL5ms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9SgKuCJmAF6/uHp2+huAtKI4yC1vmMX/85Mx6nvnptZxtv1DQi45oNx/bLWdRvrTYFwvnj9VQNWkwydt5JZO1Y3vcMQ/epNb2ZZ5OLizpnZCt8kyRVdcAE6oupdN8FjiqLQDGc9M50ZJUfg7oRxZ9pDpOi5ohy8XA9oB2P8nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LotXmztZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70215C2BD11
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058727;
	bh=kw0OyajsJtkHftb/67jG6AlFbhJmogH1Dzrh+ULL5ms=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LotXmztZvSfRBJH5Vdx0oyGOSurBKuI01NMoKGVlee7g/4ijX2xxOYbH44k5Ewsd1
	 YV+6cBVH4/CqDGjHqAaGRAneE+GqG8SGkDmCvYpfJpasSf4MhyJrjCvfobHHr0ly/8
	 aRr5lj0g9qRLjG+OUFb75cOkxF77eiae7NeWdxSVkY4IikSLm2eWmhmyuCMNbNGTPX
	 gcniAbquoKS6bW3BV787TYjKHdZwtzaNjEo+fxDzJZv1mu6HLTmlVrmDb2qlPgVd2U
	 UcxTzrAgrWM811YO5HcDCzjXU6zQFMYio9F/IFqZUhA8Y8FH3jU0SxkkQ1XOrQKCo/
	 6r9XIHES+AWIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64A6BC16A72; Thu, 25 Apr 2024 15:25:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:25:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-TsNUJy8Knx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #9 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306207
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306207&action=3Dedit
cpufreq_grep

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

