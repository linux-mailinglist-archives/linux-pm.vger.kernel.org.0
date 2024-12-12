Return-Path: <linux-pm+bounces-19099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2511F9EDFD4
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3966188ACF3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314902054F5;
	Thu, 12 Dec 2024 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8ogm8QC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8D2054E6;
	Thu, 12 Dec 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987085; cv=none; b=ASOEA4cp7Mwkvt9yLKW3bYOm08aJXVAAtM6tV5+3PwIKFFB2YgTMB/nUOlkZ0nw/9QiKseCH5AKW/6dPNDxtoEqiH6hL3y1RVIGD+6qglPv6CsXNBHUNJ5oVLJlp+27fnz8ch4pcdZNHr+rvujQU4XFlNJpt4/pLdoD9gaUGb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987085; c=relaxed/simple;
	bh=Z0UJoK+JMHqXLXGpFMKhOQr6LnXF7afe9z5eb1Hv2yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYdso/PDrF0pG10JndZL8+A5plkUPgZrVGE1vjE8qsT2RJtpW8VRu6b4KuAbSqpQJ69YMsYNtwrGdgrY5A3RZ5cxUuN4+scx4+yq3bHa3O2U+hij63z5bFmjynq+WimW7mMW6WES0znFjtm6Qsr0vBbG5htgcRFp7TCEO5VTxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8ogm8QC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725abf74334so219081b3a.3;
        Wed, 11 Dec 2024 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987083; x=1734591883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUHH+eJbCiMl2j2oN03m6Q26pa8Tho3uZPMyt8IDCBg=;
        b=k8ogm8QCj0Cua5i6CkZ2FYDRRu4VUk6LA2MI7I/5wROHr1fa8wosjR4VyaXR/WR7FK
         NU1vgaaAzmxHmk8RrzSxFnYawWIhLwcanCvXnOw0srReu8TzihhJru14JMsbnUpxiTYH
         JRPHCWHHIGhwvp3+fjQe121GY472Ns8jLztpARCteooGB+JcyHMs0fSy4BOSLhMKHFvY
         +jkdUbXJBTuunqfO4ED6Vnh+U2FtZ/y9k6004cNONjGMB73iftCZU5YhIcQf+vqMmgVz
         QAShPBEW5UUsQlFO4lZWV0YfKgXi3WaFmzyrZlndEArEyf0OwUdrzWyWnZs1yxBiQX4w
         KpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987083; x=1734591883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUHH+eJbCiMl2j2oN03m6Q26pa8Tho3uZPMyt8IDCBg=;
        b=v66KLmLtNumqDIdszYUZQHLqN5ZIX4fgNatsPWHA9ggvOU5drqTXTiRsGPih37PT3b
         0KrihfiS0S5B5s2Ap5LM716SH+Sps3NosPAKxY4xy6ABgRqMD7VKQs6FOpuizNSVUmuv
         oVR52Sdjn5Za1iSVYlTYJOLPf74i2qJABMKajDqmkR4jGMKIfcf9kTzB7fwCuta4psah
         lULU2extzWOzgPxtONrTG1iEQuGb6eAIxNSon1np9aevDCPtHM2Zeaeru5+myKQ/DK1c
         SKj+qnbXRMkguyFNp3cAI1rzrR1wRvZ+qzuFA5zVAx5Na5wcTCvhOJrgBfWN8iUUTLT2
         z/0A==
X-Forwarded-Encrypted: i=1; AJvYcCUCVVdALxO4IQUCpByaE+0RcJy25T89+JD23+OW3Gy7F6xxJKnVRZjdYnCL2nxNzNUPZNi8h8rYabFV@vger.kernel.org, AJvYcCWrKV2sPhtnWf5CuKLsofSLFi3iMM1iSB+tIloolH7mdzjvHg/aGeJEX98/refZwyZug4+5xX4nCCC1K35Z@vger.kernel.org, AJvYcCX2uxpt5SP4OnDe276aAzg7J+K4EpXicACr2k26dd5a8nX/gPzX5FualC61AkTx6FpA600wDnMoT78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gCZlNy1Jnnqo9tGRjjkJ8PtWFmmDNALOxGOXzmtoLWc5f8uQ
	IlI4tRGWoTH+TEW7FquYxSlNujYKKQcaBRjY+eJG7C6Bxqle8VqQ
X-Gm-Gg: ASbGncseq7C4GCmAdUeoVl0xmpTLdRgVc9KSajzZBeXVOw4O2tjrkU69OWI8ni6Y//d
	zG3f/2Qhlx62e5oB/3ezCrHFBBnIA6PVz4SJW4BwcfNGKWWKesXjdtrEF7qhR6tkw2TVSDBkuSg
	ucEpSEb8dP3v9Rjx4c4QO34hHfVs7blMOZRNkod2U7naLIqdNJ68R+WdUhCmvjLCNJ10+1KbAST
	Cv4ak+U3nflipqUehK28/c2FqiW+5nEyEKGTpFM6aJ/27/bbFBKSYXZP+MsZB2RmIg99lxJ
X-Google-Smtp-Source: AGHT+IGtN/4wOi7l9DheFzbvnmhfw8j2aOU+HkhGN2Yp/3Yo0IKmhXbzVUwwdn6N9+FFWNTL8LZBlw==
X-Received: by 2002:a05:6a00:464f:b0:728:e196:b5b5 with SMTP id d2e1a72fcca58-728faad31f3mr3605642b3a.20.1733987082812;
        Wed, 11 Dec 2024 23:04:42 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:42 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 1/7] dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compatibles
Date: Thu, 12 Dec 2024 15:03:00 +0800
Message-ID: <20241212070344.3858-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212070344.3858-1-towinchenmi@gmail.com>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
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


