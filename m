Return-Path: <linux-pm+bounces-30474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38608AFE807
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21DD1C47886
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E128E572;
	Wed,  9 Jul 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Rmpm5GBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83C22D7B1;
	Wed,  9 Jul 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061543; cv=none; b=E97oZLVJS1qoKp/xlm3ReHXTIquJMDWa9aHD943KsJhHL6xXqYiZcbbyZv0u7y99fwAj/VQ9kUfq/33p0MXI9mKMkbwSwUvGO/OI4VghYpFulIiLzWQAaLvg0VElYU+OTegLx7dOchKiWRyiwlp4g9CYETorbvDyS7f3KRFWx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061543; c=relaxed/simple;
	bh=X6wAIxGJg9I2gSKZsvbsMKrCF5bbQXnk8/bFYe5BAsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/KDXhMyeF5ye9QFywAj1EnuNqKlc5p/Ezz+nra1Jbmb0n4P2RYVbLuW8kI5J4OHr+E4KF2JASRfJjskcQGn3NDznzvnnW3vyJ65UiKsai8bBwt8GB0eNcgMn7Ql9kS0Kje7fanZ5rrXVIVYultg9p2SodqNwA3Cgkb5J3NjE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Rmpm5GBU; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 030A666F54B;
	Wed,  9 Jul 2025 12:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1752057706;
	bh=X6wAIxGJg9I2gSKZsvbsMKrCF5bbQXnk8/bFYe5BAsM=;
	h=From:Subject:Date;
	b=Rmpm5GBUH+Zmx/vvUbAZXikgmsRho/utlcWCZSfh9wO9asrGNTXDL/Fq7DnyQWyg7
	 adlFR0NPE5vf2m6AAIAzn/GkFdsVwJSr4c1pYCI52Qm2OJd4p+cRC0Ick1aGcEth+f
	 QebO+jdSoYFkhEU6S/icMvh/i5R4+ws/07VeFyVPElKbruwG4hJFJqx2pBAN/YxGdD
	 Io4PIe2R36+x3/TP60XjuVpF/Iic6b/Q4E65+xt5ptqii0KPIuiEuqDP078rgXEDKa
	 SNfAT7wUbqPmt+jM0mq2teVnEn00vHgt3tI3YprzT9y8OKNXethstrxPMPFcczd24+
	 SokYF2FGiyEMg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Alex Elder <elder@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1] PM: runtime: Take active children into account in
 pm_runtime_get_if_in_use()
Date: Wed, 09 Jul 2025 12:41:45 +0200
Message-ID: <12700973.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGJaDV5ofXpT6ZlS8J9pKL9OR28C4yBvUyYiGiZ7jq6SJce9VIYVdnK0DAaDhHJahS06XJlgCaTLYGe+73iY1ji8yDQD22axo89159c2Aa2yFD5ZuaRyQhwvu7CTmlcD+EZfyBfZMvObbN2lC/qFHTHCpdy9KzDPNsEXHMYEnpCxkznSDh9sEgvYE9X30clwWIEHJpuFl/mBkipSk7+TMr2kRlmWWdvSXiHOg+QdqJppeKCITPwH5928F7DX0kHPaac7YOtcXQg+bn6oO/tic86wKEaeJauphPhIcKjXKP7W//RSVwg49n8uutHVo+KJh9j3M5rWAXZ2OK/YjmZuxXcN1drPykQQ5G8/1MlrwnM5xEdC0fAdO8kilmykN/+efjGAetV8zxoCPvam9p60hErsu6KVTi2+tqlchuwtnQ317h08M3G0MRnWYPnxf8HUDCuy3Od2c22qMW/huSo8qFkCwyFrrr0v5cEZ35DQfsD890Gk8TEjiEx2ucy6zGQSps5YaC/JrgfPYcVyYAbLSWPKfkHM2VQ6k4WEJ/Lg1yqK2gYX9w23tk4VQfPS2xVgOn1D93NRxHx87z9TeeS9fQ7+k0hI6IBCmzxYgTF2ztZNFInrGB8GHJjTz/J/aLU0fqHigHSaTEgPOADmbxQkYWkkS3QqZbkP4dOZ/cHV0diLg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For all practical purposes, there is no difference between the situation
in which a given device is not ignoring children and its active child
count is nonzero and the situation in which its runtime PM usage counter
is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
device's usage counter and return 1 in the latter case.

For consistency, make it do so in the former case either by adjusting
pm_runtime_get_conditional() and update the related kerneldoc comments
accordingly.

Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1203,10 +1203,12 @@
  *
  * Return -EINVAL if runtime PM is disabled for @dev.
  *
- * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
- * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
- * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
- * without changing the usage counter.
+ * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
+ * is set, or (2) @dev is not ignoring children and its active child count is
+ * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
+ * the usage counter of @dev and return 1.
+ *
+ * Otherwise, return 0 without changing the usage counter.
  *
  * If @ign_usage_count is %true, this function can be used to prevent suspending
  * the device when its runtime PM status is %RPM_ACTIVE.
@@ -1228,7 +1230,8 @@
 		retval = -EINVAL;
 	} else if (dev->power.runtime_status != RPM_ACTIVE) {
 		retval = 0;
-	} else if (ign_usage_count) {
+	} else if (ign_usage_count || (!dev->power.ignore_children &&
+		   atomic_read(&dev->power.child_count) > 0)) {
 		retval = 1;
 		atomic_inc(&dev->power.usage_count);
 	} else {
@@ -1261,10 +1264,16 @@
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
- * it returns 1. If the device is in a different state or its usage_count is 0,
- * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
- * in which case also the usage_count will remain unmodified.
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
+ * ignoring children and its active child count is nonzero.  1 is returned in
+ * this case.
+ *
+ * If @dev is in a different state or it is not in use (that is, its usage
+ * counter is 0, or it is ignoring children, or its active child count is 0),
+ * 0 is returned.
+ *
+ * -EINVAL is returned if runtime PM is disabled for the device, in which case
+ * also the usage counter of @dev is not updated.
  */
 int pm_runtime_get_if_in_use(struct device *dev)
 {




