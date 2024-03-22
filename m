Return-Path: <linux-pm+bounces-5217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5E886790
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128D41C2150C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Mar 2024 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359CEB651;
	Fri, 22 Mar 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOvA/axX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44B6FB0
	for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2024 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093137; cv=none; b=exXt/YE1qhuHMaaXX9HzWPU4A7A0dKsc19AApxWkcyalyF4QFhYj9wnYwORqV1Kupr3NsNdthdQt5PbNFFgiUck6KFVOB7EMZxmp0MoxedZ4WWUYNilFZMaTKxwfxaWNC1esB/AqkG2uQk7MtaSwNgpue8q185pbath0K3+QmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093137; c=relaxed/simple;
	bh=+4QwTyhOHIfkdj2L2xXTZnhadBOiC0Q7prOxbF64Nr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjvDEJzjEyXbB0bauBCO1upHkZHMn8eXYD+VrJUT1YGEPKaeXvFJAtUgzOcoAzfTWQCi6T9Of4MscDeW1e5cPN221Z94qoccxpm/4f4PTBPCpnwn7K0YWB9Xw6fGKFvMjVfZU8ClRWkefsGt23e5Bjj6d85/+eg1gO9B3XX0uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOvA/axX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7647C43601
	for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2024 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711093136;
	bh=+4QwTyhOHIfkdj2L2xXTZnhadBOiC0Q7prOxbF64Nr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GOvA/axXf6JGt9lrl5Amxi4rJ+bwyfTeZKVHZ5gMrR0BAjsCmhFJ9+3UywH5P9+/U
	 iHjJs622VU1wxqcqLrDVr/oLaNTYVkFEUYkCA1Y+EkMSWKuRcq0ACZiZT7xmAbVOPs
	 G3IoJJNZlJLUMqBNLMdtfUKPyj53BZ+ibgPq5ET8jwIn3w5Me2oDf8u/5hHq/jCg97
	 3cybcQl0Lv8wy/pSGfhliSsA+Jc3yltwyPkxhlyi+P6nP/4uXyO/lraDYjLo0jSPow
	 wukg+USwufQEgdXtfPlWXPLGY6bsCtq+ylkrSJmGimaXN4rQOScbTW/NnoiZOJI1cJ
	 bUjHs1IcDvoIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A16B1C4332E; Fri, 22 Mar 2024 07:38:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 22 Mar 2024 07:38:56 +0000
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
Message-ID: <bug-218171-137361-U6UvSR8pMO@https.bugzilla.kernel.org/>
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

--- Comment #46 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Vishal Rao from comment #45)
> Hello,
>=20
> Is this the right place to request this bugfix be backported to the 6.8
> series?
>=20
> Phoronix says it's coming to 6.9 here:
> https://www.phoronix.com/news/AMD-P-State-TRX40-Linux-6.9
>=20
> I've filed a wishlist bug report to ubuntu for the 24.04 LTS release which
> will carry 6.8 to start with, apparently:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2056686
>=20
> Regards.

The fix patches are under review and close to merge.

https://lore.kernel.org/lkml/CYYPR12MB86558EBCB812D171DAC34C759C312@CYYPR12=
MB8655.namprd12.prod.outlook.com/

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

