Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42EB9AB00
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfHWJE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:04:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56102 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393380AbfHWJE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:04:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so8202126wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=GmV8Y1qAC14OzfTnstiQTLtSRJ4eKTZc3RCsEia7V/22Us2/TJ6DvracJKrPIOyt0V
         XSWI5ru9VfHDziUruw6sVNCura20aXsw6/OFD+G8Vl6ER+1uaJK3gjk/bs9F/JOojCnA
         NQM6+A3A4avL9YZKxlcRqquhPsVqoR2MaOUU6Su+2xeJJYA6vFWXsv4T9cfqlBvrU3Qw
         7+lilrgMdKAYBbmZ/U/p2dANT24xBrDEr8LHFqmDpq9O5q0qrGywSyMQhqIlGJy4yzu6
         05x1HRk2ngC9gFNXeDvtN3UR39CssrFA71aRJk/3PQR39v+lXHrEDfef0SLrv6ZG49M6
         bK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=bX08JEwNPc9kqIbStsOgkwQ1xCUFyO4cToUpBk0xwMpHzimvPoPesoB3vv29FqVPUM
         pnv6kFI6L3I3OxtDggqeOt4N4cZ+h3N/26sb/mzpJ4iNjtcLFmS7/00tiMJuOPSHWIRP
         Cm6ataCnTPcj0QHXGDZQC0wbSgT7xCogliu4X3lJXPT0cBAJ36Oto6evS1uDmbX8yJT/
         jTv4/uwODKKLyoZ6K4E6QdjhtG5N9s1dFhawCOYL2kYEj7SioZVqjZiQD08aGtXUlMhy
         1LrHatLYVh7HDLKPhSjPos3uybBMcoy0KXvIpib4ARrw/vh6qPSFLL3AcXpMXPlP38c9
         PFfQ==
X-Gm-Message-State: APjAAAX4h3ZM98P/2ShgxqjhRSU05wXnEfAfbMgwRqNswmFWppZ606Sa
        ZulLaOzAbrxxE//m7mAlSZDHgA==
X-Google-Smtp-Source: APXvYqyNRvGj3V0YbEVMpMvc8XkM8d3DsccgAZV4aJwajw0WiCJWsTm7i1pRBnGymWb8H802qYaLHw==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr3941416wme.147.1566551065315;
        Fri, 23 Aug 2019 02:04:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: meson-sm1-sei610: add USB support
Date:   Fri, 23 Aug 2019 11:04:18 +0200
Message-Id: <20190823090418.17148-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the USB properties for the Amlogic SM1 Based SEI610 Board in order to
support the USB DRD Type-C port and the USB3 Type A port.

The USB DRD Type-C controller uses the ID signal to toggle the USB role
between the DWC3 Host controller and the DWC2 Device controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 66bd3bfbaf91..36ac2e4b970d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -321,3 +321,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.22.0

