Return-Path: <linux-pm+bounces-3156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B398456B8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE04285A51
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6315CD76;
	Thu,  1 Feb 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0QRo4oH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567A15D5A3
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788886; cv=none; b=VaYMQ0iNkXDfIG7viirEv5bXbf19IusdDkNo7oa3cVuhX9hOL5BGR9HSKSaPGa044jVBqsA8/v9H1GjgIlCj9mbPg3UarHzsrvm0hZLvRgmvilqaRmAOn+qWJICdO2BYa5l8nzncuOcs7CFRa5Fap2ixIf7Ey8hc/hSacC24Uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788886; c=relaxed/simple;
	bh=pljrbNa1L1hsH8ig6iwuiy075gM53Pwrej4ODQ+xqiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iD1V6mhTESrNBwA8UYRF9wb2iOFSoycg+VJljMvlhTzVj9BQZ+gbotaYXr3zYCuqnYX8yUsPAAnt+AfcB2+nmtSr6ztvF4TSgoR06P0G3uFML3wgC9YKcKHFnKAWuDFOukB7wsslhPausCt2A3XSYiFKIxd4/4XrOH4Rv+h6qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0QRo4oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EBC4C433A6
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788885;
	bh=pljrbNa1L1hsH8ig6iwuiy075gM53Pwrej4ODQ+xqiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T0QRo4oHbQzS5BnWx423S2mRjltFBZWtt3oJVFw8cZTUQzxEUvQR2QrOrqd9CNXiQ
	 dJ2dBC51QqDtDkFiExuB4xyL1ABYlNbJCT6Nf7R4Eg7EnTb7vRGZQuzHC7TxDIE8it
	 21uv6a771CTPazKblZKD2efUphLtuihCgZAAtmk/PayvhUda2s71GFNfOiCZroEy0u
	 xji+3K8g/oA9AD8oN5pzZQBplVr73CXULKJtZD3QxFBPeHr1nsuuvN/cgBGieaRx1e
	 +27HX0acNGqs7Yg6m1UmFT70KBTT2HO3ZI5ep1JlQvT4g+dZhIcvkwGwHpE0m6CtxL
	 fipt8XPBstong==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8C01AC4332E; Thu,  1 Feb 2024 12:01:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 12:01:25 +0000
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
Message-ID: <bug-217931-137361-EecOgLBvLi@https.bugzilla.kernel.org/>
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

--- Comment #48 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Did you pick up
https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.limonciello@a=
md.com/T/#u
?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

