Return-Path: <linux-pm+bounces-33297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D998DB3A1DB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A80A05CDD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69242221F0A;
	Thu, 28 Aug 2025 14:26:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86A21CA02;
	Thu, 28 Aug 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391162; cv=none; b=fgSJOPENt3OBTx8I5CxdMS9nJDI85CzOGkGeX/+Bc9ScqzRayGZ0RrU/cMS0SsdRNdaFFuC2igakx8pvdDyYTqyKmdlwEQXmBU4WK8diy/ewN03c92Ia8N3W4dzdf5irimpCOg/4zDdpu0vqPhmj25kjByHOe9so1zTMcf647JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391162; c=relaxed/simple;
	bh=tVpT6XjIyI1FQCJlEk+4ojWuzvl5wVAREanoCFg6vgA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VXtwv9pYejjuLeCGk0qVJPg1jit5o7rf46C2RRh3X2u5/BoGvGnjtthv9ZnnphTsH4IlkbV2k0ROvDANVZchN09AqgYOKhRNmDXkpAlEK7TwWBJH8srJaQAFF2PikIiR0UeJZa7r63e45SX7tLJrmyfEF3cRWA/6WmZdmxBw+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B644F1688;
	Thu, 28 Aug 2025 07:25:51 -0700 (PDT)
Received: from [10.1.37.80] (e127648.arm.com [10.1.37.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763CE3F694;
	Thu, 28 Aug 2025 07:25:59 -0700 (PDT)
Message-ID: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com>
Date: Thu, 28 Aug 2025 15:25:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during,
 initialization"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.

Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
in (and leave them online) which weren't supposed to be online.

With the revert and nosmt and maxcpus=12 on a raptor lake:
cpu	online	capacity
cpu0	1	1009
cpu1	0	-
cpu2	1	1009
cpu3	0	-
cpu4	1	1009
cpu5	0	-
cpu6	1	1009
cpu7	0	-
cpu8	1	1024
cpu9	0	-
cpu10	1	1024
cpu11	0	-
cpu12	1	1009
cpu13	0	-
cpu14	1	1009
cpu15	0	-
cpu16	1	623
cpu17	1	623
cpu18	1	623
cpu19	1	623
cpu20	0	-
cpu21	0	-
cpu22	0	-
cpu23	0	-

Previously:
cpu	online	capacity
cpu0	1	1009
cpu1	0	-
cpu2	1	1009
cpu3	0	-
cpu4	1	1009
cpu5	0	-
cpu6	1	1009
cpu7	0	-
cpu8	1	1024
cpu9	0	-
cpu10	1	1024
cpu11	0	-
cpu12	1	1009
cpu13	0	-
cpu14	1	1009
cpu15	0	-
cpu16	1	623
cpu17	1	623
cpu18	1	623
cpu19	1	623
cpu20	1	623
cpu21	1	623
cpu22	1	623
cpu23	1	623

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Rafael, I don't immediately see how to fix this properly so I won't
try to, feel free to treat this as a bug report.


 drivers/idle/intel_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 91a7b7e7c0c8..a9c58395a425 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2507,8 +2507,6 @@ static int __init intel_idle_init(void)
 	pr_debug("Local APIC timer is reliable in %s\n",
 		 boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
 
-	arch_cpu_rescan_dead_smt_siblings();
-
 	return 0;
 
 hp_setup_fail:
-- 
2.34.1

