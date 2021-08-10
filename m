Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCB3E55BE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhHJIpD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 04:45:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57182 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhHJIpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 04:45:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A8gCmL016137;
        Tue, 10 Aug 2021 08:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sXX1cTvJmqTTHSOO3RnGlSKyYCzBS1tgnP8mWl2esVA=;
 b=GRR0wA3gPDH95A+y9L3VgqL7jiy7bSB7AidVM/GqVlZhtHjEzUXlWVZn3ICHtYggLCBO
 +UqJeBGUdI1JVgaYcNV+nVhDnbv7zI660vWgD8bN0YvSLEpgrimVZ2K1WWb2YBMYK/5U
 nkRtePTCzNX4kwAZPto2kbVIf9dDcwIA6MKNDf6De9pV/Em0bwDHM4XbQdCrg5EQ8hLg
 W6ON0G2wZOK8dFOg3WiuEVk+UPUcTJbyPsOa+01E2NzUix0PVgw8Hd/Xh4YhJe0rO1YX
 zdLdheg/zVD2Pui/NfQM9dy+0HAbqLNJHWuV8E3mgcoFbKfIKcRgENopbRpo+hPpWpac Ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=sXX1cTvJmqTTHSOO3RnGlSKyYCzBS1tgnP8mWl2esVA=;
 b=zUIsy0aXr1Ko8SbNiJn8Q/R2T0/zzVU0fgok38CxPPaaW8qZBcYkkiNDELLIQhAPRszN
 i9GwclKrsSe384i4LmVom/gF1oxirJBKKorKlyAwbNYB1eLeIwLBKGSlMNKPBpfjce5H
 qpxix8c05C51OpoVqmyKrTlAurDnf7sy4arwWGKfB3FY7irexSGnB7PgGEgx6L8EO71x
 ixbKgu5hPhXXB95/22pVzA8Ym4X1rML62lZO6PMIJToN+9+HVJRmoE8jV46akT2FLDI1
 q7QjDBfLM5nZ2ej34eO5RLhsfaCGHyYe/qjwrWpTUOYSKEb6RyYkU35m8jEzu8TtDUuG 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fu40n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:44:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A8e5eh149448;
        Tue, 10 Aug 2021 08:44:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3abjw414hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faKMTgkxR/eajB7MgdsRzRexVr8PlG3uWEiY0feh2ufC/ygqp6ToSgRCb4bepQwfxIwppfyoHJcOaThgA63795tQwE9eodoC0Co4PJHQ5QYYeVW2HdRLMW8r4j6mV/xutSGENtjYuU6Cx1o/geE6Ce2Ml+ajyq9zekAm+frozp9mAHpXU0Arskn5/xYU2dm72khNyvlNUKV01pUxyBQq5IeH/1lddplJy/8xRCDM7QwaNiFNGX9pRRfsvU22DDWWjefhKBesbEiEUSeoSxKuEivCNWvJN1HqwIMJTJZpfhPsK789fDj4O3aVA06w93iYEGv8nMHhTSw+KWQZffiMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXX1cTvJmqTTHSOO3RnGlSKyYCzBS1tgnP8mWl2esVA=;
 b=jSwE109hzKiJFq1StQ6IfsQIaVOKS1H6pvrg+1cHFgMlZ8Z0BFVtCzYsfQUPHA9yEs+Z6vRjYIfUnhCmFZdfCJfuKhlCfWJl2CeA4VFcQa1RN8lTdfo7WK42kRKN08AEkz71tw15vOQsSjgHXhvOLCJcvTolsm4ZnSQBPB8llXIYCdysOiKNXeX2vyvc2zHe/21fJSn4cHTjVB12z5xOBp0odbspR0cxMYLNBu8OuU+vX59PjrAT7zXaY17UOu1kFURmyHB7l5KlmuNhXp0vErLgHay0sseEgLfKvKoEkgkXGJlZxv6KtkgS8LtMdt51o1BOJWO4niGd2nvHKENuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXX1cTvJmqTTHSOO3RnGlSKyYCzBS1tgnP8mWl2esVA=;
 b=PDzofpH1pfXNN864Faqr+JsucmE0XYnpP2Gg7NIiIl6xdRQvBfMzpL/1OBrrlWBdUEh/LEWWEf9YZudW1GddH9BkXxJYprWi9TRli7IfUvtzZfiit9znw17dHw+H8xNJIFh6TvFZTOCPbio2n6lH5P7y1SNGaYQAsHUcc/p0a7U=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1566.namprd10.prod.outlook.com
 (2603:10b6:300:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 08:44:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 08:44:28 +0000
Date:   Tue, 10 Aug 2021 11:44:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Abhilash Kesavan <a.kesavan@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: exynos: Fix an error code in exynos_tmu_probe()
Message-ID: <20210810084413.GA23810@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0059.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 08:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209f02a3-2a69-4ff8-f189-08d95bdb10be
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB156649CAC423408217D14A3E8EF79@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T66FognNnW4PksC6xmcYmtMKJUod9+6uk03LyvxUOY0f+tWOUX9+DsHRJUCIHm0HrnpC4knqv8noG85ebrn0wxPaYiVoWIU/bMYjdia5xyCk9byWwa3nDMnq/vKmpV93BBgckb4G5Q/bhSOeCpTvTckWka2wcIca4DPQ3mfIRTyPdsc52v03bYKNRkpdUhagAG0eaBWS3gQ4aN7/hovrQX8JR7qIeKJ6WyFTE1DrJB93e5Pv+66597fyvEvvx0GQrtGUppw2BVJrtzzEbZ5118JGtM7N7Jf6nKcWUZFHsWr0b3Jo3cRdSASVg1z0urCZWakVb1ZHfeNT0UxKLbJxoa5FDER+FLUy5raw3uXajLc8K6LeWZTI7e067WPXa9XYNVoAvCPLZIiXs+fVzl+ifpw8hQgRPl2upF+PO4yQ9puRmNTc7E8QanLDIpVaj12eBmyKVQB95MP1R/DXmCrxChgMRqPd8yKRxxHqLj5puY4ZWzIZdvd80kgV4VdisezMTfskzdo2TozOStdfoJhUSvEI58ZKsiYGwjg446Y1xUJ/1GONIpMD99mn9RtJONbVPxeX25YmAp1p2PK3sarCRIYi25G+6WFbTH69/mlJyDD7+dA+OmJKq0IN/5j90oL0iHjR9YMtQ/kpgWGPesmXa5ART4NnKlGXCyGQlxnjz0CBzfjyi80irMjxWSQkeev0sbi0+BiYSeqjPSAu7ZikvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(38350700002)(52116002)(1076003)(55016002)(86362001)(9686003)(478600001)(6496006)(956004)(33716001)(44832011)(54906003)(26005)(38100700002)(110136005)(6666004)(316002)(4326008)(8936002)(9576002)(66946007)(66476007)(66556008)(2906002)(8676002)(186003)(33656002)(5660300002)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmPrdx5MDMrS7+wKQ0HAwr+hgTy1Y3iuXyRKIOSAC3Ld/9iB3DmjmPpsP/yp?=
 =?us-ascii?Q?L1J7I1PKxNEz5S81IjRjpM4xnIkDy42l2cwurrBoIt4J2wcKZETOQS9iR9PY?=
 =?us-ascii?Q?DWHq3DrKVtMlcHP1cZ7PC5BgN3eKiLqLSjHYd6iQXJOtC+VVTxdVgrUnFHJb?=
 =?us-ascii?Q?bEL1HL3+ZtboaLWDWtP6O4pstckbxiFQNtF72uYQi35Ex6QCPtJaXnvoNMOg?=
 =?us-ascii?Q?I5mswo6ci4KdzKNJxMh3OM3KJgQzIxhepyycftvJ6GW3GMd2tBdiKoTROtBf?=
 =?us-ascii?Q?xyt12+uQ7cXRva3N3yfiennqCfYstTAyhXN1GXyzd3DwCo8daPWS01P3Pzok?=
 =?us-ascii?Q?mysVV01wfrCwWhLdED5tKrNqYdzzp6jOOU/0D3ii/uG6Lq6Yf074dVT2HIwb?=
 =?us-ascii?Q?5UUUSWGi+bgjdJRVu92g/0AQXSF2f2cYATMr88Vp6nnChGaOvpNBQ2zwePOg?=
 =?us-ascii?Q?R7cdK0sw8RSJb0fL766MNePAHn+aYf/wjqERDcuv5Hwn8TnsLmw2zpEjgByE?=
 =?us-ascii?Q?UAkILDyNIYx5h/OSC3QrM92402HN0arPjJU1TMmb5AdVy5+ACZG7K2IH1+Fi?=
 =?us-ascii?Q?u3ehsr21/02MWJClJSaeqSGw+grEBNIQN25UkwpDoNc6BQQaWc/944O74QvQ?=
 =?us-ascii?Q?lvx1sZsHfD1MUo4PxLRba3M+Mg5pEd/xQFUSd0MToQojWHgn6vs9u6Cg+rr4?=
 =?us-ascii?Q?QBcj+G9CwuHwvUPbrRWX4y12OGfDGry2tNJuDzzJ9mt2Uz1uTsM/e4KS6XmS?=
 =?us-ascii?Q?GWiLTnjIMT4IiC4RhBKfni8Z3YKafRH+N2oG68flgHkS+pSkYUcmTuElPRFM?=
 =?us-ascii?Q?PxiXY9UAJQ4GQP9OerUWwtdfKEuMqnyfwDe++U1t7qZKIreBiXu9HtZtNXYR?=
 =?us-ascii?Q?13kherrv4718pxCLvBRel2psdkTM5wsy5DhvRKyHjLE+ZtcjG3WOcR9+UOvf?=
 =?us-ascii?Q?wVIGDTQzbZgZc8p70Rkt4YaVbuRYSd5OPZQkklQBAR+6GrGGmnjwNZQDquy5?=
 =?us-ascii?Q?mZmJgDYr3w9M2Fy1hOsi63TSsIF9BuDn0PNngBbYoMBxjkykCfjS1t0zJtN8?=
 =?us-ascii?Q?XxgH1mHtshcH5wOWJBtaCsYFPjgbOW45INPq9hznjHoOI9s3dIq0Be8jnAvk?=
 =?us-ascii?Q?SYdLADmCNnvHejo6+Y23zU1BmjR8G7scx94JAtsTkrqtBofEkemR8feYk7EQ?=
 =?us-ascii?Q?8Ikmy/1EDTzndcYSfODZUu97OOYZGMfhbu5i6WyGpjBK86QzXIktVuKWho5c?=
 =?us-ascii?Q?7aSOfzvYw6Us7HJHy5gYsOUuyGXRn4ktCCXKfNwyEhR5bgnV+eUGQ9IYhF7d?=
 =?us-ascii?Q?DMVjAC0IfXpjKIEu6VdDXibN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f02a3-2a69-4ff8-f189-08d95bdb10be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 08:44:28.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmdUQvY+k3NU6WPFBkzfmyP52oAWnarFWQOP1UTFVTdyRAM1lq26rPadsBycpVIEt3XgaU9kWLQdnfzbkJ3nMF0wZbZq7HY4ixPbwkL4Jlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100054
X-Proofpoint-ORIG-GUID: RX7mUvLfs8AxSyIDm7pxGuUmnCPH6YD3
X-Proofpoint-GUID: RX7mUvLfs8AxSyIDm7pxGuUmnCPH6YD3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This error path return success but it should propagate the negative
error code from devm_clk_get().

Fixes: 6c247393cfdd ("thermal: exynos: Add TMU support for Exynos7 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e9a90bc23b11..f4ab4c5b4b62 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1073,6 +1073,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
+			ret = PTR_ERR(data->sclk);
 			goto err_clk;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
-- 
2.20.1

