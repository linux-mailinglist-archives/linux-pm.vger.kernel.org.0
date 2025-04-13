Return-Path: <linux-pm+bounces-25330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348FA871C7
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 13:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FEF1754D7
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343401ACED9;
	Sun, 13 Apr 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRnWJBq7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB001A8F79;
	Sun, 13 Apr 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744542663; cv=none; b=QoGzdurtNjLKhkFkZvVoWhgv+euh4Q0tkAWiG2Fo/2Znl4TY0R2avwrxqvcHlmcKegMSaxqYi6FAzHu1ZINtdxhjh4zMVkMZBVaJwSWG9zQLGfD46UryUCxk5OJAHRb5UHdgzDoFPWBsBlVvRLgUZYsCGAiuVq9V4XyrIpbZlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744542663; c=relaxed/simple;
	bh=BBXGgxmEIZfQk26iEKset/TH1HIPQXdklPwmouELyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alsuBhL+PwzCcdAZvWzYWdomlr+Qqn6Rc1Dxdo/x9qbk9ZPA0CiEi4R5BqBADuXL/oYFW3wRvqBLg2Wmg1ayrE4mc9REKkBZU8OjzoqzX+xHx/vPIQvtYHggxQxpVvh4sESrlpdTSOzw4PraN9qQlIaUTfd0f2vs9X1Hq0N94MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRnWJBq7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso6241720a12.2;
        Sun, 13 Apr 2025 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744542659; x=1745147459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taQydatFRUUIgWEIrpl5CYVqIF0OiF14uRuCSzbkAJY=;
        b=BRnWJBq76rOAMrhFjdZXErt7zPEcH0cSmgfmZuOBqX1aLUuKigm9ZXlUGPGcUxJq2Y
         bdW6fnhtbM4UPOBwTSJeqsB3Ibmet8sU631/BPlPOyl149mRMkjq/ZfQbXeCYJkFNhxy
         XGYWhoZZo6ifM38TD8CSEot1yzhjrJ4mlxMxvwE8zRQTxMXt2t/714ZmjJU15ckN88yR
         +tKua44Vsz2R6rK9HNzonTujKkOVw+5+VxSX1/02oxMTkE1itM0t0IjKCnKQTeoe4eio
         +fROy3cqh1VE3Kq+SssD15Y+nJKVhCBe75CnsjefJxrSqCYCm2ZawQ8S87KTzYlllb/x
         TbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744542659; x=1745147459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taQydatFRUUIgWEIrpl5CYVqIF0OiF14uRuCSzbkAJY=;
        b=MgyM03BgYfKUsxbgqAoN1BR7vPBlXnWiLJDv0BgdYixDpVdU2xwBxzaG429LQcJEVP
         MC4u0YcmIcqiUuXf9J8BE+7PMDKLkwsuwOt0wdxwi0bYNfHd1/OI/SLnZw5FFAwYzWT2
         dHkcpMZpjPRnuUN7cl63kW514iuCtkD9ujHF8tf75lXc8Rbbm4EyuFbN5+OVYB6N7Z/h
         psxshC4FQ8BuvEv4giUW37rZJMF9R6jomlo0aVj7RM8SjanVDRT5VgGkk7CyPIBFJWaC
         N2dnuD2cxEp/8A06CFrh4lX+5Ms0JBQ4T5YtsPwuVigtfZW1xvlLbPcd8izYMEwsG3sF
         j6qA==
X-Forwarded-Encrypted: i=1; AJvYcCU7rypBzMiLQnYEx8m/0qcwCXIZ70YReMCHKMaQd9/SIHS3WnRefS2q7plCb6dt1YZq/xRLWNMs6lUv@vger.kernel.org, AJvYcCV3ZtJLHt+FyS11WoxjuxWjTgN8g7m4dL2E+XG602mInuuGAbRhUnw0ZMFRWY2RgMhY1W5/x89kMF3Oc1I=@vger.kernel.org, AJvYcCVv01JPftyvdn5x9d+f21nnlhxgWEy/wc93jlLW4tqF3Cx3k+ROVWAIdEiWv1P9AQiFeceCJ6solDUNl6xq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7X7NXAq+zqkzpVkTjIJ1ndIKlkj4uuvngHCg/84qEpYnGqCfD
	SP7gjHIvtoMw2twnepLhJrF/yB5OFNaqCQ3E3kesiBpKDp0NaOcm
X-Gm-Gg: ASbGncv6aZgbGk3wzXzHhKNiJgRYlvmJ6R0xyzs2Jdsh/oJ748gwUoR+qcSENofHYoA
	Q4bzME7KgLUNJBsiOqXrsrunip+JQKWUGU/kH0MK0p3iLIu1xyua04nihetwHXwS4ECN4YgmkN9
	2DLIUCKevfJllPZj+nC5dgS2KQNIU/IwwmumyIMHHldkVB63RZbjIbDi6KuZREjXB/M0IOoZPVe
	cyhUpvekIdZPqSJIHX+pGUfEEmGmrgnUJ8WXW8cXFLCri6uBKXks1g5SBFaPrVN6eqjLT6WSKu2
	EyFaqqHGhbHv12/Zg5QV0h2BCmVngPIo
X-Google-Smtp-Source: AGHT+IGPC9f/KWk0lWHsX3nZmihYw21EjWEm1OZsXaWLqJQRQ5y0yZvbB3JEz1t9QR2eEzbb/Zp6ew==
X-Received: by 2002:a17:906:c14e:b0:ac3:c56c:26ca with SMTP id a640c23a62f3a-acad3446a15mr776027366b.8.1744542659317;
        Sun, 13 Apr 2025 04:10:59 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be98d4sm728571266b.59.2025.04.13.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 04:10:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: tegra: chagall: Add embedded controller node
Date: Sun, 13 Apr 2025 14:10:33 +0300
Message-ID: <20250413111033.11408-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413111033.11408-1-clamor95@gmail.com>
References: <20250413111033.11408-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add embedded controller node to Pegatron Chagall device-tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../boot/dts/nvidia/tegra30-pegatron-chagall.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
index 4012f9c799a8..b7d0ebb766a6 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-pegatron-chagall.dts
@@ -1155,6 +1155,14 @@ lcd_ddc: i2c@7000c000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
+		embedded-controller@10 {
+			compatible = "pegatron,chagall-ec";
+			reg = <0x10>;
+
+			monitored-battery = <&battery>;
+			power-supplies = <&mains>;
+		};
+
 		/* Wolfson Microelectronics WM8903 audio codec */
 		wm8903: audio-codec@1a {
 			compatible = "wlf,wm8903";
@@ -2596,6 +2604,14 @@ backlight: backlight {
 		default-brightness-level = <15>;
 	};
 
+	battery: battery-cell {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion-polymer";
+		charge-full-design-microamp-hours = <3050000>;
+		energy-full-design-microwatt-hours = <23000000>;
+		operating-range-celsius = <0 45>;
+	};
+
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
 	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
-- 
2.43.0


