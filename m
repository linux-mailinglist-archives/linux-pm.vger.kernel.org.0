Return-Path: <linux-pm+bounces-38830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67DC8F58A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F44E9464
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97A2848A1;
	Thu, 27 Nov 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfgaRhEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2032E149
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258647; cv=none; b=CvE9CSvbfNDCiAW9ua1hv7gkoWZABxVgQnayR+JE8uFvzC76wK4dEm/XyAILDWRYhB89E+j6xmKUyRDp4KK70YfI0ze1spWOHcFoiDKsAEzvy+GcHD4P7Y3/lvgO1Ji3+PyJ+S2ux2vW05CJN9IZD8ObwRMhR2+Wk7plop0LMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258647; c=relaxed/simple;
	bh=WP3ABGEoiX/jw/ImKhUBUAQI5YA1XYD8g0jDPSyftPw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MnfBEObJlU3u46VLFkXutdMxYHtauNrsEwdWyQp/rwZRN7YAgULjq/RhvWLYY6zkHba3Mjw1Cw9DOLBHePF9fqsA9xsAo+ofXPcMQX/wBZbaUGHeYnPxSYz4led9EgR9kMqLrAuCiMMhhJJoLaCv3Ap1jQzr25Q14Y3i9D08jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfgaRhEp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8302415e9.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764258644; x=1764863444; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhzmSsxu/7OD1CaWKOg+1THQqyol6J9De/tx7qqkEvs=;
        b=KfgaRhEpBQUh1++2bIsWEFKsG8hKWg78xnduyRiwCFSKNSfYZR9xEt42J2YH9HRW1f
         2qK5u+JmS7Tjn2aOlXYD+LUERKj8TuRbJ/lqVkRphRWg80Fd8v9pFiwRZVhLGI+38C0a
         PX4ttobqPVapW6ASSBZsURTUVQgXufRe7DTLqJGrSnb63pAHrLz0NM3He7Mq1ucxh1yD
         zCr5Z+XAUE5p8A18SOXC1LMRt5ogW40/765cKsLwL+PlKQXS9e0S02sAwnmocgqa3skV
         I1AnJD3dp/trxt3PBGCjBV2t5L6XY8PDdjVmQjREhCSUMHCC95FyyrFhs1EhPlGs+0Ep
         U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764258644; x=1764863444;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhzmSsxu/7OD1CaWKOg+1THQqyol6J9De/tx7qqkEvs=;
        b=Vh5YdjnnL3wisLcb7HGIxIkiMqX989y/8FXQrkRx5774QWDv5wIgaarD9q6UAyU7oj
         ODVHYm7plAC9JW8dRxMO9tGYyRn7zyx/W3NMphVub/14J3HUj9IyxDXacdmGY4H0SRlD
         qMLu4/01ao6gChnh+MOGBVozgBVTzPnWh3yRPFZYT/P217A+BhNOoAK/85xnmfR7R+za
         0LwUR+pQbmsdgEEdiGyVNLUM5tKyX28pT/kj+tt6LmUaIMqiISr1ibvFIT/7JOIVRGAe
         ZLc5rSUx3z5rbb1f5BBnnla5+0KgZtbQt6oOsUeWN8nvCUhr3Zr1jES+myHgHaNMl6pu
         YNPw==
X-Forwarded-Encrypted: i=1; AJvYcCXcW0WLgZl6vDNW7xbvS1soCr+tL7exJHUfiSCUBfRInZUP2cWkY13wvHfmMhKg0kI3RFGhIRoOSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5n6gwI6ERi8+wj/T7vENHB5AqgIQzUsF79pQ8mM/ts3S5xxv
	84f9A0PvNqiASJWAvAWPQKU/4BoM6UTKlmb/DlnHulMettegD2MgvrBmtHAun9dagXM=
X-Gm-Gg: ASbGncsUZv6fNvVoXJCc5HYNA0obz6E+Pko5Vy0ANrsiHzQTWspI8/njFablmUbtLA8
	T+qNc9vK1b7BceXkzQjsBf2gVg5CWCW5KLTXS6UiqlbGEUO9bQ7jIsIXdTBgVP78yfgM6WoQmbV
	A/mKZuOBWAZ87tV74qoB9IMiHKiiEUEYpfipkHDv4sFFhkD3h/htRLMcqtN39c/PBpDup0olIOO
	FkDo8c+rdAHiTZTrxxTTtD+kD6gYIMZzdEUbz+PUsgiPkg8YKM8Nz9xtadEB/FAPClm8d2hkhXk
	sJb6PQU+2Hs09WLTxPtcvTrTyNCD2jX9LhFYIrsNRmlAIlqAsRlRu/XnDVP4vC49LwL69tn6h6J
	AYPCfMOfRqTezRCgY23dUrb+QZywikk7/OFSfxEtDYdyEM4aZZWr1Fzkl4GnxC7HODO674lwbJ5
	COLNk1NJ49X3GJhql6hlOr9M95V44UMOAF81fPjpFS3NSa0235kjOLSB3jUAL0xhFfKA==
X-Google-Smtp-Source: AGHT+IH/8+cai4JFmPGQbtxu0G2fftRXDEiHCNPF2leFrmIz2MSi/7QY4bMG836446KS1dXYkvmVig==
X-Received: by 2002:a05:600c:4f45:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-477c04db9a0mr259432855e9.8.1764258643977;
        Thu, 27 Nov 2025 07:50:43 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:86ca:c3a9:3116:833f? ([2a05:6e02:1041:c10:86ca:c3a9:3116:833f])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6049sm4352112f8f.10.2025.11.27.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:50:43 -0800 (PST)
Message-ID: <0b771d57-b280-4c54-886e-6b2c4602212b@linaro.org>
Date: Thu, 27 Nov 2025 16:50:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Malaya Kumar Rout <mrout@redhat.com>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 marek.vasut+renesas@gmail.com, Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Pengfei Li <pengfei.li_1@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers update for v6.19-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

   Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.19-rc1

for you to fetch changes up to c411d8bf06992dade7abb88690dc2d467a868cc4:

   thermal/drivers/imx91: Add support for i.MX91 thermal monitoring unit 
(2025-11-26 15:51:28 +0100)

----------------------------------------------------------------
- Document the RZ/V2H TSU DT bindings (Ovidiu Panait)

- Document the Kaanapali Temperature Sensor (Manaf Meethalavalappu
   Pallikunhi)

- Document R-Car Gen4 and RZ/G2 support in driver comment (Marek
Vasut)

- Convert to DEFINE_SIMPLE_DEV_PM_OPS in the R-Car [Gen3] (Geert
   Uytterhoeven)

- Fix format string bug in thermal-engine (Malaya Kumar Rout)

- Make ipq5018 tsens standalone compatible (George Moussalem)

- Add the QCS8300 compatible for the QCom Tsens (Gaurav Kohli)

- Add the support for the NXP i.MX91 thermal module, including the DT
   bindings (Pengfei Li)

----------------------------------------------------------------
Gaurav Kohli (1):
       dt-bindings: thermal: tsens: Add QCS8300 compatible

Geert Uytterhoeven (2):
       thermal/drivers/rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
       thermal/drivers/rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

George Moussalem (1):
       dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone 
compatible

Malaya Kumar Rout (1):
       tools/thermal/thermal-engine: Fix format string bug in thermal-engine

Manaf Meethalavalappu Pallikunhi (1):
       dt-bindings: thermal: qcom-tsens: document the Kaanapali 
Temperature Sensor

Marek Vasut (1):
       thermal/drivers/rcar_gen3: Document R-Car Gen4 and RZ/G2 support 
in driver comment

Ovidiu Panait (1):
       dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU

Pengfei Li (2):
       dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 
thermal module
       thermal/drivers/imx91: Add support for i.MX91 thermal monitoring unit

  .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   9 +-
  .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |   6 +-
  drivers/thermal/Kconfig                            |  10 +
  drivers/thermal/Makefile                           |   1 +
  drivers/thermal/imx91_thermal.c                    | 384 
+++++++++++++++++++++
  drivers/thermal/renesas/rcar_gen3_thermal.c        |  10 +-
  drivers/thermal/renesas/rcar_thermal.c             |   8 +-
  tools/thermal/thermal-engine/thermal-engine.c      |   2 +-
  9 files changed, 504 insertions(+), 13 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
  create mode 100644 drivers/thermal/imx91_thermal.c






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


