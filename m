Return-Path: <linux-pm+bounces-17693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261149D0A58
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EE9B2238F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF419922F;
	Mon, 18 Nov 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Mm/7i0Va"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A1198A08
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915003; cv=none; b=FNpuZC14RG6Cnjs8N/XrxN7Xu7kU1YUTurhPacPZsLyw6TzFq3uvPxIfGP6d+UKdNh9sHmMV8uHYGdsPLb/I+u8QO9+AjvK9dAE463d+S5BJwVeNQ/3rkt2kdOor7iGLmZLRatPqn2gQOsU5bCD3QDqgddCsCSr3ln17gnhsTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915003; c=relaxed/simple;
	bh=tf/n/Vd2Qey2MSMkUj+THLnyykLaED63+olpFeHg3ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geDftqkfPmpu+N0Szi+mKzE521OvHzKql72pZHIjA8CFqKxVvihLuTiYNwltqCPGnJuZZ891ysv9AWF1WvMuCOyOM5ciqdOqSLC/2/p5QbwNZ3OR/13MHIDuIFqpdQE/Itbz3L89UN84jtJWS8Ltsoy0GWFpPya8myCGZRGJU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Mm/7i0Va; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=9HmycQ3Q7Y5MjAcI/7v5Syt7rKnHNfDgqZTswGXx3ic=; b=Mm/7i0
	VaDHscWaBeRw1E6Ns7S/hIZ3c5XipVyVDOF1qPzPpYLOcsQ7j8CipgqeZykrw7aI
	koPXWw+fAQBO6BZty7gz5CRXyxHPUxukZHrNsR95YEcL4TKh0gQLn2lc6KlW27tf
	GoxBYDFhd4XzGXEqxOu4a4Zf4K0l1BCK0+yZcfXV+h01UZSnVRpIniyCtY6DLfo6
	s8pxj+sqlF7xRyzc7XhJeL8KOZJYiQcSs1tDJO/9CiD9oOeEX4WmViH7jQ9OgOdI
	q8G0+6zcfr3XGF3cyC12GGyAUkOw3I5cJzx12YPQ8YAhKxAANuNG1mLntqvRMKkr
	1R4/cOC/pZ0uskkg==
Received: (qmail 112606 invoked from network); 18 Nov 2024 08:29:44 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:44 +0100
X-UD-Smtp-Session: l3s3148p1@oAto4SonxIYujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 15/15] PM / Sleep: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:14 +0100
Message-Id: <20241118072917.3853-16-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 kernel/power/autosleep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index b29c8aca7486..865df641b97c 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -9,7 +9,6 @@
 
 #include <linux/device.h>
 #include <linux/mutex.h>
-#include <linux/pm_wakeup.h>
 
 #include "power.h"
 
-- 
2.39.2


