Return-Path: <linux-pm+bounces-20211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7425A090D8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867ED188DF71
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7568211A11;
	Fri, 10 Jan 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOUE+DxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3F21170D;
	Fri, 10 Jan 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512789; cv=none; b=FPOtM0fg4Qvcxjkal1hErzHDrPtMb184yUKOiQ961y7BNu0l+Dapjl3iVpgCIAMTF3Qxte8MGwee2uKhrFiOrSX5NJwywDnJ6jZNxLlV4lluWiPQ+T2cWvoEiKDfUkOV3JCBVhaRDYBiGdZMXTzWXysqJR57D6IdT04TXRHTtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512789; c=relaxed/simple;
	bh=SZgfK2aYv8pPFIHZLmPi/tO9yG4IwtWpB9p99FLcJzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRxHjLr3sWXgh2IX4ugkXirJAoFwfArtoziXN1LbxgSwhb3Cxr7Z9mU+PVex39qkXU1zq2RZqJFuUSyX16yQvO8FW6Tnn0/TJhov/ZwqkqpyFtbn/3ZYNgHil+HNzVjWGJTts1OmreHXDgdgZk1EQzsI8vFRZzLog9brd13edZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOUE+DxT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso1104627f8f.0;
        Fri, 10 Jan 2025 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512785; x=1737117585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJmyCOFqadWSRKuEdBKxrveAFmDdO3l0+JDt7G7jb0M=;
        b=HOUE+DxTsAgpJwqHOqz8FbgfGnXFaS8fW2XQRLfE+lITS4/H3hcoA8Dq9no9SAH413
         wfp1trs1RiVkBuMvacgj24gMZ32QLqfPAsHqsc4msnLPqFcR6Ejw5B0V/a+Ov/PMSWLT
         yuUrWzJiIDfJszodZC3Z+baD0sqPVePZPQhBRQ35kLorGlhq2iVPbiu73iNSayzUyFnZ
         oOU7/6MFcRwfD23gaMBd4eIf9AqQwtFA/4I9qVmilWipBvB+WuMth++YpiE/vpSvJVMs
         81U3XJAon9BGIHPqyhKEmeICWxB/r3oMDiauLDnYMRAtOcjoIBM2lBf/Z7Q8u/wuUL1d
         NSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512785; x=1737117585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJmyCOFqadWSRKuEdBKxrveAFmDdO3l0+JDt7G7jb0M=;
        b=RGlfTo/5uhwoCcwLRSghbEhmoEHuEkY9GqZD+CPb2Li/KYYCKatafPuZ4VVzYhLmd2
         w9b+ylW7bLjL3aIVHQqEl3Dd7+iYpuXP12yXFnFktjX1/oZ39FCvQOMQl3/tmXDninVx
         ctd60M6EXnP1ccC8WYjxMtwVBT3AGBlpKGV5yoERQeKxj2H9gHjf8NhIZyW79dz8t84b
         dcnlHoCmfmaBQYXK8OXGHsadZ3yZRmQz35HkekrbjySkii2z6f0Nke2hAhAOYiv9VSUJ
         AoWMC6yNFFV2Y5lLAoBt5EoqDQkVnxzqvzrYxC2DiZo1xyQt9XYUVfuv6fbvemy9qTjY
         4WCA==
X-Forwarded-Encrypted: i=1; AJvYcCVvgvBRyrDQglCWMtXC5agCpXrWWcSrhWnxQL6LsOvYRDJ15P4iCuI6OE+QhZlkAZG6qddoB9AqLmE=@vger.kernel.org, AJvYcCW1Rgf5RX109NXeZsqN0nJ/AHOaXZSISqq+PHX6/1gqmuEsqdBlhmKyuTnyfjNsYNnLcGk1G6qt0fn6@vger.kernel.org, AJvYcCWsNgTuwR5UBN2xCUyk+vHXdv6MahtpbcifNhBgP9YYnrQPBexeNCCNhY7uo9W96Fp49BOvuE3XDhfn@vger.kernel.org, AJvYcCXSdsEDv52h/62DdRXi0i6Uxki9XAx4w5e9nRwd2HLg9m7zakVPFIMeORpBhaNklMWVCSeet9fOec7Snw==@vger.kernel.org, AJvYcCXuR7xrELMLzRKcJBU80UjsXmLTy49qWozVghXkkyvtGmYEWJp1A6Dnc/bhA0369aERHWA46zaPwrtD0i8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTmgVAxVKejhIl40Xr0vDe8TeYRiX2Mxm9a8lrFFt+XfhstH6
	32RDhw5zWLUWwiZNuxf7JxEvJwm3OYvaYqu3NSOxxUjA7RIQ1e9L
X-Gm-Gg: ASbGncuHEvG0Ls4PsF1VAWinurQVK9EjbDUjvXPrEmoQ9oeyDQ0djnlmZuZtoWSK2Qw
	vBPVRJUqkfxSZNCuCoNggTfphssRlHMbO0RUqhfeNikxjpJvDdoEeaiq/G8TP5RXds85mnKmBOQ
	ZbbkiJ/Tjv1zHmNcCPCi9DvCepdMKyGeADsV4l35i31KEJ5q64ZM0Awm0Z4ZipkoTFedDRZLwen
	9Yg7lPvALSECDp16NIh196R8GSmjQ/BuQkThzjJpm8S50RpSqOvpDXR0qrJ4PIRkQP61gMu3eS2
	q+dI/pX8QIk=
X-Google-Smtp-Source: AGHT+IGUcoLwzXrCYitO84d5KV2HeS8xG6qa6Ve5jSQImeWaqyZAVC1ymQps2bk1a3ZQgoMPtkkXww==
X-Received: by 2002:adf:a108:0:b0:38a:88ac:ed10 with SMTP id ffacd0b85a97d-38a88acedf9mr7519150f8f.25.1736512785405;
        Fri, 10 Jan 2025 04:39:45 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:44 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 07/12] devicetree: bindings: power: add v853 ppu
Date: Fri, 10 Jan 2025 13:39:18 +0100
Message-Id: <20250110123923.270626-8-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110123923.270626-1-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document V853 PPU compatible.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
index 46e2647a5d72..f578be6a3bc8 100644
--- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun20i-d1-ppu
+      - allwinner,sun8i-v853-ppu
 
   reg:
     maxItems: 1
-- 
2.39.5


