Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F43339A14
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 00:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhCLXkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 18:40:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhCLXjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 18:39:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CNUJgc159815;
        Fri, 12 Mar 2021 23:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=jzjXHNMyGk+z3372AJ8At/wuLp2b4vLa5t6Y/HYYm1c=;
 b=pvaBGzatWkLxWF8UMRTssjxFvGbgj6cBNCv2cTY6LdLFYWZGtPheOw6BCxpzA4tC5fbS
 MhWaYApC8qa2W1/CGlSNMUEWMzDxTP5zIOVBDq8MBm0LQQWcW82KHIz6ztUkbSZVQZqK
 GymxIGNtrZqUsk35/p8LM/CiHxnmYf1JUVqagvmIxVwg332AdFK6dsW4raKpwecORrk4
 gikh065qrzQbN1Q0ywFZRM/MeaJSYwRcMKKgXz8ViGWV/qtgZsQv68x280QkdUU2vtUv
 IvXNYZK7E3Guw6htf/0wv/Mg34gqgHZONa74EA3qFUNHNpgeJap51aTn1g/M0s3OjRIS 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37415rkjba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 23:38:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CNZaG1179205;
        Fri, 12 Mar 2021 23:38:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 378f535cxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 23:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT6NCKUS30UCABzxfGzkV86FRE0nO3McqOMU70sjM0ij3fzM3RQKV/kAWAJPPQ0jzwBrHIi3CHIUmlsdspvA+LlJSXtUQJItwNgvriXYCutKhbJIeeA0uEi0eocyGv9nDaD60Jk5d93GKt07w4WgvNxiMgNLZzBY1YVCxPq091BirP9OWaSpcIUDf9N6NUdKWFirnnlie/YQSIb0k3mnTzB2Oy6KcOpgqGaKu1csbeyHYnscga5xWkRY7jqpJNumrFlIgIXWJDvdn2G522w1lPy54F9/rLPdA519I+YPisv8VeSeeMgi0fr1yppFPlAg1zbuB6DDU+wIZoA9wUeYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzjXHNMyGk+z3372AJ8At/wuLp2b4vLa5t6Y/HYYm1c=;
 b=Z5udzEmsruGjh5+aInQ/Bz6YDZJuVv3WZaUmuEpm09jZXaU/u2EhLAp8E3y47dfeWLAkVYF5BbYiG5mN0HXfphMumWLEajFJdX5cAWEs1yyFynCJlw7kueTc/iMMPgoispVGkrsazfT3JldiD9w2jcCwpk3DMgbL7GdcG+83taNt8+8dsL0suj0sddYAq4euwHFREHLYl2m/ojQJkBQ/zq+cbOZE6agmnllQJLa9wR0QewKb+fcRzNM3YXJhdwVPSR+5TKwJQMv5xu/53kdAuowtihZDZf+E9HW83hrIyQeATtUGDeejIX0UUWvDsi6/azvcl4dHbROEgzMH+HVp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzjXHNMyGk+z3372AJ8At/wuLp2b4vLa5t6Y/HYYm1c=;
 b=LNgoFjj3QsAyMDRTEf9XSm/5TUAPaVuUNgIhLeSSfMwahDmwiNU8ev0mTL0FWVA4DTZYYmddNZCTeJY/fhiRvcf491SCzyX9rX9OWgTFRqusCNAKRPo1XFZ5870y+dg9QDWZPmNx7Y36csO7oj/OmZNEbUu/nybau3AKl8ULxog=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2981.namprd10.prod.outlook.com (2603:10b6:a03:8d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 23:38:05 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 23:38:05 +0000
Date:   Fri, 12 Mar 2021 16:38:02 -0700
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <20210312233802.bzriltvej5gccsdp@brm-x62-17.us.oracle.com>
References: <20210312120817.12604-1-unixbhaskar@gmail.com>
 <4c0c0738-72c3-7704-500a-28cb1a068aa1@kernel.org>
 <YEv2RDAdeJEU75ib@Gentoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEv2RDAdeJEU75ib@Gentoo>
X-Originating-IP: [129.157.69.41]
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.41) by SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 23:38:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff7474b-9273-4254-31d4-08d8e5afe251
X-MS-TrafficTypeDiagnostic: BYAPR10MB2981:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29811BFD573DBC287331519CFC6F9@BYAPR10MB2981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6eze9GdiKpS0bZV75zgUWjL2CjAhpDKTXCpE/CRYUlk9rzQ1mKUsX17pzReev2O05eU9UTNznhPhMNKd8f4wCrrm+e1XQ13OTRYDIEzt5JJ7kzhDcReZiekAHiG9EhnyGD61CfNxbJHKPxVm67nxsFv9OZSgkZnAxJH1cZpoeeeNC7jz8Z3Yso7PL4dSiRrEIFwfZo1EDxrSv00CIQfxGTl28dgGQPUeef1XwANEtkbmzvX85ac8K2KBZiXWYGwC1phtMz8aNAhEnNyx3wR+qxgCVU0Z5rVNDyFTpZSBNxOcB8oXe0q58XEl+WFLAyZmJGqh3XnpY4l532Z2tdt+RsJorCCWVwtbGs3mztfXZABcZLrTsRdnDB6FcHFYpUWGCXVz/afQN1GmDHFBbG7+tRZp3Y/+5iasiZQXP1NVfGYaG33Mb3/9Vy/jR9vgFpZYhC4TdJhM8auEqgZ/PerFzOqZLahW5RxeDGFgJuoqG+kDjvuDyQ/UwSH9yBOFP+loqww/WvJhASnsDxE+tW/iw2BQkJaTqNmH8AmsOLHI2eA3NENhRKjrUlSTriysVuN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(346002)(39860400002)(478600001)(66946007)(86362001)(66476007)(66556008)(7696005)(44832011)(53546011)(83380400001)(5660300002)(110136005)(316002)(1076003)(8936002)(26005)(8676002)(52116002)(956004)(55016002)(2906002)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PCTeXwYu5JV9wBf/+r6CLu15K8GvRhjGTcT03Ub/zKGFT6pu870RRGO/pkRV?=
 =?us-ascii?Q?HuM0zUAG6PIYmJhO5tponuAsdDnhLCw5yBMzj4ZyJJX9uglY6nBtwBE6DKpg?=
 =?us-ascii?Q?ZmVTk6z3XtTazXDtEiwWEcmGhP41/og3DGw9END9j5pSWk65yAF/kb+7+9vk?=
 =?us-ascii?Q?j7NyaabVA1mTOkJpBHs72CvmVp/SmJBuPcvPWk9IBsQCoEz7DRlTdDs+w90v?=
 =?us-ascii?Q?rybSqqygyVpDD8NjZdZ1PfqRJ+Iz5XTkl6hty+7+kB8jnaw4r0VDUmUDboTn?=
 =?us-ascii?Q?KjeJwB0NGktG5t/ZxcfpsFqCXR0EaZYeIV9Y/XhLs+KcJUZLT+CrLdchnavf?=
 =?us-ascii?Q?Lm0PbxeWg3KKYdI6OKA1bG6lnbVlHUslNmCd7FIG2OHeCGHm5zBiS4Lmt/xP?=
 =?us-ascii?Q?tpFBI21e4gYxTP3GIxa1etezoc6SQ/V3ds2pqiid8odhZqISU0T/xlCha5+a?=
 =?us-ascii?Q?072e2bMKF2feGkc+UQrqyplWkiW1cshnLoQZQBcdRR1T5pKjkO4ctq/HkkD8?=
 =?us-ascii?Q?x+Fz2o2EmCSNt3e4SOV98GO3lb0awMLHOTKMymNPGcZlM0NvfJ1frRlp1yjt?=
 =?us-ascii?Q?xnoK7hvNHg6c3esBO5uyLBpK3SUaYEAaVeCIkT5jmkR+Wsm5XWkRP3c8M3FC?=
 =?us-ascii?Q?2hqGupb7nNmtEXXXCot8WVwOiOA99W65REix/vRdsFpRuhHaK79HRgz6G9gp?=
 =?us-ascii?Q?pXPq8iWnAFOf+ubEWmFlT5jbGhataUzoYmxc4HLneLni8jxaARKIGZmFhsy8?=
 =?us-ascii?Q?SagG9gB539Fn2BXSZG5+9/DAq3VSzhxSmS1LEk0lN9fMTaCjo7s8KFRxmTrN?=
 =?us-ascii?Q?OtkY7NoQTNHtVY59ctKUqkEWinPOk1r0OUJTHjUvCBL9A8IbfOGgYaVMjsiA?=
 =?us-ascii?Q?tFFCUs7d7po1D+9Ox7AB+gmNTiZOE1YQR+CcLQMokQgaDunWxDLzGJZuKFLT?=
 =?us-ascii?Q?zjDpbNSut/+V6rXzfctGyPgH53Q9u69pi9Y8hEJ4VG0WPcaY3kaEEvGrT+7S?=
 =?us-ascii?Q?bMHEjJcL/YtXS0Y6jcOBKtnMeESNvGwWl0xiBU811oaaMLZWGSTO1fXsI4bg?=
 =?us-ascii?Q?dNR6Az7EYmVWu2aGUNu1XkEJV78zGiDINWDobMC0dyhKY6FZi59ZsHzj3azD?=
 =?us-ascii?Q?hwE0pkiWJf/RnfF+NrjNrSQY3pnX1Kq9Tjgcinl+yE4SIF20ZLtgAgP3wmv4?=
 =?us-ascii?Q?UKH1BN/DwPYsxqhx+O9Y/G9RE/Su/GkSdetoNMGNmBdGseLfrhQX0IpZ577+?=
 =?us-ascii?Q?EOyysxQD/E+P6bVVEwP+Nbk9wElgsB6nU+BDccP0OZ6WNXEnopX+vnMvQW6R?=
 =?us-ascii?Q?8qCdewj0TpLbNoCFXHkFf4QB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff7474b-9273-4254-31d4-08d8e5afe251
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 23:38:05.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE1y+iE8kixJnOPgO3rdCp5hC+wbja53XykZciTb5nTi+FRcCdjQbVpw87bJ9zXUz3EtaUZRWlEKvG1SwzHXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2981
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120173
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120172
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 13, 2021 at 04:46:20AM +0530, Bhaskar Chowdhury wrote:
> On 15:01 Fri 12 Mar 2021, Krzysztof Kozlowski wrote:
> > On 12/03/2021 13:08, Bhaskar Chowdhury wrote:
> > > 
> > > s/untile/until/
> > > s/souce/source/
> > > s/divier/divider/
> > > 
> > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > > ---
> > >  drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > > index bed496cf8d24..1cfea5339beb 100644
> > > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > > @@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
> > >  		/*
> > >  		 * 6. Turn on APLL
> > >  		 * 6-1. Set PMS values
> > > -		 * 6-2. Wait untile the PLL is locked
> > > +		 * 6-2. Wait until the PLL is locked
> > >  		 */
> > >  		if (index == L0)
> > >  			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
> > > @@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
> > >  		} while (!(reg & (0x1 << 29)));
> > > 
> > >  		/*
> > > -		 * 7. Change souce clock from SCLKMPLL(667Mhz)
> > > +		 * 7. Change source clock from SCLKMPLL(667Mhz)
> > >  		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
> > >  		 * (667/4=166)->(200/4=50)Mhz
> > >  		 */
> > > @@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
> > >  	}
> > > 
> > >  	/*
> > > -	 * L4 level need to change memory bus speed, hence onedram clock divier
> > > +	 * L4 level need to change memory bus speed, hence onedram clock divider
> > 
> > Also grammar fix: need/needs.
> > 
> Hmmm ...good catch...V2 on the way...
> 
> > Best regards,
> > Krzysztof

May as well roll in few more?

Regards,

--Tom

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index a186c0d8a290..6ecef301bd40 100644
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
