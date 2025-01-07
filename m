Return-Path: <linux-pm+bounces-20002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FDA03B23
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 10:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B718852D6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9DD1E2844;
	Tue,  7 Jan 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdlfV79Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8D1E0B7D;
	Tue,  7 Jan 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242308; cv=none; b=UWqgZlZG1QVJa7OJhqEpX4tvMMYPBzQkUm3XqXn+JiBfAW7/4TZNmAGpELLcHLaR7hVz4TszdH4jPkrUW4n+kQ2nllfIgwhuR57HoSzKVdZ5eEZPjKNcL76O86/pjPiUZxnT9ji8EHqQy+nRhNF1ePa1E89u2J7q2cai/gW4OlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242308; c=relaxed/simple;
	bh=wNxScV3swdqLS2kSQnTrWGwVBmGv+k7mN3nS5bD4pig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ci6Yg4OHQC4+3hMlRMAw515g1L5V6TV58uK3HrjGgSSnGhbkVO/xVpQwV/TL16+xEBsm464zIDoYiTX0NRzSuURExnp5DRlVTygGOVVigP9oy8IClkfQQKPUYCwkFqCryFUtOIOPbJ2TbmuQZ7RmyZQSp+jInt2iRsMLWfbsvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdlfV79Q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aab925654d9so2698904866b.2;
        Tue, 07 Jan 2025 01:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736242302; x=1736847102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEVZrcp6sH8kKT4/yJXuIbm9BkC4O+Tbaah14OHvXYw=;
        b=hdlfV79QxjYZWg01dGHcHO4tYjs/+n00y5vOa/f15WHHIPcTzgi0cPG5yWIJzxfW+d
         elP3Ww6NbrqbsedX9xzKRloLpZwZXoTU6jeuZn/2R55jhucBt9HiEcvvBTc03myF71Ab
         dPBofsp0E6AgNJjoXXSgINWx4dpzaPloDMYLZv3L4WmjZA6ufTGCEuH3Wt3ExWOYDrgF
         zCRR82UxonfZZUFSo9tOqMD4C8BnYyGSZ72JV0iY0yhahKyRe0Gg0iw9pmatypuWn3M2
         gTw8ZMu2Ht30k8qms/9zAtVIYcehEKCWkdyDvM+1iTSpW/H8I41XTmU245/pneSjaUrm
         hOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242302; x=1736847102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEVZrcp6sH8kKT4/yJXuIbm9BkC4O+Tbaah14OHvXYw=;
        b=lXZFXj084n9CLIY02ElHEZOoCVstaZibs7nyEpuzwXESoNWuU6CXrdxkJ1VVJis/1f
         419WHtqktb++9vy4t00e8zcy9qxDdny67I7mezDsCF/cjCSvpNQvUnIU1kjb5Gs7mQXS
         Cs/4GqNDurQ3+pmAfdGUppqrnjISMGRc9zqwfoA8aSWgwFgaNAOTQzwND4C62tEjNb6r
         wYv0njSce4OkXrdkEQ9XzZlXw+mHu2n0RNgCDzss7YFZc01mI2EnvIN+C4oAxAFs4YK4
         RMybqMUV8MM68N5kZFDXqOTwOugqgXl0pWscTyzz5mpjL3nfG+/uFog/Lx1tazHZyoa9
         tnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUrLtHR9W/yU2rhHgQkHfIyfluaN4aygzbU3bInMt2Les7nDIBC4sQ0towBsUNIpWlxgAWUcZkNaljGY8qF@vger.kernel.org, AJvYcCWjFVkiP3ABQS9Vgk1YO8p9fXHcTZ2tCwmmTunIH4w99dhuLT+cMxMK7yoRLdMCIDbt/1J5fQlRV0Ic@vger.kernel.org, AJvYcCX/9hAtY1zZYRyrW5L7rGQoDA58mlcuBRAl7dR94URO+u3KQ9VVXMoTclN+9QESlrBsgOWVGtmpYTD+MWCo6w==@vger.kernel.org, AJvYcCXDtiPhe2F7K5yFM5VCKeJEkSsmVWv1KlZjR4jXwJnnlFDO23z1AkIwdSXOrKrw5HqP1yV3mi3peoQZFku5IcT6nKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktNMlMk6RCaCHEf3KcQT/qTxG+evwbi80BNH0E+UBwiQLVbcu
	hjGkP1qouysu0gS2U9lkJMhBPe2Rb2u+L8T8G583GgJcSNWZGbxh
X-Gm-Gg: ASbGnctlfQd676nbag+0qJ+mEy9htwTL919jnrZt6iIwCjNRaE6acYJkVyh7JmPHqC1
	1x9mSj+/PHiTGwqGm4nKeUTHQB/uaeSqN8nx5USanPM7ERI6iOy4LiqL7O7b/tQ0QwdWJs/hg3p
	6iwNTo84U2lgnBOUMN4ig2i38jyC5SYifmJahaW84D+R1WRgmD/12hrAoVt6cu/sPpe4Ed38Fyo
	FHhwAyxbmITPqVwDbV7fJqzOBNYAqqS8G9Omo7WR81UbgMpieBUlhEtA3ajqXeocSRTYHo0bSvt
	e+Au/Ex461gCTReudzWp7+XDFw==
X-Google-Smtp-Source: AGHT+IEVG3G336WmBhvtPtrjSoYbrfPG9f0yBDcuNNv8Va58Y4lKbJL/RINEhKFkS8DMU1all+HtKA==
X-Received: by 2002:a17:907:7f0b:b0:aab:dc3e:1c84 with SMTP id a640c23a62f3a-aac2b0a56b6mr5288197066b.17.1736242301740;
        Tue, 07 Jan 2025 01:31:41 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806feddfasm24976300a12.58.2025.01.07.01.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:31:40 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v6 0/2] power: supply: max17042: cleanup and more features
Date: Tue, 07 Jan 2025 12:31:29 +0300
Message-Id: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHH0fGcC/33OTWrDMBAF4KsErasijf6srnqPksVIGiWCOg52E
 QnBd68cKLVd6PINfO/Ng000FprY2+HBRqplKsOlBftyYPGMlxPxklpmIEBLKToeNO/xJp3QwL0
 SNkdnMCOxJq4j5XJ7tn0cWz6X6WsY78/yKpfrT4/f9FTJBfcEQTgympx9P/VYPl/j0LOlp8Lab
 n+o0GwWpssOpQ0Y9latrNxZteyGiJRQA4o/u/qfXd1s56JN3geVVNpb82sB1NaaZkmTFt6BCpH
 Wdp7nb8tDV4yWAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736242298; l=2494;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=wNxScV3swdqLS2kSQnTrWGwVBmGv+k7mN3nS5bD4pig=;
 b=1JtrugEyOnG9rTV9ipPmn7Dqi8oclWFU4f35ch2Nd9PNVtszt3ORa39p1Fv75jGVZL6bvFqTI
 CLw2ZitS2mYCt3iVQgrh6G9xfg2If1x/LAD7//OYAlHcpoBi2E9VM/P
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
Changes in v6:
- reformat commit messages
- add trailers
- Link to v5: https://lore.kernel.org/r/20241223-b4-max17042-v5-0-e4e409723bce@gmail.com

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
base-commit: 7b4b9bf203da94fbeac75ed3116c84aa03e74578
change-id: 20241108-b4-max17042-9306fc75afae

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


