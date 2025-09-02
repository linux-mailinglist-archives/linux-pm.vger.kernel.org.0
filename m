Return-Path: <linux-pm+bounces-33634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D2B3FE96
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01574E317C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53530C358;
	Tue,  2 Sep 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N5w2ustc"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109492FD1AD;
	Tue,  2 Sep 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813572; cv=fail; b=sg7WTK2+WgEs1Cyh/wHE47DFc/zBQaSdUIuAUIn2tgFA7XPaQQCTpQhDXgzWGZxF+MY8hJeoNU/yMzMrTLQ9PmMl941lbRncKETZB1PWNe78pfw8gmVa7b9Nh031N1PRb3P1mDYmEPvb1P2BtjyPvStUGrXG6d8w9bKI0OZpa+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813572; c=relaxed/simple;
	bh=CmCz1YOMyDWbbY6/mTkKwd1K5HIp/5NnkRa5u8l4Z2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pciKeyoGTPChWx2zLhhYqKd3opgvLplowpHDopGo83nsJkMwDx6WQTz4Un7xlNY28MJRx0GdwZzLv7lR9Svj0fBSbgtd9Hnrg18bEheyjfRgqGS56SDhQOHrt2MoCVA8ssWFa6vcMWLksHTehhQQJYZYKc/r6VvlHqjptGh7CvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N5w2ustc; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYpk5ERAq/SudeGztkkpwgC4dn05X/81vSlsmQHqd54zScW1rP9mpE092mFpmPx+11EzwPDi2dI1k36M9HUgttq4Vwn5MymUGQ0h9RF5CWp54TYd8APrkuqrxk/iSb1QObe/UGEsVz9oym6IDOWes/GWEM6RjjFR6Iix34Hv53O/8VHsd1V6XJUmVJHEEIWRBQOgbSOs3jC7xWbPSJLHSKU6L4/iPZHF/+S2QLMa3E0IoapJGhM7kIfTva9fr3x0IhvSr2JktHx3aihrv9582dainNMhT94i88dU3iuTRLAZNbwgl1Ktkc1GeijCbHptWx/uOBclINJ1HvNAdICsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Zs2kJB7CKbWQmWOEyBbxC/t7VLmDIayYf/eqN8BBg=;
 b=FkAeH9aClPSDIiSQdydlhBMxSWFuA5S42+dLSdndj/aZ/TcDbyrrBDOqSiNWisMtpgwoDlJhSl6bTYRIWtJ3lqyQ0iJjVQt5+ZunUcf0XTFSpky4cwnVgTSiLNDx7326obq94CWs7zwZrwY99pYfpD8GNVarUcSQNghuOX2wkUDfZQq/FS9eLB5+z+RRnS6uR2PsDqp9VIIQy8asgz/hIMWIw7Beg0Y3+NXF651ihwHfzwZDi7j55v5CG7C3/WfSXDbmUQHDhwrQwEevU2gWqCNktz3H54f30U6HWc5yU9ywiu2HI7EiDNO5etDEatpwtDEPXQeYxdBeqk3gv6/rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Zs2kJB7CKbWQmWOEyBbxC/t7VLmDIayYf/eqN8BBg=;
 b=N5w2ustcjml5rZzcveBzNG2LHiLImYgK7oiS3LFjMZCfqi3blF7W17drAJ7lxelk8fPziG8fyb1JgeFCPxa/t/EonXLiFHGpGse48epzuRgbnC//v6wkdX14Ze6NhSGrWsj5EOVRN0l4qEYEZ2UPe2ut+krNPwYe10bdNd7DViO2u854k37yC8JgKkEREVZgYBdMbBJa8aDcNWhC7zcSOhEaegoYCWdZss8iMNOqtS4aVUk3d6EWYDdUuV0aw4OHBqI/44SxOEMmSf+Q7VYAM4TFoz+KJXANgCCBFttiwyhSPmG3jbgqVmuPsFUQJJGuxeUqTfXK9T7LBCMFZdJfOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6256.apcprd06.prod.outlook.com (2603:1096:101:f2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 11:46:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:46:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v3 3/3] cpufreq: speedstep-lib: Use int type to store negative error codes
Date: Tue,  2 Sep 2025 19:45:44 +0800
Message-Id: <20250902114545.651661-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902114545.651661-1-rongqianfeng@vivo.com>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: d14c15f9-5bfb-406a-be08-08ddea164ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrYunDgoIswL3AzQsYS+V9NFfj5D1qfB1KZ944SlWWO3f6COcgto1cmF1ICy?=
 =?us-ascii?Q?B7z4+GT6jOGrDI6SgmapnO5ouzijET55BaIaGgjh4f67L1dWVgkoU60PJUo8?=
 =?us-ascii?Q?enlSkRcvdlLXEgYgPB/jaPg2C0BEy9Eb1XiFKYYYtLRePsZjgH00CHKO2h9Q?=
 =?us-ascii?Q?ZVp1k+N1bIKHcM3uBMsK6+MWComEkY1yEIvfUJidHsHXh3lsojsJfC0lcEAO?=
 =?us-ascii?Q?Atr2hIYgjaijOW6GUHyNjhDdx9Tv+7ODSzr2zCibTQQJmSLLWmgOcMCyT0q4?=
 =?us-ascii?Q?4K7k310aWPM4nbKIfMrTFTatc7EzfOUBuEIQ7ZHV0dkzeKxx6MNNzuB20WFZ?=
 =?us-ascii?Q?rPWtKjDa5fsxhCCnOp61vtjwgxjRSnsocuy8y7HgA0XIrCF+0W+Lhv8Vqr90?=
 =?us-ascii?Q?P6uRlWg3ZLwoan/HKVFcNpquAX0qPJLV+NVnOd2/D76p7jk6+aeLlfy3ZM9H?=
 =?us-ascii?Q?7W7aSol0un4XdWxmB4lm8MPGlCy52PyEXH3bCeQKgi0uuvh36anSXl2vUfPH?=
 =?us-ascii?Q?tzqrbkK0Fw+Wnxo4+a/Fb+Mo1lskctPPuW6o786mC5gZgpOnaDYPRM+bJhJQ?=
 =?us-ascii?Q?Yx1knrg1++iShW2qHmEmPUD9jW0gjHPGk4WyhprokvSvyOzSzvZNMn1UaoEb?=
 =?us-ascii?Q?fc+BYrbhe8jF92PyIwxCJxjqShsH4QF5t8K1TGO/l6chx5B8geU8XQG3NujU?=
 =?us-ascii?Q?6+KDzSQmjM7qHWN9yHx6NbecisQDT5zT3R8RYe9ud3fCZ+w+94ad/YkmwZbr?=
 =?us-ascii?Q?1OZPaL0PeUNIjthLcgedRmO8SLxXLhwpzDapuI/ZB6bE+W8dWorloTmcOCK9?=
 =?us-ascii?Q?LSBiceTc8KS4aG8QIl1K86dqIYTp+R4/jM6O84s0eu5AWbD/KIVz+7+ILwYg?=
 =?us-ascii?Q?c5gOiHTS6sgLZSTnUKODrTqme+D7mVWzEo6YuQTQGyCM+w9C9D7qHZNdQ9xk?=
 =?us-ascii?Q?PirXn3Rx+HIVqZI+KeqwmdHvomIfcGpVBi3pQAk5KXamT7bBnViaj7Y5lCSu?=
 =?us-ascii?Q?mMDTlrYTsAFJirEu7x5GNDLH4Nv2BULpunmWAemBc67Sdqa0rIw8X7ho59e9?=
 =?us-ascii?Q?9x2sNh/SkxUO+Xy60GXaxhlYsN5UWHh10WonLTRpzdCW3rnEqc61waIsUDlE?=
 =?us-ascii?Q?TXcImWUryoxUjZsuGLGl6nrVxD9Z337EMX8nCBy17ZfndTV3XrcWGo3l1VVA?=
 =?us-ascii?Q?ui6/WkBebMvV8XYfOATGrwD5djHQLlmhPWDxoFQU9Ukl8f/Sz6CDHeOSCsln?=
 =?us-ascii?Q?8HX5JnT+QeIV03xJ+fgTysAv4vzi3pcgUgixK2DoFfUs1DtpNTUqL9PVOkeB?=
 =?us-ascii?Q?alglX1XCSNjxpmAjVmAgLjALPWC9ft68VY7FynmEZ535BIdoPU3C3EQxU1jv?=
 =?us-ascii?Q?t8NREWNt0PW7X1pED4NoAivGbJKRzEbqAUt0f0sT1nrhT1RUVEX9VUhSbU0n?=
 =?us-ascii?Q?EjVpiwU7HaNJ9PLRLqduCya/0zTKjyfVIglvsjYjAmcyKyEMlB8oWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2r3+MWn6SpqIq0pccfJeQjvO/bAXl+5k9eo9va0afbnWdAszVGdquv/6p1O?=
 =?us-ascii?Q?RSCNM1VYZU52jk9BI9adLE4M9VhVBkPiBNLgmm+tXeyMVkoF4C+Vxy21tid+?=
 =?us-ascii?Q?iihTOySmz1woCErJVScgLbX39TcrpL2BwxonYfko4GFcoq2g2DcApVhw1Exz?=
 =?us-ascii?Q?oKuGQks6KFooOjr5nkmzO3Ir4H1lGnbVSdUyDqSwNBIIN9imRau7eioWwxWB?=
 =?us-ascii?Q?1LRKZQPrho8BxyR9RfYPYznAljbmnnzwPalfQR5Vh2JM+3DcsO36J6piV9+O?=
 =?us-ascii?Q?W3Yhc1/xx6T9G9GchtZPul/jXM01XurHDHnJHkxYDtQj7fytubaQ06u6xAx+?=
 =?us-ascii?Q?mHhOhV4c8wbIx+6JaQjPyCfBwqhFAfhcdjsPutnGcC4mtEtvPot5H1IVquHK?=
 =?us-ascii?Q?DUYGCWKrWrL0+OzwAlGDmtMgfFcYszxMCmwCldngSOAkCKrGLyvqZk54LO4s?=
 =?us-ascii?Q?cIPUW1bUmaJngYOkJkuaNLJTspw5Tid0Sz1qJcpANgBSvgQn7I+0aYsC56TW?=
 =?us-ascii?Q?oU3OMb9TH8oT4bg6DCRE9ffSzbJjLyGmgMUTUXWE/Z4bOwY51jJFHhH7OX6U?=
 =?us-ascii?Q?+Yjaw2ieZfXjkR5ohvbDwF0aMZ2+03zL1Fwo/Ng5e6dJjafpAcuBGW7S6TPk?=
 =?us-ascii?Q?mFGBMu+lLIgi8O2QwVtKB2rVZmIzDW46J+h645rzdF6i0eJoZt+5g4qpobOa?=
 =?us-ascii?Q?+wktTbIsARw+lh/WKpviF71O9Fntj5Wrx/h1iI5JsnwOdhhn1PyX1L6BAeMW?=
 =?us-ascii?Q?cDY3ORt+1pLKbwWB/WYDIsXRysGf+uAPAmyHH7BMqk4I094+wiXNp7K8rdlk?=
 =?us-ascii?Q?kTTmVbN3+I8YQoLem2oHqwWmXaHuI9URInb9oR3bbaT9eUbio1ogOX0xypyP?=
 =?us-ascii?Q?JObcEwjLPhAixSwL/S55vY2hmozbrKCqwrcMeKtCWc7OYsxV8b+JbVJaYG1r?=
 =?us-ascii?Q?WwFLyJ98eNOSuJPVSLlq2RItFncg7Tes5cfkNkRZO5LA0uPMYXmmJybmVAKJ?=
 =?us-ascii?Q?YYgZ89J65C4Dv2ZW/2GWx7TUSyRqbcEqzp1e4c71cH04w8rznNacSuaG4+Uy?=
 =?us-ascii?Q?T04wGw82JDpsKYUuXNtq8GZDovtFK3UpF+FOk1xbZgWvKYO4NbVNCaTbfNDD?=
 =?us-ascii?Q?b+bCiksgP+WRxw+O/jYCwbHBVT97tZVH/eorrpMVH6z/z/W05Q27ysAIqvSM?=
 =?us-ascii?Q?nltVVm63LDPxlur+ysvId01cuMtqoJ9YZPISfPNW/aolof0LUC7Fm/nUi25a?=
 =?us-ascii?Q?hONgFu13f3Wh6lOVIF+EdVvykQvozIgW5tWqnttckAnVLcJjKwm5fEoSwkNp?=
 =?us-ascii?Q?haD/qng4iX/FgrHFzzv/hFQVNmcx0CPNbYHe2R2fJSt00f8kvckj4JcTCeUU?=
 =?us-ascii?Q?yy2/VXIKyVEi2/1Gv7FOpRlvWng3PPWh6mPtE1Fmejm4sLFwP8CwZv9r1/Ni?=
 =?us-ascii?Q?3M1flwadCtNmN6M8tbbpzlHEJmSzSWV5PjbTzR5tX2UzMaPZgRGvgX8LT7wP?=
 =?us-ascii?Q?vIXUsAWnuFzKWQoPCeito+bpjeM+DRNNnWYdjSOIfeBHkpBgQWxW9R7Hacp+?=
 =?us-ascii?Q?K/4ix9CdZFrcQ6skUT2/2HzsimJxHzNMKPNXmvzH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c15f9-5bfb-406a-be08-08ddea164ac7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:46:02.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BrntdBi58DqWqi5IXUTy+HOI0pBEjnCwfUJFui0Ef5PPLOMMwBAlZkA+ve+M4sE+x5CNpAb2uE6OWKchXceVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6256

Change the return type of the speedstep_get_freqs() function from unsigned
int to int because it may return negative error codes.  For the same
reason, change the 'ret' variables to int type as well.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/cpufreq/speedstep-lib.c | 12 ++++++------
 drivers/cpufreq/speedstep-lib.h | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 0b66df4ed513..f8b42e981635 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -378,16 +378,16 @@ EXPORT_SYMBOL_GPL(speedstep_detect_processor);
  *                     DETECT SPEEDSTEP SPEEDS                       *
  *********************************************************************/
 
-unsigned int speedstep_get_freqs(enum speedstep_processor processor,
-				  unsigned int *low_speed,
-				  unsigned int *high_speed,
-				  unsigned int *transition_latency,
-				  void (*set_state) (unsigned int state))
+int speedstep_get_freqs(enum speedstep_processor processor,
+			unsigned int *low_speed,
+			unsigned int *high_speed,
+			unsigned int *transition_latency,
+			void (*set_state)(unsigned int state))
 {
 	unsigned int prev_speed;
-	unsigned int ret = 0;
 	unsigned long flags;
 	ktime_t tv1, tv2;
+	int ret = 0;
 
 	if ((!processor) || (!low_speed) || (!high_speed) || (!set_state))
 		return -EINVAL;
diff --git a/drivers/cpufreq/speedstep-lib.h b/drivers/cpufreq/speedstep-lib.h
index dc762ea786be..48329647d4c4 100644
--- a/drivers/cpufreq/speedstep-lib.h
+++ b/drivers/cpufreq/speedstep-lib.h
@@ -41,8 +41,8 @@ extern unsigned int speedstep_get_frequency(enum speedstep_processor processor);
  * SPEEDSTEP_LOW; the second argument is zero so that no
  * cpufreq_notify_transition calls are initiated.
  */
-extern unsigned int speedstep_get_freqs(enum speedstep_processor processor,
-	unsigned int *low_speed,
-	unsigned int *high_speed,
-	unsigned int *transition_latency,
-	void (*set_state) (unsigned int state));
+extern int speedstep_get_freqs(enum speedstep_processor processor,
+			       unsigned int *low_speed,
+			       unsigned int *high_speed,
+			       unsigned int *transition_latency,
+			       void (*set_state)(unsigned int state));
-- 
2.34.1


