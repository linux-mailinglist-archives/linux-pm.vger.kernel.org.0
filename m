Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE6100CA1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKRUGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40476 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfKRUGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:06:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so20471342ljg.7;
        Mon, 18 Nov 2019 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTMYCgIgvCNm1q2JaoM7zr2eJ5iQIuvTMHSD1CcRgH4=;
        b=Pmcz5aQvG4kdoLoEesuweo15xnoulLsuqWT1ryquWf4xC5WKJlk7sQdtOvmwi/NpWC
         gTAyERPFtJNkUzqd4x4Y9rBPZWSbynQmALOKWutfXwNS4xK3fO7jjK2GDLacc/aQ4LcP
         +q4GSBo7nTObUfUYvEZA+5mjAci1NekYCRzqfnTxFjX2jCG1NoMyuG0ndkiuNDkNIZw6
         YUmu0ciM2Q5HNUftUJWbOm6oRtbezUhpkApFq69Za9Q7EyPkCVilwY6lLCRBUpkcV6Ls
         ScgNRa7PKIQ7q4LUjwPPhiQtna7RDkugFnxfY8NTockXYQp6rNkhVgPmUdt6uv+EVWEa
         hi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTMYCgIgvCNm1q2JaoM7zr2eJ5iQIuvTMHSD1CcRgH4=;
        b=ZY6eSaY8e7uW164498hB66KPXWcD61EwSJe/YCZ8sD7i9YXOlj0UPSWVQmTkum22Ts
         LgSrFVu0WY6b4uvNg+zwTfG7OCT1eRfbGLYYwi36zL3/Y7HXKAt3PQiNkaJl/o0jl9HW
         KEHFHrdl4JJVNzqlPGJqM/nAHyD6dTC+kE6Sgc05gSMhX75myrymE63zoR+KHcFqibZi
         A3NUCHwGBKAskUiOFEXalk8CfG/6pN79sJ7ng+dM9oF41K5j8P/jkoL6fsRgZnl2SU2w
         Vpk/Zlrqfwf099PiULzd386t4j7kZba3JgcsqcrN6M/iKcKdX8865QxtoUcOEuY79X06
         E4WA==
X-Gm-Message-State: APjAAAWncHhgvV4y31e4aMSMHJ34I0L9SOSoUpYOi1d+XNs31zGkM7xr
        Aw6OcM0++OcCCglDm5QaeEE=
X-Google-Smtp-Source: APXvYqyHgybcG5MMZcJRPRCQEbkIktBAw9M79vtA0GyQaow6feMEG7kPjNrNfppBRmcsYR1tJhTMlA==
X-Received: by 2002:a2e:9841:: with SMTP id e1mr922343ljj.19.1574107559605;
        Mon, 18 Nov 2019 12:05:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 29/29] MAINTAINERS: Add maintainers for NVIDIA Tegra interconnect drivers
Date:   Mon, 18 Nov 2019 23:02:47 +0300
Message-Id: <20191118200247.3567-30-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dmitry and Thierry will maintain NVIDIA Tegra interconnect drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51bf69f520e8..fd82089edad6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8614,6 +8614,15 @@ F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+INTERCONNECT DRIVERS FOR NVIDIA TEGRA
+R:	Dmitry Osipenko <digetx@gmail.com>
+S:	Thierry Reding <thierry.reding@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+S:	Supported
+F:	drivers/interconnect/tegra/
+F:	include/dt-bindings/interconnect/tegra-icc.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
-- 
2.23.0

