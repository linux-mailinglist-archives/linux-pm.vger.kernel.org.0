Return-Path: <linux-pm+bounces-24506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97FA712FB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89FA188ACF0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AB1A3BC0;
	Wed, 26 Mar 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7attKm1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24417CA1B
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978630; cv=none; b=KxtdFJU4vqBB+EmFFHn/vSxxLfkjNxraBa4/UoQ9PumNECwO2b1h39p3HeYClmRzbaXEjJyWi2mkQPkzf6qTdnq84EuHpjPE6FBIgWSMpO0wyNEQ30FOeUcrcUt+8XdwVu7TUYyXqdlwo7kN6wdEaPASFS6VuOSsi9W4AuWOLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978630; c=relaxed/simple;
	bh=+/vbVvp7TBfeyIb5aA4p3N2on+ew4il4U+oUd2qfWzQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VUrusIJogdkBVu/Eea1pkykJXsYx9GJTke2tG3IbnG8mVkvbsHom7sIMFIzBznPiadQeAVw5osro5u1sZ5ydlpiWE3J1aDlSIit90AUvoQX9RNxX0R7BIyDb/LOburQW4aeDjqiiMN6pUmQkNz44iubrNCAbrSTrM6rZHjEv4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7attKm1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso34124055e9.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742978626; x=1743583426; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sJ0/cjtOuS0rqzVhbqmd3GPHS9gnvVNLtBH1FZbB0Y=;
        b=l7attKm1xluM3oHLAS0WMzTmTJlxJi5GU8WUfenriYx2jiXlB4rJ73EO1WuX8ZeAkH
         evZ7f0wQUADbT1j9b7lJzlEWpO0x5DedyXX+t43ZnYaxGeUvMb41fBr5FQk4sAfJnimy
         36xf9+oHdVl5yfcOXcAN/xMqt0S8PJ6wowNO5iNwK1j2HmMnr0cfAbJY8WBTtDOxNGJz
         YrhDHsu3XBV/L51b5wkgkSDuTk4rDnh4I1+E3OIGmjQoFS8eQXM4+48Wfb8yIZPr7jkk
         2u/tRV2d1LI35s3ppYtw0Lryk9uukKebvSuyS7hIoQc5eAz1VsAtU1WbAdBk2OhS/Kcp
         hPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742978626; x=1743583426;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5sJ0/cjtOuS0rqzVhbqmd3GPHS9gnvVNLtBH1FZbB0Y=;
        b=ZBqztfjElD+Dp/pe2FgmFnAwfKWmVuzQMdhmTC+ghfcIaieoFeFMbNx+S/iqRAB1TZ
         oZoq8IBP1HKoddO8GOy1jHsaFoFeYWlsEmfn2Stb3v8mnts6BpI1j0h3OwiWIxRVrah8
         5m2AGj2MudHLe9srXL9bNNTGoXmE3Y/32Vq+HotHXr8KS0twxiDE5ITxY08sar01TI1Q
         L/8wMnE1lO4FD7PlLCkbnZY/fpfC23KLJxRfrGz3LD3qVJnZy6Y1G2cYyub0EUfpTLzZ
         Aalvzu9lPa26yCENV4IW1yZCsuqFgFzkuE+EJnXQVVpFbmCO58hXIB33byvFtR5zOa1+
         56xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBwY4mxvJH/btUVxRp/Jn3EyGh2toIvcLOxJJPZ+hnr45rEULcaUnW5xv7VhOM6bCRrVlShwFYIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYi7/0umv3TY5RpJkNppcO5HuDL3ovbejt2CXT7w0z51ZA/8DB
	h4YoMS6bnBhjdbgGptff5xfnf/VlKvTIlF0CwWTiPiIOBtM3UIwtfo8Of61OfUY=
X-Gm-Gg: ASbGncv/wHZhTO4/iIufqkZpSciy+3BoFd8GaufqjW0vGCqAUBoQ51P8gQN6QSvYdDR
	agLQIfjT4Ak7F5wAAfY3P8PFnB05oZd3jhgqpNItkD/izRKINT54P4p1SNtTYWBt+ij+FAhPWWv
	FM2cmmuufT70n21HlxapA+Zk4cVychW2HjAa2vSYwg+/McWqQ3b8L/ClMBu19B258jhsqVEHY/E
	aAqhV41u7vDz4UUcPcJc++W0lEPyKgfTCiJD1AHv0yW2hyuIXup1v+mPDAL29Rsj89XUP37r4DS
	K5Czo44Gigs8ThP+PvFptHxoX4+u8K2Pg6YAllLVjxLzzVO2nCOQvsy2+bkZwUxo3ycQfLRhHQO
	JiiT3AxB3
X-Google-Smtp-Source: AGHT+IFF0Aq5lld9jdkAuw42huB04Wc3niueUjPOAlPTax9zhbSZF2hXpyEJQbfXp9HVFKoj2aF1Uw==
X-Received: by 2002:a05:600c:45cf:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43d508715e4mr174902685e9.0.1742978626245;
        Wed, 26 Mar 2025 01:43:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9ef098sm15849259f8f.84.2025.03.26.01.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 01:43:45 -0700 (PDT)
Message-ID: <8a52679e-830d-4a7f-8eb7-c6ea90c735d7@linaro.org>
Date: Wed, 26 Mar 2025 09:43:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Praveenkumar I <quic_ipkumar@quicinc.com>,
 Trevor Woerner <twoerner@gmail.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Johan Hovold <johan@kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers for v6.15-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider the following changes since commit 
c3b659b74541f4564f9f5a39f65e625c47e77e21:

   Merge branches 'thermal-core' and 'thermal-misc' (2025-03-24 14:09:38 
+0100)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.15-rc1

for you to fetch changes up to 1b4ef46fd6660712afcfdd841eadd928193e850f:

   thermal/drivers/qcom-spmi-temp-alarm: Drop unused driver data 
(2025-03-25 20:52:04 +0100)

----------------------------------------------------------------
- Used dev_err_probe() helpers to simplify the init code in the Qoriq
   driver (Frank Li)

- Powered down the Qoriq's TMU at suspend time (Alice Guo)

- Added ipq5332, ipq5424 compatible for the QCom's tsens driver and
   TSENS enable / calibration support for V2 (Praveenkumar I)

- Added missing rk3328 mapping entry (Trevor Woerner)

- Removed duplicate struct declaration in the thermal core header
   (Xueqin Luo)

- Disabled the monitoring mode during suspend for the LVTS Mediatek
   driver to prevent temperature acquisition glitches (Nícolas
   F. R. A. Prado)

- Disabled Stage 3 thermal threshold on the LVTS Mediatek driver
   because it disables the suspend ability and does have an not
   interrupt handler (Nícolas F. R. A. Prado)

- Fixed low temperature offset interrupt on the LVTS Mediatek driver
   to prevent multiple interrupts when the system is at its normal
   functionning temperature (Nícolas F. R. A. Prado)

- Enable the interrupts on the LVTS Mediatek driver only on used
   sensors (Nícolas F. R. A. Prado)

- Added the BCM74110 compatible DT binding and the corresponding code
   to support the chip with a different process (Florian Fainelli)

- Corrected indentation and style in DTS example (Krzysztof Kozlowski)

- Unified hexadecimal annotatation in the rcar_gen3 driver (Niklas
   Söderlund)

- Factored out the code logic to read the fuse on the on Gen3 and Gen4
   drivers (Niklas Söderlund)

- Dropped unused driver data on the QCom's spmi temperature alarm
   driver (Johan Hovold)

----------------------------------------------------------------
Alice Guo (1):
       thermal/drivers/qoriq: Power down TMU on system suspend

Florian Fainelli (2):
       dt-bindings: thermal: Update for BCM74110
       thermal/drivers/brcmstb_thermal: Add support for BCM74110

Frank Li (1):
       thermal/drivers/qoriq: Use dev_err_probe() simplify the code

Johan Hovold (1):
       thermal/drivers/qcom-spmi-temp-alarm: Drop unused driver data

Krzysztof Kozlowski (1):
       dt-bindings: thermal: Correct indentation and style in DTS example

Niklas Söderlund (2):
       thermal: rcar_gen3: Use lowercase hex constants
       thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4

Nícolas F. R. A. Prado (5):
       thermal/drivers/mediatek/lvts: Disable monitor mode during suspend
       thermal/drivers/mediatek/lvts: Disable Stage 3 thermal threshold
       thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum 
threshold
       thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
       thermal/drivers/mediatek/lvts: Only update IRQ enable for valid 
sensors

Praveenkumar I (2):
       dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
       thermal/drivers/tsens: Add TSENS enable and calibration support 
for V2

Trevor Woerner (1):
       thermal/drivers/rockchip: Add missing rk3328 mapping entry

xueqin Luo (1):
       thermal: core: Remove duplicate struct declaration

  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  48 +++---
  .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |   1 +
  .../devicetree/bindings/thermal/imx-thermal.yaml   |  40 ++---
  .../bindings/thermal/imx8mm-thermal.yaml           |   8 +-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |  18 +++
  drivers/thermal/broadcom/brcmstb_thermal.c         |  11 +-
  drivers/thermal/mediatek/lvts_thermal.c            | 103 ++++++++----
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
  drivers/thermal/qcom/tsens-v2.c                    | 178 
+++++++++++++++++++++
  drivers/thermal/qcom/tsens.c                       |   8 +-
  drivers/thermal/qcom/tsens.h                       |   3 +
  drivers/thermal/qoriq_thermal.c                    |  47 +++---
  drivers/thermal/renesas/rcar_gen3_thermal.c        | 107 ++++++-------
  drivers/thermal/rockchip_thermal.c                 |   1 +
  include/linux/thermal.h                            |   2 -
  15 files changed, 409 insertions(+), 167 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


