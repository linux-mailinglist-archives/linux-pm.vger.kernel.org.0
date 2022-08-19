Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1359A5E3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Aug 2022 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiHSTET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350263AbiHSTER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 15:04:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6CDCD501
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 12:04:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JIEHjn011879;
        Fri, 19 Aug 2022 19:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Henp8JiL+UyWBsw1rfkn8u8LdCHQTkWhBl3OyVCJGYQ=;
 b=Xg8tJ7PKcSQRfoPuTHVeNLJEq59g4qv9PwO3BdIaLOqjdVDgo12VZVBQ9DnNx3iyBGm1
 JEkzhzITvzDT7FrFNWpkWNbs8OEa3vjjzkxega2xK62iGoccWE5XAtqM3lfXtDc9ox3D
 z2JWSgf8e8d87/YTcprDsO+jfTJPfwwJcANY4zTyT1lnwJZJEeTdtBVTjvJlKC6oSvBi
 Kta7x1ymJE5cLVFuW0iyZ/gDEi0zTtpTIFzFa++dHgWIkLhNZ8ZMSySPUThNjs9dnPPC
 6oyYpqMeQgeRZPGF1HsgOe7yu17OmVtom2NwpYYyuitjWzJ+vyp2qfsIaUqPk6nrXGNw gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2fm9r54w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:04:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGg1mP010395;
        Fri, 19 Aug 2022 19:04:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d5ru38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EERz7m3agccH15iaot00j9Db11zrpzMFVdEHBkYo5Mx5z0JFvGarRP640rw1Mhi5dYIsc0dsYF1GYtiJRrZqY5MRhENlDbmhdS+xx+sVhh1C2dm/yIFwBQ1zlREEuRcNfiikWc2b1uJNMHyPLBqe2tbvehq8ECDHAPOiJzvM8P96KkSRR0K1wRdO8U63Ab3uDzZwYLKxf2X7tokkdZokASmJlK53aYmgsVJbYsnfgz2fRVltkTt3AtizVvqLf2x5huF3AjnEzj+f/9OnNwtHvGziAUBNnA0/eiF0zX2IXpCEY/hjNIKcTfUYCuzbO4PkC5OLf+gjTtYUcFQMYdu9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Henp8JiL+UyWBsw1rfkn8u8LdCHQTkWhBl3OyVCJGYQ=;
 b=c4Psdrk2SPMsyWrnLOqHD82IeoA60dDT2y1grASOkB83k88jrLN7rXP5Z4HsDXba25Uq4CO4ywZ+0x0MXQIEJPIxrMbSHqkXkfg7pec5tfjAkI7WOTZQBwWuKtt7erNfkNmOkzUpOk208n++85ClrA+CSD6p/lKYrwVvwBQbWniRojRP5hhdt5sHm9AU9lo9O/8790BmRaeEp9laIxg0lhtlELsdyFKAeTJ0sVJHs3wVVAM9hrEO7Y43KL6QwLz0Vj1eFBA0nfzuDH04xWQX6cJjA9o/+bp2m27hQ8YLpKups5pytRLQukUYkEXmDpBy8bIJ8BIDAFGOG7qzXXhjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Henp8JiL+UyWBsw1rfkn8u8LdCHQTkWhBl3OyVCJGYQ=;
 b=xEdoficM0lHqIHJfbvBFlRoClsQfik4sDpuZ0jFapO9xwSlquSjUTvjSfXHXTWCAjn5W1uYZOvez88VqGZvbMkK90zilfqQlqqzHy25UN0OMdTMqvpJF1h7hqT9gKT+ZRSfGUBGgRPLdsiGF6j9ij4Jq1T5jiMqIL71nqyDeLzU=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 19:04:06 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c%7]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 19:04:06 +0000
From:   Chris Hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: cpufreq: Scaling driver sysfs attribute issues.
Date:   Fri, 19 Aug 2022 15:03:56 -0400
Message-Id: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::40) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168c6492-e74b-4a43-0f8e-08da821596a9
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0+0fP62tcHNKOY/NrhyDjm9bAPNe/fZLGnPLB4tkhBjz8h3QO/JxooS+ylXiM54LoNzoHhRHPhUT4/cc8AJczQey29dfAzkCrPlgyuFo53ZGubfp6Mdsthky8+LhlIhJQCBQlrsbImyFKEsfp9uX3+QFP+79F5ssoVhztV7/wpwJEslRTlp/HVzsrgsPetSkjHVBUKMCFmh2Mf99hAh+L7UaFYf0Bl5a9OxUmHalwzKEBlCemPHItUEnm4g2wSc0UbXinBDwdLCGnQNISdrjEncEJvbPSHT7wQJJM5IaZjLS7te4juX8qf5zdHnaVHsHSzfrMwZf9hSxCA9t0KbXWGWDBe30M2a63V3QfDGO5vMDgMHT72wqWRI9iMBI/4+m45bVkkLvd2iFy9xrZGIFij54IXzHRKFdQdPNjgBSXUehVX4x2SBWhsBjTWl5+MnrnK6+7KQfZU1lZ3mmWxTk8T1nXOiZJGlwOE5yVtJumAldLstKwztE7KfMR8U0nsnWU3re6TSX+r7Zv9LddhxN5MumriXf11ZHhiz/IiApxnI4S21HD12IRa2mOdwbe3h5LWtEvSO1tEa1TlyIefGxvtJxVOQOxSuQ7Y0tjJ5D2npJqMOPvIGb1OYsSBOvDUf6+8P79PM2xqwO8BzQclAa0YTiUEjGBIAGPmOyAyLIkvLbeLOyAXfBSNQnp/P/LjG88LqdPcxyF+0Ywr4XKkqpuXbSswBpVk1/X9eVtrYb7iIye0nuYXfm07D+N8lg0Sq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(376002)(396003)(346002)(44832011)(6666004)(6506007)(5660300002)(110136005)(52116002)(186003)(2616005)(66556008)(66476007)(36756003)(86362001)(66946007)(6512007)(2906002)(8676002)(26005)(83380400001)(41300700001)(8936002)(316002)(478600001)(6486002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YqvFWLCBfOHMhJy8wD0m/ZDGnLCG6Mi9jKVuRJPZmDVayYuMDKeghl9i0vUf?=
 =?us-ascii?Q?cUrH+0nL0seDBYyMwbh8GkUpz3SoY8hCquewdDpDBed22TG2b8HoXVCTvARq?=
 =?us-ascii?Q?yWmmIyS0bIaPd+48LwIfq5uw/1MLnm8K4Z2iohcaIPKpj12tU7wDXRg9SFPl?=
 =?us-ascii?Q?BkKaWkaykGP//7ah7AkE4sRYwfGAA1AuogGQOFJO4+bsAbBjJIviA1pa/rR+?=
 =?us-ascii?Q?5lF3R4SyV1O8QDk3VmiAICQLQmcKvmlj9aRS+8Nue9JYDOEyQgpjG1gXcLbE?=
 =?us-ascii?Q?3zsgkDyrLHn2HhuLjipx0K1GZJjecuDZVymTfOw2lKfkdEUgKkEu9LDsOOuL?=
 =?us-ascii?Q?WzQnpitejK2dBEm2EjDut4zkMiMjw04t+++0vSgHSdckoifBosgpCeYHNUfd?=
 =?us-ascii?Q?59U9tMK2O0TqEzCh5gq3+aNyLhHcr1Vste2VqvpclPNcwsrezXI9Ogzvfbqs?=
 =?us-ascii?Q?IZP8fF0RXAYAk1G4QtvuSMz5Xhrq2QOwD9rzHhXqzlVxdILfpzUGc6wdjxzF?=
 =?us-ascii?Q?k9e+pHNRY3osXJ41iwrvUCndZf3NIL/Illt/8TNlPUbpqPfBQX9F/Qbvjjtt?=
 =?us-ascii?Q?K7nQwSXEtog9SWUbv1emEoAgcFHu36rjAHUL/QqZxwrASQ2HcSvE85VcVYrJ?=
 =?us-ascii?Q?+ZP+MI7lvlZ88VjteSYCKIblJVSE8chBQ09HFHjLFxYYxSiyOuzpqmKHVmN9?=
 =?us-ascii?Q?LzLYp9CLg4L+s6LkT202QfAedU8T4yK5fMkuz8n2gPSs+SDAGIe30Z6FdT5u?=
 =?us-ascii?Q?xlALba49w7a6TTbsSjnyKpAeozfmui2OyVRMgBHhnWFX8dLX5J8NpAtdSS7B?=
 =?us-ascii?Q?CGGCkgpMd90XpGnLd2YR7N/1/vJ5NI+NFlq+O3HFv5EfjJGEnSdCDE3XJEx9?=
 =?us-ascii?Q?gnq4IvDbmJhHqcTNm02T6dAg/XfRZp2sXGJ6bt4/WAB28TgiQqf+iXCopbli?=
 =?us-ascii?Q?Q0WTJXnYPZd7Biqj0pyTxS0uVc7CEe03fGjm27GD4tBO+fOw2BrU0PqQQQgL?=
 =?us-ascii?Q?RWrnXKM0ZKG/UzuNtJIbyAnO3b/V1KKVZGGgWylCvaxgLpYv1sYNgIlJeC3y?=
 =?us-ascii?Q?grWoI8567cznC7sd+InN5DeJtlqk8q/WOhY94K+m7nhvLP1Oo396eKnUNTRT?=
 =?us-ascii?Q?hLc0Qf1/YZiyhKSdJK5SaY4RJ3PsfgTp/TPnNryZEoejQiITQOi/ijlHZcTE?=
 =?us-ascii?Q?leVhH19hbnFer/gmhvfqwMiE+p8VXvfJhC44R2QpZVZwiG9wCjN0wOt8o4Qa?=
 =?us-ascii?Q?Hz3Ul5jLEVLo8qOi+7rPto9nu/ViVsBF81fu5MQcxW+mCgF1i0YDt77DFGGt?=
 =?us-ascii?Q?DrRqPDq82TKcTuZu8C86dMWMqZufcc2O6rLkWTaRsFQzfJv8wZzUDvHyCqGS?=
 =?us-ascii?Q?yd7pjAD1/ehWZkwVZGtdBg1YkoMnIOYMmJOCr7TYQ4ELGvPm1lNISZ6WwjXB?=
 =?us-ascii?Q?DgQ+lPYh8T0hXhRmXQs3ABP82sqpX18mXH1DM3lwK6sVXRi50nrwCwtlwlcP?=
 =?us-ascii?Q?CqM9RMVJaO40O8hGP908X+ntWmKSnpwvPRTfq1Mb9qVSQQxpaO/MW1gCnOmd?=
 =?us-ascii?Q?3XNgJb/xTzEYIls1KOQ5wuGFD1yT1+Wv1nIC2X9j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168c6492-e74b-4a43-0f8e-08da821596a9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 19:04:06.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb0DvAnOvI5cxB2nb44j4q7EKUCS3B0K7uZZnBy09aW7wu1egrdK8kxIIdnS1c0GvhZ/B/ZDtfwpiT9jcF8ujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190071
X-Proofpoint-GUID: RNzf02q-xqczF2YXQ7XoIt0Ds24f6inM
X-Proofpoint-ORIG-GUID: RNzf02q-xqczF2YXQ7XoIt0Ds24f6inM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We found a NULL pointer dereference in cppc_cpufreq scaling driver, traced it
to root cause, and looked at the other scaling drivers to see what else may be
affected.

The simplest fix for cppc_cpufreq is basically identical to commit e25303676e18
("cpufreq: acpi_cpufreq: prevent crash on reading freqdomain_cpus") and is
included.

The problem is a scaling driver which provides a struct freq_attr sysfs
attributes array passed via struct cpufreq_driver during driver registration,
has .init() and .exit() functions and does _not_ provide .online()/.offline()
routines.  The freq_attr attributes are often backed by allocated memory from
.init() and freed on .exit(). The issue is that the cpufreq core does not remove
those driver freq_attr sysfs files in this scenario though the backing memory
has been freed and while some instances just show garbage values, others contain
pointers. Note: registering empty .online()/.offline() driver functions can also
solve this problem as .exit() is not called and the memory has not been freed.

Looking through the other scaling drivers, most that provide a .attr use
'cpufreq_generic_attr' for which the 'show' functions do check for a NULL data
pointer. Two others are worth mentioning: brcm_avs_cpufreq driver has it's own
attributes backed by it's own functions. These do not check to see if the data
pointer is NULL in the show() functions, however as it uses devm_kzalloc(), it
has no .exit() and the sysfs files remain backed by memory until driver unload.

The other is the 'amd_pstate' driver. I don't have a means of testing, but I
suspect that this driver does have a similar problem, ie if a cpu is removed
and the various driver sysfs attrs are accessed, it will crash.

Additionally, I spent some time looking at an alternative that removed the
driver .attr set of sysfs attributes prior to calling .exit() in
__cpufreq_offline() and puts them back following an .init() in cpufreq_online().
On the AMD and ARM systems I tested with, no policies are shared and thus
.init()/.exit() are called on every cpu online/offline operation.  A simple test
consisting of two tight loops one onlining/offlining a few cpus and the other
reading the sysfs cpumask file, ultimately results in deadlock between sysfs and
the cpu hotplug machinery.  This seems consistent with various commit comments
about the locking here and a good time to send an email.

-chrish

