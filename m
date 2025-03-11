Return-Path: <linux-pm+bounces-23818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97956A5B7FF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 05:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E283A8A6C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 04:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42AF1E5B79;
	Tue, 11 Mar 2025 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR3Wa34p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23F1E47B3
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741667250; cv=none; b=tCRS23cLy7oDYxLVCCiugGsn4IW1pbN6swvRKqhgg6X4uE+qZb1otGG0Y0Y+rhcWcfcnFaNNpsEp3rjWmyL3+TCaTLmbL54YauijnchEZ06+BKdv1We4nZ7DPMVT64iZmiga+UCwgP53Qin9VzPhZYbzb8jnq5yVwT/Xpf6tdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741667250; c=relaxed/simple;
	bh=t6nty6gEH8DY+hl39oJjabWQl4uCQ9K3H8V7FLliRHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkesYkS6jtk69nplAEXJM8cYZWBuMXtEsCkLPUuAwWjy3Tz/0T+Xk9CFDW/kcaNvz4PI9RfwSo2vDKdv/8oRfYdZl15cABag0ofQKnjRObJf0uocLOrcnXNoOf1NUZ7f8NbjXbLsfRhcuSxg/d6ssPJil3VGFBKW4GuiWdOKiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR3Wa34p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89215C4CEE9
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 04:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741667250;
	bh=t6nty6gEH8DY+hl39oJjabWQl4uCQ9K3H8V7FLliRHI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SR3Wa34pfnJxg0+mkCf3WZabyRhjI5CZdsOj0chJyU5r6NAVfk1BPaGDI1OZ2nolG
	 tvfsN+97UM3sp0JIjpoDuuii/SO3yM5tlxExh5aipcH+qQbZOcRK9KkSK52A+c5gir
	 PpnCrVSau8R5ZJDNRf/gOufD7l3WNH46lgAbebed/MyKX/PqaEdHJt0Jf8ae2IG+EH
	 GcNQLboF9wuis9T+lNddBuipyB2MX3/Un2WI6cnfxdoGEE0DxmI6pfNEICw3vP2ACD
	 20ZPj9KRo4y+kR0ZdaoVcDlrejFxORZrq7hYBXH/+Ix4JWi8oW30GDBRa1V6tuFJKu
	 CNXKuTZCmQVRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82E80C53BC5; Tue, 11 Mar 2025 04:27:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Tue, 11 Mar 2025 04:27:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dnaim@cachyos.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219851-137361-GDmjzIjg5M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

Eric Naim (dnaim@cachyos.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

