Return-Path: <linux-pm+bounces-8310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEED8D2648
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503EF1C25FC2
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844CB17B415;
	Tue, 28 May 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEUEogse"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402717A92E
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929098; cv=none; b=SU/5UlPCReGiJ39NBhrBEA1Nmqaf8k08CkuF683cegbV1/RDSyuKN8232Db3RnQfw08iwKzCkKo9p1uhsduTEtXsQ7lBN9gNyQEKai4i6egTXYcTbB/kDJSqwqrO0gy4jxjuP3g1OgHrmJ2PIOfgxEB6YDDT9XnQrrzCpAbYSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929098; c=relaxed/simple;
	bh=Ort2/caZVUYwVthaQyqzi46Ex/gklHG9yBV76k5aP2E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eyMl2u5qYVsKpDPM0oZ14k6Msr8sM1siWL8XuPMNTWKSGKvSIuLbuwo9BcZKlyKLOJtF1wDbRDC7R7tDG+7RcmogVjSdz7mFd1yYpvBu/mnamB5chsKwDuMYCV0NHsEkvtO6GofVP0RpE4WKOyhCcY7cSoOb82zo9gU4CdK/GZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEUEogse; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso14089121fa.2
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929094; x=1717533894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzZhxdvPLE6mLIqgxvohaJdPdDCKtRQaOpGQeC6Iw60=;
        b=gEUEogse2a6pvTcim852+up1CtuqHIkXK+kjmSoP6JVYMjb5mkSqGJa/xzJ0JzeKbv
         toDO6kOxMj6BEfIlyK0tsC7o/KSdmdS6bpj0XPs3lJygFVXR50CUa57WsSVp5Yq8/O9D
         268VGqiZQFWvhSdf9Km5gVaIInu3KjDn/K54eIsARffpVzU+ngIPYUMiLEQ/r6y3gaIp
         88JNhNEI11UX9RWjwepKEFOR/4Jl2QwoZmoHcnVqLng2iE1Wu5p5Zr807MbQUoivPZfE
         Q09vtSTDuehhGoAE6B99XfM95TuR/kdkNEhWniDaxn/F6I62d+vs/y5BSfpe4DARM6QH
         4Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929094; x=1717533894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzZhxdvPLE6mLIqgxvohaJdPdDCKtRQaOpGQeC6Iw60=;
        b=v0nnHb/3kGSoRf+n0ZK2AkY5x9bg+eBxFNIaWk8sOnT5EO0NLQ8djMK/iI8Rxv2tJm
         gACc8OxNbKDvbz8hKwQaKwj1S7fk+atcAqZSgZzLvemPfN/br9nkN+XsefCzn3gj0fUO
         DdYuqbaKfhyDMMXL37B+yHyu2F2NFT/8ffJW5ddx24bfCmZ+FieOCfSacFgXrRHf3JWb
         dFzNyOKXLkoyOB2DvglWP6PiKasqGtlao5JJ5fF6ChTjslskKfvNpmkdynA+770saf7T
         PfHj5bPcloLoLdXcZJBGetOoSiTuaXD9uUMC5OqbUuHPNqFe2d2Gg7wY7YbJIhEoylUN
         wSug==
X-Gm-Message-State: AOJu0Yyg68roxDLSPHpLFTINgtRZsfkKjBub695HJiHCuCvWPFUPlIF4
	PvVB9WU+oEYNBG3cbUOcJ6/Sa3uIhHoxRcWIw0rJ0Qi6SlNFBC9Odnsdr4vbBkVLrCnP+9LU/Uc
	S
X-Google-Smtp-Source: AGHT+IFTNyH3pP9dDhWyNzNcnITON78FAZ8IwLzhdnouwqB9V1tT8j4dkc1idJoVA0AlJzFnYtxDBQ==
X-Received: by 2002:a2e:8ec4:0:b0:2e9:87f7:caa with SMTP id 38308e7fff4ca-2e987f70d11mr17203611fa.41.1716929094332;
        Tue, 28 May 2024 13:44:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdcd21esm22759431fa.100.2024.05.28.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:44:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/6] power: supply: Lenovo Yoga C630 EC
Date: Tue, 28 May 2024 23:44:45 +0300
Message-Id: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1CVmYC/3XOyw6CMBCF4VchXTuktJSLK9/DsKh0gIlKzZQ0E
 sK7CyQmblz+i/PlLCIgEwZxThbBGCmQH7fIT4loBzv2COS2FkqqXBpVwux7C9iCY4rIUBadKzv
 jnMVKbKMXY0fvA7w2W3fsnzANjPbLaKmkyYyqZJ0qpXWuC8jAPWniOb1ZnsNw9/HyoNGyTz33O
 ztQmDzPx82od/zvo6hBglalrSuTOevML9Ws6/oBlMuyoPQAAAA=
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Ort2/caZVUYwVthaQyqzi46Ex/gklHG9yBV76k5aP2E=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1qYk8uBHNmJot+3S8w8Pfc2n7pSvLJijOn0Z+/a3Vxbe
 69z/cnsZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBELC04GFbmyeZrfXbg8/rH
 4Vxkarnt2L6GufafdX93WG6XWvVnloLaVpETV9gk7Xxi3cL1L5ncueqV3rgpZsX3C3qBMt6/Y++
 8P3b3/LPiJpW6EA373ZwvlKvntzT6Pwp8ePTsF8eZ28U4Qu8wFGkKpu2RbBUSXr7tzZbdghZ7c1
 oL39z8x+Os9lDm05XeNO3Uo9rpC+ZtZmQI+99WL8Rx93nvAY6JnWwL5tV8Om8Uc47znv9Zg7pZ3
 jW9P+/VGFf4VzddY+wKenWPz3SB0bVZWXKt56LO/64rTM+1fNOrwf0oK5rX7FDhVtXzu6fO3brj
 tbH02ceHuiQDj+p+aNDZdsDnpLyQ75KtTuUZSg1MvZM6AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

This adds binding, driver and the DT support for the Lenovo Yoga C630
Embedded Controller, to provide battery information.

Support for this EC was implemented by Bjorn, who later could not work
on this driver. I've picked this patchset up and updated it following
the pending review comments.

DisplayPort support is still not a part of this patchset. It uses EC
messages to provide AltMode information rather than implementing
corresponding UCSI commands. However to have a cleaner uAPI story, the
AltMode should be handled via the same Type-C port.

Merge strategy: the driver bits depend on the platform/arm64 patch,
which adds interface for the subdrivers. I'd either ask to get that
patch merged to the immutable branch, which then can be picked up by
power/supply and USB trees or, to make life simpler, ack merging all
driver bits e.g. through USB subsystem (I'm biased here since I plan to
send more cleanups for the UCSI subsystem, which would otherwise result
in cross-subsystem conflicts).

---
Changes in v4:
- Moved bindings to platform/ to follow example of other Acer Aspire1 EC
  (Nikita Travkin)
- Fixed dt validation for EC interrupt pin (Rob Herring)
- Dropped separate 'scale' property (Oliver Neukum)
- Link to v3: https://lore.kernel.org/r/20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org

Changes in v3:
- Split the driver into core and power supply drivers,
- Added UCSI driver part, handling USB connections,
- Fixed Bjorn's address in DT bindings (Brian Masney)
- Changed power-role for both ports to be "dual" per UCSI
- Link to v2: https://lore.kernel.org/linux-arm-msm/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/

Changes in v2:
- Dropped DP support for now, as the bindings are in process of being
  discussed separately,
- Merged dt patch into the same patchseries,
- Removed the fixed serial number battery property,
- Fixed indentation of dt bindings example,
- Added property: reg and unevaluatedProperties to the connector
  bindings.
- Link to v1: https://lore.kernel.org/linux-arm-msm/20220810035424.2796777-1-bjorn.andersson@linaro.org/

---
Bjorn Andersson (2):
      dt-bindings: platform: Add Lenovo Yoga C630 EC
      arm64: dts: qcom: c630: Add Embedded Controller node

Dmitry Baryshkov (4):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver
      usb: typec: ucsi: add Lenovo Yoga C630 glue driver
      power: supply: lenovo_yoga_c630_battery: add Lenovo C630 driver
      arm64: dts: qcom: sdm845: describe connections of USB/DP port

 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  53 ++-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  75 ++++
 drivers/platform/arm64/Kconfig                     |  14 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 279 ++++++++++++
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/lenovo_yoga_c630_battery.c    | 479 +++++++++++++++++++++
 drivers/usb/typec/ucsi/Kconfig                     |   9 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 189 ++++++++
 include/linux/platform_data/lenovo-yoga-c630.h     |  42 ++
 13 files changed, 1234 insertions(+), 1 deletion(-)
---
base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
change-id: 20240527-yoga-ec-driver-76fd7f5ddae8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


