Return-Path: <linux-pm+bounces-7159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECA8B3225
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511D01C21B5B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350B13C8F0;
	Fri, 26 Apr 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usSjiqWF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75814293
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119519; cv=none; b=KnrGh7IhZ43y+hw7g7qHyIJg8tZFqyY0Pue8MMuBiCuE4CAPm3+ULBLzqEhW3IkKwlFxhYuAmtmv8v9hl4D2tS7exBwegHZevhu+GgQoqxJO1Qlvghn+sFErJM1F7YcB6pe5mUD9DzJeCv+W7w6sCTTcL/KTdAcVkVE+8CHUtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119519; c=relaxed/simple;
	bh=3bp6b0U4ROn6e8GNy0y9GjbCo4K6QVUCxLJDTeeIASg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=His7Ejl3N3JEw4yjTmeMxMnXQZtkVa2L74uXMqpH39OFJc0feRhtPE3hF/v4yEEJTis1GENTKRJ9g8h9PBkafb4zFyLzYgfQ6vc4R3Zwem/wa1/xAnrzkMhtpJdlSiUE07pVqOxirf99VbaRmjSvO4m6yJj9E1i0uxgK31wbfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usSjiqWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C7FC2BD10
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714119518;
	bh=3bp6b0U4ROn6e8GNy0y9GjbCo4K6QVUCxLJDTeeIASg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=usSjiqWFckiBJt6Ku8634QXeUmFnwD5e6ftX/cF0uV+BYc2bDxdA7qklXCICiYXPZ
	 vjtJq1Gn3hycUsF5eXWpq2sqSO9HhTAcVYA0UQ9eHqi2Apf7mIG+3lhc/wWtL6fZyl
	 tTcJ65PSCQquyBZJCyi78VjNJrNZQxFXK5MoxsernSAcs7uEnAjyCqZ57A6lSYdp7E
	 9QSV5ktbQzKZo3yRUEuIfua6TxIqnSaNn8/yz+6TrE0drGloAY+LwnwIT60iONOytz
	 B2u6e7enXh09l8Hun4YA+CEZHAzr8rMWNG/qcT9n6aSAWSxcwt9rqPoM5C1lwZS1l9
	 SXEBQqO5bRYIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C6B94C433E5; Fri, 26 Apr 2024 08:18:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 26 Apr 2024 08:18:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-IV3F2xT49Y@https.bugzilla.kernel.org/>
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

--- Comment #13 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
FWIW, a more verbose bisection guide can be found here:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

While at it, let me add this to the regression tracking:

#regzbot introduced: v6.8..v6.9-rc5
#regzbot summary: Ryzen 7840HS CPU single core never boosts to max frequency

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

