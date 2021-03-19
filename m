Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0270F34210F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCSPhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 11:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCSPhO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 11:37:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218FC06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 08:37:13 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c6so7021904qtc.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQ1ckpIxzyK43V/bt1ZmIWePw7DKixuOTINODiwH4kw=;
        b=m14l6wiu+fXwfLllo0iU2RvWRZQ5bXXhrrLKC3wrfszJv/m8GYBpl4TbXgw5UGiKfm
         /pCr6GKlmulJz5eZGSxMmx5/boZ1ZEsUeXc/bVJ535dXZxjhIAj5zkMPcd2jtrnpf1wb
         FoN08eT7J5LEyUex9ZOHi4Vp64CpxXpCjCD/iOggZxRvp+bwiOVKdjp1elluZ00jP/rc
         hJh7n5INvB9+XsGaUDaTluqerL+v0WhWCVZDsJZM8BJskQd297GmQWTUF15wwDPua3LE
         eW+MfXmDgSYpoVi6XTrStFLFhKby4NCNbH2FvVLluO3mfEorX1jv7/ey0MHRzjOhGKRk
         mClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQ1ckpIxzyK43V/bt1ZmIWePw7DKixuOTINODiwH4kw=;
        b=RaFyYG2cX8Re/gzoMn0JO7nRIEgudToohlNT8FuwZJad+y7cU94Y2moQ0av6U98L5S
         +6NDjNCa6BvAZ3Zg5LR9h6MII9NWpMj8Ii1x4erXcKim9iNhhYWwFMZeEBdJT9yXDm9Z
         /N7envGGhlGwEfWKC0Og4tdU9vu4PpKRLpWfXSpFQa55lixuUSF5QZTnO/YxsOxZ/oQZ
         CV1UZMW2GA3DixHP/w0GK7UUNSJffAgNGR6keABbibidPOrPipUnHrffPkmuXD7N/ry2
         h74k2CiNNbRmvlDpoZ2cVS2hviyd7T+tuBR45V0GXtRM3FYsKnQpvXB6P8+aeph/BG7x
         VKSg==
X-Gm-Message-State: AOAM531COspqXlqu+8WGKHV8OpAOdN6SsxvL9dQbdbNTDxZ0NAVhXXte
        bqoLNWFyjpx1+rEHfHexGxRzIg==
X-Google-Smtp-Source: ABdhPJzkFeGmfUoPoXTTj2XkmHXy4A0QGvHxvX86PEAudoYeltGWlEI0qTYWYFa+6SGDGdDqh5mIGg==
X-Received: by 2002:ac8:6e85:: with SMTP id c5mr8485912qtv.299.1616168232867;
        Fri, 19 Mar 2021 08:37:12 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id m25sm3990790qtq.59.2021.03.19.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:37:12 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add co-maintainer for Qualcomm tsens thermal drivers
Date:   Fri, 19 Mar 2021 11:37:11 -0400
Message-Id: <20210319153711.2836652-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add myself as the maintainer for Qualcomm tsens drivers so that I
can help Daniel by taking care of/reviewing changes to these drivers.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..ab66ab9a628e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14892,6 +14892,7 @@ F:	include/linux/if_rmnet.h
 
 QUALCOMM TSENS THERMAL DRIVER
 M:	Amit Kucheria <amitk@kernel.org>
+M:	Thara Gopinath <thara.gopinath@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.25.1

