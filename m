Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F126D199
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIQD2d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 23:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIQD2T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105FEC061797
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so886373qkc.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOjR8vxr5WwVeS1m/lfV7tbojY1ErwXvE0dsI9QW/uo=;
        b=kPWL4eCuolVXw35vyUzORP0/S/rIAepUZMAvp7ZZdAhaDRpkH1E25kh74NGxkqvub6
         EHm7NsrHU7o8gAX4/7USoUt2l7awOKN6znJPoujEb9pcEkXkf6C0D+fZuW4s0eA0dKsL
         pYXjrlIcUsEe2LpunJ4kvAnWvvQSJ0NCJSXQ4dZ8R62GQw9TYY0cgCnEM+cmgHMfsMIu
         kLYLB+SnzfkuWKUf2lRGiJxt4TWy94+YT0h203bINrOr9nJvTELxnsSvjonnFlzPTfwb
         wyJcbIu0O1rtvGkQT61nfZ0I77Foo3LV8MySGrc2Vvt7r7QD1ULzvuaTFiGDgnFfq+/5
         DTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOjR8vxr5WwVeS1m/lfV7tbojY1ErwXvE0dsI9QW/uo=;
        b=mOMHmR+h6hgFg8yR7lHsPZQuC+VWfvqre/78/M6UESgzy27K+MK7K0o8b9sdtCCe/E
         qouDzAk9KUXHoyNJ/HyExSwFi2+CSDhLs5iLmxAd30g+o8Fh8dBcJKAEJHuysGk4EhNJ
         W6L6F9ihMdnxvciHpCG1qBSN8Ne7/+8jsp+ig1fyZOlLvC7ap4atBfjYQrey3uBnOp8x
         OPmpWfrQcSCjsOyvPI5dxndGz4wcFsULt8RqxPZ8AkOvCnXuOUAR0Iv7XNXBwa2hDDUb
         lcKDMnMgumPYZ5MbIw5BlK3qene5bG5TDsBV9aKcH78LvZWK6r761HYNuwKF3MxC61WY
         hs2A==
X-Gm-Message-State: AOAM530qHH7zVqWSbMeCwtZGZw7kI3vgJG/qqg0XLCu/BEoGSLbIlluJ
        cJXxN31psbdJZD7blBz4j4Df5g==
X-Google-Smtp-Source: ABdhPJwrZ4vSxdjRvdBIWTFXormzDUQW/UqI1T+x0gkPM8a4jmLPzyFxrDQyZ0xg8jAV6ESq5T3LxQ==
X-Received: by 2002:a37:5042:: with SMTP id e63mr25056428qkb.453.1600312948930;
        Wed, 16 Sep 2020 20:22:28 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:28 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 1/8] dt-bindings: thermal: Introduce monitor-falling parameter to thermal trip point binding
Date:   Wed, 16 Sep 2020 23:22:19 -0400
Message-Id: <20200917032226.820371-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new binding parameter to thermal trip point description
to indicate whether the temperature level specified by the trip point
is monitored for a rise or fall in temperature.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 3ec9cc87ec50..cc1332ad6c16 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -161,6 +161,13 @@ patternProperties:
                   The active trip type can be used to control other HW to
                   help in cooling e.g. fans can be sped up or slowed down
 
+              monitor-falling:
+                description: |
+                  boolean, If true, the trip point is being monitored for
+                  falling temperature. If false/absent/default, the trip
+                  point is being monitored for rising temperature.
+                type: boolean
+
             required:
               - temperature
               - hysteresis
-- 
2.25.1

