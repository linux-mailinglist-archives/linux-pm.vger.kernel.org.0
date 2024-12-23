Return-Path: <linux-pm+bounces-19683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D99FAEDD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FA31882BBB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A0190664;
	Mon, 23 Dec 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv820YsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A41C36;
	Mon, 23 Dec 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734960674; cv=none; b=hf6Ubs2NtWsqlkzxWZJntugXDoflqQ1HDizJtW73w0EtRoBWBpcFZ5kWPN2XXFOJmGcQREJiBrGnwWbry7Run5oF42D1/C+wQkV3bnc0Wgg3RwTPL68s1NLMtzV/R0MODBw5TkxKuOXxvcvzEjnAbXcu2PofgluoZzDzXOv1pJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734960674; c=relaxed/simple;
	bh=o4Fom0Rpm9fWzhbvqugXg9BmbPqo3cs/0znTlLu54ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lJodlWKMB5Mepyk4XiGo7MbR3E0uSPRQWliBL87+BBNjK5RIyVT5yYnxiKJH57LZiF6GpU9AndYJvmT57sEAmOOk0/7CW54oEkiKv3TQw7iVGHMk+tUnk9XdOjHUqhl14EPdabHVWDptGf/TGhU3IxEp9WTeACMTmrMBUM2T19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv820YsL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso8138733a12.0;
        Mon, 23 Dec 2024 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734960671; x=1735565471; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0E20nH4nI7hZl+zQi4Z91y7ffU07fB4nfSqv0rzeH8M=;
        b=Mv820YsLFb0n7fwGqx0v5xeyxAVxuUzVTlNaA2791cjZwwAe0hCkLTEQDAGYygVVKo
         UHqx4EJSEX7c0xP1AWgEWF+fkJbH7ByDVsz4BMaXhoIuaXqvyigE4ps62M8dwM2E34RH
         mnX+vHmc47KHMaz/DirvN6MXEPaAGsov2Db+fwGYWF/LxSSwr5FPXblwuYuN91nvRfuf
         MPsAiId9FGoiz6e9gnMy7NJNqgDqJRu0eAlXTXIXmJzJV3976LllAkWj7GzdMLUpnS/D
         cdTInTHXHW15Eg1itNXEcPWy13WQ63Gf5ax8o2LeYsTVe4NbaitKLNk8pHIZuQML145Q
         nshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734960671; x=1735565471;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0E20nH4nI7hZl+zQi4Z91y7ffU07fB4nfSqv0rzeH8M=;
        b=ql+vuFknkqf797iCvqunC5jObZosJs3Mx3bwxvYN4FaXBPRVp5DATm/vsPr7btqD/9
         yjCc3nXkMfIu2K1YuBRHg9H+F5jT1Me7girutJCuiE6YMGwZlonytXzasa8OpoTmDpP2
         gBPi0xxy+n+Rdy+5k4tcsJ0+7KTARz5zQCQtR3+LOA+VustzdUeGt46gD9/1P0MYLG96
         maCVYPsp5TlCCFrSYdxVWgUayuD20ScZBeo+uYdHMBmN4jDSc6ZWwkj+cst7yNk0ta8I
         N3Oeo2jdY3Hne0RA58p49Y6vlLKMRtQp0pxPApl5K5iOwKTugnnKcu0ttLCIJ/7JTCvD
         z8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVNK+5w+FscIUgu/sJNKSHTXEJlnzLQL/04vGrqFgghI8xHBY/pWEvb4ej/4ecbUwmMJ1FlwYCuiIWDQ0kXAQ==@vger.kernel.org, AJvYcCVXbB9QDvULiwGDMKfHzEfLFdRZRPIyt1n+n0tapABVLKLf8UBNE8kXQCmTHkDiZsEPK4m/PQ9wt/3CgFtg@vger.kernel.org, AJvYcCX7kfCSzPwglVxSGMYeYbvTZu2zejhHcVcoFyBvk8AXVD3IuseFxKAg2jX4qWeCsqdYS/KVS21ZLWe+@vger.kernel.org, AJvYcCXer+nfC234+5+7TP0aVOIepbru+T0KpItVF8BSin0j1rh7N2ZtNtvc3zpIKiw2hGjTbALr9zFZHfwH143GU7tfEwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwueigKNnTJs1l2keB04Z/PL9JUl4/gxUTkOIopY7BMsTYkDnRC
	K8xlrAsa08H8/FW+a8JxX06BZJlq9dB0QVc7zcZ8FKQFcpT8w8yw
X-Gm-Gg: ASbGncv6cbRIKDOApkIuIK6fhosffokuAVdW6yjubT01ef7yl+u2eOSLfQnZ7rWA15D
	rvXiBuJwcOB5VxRCiEYMtwdJ4pDIlg39APeXwQ/PVWFC0B0zBJQNv1XAZFJKXg3PxTA+i97pD1i
	ITX1cXQNqIYM+AJxo+iVuCU5K0XT7uTCbnoiZDQSjM6p9xAYSu7mpSim+0OwACXRTUfK6/qaCl1
	6pCmwjHU2S87WXKitkjkhiWn8BSnyz2eXfvMmlnIlaZKVw9I5tRa43wlX55h9JrqMB3LeJR7wTV
	PDkWrbxaVvc386WVdlU+x8vQRQ==
X-Google-Smtp-Source: AGHT+IFtl3Jc4R8ZM18OiD8T35sINFW2yCCL1hkjUfHrIzuM/MvcGihGAKcF6iZA6+Q/hgFepUAa8g==
X-Received: by 2002:a17:907:96a4:b0:aab:7507:7a94 with SMTP id a640c23a62f3a-aac2ad84badmr1228517466b.16.1734960670508;
        Mon, 23 Dec 2024 05:31:10 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e895502sm523749966b.63.2024.12.23.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:31:10 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v5 0/2] power: supply: max17042: cleanup and more features
Date: Mon, 23 Dec 2024 16:30:38 +0300
Message-Id: <20241223-b4-max17042-v5-0-e4e409723bce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5laWcC/32OzQrCMBAGX6XkbCR/bRpPvod42CSbNmBbaSVUp
 O9uKghVweO3MDP7IBOOESdyKB5kxBSnOPR5lLuCuBb6Bmn0eRPBhOKc1dQq2sHMNVOCGsmq4HQ
 JAZBk4jpiiPPLdjrn3cbpNoz3lzzx9fr2mA9P4pRRg8IyjaVCXR2bDuJl74aOrJ4ktuznD0lkN
 rCyDhp4ZcF+s3LD8i9Wrl3rAD0oAeynq/50VWZr7SpvjJVe+i27LMsT2LeUIloBAAA=
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734960669; l=2342;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=o4Fom0Rpm9fWzhbvqugXg9BmbPqo3cs/0znTlLu54ck=;
 b=f8X4xAir/UsYai9B01gBdXs+JRfS4B/GpHsSQ6bQ+wpNPfRjetFZ6uLzwavBXVG0SW/VerEor
 87W4HwyJbVHB0I2ApwmvSY313JIzXsnoxdlHPVOGMYxp9vDxQqJ8SlI
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
Changes in v5:
- platform version: use parent device of_node as current device.
  This is because mfd driver matches fuel gauge node, and max17042
  platform variant is intended to match a mfd subdevice.
- fix platform version issues.
- Link to v4: https://lore.kernel.org/r/20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com

Changes in v4:
- review fixes.
- Link to v3: https://lore.kernel.org/r/20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com

Changes in v3:
- pass dev pointer to probe
- Link to v2: https://lore.kernel.org/r/20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com

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

 drivers/power/supply/max17042_battery.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
 1 file changed, 142 insertions(+), 58 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241108-b4-max17042-9306fc75afae

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


