Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F172329A99F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898124AbgJ0K1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 06:27:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41703 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898122AbgJ0K1f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 06:27:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id p15so1119418ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCvescP5dSLVAXgQnwSOh5I7PubzBY6cI1Voa43IB8U=;
        b=pZEfMD2yDs/S/7GgBy1MMnU0ghnX+IObgLHS9qlIl2ZMZfmGzdIPVyMd4KvYbGBZaM
         BIL4x0CTu5qkw4jLyFrJ26/wuI8Zhj8AO6BLjMv/joKjahnAvBYjGSUU5CnMcAL+uHTS
         A4WHR/zHi4S5jhaeH9LJYvydozZHo8g805YaFpSCSotoap0MzP/BnHZvEEAJL5m/E2ss
         tI3I4IVeLfvJbCB7nIzNX4clXVxs7haNpCgcG+IpJccGUIkBO2JOE+EJw/W5zThoI3WG
         HvjTi/KicQP1mdtGTCq/xsb94MLMjt2DRrjimgvDUkSEeUxdLXoWMcaK80KVA46x7bjW
         HdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCvescP5dSLVAXgQnwSOh5I7PubzBY6cI1Voa43IB8U=;
        b=BpAbBjaKyBdJbP2PZBnd/K7gKu6zVqOfRlp3bXCkMMCWh+lZOcUvyetiyyizDCffN+
         G3Dj/Fco6fTBzs1H/YQtCGDZZFj9YgckV08SvAXwCCwHhePsBMD687/FuUHpGu8MoSgx
         DgcAYA5DIdyOKvdDEdKfIT1IflfFHEpQqccVN9on4KxeQDxbL42dnFnZHLUt7jR+vpR3
         KsWiEvgtE1X74tR4jJykYpQ2SNbDBhuDURu/nb2JUfE8ppeUGvMJWn2rjPUThZGxGSch
         9SMSJhU8xR1yC+k9Chs3/qiNDHsEgo01+/x26drfnUvBnd2HYHrIxlkYwb1k+ni59sQI
         Etdw==
X-Gm-Message-State: AOAM531kS90+F1l1EYalv6AU1yaA4c4KvZIAW2HqqIELxy7jA7X3sft0
        tgF6oweHDY3X0Hip4rajJvrBQQ==
X-Google-Smtp-Source: ABdhPJyioIK1VSWaQI4/Am6kRTzmspO6F/aqyjN/dRPjtHLtuKlZJoRBgyvyVGMo8GSOthOqMGYXuw==
X-Received: by 2002:a2e:b558:: with SMTP id a24mr738696ljn.328.1603794453902;
        Tue, 27 Oct 2020 03:27:33 -0700 (PDT)
Received: from eriador.lan ([188.162.64.248])
        by smtp.gmail.com with ESMTPSA id l6sm129686lfc.8.2020.10.27.03.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:27:33 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: use icc_sync state for sm8[12]50
Date:   Tue, 27 Oct 2020 13:27:31 +0300
Message-Id: <20201027102731.951421-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In addition to the rest of Qcom interconnect drivers use icc_sync_state
for SM8150/SM8250 interconnect drivers to notify the interconnect
framework when all consumers are probed and there is no need to keep the
bandwidth set to maximum anymore.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sm8150.c | 1 +
 drivers/interconnect/qcom/sm8250.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index 9218efed04a0..30fb6567fe19 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -627,6 +627,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 9b58946f7898..49c5ee2e70f0 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -643,6 +643,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
-- 
2.28.0

