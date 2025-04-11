Return-Path: <linux-pm+bounces-25198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8AEA850B5
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735DC9A4821
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092E1401C;
	Fri, 11 Apr 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azoN9GzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB4FC08;
	Fri, 11 Apr 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332065; cv=none; b=o/ojbzLYsrpr5gqAtuNAcuwN7vtX9cV0dv+83a8iRYF8m9J4xv/10fD31qOVcMQbsKdgzrY2tOdMhooUd8uoJ7gdCPd3SYLVNFj76pPuWRxxtpBVLmLse6wf2NC3mWF1cb2nKGenwkQLPD48stg3jjhpHIkooGEI88wMR3WtDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332065; c=relaxed/simple;
	bh=3gj9u/hlulCyyg8E7Exqz6RlgLh9YXNSVMUR363LDeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMrCwy5S5Wtg6/rP93XlXNa/Fmn8m/D/CNGUUYkL5R2OnOO6jNI/s8jl5vukt3sdkriRs5u/PjuWKjOkJ1z7ki6k1MXJrfP5YKYqa2RD3BnmM508KXvdIUgoi66zpSvBwd/ypSwQuMni9na3w0+JDLQr+0mH8MdAUr6R0hMzn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azoN9GzL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3061513d353so15207791fa.2;
        Thu, 10 Apr 2025 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744332062; x=1744936862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVVDUXMgIvl3qGuqG7Y9JWon05wMZyYxnJ2zr2Ehlos=;
        b=azoN9GzLjcMzmmv+eGLU+LVnLWhESyTA0lvkud9GZc8tykobQhAIOigyTJ1mDhUJH1
         ZJ86rc4IFZu6hpmyywJXitUzexr6W2EU9iCQUUN08DqfNQUgNQCaHtMTEr+7/F4CHJO/
         jmKvGcZ7ZOCOPuUYrEFtjhzILTv/rJGFVQf10k2xySKEoI7TURvbV+0jStoQhGOHZLCB
         iJ/ZbH8jwdzR7EXBUa6+5IGyVDwKDg3w8HEFZBhI1fGjRmcuPglkpkoFlNRXuuVT6ziB
         AIiMj+lxR7yXAYc45XZIHG+pKCsi1nD6PIorQOBdBfb1zA2jXXE6OX7B/yBnaJSE9not
         tVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744332062; x=1744936862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVVDUXMgIvl3qGuqG7Y9JWon05wMZyYxnJ2zr2Ehlos=;
        b=UrFiaLbl4ASKa0ZtLJee11Hp6zM5T28mtWvVqZi7fiofN4rLZsq7Dt5EOzBDUZJyT5
         a2MpJAeEdw4IWTMzKTHsBB2oAdI12QbyzB/sbYnCmSwgCfI6DH8ivSx+iuQScZN4QBj4
         uQXNmjdLYs7NIY9w6p845fro8vSesRjCKm1FfPlqXsXi8t6ik0hohYKqtqiVuk6IM6xE
         tq87pZI5/9D9Qc7xsqiTKvCQa07Cwedyes1D43OvCKHGeJ8/XJ60lwrLOZ63D5zzgxAd
         eeDL36CO+sk0J8Wb9ubcjyVVM+ci3k/TE/FUqcOGS/QJ1EYLEjE6N8dk6j8j9KwTIgXK
         T3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+RZ3rwBuy2Ke/mJp/211IsEiVsnfglSwbDmozFWYLUeRqWoqsKBiF+Qb4ocRKcSw1Ow7JeQ1hEEra@vger.kernel.org, AJvYcCX+YQEBOImN501BHBYhIe2i42Rbm4YEtduAGZUxAX/SqCi6yLcgrgz7uOspUm2cwysQINtYZ1sybb8Le1K4@vger.kernel.org, AJvYcCXbvLEx+p8Fgn33+fB6Ff3tvm3zbhb1MWvex2yDW2M5Y/qCgqD/2MPOU3dvpJan0wZ+kLeBNawHh+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcSaQyfRMb16PGUSIIM/ugTPU9WP4SGHqn5g/OlxKL9W4Bejn
	Jh46vkEwGi27umVudq4kenjNRt4ePZa+Rg2FHazR4hWF4yJWJMtU
X-Gm-Gg: ASbGncvr2ZUr+KjvIr6MB9Bi1cN5iZIXNjft9EwQYMZXJsgmSFa5Yw2ZNBOsATCi9/0
	TC44sIgMs8HFjYt2GtRBfH46XPEdcC9s1LG5n1U1nPs76l1tO/EdQNyFVCH/E0L4AWBY0YUX+An
	owmQg2d41kGbfKB6qF1gwJUTKx4WXfuNWDEcN0AC0fPXQYYnU8l0Khyx8UhH7VGZpp3+5HArgRv
	6C2oCC9LqfULsxZGWQlUhdd9C6r5OE1v7fEXx577prGwR0C9gqf41AMFbDoBmY3PtHXjshvTSvG
	1bpcpcTGR1/yWYW1LAREfsudnCMyet7VBwMjZTxxTzsQi1O/tg==
X-Google-Smtp-Source: AGHT+IGiJdnH2bwA47CyELRWVzejAMbjmYQFTtee9XHHNai4Q7kPWpY1iiYd/YOYoOt9vN/NRllLgg==
X-Received: by 2002:a2e:b8cc:0:b0:30b:b987:b6a7 with SMTP id 38308e7fff4ca-31049518235mr2053581fa.0.1744332062006;
        Thu, 10 Apr 2025 17:41:02 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:41:01 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 6/6] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Fri, 11 Apr 2025 08:38:26 +0800
Message-ID: <20250411003827.782544-7-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add dt-bindings description of the thermal sensors in the A523 processor.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689f6..70ac395ef 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -24,17 +24,21 @@ properties:
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
       - allwinner,sun50i-h616-ths
+      - allwinner,sun55i-a523-ths0
+      - allwinner,sun55i-a523-ths1
 
   clocks:
     minItems: 1
     items:
       - description: Bus Clock
+      - description: GPADC Clock
       - description: Module Clock
 
   clock-names:
     minItems: 1
     items:
       - const: bus
+      - const: gpadc
       - const: mod
 
   reg:
@@ -107,6 +111,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-ths
               - allwinner,sun20i-d1-ths
+              - allwinner,sun55i-a523-ths0
 
     then:
       properties:
-- 
2.49.0


