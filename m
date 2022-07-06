Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB86568B29
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGFO1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 10:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiGFO1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 10:27:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D98720F75;
        Wed,  6 Jul 2022 07:27:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E4alg009659;
        Wed, 6 Jul 2022 14:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Rjxzm3ckdi8sqaRWhhfLeeC68AZnMeSDIKBFRakrxgQ=;
 b=mQn+vUSqnDpZ9wQhlBOic8VecygQ5j2MF6UQGwnWOx7+oZt7ef/orQvqGMM2KsKa1rtz
 jGuwPQkRVxlncSQ4AplZSfXYlBOtDKm5HzdW8D+iMRuj2BTP2PkRXkOxmQ6RL0h04wY2
 tT/d0HmnTx+6CJWwPASNXckPArE4OH3/gj+jmE3fJA1RwGRDKlWgdN3tApgWFXnVotJC
 OzKjCfEO2rA/aeAIh7DcRKuxg+oSuokGDM94k1vGK4h+yGxHHyof/K6GoKbFDGlU7Fpy
 WZ27nnj794raO8synkxddwKATHDwlPjIqzSesjbs12/TLtd9lVowPh5EE6rkOeRsS1/R xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubya66e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:27:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266EFIvb015471;
        Wed, 6 Jul 2022 14:27:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud5uks9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J63YhcFFjpQHji2k7fhZEzZH+MCAvBFHlgFUQCjFY5FePofWFQqYSHMsaylRI5d5fxaYDCyBI5t5fKRovKULkgrI/ZQGEfkbO9Oeo/qP56oxlaFfaZF1pQo6/chNhO+OuU2XV8Vb6+1u1fOzn93Kze4uzl44OBVm5u973sLMGeOjonPCXCR+A9mVLDmo6Tni5dW1CtO25vldf2BdVuHa+JEbEXhr83Z3IxBnoRLxnXg+OOG79HL3i8WC8jdP63KKFzsSvws0dPaSFrXGYh4Ecw4YI88vuLsV5ua1MvXYMzXGxGiWUqfCmtSpf8kdedYcKoyytAyo0r+aDNVXiKQvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjxzm3ckdi8sqaRWhhfLeeC68AZnMeSDIKBFRakrxgQ=;
 b=hs5wVA4dCSGGsK7zQPC6NyQ8uPUrJm5DyrlNyffOr8mwVP1BQixejctFjS3PTIKM6qWkLZ7VT0WLTiYYEGewJYTM6H1HRT2/jGtOTsnEjLATjZfd0ave33/anXP8IeVPeSiE03pFLvJMkfqozlP59RvGYz7hUbWKPmzHDFD92vRDSgSWSHMy5R6vXYavUnkTqkiAZPxK6HLRcNb8eaBFD2wJlzHuTEBo+dd9XK0vmtaSNm9bKKfuchoJYAqDa/l4AMkPywjlfFr4gffzL1eLWBI838pXRffJr7WfWTNfg6BcdsVe7UWWUwknERVn7L34L6K+ihgSUVH5OneeMq6muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjxzm3ckdi8sqaRWhhfLeeC68AZnMeSDIKBFRakrxgQ=;
 b=YqYUhPPfAtl8a/e12hePot+W1vOJQnQ5KKaxeJVvDq5YT3nC4yCTo9ZU5K4WdFNVBF1WSMUVQflXMUyNlD+JnP90h8CA5tUKKhCsh3Q7sl0rkb3rUYd2BCrhMOHE/ymV5fumLlc4Tour3bLW12o8/9OviDpKHwVhbQZM1lKYIg4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5813.namprd10.prod.outlook.com
 (2603:10b6:510:132::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 14:27:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 14:27:06 +0000
Date:   Wed, 6 Jul 2022 17:26:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] powercap: arm_scmi: Fix signedness bug in probe
Message-ID: <YsWbsKolf4UFeEYz@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2222be65-8711-4c44-64d1-08da5f5b9a16
X-MS-TrafficTypeDiagnostic: PH7PR10MB5813:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yYhHdAT3IhClx6r3krScYJVLK4IVMJCcSoFaoQQlBigmic2spp4nEgw4s9DDhGkIxsr1gCaFe2g8xc6f3rXc00NidqIF26p11keAOphChBC/h3/gCjGuetNdodN1IJLt9YliOX1a4P/Z2RXynKDqvf5XZz88N/NL2PoyItg0KQ1Ov6Gc7yuSitdk2ve0V5k616ArB5YVDz102IQBFW1SkfNL5m8SlNWlhiim4dmFSHGnrJrhczlny4mQ3rV5bLlAlYSzgjAB7uBwwgHwpSoxkbHPzmPIfcBLMVyYObNDIf5J4KGQvlTMeSJvfy2c2CPRYrVrUwRsHuqsZEGxsCi5UWWiOA5V32P32c8pYPQ3KoUSdGGhKLXVe55orH0Vq3J2duXg/JtpSZk6n7a7x/OupOiIoMegdxtUfPVsy/Lhtg8fR2M8drKKdY9qGOkKX1ew92wyh9xLjHu8FJrKS757xydW7LJwG5XX71Nmg5wm0QKHDuKcHLC4+s9uFBDENrt+wFv7Ud7sWxIWkJKjtGNRDJSHe2Xxdbr9fj8Zh1TlQvXyhgvjy8ytaZ+j8/gEwRDt9JXBlAUdy1wZMlGupkZ904XATfQ+vx9teWWS1d7MERXH234k8CF4koO4AEQ0lRbkmZrSfQjdMpduVtUc5eme0g/WK7HxKo/DRNWRIr43H6DwL4S8bzEF/Y1Yv9i27FRPuNB8rYEGop2nJpdCVrx22EDqp8P37vspNXmt2tWHDHHx06YFBfBMDZeM8RvUPUKj9zdLhn8rvu2jxLyAnYzdmni+i04kPlUZmO2N5uApshL/8xFt+K7sD2ryYqLF7KN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(38350700002)(6486002)(186003)(6506007)(41300700001)(6666004)(52116002)(110136005)(2906002)(66556008)(316002)(8936002)(5660300002)(44832011)(86362001)(4744005)(6512007)(26005)(9686003)(83380400001)(66946007)(66476007)(33716001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckjWnfQnBB6ruMdnkzldYEDc/aFBOGrzDBUlzmKOd/rfvJl9+qaVsS7gXbVG?=
 =?us-ascii?Q?wpBV02mjTavj1RZ1kW+wz/D6JLQCNQghAuXwtAiuuhq0xFJ91Uu23/Gm7AEH?=
 =?us-ascii?Q?zl4grFO9ALd527IT8WlPdshhmNZuoGwGl5SNFbHqYPzbnmocGU58ChJg1wGX?=
 =?us-ascii?Q?I1SRhEKHtKqJITxCfcEZoWusaJc+PyhUR2tsdacAQZyl5IUF71yNaDxAvMq9?=
 =?us-ascii?Q?o3uKYUX1bd2VXumghTBL/Qk6InqJgFOJ+WhhRR9FO85sPR3WkOjV1sXCAcYs?=
 =?us-ascii?Q?rTI+hsGbrSTxqyWiZGT4urdjRIXEqcbXPj9sOlcq14M+In4Ql7dEGBNUmxFK?=
 =?us-ascii?Q?KclSzujimZk2TG6u9iXipxW4tn11uilwANu4/Ah2icRpSlSevO25eSbTf+Ns?=
 =?us-ascii?Q?FDqVYhMPq9jIe7IcCGSkThVyEZfjZ0hQN+R20ayTtiauceiHWFq83V/rgAXK?=
 =?us-ascii?Q?Qzd11YTXTB3NpAsNkMnxZlOlOwwGCQ+C7Fb+tboqTTGL/ZpxGmbI17QgcvWX?=
 =?us-ascii?Q?g3rMp2AN3jz2rsRtpw1n2rkbzi1tAHdw0PKnG2KzdtmBw7F53kDE1Y77RZIK?=
 =?us-ascii?Q?HZtHWaQNPqdZJ3l9AmWhd3lNEx4TbOyoqhXX3fjJuHb5dSG1oj9qmWskYsN0?=
 =?us-ascii?Q?8o2Qa5be/K/q08Oq4MmXmN/v6JVdk3ItHqjjEPv7Mvh45g6GdWdVZGLKkwtB?=
 =?us-ascii?Q?WgyI1pmKgqJyLHKcuNL2InYesKg4XXKYn9MNv/prjf9bguuA7xt5VD9kHeH3?=
 =?us-ascii?Q?b6qYzm+eFBNdIPeY7AU58baJ4d0qarTXqv/cqgp+zW/FyFHlcsP07/1iB1WP?=
 =?us-ascii?Q?lYdi+4UwkSE1ACveIH6nSKfMbLiVuZ770MwFvaDaNjEV8UlihhfIDQ3efuoZ?=
 =?us-ascii?Q?kkwlYTmRBiGfFF5R7pSSe0bkpxzSh3WFEB9Dnz5oHYa6t9waE2F80UnBdl7B?=
 =?us-ascii?Q?39/J4AFSN9IaiwmRZoyXQS+qSjseU0zsr52CY4sPs6KkesGGMhYrJgAHtYyu?=
 =?us-ascii?Q?uh1NgngVnwZH/SlV6K8Vy2Q7rBQQ9XyDXEdNQfRfCBqCkLxC4k9+BNFPt9JQ?=
 =?us-ascii?Q?j0iTqWrIfJDb/FPPAt2mvEq/80QRGN/B8CQO4+wyBHmdYUb80M4NTLHTzGFt?=
 =?us-ascii?Q?4sDODKnzuqpRw3Y21DNhIzNFcapOybhWgfmdihMUIosw9YxQQGMWFhB7LMtm?=
 =?us-ascii?Q?XsLUKch/MM6Y4pK6kD+0enN4fUz3GYprNlQIDssK1114DEhARJZNtpPww438?=
 =?us-ascii?Q?MJwf+A1x+DVpf2ssbaEDiLF/29A+qpKrmUjb1S1N5mvTii8cWjUkv5mHeQcu?=
 =?us-ascii?Q?afNIknAARh4lyTeDClzbxfLAnFqFsA+V7i8j6b+Hc1QP+BKvjzlbkAc4i9Qv?=
 =?us-ascii?Q?2whSywYbdOSBcFAGBcRD9KR618u/ItbexCDnQ5Z8oD/E7eKUc+BSsmiWV64K?=
 =?us-ascii?Q?qaTYwwrwIbiVO+a931dGEvZ/+TRnuU0Qmoaq0TduBFz3YRTiP4CuyREF2vpX?=
 =?us-ascii?Q?JpnDHl31cw3YtFdfG2BrItHjIHJOO0x4RG5o92/O1VNJ7+mOJyZD2mf+3eTE?=
 =?us-ascii?Q?6FscSKS/RtsXvW1MQlxgu6tqtlEndS8+iX+2fnNfVi3jA7okgrWmyRcEGsBu?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222be65-8711-4c44-64d1-08da5f5b9a16
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:27:06.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0vhyWfUYZmIdzoTmgZh3iVC0Rk6RgYUotwm3ApzbFa7MMkXBAuiF8ugCbBleJsLK6Cck9TQU6oRZ/ZJgNUkwQMUBXZ12TnwsrCI7xqAgsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060057
X-Proofpoint-ORIG-GUID: um0tEGgFZlZeFgD6EXq4aIJGpe2Jl39g
X-Proofpoint-GUID: um0tEGgFZlZeFgD6EXq4aIJGpe2Jl39g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "pr->num_zones" variable is an unsigned int so it can't be less than
zero.

Fixes: 31afdd34f2b9 ("powercap: arm_scmi: Add SCMI powercap based driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/arm_scmi_powercap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 2273768d70ce..ab96cf9a8604 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -425,11 +425,12 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (!pr)
 		return -ENOMEM;
 
-	pr->num_zones = powercap_ops->num_domains_get(ph);
-	if (pr->num_zones < 0) {
+	ret = powercap_ops->num_domains_get(ph);
+	if (ret < 0) {
 		dev_err(dev, "number of powercap domains not found\n");
-		return pr->num_zones;
+		return ret;
 	}
+	pr->num_zones = ret;
 
 	pr->spzones = devm_kcalloc(dev, pr->num_zones,
 				   sizeof(*pr->spzones), GFP_KERNEL);
-- 
2.35.1

