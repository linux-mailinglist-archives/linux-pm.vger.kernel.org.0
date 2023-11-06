Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4757E2467
	for <lists+linux-pm@lfdr.de>; Mon,  6 Nov 2023 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjKFNVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Nov 2023 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjKFNV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2023 08:21:28 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2149.outbound.protection.outlook.com [40.92.63.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9001F94
        for <linux-pm@vger.kernel.org>; Mon,  6 Nov 2023 05:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZhKyOCvzGuicjCATXh0DAISkHzI0FQS6jH0BP5ki/lZVtW27vR+vvemdlWpCpTLSoKI7HN2JxNH+6CFibVNwYC4XGkn/TYbq8uicWxVHAoOZ6xjZefaaDWCDTVlTEOjThjRyjpSSGcONHB26ets76jvWsU6CM3E5/8mx9gBEgJ7Vtjea8yMsKZwGtPMfw02w7zjo61Y3nM8j4DFe2Wa8dbBnpqKpUf/Mf7y1Z20YQf3HUZs+fSrpTGRic5aOzOX8PnCCuK1WkLKBWlSxNMh+z3fkwN9ZeCZCZ3n87Hw9bk0Vvp03MXLeevnNO0QW+CT31W9/rd82zsEF7Th1By78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1waEGewgtpNloL5Ezoanp4kGnZMKF16AD9erxUPZONg=;
 b=gv5ukatwPEteNqvP/yZT5tbet2fAt+JchgkgAXkMG6RfhPAPwARZ2OnEGBReVVreOX7zs1DPb4zsJjpSnIvv8r6V22ewCpRxUGjpA+h2QcnEpr4HPwuY8OyC2edklB0T0t+kYitXWeG/xGFoRkfb92wQHmhhpM7P8RZfNHADXfSP1q12xKpi47J/RWujlz4CgTVqijiaxRvBr4eeOla2eKI/UeTkhhtWxu7hvK379fTAZWXT6j0618Y5+at2r9pL7X/PcxQI8K9mbJtFBw2s8D3qvFSnQlbIs1SvJHgNCotKSSG4d3ne64vBQdw018vS1DBC3F3kZ7+c65FK3gERIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1waEGewgtpNloL5Ezoanp4kGnZMKF16AD9erxUPZONg=;
 b=C9/SOYJqj6YqACoePyrEPNNnN9jT6jweOIvs3UUr42FK521TAHZg4gzHCXyVVsKXsCi/E9pQl7osNqtMKTNnNBn3ovx6igPUvvt9bO11pmrOle9EmPdyXLTyEyUgvvk4Wi2xAhNeZV4Ff7NJSrz6RL5jzNOh09UD1xxE/O5uzrBczuOV+iP60MvO8HQy6ecflstA/MCFL+6tBhG16TKWA+Vdny6SasQ6sac7aiXceScuCkXch97t5uqsi9PvmZyohtaf3tehmNrkaZgEpZjwa8sOxLRYczeWr5yyHFwtXJ/UJZBla/L2Z70ggafiPoAlwzTjXJR5/ulO56JESEIjOw==
Received: from SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:196::8) by
 SY5P282MB4313.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Mon, 6 Nov 2023 13:21:21 +0000
Received: from SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM
 ([fe80::836d:df8f:3c3c:cb20]) by SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM
 ([fe80::836d:df8f:3c3c:cb20%5]) with mapi id 15.20.6954.026; Mon, 6 Nov 2023
 13:21:21 +0000
From:   Moody Liu <mooodyhunter@outlook.com>
To:     linux-pm@vger.kernel.org, luoxueqin@kylinos.cn
Cc:     rafael.j.wysocki@intel.com, Moody Liu <mooodyhunter@outlook.com>
Subject: [PATCH] PM: tools: sleepgraph: fix a syntax error
Date:   Mon,  6 Nov 2023 13:21:04 +0000
Message-ID: <SY4P282MB3970167FBCAE2A104AFA02D4D3AAA@SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5A4uUqCicOo0+QNJbUXDnWPm48bPt+WR]
X-ClientProxiedBy: LO2P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::30) To SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:196::8)
X-Microsoft-Original-Message-ID: <20231106132104.34731-1-mooodyhunter@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3970:EE_|SY5P282MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 009cb6fc-deac-4b40-e9a6-08dbdecb43b1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BU6Q9wYYyJ3DBvoTXbrWjHw3m28HEw9ELTf00CM491gRXIbh2IxQixfR+r+PHwlhXQ9blXrVpFX5iWbBHHm86pAeyLxXKqnh5cJq0NPZ8WGioUD8B/WT8eqUgOts1uUj21KsrGTg2Av6J8VGCOVAIf86TwAOn+KxGbGGmngwKNS+9yx1S0FRIR3KY4mWWbXpyd3gwC2yfHgsFUaeQ+EFFBCTzqH6R2myfQlJNKyQpPcRZPQXvFFg0OvtM5lQd1kk8RURrWCABTkg2u7ZOK15ilh2gC/rn0nknpPaMBu+17ifjBNDdPV9E9RvauBYlK+WOorTQLL2tce4vaaW7BYDLj6agXfT73N+m8DpHQWv1LdzJDoTMiZYV9rBtL4WDWP8Mi/WGBYa6AFqOuyW8uRObuYAPsi6CVJACHY483Rsss/MHLUph1m79/pXW9qkq0L2OwBUKPrLIDLbylKMHqpT0cc1FIPOjJXYWplixmHtP8+/Id21kDYyhE9C2WS1MAV2ABMqoPNsJAjtoZxpaseeDdAcbnIy6ttHjsSyzBX10muVlGb+4gEeWGLG17jwxCqq/WUBd3kO0CsXDmVyeGIj7C4WyGLwqmu0TTePuPBCQEd5fzRbYYCWIj/J7iejVGSp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+ZhITJSyDoxMhAOdzcpwjwAzuA+W1TsIIQQEt8pPbc7xFJxd/u06Ub0lcqH?=
 =?us-ascii?Q?2cTInlb0a42fkvGVLA8A9egtRTWyOTJo7GKJvO99aIBnX1aCf5bjkmEy4rO+?=
 =?us-ascii?Q?knfbT9TFn+TIWw4YP6z0GC22ZLUzC2zInsKAiUVvT2fSjPjFAihFxbwg2Zwf?=
 =?us-ascii?Q?6rSQ0H6PMiCRInhiKOYLlTthwbbC0HOgfygU6orwJegIfI5dcliU7enwYh88?=
 =?us-ascii?Q?KHJrexYlzbRggV5y6pqWA3buu7//IawA7zw1CE4/NG8aAY7JNNflRDffNpKj?=
 =?us-ascii?Q?iKiQTYU203MZg2EdUBacSEQLxW9PnRkDo2312hdM/grTpBGrGREwuA5bQfW4?=
 =?us-ascii?Q?fO68Af6jvz6BN1XzzgY5ke0caEKhyo4SAuM9b8UwM9U9s+wRJwxQYyseALEy?=
 =?us-ascii?Q?pWimQ4Q8M4jkjXfqgvI56G+oGSh6sYJoBvrb43f5FZkx08/a7ljhqcDNQ6dC?=
 =?us-ascii?Q?jcKr5c+R3rRHs4kXRxjnvU4XnJ3DOQRYAcR4tJB0mdQtJk5WPbP0ekKgs+qC?=
 =?us-ascii?Q?nauEKFw4PHZI2F1K5WkjE25T/kMl8lK0VsxAfrtOT+NfmTvOdpX4HxB9zsyI?=
 =?us-ascii?Q?238gvqcnACtekF8ppuMg6QBMu78I1eI1QSczaFALr9a21K0ROkNNIW/P4OP8?=
 =?us-ascii?Q?Cj3ypzHCDMExJbQnUIToxDI60tV1La8LXMOCCqiz3n2TqyZyXyTpMO/7LcwJ?=
 =?us-ascii?Q?fLJd6mBxhDIQ6rC6F/mXrvSWp4kcDTDcAS+vI3pMkKkNWlWIbE+U9scYDsau?=
 =?us-ascii?Q?80maznTpurwYxhJhGuPf9SOd1rTtxl/o6+6IoDLXKRs5GnakDEYSiSAq2R11?=
 =?us-ascii?Q?kZICGFDl3m4JbSHAgk6JQFnttpG9/yHgKna3Gd1ZWICHPTbhN0ujMmb9POgD?=
 =?us-ascii?Q?auTaxZAGGbQzBfSt/DJzY7SmYuoKtBNu6CUCvQXOgGulawZSGgae+vPd3gmp?=
 =?us-ascii?Q?gmKnWtw6/ogdamve+AIgGZrtDkEgo3/YbvBGCqrLDXpGGKzwXJUPxfnQ5M8X?=
 =?us-ascii?Q?3SXqimrg88HZQ+4omNX6Fx0hxRM0g9eVDMbPg6rCo4mEVK5d5vBbXt3Gb/Xo?=
 =?us-ascii?Q?pvpysyxCavlYlp1iCZrZRiwJIcwRKLfiNsfQEF5izxkVTlWac3NduRVQLy9y?=
 =?us-ascii?Q?aguEDix3YSrkbSHzpxXfsNoP8l2L+JHF9KwVDYO2FMWWGETGx5gK//wRrGIF?=
 =?us-ascii?Q?VJ3J1iTBmwWPR0qyaz5rVGgw4GJLEKQbvCexQLLH0t8jf2YLQWsqq+B+MeM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009cb6fc-deac-4b40-e9a6-08dbdecb43b1
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3970.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 13:21:21.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

the elif statement has an extra close bracket ')'

Fixes: 34ea427e01ea ("PM: tools: sleepgraph: Recognize "CPU killed" messages")
Signed-off-by: Moody Liu <mooodyhunter@outlook.com>
---
 tools/power/pm-graph/sleepgraph.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 4a356a706785..40ad221e8881 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -4151,7 +4151,7 @@ def parseKernelLog(data):
 			elif(re.match('Enabling non-boot CPUs .*', msg)):
 				# start of first cpu resume
 				cpu_start = ktime
-			elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)) \
+			elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg) \
 				or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
 				# end of a cpu suspend, start of the next
 				m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
-- 
2.42.0

