Return-Path: <linux-pm+bounces-24431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B70A6CE33
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 08:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCD3B4EDA
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A5202989;
	Sun, 23 Mar 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQhpCroE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767771FC0E9;
	Sun, 23 Mar 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714095; cv=none; b=ojQ812gd00CFeWYodPYsZHNQWcKXzV2zsBguTXjgvgsLA9Ak2t3h2Qt5LVrjrCIvzspdDjHaQeFPfvhHW1yMm0jo+wWwr5tteFdZm4mGAhGl9RrBCffvhTQcMjkZaa2UIoQbdOajgU7HDNGiMRVkQBJE24lENjk20KXMuuAExTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714095; c=relaxed/simple;
	bh=LbfqHIJBiWIwwt+TO1iq0U3ZOV0oDMuejgyOImjp2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVTXzMaICbgVFiNtL6uYh7OIKPyyPf2rfeywezn8XxTBSAP1yP0Ea59piv8k7FrYExdsu1Nw26pd79R3+Xj3tXX/MZR8bF4J8PxEky3UChPP7kaYFxuPTMoXWKeC2cbK2ojq004beieNw1B++Hchf7uM4tTQL7RcRtFf/KukyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQhpCroE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so4839276a12.3;
        Sun, 23 Mar 2025 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742714091; x=1743318891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1mSfG9tzE1vlwLPDBezMTy+3PVMsOvW4K1F0qCroTU=;
        b=mQhpCroExgEG0F8pSWbF2lIHptct9UiV1qb9rpL3U5AFDrC0tAvbt4kAl1VSzk1WuW
         petZfBF1g+aBvu9L8NdBfhxgX3g+gS/M+ElgH/LLMs835QbJW1VG+DFuzAo2kQeJhaOK
         ruVZ/9vs2i4PzUyhf1QVIYorHIEhYxhbX9MP7GS19WPGV/RWS6JGDxmItSG/waTHIGjR
         bIcSFYI8MqCROwd+1lK8CXxpojp0zobC6g6a3y1evB8KuFAKln4sjZBPvVL9W/if9mxn
         n4/WLNbhxhCe68pfAfktRskPuXyALu0XUKGFuCActhUs05qns6Nc7DZhWFIQXc8ihjxA
         L7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714091; x=1743318891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1mSfG9tzE1vlwLPDBezMTy+3PVMsOvW4K1F0qCroTU=;
        b=NydIqguhqax6mwhyIGJDGzqWFeSvac7H6X56zQqOv7I4YUsO/tK5yv0tpjYMJLKcpx
         x/3AZO8hRR/JD39fohzNhTP/t2Ai1/aqQ3AwzRoJGpeJln40ScMbBDacbqT1Q1eShsQt
         6ZafI2EdIaWSU4gxIbYvdE6k1megf+xbLFtNhg0/r87Gzrk6KcgE/TKc/opzuQ/Wpm2h
         mA6OzlynSaRwsrKYymzn2mAqOcT40r4sDNkTsDODR0e50uj4oh2e92GEm8TEZX10SgdS
         y761w1rQppYFRhyWmiysjuSuX0mV/MI6XnDRZM95jGLD3VoT8e1SjpQ9M6NN73fK4JAC
         tC7g==
X-Forwarded-Encrypted: i=1; AJvYcCU+BJdf9OzbvVJohgOCLZdDiKPggLYRq6JGOBa5PhxSJ0sDStx2vf9LKMbLNm3A2cZp8DxkfVoj5PU=@vger.kernel.org, AJvYcCU2dpLj+kHsAdiV4xEIxX67yXVcf8AM9/IGcnGxWo+DggzFYLTzHgBZD9EItKPCO2hifP/n/CU6H7JUyDI=@vger.kernel.org, AJvYcCUWU1xfUqOvIYOXAudyqZZ+Md6aDX59KA/+bfPYIiM0Kizaoy4G2GSsnPyhKKVy+2iz1AXt3uWxkSTtMlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHOwG2bXxK7ODMnhhubPOkvCj7bo2Sl0wnyxiR/Ejrz/D9lMY
	5yN/ZVABIO0YWFSfRUwwLUP8hLmtltahOK1Mq2X8urXihmcEqe0fNzJ+TA==
X-Gm-Gg: ASbGncsWoI0rLtuTn3SZVk0pXsw71wQCNElFW2kzMXNVytCJkC+NGenN1jqeX3YuwoR
	9hpXLgxtKExl49IuhPFZcTpNBMO5uLvd8B8jHXxwRX62pwyK/Wb2aHiQb5z9gSzoR+5Z3s3qi1b
	zXpM6zPBEs4+j94bcKX1SD6SUcMUWst2kO/jXR4CDjqhm2erRKrPLsb/bHtlPuEwXOw5vlJkZEy
	SdP+6H/VuQ2CPGvHRniva6JZlF5pw69QKmKwUc5tYxjz5MWEw6oUHnrw3Kp3oKjTqCND3u3St+/
	5CWG0ocMj9grmTFenkT+IDXFLHr4FHGCMMez
X-Google-Smtp-Source: AGHT+IFUCQdaf1gJxSDknQhy2Z+Dm5vufDvDp/v5PIZGlQ15eVmjUOCJgWaoqFmDfVj/No6fvDsovw==
X-Received: by 2002:a05:6402:42c8:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5ebcd4342bfmr7112233a12.13.1742714091393;
        Sun, 23 Mar 2025 00:14:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm4218283a12.41.2025.03.23.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:14:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
Date: Sun, 23 Mar 2025 09:14:21 +0200
Message-ID: <20250323071424.48779-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323071424.48779-1-clamor95@gmail.com>
References: <20250323071424.48779-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PEGATRON Corporation is a Taiwanese electronics manufacturing company that
mainly develops computing, communications and consumer electronics for
branded vendors. Link https://www.pegatroncorp.com/

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index da01616802c7..d36389aa4d7b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1146,6 +1146,8 @@ patternProperties:
     description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
+  "^pegatron,.*":
+    description: Pegatron Corporation
   "^pericom,.*":
     description: Pericom Technology Inc.
   "^pervasive,.*":
-- 
2.43.0


