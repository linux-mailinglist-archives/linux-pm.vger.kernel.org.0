Return-Path: <linux-pm+bounces-10195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD491C02F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 16:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0842E1F221CB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD051BE843;
	Fri, 28 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="PbX8PuGt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA681E889;
	Fri, 28 Jun 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583312; cv=none; b=jdXn1X+hmctfMgWb5yCpOYi1qMuQhJ8WTFZ8YeMNd3GldWXoudIxGONueN5RmLP+I7aclTHEQY3ggFjki5/Gca2CMbvJg+NeGKcHgJBYIX7ZQ1/TnfK5jA3foRj+IPyoEaWyqjtcxvUzA4tVgWqVu6km9CBZ0AD5OddWyb5ZeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583312; c=relaxed/simple;
	bh=bOWYB1J8TNIV/bbNiX30Iz/lkPJuBYhCSi2Z+Wuxuk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sd3JIasXCwqBBoWU9uit9suSACf52JYi2DzYWgOUXDGB+Kicc9ffJMRP+yvVt2c7vP4WMrBAJ8/h5hi3We/oVDNLotoc7vV9cbhBvzF4n4FhQGLas5N1a9PIbSllHvNBcu58zcVZ7lKYGbqIx+FTg43eaSHtzklXFrFKzzr82zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=PbX8PuGt; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2492F3.dsl.pool.telekom.hu [188.36.146.243])
	by mail.mainlining.org (Postfix) with ESMTPSA id 96E24E44E7;
	Fri, 28 Jun 2024 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1719583307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5xJUu2go+fHgUDqngjEjlvae6tDQ/groZ0ukDvoro1U=;
	b=PbX8PuGtmcxP3qlvxTShVKh/GMWFXUa+YR9EVXPeNU+9BnmZtPb8vXByKDm00H7LQP5gNN
	gV02SSKJ1nSDiJBprtGifR0XaO3lNlYWAj6WQfPm5sUIR827CIdp9h81AWphkHbrGKQK/D
	9Oq+Buos7w5sV72Lxm1cdQSn5UKeiUz0tu7DjSgSFCC30CymQOy6Rf8v4lGwqUN6AjcZc6
	UdYvaU8EPNxUSan+yS6DDRQ81SVxj3CHZGAWkW9HCP6eVL0UQG5qcao31F126o7ZiiZymB
	1gxLSMHInq5ILZG/GkNBadZrZeKF3As65YTTf6NBKtQEaDO0S/0a93LASDjJkg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v3 0/2] Add interconnect driver for MSM8953/SDM450/SDM632
Date: Fri, 28 Jun 2024 16:01:43 +0200
Message-Id: <20240628-msm8953-interconnect-v3-0-a70d582182dc@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEfCfmYC/3XNQQrCMBCF4auUrI0kk7S2rryHuEjSsR2wiSSlK
 KV3Ny0Igrr8H8w3M0sYCRM7FjOLOFGi4HOoXcFcb3yHnNrcDARoUUHJhzTUTak4+RGjC96jGzk
 K5TRaqFtRsnx6j3ilx8aeL7l7SmOIz+3LJNf1DVa/wUlywRGtkgZASStOgyF/I0++24fYsVWd4
 FM6/JEgS1Y3Wpgaja2aL2lZlhfKeTU5BwEAAA==
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0

This patch series add interconnect driver for MSM8953/SDM450/SDM632
based devices.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v3:
- Remove unused msm8953_pcnoc_bus_clocks. 
- Link to v2: https://lore.kernel.org/r/20240627-msm8953-interconnect-v2-0-b4940a8eab69@mainlining.org

Changes in v2:
- Make nodes const pointers.
- Fix schema issues addressed by reviews.
- Link to v1: https://lore.kernel.org/r/20240626-msm8953-interconnect-v1-0-eeb31a2231b0@mainlining.org

---
Vladimir Lypak (2):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC
      interconnect: qcom: Add MSM8953 driver

 .../bindings/interconnect/qcom,msm8953.yaml        |  101 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/msm8953.c                | 1321 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8953.h    |   93 ++
 5 files changed, 1526 insertions(+)
---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240625-msm8953-interconnect-e03c4eb28d05

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


