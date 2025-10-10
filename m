Return-Path: <linux-pm+bounces-35904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204CBCCBCE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B69F74E5BE6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E6287514;
	Fri, 10 Oct 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="aG3Gy6mi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B35262FFC
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095433; cv=none; b=A4rnOVk6IuhyX7vk0qVLQpjDe7PHvLSeH+h+hUXM8WzoP0KdcFi7DfTzYSkvqoFOzozY06AFVxZ4D9OFmVaXj+yMXokMGHdgpMijjROHyHUUbUc9O8ZU6kADM1SVBIlPMF5/EI8w9KQ2OQzoVgdO3VRKzOaxoxXUEDRMfPtlPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095433; c=relaxed/simple;
	bh=H5LgljmnkNjvXD6n5IG7Ap4WWlw3CGfBh7hhGFd2RjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xvl4AgrrhlbrN277bjO0rriieKCcwXAa0+p3Eok7w6WCZzWCVX5G03W9kA3YHQVwuE/ME5B4QImOCt+SzQvEUIS9VYaWM2ZDkWFXjjjEudXBd3iUgJuO6VAFJPslgvIlhXJeOnqFdk6g0r0Ty/50vF/aUd0PMVM+iQVbTLksZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=aG3Gy6mi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so350225366b.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095430; x=1760700230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+WH0817Ps1vnRuu5RpMwf3DsYHgJQPb6FKq+YW7fXM=;
        b=aG3Gy6mievSarLUblY8MnPhoFwA24TWyRie0zu0FDAw72b3CC3USj7pflnz8rmOoi7
         mJcxBfpQanJv0YRDLT+V9CkoIbF7yMt+rBME24l+T8OZkRWhGW5ciFY70rrXo5l5yQZe
         enCfzlLwok9bR9N66/5cwlodlNyvu35wyMiZ74c94v5Hvwem9h3daWgXiWErihs27qMm
         eLGwo8Qi8N9nUtqhKUGQqgEYl1GQe0Vfwiow6YX0UxYznpR9WMno93yOoa8T+urHQbI2
         Xo9hyd5Hv/4BHJwkdUYehe5nZj/nMv62ip/xqGijTdZ0WJ93gYyk55Zlrv22zezcYCLN
         PIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095430; x=1760700230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+WH0817Ps1vnRuu5RpMwf3DsYHgJQPb6FKq+YW7fXM=;
        b=eSLBJnHno/EDSkPKpra/nBd9Fx7+fxiGofCVceLnbqO0hYyuiQBAinf8GRYnWUaTL7
         suNPxQVElF6eWFUJ2Vt4pPJLp9KKgiTB7GZh0/yl79dM+8l7sDeecVg6gr6wcQ2XCTBS
         6f5UmxsjSZYOE5HkxVamAvX8sksCoIEqQlvJFBa9zCtBWqvqJyZRJbyOUx51DmgqICl7
         27G++sxrowkseoZSlx2Ry2SSsnpcWKiN4cIpMQc45zSJyqAS7AjCxYKOOW6OHBAFUe1Q
         NYoqCGgNXeBs9t46INAc5eApGFmcRhWS4vLDnJuRjZiZpmxeRIBk4tlsL3R+60ngYte9
         Ipcg==
X-Forwarded-Encrypted: i=1; AJvYcCUbA0NCb1cDEjTuopKCMtL2nuCrRZYVtqVn6gWXVmYN5+mKL1m4U/CYpGPhaQ65Poss79I9AI0cgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1jgxbmBGE0Ooz7PILMwUspjCPG0UmErVTW0kfcbaWClvIIns
	0AgFMBfFpTKgYh4yFh+ZUJB1uMGDKFZiM/ml8UYImN6bsVDKkfwjBw4Y60eaZHmyZr4=
X-Gm-Gg: ASbGncttR5V3ccLY2SKIuFAupK3K8+lbMgBPOi9HLq3nqX7YlQwfB2aAbfk7C+cpVNE
	MDqr24caNxeN89wKfsU9h+YfTsR5mbbSWV6PQz9CSJjbVp9E6ept9lRJ+nv9N/yVilzzRW+U9l5
	AJdQ4dY5AtY11qJyTGq/5nrlNvEQDOYSXf53MwZxkXC5wfKcIe6vHfPXeWY43CqlqIiXlue2ZPk
	p7GvFROHiE31ZKbH4QzXHhDRdIcr4KLBRmH3tod9WkTU9N/YyMvwGpxROg5FJ5copy4w9voSNMP
	/06I8Gn2FGj/iR7aKOBvSNceMnVcWO4+rudn9JIcRgYYxpXmnXs5gKRDhX3cO/jJk355HUqoHN7
	rP8CmzxpWJZ1b/bR1TlXbpfWBfSvcm+nxbFO+IDrMlYHEOkJY8rq+kjee0BNQTTSOusSAg1PQ9I
	DZpuW6eKdg+1UmHkZFGUoHeUcYSqD0/A==
X-Google-Smtp-Source: AGHT+IGElPVM7npd0iZwM5139p5UTz/fZNApktIfn5kuKF28780Gdo3rcyMkFKGp/gW1Ak6ZBaU1Dw==
X-Received: by 2002:a17:907:86a6:b0:b41:b5df:89bd with SMTP id a640c23a62f3a-b50a9d59b0amr1084043166b.6.1760095430130;
        Fri, 10 Oct 2025 04:23:50 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
Date: Fri, 10 Oct 2025 13:21:58 +0200
Message-Id: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbs6GgC/y2MQQ6CMBBFr9LM2jEtpopsSTyAW8OiUwadRQHbS
 kwId7dRl+//vLdC4iicoFErRF4kyTQWMDsF/uHGO6P0haHSlTXaaCSXMXOY0fUea3s406CptuS
 hKHPkQd7f3A2ulxa63xj5+Srp/H/IJUY/hSC5Uctxb07QbdsHiZxYBowAAAA=
X-Change-ID: 20251010-bat-temp-adc-8539bf0b85bc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=3344;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=H5LgljmnkNjvXD6n5IG7Ap4WWlw3CGfBh7hhGFd2RjQ=;
 b=KqE1fucyVBMu5pDrzDvyF2Qfx4PQfSPiXKQSTi2ahEjUJqOFT2+W5qVs5saLypTG4U/fyL7it
 zKBR8HeuueiAJt0bc/93C0oNwirkBkYPymSh2RKCm0IlwVpMQU3uPIs
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This is an RFC which implements a potential solution to get battery
temperature readings working on for example smartphones with Qualcomm
SoCs.

The solution chosen in downstream Qualcomm kernels is exposing
ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
lookup table ("struct vadc_map_pt") for the specific NTC found in a
device's battery patched to adjust the lookup table.

The high level solution proposed here:
* ADC driver provides temperature channel in (milli)volt as IIO channel
* generic-adc-thermal driver converts voltage to temperature based on
  provided lookup table from DT (driver has one IIO channel input, one
  IIO channel output)
* The fuel gauge driver can use that temperature IIO channel to expose
  battery temperature via the power supply device

Variants/alternatives considered:

1. Do not implement IIO device in generic-adc-thermal

Without an IIO channel and using thermal zone directly it becomes more
difficult. You cannot get thermal zone by reference (e.g.
thermal-sensors = <&foo>;). The function thermal_zone_get_zone_by_name()
exists but lookup by name is kinda clunky. Adding by-phandle support
might be possible but is lots of work. It also doesn't really look like
thermal-sensor is really meant to be used by other drivers. E.g.
there's also no "thermal-sensor-names" property to designate passing
multiple thermal sensors. So I believe IIO is a better fitting API for
this.

2. Expose IIO channel as temperature in ADC driver

This would require passing in the temperature lookup table somehow to
the ADC driver via DT. I think this passes too many details about the
hardware that's connected into the ADC driver. While possible, at least
for Qcom ADC there's no precedent yet.

3. Add temperature-lookup-table as property to simple-battery

Since the NTC is a part of the battery pack, adding a
temperature-lookup-table property to simple-battery would make sense
instead of having this lookup table be standalone in the
generic-adc-thermal node. However being able to re-use the existing code
in generic-adc-thermal lead me to the current proposal.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (6):
      iio: adc: qcom-spmi-adc5: Add battery thermal channels
      dt-bindings: thermal: generic-adc: Document #io-channel-cells
      thermal/drivers/generic-adc: Register as IIO device
      thermal/drivers/generic-adc: Allow probe without TZ registration
      arm64: dts: qcom: pm7250b: Define battery temperature ADC channels
      arm64: dts: qcom: sm7225-fairphone-fp4: Add battery temperature node

 .../bindings/thermal/generic-adc-thermal.yaml      |  4 ++
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 83 ++++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   |  6 ++
 drivers/iio/adc/qcom-vadc-common.c                 | 16 +++++
 drivers/thermal/thermal-generic-adc.c              | 68 ++++++++++++++++--
 include/linux/iio/adc/qcom-vadc-common.h           |  3 +
 7 files changed, 198 insertions(+), 6 deletions(-)
---
base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
change-id: 20251010-bat-temp-adc-8539bf0b85bc

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


