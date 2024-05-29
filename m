Return-Path: <linux-pm+bounces-8327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06A8D2B69
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350282818DE
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D13155A59;
	Wed, 29 May 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="tYcecG9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19011002.outbound.protection.outlook.com [52.103.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D44C80;
	Wed, 29 May 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952962; cv=fail; b=goZ/OfbOv21koyeXjSCM/lB/ijYeoWjAnuyu/y1lmt2qdqjSZ6YfB6mx55sHvutbCRWcm5hh3hegpNdFWQ3JlKbN20wBQO5nTJfN5U4Pcd1787KwStlUa473CkiQJDeXE3XRRFBhQYiLHanrSY2IuamiXFWf8ijkv+ac8DwgI9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952962; c=relaxed/simple;
	bh=/eiSB7dpx/ksJglusCWfLVr8xQ7W96zurI+rLvVH8QM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ik/QnK9GnAFBtfRgyXIrIDXZRNqXDm/DTNCrQzQz74vjdBinxXnOK+7H8i7tEmZ0z1keqxevLUPiGg9YrBf7FX9TqNh/yhfgyivK6L2Z/GaiWcs7bdNwfwRBHSVcy4DUBqdjsfzaOsOkTiuzh+wAnahk9T/qVNlu/Elq7c/HMvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=tYcecG9h; arc=fail smtp.client-ip=52.103.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOCF/yCscDpifqWFmJCLFmU1iw7uZFjFo+dxccsdt6jB6Pk4wl5Ow53U5VG3RU4WidruP+lShebXW5XWxJLQdcsgDyZHAirml3f8s0oIrogPlFuTOafz7Eshxw3xfRr8boi+HVoUDpyZgyTxm+3HZ1riV4FfQIRwUbxXsnyOlAo/F95Hp7m9i5U0iMC8xrpBo8X7J7n38I8lP78VaZg8KteObkl92TR6868vjyKtCvK49q3HFm042lUJZ74XZaDqIVzd836jtvazh2+b+6sI558hv+cKFwCeMT32nM5mVTeb7NWW5syyIQxEhcbpCUthMS1qULIcCYSKNtZ9wv+DmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUKUbmptrLgl0jXlXaLfAPpd0Yk4GTndZkJHs08xlqM=;
 b=JXWN6QMI6OUJUnfj6VEQYimsDqaLcpUYXtzBOnSUlPtIsoX4xE5hx2IAZyHrTA/Eb49f7L/D+C8cXVgUhntuQpeNv/pqnc9ucH+bgtTDhJ7Zn7i/dQHyJd8xXYFK2/GtU3wpptISNWMLwmnXWLsYwplV6kYruI4M0fLCDUdY19NOwkk3m1JIpEWqL2yhqdlRoGpgFfqtyowoTH55bT+5l4v1y0CHupDEcb6XPlfKxpx9MePFWXJrQ/BZjl5axhEoKiriJnm1iT3qvuIX1k4ZFDwdqHfgb0gTweKhEHEmDSXJLQSYmea7Rz5PYgFYU6WzkHciXuGIfi7Mx390T/yMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUKUbmptrLgl0jXlXaLfAPpd0Yk4GTndZkJHs08xlqM=;
 b=tYcecG9hP7HDrSX9cgPeXOyYD0iyrNCElQJkCHtjI6Bf8dSWwWx/TXa4aHFAQQ9c+r3E/e/5g7woGhBUmZDWTi7iNI6OrTb5EkB4y4c1ySbJcDF6zY87xg8KKaAWMdoB25g41RDsTweBHH1RJxUoAURInX8XCFu1of4BEuyvaTRKbxh2r43WGRNvfX7SdIxLzbFUXM8pZpGSVhpMlEyIaYhTB/Q+LchlDqsbjJNyFMZdiTIdpV5of+792i+NJTezVH98y3huxW2VZsT5XuMU4Y2825Lieh0x8z4+2Pl5RYDCVYY9r0V7PoImAzU5c+9vhjjY/1cxQURf4DFznbMwiA==
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:221::11)
 by TYCP286MB2896.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:303::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 03:22:37 +0000
Received: from TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19]) by TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8048:573b:c353:1c19%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 03:22:37 +0000
From: Riwen Lu <luriwen@hotmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] cpufreq/cppc: Take policy->cur into judge when set target
Date: Wed, 29 May 2024 11:22:26 +0800
Message-ID:
 <TYCP286MB24861BA890594C119892FB3DB1F22@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NgrwV2aTKXg81Ac9NU1J54HJlFES08Ss]
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:221::11)
X-Microsoft-Original-Message-ID:
 <20240529032226.2823829-1-luriwen@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2486:EE_|TYCP286MB2896:EE_
X-MS-Office365-Filtering-Correlation-Id: 881e153b-c299-4b22-224e-08dc7f8e96f4
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	ICke9GZ4Kkb9NpYX4Ks0J9j6HHqTuA9XPA6ny1xD/9v5CMZeGDMAm51aOb5RVFcVPDlH7qlP/DFnD+A3UFkl6vVJqzBoGjlybDU0zyOxChzPmh8IUF5OgQ3xL4uJXqhGCoBHao9SFpcoSkhBEkx/GC7fgGTUwTmtmWltUrWpWsa/NlybqlIqoF5oW7SITQ+30HUFgcedbTwtQyWdlUwFvNpBahF+Yre8sVxy+0qx9mYVPRdEZhVg1yVXyfG+6nXrm5QUd0/O66CrBSJR3Jsbzu+EGcf4R+WzhNcsmdGSpAN6OqM/LUAyPjh+VTv1Zpu1DOHanaOtBgBxXgt4/Iuz5lNuns+uQZ3+q7ZNMn/ua2Oiu7dyWcPrE5/GH1JV42vf36HVxgzFdJ1Ggg07jR7n1te40gIinL/khnX/X0ot2VoRYHYgZM1rw+RdaSKllzOc4Jlui3wc+DNNmAtJ62BbV6f7l++QbDQkVkw6VoKMNf0Gmm4N4C801XKt3mhKmOC98U56WnT4gKwjiHE+zGGqRwf34aGAnFp+tm4hXu2051zp5LcNow+CwThrRemU+yHu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dySRBaw6DADXZUpJd9uP9+9TpIek/kA1/aU7WHyT0YzSvHTTcPbpBP3z08q?=
 =?us-ascii?Q?Dbq1kmENo0NzvatyZL3Up5q7bt3SpH+LAHgqRfWWVAd7CMGJ5IemlfoCGLIf?=
 =?us-ascii?Q?eUeDNbx95aRXtOIJ8IDZBSgiS+DnSgxseOWCM/8TJJZ9gvNm0m/HJxrz1Zwy?=
 =?us-ascii?Q?EiI1v1AkurLCPCSGW5xeAD91pZruvMR8IG0VuJVnXMTLcoMnekT+1eYJMa5c?=
 =?us-ascii?Q?LaP86TlslNYZKR+0LVtjxUtn/ecN/AHIlwUilZ2U2aXeP5qYvBvEr8YOALZw?=
 =?us-ascii?Q?YXWzuort9fhl3nIupxiviiQ8Rf9F+w+ue2bYAbKJ8M0FsCnbUaTYwE5RWgH5?=
 =?us-ascii?Q?m/zuElTfYogvpUovWPKOGOhNs43Ym25Y1dnBhT73cli+x+wdaBSbDAyv5eZD?=
 =?us-ascii?Q?euzvT7VnCtzvY05P1dhooqhLfwfEIZ28hVAuvAUMJdZycK4nklMXXtQr+vXL?=
 =?us-ascii?Q?CJqH0WOBhqSGo0shKdoGXEQpscfgnPJhaGGHO2GcqxJdcfdkSyMk2aVg9Gdp?=
 =?us-ascii?Q?Diy4ONmaRfryfuTp5DlfuqFkWQEIRDVhWnYG1RYiL84GZWnxY5JicQ6BJY/V?=
 =?us-ascii?Q?1Ov8q5LIHycwB7hkqUJHTUxjzPp9FNl82Sx4ze8vCJJnZGdhmXR2BLT2KNvE?=
 =?us-ascii?Q?k1R3bLZYhLXUNCQK95MlPqNya4qPmjHbL4QBd+mHfgGfhe9B/48q39VWDAWO?=
 =?us-ascii?Q?1SYIRT2XP6ufaxFOHfmpOQ6ic33rfgu0d2PP/XHPOnAUn48CJ0NDLCbpZihl?=
 =?us-ascii?Q?fJhwF2Re5Tx/+g6z4WsYdHk30NgtXmRK8K9zPf6PuPloQHrV/hjXi4BCPBhU?=
 =?us-ascii?Q?s2gWNWXLATsw9RxNnp2GtYnsX27EO6IrRZ151whK65erNne0tSu8n9hIejke?=
 =?us-ascii?Q?LRJn4KAlSPcgQLhAG+UPPE1hr8RQKe1qpCOsdRc4p7Y0QYXbuJruJv+8aZ2m?=
 =?us-ascii?Q?Wkrnnt0IEAKhuoH8Pyb41tY0rThr5LBMg0LPdaPrwQYqIKpEZaDNet6nwR1r?=
 =?us-ascii?Q?bksb/MS54U26ffM7vT01dmMJWR/RtmLlQ04QOHCNhsPZwZ/x0Vmx1mqXslF/?=
 =?us-ascii?Q?8p5MX9CItwVAEHUpGlZEL5ciUe6yUYrJ8k1PYjC5p/d2pY9PwPky3XxKMYWO?=
 =?us-ascii?Q?X75hnW7HCDYAhGZcCckG0KyX20iJgtieh89SbzS6ISMkxwCz96fxM+oJv+4u?=
 =?us-ascii?Q?BLA9tXDcbBviIDZVivrjej7SZtf3DrYjvdOOmaIpPJlkdr/dqpJL8nzuo3k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 881e153b-c299-4b22-224e-08dc7f8e96f4
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 03:22:37.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2896

From: Riwen Lu <luriwen@kylinos.cn>

There is a case that desired_perf is exactly the same with the old perf,
but the actual current freq is not. Add a judgment condition to return
only when the three values are exactly the same.

This happened in S3 while the cpufreq governor is set to powersave.
During resume process, the CPU frequency is adjusted to the highest
perf. For the booting CPU, there's a warning that "CPU frequency out of
sync:", because the policy->cur is the lowest_perf while the actual
current frequency is the highest_perf that obtained via
cppc_cpufreq_get_rate(), then set policy->cur to highest_perf. The
governor->limits() intent to configure the CPU frequency to lowest_perf
and the governor->target() returned because the desired_perf is equal to
cpu->perf_ctrls.desired_perf leaving the actual current frequency and
policy->cur are remain the highest_perf. Add a judgement that if
policy->cur is the same with desired_perf to decide whther to return.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1 -> v2:
 - Update commit message and email.
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 15f1d41920a3..802f7c7c0ad8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,7 +296,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	/* Return if it is exactly the same perf */
-	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
+	if (desired_perf == cpu_data->perf_ctrls.desired_perf &&
+	    desired_perf == policy->cur)
 		return ret;
 
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
-- 
2.25.1


