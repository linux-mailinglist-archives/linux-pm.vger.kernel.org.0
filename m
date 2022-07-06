Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71E568D6F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiGFPfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiGFPex (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 11:34:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D62A265;
        Wed,  6 Jul 2022 08:33:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E3xKa022831;
        Wed, 6 Jul 2022 15:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rEcfsJ5uTEDcTrq5WPZfaN2geqkg5bk66Dvda6UlF98=;
 b=rOnFq1w8y10ngGGgJ5q3IyURQD8HwjFxJXjMS8OO43qAvz1Uvan9a1m5oyuaUuZnyqH2
 n30Sii3o1WGjR9rgTzNREk30WQvvh1QA20nS8p/5Nl1IQy3vPQeXa3nHGwyu5qCJ3Lk4
 co/6OQAtrGAlZw/BPu4Osxh236xBE8BQVT8jmbAlpq/n7tZX0e5wXviiXkpBJJzpCnuQ
 ubfRVXgRa83dc/TNGc3F/m05kg4+wdc8Mfs2GYeEQ6a3dQpaWSsOcOZqHIpP6moRT8R2
 HiPnMwL3ZyRxIquY7fOifUe2SwxnWgt1c4tIY3XYS7zT7FHS8a9myMTzkRU8VetgjPOx dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby2cu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 15:32:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266FFum3011873;
        Wed, 6 Jul 2022 15:32:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udenkkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 15:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6EySi0tKwlz01ZyNuxwJoLZDtkXlX0IQuZJple/yTpNf9C8BSA/YHhIL1qIGgfKn+lxGVYGwdPlWsOV8B/tY6zlmyrcvzmj/YuPBWriE5kPB4ZcsHRgCr6nYAW5fvi4xPjPkA4zpw1WZIZGJUlpaK505nte3Zg+hmUgw0eBdicp4TOCTrfz0oCmedGmvr8bE8HMyEWH8SfNKHkQca9bgMH3M2fdfEHVjutbH9Vb6Cf6+y8arJDlzXh01fip95nxT/VAbvFlfMO267rPaJeD70tZ959EsQXJjoUVyBoSowiVxj6WvfaoUlcIPpT49u8UL+xoDijSvyYlvtqFqP+Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEcfsJ5uTEDcTrq5WPZfaN2geqkg5bk66Dvda6UlF98=;
 b=BXG/hsKn/Rk/q0ge8z8ktwj5LWnZwgJ2oTtrgw63RdF3kgxSYuP5ZZJ5MUUIF4pJ6XF/3Gc0NBxkHuUNbwF8pctKyihS9BZ5K9JHrN9Co/EpQo9aGVhv/URndQ+6VHqRK5lxhFJ2vyjoFGS6eQ2pIeEw+3btvNXkyUa5kGHru4nP38UoLYNOOBLHea8QBWgl9hG449W2gDesb8im0Mmp8TnYjPJqP6fdNdEj9NxLnnn94fCPAyRbmkQ4IqAbFK4lIHvlOpV58OI587U+F+1sxBV1vmj5EtowXb6C1sn22BZ2gapQuCnGmYs8C18721Bh28rJ5/JP/YbtbN3kmW3+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEcfsJ5uTEDcTrq5WPZfaN2geqkg5bk66Dvda6UlF98=;
 b=PYfuCiL4rDyUDvuPq423qjfiyPvnzmVAskGUkBCP5A519JSwXFQSQJ2FmU9gii7NLQgIb0NnuDAl8qMyG16OvHuhSWI5WZs24NvwZ3GKfFIAXYF0uYpDxW7fp0xFlSfA9H+2xiQIKeGSFLIii0DLeJC4fhApEQQ0gdFtfzBsq8g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5590.namprd10.prod.outlook.com
 (2603:10b6:806:205::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 15:32:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 15:32:53 +0000
Date:   Wed, 6 Jul 2022 18:32:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] powercap: arm_scmi: Fix a NULL vs IS_ERR() bug
Message-ID: <20220706153233.GH2338@kadam>
References: <YsWbsKolf4UFeEYz@kili>
 <YsWb0JLVFbXS+qGj@kili>
 <YsWjxiXeBXImW56A@e120937-lin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWjxiXeBXImW56A@e120937-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e0bec2-04b3-4d61-9ce0-08da5f64caca
X-MS-TrafficTypeDiagnostic: SN4PR10MB5590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qXTlTGMH/p8KQaQT5QjTCekVp587nRaMnUJtRXtAMk2MwDM2wnDilQtqFY7mxpTWQDoLfoZF/2K6YGYCrAecmTWhyhsCeI0D52/DQtTBjUx+1pgB4rxE2ogBaVnp7D4qkc3EWH4d7m2mj1hHPWMe1lOJ6aSb0tYfP25pwa6owssnYHQjnwJEFOTxu80tiO4kU9fxpG2AeADK9gVsCfB7n8stFMSwioKKaE1RojdsDnfiPBjDFUDGJa+Dz67S/+AM9khJi7BCFaOv8W9ROOYZRUwZW2kgVvZy9El4SxkyIopGG5IMFLjQkoK95UOXiAh8tf1CY+AV1dyF9BqdciNV77LvTj1z88jFa0XsVKCk3fbnjDB/bLG+PqFEB7P82q9C1MgwfvbpnEgTKiNm6/E/N8H4DDXt3kCOnDrGRLJdYhhM4vGMrZ+P2YURhHXfh7HKngkNn5qv/eUtMUZ8Q0exwbEWPXLiJiKFCz3SEF7kAg6nwxE9Qdvusrb87a4MTdZ2ABDQxJfoLzLo/s/QdDQxVXilMg+BRYv2A2fB8N32hrK/FwWbTK4Yjulcm12k8AVhmD0XwYSd42Ta4SyvIxXqzcNxNTyjAsIhTfAEGbDpbMobVkCMsFJMG7KhC60fR6YEODkohMIz8RtyMooH3ptWwIFwY8G+PweBb70wyV1L5OLWt2ioDs8mUJ1HrgBAs7rklrP8R4gLdPbEyyzDS+eMXX5REtyN20HvAkb0/Vwj+iTA2790/WXBmrEN4/uv/uAG9kJ8vBsnC+sXvPvLsNTfGKyM9sLCnlyHRo5ltkizcz8j5jqrK+/s+5MBqmPtjpu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(366004)(39860400002)(396003)(376002)(6666004)(9686003)(186003)(6512007)(5660300002)(52116002)(86362001)(33716001)(44832011)(26005)(1076003)(6506007)(41300700001)(4744005)(8936002)(83380400001)(33656002)(478600001)(2906002)(6486002)(38100700002)(66556008)(66476007)(66946007)(8676002)(4326008)(38350700002)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3TKX1X7KLwx29I3RoPocKbfnRdCDvJJlxLviaj2c2FO2yOcoJVR97kf2ClIl?=
 =?us-ascii?Q?HiI6Y5c6fXjnXRplil06IW87Qw3reOvIFnEakyowH6kCFZb+vzmkFUfPuq2k?=
 =?us-ascii?Q?8zQpBkbagyQXlLYvg7tv8X/G46OkcWTFGf65VlqQeUCJbq3epSIQToVTkxjR?=
 =?us-ascii?Q?nus/HSTz4AAHX073/4Ugy5tvtAKLHnLOSFZk15IuzwJcH+VrGHTXLx3vPVCJ?=
 =?us-ascii?Q?x0J5ktE6x7SabmfMHaBrSsXyQnafuJv+8nbc7UEZBxyqwPhiazgQqIttHwgc?=
 =?us-ascii?Q?1cK1sX4CjnaNCY8StuZutDiVEi9FY2uQWhTPsM1Z5FQDLGVqwU0ZCDsCMx81?=
 =?us-ascii?Q?Ayt0swBn1Kv/tkg27HUiW7mbX9+gpl424T7x3m83AgZ3WPcpnY6A6dgqpSaB?=
 =?us-ascii?Q?gVu2ROBaur4ZDEnfG8U+2z1lm3HX6TPkRuKB4nOQfzganwW2ldZ+++vSsbX9?=
 =?us-ascii?Q?et+kWIruUGEj2jc6W5H1zl0PP51MyTHp/eM7XY3P41MBQYC/432zL59gRnjf?=
 =?us-ascii?Q?KMNkK5XyTvtCBvmB5QpzeFGPrKfzcd1hZS5Tkcn5X5ahLarOHHfyDQBrXi0y?=
 =?us-ascii?Q?8QFSuY9mofjd29X04bpQCxVjG0HXIDZYiDtCWvUkCMxv6flz4GH55fwbxwoz?=
 =?us-ascii?Q?DNz9aaKDM6mjfLKIPboMwa4ggxGwS8PgABEMdkqvhWvKTjMZYdtIcQ+cMAA4?=
 =?us-ascii?Q?et9nU5s5TrsdxH3pcgOtaKTpaiThAt6tRW1yHRlOJR4LEL9sheCQkSMxpnN4?=
 =?us-ascii?Q?+vEOOBq4/19CF8zll+wTrpZofaOcc0T8aUZSkYU0y3UJ2TldzZUg/K3tLtYu?=
 =?us-ascii?Q?Npc/sECFFBCgSuaEDJj1+hzwEU/iOo/9B2+lZBqjna6nhEaEymVQ8UQghKj+?=
 =?us-ascii?Q?W6cu2+vLmBcq2iwg/TeW7f28jn7SeUj3CH1fFHa3K0iBTc3PxX8YafxbUDEc?=
 =?us-ascii?Q?D1sOTQ3isSHIg0UQqzusJE8eC0sq+ruR0wItTnSpfOPLeUTgZS/XJzGok2O6?=
 =?us-ascii?Q?oWW1Xss+YPodLYPPDZUAnNI2omzvmhISzrx3D2z0wILL3cfeP2NUPqe78hTm?=
 =?us-ascii?Q?tUaDodFJ1i4h+lE9VeCoDWm5lyaQrbnYq3m2mFdRhjvxkpZy7NeK7VUTRiyg?=
 =?us-ascii?Q?7hxhyr3m8sbbf+G3Xw43g40UQSi8PXnSNA6lRzm9Pp2z4+uEqcMtUgdWgDxj?=
 =?us-ascii?Q?OPkiWd7kfVOXTHIJUubL8et+oIyrDMYGyDpbfMdvDsiHIkVAQXUhuTj5h/qD?=
 =?us-ascii?Q?s+Kyku+Xjw20FJHb1kajYSE9K3zb5Gtl00DXwtT1jy0rqzBMZr4qWEDyWJOc?=
 =?us-ascii?Q?rrXOjAaZJ1QPn3QhwSL45GGvZ0LT391k7ja3DE3UmYwp7ISkU5QYeMjCudt+?=
 =?us-ascii?Q?Tt2WuEhiAvvvu+ygE0ZR/4ShXvoIuPwh4uv0UH6gnQ7mPk8pBXUxlt2/Boi9?=
 =?us-ascii?Q?fXVtLrMdGK958axa62D5PeyWin9jEp48UzLO0djlfj1pZFOrc3wNY2OTVeBl?=
 =?us-ascii?Q?sYhB8lPvTMSgQa4Jo9QTM+PvcQI4+Fq5lNCexO4NqLUDP4obdE639Lp7lu6q?=
 =?us-ascii?Q?t07tm6BpBz9sRHzy+RhviPkC9mAF0kmkE/O3yVQb/rPBz7wrsXzopEeu5u8I?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e0bec2-04b3-4d61-9ce0-08da5f64caca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 15:32:53.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZSpVlyimfKLxid57PvkV0CPesZyu1srCFE+mpegbZ9IYjdozRAxjC6Ba4zaMUiOL/rqwWNQLYF5TadUTwi34+VdvGliWoz9N46QbBqH9LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5590
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=948 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060061
X-Proofpoint-ORIG-GUID: nL-KpkqU4dSl2DwAORX5M6eAm6o-2qnd
X-Proofpoint-GUID: nL-KpkqU4dSl2DwAORX5M6eAm6o-2qnd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 04:20:41PM +0100, Cristian Marussi wrote:
> May I ask which static checker you use ? Sparse/smatch and W=1 did not
> spot any of these issues (including other in the series) in my workflow ...
> 

These are Smatch warnings:

$ kchecker drivers/powercap/arm_scmi_powercap.c

Using test/ version of smatch

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND objtool
  CC [M]  drivers/powercap/arm_scmi_powercap.o
  CHECK   drivers/powercap/arm_scmi_powercap.c
drivers/powercap/arm_scmi_powercap.c:429 scmi_powercap_probe() warn: unsigned 'pr->num_zones' is never less than zero.
drivers/powercap/arm_scmi_powercap.c:494 scmi_powercap_probe() error: uninitialized symbol 'ret'.
drivers/powercap/arm_scmi_powercap.c:521 scmi_powercap_init() warn: 'scmi_top_pcntrl' is an error pointer or valid
$

The problem is that the "is an error pointer or valid" requires the
cross function DB to work and that takes forever (over night on my
system).

regards,
dan carpenter
