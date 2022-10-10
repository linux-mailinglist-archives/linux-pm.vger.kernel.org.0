Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE605F9F40
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJJNPC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJJNPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 09:15:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B356FD32
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 06:14:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ABxTNW029777;
        Mon, 10 Oct 2022 13:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=TjAWpNRfff8hSXg3z188MSTVT1dbc7JMYljOYRIlElI=;
 b=V5SuR2/TRdeYgdqAA8HkyF6j4XO4s0tPf1CH+PKdP1uQpmZN3chUouOHewRwT+XFfPu3
 9J0sZcjYP1vU3W8okPHMCFqbCQI55PJuJML/CTELOBSvxObhG8iRhYkPpgjgHHsreaoZ
 P9tpey6pO4MptVykih2Q66LBkH+we3QgFui9/3WvbKZ7TYdkx0qDXz3fYcdQMGO2gyBm
 wQbR8xlAT5zhFezeraUTXy4BiqWT7I+3z1otpFSHLWpRZU4rrbK+XtccrwGxOjuc3js6
 affKQxKYPLiQ7ktSHC/pA35boZp2e7O+yw/OaJGcONkYUA0FAkQ1Tc8u9nKQ8bvhzuwl Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30tt3fua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 13:14:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29AATCew028772;
        Mon, 10 Oct 2022 13:14:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn9dgq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 13:14:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvIEQbggtUH9aLPJkjCjmbZahuadbHo4j53sstAQz2dA4+Zway1Z+HAiu4RektIxELFCylUc2F5yJTgg/25L8uyV+fQ3j1OsVzFRKG3leP3ZO1cLXNAJXGNxCxIMIihmmmTIB+D/msDGj3K5XTJpb3JXWFGNe35Db+mPP2IX/fu/pDr3AbEd7lXRXGjvovuODZ9PTzk7+thDNnHyOHjuubkiAvbisKg84m04VY9ojd38FXggMt/gLbBfH2hvjJaELp/UH0iYy9Pyg+v0NyoBa9a0FAt2C+NtTu4GXMiVjMZ5qpPuH40ukW+tz5cVI0wI4ECIhCWghPAld98ff3LbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjAWpNRfff8hSXg3z188MSTVT1dbc7JMYljOYRIlElI=;
 b=fMV/8cbAhWP3DMGCPN3O6FJpHMvO6gmF089enhp/y7bNmlguP0MR7DnUcBVbv6hKLy7yrjjUWUkKR1m27G4rueZN8D9nvNXghZkcmKL1bS1XOYbonjnwIWiO2/RJywX3r39lE/h5Auy/lXta5O7Tut8ulSc8LBHqtLj8L7XTjrNiAEKYSHwTSRdTvvvAUqzLsHMU2wTL0Gn0DIMsRtgzRre9IXVMmNQtY7ibak7FIlIPvft8ldiXqYCXe8WdgCFH9XDoJxwh0nlvdHFAdPtyC5spFJs0+MxV4AmS95kHaUfk5b3GGRhGk5CXnj83ap/wuoyhlvJShjumb/TF/kmIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjAWpNRfff8hSXg3z188MSTVT1dbc7JMYljOYRIlElI=;
 b=Cyom6IQlnI8nMqGR3Il4BmBpawjGjffjNZimEdQk3KwDn2otC0trIVxxZv8lU5OdUdv1QZNC2xDkG0LZDj7OEDKE9AAPZ3hNYR6QPbb0xn/ps++XNBGKMir+Q/7k75nVhOBjSco+a+cwlXMcT3btBwaCy6cw7dJlascgoZ1lIHw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA0PR10MB6819.namprd10.prod.outlook.com
 (2603:10b6:208:438::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 13:14:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 13:14:47 +0000
Date:   Mon, 10 Oct 2022 16:14:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     macromorgan@hotmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <Y0QavmQuuCUUf+CK@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0f4447-625a-4422-cf4a-08daaac1676b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKoXRc2g5CtRPcId8k8CRiUON/xJUgJ8SaIpZqclqPBgUyBTfj6G1QHH41xmLJ7o3sO9UT1CA1TJ7QG2dnNVc9ib9TxM0ld5YZzsOuysjP71Ey0tcEYXIRzcrp+HfHg1QFrkcuogJRWgcWWgNP57XCsQeVlVaYFQDNbSepeI+Qg9YAb9VWj5HpOosplTzxbVm49sbDRK+DsUfhQJi3TIAQUZfiEB/mUpS7q+IhPbqJmpukeTJGxFdWIX/81Fbqm1m/CJnAKAofNKvDCl0MG0rc+p/igZluORtC1J8Tt8QvONl/442jrTANMoY/PJL+BMf2DHgzR+V0CQYGhdSjWf1BtTBFSVegFHaDe3aBSgX5p2CIjFSRYu4KQk/xJElmue8tmU2Z3E/n/6LaEkdDSQOGWU4spM+wuo5om9TEkqdHoFAiAVQFg+togEXDTGzqAkl8EHqs+cEZvmhmSS+75f+C2G5evkErm8zEZ++ekzsfRTNRVBLvvFnDWErxa4Yd0Le/OSyEY34ZLqMUlRC84WY/WE0l9i+BbZPaXCnprUD/0UJt8KCueqHmjT/72MHTIfT1LyDYo8Xk99Nxwez4N4HhEYO8pbFcSHAVC8uIQ+F+RGbuguR3DGNVQvkibFJ+BeezmxviPcMn2o8B8FBeHDDZecQ1SG41k/yIYyx8bQ+7Hb9heDDESkSUO99az9x26L3sQhRRVlFcwK349ljIaXmQFQON5Il8SjS9caoiTUGRoFYEKn7XQgVYE3shcc0q12AMUo3MSK2AAr3+6aDgYabg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(5660300002)(8936002)(4744005)(44832011)(6512007)(26005)(6506007)(86362001)(9686003)(6916009)(66476007)(6486002)(478600001)(6666004)(33716001)(8676002)(66946007)(4326008)(41300700001)(83380400001)(66556008)(316002)(186003)(2906002)(38100700002)(67856001)(1531001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/Wx5V2R5RQhJR14Pi8anzv1EaR/3P/SyoxxjR2OXZQbXEM3CGiv2nlxUdV6?=
 =?us-ascii?Q?wKSCFdeA94tQ1nEMT8AoKfp0wLN0hqmqbCTH2Uhyr3Ae2mMds6hEiqBveSWy?=
 =?us-ascii?Q?654WTeT26kVonQR9faXKtjIsuJkdbqQAQBNoTEluD7XWp6/B0zgIyRwde758?=
 =?us-ascii?Q?lli0mp5abqwO7bZU5YdoXNIIiN4PNScvARlDWqmFVmmsrRaB58ZcuSVWM4Ds?=
 =?us-ascii?Q?OGmkhweURcLg4QWT1yOR/YhtHJXKNqPr5olPBWXCjXYZYuuPscIi/l0vQoU+?=
 =?us-ascii?Q?d6Y1QSl5qKcAKNrIn89/K00tYexenuLqjuQY3Jg+l8Z+PLcjan4+GMxP4zX7?=
 =?us-ascii?Q?dJJu1T6g035i+kXZq6vSSAtQzdjWAzce8tQg5wSgCx20kpRP22cVtqxGrl9d?=
 =?us-ascii?Q?awWjz96yTS9n8L456PUSWhxGfPE+c8SGOmc5+rzVKD2phyHs/LNrU8J/e6Cr?=
 =?us-ascii?Q?qshB5PHnOd2WQgThyQQV2y/vQAvzWLsT1V6djj+oBy3vEgthmbbxskaZZs5r?=
 =?us-ascii?Q?KLphFs8kTX0pSBsjtmCEONL6DuSh6i9KVVqjZ5Q3WKYfB0V6vbKtcTM6Z9DG?=
 =?us-ascii?Q?LekHxMI9ox51MyAJuD6o+sihquJh7gWLjsdU6n0RYgodDiNwndJ3o+Njce2E?=
 =?us-ascii?Q?GG8wO7DhhqVvneUDX6UVzihdeNgSAq9ZGndRJpUyGSW8FYPxC20bexqBp7dp?=
 =?us-ascii?Q?/JDF52UU69L+4rI4V2oLkobkV9ry+8DHe8daHUBlCqIne95zuYXGCGD6HR2a?=
 =?us-ascii?Q?tSMSwi32uoAZDO4RtNnU/ScOr2x/zi52pDDk4/TKD69D1MHiYGpfsaIKogWo?=
 =?us-ascii?Q?t2xuW21JEArV9xHWLUoocDQ5zvhZmqp9vao+l9g/Gm5K8od8FCG/CXtLL6N3?=
 =?us-ascii?Q?15uux7j8PCI65lfLIjC3E2V020h+uzsYO/5Kce94vrjhdccFEBoKN9DmyvbI?=
 =?us-ascii?Q?tX7def6L8b7DnrY7oZcDG1LQAHQgbOTYrDc0Ld9h3SPowFxWxNtgZThP+Jsp?=
 =?us-ascii?Q?CGPAFj2tVyVkmlaE7gXujcuGkoLCn4o3xK5L/3axgUM20KCXA8cUIwvanKev?=
 =?us-ascii?Q?noul8pen2XX4Jc52RxpA4JTksxxuufMjwmox9G3c5A4qva+sxUzCXizJfXC8?=
 =?us-ascii?Q?iLfB1Q8hAq4qD3NlWMnlz2CQuGfysUXkxcpARxtT60GpviD7CMhNWdioYsLP?=
 =?us-ascii?Q?i0m46wKGgCoPmbpcBp5jI4+U1ounogbrBwjnFLkwybA/FiDHAqLa934TngyO?=
 =?us-ascii?Q?5JRnK4THQc9OpIp0MMdjlpnEqkOdB6U27HyqHI82RgzyrPKKKE3rNPfioHvL?=
 =?us-ascii?Q?U0AJIcQxEIIMVJ/8fwkG/XSGTKC4HO0psG00jF1vCkpMFLOxM3bQb072w2oe?=
 =?us-ascii?Q?VSmHeGEMhnebMwLM4j2fLuJkm9wMyje2qKvuXaaFYY0EHQpr+BG3gjErPKxl?=
 =?us-ascii?Q?KbKK49N28WeXMJbdSa04ESLNtko2ZY5IBoUf6ALZwcOm+tPz/D4U5X8ihw9n?=
 =?us-ascii?Q?m6E10d9NtkUe+qt0vtszZGgIfjnCL5txytxA+Hcw8bsgLWOqIcdYAjUuXYfG?=
 =?us-ascii?Q?6fy2UdURIkWLDJ8cypCA9j2gYVUpKlskuP1TYg9z8Ce4y+hRuEOSYOKsKy4v?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0f4447-625a-4422-cf4a-08daaac1676b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 13:14:46.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eGRbHyLegBQI6Ah3DnE5i9FRrmwWiuLqLC2BrCeyStX8OMte/JpSQTj7C4JNln+2jOt2uPqe/Mq+E+TAi+S3KZ6FsLxA95UeCyFRcgdX9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_07,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=712 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100079
X-Proofpoint-GUID: fEV40fjJHIZFnu7vK2aHIgmbjY8apy5l
X-Proofpoint-ORIG-GUID: fEV40fjJHIZFnu7vK2aHIgmbjY8apy5l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Chris Morgan,

The patch 11cb8da0189b: "power: supply: Add charger driver for
Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
static checker warning:

	drivers/power/supply/rk817_charger.c:143 rk817_chg_cur_to_reg()
	warn: signedness bug returning '(-22)'

drivers/power/supply/rk817_charger.c
    124 static u8 rk817_chg_cur_to_reg(u32 chg_cur_ma)
               ^^
This is a u8.

    125 {
    126         if (chg_cur_ma >= 3500)
    127                 return CHG_3_5A;
    128         else if (chg_cur_ma >= 3000)
    129                 return CHG_3A;
    130         else if (chg_cur_ma >= 2750)
    131                 return CHG_2_75A;
    132         else if (chg_cur_ma >= 2500)
    133                 return CHG_2_5A;
    134         else if (chg_cur_ma >= 2000)
    135                 return CHG_2A;
    136         else if (chg_cur_ma >= 1500)
    137                 return CHG_1_5A;
    138         else if (chg_cur_ma >= 1000)
    139                 return CHG_1A;
    140         else if (chg_cur_ma >= 500)
    141                 return CHG_0_5A;
    142         else
--> 143                 return -EINVAL;
                        ^^^^^^^^^^^^^^^
Can't return a negative.

    144 }

regards,
dan carpenter
