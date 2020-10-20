Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE896293F1F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394434AbgJTPAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394426AbgJTPAj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 11:00:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D1C061755;
        Tue, 20 Oct 2020 08:00:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so3226699ejg.1;
        Tue, 20 Oct 2020 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lpzg9E8YWdWK89OKI0wDEPTciVMeI/Mc2lVQsmauyiQ=;
        b=AtVDHiNhB5QqIX/4UrS7Qglk6aEyED4HAimw0AZw0X0G6fg2yRBXpFcStUMIPcEI/a
         9Km50n5N3M8XSV3c0bJ1Dg4yMNj77x+Zzm33YhSv65WYOL6MDlIgT/MYSFZSHpEHmWT1
         t+O/IP4iBUNZMzoYAGalOECgQDKoB/o8mj+Gxni2b+xSlHqjsHGy3pD3SJ4F4mDGqqyn
         ODJvm53NBO2iv0n9dbBI5mUUzzjaadBRQgwyuiIgXV7TQnau5CSe08umH6nzumjMwG9p
         5cAMfsZigEVKZxn9xQ6m1JhuXUEkvrTBA3OSayPTDWxyHMZ03zIqapfk1hN7Xea97pdp
         agjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lpzg9E8YWdWK89OKI0wDEPTciVMeI/Mc2lVQsmauyiQ=;
        b=JHPhenD1fiRxFFQ2nTONDVzeAM8N1XjUgo7KDFhXKx9zJ7oQGnOGoma2WGrrXalP26
         nDmjEiXeMXIW8ysA0OEnKSLqb8DD/Zg46p69rkKyYgiNGlQfFOhuyJGO2MKiQAOhFg1I
         83ULvBfzeAESeokhU7JMFL35GaFAroKqi2cU49atHDjk3jLVkSkIbbUb/UCET3/iVjP5
         dR00oXtAOuR2cmXPz1V+VtYyeMdJ/ZmpuLp+Aia5Q1XdpMUSqlOdqmbMU4ryQ5E+FJGC
         IPCe1FM4Hz+KVxRQMt8gVxpda4bxJMtsMmSqKFwC42PmfCoOBCTQ9T38vNDF8jqWFJMO
         7mQg==
X-Gm-Message-State: AOAM530FLZslvAsMFjJPJGlcPE2MOlsTIacrJiZs2fKTubr7iqF9SyPO
        iw58imvheEcojvw0+kCNH2Y=
X-Google-Smtp-Source: ABdhPJzUUEMZvj7TEnNmHaiOOY5v9AX7Gx78BcF0/d6r4vblUGqYrEES7Fefoqk2GByHsch/PvtcLg==
X-Received: by 2002:a17:906:f298:: with SMTP id gu24mr3549205ejb.53.1603206037928;
        Tue, 20 Oct 2020 08:00:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b900:df40:185:7e9a:74c:2d13])
        by smtp.gmail.com with ESMTPSA id t3sm2699564edv.59.2020.10.20.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:00:37 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH] PM: Fix typo in pm_runtime_set_active() helper comment
Date:   Tue, 20 Oct 2020 17:00:27 +0200
Message-Id: <20201020150027.27392-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

This patch is to fix typo in the comment of helper pm_runtime_set_active().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6245caa18034..18b02dcc168e 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -479,7 +479,7 @@ static inline int pm_runtime_set_active(struct device *dev)
 }
 
 /**
- * pm_runtime_set_suspended - Set runtime PM status to "active".
+ * pm_runtime_set_suspended - Set runtime PM status to "suspended".
  * @dev: Target device.
  *
  * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
-- 
2.17.1

