Return-Path: <linux-pm+bounces-611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9386D800AE0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539C31F20EF0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C7250E7;
	Fri,  1 Dec 2023 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY0o7W8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF824B58
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 12:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E3CC433C9
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701433737;
	bh=krorMoPkddcn+Tn2NFJT5zoyBX7cgvfjuCeu3L0EhP4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eY0o7W8xz6i/9dr1aEASAsoJkwfVnQoIrripMrggKUqbgaDuervSnMXgQh3P0dCQk
	 mKDKZYKjv9REb+BmY9XJGbvsYQvOe2QQYrviOTZ2TQ934panaUhQc0cQML+xw+/G88
	 fnUl58SXxZtpOwfMv2wiNEP8VvFcpu4KCEdA/o8Ww76Z0tirs6Bbg4WMfjdJs1fc8L
	 1h9jqq7vUGydmaxoNCfYjVHRTASAYtzC1ksm0Iwle+lXc5d7/AOwPa4PA7KRTXU+3n
	 ZIY6ML6As1gVP2ImEhFSpgP3jlzqKgckzsHfcfbHyH08E5m0xFbDq7dM+w7jcTYiNd
	 ox6H8TWCUKmYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0F510C53BC6; Fri,  1 Dec 2023 12:28:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 01 Dec 2023 12:28:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-AXfNclY1Vt@https.bugzilla.kernel.org/>
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

--- Comment #13 from Gino Badouri (badouri.g@gmail.com) ---
Hi Perry,

A little offtopic I guess, but are you saying the acpi table is not complet=
e or
correct?
Because when I tried Ryzen Master software on Windows a while ago, it was a=
ble
to gather all of the performance metrics.
Does it rely on the acpi tables as well? Or does it use a different
method/interface for getting the information?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

