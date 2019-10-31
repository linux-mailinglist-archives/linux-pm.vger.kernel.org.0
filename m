Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDCCEB02D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJaMXy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 08:23:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40548 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfJaMXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 08:23:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id r4so4269247pfl.7
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dics1qLSQG/6LjTjU1Zksk8uqo/tbnnILQwq9HvjeE8=;
        b=BqkSGS3MEt3vqyBV2jt/evjT92CEC8fhA5pKhgaSsQ8tWWeOmTv581aMDyQGGAoM+u
         CizlHBmVS7JFv+AbHdVIc+fwuPNnYDQ5G0QdKchvh1pTgp29tF6A8zyKt1QvwMol/BRT
         p+m+UaMhQoR5c9CeXA4YXY2NWs4lmn2+jxCulIUrfb/1nlgCzquadJ4snfiwfiqBJOO7
         GsgrWxVtEQtBNSBAF4KO2JUtdxh+Jq/nS60cxugG06jl7Yqy+Gp+8LWEd1/z7LVsMtdg
         Ft/z8YOxhFafX9kqa0ciDJBhWo0+vNVMk8217RiU0dh+3EYYDQ8obAO1US0ZTzG8MNEo
         xeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dics1qLSQG/6LjTjU1Zksk8uqo/tbnnILQwq9HvjeE8=;
        b=Lw2Kxn+tqqh76Bg5X26BDylIjxs03T3pyHmvg2THHD5pry0jDnnesE0++b8qQKc848
         2M1x+kkq3dwn37QbEF7UgW45JmZGA5cR+2QDfJHCszGUxjW8TpvT0sdK3d13541uGTmZ
         puMeQyW7HwtW7nF7Ly23/2UdimGcr3W4EQ3ZXbg0ynr4tT3NXL26ezlxdqrelTqDR+Ru
         uQX+Y9SHbXQRFgElpEKX4YJ1dMj84ntVHbxftJg6lRSBLJWJQ8w1nBbmNHUC1cVpmekB
         YYc0mOD4FQ5wjQj+cM5rP8g65NWjvZyxHeSr4tmx37TnYyw7+BX3RabDTt7PdR14ns1p
         6Xog==
X-Gm-Message-State: APjAAAX6xFzD6jkUlg3tv5EPqXlmMtbxr+9arXSWxTzOWvCRtKSSOQH5
        DlnxUsHpRTzXAxLF0MmeZ5za9XMMo9WNGg==
X-Google-Smtp-Source: APXvYqywmmnkq0C9/UxdrNA51atayjz+UUdnkuN6KmsYJy4LVGSMq8xCRtxjvmuamdEq9iWHISdLdQ==
X-Received: by 2002:a62:1d8d:: with SMTP id d135mr6267445pfd.172.1572524632666;
        Thu, 31 Oct 2019 05:23:52 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:51 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 4/5] dt-bindings: power: sc27xx: Add a new property to describe the real resistance of coulomb counter chip
Date:   Thu, 31 Oct 2019 20:22:43 +0800
Message-Id: <b7c373b4329fe7a506890dd4c4c53e73cc64ff8d.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new property to describe the real resistance of coulomb counter chip,
which is used to calibrate the accuracy of the coulomb counter chip.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index 0a5705b..b6359b5 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -13,6 +13,8 @@ Required properties:
 - io-channel-names: Should be "bat-temp" or "charge-vol".
 - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
 - nvmem-cell-names: Should be "fgu_calib".
+- sprd,calib-resistance-micro-ohms: Specify the real resistance of coulomb counter
+  chip in micro Ohms.
 - monitored-battery: Phandle of battery characteristics devicetree node.
   See Documentation/devicetree/bindings/power/supply/battery.txt
 
@@ -52,5 +54,6 @@ Example:
 			nvmem-cells = <&fgu_calib>;
 			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
+			sprd,calib-resistance-micro-ohms = <21500>;
 		};
 	};
-- 
1.7.9.5

