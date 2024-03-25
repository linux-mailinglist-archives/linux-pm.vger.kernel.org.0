Return-Path: <linux-pm+bounces-5271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D047889B3A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0691C34307
	for <lists+linux-pm@lfdr.de>; Mon, 25 Mar 2024 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1E14D6F5;
	Mon, 25 Mar 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPoplnL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFF152E19
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333735; cv=none; b=GZERv6bfihCR8edmJ/f7snT7kq6ALWo6eKAFsmJNcWTPX3rweYlzZK99v1yWYmcUeM2v27LHG5dPtJZ2rTztLy7+OhIaeUe1PlszdFBxcHtQq9stWgjK/1fKGi0Inwr1uwu2HZnvdslpnJDRcqZn72+2srnzMOFqFvAvucvcors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333735; c=relaxed/simple;
	bh=eQu5z1Saityzh+ELjWZW08b6xDU0JtkLnbt8JAyzPBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzrkniZny2566WIBI/GQ/YpFMkISE/wINpbM8Y5yC5KiAU/erwzv7Ihqtx/JDnmYGkJANgDNdawhGOKWnzcjawR1NBiejNQ2EWliNU75m9+2tYJm0V28VE0YjvIBPynmNcluoH/4FE8BEu0h3L3mTlXup6AjEMxcfXm2UJm1pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPoplnL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5084BC43330
	for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2024 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711333734;
	bh=eQu5z1Saityzh+ELjWZW08b6xDU0JtkLnbt8JAyzPBg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IPoplnL0gkRWqY6inELh7Wqk0YgfEVOp9cCUoY0mDMiUdUYtRyJsshimwUjwNAymt
	 fMnuFUMb2kMPzEpRxBL4F+H2qEzunR9pYEHjzj5GHEkS1DHSbEh1q4buiDoQlE0zXn
	 KsM3YnUjkvH53rHvtK7BcuPFVQq/jJFHhVrOV5FoubtzIIeWsbq3ITjvaevhQhlDxM
	 NE0zx9K3DeiWVl9VGuFYYBfKuQT7aBCwX/mlomg5/205Kd0AT96OsMhc76CSuGw+2E
	 e7atbeLNuaOMS+r6DP2LkWcmG7PRISAObRqE1Zq26Y+GUPDHYJ3j8sdEMbEoTDsDzq
	 TuROT6agBlMZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48810C53BD5; Mon, 25 Mar 2024 02:28:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 25 Mar 2024 02:28:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-zky7UTFTh7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #47 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
https://lore.kernel.org/lkml/20240324230116.1348576-289-sashal@kernel.org/

The fix patch has been merged and backport to stable kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

