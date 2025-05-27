Return-Path: <linux-pm+bounces-27694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B635BAC5C79
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462C19E6562
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F921325F;
	Tue, 27 May 2025 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3deWB9V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DF20E00C;
	Tue, 27 May 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382791; cv=none; b=QytpBA34LdupieunBokX/x2D5UvdtpJxzK3sgu1X0sbjkJNQTnwzCUBtAItkr57mNiHk056cuhTMRkn+oRQWVQ+mRnA4MQ73rfjOsCbGev2yrhkJZVOpd8egvauK+zVBiZy5P6+zhp8CTXDnBVCtsavZl6egTzT/V9xcEnF7dYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382791; c=relaxed/simple;
	bh=XkFISfUdjqrV2y5wMsuc+Coh3gnjR6dBVlXPP2rovOo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IahcjTgfLNIq4e99plM7/uwE6W00erNgmJ8dkyQtW7v07eV8uVoe9Pqxm86xbAfAZJxP7F+7WPY+QwEMJMsPCSpx2OAdihgz3XwWqvsNDtPviIzJQcmLm959Uu0TtNZHRahTUCF/A6YOwWRlrelCFgfJIWFbgArmUius6bMIg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3deWB9V; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so35013915e9.0;
        Tue, 27 May 2025 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382788; x=1748987588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qeTtCVvzQ3HFi7OkLo2uFwxYAnFBLVehN2xVIJJWLe0=;
        b=G3deWB9VE9OmoxkEyji+Te4VxnSAzdxExVFbibYc0Ur1pTkXkUa9srv51x4q9vx8bE
         OFGTksQ7chu1GWFnhc0YLJS9yzSlNRVf4j1WbRT3wqy8OrIWDcz4MM0MJrvBWNR7iWpQ
         vmhw0ZqWbT4sHBpaP0110fXavMpSfd5LPnRNmxtiNQVWeAOrkGIswvKb03b5c2a14NZP
         IqGt00ZAUJ0J86kp6xw+D1fM76gpzya91h45uBLIvSfv4PIEnnQSvzuf8vtxnHv2mZea
         igPUSSa/QPMMEli10ExYYC14ksQ2W+S+/0GEGHAcgStaNCrgeZ+g0sgutosX7PLs28sm
         gOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382788; x=1748987588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeTtCVvzQ3HFi7OkLo2uFwxYAnFBLVehN2xVIJJWLe0=;
        b=uIHwqC4LkYOEFkuj3cS8R53dJQLRnb5MX+h24OSNPzu/j9x1ID1vp0Fq3TOxAF2F3/
         hM1jKSqlLD+RJdKFg7fXp2tXDsRlGBbEHn/DLiXIE+qLDa4JGWRBkX6YnP/Uj0ym4eMo
         tculUlgXLi4j3uDQQcRHyKVKEmx1tvduw7ZO9eKOXqGaqUvdCQl/8/poT8qcb5ud/Cj8
         TyQOPDpCh7HVq4J+jzLE2BxPDPftUjLFgedIzlbq91vekROj60QsxmFVKOvqqJQBN/de
         soqe70ZwZ2ZdbRLM3bZzplzRu8Tnnnjfff/MS3YlV1jaV12hlnFEdDc4IctcrVZ013fK
         fUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Bo4wxwmlfktsCWB3qFgbg+rrXrkFww9MjzdPDHroL4+Uiudccvk2DtRCm26hmIDpeBy/wGZRHw4/@vger.kernel.org, AJvYcCXBWSUUR3iZwQnhaKuM/wCFI6LFMDmSY2PR57vQXagiyybZiGslgFad5zH1vexwzUjWbIcguz8NJ2g8XPwh@vger.kernel.org, AJvYcCXBgvP/X1EWSWYGSGJfP1AZ6Hgzcz1/P4EpWaS6aflKXwTIZ1gxZM+ooVYsl3PaAb5DdAWSPrXFOl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rwV9WpwkgRDnMqXVovzcvo8VLt6RJfAdxN5L525CG5+P/nbE
	QB38P5XN3aT+HfuzlQEzeWQxlqWRISEcr+pPpw3OX9bJJgU9LcWSArp4
X-Gm-Gg: ASbGncuu0ZIE1PtB6VJSdcq5GQ5LFQD+EehTHqidn0xRtLa3yhdaae70oMBe/6uXwz/
	DXbuCQSlOnR6hQWgvmppa3dCztE+MY4NtE5ET+97WmPcMkhTWgmyCkXYyJzABjrcslY/0xYMWiX
	4yTrJGUTeDNgpME6qmfy2h2wCbaB9p/mWznma0C2HDc0XHpDI4DM+PqsJltHttEaNznw2rxKT9D
	ilyCFcNjRPrlDFYSGdU2BzWZhOObjuqSMuEsJiJOR4nocbrWVWGnXfi4c3iB0mIFJJIJV4mN7Jx
	vV0xxGezNmr2Jd3DxREYCi8Cnt/PoxpQdp2e+qQL1mTlSg6rAP6ef7/aODlHRkeWcx7yfQ/yaNn
	fP4PkZBSD3GzpboTr3886
X-Google-Smtp-Source: AGHT+IHL8btJjiyzKdzb+hh88Z22CPpr3Q8/nb58lGqaGS8W40EiUzAvVYd9UnxoX3LXS9YW6sbhJg==
X-Received: by 2002:a05:6000:430b:b0:3a4:d13b:4aaa with SMTP id ffacd0b85a97d-3a4d13b4c6emr10611640f8f.5.1748382787816;
        Tue, 27 May 2025 14:53:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b8dcdasm206656f8f.11.2025.05.27.14.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:53:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] thermal/drivers: airoha: Add support for AN7583
Date: Tue, 27 May 2025 23:52:34 +0200
Message-ID: <20250527215241.25767-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Also this driver will live under the Chip SCU regmap
entirely under a syscon hence the yaml schema
change to reject reg properties.

Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (5):
  thermal: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: thermal: Document Airoha AN7583 support
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../thermal/airoha,an7583-thermal.yaml        |  31 ++
 drivers/thermal/airoha_thermal.c              | 368 +++++++++++++++---
 2 files changed, 335 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,an7583-thermal.yaml

-- 
2.48.1


