Return-Path: <linux-pm+bounces-19697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 203699FB03B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 972FE7A22EB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC091A28D;
	Mon, 23 Dec 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Nm7WZUN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AD14A8B
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964900; cv=none; b=ErpekYNfs4TwMAjIR0t0N5TRdPo617uuGMNmTyf+fQx/vYvVCYUip6y7lYhXWU3rO4Aetj2EjFdtPGgZg8OXSPL2OpAHLJJRFghXkmUuP1GVczPIx6ekH+2chPZwq+r4k+MVlFXZcFszWTxWUBsw1PfU+Z4trDLnRW/qJPVI82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964900; c=relaxed/simple;
	bh=s3RGCpKkz5tqorVt2UoQ7VDvDIM9QHefPfvU+C1n65A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FxuWk3870ij4x6Vzj9E0EA7GirvbXGkTvhLYw4+8/04sH16nhyPCuwhSlo22t6n9LXx2olboI2NElW3IqENxrd/cqFAcRTH1Y6o5ESHpU13FB4eewnDnxw9mRcoamkbjX4jb/mB2ajVnkvWfLUr+5lJo4P0UMUo52FZ41qzPg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Nm7WZUN5; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=protonmail3; t=1734964889; x=1735224089;
	bh=MS7nF1XKmYMD9B6JpjyW2l1dOmA8eIOqm1xmuEVC4pA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Nm7WZUN5lXXF5mCVJwwYvBmgo1tIoW5L7/qUJwIynXc9t0Kz+zwcD2h96K/KAxlsn
	 BWfPF0Bv0Q9Kn7seK3e0E6gfAFLM8qe2QsECctMna7m1abt8IzzLcJGLbkDqs2wIkq
	 PfCSEQoU1EILk5qybQq5mQx/aEnS3qKWgvgmgfIhqMaKosWnj92kw5eDYDqRJ4bAuy
	 dOfViylvM+dd9tUODMlhoguc8h1klAqz5gg7Ewmo2XkKXn9v358dhcT4ZNU8lhKhue
	 tOQAKhBGa+3GNt0tLzDuMTOG1dG/skFZgQ6Cz4BQqep6KLDMUVJm1rxlzpM9gjX/x0
	 tf4zl6y7IfPlg==
Date: Mon, 23 Dec 2024 14:41:24 +0000
To: "rafael@kernel.org" <rafael@kernel.org>
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: sparc: change kzalloc to kcalloc
Message-ID: <e3fXwH1TSclUunsB_ocTKA411JNgc8KozFJo9rGansdyTkxV-f6sj-TrJWBKXNs-DdlQTF-YEWRl_UcFQ_kQUCCEMsUUgnYQjiFrvWMrtYs=@ethancedwards.com>
Feedback-ID: 28410670:user:proton
X-Pm-Message-ID: ab6fa1139b90b391bd7186aee2769a070ad2b9e7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Refactor to use kcalloc instead of kzalloc when multiplying
allocation size by count. This refactor prevents unintentional
memory overflows. Discovered by checkpatch.pl.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-u=
s2e-cpufreq.c
index 8a0cd5312a59..15899dd77c08 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -323,7 +323,7 @@ static int __init us2e_freq_init(void)
 =09impl  =3D ((ver >> 32) & 0xffff);
=20
 =09if (manuf =3D=3D 0x17 && impl =3D=3D 0x13) {
-=09=09us2e_freq_table =3D kzalloc(NR_CPUS * sizeof(*us2e_freq_table),
+=09=09us2e_freq_table =3D kcalloc(NR_CPUS, sizeof(*us2e_freq_table),
 =09=09=09=09=09 GFP_KERNEL);
 =09=09if (!us2e_freq_table)
 =09=09=09return -ENOMEM;
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us=
3-cpufreq.c
index b50f9d13e6d2..de50a2f3b124 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -171,7 +171,7 @@ static int __init us3_freq_init(void)
 =09    impl =3D=3D CHEETAH_PLUS_IMPL ||
 =09    impl =3D=3D JAGUAR_IMPL ||
 =09    impl =3D=3D PANTHER_IMPL)) {
-=09=09us3_freq_table =3D kzalloc(NR_CPUS * sizeof(*us3_freq_table),
+=09=09us3_freq_table =3D kcalloc(NR_CPUS, sizeof(*us3_freq_table),
 =09=09=09=09=09GFP_KERNEL);
 =09=09if (!us3_freq_table)
 =09=09=09return -ENOMEM;
--=20
2.47.1



