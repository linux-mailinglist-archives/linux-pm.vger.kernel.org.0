Return-Path: <linux-pm+bounces-7584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0BE8BE2E6
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F04B20C2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56515D5C9;
	Tue,  7 May 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSxVLJHp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34615D5A3
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086802; cv=none; b=ZLPsCVt6oFhRmKi1G/xOb+6LB+/c0xfNZR2xIIWqLaO9NKYH6f9Dw2j25u9EKwtqN1+K9mkkxsmAJWY5cwdK9zwmyDWZZC4rzEiguIp+OA7dxrhcxICQhr9Qph3fH/Eoi1XWUOi/ZkFeujip1V8A2wiIfoQVms0eX0VaLFfDE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086802; c=relaxed/simple;
	bh=cMNf9Lgr0NRsD4oeuHJYe1ithcK/F9szuGnaDrK7g4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dlBdUTYxDaGiZqcYyolNOFeTUgklgKPaDpiRy8Yjqu+5xyLeBGQn2KuUVB9IwASbuWnvutVvnc4IEczS8zJvJk6kCS47hjg/0udgMZ1pN0ywznsos/fN1OU7s9ShziShrOM+S8Tv/kSS/X3qIYDQgATNQ+D8IHdq42LsxN9Q/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSxVLJHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22CCC4AF66
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715086801;
	bh=cMNf9Lgr0NRsD4oeuHJYe1ithcK/F9szuGnaDrK7g4U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XSxVLJHplnt+m+VrSym4lkFwamWmtsps82jJ4LEAmp1TOQj4BPDzoU5sxydOvwXPs
	 ZnzPpgKBTrrrTMFwoIehTGJZgi4dtkXgeUxy6m4K7ysM1WqjGnKCq25Wzl3YJVZAII
	 ujXc33Q3YC3tDzn5P9D/DOFDGHC8X5t/AWu0I6D4llkiJk+stCjEAG3mB5rtzImu7/
	 IG8zeZbp/HUXsyX0HDU93+OH9F51oNIeJtynrMRQijNZACyuJLQ0liugUzP2/vxqYk
	 0SNM1nbIcvy41Nj10pgy2mdx4CWwaStOTMM45yepLXilvk1blR2kN0Hvbc9IT9Pr1C
	 8xzjgmLAVDgQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9AC9AC16A72; Tue,  7 May 2024 13:00:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 13:00:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-nAaK7LNO2h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #27 from Gaha (gahabana@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #26)
> But that might need patch 9 too, we'll have to see what really makes sense
> for stable.

Thank you Mario!  I tried applying only 10 or 9&10 (git am -i
./patchfromperry.mbx) and it fails in the same way.

Have even played with previous other pstate patches (latest versions of tho=
se
mentioned at the top of this thread that Perry mentioned may help) - with no
avail.

So my question is please the same:
 *** to which source version these patches correspond to and what are the
prerequiste patches (if any) ? ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

