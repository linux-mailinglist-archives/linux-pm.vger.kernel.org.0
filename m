Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57305FEFD5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJNOIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJNOI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 10:08:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D19A8788
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 07:08:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EDaSol001540;
        Fri, 14 Oct 2022 14:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=5jCdzRXOzD3Y2AvUBSnsacxGPsIOG5BkFUJ+7TFR1uI=;
 b=chakvxWZOUT+hFA2o60sIr5vvTsSjDIcQFwrsznHbmohg8ZfWT1CB0oX4lTzngScNdOG
 S4O+bwhSQNxcqYjqgpKTNOQj58tcG2/E8+OrEz6Y5k+a722DtC3kcUc/htYTIpUXa+Gc
 0clMR/l9f1ZvuCsYsvZPItrRq5xG0yA4sWj74xBFr06wq/10Mt3D3+COyTzjfjXap+v8
 UhsUUSFSwuDmfo3/MrNf6OPvLD9D2Y9qlYnJPSgliKzIPWJ3OGDpAUTGXmve8l1qe07f
 whsvwsM7fEbLBUEfHME4C6/kILKqvigDUaWPhnwMnNVvWUFK6w8jzhRv5fx+dcbT+9vr /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswjvyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 14:08:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EC2Peh040704;
        Fri, 14 Oct 2022 14:08:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndy2uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 14:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWiYC1PBrBPr2bny108RGvwyIl9N/bkM+ei03Ps1wyXfM5hqByzzx0cmGip4uxtRPtB3ypyolFcGTiSEOJR8LIgG3ytKkI1iUIshjXg6/ngrbKyih7XVYthit6wTKwpEm3ds/zftyFYK1lmERCGC79iu5tWdlYN1H+1H6tCAPKPFbTU1krGMKsO67tuWOuE/5MqFVB7GJ+STMOAqaQ8INZd0Otb4096BohXhuXEh6vI5k6svJZwbcwldvFS2EGVG6xws7hOVrfTLy2UMW7/R+bL3KPuva7utayqhdQY26vF4Ksc7gLbAKjdwkx6ncEeHXqH+1Z4Mk44voJbdv9yYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jCdzRXOzD3Y2AvUBSnsacxGPsIOG5BkFUJ+7TFR1uI=;
 b=STuAhfJ/BQ4hOqEzsyfMiqtfvS+XGS8UXxzGBMSokZBhLb8u5TIWqgh18lD0EMaDz0pfuN4Oj/PetOj8exdQJF5ZXS+7aM0m1ThOQvFGfcL1ndHDwOncFHAXdxg5k/11fEX9euacuQ6LglEz0XQSuDk409YnXWVEMEKxA/NO+MBbajnCnKZtoWv14ojuMy34+BbNSEjbyOJ/Jie7A7OBAKZzYrX5QJjU8+SXxLDwFyfDXL5HJH/x5GR72FWZjbMgUiQLdDfLkM9m3hiZQ5pjZF0Qh/5z+moASgxr6wb4+9cH7zmHGgZiLJYXOQrFWyx5o8XPfyxN6QkA7/ZYwaBZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jCdzRXOzD3Y2AvUBSnsacxGPsIOG5BkFUJ+7TFR1uI=;
 b=jjaqoJWRdWSEM38bVME4msSiJUPQhud9UjcwWRnAmyO41YF4bFgF9yCxGt0jwiCmJKjlU2XfdWFkLDXkbwfN8asf3sDv03WNmLe3IIOpfBpocxifxAKLW1tSbdVWd7l1yzjQvxUXFUGjYGKE5bKzEj6Vn2pm2ck+rV69kBd7Zpg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB6166.namprd10.prod.outlook.com
 (2603:10b6:930:32::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 14:08:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 14:08:15 +0000
Date:   Fri, 14 Oct 2022 17:08:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <Y0ltRJRjO7AkawvE@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY5PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 46715562-783f-404e-01c8-08daaded8955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5nc9JcWGiSm3bKpYEEgsLBXhkJPZiI50pyejArnYgMKLon/iVRVsRWfnj1zs15l3QnkD9hvKVTW+CwivgLS6G4XBZ6bLCwhyZaZ/yv6waoyOl6hP2cd6K1onc2JXL1w8Dlk6k2wB1ZJglE1xXBIIupiWP7yU6q21qRZnGyrlnRLTbM2emQbiEYNnx3dbqjNQICrjmb4HAs16aBM6/MVazoSsoDErmhYQCMDOxetM9yADd+HdVTGK88hNvY8fslRZD0Vb6coWKSy9NZ1LkfsiUECy5kpDpe8KZk2oGSsLlNej2JiYKspdrUSGfR+uQBVVFtoSMHBQGqog0dVMLdZ/Pq1zjMGtz0oYp0xVleTcf04jNOV1z33kW62Ge+bzqNGuvy0UP9ZhwSKuIRJJWt0rzMDP/B92gOy5hEIfmMMgq+0QAujA22C/PoTKETTvVXe5Ed/0h/dNLYfKGN0r0fyiWBd+ugfzIg8lSEy0BuBTSoQcnKwW64tT71qjMxUHedsSqV+HdBPczvWdEXLGyJpmxU+tmZ1gCFYxwkSWgNdrANGvCDv+OKR0lOiD+zR6sxLe3G+tEukOHLeNbrjstmKhtLo5V79ygWRaqM2T8dkV9D8pqtvMLGOLAUYjQXnmzU/hpxy7dnEKPolMumbl7rcA4dHy0BY4h29vDcm2eJGueJ41Jj072vkBFFAtrZuFy0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(6486002)(6512007)(86362001)(41300700001)(4326008)(5660300002)(8676002)(478600001)(6916009)(2906002)(66556008)(33716001)(6506007)(38100700002)(8936002)(66946007)(26005)(186003)(66476007)(83380400001)(9686003)(316002)(44832011)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vz4yQkYXPkPozZu5kNWE1rGJgFQAWyO6t3WDGeJrOtiyVpaAXMFxIi+6iwMj?=
 =?us-ascii?Q?wo1rDzZgqmsi12+sEVN6v7AHB35RjIwd/zNmmmmU5blgSKMN4XM+hK1gRfDs?=
 =?us-ascii?Q?HB030sb+bOSynfZzS9GhdiLlFn1Vrg+1k2dp/QV5jlGtattOpcnUrE1r2sHO?=
 =?us-ascii?Q?sGzV/nwkPH7qiHjdBwMHFbdgMNBkScQG8txcRtlpcuzQkeVvtAPlrnJaeaHS?=
 =?us-ascii?Q?pzc76wpak8BMHglSCGpEqh21Nki2eiD/VBhR4NieDwscSH0pSeREOPQw2i/+?=
 =?us-ascii?Q?nXcMqv9amqq1K6UsU4kCwi/9LpiHAw86or9imKNeaQay0ms8JBXkVfO6UIY2?=
 =?us-ascii?Q?8G+sjDr8qG4tl2gaNH2i7SPXwI/JN1N02SFMKLek9d/tbWLOlvwSenI3MaZf?=
 =?us-ascii?Q?Wr1SkkCnA71rpOG908FvJFkjhrXnBSNLC/XtFa3UQhrYJjGBFzSnPwRp4Hw4?=
 =?us-ascii?Q?YWbzqmmyXCqj4n328JhSFzIS8zbJon3SJIO//1fZR3UjO0Tt2VmVOKNnFzZz?=
 =?us-ascii?Q?Yr9XnCbnpTth5DelQhmthZcnK+rNtH2Sf6KmE0w6EssmL/WK4RH1yIfYzsnx?=
 =?us-ascii?Q?nh99GRyVvwhwW3onbnsniCx8gx+VNTl0UT23okdLdrhw5p3duqv79SeaWlGp?=
 =?us-ascii?Q?r2BfyIdjD2pDfMYXR5W9qE84/+87wkwt4ovLO76hiuw0otyK62quIQyayHu8?=
 =?us-ascii?Q?df/TDLU9e2TRSZAdQ2IE+d07XLzFUss8w3axIedqLwOvrqBuYPXZAKgNxmk3?=
 =?us-ascii?Q?Jg5YcIdUr2oZjL5n27tCdAbPRTvRl5rw2BjEVa7l4HOL/hu5ig6f+O+4Ip/I?=
 =?us-ascii?Q?+nNexA7pkmORvocOQeRb8N/rHBy9fVc+8p15TDXNbwYGUMTb8+xEfB+YwyEb?=
 =?us-ascii?Q?wNH6pt1MgybodnI9MjZgFUSiINDn2RST9nwQYXPHgjN3elBQnh53lI88PyyM?=
 =?us-ascii?Q?/oC18Q6l13uxfiH/GdFnKTUfqEbCnm5RS2gYXX5pIgfUxkAdafcyHIv+hr0F?=
 =?us-ascii?Q?StoSvDqchohlXl+pvt5olqZnG4Zp8/ncgsCJNKprq5tfEq8YtyoPAtNKCtBP?=
 =?us-ascii?Q?fgLFKnv78KMM1bVOvrdb/dM5wmTzSDJBZofAKkupyntG5eaJHjB3DUJrHBgY?=
 =?us-ascii?Q?bw/co976wVYfZiN+GXYgpu4fkU54Jrm5sJBt93cd2AcQL+G6KF1Eo4ymIpkN?=
 =?us-ascii?Q?6GjTMsO7Rg+9bQkVqeKsxCIjPro2H174Q2cPsZEZ75gXvDB0cbke7uQYrga+?=
 =?us-ascii?Q?9fuMkWYscAAhq3j12o+NPc60xMt1V2xLnpa8M8E7NMgFYXi5Ony4QvbS96f/?=
 =?us-ascii?Q?5YovSWQDjsaka4zGHh6YD+HCoPRBQOnuSZ+j8JOtb75Te+8I4eiGk/QtJbYd?=
 =?us-ascii?Q?O6BncCAinjUfvI5SFvPiFcvRtNVXiPNbYRXmsnV3ZYt3X/920xlQCyICr3su?=
 =?us-ascii?Q?UqwC9oIwQv2bSvOI/GtcM7L16anac6LPgaZZbKoOzBOpUSfZiM7Rp8/+8F7/?=
 =?us-ascii?Q?j7SHwNI8uwEKTOzHRKl5eJ/datfMPjioNqTCqyNVlCa2yA8N9jsEHb59Gu+C?=
 =?us-ascii?Q?iw8jSViKaeFi3Ncyc8u/W+uWHDWiDR8D6b4TKlIVTZ9lBPWwlEZ4FeHQ63QX?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46715562-783f-404e-01c8-08daaded8955
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:08:15.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbAYO1mWjnW/xB7huNkZK572HPnqhGQPKmDoAxf7U0K/HJITjaYVjVxxYFPy0K2BJfANlXsPxzR/INJ+di2C8E+KtoaroxgccQ1sY7PsSJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140080
X-Proofpoint-ORIG-GUID: DfgKHeiNFkODepjYGpRakIrncGo6Tlfm
X-Proofpoint-GUID: DfgKHeiNFkODepjYGpRakIrncGo6Tlfm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 8ea229511e06: "thermal: Add cooling device's statistics in
sysfs" from Apr 2, 2018, leads to the following Smatch static checker
warning:

	drivers/thermal/thermal_sysfs.c:656 thermal_cooling_device_stats_update()
	warn: potential integer overflow from user 'stats->state * stats->max_states + new_state'

drivers/thermal/thermal_sysfs.c
    642 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
    643                                          unsigned long new_state)
    644 {
    645         struct cooling_dev_stats *stats = cdev->stats;
    646 
    647         if (!stats)
    648                 return;
    649 
    650         spin_lock(&stats->lock);
    651 
    652         if (stats->state == new_state)
    653                 goto unlock;
    654 
    655         update_time_in_state(stats);
--> 656         stats->trans_table[stats->state * stats->max_states + new_state]++;
                                                                      ^^^^^^^^^
The new state value comes from the user via sysfs.  It is <= LONG_MAX
but otherwise there is no limit on its value.  Presumably only the
admin can write to this file so the security impact of this buffer
overflow is not as bad as it could have been.

    657         stats->state = new_state;
    658         stats->total_trans++;
    659 
    660 unlock:
    661         spin_unlock(&stats->lock);
    662 }

regards,
dan carpenter
