Return-Path: <linux-pm+bounces-33027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92475B340D1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D90E7AFF6F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3C274FF5;
	Mon, 25 Aug 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgRDcVGD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FC19AD8B;
	Mon, 25 Aug 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128758; cv=none; b=Uj4UhZwe5yVG6b5ycVWAWkHmJ0L18QWhtiL5rKypOcAYaTBABJr7Milv97IKwKumOa14tRzsavxDKSL2QddMYskQsGOxYhnGOVmvUPMxxxA0m4n7X/CwDAwUdh4QYrhF/K/5E4Cv2/FH3v3pHQqKZSYCVAs1rRgs8eNuLAKjzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128758; c=relaxed/simple;
	bh=kOYOJ4Zd3xGh16wfCQ1Hg2f6q5P/EI0G9vscAKqa5hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzGPv5i6V9uH4B3IG6nF0Tbno3hHP7CjyA8wvsNb4UGg8RydQg6zcc7hISROx/C1IQpjwQUpRHbu6IIW6qvkL8AFCDkCeu1qMnwcCjoSK5flgjCQlKHtjXK8SM1PGNj2pBRpIe7je0jbgNYlUuoSl3JT080BXQVOZy6Ee+9TZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgRDcVGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E2AC4CEED;
	Mon, 25 Aug 2025 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128757;
	bh=kOYOJ4Zd3xGh16wfCQ1Hg2f6q5P/EI0G9vscAKqa5hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgRDcVGDaa8rOwo7W6yWRCvL3saG7bvj1myOQjViVWnC3vQ/SfoEBX9RFFzClTnnw
	 WkhvsnCQQdeybrSIuBgmsSPrA+4x9PqL79MZjQBsp61KPtcaLIX4iERLxqN55XdEBd
	 MGIECot0704Aw4cAU4rSLLaEgaDGTknHl32RzUYlQq2pKgdfylFspJzOf2yBL6/Kcp
	 uOkalHalxFz2rEvY1RLwKRNj89hxZYavS03gQpLMyw/uVK99V6J3IzKw6a7R9jFgJg
	 ylr2qmwLVz2FTUyyYSVIr024dYC3kHvIQIyArS3rw3Rw/G5+L9KaVw13sjf3UzXgVb
	 Xl8SeVEAMy6HA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 1/3] thermal: gov_step_wise: Clean up local variable initialization
Date: Mon, 25 Aug 2025 15:27:46 +0200
Message-ID: <6203592.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12745610.O9o76ZdvQC@rafael.j.wysocki>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the initialization of local variable throttle in
thermal_zone_trip_update() more straightforward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -69,16 +69,14 @@
 				     const struct thermal_trip_desc *td,
 				     int trip_threshold)
 {
+	bool throttle = tz->temperature >= trip_threshold;
 	const struct thermal_trip *trip = &td->trip;
 	enum thermal_trend trend = get_tz_trend(tz, trip);
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
-	bool throttle = false;
 
-	if (tz->temperature >= trip_threshold) {
-		throttle = true;
+	if (throttle)
 		trace_thermal_zone_trip(tz, trip_id, trip->type);
-	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 		trip_id, trip->type, trip_threshold, trend, throttle);




