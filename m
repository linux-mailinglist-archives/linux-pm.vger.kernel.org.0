Return-Path: <linux-pm+bounces-9236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACC9099DA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E5D1F21CE2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E255774;
	Sat, 15 Jun 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzTqE9qL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2FCA6B;
	Sat, 15 Jun 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718483143; cv=none; b=HL1IzCQ/XeFt3wa+q8D1Whp+/HnR5yiXeF7pW5Srw+00t/OSwXizRFuFhJwQdYjQY5L45S+RTOVni5rN0sZpFqGz3nY3M7gIbvXymO8sOSknJ8u5ycEiEfbaN6r+XinNMGV5gDI7/TDECoAuirhx+AxdANLJZgaaa/UmMGbUGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718483143; c=relaxed/simple;
	bh=4XGrnqcIzlgogEprEB30ISLMTdF9AZgAV24wOsKMnQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4iwUY7i0hcxjyTnJRqrejb3rUUZmZnVbrJme2YQI65EMWbGru/EQgRTh2rZkXRB1mRYD8OMYycQFcimsv77sVKms8Xn1e7Lk0xSa9/8bVC1V80NtWN90TwNogaPOfQBr0PPYUzf2epQdlhd7pxpnF/B3Iy5OOy7tfLV+5fp1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzTqE9qL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so22642915e9.2;
        Sat, 15 Jun 2024 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718483140; x=1719087940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNKt7Ml+VkGdZYvOnEsbsW47lMaRP2AbddrHl/jp3zk=;
        b=DzTqE9qLQcWaJAVZ7V6eeamMHoE6ew0Yn3WlJ93rCRJxc89/G8TM1dWuYrBr5U70PL
         8NPnC3VVLdebFDkfhrQE6KLBqyilqParVdLGs0Y6mcCev9Go64fBvWEVDFOuWVBbgLOR
         D5HFEbnO1ACn52BAmfWoAhGRzcx/EKYZvs8NBZ8Dplcpm3xg4+GaMtOgy3q2FCtn704W
         bW7fcJ6MR88DiVC3V0moDcY0/rWmzoWPlz3iiy1QSRSspwNZmNx+qA4pJSd/1ugERy1x
         0Cnv0sU5Nj4PDq1pW8icEgRE6jryqb94tqo5BNh9eS+Tn41UB+ETaSUZbChIElDAbjWC
         FH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718483140; x=1719087940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNKt7Ml+VkGdZYvOnEsbsW47lMaRP2AbddrHl/jp3zk=;
        b=QLy+DA/huEbt14woSYafoupZYUyWlX72vhtBiK1qwp8TFlCKzWw3nNFBK+beCHFbxl
         vXts3qZ76ccimabnPl8W/67U0rmoI7lt5OHXt2F2Gm/hc7xWRX5RUflWFEaR5M7w5tJ8
         Iu5G4YNOuxLeiI5SBZNZHWPQ4EyPBjATSNFMcmW3XZYANolbYS+bq+Mmi+oC8dqOB8K7
         /H6tHWx5qRTsNM92yMr71m8s6XV4RpmeNifiI+8T+2mnAlItgEfIB5fiputvWOmv5dOo
         WLM/KnS30ckHrP9JKL8rMEr3Rq9igsc7J9WkKZYJ22feVaHg9Mh6BiW+Knl9PdOL0UGh
         JSgg==
X-Forwarded-Encrypted: i=1; AJvYcCWAsKLEzycQuv6t6oSdWSqIPfeacQqxVfeiwZ5Vzy6/yKpIJG5kstRwKwOH+dfahWfcVwt6XVGC3NXmFkkwIqOLOSiqiI1tMB46SeANidHR549VWNxJeeMgqQgxNVUFUiOdc/kNhF8=
X-Gm-Message-State: AOJu0YwSCs5/aIN8x8nNmEl2pCe7olNP2060OVzREWtU37RtTs1Tr79D
	ceVsfkrrVBs6mE5SuJqcgG3sRdYYmPA1AdUz4CCmFAgIkQvSnNZy
X-Google-Smtp-Source: AGHT+IGdJOgU6TKZTTNnaPzTE7vJyVa/Oph32kGoQAyGLxjcubb5rNs98xrC3/CR8X2rLR8VrvcmjA==
X-Received: by 2002:a05:600c:154a:b0:421:8f16:16d5 with SMTP id 5b1f17b1804b1-42304852afcmr57488515e9.33.1718483140145;
        Sat, 15 Jun 2024 13:25:40 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm70289275e9.22.2024.06.15.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:25:39 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] power: supply: add support for MAX1720x standalone fuel
Date: Sat, 15 Jun 2024 22:25:23 +0200
Message-Id: <20240615202527.163641-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to max1721x_battery.c:
  - reading manufacturer, model name and serial number is only possible
    when SBS functions of the IC are enabled.(nNVCfg0.enSBS) Factory
    default is off. Manufacturer is "Maxim Integrated" and the model name
    can be derived by register MAX172XX_DEV_NAME. Serial number is not
    available anymore.
  - According to the datasheet MAX172XX_BAT_PRESENT is at BIT(3) not
    BIT(4). Furthermore the naming is misleading, when BIT(3) is set the
    battery is not present.
  - Removed DeviceName, ManufacturerName and SerialNumber from struct
    max17211_device_info

Changes in V2:
  - Changed E-Mail in Patch (2/2) Signed-Off

Dimitri Fedrau (2):
  dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel
    gauge
  power: supply: add support for MAX1720x standalone fuel gauge

 .../bindings/power/supply/maxim,max1720x.yaml |  51 +++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max1720x_battery.c       | 324 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
 create mode 100644 drivers/power/supply/max1720x_battery.c

-- 
2.39.2


