Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D148118C4B3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCTBlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:20 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36673 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCTBlU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:20 -0400
Received: by mail-qv1-f65.google.com with SMTP id z13so2204342qvw.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52Uodj2SzxJW+qxs/0UIGlzA4a0LVLQTDw34ezZAhxU=;
        b=oam8JWZ3B0HMyyED4XOyqJ7WO+9kN2B2G75Q+shvg5iuMD37rho/XK2LYyggtkp4FD
         WLLv6b4KPs71RyTzlIkjmB0Y+jpXkv5l+VwdFp8K6M4W0sYJgSBh2ubme7mOgNyq6HRU
         ImcCdBD//Tt2lG2ZYrtMXEE2lgL+lhLf6K9l4WgNkZw/lGi4E9UdlYg6yegHDsnoCQzn
         WWYmrB5MtDtpE5dVQQknZYQidYDANdQg/sqlM1H8mMnMDid9eWmKexagz3yJJPdZr9tH
         cSgac8HaxhEhshozUPLK0RuoeD8z/ns2MRFJ2tS7jF7Rl3WVu9xZ7pChvxrBxmqePMwc
         k2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52Uodj2SzxJW+qxs/0UIGlzA4a0LVLQTDw34ezZAhxU=;
        b=GVlhCs95iilh95cuNvi7GBG1f2zotv0Qcgefg8KZlN3q0nT2bj16JEETDx0XjZOf7S
         g+1U5g4yv3F21A46K47Rms0IjJyyReFP2do1+3zUS68BQAukKgkoTR/VBy7flHMWECik
         YXu/LYXksIjdz/197n6Znihd/GAevyFMKlkw+FWaoHC09aFq0j2p5TcQIygLZjJQnovB
         QNBduVQed8x3a40D+2mJF1XuoFTfSR7pIvYxJhF200fHsyr57XbM4hhu0n/YsNQ6I7bw
         hJ9E8ddEiVqO6QPAnGC6BvhF9llMC5I5+GrhxddeBNeFpm95SL5e3m7cZRnwRYw031FK
         VKXw==
X-Gm-Message-State: ANhLgQ1p4ErPgxCTbASPq1Io0o/fjA/E0sefdM69/uD9znYYlYaKqFig
        FDveO0LLXE+h8YjlQxUgOhMvAw==
X-Google-Smtp-Source: ADFU+vuKKFrOz+rjU+KyncwIFd66K8roSktkMf0iaMaBQ+5F+Bkq/JoTPLHcji0jBMA8VXOSEirdhA==
X-Received: by 2002:a05:6214:14a:: with SMTP id x10mr6086238qvs.158.1584668478038;
        Thu, 19 Mar 2020 18:41:18 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:17 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 6/6] arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be used as a warming device.
Date:   Thu, 19 Mar 2020 21:41:07 -0400
Message-Id: <20200320014107.26087-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320014107.26087-1-thara.gopinath@linaro.org>
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh hosts mx power domain that can be used to warm up the SoC.  Indicate
this by using #cooling-cells property.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fe35d37a11cc..0d878b2ca351 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3703,6 +3703,7 @@
 			rpmhpd: power-controller {
 				compatible = "qcom,sdm845-rpmhpd";
 				#power-domain-cells = <1>;
+				#cooling-cells = <2>;
 				operating-points-v2 = <&rpmhpd_opp_table>;
 
 				rpmhpd_opp_table: opp-table {
-- 
2.20.1

