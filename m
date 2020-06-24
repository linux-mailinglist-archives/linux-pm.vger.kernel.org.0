Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AB207828
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404770AbgFXP5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404672AbgFXP44 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB36C061795;
        Wed, 24 Jun 2020 08:56:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so4808244wmn.1;
        Wed, 24 Jun 2020 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUKa07WIX4FJ9UC2RNCE+udUH0IZVYqwllIgAs/5xTU=;
        b=K43RLRxVJUYUEKifmRwwtb9VtFl2vRTd0bBYdDk2fRq0txh81+9QrhqhA4MxNOlFvK
         IDi4b59GeJK4FsTrZDYjqBiH+ByGb0EBp37DWAhXAnbA3wrytiNtZR3bsfAekM2LvAWB
         tdghQVGPDYXDSOtX6GBrUSz3I0wazLvnJZ1RsIlLn6ea8LUt+OtQTrFjlnMoZhoazmjp
         kSzpCRnExbta7cbHu72zd8CcrbGS/kxe29snIB2PvTE6uoYpt4AjbsbJ8HS+j2zHgQ4d
         ZeUnTANXgMbpjJ5tNHzrlPYaUeAWF7URyAT/bf2VXfAvfiXfyjEi+EDXUP6ig64aKnDG
         5WoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUKa07WIX4FJ9UC2RNCE+udUH0IZVYqwllIgAs/5xTU=;
        b=elIGyUzWjeDQwj9SRJGn8ryiH4yom86d8KKIHXKK6BCM7faM3xthfQssddI/KYE7mx
         Ln/qgfdL7o9LgVKvxLiHd9FxWjAu3ZBk+1siODX51bngsRQayj7PlaMzqSD71KrbZSEb
         duZGu/4N+utOdvkXchV3TlDEhiNmsYKuue3iXY71Kr9KbMokh3GVmnaUAreoVCGKjNXS
         rwmAGB4Dj39zf9wipDAed76ZBAEZEh7XhLJS831T/itXC1osnP3crUnCDvHoFmtBuwlk
         s2qT+WgmHdrkYiPb9ZE8h8MyS3og/56IyW4dk4uhoazQ9OcQ/1q1Hv/5oVJeXD98nLRu
         QBOw==
X-Gm-Message-State: AOAM532pyx+wAMdfKvoSoJS5821bcrFBDB6O/XW7seylHbi+ZKCUChEg
        DQonF1nXyT4OnzP8dNHPXO8=
X-Google-Smtp-Source: ABdhPJzcxM2i1Qf9RVr14XaBQbQldzvyj7eR6MN6J7NfyO8CWTG4/WFBLRccMAeEC8hRiUOAtbXarA==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr10837709wma.100.1593014215292;
        Wed, 24 Jun 2020 08:56:55 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id q188sm5074344wma.46.2020.06.24.08.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:54 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 4/6] dt-bindings: power: supply: max17040: Add maxim,rcomp
Date:   Wed, 24 Jun 2020 18:56:31 +0300
Message-Id: <20200624155633.3557401-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To compensate for the battery chemistry and operating conditions the
chips support a compensation value. Specify one or two byte compensation
via the maxim,rcomp byte array.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/power/supply/max17040_battery.txt   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index 554bce82a08e6..2cf046d12d922 100644
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -17,6 +17,11 @@ Optional properties :
 				Specify this boolean property to divide the
 				reported value in 2 and thus normalize it.
 				SOC == State of Charge == Capacity.
+- maxim,rcomp :			A value to compensate readings for various
+				battery chemistries and operating temperatures.
+				max17040,41 have 2 byte rcomp, default to
+				0x97 0x00. All other devices have one byte
+				rcomp, default to 0x97.
 - interrupts : 			Interrupt line see Documentation/devicetree/
 				bindings/interrupt-controller/interrupts.txt
 - wakeup-source :		This device has wakeup capabilities. Use this
@@ -41,6 +46,7 @@ Example:
 	battery-fuel-gauge@36 {
 		compatible = "maxim,max17048";
 		reg = <0x36>;
+		maxim,rcomp = /bits/ 8 <0x56>;
 		maxim,alert-low-soc-level = <10>;
 		maxim,double-soc;
 	};
-- 
2.27.0

