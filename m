Return-Path: <linux-pm+bounces-16644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FC9B4334
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 08:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929311F22F21
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16A202642;
	Tue, 29 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrBaov40"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC261201111
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187356; cv=none; b=fQDsvkqYrhXtDzDHCS4BNpeC+a2Tg5migC32uAYKIi7g19Vwfa74insBHcqZs9U61jkFTEy/Et6rkyr2u6S8gHAkvrOAO1E+NSOVVhQnYVs1wHpzptj7NGx/YhJfiw4aALzi1lHKKN2JPg3CExYFB4+vkI2jphtgVgkK7FENSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187356; c=relaxed/simple;
	bh=lDxvvekklQGYtjusUIW6xm+Bwm2jIYeXhip/L6YHmyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dL58k0nVDSzN7xb8Z5W4UoPxtm9n9aWWjgE1keVuRTzz0AfatMWVNQw0x1nBWk66kRkZ8ye3RWIrbipfXdj0YeYkqvk3eWLCeg86DFhgDrJJG3tIrQwgeK+X23Z7hWfjyeovvgyLA9InS21XBwCkoGxQN/mUUpGRP8Tix0KV0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrBaov40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76932C4CEE3
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187355;
	bh=lDxvvekklQGYtjusUIW6xm+Bwm2jIYeXhip/L6YHmyU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PrBaov40vePcbwyk1oUE6MjM9JTQT6S11++6M049BVFCsop8q+Zer+yulvTRJFSQg
	 AjYt+p9+l6Xrb1FElnzPKQpGZ1exmyST74jY6XJt06CM6LpolfQyvhC3e3cI+4CPkJ
	 7n41M6tiNV0tY0jN5JStvMgtqrM7sMeYc9xA+dIEtmk1aPPaEsBiMjGYVjJ5I4WBsU
	 lhKeyBCsdateI0nh7KnxQzDt0oaDez7u9fDRkPJuxKAugQMBq5tckrkSde5+5ZXdne
	 f7pPvzQaF8mXb2hUURnVPK9WOnhfUoclYwTylZPIXxU16rkIFaANCNXQcnjt+oM65h
	 lUATZlLwpimpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6E31CC53BC5; Tue, 29 Oct 2024 07:35:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 07:35:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-hMwIm4kjeD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #15 from Ivan Shapovalov (intelfx@intelfx.name) ---
I'll test this later today, thanks. (I also want to try to dig into _OSC CP=
Cv2
flag not being set, just to definitively confirm if this is a firmware issu=
e or
an ordering issue.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

