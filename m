Return-Path: <linux-pm+bounces-7587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF78BE439
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B26C1C23D39
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4615DBCE;
	Tue,  7 May 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEpjGD3R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBD15E1FD
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088239; cv=none; b=UZFzDVcIf40xx7j/l4t/fk71v/P1J51sLt9E+N1r1VnocY0v1edCB+Oi99ufnA+TRsnalzJVl0cM3zKxzQ0JWA07JsBkl+Z9a82C7I+t5zYXPqcVWpG3g4h2NVeOhXd8KpTjKWK/A4HdYE4ygdYCUwDZHjYHksskLBpInSU1ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088239; c=relaxed/simple;
	bh=RRqSjXiMnSPenPlkHQxMsKzfqm8uMmKKksIzM7+mHxc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAO2KaT3YnQtxvXnJ5RicjGSjwrCaIgdOycpBOWEQa1/0JNZpD/Ta3HEpSOuv1jjEfEjYIjdEXrPPQhpq58CkXUffVz0b1k4mhfEBIuM9w77Y385dv3BOcM3ztavr98vLXPDfS5rZAy0+nrodyjPWdSV9actPOhw9sguMw//VcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEpjGD3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB474C2BBFC
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088238;
	bh=RRqSjXiMnSPenPlkHQxMsKzfqm8uMmKKksIzM7+mHxc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NEpjGD3RztjR2f2CdQ/DeRIiWr8H7VTz3JxEYO1MnknfboUshkTrRnsCwsjqYqFyq
	 gGVxg0DpNitALMN2Yf1GBiPs1Qjfq1D7927+lOjYMvO4u5QcdFlhbDjNTfTNv83KgO
	 zuhzedsh0ygTMBrYHRQAQnZ6YT935sMkxsBxY8bywTlDjjYss9VNYAMOJVnXA2InRE
	 Ee1cgmkXAEn6RQuDOpjnA52rSdAh1pEv12z4L9Ly1nI8KcxgW2qTne6ezvDzcQZE9Z
	 HuiQzZjhtFcT4ecxdJb9NEGZHKa+k/8ezYGdARjCjbBzLCUQfxOnrzIbKr8HHQJ+3c
	 OG0Ru/ZaKruVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CAFDFC53B6C; Tue,  7 May 2024 13:23:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 13:23:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-WsTDEPGqmP@https.bugzilla.kernel.org/>
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

--- Comment #29 from Gaha (gahabana@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #28)
> Everything should be based off the bleeding-edge branch for linux-pm which
> is code headed to 6.10.

Thank you Mario - not so simple for not-kernel-developers :( Appreciate the
response and clarity though :)=20

Was hoping to be able to test and report but will need to wait a month or s=
o i
guess for 6.10-rc1 to be able to do that. Pity 6.9 will limit single core
performance on loads of AMD Ryzen CPUs ... unless Perry manages to address =
that
issue w/o requiring all the other patches ... still not clear which change =
from
6.8 to 6.9 caused this to go 'wrong'

Thank you all !

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

