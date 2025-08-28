Return-Path: <linux-pm+bounces-33244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAEB39AC0
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05035E3DF5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC730C62D;
	Thu, 28 Aug 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taKNbPL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3E17A2E3;
	Thu, 28 Aug 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378786; cv=none; b=UzYTfxJFAe2Sa3GA4ebykCXnbN0xQdqvrn7y6M9pyd6M1H5ey7mZ3eQonrWGwTqcMqwd52HeiplZpufO7qFzwAn+mxo9fGeIULhOa41LvvI1YtHQQkbIehLQ47Nx6Cend2nAPcHjtXTdVelCt7tcTAKF3rWPEue2DtcYOYmwJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378786; c=relaxed/simple;
	bh=sQxAZWi5Hlql3g15R1EmV8s5uhOf7RUvbElWTk4XWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUas5YGVB5gcfcXHQmxB9wBhyxcjVvCBIRU3GJGpO/vR7J/ocbJdMRaueAe4hXFMhT7fhzxPnlccRDSYtH6xu3HLLx5mtHk2TQ4mN3tW6J/Kp2JrACB49fZk+ZR/NGRbw5HMco2sL4k+sdQYFGqT8kPrnFC9acJ7kajTDnuT5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taKNbPL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB98AC4CEEB;
	Thu, 28 Aug 2025 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378786;
	bh=sQxAZWi5Hlql3g15R1EmV8s5uhOf7RUvbElWTk4XWi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taKNbPL1DZ193OFvzRiYaCvGRBCO9vaWlSIb9ql3JsrzI89cKUW5iGTA5YxI3QRR5
	 NGKBsGB+X7svjessv9RyQgqoLln5yjo5rSPbtF/qI+mw7H6gpq7bcyDBv3IWAR7hmZ
	 1VWqkFjgFRs/B9rG/oU9ej81POa2CLpfOyyVxx4WjLqEjimzbWRK6YEGiHpF1C+Pkc
	 5OyuPI1ko1hFTASm3Hc7KWbTffTkVI6ObHV8dOLasKCqyogzK2baWGrpGbvAf2123y
	 saSO9kKQPfVG+mVjkGo8ENKNPzFm3Llo7oGeQL+rR0wQQu49V9689xl5d22AWHfmi5
	 cG016z+NFQG3w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject:
 [PATCH v1 2/2] driver core/PM: Set power.no_callbacks along with power.no_pm
Date: Thu, 28 Aug 2025 12:59:24 +0200
Message-ID: <1950054.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12749467.O9o76ZdvQC@rafael.j.wysocki>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Devices with power.no_pm set are not expected to need any power
management at all, so modify device_set_pm_not_required() to set
power.no_callbacks for them too in case runtime PM will be enabled
for any of them (which in principle may be done for convenience if
such a device participates in a dependency chain).

Since device_set_pm_not_required() must be called before device_add()
or it would not have any effect, it can update power.no_callbacks
without locking, unlike pm_runtime_no_callbacks() that can be called
after registering the target device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/device.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -851,6 +851,9 @@
 static inline void device_set_pm_not_required(struct device *dev)
 {
 	dev->power.no_pm = true;
+#ifdef CONFIG_PM
+	dev->power.no_callbacks = true;
+#endif
 }
 
 static inline void dev_pm_syscore_device(struct device *dev, bool val)




