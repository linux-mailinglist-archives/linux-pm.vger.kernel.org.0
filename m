Return-Path: <linux-pm+bounces-6761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F258AC63C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1B1F216E0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123454D59E;
	Mon, 22 Apr 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgUg/DH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CB4D58A
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773087; cv=none; b=e5ulsg/p70yds8YL8YRBCLmLsYQ3DdiXYZ0iaBL/TAgg66iMEisZexpQHsCbvPljYQrt25OQoPNPWi+/37CR2h98W4kD8hcWyDvon7hASuxCmbcEZdSbtqBkU5OGt5i0XHL/N2yHrT/nYjuHyJ9NHKmBFCBpLnuat4CdnVbwChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773087; c=relaxed/simple;
	bh=VAY9UTlbrVR/xcpA5OGnngA0COeF6w8LNP06jKomXEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnhIUkIYWcokJf5dH9EU4YHVBTrQIcTFClFtRwDjd3Avg9mwJb4qiYSWddJ95Th1KkforSnAUW/DZfRsHscDVfkXH1kpyNQmMfzLw+poOcppANTVGGF/jQimIkCU0MfoGFhrCNKwkTBZfkWh/VpSwBydJ3AWKiC8+h69Hu3E2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgUg/DH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6493CC32786
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773086;
	bh=VAY9UTlbrVR/xcpA5OGnngA0COeF6w8LNP06jKomXEk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GgUg/DH75oPb8EJaF+58XDmDMey1iu7NCvnBUrofuwGFQFmyhZmxK0h2oXBkAZIxF
	 ijdED5na13EQpZ8c7zUeAX3CHnBaQTUdVGF8vUCfivw53cbDGxn0HORf3tm5TIOPCU
	 y9/b+vzx+F1M6A53XOcFAU4ATPQerKfeHds5Fct2n89rb/mg3MlB6FH4aUTOnux0iq
	 QP1oFgwojqV4tq9EOzlBU/e7SFCAq79qTz6ypfXcVeR6FH8JyHg3Duh1u98+NIFtYR
	 +RH6WzLQwganE4lsDSjCgIbflzFG01P2wK7wy9QNwWsoBOpJrPTO8Pq3Ens75K6shD
	 nLkrB1hHl1kOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5644AC433DE; Mon, 22 Apr 2024 08:04:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Mon, 22 Apr 2024 08:04:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-eRRg4Tq9WW@https.bugzilla.kernel.org/>
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

--- Comment #3 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Created attachment 306192
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306192&action=3Dedit
cppc check script

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

