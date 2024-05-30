Return-Path: <linux-pm+bounces-8408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83388D4797
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E871B1C21DAE
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3C1534ED;
	Thu, 30 May 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyUzRgI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1556F31B;
	Thu, 30 May 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059390; cv=none; b=j2Uq2CzFqbmgvbmvPzMgrKvSoewa3VSU8y90Cx9d5ot34BosiBFrglQ1S0T/EK0l7dfjZPlpn+GphJVl4up7hjYwviPDM7GhJdCx9EXZapuO9l/sAdmoEdyelBN3Pi4Bf7Ex+Am4Ajpwr0xXUzy8AMa0xUfkPvg7te0RmbBNd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059390; c=relaxed/simple;
	bh=4/v4Yl10Sn2/85JqCalyxo+mnQfcdDcS7xIXZOrC7ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVcw0PhZLQIpiTU/otBlcnhMllMTKcaOam538d3mlywEF0MxNF1RZ51bvY7goTdL4bCWUlvZib8Ayf4HqlpP43ZTjNtDO5z7/AtwYkvpiNdW5d0Y7VQIicOUq+hvBPLwKQJaS/4nhgPa63yMk9Z5f/q7J0TZVBsncokrr5I35Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyUzRgI5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5785fc9c543so782456a12.1;
        Thu, 30 May 2024 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059387; x=1717664187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N+Ye3RWAGURspV1/ZdjrT1yzduMmRZpH0IPoATU19E=;
        b=hyUzRgI5OvGyWvpky2wID8y29b89c+tALi2WvmCRiIpEg78pZLdMjku8OUHbr9jjVN
         3JkNYYE1nZwOTclAMX1JRzUhvxQUJdAPzz7HPO38bDaLWk8kuL/3C6YlAf3FD06bLmG1
         Cit4zAlB0xsGfuqBo6v3uAB3U5EmjLuzuLsHqFv6Hoo3LiQ9TLlEJMXFawnXrj3hd3+5
         QhH2adeyAP4kPTI6umTEw19iBq0Xx3YzjDcwPj138fd9jk+3BQzd5Vp6YRgx7xl4MwY+
         Xa5TyLgA6KLntdYFcexamaCE2UliAtG1cE6C+yclR0VWEHPBfB1iu/n+1TWyv9iV0MxY
         oH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059387; x=1717664187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N+Ye3RWAGURspV1/ZdjrT1yzduMmRZpH0IPoATU19E=;
        b=GjQHGBgSIiTbaVUP4nOD2LsXCDCenYsShf360h04FM7s/tcJHENn13Uuh0j1cUk6Tk
         rZYZ8Fg8DMjV1s9ChxnrOQJ/Wr5CVpLkae4n4aakYEVOFdEkZBkhARHc4G3CWLzIfEHe
         r1ObdSEECeOtwVLKHFo3N5pZUF69nVJC70V5GwAPk09Gf3p6tX38VmIakfu4Cj2Nd0gI
         yWekzviMKQNjPOEtAHcBgYilM7iFnNa541iUHh0mAwQQXmcjnG83jRm3tQkGU3bYgSMM
         uoi6fa5vIumRJbalTyVx19StrBt5bd/BS37/qLCGjTuolr5mkkHEbfCyUE1ahwxagtAr
         Rsqw==
X-Forwarded-Encrypted: i=1; AJvYcCUOSXgSlBegWIdMtCyKT9pfVlhJiH2NGjN0VCaC3OiM70adgNxiQMSFGH9XNALYTsGqwzYNvRRyAQp2fi/5DDCPCoihXelp+0UnnLmU510fn66xV9TU5eQoGbkenvV69wS5647wBgQKnE4AgSQpwdq4ukGLZXUIJml7oormoclIsXDVEH6I853V0YHO3fbjLTO8lnMY8BnL7dvxVnfsxfaFPy98+m8=
X-Gm-Message-State: AOJu0Ywz+Sxx6OOniUq0I6PX5qhRvVhRl6h5wz+26nMh5yA1DvPtX1fN
	xZ52E974z0fxlXTVKPuLvK0gBIjFWRYLX/oKvNK97vVaFxQyVaPm
X-Google-Smtp-Source: AGHT+IHyS9Qs1kepjHUHXQ9aTRVCxMOeETyLoYnij3nd0Zx182VoZWHIgOSIq7cw0Jq3QCpsyGoctQ==
X-Received: by 2002:a17:907:778a:b0:a63:7efd:8ec8 with SMTP id a640c23a62f3a-a65e923ee67mr170948866b.70.1717059387252;
        Thu, 30 May 2024 01:56:27 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:26 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:51 +0200
Subject: [PATCH RFC 01/11] dt-bindings: power: supply: max77693: Add fast
 charge current property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-1-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=1078;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=4/v4Yl10Sn2/85JqCalyxo+mnQfcdDcS7xIXZOrC7ic=;
 b=sKpGCUSVFKBncgtLjB7f/kEoxXGDMoNCSfXcuMN/D1NHxakSVBPwZ+t+uFWNO/Kj7a08w2LHV
 JP8o7ylKyIWC+u/A+J9LWEntsVmE7li0U3zho1hqAtywGVb74KMqq0J
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add the maxim,fast-charge-current-microamp property, used to specify the
current limit to use for fast charge (when plugged into a wall charger).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index f5fd53debbc8..4f80cc5418f5 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -56,6 +56,13 @@ properties:
     maximum: 3500000
     default: 3500000
 
+  maxim,fast-charge-current-microamp:
+    description:
+      Current to use for fast charge in uA.
+    minimum: 60000
+    maximum: 2580000
+    default: 500000
+
   maxim,charge-input-threshold-microvolt:
     description: |
       Threshold voltage in uV for triggering input voltage regulation loop.

-- 
2.45.1


