Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15876146B68
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAWOdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:33:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbgAWOdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:33:35 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NEReL2039530
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 09:33:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqaneq7ps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 09:33:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <latha@linux.vnet.ibm.com>;
        Thu, 23 Jan 2020 14:33:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Jan 2020 14:33:31 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00NEXULA56164378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:33:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0CBEAE058;
        Thu, 23 Jan 2020 14:33:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC05AE04D;
        Thu, 23 Jan 2020 14:33:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jan 2020 14:33:28 +0000 (GMT)
From:   latha@linux.vnet.ibm.com
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah@kernel.org,
        Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
Subject: [PATCH] Correction to manpage of cpupower
Date:   Thu, 23 Jan 2020 20:03:19 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012314-4275-0000-0000-0000039A4328
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012314-4276-0000-0000-000038AE5112
Message-Id: <20200123143319.19580-1-latha@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_08:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230124
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>

Manpage of cpupower is listing wrong sub-commands in "See Also"
section. The option for cpupower-idle(1) should actually be
cpupower-idle-info(1) and cpupower-idle-set(1). This patch corrects
this anomaly.

Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
---
 tools/power/cpupower/man/cpupower.1 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower.1 b/tools/power/cpupower/man/cpupower.1
index baf741d06e82..bdbf089794c7 100644
--- a/tools/power/cpupower/man/cpupower.1
+++ b/tools/power/cpupower/man/cpupower.1
@@ -62,9 +62,9 @@ all cores
 Print the package name and version number.
 
 .SH "SEE ALSO"
-cpupower-set(1), cpupower-info(1), cpupower-idle(1),
-cpupower-frequency-set(1), cpupower-frequency-info(1), cpupower-monitor(1),
-powertop(1)
+cpupower-set(1), cpupower-info(1), cpupower-idle-info(1), 
+cpupower-idle-set(1), cpupower-frequency-set(1), cpupower-frequency-info(1), 
+cpupower-monitor(1), powertop(1)
 .PP
 .SH AUTHORS
 .nf
-- 
2.19.1

