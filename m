Return-Path: <linux-pm+bounces-15314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F0994466
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E9285833
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF918C00D;
	Tue,  8 Oct 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VvJwCWOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B817C9E9;
	Tue,  8 Oct 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380101; cv=none; b=RQgGHjD6qeTcqljMyMyp/byD9ucRSaa3Q7YgsxYGFrJP2b6IFDD9YAW1NDl+89XPXJLg18j9g2UCzWycAXkfrzjeevbo0EiyCBgBR5SFo2LYcM4WgJRcPhXGssV2FJyUjaLHwktKrtl9g2nICOjSJk2iTn5nf507kbtvbtX0Vg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380101; c=relaxed/simple;
	bh=xiQyNd8nwgbLMKCGJtOhLvhbzts3Zyiesad1YOA67B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lt/HxPCS/W/sxFet/J3lerK8IyqaZ46Z8k9K8pd8aeRNkAE5ro6KKzXOSzidiZuzBfKy/aLfL+zeM1uaGDd7X1MxhMP0GGuaPsubGVeWlc1tShl8sFxjd44E6stgF8CtpSfIANSKxRvhOVHtDX/0hgGFCKPQWYYrQk7yDRAMXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VvJwCWOS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76E9AFF805;
	Tue,  8 Oct 2024 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728380097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6pUgjetX71AkeSNcjihdWO8cWqAN+2fklEFHWBBZho=;
	b=VvJwCWOS3HqYCL/UdfU0NyI05aguQMiqPO9D7kyZlyr2h6hDa40yHt1I0XYdtySg59s8J5
	uhqzv9KfRlXb9EEA39Qd2tnXJTxHtKDssyBYSqKGUp6cv5TR697+BQImUoCm88t9aYWN8h
	9rOtFT2UyucyqajoGnh763HOIv1IKPo0QIQUvCjlw+MKMpKMBI4UVgEEJrYT/U9Q4pixVy
	U7X9wv50VXpzez8EhArLYf0go/uu5KWZTF4WglVrzRVWHyYhr8NcV6zBzBaJcCiGtnfsUv
	4+ZUzDKUqZz2G5KEkidAPGrwb5GlGzihm9PmTjbBY+cuguTrDvi12KB2cpbOtA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 08 Oct 2024 11:34:16 +0200
Subject: [PATCH 1/2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, u-kumar1@ti.com, 
 tony@atomide.com, khilman@kernel.org, gregory.clement@bootlin.com, 
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, 
 richard.genoud@bootlin.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

With this flag, if a device is marked on the wakeup path, the corresponding
PM domain is kept powered on.

Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1510d5ddae3d..38448b4a035a 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 
 				pd->pd.power_off = ti_sci_pd_power_off;
 				pd->pd.power_on = ti_sci_pd_power_on;
+				pd->pd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 				pd->idx = args.args[0];
 				pd->parent = pd_provider;
 

-- 
2.39.5


