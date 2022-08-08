Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDA58C787
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 13:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbiHHLaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 07:30:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6F9E0C7;
        Mon,  8 Aug 2022 04:29:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ASmIY015210;
        Mon, 8 Aug 2022 11:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=xjpIa5jb0cT7c+dDCFPoLT1GZJneSMzOd954EGh1L8U=;
 b=Q+/7A537W0FwXXlid3G7C7Jq8v5N5rBLLW/dwF7NPtDOOYO1PsD9Idh+g+T6adThg1xl
 wOPnwmmesH6exxBw4wzpde+tkLu4oZ27Vfg5ZqEuqvcOkmAw1bBIurcFJ0+jnMAEikQp
 ILHccyILvZpoD88e7Tw1+CCj2mVtUTlEuvd1rWe1vjiIQU1S+7GtKE8EyHds1ES/tgde
 RTDb91zU55AYxZuA4QNrBm8qM+8SUJ7nyFWgQ8wBbF6No+6s3oAyTAdMUeq1WXWa4+Db
 4EQR7zT5yUHaoEkqwqbD4R25xRXtfyNLmRhIeMswSxK/1Hv5tuJmwrtEZLGI0YHEogM0 Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hseqck7hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:29:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278AI8hK007743;
        Mon, 8 Aug 2022 11:29:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser1tn34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 11:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuZt+t2T5XvTKruHLkZ0N1a3sMedOoKFtEhNuVPynr8ytck30YwODeJw+IEcs6HKLB7HM0loNoxrSxUF0LcKjRtm9+H9vr94CBqKzBoKrOVrp/ftnPFwLF+JeLXz+H9JZBllvkZcU1Pz+NXxkpbuuhI+YWesunTH8PLTQ09NlrUlWygTAVggzPper7jOHQ6aFyCjvrM2RrcDf7QXAij5cpXskxf7PXPVbYSG8uxx2NoNhxpdclAEWX3COAFNcjHBjTpWGCzirwkXmcUyXncUiuHZDkutWXcmsT668Z3FEBI3ZpS72qa5+gsI/ZQTo8dSrNGDgS0tLVJYH8EVvWqFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjpIa5jb0cT7c+dDCFPoLT1GZJneSMzOd954EGh1L8U=;
 b=a45v5I82PN9zrLgAfcroqJYg04pfD39Vm5cXmYuiCkpYV7++TqwD2u4tLRUv/6ELSWrI9xJ56t3sbsV9m64xoVCzzR8xyYPYQaQZvRxWjYodKrEK11vQtttrKt2jQxhWC8uVFYyTG+AOu58x3v9B/JW1Aq3iLIZCseFfREHt7iF8nuGocurzGTiSTMM0fb9rqe1h0wM58cns0M00G0mi6Lzd5pHNB9jODizKfojPKv6jm9h2XovZwhBM/4MLMmMeo0fOSwiS5vQCsbm+YndNnFForPSvJCXjWvXiZUjOc/Lb9LwrxN2JjOS6ERNW94LoLtyzFGM7M0JGGbpOz+fXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjpIa5jb0cT7c+dDCFPoLT1GZJneSMzOd954EGh1L8U=;
 b=j4VfqqvVQJHTkSevsPZeegS45wofoKEm7rWzQVJk5dpX5VAUOht1lCc+2n+r2y1bxRbZ8GDw5lvkPuH5EHO2k1WtrljvsMNPP4RKtn1GVxGFCfsLkYU9zO+yQsaKBcAqndDk/X+PWnPB5RxC8TijLVkE5bOOfCDAdanu2EvYjsA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB6120.namprd10.prod.outlook.com
 (2603:10b6:930:34::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 11:29:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 11:29:49 +0000
Date:   Mon, 8 Aug 2022 14:29:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/of: fix error code in of_thermal_zone_find()
Message-ID: <YvDzovkMCQecPDjz@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0107.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ecd393e-2f8c-4596-5d02-08da79314dfd
X-MS-TrafficTypeDiagnostic: CY5PR10MB6120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riWD8lVVbWuzZPdk19JCumvVWDjdzZe/gACKjxhDATdXvExxvAuNXiqDNmkMzka9MIbZURi/Y8efIDDlP33GmuzYYn6T+VtrPB4Rl+/z4cNkVF+mrKvAPosI1vZU7oKM0s8qqHGnyBwYem/P4MAIa6xm+powBzURAXu0kv3FI/vorKzOHPYkuR+5kGcYgGzpUew4XaPBzHF780vbmCBwT9tdYPh0ZwWRa6+S7C1XG9j6+K5/9LmKoumtgmt7OrX76jaDm4xdYLvBN8o3MUBXrDs/OJKteSb07QQvFoZ46nccw6jK3WmuggJvNki76dHusfudqNBbd+ZrGO6DfFROzD2xyUUHv9Y9vypRVdphsmUYGj4h5Y6fu+q/sGi33Gtl0/ZUunlLhjH1b1M6rDWw45mn+sdMDwJIuhfUdZgdpbuX4Dh4FjLBA323+g/yG8hFarr1J1V/53jgDO3PHw0p/gtvxDwqZhUy32stwLp1QUgOb5ntRsRXfX8mZSRw9SgmrXo+AMNFPed7kRIpptSbB7w+5jEi4WgZ1yFyQFHwYPgQYn1iujcRReh4Y+IEn6jP+dNJsOg9AG98YPUAjXezNR95iu2vRa5Q4Gl3xpythgHWHah44jy7Ec19j6k83gASTCiGfvnRXHHunDH/+3i+lQy10D7rH2EH99OTAiqltdg1xndimg00vqG8VhQVNDYccJ/6w0Qgcg0EyvJhniaTvknjqGG2z8NMUCCL7plXu7S5Mq8Oj94253qkZ94jlEz+5Lkr1dKCWTT+M/mza8zKn36mAW6zBFwZZ7EHkMMzOX89S+5hhhKHps/Xtucc6TBN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(66476007)(66556008)(5660300002)(8676002)(4326008)(316002)(54906003)(33716001)(110136005)(86362001)(4744005)(44832011)(8936002)(2906002)(38100700002)(38350700002)(6512007)(41300700001)(9686003)(6506007)(52116002)(6666004)(478600001)(6486002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UE31T8jytcZuNuqnUXXJdGytYtJkXstfNA222sjDuGM87yyyCIP5KZGZ30uu?=
 =?us-ascii?Q?HuqgQ6t3342QLwOo1xZH9fS8SBmsEMfavdMGJv1Rv4ZZr0cpzi2TG3AZMNa4?=
 =?us-ascii?Q?7yy6ttEUrEXaWyP75ozfISR5hZgigMSoOOurMZSvvz+NcLpqf6WwucYDbpTf?=
 =?us-ascii?Q?7bkqsRZt/fqjsXHsM5TTJ7XjZ9VOZ6X8DG8aRNcBVgn2rAHqOXPaXLonJ+wD?=
 =?us-ascii?Q?yboAZKEHrJTTIPD/k0M4CF/Q3K1e2TiBfVOPe1wI4FjFVFj4uLc+dxfQ99Ic?=
 =?us-ascii?Q?5hG3xowKDutKFTOyxUbEEsY2ZF34J1MqeEdNIlCtHSw1/lnsscOet/Mukur9?=
 =?us-ascii?Q?KfaA3UFuPHYd8I2gGVIf1HB1TTSKa8ZaXZCbkCi2EhEJYviM0f9A2wwgq2IQ?=
 =?us-ascii?Q?jE+3NIiHbF0Anpsf2pKKKQiXhijf/u3J7QG7QzAVizFqOwVeQtjSXWzC/qrJ?=
 =?us-ascii?Q?ra0ItVvsbZsYLobRgiGPHotTUZBcVLlP3cw/5ZxMvTNoQbxmW1QMsfCTHYAM?=
 =?us-ascii?Q?fIdUfvNPy4NuCrGasBfu6555UR4ekx7iikmOhqK7SHAoQqqmlB7ljLdL24ka?=
 =?us-ascii?Q?8FZwQpotWz1bJBSzBmJsbyezNFMZoMKd/+2NNB0JUf2a9KlxIxPJT569gfil?=
 =?us-ascii?Q?fb5uMO284XYf/kXF1MCXjbf5gm1/qdaOSUGyTyc/FINi+ALWsBf5YtE2aUjo?=
 =?us-ascii?Q?0C7jsUkij+H7kh/z58e8z7KWzkW9OVdkV/C0D6yROaIJWjByc3THJxlxpc69?=
 =?us-ascii?Q?Ogsxv6/oADDoS5XDwphHFmWiWSgwHvTA92F0GDk2jQvtD/xdgm62qW9IzKms?=
 =?us-ascii?Q?Tiiy2KKZqL0J+w+tAqte5LhTiqyUKZEN+RtK41Kuh9YCwEuRThkSIz67pOEO?=
 =?us-ascii?Q?QJybkQjBigZkMaSF8sS0mKR8Bo43ATrtGOOtM6K55qAp9Q5QAhN7WuA7D7kT?=
 =?us-ascii?Q?c0GZj7WWUdAmwF0ojqnrOmcDbI+DH5fK5BdGQqqMIPrDvUB4T/qBB2x/PetV?=
 =?us-ascii?Q?xzyDTVp6QhQ40aaTomqnT/v9TgoAGSrfV/qUyQdVjt/Grfiii+waFYZl3h34?=
 =?us-ascii?Q?65um9FJhZ4I2OWo5b3/YbZnPtux6/noPoez37QW6ZBnABk93BgBP3q7H0Ifs?=
 =?us-ascii?Q?64xO58rZ7VAzA9k6GBSmYn2cobPwHxpvmraXs+T4Yp+g13bnPDHj0RLKIHEr?=
 =?us-ascii?Q?GSNxivtUYqUiqiPHRmdfHkEy1xele5Vjevxbmstuy9ahH3eqDPqnh3ytEG4t?=
 =?us-ascii?Q?5HqyQSoUR6vYgKXH5nztYWbU0BmxXvscxYYVPaTNFoDg9iCMc6oHKdGNk9k8?=
 =?us-ascii?Q?FqIK1prQV239DMhczbw8dr68jg4dF/SvPnYlAY8x+WLh5TNhT8ToE0tf53M8?=
 =?us-ascii?Q?Edu+Rf1chClYezyeRDQeb5XNNc7ZYro700Us3T8aeQLySB+s0ZCRlLYqqDe4?=
 =?us-ascii?Q?S9rwfwR4WF057wkgc2hx5PME6mEWY9Zl8752Z1wKKpFQtpUv9b1neCsFpg+p?=
 =?us-ascii?Q?Jpj7sMPnjE8L+4mw+kU27raAJ4cBFEHI4G58q5YDXyQVLcc1Zget77CLljOz?=
 =?us-ascii?Q?Y3FbIK9clCDpxD5i2N4VibMQaDd5mtpxWif4Kk5ElGBjpp3MeCC/Vkf+uJIo?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecd393e-2f8c-4596-5d02-08da79314dfd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 11:29:49.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKlEvcX1M7g+UOle+po2jKNWazzJVUUARb/zltuyHH8ExAnvupeHbevyN1beQyepdEbVVperkVUb7ssoeF1ntjrYOB7flkMzokMFm271xIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_08,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080057
X-Proofpoint-ORIG-GUID: c1iVzOhSZlrrluob3UahIoHVqc8vHPID
X-Proofpoint-GUID: c1iVzOhSZlrrluob3UahIoHVqc8vHPID
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, if we cannot find the correct thermal zone then this error
path returns NULL and it would lead to an Oops in the caller.  Return
ERR_PTR(-EINVAL) instead.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't know if this error path is really possible.  It's from static
analysis.

 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c2bb5954b21e..368eb58e97cf 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -368,6 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			}
 		}
 	}
+	tz = ERR_PTR(-EINVAL);
 out:
 	of_node_put(np);
 	return tz;
-- 
2.35.1

