Return-Path: <linux-pm+bounces-11074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A09309C5
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BF8281B03
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA061FE5;
	Sun, 14 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EckQe8fO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044945978;
	Sun, 14 Jul 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720957396; cv=none; b=jnDWDUhMZ+NWLSl7csuukovhRYkuRQs422nmaHynrfccWCpAFJQd1VdhNTuQ7D9YBJS7eSHZh0UmhDAl+alE8OSfL3pVradvDcJ42oMHdBclnxvivn6s37mTYc1IsTVr02Lahjs3Bn53WAxcTds+2qVWbtPmmgO847d8oIclYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720957396; c=relaxed/simple;
	bh=DqpzFM273UeLULst+xIxSPbTgAiEPZSRNvCtxF0gS64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bfqQH4RIeVeZE+tn5lDkiAcCYLkP6mTSfwWK6z6LsUTAA9sLu/dOgquOEGQ5PduJWB9e2cLjBaTJYUM4ARdvuUkISKxesmkN4EV/tDsrwhwxL6/eA6Xf9w0jfx0qJhE+QoVy69cvbONWGhhOYItPCwdNwAaX+IJcjL9biZsvuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EckQe8fO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso24764955e9.2;
        Sun, 14 Jul 2024 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720957393; x=1721562193; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2n5TCQJ2aZTml13MKx0tGjckXVIFB7K8BA9Nly4+9wo=;
        b=EckQe8fOBy1YScgat0beBGh4t0S8DEJSbwFKuT8Dcmt0XSKfOGVnwdlUie4FRPZqkZ
         fZN0V/R+VddwI5+GUi1BurjQYyGTVVAHquqoSfyhItHwBhbbfNTz07Fqu+y3M3uwTEqD
         MGpOfPXBmRFTAWaP8L/nIko8BWmYteLBnPl5aYdo7rJBSrllSySb22Jvm5q82Id1plDg
         2a2PV0oAkEcSfKpcvZmvc1YDZkmohNjkJojmf0I0Y1JsmLGcUDPSWG7H5/+4VGyGO/0b
         0Eb8nZiw+v/zOS+lzaIEnJMKCbfbT88SwkDjRkWc3bNvka1Zhpi+i0gCKwX98t1UA5Xr
         8Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720957393; x=1721562193;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n5TCQJ2aZTml13MKx0tGjckXVIFB7K8BA9Nly4+9wo=;
        b=c6Zf9mII6n7u0pAl2d+OS4maZeSgWfw4zEROI2PaSRqtHt65FhUE2FnxfII5nVxAbf
         olNtCccBMMleCjUBLNSvMiz3MFZeTaHXITum2mh5pvaKblnO8lYI7ZCqK0nelQGytY9Q
         Om67CVQzhf0IS8m8O+gzwY8yXepwIizCiHXCQKuo3U93lNZ+SnkQYINcAPKrahdfqQwW
         yiHJJhgGu1T4w97GyaS+cuIwliqZaddfCsUC7o6Wz9TRhmmhvPDnCoXNBaWWLU5ns1Pk
         vwlsa+y9F9Ro+US9zRXgP8RFOFweJduDaSiC63kTpN9LSaMjYCwQ+l8MubLv8K4oA1PT
         NCPA==
X-Forwarded-Encrypted: i=1; AJvYcCUoNDuY+DMbAzlByaPoRHSDmxrOKVf+u/Fuut3PlPimUSvQM/gyjigxsl3TBDmlH8qabRio7rHuwS8nCmG7HW2PsAW/nTjAtGrMC7A7Sa9Dz/53noq+93QP7Z/pEZbmdN6jp+hW7YUWAQ==
X-Gm-Message-State: AOJu0Yy5gizbppEpatcallUoKieh0uCt1USuKIdTYQzxJs+RrZDlVPMG
	I7x6/bKeO17vQxmx8lpAlS6iHOSMPNhmJ6+nWs3bKkpji+nDRwtN
X-Google-Smtp-Source: AGHT+IExNrbXa/f2Lp9GuK2cGefWfniERXAX71ycVDSa7Qqxj4fnPg2Z1sso2yeSttZjeaTAepYziw==
X-Received: by 2002:a05:600c:b48:b0:426:8c36:5841 with SMTP id 5b1f17b1804b1-4268c459b89mr102803385e9.23.1720957392745;
        Sun, 14 Jul 2024 04:43:12 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb454sm48887395e9.32.2024.07.14.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:43:12 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v3 0/2] Add thermal management support for STi platform
Date: Sun, 14 Jul 2024 13:42:44 +0200
Message-Id: <20240714-thermal-v3-0-88f2489ef7d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALS5k2YC/2WNzQ7CIBAGX6XZs5hCQdGT72E8UFjaTfoXaIim6
 btLe6mJx/myM7tAxEAY4V4sEDBRpHHIUJ0KsK0ZGmTkMoMohSwV12xuMfSmY9pfhJJCG+tvkK+
 ngJ7ee+n5ytxSnMfw2cOJb+t/I3FWsqvz1lTopJL1o+kNdWc79rA1kji8/O3wRPZqrysl0SmO+
 Out6/oFDGIXy9YAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

This patch series enhances the st_thermal driver in order to enable
support for thermal zones. The changes include:

1. Replace deprecated PM runtime macros with their updated counterparts.
2. Implementing devm_* based thermal of zone functions within the driver.
3. Updating the stih418 device-tree.

The device-tree patch depends on an earlier patch sent to the mailing
list [1].

As it is currently implemented, an alert threshold of 85°C is set to
trigger the CPU throttling, and when the temperature exceeds the
critical threshold of 95°C, the system shuts down. There is for now no
active cooling device on the platform, which explains the use of the
cpufreq framework.

[1] https://lore.kernel.org/lkml/20240320-thermal-v3-2-700296694c4a@gmail.com

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v3:
- Fix unmet dependency in [2/2]
- Remove no more used variable in [2/2]
- Remove already merged patch in soc tree
- Link to v2: https://lore.kernel.org/r/20240625-thermal-v2-0-bf8354ed51ee@gmail.com

Changes in v2:
- Add Patrice's R-b
- Edit patch [2/3] to remove unused struct
- Link to v1: https://lore.kernel.org/r/20240518-thermal-v1-0-7dfca3ed454b@gmail.com

---
Raphael Gallais-Pou (2):
      thermal: st: switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      thermal: sti: depend on THERMAL_OF subsystem

 drivers/thermal/st/Kconfig             |  2 ++
 drivers/thermal/st/st_thermal.c        | 32 +++++++++++---------------------
 drivers/thermal/st/st_thermal_memmap.c |  2 +-
 drivers/thermal/st/stm_thermal.c       |  8 +++-----
 4 files changed, 17 insertions(+), 27 deletions(-)
---
base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
change-id: 20240518-thermal-8f625428acf9

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


