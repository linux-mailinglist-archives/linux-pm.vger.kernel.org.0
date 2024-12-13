Return-Path: <linux-pm+bounces-19205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123709F14BB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF11188E3DE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CC1E8823;
	Fri, 13 Dec 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZC352md"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AD1E6DCF;
	Fri, 13 Dec 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113429; cv=none; b=lcZu3NOGOF8dckUYpsOtqpjvlnD1NAaAHh5LJ7cS51TiGT/+M+3IIWWJdP1ENiJlfsWvdzO6z9PsLpe/7/kMgzFd/7+mtABUBiBknLYCmbRiiW2MW94v4fVx+df3AAXpV2ksgM9jyupnwfmFpx81UWPL8w2GL/RPyj/sovXzfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113429; c=relaxed/simple;
	bh=wCwlt+7GCLxcopJC5MJMifpu7xdIRDMWb2raqFoT4oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjurkQpmN24oPpdfPKrSvdkKIHyUforwsUzXQbby6eYdKOwWJUmSAq/WbtQiKAAdSlnQmm5qrXeHsLcwtC2N6xk1smYHL42UN0wAxDoTQEHUOnDJ0dTlKRwLb3N99y+CLkb1AFXCsPTVr2PCuP5SgnGVZlr+KPrRPg63rTiYLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZC352md; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844e394395aso53293439f.3;
        Fri, 13 Dec 2024 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734113427; x=1734718227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXPrXpI449ov9UhSKua2z+0yiJDVS90M3hJvDU48AIU=;
        b=QZC352mdwrs4oWUP97qY7JU1MawykQfJatAAZsVQ0saNDbjeXWpDKaTB1T642RyjGO
         znBBHIFcUU6qYTm1kKHdv+2iNTibHRT3cAciQRAYFyODTVnqjm+taBw5M33mEfVU0977
         kJ26onMvmFfd+VUY1/oe8GQQ1qz5EVDu0JkvHtj3M+3rQNXCuZQ1DgpGnanp+6lIfajx
         V7ACXO3NY5g6KrUpKr6xkmV0q2Pb9Y7pe9QZcqwDr2cqDDrnxWGddCo/Em00xeyh0RoY
         lBlOgQ5fUKaSOLJsKIeGYPaEnfp16bfPhziLVGErInixXJClg4d0mPjQLNAFN42EvC97
         ZIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113427; x=1734718227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXPrXpI449ov9UhSKua2z+0yiJDVS90M3hJvDU48AIU=;
        b=i5H+yHCC3pR6teUTmuyvfIluLCrKiMZM4dv2V2Q2W9icv+y89BTPpRafgdvL9BmWEP
         kJ1Gy6ZOZuo543hhbC64NqnRp6KkBxkVJUS213bvqDikcoKNTYN2R8/zP7ThnoEt2LnE
         q6K9DvzcE1PId1XiqzwxPZmlAAAbBMV1g4LRweg3u6KFMWFy7T7cqJE4oEprJfHSPL1V
         KcBKnNic7g2lMNbFoaVbNY7UVSADZva6ojWAy4R1vvMAIAOQd+7QNiZUeR9/QgenEPry
         HNgof6b4f/TUqL1n3gBOw+lh3+Ie30f3lVZCJQSl3jEpJE4ijv2MQjQw5kvmOq27F9Lt
         72Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXOMwuFQQ8oaiqnRjjZXg8jqcWhj/1jUc4H4rb5GXtlAXYcHHniR9h+4p3nh9yMZc3kja1H40iN5vU=@vger.kernel.org, AJvYcCXjqxb40Fin5tY2hZS+pwpEwnQOJQ9uGysC9waRXFxhtP0xCeM4yoSkgRJrced7uun8MCLrrOqBZeHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1SfvWBnZiRct1Ah4BvJDK5R3AZQn/c9lUSK9cBab8DlbZQcp
	be6kplq9LMbNb8qdXlsEcnT+FGzGdcXmY00JxYrowb6uoVzJEcp/Pu9Vzw==
X-Gm-Gg: ASbGncuioVX+a8II95kEdi6ysafhMT0xgNFNi3f63yO3i3n/OxEBt5CacndBhvkct8W
	QVeUfNC99XmL6ejJLPlAkYUEVZ8x4BehpqJP0fvdPGvWWkNMep1WI02vsromTyu7ex6H9ga3Gai
	KNUJHx+SL0U9eWybmrVUgSNUju6YBh3FzeESDU9+mxfW8NCxtXCQmqq6QpR3sK4bcTlObiKCP2u
	SGkieV0rIwlobo7L4R83Q2TxpA6mz3+YoW6/lY3dmjG7SvqKGgvo8guW/3gm2CfAaEwxC+x2rh2
	nZVk0YSARV8hwX9HyWVFVpbpMd8=
X-Google-Smtp-Source: AGHT+IHLYxooB8Sqn2S8F7OH0vGMIzkYzZ3Jr/Pux0565zJs3ssqRpJ8c0d/gYSGr71vt+GOdL6q1Q==
X-Received: by 2002:a05:6602:6416:b0:841:a678:de3f with SMTP id ca18e2360f4ac-844e8698247mr499346639f.0.1734113426981;
        Fri, 13 Dec 2024 10:10:26 -0800 (PST)
Received: from localhost.localdomain (65-128-205-244.mpls.qwest.net. [65.128.205.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2baf714cesm2922533173.101.2024.12.13.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:10:26 -0800 (PST)
From: Shimrra Shai <shimrrashai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: arm: rockchip: Add Firefly ITX-3588J board
Date: Fri, 13 Dec 2024 12:08:55 -0600
Message-ID: <20241213180855.16472-3-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213180855.16472-1-shimrrashai@gmail.com>
References: <20241213180855.16472-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatibles for the new board.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 753199a12..9ee96acdc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -190,6 +190,11 @@ properties:
           - const: firefly,firefly-rk3399
           - const: rockchip,rk3399
 
+      - description: Firefly ITX-3588J
+        items:
+          - const: firefly,itx-3588j
+          - const: rockchip,rk3588
+
       - description: Firefly ROC-RK3308-CC
         items:
           - const: firefly,roc-rk3308-cc
-- 
2.45.2


