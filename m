Return-Path: <linux-pm+bounces-14806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6B987083
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED11F1F2931B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872DE1ABED2;
	Thu, 26 Sep 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oe+Xvlit"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926E1ABECC;
	Thu, 26 Sep 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343747; cv=fail; b=QV9HfhtujkQ4EMEA4veowd1Mc5A1JUGmAF+k0wr7rMKwH5BO4Q/r7732QJQPHVaKkfBtHc4PyOv1H96g2q4T41zrRksEJEQBeb9hlP+KBa2C5BYKpNLJdbZJt2F3Ut1DxjuCnP0HyWsFX7hQFBL/USUewsn6Sv+nv9n2NWhK9Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343747; c=relaxed/simple;
	bh=ZyCl1GYDcE17d9h0cVO4xT4+xVjlNGuVgbmQsR8nZQY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JLhb/UoJX0JlPqY8KUaJTM5bQ7Rw6AjVVn7zTIe8k7f7i+0mslvF1QdkuolhXYbmexgN0FMdLMirNoB7ezm0NwsI/JJhkv62a5t/4xMJBm2LWxVFWKtWNohUT4jzAZlcJ/NPTio0byZOfxDRMIRHuwJfQPku7bkRXOPrSr0ZweQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oe+Xvlit; arc=fail smtp.client-ip=40.107.215.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/AfgAM6RhcMfXiy9KTGCWVerELV7Jmq9FAFvIGrSOZ3bQ8pQGk5G/gAGPj1mrNwlOvy+Tvoa09QkLTwLLZoZhFjHGV6i4FhnfiEK/3MhJEkxr+Jk4tWx1w6c0VGwOxfyVuShEP4uxh6d+7dSn39Ae4Ard5lTnsxu6oiVUuXDIgZXy9LETVjZk729bHy6op0dVlwOMXe/j6IE98KDlbdCpkCDFc6IdkF/SaB5Zpl/tkgd/P0SrBUHQRAoPXnvrCHmK5vs1HXMsGD3jPcE1N9HdylLFgy+xrMgizBHXWy33F3gKS7wRHYHw4dbtKx9IHQTOlMWE66ML98xlTEu0PayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dovsA9McYAkJVlTheMdL3rmxEPxOfeaDPSWLopvMEc=;
 b=sPCeUVV3IawRfDBBE5BlFPqLDFAHmhXw2YYel9xBHowrra4Y80gYF4L1Dj0ER2S7cqcZFD2bb/24DkDgBGyIWGMFKjxkcdNcGVcPF/Z/Mt/lZDKIf2akAnXIPWzO1YI1xe1JRDSNl177A7cRm7DQcZMiC6pBjgUEIskgoF2tB/dX+W2h4ye0i/wyyG4fBlP+S64pddlbejWUB1QcIE6LJhq+aoBm7vFNToiDiqjG7o1tP6yWGsHnAvvreLlMlPK4q3VI7jGsfAnpxBzZ3ufjibdmNQhSulfWGAH1jxkCucGUsyaMcwxQAtItMySnKgzXNcvp2XZzp1DeT9QRR7odkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dovsA9McYAkJVlTheMdL3rmxEPxOfeaDPSWLopvMEc=;
 b=oe+Xvlit610RjO0K4xeUErXA0Bv6UujTbOCFlGflIQud3kQx6WeXGT8kJQDTPVlmE3BqcH133iYD695iDQV0VbeljUpeQ0OHucQhdobhi10Ws+wDoDuuq/SJk4HgAs/14D6LJk9MZIS2IKkDYvakGSnE74I9yEhvySNb6xgN0JIb7KimHoLHdyb3uDMjZWxqP9Pqt9jJFZQ/2tC0qOe/96smmsiA9zjCZ0YVwH2Y8K4pCmqAWs6TAjqAuIOKLf7qX5xNjbpDMGxERKRJHBEn3snMm9BSiAc92SdsToP5r8O6TI3udNTtVIYLwAexaAKCoZ8N2PbVrAn94INSZv+aIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TYSPR06MB7259.apcprd06.prod.outlook.com (2603:1096:405:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:42:18 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 09:42:18 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: gregkh@linuxfoundation.org,
	johannes@sipsolutions.net,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	pavel@ucw.cz,
	len.brown@intel.com,
	broonie@kernel.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] drivers: base: Fix typo in the comment
Date: Thu, 26 Sep 2024 17:41:22 +0800
Message-Id: <20240926094122.3984018-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TYSPR06MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1842a108-e692-485d-4830-08dcde0f82db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ku9sqqrKy3Qt4X1NjaLZe6sMvQaZf3kVxVB9bmTkDRFfqW1oHB9dOiG1dhSi?=
 =?us-ascii?Q?pNMxxStekWXk/9w5+9oyIMTHDWSLFvnXE0n3kOydOO6cGDLhukOZpzI5GR6C?=
 =?us-ascii?Q?SRn7RPZOO5bVeAygU9Xnd8iIPPzRaXtAMzzltzNiaziGVuR3nxtOunbAK9YX?=
 =?us-ascii?Q?EBuSP16dwuwVLwl7YXIEKjc3gBSR/meX5Uz/Q/BeXpibfGhAxZX/ANQhg9w0?=
 =?us-ascii?Q?/Rs0yDu1F3LIem8Qh3HT3NLr1dth+koGlJ89QuLADBMI18KqPbA9iOvOIcbx?=
 =?us-ascii?Q?ZlhWM/G+lrUW8c0ic9WSZB8q+h/hMWs3zmd0fOXP6SSJnuZE2nKXonk/bVpZ?=
 =?us-ascii?Q?NOvhnhYkWP+1r53dw/Sj/z2uekRM8mIlMtAmvdFJXI7bcZvKPPFl1MKJ6l6m?=
 =?us-ascii?Q?lAXOlkbfVPFXIyQKhf/fIDQdVRQeW6x1bJPuBc3rxt2M1Dsu3U9/RM+gksZk?=
 =?us-ascii?Q?t+HlpGZLGUlm1boVqflE/fLuMTp/aiap/gUKYz1PSpAK4CIFO3V5G2uCZsGt?=
 =?us-ascii?Q?RT9qrCUpnc/NalDJLBt/XvoTdKqSZ5AkImUVpVsnMY7r0EZdmshuObf7dO6i?=
 =?us-ascii?Q?mHODpl5hc4/DUHruabP3n3NbJY4oM37b2ZWqnqmVXLPOhsSDPmecFTG2oLW0?=
 =?us-ascii?Q?MxRrHxbSTcI2fhSuF/iHzrHqdj0e61aR+lY9bS71rfaqauoJNl/S52/YXK0D?=
 =?us-ascii?Q?jtoGQ1/Zc8HNfQlC6D6QqK3gfnkHbSIWXVS8HuJCEJGlVQk0t1HqXfOuEX95?=
 =?us-ascii?Q?cYWjo5m7R4sZM/hC50MSgmSh1pkBRkdGGoca/Sgw2lGDB7eMlnqeu1OWH9mN?=
 =?us-ascii?Q?0/7fPlLLv2dIJVuffk7whGtCUeHbBC/LWhWHlMogwcb/Ylx+pRFPlY6EatSA?=
 =?us-ascii?Q?NML6FJ9Zk/XBUXdQJn99xIfJtfmbxOgT0D7MfekuiIEOSUxeursejpPjy3qX?=
 =?us-ascii?Q?q18LBNUmEpQWHa2DEuk+4Do0wi21RgsUmgHBKQP1Xch28vXyiiPoHqz95Gj4?=
 =?us-ascii?Q?4ubvgDoxWh+bPZtRzZYzO/6f0TbJHECbgLzXpyvbvWW0ASSGnZGJ1FbIrGh7?=
 =?us-ascii?Q?fJdcEP2wUumvIm3DoNrucpcR2cL/XzbrBzz1TalMoPldvk+oNK2AfkDs/f8X?=
 =?us-ascii?Q?mROU7frhawSS4SU/jSWzBj3qJxaszeCE1eGT9NIDE3BZl+kyC3dx1yzdpvnF?=
 =?us-ascii?Q?S0qG6V/gXu8OQ49HWey4Hi6GwjwItw3YwMv8BSxoJcD5uqGLslnhk7Xbqwi6?=
 =?us-ascii?Q?j74U5Bt3O+uvkUOrpmSA5gBu9lCba/4x9kYNh5KJoRRgseRnls5jLlTStfOo?=
 =?us-ascii?Q?rPthphT+CDF421k5ri33AoOkAWpvX/MyBM+YV1Y9yqdRlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuOpjO3QnKCKbK9GbXtap3VlW7d49CQZEKmghCEsVVTBGexZmVQaVZoDRo9m?=
 =?us-ascii?Q?4du+HeZeWjOkfd64HWXUU7SUqzC12upssv9pn+ra6Cfukftx5SVXU4yt/AxH?=
 =?us-ascii?Q?4sC6sSuC88hptVUW4oZISHRZPcaoXp5Muz6SU1ZrdfhTkdhRaH5/XgzhhDFb?=
 =?us-ascii?Q?WGG1LiTOqKW/ncnm6IdfA8Edsns+vEpSYEuj/Irc6RLqVGqyr0kN7J9K4oJ3?=
 =?us-ascii?Q?P6SiS4TT+ji9sv2J1qxCZKaFv7g+kklXdNUai/TL1zlqPOzRJpCpoXfCd+02?=
 =?us-ascii?Q?a1AhcLVlu+5kvAObDt1Def7Ct4eOayBRitFrsRfzGUYI9+cJqc3aOBUBNxNT?=
 =?us-ascii?Q?z4SwUbWi6ZBaRMLhOQmC7g1fGiicZko/cIGh4jZD5r6JttqA+sZYXA2pzc9A?=
 =?us-ascii?Q?YAbA7a1I37oL2tKcoOyCKKx6VraCYuP/WLVwPnx8jPE6mruMSKvEwJycfNUN?=
 =?us-ascii?Q?QZQL4H8mlgrMfeNEK2LvUInJTgrryWnz3iJDYlGPNjcVtJ9yqmcPDL5DiSxL?=
 =?us-ascii?Q?8HdR+qWtfwoXnikbSWEE5sdUl0gkc8Ke79oOIvPOxhh/T3BJNocFv6c4Qi+Y?=
 =?us-ascii?Q?bHAMLQXQ8m2gpA1iz+4ikLUG31GlC8hdHk4ELmZGOhWUbUM/qonrAlQMYLsF?=
 =?us-ascii?Q?YysitP/z9wtxrPhqbF/4uz+F0RxhjPg2Qh4OdJxmzYJVwry64ObJzBCiYa78?=
 =?us-ascii?Q?mmUk7OQFCrD1aARFg92mWB20tFHxhF8SMuhh7icfUVUpiycWBnFQO/PFb3Uo?=
 =?us-ascii?Q?LaxWjFqNFYBPonjBqam/XyaPJS4HwwUF1vqWY5+E2h7auqBhxVnNPTMs9QAC?=
 =?us-ascii?Q?5O+KGua5TLZxPYRHdkJX0sNJVMLSMvJF2WltcW9RCFcPJ/SEP+TD43dmgCCO?=
 =?us-ascii?Q?aNc7JAhHn8OEsCy3Hmgkwr00zh4Pe3x9D5lK2m9xFkzeN/ogm7ED+gLrSPto?=
 =?us-ascii?Q?dqC9ChwK6oMIuAcGLryIT+VZudirgnJLgn4pk5nh3l3jRGFhMXEa5pVHep0V?=
 =?us-ascii?Q?vNsC3umaoVrjViYPAXK/fho8L0QJhvTWIhC8d6fvvpG8pkHv8M8qTphVKAR0?=
 =?us-ascii?Q?ouhWCfiF8Ha29VBOTi4PAzFN4wqZI/5JaRUfMiw8Fox7NKzT85RiDBJ2pH0j?=
 =?us-ascii?Q?84bOtO0PJ8xY1MW5X5udYEeBw4vKASLWNZt0+A/EhfSlU5vdhKVDZXfT+ogo?=
 =?us-ascii?Q?4UEEq7tqUbjDuQfp1ym1VIrcQbY3WySDBeZ93BFyi4OclOB5SKapFwLkkwBr?=
 =?us-ascii?Q?UaKn5xwWw/AxfBJr0W9ENy2SA+y1r5C7cylt824bBOdII/YN71cxze+WO4aM?=
 =?us-ascii?Q?QZ3DDAXBAUunx6J3DnkndH9QeOLJHYivLH9CtMMFrr0BkfeIaZzjRAkzJi2v?=
 =?us-ascii?Q?+labpACU7NjHlEkcdbt/2muUTUzyHGOhtFnC39kRIUy0ka3PP81R3zTTlOwl?=
 =?us-ascii?Q?R9yr6rhNiF5zSayvVbPzHmEurik6MxRLessFF6sBnGFOYZnPZ9UM6wf7agLt?=
 =?us-ascii?Q?qL9HpMuJc9et10j3oGuZ5d4s4l+M7biPZrcWpcaq7HGiRowlJ1FuCCHHmY2r?=
 =?us-ascii?Q?sqhgnZn+zY3buvC5uIqKcIpbOYiD/K1vCz+SRYsp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842a108-e692-485d-4830-08dcde0f82db
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:42:18.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saSASMKbiIHPJftp1OSzDtjpZV2ixt6Hnb0QUIV2ZpwNMafyI33jdGhx70c5C/Vmimb7BRC7tjYnNaCotGXacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7259

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'aritrary' ==> 'arbitrary',
'numer' ==> 'number',
'busses' ==> 'buses',
'subystem' ==> 'subsystem',
'drvier' ==> 'driver',
'publically' ==> 'publicaly',
'parallely' ==> 'parallelly',
'recored' ==> 'recorded',
'sucessfully' ==> 'successfully',
'responsed' ==> 'respond',
'addess' ==> 'address',
'neccessarily' ==> 'necessarily',
'asynchrnous' ==> 'asynchronous',
'tranport' ==> 'transport'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/base/attribute_container.c    | 2 +-
 drivers/base/bus.c                    | 4 ++--
 drivers/base/core.c                   | 2 +-
 drivers/base/cpu.c                    | 2 +-
 drivers/base/devcoredump.c            | 2 +-
 drivers/base/firmware_loader/main.c   | 2 +-
 drivers/base/power/clock_ops.c        | 2 +-
 drivers/base/regmap/regmap-spi-avmm.c | 2 +-
 drivers/base/regmap/regmap-w1.c       | 6 +++---
 drivers/base/regmap/regmap.c          | 4 ++--
 drivers/base/transport_class.c        | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index b6f941a6ab69..d00c3d8d81d3 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  *
  * The basic idea here is to enable a device to be attached to an
- * aritrary numer of classes without having to allocate storage for them.
+ * arbitrary number of classes without having to allocate storage for them.
  * Instead, the contained classes select the devices they need to attach
  * to via a matching function.
  */
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..513183c3cab5 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -50,7 +50,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  *
  * The driver core internals needs to work on the subsys_private structure, not
  * the external struct bus_type pointer.  This function walks the list of
- * registered busses in the system and finds the matching one and returns the
+ * registered buses in the system and finds the matching one and returns the
  * internal struct subsys_private that relates to that bus.
  *
  * Note, the reference count of the return value is INCREMENTED if it is not
@@ -1288,7 +1288,7 @@ EXPORT_SYMBOL_GPL(subsys_system_register);
  * @groups: default attributes for the root device
  *
  * All 'virtual' subsystems have a /sys/devices/system/<name> root device
- * with the name of the subystem.  The root device can carry subsystem-wide
+ * with the name of the subsystem.  The root device can carry subsystem-wide
  * attributes.  All registered devices are below this single root device.
  * There's no restriction on device naming.  This is for kernel software
  * constructs which need sysfs interface.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..437444f2e064 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1408,7 +1408,7 @@ void device_links_driver_bound(struct device *dev)
 
 /**
  * __device_links_no_driver - Update links of a device without a driver.
- * @dev: Device without a drvier.
+ * @dev: Device without a driver.
  *
  * Delete all non-persistent links from this device to any suppliers.
  *
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fdaa24bb641a..97cdd0187da2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -325,7 +325,7 @@ static void cpu_device_release(struct device *dev)
 	 * This is an empty function to prevent the driver core from spitting a
 	 * warning at us.  Yes, I know this is directly opposite of what the
 	 * documentation for the driver core and kobjects say, and the author
-	 * of this code has already been publically ridiculed for doing
+	 * of this code has already been publicaly ridiculed for doing
 	 * something as foolish as this.  However, at this point in time, it is
 	 * the only way to handle the issue of statically allocated cpu
 	 * devices.  The different architectures will have their cpu device
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index c795edad1b96..3ff01847a6d7 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -186,7 +186,7 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
  *             mutex_lock(&devcd->mutex);
  *
  *
- * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * In the above diagram, It looks like disabled_store() would be racing with parallelly
  * running devcd_del() and result in memory abort while acquiring devcd->mutex which
  * is called after kfree of devcd memory  after dropping its last reference with
  * put_device(). However, this will not happens as fn(dev, data) runs
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 324a9a3c087a..1aa509756d3e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1528,7 +1528,7 @@ static void __device_uncache_fw_images(void)
  * device_cache_fw_images() - cache devices' firmware
  *
  * If one device called request_firmware or its nowait version
- * successfully before, the firmware names are recored into the
+ * successfully before, the firmware names are recorded into the
  * device's devres link list, so device_cache_fw_images can call
  * cache_firmware() to cache these firmwares for the device,
  * then the device driver can load its firmwares easily at
diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index e18ba676cdf6..36f4bc4cde41 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index d86a06cadcdb..67123e9db476 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -242,7 +242,7 @@ static int br_trans_tx_prepare(struct spi_avmm_bridge *br, bool is_read, u32 reg
  * before pad ...|7a|7c|00|10| |00|00|04|02| |4b|7d|5a|7b| |40|
  * after pad  ...|7a|7c|00|10| |00|00|04|02| |4b|7d|5a|4a| |4a|4a|7b|40|
  * Then if the slave will not get the entire packet before the tx phase is
- * over, it can't responsed to anything either.
+ * over, it can't respond to anything either.
  */
 static int br_pkt_phy_tx_prepare(struct spi_avmm_bridge *br)
 {
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index 29fd24f9c7ed..b0f39dd46c65 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -15,7 +15,7 @@
 #define W1_CMD_WRITE_DATA	0x6C
 
 /*
- * 1-Wire slaves registers with addess 8 bit and data 8 bit
+ * 1-Wire slaves registers with address 8 bit and data 8 bit
  */
 
 static int w1_reg_a8_v8_read(void *context, unsigned int reg, unsigned int *val)
@@ -63,7 +63,7 @@ static int w1_reg_a8_v8_write(void *context, unsigned int reg, unsigned int val)
 }
 
 /*
- * 1-Wire slaves registers with addess 8 bit and data 16 bit
+ * 1-Wire slaves registers with address 8 bit and data 16 bit
  */
 
 static int w1_reg_a8_v16_read(void *context, unsigned int reg,
@@ -115,7 +115,7 @@ static int w1_reg_a8_v16_write(void *context, unsigned int reg,
 }
 
 /*
- * 1-Wire slaves registers with addess 16 bit and data 16 bit
+ * 1-Wire slaves registers with address 16 bit and data 16 bit
  */
 
 static int w1_reg_a16_v16_read(void *context, unsigned int reg,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 9ed842d17642..79fc8e160215 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2442,7 +2442,7 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
 	unsigned int this_page = 0;
 	unsigned int page_change = 0;
 	/*
-	 * the set of registers are not neccessarily in order, but
+	 * the set of registers are not necessarily in order, but
 	 * since the order of write must be preserved this algorithm
 	 * chops the set each time the page changes. This also applies
 	 * if there is a delay required at any point in the sequence.
@@ -2683,7 +2683,7 @@ EXPORT_SYMBOL_GPL(regmap_multi_reg_write_bypassed);
  * If supported by the underlying bus the write will be scheduled
  * asynchronously, helping maximise I/O speed on higher speed buses
  * like SPI.  regmap_async_complete() can be called to ensure that all
- * asynchrnous writes have been completed.
+ * asynchronous writes have been completed.
  *
  * A value of zero will be returned on success, a negative errno will
  * be returned in error cases.
diff --git a/drivers/base/transport_class.c b/drivers/base/transport_class.c
index 09ee2a1e35bb..ba4ef4dd4779 100644
--- a/drivers/base/transport_class.c
+++ b/drivers/base/transport_class.c
@@ -7,7 +7,7 @@
  *
  * The basic idea here is to allow any "device controller" (which
  * would most often be a Host Bus Adapter to use the services of one
- * or more tranport classes for performing transport specific
+ * or more transport classes for performing transport specific
  * services.  Transport specific services are things that the generic
  * command layer doesn't want to know about (speed settings, line
  * condidtioning, etc), but which the user might be interested in.
-- 
2.34.1


