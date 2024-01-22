Return-Path: <linux-pm+bounces-2518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F78375DE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 23:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA0C284B55
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA65482ED;
	Mon, 22 Jan 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkJqLKrJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA4482D1
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961409; cv=none; b=F8NPaDGBi0Atzzew3WLwTGauWcWCrm0EPZeblXc0MgPS67DHeafr5fGhwlRekVieKwSsc5gw+PTUXk4dRNXe/YtJ5NFua6PsFaQyQzanTOCoNynGmlx4L3ff+mYGAiglwIu6nnU41m8iwiFWxlxlUZDYCmB6xkjmNLA1E9i8VU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961409; c=relaxed/simple;
	bh=4Nk/8xuujbDXDgqPaLhwkVh4NO/vyIPVtAxSHZAU/bE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEEegLG40zNL6H5713WsGdkyxbOoEA/WJTXU53j4AS5RLNZCV9Rco+3P6H1nCzpouazHYTRc11t5o6lcXmtugUi43bujXxnvRjv5noD7IG5XVhicGv32DmBJ60qjof3QrRzJB7h7hXk54hsQ0xDY0FOlxveP9Z0SBEKAJMMHOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkJqLKrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82E1EC43399
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961409;
	bh=4Nk/8xuujbDXDgqPaLhwkVh4NO/vyIPVtAxSHZAU/bE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EkJqLKrJt7KIIV/P2KMrP28X9Zdqk0Xk+xoBYqZoqo/Yq+YuFIZzt1NbPw6a4m2t1
	 DzOJHb1hwsLxRTtH0XIM6eLlUSELISR0LiXYVpLuATV4ZOnBab+57+B5kHNuZrgNch
	 ZqsGyIJPQasbLJohfMXdEYQsXahsN2Q06pVgMg/ZV59b7p7BLJSYt4hTYI0iMM+ud2
	 bMRdcptYzvsGiPlfGCgZ1lALA1VxefvtTDsfpWzK5J28t8ihPqgj4xGtZy0Ve+qhjr
	 yW0O+s399vya2h099lWTvcplkmZn6IcwfRtlIc2LA/HFAmTnClX2aCm97gaYulKge9
	 Eis2ivT9RnxCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C150C53BD1; Mon, 22 Jan 2024 22:10:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 22 Jan 2024 22:10:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alessio.disandro@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218171-137361-N8CjLuTb4H@https.bugzilla.kernel.org/>
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

--- Comment #34 from Alessio Di Sandro (alessio.disandro@gmail.com) ---
Created attachment 305747
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305747&action=3Dedit
Windows Event Viewer CPPC log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

