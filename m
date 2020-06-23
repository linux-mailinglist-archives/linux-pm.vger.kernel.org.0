Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B895205A44
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgFWSI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733263AbgFWSIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE838C061573;
        Tue, 23 Jun 2020 11:08:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so4192722wrj.13;
        Tue, 23 Jun 2020 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbtJkgou2Sv/07rr10hS93WNcruB7HSmdvjivA4sw00=;
        b=tMkrHARnKddaR8UWmDyAwYMPricXhySA3mGhJUZ3G3FuHVEwjhIzoesy13LjwWZvqM
         bi9s/Tg3wTza6ZLqpBtG67kI+R4T08H+h8stHDXyppCbD3WhxKPuQ/rk3VPkL1EdBQRH
         3VXQtW9/qjpggV7euvaA4Ivafkm4fj4IfwZI6W0ugpakUUlpBMgpII/zjmEw0C9P+ROu
         rgzMOZLlEyDTDfYYgzFFr6iDsH1mGBL/MV73e2GSXCrTZfYKv3K4IwV4MHXTlMC8prBC
         wRl+lN6QQygDatcXUzvLMKHJnbKol/r7fVJyWpda4C278LJ8HzQPbe/soBzuBHtjpZwK
         58YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbtJkgou2Sv/07rr10hS93WNcruB7HSmdvjivA4sw00=;
        b=h1WX9K111pCODiGH+OOEKpw0uD5Q7XOV5grU9xtyHORTvRuDj0JacQd5zY6RPPOT+m
         8roJsLHlt1NSxA4qYciTBHoTqOelNVOiFYMTqcFAz9Ro6cd5S9xV2SlgVcizZKxCdP0z
         iHUpP3wH0RI0CCe7imdQGFdejzoWGdO2Dxj/fBZWmXZlcJmzVTMJb3ydPF9ThZfE6dWL
         q1EkMg60W93stVrEffkPB+eXJcnvjgiy1Z0Tt2VPsqWy6/Nc5+nTyxBDipXlSTtptCFG
         7pdu+sVNGhfU3zIr7sa4AxQyoqTzLGD3VNN9VuoB1ty70UOMRyoj69jml0efdrWxU0EL
         yEUw==
X-Gm-Message-State: AOAM531yCp/4dzHO8UcUj8LeRPoBEqNR3VPspw6g5rS3WXSEWtVV80uF
        paak9gXKz2QqaoeKZY74Hxs=
X-Google-Smtp-Source: ABdhPJwIHeaLsKMAC3sndH10ckS+doecfyDBJU/fW+EBqHQRwhH06Gkx8/ImQUF019F2EkLutD/hqw==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr26392727wrj.227.1592935730692;
        Tue, 23 Jun 2020 11:08:50 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:50 -0700 (PDT)
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
Subject: [PATCH 6/8] arm64: dts: qcom: sdm630: nile: Reserve disabled GPIOs
Date:   Tue, 23 Jun 2020 20:08:30 +0200
Message-Id: <20200623180832.254163-7-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both Nile and Ganges platforms have gpios 8-11 disabled.
Without this, the kernel will not boot when the pinctrl
driver is present.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index de06fa809488..9fe800d547cb 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -136,3 +136,7 @@ &sdhc_1 {
 	/* SoMC Nile platform's eMMC doesn't support HS200 mode */
 	mmc-hs400-1_8v;
 };
+
+&tlmm {
+	gpio-reserved-ranges = <8 4>;
+};
-- 
2.27.0

