Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E324841D9CA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbhI3MaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 08:30:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49712 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350193AbhI3MaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 08:30:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCRikK028034;
        Thu, 30 Sep 2021 12:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=C94lIE9CsEOSg3G62/UmMphuUFNHXRr/8++NaGX6MHY=;
 b=zZdMXSnozvhaInG9FvHHJ0PqL5hNDyRWcGUAU9TQI11mxoZqsaOhlViM9HQFeNu++2vi
 VD9bWCxGA2BsG8PyL8Lwvw6Kj9teFmag0QNDDs1wEFitCPxPVJKv0LwTKadokBSMsx6u
 lI9iQRBsCFFX6h7zlmwag0TpHMJxq1aVQgwPNp6dPGZ83IsspRGSx5or00PeEu1UQjjN
 /mGQSHpJyaDCiviY2s4bpTkluF3m2i+zUrW3KLO65M7qLhzjfr8LUH3AhBWdLzv39Xp4
 uafHnEToJmwUsk+MHJpxJlUNIXFc1OW3sEnyvvzcTcCQh9ujyiURa2IAn90+uVfxkZ2Y XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfm26p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:28:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCFA1v017018;
        Thu, 30 Sep 2021 12:28:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3030.oracle.com with ESMTP id 3bd5wb0pqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1pL7Cya80F0/ZBZykj915P/abs3e3Gyr6tJv0/Y+HjSysYCNACKiCqJP9WyP7xmfyf7wnft61c9Vc9WVgR/rEwlh4Jho4l8oqdSFRpStPx99JlvZsQ5bboq37cUHSol80j/CR0Yy3nWUAPFaPmSGL5QRJ9RjIS7FwKATMSAiWEg7B3y3X+XceIrq01P9rzeKfUypI9nus1X2+nKWPQJq4aplZYgLEnPCe6vIWcUdN1tr1giuTUfqV83D+qG8A5h+bNTyy3Uxvq0xU8fe0ZTAGPArv/1lHnvjmvim/jPU+UONBNvpR+xNeVJTKnn13h7RHfjUCXCDksPvWcElBJurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C94lIE9CsEOSg3G62/UmMphuUFNHXRr/8++NaGX6MHY=;
 b=USaAEmGqPoljb7/rpPCWB0u/zIhoWjbbRSkfRBV/5mIs/4R5Hq3V4saKK0gxhsR2wiJqzy5mXueMB/edDT715qiIqibgLskUB2+YLcBynabzrDLzSsDIV6xTA6+ZfV0QuEgtjL02M9anr8pHv5BbGGvSMjs6l2wlX15trWaSDs/yWdhBF8L2VEJSBQ+otXjrbdUrRtEeE1DDqzZO58BvhAHWuzkLG4IflbIOQqeljZJCG7+WYe0++R8PlzrvlklkMxj7aQZJ+6eFkNe81kGqnotcVvPMQJ9otUFPKDbEJo+EYE48POQqoj15JKEuFg4x5ZsnU0BX/ndOkt1z0Ga9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C94lIE9CsEOSg3G62/UmMphuUFNHXRr/8++NaGX6MHY=;
 b=sftJq3Qx78Y/ge0PFU6gDvBZgPmRJdyfHzRS5zklIqhS3ebHvpbM2SfN5oP2cyiwQB6xaOa8taJtSipqPzUl51yU2zItggPFewMsYQ/FJ9CytUUyMFetDoFaErqrtac8BqR/UEY907kb3ExpU36vWvjjcJf7LPMXWfeIU8Xb/F0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1824.namprd10.prod.outlook.com
 (2603:10b6:300:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 12:28:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 12:28:18 +0000
Date:   Thu, 30 Sep 2021 15:28:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhang Rui <rui.zhang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: int340x: delete bogus length check
Message-ID: <20210930122803.GC10068@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (41.210.159.27) by ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 12:28:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35d414d-37b7-4a55-e548-08d9840dc7dd
X-MS-TrafficTypeDiagnostic: MWHPR10MB1824:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18246DC37513BB7063109E7E8EAA9@MWHPR10MB1824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sXAbQZonYP3xtBJv6jpvT82KGdIMDjYjQqCd2fldel2GqS1wH2ibxrq/E8yNgOxbfIgxcfnzc4/aetrP5PJalf4xFHTLBtCFPR/8ufonViE8hFAG/RV5ZYf57fYV0arwKN6/IqOmhDpxHhk6EqgI0wpQytKTr9oBm0oi0NJaTx00Aop6jvv6XFBz+RO+XRMWJf+2lDBvS5QLK9Gy55VxosnlYl3rXcuOw2LyBKA8T0YPNHlQ2G3jNk0SRXrGQy2vOx3QIt7TVhDEXM7OZ5lEKL14CNh6OG1Tbk1gs7UGKuqgwZIoOEavWBDkZWMyv2VcDYUYJq3+mBBJjM/2OrF3GoHSAjQqW2rAP2Llmg5NUIVLhMX9ic1AkIfmqj+y8nMDTxP+Sdist9w1P5a2JNGEy/G4NBCYSJXdx7XawX6pvWuekkyz5wl+m6Smf9EZ6zSHfo5PwBbRlflFuRGVZmtSWBNffK85Ll3B+m9Zlgkdsvik1H7k32eswmjqSdtZb4wTECP4k48ZkITkLeSkataMp4sRqBlsxiHvwE3cZGphq+yyCjZ/o73ceZGmGP0xdpw6GMpi5d0POjOrVezS7pk8E2ftehZPyvM7l6uz4/QyDDbanB/3dDntTuDPfhrXY2rWb23z0/DCznGBHTAhYRGOM4Ro9qsNZGYlqB8uVAzujJkRlb8PoNdIMf7L1oBVkMquAc2igCfs7tlWeuLWZvMpr0vfuf6yaNBA4nVeqkR5zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(83380400001)(110136005)(54906003)(6666004)(8936002)(316002)(508600001)(1076003)(8676002)(4326008)(66556008)(66476007)(52116002)(66946007)(6496006)(5001810100001)(5660300002)(44832011)(33716001)(9686003)(186003)(26005)(55016002)(2906002)(33656002)(86362001)(38100700002)(38350700002)(956004)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WN2pqwUt9i8TUH2f7gmyUta1PkQy/cqgTzGRKKXcdlaIBVBDhsCWvcJyojy5?=
 =?us-ascii?Q?jYSp20+Mz0wa4WklNMcyM/T0EQQbX3thNtECwfSP4NIFutM9jHvWSULqotbT?=
 =?us-ascii?Q?wfXGz9vImjwGwP6JkBuv8vaIIL4/6pH7GpYJOC4UZmEWgI958UuE7lepJjXP?=
 =?us-ascii?Q?gZuv1EKC0KpwCyMkczZAhyfFsrjeRcXtNSLinSAtwNDRKn/TkCs3I2pnSNhk?=
 =?us-ascii?Q?DGtgUJJrhUf+XKl3EIkupVogeCLzbBj5s1N+3MIGs96lqL7Ddh6hmZTqG8/7?=
 =?us-ascii?Q?M83KSiAD6FU0LOl9D03tZxxXsgbR93orMaZAWvybNz3Oxzwxcl94gHgOLe8D?=
 =?us-ascii?Q?ZQxvT4YEbhHE3MN0ZWKrQ3hkDKQI993EERD9U1ZNJ6tANlJ7KRibaj9sAH3z?=
 =?us-ascii?Q?x/kH9RpR6VZ0MKXSINaCEHm5+UlJADXcNfzNJlaAvqY2KmNbGMve/rSG/2uQ?=
 =?us-ascii?Q?6+5g7pIBLOkr4ZM6phmelegQdPe+XkoCn5PPAL3nzjL/qUGjrsu1wg5IuLFf?=
 =?us-ascii?Q?56mBy8dRNZAXhDDhO5aDbZyvYSqG3mc4lzCb6ScvouSWF2MyFkKbtwE+VU0D?=
 =?us-ascii?Q?0PJQldye7Yr789ylTQ1jrlrQymwXpor6K9jEu7qpo4WuAbQq2aj00xXxVTx3?=
 =?us-ascii?Q?gzwHrMWtJpT+8g/EtmRYm7wN5e76ESEYt99Kc8jHn+XTiWTMyY85t2wV0BtH?=
 =?us-ascii?Q?yB2n8Dy2+NbNq1Bn1FAOYKv9ZekIxiReP3WcjUbIUs02PPK+fiXYAq10vKJZ?=
 =?us-ascii?Q?v43AYK2F7WKrQsrfnMdX86lCCsRokrysgEdZGt7pOh+S47j7RuUsT684MOtZ?=
 =?us-ascii?Q?nsXbhdGxUpqTHYdjtdN48cHiCrOg5SmI3zyAm89T8aCeJFTectePdW7fBMEg?=
 =?us-ascii?Q?qjCaScKiQqRfBPOCEWmx4T1stQRTMDoGM0gM5g+0prz2m/027ZcMcW2++IKn?=
 =?us-ascii?Q?xc6AIrf4NIRlHoNZfAYyQgd+9SnAmUl9bL9HlkYnyVAczVffOS0ljQIuV4dp?=
 =?us-ascii?Q?phMwhA636sRI0CRWrD7TlXr+p1S8EPmXioT04dP5hDM4JszfyT2Er4pFxw1M?=
 =?us-ascii?Q?PBO8hY5ngkQfN+jgXlRRBjANLh6Kc0TpZJhY9gEpXmbaTy0a1CcQOIthL8+y?=
 =?us-ascii?Q?kTc4286VhOtZRs4r9dwc4gxKuDqoJWVNtOGwSW8lAqESnx2hYanEr98Letsd?=
 =?us-ascii?Q?uGTym0CIs7HhuJ8lni35YdWk/a5f0rd9/DN3z3nykwAR80RGB5X/9IIik13U?=
 =?us-ascii?Q?EEb5bcP5mElf2X4CKD9Sqsc8/2maz0HLuG7PIDdR8lgH6u6x7DvRE22Mp4Vu?=
 =?us-ascii?Q?Np+fsrF58sMIDsEbDI15DJT+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35d414d-37b7-4a55-e548-08d9840dc7dd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:28:18.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7/Pel0kpQlx8NVMuzwSC0/gt+WvN+6TuABVMrdWk6c+G4cDiKO0qsLpAk50RvVyc7DFq7jDvroZHbv0p2U5AgmaTfpHpN8lyMxADC6LmS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300078
X-Proofpoint-ORIG-GUID: uhseK97Mx8kGdGKnhhYAFBlMXeMeEiru
X-Proofpoint-GUID: uhseK97Mx8kGdGKnhhYAFBlMXeMeEiru
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This check has a signedness bug and does not work.  If "length" is
larger than "PAGE_SIZE" then "PAGE_SIZE - length" is not negative
but instead it is a large unsigned value.  Fortunately, Takashi Iwai
changed this code to use scnprint() instead of snprintf() so now
"length" is never larger than "PAGE_SIZE - 1" and the check can be
removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 19926beeb3b7..8502b7d8df89 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -129,11 +129,10 @@ static ssize_t available_uuids_show(struct device *dev,
 
 	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
 		if (priv->uuid_bitmap & (1 << i))
-			if (PAGE_SIZE - length > 0)
-				length += scnprintf(&buf[length],
-						   PAGE_SIZE - length,
-						   "%s\n",
-						   int3400_thermal_uuids[i]);
+			length += scnprintf(&buf[length],
+					    PAGE_SIZE - length,
+					    "%s\n",
+					    int3400_thermal_uuids[i]);
 	}
 
 	return length;
-- 
2.20.1

