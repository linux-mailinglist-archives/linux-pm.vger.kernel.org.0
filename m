Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615745FF923
	for <lists+linux-pm@lfdr.de>; Sat, 15 Oct 2022 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJOI1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Oct 2022 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJOI07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2022 04:26:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA35007D;
        Sat, 15 Oct 2022 01:26:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29F8BtIY012234;
        Sat, 15 Oct 2022 08:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=4E3hi4f0lGJNzZ0C9yluMXI76fVAAui2Gpa2AVnZ+xc=;
 b=ZsYGZIQ0ESFaclcI3qhXy85PYP48+TrLhyHBl4lo3m6alTrv4mYasoZxFFg+ZUSf8xt5
 w4mz6vgzfyIxzb0JM0WxSndYRo0HcE3mCQttM8FtP1LLsv1KNSXwUBf4JjMVLhdjLMnt
 3XEqrKPz4KIWbxEG9Fj+RPJa1ze3SUwcmhDvQUEPOBD8hEWBoPB1GmYZ/fPjoQ75l06v
 Yoffvv65iEvBB9IFjq4wprw8u7+yfjzXSFX+Eqm1RDhxxMRObFlw4TAplx0gq+4lCDhH
 8/b9FzxGgwaPwvk5hQkHzeFjd9FRO3sP0u4mOermSdvJgGN6scBneExdcqzboC3ZZTz8 bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw38721-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 08:26:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29F3DdDl030748;
        Sat, 15 Oct 2022 08:26:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k7ka1d3s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Oct 2022 08:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esrMv5pPYC4KLUci7hDQ1K7pUnwg9h6NHByDH6qZkHAbRaN0eHU5IkMXMTkhZ84MlmcqPk/VXGa7VbBx2dHUgZ5zoLmoKPiTqCpfA8CPmAL8vEEsk+Tf48dENjPTOwvR/wg8iShEk+uXo9CsziFNTUeSI6yzYsZx9Kn+iXJJGnAcYYp56YkaDZLzMHOHtdB5kxnpSyAPlclr7bIdNzNEwQ6R/4qaqwE7pRk06POq1KKIaYg2hXAm4Pvy0Hjb2IHP0hlqEIbyM6dyxIdyLlTbq2Rb1kim10Kk20hpZEx+qU7fXoL4C5Ltl5dRmoxpaO0JzRn+U/SE/Qfjwp95MyZSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E3hi4f0lGJNzZ0C9yluMXI76fVAAui2Gpa2AVnZ+xc=;
 b=M9NAb8M7BgpbVVzZs9miwh03x6Z6c4MQvJOnzA/mhrBBBxSVTDH8KOx3y8wvN0oKx90+NhzoEDTfSMnWa+7dN++ZEYF6Mgj5S9cokU41mtb2kXqPLyYGF67RhaEdbTjPkpZvKpRB3lj2n48/McNMIlNq8eNPNUsHFbDEDmlDLkfD9RnhQlrTv33inUBzLHG6u4clrjuHjjkonm4wgxw/Rq6Tg3Q8+kMAWBRqWnEV1WvQYediM1hk0qbz34jUKyNJRqv9p+jWx9ipfd3zz7r4Z5eoJEFVIFN64y2XHfFQI9qduFDKpZfzzlgjtch4ppGVNoh6mg4vgSGQ43qh8T2fcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E3hi4f0lGJNzZ0C9yluMXI76fVAAui2Gpa2AVnZ+xc=;
 b=hd2ayJmAEOByFEeWwBe7kmUT2IPPNQNMuJb/JpHtnPo9WNZzgW/zOtYE3K+Kgae3IuM5C/+uHU5I6xbyKX1HXVudlVCW7dryfQ5KgqOX8zuiSBGTTeQzbpogj24rnpT2QbL6CJQme3o62XU6IVxDGEKb5YTx6UnE2pV6DO/MeEM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5595.namprd10.prod.outlook.com
 (2603:10b6:510:f7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 15 Oct
 2022 08:26:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Sat, 15 Oct 2022
 08:26:47 +0000
Date:   Sat, 15 Oct 2022 11:26:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: rk817: check correct variable
Message-ID: <Y0puvQLWS/rQ7hSb@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: LO2P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: d75731ae-a54f-485c-da4c-08daae870016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeJSYhd67Yss9lZMBWc3urOKxUa+QuMM4RROOyuDs6/+zhMUrDpAmaJshM8HkaKZMjgZ9jF50OGY5em8tODB53nkOaxAWESI1qMBZlIlpfQm10UoutO0UjWzenrNdHK4/e7ycZImFNiaK8nE6mutOZmWgRbF/Gn2VBFd73xnqxLxh1E+EqMKu3Wrm9klJQ7I159k2XjDDBhhNghD9SZB9GXhqDE/8h0E6kZoZ22mizjD3MAHRZHqEDMLcWxtiKexae+DiuqIO3HkiXUgGtwC8ULCT4ZOWIYa7X98TEzueOBSY24WJpaX1oZs+QkdugK3LUXTjhjwUyPofMd/MpV56dwDdXDwUBdnALJfZ9Av7l9Sknczs81AnX8Eb+pqkLf81FUwysNuM3n72FQusispLBu6v89+dOYFY9Gj+afOPj+Hf3laRxPqYrco4Pb0NvCE1DDxH243hv8BzARi8/zxNsg8+2SwGe7lGx1hwB0MRduQ2HkExjJpuQHA1Rd4NHdVkwFLumBk2wf89+u73C4VrHap9xJc9vjDyPyGQEAaUtvFdWzShPcMrToIbWnrUZNXxa1XGg+s8HzRma484oUzjXjopy+jYZ9pml5SSnB4fyquyVMKGgRCGVmH9w1PKb8/3milGF4b/sBUkZixtkCYMDK/7UItJH2/Yb8IdK8zOrQ3skLsH+iQdyBM3MT+yimS4gnirSl3eUsEiRzAGrv5Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(66556008)(54906003)(110136005)(8936002)(38100700002)(5660300002)(6506007)(186003)(86362001)(66476007)(316002)(8676002)(9686003)(6666004)(83380400001)(4326008)(6512007)(44832011)(478600001)(6486002)(33716001)(2906002)(41300700001)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAnB6GrudGPOVEVxVG1wA+uTq3gcm95RizAbYU/LmuMq92OjWnna3XAvwt3f?=
 =?us-ascii?Q?++ImyKxKQyslGfWVgB2ELBN75Ht059Cvd8chz4mioAs0Bs1+0qC6LnnUXhrs?=
 =?us-ascii?Q?+nju4euoWa2TDCVH2vf64WGHoSCkxd9S++fElAyghWofZXt2PQk+lFRYGGyq?=
 =?us-ascii?Q?Px7DGxfDBE/3fNUtVxJQ/DWe1LgwKXJ+50/JpqzvNNMQUYvIjMUoU2yNY2o4?=
 =?us-ascii?Q?jXIEg62RCZuJy4SdZUB/ukFS1/I+hQXMWxhob77R1T/EN4N8bSKXxtCqtA/P?=
 =?us-ascii?Q?2dwewITK+9IyzRf3ISri339lgZ76NaKFIDHe1msOXhGZFZUSvufklHxx6A04?=
 =?us-ascii?Q?8GYfgvaVFlYy3WnCpH5g8Q0UOnTB/fzNC/Tyr/poxVO2mCX0eEmOiKHEqZqX?=
 =?us-ascii?Q?qYN/A5AgbD74ZX+qJ/Ax/OKliJaYQ1YJSszmQR6KvltKPSLMf5VC5uasZmMO?=
 =?us-ascii?Q?B6XFwRPhu65y2cmSadWnOZ52EW7pq7XV1JgA+ePPr1Sn4oUPpEPL4H1pVmCg?=
 =?us-ascii?Q?1jUAdKeq2YUFws0uWqaMiOCCLdvRTSbQBbAc97ILFUbP3Jowz2+tV80sNA4J?=
 =?us-ascii?Q?SehVXq+zTSxUa5tCy5sxpJbNagYdKLZ7DqYQNagXIn21HJ9N89txgsdICQB5?=
 =?us-ascii?Q?Q2hZmPXMXU7/oAwgCCLj6l5jYfcOK4b3R8xyVR0gJ+78ga+iM0WaS0ZnEsPh?=
 =?us-ascii?Q?B7yocpirkKzdjoy2+zN7xk0AnRIGz6P33ddmbmF7Lu9Tx2ocay7x2i9JOC7Q?=
 =?us-ascii?Q?IQ3jS51/SJbl80giUA+l618RVUsJoWqzHpRkox8WUdA+iFvK0dAdjF1wcJYl?=
 =?us-ascii?Q?P8PYEJhfZpQFGh50I7gjxLG8hBPaoHVEWoZSmWrTC///7rANNTLoRV0oHhhL?=
 =?us-ascii?Q?qb2IDJs7YuR1XtTN9udL6MEElmN4Y8hbuSP5QgATNkJKs4OGg327x0F9N9Xt?=
 =?us-ascii?Q?MB27FxiIkSBMrMF31xh0MJiO99lCjy1YKF3nlIp8EDSsUyLqroeC9+BqKLC0?=
 =?us-ascii?Q?fHzIS2V4w12827nr681SxGRv0mB8GEJ18BdLXG0EZZ1qylp3H6uiftsX08UF?=
 =?us-ascii?Q?bedFG3AbpeppYF3soKdFoRgeCr4GVkcknrXj7kW3LyeimDnTeNAZA7lWeN2G?=
 =?us-ascii?Q?OBY/ctcnUfHvRVgpItdLv8yUW/xX15XXBc3PazF+GkJXrsAgznmMuJb9LV+7?=
 =?us-ascii?Q?sAVEIyg33+Qf6uinLXYprAuzmiXm0HlEAY+F6MsloNLSkt9rVxBBzsaXG8c+?=
 =?us-ascii?Q?Qx4HuWtq177wi/XGnHBelZdutIchtIF6z1uk9f9tQiVIJ69kkz1WakO6b3nD?=
 =?us-ascii?Q?av4o31kMAHOSrJnjS8j65X6qTSGGgn5lmOJs9Nx8jWMXs5Uy5O5WaZMrxeiw?=
 =?us-ascii?Q?iZFPDMIaf+vI9QmpEdInxcrLRXCiWVIISTC14SmNLPX/ngav8/SKslXDbc/5?=
 =?us-ascii?Q?RgHcDaIVJxDI7IVlPgFGAKXPBZRoTcCm3eFD3dqKfJwrOaSfbs/tjQgBKzP0?=
 =?us-ascii?Q?EfVdr6W60uf5RKtQA/Y1VutjNuFI9GcSfEQTop63a3V/+dWq+FOBllw8Nk2C?=
 =?us-ascii?Q?x09CxkM8pP5EgnnbN7vpsYmVk3KUlNzwulvvYwnYfHTe8CUUqV09dMHDDF/P?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75731ae-a54f-485c-da4c-08daae870016
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 08:26:47.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvSvyclnPjIylAih9FBNZ+Cu8wcT8RlQUv5/EBH2lTkvdOCwJDeHcH8DiKTzk5qTL/fmeosjqSPBlIYbeYenUPPRNaEpVZg6Rq/oZ/EpIAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-15_04,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210150047
X-Proofpoint-ORIG-GUID: Q0VLKKuX7AMDC5FgQbNvwrZvDoF0OIF_
X-Proofpoint-GUID: Q0VLKKuX7AMDC5FgQbNvwrZvDoF0OIF_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This code checks "->chg_ps" twice when it was supposed to check
"->bat_ps".

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/supply/rk817_charger.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 635f051b0821..4e9c7b191266 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1116,14 +1116,12 @@ static int rk817_charger_probe(struct platform_device *pdev)
 
 	charger->bat_ps = devm_power_supply_register(&pdev->dev,
 						     &rk817_bat_desc, &pscfg);
-
-	charger->chg_ps = devm_power_supply_register(&pdev->dev,
-						     &rk817_chg_desc, &pscfg);
-
-	if (IS_ERR(charger->chg_ps))
+	if (IS_ERR(charger->bat_ps))
 		return dev_err_probe(dev, -EINVAL,
 				     "Battery failed to probe\n");
 
+	charger->chg_ps = devm_power_supply_register(&pdev->dev,
+						     &rk817_chg_desc, &pscfg);
 	if (IS_ERR(charger->chg_ps))
 		return dev_err_probe(dev, -EINVAL,
 				     "Charger failed to probe\n");
-- 
2.35.1

