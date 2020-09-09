Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46592632B5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgIIQte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbgIIQHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 12:07:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618CC0612A6
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 07:43:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so3883940lja.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcVYXgQ5pttw1IKCDgQFlSKYdGXdwjbBjMlIEbUjqiQ=;
        b=OqjBqEAWPDnfTgGoQjNBjYeKg4K9GLkX+Bw8XJ40eGAnEnptk7yRupxf6JWaCD3JmN
         5RsG/GLVMzpJiJHXxHhGdf2uNA8I5Ti9uw3PbTjKXGjl7tXt/Lh+00q2uqsGRLua4bpz
         c0xwDeKX8dqKrNq1y6poqRfUh+qMciJUiOGJ1aEbPxjGGqtUdA1xchxaDu0XrEBPxg2t
         2EtWKUuNJThIs44LYt4kbj5pee+7qcsqeQorMdD1UcHjN5e7IFGFQAW4kqhOXP47C5sS
         sq40F/txN46g5H8AVsWXBkPwPDLuurGMmnKh5rU/9dl2kro650tFs24zR8g1lE8OeIOt
         cn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcVYXgQ5pttw1IKCDgQFlSKYdGXdwjbBjMlIEbUjqiQ=;
        b=M1jVZAJVWNziihlBrVp6UeAb2HpsxuTXh3v9r1PHFDPmFmtYtqxuA+EWtwW468OEW3
         iWd93A9Uu3jmKFj1OnbvE5GB3iCpPIWXHImwIdmGSSK4pi8RuHKZaSyYIMzm1QpQinUS
         zEqrOMKNP/3wOgnTqYgIQ3mlWHn5Bc9WPgrIgQCiogr/lMeC4kw6yORvKg+8z3KhR06V
         9+qqT2lFCM+JyDRtXk72GPLbhdIq5x5bYrjQ49pm9GPCd+5I+qBFmx7KQTjKSUEihPjJ
         d5gFyC76WzG7WJJC8Uj9NasYtFr7Yu0ovvCkOVT+xRIkblAaJA7pbIExRfehyAcQzKyj
         9CRw==
X-Gm-Message-State: AOAM533LmT7JRxkDf21FDqysXNlSpCAWhpTV7NDv4Wvk0NMpHIk1Vdlh
        VjHmIrvg8xoy4LetY056Pc2Npg==
X-Google-Smtp-Source: ABdhPJyWwfksQxPk2Tnm2ER0m9k37Twox0OGJe88A6KO3gv3HM/BUcjQ+SFEmloMY+FO5ietjnqs7A==
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr2031092ljc.66.1599662584166;
        Wed, 09 Sep 2020 07:43:04 -0700 (PDT)
Received: from eriador.lan ([188.162.64.155])
        by smtp.gmail.com with ESMTPSA id t12sm621665lfk.26.2020.09.09.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:43:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: [PATCH v3 03/10] fixp-arith: add a linear interpolation function
Date:   Wed,  9 Sep 2020 17:42:41 +0300
Message-Id: <20200909144248.54327-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
References: <20200909144248.54327-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Craig Tatlor <ctatlor97@gmail.com>

Adds a function to interpolate against two points,
this is carried arount as a helper function by tons of drivers.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/linux/fixp-arith.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
index 8396013785ef..281cb4f83dbe 100644
--- a/include/linux/fixp-arith.h
+++ b/include/linux/fixp-arith.h
@@ -141,4 +141,23 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
 #define fixp_cos32_rad(rad, twopi)	\
 	fixp_sin32_rad(rad + twopi / 4, twopi)
 
+/**
+ * fixp_linear_interpolate() - interpolates a value from two known points
+ *
+ * @x0: x value of point 0
+ * @y0: y value of point 0
+ * @x1: x value of point 1
+ * @y1: y value of point 1
+ * @x: the linear interpolant
+ */
+static inline int fixp_linear_interpolate(int x0, int y0, int x1, int y1, int x)
+{
+	if (y0 == y1 || x == x0)
+		return y0;
+	if (x1 == x0 || x == x1)
+		return y1;
+
+	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
+}
+
 #endif
-- 
2.28.0

