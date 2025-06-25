Return-Path: <linux-pm+bounces-29490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE3AE7E70
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BF7B18AA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073B29DB95;
	Wed, 25 Jun 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yEiOiXkJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qQngjBks"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2729DB79;
	Wed, 25 Jun 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845708; cv=none; b=gl4RkKORM+bkTn4R18LCaonwuu2EItG18B3FwHV2KMRWtXowjM+9ZpoXCOXEPhaqBsrqIxFlw6+R1KHfLHaUdAplyDrKuyiUEaWqfce8YOXhlr6phrLbKj0l5ziNmasw1jMe5HWLvezPdjoFFL63kjJIbj+M4k3TJPJPoPQOlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845708; c=relaxed/simple;
	bh=fjLTcchgfb41mfycQttKP0dhNmym6kx+G2b65FCdzRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YciHcAtcIl/00CqdOk8AVPIH7ag4S3uF+Dh6IQX/D3hEC9jGdvAl8+cPQuqUvpQXCWrixlDdAXaoR+YaRvHGr5xlFuzobOIh4SOUcyom0dmoEfPTgVbkiLY+ScIVUKbb6m+McW+NBLKF1mv3KeCwnWBfH7TsI09ydT7f3mHKnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yEiOiXkJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qQngjBks; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bRy5Z6M32z9v0J;
	Wed, 25 Jun 2025 12:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750845699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MP4qRiHWvycY3gZlggHSbNf31EkDcBHeSDJPJmKLz6Y=;
	b=yEiOiXkJj20WMUXdc0y71KSCOGkmwkvIYgHWWJoZjtBj+aSoSXtJ72WqHRYFyzC6++C9Xt
	ixfdY9JN+YHejaRwxQQsi9+d6VFtrPvhtBvNd2ARPK20mxCQOkk9SnZrwzRXUX8QrBz8vK
	xa8XRG1RHotJLqdbtkioa3WsZEVO88BUUsvW3DaWcZkEFBgE1A0m6qfnm9bChVu4F5CYYA
	XjROK8wFpZwBGoL4ZQtNDfq1r/cz1wNiHUQaerBkoylu0NkEq2zEErOfSUB156AfLopDBY
	GiXA+SpgvY+5X4Ss/fJ+1mp0hc2M8/waGl6EzOvNrvXA2iMJJidfurPkhy5Knw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750845696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MP4qRiHWvycY3gZlggHSbNf31EkDcBHeSDJPJmKLz6Y=;
	b=qQngjBksnRqJx64c2mZyEFn5P4zT6QJJ1aYIjjEkDVc0Iax2Tv/ImVe4wWUpQd0l9wM1gl
	i8nIp7ekXasvDVPJB5Yi/idmryTx3aYaqB0T+qMbH+glanflHH9JGT1IflUygT+32TeKAg
	5PU3H/On8gnphdS60BhBhuRge7VTE/NrQUWVWRxsdFP5FBoA+GFiTnkz9HbDxuGbn7CVVF
	ei4ZIsvZGzl8adZd8tWZpM0DMU0GpuMB0NsqwH5ZgMIh4/Qvc50Vd/pCpLzTPIIfmEqoW7
	mymyzfBEvaqw9YDlOUhXS5w1XO4KcuUxZY8lNErIlvr2xOpwGH8FftO1aL/WxA==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] thermal: rcar_gen3: Add support for R-Car V4H default trim values
Date: Wed, 25 Jun 2025 11:59:59 +0200
Message-ID: <20250625100116.7538-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>
References: <20250625100116.7538-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: imk131dy3wjd6q69tomizyaqdrxwpxw3
X-MBO-RS-ID: 5e6af6833454875df54

Add default trimming values for the four temperature sensors located
in Renesas R-Car V4H Working Sample SoC. The trimming values are
identical for all four THS temperature sensors.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index a388bd3135e4..f361991e9651 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -372,6 +372,17 @@ static const struct rcar_gen3_thermal_fuse_default_info
 	},
 };
 
+static const struct rcar_gen3_thermal_fuse_default_info
+	rcar_gen3_thermal_fuse_default_info_v4h = {
+	.ptat = { 3274, 2164, 985 },
+	.thcodes = { /* All four THS units share the same trimming */
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+	}
+};
+
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
 	.scale = 157,
 	.adj_below = -41,
@@ -396,6 +407,14 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
+static const struct rcar_thermal_info rcar_v4h_thermal_info = {
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
+};
+
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	{
 		.compatible = "renesas,r8a774a1-thermal",
@@ -439,7 +458,7 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	},
 	{
 		.compatible = "renesas,r8a779g0-thermal",
-		.data = &rcar_gen4_thermal_info,
+		.data = &rcar_v4h_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779h0-thermal",
-- 
2.47.2


