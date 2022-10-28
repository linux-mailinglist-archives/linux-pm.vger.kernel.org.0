Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A497A611560
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJ1PCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJ1PCu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 11:02:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE093207505;
        Fri, 28 Oct 2022 08:02:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SEo8CQ003768;
        Fri, 28 Oct 2022 15:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=G+Z3fIq+HqqhhFIBwrKUDfIZE13zKBsXECqX2VyBflI=;
 b=i/KvgcYqtpg8ImxMcCE/177Hvjf9LqVvqMLJBkL3hpwoaf7D9oBjskDfG2q+GK5qF+or
 P2BfFBgzWsOwLQ6bwo9MMQn4PViUctDm1RmZRshrla6TScHH5xPTctoU3w9KZ/OCl/MV
 yTUt31R3NFYYUuPy0tsBYeFNBfmVUH5pdt05kaRle7lTKWoTIvxxBc2c3i2/OwBxhA56
 7xJcgOVj7+9KM15YkkGkjhaDQ8e+5sOzYbiS92nX6G1V/7ZwEgydVDrIf9Sd0uA1pmlP
 JTVEwAc4bzaLQgMDoSIfF8W3RGRI+gF/dH6Z7Gy+iPGts5EoAaRatxeNS6bI+0mJK6aO 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0an7hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:02:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDCWK1032723;
        Fri, 28 Oct 2022 15:02:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagp6cnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 15:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThGJPGNm8npPEeg6SwzNXx0VhIE6SRGnBzYfK2r2Wrh/oTKQXjE37hm9UQMKxd2xCi2HiToC4fbrJufIdkQP+csYBeR+pqkTBaWFH4wsIYUlX8KuDD4JQ9IM+CLOgFZCvPWVOlPezRpqomHaNyvfx1CO/h/W0+/yJ4lm5cxz3boezKbyhBpceSdQKUjLGKly85XhqEWq+ORUDTBumGjnHPHoVVy/2va09oByNaBzGDTygs7MTGcbcWlS1d2MV2mRfSNFj8pKUq0IauQ1AEqEmjnhNHRymQ+Y1JWdVHlNlJMA4WSa5iWdG8crW/zfNHBYU4zlA2PPxc2MM8sk29QqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Z3fIq+HqqhhFIBwrKUDfIZE13zKBsXECqX2VyBflI=;
 b=P/W/5wvukxASHgddaiRESenJRqLsoiCw7mwgKFY7Iu5gUGx0EEe/aKPHo6j6EENA1eixnCT5dBTJ1iDvYmrrq4Cr/Kca1Fghyv/LaKDOXYZM/lmganu5cGNt/9uFbCpt1hUWMuSsziXUDjozwHCvMlT/G1APQNSu6nFJP9Dmne+xyVvv3Je+wJg33xqWbH17fZv3jlQhF5FSpBALiUY+E9BCCJhVjz06CdeGgxrSumTVvQxh3zasGKVN8tpg9d16MuuZ8k6a7ETBuMTPJMwrM8j1LllH5gxlC2J+oIpGtbgL0sRHwAHiJSgVS3l/q47i3isy4wHHxiNyNRiIBOaCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+Z3fIq+HqqhhFIBwrKUDfIZE13zKBsXECqX2VyBflI=;
 b=MkmHHpLsHW+s+z4u+/emo0mYKCUe8ynoCJQk10hH/Z5W6uEAywHgHSyM47CybpyM1270XCqn+dihwRYTlmYbW0Y9cUnAA1FjZQsNAxccIS2cvUiVdKEhCzhMsaA+Al1hMgS97ASAMsQo71UFBfdaW2xfukoLFQWChlWfQl0R4NQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5040.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 15:02:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:02:40 +0000
Date:   Fri, 28 Oct 2022 18:02:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/core: fix error code in
 __thermal_cooling_device_register()
Message-ID: <Y1vvCrOMne0XNORj@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c2416b-3ffe-4262-ec5b-08dab8f575aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QF1rj36uDk+P6THMwQ4Fm/8ye1o6HLN0aXbLjOnR1O07MyImn1hva4eRPh+LurIoQhdc+HIY0ZzeW9AK7reTvf5lnFL1J1Ye0H5jsTwC4KYqYiw98rK0PapWHI2s0UnUuhr7dL3Xe3qi5+CgjtZgxEtIgRMi06ukm8bfo3TJM+BWlHDq0CrYV7W314cTPIxVUQZqg4pUZYVceY1ZBKV+sUV3ni1Hgeg2zYwudqaLZAywuqBTrnBF7ZJ8BU+W2jvhViNRxTq4Jeo7+1w4olom5M3tBgVlNlLCHTwqq/68p/TpRXl9MUk6FB3VxeM3xqMmomumpiFreQS/5Z1a1ZxWNpP2YH1/zL6PbJ/0rKEbNPQmwREAT36UpKhIdkIWLaJNDvxuyWiIJ7nrjq8EZctR3QO74OJnaNoXJgXheNnwvfJe8O0KmSuU/1PCphqe9P6hR0MYpIBCkhU3qCjoLbs527PVZED8PcHoFLOczowX8nKwoo4BRlc0L0bQ5B35lD0y20UAs1l7hqbY2AxFzA4UCY18mxu8XQ4mhS4iP2xjxmCniamMyaSVu0PMojnWpxMFDpeILbeSWLpB03GTfWiKWUY6p1/PMuh3aZXAr4eaEpAFxm/4lsUS/oA4XOwuX9HdVjk+tOv9wkklOBY3RvcxVjUEI1pNP12GnokNrgKXDFX9TxFHUGpfkNeQx4iuQGO/AqtpT9FKw555mpGEWXj2BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(6666004)(478600001)(6486002)(38100700002)(33716001)(6506007)(54906003)(316002)(4744005)(44832011)(26005)(6512007)(9686003)(186003)(83380400001)(110136005)(86362001)(2906002)(8936002)(66476007)(66946007)(41300700001)(4326008)(5660300002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4DqOHxL9ZjQZkEEtGIkkaOBj56R0/oQGK+6TqH29Hy+D2lMOCLUCxrUWApi?=
 =?us-ascii?Q?Ex0U2/lXTHBRcCJACP3DAF0Qkady7Mc4tvDK0SC93nb1BkTFm8tIDy7d6Y4s?=
 =?us-ascii?Q?E3UPn5gaIIilX2X9aODE1g7jJfHq+MqBNhwwOcyZwCiiLYmD5BLxIVWgz8i3?=
 =?us-ascii?Q?vlOYtumlnWKJic7U3ejqohR6G5cAc8iTzhjoIeu87oY2z/Du8b8+MGVxRQR7?=
 =?us-ascii?Q?jmT6hk+qCkg8TEExDvsrpNl+Kd4usCuF5zDrfdfFL9v1ZiDob68xHZL09Ee5?=
 =?us-ascii?Q?fZijLNZUNt+8BdmiyHs15pcK0PIrAVRbu6z8XcA+99Gk2eLbl0bEEB9wzruH?=
 =?us-ascii?Q?i/zogWoNeRA934kOoNcLbXPSjEgaV0uQIHLuQQAsS/qHWHhpg88bHxjGBmc7?=
 =?us-ascii?Q?kanLiBkcx/DfvC9U/G5FVBrVkpO2Anawri50be4kTAWEXUpowLfhiNKYppQ6?=
 =?us-ascii?Q?f5ozXmElytAPuIvtSIPxoEWO7r7Z5KVo+lWZmoh/mFowgxBnhMcIfDWg5tfq?=
 =?us-ascii?Q?01XOsPye5FruvMmbHJ2XNHN/vV8DVH0g6l52vNpB8X68P4anZ5bInOrvU1e4?=
 =?us-ascii?Q?LaE/4ugjqlhDhDqHWoqLCPtCMgjQ57tgCINiOKZmHhJPZfrBTXfHzeKxbg0I?=
 =?us-ascii?Q?mtAYA9uLNtXz6vBhlHiHRs3U+KcRopwGO4ntZwh/qY0vFfJ5vRZJfFzJQWge?=
 =?us-ascii?Q?k3sVd7V2EESXFVWcGW0fVo7RmM/rLBO90lsbiPLOgvm7d1pgJZcUpj7rUofd?=
 =?us-ascii?Q?bhjpaw4S3TGjgSsVkybyxfJZW3VmJEbhBROzYrfR6gSX36U8KGe6L+oH6dcO?=
 =?us-ascii?Q?J/SOlzDRnMdom8in+fq5OPsGq/2u/oh0FuJYJiU3z+saqfYjxDgDFnI62E4R?=
 =?us-ascii?Q?fLFnmr07R8FS9namNwdzWVKzDcNlod7T7R5/jDyFP9Tu4xjPMPdJY9vKcGmG?=
 =?us-ascii?Q?8KOrJIUzJOxET5MFfdCF9QZIqKD2gurBv5rc1SdpBth0x2vtEJOWtmkWQiau?=
 =?us-ascii?Q?RI97DXM8oblNye55IVjl8/8DMCummYAGb+hXkuvj8T6WnzEjiyOfvqTfa7ti?=
 =?us-ascii?Q?R9UaYpawbYjTA0DcO9Y3iAk98Vk3C6gNlMJ0oPX84c/Lh3pBi7KVwTlnP9OE?=
 =?us-ascii?Q?mxRrh4TYqoekoBUO2ULxgD4ZmL6NiCkQ2rqvxJz8wuYqEVBPNmZxmwd6OIDV?=
 =?us-ascii?Q?udjVYbHv2ly1EIg1Nw5p9yModB2vuyLt391ABY59knlv6aArD+4z/Mg3bV66?=
 =?us-ascii?Q?rAqwjYENL8xbDWzE8T2zr8J59FWXhclB9XHAgfhrlW900XcistzTuqObmwzz?=
 =?us-ascii?Q?QjwQpHKb+Utzd7Rkqws9lueq/pEVn9n5Ntg/n7LEmjYnF7zR1LGVr2NmIS4Z?=
 =?us-ascii?Q?W+FTI9XfYjK8FEj0uqXaEaB3BELAE8Y7c2MxUCGWMMPSE3tyCf/aBs/DQktb?=
 =?us-ascii?Q?R2/VNnDTxwTM51rFEsHqwZz6PYUGA6nWmrXOqtnbTXrgqI3YQoLPWW7JuSnp?=
 =?us-ascii?Q?2Jjd3rQRsQMwt7g7W3Zm+3P1zJfySN9hB7GaVoM94qne13IlQz5wi8uVbfkF?=
 =?us-ascii?Q?0rTpvn5DkLZGkWvmlY2IKLdJcPUKSqMiNf4e4LmT1i/XsrTLREcOGBLR3Y4W?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c2416b-3ffe-4262-ec5b-08dab8f575aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:02:40.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NEWKuuDN3S/zQK7E4k/pPLHSel7ru573Iw1Hr1KkAGvLji+e5Xnnsygmw8FL7TiiYSXejDc3IxTlt3U4vwA/lhGxPGtZiMkZXUOUdCE9Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280093
X-Proofpoint-GUID: vIgTsl2MIIcNDctRyeB6R4G4KaSZ5UwY
X-Proofpoint-ORIG-GUID: vIgTsl2MIIcNDctRyeB6R4G4KaSZ5UwY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Return an error pointer if ->get_max_state() fails.  The current code
returns NULL which will cause an oops in the callers.

Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4ba7b524e5de..c4d18e462de8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -892,7 +892,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
-	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
+	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
+	if (ret)
 		goto out_kfree_type;
 
 	thermal_cooling_device_setup_sysfs(cdev);
-- 
2.35.1

