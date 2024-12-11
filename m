Return-Path: <linux-pm+bounces-19001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B879ECAFD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEE7169EC6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6322ACDF;
	Wed, 11 Dec 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTE1EGvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7E2210CB;
	Wed, 11 Dec 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916188; cv=none; b=fq8cK1krcSCVbPxVnFIT3L4WWB2+VZfVHTXl8WuEJxKf+FjvoXB0vOoCmbKR5Vw1wKQZd9foXJQVVjOlXmdxM0z8m8V8ZXY7Zjx0KwI1SQKB5ib70ff4dyR9wFJW08dIF5WPa5QQ8eQTz8n1M8iNt0yKlPa21k06K7WUFhkN6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916188; c=relaxed/simple;
	bh=Z0UJoK+JMHqXLXGpFMKhOQr6LnXF7afe9z5eb1Hv2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJadUz0BT6bDk43mvT8VwPsq+VHBxHb9LzIUBfU5VSBKDzO3cyBw7VptoVo+rQXrx2ZoDAd9Y8rQFEB+uir1RlKNPV3BUxVIOMXRUJum82bflBRszqkTOjf3pKJDhrZB+UbIisqPoyC2E2opIMOBKAe/zJ98LmM9A//+iFIbEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTE1EGvM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216634dd574so19626195ad.2;
        Wed, 11 Dec 2024 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916187; x=1734520987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUHH+eJbCiMl2j2oN03m6Q26pa8Tho3uZPMyt8IDCBg=;
        b=GTE1EGvMW1tt5O+TZG46Ymrxh+gcuM4WzlF0er4y4y0ktZLA9jT3DMhY5rHvN757gZ
         VKU2IZH59GOHV3VaV9LXxYgW2dlQpr0bzdft26mdfc18VjRmt+DZkhu4LIc6tMOAHfBh
         Qt3d1wPU9kvOI6BGdgWS90F8s6Hm9bwRiCoAM1tPHj6oMz+mr9yNwkIWqHosWkfPWx6u
         ArlKMmkxzOIEBXJhJEWESM1dY2nSdho+1mjzCVYgzzlA/DPFWqOS02VkakRRv7yydbba
         faBs3qoM9za7DVwIin4+NYTzChTp9UDnkm+NGtK7ST5/8Dx2baV02JQRcPKjCKm0dh/M
         iM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916187; x=1734520987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUHH+eJbCiMl2j2oN03m6Q26pa8Tho3uZPMyt8IDCBg=;
        b=GpJchaD8AjHMCdbk1Y9pppMHiwgYHO1WiCv0M8UVu+K1XPKuQDc/b0Y+9clQuew3CM
         gaVe0o+U82SVp73t58KpNz2DDO8OCuCOpJwp4tW/Z8sgk9XwEOZ9d7OQRCdEveBJFG64
         9308FSuwOchavT2X79dJObv5RFzDpZNGLVv4WImnMsMQlMFDG/ubB6rs/oz+TauBhypU
         5ALVjtapJ4bMIq/bTcBTkWOoe7mXdRlvrk3remml3fLUcvafetfs9URhxdq3sz66ewv9
         hRI7kIGXj2el0pIrWkT67lMwz+MfXD1KGafl/nU1/uePomUg0HCkPYxsygKnqj18+ljW
         h3tg==
X-Forwarded-Encrypted: i=1; AJvYcCUV098bawyWLie+FwkE+FPEfH8SZ0gj2nSfSfH0LhZRWmlfD89qSsW6g2yVTdvQGIkJjTo3BrTiG5I=@vger.kernel.org, AJvYcCV+i1aNDWWLUdxmzpZHu+cd1QwNFcXZcm/gIMWsukDexU+dUfDnYV2p6GNH5J/e8weFTWqF4Bd+eEI1@vger.kernel.org, AJvYcCV1rqqsRt0V7Pydfr/yMbGH2/6K+xzIh4r33QeBN9sP8rm67xTPEauAhY15HnzzkstOJizuiwvAv3b4ULw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxCa4md8jLq7VV2Vj9DTqrwXH10mVH3Z+JdWcG1M3Jf6g0hgPC3
	qke0yl9rjer+uwHc0tYLaUpilZguTtAiKffV4WUr0ysdY/vdn+gX
X-Gm-Gg: ASbGncv/utHuPwo3Tn7AjmN0bzCS/elWpY7+Z+jpeDcAxJU6+pqK58opoI5ZKAVWjNe
	yu+v449bV5rYZ/B/x/G8QmiPI3+MPUtjquHUI4iIj/JUOzW5zdUBD1KB118SSnsV2ZxEU4haWsG
	m8a5KRb1ulfwM4j9dSCMoEzJwJJe9J0AbJjs0G6DsFuZ/o35uxEfKEs3ZeAgGueuspmAGF0Ypk3
	pvOxrIEnteHAL7ikmXHfUbYv3SqFWoNG7z1QuG5D2Zv0GSE44HuLxAICUjhGVIECnIdUw==
X-Google-Smtp-Source: AGHT+IFM5a7MpO8fzMF1Ciyph8SCkj9YYHpvyC3PVX6ufLbwk3i7/23nnaT70/hHri50A8+ULdGjzQ==
X-Received: by 2002:a17:902:db08:b0:216:2f7f:ff69 with SMTP id d9443c01a7336-21778393b9dmr38658675ad.5.1733916186646;
        Wed, 11 Dec 2024 03:23:06 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:06 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/7] dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compatibles
Date: Wed, 11 Dec 2024 19:19:28 +0800
Message-ID: <20241211112244.18393-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211112244.18393-1-towinchenmi@gmail.com>
References: <20241211112244.18393-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Apple A7-A11, T2 SoCs.

Apple A7, A8, A8X gets the per-SoC compatible and the A7
"apple,s5l8960x-cluster-cpufreq" compatible.

Apple A9, A9X, A10, A10X, T2, A11 gets the per-SoC compatible, M1
"apple,t8103-cluster-cpufreq" compatible, then the
"apple,cluster-cpufreq" fallback compatible.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/cpufreq/apple,cluster-cpufreq.yaml        | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
index 76cb9726660e..896276b8c6bb 100644
--- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -24,9 +24,17 @@ properties:
               - apple,t8112-cluster-cpufreq
           - const: apple,cluster-cpufreq
       - items:
-          - const: apple,t6000-cluster-cpufreq
+          - enum:
+              - apple,s8000-cluster-cpufreq
+              - apple,t8010-cluster-cpufreq
+              - apple,t8015-cluster-cpufreq
+              - apple,t6000-cluster-cpufreq
           - const: apple,t8103-cluster-cpufreq
           - const: apple,cluster-cpufreq
+      - items:
+          - const: apple,t7000-cluster-cpufreq
+          - const: apple,s5l8960x-cluster-cpufreq
+      - const: apple,s5l8960x-cluster-cpufreq
 
   reg:
     maxItems: 1
-- 
2.47.1


