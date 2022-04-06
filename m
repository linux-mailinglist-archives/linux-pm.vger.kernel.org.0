Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9494F5AC6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbiDFKN1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357525AbiDFKM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 06:12:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCA1A8FD8;
        Tue,  5 Apr 2022 23:40:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2360Yg2m001019;
        Wed, 6 Apr 2022 06:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JhuJNK5UhpiQPOjo92p8KCTtLVNOLPhpEn0ztFtLO6U=;
 b=AOoDKWqD2L6hHPlTnq81Ss2IHDmqxTQA2qp+4ouYKp0WtNsJxc5In2LkFs9M6jUFe3S1
 bJIrJ/kYCsdmhE+ZDDGYHO4zSVEniGQDfGZZR+LgyAFOwi6iADhg2uXMzbhYgRVfC4gB
 y0oq3a4/KuQSDQrSEAYlXWRL5K1XrVfd3vfi13T2tsmiwXxT6TKmfs7NMnPhFlfA4Ox0
 fgiysY8tgQE5U9o1/ZC0i7oNj1nfO848A/vFft1YsT91TyfvLIJMy7Hy9ecWb3focvLv
 laNiMuWspdY5fAFenT6ARaHd7aLseFUuvoE5W0lhshExtC1kIv4spIrvfqDdsTs/vrr8 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sqwt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 06:40:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2366UpDB034554;
        Wed, 6 Apr 2022 06:40:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx49506-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 06:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTOCkRF3Nk8l0GBtwW7hNM+zbyQd3Xbz33gtpSAVF83+wyDC8zCAsE++XJeG0HrjxnGZfe8VyVpMRhaWP1nq+1uu5P/qJNym3k7QTwVLjB9DF0LPCUMdX59WsO2BPkQyMupEdb8EcEThF4ic5rHuwSqxbLLYEtw3joykQhnRlrya7Pmc7WXZslhKhkt5CBxe3GfAuUOPAe6rhxho458p4lUQp8Z9JyJ+UBiFS17tYT2yfNUDwafxMkqBQ0dv9++/oDwsTxS5D6aIbxmEb99Bs04Xj7q/IyA9Zx50hcRrTGhNikTlD6ro3bn5r8n9+aDOwRPRZfMpDxi4/oo5EvIqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhuJNK5UhpiQPOjo92p8KCTtLVNOLPhpEn0ztFtLO6U=;
 b=MsZ6ZfBcDEqeKB2JZ789eTZuNGlm+6wvjjORIcpU8cLdGh+eDJmegMQY6q81YoZAFBt8ZVy42T9ILR7Gru0y+q2YnqvdWE4+s0dLo7I10vyymORBjsv6eZvdmtX59Qpt1iCH2J49+cpS1z/BdczP6LuOi1ohI1lq9FPV1Lk1VYsZ9jBirYiTt4SBMT0mZucu9th1Z/7Mgv93x/yEu3hYIQ5M4v5vyQF2tmBFX8EtX13OWN8lEUKaEffe2FlfIvuJX1qlxCYfbiZeJlWpqWTlevrkclssl/9zEn6Ckbeo+j2zsVLDBgayEtrdpU9s2qY3HJF/TG5bWSFPxP+D8mZeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhuJNK5UhpiQPOjo92p8KCTtLVNOLPhpEn0ztFtLO6U=;
 b=wEwhfVSdrnAMr7hr3d4h7rpjkpZrB7OYh0nunxuXNW1ciBcAr30kR6nfFnQYVHS0dQPp4JN1By+0rG470MS9pnk2sQkpgQBtyWhBzHNTdgjTPvsRYkZF1V4uWcZdDbpGhVdZeyV5eokieGyu4lAtOp+zseFilxJRN5fgiUSQNt8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2687.namprd10.prod.outlook.com
 (2603:10b6:805:49::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 06:40:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 06:40:25 +0000
Date:   Wed, 6 Apr 2022 09:40:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] OPP: call of_node_put() on error path in
 _bandwidth_supported()
Message-ID: <20220406064014.GA28099@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0055.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7e2ef5-900a-40b5-49b6-08da179854fd
X-MS-TrafficTypeDiagnostic: SN6PR10MB2687:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB268798693A2C5F17C6EFA05B8EE79@SN6PR10MB2687.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nz+bBJBvfDRBpYDRBVZ5qFnAV+dIk6x3ACGHJktAUm0W83DdW/p1gFjS0AEbu10N2xTcBFpjm96I2ZbCDSmzoRf90SA07P0OWDSk0i97oF5D5GKYki01qIjs2JCL7INpPAGWnBN+FQZKRJn5rHfkc19tRccOP2CaXOFtEsiR3d/WneOc+6KEErRXfRcufa54Z82b+tSTjRCQAnEgFXvR32O7rY05XzcFVtNP9/25fmq9KyGU4ru4IHXJuqt2rdGJ2EBfrF8/iLJX5TpegFAIJT6MbL8QgksCIItYRztiqS5QKHsuryXCfh21jjuq4a9P0mpmdvmQZnzwOKTc7ALHP0V3o7aXUgEghsM+fyHjdzeZWs6cBHKRebbC7jnT+H7u+8QKlAJghmLX1880mHFVd+7HLIB84rj6XVg/kAqSPGeSU8wj7EFC3vHBwWK3MjXHSh4yE4lU4k2PdLsj+8k9rZLC83BrvmD+SgKWXrhZHQiTXutA57ERPQWY2BeScovPJsC5vjJg8sac/aWxTU/rVShXJDKMdsJi1gafGmkm2mWu/Ut38CyUe9cfrsOcYqJb1blUJjbLD/QRVICOT918ISn2eZpjx/1idakpFFOs6BVO4PF4mha+8IW2Su9rMmVAa/JpS4Sslf5OfaEkSGxkyCXCx9O5B5NIRUw5RtA3uTrLWjR9Zsbk+yFka5hiaeIzzCwpJQRHXXM/87Pw2O7CvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(38100700002)(38350700002)(83380400001)(33716001)(86362001)(52116002)(6506007)(4744005)(66946007)(66476007)(6486002)(66556008)(54906003)(508600001)(6916009)(2906002)(9686003)(186003)(26005)(1076003)(6666004)(6512007)(44832011)(5660300002)(8676002)(8936002)(4326008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTFHYNfr5+LxGkN/lFQlEiXoRm2qGUsppVaNVwmThoobJJkvnmDl8HMZXy0r?=
 =?us-ascii?Q?0DlepWc9BBigV3ld7XC33ohIPqG10ctL1UROK6jImm+R26q6tl//VfBFp4yI?=
 =?us-ascii?Q?dU2PRMSazpdEoqGPWijO818Eta+MjDXGSh6/7OD9YNRaNKLXddcddwWT1ljO?=
 =?us-ascii?Q?ch8eU5fkf1JLDjsNXnMMZm2y1hLvcK+8v7C3v1IWUVbkh4aiqpwMbbYTJDgW?=
 =?us-ascii?Q?/UI67aViu6/6XcD+Oogv91CHVbcHoNiasy72NsUCFO806sfdS4yuKF/CCbtz?=
 =?us-ascii?Q?oZcC9lGcTvi6rb8G9Zmd3qxaDSEIRvMjcZ61WLrI36EbP1glDz77ZTaNW7TP?=
 =?us-ascii?Q?z/lG5mkcELMe0g7ierWWdLPJI6Tjf/6wN5bdR11UX1h4dJZFamupJquQAjlh?=
 =?us-ascii?Q?oKZznsVKQolD+rlcLYHmwgoszl7RveNeQLGBC5dJCtIOyYrfVwEchTqfNh0O?=
 =?us-ascii?Q?Lqz0jMECwDnpBgz7nxIKi5QUvQkt++Xca5Zp9oMWfTqokghRYV6orm4C7MGK?=
 =?us-ascii?Q?2Vq8Uc03efx2HEf9CMp2iuiD941YufMp26ah4/ST8CZNQ2mdiIAS6gczM4qu?=
 =?us-ascii?Q?UcdCONUDzl0eI4HATL0Ix47OsRK24Dmz+v7aJKIVvyYoGFZz2TdVyTHzV1Or?=
 =?us-ascii?Q?oQW2vrbufEMGzro6ZP1zYwT3tpwJjkkak8iS2zGh3VExXf1TEsYBwcxpMj9a?=
 =?us-ascii?Q?AMFGcdZqRfpS0wm9mdk/A2WPX8JI8gf5uarr6YCyRCC3M7Pab5CUQ+EaPsBw?=
 =?us-ascii?Q?Vgq81slcs2X9HZ+sZgfzEh+v4dRzAJwMvDnfz68kWhOQFVqaEbG8oZfPYYiZ?=
 =?us-ascii?Q?2FltMJzeXwUFV9E3GhbMT1wSga6SyW77r793ZpTfw0KsAM3HkJz1Y6TZo0v0?=
 =?us-ascii?Q?lqvfdlz9ixWnv15DTcR0dZHNt37o36KFcM2xQR99HRhz6YtXORLeKHmrcHsI?=
 =?us-ascii?Q?gPRdR2erKT0PuplDUrJMKxRbnKaHJLlr4QNm2Y4g4kBOJnw8cU5yXQXDKOm+?=
 =?us-ascii?Q?gMKEi3rKnt3zIrjkvPYInGxzNrLaVew4iEQQQEWNkFZB5FrgHV62kiFHl7Ma?=
 =?us-ascii?Q?lQS7ZRwHPfN+2GAULIeVWM/KaV/foTwn77b/wvg7FZce/fLX8eZ3FPVWV+Uj?=
 =?us-ascii?Q?rLuY7PLFk0CY43mrViTF4D48oSZL0pLfPoNx24g3hLCOT3BQ6+YMzAzyOWeY?=
 =?us-ascii?Q?ANebrGh5C9eDSjbdAsAPZ+2NHYYjVqwN2CykHB9QI5hr2N0rM61LFk2Cmp+S?=
 =?us-ascii?Q?WJtVnTh+EOe6Pr0b3F3bivEGnRHks+J7G79QBDMFmUFpP17Z+jUtpuqs4ymi?=
 =?us-ascii?Q?AtcPblDTtSZ1OlGVkCkzKNk5IQjxxZewtCxmlCmiHrmxCM8XLnVqNKdp8kbR?=
 =?us-ascii?Q?XcB1BH0V9EhVmp246jTJOPp5JF+aduQKz6YpGtL7ZS+rH7l+alKHg5IR5ve/?=
 =?us-ascii?Q?j+MuSwFYJBF/xMq36xcN4BaM63cmhgLuuDvl///GIho0rGS/8K9QSHx/avKR?=
 =?us-ascii?Q?Mj4h1WJbOQRzzBUjaGV6rgoHFKExtGLgNcVyJwQpBeFrUa8UfNcow3qJG5NO?=
 =?us-ascii?Q?CNfBFKwploMCIzOKeunA/Kpl4dU26r8LP6GEt8F7YELkUDrbsO/OAiauggwL?=
 =?us-ascii?Q?GY/3h+0LZEI+Mlx66YTW8yu3Fu5tl5vUFH/FHauvpBmBwYFweffHcKXWI17/?=
 =?us-ascii?Q?noT9zFBNM4ipDJClQvi2YiQgD07FQY8o1p1sADl/IRS6GTxWwN0pTVmLPKkv?=
 =?us-ascii?Q?Yp2OtkoK0H8S/i3Q3kBobge5M3qgf24=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7e2ef5-900a-40b5-49b6-08da179854fd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:40:25.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCMZM3FC69q1KdCf5OlHonH4LhSPV39QR/lJe4qdnFnLtSc0G8mkMGKSQv8NrSB1aeqLISTLVdEo73WPdBrrrJ0bREWc3EHvVlUUT3m9Pm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2687
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_02:2022-04-04,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060028
X-Proofpoint-ORIG-GUID: n37AP-xC0dd1-g0afeHN2gKmy08IG_8k
X-Proofpoint-GUID: n37AP-xC0dd1-g0afeHN2gKmy08IG_8k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This code does not call of_node_put(opp_np) if of_get_next_available_child()
returns NULL.  But it should.

Fixes: 45679f9b508f ("opp: Don't parse icc paths unnecessarily")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 440ab5a03df9..95b184fc3372 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -437,11 +437,11 @@ static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
 
 	/* Checking only first OPP is sufficient */
 	np = of_get_next_available_child(opp_np, NULL);
+	of_node_put(opp_np);
 	if (!np) {
 		dev_err(dev, "OPP table empty\n");
 		return -EINVAL;
 	}
-	of_node_put(opp_np);
 
 	prop = of_find_property(np, "opp-peak-kBps", NULL);
 	of_node_put(np);
-- 
2.20.1

