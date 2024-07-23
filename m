Return-Path: <linux-pm+bounces-11336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3793A26F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA271F23E3F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B766152534;
	Tue, 23 Jul 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tp++tmdi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26A15252E
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744225; cv=none; b=lSkufnySL7R7KXwcGhM5MFWnKkDYppEzt4IBA4GbrajNBM5QvKurNJLCAzPTw82jdnepZ5kyhqHdXtgfjAKlryfX+Za0QGAeH6eM16t22q1q1f0L+4/rqbFKZnXMG/tewAXXPq1i9mhanFQ6exetI1AftIN13ulf4YfZmB+0hIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744225; c=relaxed/simple;
	bh=DokAt3REwYburQaPky05gjnMoWXv28kQ8L7i12RmZ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=lW+gIvPxPJRPi0rP/C4qYqd9pl334Z3jJAWKcM65BSUxc9F8x1vzUdnI8APch4mHe+fimgJ2EAnKUTDzJYSvsqdognZ1YsWLZ+aOH4DeBHr6D4FzSy4X2Q/XY4EC8rocZwUWAfil1l8XIuAkJRk0LCRmgMjH64+DncnC++2VyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tp++tmdi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240723141655euoutp018ead202bb6a66749963178229d75e995~k3T3eQebh3126231262euoutp01-
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:16:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240723141655euoutp018ead202bb6a66749963178229d75e995~k3T3eQebh3126231262euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721744215;
	bh=FMZuGVWWsRbasuE+xwjGAfo5VkxSVrg2vk1+uKbDH9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tp++tmdiiZXtlwgv6otx4eHx3Zz5Mcl09xU3nrbxX0eGdTRZMqJsyL/Up48hKwRK3
	 vmugfxrdaUcCISYQi9BhNP5+Qv+tXLgVS7PWXlqSuGvciyyiIYeYkirbAREFSgoat5
	 BeN3T7TUwErOCMGmEqT6S+zw8ZBVnUyKvnoqRYEw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240723141654eucas1p27e8df6cdd970fdc8b6b3e87b7cb8c8c9~k3T3F7wAc0973109731eucas1p2D;
	Tue, 23 Jul 2024 14:16:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 17.E9.09875.65BBF966; Tue, 23
	Jul 2024 15:16:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e~k3T2iYk3f1687516875eucas1p2H;
	Tue, 23 Jul 2024 14:16:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240723141654eusmtrp151b8102f680066a81154f58785982620~k3T2hmF6Z1462214622eusmtrp17;
	Tue, 23 Jul 2024 14:16:54 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-2a-669fbb5666b3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.46.08810.65BBF966; Tue, 23
	Jul 2024 15:16:54 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240723141653eusmtip2de4eb2ab058d9df0509ecd6d9d145e33~k3T1sJZx12309623096eusmtip20;
	Tue, 23 Jul 2024 14:16:53 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal
 driver
Date: Tue, 23 Jul 2024 16:16:37 +0200
Message-ID: <20240723141638.374742-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4m0xG5yHOT_ucGdrOhLZvjhga8caqHQZmVH6HHKUnBgkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87phu+enGbzrN7Z4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mu51nGIvOC5TsbFlGlMD4z6xLkZODgkBE4kfm58x
	gdhCAisYJTZ9cO5i5AKyvzBKTD14kAnC+cwo8ebUJ5YuRg6wjneb4yHiyxklji+awgzhtDJJ
	TJrWywIyik3AQOLBm2XsILaIgJ7Eupmv2EGKmAU2s0hceDqTFSQhLOAvsWDjN7DdLAKqEhdW
	TgCzeQVsJdb+/cgMcZ+8RO/+PrA4p0CgxPy935ghagQlTs58AraMGaimeetssCskBKZzSlw+
	uZ0NotlFom3RXShbWOLV8S3sELaMxOnJPSwQdr7EjM3voV6rkLh70AvCtJb4eIYZxGQW0JRY
	v0sfothR4uW864wQFXwSN94KQhzAJzFp23RmiDCvREebEES1qsTxPZOg/pCWeNJymwnC9pDY
	vfcC6wRGxVlIXpmF5JVZCHsXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExsp/8d
	/7KDcfmrj3qHGJk4GA8xSnAwK4nwPnk1N02INyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQ
	QHpiSWp2ampBahFMlomDU6qBqVpmUSBnz4NXbq4XQ54wllhNz1RddMd0SuexbUccBI5cnbQi
	pqW5p1fw1RbrCTfv+okryaoLvWL8cumKcEbW+9t+Ez9uaDZNWLiHl+vQvHMmx9O5lBqqtveI
	Js9YJTmFs277BY7NhwWWxlrflZUWudWxtX5bgNO+D/7m5v/c+IWOVaqmh1ozCb7Z+8iw+c6L
	cymTJVYueZ6rznuZVe1Ty/3fwe5zdj2+2+VTZ+P5/CbnvZmr1+3RvNwffkbhVLNW0CpZu6Pz
	p3KbtjEbNMQUMP1jkY61s+ra9F37x8E/ZruenEyNerKhI59zw6Qa0eLvwfWcfmsrxGR3mt78
	dvZ+wbmlX8PfNf1fKH/9msLTVCWW4oxEQy3mouJEAKzKaVbbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7phu+enGTxaL2DxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgtJh6bzGwx
	98tUZov/e3awWzx52Mdm8bxvH5ODgMeaeWsYPXbOusvusXjPSyaPTas62TzuXNvD5rF5Sb1H
	35ZVjB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
	pRbp2yXoZdzrOMVecFymYmPLNKYGxn1iXYwcHBICJhLvNsd3MXJyCAksZZQ4ONMJxJYQkJY4
	/GUKO4QtLPHnWhdbFyMXUE0zk8T26ZtYQRJsAgYSD94sAysSEdCTWDfzFTtIEbPAQRaJvtdX
	mEESwgK+Er03FrOA2CwCqhIXVk5gArF5BWwl1v79yAyxQV6id38fWJxTIFBi/t5vzBAX8Ui8
	2rCfEaJeUOLkzCdgc5iB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ
	+bmbGIFxuO3Yz807GOe9+qh3iJGJg/EQowQHs5II75NXc9OEeFMSK6tSi/Lji0pzUosPMZoC
	3T2RWUo0OR+YCPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphW
	K6u4ZDvKKUUuLj69aq3t0e1xKbbrHsyZpfF68Zno1ib3SBl3mVe2zUkvH560XfbkluWk38sv
	z/4c5Xcin4v3lNDNKd7y1xx61mg5c7FbhyXP27w0MMfBYEPMq7+fZO/6vnrWXmd5TtyUcUnc
	VBl1b5e1Qr6bjN0nMRluCg1uZpeW/Bo7ccvdpjm/5/eknuBdZ7ibfcYeN5mjCu1n2t5osc7c
	zrB8UWTp8tKOh385n3uamUmJTvNLFAgzenzqaNz3U20SG/eZGra82R3GXdIhv8a9zrUo2H7t
	pvOvPJ0P6f9n3jA9YY3X0XPfTh09Pul9v8d6vZWlM/vFjz02Mcpw8BX/6iT9+9NiRc+3N2KV
	WIozEg21mIuKEwH9+gNETAMAAA==
X-CMS-MailID: 20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e
References: <CGME20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e@eucas1p2.samsung.com>

Hi :)

> Thank you for the contribution! Did you by chance test it on any
> hardware, perhaps on E850-96 board? Just noticed there are no dts
> changes in this series (or as separate patches). If no -- I'll be glad
> to assist you on that, if you can share dts definitions for E850-96
> and the testing instructions with me.

I did test it on our copy of E850-96. I used this for testing:

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index f1c8b4613cbc..cffc173fd059 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -617,6 +617,53 @@ sysreg_cmgp: syscon@11c20000 {
 			clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
 		};
 
+		tmuctrl_0: tmu@10070000{
+			compatible = "samsung,exynos850-tmu";
+			reg = <0x10070000 0x800>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		thermal-zones {
+			test_thermal: test-thermal{
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+				thermal-sensors = <&tmuctrl_0>;
+				trips {
+					test_40000: test-40000 {
+						temperature = <40000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+					test_50000: test-50000 {
+						temperature = <50000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+					test_60000: test-60000 {
+						temperature = <60000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+					test_70000: test-70000 {
+						temperature = <70000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+					test_80000: test-80000 {
+						temperature = <80000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+					test_crit: test-crit {
+						temperature = <90000>;
+						hysteresis = <1000>;
+						type = "critical";
+					};
+				};
+			};
+		};
+
 		usbdrd: usb@13600000 {
 			compatible = "samsung,exynos850-dwusb3";
 			ranges = <0x0 0x13600000 0x10000>;

I did not post this because it would probably need some more thought,
and it probably wouldn't get merged until this series does anyway I
think? During testing I couldn't get readings higher than 35C, but the
values reacted to CPU load as expected. Also, Marek had physical access
to the board while I was testing it and has confirmed that the values
are realistic. Some more testing was done with some combination of
lowering the trip points, emul_temp and those temporary changes:

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index bd52663f1a5a..8db3f9039e7a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -941,6 +941,7 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
 
+	pr_info("interrupt\n");
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 72b302bf914e..0864179526e2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -232,13 +232,11 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops.set_emul_temp)
+	if (!tz->ops.set_emul_temp) {
 		tz->emul_temperature = temperature;
-	else
-		ret = tz->ops.set_emul_temp(tz, temperature);
-
-	if (!ret)
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	} else
+		ret = tz->ops.set_emul_temp(tz, temperature);
 
 	mutex_unlock(&tz->lock);
 

