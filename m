Return-Path: <linux-pm+bounces-3238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4128471E6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1908B29C58
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084747A4D;
	Fri,  2 Feb 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umtqzjKp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EC17C77
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884140; cv=none; b=d/yaDiUa+m+XZLFP9y3Zerp38luId+73/qN0AidDrbRErSBYnayabd02iOrXEqJthV8RysqaytCrL360ZUgIKhfMsLQCFYnfLiMVHIzDoOZNPz1gbEK30JDrYrqyWioomgV+IqV0UFGQyYp27/K/bxLa2omQaY+M6/njpdwEIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884140; c=relaxed/simple;
	bh=11hd0MdyUcd3HdmwB34NmDsuCWpsRmckMcVWvzSFJgU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrutUuwtJwhIWqyDbZqIdIZrzoEbQ9DiUmn1Lvu6sKEYWe3vP4ADnelI3y9bObz7aO+oVSso1TghxgJsAre3oLB1sOdbTUPcNdTxg9t1RlqgHXo+R1o/CeZk3iB8sCMhTqSrtlI6FQMcZ7BxbI5LTKqVuQcRmm3tS9d63YwCVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umtqzjKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A4FBC433A6
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706884139;
	bh=11hd0MdyUcd3HdmwB34NmDsuCWpsRmckMcVWvzSFJgU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=umtqzjKpgz82O/CSV5PjIHIRAHIQcR3MPxWVJVK1aC57b6oVmB4r50Kguw9/oNnHL
	 96+EWa5ex1TT+X8GAyJif8jQnCpax9f3r0pm4zOhXzLnQDAZ2mmEV5wN4BuyYXN4mI
	 p3wqi3rKL0na2fpZB/46Z5mY0wmhYoLP9jvF5KuiZ3Ab1Q1Dxeg9ayu/qOltnW2vN8
	 bHTlxtD9iznRM217OOfqQjpjj0y9/11FngERXe+3fA7eDdJ4Vq9PARgwtXkGAUK0Kc
	 hucpH7pigfA4iQKKokyq3JPWBxaoLR4W3m8Y/WcAiRWs9OUBe24MfGrHvOiCx/vXmY
	 YsrdnStYMRuMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 865AFC4332E; Fri,  2 Feb 2024 14:28:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 02 Feb 2024 14:28:59 +0000
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
Message-ID: <bug-218171-137361-nV8CZQ18Zg@https.bugzilla.kernel.org/>
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

--- Comment #43 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Gino Badouri from comment #42)
> Dear Perry Yuan,
>=20
> Thanks again for looking into this issue and making the pstate driver
> compatible.
>=20
> https://www.phoronix.com/news/AMD-P-State-Threadripper-3000

You are welcome, glad to see more and more users are using AMD Pstate driver
and provide feedback to improve the driver compatibility.=20

https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/

The patches have been sent to upstream for reviewing.=20

If possible, please help to add test-by flag to the series.
Thank you all!


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

