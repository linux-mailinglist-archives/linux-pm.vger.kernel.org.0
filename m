Return-Path: <linux-pm+bounces-2342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE50831DD0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E169F1C2334C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A06C2C842;
	Thu, 18 Jan 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvMXfamM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB92C6BF
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596591; cv=none; b=ITPFkXOphRRnV/c3i4zgK5z8l21JeK7jglKjzfpX7rO4qsu2nbey/Nvla4hUPkFXSekYEDUUrncE9+I0a+afuUeDR0Cnzkqunb+0qLpt330Mxb8jDxtTTqWx5nKrvu2y6kYfp8bQ7jq75Bqd+9GdQfpycakZrzKES+63f6OnqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596591; c=relaxed/simple;
	bh=ip+eamckK3Z1jSt6OwJN57ha8o553O3gvWbkrpjOhSg=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=W0hAR2mLSWzy4KZdMBBVoBapd7ArdTMtjyXldBeDjxrT/J7cyFLCVGo9Zja0VfanEfqmc/dqyfRM5tAJuydIStf4ykAGymcVe7jBjsppGfGhKfiAOO3ZIKgn8feQMzcoQHsPRhbswCIDQA/bT93VOwWZldfcgfz5HHdgLRmt3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvMXfamM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15C14C433A6
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596591;
	bh=ip+eamckK3Z1jSt6OwJN57ha8o553O3gvWbkrpjOhSg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KvMXfamMF137fO7QXRs+nNEO9ErD59F5PpSi4eontDGnGPtHcXE2V353CCnOHX6zI
	 t0Sk7RawyNtEVvg34QbjwyFLoYCZiztplkl0emXOW3g7euQjO5bEsbYij6IfdnfZp6
	 03MLDIZlXWtAP6vrqSdXPiYJ1vIYJSm+1UggASyrhw9Dp7c9JYKqbAU7d5WFSvzg26
	 SxVy+AUnuWmXTrjTyyXj3rf0hF4/xkzJrymrcXXVI0gGxBsFMSCEI8p44mCmUzUqfN
	 mvSPRVj01CQgFiA1pA+yr62o5gcDz0iM3zfbfmUxll6DM90cubPazGuSnFC4ctIn+O
	 SEia90dCPbmOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 00904C53BD3; Thu, 18 Jan 2024 16:49:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 16:49:50 +0000
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
Message-ID: <bug-217931-137361-7KFl5aWrld@https.bugzilla.kernel.org/>
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

--- Comment #18 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
I was meaning #14/#15.  I want to see if they're finding the same thing as =
you.
 Looking for a pattern.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

