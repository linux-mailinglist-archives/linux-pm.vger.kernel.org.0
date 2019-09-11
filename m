Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342DFAF9AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfIKJ7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 05:59:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbfIKJ7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 05:59:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8B9qjtv128484
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 05:59:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxw6b3ahb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 05:59:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Wed, 11 Sep 2019 10:59:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 10:59:00 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8B9wxwT56164354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 09:58:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC00A405C;
        Wed, 11 Sep 2019 09:58:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8ECCA405F;
        Wed, 11 Sep 2019 09:58:58 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Sep 2019 09:58:58 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, trenn@suse.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpupower : Handle set and info subcommands for powerpc
Date:   Wed, 11 Sep 2019 04:54:24 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19091109-4275-0000-0000-0000036467B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091109-4276-0000-0000-00003876BEB8
Message-Id: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110093
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cpupower tool has set and info options which are not being used by
POWER machines. For powerpc, we will return directly for these two
subcommands. This removes the ambiguous error message while using set
option in case of power systems.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpupower-info.c | 5 +++++
 tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 4c9d342b70ff..674b707a76af 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
 	} params = {};
 	int ret = 0;
 
+	#ifdef __powerpc__
+	printf(_("Cannot read info as system does not support performance bias setting\n"));
+	return 0;
+	#endif
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3cd95c6cb974..c95b29278780 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -41,6 +41,11 @@ int cmd_set(int argc, char **argv)
 	int perf_bias = 0;
 	int ret = 0;
 
+	#ifdef __powerpc__
+	printf(_("System does not support performance bias setting\n"));
+	return 0;
+	#endif
+
 	setlocale(LC_ALL, "");
 	textdomain(PACKAGE);
 
-- 
2.17.1

