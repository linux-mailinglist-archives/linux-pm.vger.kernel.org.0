Return-Path: <linux-pm+bounces-27685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC62AC4F1D
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E823BF727
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7742741DC;
	Tue, 27 May 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="yC19Nsox"
X-Original-To: linux-pm@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22455271465;
	Tue, 27 May 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350823; cv=none; b=kFxxIBEHFAkprTCoTOrsi5XrkzflhMXKqRf3TdkLzwZEHgBxCJ4nDC0C/y/AHnUg9qQQlA+pjke5CI6liIiKHX7Y9RlJZJiiBTyYUe88U7mXNDPYRvxywMvTdrZh4g1vGGjhmJSbU/nS0SFU0KYpCauNackQVRagE/Ofp4/q9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350823; c=relaxed/simple;
	bh=wz2YLWMbq4CtCNT5+hXTW4Pe3i/LH9i2UYVGXT38WoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2GlNfwM7yYDIIrATAvLjFn3Sy5YaNfQzTXkzdEV14WeIJ7Itg9Kb+zCM+ICf8ta10zYHj3rNwgk7O1W43hN8FmbVJPXwcqBREWL6Ebmy1qtpyRNaXyJwDaUHCZNUfquGJ1GHNHGtA+ie7u7IVmlNgJ1fhCy2eH8UAW3C/bDqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=yC19Nsox; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748350820; x=1779886820;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ESLzshhHlbbN/3D+meQ6D0p0oySo64yvRcb3j4KyjO8=;
  b=yC19NsoxYsR8r0yCjDdPyjg0T0OW4kO8jJ9i0Yw/+1eSr+OxDj/LK7YG
   Lxhypn2P3P8r3dOCMX+vMb6wHj1gTEJ6uzvrKZvWBG0ZDNscTOh6K3VNT
   f4+dVDydPbnRDhvm9r4yyGU16PX7MK3k62i/5apv6i8YYspxb6n7ue0oJ
   OiHd32F4AxUIopMZC4Vk1NDKDSj7YNXuHyQFczB0wG55nMqMsB1B/VT/+
   7dRJFUgqVK+ZnND/FN2Knv2F5e3hZMzhqy7lC5GN4V/GM/w8fYyZMoYX9
   If5j9KOO0Lcl4/7URM5V9sTnRsq4Jf4ZbQyUAj6jwO2xTl9GSeDxFweou
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:00:14 +0900
X-IronPort-AV: E=Sophos;i="6.15,318,1739804400"; 
   d="scan'208";a="564893579"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 27 May 2025 22:00:14 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Tue, 27 May 2025 21:59:09 +0900
Subject: [PATCH v2 1/2] cpufreq: userspace: set CPUFREQ_GOV_STRICT_TARGET
 flag
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-userspace-governor-doc-v2-1-0e22c69920f2@sony.com>
References: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
In-Reply-To: <20250527-userspace-governor-doc-v2-0-0e22c69920f2@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=wz2YLWMbq4CtCNT5+hXTW4Pe3i/LH9i2UYVGXT38WoM=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJMt8cWKLyNObR6maTwhc3XJk6ey1cuVBh9ZVeRX8JE5
 bcnzR6t6ChlYRDjYpAVU2R5J7PuwkEry6avxxm+wcxhZQIZwsDFKQAT4cliZJh17mCj8v6aDeUn
 VCRVy1Nm68qGLDtQqvLcqCLhqmtK8QRGhrey+4KKO57M6jSawDJlhuYKnnPbt95/zhW8Ic+z912
 HCwcA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

When the userspace governor is used, the user intends to set a fixed CPU
frequency for a policy, for whatever reason. The CPUFREQ_GOV_STRICT_TARGET
flag is the required behaviour. Without this flag, the intel_pstate driver,
with HWP enabled, will set HWP_MIN_PERF to the target frequency and HWP_MAX_PERF
to the policy maximum, when configuring the HWP_REQUEST MSR. This lets the
hardware choose any frequency between the target frequency and the policy
maximum, which is not the intended behaviour. To fix this,
`cat scaling_setspeed > scaling_max_freq` had to be done. With this patch, that
is no longer necessary. Setting scaling_setspeed is sufficient, as expected.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 2c42fee76daa808f0cd1c7b1ab85476e695082e9..77d62152cd386d0eea69eba347b39f055ec860ce 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -134,6 +134,7 @@ static struct cpufreq_governor cpufreq_gov_userspace = {
 	.store_setspeed	= cpufreq_set,
 	.show_setspeed	= show_speed,
 	.owner		= THIS_MODULE,
+	.flags		= CPUFREQ_GOV_STRICT_TARGET,
 };
 
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>, "

-- 
2.43.0


