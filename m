Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1534894C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 07:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhCYGnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 02:43:40 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:20288
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230051AbhCYGnN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Mar 2021 02:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo/pSTrDazjN3Pnfgr9IKyIZwsL/kf2mH4mlecFg0f+E0f7aHQBcR+jykKzZXunYMUEQ22ShlloaMaomjEGA8+oNutN1rpO25CV6ZoeFmOsruObClQMqlfCTuwwrsFONuD/K8QpIkxsWWo1o37cIAkY638UdJHXH645HXr7rHsxRLZKGg9JcFVkII/sYPM85A6HzjiJ2wBrSRiE4N21p+hH92cNJqgmMIGCLmXdK10nfGJHrSsMte+70higJmXGHuH73/xf7RGrJdxyqEekzjQGZ27txD10mcGXZRfWilpemwA7GlLnZkJHHByNVQnSfuFuxfWS9KJkWP6HhUD0+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txfTOB7/j+I/ATo0RI7aqFzoEQ4aiqk6NEVyW5a00IQ=;
 b=bVWZ3goQp5vg9oaRiXzqZZ6Sep16YRP7eLQfhTNjWiYR55d3CfRmSPN546sKXs8dldEhh2sF1nTo/aOiQuK4o9NjYg5vaqQpvA1VgRU/biwWS4ICs9lFJD5DN4ydttRewxAajgqU/HGcGWdp79ljLBhAT23FtsDVA0Sftas3KqPCQD0BgeXHYjFAr7tojLxLdvVDwdWAAwt15JqylPvqYCCwL6CwH0+IdM7EIKPU87WxcOb0mqgK8M0BBfiJ96590BR+ulU4npwBsUmTXBqHzS8TuOpRK4R5XXjDO9Fql1o34kSkWmvPWrJvP8h8+90raW3c4R7eCSdoXKAAGjyBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txfTOB7/j+I/ATo0RI7aqFzoEQ4aiqk6NEVyW5a00IQ=;
 b=APyMv9JVV1OEE5oFZUIgo69bW4ckALzlBKLVxkF1t5vgZBNyj10QyErkWpY1DdHWv50TiIgDDmE6ukyTpSRKGpoqewcjF8p6PSNZeJ9GthiWqZJ2cykffvPkUadwE5elpNyf/HOEUemTsFFh+XCpDxlxuHH/XRSuw04fMmJJQ3o=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1943.namprd11.prod.outlook.com (2603:10b6:903:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 06:43:11 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.025; Thu, 25 Mar 2021
 06:43:11 +0000
From:   quanyang.wang@windriver.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH] cpufreq: dt: check the -EPROBE_DEFER error returned by dev_pm_opp_of_cpumask_add_table
Date:   Thu, 25 Mar 2021 14:42:08 +0800
Message-Id: <20210325064208.2291413-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:33b::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Thu, 25 Mar 2021 06:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f54aca-b9e0-4410-15a6-08d8ef5941d0
X-MS-TrafficTypeDiagnostic: CY4PR11MB1943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB1943C9E32E0E5078677CC693F0629@CY4PR11MB1943.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXQox2PQh2seGHirZUkUZkscCgM52EUdQTbf2RydbIRSdcrS3uAZWCmqSVxrwfl5kXVkeSQgdiyKdpytznPhoODUtOG9JU1+TXUMdWyV43L4f6aYXL1BvHW7LmSPt5/EJ/Jlk26ECrG32xD1nENgDS/buyvsJzTF3QzP7mCcOHkA1wGm0jNUZ8pOjbB/pmC5fx2OwYEO4WUau9GnGSvAXSpR9TyGWLfS+R4lrWlaulSTVV2o15AgOQde14jhO5NLFZH3NdtKjJQUWGs56v0dVzZBka2+O0gYP46+dJDI+u2028ngPd4PJx9NXjZH2/aH/q2yP0zyhHar0tTUfNQcOXSimCwBVtpCCDIKE2rttEEzTwJDGqzPsew6njGldsIRKOQYikXsDaoLOF3AEoNMVyGlxf3TnVLbDUQTpaCk/BopujEr5NSYLv6hu6dlIOUReTwfggBie39qfy8DjejdJBKZBVnJwfnx0J86yXi9L9V+5nWp/DAUzBjg7nneFZla25tDptAA7UvzeSNmJ9fHhcWV9rxGcTxXhp9uJDLHnFrnWBbIjB8PqLt+DcF+qQdOdPcdWzlQxQo0qml/gwXmZQzHCqY+JlKgUgL/f1MMvZZuAE3H6Ii3MNxvFsSOqnEGEKrVli5//JtvWbidxfvkS4sWK/j7JBVl/qhUmngk4ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(16526019)(9686003)(956004)(2906002)(1076003)(2616005)(6506007)(107886003)(6512007)(6486002)(478600001)(86362001)(83380400001)(38100700001)(66946007)(8936002)(4326008)(52116002)(186003)(26005)(36756003)(66556008)(316002)(66476007)(8676002)(5660300002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VWLNCuqBcYABd7Czyjehaspdosi1mL9wn/iOkxRI+ndNyIviiuBe+kzgc+o4?=
 =?us-ascii?Q?jX6dixF5LvD+mdrB1lsPyLmBbRJ1NVUvChhVwo19dN2qXT9W3WLWFFPzUgcm?=
 =?us-ascii?Q?6hbOW6u8OFUkyaJWi33/a3NUzf7+k3LeNa7m9qvnljAVz0iOgkC81iD3OFHI?=
 =?us-ascii?Q?2H5se+KnNMpkjApuzROl46vZwn5k2rON3lcHb7hbjsYQt+jOxPq/EKwZtMHH?=
 =?us-ascii?Q?bIOKY020JlW4iHCfW5y8F6qE84fZk1P3WhJt2ywvdhH56sp10o5ygOXeKHK+?=
 =?us-ascii?Q?PZhzV5/0zRxKJv/KqJ0+lRjGni/M1k/c4x5jDoK9+XNnCjRKzMC0wq5QBLeP?=
 =?us-ascii?Q?QcTrppb3uplF0Zo9dvY3728tSoSC01AknazYX9RK91kEUW5YVZa2Kq7J3Ct6?=
 =?us-ascii?Q?1CyjEGc7TFgBXY0yeNEKcTEfrRJDRETtuyMq9ttF0kRnCGzh9K938vP5q2tz?=
 =?us-ascii?Q?V6AMyDzj7APe0OZYiSZ3ZYv2tSl1/poEXj8ixymLHxnNLme7XuBmC9zaZc4g?=
 =?us-ascii?Q?m2Yt12rp9JeICZeAvOh3v3C9SqiA3Eg2Q3daKgkwnXU5jXPpbM4Rbj8RUCmM?=
 =?us-ascii?Q?3HU6T2dW5cSy5/MktZtOaLCCltJhmlE/u+JwON5U8RZhGjMVm2gar4jDTXVo?=
 =?us-ascii?Q?hgs1lQ3pA3sOHC8JR73Ky+Tyb4PFPB76DqWZyeLVGGRSdlh8dWcj7+9nQd3e?=
 =?us-ascii?Q?/faM3En6m1xFezyf8Hr5IPJMnkPez2bWSmmggsgQxEYRZB9Gg7PwWiGBfZxu?=
 =?us-ascii?Q?bjlQa+yjU4PFsr/XEYmrmtDseDNh8AugO4lIncX1MKIkCsADZQuocYghKRie?=
 =?us-ascii?Q?XW+I5w6lfMwvpmC64UUJmTc8kpf3WTNizau5/GERXrhR+5jEyNmz5KKzsWZH?=
 =?us-ascii?Q?a0mOsxO4biaXJ5TJe1HIW27IHFV787S5BRQuckxFKd9jm01y82fNOmfRbYCS?=
 =?us-ascii?Q?JRjdKiynWmAaa4w7/Y6qg25DKfHkVpxLGtbLWaPbBVzqt08Fh4izru+rfY58?=
 =?us-ascii?Q?5sSxA6vxmmZwcVwsghtMB/o/z36wSY95BcEL7zm27R7NQG5nC/CEQRSI4wwv?=
 =?us-ascii?Q?T5PTRvC1Xju+L4TDMbIF3UWRETDc/LfJxEkc64i69uCgcWVTe0RTmyqqGB8h?=
 =?us-ascii?Q?p5c4DG4/SjEhcJTcCo+aSlv9a652Z+3Irr9RKT8lBR4ssKklqGVPJYHVh4yl?=
 =?us-ascii?Q?L64SayfSTbi0V0NcwXIayQU+1HSJa2+g9UK77t+SwJFGB3nBvxl6SYZ64XuX?=
 =?us-ascii?Q?3PXCqsJhfmrSP37nscif3Gy2/PueLQLks/YHVUtd4qM5zgQFj8I9WbahooDr?=
 =?us-ascii?Q?mEVMRXUJN5m5RM6/4NlLw6eC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f54aca-b9e0-4410-15a6-08d8ef5941d0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 06:43:11.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwAZxdhLtW+FsNB9PDkTNxeN7HnImqz/2l1Bb6jVrse+pARdQB/2PBy+vtHKSNIdAlqun3lhD2t+dnq+P+vFmByZ9/u8334ayu8vgskpjiU=
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

