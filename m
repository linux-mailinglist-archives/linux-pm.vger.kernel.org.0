Return-Path: <linux-pm+bounces-43526-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBplDmFAp2kNgAAAu9opvQ
	(envelope-from <linux-pm+bounces-43526-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:11:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E41F6A85
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 21:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8675931208F7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D953A5E65;
	Tue,  3 Mar 2026 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lw2o7OJ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B74396575;
	Tue,  3 Mar 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568557; cv=fail; b=BP7r20r+874kXDRimeUHj3TTwa5fIKWPt1EpP0fweEbkr/DwjXJW1sMwsVoSmit5hY4iCEcC9W+c6F+Cn0g0DC9JAcsT4v8QOaONL7H5U5kXVVrCbfpmJv2ImEd6k5GOyp347t/xiMnW4MIXDczraNNADRf0wG6HhyBGCuZF1II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568557; c=relaxed/simple;
	bh=O3skWGv7SPT9OEftsOovcNTkKYkFCNVMLpniFIKuV/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxbxaJ9QjBqzzO43d0WNSOZ69Gu6UtqNx3NyOJeEzG9XzQSKs+UUe0K82x3k6GoguTNufdDagA/qW+ja45cWw9+3mjmX/0Anyg7oDLJbhaTenzi5r7uhVbcF/bQsuccgsGoXHAJYgLAId9KUCssBEOtXFO7FRaySbicsf1Sm/L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lw2o7OJ8; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukOExiw564ZmifRIW1zX07r43RCn6F28K2pWRv5Qznt0xm9ZhbecrkEBmFe73uGmVxlxYNLL/fKczvKw2rlhUtxeabsWTChwCfqkYHL0RKWm1bTOu1P8nWrs/gpcHWFx2ZOhzhRFDqoR/Upw+uSWJN1571VgdGXs9BVADnz/MhdCv+TYXQgZDeWMG96UAONAIW+4XGf8QtA3UkFAUXqzTxn/f6hpAeDVGOp/0+HJ2t7i8kuKS38gtmI7C9KHNhVVLQOEApprriWgzTOp7FlJpPqXGT4Ln4OgLbg/LjddblhugK20/+YownTzhztHYYBthK14lZ0yqNPXI8iv57cyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNqqN498IDW5eyfcUD1vMMmrinlWyRwOjiSQNUbO5d4=;
 b=woZwJYDccvBp0o5SmxZl7eDwgC9vAogNXcPM7lNZF9M3TWAE/q+gc+gMkJkOt15tfUBYZCfEaqu9T2qD4G1Ium6aq68fBWJBaJGavl6/NhnG6D+VLtZDdUGfUV6hSAEZJlWA2aSJSGnveS8CbLz+eVmoPlhScfVl3qK2Lv7MEEq1hIzYTZmvjsdDJkQKcp9dRjYrRjE9NFx2KX0qbQdxeEFBUWLnwxiau8aAm+Tu8eDiBKQ3lBPrfHetIkGMAMW5p4XYtTX5fHOaWWxK6o0t4HwhvnUfidT6l8U4cWpJrZxuTgvpZxAMc4UJWO0jmfRURC2qc6Yn9ay6T7vCMFdY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNqqN498IDW5eyfcUD1vMMmrinlWyRwOjiSQNUbO5d4=;
 b=lw2o7OJ8JNC3T4qn5EQNE9zdqZI4WvC6hH8K58SR1yWMt5kc6o95A3SLg3Cz1t3eHMUCHZsKnOPnZKzUf3WQFeK4xGeVOzsdboNvy06abJzfdejsPTKqSfqaRZTuEs6GQoDG/8OzY+ywP8d+NkmtY1af4aYPZ4BDir5WSksC4ytCFHHiHeFWIPc2Cfn5a0Sh1DDZXL/ncL/S7kb25shMbwz3YS0BLVpdALm6GC10JNQ7ppuE5Pccdd8KoXknNI83tFxmYvvDuD2YTt4ogHkYfBedVOB/jKOWeFL5Mu704j6jksmU9hbRh9I8efFMPAEy/aNgUMJT2NfDiUqqY7H+uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 20:08:51 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:08:51 +0000
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
Subject: [PATCH 2/5] thermal: intel: switch cpumask_get() to using cpumask_print_to_pagebuf()
Date: Tue,  3 Mar 2026 15:08:38 -0500
Message-ID: <20260303200842.124996-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303200842.124996-1-ynorov@nvidia.com>
References: <20260303200842.124996-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:408:e6::22) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 25863316-a59f-4fc1-b004-08de7960aefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014|921020;
X-Microsoft-Antispam-Message-Info:
	clNOo8hegF2DI1JTY2VGuCIe5yBGL5U0FL3YLYQ7tDICwlfyLNaZtpWJAvmntLYoU0eyPzBF0z7Wt7eb9L+7eHMWo3x1SuAODNFSwLfsurBiBfdmSLCfZABm55i5sLrg0cKMlbgxz/2VZD1G8j2ud8cUUtjnmPs/MLb2F8bCg4VeN3GRaycKj3sKxI8xgrSmn24e3sDXo7hkUN3GINDyVoSG0DjyIV05AFDIc/2/u6Iro6RNpMnm9IT5i8pqGxTCwTdQ5GlFkNvyK+15JCZmOm7GTMMYvIrEcDnfJCCgBFyzar1KTiMIRMhVM5/cFqIt3SjM10WluJVADzpdC6QGSfKePWDZYpEfHDZioJG/MH1NPVXElPKClSZD5Igm42asA8r6n4yYrqd6yTs0N7ZtM+lBXRDXAAz0Nm4xNKxrxa2ZJVvXvggZA40IwdKo/8i9dcqj0MxMl3DXzy62Vto+g999JMCTZUhGWBHUtScPp/9YXzet5t2J03LIR4DrRIqWkW4dh0K+hoSesr+FYqxJIKndDw+rWX+K8K+groNC0SDLLOJF/+EZPhox5jHwGEfmJPelbmz3vmlW3HJQkt5LniwzCG98uNL3dYLL3rxmM1QBIfksE9pEtQzPIGzpJo1NVbQpdH+3b7bRWBhRxzSWevwXSEJZDnPq/LR2zJw9/4g6NAWpA3d2TLQBLGRfvMjs4SWMIT2TZNnf/1lHlPW/AKQcrXAKXWMHkdJ2rq6CmoVgDfetJ5M0sgOMIQR8rZ1bY6agBKg0qvqGc+gKmmz9qQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SfqSAYUJZaJ3qgFuFbYq9gVkoAhDQnlxGIzisGkLlYNpkMDM/hurKD2NS+Ou?=
 =?us-ascii?Q?rJEAGkzFA81ssoBqD5trN9eJsH1MTO8czTRvuy3mJpr/GxdJeqsjZwUcV+IW?=
 =?us-ascii?Q?pY9w8w3pT9iJLIx4yF/k2Y7K5JIAsZaiRI9ylK7+EFuRrCdjdyphC4ShT0yA?=
 =?us-ascii?Q?QNluYsFvomK6FSQY7Yit8NXnvbVooAfbNPjo0aIec+rFeacFTGRsM169TNqC?=
 =?us-ascii?Q?fecXGI+S9wMlYIrNuGuJNYvsvyY2jM/3FRe+YVjxXTvyWDp0AVQ8jFL950TF?=
 =?us-ascii?Q?c3SAWZwJzh+VFB/9NfZGV1T5PBC1Lk3bwSO1IDoYIgl5T+205D/vhb0UMLzX?=
 =?us-ascii?Q?c2gQz9FNqod66/muvGT/J2nDBJLiwl4WKFVbC1ehJeCecdWWHcgzYtfU0iIu?=
 =?us-ascii?Q?ZBk01udhdfkyxGWtw1PQAHku/hubKYj64tF4b9TLUQp6Xm+AbrRqI3t/ImQo?=
 =?us-ascii?Q?q/iHJ7WHrA5Nzr3KR5JWEo/SkZlQIBIs2m9iTQxMgSeJhqnrpG+TzEo7D0Re?=
 =?us-ascii?Q?CQwwdl4ZpTGKxi14k2/d8Nlmonsz000Z3d+d/MXYapBc9MMCutnYVv9NM/Hr?=
 =?us-ascii?Q?TdCJWd37Q6VWysyBkZ5B11Q6C8pyhLHOtVFxaFkq04pzM4Kv311rDmjbGqmo?=
 =?us-ascii?Q?/mzdHATOJg+AVeCKqJRBvmHEXqgrmHHVOLUdweLA8eeYyDeNvQQDMllXMqNL?=
 =?us-ascii?Q?nZfqebvYubSF6MRYl+mWdUz63BYQFngSNOCO9qJ3UBqOqDfpcIGdlJrzfv7M?=
 =?us-ascii?Q?dQ9KPOHGI4a+QJ+ymbSucxjDeeES8UanZ2rBaQkTuGJSBGec+chXhT0CQYWq?=
 =?us-ascii?Q?VzfnJ44i0CXcQRVhaGU0a/UkH0A9Ny/tLy8ywHV+y8qDKM5h/YR2nLyW7FXf?=
 =?us-ascii?Q?T0CexWYtiJI61p1wHsvmeTk096uq4sRrDG/yye2H+UXU1RKkGS+dmde6Dpiy?=
 =?us-ascii?Q?s10RBb79rzN+GuAg0y310L/OJ1bSZ7JC4VVxk5XcoFI+ToK80zbqV/mhpMbD?=
 =?us-ascii?Q?Z53O2ms+k4A6WzpMWOwYmljAzrwyn03lpoiV0qnTot0U0IOcNY+Rw1eCCSf5?=
 =?us-ascii?Q?haGB1X8Urdxx616RGV40VFYk52+9OaErpVVJh+vN7tOOZxpAFX4TylPbmHJw?=
 =?us-ascii?Q?4S25dtFSHZtUjqhT4i010PWSiJKybxV5wHVFbpJIlTLsQYIT9CjoU+j5ul/z?=
 =?us-ascii?Q?coW+DD3kvvBzIEhA+L3ifGN9LboQp+/tPYon7B46sP2lM8IDOrtMlz25gdiJ?=
 =?us-ascii?Q?qGtTH838ThJBVC8Op3N/pYiIywv/WJoo7o0RuY6fH98rRk5uy0rWqx/hPxZO?=
 =?us-ascii?Q?oD3TYGvWP14r2ReIx4jTptdXQlYY13Exau15K0VsTGz/rvbAHnqyYodGQ76d?=
 =?us-ascii?Q?8xxCV9vPWMjK6pSuZqYfeP36I9Dz89DGxGWFNcFdw/KGd8fyOBx7vJQvXCQz?=
 =?us-ascii?Q?ofUivBfMbGL5jyVbbLio87yK/0WFSswJZ4/mSAZTcKCQsCN5LzGSfzKmBAC7?=
 =?us-ascii?Q?20cQKYArPay6yZq18Gy9OsIIFvTH88rnSDFrd3L+XOs8wgdhvhAmxEswIwp9?=
 =?us-ascii?Q?DhV8VGmhBQdpD8IVlOmbdps1QUCBJXplEMyRYg8V7gmbshT2olT7H7DIbufP?=
 =?us-ascii?Q?D7+yNvuWq/oWNIjxv7AYjZP504LBURjdSe0LE0jgAk/DYrDruvH+p6RvF+0W?=
 =?us-ascii?Q?PAO9drohwEPw6XasPQnuRiq/dxQZA1ba/dKvHO7B/0VQh1dXlD3ebuKkNOuT?=
 =?us-ascii?Q?cAfHnltO1mLbn+hfpov5jaZi9Mtk8aQVgvHk33hKht+bo/gNMEL3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25863316-a59f-4fc1-b004-08de7960aefd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:08:49.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRTT2x5TxX3dUtdXi2u8tOXW2KxRUzbBAgXs+tTQmt0GTX5Os2AcPuAApi85oiyyRcPVayf3XIau1yEPDgGESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
X-Rspamd-Queue-Id: B17E41F6A85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,infradead.org,linux.intel.com,linaro.org,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,linux.dev,redhat.com,weissschuh.net,intel.com,lists.linaro.org,lists.infradead.org,lists.ozlabs.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43526-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

The function opencodes cpumask_print_to_pagebuf() with more generic
bitmap_print_to_pagebuf(). Switch to using the proper API.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 9a4cec000910..ccf380da12f2 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -200,8 +200,7 @@ static int cpumask_get(char *buf, const struct kernel_param *kp)
 	if (!cpumask_available(idle_injection_cpu_mask))
 		return -ENODEV;
 
-	return bitmap_print_to_pagebuf(false, buf, cpumask_bits(idle_injection_cpu_mask),
-				       nr_cpumask_bits);
+	return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mask);
 }
 
 static const struct kernel_param_ops cpumask_ops = {
-- 
2.43.0


