Return-Path: <linux-pm+bounces-11703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DE941F87
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D657D1C230E8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925118A6DC;
	Tue, 30 Jul 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApDHKgT0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934618A6A9
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364184; cv=none; b=OlTRsCenvwtxWSWgH7kX4gV2994SXZRIoEnOxfImmUT/9XxrUtWyjxZFbAlWOLsOiAwNrTy4+5WrRaC/HCphpVowPyLkGPYhcgZ0LH6c8xB4Ctnli8sCoOr/kCxpJwOE2C+sep+duIhhs5u0YJw5d+XHeKlRMAfP/EK0yYDKf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364184; c=relaxed/simple;
	bh=w/HpF/qHgH0/AuQH1qjavJCV/jp/6lZx5lpzVyKig+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OaGVY7a6mGoTDONieHosGqeU1almaoAlk/VfYn28vOUm9JLK6Ieu7cyT4kxSlPvMSbNJUpMym6bWfyiGrcekTLLmJ6m1icw1ksvbwlYibTS8TOuO7WPmgv2h604nSpOW0BdFPGyFS2YXrClfUGm1WMrg10Jaru8lWcdU0YiKBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApDHKgT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E79ACC4AF0A
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722364183;
	bh=w/HpF/qHgH0/AuQH1qjavJCV/jp/6lZx5lpzVyKig+g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ApDHKgT0pnDaNfzRYNr+OTkCQWAXRWE/i904GyaZt6EsOwnZr9SGTbQ+YVWPHd/ex
	 xqiGEvRjCroxSJPlmIB/aFZxxhNceuk3Hu8HypEs7xe6ggLQnLey4M43P2nLWJcrWB
	 E4scwz5XLeg4NpALfQf3b1WejPeMd2kI3b5z2N2USNsVPy2ySW626GbTsO8MucUbGH
	 R8doJq9Rh4gJMH5LplLme+ChVXPSmzohn7bdFQVzJVufmXjGtfpZHJKswFNL4/dUnY
	 Xf8DsRUTofRsJANS5EG7CTHVRtMw7ain+Ioo334ZYvwDhOmnfjQtSjKtTY1QdqPjNi
	 Hmw9Tu2GbfgcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DB163C53B7F; Tue, 30 Jul 2024 18:29:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Tue, 30 Jul 2024 18:29:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-kXWAGsqEoQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #3 from xiaojian.du@amd.com ---

> I wonder why amd-pstate cannot. A kernel module can keep this state as a
> simple variable and restore the energy preference on resume.
>=20
> And secondly it's quite misleading that it reports a wrong value after
> resuming.

Of course, this should be a function for a complete and robust cpu driver.
will discuss it internally. Our team now lacks resources, both human resour=
ce
and project funding support. So it will take time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

