Return-Path: <linux-pm+bounces-25327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B247CA871BF
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEB5189AC9A
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30651A3BC0;
	Sun, 13 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnpiHLJ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBC1A262D;
	Sun, 13 Apr 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542659; cv=none; b=XxaNVoc04kNe28aF5em8cP+lMFj4HKPOY4yULnvwtoWwVbn0oEQtmMYbZiNtb+qG0fuVf+yrKVxBHgI29cb4bqLIzK3YuBuUJeE7yi4cyDYb+pJpK623fW9Y02lwrtfzsEkBV7Nlofx15+KQA1TrY4kYS/nKm2CgqFFb9vQz4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542659; c=relaxed/simple;
	bh=tWuvjdvK1kEwuFqddb24VhlwMFIlzbf1J2NMq9nJ3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se+hxV8cvvxTJ0qVVkI9BJduazfTo2avZrxLXZ6j4+LFfzlJH7gGtNUSR8AaRDKvDl856bk30Dcdku/9n3Xh0owopVBIfAzXzAXDolQ/9cTRWYbPxJM99/jYnJj3CrWPCnlTln5WEm0v3h8YDUuRkr1sLejtdBxk7MsmJaZo9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnpiHLJ5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso663546766b.0;
        Sun, 13 Apr 2025 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542655; x=1745147455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU5CATviFJF/LK3wh5sPsEQeQtBjz8XojChp1kJqUl8=;
        b=UnpiHLJ5i8KniCqhrovlh/i/AcY1zcEa6yryl9GOn7MpjZ3Vz9a1t0j5AbAFaZurzj
         I/KtjXbKFe8W6X2MHINTDBNy6KCJwtRheRswJizwCg57Ivvuhl7Za7+2ZxuIKxeZIhK5
         tYEU6qenCne7Vy8Qs637kGPOj/Maq4N3pBbvWSL/FM9JxBzxfV2MjaLLKykWv87ojNhw
         6CzU4r8r5I9VpcSUOFKzrj05Jy8gHWI0ZNs5cxY+ncB6/Rpxc/g1dyVUAb7AXb1H5XVX
         GAcY0KYBSLtzYsqeMZH3+XCdL+ENFDzfK/agpF7dLV6hnZNXcJb61cYoqkGPR1Ql4Y5c
         Hm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542655; x=1745147455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU5CATviFJF/LK3wh5sPsEQeQtBjz8XojChp1kJqUl8=;
        b=AjwjE6dB9jueYcbhlPqlyF4QQtfMqCje3I++2vYCPccYM7IsT60AhPg0f0k9lZC15X
         wUtoTL8rfZtzyUlsuAVaMk/HeSYGaNbtXT7RuiR3BWoemIRsLzaA1kAIzimnl10laUrZ
         IlykDj7NqYhEdLHTdP3wMCdOBL6FJneBtDs08hZ2NYy/VoNLFbcSvc3wbYkLvBt9a1Pq
         XoZu+1K2y6QuLUZvjS+vijFH3X71ttgmROK1a6fgKXJG6vzE1Fq37NByxaBw5nZ9sh6q
         EbkSHQdX5trKOnRSpzIqgFCKkGmdOcMnFQU5BBtMT8fMSnll/QpoyxwceRtUoJYUTqqc
         reeg==
X-Forwarded-Encrypted: i=1; AJvYcCVS62sdKJF9CcTX3aDqEvnaeJxf290yhsr2FfLr4YqiJuuHXkkktcN+iBqxiAcnXY+GUWcKsPgG+lxrVY+X@vger.kernel.org, AJvYcCW+2ENSQXJSjnNX6P7vKqQqNv7/RPU3M/7w/7VJrxizishfdI/1elHcYC8IyDksvJ2oHSDTBGeowekF@vger.kernel.org, AJvYcCW0Y1onz90maGp+vdoWwKSsQXfOzWmUMZyxXizVH5vngL3Vsr0kK449cx9RGE06+M+pYc6igbT1xkVi/2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDxh4P9jW9kxKq9PCSOfJSflc39Nc+GF5fHoSIAqWdAArLokc
	ALyBNWX+tKo3vQ1QlU6dpEu5Zk7A45GyclWAdN/uPjW3ohtnIe1v
X-Gm-Gg: ASbGncvK3NoY4TFw1tuFBuH3AMUaVxEd3znmb2nSA0nu1fyzn/xMmoKIgGtvES0UaSG
	JKpEl8yPLyxta3mes+ymYIZJspf+K/IfeIMwStP5axXuJ8CFphO+V1ZIRxxsP/L0Lqp8LVFFPXq
	rl6sKohPL3xt1VvymYKqrSyZm5NoEytDbynILwXOPYMHepf7kgLR7DgIyxRBURRyAB0B56PhjPE
	vMNfklgcwcJmZaZO6MSA5LMlPl9/qO8c2YlKgBDAN3nsIIwgtX90mB8JCwK4l5nktTIc5lTqHTd
	zCbSs63jIzjDEjkr4WqoyV5p+mv5EZgz
X-Google-Smtp-Source: AGHT+IHX+r9x8Mlr+RfvnwRXefB54Vlps1So97wxcat5/WnoV7XKrCyoxpcfqd7tmwCNGuiMlWftvA==
X-Received: by 2002:a17:906:71d6:b0:aca:e6b3:6fa5 with SMTP id a640c23a62f3a-acae6b377ccmr348286966b.14.1744542654946;
        Sun, 13 Apr 2025 04:10:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm728571266b.59.2025.04.13.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 04:10:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
Date: Sun, 13 Apr 2025 14:10:30 +0300
Message-ID: <20250413111033.11408-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413111033.11408-1-clamor95@gmail.com>
References: <20250413111033.11408-1-clamor95@gmail.com>
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


