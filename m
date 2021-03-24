Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA18E348406
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhCXVol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCXVoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70FC06174A;
        Wed, 24 Mar 2021 14:44:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so35323826ejc.9;
        Wed, 24 Mar 2021 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EysxgKaLoRz6qMaxq/7Ea5iaVnv0Q8ua2gGP/W4HA5E=;
        b=rtAThIhGGCugmXLIt4An8XLkXoPJ+efaC5NTDnjrg1z7X3heuIQzlzi4/bW7fcMyn5
         PPTvn8TWHPMALQ9yxO8SHOVMUoCMbsSA7a/uhgOKwKsVuvXMHnmzsa6ojNni2jA00oPF
         1VFFepBmrnpH9jhYdmeFGsuUTotbHwjSiBvu41s4ux41Djv7UzkgnXoazQ7FORNgEAwN
         jXtdkZpPS39JkL/Dy2Xfq9NFLF3Wm7GOCe516paffG+oZ1AAIqmt12i8Y8m0cu7pXGrG
         uBB/Erkgycbf1wNQmBwx6PXTwD8C2s04ToW0MLyJKYbEcSl/PX06SRN5fLvynM+3OKpf
         mKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EysxgKaLoRz6qMaxq/7Ea5iaVnv0Q8ua2gGP/W4HA5E=;
        b=YA1Tl9j9man1nC/JE2F2cEbO6PIvuNpxR8joXtOzsjsYbDaUW1p+RzWHp2l7UVuEtd
         eZyIgTB3py+Q4ij1MUCvqyge/voDHksqd1Za0XEQcBlvT+DkJKxrFBPOaIuQCxaIDC3J
         O8yRp99I+Ile8t2Ioq4ZUn51Ic1g9XPQyUEAxE0g+WkadnSQy5C0j7D7CDmFIZmQOJS8
         ZrXVweuAtSeEj0qj3gq1n2XtaKjiGeNlMHD3VxK/vfE9sZVPC19V/dpHbXD5DaVmPIQM
         oOphee/E7S6TlucKMFJRRf05Fo3QbB4bisQ1Cahmzt4EiNDtgMtiTxmZdom9k0q9pNzu
         4OGQ==
X-Gm-Message-State: AOAM531IHneTgI/Bsnbvk/qCT1VNrWZflzu/FPL6YT20fYTRxKcLmwXX
        9wSuPbrMkIh2Srl+KL0j7DI=
X-Google-Smtp-Source: ABdhPJyA44CXV2h/MmdMTjPaxxDEEhDCfX99rHLJNJCUP1CBhU0YTm9Jxw3n4ztkRJSScUcMQyXrLQ==
X-Received: by 2002:a17:906:1c98:: with SMTP id g24mr5953911ejh.51.1616622260775;
        Wed, 24 Mar 2021 14:44:20 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 8/9] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Wed, 24 Mar 2021 22:44:02 +0100
Message-Id: <20210324214404.798-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6da567de1db7..df04e96c2044 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -963,6 +963,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.30.2

