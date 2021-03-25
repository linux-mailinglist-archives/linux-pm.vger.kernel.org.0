Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66513487EA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 05:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhCYEcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 00:32:45 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:2016
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhCYEcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 00:32:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2KJPe0v6jQ/cNLdm6FRMJAhNB3DN0HFPWrZvhMpy+V1czslGksuLdc03Pi5svWSjROsFYTbMj0LgkrlyfP2eGjIQQZ1KyzcGKk/7QlaxcsWj0FY4YvnZYnYQa9BN6HywgALGya7gBo8uwNUqHBoF64A6Y0Q+nRIX5InRhBa/v9Uc7Rf7FEmMwgyJnuill41XA4p5x+V8ZkvpDom4qPmUlCCYE/smFbOx78hRsIoTHxp572IoGjzKm/O/qLK4ctAZe/ylh0rfe2HK1KRu03M27KtU4QZ3Ik1GEfGha8OD7EPRxlaKIr8fZiTT6qVyx+oQ3yxu+dCkwe8Vd5CGlaiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xzTKvFTmh/+NwgFSrH5Ey6LD4sLHWRQRM0VjqZdqN0=;
 b=kX4Uyy4DfReTHH0gL/2HxvyCAi43eQ0XuAziI4kPU2bQL4JM22d8kcm0YmYI76e5UzcZhoDiHckeImb5P9WgchvfsvXzmqoH5bdX0a7CaCWey3ZV5y9Nj5yLWf7MwJ4QvanUPCVwyIej3P+l5SXT2aOTSWSUputwJWooE5GmlniWWIcbPiSAoF5cqxOn2xBIsHju+aD9NmEQdSIhWUYfTHDr7F/eFewXmtzy8vzlj4MuMiB6XA/0kkBe63OG9yKFdtKj5Ne6EER30+vnws86qaqkiqNL8kQ/2bzjF8CeoK6V1wLDZa+WcoJfAo5ejp22i/W/QkVmypUpSzhVaBDP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xzTKvFTmh/+NwgFSrH5Ey6LD4sLHWRQRM0VjqZdqN0=;
 b=Loc5kyhaRQsYVR8bERpUUF0XaaD/Et0cVOUOfAD+vKBYQPpYhwaiD6ykqfV0Derom+lTmsZ8TNg8SZFTL4FvEVA0n1xkbvu0uYUrQe86s6rU5C3ZkJcVuOZy+JGnKGiitVq2VQ48lCWvxjP4yWRqd1ehpdtP1aHQpU6ko2Sshp4=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1527.namprd11.prod.outlook.com (2603:10b6:910:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 04:32:42 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Thu, 25 Mar 2021
 04:32:42 +0000
From:   quanyang.wang@windriver.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] cpufreq: dt: check the error returned by dev_pm_opp_of_cpumask_add_table
Date:   Thu, 25 Mar 2021 12:31:29 +0800
Message-Id: <20210325043129.2255918-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.15 via Frontend Transport; Thu, 25 Mar 2021 04:32:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b4be48-5cf2-4ec1-0d74-08d8ef4706ed
X-MS-TrafficTypeDiagnostic: CY4PR11MB1527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB152749F1E29F713FF31BB52DF0629@CY4PR11MB1527.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2XOJ8OWsPecjISNcZV+DLbsKT1USKUdEnf6DoLmHPe5yquBiUaW9C3TjmVcB30uldAZb1fvqSLjM7kGvZuntE2pmaJ1dhBuHgaWNTAU9EKviY57msRZhrT6DJ0wqL5og3SEaBlE5HWaZZxdECrz4oNUeymFhGlB0bXfnICBipg/ThQtApRGSPCmPU4Kced056M1m3Ok2F5DWKDNyxmJW7e41+A1JIwR4xJj9OXUaKi6mhg/glO2DLhzBWkXeyC+3WHtY2ab4ozbS/E8CloTApZTqz8CjyWzBL4+xsnfsHRxflizwwO6ctc7mVg9sLrFmBKdyQvQH1bQHxgA7CtLFjNAReqYjOKmQCaaUXxzdU+v/jvrad1SyG4ZfV8nrSbe1PqIeFWExZQfoT4NBlm5ERQ8y/GRR7KUxEIY5aNh/QGqK4RrnykzfsfWWXlZaW4iFCYFGiyqTrCszyhitenRt0rRXXqMxUiVKMP/cs5CZWaqeVI1wYbcdDOnMc6qGjCenPP5fiSSeHQsFTwgx/oZVkl3AGdyFqmOIICtlQFNZN7UIv5RJFlJ3yIAIvt1QoBKfvKpSLq4XDp5lfAfNSQHmVNlqyd16VSa9xmVvLum4oLVZDB9tMHmHMW2NX72gzasU2RfbkoMyOXnCRqutEaCWcVlndVzfCzvOE7NLZkdN/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(956004)(2906002)(186003)(6486002)(16526019)(4326008)(2616005)(8676002)(83380400001)(36756003)(478600001)(26005)(86362001)(66556008)(107886003)(66476007)(6506007)(52116002)(6666004)(1076003)(5660300002)(38100700001)(66946007)(8936002)(110136005)(316002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GxXf5F6Vd53vlhmj3DnDiSfmirnA1JmgCNQIoAydmPcJfNucxl14V7lqxlYF?=
 =?us-ascii?Q?znU5ajGoYM3qB66fNG660fpmnL39LhS1jCI3v+FmrzOkLe6JDLfTpDMYw4Fq?=
 =?us-ascii?Q?GOkcqk3PDHMqx3xt4GBm1VjXu+BgvV1Bh22KZ6vW6+CymMPAydpxex0zpDDD?=
 =?us-ascii?Q?yic8g02yexjNRluMuKzfSk11Ni7BbhXu+/JWPnbwch6J6KuUk6D+o0oFyqbF?=
 =?us-ascii?Q?S3LlXbOAo2kykvBne2dgUxeeGaeYHIyHaEhiuChV4Vt7qAb2s46jlbIgjFDi?=
 =?us-ascii?Q?5OAX6kxyGSXyD5dr/WMqyRd2XPPf9ZjPA8kxz+FYOSMXYe1rqQmh9n0TeRsb?=
 =?us-ascii?Q?Dsv97ZjrXb87XKg6idiPddONCGL+53fcV+taS8599doGW+3bsE015BoHNI5+?=
 =?us-ascii?Q?6TdTwlPDNmnu1dVDfYhZ38E+Q4KZ9Aq+b/XiuFWVKuJoZD/r3gJ3rjy9hfGV?=
 =?us-ascii?Q?n4Kyyzxi83MFDsetUcGxa9e3LpG3QLJTBYhclvQ2zOkcl3hrxytqs+Sg4VPo?=
 =?us-ascii?Q?fsXCfTHTG+REH2I1U77CDQ+CFE659yJPtxyor1txoTojLHt+QGxMEyC0cwRP?=
 =?us-ascii?Q?dkgw5BmTE4Mcr4tTcc2qjcOIXRhxZi7atIHr/prL7WHdSDkrgEVfLS3bWhxq?=
 =?us-ascii?Q?41NT4j6AiRNu9azyYLdDf6Wtfoq0byUYFgjNuYCy7aL9HXw1v4YZGTGrT8dQ?=
 =?us-ascii?Q?N7gOFl501cfs8TQSfPk2J1h9bC63YqH2JMAsLZispiV/Y5KCXJkHbArrf1Be?=
 =?us-ascii?Q?0NAH5U4OINlI/2O78EtEKUBf3RMAHxWRx2c/YFURDT3rPEqedbpc40UEfM1u?=
 =?us-ascii?Q?iJQeM9w8BkXc7zsgLWvDv18lepNON13dFls5CTMqc7aJOieBV12/s6An+mC3?=
 =?us-ascii?Q?uoKgbgxZ4tV40E0IkjWhLA5Wl0hRw0QSwqcidToCxMF1UHy4OCVSFptwaHD5?=
 =?us-ascii?Q?D/wbFjqxe9bD9YvLeiwfG0+pW2pvjzHbzgKq7fXovG0vqVvQ34aMwei+GIgL?=
 =?us-ascii?Q?7eXH2M3yR1MDDKMj9MPAhhq7oaxzOBd1cdH4pgcv0rfE4GaS5iX0WNIWUjLl?=
 =?us-ascii?Q?WMXwwUgfdbZiGRNyQpbLiCEYN/od0GuByqrjNQmdpCjt0FcwKOBSwdpokcWf?=
 =?us-ascii?Q?UlQojoNf9nor/05YLCyYOkhO97znqLj7qKYz0Alxiw/P9dLLVBQUR9axFxXa?=
 =?us-ascii?Q?Av2I8W9KMebvT4agzOOdUEilV5pYVnAFgACmChaE7TMALwwG/JCJq8E3uQ8i?=
 =?us-ascii?Q?5GHcx7eKlzeUTurtioR1xf8zfYFTRtIH/qcAiblU/Ls8cIQV1rlWFzNkvKuB?=
 =?us-ascii?Q?Ylzl9HV2zJRsK9aGRZHWU5aS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b4be48-5cf2-4ec1-0d74-08d8ef4706ed
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 04:32:41.8845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU5udI9tYFpuTogS/Ha8O7/VyzukShJfYlW+9HNQbsG58xILKo7kSkvA2E6J18oJ+zD1e3F2V25C50Fh+3vN3p/SlFUaRrBBIiacKeVEXr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1527
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function dev_pm_opp_of_cpumask_add_table may return zero or an
error. When it returns an error, this means that no OPP table is
added for the cpumask because _dev_pm_opp_cpumask_remove_table is
called to free all OPPs associated with the cpu devices in the error
label "remove_table". So continuing to run the next function
dev_pm_opp_get_opp_count is meaningless since it always return the
count value as 0.

There is another reason why we should check the error returned by
dev_pm_opp_of_cpumask_add_table is that it may return -EPROBE_DEFER
which comes from clk_get(dev, NULL) in _update_opp_table_clk. When
the clk for cpu device isn't ready, dt_cpufreq_probe should be deferred
and wait to be called again. But if we ignore the return error of
dev_pm_opp_of_cpumask_add_table, dt_cpufreq_probe will return -ENODEV
because dev_pm_opp_get_opp_count returns the count value as 0,
the cpufreq-dt driver will fail with the error log as below:

[    0.724069] cpu cpu0: OPP table can't be empty

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/cpufreq/cpufreq-dt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b1e1bdc63b01..f24359f47b1a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -255,10 +255,16 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 * before updating priv->cpus. Otherwise, we will end up creating
 	 * duplicate OPPs for the CPUs.
 	 *
-	 * OPPs might be populated at runtime, don't check for error here.
+	 * We need check the return value here, if it is non-zero, there is
+	 * need to go on.
 	 */
-	if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
-		priv->have_static_opps = true;
+	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
+	if (ret) {
+		dev_err(cpu_dev, "Failed to add OPP table for CPUs\n");
+		goto out;
+	}
+
+	priv->have_static_opps = true;
 
 	/*
 	 * The OPP table must be initialized, statically or dynamically, by this
-- 
2.25.1

