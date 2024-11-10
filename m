Return-Path: <linux-pm+bounces-17286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604929C345B
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4AF1C21341
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68A1420DD;
	Sun, 10 Nov 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDqjekhd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AD38FA6;
	Sun, 10 Nov 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731266668; cv=none; b=UMST/be/k90BIP9LL5n7v3Bl/d+ODWY5eAEdDum8IBj62FqBDPtUeRSvxjrrB6Oux43FRqM44crxAl/iB22Ut/CrLqEIUlRJ8lvZmOS9zYoMGy1vgzVUjQu1auWOL921h4jgLAiFqr1xR/OQieVJw0/S27YbFRL4a6a49NuSQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731266668; c=relaxed/simple;
	bh=H1Syh1UcSJ7M8dVuvV3iuTAa8UOyjg7qSAGjvxwMJ7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WvFOQ8OuTtB7OM7kx3G5d1wL3GzS8F4xrhDVNfbv0nVuUps4VqmuaHMV2JZFnI3aB3OJu5TPh+B7pAcDksXRZuuu9eW5MmKsND2tLClkyM6XRx2D0xrGT+OZ4oVBiavm4kXX4ApQ9XQwwswwvyxSEKKMxr6GoQ0tmhCtha2saiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDqjekhd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so545825666b.0;
        Sun, 10 Nov 2024 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731266665; x=1731871465; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpd/1gDMy+CTi0HB/qw5fPz2wxmUKHefEUhB4gCbWCU=;
        b=SDqjekhd6N9xRenRoCl3/FRw4XjvYBozg/KpO9Ie7ksIECzcSaB2xZ2McFyURbfeG4
         KjflKfCpl2AQyHQGsskN2tP+W/ACPzj4zZrR4qa+wKSyIMqsjkepFW1FpbrLMnQKTVyr
         afZMFBPjWU/m8sM4KTk59p2YrIJvgHtaKXRwHKEf6OGW7AfTkFwByZCRW0UdOIL4QG9M
         sxd0CCNzeFirJUmuCa6T2XC8nLGHX1mcgmJZLnUHwZQwNTZOPJLcsHYu6Axgy02BCJ9t
         /7kdqmOtgTuUZ/vytODkYmGUX0rYEif7X5k85DbDHhPCQwmHPzKyDAq19kTlSk3e8jP7
         Mtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731266665; x=1731871465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpd/1gDMy+CTi0HB/qw5fPz2wxmUKHefEUhB4gCbWCU=;
        b=uuMgt9+ajVYrjUFFyn4z/PL5wbBlrGmlIDwVHH+WhukD1Xv8L0SxdcBFKSzoz1v2jG
         AcEsxCF/0iRWsH0OuirQhO7zm1Wqfbzyv2Z7Ex4DlkKAOviTS+/ZhhaHHzTQgSFbgD9s
         N3XyQbHl1WL+XAKMj3bHHuioCT4HuaujuWRWv2AH/H93NEDOhjvVeqiAfKLISWXefUPX
         2tl1dxeOyn5k3w278eUf45SC9kCILHVJU39zx/luTs1Z7btiEEomcI8SFVea0oBjnQwi
         gJx5LxZ0yQcKDqJmdahL4HaI3ub5f6LkKGrpsX4JZ7nuXTZxEIhpgOOo0PjyLf7HnjCM
         eYEg==
X-Forwarded-Encrypted: i=1; AJvYcCUxcyYo20KtWvptUZoEOwpqqG+HdLFhQ6RkGFUCPJ+NR/VXn+EUlu+5QIIWiDoddpa6rMnv8MNnyOKiL8ynaQ==@vger.kernel.org, AJvYcCVLnVC94WsCaow1QxAoap+u5nkO9joloMY7SsXOH9Cg+aNiKIQI/4jCveyWhwhepOtf56W38K13zHUePjqS6bjMzBg=@vger.kernel.org, AJvYcCVqYXt3GeXuINivTYlsgizLkc2driXTHKBa9fwDs018VmQjUnMH+Bh4Zhc8jLvWm4VMOdywsLatvYVd@vger.kernel.org, AJvYcCWfRBzu0do8C2p4nmigaJtF74AYdsWB+7+M5XCe+AZjnP6m29NlDSOBkoESZlhyNOQPrbwgOEfxLi8P4gwY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dy1gYYfeOiubHeW+egbSTO8YwrP0PVRR7qGs8Hrw5DS1Jahf
	abKi5sMWJoULv7oCmPUmFKorO8wevmNHYYtLSIpiTknSA1R9L5ak
X-Google-Smtp-Source: AGHT+IGwg5e/yEHyqFxbzv6x83YEXnH3A7V20G4q4dRQLeeKdzn0HLMK+KtUTjQlb8+OrHuv9q78gg==
X-Received: by 2002:a17:907:2dab:b0:a99:89bd:d84a with SMTP id a640c23a62f3a-a9eeff3786amr1003564366b.25.1731266665135;
        Sun, 10 Nov 2024 11:24:25 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fabesm502497666b.174.2024.11.10.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 11:24:24 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2 0/2] power: supply: max17042: cleanup and more features
Date: Sun, 10 Nov 2024 22:24:14 +0300
Message-Id: <20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4IMWcC/1XMQQ7CIBCF4as0sxYDSIt15T1MFxSHdhIpBgypa
 bi72MSFy/8l79sgYSRMcGk2iJgpUVhqyEMDdjbLhIzutUFyqYTgZzYq5s0qNFeS9SfeOatb4wx
 CfTwjOlp37TbUnim9QnzveBbf9ef0f04WjLMe5cg1tgp1d528ocfRBg9DKeUDk27vvaYAAAA=
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731266662; l=1653;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=H1Syh1UcSJ7M8dVuvV3iuTAa8UOyjg7qSAGjvxwMJ7A=;
 b=CTvVR/zeK0bf1gPQRzeu+eKHLSmULIxA0my7hMX8imFRf4sEhbEdk/kIXs3kXFl0+9AFP9aSq
 OzM08qUtk74DuRPugKgYdS6HsD1UZnzsbT5MYqqiaOuBVougzy8Jg65
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Fuelgauge blocks often are incorporated in bigger chip,
which may use only 1 line for interrupts. Shared-irq
handles that case by requesting irq as shared.

Maxim PMICs may include fuel gauge with additional features, which is
out of single Linux power supply driver scope.

For example, in max77705 PMIC fuelgauge has additional registers,
like IIN_REG, VSYS_REG, ISYS_REG. Those needed to measure PMIC input
current, system voltage and current respectively. Those measurements
cannot be bound to any of fuelgauge properties.

The solution here add and option to use max17042 driver as a MFD
sub device, thus allowing any additional functionality be implemented as
another sub device. This will help to reduce code duplication in MFD
fuel gauge drivers.

Make max17042 interrupt shared, and add platform driver
version.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v2:
- drop NACKed commits
- make shared interrupts unconditionally
- rework descriptions
- add platform driver version
- Link to v1: https://lore.kernel.org/r/20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com

---
Dzmitry Sankouski (2):
      power: supply: max17042: make interrupt shared
      power: supply: max17042: add platform driver variant

 drivers/power/supply/max17042_battery.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 22 deletions(-)
---
base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
change-id: 20241108-b4-max17042-9306fc75afae

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


