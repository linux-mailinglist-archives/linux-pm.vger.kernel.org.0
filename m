Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84A2573A0
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHaGUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 02:20:22 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174]:39087 "EHLO
        st43p00im-ztbu10063601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgHaGUV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598854282; bh=cmlnmNfbD/rroShDMwgyVMctfmxpMukvVmgwJORb28g=;
        h=From:To:Subject:Date:Message-Id;
        b=pzyZZHcsfZK/JDbwckEYbpkNH6gIxTU94/tBs4d154k1S9qvXpNEbGl1/YEi84EX2
         RK6/b6jMSWw3RbgKeuQnWsOuWHdXfZLqnSdHnhfCWngRb0FuC+7UHahJlKyV/6FoCG
         eDZR/ehe+o8trndAMMinnWzndj2Da3MIdvx7m8iM+mT6kW9d3r53LY3OYzPMDKVhza
         bsbeQ9mh+yrORjJsXIwFUHMbVi3YLF2Gf0VAzmLj80E8YFJX0/yHlojkQR1FLEyjus
         cziB0zYkYP34YqpxDFt7XA9yNcc6R/+C0Ai/SMo+eh5nn8M28ME+O9uOcaUBGUx9Lr
         e8O1/p0EK58yw==
Received: from localhost (unknown [80.214.144.204])
        by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id A7A197002EB;
        Mon, 31 Aug 2020 06:11:21 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 3/3] cpufreq: arm: Kconfig: add CPUFREQ_DT depend for STI CPUFREQ
Date:   Mon, 31 Aug 2020 08:10:13 +0200
Message-Id: <20200831061013.4327-4-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831061013.4327-1-avolmat@me.com>
References: <20200831061013.4327-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_01:2020-08-28,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sti cpufreq driver is relying on the CPUFREQ_DT driver
hence add the depends within the Kconfig.arm

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index cb72fb507d57..bf5830eb664f 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -283,7 +283,7 @@ config ARM_SPEAR_CPUFREQ
 
 config ARM_STI_CPUFREQ
 	tristate "STi CPUFreq support"
-	depends on SOC_STIH407
+	depends on CPUFREQ_DT && SOC_STIH407
 	help
 	  This driver uses the generic OPP framework to match the running
 	  platform with a predefined set of suitable values.  If not provided
-- 
2.17.1

