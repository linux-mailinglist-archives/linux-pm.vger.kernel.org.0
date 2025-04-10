Return-Path: <linux-pm+bounces-25073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C84A83884
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 07:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BB44637B1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0B1F0E3A;
	Thu, 10 Apr 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IKZXONR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830701372;
	Thu, 10 Apr 2025 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263596; cv=none; b=jBlVBaYjDU2j9EjDbUCi5vAlY8I0FAH+t5uDwJC6dQzf56G91oTveTMt1leQ6nX9JRZs62oGY1B0ImtoPrcYhwSS+xYNB26wcWpGyDTqLuh5UKo2JHW/9HH24IRYa6WzH3XkO+mplyxsZRUXlE3E+qN6Q2x+DwQvi79dKYe1Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263596; c=relaxed/simple;
	bh=x4lkIIUIDEuAdWkJfhkx8KGb8d40e+13jkCF+F8er2Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bbfMErwrv+q0kFLkjJx5WxesmK/n/ANUn/fWp0ZPou2qQEsvPdRhc7DCQl2PLGGEeU2KDoo6ArLQ4c+tPhPdKW5rdKut1ehzsvBJk8usx01M5fi1ss/OJXF04cEixkvVRWhwHrRYCVK24EHFebU+AYEf+Z5wZeBfTC7PHqRl5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IKZXONR3; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744263581; bh=KAYunzAnh8IZTAn3POQE3m6686i8Sy0Rg+4ZJW/YE54=;
	h=From:To:Cc:Subject:Date;
	b=IKZXONR3REfObL0+SzsmJeV1JybqAtDsRbIR2isltAvaxUdV6nzntotfBU2La32xK
	 uM7gbu7aidWFYurs/qTvZljhdlLeDa6sIFhaqXfRRJEgVxyWRk2+KW2A/tUNopN4l8
	 vVkweNxe2J/KEiLHy5cYpY7FLJ1iEv+JufHEkfB8=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 852A5C45; Thu, 10 Apr 2025 13:33:18 +0800
X-QQ-mid: xmsmtpt1744263198tgazjg59j
Message-ID: <tencent_8478BF8F2549630842D323E7394CB6F49D08@qq.com>
X-QQ-XMAILINFO: M7dxyDFn9MPm8KexzQHLy+mPN014pmGhGhqTGFvLq0cVE5KL4yznIo+9R0/9T9
	 kOzu/OuwUeAJc6tikPhGzbQDOFu14bVztGwBzIsOEjJBJ8/OT54vniOjEMSsrcNS4neJYsqc5KNk
	 PvjjbR4kOBWHJsekOvpZJYA+l94auXEf2fZGaJaBCIghXcgTKCl6KVIobjc0kiBUd/5aVUohJ0O6
	 8Mg+gQWw4ROOJN70/2xdsJSYbZCYwLZJVd+ipoIzjNsZsadJ6vUzxspMF095a1UfnUkISam8AO4j
	 FWmb7OCyHSSK+vAU8vABqyhWi3bBMvsB1yc1T+2l/WwoexOg0SYl0VNAjeHAc6ITvUh2hkGpf0a6
	 H8zBb6no811pwIWJTCAZ+2wU5laYQPmRw78v1QEIuDqpWXrJ+SC0tTX8GBCXTqGogplTRZJSXwP5
	 6KRtWd0GThe3vQMHQwUuvz1Ft/uIy5ujCjq2ErH+3/G5qYCV4GNXdzN7zN+dM5avyXbciW3IXSRA
	 0fllEcrKMZhsF4Is7Jeu+Y877hrolpCl0sD6KS6a4ZaPPHmEP5gfKz9UfExJXgaZDVvc05oG4TvJ
	 8pJAHADlY6C69nGOBWr1gitpclvWkqTZ7PL1pnRBwj3/JTJbEgHsRjosiZjMt6cU+aVin38sfepO
	 m7mntQG4PUQ2wMH7MTggJXntTJPeh2tAjOSlTweAxk3wjuxlVw1h/71LGzDRB9Vn+CN4zi9+qyhy
	 kIqFw8NkP1t4Oe1UT/gdwI+9BObrMZPD5/6wjzwxB735Fr27+ELChFm0AfCgGh0AZ4Iw3BM2nEam
	 L1ZhN7yWn3vuuoepY5Pbi/wkFCJDKFRHw6/Vy2gyx9y0FIUzIBqd/6/8mcInhxxVwqGfjsxo+N8H
	 LDMZpBTmXQXW8V/xgHBfMXOm80frN7FjbgKOTMQ4RYic1o1eWcxXxc9jJWfsYnwcR0sndHWxwnai
	 pvz11RBjw=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yaxiong Tian <iambestgod@qq.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] PM: EM: Fix potential division-by-zero error in em_compute_costs()
Date: Thu, 10 Apr 2025 13:33:17 +0800
X-OQ-MSGID: <20250410053317.890254-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

When the device is of a non-CPU type, table[i].performance won't be
initialized in the previous em_init_performance(), resulting in division
 by zero when calculating costs in em_compute_costs().

Considering that the performance field in struct em_perf_state is defined
as "CPU performance (capacity) at a given frequency", the original
calculation method should be maintained when the device is of a non-CPU
type.

Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/power/energy_model.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..bbd95573d91e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -231,9 +231,11 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 			    unsigned long flags)
 {
 	unsigned long prev_cost = ULONG_MAX;
+	u64 fmax;
 	int i, ret;
 
 	/* Compute the cost of each performance state. */
+	fmax = (u64) table[nr_states - 1].frequency;
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
 
@@ -245,9 +247,15 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 				return -EINVAL;
 			}
 		} else {
-			/* increase resolution of 'cost' precision */
-			power_res = table[i].power * 10;
-			cost = power_res / table[i].performance;
+			if (_is_cpu_device(dev)) {
+				/* increase resolution of 'cost' precision */
+				power_res = table[i].power * 10;
+				cost = power_res / table[i].performance;
+			} else {
+				power_res = table[i].power;
+				cost = div64_u64(fmax * power_res, table[i].frequency);
+
+			}
 		}
 
 		table[i].cost = cost;
-- 
2.25.1


