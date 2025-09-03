Return-Path: <linux-pm+bounces-33733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA25B42412
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E441BA6326
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD562F618F;
	Wed,  3 Sep 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLVTA5Rp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243812EAB98;
	Wed,  3 Sep 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911171; cv=none; b=SugLPPquz9R6dllFs5aJG5ogtr8gxJCUCTK0Nvw3m+HT3nqZL1WaKYKNTDlXQ5csHfzBUnUu9uIVSzTVSlmQcJjya1GT0lnWdqdaGjoV23w934vLtepNQdO5RWEl3xLyJXi90ytSJ2T0HRZy6K9ipnOEgQnsU7eRoxl8EGlE+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911171; c=relaxed/simple;
	bh=nV+S/XHLNnvkXUtLlnmeR7m6BvGtTpNnmtypMB7Ondw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MnAJB2CeFRgJzsJDo29MaZw6D/al3rMGA+Cko69vKywM7z2AMj0TWdeT3dqlTf+KXlwy+2l5gDvQlHbU7E+xOQnRe0ONgs0qs/WuBlmDENWPoVVKxIOmNWJfp5RBQ4cMBVqSkWe8sp7/icQy3u2WbDAR4+c6nLzTqEYXPDt6WLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLVTA5Rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5987C4CEE7;
	Wed,  3 Sep 2025 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911170;
	bh=nV+S/XHLNnvkXUtLlnmeR7m6BvGtTpNnmtypMB7Ondw=;
	h=From:To:Cc:Subject:Date:From;
	b=jLVTA5RpyM32+M2n1e8WmRlGXciz1hK/3H7yt5uwgmBmhTCFReAFimDJUHl+nZX2b
	 IqbmslFMd0j6yyavaNWxouSICJ+fa6K8UwqUVqjP4KcidVvBEp7GkzKj6tfaia99id
	 XbLzL36r31ZZA5OsJxDm3ttQlNHK82yW3/BfWUR4UaSntZoJS+TnCvzUjEQ0NJ+7d2
	 cy1JrLYdpHlWtvVc18Xyy/0XSk5++qyQTc27SJE7Ccm1rjtGyIBkGwI9vdaNu8ptSF
	 Rl9nYvHmKM0XLFSLOmHgpNMmlXL2aBk21XQZf8fNGmEGBBP4Y7F9d7Thr3C7Jiq8PF
	 9g2b7QK7Nd/ig==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject:
 [PATCH v1] thermal: testing: Rearrange variable declarations involving
 __free()
Date: Wed, 03 Sep 2025 16:52:45 +0200
Message-ID: <5934556.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Follow cleanup.h recommendations and always define and assign variables
in one statement when __free() is used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/zone.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -184,15 +184,14 @@ static void tt_add_tz_work_fn(struct wor
 
 int tt_add_tz(void)
 {
-	struct tt_thermal_zone *tt_zone __free(kfree);
-	struct tt_work *tt_work __free(kfree) = NULL;
 	int ret;
 
-	tt_zone = kzalloc(sizeof(*tt_zone), GFP_KERNEL);
+	struct tt_thermal_zone *tt_zone __free(kfree) = kzalloc(sizeof(*tt_zone),
+								GFP_KERNEL);
 	if (!tt_zone)
 		return -ENOMEM;
 
-	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	struct tt_work *tt_work __free(kfree) = kzalloc(sizeof(*tt_work), GFP_KERNEL);
 	if (!tt_work)
 		return -ENOMEM;
 
@@ -237,7 +236,6 @@ static void tt_zone_unregister_tz(struct
 
 int tt_del_tz(const char *arg)
 {
-	struct tt_work *tt_work __free(kfree) = NULL;
 	struct tt_thermal_zone *tt_zone, *aux;
 	int ret;
 	int id;
@@ -246,7 +244,7 @@ int tt_del_tz(const char *arg)
 	if (ret != 1)
 		return -EINVAL;
 
-	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	struct tt_work *tt_work __free(kfree) = kzalloc(sizeof(*tt_work), GFP_KERNEL);
 	if (!tt_work)
 		return -ENOMEM;
 
@@ -330,20 +328,17 @@ static void tt_zone_add_trip_work_fn(str
 
 int tt_zone_add_trip(const char *arg)
 {
-	struct tt_thermal_zone *tt_zone __free(put_tt_zone) = NULL;
-	struct tt_trip *tt_trip __free(kfree) = NULL;
-	struct tt_work *tt_work __free(kfree);
 	int id;
 
-	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
+	struct tt_work *tt_work __free(kfree) = kzalloc(sizeof(*tt_work), GFP_KERNEL);
 	if (!tt_work)
 		return -ENOMEM;
 
-	tt_trip = kzalloc(sizeof(*tt_trip), GFP_KERNEL);
+	struct tt_trip *tt_trip __free(kfree) = kzalloc(sizeof(*tt_trip), GFP_KERNEL);
 	if (!tt_trip)
 		return -ENOMEM;
 
-	tt_zone = tt_get_tt_zone(arg);
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone) = tt_get_tt_zone(arg);
 	if (IS_ERR(tt_zone))
 		return PTR_ERR(tt_zone);
 
@@ -387,7 +382,6 @@ static const struct thermal_zone_device_
 
 static int tt_zone_register_tz(struct tt_thermal_zone *tt_zone)
 {
-	struct thermal_trip *trips __free(kfree) = NULL;
 	struct thermal_zone_device *tz;
 	struct tt_trip *tt_trip;
 	int i;
@@ -397,7 +391,8 @@ static int tt_zone_register_tz(struct tt
 	if (tt_zone->tz)
 		return -EINVAL;
 
-	trips = kcalloc(tt_zone->num_trips, sizeof(*trips), GFP_KERNEL);
+	struct thermal_trip *trips __free(kfree) = kcalloc(tt_zone->num_trips,
+							   sizeof(*trips), GFP_KERNEL);
 	if (!trips)
 		return -ENOMEM;
 
@@ -421,9 +416,7 @@ static int tt_zone_register_tz(struct tt
 
 int tt_zone_reg(const char *arg)
 {
-	struct tt_thermal_zone *tt_zone __free(put_tt_zone);
-
-	tt_zone = tt_get_tt_zone(arg);
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone) = tt_get_tt_zone(arg);
 	if (IS_ERR(tt_zone))
 		return PTR_ERR(tt_zone);
 
@@ -432,9 +425,7 @@ int tt_zone_reg(const char *arg)
 
 int tt_zone_unreg(const char *arg)
 {
-	struct tt_thermal_zone *tt_zone __free(put_tt_zone);
-
-	tt_zone = tt_get_tt_zone(arg);
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone) = tt_get_tt_zone(arg);
 	if (IS_ERR(tt_zone))
 		return PTR_ERR(tt_zone);
 




