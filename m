Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E261400853
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbhICXZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbhICXZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89CC061764
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t12so1315077lfg.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kd2nb9s2Osi8MHIbxM1lxmxPOFNi6CuNMu2QVLL3eSM=;
        b=A0iD2EDzSQdJZv8n6FQutX3dJCkT59Q64Yxf6q6obbCwFZdilR4HHsjrto8qUvxGkI
         oIpYFABP8TeWMJS2neJ5wyk1vCPnAdY134lE/LbiT4QYe90ct1NEGG5Sp6IHoxoE3ldI
         LNRC+Pvw63SaD5SgLTA+5aaTisjPXgS9V95iq6ZdbVHouzZM59bNOnG7sFRgqzFywNtq
         IEqLqntxXcwEuIeaQ6C0ZC2/PUPjiQLNX3t7hadsdxar1wnpixmIZbbiQtSk3twQ3I0F
         IptoKWrIr1kKNX33WomwS5l+mcqOQuSecFoy8jN6avi6bNMRHAaaUuwgZkV+MMmrRzRr
         nUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kd2nb9s2Osi8MHIbxM1lxmxPOFNi6CuNMu2QVLL3eSM=;
        b=h3veMtyxCzmCPjlef3nliOQ5Z2k6scpPjtHSkmk2p4nD7a1KbtjPVTeoC0TdRMLtPK
         HWTn0nlg8iHYcWYth962FzmmCEvEcUUmpJSH1epCCmv48Qs78BCiOE0ck4xZcBUSk4CO
         rqxC11k5sHBSa7GKhZYWIakTPUPJY6+4qr44eTshDWAQ4ZZQFrZsyt98he6myQUINXWY
         R1LUdo83LUssCCl1Gx0iVb8fcAwtKC2uBDkZG9CRCR9Hx1b2768SQbIFnh+gVwG2NYA4
         NKTGY0EjX4Risb5+DRIhwTiMEFqytSET//FzUofbKPFeigbBT5lk9MBSeEQonVdDGryn
         rrEA==
X-Gm-Message-State: AOAM531VNmY1VBZkcoMN69RwCMx+VYyDuaSztVyYnwLHmgE9+5ENLLOl
        HIWk6NdoVuMwf+VAprcO9P2+Mw==
X-Google-Smtp-Source: ABdhPJySNODxIOP2Bfc1YjijH4vbrowWq33m1D+oiNuIvdm3Sef38Fc4KeqIemunD5hQnGntN51urQ==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr953895lff.504.1630711472895;
        Fri, 03 Sep 2021 16:24:32 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:32 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 11/11] interconnect: qcom: drop DEFINE_QNODE macro
Date:   Sat,  4 Sep 2021 02:24:21 +0300
Message-Id: <20210903232421.1384199-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop DEFINE_QNODE macro which has become unused.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index f6746dabdf28..0b53fae089ac 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -82,20 +82,6 @@ struct qcom_icc_desc {
 	unsigned int qos_offset;
 };
 
-#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-		     ...)						\
-		static const u16 _name ## _links[] = { __VA_ARGS__ };	\
-		\
-		static struct qcom_icc_node _name = {			\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.mas_rpm_id = _mas_rpm_id,				\
-		.slv_rpm_id = _slv_rpm_id,				\
-		.num_links = ARRAY_SIZE(_name ## _links),		\
-		.links = _name ## _links,				\
-	}
-
 /* Valid for both NoC and BIMC */
 #define NOC_QOS_MODE_INVALID		-1
 #define NOC_QOS_MODE_FIXED		0x0
-- 
2.33.0

