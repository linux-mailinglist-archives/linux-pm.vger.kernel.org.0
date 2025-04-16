Return-Path: <linux-pm+bounces-25505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F6A8AF66
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 06:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581FD3BFAE2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8371E5B75;
	Wed, 16 Apr 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1vd+fAu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6262AD2A
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779211; cv=none; b=Et36oQ1E7NOMl9+pexIsHq0bQy6vKAD/bJLOtKTN2WG1p74RsrKA2enMITntqPL8Jk1NzgpsJQ7vMvd1isL2UVH8UKDiKL3ElQyY4uNUjGF+4YUQPuX4gJNb8eGrkaZWh1dmIcVAf4jLvPxC3L8Am0wny+ETmDGwJeHMJYLr2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779211; c=relaxed/simple;
	bh=0a5neTt5R+aQ6zX/sgMjNKgs9q//lsTUoBk46QqqSfQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twDAZafSLkdWyT4Eo0/tErrzufDFODbdofDSTfpav80XewalpQZlEZ7+UVG9+Zl+rA2NwMASGBWCA+iXYsJInUlCXN7QDpTCqD6jdFIhgkb7fv/R2Xfm4EnXvrjSPy5Ua/efnFA56+287UyXKU0q7FmAc4fMmI4oAN2xtP99IZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1vd+fAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52679C4CEEE
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 04:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744779211;
	bh=0a5neTt5R+aQ6zX/sgMjNKgs9q//lsTUoBk46QqqSfQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W1vd+fAu2yaB2PW3MnHDuB84+ppDZ+fNJnhlajYFjwkHI6cS0by1hst1ifMa4hnLw
	 O2aqDxYFSTjU3WC3yxbFk/9HWAfwTDmWghaztM046j2LDp3/9S+u2OUrxZaF0LymRB
	 V6lrCNALdfXZrOvmPnhr2B4ypmVvUKT3EGnqtV8Yrh0CyalbCJBWRXD5eN7eTfmSJQ
	 f1+7zuNhR7hd5QVKKFI12POozMMmkZ5UWPUSaXqWHTIoefU/tI73GF1Oxd/JZItN1n
	 8bCTOEXmcfREI6XorVnugO6NwICqISVCs1Hlm0hevnuQOvglNfVEru70eufDe7joZ9
	 C5px3MZdzUsrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 402C0C53BC5; Wed, 16 Apr 2025 04:53:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Wed, 16 Apr 2025 04:53:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nic.c3.14@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220013-137361-4WZ6ZlBP5V@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

--- Comment #3 from Nicholas Chin (nic.c3.14@gmail.com) ---
(In reply to Viresh Kumar from comment #2)
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 924314cdeebc..d8599ae7922f 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -538,6 +538,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
>          * Clear the boost-disable bit on the CPU_DOWN path so that
>          * this cpu cannot block the remaining ones from boosting.
>          */
> +       policy->boost_enabled =3D true;
>         return boost_set_msr(1);
>  }
>=20
> Can you try this change please ?

The suggested change fails to compile with the following error:

drivers/cpufreq/acpi-cpufreq.c: In function =E2=80=98cpufreq_boost_down_pre=
p=E2=80=99:=20=20=20=20=20=20=20=20=20=20
drivers/cpufreq/acpi-cpufreq.c:541:9: error: =E2=80=98policy=E2=80=99 undec=
lared (first use in
this function)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
  541 |         policy->boost_enabled =3D true;=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
      |         ^~~~~~=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
drivers/cpufreq/acpi-cpufreq.c:541:9: note: each undeclared identifier is
reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:203: drivers/cpufreq/acpi-cpufreq.o] E=
rror
1
make[3]: *** [scripts/Makefile.build:461: drivers/cpufreq] Error 2
make[3]: *** Waiting for unfinished jobs....

since policy is not a global variable and is normally passed as a pointer to
the various functions in acpi-cpufreq.c.

It appears that cpufreq_boost_down_prep() is only called in
acpi_cpufreq_cpu_exit(), so I tried the following which should be functiona=
lly
the same as the previously suggested change:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..36e2ff3188c9 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -931,6 +931,7 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_policy
*policy)

        pr_debug("%s\n", __func__);

+       policy->boost_enabled =3D true;
        cpufreq_boost_down_prep(policy->cpu);
        policy->fast_switch_possible =3D false;
        policy->driver_data =3D NULL;

With this change, boost disablement is restored after resume from suspend.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

