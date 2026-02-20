Return-Path: <linux-pm+bounces-42959-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AhhFvvkmGn3NwMAu9opvQ
	(envelope-from <linux-pm+bounces-42959-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 23:49:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6816B51E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 23:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60AE7301DE0B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7DF30F552;
	Fri, 20 Feb 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nS7foOf8"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975419DF8D;
	Fri, 20 Feb 2026 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627768; cv=fail; b=LuddDAXCnLq6YnLzb04Lg5woChkdEoxz/fz674mj2tIgtrmT/oLaFODo9x4+SklpU1Pgr29qL3gWPJNxrvrf66OR+qMJdIKvCUoRVtz/VeBv8q38SKcnlBDA8rNd5DboionTLuj4pQRftwd51X4vTFXFsjEVqVgnysxDs1Ga8rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627768; c=relaxed/simple;
	bh=nACNI+rMDVS53dGswOc3yB2V0wC27j3hzdehaU48+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GdyDbnQjZIkLAY9cG+punxtWFRikOVYXoOZMbbGit4Je/vE+Kr7/OYt1JmO3jKF+H0moE97ylveV7DBNYLLNubT4D0L6j75A/Y9YqnNlwRxIEU9RGgxTFsjfmylaFKCndScNZi1bhNDmEC/iV7fo2lU/aw5vEYQ0WEyW5gx3mLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nS7foOf8; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4cTBoF1oQW3zc6i6wn+wesF+pE0iz296Km3aRQlOJFyXBQe0uKzMSB4SfLDsFh4uC1QSucv3O1xGbxoCvbs1qxVrzr2oZhk9GK6wOcJzq3GpP3xW5wcWRj1V6yQkQdVqeDCcAKCfjjd4t9H4KunS30JCpNKJ70F7QtJoo2W5YKXa0RwHa9LhpdpPIgAvYrUccHxNU+WBTppIkUrJD+kIv1XWqrgqPFqZR0QrhEeIUgcdFJ2qoOFznPHk2hhgNQMrQiOqpO+mQAr4Ztrc+C0z1MeOFpoofhlOKargO6WZSd4ETzUxX+4AHl4DFMfiaU/z4S3BBesn+X+23fxfzm9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2XSauwEXwRTcVHAjo4zGTZoxp6m10IO8d6u/6G6w+0=;
 b=Au4VPaD7/Paxw9zigzDL/x5XvUJKccgezMEuqVKUXjriHGlBNz6IdNvsEgHBVWKunMyaCTSmCCPKz7phr4nSbxJX4poUUun4vQOGDzX3op2qtgklp0Pksu9a4T8LuffTtdKybCirVHPBvIHUiYbMakZQ3tK3w5IzHWqzrVoEHMpvWNAw7dkJa3XMsXdSu1Ob68PtfabvONC4uakd3WsqoLwv9+qEgPxOo477DTVtpNfVZUSbVrpri2BnaWhwTsgML/69B/MsP3V3VPatvod1e+RVNVbf2Yh13MJSnAhGV2eTfAL7b93MoTTWOwrS1nDlRyh5hoqPGopeRVKn0Ur50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2XSauwEXwRTcVHAjo4zGTZoxp6m10IO8d6u/6G6w+0=;
 b=nS7foOf8LJYgse8hVgEy4Xl8Ml1a5sQbeLGdpfYUpEBgMab53ylxQ9mJv4eCxZSCcwtsPIjJhj7q9GMtK+j0VOGinhGGqbWY1gWT3vksSqexPndRroMaM17Lymk1J96yulXQylGITtfdbkfWZdoJc7yGaOm2S6izzgGgZcQhn/8J05y06GRzHyMOw8w3bqcjnOGORSQczNTwFomvJDb10L8ZzNO1Ry08YfWQdWKwZOL7pNeSf2r0fyvz4xX+2SBzB3WU3tJS54iA3AVsuRkvQR4PtMqaG4ihng9qx1FMurrklv+hngPhQZpJnH38+k6RDBVvAz/aVLTS2tBzV0KX6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Fri, 20 Feb
 2026 22:49:23 +0000
Received: from CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f]) by CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 22:49:23 +0000
From: Penghe Geng <pgeng@nvidia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Penghe Geng <pgeng@nvidia.com>
Subject: [PATCH] cpufreq: cppc: drop invariance when FIE is disabled
Date: Fri, 20 Feb 2026 17:49:20 -0500
Message-ID: <20260220224920.416602-1-pgeng@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::19) To CY3PR12MB9630.namprd12.prod.outlook.com
 (2603:10b6:930:101::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9630:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b95c20-e345-48cb-cee1-08de70d24aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODE3ChoiZdhpzxf53uvAq+PD+CQpBEw1DxtJ88kBMce76Rw97zOOO42CzrqU?=
 =?us-ascii?Q?6MmACm92jVfnordmsUOPS0DtrwhPo5TU7J3b+m0HvvDXEr7KvinuvMaqHQoV?=
 =?us-ascii?Q?NlCJd2lNgZMfwlj0OO+a/ci0SWWD88QQO8y9J4uehOC1ogt+R6uAbkw1YpDl?=
 =?us-ascii?Q?Gw91tfVoKf9rI61vbDyhKdMO8XU5jrzTxIHJkcAfMwqfrCnXzx9yoiXATK9U?=
 =?us-ascii?Q?v60kPxLsh8msYf3Mg9cgMIfPSUXCz5k3gAZmFGQISuen9gGKjGz5i8xUoBjB?=
 =?us-ascii?Q?2aHrJXjz9Xbc/nInWq+EO0VM2ipSikL6HTdC0e7CXWVQ9u31K4Ac296q+Mg+?=
 =?us-ascii?Q?MjGv1SzeGjAqcXj5YUIyKU4UkkOg0kwqKyUPoyVxaqGFYPE9PqQwEGsYhdV1?=
 =?us-ascii?Q?/Jz3ZFMk1+jQfnrreT6u7GhRdSb22vlOSdLPwnJcXSBrteFT7ktXwwIPcZbF?=
 =?us-ascii?Q?mWZVbgpQdWHmI+BFJuTvPrZU4+aPVJmihx35CxnRindM53rqwoPZ03yx6EN/?=
 =?us-ascii?Q?GoP5qeN0gBZYPCF3UtFpRFIHucMHKKzRKgO6sp2sK+znFawD4+2aelhIl/9J?=
 =?us-ascii?Q?LmZ8txhG+5yhAqaNl7IwpmyzkMbky2pRWZyHKFxdKzrnjHpSAJvvcAnK9XmV?=
 =?us-ascii?Q?EwU/iReqtR0T+IQedA09KykecCfo6LmhVOrPye89BokuksRLlHGJJa1YHFCh?=
 =?us-ascii?Q?RT7c9WiEyaL6NSddl50X5JUpCiwq5wItLe0JMC5k+u5Q1OAU/zhFYiDqaTHv?=
 =?us-ascii?Q?sYHsBXsa6orB9D4e00x2u3q9znmylrrJB2sFTF1NjLN2npbOtlua0TEUaURJ?=
 =?us-ascii?Q?D9bQo0m6ymwtor/klH3NuVAJvD1IqKe5kZIewK/DztLLTim6RZXRLLhIh7YF?=
 =?us-ascii?Q?ZGPoQCth8QnK8oxXLqskBc2vsQhJvHD7PNJGuSceCHqMxct6+J5/Q2br0CWE?=
 =?us-ascii?Q?wIRz2KK9xDAiAVB4Cxze3whevhyKFSxaXsCQRu+9YIHF7CtucNtuY8MSWvh6?=
 =?us-ascii?Q?bwPxnrK3ZAsUMIxSwpnucdgdbWqg8ofz3kn2sBwj35CdtI2N2Rn06CgOj8hP?=
 =?us-ascii?Q?pLo2n+9MZse3FO6RgXvxZzs4UQ4v4MpKniBDhbvM5kVMmac534f/4huiE0SO?=
 =?us-ascii?Q?4WUPzMUW8R6hNh4Ur368L3qnV9h/uA12qc7t9p2jVhAtaRekcbgiqf7WNJXF?=
 =?us-ascii?Q?rMBi8g002Xq4qm1ksAoLQ/BuZo1ytGtwxz573BQ2l0gsl3Gj3HtrUkGRWi+r?=
 =?us-ascii?Q?uAkhB18Ua0zs87MEpJDyw5i2YZ8A9Ed34YrLd5aYKrh9i20F3IzEK0EY6p0v?=
 =?us-ascii?Q?igPJfptATZZ+pZ2uTZcN/b3qvOXt4iMlA/tQxqbJg47k9QBPpwUYD/pEKndu?=
 =?us-ascii?Q?2MxTh0dpMGsc43Gz6JyHDiWPPTmZBrmFvGvaQwOs6WltjEO24j57eYR/28sY?=
 =?us-ascii?Q?Y7VItIRGSLYIh8T7nP2pF77HtThvgAFXYvuM06LNjMARK9vXjFczyfmDXImJ?=
 =?us-ascii?Q?fK/w5T08JEApT69EFxV56eAPRMqKoF89a6r4TT30ulL1AYjmWxt2B2I0Ajkb?=
 =?us-ascii?Q?5hxZrRmj6mb19v6mrtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVUDmVkqOYSzPMrPpp2o2LCgzWRz+q7MPczDDjcIh92vRETG9/EFx4lcLR1q?=
 =?us-ascii?Q?jUtLVlQbiF032YH88y4VI5pC/FCeRMSetestVzXgkT3Ipx4/DwUNcEP795Ge?=
 =?us-ascii?Q?BqVW1oV1Q+BDJTJJg5X0hEZ4HxV/o0JgiFN3/B58EsvFucFS3OT1aZz7/SxY?=
 =?us-ascii?Q?V3TKPkLPYvywP3hAoXk15Q+MZI6yZaKYvXZys+tLGs8brXzz8cw0YF6nPVFc?=
 =?us-ascii?Q?DigRkrzWG/tXwJpUqvGG6XTo5Lt7Ty9jMKTOFcUjFzqILLWOTKxtsLM7z6nX?=
 =?us-ascii?Q?HGrEFY0ZwpYBEKbaCGv2fsYicoDzWvqHW5lmfm8MR10VGB5AMQa2MzQyYrz5?=
 =?us-ascii?Q?MizDEAt8NLYADe638lzXXrttmv6Gl9dgdpMsTC9ustIq4lQ7Bm7B0UjVWnSx?=
 =?us-ascii?Q?KZyZvJyeGlkaVkEy6jLh1+6bU7/+fWUtMCuyMSKefQW3hHkY6LYVE/+GGy37?=
 =?us-ascii?Q?5ZGEblGhf5dzMd8HE82iTDust9m2tL4m2fE9YOpdjkWOBSUWjWS6RgBCv5bX?=
 =?us-ascii?Q?88TNkEPbCr10VL/2sJVqu/u+dUS1WxJzwH6RRuof13tEfpfN69jz6N5JsFrv?=
 =?us-ascii?Q?flUZaLS+7iWpfX+BT76UW2fDsonKf83ps3Xh1viy9H+lqIuhSoODDTYSpFHn?=
 =?us-ascii?Q?1oC4KoY3vgNwdsLvYtvnHABEWZDQWyBsPXkkZplEolzWixGEzTg/mvaz4MG9?=
 =?us-ascii?Q?4MmXgggGFTcaHkoVGu9pt6P5XZl7YZCHOkXuqzrpAM8u4LGYeCHK66Wwunbm?=
 =?us-ascii?Q?Tw2o2JGBczvbAzDmFBnF7rXQRg4ur5heWpxuXOVNASgsuJ7PyvRkpDA1Vg4U?=
 =?us-ascii?Q?jUrlI73y9OHmlOW3ThC5BzDXLmqgwGKuGB+TP8whalADHHgmtwJYRKJmCYxB?=
 =?us-ascii?Q?YezHlTrlEtHwiJQeuvA0KMTvAbc5T/rCBUHyALzKJ1t8nbazOKF1+t7q+YY4?=
 =?us-ascii?Q?70pp0zcLCizRGVgmEeiuVlIbcC9BikrlBMMMmJds5A4KxQR8IgRZotbmYVtt?=
 =?us-ascii?Q?thxOmuTNBSX6s1deYghrvt6miJER/7fosMjBBK4dCEwIRfMfwvOAkS89UZLy?=
 =?us-ascii?Q?0r7kmhMk4XieoJpKPEQc5pApzEPqBgpP3oTMpSm9jfLrJTy5FRYMlRuxAwGM?=
 =?us-ascii?Q?34hplHBt1BDo706v1CZlzcSxu+Xspe/poDs6SqsyveJ9+z4FNG8SCdI+tUlB?=
 =?us-ascii?Q?X2TfMsVLGy4XFNo50DE4ZY5tsOFwQNoWyWIbCO93U6F00MKkAkial48cJdn4?=
 =?us-ascii?Q?mm7z6abKaK6DX7ETFlb8BFvK2Ikno+J7e7o/7ycTs6mzjoUTbIx6nsPfwIBw?=
 =?us-ascii?Q?+l9SzCZ5fQwbgG3aThyIg53ll1r3hhIwymBzxhou+mHaKvFq7whKWSRhM9TQ?=
 =?us-ascii?Q?Yr2Z440P6FoNvYFNfet3ShQ3RI9WVWDGTo43thz5nyzaO2MBoqHqcLmKaaQ1?=
 =?us-ascii?Q?FQZoKUdenHPlU5mOMz3useDsE+D1LENwkYVTE6jWQz8WbxPXFVm4swrHzy46?=
 =?us-ascii?Q?iHvedo9AGPZ9YsW0F+Fxo7qcZZX3zt1PophPFJE9Ic01tuS7ARQlN0D6bCQm?=
 =?us-ascii?Q?T4sxx4MGDMQiPLNMOuNBrSP+sYk3FIgMygrd67E+dJPezWhUdWY/i5NVd6BI?=
 =?us-ascii?Q?BQauAYWHREcMRF+VcaTq3NCQVx9oUAOsTzWyQ0HQKWerSqhf7x6AdZcPl5vE?=
 =?us-ascii?Q?Mo/52Saz1GdvXs5dwtmprSwcIlxk0/PoqxYJVfWfJmA4qcee3RGdKQtKEYTm?=
 =?us-ascii?Q?Bfd3KIBLNw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b95c20-e345-48cb-cee1-08de70d24aad
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 22:49:23.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OyrdfEQabYeNcuZzamPqYNo/p4udyjy72u6tWSncCoV/LtdZbH9nrKNnQXSowObw/hijGEtRO2Xedcit0tjuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42959-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pgeng@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: AFA6816B51E
X-Rspamd-Action: no action

CONFIG_ACPI_CPPC_CPUFREQ_FIE gates CPPC counter-based frequency
invariance support. When FIE is disabled, the CPPC driver does not
register a frequency scale source, but cpufreq_register_driver() still
enables cpufreq_freq_invariance for target/fast-switch drivers.

Disable cpufreq frequency invariance after CPPC driver registration when
FIE is disabled. This avoids scheduler behavior mismatch when no
invariance updates are provided, which can cause major performance
regressions on sensitive platforms.

Export cpufreq_disable_freq_invariance() so modular cppc_cpufreq can call
it.

Fixes: 1eb5dde674f5 ("cpufreq: CPPC: Add support for frequency invariance")
Cc: stable@vger.kernel.org
Signed-off-by: Penghe Geng <pgeng@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 4 ++++
 drivers/cpufreq/cpufreq.c      | 8 ++++++++
 include/linux/cpufreq.h        | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e8042efedd1..ad96dfb731ab 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -952,6 +952,10 @@ static int __init cppc_cpufreq_init(void)
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
 		cppc_freq_invariance_exit();
+#ifndef CONFIG_ACPI_CPPC_CPUFREQ_FIE
+	else
+		cpufreq_disable_freq_invariance();
+#endif
 
 	return ret;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7a69f4d7675..4e79f704a8e7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -66,6 +66,14 @@ bool cpufreq_supports_freq_invariance(void)
 	return static_branch_likely(&cpufreq_freq_invariance);
 }
 
+void cpufreq_disable_freq_invariance(void)
+{
+	cpus_read_lock();
+	static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(cpufreq_disable_freq_invariance);
+
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cc894fc38971..698b8e044e89 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -249,6 +249,7 @@ void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
 bool cpufreq_supports_freq_invariance(void);
+void cpufreq_disable_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
@@ -280,6 +281,8 @@ static inline bool cpufreq_supports_freq_invariance(void)
 {
 	return false;
 }
+
+static inline void cpufreq_disable_freq_invariance(void) { }
 static inline void disable_cpufreq(void) { }
 static inline void cpufreq_update_limits(unsigned int cpu) { }
 static inline unsigned long cpufreq_get_pressure(int cpu)
-- 
2.43.0


