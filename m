Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D113C34894B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 07:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYGnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 02:43:40 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:20288
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230034AbhCYGnM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 02:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiyUsmx7caBlRNsgdJGHEDEA+dcBvtQ5EnsQKEV33fEeflQzNow6nzVWavJnuBHjsFlpw82rGWUnOzqDHFBVqMOfWhsBtDhzxuYDq3iQoeg6KkrLE/Q+RuglyWcIXN/yQoeyJLsWoR4m25jUFSkBB7BgrCAElQ0mRTBP21slecmJspL3BodLTK92vATV0GjNtLuyG+sjnGpekAvi0jBcZ6oskVYA4AaiI/rL8GBBjFo3amZVD/yTh+Cu4IL6n2vwiktz3DG50M1KP6qkMIlv8v+cpbPcNnEDddAYs5KphkYou+xQCmbfXs47JmtXs097TgyPEfSAZIYTaEWwMf28qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txfTOB7/j+I/ATo0RI7aqFzoEQ4aiqk6NEVyW5a00IQ=;
 b=D66W/ZXArF4NwoPTxslxdI0TYkcmbiqUMHphC69kzRb++HVa9NaFK3psF7Rj2xcPaIDsyi4Wil7bL/GdBklU5Mh1irYmrZaUq474o8e6ljy6QqTWMBafkHtFvPg9ZXv+uiWRASObWjNgVAS0L4QjwCAc7InnUVop2oPOLgVGCDIlyJHUn7e5ZbHdgxD6SNdbWpt1fxjolISepVOZo4LFmsKJbuwB3MaXuv4tS7+1yEYOqjqfB3ZOhTSyXPD8Odu2iNaz41UtvvMzsg4sKQjESxr4yJi909Jc7jj7v5dePwqkEFD/E7DGEcSTIBME9XXqs+67zMwgcSDwl5/WzvyZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txfTOB7/j+I/ATo0RI7aqFzoEQ4aiqk6NEVyW5a00IQ=;
 b=lXpGrP4O0gXVCahXrtbfI9AjXoRac6beXhBdwftrVmMTqmZ8xYEtZyKJ0gMu8qzsKzFXtjp8m9tbd35+7Yl1CcWy3iKvBYZfqbXOxydPxFImpgRhynSmMuGhZWYjn+mgFToTsHj51sp7v6RMa/ydO7PWsvyzcXnge6k3JZl7CMQ=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1943.namprd11.prod.outlook.com (2603:10b6:903:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 06:43:09 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Thu, 25 Mar 2021
 06:43:09 +0000
From:   quanyang.wang@windriver.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH] cpufreq: dt: check the -EPROBE_DEFER error returned by dev_pm_opp_of_cpumask_add_table
Date:   Thu, 25 Mar 2021 14:41:38 +0800
Message-Id: <20210325064138.2291316-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 06:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5116560b-3b1d-40ea-98bd-08d8ef592f34
X-MS-TrafficTypeDiagnostic: CY4PR11MB1943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1943C74AD802AFC8ABE462CDF0629@CY4PR11MB1943.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICF5gvuLOXb7at4C5YlZvo7MrioI/EGPscyWK3rbOtp3sJyGIGH26+XFdiDKYoZhUite5edxxM/aPkzRoc5NYQLlJZZYyoLRqvZ4S6uKb7jYUSdxrF9N/vOMmzXxOoRHwP53yVDnMC24iIEcfMwAFWCecTWBoscuz1iEsf7KDqNebeLWVCi5EYvV9WuaDatZhfKsYc57M5WXCHdpXhwkgWGUYLXBoH2L9MH5+lj4apLlkyLgJ2/Eh3sApKD1YqWlVyx8zi8pPFQrQ47TAm/MnYxNwKiiCSRYa2Ztr1xWxowy6Jzj+qrGeJHLJVGSID3Si8Yvnp/mnhDp1vpQoF2PayZLIQrdh0lQlEvwjp8oZJI7N7cwzY5WvYBRbMBHQD44WvXZjrIEkKxkCGWG047HYjU+wLed/XXYRieyVBJlL6T8MeuyaOCbfNSg+I8eGXUmJSyCDuEHqwII1/KSdGejEoWroM8q+MlzceNWK57ttGpScjNgziKBTQrg6k//Hl9hAlO0DTN0Am07qud975XqPdqBnWewgKLahYRDYqa5FIYyMwqGNWe87HmhPcLHmpYdK1ZFPgmunvfhN8zjzuu/Tuqu2uiAEJRs6+UplEzp1MGpcBytW7vjJRKOkfG4TrlCPIHA0kL2/MPIp7DTzUKrj3bGk4HuWBnqHYXA0dD2HG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(16526019)(9686003)(956004)(2906002)(1076003)(2616005)(6506007)(107886003)(6512007)(6486002)(478600001)(86362001)(83380400001)(38100700001)(66946007)(8936002)(4326008)(52116002)(186003)(26005)(36756003)(66556008)(316002)(66476007)(8676002)(5660300002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GiQf2mv9DBCyc/npkcJIZwrs1ThhY396vEK0ArLLC7gEcJBLWmiaGBUg9QnK?=
 =?us-ascii?Q?kpsE4pR6WPWhQmGpHXjldAUf2v2rVha+1aMl5M+MN3CWKVO9j5BtMWnnigdp?=
 =?us-ascii?Q?/jBJ/HWS3kPGhOdKGB7BDUonxz2nPAfbWimiyKVGdg2WfwsRqKwU5l7YhQ3m?=
 =?us-ascii?Q?+ys2sg/A7kupMsL3N/YKrhwk7XykEKx8iHhuvdABRf2TWglJEMIhAt1Qmr8D?=
 =?us-ascii?Q?ERlWv3mjg4lIVZXOOwlmH1AorQbGBFdvTrpBf3C00dUH9YaKh2RX+wSLD0dL?=
 =?us-ascii?Q?4R/ChBGbCrOYRZvo/GBa1bceLSfjCTBnB4+8hfpLmeILm4Fx2iUn0kyAKzi2?=
 =?us-ascii?Q?8aXd04RsMVsuTmo1/JgIVrDRMhLQ4jLRhdhXiYbs0QS9AYRlHIcdITK9xFXI?=
 =?us-ascii?Q?GcHc3Wol61m93nTUE5auPcdSGbs6zFnHLdcIRwm9gGYMp1gHF9zlGv5Tty5E?=
 =?us-ascii?Q?zzn5My4ZIcREkyCtbtR/2Fi1nwa3laJDytYIduGpNBcAuzaQoY3B5tQqEbZf?=
 =?us-ascii?Q?kWBzOuLagKnGdkYtlfMOwXB6CMgQ1WVUFlpsedU5e6jHlMoQ/7ISSfu32bs0?=
 =?us-ascii?Q?VgY8h+PrdRlRqXYG1zN8YLg7BFnQJaBxLT+rYkb2uy10Pq+qU2BAebpLHyP3?=
 =?us-ascii?Q?Xk4I5TyD9871VDs34QywJgHEXDUNBZMjqCPCr2HVdfi8mYOi+NPj8vClCldh?=
 =?us-ascii?Q?bgfNQoilB1v53WQg/9/Gn4tPqlqUlaSI3p2POBXw0y9ra3FTI8nUAT/R+H4c?=
 =?us-ascii?Q?5rv0VElKMaDCRG8UqQXoxa07DIHc4as3tLpS3/cAjfxStYT6brtyHGHPG3J/?=
 =?us-ascii?Q?30zCKRy9/qLRe9aHfWd8KoiBzxlLbfvFc5APb3fELj7Du+jYo2yCfvUXzM7K?=
 =?us-ascii?Q?CwLvFD2kkNADK6nHc3nC5L2kt2UjIbrS2C0LGim7hPx7BJ2WefyCwtvbBjsu?=
 =?us-ascii?Q?t2PMYopgf4gU7LRFUeR435fWE7xppxARaE1qA+BA5mYyUbckcbbT+Ov1xWjB?=
 =?us-ascii?Q?xyTVvcly6TZlDBe6qgjOppoX7fj7/rke6zNvhWb33xzWjzBqm2G13WNVmf+U?=
 =?us-ascii?Q?gE47Up9x/Lps+WAugTbS3DTzX05Ykiuf23QUBN6s5x7dcxkKMmmxHKCgf5vE?=
 =?us-ascii?Q?VHAfEUxjRkYmr7G/5eho8fvplzwP28ciQlsCeY6cpE4qcHGaE22nwX0xfHs8?=
 =?us-ascii?Q?3Z571tUTi9D01HlqxXCQMOHAZTYcaSVa8s8A1NUXfMgxN4iUHvhi7k+INyZE?=
 =?us-ascii?Q?YoeGvPR8mwctcWYAQ7WPOcyJf+KPvoPgVXYkQ+XWNGZocHOPKqTyrNFkLeRW?=
 =?us-ascii?Q?4KjLqjeaD/mtpkrPa08OOvh5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116560b-3b1d-40ea-98bd-08d8ef592f34
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 06:43:09.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7OlqjkfLCKvuCx+frO5Nca9u0vg2LSr4aFxsXN2+hXio22RLOYtHd2qiGATBOyiVM6S3A1VqWdqSn18Rjy3bHKo1aB9jDUAngM72eUVQSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1943
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function dev_pm_opp_of_cpumask_add_table may return -EPROBE_DEFER
which comes from clk_get(dev, NULL) in _update_opp_table_clk. Ignoring
this error and call the next function  dev_pm_opp_of_cpumask_add_table
may cause dt_cpufreq_probe return -ENODEV instead of -EPROBE_DEFER.
And this will result cpufreq-dt driver probe failure.

Add check condition to fix this issue.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index b1e1bdc63b01..25e46df92941 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -257,7 +257,12 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	 *
 	 * OPPs might be populated at runtime, don't check for error here.
 	 */
-	if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
+	ret = dev_pm_opp_of_cpumask_add_table(priv->cpus);
+	if (ret) {
+		/* Return the -EPROBE_DEFER error to trigger the deferred probe. */
+		if (ret == -EPROBE_DEFER)
+			goto out;
+	} else
 		priv->have_static_opps = true;
 
 	/*
-- 
2.25.1

