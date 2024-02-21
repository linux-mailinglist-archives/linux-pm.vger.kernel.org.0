Return-Path: <linux-pm+bounces-4200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDEB85E3DF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26001F222B9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2982D97;
	Wed, 21 Feb 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMUnOIKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37482D7B
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534765; cv=none; b=sxZcV5cJNEGiXIPweQeOEiwxd0xer63iPF7qI6igvVlcYy0sT5c6FF8NlGI1d8rdKNVE40GhpK/nR68F7QBwyJPNMpA7QeexkZi9w/nBIiGYXQLWypOfvtSv+ctmFe0MCrlEXehkiBHAoz9Cj/ArJF/Ja8Z/oEuMJ9k/OxkT2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534765; c=relaxed/simple;
	bh=bxnugT+f7a2/XLbT8XhNumS0oqDwm3RU10gOpjfVv1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSzS5oPlwDGTa+Mkpt+5BYrsGqKZWQk4YsCDUdNQucI+RWq0kAbleypznSwuxojZiiAkR3e8MdMyzyOEadUhlW1rCFwcnpxQ1kurW/pBbZ1uRis2mztsaZv1bJk6N0ZY4RQAUV2CN1pZck7DJDcrhdqQIIjZctbZRY0AVckXH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMUnOIKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F23D6C433F1
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708534765;
	bh=bxnugT+f7a2/XLbT8XhNumS0oqDwm3RU10gOpjfVv1s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sMUnOIKYf6n10C8RL2z7eAREL7TyShebQ4ohlGz7MACtliA1AglCTztV6Jkv4ahQo
	 Q2qCI9YTLMy96duiRQA02mJ8GtZbDsOAYmLY4ZcZgRxkNgV3XXg3hSvSiO5r58DNLa
	 ms2a6BWYSnaZIYNcXA715snvQdcGspSHAc9Y3fEqy7lofkGrSlJRv9Y9sa7TPug2pf
	 lCOfM1W9bi3TrbL+dwGDga+hkHAmXZyb/Pe8qkHEU00KPVQig52E6pOB9QcRE9/uHF
	 x80CASbqT2Uh+a3Nijx6EJFXfkSRSsBJ3rCZkzTZYZtb4G/r3KZfvflVPAunU2RN/8
	 i0BUr71kRNopA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BCBD3C53BD0; Wed, 21 Feb 2024 16:59:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date: Wed, 21 Feb 2024 16:59:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ansuelsmth@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218041-137361-wPpAj64Y7L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

--- Comment #6 from Christian Marangi (Ansuel) (ansuelsmth@gmail.com) ---
BTW this has been fixed upstream and got backported. This can be closed as
fixed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

