Return-Path: <linux-pm+bounces-9128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED21907FAB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 01:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408BF1C2135A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDF152E0D;
	Thu, 13 Jun 2024 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlgXfjm5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4D14BF8B
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322226; cv=none; b=lQx0A52VBpjVdDVbh7BDiFKd+ts82eI8rBIUSIwAdOGcO25SRPF+1vhvsTP0JCPuzWrTm4GrcCmy8jItT30FzYcjXBjSm/XihTgpOOUBbfi/uRZvur4Wd2HMSNNfBwq8B4dGNz3N/uVl3MpF18yXcV3861meBVRTLxpTU+5qF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322226; c=relaxed/simple;
	bh=bvkmdVPRbAEAAQvqUF2QXsmCf2b50cjIdy/XyZ0RKyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZADl+SdDF2RF8UshF1eUhTnJvlrUDmzBBz9UgT9SYrAaoAk+uhtbM2pdPNpR/cvblPuhptIztcZUgLQCd8b0ZyZ9R6P9y8HGVnxIXUuCUtCbRXPo28WSr2KkQku/CyAdpto58VTjmdAcY/My6d6Y7ItDnVfyPjrpp2vYD5/J8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlgXfjm5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so1939446e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718322223; x=1718927023; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBGMHq9Wh3giz27rRFHu5Pt0hN+wKFfawhzCs9P8HwA=;
        b=xlgXfjm5+8Agh/4ZocDUXDPT/hmAUNVUbFvp1ayLhY376KBVnSbjb/tYR/HAHWRy6P
         uNwP4Hrn6j7LQFQ8UtzRYYYmhGffNuheQL1ytWyBXTr0EYW/GmHeYcs/5AQGvozKpAYT
         +BHew7QqLn4qeGVk9h9BEI3ltZH2OIL/Ug8CoCV5lhSPcV8c1/MtIk57nrDXpeZQpkbO
         9EOzPcNL8haUjO+Jtw3jGd3GdHaS+xuXMk88ClcuocZ2rRKf2rEjxD9bWziIHVNY7mKo
         bY59lreCwD+FraEnN6Xymp3ehF3QxVPGkAjFqkQcwazWnwKy5V6RbOn8nR8gaglskz0g
         5b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718322223; x=1718927023;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBGMHq9Wh3giz27rRFHu5Pt0hN+wKFfawhzCs9P8HwA=;
        b=SQpug+uso20XHB/LtORHMnRW3ONwvGEaRgaEWuGniFTK/lgJiFVOgwlboSIzW5nD69
         8iFWMkTfo1jBjsTVS7cii0x5nLYSx1aSh1PaK54qx/Lg2z0O1Xr440YeXFWc13qDjjYp
         07iMfh23LuLZY+GVlj5qGvrHoQOPXnon2AUsbXmvY5iQp6x4x/J0wu8C0weZQ0QC7ZVt
         0XKCMY9nWsQerAwUawX7maLM5ijQDP+kYaZiNemC0pnAmmF2sa17fu9jHWo0iWDnU7KM
         JMnXEXp1iEWxVg57WQ/q0n5apPVMuHHXWrt2BEk+mkwWyIJYk5OIEd9eeNer8+z6fdnW
         pm4w==
X-Gm-Message-State: AOJu0Yyvs3l+f6XwqYdp1ynfcUHaBIqY7t9d4hdlBgBOgUQlQ9xsb+i3
	FQUUCkdYZMZSDtPOW/7pki0xtF91KKbRM5AJ86eofeWz1avv1738Elx/MS6CvQE=
X-Google-Smtp-Source: AGHT+IGDvZfiJ/4XvoDygCDHe+Yp8Wm6B3ueQaKPdSs47eimYuDVJK0r8MCo6ySHPBOaf2w9OYtiSw==
X-Received: by 2002:a05:6512:2255:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52ca6e91af8mr1010269e87.50.1718322222596;
        Thu, 13 Jun 2024 16:43:42 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872260sm359298e87.142.2024.06.13.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 16:43:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 0/6] power: supply: Lenovo Yoga C630 EC
Date: Fri, 14 Jun 2024 02:43:37 +0300
Message-Id: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmEa2YC/3XOzWqEMBSG4VsZsm4k/4ld9T7KLI4m0dCOKUcJI
 4P33jhQapEuv8XznvMgc8AUZvJ6eRAMJc0pT3XYlwvpR5iGQJOvmwgmFNPC0jUPQENPPaYSkFo
 TvY3aewiOVPSFIab7M/h+rTtivtFlxAA/GckE01wLx9pGCCmVNJRTf0sLrk0HuM7jRy5vn2kCz
 E3GYc+OaV4yrs83i9zj/35UJGVUCgut09yD18fU/lJRR+9OXlWvIjgfAYLtzMnrX2/Y+b6unkP
 fcmCdkuLszcFzcfKmehes6aDmlWz/+G3bvgFVTT2YtAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bvkmdVPRbAEAAQvqUF2QXsmCf2b50cjIdy/XyZ0RKyM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBma4Qs5RMbLITSC+O7xOl953wV9GKtwwGeXPgL1
 9RzOwrUbheJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmuELAAKCRCLPIo+Aiko
 1YJZB/4zXnq2+gUrpjMfLIv/0/TE1pv6cZzRt1WwPnySn+PC9r/CpDKFW5vsGvwZ+q4xjJAzjzo
 bjuOiPemSMhWeupbFRnn3+0ECY4IeggWZP8iVdD73KGKh2aY0sN+cwxEC8Wrg+/CoakBBV+0DwZ
 KmOm9b/W3qDqkt0SXBpGnlVuDU+/7OyeSPbfItAemtCkdJB62wRHX0nJO/vhyjLOePtmlvekEXm
 IflaWi0uXWUSs2HVkxqGmZTMdTLgj7FjPbAlq5jtpxrc7fbEBgvazx5PV2jc98vU0Du9MOAPtz7
 NczEesbhCFsTWcvqNRIqx5lBrJbEva5mEFyueKW814jZnNbo
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
Changes in v7:
- In PSY driver use guard() instead of scoped_guard() (Ilpo)
- Use switch/case rather than ifs in yoga_c630_ucsi_read() (Ilpo)
- Link to v6: https://lore.kernel.org/r/20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org

Changes in v6:
- Use guard() instead of scoped_guard() (Ilpo)
- Add a define for UCSI version register (Ilpo)
- Added a check to prevent overflowing the address in reg16 read (Ilpo)
- Link to v5: https://lore.kernel.org/r/20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org

Changes in v5:
- Added missing article in the commit message (Bryan)
- Changed yoga_c630_ec_ucsi_get_version() to explicitly set the register
  instead of just incrementing it (Bryan)
- Dropped spurious debugging pr_info (Bryan)
- Added missing includes all over the place (Ilpo)
- Switched to scoped_guard() where it's suitable (Ilpo)
- Defined register bits (Ilpo, Bryan)
- Whitespace cleanup (Ilpo, Bryan)
- Reworked yoga_c630_ucsi_notify() to use switch-case (Bryan)
- Use ternary operators instead of if()s (Ilpo)
- Switched power supply driver to use fwnode (Sebastian)
- Fixed handling of the adapter's type vs usb_type (Sebastian)
- Added SCOPE property to the battery (Sebastian)
- Link to v4: https://lore.kernel.org/r/20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org

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
 drivers/platform/arm64/lenovo-yoga-c630.c          | 290 ++++++++++++
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/lenovo_yoga_c630_battery.c    | 500 +++++++++++++++++++++
 drivers/usb/typec/ucsi/Kconfig                     |   9 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 204 +++++++++
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++
 13 files changed, 1283 insertions(+), 1 deletion(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240527-yoga-ec-driver-76fd7f5ddae8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


