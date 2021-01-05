Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847EC2EAAA5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbhAEMZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 07:25:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728862AbhAEMZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 07:25:54 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105CI6sk174780;
        Tue, 5 Jan 2021 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4qVtH+jSjsW5NP/fGJ6PEX3HmzWMveU+fBxP99NEcHU=;
 b=dOZu/Iqt8TTWqdF/SX3RiIfS7tCPPjoPO9CvjXDk+ioO74uoEd6cCXgiTtwLrBpR8gZ9
 K1LjAd62604vyUs0dflCGM7TZi1/dhKgEOsBz7dkhAHlfAqqWQVNH3QkFz4h8Q0zjrrJ
 fd4JLywcZZyH6w0IJCy7rwqQUpJb2lq8v1F/dk46wrYN60nYlYFERwUc0nMmFY43QAXy
 +H7aznxUhUk5yPMCu5GwrE+8lf5+yBGhBxO0Kk1/4tTCOfCUocfgdXLoyhzFQSJXNYai
 w1V9RFFYlwxqBvy0s5T2bu0Li9PvkzSy84Yo8wuSpcxojdvYJmNTGOam3egwEOf3SI0z Gg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35vr05r4b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 07:25:08 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105C86hE010528;
        Tue, 5 Jan 2021 12:25:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 35tg3havea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 12:25:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105CP4Nx41484668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 12:25:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C96A4051;
        Tue,  5 Jan 2021 12:25:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F43A405F;
        Tue,  5 Jan 2021 12:25:03 +0000 (GMT)
Received: from Brahadambals-MacBook-Pro-2.local.domain.name (unknown [9.85.95.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 12:25:03 +0000 (GMT)
From:   Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        latha@linux.vnet.ibm.com
Subject: [PATCH] cpuidle_set accepts alpha numeric values for idle-set operation
Date:   Tue,  5 Jan 2021 17:54:52 +0530
Message-Id: <20210105122452.8687-1-latha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050073
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For both the d and e options in cpuidle_set, an atoi() conversion is
done without checking if the input argument is all numeric. So, an
atoi conversion is done on any character provided as input and the
CPU idle_set operation continues with that integer value, which may
not be what is intended or entirely correct.

A similar check is present for cpufreq-set already.

This patch adds a check to see that the idle_set value is all numeric
before doing a string-to-int conversion.

Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpuidle-set.c | 39 +++++++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 46158928f9ad..b3dec48e7141 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -21,6 +21,19 @@ static struct option info_opts[] = {
      { },
 };
 
+int is_number(char *arg)
+{
+	size_t len, i = 0;
+
+	len = strlen(arg);
+
+	for (i = 0; i < len; i++) {
+		if (!isdigit(arg[i]))
+			return 0;
+	}
+
+	return 1;
+}
 
 int cmd_idle_set(int argc, char **argv)
 {
@@ -47,7 +60,12 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			idlestate = atoi(optarg);
+			if (is_number(optarg))
+				idlestate = atoi(optarg);
+			else {
+				printf(_("Bad idle_set value : %s. Integer expected\n"), optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'e':
 			if (param) {
@@ -56,7 +74,12 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			idlestate = atoi(optarg);
+			if (is_number(optarg))
+				idlestate = atoi(optarg);
+			else {
+				printf(_("Bad idle_set value : %s\n. Integer expected"), optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'D':
 			if (param) {
@@ -65,9 +88,15 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			latency = strtoull(optarg, &endptr, 10);
-			if (*endptr != '\0') {
-				printf(_("Bad latency value: %s\n"), optarg);
+			if (is_number(optarg)) {
+				latency = strtoull(optarg, &endptr, 10);
+				if (*endptr != '\0') {
+					printf(_("Bad latency value: %s. Integer expected\n"),
+						optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				printf(_("Bad latency value: %s. Integer expected\n"), optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
-- 
2.24.3 (Apple Git-128)

