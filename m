Return-Path: <linux-pm+bounces-43669-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHInMpVWqWkh5wAAu9opvQ
	(envelope-from <linux-pm+bounces-43669-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:10:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984320F738
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 841F2306341B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350537D102;
	Thu,  5 Mar 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GYU207FK"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7337CD40;
	Thu,  5 Mar 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704954; cv=fail; b=Ieiw2r5b2WfzkXJFZm1vP4U/cW0D0j20vqy/nSDw+nnLNgig6y1vEAfaUcjqnJ6/HKBVJqzOn3Bnu651NUSxMhboRSNaXDdO/BEGpitaxqS1mDIZMXWZ7E93YlDieQK6CTrokLAXzZ8rjP/QG+CYYQmj9h9uK8DNqMFSj66srD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704954; c=relaxed/simple;
	bh=MDBsyEtM8OlONxnNmxyHJU6z1qFmcveHZflsGaGUvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V2tKZLW+zw5AFHNghP4FivxeFqyf5XvVa0tQAoICZ3g46GgTJnqxlGGqi2JDsunbw6cMAHBZ9KZfAmQZRPt5KadgsxDVaMn56uPwmHjmVjsAY5VBusaHJuROqjSc/lTk9STgekGm1KjaMImIboHpEhPyL0BVARAUbU+Hk+D+Roc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GYU207FK; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgUi76d4zCuBOSCX4cZQVawoMFuoUWhSsDk3iLuGUunlMaYIr4ENIXFCXH+jjyQgHeQoInGYPj9RodOMI25vqvIBvLCQXxGOLPkDFyWOt260xIYJtuu28jQdoHIVsKjv9IW2xCbJVFZ9vaeKYp1c2gFO8eRrg7tya9uNzcxhH5Kbar8Rml8mcZXIUxkny9xXjnySy+ftS9y+x8q6uk2eJit1pJ75kud4zxmwwoVb6OId3cAFtEzw7gACB1RWPQ8eA+EJSbSDejfOOmPKq7pTBlVM3YxPPmTM+fnSqLHWUqF3/jm2MhZsXj5LMOWrNkZD+ISgoPYnUb3U4eS1fuqL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhLI8nUAaEAPVC5o5dn95EO8aPRidblJeZgYVfyjJEk=;
 b=gEh0zUJJ/dy1mP7Btol0xpkfR2n7+Cdvw1fcnVdVXtN+9C2YOWOw4Vphi6btj3T8VVLe1HR1FWpZtMGbVjGsjrJ6GwwBgWd0ZJnttgBbnk9XZWgXQF6k59bHBW6qGaUcyP40bKUJGKjAp/8uyJk7JGmBEtpj20ip0fmm41j62jKRSjH53M4cI3AKfgs6gg1uVcoabNmhmpkdJZCDLNAKLrrki76TyAEMr7RM0fDlMeTuFX7BnER92w0Dofs9WWITfOxZwwcQm/kc5ZWsgsqxvHw4oXUdV+AuVrBh9QARGN5SPbRX2sImGHiBPqaYBTyGeFz3SG9o0JqlpxK4spCahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhLI8nUAaEAPVC5o5dn95EO8aPRidblJeZgYVfyjJEk=;
 b=GYU207FKrZhSBTGDmOhpn0Kd4I8dqiEIPDabxMb4emjgpNytTV3p5xwRqWZDK60P9V3ppA6vv90QOM3v+dmMGMFMOQQ3dqRhSEZwEDhRMHDAd74VkYNjfqYCU/pl6CaxihagOFsxBbCRqlu00ULjB2nxIdSzUUxd0aa+hGjSo9EePkWew5K0sO/lAihJGePoEJwV6zu1TWmuKZvcezi3UFt6bbFUOikGn8itTIgGLZvz0pblb8uDRNTSu47SR0tT5nG1q31AOmyVr2C55IxOJJDMrn3i4g8olUloKN+YDJ3RAh11cAhHrEaPjysbX6DrCNJsT9USPoF+q+ZL4gPRRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:02:28 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 10:02:28 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	m.felsch@pengutronix.de,
	fra.schnyder@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: verisilicon: Fix kernel panic due to __initconst misuse
Date: Thu,  5 Mar 2026 18:01:48 +0800
Message-ID: <20260305100149.722-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: b3efc4fb-7e00-442c-d8a0-08de7a9e4eaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	8uuzn7jfqaoiBZn2InAnGq/UKEvCvPF+hlNyQsD8p/WRZTvpqJUaH+dQoo7ds+3ebYjoz4xDWZkKOiaQteMS/ZFt3uDSkto2GKe9D5UH2BPm920450iacQSenCWw6MSCq11+1r9+OhEmYKtHCphwctFdoyX2tKmjBNH6aLnlIh6gTqVt21EEpEsmBuTykbLxbQ+fSaZoPhikLg8LZWKlcbJt2oG0ZNt5Syv9Hq0vpbhwS5hPPnAMmoVGtjbpnb7ET4XTCl2p+/RJ1+ug6qqQP4Hw7on8dMn2KIdBImCKNh3gkjF6IymRmCVgNXxRwW/nNMrLkwMZPAcRU2zgxU9iwcoKLRZ3qwi5EMr1g4nrjedy5HVOtoh3YmS60R5MeOeTIIE9EoWU8miUmzRDMkvg4ATkbvfSsJm11QUS+XnOs2cFjTtDkRnZdRhv4Q11DXS3vFOgnRy9hWD/v5FmNCKLKC6EN0vBQCOxG9v6dOUzk9V36HwGIouZmJ8XmKRlR+Ex0iUW/IDAnN9a+4SypYDXlQzx9cAIv4g/pMGy8h5ScaqMb1RSitY8obOdG++N5OhazCLEAeRKcjl57PImMvQQi3qdxAmMd8xKGil0Ov4HsvseLBaGh962o5HKlRyKuLgsJ2QaXEHii0waZXPN91Ca95s4/z5FGx2f9Xn9WQzf+0i7HwIMDTqSzM1XwXaaLDS0pKGNl0b1p1iNrAWahxuDONkgccP6FY+oUq990/bSyWh+iZkDYFgoOQ/6PI3ZCY7rGbW+XT6g9rskubGHsIpPEu8CTavS0XVJIszsE3kthM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U+QVKa+j8T5XLIKEBOjO1c+sYSLRaNZThXsxG8j6XsCYeFKCB4iFroiwZbUT?=
 =?us-ascii?Q?CjSKqtbia+VjzXWLRitQOK3+79dboQpxhPE+wuJgGJ68WcwOy93LzXZCw3jM?=
 =?us-ascii?Q?T6TTHNwCuAOyCIwIAdaEjdhdNRPe/VBnimJtjlvqFz8OoilFTZ0Va1u9JB/o?=
 =?us-ascii?Q?gi1Sjd2m1nWkG4H36eN7ATnRaXeDGWWVBBFqjZruftIK0vB2waIfzWF40aA+?=
 =?us-ascii?Q?BXA0mvOkhmWogjwZGrWXfYagDVSOR0ff3wx6Qj73K4806XrHatuRsgS1qOgB?=
 =?us-ascii?Q?fCHAGpUR4e/UOfWLArHkuSLqYCAyCe9erT5rDfXAwCqWSGmB3YO5p7z4vb5W?=
 =?us-ascii?Q?ZXvUSjaFvh+7mQxou9B6o4NTD95W/BgSwGMeNN+rcodAdcel1rw1pGuElL9I?=
 =?us-ascii?Q?vIq2UVDGY9+xkSHQHsTq7LcfkRy9+XeeRg+3EFZQSJWU+VRxb2X5wAmnfG50?=
 =?us-ascii?Q?Hcw3lhQvtkUFmluEeXMUkO5bFvpuJcj+aLdCBocdb2aI9nerakck+tj3svwg?=
 =?us-ascii?Q?TEJocCTf72qmSGxFXYYwWut5RmOaZUksCcqpQ9J35CaNYU3P5Eoxny35jWBq?=
 =?us-ascii?Q?xKnPqaBDZGquIquUMiha7Xpn7pp8B0p4hQ3k49oChqgPQPyteJYUUnOJY01u?=
 =?us-ascii?Q?T/Ob18JHbqxpl3L2DcJ4EPo3gyuRg9PQ/p9pkBDxBuAZ118KJP3Ph5toNPzg?=
 =?us-ascii?Q?ebLqnJLyhokQ+P60F2MheTdTfLrRZ9x88ml9wcuswBRoAp/FZgMuylPKV7k+?=
 =?us-ascii?Q?LKZdaUyrim2cJDg+s56QLToNrz9ARg0yfjAQu5uDBGrAxygTiqYnsjSlo5lx?=
 =?us-ascii?Q?v6GyDuohOcNXQYf+fTI1//O+1MK1r4g17UX46QuwECJWxOTwvc4KDFYMKSJJ?=
 =?us-ascii?Q?Comlr1UVhsK6HajS4mzTLjO5ctRF+HqYd8qtiFmxIl4Iz1m4FSVWZKCjI7du?=
 =?us-ascii?Q?G/kjnIacoDbrhOLL8sQKCrKldKDW89VZSKS1qhTjUNEIu7JV4GBHfyDeAGri?=
 =?us-ascii?Q?MOVGyIQiDDRAOrwq18U+No2ic4uEaLvPl8ScRXFeipg76N3RlxGDNUs5LbVj?=
 =?us-ascii?Q?dLvxkNXOU5R0odfJ4QS22pTTSKXt3+0Ds8q3D6ESaoUspAKs3GwC+wnxa4JR?=
 =?us-ascii?Q?99EHyCqTCIvO5grixrqmqUtJaHKrasHAgrVBxB4zvb2bvt4B64pYTVdD22dk?=
 =?us-ascii?Q?f6jToxHFyZSHtCVHxUOn6Qyty/B1KekyNmLTS5B6aMrp5l33Kvgul12hliQB?=
 =?us-ascii?Q?/ZZBnhiAZGWO3Cil7GJxSaVHP8BIEQ7JEDuHXeTyayjq7QBnzgTdoHigti0w?=
 =?us-ascii?Q?Yjo8fPfKivDFmBWv/7UiuAu2LWJklbhT76s+ENfWH6gKTvwNHKRDLwPWkdCK?=
 =?us-ascii?Q?TAhsGJ7iSBNtP6XEbQLoy713W5hBvlL8FgCInqER0Z2zByZfXPh7IxzXCSXK?=
 =?us-ascii?Q?xDucB3EFrqjOO5rDX8TrDBdh8qLR7HD+0J3MwWma5N2+GfN5mcf4miI2gncT?=
 =?us-ascii?Q?KDE2vO+VXiPqkYgF+64QFm2FYdL8oIGlv80rZ6UXn4TCf4Ommj/w+6voPMK7?=
 =?us-ascii?Q?+MakKJANNkEUGlwOZWPXXDpt6Q6tiNAofqt/7x1knW1yiEqoj8H4SlHuwa0e?=
 =?us-ascii?Q?pac86EhhY4OdTw8c4d5W0va54Rd86HOU2DCmxh8I4jLjHwgBT94fxWD3Ka2D?=
 =?us-ascii?Q?r29xDq3aRJ19wkijqON0WXdtqIYFtm0tCXlne3e6UmKK8Wlt0YRYU7EXj21o?=
 =?us-ascii?Q?aLWYDNvG+g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3efc4fb-7e00-442c-d8a0-08de7a9e4eaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:02:28.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPMQCLI+E1Q5SMGH0+2vJlwoDMIQ3XPb/vmmCQL4WJnBOfvuvZjBhIwkYL1Y1sYXk1gu5qOuVFl4hvY663OPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128
X-Rspamd-Queue-Id: 8984320F738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43669-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,nxp.com:email,pengutronix.de:email,oss.nxp.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Action: no action

From: Ming Qian <ming.qian@oss.nxp.com>

Fix a kernel panic when probing the driver as a module:

  Unable to handle kernel paging request at virtual address
  ffffd9c18eb05000
  of_find_matching_node_and_match+0x5c/0x1a0
  hantro_probe+0x2f4/0x7d0 [hantro_vpu]

The imx8mq_vpu_shared_resources array is referenced by variant
structures through their shared_devices field. When built as a
module, __initconst causes this data to be freed after module
init, but it's later accessed during probe, causing a page fault.

The imx8mq_vpu_shared_resources is referenced from non-init code,
so keeping __initconst or __initconst_or_module here is wrong.

Drop the __initconst annotation and let it live in the normal .rodata
section.

Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
Closes: https://lore.kernel.org/all/n3qmcb62tepxltoskpf7ws6yiirc2so62ia23b42rj3wlmpl67@rvkbuirx7kkp/
Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v2
- Remove __initconst
- Add missing Reported-by tag
- Add missing Suggested-by tag
- Remove comments of sentinel to pass checkpatch.pl

 drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 6f8e43b7f157..6fbe3c581032 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -343,10 +343,10 @@ const struct hantro_variant imx8mq_vpu_variant = {
 	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
 };
 
-static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
+static const struct of_device_id imx8mq_vpu_shared_resources[] = {
 	{ .compatible = "nxp,imx8mq-vpu-g1", },
 	{ .compatible = "nxp,imx8mq-vpu-g2", },
-	{ /* sentinel */ }
+	{}
 };
 
 const struct hantro_variant imx8mq_vpu_g1_variant = {
-- 
2.52.0


