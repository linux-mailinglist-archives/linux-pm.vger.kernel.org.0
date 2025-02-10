Return-Path: <linux-pm+bounces-21755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A5A2FCA9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 23:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1DE1886F62
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64E24E4DD;
	Mon, 10 Feb 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/wVAPiN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940024E4CC;
	Mon, 10 Feb 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225407; cv=none; b=VOHgQokK2XrR/c8rbLsLMRo5OAFvfdWmoPl0oHfH9p/cjwA5WBrh6qDMLmlp05hab6Ouo0hvGCmWDw6vmoxDzACQ/vqVCo69Jqg5iReNgy5882gKVGreSrZFLdRw5rvAX+vMJBhQg0ld+NEJ0fr/zxPQaeY+EnoN4Pdfb7UuOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225407; c=relaxed/simple;
	bh=lAvoyba9xFl9uwuh9s7txaT9iZdnZ+MqsCE4z3EFFOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyFHczLP8uk7nXXbNSTC4BZTeMqieQTPwzdQb4fpKpYLxvpSeDB1vyNh++REV6oGnzRH1fo+vflyldR3O5yzEpcLXx4C9656V62DlPATLSHCxfRrVlbKxNjlBIZfnf46J+LE1XC0jgITJv1PSZi0a8NDx45k6ITtrh1q7TzGw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/wVAPiN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so12146095e9.3;
        Mon, 10 Feb 2025 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739225404; x=1739830204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTebZHS4gk5PFvDqlcXeMybwJIw7UkV3r+TMXWTUvHQ=;
        b=G/wVAPiNgvLCi7Q+i9bgVrfcMcGPW5ET/UIwYxUGVbhZRBR9ZzjOwIE7anhAsB+u3y
         yUJRJLVZ4/DpBfVe5bZ093WAYw7xz4/WC4hJgB/sSGWHUabeJGFA+LwgbUZ84kxL8rZL
         iAYR2U4o33yXsG+jdQCcf7x1DpGR7jrB4W+UE8Crj8a1kps35tpymrYDAvVR5khHwfy3
         78rDPbF0hcKqDaFv71MbLZmzmradTFPHt1LSpzFa8EmAbL4yqJMcn3bGY/DjWZcMZ3OI
         OIRxx7EGCo5g6D5cvXSBhZgNOkT7471AlXPIrWnxEBhLmg5nUFMffKAokaFVYVvozBZk
         HklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225404; x=1739830204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTebZHS4gk5PFvDqlcXeMybwJIw7UkV3r+TMXWTUvHQ=;
        b=FOtDdzhBZy1h2x8H/L3sc3QTf1xXIZpYB0hWrKPTDhvQcTe2iuAsdIeD0qSEhvLix3
         eV0gXxxdavl/ebgnUHFtxigIabXDii6K1VuGdjHfaiBn+f8hI8RKQXTNiqlMDyUyD6zK
         FIwDHlVAMeicZlfwl41oXKhzBpeH0RjZd+1v4gl7zB7n3Syw7S7pZ2Mib3+jkYppFv/G
         4qQAAHNaZysqVKnKMJ6PAnUmD0SW7UHoBQ6m8DffTEMU0cfuA8jDWv82YVP3noJYvIaa
         WCVJM2jyJCqW5l/oVytnTrCsCRqWmWfs7M8YuZpiHiphlTWeTCfkZubdDKh3b/VF/+Nm
         BxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEjrP1xyfi9S43/+KMQs+UMgodBekcOgFcgBIW0/1HDZyfkQO6FO8F6dwb9NdZ/YRYWQrW81VOqkY=@vger.kernel.org, AJvYcCXe1txkTxeY9GPGBlQAGyBDajRu4xAtAEt5e7gJoVd7vsucmdA4MYsVXBIVCxBZ+x9kyOSraW68HR5x@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPRzPKKS1VX8HyGdA+ivPkhaV3MsndkdmTWq0gYDP8TNoO7L9
	n/CMXBV9Qbaxgtnkn5PJEfuuUB9809A6kPT4fLVcspTtbK9xh2EP
X-Gm-Gg: ASbGncs4lUL6/WbwqMfUufSZj+0nr5q4DlFWtmhjAQWnpILSFf05VzEZ+r7SnWUDHf2
	4/t5knYVW1NdYsVUYAlrLx8iKQGHSRYEoMVNftmwJd41ShTlgCIEDQkVNO4Kh7Z6exCAkZ9Ptqz
	7gFXREC0Y2d3kaiwi3qrs/89t6cgoYTZJLTrlMugyb6nCJyJAC0oK/qwQZSRobAlY3OR3unZKaz
	+bQljjJun6dmRF5tLPK/8x63qBUlopD8oMZlt55KMPvHzZPfhwDs+v5n89fMQQMe5lry0c2Qqx5
	IhdcdKor3JORjqCG27mQo8Uz53lg
X-Google-Smtp-Source: AGHT+IFDQWvsMaFRnPlrYGf48iq281hise14mQ/LTGh9TT2T0tV9t8mYcQ5+AwVJvhksx+xbz2dF6Q==
X-Received: by 2002:a5d:5f91:0:b0:38d:df05:4d9 with SMTP id ffacd0b85a97d-38de41bdfb5mr1082207f8f.43.1739225404338;
        Mon, 10 Feb 2025 14:10:04 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm13443450f8f.90.2025.02.10.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:10:04 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add SG2000
Date: Mon, 10 Feb 2025 23:09:42 +0100
Message-ID: <20250210220951.1248533-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sophgo.yaml from riscv into soc/sophgo so that it can be shared for
all SoCs containing ARM cores as well. This already applies to SG2002.

Add SG2000 SoC, Milk-V Duo Module 01 and Milk-V Module 01 EVB.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 .../devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
similarity index 80%
rename from Documentation/devicetree/bindings/riscv/sophgo.yaml
rename to Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
index a14cb10ff3f0..5d73d0ccc547 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sophgo SoC-based boards
@@ -26,6 +26,11 @@ properties:
           - enum:
               - sophgo,huashan-pi
           - const: sophgo,cv1812h
+      - items:
+          - enum:
+              - milkv,duo-module-01-evb
+          - const: milkv,duo-module-01
+          - const: sophgo,sg2000
       - items:
           - enum:
               - sipeed,licheerv-nano-b
-- 
2.48.1


