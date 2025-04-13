Return-Path: <linux-pm+bounces-25326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A497A871BA
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6608517534A
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DA01A01CC;
	Sun, 13 Apr 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNsRv5u0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAB4503B;
	Sun, 13 Apr 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542657; cv=none; b=RHzrj5Z01eihBaTA+nFDopRGwCUyBkCNzIvtJMQ+/+n7PUif6TeaoOHIyArOxsWj+/hIfdZupB/1ATrJUjIaYvu4O4PK+jjyTXMHEtR3yy9I2Hy3wu50ZqfJ0F8DZeX6nMA7OU5GmTo3mociGbmSzDdz4V5Lq3JDCgWjc6DW7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542657; c=relaxed/simple;
	bh=shKwtuRWOwVuhX7nJ1VVirTbPVO+qCucGtBLaD2uN54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpRz39DRrV+sFFJprrzeTdJnGzM60i88zG96QmL+Ua8bHL7A8fPqg4wGbkCL6HOnCbu9YLN0MPpJHbw2+dXkzxQwXtLPYMMCLvy2rgMaZajnITPp7SpmKGQcwdc9PtmFF6ad/p8uu95OKGYci5Zpb1gpuZeFoVUjDHRyI1U0s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNsRv5u0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so5742786a12.3;
        Sun, 13 Apr 2025 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542654; x=1745147454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcf3ZlnqzkHWxGOvggdBClD9tWnI/YAQdzz3gSG5sjY=;
        b=kNsRv5u0obKwVxBYeVBIxf7e0ZMqUn2Y7HAu9JoXTSZFsbwRNDmZ3/ygXU0Mcs0keq
         hZ+SeE3c+R8X51x1cavpleEdlz4oN39kSZO0Zhr5UtF3HZyRThtxCSTxCjNVz9jXPWQu
         MqaHU1/ftlw799Nc1Xj0JHk7kxtspEpROqWCBj17xl7cbNXS3nnl86HccFdbH/JuIFlt
         tzhpAqzSz9XO/E+gb6AOHLFqlk7lNhMEuqj4FsKJx6hav+Q5gE91G9AbkGKfpPGou9Gk
         V1S82wzQ7ay3DCcE2EmXzjYBbuEg8wXz2Si39/9viZF82rG4Wg9dUzajCH78IFddfnAv
         8vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542654; x=1745147454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcf3ZlnqzkHWxGOvggdBClD9tWnI/YAQdzz3gSG5sjY=;
        b=VG+2VAhzZw9hVSNzhY3g/hxcx1zOBU4Wb6JBCIz/qcG1b/wAquUcIOXdE3chcns6VW
         vyK/tP2q5O2/WQRNdWupAbfkQMLNhsLAuoSIfz2zrkZOSChII77QQ+Xgx5mAUrGj+hEd
         /GKlx8K5pwgIAyGGebBILrdjaoiqzmr++XBcc82wXThoOSMacmAWgMoxoNDs4/scWIas
         kj/hieuWoemKbxNy2Lbj7tmzPicezd/Wygg52MpxlZHz5iDLtXshOgUcNv/IQ8Xy02xV
         s/GtfsR+kpXY5xGQTmeMaijt+mR0VxtIEFBSSLO3AgmqqfvovTz1558g3JUxwTlYmwmy
         1OtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmvVr7ywLbq+yAp07MiewEVa/R2lXH83rbawAtP7L/NEBoMP4ElLSl6gaS1bvRDi7DtnBdXoCsy8C8tfZM@vger.kernel.org, AJvYcCWP0xu2unhNUWesu5hieK4Iw3MTqx8h/tOhSBQMOqQ+oa/2wwf9ib5hvDfSo9BBAObWu1QTNNCi3ZE6J6A=@vger.kernel.org, AJvYcCX3pQTusJiZ83wR7Az5UxRTXwNhjdHl73PgHz6ZDD8aMVv7fj10rrLe/Dz9+zrXrt1MOAiIbK9fFCg0@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpmNK5DPSGAbKnoAE/iwuSI6LvoaambeQ1jBuriylCrZBf7+r
	CG0QKFOjlV+KwgQoIU5VIULUCDlau0LrRwI4JRppv9zIyFUA7lWM
X-Gm-Gg: ASbGncts38VlaG0Nx0lViNdSpi+ZXrETiGXguePNYxFAbGE+ktnsrp/w+M8I7CfTpwo
	BZ43f6jazkf8pPs1OKaD4o80ZtyV553Gg2b+kCexrYfkzx//naQ0YX4EemW7m/oYtjD9aqBTy6x
	vIg+p2skvHDDWFVkZdyvTBZPRylqGjcaoL6bSakv4s+3OhdR7VJThSPsv1P+r0Wia2Vt5YrTXrR
	7pX74LyJmGtgyS6LmoiOtxBc26yuoAHJGfhf4y7Kin5HRbJZi5S9xS0dhQgu1npF3MlHnfzGqfn
	cnMTgpcsxWnkTcywNe3IApMK62JEZPDW
X-Google-Smtp-Source: AGHT+IGKfEU3UPmw1OGPxln3hVIVkdOwAD7uGiyhhnTT/J4PdK/mNLgEZSe+9QpsBbpaemUGcjuPTA==
X-Received: by 2002:a17:907:96a6:b0:aca:cda4:9aae with SMTP id a640c23a62f3a-acad3584f59mr647353666b.37.1744542653492;
        Sun, 13 Apr 2025 04:10:53 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm728571266b.59.2025.04.13.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 04:10:53 -0700 (PDT)
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
Subject: [PATCH v2 0/4] power: supply: add support for Pegatron Chagall battery
Date: Sun, 13 Apr 2025 14:10:29 +0300
Message-ID: <20250413111033.11408-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pegatron Chagall is an Android tablet utilizing a customized Cypress
CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
single-cell battery and features a dual-color charging LED.

---
Changes in v2:
- removed CG7153AM mentions in code, documentation and commit messages
- moved schema to power/supply
- left only pegatron,chagall compatible, other is dropped
---

Svyatoslav Ryhel (4):
  dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
  dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
  power/supply: Add driver for Pegatron Chagall battery
  ARM: tegra: chagall: Add embedded controller node

 .../power/supply/pegatron,chagall-ec.yaml     |  49 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/nvidia/tegra30-pegatron-chagall.dts   |  16 +
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/chagall-battery.c        | 308 ++++++++++++++++++
 6 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
 create mode 100644 drivers/power/supply/chagall-battery.c

-- 
2.43.0


