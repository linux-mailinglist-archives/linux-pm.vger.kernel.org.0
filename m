Return-Path: <linux-pm+bounces-39795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FDCD71B0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D788A306DCE6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DB33EAFC;
	Mon, 22 Dec 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD/LfKTW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DC633D500;
	Mon, 22 Dec 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435842; cv=none; b=jvDx/gzBv8kvrB7D7hy8dGSp257wl79mc13tXCkPkBulHj0u403mfmITAcppWXaEtYLFv5NeYhSWM0PpuQPCLEhw0JcAEl2wJqVG7Eqoh9794xbO+M5ZEqqB5QdYt1QshQRPtSDRq1QcV1cgCY7j9sqxwCyCVlTAdYZfhjQJnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435842; c=relaxed/simple;
	bh=GO/m4kLE9uXqI+PQMFuIT8IUvN6EAoMLB4KMAF8UHb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZgfTi+EonZFPbFbtAaNtNmStOH3VGmqGTa8I1mn2i4T6lpBoZsXdcsFviCngk3Pa5phGIPfHTV7uPg7mmwyzsBmMn3yNFemLD2MJ0BMm2ckVYjFZ6ZI01H89kPt2lYpucKqzOYhZ2hzg45ld35n9d5ygzfnuyCj6sUh+mBCNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD/LfKTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF402C4CEF1;
	Mon, 22 Dec 2025 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435842;
	bh=GO/m4kLE9uXqI+PQMFuIT8IUvN6EAoMLB4KMAF8UHb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XD/LfKTWwQ4z25zLFS2LHWYz6nNQ136F9UVqrg1IC1ju46OJamOr1+ADuJmZAZyDl
	 2qbjWEkyapEzv32DsvK6W3/SxxWMOqSPHwjz5X9B3Z+7P49LWzMQtd23ophkcKMm+u
	 k0wSQu8wxVh24tYgBXV7a9PBj44jUoigPHD1J/tpD5NwFIjoX1pZfLbUlR/SGcKb+h
	 UFF/SIrCpLuy1ntlZkr7Om64S++B68kP5Xljscs+mbhBD0deV1C/5+YUHqP9TOEHnJ
	 npAS770qf8J1TBCLdWZUFqt+GuvVeTCWXl8EWyO6Ig2IMu5B3z9tPdBmK7yfrbErqg
	 v0sI7l9inj6yg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 17/23] coresight: Discard pm_runtime_put() return values
Date: Mon, 22 Dec 2025 21:25:57 +0100
Message-ID: <2058657.yKVeVyVuyW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Failing a debugfs write due to pm_runtime_put() returning a negative
value is not particularly useful.
 
Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel
has been configured with CONFIG_PM unset, in which case
debug_disable_func() in the coresight driver will always return an
error.

For this reason, update debug_disable_func() to simply discard the
return value of pm_runtime_put(), change its return type to void, and
propagate that change to debug_func_knob_write().

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/hwtracing/coresight/coresight-cpu-debug.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -451,10 +451,10 @@ err:
 	return ret;
 }
 
-static int debug_disable_func(void)
+static void debug_disable_func(void)
 {
 	struct debug_drvdata *drvdata;
-	int cpu, ret, err = 0;
+	int cpu;
 
 	/*
 	 * Disable debug power domains, records the error and keep
@@ -466,12 +466,8 @@ static int debug_disable_func(void)
 		if (!drvdata)
 			continue;
 
-		ret = pm_runtime_put(drvdata->dev);
-		if (ret < 0)
-			err = ret;
+		pm_runtime_put(drvdata->dev);
 	}
-
-	return err;
 }
 
 static ssize_t debug_func_knob_write(struct file *f,
@@ -492,7 +488,7 @@ static ssize_t debug_func_knob_write(str
 	if (val)
 		ret = debug_enable_func();
 	else
-		ret = debug_disable_func();
+		debug_disable_func();
 
 	if (ret) {
 		pr_err("%s: unable to %s debug function: %d\n",




