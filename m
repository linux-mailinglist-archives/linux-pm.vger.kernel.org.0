Return-Path: <linux-pm+bounces-6889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6A8ADE33
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F5F1C20CBC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402445BF3;
	Tue, 23 Apr 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmUnS/z1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9D1C698
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857153; cv=none; b=c2LapW5g/KjJtCoJXVMzGzgaZUAZBbi3qGRPGzUvCJ9ySZBTQN4ENG89yzogNHZdC6oQhwySna3+mCLls8X1OQmLzYO2fcgOzpx0fp4npACame/Kw+8dq1coeUMkLhzqeL1DxpRq3ZIHwT5v2Uq4zASgHTDJhf4HG5S6FfYkmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857153; c=relaxed/simple;
	bh=XViWGPNpcp+6+TsAesnw0VJlnBmEZsA+7oAUKZSvl/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qluH3bVCvK8M2UplKhj7jXof60xfII+FHSK/6k+ma0piJc7I1QQi/DtYf7/xmM1otoxKRli4/N+HpiRCFkGAd/fRzBzfI5ZhVfAO8R4sFWsQdC1Q2LZGi8Hu4ZLRhDGDZ2wah8gcxVoOeJcvziXQSYQk+UOkBXVrjeq/FvWVNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmUnS/z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3419C32781
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713857152;
	bh=XViWGPNpcp+6+TsAesnw0VJlnBmEZsA+7oAUKZSvl/o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QmUnS/z1g1tb7hsXr0qkYS+pesP/vUht8LcLBqRx6Re4yHYkokwBPnGkiGrBwrvIH
	 u01r6ZhDa3eX6UcDM+rK3Yni6QNrpnRZunWhOjSCKk2TmR1hjh/pwuZurwtve6/CKj
	 P14JNUT7VBCPqR43DOx4pevu4QMu8KH7mmorsZWd6fC8taYHNINlZrLeQhMED8WJ0g
	 qFQFlEeLnCjaXuwTpB/UFbiLXwbJD6rCMouC55JqM6Sqbz4tcfT6TcvqncRw0Y2QYD
	 dQHU0KlnEr1L4HpLLL6LvgxgPBK7XG8a85fIW2Ro2/tciDY0rACZmmuOzTzoYeqrLh
	 JCTlJ2JB74lVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CE037C04223; Tue, 23 Apr 2024 07:25:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 23 Apr 2024 07:25:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-hLRNJn0heh@https.bugzilla.kernel.org/>
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

--- Comment #44 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #43)
> The issue has been confirmed that CPPC is not enabled by default on the A=
SUS
> GA403uv BIOS release. AMD has requested ASUS to enable CPPC in future BIOS
> releases. If you wish to expedite the release, you may consider contacting
> ASUS customer service.
>=20
> Perry.

You really helped me a lot, thank you Perry!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

