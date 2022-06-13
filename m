Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB6548BB0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355553AbiFMM4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358038AbiFMMzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 08:55:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABAC13
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 04:13:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DAb8cL027136;
        Mon, 13 Jun 2022 11:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=a4fJ2Gu9aJowTZ3RVwjnYkGtrh+e2H116hzbvNv33Tw=;
 b=YuW55tFatkQMvBXs1PEcaTiBW8eVKAyJjSsP6b39CGgPOiu5ymPN7/8uC+sVjNX3Tp9T
 fn9/69drxZp9uZepqJf2989PGmnmi7D/KAjg7ZtKa+t7XFy0s3OsjdQXvI8FfIdyDwtu
 Z9G6/SI+tl47WTWFiMPmXt4pIkLQbBxOM1yLa0BkOx78fxldeg9WhZu5fOnDiKwkng+z
 V2QBa8EcZVt75ulrJNGWkOOS9ZP3gKuFNnu2HQuW91RG0bW1Hzl599HcNjmALTkh+ZtS
 Iq724SN5EjK6ejh9m6+GEt3MLV4Fr4CuKXBFxwWKNtS8XdYRqUlmxeJ9EsVJCHgdIrIn dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0au4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 11:13:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DBC0EE027625;
        Mon, 13 Jun 2022 11:13:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gp45cr10s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 11:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STQGmVZOA2rgL6iRA1X0OATAc0xn9gPyLqokVj5aKYWmUI/7RZy2vH/2pHHr7e8OCclOjm6wfJYy7FMK0EKX3dYFVt8umU8CYENEbPhWAdmr4ECBiq3R+w8Y1+WZ5r++uxpgU8XZJEF0IL5n/iI5tc2gYTOdlXblHrSe8icrLel1xYfunSr5iz593UsZqX+1Cf7BT9h6wz7vWTxWc3vix/nc99ueITLF0wnC8csoFjrvOsWaWdS49EOtzVM7e6bQ8wIRU6yWctzu5I3HLuvZ0oW5hx2uhU0jMrDKNrgs77n6qnsr2sPG1BW2sS1Ny1cVBZjGbAQGdIaREZgJy+B6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4fJ2Gu9aJowTZ3RVwjnYkGtrh+e2H116hzbvNv33Tw=;
 b=KRBBoX5EjnV906MdsxcSHXyyjoajYykjwffiyPkc7Tm/sSmL6zu8wehKvzS6egjcDsVPLom7OtVpyNjkRequrLEn7VCcfZi4d9NSz4VaWYv07NfxRucUmAggfRBd1oJBuU440oKLCN5wqJoGW9Pdcm+srYnRbgVgdBnCfomqCyKoZO0Ws/N6dbQA9KnES8cFWDXJB7g1F24CRt7UEZ5QOHp4cvukoodruMjgJhkvZ0dK2bBpyzsJLN67W+o07K4UwEZi8JrKONjG5nlusT3TUc3sk8m/jeYcYYrgZ34vnjtjRQ/97aSgZG/TI6YFZJCihRqddd7zaZGJU5C6zsE2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4fJ2Gu9aJowTZ3RVwjnYkGtrh+e2H116hzbvNv33Tw=;
 b=yWrxlyGz0BNXwYSVurI5JLteUWMHkESnvZBHJCP990ixaMl2op2W3/UKVRHBDp7OxTolZ9J2wcieFhEZmpwgBdt2tQIGKqoi2QVYM+vuhQYtX+toOjahvr/S5RRT6DZkoU7cQtAwZN5v4JowcK8dDjQOzzfvnc/DV8Baqs/PM+U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3445.namprd10.prod.outlook.com
 (2603:10b6:a03:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 11:13:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 11:13:42 +0000
Date:   Mon, 13 Jun 2022 14:13:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] PM / devfreq: mediatek: Introduce MediaTek CCI devfreq
 driver
Message-ID: <Yqcb2LyvqF/qRUsU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f811e30c-518f-4e1d-d357-08da4d2dc64e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3445:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB34456153F2B7F518D3BBC11C8EAB9@BYAPR10MB3445.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+Z3S6BCZVsV3dOlq/+hwPq9av0XgwlDsqU2xXmy7VgVxC5awRlJlW9QqwDIpmbse5/yM0VT/fuHzPGLMt4EL++/ACmMipeBEoEQ9rR3uN4zxXMSz7CNn9AuKaGvCO+aT32BlpJ2YY/cupPk+yGgH/WO2ugXQoLIACRDoar5D+6qOc7HG/cl6Lk1IErmAbAolRMUCYpXprIZXCtW1XJRicQN4vdiu2buSbtA0NrWzF7kAQKYg4y3x43qdf45lMupZuSjKG7zHjqaSgJgrYE2VMbGzl/P5xo19sOxbclSZ1B+z81n+nyEyaMv0NdxFFwAJ//yG/D0wfO3RcwLb8bwqS2tLtphisRBWljdLXfgQeUXCNruZ5Q8t83EU4LzpGrFSDGKbQJAJpxfV7q0x0RLPU1i9JFa1xSQx2w3JGS0ZP8nEFeRXirU08PiI8+c43orgPgIr44BgIQ1B6mhceGpc9eC6D0Uh1rdXWHg7MPxKi3rN6WLYSWzkfiQmOcbAn2WBJib1ua6ljUpXXzGzNKgMTLeJsG74sS63uZpE/DzdejOA1aiEaWSuwBE4WMK8zdbt5K0rb5ypLzYY3ZRCajOIkPIQ+i+9bqDPkEl0/IO35sRFZOpxfqmpO9gN7mE1WJthbTGPKGuGwBD9HJYdH8klpqvNnJ4+PG57vgKQqR3+a/alh/O48YA88aSapgV5vEsdqh8Zw5e01XXECXbP6Uoig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8676002)(66946007)(4326008)(66556008)(66476007)(8936002)(5660300002)(6512007)(6486002)(4744005)(6916009)(86362001)(508600001)(83380400001)(6506007)(33716001)(316002)(9686003)(6666004)(186003)(44832011)(2906002)(38100700002)(52116002)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JO2fIGql2LpVIPwz67/6bvoqkV27tWTTpcgBYBzvaVpttoNDIz9IQ/7t9U2n?=
 =?us-ascii?Q?OeuWeYUKLdJMNNcTnyfJp21Gjuwf04piIm/MTJk9orhe9xJhTTCwgqjn6Mzq?=
 =?us-ascii?Q?Yqh09dNBycMEEhYIqkrHu94u057fKx3wwxHKX+q4EpWiBU8tiwlljU/dauuk?=
 =?us-ascii?Q?L+hrsotJ0IRdkjfKUi8NUT3Ke5QRlQwdXO2rR0L1JuN9S2alg5jOkhXTBC/y?=
 =?us-ascii?Q?zVCWRQE+SFKBry/Z+YGCofi/XJ2uoEBkUwtIN02+OUxdSZSSeifphSAqLEgc?=
 =?us-ascii?Q?7kO/xDM8+zSR38zxNyn/4NPr7vLl8OTxc5qlnSLIRRPmMDwHHjr0siSqWuGZ?=
 =?us-ascii?Q?lghZDVjD72qKOS/h01nOJypwPJV0oZteaUJA4JLrJ4Y9r6a2yzKHESPEHXxy?=
 =?us-ascii?Q?yjXvi47cxFk4cmKdUNVCmUX+fyQMawY/dPZPQ1bBkBnAc9065X0TTGQkW7GK?=
 =?us-ascii?Q?41knCAmDaY3oDGT/Kb3nt7HDgPfSqvxPkiCUNnsjCH9FkAaJYGhoNZu8O9wY?=
 =?us-ascii?Q?iPjQ8N9RK4+sAWdWfPQQNbh8FcelDQ65brOOFzxr1Il4IaEjJgpntVYDP1uI?=
 =?us-ascii?Q?7W2Aqr8KvnssuNPlb1s42/2zYaq0wpLoqx4KJGunBuCP4HasLeADdjs06fjg?=
 =?us-ascii?Q?9nYVCA8e6MH0ib2526+7vfbqFbmg5H/7hcDlawlGs0aGvVetmNreAQHm/NlI?=
 =?us-ascii?Q?XfVWo5QqtkVbj5FzSWul3fCW6q1tkICBg01eN+zkRmpT/Wpq4hRYa7JgvO5H?=
 =?us-ascii?Q?y7cv0w43bR0vSVeRMf6EAxZCfwejo/t/iS6DVOyRB7gj6MkLLq69enChm/wo?=
 =?us-ascii?Q?gjle4JIpXQ6NBFGubYERp/g9vIapSKCCLpERBwBq574rDJejTwzzckQmOAlJ?=
 =?us-ascii?Q?LND+owB+17TPlL2oH5P6/WMt/ctfpRfONSsLxLsoU/peJITlY/0YUkKnCQNT?=
 =?us-ascii?Q?HezjRtE2F3fobVzIkanmK1n0RLWdoS0xlOHegEmaqIlRlpj5Vo8w1YZ6gHjg?=
 =?us-ascii?Q?PlRXYswoo0atMBhxRGTPlgXQKQ6u+BN4yBzFRszLbF9vRTM6TMPVkZdrx3AO?=
 =?us-ascii?Q?qlNNIzMkfTSrOIP42u6rjkw7tLWTa3Wt3LpwuwtPhX86dAUYXFrlbuLd01JD?=
 =?us-ascii?Q?FoS5jScjw3bUrK7wTqDPWvjLLFUHLM1VedlqrFT/zL8ypMB5BlSafUHF/F71?=
 =?us-ascii?Q?r4yP0XAVwbidFizip5bGmS1VslM+UvA1Xe8zre0EwzrGH24UClM/CK8ZQ59V?=
 =?us-ascii?Q?EJ+y4O5wDHugkMkydTZqa3XW8gcwfc+6PcJclJEV2BVSo3ErhVUc5C2VAbJ6?=
 =?us-ascii?Q?FytnTDffkKB9CtOeOrcB1wNZR5+EqAx2VvT3TCYuCjfkDCaRCxsF/uUZC+/z?=
 =?us-ascii?Q?JnGB9EyMeZSii3RBnlA2LedyrtuPe9nqRmzi2syRI8Xpbzk/rKyUwOr8Uop1?=
 =?us-ascii?Q?3lqPREgg5bfxnzPCx0cejO6WYys4o0gSLqu6VQsPUzCFUMQx3j535l1MO2Ks?=
 =?us-ascii?Q?gBvB7VayWNvCvGwAjsjiul5bLN8YQKvvrv7dKlLHXNA27HSBldSScU6fv7w0?=
 =?us-ascii?Q?fMLTgLhel/6mJWVwHMzDKp4WgsFKEHBx+77cqakVBs6r8v+FHxtnlNT4Flod?=
 =?us-ascii?Q?66VL6aW0W4rM6blwftKc/9m0+8sat/Tx8kH8hmoTlEUUcNpeTONuHKXJ7IWg?=
 =?us-ascii?Q?7KnJ85iumGxwJ2Uc0e2Fv79TJunQmBgAFiSPAMN5e4mH2P0B3+8aad1nmRfg?=
 =?us-ascii?Q?cNJN4rGd0dQaOe8zaMH75HJK4QpZ8RY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f811e30c-518f-4e1d-d357-08da4d2dc64e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 11:13:42.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfFcndjMIWd/gnYwRs0bkr7KkJvq/tD7yZJ1i7sZX9/KwBkJDjqACCNT51/xw1etRzrehYALCaitCmlrBqY9YlRucTdi8Smtmbnwz9XR3sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_03:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=640
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130051
X-Proofpoint-GUID: NDOXTmFwOdrr1ZcPC8hSSzdF5E5DqiQ1
X-Proofpoint-ORIG-GUID: NDOXTmFwOdrr1ZcPC8hSSzdF5E5DqiQ1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Johnson Wang,

This is a semi-automatic email about new static checker warnings.

The patch 9f3ec0f65421: "PM / devfreq: mediatek: Introduce MediaTek 
CCI devfreq driver" from Jun 7, 2022, leads to the following Smatch 
complaint:

    drivers/devfreq/mtk-cci-devfreq.c:135 mtk_ccifreq_target()
    warn: variable dereferenced before check 'drv' (see line 130)

drivers/devfreq/mtk-cci-devfreq.c
   129		struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
   130		struct clk *cci_pll = clk_get_parent(drv->cci_clk);
                                                     ^^^^^^^^^^^^
Dereference

   131		struct dev_pm_opp *opp;
   132		unsigned long opp_rate;
   133		int voltage, pre_voltage, inter_voltage, target_voltage, ret;
   134	
   135		if (!drv)
                    ^^^^
Checked too late.

   136			return -EINVAL;
   137	

regards,
dan carpenter
