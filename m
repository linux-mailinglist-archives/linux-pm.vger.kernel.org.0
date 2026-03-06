Return-Path: <linux-pm+bounces-43814-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL3aH9/XqmnmXgEAu9opvQ
	(envelope-from <linux-pm+bounces-43814-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:34:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B8221BBE
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 281963016EE6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C03002B9;
	Fri,  6 Mar 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0+11BaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24682F9D83
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804058; cv=none; b=WEl0tfh7Ny4kPhbPEUxFxiMwFth1Vs+3gF1+7ddexn6Dw5iQyoBifRm1jh+F6xFWwXXQe3syxkmSqq8GMzczdoWl5dMYlu/J2LlYWJ4gVP/V2M8omxaWi+Tp2v1zRZ1Jk5ThmxQaFPohRXCN8EXNryCqq18YtTnU5wrG3pREJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804058; c=relaxed/simple;
	bh=QmVZnymuKZyt+jas88ZdM1RSMSq6eliSCZ7w1JjExYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dy1G0aXiNdCzZ1SPWemxnl57Eo+9hkP+0u7do3cAUKZ7imsbmJOqzbGn84MV+RG/GyPfYdtoNX/Xack+uSWmWJX5WNBCTYO5nt0OvKy3iHb4YVaFy8whOFa/Re4+QZyVDYS9GVj+QLbI/kTwkG8iEmTVvhJJEEhdGZ3++/SzfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0+11BaZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso6359116f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772804054; x=1773408854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xHL/Lpt5xGEmKGDVXqkxWpU21U0hJ9K+23Ta0DfsIv0=;
        b=F0+11BaZ8qBHF2H/cKlbTEPjYC+zLmLRvOE7tfV007hWEmdMYXmydf0JnkG3H3IGX+
         BH4fChB6RPelbTSY4mjiavkOvNFHyEWqTLcjCEU89GNc0ANsZ6997aohUsveQAnv2UfY
         VZKG7wGs9QV4J0mTNyxMxqOgUiDvTuIh5c98VL8FKe4BG3XELH3/fHFSOdwYeLoM5UUN
         fFldh15iRLQlYSsX6Vl+rjUj2o14Ro0qTk6bhmJtuYPoG7krpy8eFPVGQoXGUVfZaOZd
         nBu8GviveTKThgUI1Sd6u9kwLMWKRotLTCTTyxLHrSkKYCQBVPwy8orv6OI9OlBJhIcl
         2Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804054; x=1773408854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHL/Lpt5xGEmKGDVXqkxWpU21U0hJ9K+23Ta0DfsIv0=;
        b=ub6aY3A1o0c6eaJYw7GWB03unnMvvcaJ+HP7Z7qrwLSjgQSjPxjoUuzNZhtxGxQ+w3
         BNFCVBQsZ6ZlI7E3NVuSvLOvONoUHqC1PVas/jKh1QVY/Rzdlrndf0I8GvBGNJRmmDC3
         lc2ptYYdGBn8KRVT6kiIEMfPAbAIwxST06Eoyw30oka3tqtUrSPJm2wwlVT8KFkmPT53
         DZw17vHMKTdHLFst3EeOl0YHs7ZTW7eZjzjVAL3uIPh0Ohbcf6U6JVBGAXDbH/kmvy9l
         l3VXy1KPTBlQz+mRKn+1M9JJsZDNRiuvEUH07VmGMoJT/OPmlm8uIbxV4ES6hIN3+JaR
         tRBw==
X-Forwarded-Encrypted: i=1; AJvYcCUjmSeKNCyA+ucxGRxcm3s/7vS/zJ6mljVJJf0SRro/fqRc/TIsUmAu8eEtgKc1CfDyird88V32SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDj4+WpufE33Jp1M/1ZhFqik/4B5/joATuODBuGGXERUQYCVe
	cGnkM5CQ5Q+qNVuW9z9MfY+ZyqyPsoFRqD7fENyuoqhOdL+FxdE3A97c
X-Gm-Gg: ATEYQzw6Lk6Xy/O1PS8wa7frHZlsWm5sD1inrDE4iSlx2BFHS6j4gcClZeXpjFaiMoP
	DrYrgTSXmTnnFvuXiSK83kprWXu0CBPNQcqMnyrbpWfa6b7F2VqqeU9K2Qt4hNRQGm4kH0ekRAx
	7NEBjRanjtyI3Il/tJfG9+7MtwXBJmPSpjjam7vhW2Bbd9pOee94htMKf8kM691PhPn5BqtFf2U
	ln34U29MMaogouW6pZxaOpvgcMVWGYHSHGgbVhateGMeon6bYXkZUUSkLby+lyJjRJfWm3mWKqD
	2+A1mHC2HE82pM83XH/4qSMCU3Cq7wr5WOZWLcr2kCrjZ9zqhcb5dAiZlqg2EGxbmD3YCMZ1CKs
	hiM20N/gdADIQ6q0IVbFOgt65vITOKYq3dO3abjfZoOXelQ3c/H6vMopISTMqFwhcnNakRw4rC5
	joC4dDc9gBGlYn
X-Received: by 2002:a05:600c:a013:b0:485:17a7:b9cc with SMTP id 5b1f17b1804b1-48526958835mr32628385e9.18.1772804053745;
        Fri, 06 Mar 2026 05:34:13 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm80856735e9.4.2026.03.06.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:34:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 0/6] rtc: max77686: convert to i2c_new_ancillary_device
Date: Fri,  6 Mar 2026 15:33:45 +0200
Message-ID: <20260306133351.31589-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B2B8221BBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43814-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Convert RTC I2C device creation from devm_i2c_new_dummy_device() to
i2c_new_ancillary_device() to enable the use of a device tree-specified
RTC address instead of a hardcoded value. If the device tree does not
provide an address, use hardcoded values as a fallback.

This addresses an issue with the MAX77663 PMIC, which can have the RTC at
different I2C positions (either 0x48, like the MAX77714, or 0x68, like
the MAX77620). The MAX77620 value is used as the default. The I2C position
of the MAX77663 is factory-set and cannot be detected from the chip
itself.

I have tested this patch on LG Optimus Vu P895 with max77663 PMIC and
non-default RTC position. RTC is registered correctly.

---
Changes in v3
- max77620 files converted to DT schema.

Changes in v2
- dropped patch that changes max77686 and adjusted max77620 where max77663
  is described.
---

Svyatoslav Ryhel (6):
  regulator: dt-binding: regulator-max77620: convert to DT schema
  dt-binding: pinctrl: pinctrl-max77620: convert to DT schema
  dt-bindings: gpio: trivial-gpio: remove max77620 compatible
  dt-bindings: mfd: max77620: convert to DT schema
  dt-bindings: mfd: max77620: document optional RTC address for MAX77663
  rtc: max77686: convert to i2c_new_ancillary_device

 .../bindings/gpio/trivial-gpio.yaml           |   2 -
 .../devicetree/bindings/mfd/max77620.txt      | 162 -------
 .../bindings/mfd/maxim,max77620.yaml          | 442 ++++++++++++++++++
 .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 ++++
 .../bindings/pinctrl/pinctrl-max77620.txt     | 127 -----
 .../regulator/maxim,max77620-regulator.yaml   |  99 ++++
 .../bindings/regulator/regulator-max77620.txt | 222 ---------
 .../bindings/thermal/max77620_thermal.txt     |  70 ---
 drivers/rtc/rtc-max77686.c                    |  14 +-
 9 files changed, 650 insertions(+), 585 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt

-- 
2.51.0


