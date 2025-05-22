Return-Path: <linux-pm+bounces-27490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770EBAC06CC
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E0B7B6761
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051C23372E;
	Thu, 22 May 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WMbg7s3o"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C91B0434;
	Thu, 22 May 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901753; cv=none; b=kbXFqLkKDH6B6enAtrHn8VocKW+CcAFwxMU5ilQ8PxKJU9/VvVy9zvhROXfRplM9UBLp0q1+YAOKd1KObbuz0vZq/rcyVqv8nUrWy3ZgoVgW8ROxwPzKtu+3iK/LIu5wG92PKg07GM/KdUmSbjA+fCZ5JRnmPvUkttzDPuKKG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901753; c=relaxed/simple;
	bh=7E4VpZaYTeyHmonM9ukVDRJ98qeI0xAsr6LbdRcYv4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QK+CowQqpO3mNf10QHDC/P9wYfTwyPg5VjcVesZr/x1bOT0HkedsdueEl7SkAnaS6M84mR5IO7cN9A0aiAvYhM947bb7zZ11IugFs1fqwrJq5kBTfbdzO2oD+NeEK6fJdyY0VFxgePnJWw4nuypX+93ZB0IX7OoS/Q3noWYcNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WMbg7s3o; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747901748; x=1779437748;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=1WWTa3On4JPd2OiE7+97JDn9jIPF7/XgeqzVzCmonJQ=;
  b=WMbg7s3oqbnhLci0corqti8vq/nksYm8JuLweDpUQps/0XTYLVTV2Sp6
   ppiu8xgXAMEaTopXykMGdLsKEwnFMG+KnA6q37tal5XiJlaRi4Kq3X/4g
   ipWyyCpajpr4Q/gP131EKIDeQuliDhu81uEYoz5tUd/6tpdiPnkPjRdPw
   qnoR2D3dddV24f3Kieh9KsKgoXQ2tkcTsyEcE4MwvVyME6FRRfM5l7hQT
   wIvrJwTaxa4Vg2NsDdFzB4Ii3fAxVZCUszSuwewDdZyoT5VIxmNwwqxd+
   QdP3juAunrhgsxwekS82IVLFL09cAcBtcT1QQWL3i1ns/0caD+AokidKg
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 17:05:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,305,1739804400"; 
   d="scan'208";a="562594206"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2025 17:05:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Thu, 22 May 2025 17:05:33 +0900
Subject: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
X-B4-Tracking: v=1; b=H4sIAMzaLmgC/x3MPQqAMAxA4atIZgO1UhGvIg79iTVLKymKIL27x
 fEN33uhkDAVWLoXhG4unFOLoe/AHzZFQg6tQSttlNEarwbKaT1hzDdJyoIhe5yncVbBWTcGAw2
 fQjs//3jdav0AAr4h5GgAAAA=
X-Change-ID: 20250522-userspace-governor-doc-86380dbab3d5
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=7E4VpZaYTeyHmonM9ukVDRJ98qeI0xAsr6LbdRcYv4k=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDL0bl04EOm1ZPGGI+3Bvpe9CqsZZu/7bhklo2jw99ok/
 +9Zde8udpSyMIhxMciKKbK8k1l34aCVZdPX4wzfYOawMoEMYeDiFICJnL7K8FcyrilrX8Yi6+PN
 C96vUusUZsk1PKoRd3oSi0zKX7b4XCdGhoP51zUc+JU6A0OfS3MzFfS5f7dw7d7ybs1/JubDL76
 u4AYA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET flag, which
means the requested frequency may not strictly be followed. This is true in the
case of the intel_pstate driver with HWP enabled. When programming the
HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the max_perf
is set to the policy's max. So, the hardware is free to increase the frequency
beyond the requested frequency.

This behaviour can be slightly surprising, given the current wording "allows
userspace to set the CPU frequency". Hence, document this.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 3950583f2b1549b27f568632547e22e9ef8bc167..066fe74f856699c8dd6aaf5e135162ce70686333 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -397,8 +397,15 @@ policy limits change after that.
 -------------
 
 This governor does not do anything by itself.  Instead, it allows user space
-to set the CPU frequency for the policy it is attached to by writing to the
-``scaling_setspeed`` attribute of that policy.
+to set a target CPU frequency for the policy it is attached to by writing to the
+``scaling_setspeed`` attribute of that policy. The actual frequency will be
+greater than or equal to ``scaling_setspeed``, depending on the cpufreq driver.
+For example, if hardware-managed P-states are enabled, then the ``intel_pstate``
+driver will set the minimum frequency to the value of ``scaling_setspeed`` and
+the maximum frequency to the value of ``scaling_max_freq``.  The hardware is
+free to select any frequency between those two values. If this behavior is not
+desired, then ``scaling_max_freq`` should be set to the same value as
+``scaling_setspeed``.
 
 ``schedutil``
 -------------

---
base-commit: d608703fcdd9e9538f6c7a0fcf98bf79b1375b60
change-id: 20250522-userspace-governor-doc-86380dbab3d5

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>


