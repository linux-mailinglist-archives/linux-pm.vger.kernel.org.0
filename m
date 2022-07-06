Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E9568B2A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGFO1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiGFO1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 10:27:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E789C21E14;
        Wed,  6 Jul 2022 07:27:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E3ggd021463;
        Wed, 6 Jul 2022 14:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=4SHq+Du6ohQxycotkTXGAVx2FxIHl893Wh2JIjbihMk=;
 b=FGwHs8KcafZn8iGop6tds8Wf+e53FOIufvYoUc4tLoq8jbxiq7cg5xvuDohfnBSfulWb
 677moCvfX9f91vIHaAQww5wyB+6RwrUFuMg54nzr5nPkAbSbISZcBBMZr2kf0j56MgdH
 POOeLRD05TFTIt/vtZqo9IPzheahoAz3e/HUqfTfZ97VBd6jkX6GKtKQ9uuA0+BkBiWx
 TY7cZA/Q/rHOfaBLU0k02OLKXEn6biEzRv6FAWfn8NKpixdJC3v69IUk3GXKTEpwi4IY
 akpt+2iCtPwJ4x5u05XjQCn+mIFUgi5f1so8ONij70IjZ/o7z4M8ZpcLumev8LRHHOLj hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby25pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:27:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266EGxN6021079;
        Wed, 6 Jul 2022 14:27:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud0v7sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzJPVJSdsD3K75clRdUIp2o/pcgH6RHjK+inkKR/1uw//Ra8lcE0UkK6JFlM8rykf2tI0hN6GI7UCpQQWTk14tUC6TM+lzJw9jMMLC82pytwpCNbZeFrHQ9ckjl/JqpL4HmzGhjhvdSEZiaJJbfmYXXQigNy0fw+0TZidgIh6zKfTswhnE5Zetg1nfC9JPBJqMg9KfXAz7pDFk2ELqeQdAp7z39wKC7viuMG+LbEmuJX8+5oCOezZqkayVnlQ/KnioLJHa5FUG95DjMPXpVEJBPG8izWURUT4Qa6fcIeK792yBUwLMLHuI2OmHGqWNUb9F3HRsUoUUlRArXktmPloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SHq+Du6ohQxycotkTXGAVx2FxIHl893Wh2JIjbihMk=;
 b=JpOO+36ePVbUaFcWClMCYLjyzhNe+vH4zisHnrOXObg/9EdGQZJWLXQDC9iASt3yt8VSICL6zuPSN1ZkHuxViioRYiytf0WmAdL/1Qp8vTmS9nVKVn5rZjqVJA7eGVHOzH/kgexBCCZxNHY4MlH5Hvnai5FVab69TZDZ/MCYDQfVuTeiMskyZ3aZe8Cxj6DfZ0+D2Km1VjpnQvn9i7KOwpXYLZZKTn5Atc8LvPRdVz4WLD8noY2jTx9FMGGMx8mIGRG4gvIb12RXcesl5AJlIzqJvFbocx5kXZlTKkoLj7uTaqsJ0q5WYr0f8JiobPY1IwksvrhuG7cGP9coh3rhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SHq+Du6ohQxycotkTXGAVx2FxIHl893Wh2JIjbihMk=;
 b=vRu+1EH4TDuMEMWfvwoWqOUR7rBoEv5lP9EZD1EFDto+219vPoStEZ8FMMbifMI16N6FjiQVdKDWAk6Ic+ReNA2nSF+w1XvLhcCTkdB8m5vJuzzmBdaXqMa/M4QO8q+ShWFgKFO8sjIMT2l0guL3twqzSsmOVyVBGaDMUXJw65w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB5813.namprd10.prod.outlook.com
 (2603:10b6:510:132::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 14:27:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 14:27:39 +0000
Date:   Wed, 6 Jul 2022 17:27:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] powercap: arm_scmi: Fix a NULL vs IS_ERR() bug
Message-ID: <YsWb0JLVFbXS+qGj@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWbsKolf4UFeEYz@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93192d3-05b3-4c51-b5e0-08da5f5badb0
X-MS-TrafficTypeDiagnostic: PH7PR10MB5813:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0AD/BArOcoc4/dhWg54KPDRp54SgATgbVmveQ+K1eXHCwd62auc+OSHucmpEyqkECP4dt1rU+UG+hYfKlPZ7SnPgZ8xxJVOCeeMGMSPK/GYpSBfVPgEJSsYW6JTlXNh74GiWujlizWYr4S32gIc2fY/XQtYBPsHRgwpDtC78La7Wu2ZIGlwyZvKvrR69phGTx/O9Lvf4J86KxzoMncJaotz0Mt6iAQHn4jsjrjCqbDjjm4JAZz9C1WlI1p0tqYGltmxGxBXzIUDKdhmc8bzlQ9EBnnC+67p1KKNDTnjt73Pa3wPxdqfvIeISLUM6KFoRa2m0OotLgGq2XNsTYTpEZKCN18Ncml/O8/axxJSX5CRFFzt8OxdfDc9CbQC2VOU5cXn9ow3AqcBD9Ph0PDXXrUyZ8XfTCO9uuUrNaffca4mJ5RVLNyK5zrbRMOyl2FYMIZsTbkCtHweMD4u61jltFMfta635lZwB52vnhP3jr4iAsmL8yzeS4/C0p6/nXlcjJSr/u17P7w7Xwe2rI8+JIvaF85C7+DCRTwdwDY2NbzbrLSm9NGjgMC+wMtl9uf58An4HfJBuM+agZ2zJRQuJ3Z5qunmYvilFrptg5lS3m1l63gJmGT3/MhD2B9spCfynxoGFOPuuUS21bAwX0QtqYEjG3Jh4FFj6G6Kjc5apUI7o2ZrUD+q5Ki7QgABD4jZJyQ7eZeJ1dtz4TyOa/Q1XvLD9SJnvQ0CnGv00DRVcwX1/H/WP+R/Po8wQfT/f524M8QUpGxJ8TlWE1XxyjlW1Mc1/cszklYToT9iG9hQ6W6hePR3d3lyuQvVo+fumS0ZwX04dcnzXKkYKgncOswaTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(38350700002)(6486002)(186003)(6506007)(41300700001)(6666004)(52116002)(110136005)(2906002)(66556008)(316002)(8936002)(5660300002)(44832011)(86362001)(6512007)(26005)(9686003)(83380400001)(66946007)(66476007)(33716001)(4326008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+orFxSSa3x63AlfVSS75rPyPDekI2OUSD9tJN6DBh1ZjDoHFWHIEgbFbwMCp?=
 =?us-ascii?Q?WeEWHzfhmBqVX6qyylLtsaIVQ/vzi6NyUGiL7T4QfHY8mnbH7yU1xHnbkP26?=
 =?us-ascii?Q?izf+Dv9Lu2rZS39HS7aV8nq54aMEltctYwnBbdojBn2DzhXCVxLaQuaqF874?=
 =?us-ascii?Q?G06c5xK8Zr0WSZU7BMC4soMtpTHCXMrw1CRqHki+JYNTThYXiM3cVKIHUf6X?=
 =?us-ascii?Q?fIBu5sQ3rKt8W2tViR4r6YPCa8F9lfQwFJW/5fpns8ZaofMbKDTPxEoSgtGL?=
 =?us-ascii?Q?HXZP1SDUUWyohC/dgXRrPtcD+Y82KubPHY20iNnZFkIQ51PsCrEm1xjVf7KB?=
 =?us-ascii?Q?3RPiX5n2H2tR4nsKXvyrgcu03abVHVh7oOJpaj7OQ8nqE13JpWP651stqPx8?=
 =?us-ascii?Q?JphPXtkLmjStjt/IaYQPgtGoS9Y1s5imJJWXAmMoE7X3I3E8+Dc6JFY+v40H?=
 =?us-ascii?Q?Vv7VxB9qLs0zi+/VCOYVhNzI62QcfexCBr9wpILxHowiTyBXDRrigNzIukxU?=
 =?us-ascii?Q?xcVIymCSfcLhoDBKK7kovfvk9CRYtU3K0Hwi02YJ4QeW0Yc3pNH9Sph6DHcA?=
 =?us-ascii?Q?d3Y4fsUH20FpCunZ4A7Nk1G9mr/ezS0hj1Lux1eUac6oIsufecodhbSfrMYW?=
 =?us-ascii?Q?dJ6mSB8Jpy8bCF1q1RcPN1g2teyhYhCLiGovG+QBnMbcVwMBMGoNlnKiZQjv?=
 =?us-ascii?Q?UFuZh6YUlFX4aMpRXhxOovoUXL4sojzzQvzBcuTl1Gr0jPH3a5DqQnVbXoRe?=
 =?us-ascii?Q?RKIBRx+LYzV2iPhOTS0SCzr/NXKHykAlHO9wfieaKlstnC8TYvKMOVvAGTcE?=
 =?us-ascii?Q?6KwOqTl7q3+Mp8KsUO+rNTHwFX+ECzCMTOfF9+yGiYa3/ndwmjEELAgg+U9w?=
 =?us-ascii?Q?GJe90Q4luEfVWAbwzulo06jamHu5tAPjRL/x398abO6ObR/KjrjruPwsq61F?=
 =?us-ascii?Q?M7iOyQXlErUdAiO31XvL4kCV4+mWPg2LaQ6eZfTHEP6n7U+71MhXWw2e4mjy?=
 =?us-ascii?Q?ZaXe1LepXNrl/WyLM9XlCwVvp1cU2h0A9e0q/YDLcu5c5qWPra76T/tVE6iE?=
 =?us-ascii?Q?0YeyxHunPV87oVkvhuLAFhFJPWm8nFulRTLJStZO01pqvAC79A9g7P4dstYo?=
 =?us-ascii?Q?m7eIGOxdA2cBM3VnNnyUxJUCrSIJ18Yul3WqK9lR+rcBSIcCfBUYwzhHzkHw?=
 =?us-ascii?Q?q1e93DPHeQYQyweV1s+14C6RYZlxkfQ4eZ10Kd3DzvM4zfCRjZUohV+rkYAf?=
 =?us-ascii?Q?z3LgDuqKSsPnPhMjEH8Ao3fdZpUdVMvIgxQGMEaXKm59MFy91GakEMntD3wC?=
 =?us-ascii?Q?mtrHj4mJkawyT42SFcSOcctRg2QWX+S1SmebQRKm40NiIYIieVwPWLp/UyNq?=
 =?us-ascii?Q?ldGrBtNpYJBla3J+ujhUpXQyTEDx+JR4oeNNHEwVNY3HSLM2A6JSFypesNnm?=
 =?us-ascii?Q?4TAKcE6s1NXnYJljKu5iSdEFhY/Lvj1+RUWTNXL4qlnuJZh4BRo23/mwAFiG?=
 =?us-ascii?Q?ZpBNmWUaeTKePRwObtIMPPRWdUl+y6tz/tOngxe8D5psdLGm7a+E+t/L/GA2?=
 =?us-ascii?Q?nAIo+rzKfWdJBA4rwNl08UAVuPgITuDSf/6PAy/yORy4bbnxHnbnq5BZBjEl?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93192d3-05b3-4c51-b5e0-08da5f5badb0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:27:39.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGAm1VPOlH3r5zLT5MpaiEFleekH2OViC8TDCNpEurtWhA64AUHACu1ZcJhsZTqAqE6L0FK4J0oKx1JfvRCv0IS6uKp7JbMexQDqWR3wg1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060057
X-Proofpoint-ORIG-GUID: gAWlqgS9cj6pGlhCHMqPhWK2XRXGgSJu
X-Proofpoint-GUID: gAWlqgS9cj6pGlhCHMqPhWK2XRXGgSJu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The powercap_register_control_type() return error pointers.  It never
returns NULL.

Fixes: 31afdd34f2b9 ("powercap: arm_scmi: Add SCMI powercap based driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This functions should really clean up after itself if scmi_register()
fails.  I need to fix the static checker for that and then I'll come
back and fix it if no one else does.

 drivers/powercap/arm_scmi_powercap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab96cf9a8604..2d505ec7ff81 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -519,8 +519,8 @@ static struct scmi_driver scmi_powercap_driver = {
 static int __init scmi_powercap_init(void)
 {
 	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
-	if (!scmi_top_pcntrl)
-		return -ENODEV;
+	if (IS_ERR(scmi_top_pcntrl))
+		return PTR_ERR(scmi_top_pcntrl);
 
 	return scmi_register(&scmi_powercap_driver);
 }
-- 
2.35.1

