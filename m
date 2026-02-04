Return-Path: <linux-pm+bounces-42093-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKxrArFyg2mFmwMAu9opvQ
	(envelope-from <linux-pm+bounces-42093-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:24:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137FEA299
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E17003029F9A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4C421A11;
	Wed,  4 Feb 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9YlSWIa"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C532DCC01;
	Wed,  4 Feb 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220494; cv=fail; b=bUHH5rdx4d1Y5jJ8uMgXJKgRDI0muTteK3iS1xVuMD6kpxgOZ7j4fzf6VrC8fzjEykp5Cij1dvPLZFOEYrgymfblMjSPt9RLfKitD3JvhgGLWeEYdIYaj13fQSyi5EAkg/r3u/U+KvanTDZ8CsSdmdnR4/g0lEwBzO/oH+2hHf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220494; c=relaxed/simple;
	bh=YPddosqqrQRRpjdmse9nST1OGqP9cQFDmzstjaLu52Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nB4I2f+3rXcHIbz23/841hnXIX7JWzuw/VH5SVJwRZyeuGGyHbHBuJSLxkR3Ukn0nhGHedN6gwLMqL11+RZtxv7GOo/yjQvYw0kQ9HZgU+zlpK0VRp2TkmB2PQP1PaCsGA/tqN0oSULkpBwne2SJ9zZmw4M3606ji8xyADGGVEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K9YlSWIa; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHAGG5qO+DdM6rU2osp8/u1NVUDbPOGviI9SSOtk7W5oO9GdtXj8tc+SINYAz/M50XchYef2wwr+ro0hmB+/MW7raWj9pQ/4Sv/BZ/zta21V5Lyq+LiLreY+peAHQMlKWOeDE1KXWCt9kdN1MvaH2xTjuh8XDUGmFgEpSDylksSrGZMpDDr42YDQsPPCUmnPLny/WyndLvTqOHojWqrWWnWkvbuusPZRtv7GrvD23o0l0zMeFdeXaEwrntrdTr1xMTZfLXSKiMHr7OAUsqcCGP7pHIIz4zvm15jtV9oSdj8Jt44OMJUv7dlSQnTXazZfFUFeG5yhPKFFRVddAZ+WFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ACZM9pJjEULJH8BjvXqSTBvgujr16E67w/nWf4Ja7I=;
 b=kAKIE/YiiKYQeAqfk5l9dIB6H/UVLaw4ZJLoSHkgHAVRy5ENOpxEItddF07XkVv2CSR/08FQ4dCTidCspvYjZYnVAXhnS16V0ihEKzNp1CHg/cMNZ3ihCADw5VgozBGpN1OyiLI5nFi6LSwWtgVV+tHJkc4WP19BIf906wocxN2e/DGOR8ITq6vM6UHChPPdffLVWXTUJwrIhIyGnAV7uTn72eoj+MXPtmYTP8VOMtTVYTzh3iGwLSRwru5QAuqKryNNNVFuWPKo0LK1yVBbbqvl0y2UMxv8LCv3cQjHNzPsr5vnIQFohsOYyn/q6A/gVk7NlTjf002BBy/72QOU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ACZM9pJjEULJH8BjvXqSTBvgujr16E67w/nWf4Ja7I=;
 b=K9YlSWIaQHnzq4QRvcDDFKpAIDybDf8H2vuw+VcKIjM1zxzYUaGBD2ZSBtVHtHjnxZARFDZwBpkosFLsB+LCaTCYf2wrp4vhJxKGzEHF/36DprnmRUPXtaC/8iZ87WteJVjiSA6cWUH66ohq+FKCRPqELPVw99Vzz1649LcpSv3s42zl4lgKCTpQeImvHP8LE9nrg9dWP6CaFs9b2vuHxDiNGFQaScWfPxNJuLuQwZlJH7/qIip9GvpgoXLAw03XA/f17YKs6fwm30mn7xHBJAArzmHBhnGWP8vlV4XyOt2Qz0g1rSSlvG30uG1fDDtQoEQsSDQvLbSUeBy43JnX6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:54:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:54:51 +0000
Date: Wed, 4 Feb 2026 10:54:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/6] i3c: mipi-i3c-hci: Add quirk to allow IBI while
 runtime suspended
Message-ID: <aYNrxOHJg7rw-kpM@lizhi-Precision-Tower-5810>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204111511.78626-4-adrian.hunter@intel.com>
X-ClientProxiedBy: PH7P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 32365546-4d97-4c47-0d3a-08de6405bb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0MSbnOJR18+F5FvL9xcXjg7GfTfrYrZcu83Z4vba9Ihlif7QapXaB8neoBO?=
 =?us-ascii?Q?+uIBC2mUrhtflnWfsCfaqBmV7Plft8eczRlJg5yg18cHR70MkBRG8B2wrrtC?=
 =?us-ascii?Q?ak5lomyF8j/5M8NKIqzmHjXGt9/pE6rFf5PMg+oZ2W/uQO8RijAwRwBmi6FS?=
 =?us-ascii?Q?5UCgNA7fxqkR2PfADOwyywAZB+kDvqHG2cpulIc1HLgc10OMP+1Ua85bQdbC?=
 =?us-ascii?Q?hPUmx/iNHA5Zn+SvPV+YGZ2CuJw6eAGaZ0nom6FFSsg/VDjT8CGTKnUJZjFg?=
 =?us-ascii?Q?e2pNNXfSAfqYUJRAHrTiAyO3L8s7WYnH+mdF0ZcfS9kL0IEk4kOUpEhr8Z6u?=
 =?us-ascii?Q?yzhX5x+k30we4oYZhgf/QB6OoffapgiPT6nylFKzFGQCR7sVajqm2MutVFvY?=
 =?us-ascii?Q?7Nq/rZsnxSDaj1ZS96+AgoUU6YbxuhWPx0hRjvbLN54vLEIlfKvgZZ1/zE1B?=
 =?us-ascii?Q?tBkFFQDVFEVDVBUJAtYigQg6wF8+ek/uC34NXTjNDrsyruAS2VFthnn1VxfY?=
 =?us-ascii?Q?YXZHc4siJmXlMbTdYH7fWLYi8G6qL2rWvwIIkk1C9j6cWMZ9Fkf7h+6Xr1I1?=
 =?us-ascii?Q?iLzmP9JhKmM0NLqSV70pBT7i6e3OLAyuCZgGrZmlE7wKkbKuwkajMeYcuUOP?=
 =?us-ascii?Q?+ErnA1x+hqyHRuHFBKWtKG6+redUYgWRbxvewS3Xh9jwrMP72mlZT4T3BN+n?=
 =?us-ascii?Q?N1ZZlsCQvApQo5PHRFWw6Ai7b9TmqZPj8qTZ6AqfkpQ1XEvAyFLjlUbnu2ka?=
 =?us-ascii?Q?ZU9PROIOrMqHxY+/nl9lBoF9+3DQm0aFUFE/QWn1WNmYKTnXyM1xLk59BTm1?=
 =?us-ascii?Q?3fbAuaD2NmH29/zZkFHKyLqLgzLWtey1hgg6/qcHSyoNUDlwhxnrh3pxW5Xo?=
 =?us-ascii?Q?iqPh0RIag2iKBBNekA235ApfeLMyFy1uK5U9DL8+u94lWMycb33VBg4ovb0f?=
 =?us-ascii?Q?j3cn7NJo1DgW8nvxJ+hp/0tDJxqOTSudgdFlfnF3K5XQUHa2uafbcttqzlNM?=
 =?us-ascii?Q?rmtcQAkGVBfzAOkhEwGSB/FPOkH4ZFfLPX962SU9ENK+rVXfZ/AXYWi2vkCy?=
 =?us-ascii?Q?KWgQ6tpRjNxt2T4MACEvEkDS9pg01fg3hPqx3yQUVA3xtD4+Q2n5vTBxAVRl?=
 =?us-ascii?Q?Uo5iuZRLLID3dIbK0BY4c9cz8+9BXWRWknjoU4oFuV+8QKHKJE2FMrGTUsN/?=
 =?us-ascii?Q?NPo9ZlTZLOEPZW9FvoZHfZVwHs/2sGhUpW31B2xSPwOCke7YAz3uWE2py71e?=
 =?us-ascii?Q?p0T2mikxIN3zte2i9EzpkUKxUW2UDIl0W8t/9YkN8mavLkd/m5KEyQq7FO/A?=
 =?us-ascii?Q?gBdTa8mvheFoo/BonhPtAA2amCvqfxWx6DsBRNokNXQUZzplUWDoVpj2dS0m?=
 =?us-ascii?Q?v8mLdoiaImy1V4euRlFmX6FEVOFIhTUFwBpy6yj5kbbQ43OYxyHOSxv17+LA?=
 =?us-ascii?Q?A7LAHqMMIhzWk89FZL1o5gq4OZfHRJHZunZDai7BbeLLV28i/dD5Qepu5QGe?=
 =?us-ascii?Q?tL0VtWsL+jrEdTLomd1Vzt6NanNGw+EQniORyRqFJ9xiJK/oIzdI9tqj+xNi?=
 =?us-ascii?Q?Gj6WSlhzkmLD/Dl942Qo6eiwD6Y83MJOk0p3NKWZhF5KErf7Wxvm+CkrtpDk?=
 =?us-ascii?Q?xpbyc1ld9gSTqkcSk7bcA2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXm28Nuz7i1ZdSRHpHKUM91DMy6lZyrU3DWWtKQIxTtMK1095KuHkqUVnk2W?=
 =?us-ascii?Q?PgmVSmfrPqfWVWT5isB8GaV7riR7H/tj+gUaIdGVYgmp05QWU9x/NGmDMNAD?=
 =?us-ascii?Q?OkEEjobgtDVn2CUE6PvyAj0mJRvIOVWfkVC6UumrIXBUGT3yiCYqeUAZjhht?=
 =?us-ascii?Q?75liBtTUnPtuJqRzeuHXTN7rLI32CNP++hp/HgmINL8yYk+9HuMtCKt189dF?=
 =?us-ascii?Q?gG9yQwNp9HSqBPKteLt3guhinnUovAflEXJyzBDU8V46ZVkhnQN1OAuepG2a?=
 =?us-ascii?Q?mKpaeDL6G0qAnvlsAzgJ7FhiDEVZNkRy5uWJolaXN4YC1hr/t51seNd0XscK?=
 =?us-ascii?Q?Q/C22Y8eS+DZDoBA47BLy5vjQpk0dZagXO1bMHsDZEyZuGjePTdRkrUTR6kZ?=
 =?us-ascii?Q?/Qe8Vk3pO9Qu2oO+gzGFGHvIXQFLpOROrNS3Z63ZGSEja84Al25GJhIHL2B5?=
 =?us-ascii?Q?eVluVw1u9O9s93xfs/B9esR0GMxRJyT8bVzFMUeI/uREIEQI7mL4yMguu5Vs?=
 =?us-ascii?Q?orN1yvREA4+P8U65Gqm9f15AZAJ6p9VJ7NO6/2tbXyyHg8p/vrID1s6u89mM?=
 =?us-ascii?Q?pOkjvZp29qK28RWdqaHRg6bV8sJE6rLKSy0L7Gp3uzNp9t3uwRk8Doe/Or2P?=
 =?us-ascii?Q?zVZo472qRwJfWVzival61jhmOhhJbLC+DmqDJSqduAgwz7jCrSUI4p+vHoYI?=
 =?us-ascii?Q?nGGbofBOSGRPUWJTxjYIiCMmRCg5IT2R3a1pTZnVz+wzmEt83FgLagfgUiYW?=
 =?us-ascii?Q?Rs8cNVguBUsLIBAuqtFS3oH/nUz7IfxfVo1UsOJOFGFfyzfns79I7BFMFlT0?=
 =?us-ascii?Q?IcLCa+fWgTu0BfwzMEuxecI2cBPoy0cblCEXQWWGGn3QIv/IhpvOtyRAcKHG?=
 =?us-ascii?Q?qj+vgwVZqwFHSr6oh4V8FZe9pTHlfH4dmBduawNCRS3S6FMFHQ/8HBeMlQbM?=
 =?us-ascii?Q?egdGAKIKC/HP7osHd41kItxqVNXdpTd8S/Nnh98ueM976OUkjg5it6ps2w9x?=
 =?us-ascii?Q?LJ/beFR6NWPuXnvDf4d6g/iV2/LGSRZ/EUYQgVKis0nJDW+tlZfX9KA/20X8?=
 =?us-ascii?Q?xSLcAk6TIqvO0Tl6cBeDpvP9v6JSy/bN7qc4eeLsmBkqe0E5rXcFuGEEMqgC?=
 =?us-ascii?Q?CuUbBrtS+X+tp2kP7gmHYwiuBMctg0kB1aATnkYyPADloqCDK98bLLIhFsSi?=
 =?us-ascii?Q?SzkGcahYIH7F+waRhiudjOMWnjidofOmwOso3GlzxqsUijd0lTxXvDG9JNa7?=
 =?us-ascii?Q?5uWQKIlw+bs4ADbld/ZPK7DIwUbcCPF0Ee2RXMBM94zuQeCq8m3VFA1TlDev?=
 =?us-ascii?Q?pSyjs1pyVByARWB6jxq1MaMSPAJ9duYh6E/eUbsk9pwn8ueETxo4OpSB54by?=
 =?us-ascii?Q?PGCHaYzQVwOkY27UUqA2nHNOmodFALTciIeK8V9i7N09Rizxp23bRyPDMy5M?=
 =?us-ascii?Q?W8vRqXZ0fJd0sQ/BFA7MFn5zdL34NxPi3Wf9pz15OR/jIkTM7iTCNs/SOuhu?=
 =?us-ascii?Q?dEAFCb8gYWUSeQY7tNA2yo/ZRvkfvgzZFpeDFGJQmyasXVgxMdH2+QXgM38n?=
 =?us-ascii?Q?Nt7htYNv0RH/RHEFSoCsyGpZtYPObHWXDUJY77DhU/Fhfj1/7Iu2gZ7UQqlA?=
 =?us-ascii?Q?ANxUI61bg2FGWKuCTsBO95i80k20TijpyzbLLfKYAr7PrwTB4gd+CEQ9YD+a?=
 =?us-ascii?Q?3WuR8sG5AmtbQBoMQqRaYKEQP+gNIlOfQdMkY7lRIy69ohxNUT0c71ZRBM6Q?=
 =?us-ascii?Q?V/jiDYBpdg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32365546-4d97-4c47-0d3a-08de6405bb01
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:54:50.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THQFNtIVLganzvs2nHnKASOHruY7z1eRgVUSEFKSJdgaGmIJhnM8lidq54nd4JKO1Z1tuqir4boHeVx5v0DKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9780
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42093-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 3137FEA299
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:15:08PM +0200, Adrian Hunter wrote:
> Some I3C controllers can be automatically runtime-resumed in order to
> handle in-band interrupts (IBIs), meaning that runtime suspend does not
> need to be blocked when IBIs are enabled.
>
> For example, a PCI-attached controller in a low-power state may generate
> a Power Management Event (PME) when the SDA line is pulled low to signal
> the START condition of an IBI. The PCI subsystem will then runtime-resume
> the device, allowing the IBI to be received without requiring the
> controller to remain active.
>
> Introduce a new quirk, HCI_QUIRK_RPM_IBI_ALLOWED, so that drivers can
> opt-in to this capability via driver data.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>
> Changes in V2:
>
> 	None
>
>
>  drivers/i3c/master/mipi-i3c-hci/core.c | 3 +++
>  drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index e925584113d1..ec4dbe64c35e 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -959,6 +959,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	if (hci->quirks & HCI_QUIRK_RPM_ALLOWED)
>  		i3c_hci_rpm_enable(&pdev->dev);
>
> +	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
> +		hci->master.rpm_ibi_allowed = true;
> +
>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>  }
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 6035f74212db..819328a85b84 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -146,6 +146,7 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
> +#define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> --
> 2.51.0
>

