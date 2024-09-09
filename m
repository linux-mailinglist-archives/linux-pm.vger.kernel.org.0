Return-Path: <linux-pm+bounces-13896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8876971D74
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784622848E8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8A1BC39;
	Mon,  9 Sep 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZouuYKBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96618EB1
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894282; cv=none; b=Xq0AuVwMgK9CoN1CmwFNx/oHavj6/f9ZnM99yHwOiS9LzmYSAIGZ6RtWFF6oZmqU/CMVJvaqF2i3a52WVWRB6Du6wH4ssmnGUANeMpLZCpcyhichfD26fNhvsdmahL5eJZuPt1Fd9FSIetUUfsZ0R0AzY70KxStED/G1kPhvw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894282; c=relaxed/simple;
	bh=ksYEnAhpCaWApSmJObTaueILss+KQNRS0N8/Hg4Vokg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S2ngmm2ClQ57Pt2C+UGfkkZLxPPOfDrzeWB9Ng6JYG1A5lpzIpsOhH9Y9PwiOkfG1NzSmpFaG8JIradu76/ZLqQxmhPjNbIxi8y9n9aoQt8GJtk6Uc1JL9p745zlclY8B0Le4m7yGRCBbZragNqdyG+ywA4TKG6EU4Kqe6SL7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZouuYKBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C55CCC4CECE
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894281;
	bh=ksYEnAhpCaWApSmJObTaueILss+KQNRS0N8/Hg4Vokg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZouuYKBNYbS5DqdHIRPrhDUU8lNDYzTDpYRu4V8oNkK0XXBM7I0P41Ft8hBVZJQte
	 +DJPonJjDO990assoHuGRV+28qSsPXHt/uZU0zxW1F6rjDoL/faRM1d4Bjsrao0vj/
	 uK/TIs3MOGXpQmHIyVpeyJaKa9baHuRR0DRDiyIvec/TYzwnr31FHygXgzIY5KxoNN
	 NKlvhYMrcsWw2oQe6KOj3eW8QA7sfWaHiPkENMhwWb6yheTrnTuUvjCsFqYTSI0Cc3
	 1ZG6BVMPD6PQyy5iktuQQnAGCUH6pyS9nsSFF9GxPlyYmX7yTWjAPsmwFiZUTViykr
	 WKVA+VdANVJug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEEADC53BC7; Mon,  9 Sep 2024 15:04:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 15:04:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-218686-137361-IquplBMWD9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #306841|0                           |1
        is obsolete|                            |

--- Comment #87 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 306842
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306842&action=3Dedit
opt EPP register writes from FFH (v2)

Sorry, posted the wrong version.  Use this one.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

