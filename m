Return-Path: <linux-pm+bounces-43528-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEDaH4tAp2kNgAAAu9opvQ
	(envelope-from <linux-pm+bounces-43528-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:11:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1935B1F6AAA
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A12315F21D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263F3BED7C;
	Tue,  3 Mar 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ive5/JXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D83B3BEC;
	Tue,  3 Mar 2026 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568560; cv=fail; b=hn3BGdlqtHXh9EuCrU5RCyE3t2p2N6X846ZuRi1MPISwxCzSn/WJFLcQhKERPzHkAjA56zTyN84NXbfFIo4BfAR4+zLmIpdN5VpKbXqll4EuDG8GLsZKwW7xIYWJ8mN14SKFwRTbKKyMZZ32XdtUsN2Qi2ugBR7Ff6POQ/c31IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568560; c=relaxed/simple;
	bh=1glAql7vKIJM7kgECxru00kvtA5YP9doTrmkQ4wLCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m04zYgZMRIFAnmj755WBucESC3cfoAL5nv+4nsx7uCTGUodACuspglBuTf141Qcq7A8+yBYSSGVIumaGVOgk0JMSGWJRBQcV736PhStKUIKeFpdz19sVJPRkvsLwKGFgtJlLm17COYehN2ilE4b1/kGu0Ts5M7kvzzp8bpkGpus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ive5/JXG; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCWa4qpKStD6U/c3cNHa9rdvISttuiv28fBTYhgn0ZyYN2PZVvgGNAiBlSQcp5QfnEr9kraglbZWVoJnw0v2H1QrW+KBXGrETuVobKYjyt99icF4dUSXtuE+UD5ZEZH+EVxUZ/aaF0jzoxf7nzUHzhqDif6vpfXTAJvzdtLZUEf7JHjhqucmWKNuC8Fdt3jHzQMzJN3z6OneoWbHH2qDMpcV9W5MEREFJSp5H3wvQgp0W2XfRf+ew6yTvm/ie2GJFpXjthvzPfSl2LK6IbBmJJlYquxVa9VVm7qlTy5GhUUVfJCYYmo+Uf9wQ6o59EYAzYTJVoLN3nfMiLJAGAK7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8BmDy0gTyR+JGXK54e1ppRP+kTpEMAoYKTdyk5aHfg=;
 b=tI24Pjir7NfQRv7IbBrPFnrPZ+zfri2G5FpQNEozVZJcBNJ+RLoGhO/vFw7ZEcIAzkv32eqYTrQ3SpOQT1mf+3tNwlLblJZPmA/brLYCBbaUo/ObDCu8r2d/Mse7/I0WVIqNzdMXuV8nVgzOTj60Ut3vx+zPChBYJSw63F9YhqPqfJeToDTO/4i/rSKwvEwx3ZAY6RF+tyP8DPJjv50Ap31p0n+rm3IaLC600ppInsrEseJVfjs0tIn2gw/qH804lA4X/I9+lX/vXPVJu8NDERxSJKbg1hydF9sRGTFDoebV3NxhRStAsqSb/fABP0i7WKh/YgS1yoWUK3rAIDfY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8BmDy0gTyR+JGXK54e1ppRP+kTpEMAoYKTdyk5aHfg=;
 b=Ive5/JXGVFpuyyFWa3B8ZML10WjtObH2k1ECR2QFrYSr1OySS5T/RN+Ac1Bbzm9TvKbvmUTFMqMXfVKkEinSCkLv+LoMOmn4xiXXv9Ph/Zy3h/VyF9AVJcYt8MgY5sD3EwKQxwERI3Vl+DLzaS7FR4dXYMIdoXQrHX47lcxLl1b/iVzsqWEqu32dmcZt4GjbGy6aAprTLPlFChiF+oSgUwwmyT41xfaNSXxV8NGx6fzFODIZOneMVPFXeNoLCvz0couJzj7zHMw6w2UBiqi97knIO2KT/G3zD3eByOslC9n4yIy4x6gsQeLVJ/pm+lYJOtJT8Ju/twfxkibOgm5NFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 20:08:55 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:08:55 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Norov <ynorov@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4/5] lib/prime_numbers: drop temporary buffer in dump_primes()
Date: Tue,  3 Mar 2026 15:08:40 -0500
Message-ID: <20260303200842.124996-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303200842.124996-1-ynorov@nvidia.com>
References: <20260303200842.124996-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:408:e4::9) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d4783e-4fe5-442a-f4c4-08de7960b1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014|921020;
X-Microsoft-Antispam-Message-Info:
	p3wwrkdz6bN6mFb41FwVPoA/09Q8XyAgzp7vH6QQRKQNDXNkM0ZiwwXkbDtLAF9D0lbjv2alXNx+rL+qdL+dcIJ3WU75iGGpb+jm+YHBNVS/CNKUElaQ8934II+1NyvsiQp3UAbCbtGzMVCaTqusnuYSgacG9CpnHsBZPMtRg7mVo9022gVHuB4tzEnTd87PkT2wX5rgEMHyq0dvS+lPyuwzB8HcvwmOxcaLpRksaCgYfNeuVhuyYLVKUg/M7fZ611uo8gUJctgLp+Zc4Jd9wt4BIkFPlILpbSQIndfUhLgImJHYwZeWWqRQ8bALaPlCNI0AbY0UELgaXRehkEw7qxpTe2OQDYuY3Bg6QfLAkIvUKqEEcZ3GWXjATmgYZihoC2Cdt4FZ3370jrpZJ3Oh6hMmi2YUhMAFANmMmfYe3HsNbtpm6SMn8RcxERhV8yNs3MhUF5itCYgnIauXJWsL6RS/7MWEH9kaI4+egTU9wp/hCNpyudXlp7+fTxxeQ5CjI1xHamEnuj74PmgUAzZARvnD3hxXUhBfCVndoWqf2MAk7rNErNqvtg3SPbdSBlzkD5bk24lalWW7f333/fgHTE5FSQL8LxqgyOKaXPPLLdBW+Ec8K2hOv/EKHBuqAd8LivPOSpyS6ne9dpS87KCjlotSsJBLN8cyH+1de0Vp882/+gCiLsSoxrGKo9w79O4vTxxwWN0asrcoSlPbttUaQmzqKieJmgytHASDvrB3xnu4qGmyjOvUi5H6OzpLbyl5dWpvAe5o/WGuCjFjJMG6Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1yxKtj+sCGuoWJk7f1Za1/Tns4FovxW8GxaHdXDYIRkzhysrsJjLTPKO+9y?=
 =?us-ascii?Q?yZyIyu7l2Yscg/DljHqpdFFm+HI5mSM7VYkFJWMEL2KmB1QGLrj31eQxVx0e?=
 =?us-ascii?Q?4ZwQi2WLEjA/PEbyXVW0IHRrqcZHV+YuoplQI+W5JHljVNOn58HUIbp+mDuG?=
 =?us-ascii?Q?RY8xKOjAEiXk2Bp2P+cBxtMR5f25OEbby0olvBCHPRNVx+lW6xZwkQaZmKWu?=
 =?us-ascii?Q?ibzgV/Up69ncn/CIYF7sl8ACj0r9o/VK3nECbA+YLlFKk54V9p3jUw93gXnN?=
 =?us-ascii?Q?cWA97ziX+qnEcth2z1bvLJDZUEOmiEFybE1w6yh3FSVfQSU37qsHnci2meRy?=
 =?us-ascii?Q?GR2OyqnRAmmHnZqWTcsRiL4yWA1iQgcl+8v8eEaWBti9pf6mhX9dS8y4IoQ1?=
 =?us-ascii?Q?2tTugoCeslDfFRmdY6gJaHywdyDkLpBiLy+jKULsSZrOgQz3SBxm7aIlZJR8?=
 =?us-ascii?Q?q5hD2dVHtAMRTjD9k3CLjv6R7d8J1+faEjF77icMrxEb05ezA+wwWhi/dZW8?=
 =?us-ascii?Q?LTb470w86B0NKROgjVyLepsMyHBYPcJF+TzWWdUY0hrW2G/Da/7ULCWRAKnJ?=
 =?us-ascii?Q?TvrY4yE/xHDwAVSzAeCb6nOUjpTexDzHbx49RSRieDlyAFXMy/AxNOqfTSMG?=
 =?us-ascii?Q?beMErfeSLgb+7eYKWjn4XnZ5QVsNKOt28ABCG+OiYP+DPzFPIyY6ENHXZDm4?=
 =?us-ascii?Q?/sAWXRR2jWozp9ZjqvSKNVWCHgeOvBZY+Dpqi1fPiTFFSW3bEpgYTJibB1/9?=
 =?us-ascii?Q?oAo4o2pca9YU3aUGk6SV8OHQK1Sn0Qi1BbDL6SjSC0hRBJZl23Ae2t/TBYlx?=
 =?us-ascii?Q?v8i6O8+R0Otpm6LUE+7LxMwrQn+/gYdmjjsfnAlPwC8Edxb2VUCA6Xyru7a9?=
 =?us-ascii?Q?MPJzmmoZe6/CKprr9DdtQMHEWWuMBaCaFJoL6HcaLKqWp5zDfFH2cso1RChk?=
 =?us-ascii?Q?uIUGZkOsBzJ+7cGkcfqRadnkoQ0ptcaKUhq0LCm4RQrXsNNrqFcX2LMLcESy?=
 =?us-ascii?Q?/uy+OU5vwR+ySXGT2XkA+RWYhwqMpQlqSsolp7Z/BsPu0LMBZLcPIbRZ3Wnn?=
 =?us-ascii?Q?aman/avHleib/X1gGYFklcyxvb9vaRbtcNDl/lcdS2Ys8qrGdFVXq47XqC3z?=
 =?us-ascii?Q?bhMSICQR0lJrsD9me2nMZ0O6yctN9x/BPRebDaTzaJY/engC7FehAcBgTK09?=
 =?us-ascii?Q?kHi88cfRM9yLzpS0gU72h4KUiGqQTDu+lfdLjahMn0z2bAUdYDmFXmElOIFL?=
 =?us-ascii?Q?hvqUWpSwth5NNHkgR6/fS3y9sM7GMLCT8hnplFNrho+Ch7lf/TIwXS/i/Tbd?=
 =?us-ascii?Q?2H7nmAbdppsT3yvu6k+RrM2UpLv5lRE6v7AU3M4sfXK52O7sMxbWvxghBylD?=
 =?us-ascii?Q?Sv+2fYoF4HPse60agQ0CODBbRWLEYW6fc4L4loj20qEgbTQR/7kvLpm/pLTd?=
 =?us-ascii?Q?42gwR330ZBXEISmCNAEX04JAOzubsJZnLgvPLKycWc97JBAxyRaeE/horzmH?=
 =?us-ascii?Q?te+DZV/AqlkRKeBkfzTdmfOgYE1fbQeLRyI6r/ETWiKwESBfkbhr0vUd5KJ8?=
 =?us-ascii?Q?JoYsmIOobrFlsNA41ZdcpzJhyxZckyKbCDO0vnp4edRcCYVXO3IIRVWKVH8h?=
 =?us-ascii?Q?xjb1lWXodbewdvE8eyduSj0mVbRzSIPtF/W5lY5rVl/znkxCHlEL6mAk3GXM?=
 =?us-ascii?Q?nE4x8LlHvyPKPQMV+jJPK8DfQ5ZNJtssxnSNsoWonHJ3XWMORC/GSYe6HbYC?=
 =?us-ascii?Q?80osS9sAmqUjrJXWx6UZ4PoupAcu1L+5IkXJESV7iq41NhWANPbf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d4783e-4fe5-442a-f4c4-08de7960b1ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:08:53.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hujDJTxm+lql4u22KrAyooWMMK7sqSIYdivhpUrDV+lrKkbD8gJSpbgd76/kD/tZ5uOGEUNt1KGZ8X4APhT1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
X-Rspamd-Queue-Id: 1935B1F6AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,infradead.org,linux.intel.com,linaro.org,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,linux.dev,redhat.com,weissschuh.net,intel.com,lists.linaro.org,lists.infradead.org,lists.ozlabs.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43528-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

The function uses temporary buffer to convert primes bitmap into
human readable format. Switch to using kunit_info("%*pbl")", and
drop the buffer.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/math/tests/prime_numbers_kunit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/math/tests/prime_numbers_kunit.c b/lib/math/tests/prime_numbers_kunit.c
index 2f1643208c66..55ac160c6dfa 100644
--- a/lib/math/tests/prime_numbers_kunit.c
+++ b/lib/math/tests/prime_numbers_kunit.c
@@ -8,12 +8,10 @@
 
 static void dump_primes(void *ctx, const struct primes *p)
 {
-	static char buf[PAGE_SIZE];
 	struct kunit_suite *suite = ctx;
 
-	bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
-	kunit_info(suite, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
-		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
+	kunit_info(suite, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %*pbl",
+		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], (int)p->sz, p->primes);
 }
 
 static void prime_numbers_test(struct kunit *test)
-- 
2.43.0


