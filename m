Return-Path: <linux-pm+bounces-21991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0659DA332CF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 23:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AA18892EE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86409205516;
	Wed, 12 Feb 2025 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2ggh7BC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E1204591;
	Wed, 12 Feb 2025 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400240; cv=none; b=BM8725eEM4ZRrixX4leIObaXXUQQ+OAwZLWsTMswk0CXEJZHi5TNfyL2gOz1YqYGTN2dPFakDHrM1tJMFntOmgOVSJLrGhf74E8DF6G1n33kcSFOwC/M8A7X4RE6YcYPIFRobaNdCO/S5ndQYt2v/VkXcCtOx2GPJYIuPH0+Yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400240; c=relaxed/simple;
	bh=6kwgRI/FlgXZhVdKkCbXIvcA7IIE4FmKk8xsnIfMDuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZXPJUjAWrcMSj0wdhDSfFRzfZO7WXxMDQ4KyggiaVv5oNpTn5TyFF6JQVGrok1K602veFrsf5IpFJ2wIdbl0XMzcy5b420gCsQD3iq29qjhYUfUo3jvqPvPVppBFQq2t3bwCXBErhJN8rZIkPwR4NTXqWQAQolcWrsIXC5hDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2ggh7BC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso2819219a12.0;
        Wed, 12 Feb 2025 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739400237; x=1740005037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZXh53n6VCDql3hZOCr9qqqfbnvH47zg00k2fG55aMs=;
        b=W2ggh7BC+owplttz2VHbxwyX3HdzXAqoQemZA7vc+jI1jxxIC08Sstd1dsETFxzmMs
         UWdlGfoZdWDRp5Q3gYK7tJAuwQa3ss6qjQgYm/g8QvyrllvvwpumQTvj4eQVsUKt7L20
         fqGqmLpX8PGK+JMopjWSkQ4kbNTYi8Ol+fVDZF3J0qg5WIlCTcWogya40yTkR7JB71ni
         j6x4Thea6wo8LcvF+smk3iUQpNX1n9Y1TX1lxW7e7Hq8KdjWX32bPvVn4ECfZgqvQzXB
         NVQY+FtG6qOeysmuZUuB+ID+6taNQJdhCb6iVdubaWu/FhWSPifOzP+gzo0d/oIVnEQe
         3DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400237; x=1740005037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZXh53n6VCDql3hZOCr9qqqfbnvH47zg00k2fG55aMs=;
        b=aGscYjUiBZeu5YlAukTyT8qNrxR26cJRYyBkBRAhWrURTf6YcQtc/GHmWCRVN/Xl3K
         aXEFrMkKgp0FNJpQdTp2Es4D6jEGv4kMDQKcQaGU+u6Z7aoRoeE5cMMpD/P5Yn6iOLTu
         A8mCiVhWFV7iyxcdQHWoLbBt9ik2XAnn6qOb1/qVtAJx7gzU8+/osFdOd18fkpE14Q3b
         FigeXI1wYfkIvMq0aSBPtjcVByAx20EZ3TKvGN1jcxsv8swnW+bFz3Rxb1HuAJIUmsr9
         +SDtWRvjRtwn6nZ2F1RS1mi3JUYJyXbPZsrM64Lh8o9Uy9CnOESHW8mqiKUAo0lAQrD3
         9qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYkDMBBwRrrPft/eJz07dVvuv01F1qD6H8quCZZ2R4nTBwxRozOVuMfNbn/lQCgUilo0yQfm/+cGU=@vger.kernel.org, AJvYcCWZSBV+8kA7mu/+2yDV1L9IJXDvZzCNLZjIeihD4euhrkgdfF2u2rcb0pxHVZsoFLFIoGeueafpHzyl@vger.kernel.org
X-Gm-Message-State: AOJu0Yztip+r00ats2ohuwtA1l2mWRLch13lkaiqxGNhQOboMVXzCLoG
	wlbMHLU+S5geesHmAa6FnXAOPoPFajn86zC9CFjlR23bQdGaPUUQ
X-Gm-Gg: ASbGncuxFi5hQ/OoP6aEHoMFfUqykxfllTtXmXe6td16v8b95vzllNO8TOYai+RECRp
	NrgwJPoG1FtcDumjDXYou+izWY+3zo4maJpevnVQ8jikOZC4cU8jHeAr535DBwhaXsbE1SiGARv
	3HYS3e2fwaJOCfqjp8mxDFt24Npk6qbYNajqg5tnYTh3CmPQkf5afBzL6sxduY9Uc4LtO8OVTvd
	uYn+f/4yHhKL7xjTVYxKecbTt/+wj5S4tXn/PbnZuR1CIO9uM1wwXibfcSxE1EV3vKclHRdDKKd
	8eUWY+ZQvIW0exol39HCzU87iI72
X-Google-Smtp-Source: AGHT+IHBmtagS8Rywtty3nyKWJ5uTo4mUVNCLeloZZ6MDa1HOxfnWgqxmhF80EhBNTH3MA3wmgnX/Q==
X-Received: by 2002:a05:6402:4316:b0:5d9:f0d8:22d5 with SMTP id 4fb4d7f45d1cf-5decba8f0d0mr438452a12.13.1739400236755;
        Wed, 12 Feb 2025 14:43:56 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e02sm119914a12.3.2025.02.12.14.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:43:56 -0800 (PST)
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
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add SG2000
Date: Wed, 12 Feb 2025 23:43:34 +0100
Message-ID: <20250212224347.1767819-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212224347.1767819-1-alexander.sverdlin@gmail.com>
References: <20250212224347.1767819-1-alexander.sverdlin@gmail.com>
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

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v3:
v2:
- patch introduced

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


