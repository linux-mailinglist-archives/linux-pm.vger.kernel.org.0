Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3101633F812
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhCQSYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhCQSYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 14:24:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62F0C06174A
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 11:24:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p19so2060054wmq.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gPV/OX/sqHdQ821HHfRwPx9/tOVz8LhjhVg6iKPGbeo=;
        b=qS/t/MBV1UGgzD4IbJ9NylnAU/iEkm0s7nU7jJvpYw3IhwUbummfrzLuJJIlHacaVU
         Exv5n5xugxHeN2Eg7lmDfwM5wWRxXdCc+7mUbJit1/kGrkVYazWpq//dZEUeQYbhM7Vo
         jpOvRUpm5Ks7vddmVKfTn0Pt+QqrRCTVI2WAdonOcUjqbvPw2/EE3VMhDWZzaAevUVGd
         3QlxgMvFRFMCIf0sy1JUDSnBrcQctfNw/HjGHotyPCWbJbPxq4Tnug31uqy2E+lfDOyQ
         hLoYBgyJ5/rPus8SroFV4/k34X9RDSTO+gZiOaK0UBCadhBbKJ61R676AWnHN/HBkqgp
         GpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gPV/OX/sqHdQ821HHfRwPx9/tOVz8LhjhVg6iKPGbeo=;
        b=gr0/Zgr8yUjROpcBNAYRnlOzd6JKhFpd2kjoQeK+XKFHniFd/01nl+Ga2ugscCOZMt
         HeV8saU5HKsiw8jJcA7DiN11vO1TeOmJDNCEyHD0QJAkl9pM82SLtt1TagCHhJ8cbzo7
         tJxWHENV7VVaag4lxZCFCfnoOl4Fo8zoe6CXVUJAlBbiFcALFeLgoyrXcRMMEREcxVMO
         hbTLge/ThrFdpA9Q13UCPM58C02SpWtnCT1lf/99Cl+3Qf9LPFtTFA6ImVZA4a4ZHoUL
         TA+dp8BSQY0jsZfAIatCf6xyvIbgCopf8+TZeBYL/KKINykE/U/noj/e/n4eCu4LmLld
         dGaQ==
X-Gm-Message-State: AOAM532oO9d0lTXNOgDXKa+pPAiWmSiuAKdnHlKTg3+lxIABDRxlL5e/
        l0yGglPjF1FomG+lUeVnKIQpreo/qSqasg==
X-Google-Smtp-Source: ABdhPJxrSBkytes7Rik9t8rpNAOK6Z62fmErpKT/2Xxhut6Kr8TfjZ+3dRcecopiN4xk8+8+c2B0jQ==
X-Received: by 2002:a7b:cdef:: with SMTP id p15mr161637wmj.0.1616005447328;
        Wed, 17 Mar 2021 11:24:07 -0700 (PDT)
Received: from localhost.localdomain ([82.142.18.100])
        by smtp.gmail.com with ESMTPSA id r2sm25840338wrt.8.2021.03.17.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:24:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add DTPM subsystem maintainer
Date:   Wed, 17 Mar 2021 19:23:49 +0100
Message-Id: <20210317182349.1055-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework is a new framework allowing to do power limitation
on devices by using different techniques. Those will be added,
improved and complexified.

The framework falls under the power management umbrella, it is more
traffic to handle for Rafael.

Add myself as the maintainer of the DTPM so I can help by taking care
of the changes for this framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..ff7a7a875014 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14315,6 +14315,15 @@ F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	kernel/configs/nopm.config
 
+DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
+M:	Daniel Lezcano <daniel.lezcano@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+B:	https://bugzilla.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+F:	drivers/powercap/dtpm*
+F:	include/linux/dtpm.h
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-- 
2.17.1

