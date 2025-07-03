Return-Path: <linux-pm+bounces-30069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8EAF7B1F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38305A0F99
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C22F0034;
	Thu,  3 Jul 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Beb2LNUr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF182D9482;
	Thu,  3 Jul 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555663; cv=none; b=W4epIoIMU3yDykbnGgf73g2RgHoFdcLCKGDCUg1FiqL7Q3eU/SuRGKh/kLuq5MAouLA8CqyEzYiHqBsO22fg/1jJzPDUC6xPqIj6f1IueOUXIxjVEmcKVTh09NZwx+TfapguAgDGW5BcBy+3K7i8IGOTd7tvya2FnYjmLjHGOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555663; c=relaxed/simple;
	bh=nuet3Y2Mut6w4Wyqoah1ZW4X/47vl0+/djn5JivXjco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYqxAkMkpn272ZoE9eGmXdWMNrEOkCeK3cYkM8vYwMrHqVJ29ZMa8Hk7jf5MLEsGKn/7x1q8QTOR+EdkjmkZU73hd8GDRA4uDCP9NCSIu3qm0upToZTzskivx5ELVbYbdVwm5NJX/9ct7klaTvD+WhtpNBY+9YGjos0rakoODTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Beb2LNUr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so1235883e87.1;
        Thu, 03 Jul 2025 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555660; x=1752160460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu4RZiro9Bw5AAl6vcrDQRHkTa7Z3Wce+i+f0KjYjtw=;
        b=Beb2LNUrSztLNTK1zxKwtv/bwe930eegQC1IpI7Chr2kV+t2lZZ2y1B5wyJviXbhY/
         wskJyVwGApgqKU8CCf/8MY0kyJbL3U4DW/Ct5+8omUx3+WgW3cwkao7KEScMZLh6Ycxc
         GJTodIfX/6vpsMOgEGeS4N+eFcwcRctG0RIIpS9HGLCBDdmMyVIMXCiiMTtACwEDGySM
         1ZYhcql6EmDFRpgjIbMqol8PFQRQ95+4mLvyjbqncinYthpnR7k7iALizmcgJjm7eNfi
         eLmGf62vM+PsBvNswXcKTSFZ+It8UkwhbXdTxMMijq1qlV03EsFmpl1+ZokcoVYUe9/B
         C/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555660; x=1752160460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu4RZiro9Bw5AAl6vcrDQRHkTa7Z3Wce+i+f0KjYjtw=;
        b=YFYee8x717Lr9vAsWnPd9FNsG/w0EQt10v3EfN3ZCq9BsH1oehUC0xwSvdVHnQcP/T
         KrKOKz/TKusB/nDE1VHvRJy3gmbaYTzFJgbqHOz6/KPzJO/oK9Z3Gp0T9LUKjw60JeM/
         PwaTcOrkHvU7N9k+tzukgZV4PtKSkh64V0/vf5i56qP+jCk4/SCiAo5d4PJ56rvmzRbO
         RYZpjSa2RyIu+aPnpGocuUxGeGorKV4+mIFuoIa5IEzD4ebgTub05FdzMjJ1PjSJKb1p
         ycGZpXvgFvkMvff04fHFY7JIfliEs8oYhfG1x/fOO91UZJn9QoSc0RLH4ViO35ysyW4F
         gqBw==
X-Forwarded-Encrypted: i=1; AJvYcCUcxN1waMCmOT4Qq7DKShA9YnhH3s6zafHtI8cIcVSx7fxFAvAUG+XEcf+E0UpHpBfgm07zA0cagJI=@vger.kernel.org, AJvYcCVmObyhKQZgk1CHILDR9j6UWHRl49617DfRrnzq1hKrBlRxs5Gg6Flqtfhx5pcwfbjx5egvivc2K0Za7g0D@vger.kernel.org, AJvYcCWGnI42y9Vyjebxj5PcE7V/pMXyvNJzBntzJTzpjbvom8LaD979Rp2Vu1xNZDCxz6gf5ir5anHKCs49@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl95I2+aymG4YJvTRS6c7UIxzWGhlvjPo9zmzaIkoy8idvTjZ+
	6ydU82tBhGCoDGLzb75dkeTwhu4sCgXSyzz/3jvNAUvXh7l8GS4NhtjY
X-Gm-Gg: ASbGncsBl5IvEo1OC8rp2rLu9gl4G1xz4pz2EEZty38lgcnAEwgDQNEelShesyLdSQ5
	VuFG29AS7/GGNmkLUpOYcsyrEYzuPnPm4OnvPFnuBVZj9YZJTgYqw0VC9uE6Ri4YHYSaLIfHgOS
	CpBCR9TNZALiqN1dv9XRaxFCGrRYV5Br0vtnSwAJh4ESz52xJShnoo9H1pUAp8yEzyTokhq67aB
	40Iwcdp67JRk8/i/7qoRxzais3/3b+JPiakKDgt0XVwu1WHhswPlvcV+xxIMU52XPYR7kE6fuly
	GaEMHZDRiZWfN72DSEMgnHx4+sa4HplijNIVzgWbtWGoaT15WJc5GjPbBjjn08CiHNfChJ8lL+5
	84qHGKw==
X-Google-Smtp-Source: AGHT+IHN05FoLHrAAAw9abh/cl/blTZb9HkyB7tIwYOujTKMU0qiobVnp7H6qLANj1z3QSOpo0rtXg==
X-Received: by 2002:ac2:4e08:0:b0:549:8c0c:ea15 with SMTP id 2adb3069b0e04-5563013d4cbmr1247150e87.0.1751555659497;
        Thu, 03 Jul 2025 08:14:19 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:14:19 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: allwinner: A523: Add SID controller node
Date: Thu,  3 Jul 2025 23:11:31 +0800
Message-ID: <20250703151132.2642378-8-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The SID controller should be compatible with A64 and others SoC with 0x200
offset.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 8b7cbc2e7..295292d67 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -181,6 +181,14 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun55i-a523-sid",
+				     "allwinner,sun50i-a64-sid";
+			reg = <0x03006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun55i-a523-mmc",
 				     "allwinner,sun20i-d1-mmc";
-- 
2.49.0


