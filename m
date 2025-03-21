Return-Path: <linux-pm+bounces-24381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFDA6BDAA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89BE1885942
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE961D6DDC;
	Fri, 21 Mar 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWMe/FjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21E1D5CCC;
	Fri, 21 Mar 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568832; cv=none; b=drNNO0oj8nA0XRqpJFillSoBb7PRhCBFfp4KJmA1VxdfcRWur4uunEhTAoc7YqoAql91cxudIZsOV7NVj18m+Dq4TW3OVpbwh0ovbZxNEvV/MfLpEUSFf2m+PKe61EdUCn82tTWIhD7m6JKL3gk2NVWjAZANF4LSDgMtI9Ar+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568832; c=relaxed/simple;
	bh=tJQaIJvEGpTx7uoe36B2IgtjGJaMYTQGyDS0OxDwzsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg21Uz7fTVwrtluTOHooFjGYmtPgwm6z2SXLtRXP06S0/8Lbng7nRcKztaIr6cKzbfw9SQ+seUpdqaS3EDsNBPzlK35fW6oIu2jrY9S68NsMTqDX/b291g2yPOlhV8V7/vxAPcDaF5f6KvJbo/6Y13k6Fk+OhFqfxtF6mCaWBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWMe/FjV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3712541a12.0;
        Fri, 21 Mar 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568829; x=1743173629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChUt5g7sEmNJxFpJWWSVXorLuRmqgR/VFYSsYvgvkIQ=;
        b=GWMe/FjVK+m7LxlVu9R/kELKbsDjss1Rurf+pCsr58YmyHGbphql/GFDgczmkaUyMz
         MYAnLQY8vAywbfCK5nuE07higqLmSnG+lH27hm+QHVuUpAEl7MJWCREKbVRZlB/chmGo
         q4zuV+sXLxfPF6kjISUSuFkS2EW7e5EfczNk5PMW94jeqtH1aAPvTYmISIDca9XoAq8C
         FPLotSN0+LI/8WuRGR91ZrsslxTkYXeb4yQAmK9Er8GPsrZYEpuoHpYaWVtqbb2SKVzM
         na5pasQRccDKrZOFEznqIO1ie6DWMoj40czVJmStngcPtpMT7xkpRU66jxbhwaUmiyw+
         wD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568829; x=1743173629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChUt5g7sEmNJxFpJWWSVXorLuRmqgR/VFYSsYvgvkIQ=;
        b=H7DhyxVBQa5CFGTmky1YY6Ea2krhRMvJCgaBr+SE/Gf9Q29djdYCW0XtQiNk/tIQWx
         qLTwgYOGMVJkQn0Hcb7ks76Yo0M0gjoSVB0mEcjGgpYwVndzqLyfHBRpfPBAJs0hWnh/
         LRcWmKtYmtQyP3zUpACrJryio9GWykEo8nzPmjmiUvqAHEy6gbsA91AZLvcySdDrub/B
         RIfU4MYIgm7pc8RbwGMYp5SCxgSwkoWOiCeFkVe4Ilt7T1HJ+MrTpfdFUh3piFlFS4nb
         WVOgYxIF+2tO+glCLYSyZX8VUFN5blQ8VlnOmpLKwF3DwxtYpl7ol1q/0R3KqYNCL+1m
         +PPA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJpMML3nYO47lpd3msBDdrM+fCdwRaXVmrz0QLN5dl/5owkt9C0OY2mas+TVIX14uTvn3ZR4fJhiHIiqB@vger.kernel.org, AJvYcCVnIuFvId0Q+SFsv6+mEw12bMByvzB7S+vjb3lNeVXduojhtPBzs9x4k8rY/FPxMyWEIDoaGlWAEHjtnzc=@vger.kernel.org, AJvYcCXpHKTXrhAXJbztAzIDaxUZsrRJDWHvOVKOMpymY/g37ClzQFZqEQcK2whYhAZSAR2gt1i+IhC4yxUo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wT/hmiG9s6cXBgkSlFKBiaF4XuVIwAvfpojpjvF/h2rUmcYH
	g2TlzrXeyYbB858TAc4xO4v1sk6u6v4vu3hWTzSEb59/vIhgIki53nbkvw==
X-Gm-Gg: ASbGncvC1IshbZsFFrETW92wGLBd9gusx/swTuG0RphH5bQPjyPXjThklXNZbnQXilq
	P1f4r9ZbnyUnsK9rF9RRH3BEynFhddhw/vLE/rs74zZcrIjQfA8sVLxYs8QSyPRiAG22wPhJV/d
	mrO3fSQjMO0Bj5WnFiVQZhM6L88G2tm5Dq7dMFjClxqf8So9fv8xlHodQyUk4QlgmG3qHhqWiFo
	dKhExQDrb+mMvkbWU0mcg6Efs+reu/8+xvtba0svkJmyrBc2n1NPcB8uLTYFFT81kgSSx72mJJC
	eQmVWREcHwF+v96MhDPHbMb1pm8/phibhtJL
X-Google-Smtp-Source: AGHT+IGsI9/Y4lZbu5RbXukOyzO+Xa93YyElGT/2zT0CcERymtAFucBxgAiQ6soKIwQ8+tziVD8/rw==
X-Received: by 2002:a17:907:7f24:b0:ac3:3cff:268 with SMTP id a640c23a62f3a-ac3f22b2c30mr350924766b.30.1742568828520;
        Fri, 21 Mar 2025 07:53:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:48 -0700 (PDT)
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
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] thermal: tegra: add SOCTHERM support for Tegra114
Date: Fri, 21 Mar 2025 16:53:21 +0200
Message-ID: <20250321145326.113211-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTHERM is thermal sensor and thermal throttling controller found in Tegra
SoC starting from Tegra114. Existing Tegra124 setup is mostly compatible
with Tegra114 and needs only a few slight adjustmets of fuse calibration
process.

Svyatoslav Ryhel (5):
  soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
  dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
    System
  thermal: tegra: soctherm-fuse: parametrize configuration further
  thermal: tegra: add Tegra114 specific SOCTHERM driver
  ARM: tegra: Add SOCTHERM support on Tegra114

 .../thermal/nvidia,tegra124-soctherm.yaml     |   2 +
 arch/arm/boot/dts/nvidia/tegra114.dtsi        | 204 +++++++++++++++++
 drivers/soc/tegra/fuse/fuse-tegra30.c         | 122 ++++++++++
 drivers/thermal/tegra/Makefile                |   1 +
 drivers/thermal/tegra/soctherm-fuse.c         |  33 ++-
 drivers/thermal/tegra/soctherm.c              |   6 +
 drivers/thermal/tegra/soctherm.h              |  17 +-
 drivers/thermal/tegra/tegra114-soctherm.c     | 213 ++++++++++++++++++
 drivers/thermal/tegra/tegra124-soctherm.c     |   8 +
 drivers/thermal/tegra/tegra132-soctherm.c     |   8 +
 drivers/thermal/tegra/tegra210-soctherm.c     |   8 +
 11 files changed, 611 insertions(+), 11 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c

-- 
2.43.0


