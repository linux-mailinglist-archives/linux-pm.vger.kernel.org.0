Return-Path: <linux-pm+bounces-17692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED869D0A3C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8551A282291
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000817B402;
	Mon, 18 Nov 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Xar6i5GW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BA14D28C
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914992; cv=none; b=qW19cH5us29KbME8aAdO+GCo916SrW41Bzhnz8LoeqT0FPjzbKMk1VGTq6f8GvXmJxCdUEEQZNzSdeqf+yoyf/Ah5vnyGq5DVYDaCgySw+uc9GezAYD23co18Ic7SEAY51FZYJtsmC6kzmvXkVl0uYJL5NoHGdh/iBtVln0rXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914992; c=relaxed/simple;
	bh=++bclHw7MThVATxoc6xQIvH9LdzVLIHAbNDmrrnhfXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaFMF3x1cvYQI1jhebD+Pw7HLKuppKCyr/z2zSD7nWfv2LaHNJm1zxLx3yzcKimnBfq6wytv3V98ozTktmRedKX1OUY1t9Z0PPWwV5TQ+ZZtlEGP1ShI9X+UVmEyvHTQEo4a5u+xOmD2F7vWqMx80i8E8873yOBNY3e3sF7RRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Xar6i5GW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=dn9tQnIRfTAKaz3pSHVeP8gqnc1nrbKo+PsyvXn6wig=; b=Xar6i5
	GWfRV1DYV6MF3jfx55RMLqYglPZ8mOR08s9+zRWKOzvmq+o6wvKqw0bO786ltu6L
	wxW3eelVfLs3QBqZZ0UdD3iLJ0v9HYBIpVDGKdxgE8LTI51zKb12mSjzE8eeJNuw
	sCPsVXjsn7fXbNQzK8jMDh7zSSSNrJzUT12xLQXBFKA5uQkBu8KbhkmgxHEr1pAO
	YDyrnlpmoTx1OiBDVlnFF4ZIZxVFYhhX7EILbr8LAF50GDQA/tJTtq+NGO/+Oxfl
	3vpWu003cTN95xDpz7J9860pM4mcphWobmnIox7lvLI77DYQsMHiOvTZgo6hEbs3
	ffC1ObvRHKsFTHjQ==
Received: (qmail 112328 invoked from network); 18 Nov 2024 08:29:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:36 +0100
X-UD-Smtp-Session: l3s3148p1@Ewzt4ConwtUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 02/15] drivers core: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:01 +0100
Message-Id: <20241118072917.3853-3-wsa+renesas@sang-engineering.com>
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
 drivers/base/power/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..82ce2d9f54e5 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -6,7 +6,6 @@
 #include <linux/export.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
-#include <linux/pm_wakeup.h>
 #include <linux/atomic.h>
 #include <linux/jiffies.h>
 #include "power.h"
-- 
2.39.2


