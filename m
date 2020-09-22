Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DACF274139
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIVLrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgIVLnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:43:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B5C0613D3;
        Tue, 22 Sep 2020 04:43:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so16673830wrn.10;
        Tue, 22 Sep 2020 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fonzV6H3kUDytr9hBf4pACI65W7dWeL4Kqz5kV0SbFc=;
        b=PACATpXjJiE5Tn32tbKvxzUNsxjvLtHkBEeSydaLlSktZRHGZGAmEYgCPQsB2LOcMj
         EyzHB8IbpkV3QyTISSCpu2WN/3nX9EOaUKOgCjukcZD0mEaMlLgEwFna1A96YovKMx48
         lJzaaA4mQXGiJ7cI1sGqsimp1VAJVymJHweJO6F83r9plm31C/PMaEnDkxKXerccgKn6
         v97eKOHdqt0kEV3APu5xNY9eg8GdxZQPy7GW/NI8oXpsgnBQ3zPVS0dGX/rfjOgvmKhO
         lRTs6TZr+ge5ksz4D2QgcPJLc3dTvxBipjUXCiPYacmbgvOUrN0cqXmT0vRemTH5PJik
         1/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fonzV6H3kUDytr9hBf4pACI65W7dWeL4Kqz5kV0SbFc=;
        b=ln4groWsWIklzxgTFB7K713ei/OSPwlUmtWzAiZL7t+8KgFF/HxqqhC3+EClJmO4Hb
         kZokQJYyatLjK1ODGR1c4xxyVBOIHvQ++RXGa3FZ0JQ1VE+aLmlqCO/q4h42e1ZpkfXg
         KPPIIs6DyxEzxT9C90TJNbRHONv2GUGlKgX5H9lvcFNfN9palpJrEYxpQu7M9yBGostu
         sYE2sysmce5aPYV0ehN5tz3s1VVdJkYl/j3xAq5yMcX/CRyoHIvhUvVpPfzpNAdPpXXc
         CUpPqcUX2+KQv8WZrVuDDd/1urCImjAvfRcsFXpoiAkeEht5Sxo7p7gV1T7D+FlDGMwz
         aqjQ==
X-Gm-Message-State: AOAM531foq4XrGMH7YBQEf8V14xzCL24vEbM+jfO4AS5LvrPm4byIos4
        tdsMksCZHjQtYwlH82b8Msk=
X-Google-Smtp-Source: ABdhPJy+VunF1iDFY7aPqp1/MDwEK8wlmoqgxzwCx5SDsDryUxm52DwAYq1ofpDrl79g+Dz7b6HBcw==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr5173510wrm.117.1600775014282;
        Tue, 22 Sep 2020 04:43:34 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id q13sm28732537wra.93.2020.09.22.04.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:33 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 5/7] dt-bindings: power: supply: max17040: Add maxim,rcomp
Date:   Tue, 22 Sep 2020 14:42:35 +0300
Message-Id: <20200922114237.1803628-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To compensate for the battery chemistry and operating conditions the
chips support a compensation value. Specify one or two byte compensation
via the maxim,rcomp byte array.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.28.0

