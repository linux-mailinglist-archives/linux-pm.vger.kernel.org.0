Return-Path: <linux-pm+bounces-8411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70188D47A5
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F0C1C215F1
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EC17C7AB;
	Thu, 30 May 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB5Me9G/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF671C2322;
	Thu, 30 May 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059394; cv=none; b=hhn6KqV/O/XyHMYVoRDWzcb1C64LG5e8kd5lDCJeUMcHZQ+CU6jobfb1l4ivqCEoiR0sK49v0l2hWc21q5o6voYbc8Go6MmfaSqXEBBcpT605zCIZJgky/kw+I/eWPEKXI+d96YJGKY1J9UaOdmTOCV3gHHXiZGO5BlbVPFmgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059394; c=relaxed/simple;
	bh=fdFCdouFtABSDklI2okYjmv8ltu44PsbFfLaKdFasJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgRoGYKinW8LGw0BbN1LQlpMKJYWjc45mog5TcFXUP3KcNkBVxyM6rlQ5T39sX6CH//JmCa7A7hFUcmkARFBtiACCje9l8TDSq92+JXVUyUQXtLo6ipriU7Qer/wZ7VVnBkTNC195GukwS+wnNmdHms6GDVBJdjBUAytc/u69zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB5Me9G/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a626776cc50so45016066b.3;
        Thu, 30 May 2024 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059391; x=1717664191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZFoX5IVFjLuki9v4dFBiplrNUJ5RoBfw9AZQOx6kgQ=;
        b=GB5Me9G/4Ss7MqV15eRjzG2fC9dl/4zkNHcwmpVh8ZJxuLMjaqLntPXdrO48GWMypp
         wwjpBFFQv2Kp28+L2/iQJBsG/EaBP3XaiXzZw71fbGyl5gIG7MNa9ru8QKHAreTpWvrL
         aADOn7uEGhnC/qYkGUSBNK6Y2jGyKcfq2xEOmJpEjUOGpuCdJ5EpZn12HK/hmlV2H/SR
         ajQuySW/x27s4WeJlI81Z2mt+Vjb2H1tHh18hlnvLts14K2ADq5pBER1uLK7UMGm643J
         1Yr3sC85cgkfT9ce4ODZAzGOK0K1qDotnOnGq18JaJ0x3kayNj/FAYqVb5tdGQObM5c5
         uSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059391; x=1717664191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZFoX5IVFjLuki9v4dFBiplrNUJ5RoBfw9AZQOx6kgQ=;
        b=cevbzjx4k8nYOnK/gX6CPWTngGaJt0mUxXTh5IwRlwXKloKdAsQRmYZrmq4Uu5UhYm
         66UTcOaPRj+zGwVgd11txCYSHRSZc8JiNkpjigyr8BzaSXSkWhVjTAwCyoHlgCSc9qWe
         RfoLO/3SsQqf21gGWpC+maBv+4rJbyTwRJQRkNkG8puqVVWOnckZ32/dGJVoyDVN9rJy
         YnLxVXNyukYBOLPcyfhajKErWcJ6uBZKnbipDEvRF+Pj7w85SDFbTekAiZSKCV+3I8Pr
         FAiS6B+VhZ+gZ/il7bkLnJJzwZcuz6uXZZO7Cojds0MjghVrvZBtdVdWEdWq7zWS0MGK
         ImPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2niaHADeINOVjtrmF+GQUmetzSkqD8+KRLKoeCl1FeORVnlt1GM19AwoNrKX3lo06weG6brLoWPanWNnaLat892tLvM5sZfaW4IjF7DB2xlhKXnDx3tKS5WKkbE25r9nVV/2oGOhADjSzMs8jqYIdTz6j+Ig6/VxoB6QHgSQDUIKnh1veRdd3LvjEVS5l71+wud1jJVApOf9AprP7iUaqVIS5+Ks=
X-Gm-Message-State: AOJu0YxlBxHotNDXobhMgu/zOAKTBb2iN6LANfmOy/EqoF1W8d+rj75i
	Tu66UCFy/xxjxAddxVyYPq0WzsXgtfGhlQjWo9SZOpydnnhl4BbN
X-Google-Smtp-Source: AGHT+IE0ZII4vqAKRbQMevN6HtZeVsEyP6AMudu0nYCEDWQluKinx7Ti4QrR8CVjHKxX2kcm6XF30Q==
X-Received: by 2002:a17:906:fb0c:b0:a59:ef75:5382 with SMTP id a640c23a62f3a-a65e8f6f478mr88907466b.43.1717059391213;
        Thu, 30 May 2024 01:56:31 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:30 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:54 +0200
Subject: [PATCH RFC 04/11] mfd: max77693: Add defines for OTG control
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-4-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=880;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=fdFCdouFtABSDklI2okYjmv8ltu44PsbFfLaKdFasJM=;
 b=8aX85TIyQjQICfocT2JKEutODUeUhtAi6tDWjBrIvXV+CLc35vHCgMqCX6obQhvgLowcjr6wS
 xa0Bz58phthB5z7BfcbkPIzTsiXTRMm/UD8Ml2DTD9NspcfNzLJPJu8
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

These three bits are used to enable OTG control in the charger
driver. Add them in preparation for an updated driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 include/linux/mfd/max77693-private.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 4570646e2f33..4448b024255d 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -209,7 +209,10 @@ enum max77693_charger_battery_state {
 
 /* MAX77693 CHG_CNFG_00 register */
 #define CHG_CNFG_00_CHG_MASK		0x1
+#define CHG_CNFG_00_OTG_MASK		0x2
 #define CHG_CNFG_00_BUCK_MASK		0x4
+#define CHG_CNFG_00_BOOST_MASK		0x8
+#define CHG_CNFG_00_DIS_MUIC_CTRL_MASK	0x20
 
 /* MAX77693_CHG_REG_CHG_CNFG_01 register */
 #define CHG_CNFG_01_FCHGTIME_SHIFT	0

-- 
2.45.1


