Return-Path: <linux-pm+bounces-17697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34E9D0DD1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F41F21123
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685A192D80;
	Mon, 18 Nov 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLR5iVoR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB881188A0D;
	Mon, 18 Nov 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924603; cv=none; b=dbbml7qqsVns0vHdTwsYMEVbNrEHdBcUPayLQWE+lGdb1nsEPA5KYuFvU6jSykZBIx/XKDG/UXHTyYR9YM3KlMqDY9kIs97xKM3RZwGvhje05pW7gEOgMgfJ59ZK/eZC0z0hBqPWNOtzozdabG8bCvYf9Zvm8DElvY3QSEUAOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924603; c=relaxed/simple;
	bh=OL7qRLSxG0s/rBjQDcTGXS3wtyvq3ca7DYri+vMk6u4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rRIHpAqAhqK36lCLkPxFQ4o1LWeQeEEEHcVBegiJX32ickI/TbwTgT1QCOCm/MOX2301oSt3rPzWbaVmRZIUXOyR5w51ecfFopM7hz4sisCVmJOizh+vxkz+xcdDBK4b0FbW6U9Et8iO7Ftkm26D0mqdHDz+yGjzO6PzzUKS5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLR5iVoR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e44654ae3so483200166b.1;
        Mon, 18 Nov 2024 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731924600; x=1732529400; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAawXV2Pa4jygEr1LKjVR7SSwvft3mACK3InAoqSWHI=;
        b=LLR5iVoR67yScY5gfqC7Tnt2XqJ8SNLTSS/+PKQszj2LcdchN1JuAlBbSqoj6eeX4X
         JVP9HgRvF+S8+B+4BYyywR+bbK+MtY2+Ht8X0CjMvBTI3kd8d0sOdc+MbJf45O8Fdly2
         7spFtmVcQc46uZPbXv0T7bw4/udxUZ5ToFmR7wlXdG9dEe8ch2SXXOUGLo1L7g8sQaYY
         WZixerFtlPoa9rVovTFIgz4vaLVJ1eMv5uxqJIitQejQSK/gQkn5zEQXrthXDH/1/a0h
         J+lJpfXbh33Th0y2xfSXxxDKoCtE9VqZ1HA5erNwh5Sa1Mi6kPWYjN/kagM8aV7Q9dxV
         ieCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924600; x=1732529400;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAawXV2Pa4jygEr1LKjVR7SSwvft3mACK3InAoqSWHI=;
        b=Kx3vo2lYAMV6OUO4vqZjnXNTfrYiDHLVk6sxux2DJhLkLLwM2ipRnVlOL5tghpbQGn
         Xjqx21lX6LFEruGgj1YCqY4Sx/Z5v8eNu5HaiTf9whEr//IXIrRv9JZn7VSOibj35Umk
         h/hpB6DHwEKA2o1fYNqqGaM6qx2DhLqdJbUttEo3tCAyJ5rjWX7diZ7T+RjO8wQur5lB
         5E1odCg1zV/WpeZ/j05mvlUMWo43W623nNfEXG7bLd6urmU6lnkgc78goKydVqEkzdiw
         nqKCvqV4kzsgoYikrLi/uYaqMZHIJzfzuSyqVi8A5J61aHcJyZB42FTPq4s7xTT8Kbv8
         RTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/3JAfoUd1X6x8Wk2aEHJe42NCnMWSc2jgDJBCb9vKmlZ9raYVSFRlL/o83ehgjCNVMcUiBAOjyIM@vger.kernel.org, AJvYcCUsXrK2imjUtHFfcl7wLyeEFGulWTLoSsBh5PkQ+x8b6vWTYZ6WPGP7ZbC0VkvAVoDRMH2lRXmU7L7s2nOy@vger.kernel.org, AJvYcCUu1Rxlo8EuYA8c/VdmkQnDn7HsmtC2+4ttQzd3qEzHISlaCpK5x2msXE2X00RKCzomFposxTPsBQ78axcOeYYFhLs=@vger.kernel.org, AJvYcCWlZURFKwL/3qjDKAaBHDJf6i6YtKepZq/kNaE7qbhPR7rQ/m86kZ9Xihg4siRMvhpez1iS1s6ONX7mASp1wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Tmv5UIVv4uwQv9cbG3TFWAdGpQXRlYp93plmWRRm9N2NMx2r
	gMz94xfvdAcisxXQI0WPvEUJZHwtShiA9WNLcmI9+7SzPGQzH1DrHW7zrQ==
X-Google-Smtp-Source: AGHT+IEV887fK4x/zoQ5oGZPDlKSshxiegqGbDkMZtPnNY8t6w/dixHiVJbN2cH6q6ldqdSmIyhyEw==
X-Received: by 2002:a17:906:dc8f:b0:a9a:3e33:8d9e with SMTP id a640c23a62f3a-aa48344ea5dmr1000913666b.28.1731924599829;
        Mon, 18 Nov 2024 02:09:59 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20e046932sm518546366b.170.2024.11.18.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:09:59 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v3 0/2] power: supply: max17042: cleanup and more features
Date: Mon, 18 Nov 2024 13:09:52 +0300
Message-Id: <20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHESO2cC/1WOywqDMBBFf0Vm3ZRJjEa76n+ULhI70UB9kJRgE
 f+9USjo8lw4h7tAIO8owC1bwFN0wY1DgvySQdPpoSXmXolBoJCcY8WMZL2euUIpWJ1jaRtVaKs
 JkjF5sm7ea49n4s6Fz+i/ezzybf136lMncoasJmFQUSFJlfe21+59bcYetk4UR/f8IYrkWiwqq
 zQvjTZHd13XH+7E4pfiAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731924598; l=1807;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=OL7qRLSxG0s/rBjQDcTGXS3wtyvq3ca7DYri+vMk6u4=;
 b=7jEvmdQJh8PUUcsHhePFwT0jY9Q7oH7hRJfOSJ5ZhmxOfSk4LVTGVseM/tab168KyDJjGuEed
 k65kLp7lcysAceAGTYo5Hq9iJlKoLIzaeBx9AQ5SHr4LoG3fom71zkS
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

 drivers/power/supply/max17042_battery.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 91 insertions(+), 32 deletions(-)
---
base-commit: ae58226b89ac0cffa05ba7357733776542e40216
change-id: 20241108-b4-max17042-9306fc75afae

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


