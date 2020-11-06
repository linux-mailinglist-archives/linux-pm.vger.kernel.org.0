Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662612A906B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKFHeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56246 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgKFHeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:16 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WAXQ024861;
        Fri, 6 Nov 2020 08:34:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=inRp6hPiIockC5nS3L+IsnkrSlcfoBjiyTAc2cHofEM=;
 b=e3xbnbEsdALKCaLVYR0ePYxAKiq/CS9GP9aC5E6L2v1pKb7p7OHLuD2geGnpSqc0OxLz
 F1opHCYdcCuiECzxL3CmTfrm8zUZqX6Ecn7SRXd9VK29bdPCfN3pKeRtDWoGM8Ng9OWM
 34GTLIDytrSS1Zz3neDHr7tyWL+jU39Md1wuINXWTC1lZ2z2P13GLasPcYgDmMUfbGbJ
 PURIZVjDlFElxPoNKw2xBIuvksvW/JfueZQnfZx2pdyjk6dURmv4T4smW4s4QwKf/CL1
 6KHARCRHZiIJY3A7KrxblNAYdJ7ME09hlMIjlmyOhJIsD0ypGf/Tq9mhJY+fUdFISz59 DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00etmnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:34:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57333100038;
        Fri,  6 Nov 2020 08:34:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D087226678;
        Fri,  6 Nov 2020 08:34:10 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 08:34:09
 +0100
From:   <patrice.chotard@st.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
CC:     <patrice.chotard@st.com>, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <amelie.delaunay@st.com>, <erwan_leray@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH v1 4/4] i2c: stm32f7: Make usage of dev_wakeup_path() helper
Date:   Fri, 6 Nov 2020 08:33:58 +0100
Message-ID: <20201106073358.8379-5-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
References: <20201106073358.8379-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_02:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Make usage of dev_wakeup_path() helper.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index f41f51a176a1..9aa8e65b511e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2322,7 +2322,7 @@ static int stm32f7_i2c_suspend(struct device *dev)
 
 	i2c_mark_adapter_suspended(&i2c_dev->adap);
 
-	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
 		ret = stm32f7_i2c_regs_backup(i2c_dev);
 		if (ret < 0) {
 			i2c_mark_adapter_resumed(&i2c_dev->adap);
@@ -2341,7 +2341,7 @@ static int stm32f7_i2c_resume(struct device *dev)
 	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int ret;
 
-	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
 		ret = pm_runtime_force_resume(dev);
 		if (ret < 0)
 			return ret;
-- 
2.17.1

