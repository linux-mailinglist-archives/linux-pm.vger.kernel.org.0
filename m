Return-Path: <linux-pm+bounces-37250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD21C289D8
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 06:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE321891E14
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E231EBA14;
	Sun,  2 Nov 2025 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b75PrH3I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB01990A7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762060973; cv=none; b=XX2w0AOzy0bis4mztVSi/8xgTMher6KYS2eGm0vUQj4KsxL648KX9bVsF9oSXhxwjbDaBNcwXLDzdZeGPrWXGZO0pERheOTz6mQDUQBgyl43o5rAqkrtQyzKsqe/hJ69+I5ddSFrn4+Mm7gjtlsmXuynwina8O2fN8Ox8htDCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762060973; c=relaxed/simple;
	bh=Sn7F0JvalcYBNX64dTtsoRYFvDKJejKfDVw1Fyl2JmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eeWZzPLjEfc4TFkMAjCRXbpqHjoIObwdDMVMevx1sTTY1NmZyPM5MkUG7dPGpODwEy/l3aIJFc6gtz7XC4+vRaABtsCAqSWQ6TymVkdk6h3q0uR8Q63RD+EwS6LtAH14dixnXTbVZZMMIFpTfnuQ48d1xITmxp17fEC+cEVKmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b75PrH3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90ED1C4CEF7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 05:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762060972;
	bh=Sn7F0JvalcYBNX64dTtsoRYFvDKJejKfDVw1Fyl2JmY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b75PrH3Ic/1lrarL0wlOY+T474AsauIgDScybmc2RQAVorwNVX1ItIylrEGuXzwcq
	 F3R9qlFuYGH7xL2R3F9so9G83pvFG64TtocWkR1AtpAqe+61BRyOAnshto18G1vf/m
	 38r53/Hj1pJOW6WaPVUZ9UZrDGZpjqR35WGHS4PzO72v+aj1qxMSHYQphA6VnrE+GP
	 9tfMI67JFJzmWIH2TWn+d3ydEYd0acxUCXZxX0ED3zPAJDYogx2Cl35YRihL8Z7Bdk
	 F7JhWIvlHfE2rwoZRKcXLK1BWbhSGIZXxV417dEgwwPJ+ZYFpMVjvMkBwGG3iUjUoa
	 8pRVd8jFOGrFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8415BC41616; Sun,  2 Nov 2025 05:22:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 05:22:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-G2uJo3mSLA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #6 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Thanks for sharing that.  A few more follow up questions.

1) I noticed looking at your kernel command line that you have `nosmt=3Dfor=
ce`.=20
Does removing that help this issue?

2) I notice that the LLM that you are copy/pasting from to interact with me
claims that Ryzen 7950X is also affected.  Is that a hallucination?  I didn=
't
see that in your logs at all.  I have plenty of Zen4 hardware that has never
encountered this behavior.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

