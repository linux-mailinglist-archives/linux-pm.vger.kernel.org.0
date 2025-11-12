Return-Path: <linux-pm+bounces-37803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260EC51B11
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1080C3A378F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A49303CAE;
	Wed, 12 Nov 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbO2yc3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358422FFFA7
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943349; cv=none; b=kDJHLVRnMc2kL5QiSkter2JNBkzRoNgNPVbS4HhA+dW8P4nV2swDxKpl1gfejbwBF7bYF2RHWcRo0ulkkuAB6aqGDDzEtTcqif8Wt3qfdQAbZG6CxFzM0D/VvX/dyKIlkzbL1m86XCFkhhCeVmROSjR3MfTfwKr/uGDZ+A4g01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943349; c=relaxed/simple;
	bh=5+dyAstf0xhbGIWyYKa5+nXexFcqNXdclmhKrec/Eu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AAM1cdwUDdqm4zqA3ce9tlYIHyPIRCEwUHXoatCy1zyettQNAzmITX1846x53DoAbzKzELGvebzOmRbF5avPkIsSJGV/UzEXOD6JbQHv2KAHZIDTsa1gRwGMgX9AJv15Vu2V7KV0o/pItThjcFw6LXQK9UDdtyEdECE4+qOJ63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WbO2yc3l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c84bf326so55212f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 02:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943344; x=1763548144; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8EF6cBHJBO/Q2isSVRmRC/bblG4Ra8gNeer+nZltPQ=;
        b=WbO2yc3lRp8/JDbrD2HGJpgCLlIrPZ3DBPgY9pPDNxeuHBUFc2KovA/0uTkI4zV4q8
         ZSG1ewVlWw3JWbmFJmbgMWk+dq9FLscTBZL+gJq3ujQyIri/7aP92OffImO7Ab8zSlLw
         i+aeWXXYavknBSb2A+mnWwTaaE0FC546rxmEdb8nFRM/iByjW3K+rC4iskxM/0RApC+W
         49E1Ka9zKeYD3gLf65WfPePi7+woAlLSNn2PwHI6883i/n+vFqvSa5ofPQwIqwYP7N4x
         rTzIuXIl1FZMA5S+bGos//7+ZFVYztQ6ckF0xLFflYfdEs2IFA3Q1IUXuqfhpViLcyT1
         8dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943344; x=1763548144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8EF6cBHJBO/Q2isSVRmRC/bblG4Ra8gNeer+nZltPQ=;
        b=TD/xdYUa9LJENEAXcFJoXO2o+r0FD03Q3BmS+dhKkUiVKl4/IAxC8iYFD5lNb/rZg3
         DH0lZEmZYgnl2EK3Pyb4BJTflam6pi/SnF+39qBiYJ5nJnq4QgEnqfbqWYBvTv/9Wyee
         7xWypZF3sN12Yx37bp5+cOkSk8bJxtr0zxH2A1JZob0cRWaq1LH9recrqJw5n98I0cTc
         P46ksmdn2KDEodfaqJuwaN/+1VWgrx7935tv3naCTLNnEvMzBGoQ3A+rNeCMb/hyFHnG
         H0afE19QF3zHnMJOpf323BPfmDuJxE0x1dhX64gJXAKUZGg9GW3Vb26SSPGEGuU7Sk1z
         YI3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPzh+94hJKfGEee8F9FZx926ZVCCyJXs42YD+IiaxrrPwSPQwjNL1t/zny+BcAT7XeQJoRJMO9Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWgbq94zMrfQ/QRneIvzz+c2Q/ahhhQh1iZ+FvuZ073OsZMve
	0LaUL4Z16M33VxJ58mvgcobWZRgccF3wTRP/vq8vSm8pnZOFGQNoE/ZxNFaYvL59+Jg=
X-Gm-Gg: ASbGnct+Ilxh7VQoSyMRmWKjqHns40WcrfyXTyydlFxTv/X6y0OaKVlPkOysH+hKCaU
	qn79dpPDY9yFmTh46BmV60pmEDvWyj3Tr6icZj29nAMdNjNx3zpPvoh+Be7udUNIoRZOosSQfdn
	DtQZVqETr2yLlhmemzhu4c70YTkUVrV1xmWL/ZbTNY3lzkjTUxZxF6UROTgjTkdYHJralPmRl7Q
	qrTknGF6n7X5fxswN07/7/2rHEUH6DOg03ljUkgxYXhanPPGLICgE4/K2DiEzJi5f4mOfvpRs8a
	15KiTqs4s+03XHBmn291zI1BvHOwIHUsa9g5mtE/2ZHB2Y8W74iLgFfLV0naDjGs1KLpydP3AJw
	lmdsQ0Gq5wHtEgVa4jBMgOaeD9eTiItSgG34YHC34YV8CLtUlGHYsie60We2JdH3nCuGv3x7Jlr
	Mv8ne7O1GhB5Cbg8Hm
X-Google-Smtp-Source: AGHT+IEMmjHlZdR4rkkkBtikr3kREAJzYe3gVzEQY2F/CPNjTW6FIV3Gq5nMQMHGsI7EpVQgzvavzw==
X-Received: by 2002:a05:6000:230e:b0:42b:3746:3b83 with SMTP id ffacd0b85a97d-42b4bdb73bbmr1049650f8f.8.1762943344377;
        Wed, 12 Nov 2025 02:29:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/11] of: Add wrappers to match root node with OF
 device ID tables
Date: Wed, 12 Nov 2025 11:28:45 +0100
Message-Id: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5hFGkC/42NQQrCMBBFr1Jm7UgSYiyuvId0MW0n7YAmkpSgl
 N7dWC/g5sP78N9fIXMSznBpVkhcJEsMFcyhgWGmMDHKWBmMMietlcPeYvT4oGWYfymBcaSF0JK
 zvVfWtdpC3T8Te3nt7ltXeZa8xPTer4r+tv9Yi0aF47lVTLrmYK53CZTiMaYJum3bPr5NAz/DA
 AAA
X-Change-ID: 20251106-b4-of-match-matchine-data-4a64bf046814
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5+dyAstf0xhbGIWyYKa5+nXexFcqNXdclmhKrec/Eu0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFgkKzLKPJ79bhNkhzUMxTf7Rq0m0OFEmF4q
 dnv57GH9wqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhYAAKCRDBN2bmhouD
 18J1EACLN9dO8VHBUsLifJcqZjQO60hgIzWj+1YfL7nCpzD4o/V3Zb9fmbppxoW4A8qBWHFp+9z
 bla89lZvHQZo5Io3ja8lW7quIu9nzOFwt9GGBLMYb+Y4ukJpyT7gnUqW8MSni+LVw0fGpJwzl4c
 khYK2MI/R/M9d8wpqyfT9qS9+54jhVEmCX7oAcfw6fUOJghJ82AjVlioaejmfFriDfgq1AqC7Tt
 tLYC/FxWxmwChwzttO5J6CuIWkPJQQoqWoFeMjSJqgz0In8mhbWxhp1F6NyiLwj1BL9z6dGyTRX
 L7/11go/X9B2H+c37Dx4RMwFJb5p53L1RfJ+cc5Ub1MMcEhPFlxWk7LVM0QTk1T1sIszZNTiSch
 rRf7xEqCdXvr9Fpd+TIK7K7Wm11BCoErJWT6hj0bsWLVtyC3N+y5Pfk/nekv4/4e2hbWTQg3cQf
 MCAmbLzployqG0E87eyUpzn8cC9Zyu9YZs2rc1Mrc4ZHC7AJlaWEAPmoNfpCZVFKErcfVMjy0a8
 PPMvUe1+u/lpKCkXWSD8JfOk+mFkqB8gR2Kh+tMtX6hJHj8J05MZAWwknwQKHYYwAY6QKdUnk3g
 zOhsW95VFgRYFLBwwC+Cz0wjXr5kwLh4U2ZhwY0tRVnLtCw0DWHx6zGGwKRTG/YKbYQjDuv2t7S
 KoMdrL+EsQdcY+Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Drop cpufreq/ti change: not correct.
- Drop soc/qcom/qcom_pd_mapper.c - objections from Dmitry and I think
  better to drop the patch in such case.
- I did not implement feedback for first patch to make the
  of_machine_compatible_match() matching machines in arbitrary nodes,
  because there is no such use case possible and no arguments were provided.
  I also did not use cleanup.h in first patch because existing code
  of_device_get_match_data() does not use it and I prefer uniformity.

- Add Ack/Rb tags.
- Link to v1: https://patch.msgid.link/20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org

Dependency/merging
==================
All patches depend on the first patch, thus everything could go via
Rob's tree with people's acks.

Description
===========
Several drivers duplicate same code for getting reference to the root
node, matching it against 'struct of_device_id' table and getting out
the match data from the table entry.

There is a of_machine_compatible_match() wrapper but it takes array of
strings, which is not suitable for many drivers since they want the
driver data associated with each compatible.

Add two wrappers, similar to existing of_device_get_match_data():
1. of_machine_device_match() doing only matching against 'struct
   of_device_id' and returning bool.
2. of_machine_get_match_data() doing the matching and returning
   associated driver data for found compatible.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      of: Add wrappers to match root node with OF device ID tables
      cpufreq: dt-platdev: Simplify with of_machine_get_match_data()
      cpufreq: mediatek: Simplify with of_machine_get_match_data()
      cpufreq: sun50i: Simplify with of_machine_device_match()
      cpuidle: big_little: Simplify with of_machine_device_match()
      firmware: qcom: scm: Simplify with of_machine_device_match()
      irqchip/atmel-aic: Simplify with of_machine_get_match_data()
      platform: surface: Simplify with of_machine_get_match_data()
      powercap: dtpm: Simplify with of_machine_get_match_data()
      soc: qcom: ubwc: Simplify with of_machine_get_match_data()
      soc: tegra: Simplify with of_machine_device_match()

 drivers/cpufreq/cpufreq-dt-platdev.c               | 15 ++-----
 drivers/cpufreq/mediatek-cpufreq.c                 | 12 +-----
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             | 11 +----
 drivers/cpuidle/cpuidle-big_little.c               | 11 +----
 drivers/firmware/qcom/qcom_scm.c                   | 17 +-------
 drivers/irqchip/irq-atmel-aic-common.c             | 15 ++-----
 drivers/of/base.c                                  | 47 ++++++++++++++++++++++
 .../platform/surface/surface_aggregator_registry.c | 13 +-----
 drivers/powercap/dtpm.c                            | 16 +-------
 drivers/soc/qcom/ubwc_config.c                     | 14 ++-----
 drivers/soc/tegra/common.c                         | 12 +-----
 include/linux/of.h                                 | 13 ++++++
 12 files changed, 79 insertions(+), 117 deletions(-)
---
base-commit: a4ebba34e722123f1c09ce3282e26f052fc8b27f
change-id: 20251106-b4-of-match-matchine-data-4a64bf046814

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


