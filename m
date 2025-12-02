Return-Path: <linux-pm+bounces-39111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D193C9D0CE
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E24E4E0D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B662FB977;
	Tue,  2 Dec 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3xai6F1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92B2FB0AD
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710316; cv=none; b=tty0dgpXBtbSWchC2BM8ntxHTqHrogFxTNnss4f5DerEkBeddWumIjgRk40xS3UPdeOFE0sH7gkbWvVNeRtc/pOu8iExLcTCadl+fjfxlOJmyp9rvSVUnp+w2yfBRLl1s6L6PDy2xjdJFoa2xc4BkufsDoVVG/hwAGPh+W0pU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710316; c=relaxed/simple;
	bh=adacKI/ATSnis6Y34NhcYNfTYmDY1V5hT6bJM3PL+3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnOlTCUooTOd43wi/WdxMmbNiAdXmANyhwnA/XDhwuk1zx4NjJ30Nf2FZyRa/mBwoMm3lRKi1Z2SXvDUHCjfLWvcRMy7pe7prq9dVTtBwcGa/IJ5c5dcmX/461mMPNBsmGN/ufNsn1g/JfEO5vsFQpM5FbECgmGw4mMpZB7dui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3xai6F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65214C16AAE;
	Tue,  2 Dec 2025 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710316;
	bh=adacKI/ATSnis6Y34NhcYNfTYmDY1V5hT6bJM3PL+3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=I3xai6F1gDN5v1Xo7Kepa4ljG9akgvZEK9Ctbm2ViLHFvDz/l3V1g/qaG09ywlqgK
	 MfV2qeX2izJE+MZ1+mjJv4Q9PsOwzEjJUp0QlZsl9kIM2dPs2DnkrY0d/zTraOaAFS
	 uCcKiyfnkefbVw4klYWnaWKlNJN4KqvwGDDhYZnhZoBfCtqfGL0OVxjuUDrHDIC6pM
	 jVBcoFYJPVJYQU3ww7z+yH6o3h2W6VsDrbvd2YX8ZcKIFqGICO8fqVJAR8f/Vq3TO9
	 k+xHLGN92z9saL41saKrfSWK8HuejLLWRTndwV9f1dz5RqS4Dnxl0VHTlX50NMUH7x
	 1euBZTPBNL2wA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/21] tools/power turbostat.8: Update example
Date: Tue,  2 Dec 2025 16:13:23 -0500
Message-ID: <64f96057a6391a643f4e7c2b2333c445acdec865.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Update the added-counters example to print counters in decimal
rather than hex -- now that it is working...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 3340def58d01..ad3fc201552f 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -410,25 +410,24 @@ CPU     pCPU%c1 CPU%c1
 .fi
 
 .SH ADD PERF COUNTER EXAMPLE #2 (using virtual cpu device)
-Here we run on hybrid, Raptor Lake platform.
-We limit turbostat to show output for just cpu0 (pcore) and cpu12 (ecore).
+Here we run on hybrid, Meteor Lake platform.
+We limit turbostat to show output for just cpu0 (pcore) and cpu4 (ecore).
 We add a counter showing number of L3 cache misses, using virtual "cpu" device,
 labeling it with the column header, "VCMISS".
 We add a counter showing number of L3 cache misses, using virtual "cpu_core" device,
-labeling it with the column header, "PCMISS". This will fail on ecore cpu12.
+labeling it with the column header, "PCMISS". This will fail on ecore cpu4.
 We add a counter showing number of L3 cache misses, using virtual "cpu_atom" device,
 labeling it with the column header, "ECMISS". This will fail on pcore cpu0.
 We display it only once, after the conclusion of 0.1 second sleep.
 .nf
-sudo ./turbostat --quiet --cpu 0,12 --show CPU --add perf/cpu/cache-misses,cpu,delta,raw,VCMISS --add perf/cpu_core/cache-misses,cpu,delta,raw,PCMISS --add perf/cpu_atom/cache-misses,cpu,delta,raw,ECMISS sleep .1
+sudo ./turbostat --quiet --cpu 0,4 --show CPU --add perf/cpu/cache-misses,cpu,delta,VCMISS --add perf/cpu_core/cache-misses,cpu,delta,PCMISS --add perf/cpu_atom/cache-misses,cpu,delta,ECMISS sleep 5
 turbostat: added_perf_counters_init_: perf/cpu_atom/cache-misses: failed to open counter on cpu0
-turbostat: added_perf_counters_init_: perf/cpu_core/cache-misses: failed to open counter on cpu12
-0.104630 sec
-CPU                 ECMISS                  PCMISS                  VCMISS
--       0x0000000000000000      0x0000000000000000      0x0000000000000000
-0       0x0000000000000000      0x0000000000007951      0x0000000000007796
-12      0x000000000001137a      0x0000000000000000      0x0000000000011392
-
+turbostat: added_perf_counters_init_: perf/cpu_core/cache-misses: failed to open counter on cpu4
+5.001207 sec
+CPU	ECMISS		PCMISS		VCMISS
+-	41586506	46291219	87877749
+4	83173012	0		83173040
+0	0		92582439	92582458
 .fi
 
 .SH ADD PMT COUNTER EXAMPLE
-- 
2.45.2


