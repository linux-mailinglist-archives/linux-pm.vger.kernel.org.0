Return-Path: <linux-pm+bounces-22243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3919EA38D52
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E8B188F84F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CD237165;
	Mon, 17 Feb 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzejn/rb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C119048F
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824352; cv=none; b=fwFAXyRbXPFXX15eSntOds5X0srEJiyV1MozN6HewdWwWETwJkFuY5BUq9VroMUz9dm1Fnlm3wdYCkW8blRkl7fdfVOLkEE8ZQmvzSlo9p7TP3SCZV67X+oyMdsigPXM2dQxl9spqfADCcwdx3S+OU50JJTHlt2Rl7670pRcqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824352; c=relaxed/simple;
	bh=1QmVGW7MQlCyFxTtZuQZzWjrmE21Gu4hg9szhgW9Jmk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NUjhNQYolX/W/SMifK4d+ZILefw+YKbS/h6lrruuQFL2lp2HDju16o0MPx8Dica/EZIusBe1JKTbzQ5XNkFCDL8IVIa05J+l5a42BeZtqJ7GY9XDk372DqVepukildRJDZYDamTqslzZ1rThNZcnAyFVpsY+ZaOjtpf06tirAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzejn/rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BA28C4CEEC
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739824352;
	bh=1QmVGW7MQlCyFxTtZuQZzWjrmE21Gu4hg9szhgW9Jmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gzejn/rbv+B1UcKJ4Uv5xEY+cdbNVv3fPzqRG1sh0EbZ5wXuSELqee49AZYhNz/qX
	 324zBZJl3651y8HPuBRIm7Y9KwkRsMub15RZoquu8p36MuMezBwqmC3FNm0lbjTMY/
	 8+ZGsstxA5oGFUkjj/UHKkOcuP3gysSm4RVH7jfYeizlKOCGuh9Ybgb1iD/eGJG2ou
	 zmpqugyXH5FOMaKoPWDXWgQHpWXoGBUkwelNMx+FPxw/pi6QZlcNq/sqdufBQ4e86N
	 1vVhjvLa+njW/CDimuqI2BpdX+hH1O/bMry3b/wqLQYSduus7pKBXMdqMzqOrgHbKu
	 ymZDNE8+KQOOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1650EC3279E; Mon, 17 Feb 2025 20:32:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 20:32:31 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-217931-137361-IYZZI6Hj3b@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #307680|0                           |1
        is obsolete|                            |

--- Comment #78 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 307682
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307682&action=3Dedit
possible patch (v2)

Here is an updated patch for another problem I see in this seqeuence.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

