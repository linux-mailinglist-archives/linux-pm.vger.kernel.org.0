Return-Path: <linux-pm+bounces-14968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820598AA91
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A10B288AD7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262D1925B7;
	Mon, 30 Sep 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0agyBWU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C8191F9B
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715891; cv=none; b=pVGVlyv0v5T5XdI26WrUk1BJR6IVh8ZIPPid6jAsUUsZ7lufOqig0A6RDnU8BE3L0uZck8HGQjttfpW1ZM8eqFGD3Y61j5+eDPfc1SsbJog5EXtMYH/Z5s5J5fbm7TeZkGW4ykC2JLbSgbryfV3ip3O60tJzKxdiNuv7p+keMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715891; c=relaxed/simple;
	bh=ezdp1C8xT5Oa2bu7esY6ORBiDiq8eTEqvncCpezuBRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0fR6Q067tjtdjYhiOYXS/FlZcaQjB3mPnpO/VLFLnvyPRPROR8kIs2BcAJTwygnWlxLt23jidFxHfPjOZlp68G4udGwlznvvmCF5qMoBj8U/6vA3VJfFoi71UzHuMuLHapmoM4rJRxj/JzGqXRLkxPiOsunxh0xUx/5XVEquYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0agyBWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8084CC4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715890;
	bh=ezdp1C8xT5Oa2bu7esY6ORBiDiq8eTEqvncCpezuBRQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k0agyBWUyAvUZnPoJP49H8AFDB3oSjwN992JO3LMhLCmGjc8UltVMqZkXIQ7V5Gz3
	 cJBgkPj3R8vnBVFQ3pT70PdJMovQMRQI9EJooyg3RDHVFXSQdyi1jGYz/5bPxjQUU9
	 N6l9pEdiJnd2NBk05n/wnJXvJ2xljCzMJ+ohSbAPloBx/z5930lU96oHHFfu43CQJJ
	 Sl83Xkq5GzkARL+pIpGeZ5/U0rzVcum7Pk67o5OGyIIZCd5YM+pNCh3RKbC++u2Fqd
	 Wy8dLtCRiFzWVbUi7hoUrs5e7KNlfKRtFh17oxmFbWhlBH8SN7zOUJ5cExTHyZVWI2
	 PZ25VinPKEJCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75AB8C53BC2; Mon, 30 Sep 2024 17:04:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 17:04:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219332-137361-IzTzDr8zHR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
When `amd-pstate=3Dactive` whatever is written to
`/sys/devices/system/cpu/cpufreq/policy0/scaling_governor` has zero effect =
on
the CPU behavior/system thermals. That's what I was trying to say.

I wonder if amd-pstate could "simply" hide/disable (i.e. make read-only)
scaling_available_governors AND scaling_governor.

It looks like these two "variables" are remnants of acpi-cpufreq and should
_not_ be exposed when amd-pstate is active.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

