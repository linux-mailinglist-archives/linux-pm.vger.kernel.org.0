Return-Path: <linux-pm+bounces-21607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4252A2E117
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47810188601A
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A11EC00B;
	Sun,  9 Feb 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY65KLzB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24691EF09B;
	Sun,  9 Feb 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138833; cv=none; b=Y1oKd2w4tEaF8PnQFaf7j5aXSubniCxKvZ63hfylvjC32b0B1LzTDC23VEriDMhiKX7tPpEYUbQTx6n4yYghrd6q7whVLQ1ecSDO8CGtLDEEVuKNU3WFG4Ztk81bRD8he9aKip3ROPAHz/lYsFyjzP9Bqs9YL80NbmC0TEUnAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138833; c=relaxed/simple;
	bh=BbFmuE0Bay8lPRZqwnXYNGxAGE2jeIUX8tiiV6wlK44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2Fnq25+f58NUCf8flg7WkMpZio2zji27HL1UhdEIlPVHfm1gzM9+Ca+zIIc0PmSTWV5hbO1YBmTkbTLNFn+wUKcHLjNmWyXPz84sqs2vmt0yAMBgpaBlX1wBPibgwrdrpktJ4OsSjpTgiFVN/v+0HDf1PH73WD+pI3B+5e6gaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY65KLzB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4362f61757fso36773055e9.2;
        Sun, 09 Feb 2025 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138830; x=1739743630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8uXdpZb0QVP49WhVJeQTFaqN+VWPKe0SMsURklPfjs=;
        b=OY65KLzB2NImoGrgR8XxcGTo/1y9CgZw+uul+WuI5RhHomo2Saur1dwEuNp5jDMyiL
         qxhdLaxFblZmFCvRDpq4648N+Gu3ucvh8KAnaAJexEnrHkgjEfIDO637Md9McKWRemIY
         t08CHmTOhQsfRw7wbuED2MFA4aAeJXhXmjeeYzsW0z/Frp6z3Vum1LUJGZr5qJNLkqI2
         y0hNp2v/X8KZ3kv98FpWJzBzdjv5JSZBkiNLenv8BldNmcnedV8VVodIq8DLpxOqmDjG
         LLNuRdUN1l0mWpjNHCpGD2noolP2YdPvMbUzEeWu9vdNzKfmZCynOBwo8+OmfCc0VvSb
         qm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138830; x=1739743630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8uXdpZb0QVP49WhVJeQTFaqN+VWPKe0SMsURklPfjs=;
        b=RZCa6wnXiBMX6+wibzVy8J6lOCITcRmH6VvzUhijTATIDdyJAz/M9mBy7ug2uhK/X8
         3FexsJZHjCDaspCVTBg5IBfA7x9aekezJWaei8DIWEnSJohp2HT2oDID0oVvq2OHTxoA
         CY7zsfhk7h2jSGupCY52ZIG2jiXd27duNSQAUwHL1kr/U6jLLw/p3hIGaTw5q5n672XA
         cGHY25g94O22cfwquphTURkW7eSMwfAGc0TBorqoaPPwZpmXEIW57PC0szibufQ1qzXA
         n40P4LT53yDbFaZfVkXcJ6elWc8+DGKRvz7uV5WLSdeUUl1+G8f6jqVi+3xYufNjheqq
         ydDg==
X-Forwarded-Encrypted: i=1; AJvYcCUTqfOoJMUqrp1nV3KTES0LpuYoewo+phNIR6K+Olpo4Hsqajk/fFgYWYcZBG2Vq9QWBZqqQ9yRa5M=@vger.kernel.org, AJvYcCVFl4+iTvJmvG5POVadZSroF/m3AoMo29aGZWxy2wmqjl3oQKRMlgLaj3XBYhDYwDr59/dXnL/GGi1N@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxi2rOlCubbxAAa5HpNxfWTAJoKf9EC/OAlzBgrt/ITunvJSyE
	crzZMMgpQHlPEsGDk+69fvuG4Y6BYhtrIFb4pu7iHz6Ynt5AQoAtBEfLQRVv
X-Gm-Gg: ASbGncvg+dEV3W9BajYPi1wgKNxChVkl2kYj630KyXzhB7vJovUMoeg4Wzg9UWQCl18
	taJ3LFGoAkwHFx7MZ+ixd2NzvYj+wwzpD/noHdegDVImewRzrSI9wn60Vc5ajbAOniZFuLKJpGp
	4Cww3yfFUg/MI6krySs+Hvi1o1g4KVvf4RIrk5lEwGJsgOMMVPU6zcvCks4iD89Ab1pqeeMlVxB
	n4W7kFM+c/8YK59OZonciUcvsk11AC9oieBrRRoPApCJA2mZwugKSKJdIp7hJBoYECtFC1pnB+l
	NuvNwj6kcSOLIbsOOnxpH8+suGIt
X-Google-Smtp-Source: AGHT+IFs/uD6uHSEXZaTM+eANebqsdHvVmdihPSPtESqNNdICu5h0lHig1CDm5zwmYfpbmncCv9HjQ==
X-Received: by 2002:a05:600c:1f96:b0:435:1b:65ee with SMTP id 5b1f17b1804b1-43926158833mr74064805e9.24.1739138830140;
        Sun, 09 Feb 2025 14:07:10 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm10386544f8f.53.2025.02.09.14.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:07:09 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
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
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 06/10] dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys core and ctrl compatible
Date: Sun,  9 Feb 2025 23:06:31 +0100
Message-ID: <20250209220646.1090868-7-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These syscon blocks will be used for CV18xx reset driver.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d67ff26d445..5a0b102d1bd9 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -108,6 +108,8 @@ select:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,cv1800-rtcsys-core
+          - sophgo,cv1800-rtcsys-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
@@ -207,6 +209,8 @@ properties:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,cv1800-rtcsys-core
+          - sophgo,cv1800-rtcsys-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
-- 
2.48.1


