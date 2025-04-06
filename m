Return-Path: <linux-pm+bounces-24849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31BA7CCE8
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34413174E1A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AA3EA98;
	Sun,  6 Apr 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibqepMym"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3022E62B0
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743922284; cv=none; b=AQPIkhh3YzoJJ0B37AJkDzHjiLhOaIFpNjZ/TxzMhshkiVaHQSfwf1NIwgDoB8Oc20oI+dTVXUcHgsu5IYkQZz5qh5SJuNtxy7YA2f85XwZnjoHtkZV9JBEqAmprcKxLuMC+bsYufvbU1tiYXiuCWmOamBRFpSYbDTf3VJvtwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743922284; c=relaxed/simple;
	bh=JLyKJx+o8EPJMfEFxabEKs9JHoh88AVdUtHkNFMR2w4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgo1xSNN4d7//f1avMtAPo+E0YFpd/zatdFtLsNWwNN0cU9T/MFBG47UIadt+LaYgYRdA3LfYIwWD3jZkPI/Q5v/enFXs2y4blF+r4QFRuSAHyIXzAKou3jNVVLHfJugjcEhecUDnwv0+e8eTEQU9GfQoInjarTXxs7Fmu93nWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibqepMym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCF5EC4CEE9
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 06:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743922283;
	bh=JLyKJx+o8EPJMfEFxabEKs9JHoh88AVdUtHkNFMR2w4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ibqepMyms+tN7dMKKAMFsgUnWNHgUqBfVQdM/ECmCoBfNw499yKrx3cmxcF5d1fEO
	 v9V9UD8cACBf7W19hGDpDF8mlZGH5Y1wdDDZc8ZpnHOqJbFQty/9HD2vkgQ9fBypWE
	 pF9L4CAuXeSkp4tySDGd4MEq8wcDqNtguzNyo9b/UnVYrg9A9AUWzYk1zWLzI8gzi9
	 GKXawZN4oiZMtgJQj439E4erHu5Bo7rOreCsqg3KnC5WaA+vHjpY/cAE2bhZ7ErJfE
	 hPxUc0pVwNghsRHfFQy5ZkB6F2eyupw8cQj2aX2qhxQLksJUw1m5Ee2IvXLwfgKNwW
	 07yCqLnVE2bEw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D176AC41612; Sun,  6 Apr 2025 06:51:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219966] modpost: EXPORT symbol "policy_has_boost_freq"
 [vmlinux] version generation failed, symbol will not be versioned.
Date: Sun, 06 Apr 2025 06:51:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ubizjak@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219966-137361-R7GGniLu3i@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219966-137361@https.bugzilla.kernel.org/>
References: <bug-219966-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219966

Uros Bizjak (ubizjak@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ubizjak@gmail.com

--- Comment #2 from Uros Bizjak (ubizjak@gmail.com) ---
The patch at [1] fixes this issue. Actually, this warning is the
root cause of previous report [2] and is due to genksyms not
being prepared for new keywords.

So, either genksyms should be enhanced or a workaround [1] should be used.

[1] https://lore.kernel.org/lkml/20250404102535.705090-1-ubizjak@gmail.com/
[2]
https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c035@molgen.mp=
g.de/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

