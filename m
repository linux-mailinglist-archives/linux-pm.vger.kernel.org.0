Return-Path: <linux-pm+bounces-30451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C634AFE69E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB527BF482
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A32C08D1;
	Wed,  9 Jul 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="azOueTrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D102BF015;
	Wed,  9 Jul 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058042; cv=none; b=s2cOoz2rg+nrcdJu3myZu1SXFa1aMehOFDsPqsMSbQgz3LDSCBVo+SCd1CPwSTdbewXngPqcJbkX0ji5RMatAtfWwD3P6wkIABjwp+iz2qEmCEEmu+ysZ2pyWgKwyoCOSR6nJ/Avfq5vJibILuomkaN2iHava9ug0QfgytXcDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058042; c=relaxed/simple;
	bh=Ez9u/s0cezxWdP+Fs1SIRb2V30U1MtIUEgSd9tnSAzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MazFFczQ8m2L8q5SiVfMNmTuYOPJnx1ymecH3GHCt3eRmFWL5SXGSnwI00U/slwbnutEWy6Z2/Q7OPKbvoFDr7GMYUmS3jGQ5NPuC1/Qlo8vZnZHVyjnlHM9RlBAYTp+Y3cXxb4lPT/PL6+XFNXVt7r576GpVVOsIV8CNVtRdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=azOueTrm; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 82B4466F553;
	Wed,  9 Jul 2025 12:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1752058038;
	bh=Ez9u/s0cezxWdP+Fs1SIRb2V30U1MtIUEgSd9tnSAzo=;
	h=From:Subject:Date;
	b=azOueTrmAe0k+OTjHkWA+W8hM77oGIzcsGtIk4i1A3iXfbzvECoaYCXICu6xIlNTD
	 jIO9JUzt/5cn2grv2aZtEyyPDh0E2kEGHUMpLQzG8Us7YKhKcVgiqD1XOvEN3GcUkW
	 MlGEWY8yRAbgmb1yKaYy7UGitDvUGZFyz/ptwm2/TpiUOBu/D/AlYX3huWnHEZNqqX
	 T9mGxX+bDl2k5iy0k3MzcAnuu+b+ocv6/vRs040U8zUqIRUJju62J26CLCCzeoYM3f
	 lDSdrDZ+MiJxHShAbA/DKaFGettaegbStIdwCMbbddCNc3L+LxDHz4NInR3YvDkpHr
	 afSxBNalQYNfA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 [PATCH v1] x86/sched: Print debug messages on hybrid asym capacity changes
Date: Wed, 09 Jul 2025 12:47:17 +0200
Message-ID: <4664631.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTGDLTCfVv4Q2EAN7OJPokU9C0zcTfrtVtrp6O3ufUlFsHBA46Xf+g0fHrW+fF9UWvZYe5MN7nXCk+2F4JSS2neR9hkRA/admMLJAbso/1G0NWysR2cxJtgylvy4N42UYx4vTLRlu5SvvlWrRfFbQ3GH4pENVc+cBXA7/P/qxXVM+SulNLMY16tUs9m/kNhTTA6xocJ+3AJfWo9TygvfT3W903gc35EFqKACmM6Ns+LBt9Bi6UdeWGV8j2GxB+1seochZQ8GuC0dI3Ll56xGG+dcfdq3qEI2d6/XJwSWSwh4Ejxm9owve04auNaGUtFLQ/En4hf/AkJ99SOq8clVWBmCAet6rh8YDJ669QDU/Lp3Ym2OLFcvGWzPsbeHD1F4Laj84bBgGDYpB3zNd5fbUHWpU4thfzaOqAnTSUk9kkCmzA4iRqEnQGOaloJwF8rwfBbpVHoqPirEtfXPcIw+/wyaNvKKhVKrYZ7OGXda0uOSu7UXH1tqbQVD1BBErQkd+hNVAK5B/ZYqd9vUGAwS/dHiXf99QdicuxHlCvxflUug/DsyQTGCA0oXM1qpP5tIav5r4FqJgN+TucIEMEBu3Xed6EcGu+E6DKEK4ahyf8998YS7xSogWdxzsyF7DdJhXqrs/16kMy843gu6qZ/2XajnmgLbJ3nho6OFrw5B6oX72g
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] x86/sched: Print debug messages on hybrid asym capacity changes

Make arch_set_cpu_capacity() print a debug message including the
capacity and maximum frequency ratio used in scale-invariant utilization
computations for a given CPU and in capacity-aware scheduling (CAS) or
energy-aware scheduling (EAS).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/cpu/aperfmperf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -416,6 +416,10 @@
 			   div_u64(cap << SCHED_CAPACITY_SHIFT, max_cap));
 		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
 			   div_u64(cap_freq << SCHED_CAPACITY_SHIFT, base_freq));
+
+		pr_debug("CPU%d: capacity = %lu, freq_ratio = %lu\n", cpu,
+			 per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
+			 per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio);
 	} else {
 		WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
 	}




