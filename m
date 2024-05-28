Return-Path: <linux-pm+bounces-8202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16A8D10BB
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95C0282A11
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA738D;
	Tue, 28 May 2024 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TLbEtduH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E63524C;
	Tue, 28 May 2024 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854813; cv=none; b=f3LtqWcJ5Zax8MT7EIutPAgKlEnV0Io2aGeZ/M75Y0Es+QtKVWX3BVNKcDdQYwzPV8v0B8FwyPGFnjQ/xZTAH4VzPRi7toL8LOwiNfpnF6uyT3CCwfjRqSiOvHy69J/9r/q2ySWBiL0yEeMTHbF/xE1s2WWr8JN7QIEO4x+icsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854813; c=relaxed/simple;
	bh=k4G+jAKGNKDxOHGUvNAzqtpnPGgj4GhdstDH0kwqqsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLoAc+EXyfyjmwjmVK1VLhXm+Br54QVZgpwT4N/iwQ5LVg+Dg7utmcI3dWCxf9mj2YtovyuA16EKeILAA3QAHcNj+ouwfyiPXALNUQ6x5P1TODRFequXMYneD8R8NaLF0qrhY10hZ44aPH6Zp14wp3mKUa09k3dydmXmGrPmwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TLbEtduH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kBL1ZEVIaCMy+JU9st0dS0LqC8kWc1aSFjAYCQfH6VE=; b=TLbEtduH3aGJT2ZN
	Q5N8sg6vls9zdJ73A1TY6a6mxWyw3LCPfxXPUmpqTujDPLbeRp23ulQnoan62wLTkJaQAUoqOp6HI
	iB+gKsWVhV2LuqSjPFl5ffIpz9F0fhLNhteZZJVUmbWLuDaosOURBxtnHnCasla2dcT8GH5A9897T
	gH4hgSEiZXmptSsJakIFJDMrao5QLUgZ7DkwX6Z1B+UQk3IDuhRB+8b6uN94MeLXYb1Wv8tCMtzJO
	y53Tiaon9g0Dn1R04ceVrQobEpU2o+D0I/l5D+kBYYK8rEeRcnsKPzKiM15PDqRkMVKAsXmUXvDFF
	EQqvg9jV3jnJxQWcxA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBkMa-002pjT-2N;
	Tue, 28 May 2024 00:06:49 +0000
From: linux@treblig.org
To: linus.walleij@linaro.org,
	mazziesaccount@gmail.com,
	sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] power: supply: bd99954: remove unused struct 'battery_data'
Date: Tue, 28 May 2024 01:06:33 +0100
Message-ID: <20240528000634.196707-2-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528000634.196707-1-linux@treblig.org>
References: <20240528000634.196707-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'battery_data' is unused since the original
commit 0902f8366491 ("power: supply: Support ROHM bd99954 charger").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/power/supply/bd99954-charger.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index 1ed1d9f99fb3..54bf88262510 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -70,13 +70,6 @@
 
 #include "bd99954-charger.h"
 
-struct battery_data {
-	u16 precharge_current;	/* Trickle-charge Current */
-	u16 fc_reg_voltage;	/* Fast Charging Regulation Voltage */
-	u16 voltage_min;
-	u16 voltage_max;
-};
-
 /* Initial field values, converted to initial register values */
 struct bd9995x_init_data {
 	u16 vsysreg_set;	/* VSYS Regulation Setting */
-- 
2.45.1


