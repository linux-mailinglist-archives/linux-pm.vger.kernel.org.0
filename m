Return-Path: <linux-pm+bounces-42972-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBYqLecBm2nPpgMAu9opvQ
	(envelope-from <linux-pm+bounces-42972-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5D16F277
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 14:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCB5300E3B1
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA1267B90;
	Sun, 22 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=abscue.de header.i=@abscue.de header.b="rK8/3YO7"
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A47081E;
	Sun, 22 Feb 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766226; cv=none; b=pA7JJ+jgJJLItw03Or4RozMU9irAOOus8ucL4D6kYU34k5hJNpFsop9Tyq5p6bDdCifSB3meun0lHi0gl/3YTnwUZ1x08/0wPQgoayznoQ/aoZNMyEHgAQNABjS5NGFnaz9dZz49YaJz+WFtf2VHXeYoM04m5Y4fQkuqM8O+ZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766226; c=relaxed/simple;
	bh=6vabVtheRu4+QZcPUChhDKjmqqZVQbanVqDlJXMQ4Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McHZ0vr5Jr5eEBPgXy2X6T1YHDplCVW99ZtUeSTi6pyMlZ/BBc5wk23iXg+OJcDpukzHnELbDJByw2lFo24CiQKxagL8xy7YrPPMjAiBsyyYfyJ5+W2jx/Cp/g6AmUHRTP16dc6GDPFY0ri3fpGUAnoeJT8ni1ziiWmxw/JEU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=fail (0-bit key) header.d=abscue.de header.i=@abscue.de header.b=rK8/3YO7 reason="key not found in DNS"; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:3300:edee:770f:8e03:a80])
	by srv01.abscue.de (Postfix) with ESMTPSA id 8C28C1C01B7;
	Sun, 22 Feb 2026 14:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1771766215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Nr7CH1bRdKQJE/NNBTH2whgFZ5JDp6BoMWAFK/xcg=;
	b=rK8/3YO7GfpnCXzpef0inC42uEF25LTmkKXQx0iwY2CR3V5sNAc6vNVmqOS+NxJzwHWUz+
	LThla1QfR+eTIAdfgOVeUqpoyt5uNV3P0SNVGUghLRlmowX77h6Fou5sHz7spr2/S+rR4J
	hYTD5eaqMap34glPLpGGmYdNeHLs8yPsmg+Gw7DfgJxAvpCcQr8B4lgvh4kXrVdkLTht63
	d3rKIq6P06ktCEX7Ent07WEYGGqy3LgWF8xD01WI220vwnw0k+nX658djmziJZo5Q6TpMd
	UH0qRG+jmCUy0wmCu39WrhEMTkRQFEgdgSL1YTOjklpMgCTInGE2zpWJc+lMqQ==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sun, 22 Feb 2026 14:16:45 +0100
Subject: [PATCH 1/6] dt-bindings: rtc: sc2731: Add compatible for SC2730
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260222-sc27xx-mfd-cells-v1-1-69526fe74c77@abscue.de>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42972-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[abscue.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com];
	R_DKIM_PERMFAIL(0.00)[abscue.de:s=dkim];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[abscue.de:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[otto.pflueger@abscue.de,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.651];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58C5D16F277
X-Rspamd-Action: no action

The RTC block found in the SC2730 PMIC is compatible with the one found
in the SC2731 PMIC.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml b/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
index 5756f617df36..1deae2f4f09d 100644
--- a/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
@@ -13,7 +13,12 @@ maintainers:
 
 properties:
   compatible:
-    const: sprd,sc2731-rtc
+    oneOf:
+      - items:
+          - enum:
+              - sprd,sc2730-rtc
+          - const: sprd,sc2731-rtc
+      - const: sprd,sc2731-rtc
 
   reg:
     maxItems: 1

-- 
2.51.0


