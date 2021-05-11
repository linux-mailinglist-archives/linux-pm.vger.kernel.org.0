Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4174D379DC1
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhEKD26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 23:28:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2766 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhEKD2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 23:28:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfNZB4klSzmg6j;
        Tue, 11 May 2021 11:24:18 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 11:27:31 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <djakov@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] interconnect: qcom: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 11:44:33 +0800
Message-ID: <1620704673-104205-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/interconnect/qcom/bcm-voter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d1591a2..154710d 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -362,6 +362,7 @@ static const struct of_device_id bcm_voter_of_match[] = {
 	{ .compatible = "qcom,bcm-voter" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, bcm_voter_of_match);
 
 static struct platform_driver qcom_icc_bcm_voter_driver = {
 	.probe = qcom_icc_bcm_voter_probe,
-- 
2.6.2

