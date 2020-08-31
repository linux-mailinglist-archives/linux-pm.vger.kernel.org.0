Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102525739D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 08:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgHaGRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 02:17:54 -0400
Received: from st43p00im-zteg10073501.me.com ([17.58.63.180]:59669 "EHLO
        st43p00im-zteg10073501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgHaGRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598854276; bh=Qfuzybr979VMJFYuutCB+9GTM8ocBV/zhEcZJGiJypY=;
        h=From:To:Subject:Date:Message-Id;
        b=A9NHYq4gRgTpiFYf1sDY6b4PyXd/sHtJp0p2MdXnqAANZMGJYrJhV9d10i838QBPe
         TUtZltqPACc8HKviGV3CdZAO3uVJn39AwkOEAARkFpG6onblBf7fVVCDk5iVVMJspX
         aomelzYy2iHFCpyX3GLqfKN7POxeFodiC8W39pZ56pQE8FbK+qSysxcKDGelmvvxMs
         Rb+Y/ECut4Ad9+0chm8vEdInYO+Zs3WkN1BECzj4HyLogW972RZH7jJGg9FxryGKHG
         w0rZ7/Y68qej40vb9/Sqg1MK662SxTAjEk7xsL9j/+XxpIl6/snv1CY8TE2kDvSW2F
         PBCJr9bDCU9gA==
Received: from localhost (unknown [80.214.144.204])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id 5BD82AE06E4;
        Mon, 31 Aug 2020 06:11:16 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 1/3] cpufreq: sti-cpufreq: add stih418 support
Date:   Mon, 31 Aug 2020 08:10:11 +0200
Message-Id: <20200831061013.4327-2-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831061013.4327-1-avolmat@me.com>
References: <20200831061013.4327-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_01:2020-08-28,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The STiH418 can be controlled the same way as STiH407 &
STiH410 regarding cpufreq.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/cpufreq/sti-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index a5ad96d29adc..4ac6fb23792a 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -141,7 +141,8 @@ static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_REGFIELDS] = {
 static const struct reg_field *sti_cpufreq_match(void)
 {
 	if (of_machine_is_compatible("st,stih407") ||
-	    of_machine_is_compatible("st,stih410"))
+	    of_machine_is_compatible("st,stih410") ||
+	    of_machine_is_compatible("st,stih418"))
 		return sti_stih407_dvfs_regfields;
 
 	return NULL;
@@ -258,7 +259,8 @@ static int sti_cpufreq_init(void)
 	int ret;
 
 	if ((!of_machine_is_compatible("st,stih407")) &&
-		(!of_machine_is_compatible("st,stih410")))
+		(!of_machine_is_compatible("st,stih410")) &&
+		(!of_machine_is_compatible("st,stih418")))
 		return -ENODEV;
 
 	ddata.cpu = get_cpu_device(0);
-- 
2.17.1

