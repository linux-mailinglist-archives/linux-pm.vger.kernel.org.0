Return-Path: <linux-pm+bounces-33215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D72B39356
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2F07C394C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760B2797B7;
	Thu, 28 Aug 2025 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHJxvgiA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F76272E61;
	Thu, 28 Aug 2025 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360280; cv=none; b=mcsKKacs5h1doqPymWtFo83w2Dwo4ZwOB6fO49iZYJwxAWuyQ7pSjgHSs+5PuD1qX3f1n3w8HLidRLvhKNb8FClIK81ifcqYwVwx3L3ZELS+FZy6O/ZOaIFXGK07VdSLKFl0HI5d+JC5qZKRYay3wEvIjav/txINiE1HSnD3F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360280; c=relaxed/simple;
	bh=L4F7l6/zYxQr6YTmwMkqwY0oWd9rKPsyg57GCchM8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbsZR49nVJtGtBI0VGYBKc5DG6t4dy8KllBTtMqlkFPrRjknXa7RkF+V8de5Da2CtVgV87P3Tq54ruFDC6uh7QstE8GuZQQ894c/NRQybTkzVhxfITZacBi6vkfekw8DYoyBciuz5wrnT3grMlg3mJbUohD9toQXVnk9RDcNeno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHJxvgiA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cb9f6dbe7so979718a12.0;
        Wed, 27 Aug 2025 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360277; x=1756965077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=iHJxvgiAbzSvCAOpsezItsxbs+BJuit39FRZYyXKTgB/W84M8hgE8K9Q2+f1AZctjC
         RJgBqAcj6PT6ubCnViOehafZ4D1MnGjTOruoRWFkSyWoU89+jvs+KWdtWN2Eo1KoqJoh
         Sgv84xEoClC9XXP8a9mHxXUbSmip4THhy0+rQCOag7Uh9ocdXqFmMxcVFC+299d2dmG0
         0TItK0c9sgEKV8wVn1Lp563JWbd6ym6OnHH+KhoqApqoKMW4FpVfftUS+pKJ3z8FJdk1
         jfAgw4WyNRUavn2td4GIVIvBQTsEPW7MZijB2EqwmoePzkkYTbZEr9RX/uJ2lkR4haCI
         KjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360277; x=1756965077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=Uqhd4lH1rGtQ+HcAU0W6LXbiuHmryW0mp4qeqqoLqh5baCK4Yw9paGhjdxn3qEQmH4
         y5Q9v3ARukETYrCQwWNhcwfdUpiA++adqtE13mNpN0JBvYbuqELLcJTAxJKTD27YEZ/i
         BwsYONy0ycYMbMe/T6s0P/2VxpEGWOXkv97IDLGKAutkVNF6Cj5PVYPJgWqEf1r8Hup3
         PXRryxRKNN805aNL9QQz1zcC2ymjX42fMCrua96E/vFp1/PpENpvpGsyihLhTR7eOCZa
         Cj8zreFdjzVWUPaIry7LnM+ahOkq71lhDlP+8Sjs4bjuptVGFiWLFqba2EIVPhPu/msG
         zuQA==
X-Forwarded-Encrypted: i=1; AJvYcCV9wKv3k5u19zpezuWxDqc6d6qXOQ6rAYZ4wgH6Uh25Q9ohu+/lwCT21qOd8X7k6UIsZV8KHHVrbOXNvIo=@vger.kernel.org, AJvYcCVrDyr1+XLc+cFVgXj4XIpvZdsGYL7aPkGnB0xdzidxfbP66yt3qgHuj+bcoU9skjIU0HTLSzc9JNXe@vger.kernel.org, AJvYcCX70PtnwtfJFClGQLyIbPgCFQX5pQ7ufe+9nmVwEzJibfqOs35Mkte+hHupgf3Hn82hOlL7epGiMJrSErKU@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7g+yFb/rzcJnVlwd5g4SdrzhVT3eq6MfNH5y08qpbhqZ3u6v
	jj/PlNQbzaYv2QeW9xudPeA27HA7bLB4ksFSXrb7P2KxyQ6JMeryD3gC
X-Gm-Gg: ASbGncu7M05Q3dT87zuqNKVOWNbZ+YrPxBl6qi7YA0UUHgMkqxeHOKij7zXLhAvbES1
	/DW/20L1fF8Xtm9sl6WYTBjGYIRZc748GZf5nY95J3tOUbGERhsTs1gvCpyj3i6Efern7+UdCjq
	ZOYuP1CwIQgpaWUp2Cpoxmtk09l29k0FhQch2v9ginhKxeIEAas9VyINdMdpsOVsrIQ4VxgpKva
	hcohFYklFX4hTrGxcQL2HkC5p52dpjMWqaHJ83ivgGXDhQNdZqUdjpL79+5rN+TeO/ac6qmC7fF
	KiVGmjvQWTG0Qx5ZYz0aSHyd+oRlKFkq8wiuxIVCKu1PCu9UiWtnBsY8zmBAS+o9ahd51cJroKi
	XCdOkr7UiLerWkKhF+1Rpl+/j
X-Google-Smtp-Source: AGHT+IHbunR78vkQfppzY9/n5uVtFdIMFPQdt5Zl6m54US+3/Qq4Ky0cPEh7w1QzuT0kf6ZFH3z9lA==
X-Received: by 2002:a17:907:807:b0:afe:d0c9:8f6c with SMTP id a640c23a62f3a-afed0c9991dmr290554266b.31.1756360277171;
        Wed, 27 Aug 2025 22:51:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
Date: Thu, 28 Aug 2025 08:51:00 +0300
Message-ID: <20250828055104.8073-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250828055104.8073-1-clamor95@gmail.com>
References: <20250828055104.8073-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document SOCTHERM Thermal Management System found in the Tegra 4 SoC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 19bb1f324183..2fd493fcca63 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -18,6 +18,7 @@ description: The SOCTHERM IP block contains thermal sensors, support for
 properties:
   compatible:
     enum:
+      - nvidia,tegra114-soctherm
       - nvidia,tegra124-soctherm
       - nvidia,tegra132-soctherm
       - nvidia,tegra210-soctherm
@@ -205,6 +206,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - nvidia,tegra114-soctherm
               - nvidia,tegra124-soctherm
               - nvidia,tegra210-soctherm
     then:
-- 
2.48.1


