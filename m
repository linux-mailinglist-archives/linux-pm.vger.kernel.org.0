Return-Path: <linux-pm+bounces-7607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE558BEC26
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095AD1C23305
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFF16DEA0;
	Tue,  7 May 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmW8Ry13"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EA16D9A7
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108510; cv=none; b=oC7ir6Aa7t/NLTr1bkDXOdQb9T8s/bdYc8xSAFYjS5VgN+R2Dqt2ebL0tosNFXlRPdI05IaRPsyunQq3pdC5B0VezBdKJ7NbPoqJiRaM3NfUZYBXuRd6YhwKWog1lRrFH2esBT27Xgj0o75IcRXtpHnY9rDGIoTPgnByPJeLWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108510; c=relaxed/simple;
	bh=k3ChrTFsSDJ03gYOBcxJs3wIvGIT+tI845+0+aMWKMU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iypHEuMahOvVH00H3qqhYYphgDh1LlbctzoHvkhEX7JiglQuZD4iX0Ew2dCI9SDmD6BGj+6+mmpKXBNuY0FxtP7HBfq+RXeZ4CRTSahbrT/bbFVul5DjL+EPduboOP8LVaDpW/RcEuDBqaQP1OwRb1e9UGeL+jecBGJ5o7NnbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmW8Ry13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A588C4AF66
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715108510;
	bh=k3ChrTFsSDJ03gYOBcxJs3wIvGIT+tI845+0+aMWKMU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rmW8Ry13DWoh+I2FLM7TtOKE6MVvK1RoTBM+lUMSi+Nobom42mu5IREzoDMp3TTE1
	 bCWN+j/9L5u/TcPeik/8gurUfYblBV/wQKCHsqaiNJwAQTJPGJQ1iiiAOFsabbJ7wn
	 4VbNyKyutqT3RARTxDHlpA30UDKINef01rRzLxeGGW+TINHEXVGtoB5focmo59apgP
	 bLZCovaB1h9dtG2wbdc7Yd3jdVWQtCn526Noe8HobpbWsmMAr75L2kqeRZUU8ItFNF
	 b1AmHPQZN86L0Be5GC+/56xfIPv8jltRC+xR/ioyhK6/1uAKvpHo/g+vJgdfcHqbWY
	 s0G7v28e6vhQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19554C53B6B; Tue,  7 May 2024 19:01:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 19:01:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status assigned_to
Message-ID: <bug-218759-137361-Q9nOwUnFuM@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

