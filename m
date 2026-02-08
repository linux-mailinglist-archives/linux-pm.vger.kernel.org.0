Return-Path: <linux-pm+bounces-42255-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFiuOFdXiGnaoQQAu9opvQ
	(envelope-from <linux-pm+bounces-42255-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 10:28:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCD10837A
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05951301112C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6133D6DC;
	Sun,  8 Feb 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zov1yUhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3212D8762
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542933; cv=none; b=M3T1cPnJXjXIRZZWcSwdSZ3/L2hlaqjVm4zhlxQPbPFIFW1dLz6ctiZOaYVC6s2gOXXMtuYH3T2cjZbd3PqjarEFmGkG4MSMe3FQzLYJVEq2ZDOv++TleRqR/iyDPfHop03yL/YIOYJCB4rMV8RNhj1EXsRw/on1Z50h64vtVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542933; c=relaxed/simple;
	bh=TI+RlJWXb2vDMS68WDTD+JOZiTemj9ayojnCp31xpjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nc6gsl6KtbDvo98IHAqHOU0cSlpg5/s/xasyWikV2j77vSs7YFQQsTZBgUjQMRwrCJ6014BdGR0MyTwhdLXMjeMqsdq/l4b7Sxe3NYOHlhNx+cBhAL2hLYX7IFJnYBh4q83RUt6mjgR8WrR2mVsQJDw8KXJ0svoiu1uzvZ4HuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zov1yUhp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4376de3f128so47158f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542931; x=1771147731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMp8+XE43yviL5lzSATz3TUvs31rQGhCrOgDU6c1JKk=;
        b=Zov1yUhp/ShI+B1EWTQy2iZQUDzX2sXgQ+FDTJWqNarRqCMjJSmYocnXmYcvLEWxkj
         YndbQ/pfLzBuspl61WXA6aLSB64ZGzDm46i2uDFyHW7E/NdoC6en3HEbT0l3yvwT4xfG
         xtJIH6FjfC/6FZy5VJNEclzkeXrwAA80D9xXX7OGHcPjnGxwigUCRSg8O14sbptkOtHV
         QylPIQuDQbQuh0aZwZsZPlwqoCFGJVe3IWbt5wdQrk35++qX2s4PS3fKKdaGi29lOmfI
         6K1YSrXK2ieyHEJDWfi77/hQJDG/oB4TVRgrFkab1cwGcThRrVm2y/XWz3iWaIxZ0Gsj
         2wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542931; x=1771147731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMp8+XE43yviL5lzSATz3TUvs31rQGhCrOgDU6c1JKk=;
        b=nGLqnRTri8rUgknK5lhHACeuRrah6LEoYks8ZxYohNy1SKiV0HyRR/RFZrsU0sp0IG
         ooue8b2chcohA/lluUI2KOSxwLXWSplwz+kzsJpesKS3diTeFX9FBk1AE+Gox5zWlDCh
         NPRON4h1hEqah8vlR2sic5m3Q8gWAZjtD3R52Hr0LkBifZxnUD1m5ypDYjMxzKsFg64r
         2k4N61GR8r31b85JWi/kWFP+CHzjhbHFaC9PuYxhidqK8bQ9Dl6UKEgHl1jAwygUiI3A
         eeJZ+3llvRVFgva3nIEgJTN1GhKhXIXu48l9HMIUXc8pKMqsMFzX07yoIN7o1BdyUHrL
         eMAA==
X-Forwarded-Encrypted: i=1; AJvYcCWmnYy9/Ogq+20XEOaMBP96/PHqEhtsKG7K1QWkJYyundhuRSYJPI2CnTmMbJbkY8gpa2Oz1U6zXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxolT0ZrLGH7g19Qxnj0O8xliHYz7y6EBw7CVRQ0YPsiLTO+zDh
	Esxbf0/CsPx6GDnI+nup/5JYL45JyLezpddzal5xj6brGCN517g/RFb8WL8Mq6Ff
X-Gm-Gg: AZuq6aJQ49UhvV8NOO8dhUUo/lh19UJzlLOpZqcAI5fIFwmYeJWehUrhEbrpBI8+7bL
	ZZexlwJOv4Yu2NwA432XAEa86oVSwPZxkB8AWas8OHkKvxnYUykV8HvHICMhXqVYt803+uwn9xs
	sctMZCBEbn+AQxOXeTqi6MoPRyj4mI6hh0NMcmlrSgjjuI87xPSbCPauwVLCZdYvGEgZEOI0AZf
	kzIXSpS6/VsE9nIAIZBoFe//bzw9NbsVnjqsOOlHVc86sp5cVMPHSQ5A4ah28d4aWGv6W8G52b4
	0MayXfmfnk4R6F1LwyW2V5mpDfck74NXmVA68b4I9nxv2zTrMsPwE+NJToQi8jR1OBQbSd9RWy8
	1Gjs07FvsgsR9nJBGd0ZGWDPBL92BRH/iJWNx0T9dtDguOaIDDY0NnAPFKui8F2ehQ8Nnetwy5o
	A64HeZ+WuPHK0AFJ2WXFKsf1n36vI2zaDzrfzFtCy9Hcc=
X-Received: by 2002:a05:6000:25ca:b0:437:6b2e:a279 with SMTP id ffacd0b85a97d-4376b2ea4f5mr1531339f8f.10.1770542931122;
        Sun, 08 Feb 2026 01:28:51 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:1656:80b:8f7e:841])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b230sm19959983f8f.36.2026.02.08.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:28:50 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] thermal: renesas: rzg3e: Drop unused kernel-doc comments
Date: Sun,  8 Feb 2026 09:28:46 +0000
Message-ID: <20260208092848.5313-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42255-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[bp.renesas.com,intel.com,arm.com,vger.kernel.org,glider.be,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 62DCD10837A
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused kernel-doc comments from struct rzg3e_thermal_priv.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index dde021e283b7..086bd3da10e1 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -87,13 +87,11 @@ struct rzg3e_thermal_info {
  * struct rzg3e_thermal_priv - RZ/G3E TSU private data
  * @base: TSU register base
  * @dev: device pointer
- * @syscon: regmap for calibration values
  * @zone: thermal zone device
  * @rstc: reset control
  * @info: chip type specific information
  * @trmval0: calibration value 0 (b)
  * @trmval1: calibration value 1 (c)
- * @trim_offset: offset for trim registers in syscon
  * @lock: protects hardware access during conversions
  */
 struct rzg3e_thermal_priv {
-- 
2.43.0


