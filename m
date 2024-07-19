Return-Path: <linux-pm+bounces-11245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8C93754A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC10A281910
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D280046;
	Fri, 19 Jul 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml71TBUW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DA6FBF
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378791; cv=none; b=NCjwfcM6wA8KAaIeikeihiCCMmW+7EOwsEMOnvsV9phdJTX6SSPXvqDUYDWTZJT+ZZw5SaFTZVjMBzIlPIT2M0DBIEg8YWnj7cr1xfUoPQZUMuT9E61ArxmpKPu0IV94ZJbzIlBTtmQ55lqkIrnj0N/Eyxjh8Grh0KKHFChzuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378791; c=relaxed/simple;
	bh=ARhPG4BZ3CkCV7JPrIBICEHgimutX5eF4MInf7ElDBU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PpX3JRMoODQa/3a/Aw0MtLMr5+hY1WCPrkaX2qtAo7zBopziAJwmn+RDgaRRvY0/i7sXIhRGfXaht8wognQS3udV4dKZXOYfSRWfFHu77S9fvogHtwcP2dIAKIJcGTsgZsakjAvuvumpgMl4pKS05On/wImWHFPiJZfz22+BzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml71TBUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B92C4AF14
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378790;
	bh=ARhPG4BZ3CkCV7JPrIBICEHgimutX5eF4MInf7ElDBU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ml71TBUW8ggaICJ1HY5HRoBpij/vzau6QW7XDijkuWraxQc2FsIHwq1CYi1FWqcgh
	 /+008FAnFgAAu/xWrzWE1YqcHvGTMJFdYNWa1fgs6DP6FiOMg10NC6WSmcm2+oMqxv
	 WmDUVZTckK2CiFZKg/WM8opS21G9GUvnH2rjLJjGsNRvcK6kGuEyjFoQj72OcBi2aZ
	 kelqsWfT2E0Z5NPllC4cKdSebNyNKJBTS4ip7Y9EqwOKHRqUpmCuwWq8yxXpuiRf4D
	 aWY3yy4e/lTghhBklh78z4Kz9syBO3fIyzQKkq+t2iRgWW34+ZBA+l++pZyyblivLW
	 Pq8OwETeIh/Yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9BE28C53B73; Fri, 19 Jul 2024 08:46:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Fri, 19 Jul 2024 08:46:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nicolas.granger.m@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-fNVBMhTSiO@https.bugzilla.kernel.org/>
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

--- Comment #57 from Nicolas Granger (nicolas.granger.m@gmail.com) ---
*** Bug 219044 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

