Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE6205A34
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWSI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733284AbgFWSIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCDC061755;
        Tue, 23 Jun 2020 11:08:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so21516976wrr.10;
        Tue, 23 Jun 2020 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJb/Qt78Z8DfdEW8Q4k8rLkSQZ59o11xf0Ra8vOTaoA=;
        b=ZjiZFdgv6Mlt7tW9bGMwcXe5JCCDkexXud8ofkREEEYmcu6QkHtaIBBz/x1Tvqwq1t
         OqRM1XWKnQQQABGjV6x0jVASO+DEzhoxD5/PH8FiTC7w6GklsbDxPNb7IfHzysNgExr3
         S/BawsNvDrzCeZWkEhOdL0BlpPpTbOWnIbjq+5FtuQIdsueEZSKPZ58vLOrhpqy0PWc2
         NZaWzOvCCKXwcS9cydX16CxWjxm73C0phsAvXQgIQtFgT47M79uvx1Qthb/tVkmiC99/
         46WY2LfQIkBchQY3IEJ+IUzHOAJar8PKyKF/TnilhXq/ID+YQGaT+fgXEX5/5BWnoR9T
         Ee7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJb/Qt78Z8DfdEW8Q4k8rLkSQZ59o11xf0Ra8vOTaoA=;
        b=Y6Ka1t/klpAVmSXCOGzcmcmxP6mvxA4BuAl713yWFzkbUntlkRzralaAo08wjakVJr
         MY7z7UDuZWW4NOATQ/6T9kcWKn8fqSZtOVS0slpl4rJC/1uy4nf/kSURNyf+MyUtiz9t
         3pPr0lDhSZ05Fe/QK9zd2g5FH9L0/ep14vj7OCkmpQSlQrRIZmYRf/T58Jk1nEMhIyz1
         o8dJmGvhFXq6+brao9OXccmDqbnM4YvJLlevndutS5enrU6OD1NtCPODdWysEL2862hq
         k+cAx844jFJVe277Vurvs3mpt9vLtU4NdO6CRYsLyPzYfUJAp9y4kb48QSm1RD1OGfMX
         3mTA==
X-Gm-Message-State: AOAM530c0qOjGdMHGb708So+npmZKJqBizl9BkJ4MxN3yZz6QT9iSYs3
        o+d9/0oG6lHbOOL3bR6qBio=
X-Google-Smtp-Source: ABdhPJwKbNHj7fxZw6W0flIpjCg5w0QrmDUyVyAjAgJ5owo2FB2xcMGrmJigdwLxPwfrCF8PiCLs8g==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr1772034wro.422.1592935732911;
        Tue, 23 Jun 2020 11:08:52 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:52 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: sdm630: nile: Remove Volume Down gpio-key
Date:   Tue, 23 Jun 2020 20:08:31 +0200
Message-Id: <20200623180832.254163-8-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the driver crashes with tons of
gpiochip_irq_unmask+0x30/0x40.

Removing the key for now will prevent the
kernel from panicking, so that the development
can go on.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../boot/dts/qcom/sdm630-sony-xperia-nile.dtsi      | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 9fe800d547cb..3646890040b3 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -63,14 +63,11 @@ camera_snapshot {
 			debounce-interval = <15>;
 		};
 
-		vol_down {
-			label = "Volume Down";
-			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
-			linux,input-type = <1>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			gpio-key,wakeup;
-			debounce-interval = <15>;
-		};
+		/* Nile also uses gpio-keys for
+		 * Volume Down,  but currently there's an
+		 * issue with it that has to be resolved.
+		 * Until then, let's not make the kernel panic
+		 */
 	};
 
 	reserved-memory {
-- 
2.27.0

