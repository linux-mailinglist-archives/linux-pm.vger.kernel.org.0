Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEA339B7A
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 04:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCMDB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 22:01:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45264 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMDBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 22:01:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2uqgl027397;
        Sat, 13 Mar 2021 02:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=edYKDX4GmP0nZEJrSA4oaWILUpTYF+7CNEKYbA4QJuQ=;
 b=VXd8eBhctZ4YVndX1JK2gIJWzQfMynj9n0fe4jAkmt7YG1zRWsxOZtwnIIzoLTrrk7pW
 x5IB9Ef4m8ZZyKfbyrZwtWMKWimS+uyxI5Zi38dXBanJzYdioY/ydiM0AP+utbcb42SD
 ELpRzlsDbA4VqX4Isbfv93ctY+tvHmCqUQCpdTIyMPYG4UyRUAWmmi8vZVh0Mtegj9vf
 wde3PMAh41xVlySR68g2YkJg87jFM7nrIAZ7fmhDdw4e+2uXgjvzavlOkXq21hShwnuA
 4f368DzU7emz0/Uz87oviN1pdtDznPLAPcDXzNRGGvehdhCf7s04lRE7zN0m2VbLndjN Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3741pmurgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:59:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2u7DH002928;
        Sat, 13 Mar 2021 02:59:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 378keacc16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm1MMFi9/99EEXi8VhtX+8q3grsCsRZ9Ldxg7jDj38t0Qsyk7MZfh/cPOJZnKRY81ap2D2latsIHpVPRxUaO5SEa3ZifvRtITfNDe4iboT/86ibhzjCF+xCinqmu1VkNjlVG1wAG9O0TSmWPVoppUInJM/gLtv/NX7JRxqzNlAsAcS27XUkqUXFOpS1HMrIQt04wTtdOmeOdSaE/Spzq38SFkaUsnLtyNBzz9dox7DZk3iUM+GjTdV6ygyubVfLNh4oE+kywrPqQTrvdwU6bcf6djddmiXASLl7ZZOL1OIQZzOnxqPV/8nJiZDDc+wDjPmN+5RqHxQccyUrXFqi+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edYKDX4GmP0nZEJrSA4oaWILUpTYF+7CNEKYbA4QJuQ=;
 b=KJGt6si/WOSwqZ4oxBHOB5uehvE3rQzTMmLC/4DH+W4eURB/neersAwT6scu6BgyG/pypHmfjeTHYfOhexowBqvmQgdILWxclcAY3kVtOAiycK4cft+eDGMh2KJJKbkm63bN5hMQ4FrhMlOq8mIAmNVInMLmFXQxiesHRz8eNGTEZvCF9AYo3jXPHjdIYFOaHdxbHM1Pi2DEu9QT65tTK7ywefZ3QQ222Fo81rUSq30GD6DLEGR9H/KS6IlDHDqkM3fI6IkzYYU7pLy75rba22Pn09AdG2k6lPKm6ehHKAZaWLn5c0ryDK3LxyYxe+sda52+LE6W/D/fyXQ5OwZOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edYKDX4GmP0nZEJrSA4oaWILUpTYF+7CNEKYbA4QJuQ=;
 b=jJ6yu5QTZzWtf9E/yIiJC2a8EGzjSQ7QYi5DwDm54zewcoKsHp4rQui8sXBD78qsdT7XrmCeiZQURmBzdiKz4YQBeljUFZDLmN64yVt8nRej21vC/qbYxEK7EmCj0RXgWlo4bu33Iph3iYW1Yi2+M1SjM8vb5CED/1ERJfP4E9A=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4340.namprd10.prod.outlook.com (2603:10b6:a03:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 02:59:10 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 02:59:10 +0000
Date:   Fri, 12 Mar 2021 19:59:07 -0700
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <20210313025907.jhpbj22gfudzx4ta@brm-x62-17.us.oracle.com>
References: <20210312232621.2083-1-unixbhaskar@gmail.com>
 <20210313001613.j3j66pvmfzxznw5j@brm-x62-17.us.oracle.com>
 <YEwMbGm83aRRxnuR@Gentoo>
 <db71b3a5-c45c-0d5a-3593-c96bb3fc4318@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db71b3a5-c45c-0d5a-3593-c96bb3fc4318@infradead.org>
X-Originating-IP: [129.157.69.39]
X-ClientProxiedBy: CH2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:5a::13) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.39) by CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Sat, 13 Mar 2021 02:59:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43448921-7c94-46aa-42ff-08d8e5cbf9d4
X-MS-TrafficTypeDiagnostic: BY5PR10MB4340:
X-Microsoft-Antispam-PRVS: <BY5PR10MB434001554306958E6F457554FC6E9@BY5PR10MB4340.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dA0WbiLptn184BQ5HJokdagNFjW5MtPSY5KYRrSNN19oGnA3k3n9FkLwLAFTFXH5zPt7eEIgKBFxSuY0nfwz80xNP8/AaJPWgkAtewIQaKjMPovEnhiqqq78c8IhiBG3r6xgv0L4ZbfSUIkX2UVAwbbjrB8fScbVoCo1gb2+ubTzW8Cn8kxqzEexsiGhGqigDWwD9rfHOqb8f/YIMf1nziPhFB0u0t6gxqWbLFwTkY89U42PkCAbCbhDXGeFLRf67yjoeQXLCJ12t1xImDCyaILXcsbC/1lJMcvameVNCjj/csOGXhuOC2aGhCrvgfeyS7/A8xlMh+Jekc0k7Nvek0oJ2eVkBZ8mdlWQ52UtRReHhw4/RvRjwNLNUuwpIPjvy0PurFF4K3MUFDyp14oc0UKynQJJWsZIeKOi6zZl7eOLTWM4d5EavtL/7I5wAHOsXgr8F8FHhEw/QPal+QmUqoqyjyGErfKQ/UaBisu1+eraRNLhBqzyX3P+afvbw+2Gk8MV2EfNRTVeEJSzPwHhxxloF7cKcyCVExss+JPEHF6SkhcdgFQw8FDuEZS/Jr3x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(2906002)(8676002)(6916009)(53546011)(44832011)(55016002)(316002)(5660300002)(186003)(478600001)(7696005)(16526019)(956004)(8936002)(26005)(52116002)(1076003)(4326008)(83380400001)(86362001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k5/XAmSLnkj9E7sBD1+WwxsHcFo5s0A4Jjau7gUS6WEg/nq+wtvofMcO5YZk?=
 =?us-ascii?Q?NS/RHLwyk/glS021sppzE3NtjfHDkMiohL3rD/nWMTojSQElfef+r1T352ku?=
 =?us-ascii?Q?VWWr+PzwNNjdtuKEm7zw7s8HCNuUIGEk489pX6HEI6rs9a7/wihrqzoEto+t?=
 =?us-ascii?Q?fDNEQ428U0m85T4bDc0+gdSy4fFDHNoakh/1tYK+v6Cqs4z3ihnO8pRns0so?=
 =?us-ascii?Q?4OU9g4xCaisB3CPQk0ltRtiK9ThTavJrz5qE8NGdrOW6nF2XhEhZRmeg0SNj?=
 =?us-ascii?Q?1F38XFR+jbarzr77coum79NhRLBZzQtn9Zr0I5Ygw3SSS7VajIS6g8L3j6uE?=
 =?us-ascii?Q?bMavpX71N91UwXr6fXZNnMGXuH5jXgiQI+HJX739ddJsUdIfSFoz8/UOpUj3?=
 =?us-ascii?Q?5ZuadeJ+FnzwWUNOmonZ1/H2uHw3ShlxGno7+JvucGaE4hq7xb2bQkgQhsjP?=
 =?us-ascii?Q?ij4jNY1DUUQax9Wr27xrWv5LrSy4yDcyi96RD7N+s8/25hfVLnsG2WuUZ6jc?=
 =?us-ascii?Q?IysZ45jIy1OrjLRJy1awPMXGPiSNZffTKbm2IN5INV4FTYxpj5w2fRMFRbh4?=
 =?us-ascii?Q?VOtea78ifG+RLEvW6jBCVyr7NZlEviVawh7sOuOOL0jK9GUT5SeLr0K+XdU5?=
 =?us-ascii?Q?++MjSDf51vFhvfrzFfZk6I2VTTWn9gF1z/PrIGMEgBlvCkJPvJXkHhMovafk?=
 =?us-ascii?Q?VJoEUpoBQENUyVgt4Cf03svEpnyS0ZDGsrBvyt07muTbvtqRL7auVULbUz+g?=
 =?us-ascii?Q?mpo/Tmtga3jrORPJ7FBrOX5v5K636j4e359VUNmF75+4FhTXnPjGdpMrVWMW?=
 =?us-ascii?Q?2t8oYWTHZLqfsjsqvOJro60qtyycOMM6mLw6QSAbKxHPFDwFnLk6NLDCdzhE?=
 =?us-ascii?Q?h5mK6HsMEO97gH7GrzB1BoWobC/3/nD3qPqQdW1k0eD3uZRT7xsyAS0RO0jI?=
 =?us-ascii?Q?Ke/OwCZ7JfTKSHrtG0fhr9cWOHrAIMZUPK4duyvHcQ8S6050oN7XziA9aco3?=
 =?us-ascii?Q?2QhwGBZuusw8XIB3g/GAv7KuFpEgFnpcZtz1yC7GfQQhDjnRDtNWSsWJ1LSi?=
 =?us-ascii?Q?tpo3LuTEUjTmUtE1utf28prpecBVu/fGIXjzl+rvyKbH0mQa+JJVN+FUIJ7I?=
 =?us-ascii?Q?R0ryShLTd3spKqsgRTx3Bh0wU8gf60M2i+r206NSgE0NNP+YSk01KQzQ2sei?=
 =?us-ascii?Q?wzQyQbfO+GuXXqTQ7ArsXzzj6n5ncsYs0+wABXHMfF8t1/L0s+eDb+yqdF+Z?=
 =?us-ascii?Q?Kx0caarW/Qm8OGOw06HnnFqRIiwASE/HzGlm+JGLEH9armWbdgEXvMjDXivU?=
 =?us-ascii?Q?Sdaa6Dzbzq99IMUakScHlUOm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43448921-7c94-46aa-42ff-08d8e5cbf9d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:59:10.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoxsq/LRLt9vRvQPQIKBdjL3wsf0p92V1mq72OYw8GYSoeI4eIQ0oXZ1p0O+T5X87YgNq7C86L0PSsUp7yvUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130019
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 04:57:07PM -0800, Randy Dunlap wrote:
> On 3/12/21 4:50 PM, Bhaskar Chowdhury wrote:
> > On 17:16 Fri 12 Mar 2021, Tom Saeger wrote:
> >> On Sat, Mar 13, 2021 at 04:56:21AM +0530, Bhaskar Chowdhury wrote:
> >>
> >> sent a few additional typo fixes to your V1, can you add those to your patch?
> >>
> >> Regards,
> >>
> >> --Tom
> > 
> > Thanks, I have already sent out a V2 in public...I might make a V3 with your
> > changes too...did you sent it to ???
> 
> It was just a reply to your v1 patch.
> 
> -- 
> ~Randy
> 

Bhaskar,

Here you go...

V2 additions:

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index af1ac3f6e4b8..73110b005716 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
 /* Use 800MHz when entering sleep mode */
 #define SLEEP_FREQ     (800 * 1000)

-/* Tracks if cpu freqency can be updated anymore */
+/* Tracks if cpu frequency can be updated anymore */
 static bool no_cpufreq_access;

 /*
@@ -190,7 +190,7 @@ static u32 clkdiv_val[5][11] = {

 /*
  * This function set DRAM refresh counter
- * accoriding to operating frequency of DRAM
+ * according to operating frequency of DRAM
  * ch: DMC port number 0 or 1
  * freq: Operating frequency of DRAM(KHz)
  */
@@ -320,7 +320,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)

                /*
                 * 3. DMC1 refresh count for 133Mhz if (index == L4) is
-                * true refresh counter is already programed in upper
+                * true refresh counter is already programmed in upper
                 * code. 0x287@83Mhz
                 */
                if (!bus_speed_changing)

