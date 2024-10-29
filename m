Return-Path: <linux-pm+bounces-16683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F419B552D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 22:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF262286C07
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66C20A5D3;
	Tue, 29 Oct 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="mBok3M+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8A20966A
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237901; cv=none; b=HMwr/Lpbd2tLfOaliADwA+yWNKMFUHs+x1hhtSg1HODeuA/mxDkJFAQZp47wAMac91eZhQuUGEwB58qHx039RTcNbGuZahDzrnOagN4fGhmHHEJ8muqrZai8HOtYzG9Bn3oXs4M6v6LMF4NXGnxon8LEbUHsDR4kAFkjVPfYlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237901; c=relaxed/simple;
	bh=+wJ5KWpgT+2Otb1SXgnm+ECduxv9o6ciNoEgRwIi6/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLL6y0KsS7TYktGlt73rbgBg+bPBuh5fLM8VTZyrMPNiMISSaV7n/liTD3M8c+pr+oo+etvGO4oUNiB+7VvNT9jyBeJ1f4o8Y1JxeCf1ME6NHF3nOYAZmzPVgeJwfGL7yOkVOSNdHRj7mHzvhAVZCsuY/D752OV4dsc+qoSYPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=mBok3M+0; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1730237900; x=1732829900;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=jizTLtrLMmCt7wE/5ipTFTDD8VO6t5SHcJxMFWKWNrM=;
	b=mBok3M+0tuseaP12sUcpJV7J+tMIMQqfqv6hhBdRaRbKHOCLvoFNy2kjI2Fs91CwKhwVYFpAY0ZdOxeW0EcjJ+GY7Y8gdJYwFS5WZ4HEHo+mzsqCjZ2OpkdP5k6URJbu2qGhkZoXbL76ankcf9fsyLKM0IN5wz5X8bf0xAPUHsY=
X-Thread-Info: NDUwNC4xMi4zZmU2ZjAwMDBmMzg1OTYubGludXgtcG09dmdlci5rZXJuZWwub3Jn
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from localhost.localdomain (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPS id CE3152CE04B1;
	Tue, 29 Oct 2024 17:37:54 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: stable@vger.kernel.org
Cc: nalramli@fastly.com,
	jdamato@fastly.com,
	khubert@fastly.com,
	mario.limonciello@amd.com,
	Perry.Yuan@amd.com,
	li.meng@amd.com,
	ray.huang@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nabil S. Alramli" <dev@nalramli.com>
Subject: [PATCH 6.1.y v2] cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
Date: Tue, 29 Oct 2024 17:36:43 -0400
Message-Id: <20241029213643.2966723-1-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CPU frequency cannot be boosted when using the amd_pstate driver in
passive or guided mode.

On a host that has an AMD EPYC 7662 processor, while running with
amd-pstate configured for passive mode on full CPU load, the processor
only reaches 2.0 GHz. On later kernels the CPU can reach 3.3GHz.

The CPU frequency is dependent on a setting called highest_perf which is
the multiplier used to compute it. The highest_perf value comes from
cppc_init_perf when the driver is built-in and from pstate_init_perf when
it is a loaded module. Both of these calls have the following condition:

	highest_perf =3D amd_get_highest_perf();
	if (highest_perf > __cppc_highest_perf_)
		highest_perf =3D __cppc_highest_perf;

Where again __cppc_highest_perf is either the return from
cppc_get_perf_caps in the built-in case or AMD_CPPC_HIGHEST_PERF in the
module case. Both of these functions actually return the nominal value,
whereas the call to amd_get_highest_perf returns the correct boost value,
so the condition tests true and highest_perf always ends up being the
nominal value, therefore never having the ability to boost CPU frequency.

Since amd_get_highest_perf already returns the boost value, we have
eliminated this check.

The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
amd-pstate: Fix initial highest_perf value"), and exists in stable v6.1
kernels. This has been fixed in v6.6.y and newer but due to refactoring t=
hat
change isn't feasible to bring back to v6.1.y. Thus, v6.1 kernels are
affected by this significant performance issue, and cannot be easily
remediated.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Kyle Hubert <khubert@fastly.com>
Fixes: bedadcfb011f ("cpufreq: amd-pstate: Fix initial highest_perf value=
")
See-also: 1ec40a175a48 ("cpufreq: amd-pstate: Enable amd-pstate preferred=
 core support")
Cc: mario.limonciello@amd.com
Cc: Perry.Yuan@amd.com
Cc: li.meng@amd.com
Cc: stable@vger.kernel.org # v6.1
---
 v2:
   - Omit cover letter
   - Converted from RFC to PATCH
   - Expand commit message based on feedback from Mario Limonciello
   - Added Reviewed-by tags
   - No functional/code changes

 rfc:
 https://lore.kernel.org/lkml/20241025010527.491605-1-dev@nalramli.com/
---
 drivers/cpufreq/amd-pstate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 90dcf26f0973..c66086ae624a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -102,9 +102,7 @@ static int pstate_init_perf(struct amd_cpudata *cpuda=
ta)
 	 *
 	 * CPPC entry doesn't indicate the highest performance in some ASICs.
 	 */
-	highest_perf =3D amd_get_highest_perf();
-	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
-		highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
+	highest_perf =3D max(amd_get_highest_perf(), AMD_CPPC_HIGHEST_PERF(cap1=
));
=20
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
=20
@@ -124,9 +122,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata=
)
 	if (ret)
 		return ret;
=20
-	highest_perf =3D amd_get_highest_perf();
-	if (highest_perf > cppc_perf.highest_perf)
-		highest_perf =3D cppc_perf.highest_perf;
+	highest_perf =3D max(amd_get_highest_perf(), cppc_perf.highest_perf);
=20
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
=20
--=20
2.35.1


