Return-Path: <linux-pm+bounces-8410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FA8D47A2
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C60B241D8
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04B3DABFA;
	Thu, 30 May 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGe/RBV7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9987176AAD;
	Thu, 30 May 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059393; cv=none; b=qg4QOEczU8y7gik/x7GJVcnfIn8rbLLFa4n6yo4ylz5Sjk8NedsVG+R6PFoPPhvDTmypshoeK/0DoTUpHr1DxEUrvxuZ/grMb8hb2le5q4V+tsXX4FKHalNHfuevkxTsp3rgTsyF0zCtYlGX4QSdK2u1hgMy2zg4P/wBAD8nVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059393; c=relaxed/simple;
	bh=lvdySO4g1Iq+BvNlPqD2DOaKCv3w2CKbmZOppf2fdkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fl1EfwoTS8Gbx2sKY/n/aIMdNHZ67SSmuFoVzcGReuhHVgV9PVhMyGNI+euVUdqZC1K6dEXeD3reAefNUQHlDp+eCwnvIBt/wPUsgrUZe58XrN5Ssq3DkokjZ7qN8XnsH3vZaIYycFuUyGY8wrDIciCLke0R9J5U6G1VOFLIZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGe/RBV7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a63036f2daaso54437566b.1;
        Thu, 30 May 2024 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059390; x=1717664190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH6IEdvPsyMn2z81M00M9CRQyqxS5gUsz993GDmOU5c=;
        b=KGe/RBV75ZcFlbq1s2s5SGBvVR5Uu/CYkSncDklpl+6/Kx5No6cQWpibUezKDkNE+m
         7F8iJntpjFIwFC0b5RNBr/AJwoZ6ZVIG6ahLLZCPpbtF3T/VpLxfuJOyJvJvZbHXJxue
         LQncPRLlv5QAPQ4xoYYDBATp9gmFwFrZs6KsMsoABdQ79ShpbAHdSOACyPYT6kigp5oz
         J0WWT50f0pBZ8JvSjosCbHQ2R6JMqZfxBCoYHe8saT1kxDhMGI5XUTW7CAyow3AEnHYy
         CHjwfVHbRR3xIHluX0QZnH9cSFAwqknOBy7MWICh2uYLvX6Ot12mhRFg/OPSj4lbWO4T
         U6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059390; x=1717664190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH6IEdvPsyMn2z81M00M9CRQyqxS5gUsz993GDmOU5c=;
        b=b9+tkW61xLOiEixJQr47OqOHR0M89I94Ghkp9Xvc4iIpfa5KYyHinfBltnq56b1AXf
         0aCkB/YgY7u393BHPvWaHMnOwj0GeoRS40EIOYW8AbQq+P3QYBIDFGAHTLCUSeEDB8d6
         OMZyWnTWzbP4Yy0svsSP+hSE8ULtqsXRuu2+ADiQMKJ1/w3XlBSaNBNDRqTFgLpVzGag
         rD8HmZp5SvezYTHq6o0JyWqJKDpd1Qo/PzLVqUbtMQ+G8fvcxcMqnbpuAe3zto9YDfa9
         ZmQ04y3J5vw0+5tL5pgq18DnBcWb1yxX7rse9whz0afCqdJH+ZFnoPcRn+2iJbez3a4/
         fJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKvJ5VrkXN5GmZmHVNZh/SgihEdUkCD9ZL2EsuPDkmGe30qPv1jSDHfc11EIsyS49cULOSj/LF/IvB1wOJecM5MQ0sEP7PzwR89iZRGhInhMRGLMfP94huOVyS2roJMLJ/U/W8ai6yELxw8Xrs/grg8te7jdCuxWAAagOhCxguQx+6XwAmdqnbAk93pNKUa8RReg6hHbclyxa8YLnm37SBzIobvA=
X-Gm-Message-State: AOJu0YzoelcD7O7PXY6k5jRL4sV4vM6rYQSrbpUlb8rcMT+LaR9CsWnP
	4ea9DFMYSgNtJlH0bz767D3uo6VMkJor8PJ4dTeiCX9gqpUsIi/a
X-Google-Smtp-Source: AGHT+IGnGk2ljLwZ0u8xsY1XXY1Hnt1SDUWhWdbiRrxUqPljltWq596nPnHiBYXJnSz/3lFgR53uBA==
X-Received: by 2002:a17:906:3517:b0:a5a:44e:2b87 with SMTP id a640c23a62f3a-a65e8e5c113mr91117566b.21.1717059389889;
        Thu, 30 May 2024 01:56:29 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:29 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:53 +0200
Subject: [PATCH RFC 03/11] mfd: max77693: Add defines for charger current
 control
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-3-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=1496;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=z92q56T3bzz9gRYE5sI8p34kLQvFNqoO5fMHOAH6pLc=;
 b=gqZVt0FTts2q85yDzL1R1OZGFpStHpJyMFNtSjLotVPYPTtwzJ9bXD5+s1WXj8u9Dm092xERY
 1xicc/PZ5NnAJu1w4t2Pfvq6kpgMbO1ljOYg9eieohJFy/G5VpO+Md3
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This prepares for an updated regulator and charger driver. The defines
are needed to set the maximum input current and the fast charge
current.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
[GNUtoo@cyberdimension.org: small fix]
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
[Artur: swap hardcoded ILIM values for DEFAULT_FAST_CHARGE_CURRENT]
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 include/linux/mfd/max77693-private.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 54444ff2a5de..4570646e2f33 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -145,6 +145,8 @@ enum max77693_pmic_reg {
 #define DEFAULT_THERMAL_REGULATION_TEMP		100
 /* microamps */
 #define DEFAULT_BATTERY_OVERCURRENT		3500000
+/* microamps */
+#define DEFAULT_FAST_CHARGE_CURRENT		500000
 /* microvolts */
 #define DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT	4300000
 
@@ -217,6 +219,10 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_01_CHGRSTRT_MASK	(0x3 << CHG_CNFG_01_CHGRSTRT_SHIFT)
 #define CHG_CNFG_01_PQEN_MAKS		BIT(CHG_CNFG_01_PQEN_SHIFT)
 
+/* MAX77693_CHG_REG_CHG_CNFG_02 register */
+#define CHG_CNFG_02_CC_SHIFT		0
+#define CHG_CNFG_02_CC_MASK		0x3F
+
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0
 #define CHG_CNFG_03_TOTIME_SHIFT	3

-- 
2.45.1


