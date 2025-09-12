Return-Path: <linux-pm+bounces-34523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D5B5434E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C7E189AAF4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC92C299A8E;
	Fri, 12 Sep 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f26NHkxf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40055289E30
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659932; cv=none; b=r9xuiZiokCPU2tyOEdfLju+0Svj/MNUfxKoNPP7929isHEB9RKKpRcjHwq/dKEci9KyTr4PPJhaUrnREpDDbl7dGTjCDedZrvTWoHMeTQKN09BBel//88Famokk2acra2h7c3tr2z63i/hrEtXLbEadd579J63azCEGncMMeLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659932; c=relaxed/simple;
	bh=V41BZQfbkLWW55oGb2ig51t9GDvirhFPE3G8Pk3DMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR3F9vdiT3yhNlYthCsr3StDPBxVl0mVmQBw2YldXKPgpr68OQxjA1nqj1eUsZnosIxSsyfm5OXhhNUN4mzGyFOH71Lbg43kcjeiGqVG/kPtT0SbXRtkQnOLircJpb432Zm/efhk7//zxBeNxFTOobEOffcL5Enmt4Eh80Cirkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f26NHkxf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-352323389cdso1406271fa.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659929; x=1758264729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reNiXcD7TudqB/sS5bFygtRC8HYtT+QaCqNOvCQ02Zg=;
        b=f26NHkxf9w3ejpmy5F2Z5fCcOevfdy38+JYmn6rfeWM/onGP180Ny7ImfeWYE84iPt
         /vxmNtKtRRTGWklf4CmQqeYpHdmAEoBb+0SLtiPpNqgkIpumQtMH9YIE1dlSVL0gHef2
         8HF4CMSBC6KYLBL+r5rBuWdnO6a9ioTbF6qBqcC9dZ0MvG59TYnUBnO7n0ZPlScfnkXb
         7ChFc9dkiiLZ82qtK1noPgg/X67YLXEzcKj3WoJCqPj8XuKQIgaXiTzSK5SUgtJW8ODH
         n9UdtlGA4ATxPEJx/AKHH6xv4qxYvji2NptxK5X86T3l04DWR4Ws+SYyu5DTBzeLUIaq
         8gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659929; x=1758264729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reNiXcD7TudqB/sS5bFygtRC8HYtT+QaCqNOvCQ02Zg=;
        b=b3pqw/Z2EWZz4JX4otr23PXZLS1tNko7v+EFKM+4aPuVz0Libyq1Xcxdq5MZztLctG
         AQZHn15hFzIG4MBd9x7HjmV7M6BuRlDH6/MUj0XrjWMSVH/lV36125G/m7bafs0riOSD
         7i/99+QEbN3MANBoUX4u49GtBpXBHuBqYKTmvREqtABFVkPLhmc3Z6u+49fGbUi37ZCv
         Su+J2TwkwKiimr1sRwRiDjEBCGXMInn1Fe8Rrv5b3Nj9MhBb76tntQ+Ans45snaVtO3b
         Cf7hsGeSF90xUtuBdA2sRYMf+OARO3dp2wNpnx7v1UHN8Zzs0rUIZCyyZ4gVetm/409f
         DXnQ==
X-Gm-Message-State: AOJu0Yy26Gw+Qs3CvtTGHZZ9segyWlyATKf5fKds53PIlrgP1TIa46uG
	PwhyZjMD1B1FNWq2ET9mNXGbO4Paj7IFk+RZYp1tR6zSEdD8504edI5I
X-Gm-Gg: ASbGnctE0l2geXrAODKKRTIy6wXlsAr295p9HimUcu88duRaAb4CVGr8lat4aA7786y
	gGjl87EvWm9lFRd/5CobktnH4DFg/hB+iyZVVwtcJ+SQDJPhZH0aUKldUaulUfqXWOzKYiSjJrL
	agBvYrNZtdeHHZUXBv2zldw8omA3f+wPjYFt9RKxyTzv2Z3RRNB8JQBBySIza4QYM0usteCz1IJ
	FiRL52eedjn0T7mQsjBUGVG+8DbjmTCNsOVsweHagwqfCYUjPMM3eW/HiONWcPK8rZjloAlg04F
	A5dzQMxymO6dAyvl+6nKdz5QLlYLlyA0qdE+17CfzvvSQ/LqdyKtv+vv4OxGQLID8+AQJxyp5tE
	zP+IhcsbUC7PBQaH6zsr9B7ZN
X-Google-Smtp-Source: AGHT+IGn19z0xbyPOa9s7kRxYEyg1LgSwuY7k0e7LwK8I1bGyacmhk0zyrN8+bwF3af8FbUua6ViGg==
X-Received: by 2002:a05:651c:b0f:b0:336:dd88:69e0 with SMTP id 38308e7fff4ca-3513e12da16mr4691341fa.29.1757659929207;
        Thu, 11 Sep 2025 23:52:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c5d5a49sm7180351fa.66.2025.09.11.23.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dt-bindings: power: supply: bq24190: document charge enable pin
Date: Fri, 12 Sep 2025 09:51:46 +0300
Message-ID: <20250912065146.28059-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250912065146.28059-1-clamor95@gmail.com>
References: <20250912065146.28059-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document active low Charge Enable pin. Battery charging is enabled when
REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 307c99c07721..2ea90e7f49b2 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -30,6 +30,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  ce-gpios:
+    description:
+      Active low Charge Enable pin. Battery charging is enabled when
+      REG01[5:4] = 01 and CE pin is Low. CE pin must be pulled high or low.
+    maxItems: 1
+
   usb-otg-vbus:
     $ref: /schemas/regulator/regulator.yaml#
     description: |
-- 
2.48.1


