Return-Path: <linux-pm+bounces-37472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10FC36801
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 16:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2A71891B8A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8A262FD3;
	Wed,  5 Nov 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz4Pxu5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A812258CD0
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357192; cv=none; b=tZVnfpCdHuEoi7CXFQFdw3ZHeIGOIVLON4yK+2sz7g82LU6MS+AiUX+F4YxMA9C260V0+KF1GmlN2Fn4e8YXqYuHTv5Rei44nqD579ZJlF5C6yvFxCvkd2G2l0yf0si3k1DC/+xaQkk7xFZrDx8MLmbw4LNMkCyID4KGmjkLihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357192; c=relaxed/simple;
	bh=9At/exsPAa2BYne6mBHA9/Z/1z0mR1karkAp+IQ7W80=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAia1aC+3pudpfvkTFcHwTJ6zCX5x+aEjgeCCfFxkWyd7SMj/4WEywStH9mMfy+18ne9YAA0DQPY+PWBT81hKE0NGXeF1E1j4w3ZH4OwtKyHBk3caSKyudvPPZkxy5EXhpF/w6kETBfilKczFWFnZYOuR61CQtw4nGP1oB2jHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz4Pxu5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC9F4C19421
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762357192;
	bh=9At/exsPAa2BYne6mBHA9/Z/1z0mR1karkAp+IQ7W80=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Lz4Pxu5/kU2UBI/DIp9U42X2bVVtJFA0EFmrSyjJ78B1hidMUWfXA9uKuh7xJoPRh
	 PLd39VpENAljQJ+qg3OlUG/JcgP68Me9Aio3cNqiKLbNT7yBwP4uyte8ZnpOd01Y80
	 IRJ5JeXvJyudC7UbojkGRAEAmG9/BgP9f1aeV/NQK9BRiQ7SOtNMlIv+/pR2Ta222k
	 s/Q7fW59MRXgmQ+9BW7jZ1+izup224UHw58t3wzLwQDN/1M0XbtHlPz+8npejfLpSt
	 YG1FohsyfAc0XhyEI8QqXSlEtM8CeNNRxd1kYGBJH3hkm3EhXHkD0fZoPevPhJjzDo
	 /aOd2VzmmTKew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E54D1C433E1; Wed,  5 Nov 2025 15:39:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Wed, 05 Nov 2025 15:39:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gautham.shenoy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-RnxKgqQwhK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #22 from Gautham R. Shenoy (gautham.shenoy@gmail.com) ---
Posted the patches to the mailing list:
https://lore.kernel.org/lkml/20251105143851.4251-1-gautham.shenoy@amd.com/

@Chris, if you don't mind, could you please provide your test-feedback to t=
he
patchset on the mailing list ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

