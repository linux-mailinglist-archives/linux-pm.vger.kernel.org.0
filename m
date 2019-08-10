Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413198876C
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHJA6y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:58:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35102 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJA6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:58:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so97650481qto.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CuxrDfYHX+eqS5X0AI2ZfNX50adsNBjzE4KO2XDlGmw=;
        b=wLJ6COGi00EZzVvhlzI73V5txQJk5y+H6rWCcKlD954xIHUCfP8m2VYviThMqxBojP
         4vib4/Y4ETOAh6PlCNzNGhIXDLUuWMHQFwyBzoQk7RYn6jHlfJlq67AJ0fgMGI0t0yok
         2EyCycA76rfiaJAMaIk/rRQGEa74kWvRUJGTKo/qmU/nCkmNioxAHGo0XlWLfIPwTEgl
         oo5Z63gEJpR+GPEcVm999m+ms24PwgY+CGjMzz0SCH5bML0hHA3kgyp9zrMiRVnTgAsH
         bUk16dImjWgHom1eTH7oiju2B43/z+RtntSy9shtBqRzVryuolfBSaogj4cAZZH5ZZ4C
         y3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CuxrDfYHX+eqS5X0AI2ZfNX50adsNBjzE4KO2XDlGmw=;
        b=Seob9QGRZs0UeL5Y/uS9fNsSQoBSTcgo0Z0hnOXJ//0AHJaKlOAGnB47/w0BS0/4Sr
         wOCDWg6U/kSAFvwKJrKP1V/dRWyUDMJwChyo9uwYHY3qd/brP4C70IwkDmVz5SbFl2O+
         D/Aa6c+V1u1hjPnaYQZsNA7JogVTje0wxeUtBpzAyMNBXjtrLE3vObt1QPcNR6dy7RFl
         RvZ+M8/cdywqHmRmt6WcKh7KGsAZmGsfjgjsHKWZyq1KySgUMPR4fpwGi+o5i53PkGEQ
         YUETu45kcRRYZ/3wVYP0UrlRdXj3ZuECiSA3GYHXyToUkXX8qguEnBFGyXnx7dU4btiR
         YBRQ==
X-Gm-Message-State: APjAAAW9A/fDhsBTM0dXj+e2irJW2cN5v5piHY1oBNnym59CcSG/9Z1M
        DbmApTp2nM6i17lPANjy8tiT1g==
X-Google-Smtp-Source: APXvYqym0VKtSznFP0fe2fhj1MWj+0eP3A7FDjWXXlNAntNZTMw5e6o5lDQ1CCB2qP0C5RDVYY9uTA==
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr20116512qvf.93.1565398733254;
        Fri, 09 Aug 2019 17:58:53 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id t9sm4603105qtr.29.2019.08.09.17.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 17:58:52 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
Subject: [PATCH 4/4] arm64: dts: qcom: Extend AOSS RPMHPD node
Date:   Fri,  9 Aug 2019 20:58:47 -0400
Message-Id: <1565398727-23090-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMHPD hosts resources that can be used to warm up
Add nodes for these resources for sdm845 (mx power
domain).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d0c0d4f..c5b8459 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2602,6 +2602,13 @@
 				compatible = "qcom,sdm845-rsc-hlos";
 				#interconnect-cells = <1>;
 			};
+
+			rpmh_mx_cdev: mx {
+				compatible = "qcom,sdm845-rpmhpd-cdev";
+				#cooling-cells = <2>;
+				power-domains =  <&rpmhpd SDM845_MX>;
+				power-domain-names = "mx";
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
2.1.4

