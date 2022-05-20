Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346D652EEA0
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350263AbiETPDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETPDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 11:03:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1A16D4B3;
        Fri, 20 May 2022 08:03:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KDTOuv014287;
        Fri, 20 May 2022 15:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Ha++xD5LmKR+qFQ3st7nRfjH6f6dDAaXFeYULXN2u2U=;
 b=W42mu7r6KXv4CIWLu38e8dr6ay/W7CnFL5SG9MDEoAATzr6PNP8Ivui6fqd2cj2gLw27
 Y6gKSF5Q31ZliZXf9oRLoVTyzFtG7lY05xib/P24gPjdeTLTcq3hGBeyaZ6RLRZOHNSs
 ky+EEY0TnbDOJYMxn8oAJ+nxmGRYaornEnKLVjTt9ztjKZgcN1kg0fBDxuRqJaVutYPU
 1ws7lAzAhE5H+HRq12MevZ3B2FVheoNhDRucFLB6mcDZLYPXNMf6nbsOZ7wqRfebyWPE
 f8epbUkTMv7sNAusHcXufijcz4cSdJBLw4TPr8mu9ktnfNf30x5otMgIPYS4b9GFiSne rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytyax2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:02:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KF048Y001081;
        Fri, 20 May 2022 15:02:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37csj9be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 15:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9KuVY69uVmkN+AW/aNHv2k2f9qCaG56Hi+tBSwMsX1IUAaeEheuSo7Ix/VDaJIAIEzgzb5Kztj7gHPIEB7wYwvb951erB7WiJwEiU2DCdklXyqNip/1WIJ35+04DiAU9vN+RD+VQpB/oyS3wVcQ+U/5fgeuEpyyX9k8uR4vh53qM1/di1AtzZzqDP6vk/AUiCOFdkPYEaLkj/oB0sZ7fbe4TzG08iMindxn0etl81K4UqgM7mAx8neWOeeL8OD17q61ZeJnKEedW3VlG59U8DQpHdbwtf7UH/q+m7F3FI3XfajyRa/EJcJVFyhXwf2xkXR0IhTA1ATwpkVUzNet3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha++xD5LmKR+qFQ3st7nRfjH6f6dDAaXFeYULXN2u2U=;
 b=ZW/bcFGk4bQEH98apDTMPzugDOSEk/mtCVHLfFiyViJz633R4VQ/B6p332Ht5+I/tn1+4rZYA/HlMVS4xcTEL5+I5MV3l7/vZFlXDkQ2hHs0DTqTEjuXRZyzBo8Upme2F2kq++meS+1gA952CJzw7P08WDdfFJGt/AjXvsTo1BbaH9IQDirD74JBHCKXP9suMXVQ5LqPEaDO5imvWmyYjW4GN6SXYOKacGyHDntI7LZyfxcIaTjo9Tza1er7Hfq0JtLS0VRkc4P/wlNv5BGk2ScXe4Spd0fn1kLglYCutC1n0OX+Gi8uZJhBv5AVNxQKm/2MFVmJVvY6Gy6fvzUwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha++xD5LmKR+qFQ3st7nRfjH6f6dDAaXFeYULXN2u2U=;
 b=DnNEYCR7PbRDXtHPiKDxsMnX4nWcNYzjQRxTE948MkjegL/BAJm1vmIi69iP2dAeaP6arXaqsVSl8FzxTooaGOcUaBxFGIx5WOVA4oNczV+N6/8ipjGAX8OyTY8Las9k57IHZC3Mno6r+DB/52lwo/olEOjlA8uVU03dMOsaFaE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3722.namprd10.prod.outlook.com
 (2603:10b6:5:152::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 15:02:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Fri, 20 May 2022
 15:02:55 +0000
Date:   Fri, 20 May 2022 18:02:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: k3_j72xx_bandgap: Fix array underflow in
 prep_lookup_table()
Message-ID: <YoetjwcOEzYEFp9b@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808c4cd4-a992-44df-e48d-08da3a71d1ac
X-MS-TrafficTypeDiagnostic: DM6PR10MB3722:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3722F6425ABC351C1A9D70BE8ED39@DM6PR10MB3722.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRY2P4R5NLwbWdV+Zt7EjT8LY5ECjVGVFE7Cga7BH9pxS0388aIVvknCJLKPjAXWFkBz4cECXaEqYK8wT7ha5yew/Nup22IOwF5hjkZUF3s4Y3tQOPN5F9i87BTgTeYU5YRA9cifApUjvxUyqaOv/RB5b4Ti1kqb4i0xTokNNDZGoRlVmAKChdzWda79sLjOa9LWlWmGhmQrvZK4khBSFX8M8FXzPMOZLcktraGVVTRvGWJKrhenVzsRua7okNWmxu8aRkAJRpJs3DPHSRiiB5eTwWar3Ed6+gSvSsHrKoGDmm3JaZscx4UlUY4mxcA3Ek8aQxI5eQbNZDr0UYaPO061PobjLaUKo6x2RMfYfEQt4cLFVmqjbfpWOxjLzsiP89pTJUnDyp/BhiVGBnfT5YpzWq41JAANO1ieLnG1m+1iZnfYhH9pgM1r9Ppy/bpJ0vD159Ap5MM3gWMyCK1WQlai9hSKpFiteXp6wKz3qDIQIHDm0waQRub+QymzPC0Clb7tM962B9W1nxMHqXlxXIzK8PZlWG3Coz+w+KD1R+xuTr+rjoX5NXamQ1Awgh7p8F0+PJsa+6Yh7TY1jgR3YVLGbzDdCWB8zc5567LQSCLyvL4ReaNT8RbwKkOmgWLlscMkotqJURvW22cdWi8SSQn2MhgVu3TjzBIZkyJWd94MPPJIw1vUbdNSH6EzpUY/UqOZ+d98TIhJAW+yNUf/og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(83380400001)(66556008)(4326008)(44832011)(38350700002)(38100700002)(26005)(66946007)(8676002)(66476007)(5660300002)(86362001)(6486002)(2906002)(6666004)(6512007)(4744005)(9686003)(8936002)(508600001)(110136005)(52116002)(54906003)(186003)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7+79d6l5tE09lmkgyEg/v6gLDBuA2Pa+lknM92NsCjv6OwOlLHXlIlR0P03?=
 =?us-ascii?Q?CAsv7INBfWeAO5A6MNkSdeMMq6sapavPr66d8Jh11wDNR+R5eIG6P3lNJ+ey?=
 =?us-ascii?Q?AtUmw4Ifoq/feJLPWK8YI0zkm6TZaq7HECfPWz+t3Lf6QWdJFbuxXssGPW/C?=
 =?us-ascii?Q?PX1pYAbGUQe0lmPdekVn1e55/s5V75IgbnBjLiGJDr9D8IHc9Rcrvr8lub2E?=
 =?us-ascii?Q?cqqMNrmQ6iS8QDKGFApC2L0zryOhY0NUf1LTSyhVjzg4Z1sPywLpgvKV0zO+?=
 =?us-ascii?Q?2NI0ROmJhoDqfmB40Cfq8uLQEzst9S3lIOVA5eoaeZFffE/s9tep1mYKaqeq?=
 =?us-ascii?Q?yvZPfOX8+qOW5K8MM7nH8GDlG/zNxUPWWkV0XVR3lfSyiemyeEpYcnUEyoa3?=
 =?us-ascii?Q?RG5J7KaHKLDvvnGZrOf5mT+HX+h9dI+uN4rTL7Dr5DHtjFCBSBtGifBJbAIm?=
 =?us-ascii?Q?hKUWsUFD3lWVqZ11Hlv8AZF5nPReh9RV+Z0IuyKpv1GjAvfLxtUgoKjA3AGR?=
 =?us-ascii?Q?teRsLbl8S2SLNfU8o7z+Fmw5ZV26GnGwniqgM6Qxi7q0hOy/Ikkl8NJVD4v3?=
 =?us-ascii?Q?InNBpGyrVQyCPul9B3IDZ+TGrDBItljzEZS6JRjQsfD3KUI6e0GPz+3Rq1D5?=
 =?us-ascii?Q?Hc+x98ek7Xk0VnTPV2qwul/y83Qp6B1RXkA35qO0JyobZFCNrse3sBmkB3hI?=
 =?us-ascii?Q?fm0J/cODyJ/Edi4fiwCI+HfsX1Zcr6uZHcrDizhZjExZiuGsjkfkdb81VZsj?=
 =?us-ascii?Q?3OfFpUiBwtZVVcxwkm1RgVoaRcaxs025B54+v7gw+ElAwOWWqCwR/DZeHL7z?=
 =?us-ascii?Q?HIR8QSSRRqWRt51xWtJEthfKQ4yMvQ6LAOC4IrNFaU6iQk4/bc1hI+5lvvhD?=
 =?us-ascii?Q?5py/2r+JhsrlNw99WQRX5mKw0gB68tnh5ZL3cEq/vWKtUC8bkoOHi6rKwH+q?=
 =?us-ascii?Q?truU9/paY9ZhIoF5c9u9oKOMNOH8mly4vibuGROnWftuanjmQ7jIP370phDv?=
 =?us-ascii?Q?Qi3Icn3kY3fSGSGbmaDQ5bAeRiErS4KN3QmHyOJQVZRjC9t3to3j/iDO8nZ9?=
 =?us-ascii?Q?MPcTVtNxoPz3GEV5Iple5GgQzXD1JcdNqYaZox39fZE89Jnrquzyvw3aLQkD?=
 =?us-ascii?Q?JKti0F8PfbjLtnMbdOXuLvALdO4GAZAZnmV10PcsVNPOD+9KSB7wkas/iv0n?=
 =?us-ascii?Q?N9xBRl4PGUQCA2GjusvLJpjkYm1VkuCp4XJ5PXJIhMY7adFEHFvBkw4dl5Q5?=
 =?us-ascii?Q?NBmOpAbP0oefzFe5vf9X7aS/PicVvnRIYNPudHbRi+I8nimC/o9Ou05kSBun?=
 =?us-ascii?Q?rqva2BNjweVJaHXN+AesJ0ecwgBDKUjkXWfFTikBsZ2JXhhswN5oGqMdtzWb?=
 =?us-ascii?Q?J2mfwqlXGYjLRZf6Ar5ix0bi4eJXCA1prAfxbfhmv1VLScgCsG25KGoLsrv1?=
 =?us-ascii?Q?8IT0Di9e9+5y69EhEnAdtk94aMvxgKyziNAl9IoRdsVj6LTPjgaBsiiKK4tf?=
 =?us-ascii?Q?EuBvNGA71sgoRTW32AEkuhNRh9XtYjoLBT3BNkdPSXVKRdclU+GnJHX8FVYH?=
 =?us-ascii?Q?MMvjhXl7eHDXmoumg2jzBLHxDQ0RRErg35ksBuWpLhkuA8EeECWNiqNlLF+J?=
 =?us-ascii?Q?MOVq7U5fkxOKoax/OixVcXPrTDa4tZD//FVzQiEnCPIK/I7HYCL2bi95RTyZ?=
 =?us-ascii?Q?lrR6uUh6r8P+Boht8io1Dpi9JJYDznEkZtkQkstXRH5G/XiX481uYIKq4wov?=
 =?us-ascii?Q?7UcWBzHo92MFdl3uVkIm9U5XyzZqVj0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808c4cd4-a992-44df-e48d-08da3a71d1ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 15:02:55.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6EBzsJSK9ME8q77NCou1pcal7fAuOZrMOoIBOK/gAccAjRpZYtm8cU9NJghE6Y30edsmNaXUOv1OGpLE8DtCSoj28Kn4Q4SKqbaR9M/ypw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3722
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-20_04:2022-05-20,2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205200104
X-Proofpoint-GUID: OligXqyY2O5aRmQ4Q14YkpGZcM8pNrTt
X-Proofpoint-ORIG-GUID: OligXqyY2O5aRmQ4Q14YkpGZcM8pNrTt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This while loop exits with "i" set to -1 and so then it sets:

	derived_table[-1] = derived_table[0] - 300;

There is no need for this assignment at all.  Just delete it.

Fixes: 72b3fc61c752 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 64e323158952..a9789b17513b 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -151,8 +151,6 @@ static int prep_lookup_table(struct err_values *err_vals, int *ref_table)
 		/* 300 milli celsius steps */
 		while (i--)
 			derived_table[i] = derived_table[i + 1] - 300;
-		/* case 0 */
-		derived_table[i] = derived_table[i + 1] - 300;
 	}
 
 	/*
-- 
2.35.1

