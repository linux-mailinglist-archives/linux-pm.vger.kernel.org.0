Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2272140DADB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 15:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhIPNPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 09:15:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22568 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhIPNPc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 09:15:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBTAgv004653;
        Thu, 16 Sep 2021 13:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZWnTI+y+7ot9SE0qGAkBokHCgsp0qiZ1totNuu0/E4s=;
 b=ITdjKa6AAwTSK/DQnroAlZdOcJxL7EIC7Gjv9WP+0BbPjl6rKfHwwk12lCpBu4FWM++C
 tKYYxCrLMSyAZ2A/a4J5AoJkQaQWfSbOo/kfox44upoJDAsW9/VprvA+rxGWoExfTWtY
 7JVkocB9TV8efnTkhkXv2AXOEhwJ+7YXwiHDL+nb7BilQHj1EzwF2jSv6p9KOKC6Oo+V
 rMp0YtBRfeqqE9D3xRaxLJVYAyXHXURi9zn/Jw2YCAobdTDNYsuJ6vSgA13Knts3T89H
 0WOfRDhi6fo6LazmFA9ZnpgpNy1gfvnPhDpeZIo/EOdnMYUPAFRL2KTLmdBBd/NwDVBN 9A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ZWnTI+y+7ot9SE0qGAkBokHCgsp0qiZ1totNuu0/E4s=;
 b=YrNtsCHwahgA42cHQb56wcssoWfhoZGqRBd7TArpwMoWfRueQIucR7bM06cobQs1x/oo
 kQbnxVXiN13EN8Lw9CmERTzRipTBoboTL2Xcw3u7W0CqL4XrP6qhYnws3yC4nXmA44Fn
 1anedvVRmh78n7ZpSrngNzjvjIeyqAtyj/sPo/R7ydwUhf0F3RnyuORbHGTC+hscFbCq
 LnXMZfpu4tvbiZH4jpX4d/KKbWLFinuRxPp0PWJCTDt3mlNAC9ZLaxEicd+zDajJscBQ
 E45Fzizw6LLWo/Wu3AjKzRdoafbIE/2kvqo8ZtghIGGfxuG6ql7nqA3uNmoeAEbVpvkY 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7kctq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:14:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GDAU3a078837;
        Thu, 16 Sep 2021 13:14:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3020.oracle.com with ESMTP id 3b0m99au0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVorG9JZTd2bEbXnpdTMciWYvrzkxLPjvnf56ZZS6p40Va0ykgD8AkqEJ7n0Dc7uwkI7DuWYPodK2RSet9HdQOhTPS7M517aQCV8dLk21x85sLTbknbRebuLrcFLbJ1mk7T5MguvsZM0+4BY79xZTK63D5Shd9rw0UQmcmE70RStkkO1srKxINkiYdeXMS/2yCKizN4QPy9rtgE4Te85yoQBx7Wgdq2wy1CxcBLG3lkoPIqeN2Iqu/J83N9BbAWT+4NqMP0AwoZYNRq6VDZWxF6hwHwgDs4Di+T3zlldbdJtO/Sy3xhjz/CKkEb/wZ5b+2wpx4VxwB7k0SPJxvWWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZWnTI+y+7ot9SE0qGAkBokHCgsp0qiZ1totNuu0/E4s=;
 b=exqeeJ1DZs+NI9/BgG592+qFQpKtW/3q/mVyHVlfmfenqYSG7bS1yLpAo6ecKx4uSGuG3Svr+hgjmVBqxNHuUyjnzpmduVjqjfNr9Gg7RqEBYpdhSSrmK/sMn+Eh91jUoEmZ0kQdT6noknYVE8n01QzVattJmiOWnBb8RSCdAf3ob3QHFyS02LpA0BKifAHFnirZIWy0nuv3Iq5tN+CszDKuJ6D6YixcYIXRWW9HF/8fzPmKfZd31JgdgL0/lENV8reBtdciDXtDAt6tz1TEKH/F4qF9nmfdIv89wAktYOzJc+V1TV6/Ch0RM8iVigqbRqeTM4Wu1S0vMN6eQlHmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWnTI+y+7ot9SE0qGAkBokHCgsp0qiZ1totNuu0/E4s=;
 b=Z89jjVUOYLznPzJZPOwvnyu8vSuO8MCs6poqyRsBRuTjtI7M3uwNdGAC+bJFiMHu0hfTQW7tIINKwQUiEiZAG1BzsiRAUH5Kqi0Jjq14Dk6ldSaEtcHAvmZhxZNqNcFqDlrqYmWVsogOTOICndQDBfseIVDUyOWjZJsTmbC11JI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2159.namprd10.prod.outlook.com
 (2603:10b6:301:2c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 16 Sep
 2021 13:14:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:14:05 +0000
Date:   Thu, 16 Sep 2021 16:13:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/core: Potential buffer overflow in
 thermal_build_list_of_policies()
Message-ID: <20210916131342.GB25094@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: PR1P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by PR1P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:14:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7f3021-72e5-4985-abb8-08d97913dbce
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2159B82A2C1270B2BC0D73348EDC9@MWHPR1001MB2159.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/MIc7LC6TbknJJDOuFqCQtpSHWgLdQALbgPQRXBRVDiGrbpufKhj6Ptv/AYn7aCpvKfB0lQi/3BFG7tr3nLehg931W7upCMp7+tVzXohsGjUd7cz+lS/dqqJ7rot+j+vSfLws2AqeTVVmW5jbmhE9TvrnbDK2k2jgUtsLyGG2+plMCs+WJ2HrYUzFJ+urgwTJwCpUt9f5GnXmvIgS62tYbzKjOp4MMztnEztAv/7WdIuh3rDjnQ3i2OSqP6qjgGAbyVvVdf51PpDZbXqTptvLZssPc7wgWzKy76F8uYKFw0kAtfdWCkB9z4ZvQR0iQAn/Cxz/Hv17KlQV9DfCnvKZdG6TH9MiM95x9RP4DgNu0hCZf6lL4BsHQ+UIkt1WZLuw7u/b3MefbODLoV0HGTjx7kzNChkx5x8o6HATgxhWdoSdUO6JdnXugthFXW6C7mheDgvMORz7YQZ6KOqsnVImxVjvJ8qXkuEvS9KW2z0Dmr3N8qPGZSGsLkbMr9KLkI5wi+M3KLTO2ArDcaG+lVqkF/LANbojG/CGrcvsGtNW/RmtWxtAEhzifs/N9ZVNlTULyZWZs4v0mxpwPems+OQf8R+oeDqsb6Uz9XlKg5NOfbfe8/m9ffEekAE28tXG1taqOBmn7iSJxW6uNLJ1J+ArBWsXRDble88JgZjawKCvKfIckWljVI8+x8nUTd9CCGoARGPFkx5POn5gAWGJR+7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(26005)(316002)(9686003)(86362001)(55016002)(956004)(6916009)(54906003)(9576002)(44832011)(52116002)(33716001)(66476007)(66946007)(5660300002)(508600001)(8676002)(1076003)(38350700002)(83380400001)(2906002)(33656002)(6666004)(8936002)(38100700002)(6496006)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAARxr6eYEi711e9YSr6zqPLW7/rbdSynv4l1t3ehW8FQlA1Ebc8+65iiQWt?=
 =?us-ascii?Q?QNY32ePq3dqZUoB5FAFVKkayTggRcl1pLbWz9+e03I+94DkPu0ls9VMJzTQH?=
 =?us-ascii?Q?KGnTWrXC8WLflhcbE7yu79OLWir1uAWciqKl3Jw/qRXSURFIN9EsWDtPeHCE?=
 =?us-ascii?Q?c5vkVLtbbHU2TcEq0O7XFlbzom+RGLHHr+47ARGCmyVYy0OK+Wvmn9d0+q6C?=
 =?us-ascii?Q?QV6wMkLxo4bgkc7rRmIkBCt0iw7lfgC9Uj6F67kV1ZnEHy+FH/Pzbi3PuQHB?=
 =?us-ascii?Q?YhnyBm4GVXC4kfEZiiz7w4XaKQChEBlB3xwtFvG1d4Uz1QyCHF1CoHr/rnQz?=
 =?us-ascii?Q?PK7Y3iFkQEiz1SY9jGG8grx/wX+kNSDx/LZYAj1pxJC5HHmnhmskW2JIvYzk?=
 =?us-ascii?Q?fIHSXGy5Mib4aCO55eYfH1Y+nLlZLCzgnkeRbV2DLfUKq1wTCMmUjZTSIxDK?=
 =?us-ascii?Q?lseFF41FZm/J9bKS7+uu0tZ63lxaRE519hMswuduYJ05MySOqd8UC+S2+EbN?=
 =?us-ascii?Q?+6d2KvbFP6hnOV/zv3Pj8iE5LMz6yozRl93kgPPt5uwBPbanu84HPwkUrbDY?=
 =?us-ascii?Q?T4bvhvJRNo86VjgbnA6sEsoUaJFV3OwpUtUr59W6TQkzxCRPsC9jO+3buG0R?=
 =?us-ascii?Q?GbgLT/zSIKckQH2f1oDn5WPLXfU+WZrxsgRRLsam4bVsHEAo5J/0sibv9RAH?=
 =?us-ascii?Q?KpieBt+w6AN8Y5AyStArmsBxh0Gj6BczWT3EpwVzAM01cdwv/GNUHxvkDMjK?=
 =?us-ascii?Q?c2bAnbOPbMMqT3nqMTDjaqbQ++yco9gBviMhjqg8qj2EEZc2eMRlNn7p8LES?=
 =?us-ascii?Q?sS5CmAsmtm2huAPg6+pQm5tv3M38I96dEMsfI0S947Y4vlq/3URGfp9hRILy?=
 =?us-ascii?Q?Cj7xc/8YUZ9t9AD7AdkLgDP05tNBDpyHO4dYLBO056UUV9yIcmDAErQYQO7M?=
 =?us-ascii?Q?Fw0HE2aurI9rrhSXKbcdDVQXFglNI/OcKvcWkkKh6cYrCd3SOCZUlQgm20/W?=
 =?us-ascii?Q?1iWHDuzYG7Lm4hma/gh6kKSgrhl3ZxGkU70pqRK+QGmL9rFIs/PMQp+sFH6w?=
 =?us-ascii?Q?dGt7TQV7e7pN4Myt04giutyc6gCPUSs9t/RSdLDR9DxGxeYAvaJhZMGEmJ6h?=
 =?us-ascii?Q?mJZfs5I/Pu/P5fsHjxlDIf/CzWezLygUpsTtmaCtXNNfNsZbhVhyMmW2Ky91?=
 =?us-ascii?Q?hcIIF709EtQEOszD0Cz4VpiQFoi4RGG3q/FjYoRtkppxKhqGAYaiRqlVf7D3?=
 =?us-ascii?Q?DKOackXf5sZzw0ibVnlTLHHCOFJb7lQc35vlRFfiXUj+QZqSYVBxUNKvjwA6?=
 =?us-ascii?Q?osVrgUELS1Q1IX+hf7M/sQrq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7f3021-72e5-4985-abb8-08d97913dbce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:14:05.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBUUKyTqYJy13QqMHXzxQ2xQ9IvaCo7tS7WM0sVQq39yfIbgzj/A464bVEDreGsqPZExexOIPgNs3IyrcQZ7sL+gterM/f/moC178jnC/OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2159
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160085
X-Proofpoint-GUID: reUX4BwQuBBQqpiTJiylA6wWa1KX2IlF
X-Proofpoint-ORIG-GUID: reUX4BwQuBBQqpiTJiylA6wWa1KX2IlF
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After printing the list of thermal governors, then this function prints
a newline character.  The problem is that "size" has not been updated
after printing the last governor.  This means that it can write one
character (the NUL terminator) beyond the end of the buffer.

Get rid of the "size" variable and just use "PAGE_SIZE - count" directly.

Fixes: 1b4f48494eb2 ("thermal: core: group functions related to governor handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/thermal_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 97ef9b040b84..51374f4e1cca 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -222,15 +222,14 @@ int thermal_build_list_of_policies(char *buf)
 {
 	struct thermal_governor *pos;
 	ssize_t count = 0;
-	ssize_t size = PAGE_SIZE;
 
 	mutex_lock(&thermal_governor_lock);
 
 	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
-		size = PAGE_SIZE - count;
-		count += scnprintf(buf + count, size, "%s ", pos->name);
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%s ",
+				   pos->name);
 	}
-	count += scnprintf(buf + count, size, "\n");
+	count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
 
 	mutex_unlock(&thermal_governor_lock);
 
-- 
2.20.1

