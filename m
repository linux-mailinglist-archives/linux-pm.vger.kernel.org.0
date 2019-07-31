Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCD7C0E0
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfGaMOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44892 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfGaMOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so69404215wrf.11
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BOF17YQQWl12xZ1QhY8MZFUcVRdvZruqxl9AoPVourc=;
        b=KOwU/VDLfH4d9hcV47fA2w/uqwOYT2FS68Y+GEZgeAIxQeMzox1GTF+0nrmfbwgok6
         lFKgs6HQrZ5vHJV79TS3uRpfM7LBBpF/8oOwgSPwJoZn4uSGVeyYfnWNtxTN0cCnSKnA
         fwLcqzDLNkSmAbYJFRKWbisb1VHFrT9BBYe1njiRWWCpIVjSFXkGFjmG8l7ix6YGmBuO
         jmb5mztHtAF8AeFgsBIRAXSHH7dLXHH2WTPiyN1yejHwdxPZrwqe+2OU49FlyeZkQ6rT
         E+OVoUnb/VSTVGanCM84e147CCmhwhG/RaHrkLmA2+q2AMN+jbaHINtHsTQGrCX8cYtO
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BOF17YQQWl12xZ1QhY8MZFUcVRdvZruqxl9AoPVourc=;
        b=Qg+dGn5WtaC2zYfNqeh7qPgtHIjRvPKGG5Xt0fAKMZW878e9IIuoNoIU6SsLUUrynI
         Wr+r2ETV2iQNKEjqDvMFSuUYR9sdEwb0O1J1+IZAXgzOkkyUQRKi2ztatrJLlrDpa0Nh
         MR53RV/IL09d4VgXqEBcysKulCsg39LprNqyxaQFaviwX4cSlGd8v8nCxNFYA6yQ7iZa
         TsrrEd67odQZlCN7h6dv+AbT4VXNGOT/zK3SFtlll508BEdSEOCcBhNdBB4pnLriJrmZ
         ORVRZjb3fw88do+iGeQO2rJcpD9riF203RC8QBld9dVO+XNiNgDUVJCouLB9K0yafuJV
         9wKg==
X-Gm-Message-State: APjAAAUK1kfja30pdKmoOlKLk83aqbAsEHckZTOpE4hTZJjbf117xg5C
        SaF7KJFOgaiKkvv5CCnKGs+xtg==
X-Google-Smtp-Source: APXvYqw5Af6krHH2u8yfiDYnUo0PUK03ieMfQQIWsJDDVp5cTQO8+Z6dt5o79L+VaM5ofBQMkgnbuQ==
X-Received: by 2002:adf:c803:: with SMTP id d3mr61363995wrh.130.1564575258197;
        Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:17 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: amlogic: odroid-n2: add minimal thermal zone
Date:   Wed, 31 Jul 2019 14:14:08 +0200
Message-Id: <20190731121409.17285-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 81780ffcc7f0..4bd8d6d0c972 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -20,6 +20,19 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		soc_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp 0>;
+		};
+		ddr_thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp 1>;
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.17.1

