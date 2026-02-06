Return-Path: <linux-pm+bounces-42236-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ap+Nn0YhmktJwQAu9opvQ
	(envelope-from <linux-pm+bounces-42236-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 17:36:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE01005E7
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501F1308AD4E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE732B981;
	Fri,  6 Feb 2026 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tf0qa3IP"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE4328B52;
	Fri,  6 Feb 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395357; cv=fail; b=Sq3MmtcmdOB2juZRpzXkTly9W8mpiIaSduD9ClXi9WMCkynxKbqdgbixJkCzlod3Cz5CssHnqrK59bOEhW20MyoumOWMOtZjeBWMSGjcL7MXqDAPByNgdv/O2whcDSpl4zA+NISD8o1xV/0XXCO3ZoYOCCOviXhCSGzRFBz+M/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395357; c=relaxed/simple;
	bh=Y4KXAC1YvBq3XXYIjdYXp89kpPRBm7XWuRgpLV07tRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euqVNWgD2fZ7afewKbaS6nOP9v/AO4bYnmrMY9CoLeZF2FdNbf4dT6L8UI66669dlXNtF/kEzVLp7R9kAiVXWF7OJJVLW4n2rh4FJUWb1HrW7zo+mauKJmV44sMa6TMg4UVKHpFY6Tr0HmcnPzi28qV5tvMArmK+8i9ogpMB1pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tf0qa3IP; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2m7PO8dH07LxOL4sBCC0tRd45s8jMl10na+Jlt0huTJQl6d0o8dy6/F5TwPD85Ts8sBklaUTmn7NndUp/GIqCvowvAxASSEVSM5B3fk1vaAY19xNnlcd2DzD6XiVFkQuuN5NRq/5kdyjJAsR54HZgQVjg1NOtKlE/Vwyrngr2wouyut+XlDp9pPid/CeQfjucolLVXIQkA3tpBKVX1ih1YM0zYV4D2uUV/bRv/bNamM2bu1BJC15kItr3hkBHMy5zxLNF3HK2SnIYeF/o2ZibnJ5OM5T8wXCcpx6mMurIMD1iOH087MFMwqzjmWeOVOPtqEnp0ynPerMF3U73kPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7Tl7lm12wFCpPKoi5jZsSxdF9Z1LRbydBFov75DyLE=;
 b=eDVf2EG1MZIxL1qN80l4oomxoxypohEOdizK8Agxw4HBHWMZnriVthhuXfqS3y7gRe4ZoBfPtj5MRvD0+OE6Rec3e7EOiidhIobRV8d0eIEaTGSjjmcaAGNjdUw6f5IvDxbekp+SkYH+b1XPLx+APZNVcxncmvnlyPRMIs519gTtowb48MDxJcez0E3hgXXyQKBZdMPL6ezP+xHD2SzpwPRxOZxzF6t0aFh1prSqd4oIXxFKXo9dPx4SZuJh8Q933dSXMz2ewLOKbwNCMLlffbr33w7SURr1T1/5j7x+C3SkIEoFhYy5fsvGfDVKqxFV+u16WBgsgMqQSLEVPxIyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7Tl7lm12wFCpPKoi5jZsSxdF9Z1LRbydBFov75DyLE=;
 b=Tf0qa3IPEMAS2+6H2B7KhSEmqURr5pApObdCuowi4VBefjl+C36h/I6hGOFIgnFnXx8O9MOd0499AK8mLciaE3S2h7IRci0QQwnQVvS5haoDFFPlKiD2LlLspK58K0AehbVp0p1EjTvoGWC1Qckf2AqOQ8OuoSsfY9lz4ImW6jVF/XG3ROHnSenJJOpgoKEcKZ3WE2+8Mcl1bieZOKDu0bX+Fpq1pUnq8XXMp9Lz2w2IbwRaUa/9xFX3DTbquVobaDxsHAWT75OUZPfVORuSGdaS40ANZ0pEN1wkzCJEKx5iYP5CR1aoIdPRfmnmy0USwmQjDbo+PXQi+gWlEZWSEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8843.eurprd04.prod.outlook.com (2603:10a6:20b:40a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 16:29:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 16:29:14 +0000
Date: Fri, 6 Feb 2026 11:29:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] PM: sleep: core: Fix race condition in async noirq
 suspend
Message-ID: <aYYW0QbEVsnPsAaM@lizhi-Precision-Tower-5810>
References: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: c56692d2-78b2-4877-f1c2-08de659cdd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cebysdcKCUFA3OrnkF0s+0yEsHfB2/ETOjnMOECWeJteh2mUgeGGQUMDgrTX?=
 =?us-ascii?Q?UAyHibbsStU+uo6cjgtHbGAJynqC76k2S8LDU8vXCNB3sya6lNnEMxJh7o+o?=
 =?us-ascii?Q?7yYSA4anK5MofpULYj7f9XkXzLsw0pRGBJCETNkJglRx3tqp9NEiShejnm31?=
 =?us-ascii?Q?4K2xdQkPsYDs+n/qwIHlqCXria6UinLIkqtyliw+TTd37LHOLYwIvLLfRZA5?=
 =?us-ascii?Q?fd2avNTUOBCuW8ZYjIg2DvF9pQPfChMuQbNtypLO4ynSdlniUY+7K5U5RFpK?=
 =?us-ascii?Q?F9ANUtMv6COIjvyeouRUnxalTojV2nWrZPCrWd6Vj7YXT1Uc1MRB5Rr1nBP8?=
 =?us-ascii?Q?8nXMsM7U99ouBDZNo9aT/Ex76odxr2m1Ny4V2VKUi1JDi8VMITenzdrWdspN?=
 =?us-ascii?Q?Fs4E43JvwRZedaeYBhTXW19ldE//t67PweApDh2Ok+uaCZDaynXvPTH8wjbW?=
 =?us-ascii?Q?QHxI6DsUu8RSdv9J6Ty86FkDh3A/ETHwyhCtU+KculSVj6KXFAMHrNIq5kSC?=
 =?us-ascii?Q?JAO63pqJDRWF1Cqsv47Hl8iWjgq7gnBYfD3ZiFVCTWwZUC9M9Bmy9g9sQAhW?=
 =?us-ascii?Q?2kI49iuhZXlsVVctiIAaxYL6DV5lyzvhaaBVBivVUlVKgBtM+N4EOoeL1ooE?=
 =?us-ascii?Q?GgmAEk+jI2sLe15yCFqEMgrs4a8Q1s2XXVKf4tTkX5AVLgVeo7odvSUKBj9F?=
 =?us-ascii?Q?ssqGkI2EeBQaMBPgMqTfTo7G58EgF4xYjhgkOolRNAOnkO7VaFnGe5aKWJMe?=
 =?us-ascii?Q?fZhSE6F0bF4CND445Eg5bbIUzPJGz+j1qvhL0SwINczvHAImp672L2LHtaib?=
 =?us-ascii?Q?XydFbost9G4h73goQZCRuILw1ch7BMTuLF6YGu4cn+GKU+xKNg1+uhEkPezE?=
 =?us-ascii?Q?VN33TD6Xkp45Stci0EBf+SCzb50ZonQ4khlmZOLO5lg0YKC8h52O8o08uQoq?=
 =?us-ascii?Q?c7lamSQ5bN4c9qdpTgeXFvfB5jAdnVVDqVcZvVO89dXvkpn4dFb79KFJCnaM?=
 =?us-ascii?Q?JUyvSsYaApX/SW75/mxk2IQkLkZDAA7p6Q+dXGVYtG03L66Jsx3jW+uanjpD?=
 =?us-ascii?Q?hjGM5LsjxsoTMq94i0IYM+qnvzR/5i8jbxcCCK7BtNT1u4UNtXuT0dA3LE+u?=
 =?us-ascii?Q?oa8gkXIzk3eUrDdixY7u8ChDph/2DnemgLKyJfR3MjG4ULOCC/tgoAE9VW6k?=
 =?us-ascii?Q?C80dGogu87uERHcrZ4DvUCJZ+P/fwBDLQnKFw9JVhEC41UlA7hIoxkmoDd19?=
 =?us-ascii?Q?JyS9QUEpuqPYGcWpX+784CeqQmGLq4+5pDypaeC6FRAc7qwW8YjxDZt4uo/J?=
 =?us-ascii?Q?yLvqSaHKYi7ZLvWmGsqegiggS5be7a0RdLcFJCtz3+G9yuds+B2WHvCY5Jhv?=
 =?us-ascii?Q?phAN5Nnaq0Cept2Rvw5K/nXuavi3jsaWXVhn3gbuj3Vxr9ffw5Aa87xRRrBz?=
 =?us-ascii?Q?07K05/K2jeSbm/8Tfo+1S974KbKFTXp7jHqiymue4LJ1sznSSdQ2G771f7UC?=
 =?us-ascii?Q?T899IJcreOBCkPEhGfw9ZfTtSg0H+p+mtNwRGP/7Acs1Jcj7M/P4rrJXHCng?=
 =?us-ascii?Q?eFBM9AtQOR0DQWumHOwO6eLmx/DlAQ53iZ1U/apwduz4xx1565/2mpFWZ6rp?=
 =?us-ascii?Q?TxlDAwI7PqoZbftnYqISN/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oL7cEOCXsfTx5xgETIYkEhUOc/kp5EdzMEkHSrMb6T1fiB5umkED/TMKmbV1?=
 =?us-ascii?Q?g7oarWddjsm2g1FhzI2+sWrLh/2MOiIklHg3bcb+g9dMtuR5/BEVShHMZGKr?=
 =?us-ascii?Q?S3YEgh7jNdegv3cab7FieY6gX2ToyfN69A1Ouje0sV2JhrhX74x7j00HZnIQ?=
 =?us-ascii?Q?iMnPd5/UKYcFNrDh7DpnJVCYMYYIk4i3Mwa2Bm4ywD6WHbfT/Yrulf7+QQc+?=
 =?us-ascii?Q?fmM9q2GYnFjnsbG08S8PlYdioTWFArQ4S37/9SiPEwxSZ7LNpctfFLFaFC1X?=
 =?us-ascii?Q?mUoWTV+WCicr6SgzWOfT3oLmAYGBJcEbTKqFY+1an2T5mDVXkO/y0GsqYz39?=
 =?us-ascii?Q?Bp+hUPJkCYhOUsgGPDmzeuKhcrjZKhTvf9epDVmgiYpdU8YVOvPFqi0wYlon?=
 =?us-ascii?Q?GGgeehffS9voc++t7l8gc2A2QcwYVcrKd14R/pR8EbNEGcWIlZpsgKdNWa6l?=
 =?us-ascii?Q?xfl8wXS+sPdIJKN8Y/R+u6bTcnq7u8KXcNzyHpQLipHWfn/LkeDIdG8MnOUg?=
 =?us-ascii?Q?60TqSjP8zs1CPDYiiXqm4CzQnBPL6qH4TqgAfomgj0VMxI9yFiELDTZVBnPE?=
 =?us-ascii?Q?V6TNfgktdtR6BPUAsyN/7NjNbqKqJhGMTphf9JcrSV+zZB5azxAMJzC7v0bs?=
 =?us-ascii?Q?CdlyuBagM+kSCKFw3lDJ4XTqj93xmXRcNl+8WfpegmzJ8iRr4MU3SO08vkvG?=
 =?us-ascii?Q?kGn1K65FS7djOfkyfU9mT58wxXb/Nlqh64hksYhV762xa3MvsjU0fsueK1rD?=
 =?us-ascii?Q?kpIEjxIqBb7/0Z3oZ0K6I1F16bVUgBpSAk13pPTu/yr1Oggtj0z4ibnJ/cmx?=
 =?us-ascii?Q?HPjvVV42NQ+G31Yb3UzlOuCraIrNoschqIUxXyOhR+8dMxRDB6wKyp35C9PY?=
 =?us-ascii?Q?Rt00XEOSFSwJCA82vUBFq/gkI6e/fLqAp4bUdGoB29Kj5WSF/0Y+1YVax20s?=
 =?us-ascii?Q?VTP//beNoLS/oJsFG43znOa8tEDFXO40bH5UOZG/FNDfLDlsjy0ThjmtREer?=
 =?us-ascii?Q?0VxZtH6JZRJ8QhsTHppBTVkIuxpCE3kpBcPhuPOEkaJRQqDKvqGvxVEIcJaj?=
 =?us-ascii?Q?7AXMqcQLQbM8gZ3/Ismk96sL3X2ZczZoFT9VvS8UWmTGsaJ3q222HK+ZOCI5?=
 =?us-ascii?Q?JwaPy022PJpc3nP25I8m//OVVkv5dyNi9XDcHJHaDFlaEFAWuAO7VodDv1ca?=
 =?us-ascii?Q?NcTg3IlCZIJeFyqFLlwT+LeBdO36v5nDFEO1Ou8PR4yw89yYpvle361Fv80g?=
 =?us-ascii?Q?7K5ft/8qQLWs1JX+pGuzMsCD2Bzuzx19o/+1Yc7Cz+JF2YLZiIPO/k+rmlK/?=
 =?us-ascii?Q?wgUsytEWGRgsthzUGvbPOi1JQ4tpBjbd70S9MQRoomC9mjwMgo6bqe/fGV6i?=
 =?us-ascii?Q?7RuL48oScJ3+0P4f1gBSHpQFSHphY6dAjQGFfSdNOqVRdYTQSKX51WtI2Ftx?=
 =?us-ascii?Q?QIoiSZUcY1vLTrFINpH2o6Qdqu5Sr+zynC95uMqvjcC77joxnxmdhuPj4KN3?=
 =?us-ascii?Q?VldrY9Tl4NvRli/VomgvvO43CcxrAHg0YzYX65n+vd+D/8KcOxrUDlel00Ti?=
 =?us-ascii?Q?qVeAp9nRhM3Y7IMYUeD+6yHOlIXXqbG0d7dHSo+9bD6oIR8T584reLepW9AI?=
 =?us-ascii?Q?iRm3I3+5n0Te+7WXapPj8Qj5M90LoSlob7sksyQ0fZL6IjbcYCuAxkcRPExZ?=
 =?us-ascii?Q?9FjL87yT+e4Zu5lsT7wmPDAyjM5ivMuu+4vj4T7+6DICEAy2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56692d2-78b2-4877-f1c2-08de659cdd79
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 16:29:13.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9ngjay8a2jSQaFS48nLt0RrsGCDZsYFhPDYTGuyN3LdQul7ir15HM0qQkHLr443X6oLSHOW9FPCSeWOJaubUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42236-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DFE01005E7
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:05:11PM +0800, Jacky Bai wrote:
> A race condition occurs during the noirq suspend stage when accessing
> bitfields in struct dev_pm_info, causing system suspend to hang.
>
> During async noirq suspend, leaf devices are queued for asynchronous
> processing while the main suspend thread continues clearing the
> 'work_in_progress' flag of other devices, including potential parents
> of those leaf devices.
>
> In struct dev_pm_info, 'work_in_progress' and 'must_resume' are
> bitfields stored in the same byte. This creates a race when:
>
> 1. A leaf device's async thread sets its parent's 'must_resume' flag
>    via dpm_superior_set_must_resume()
> 2. Simultaneously, the main thread clears the parent's
>    'work_in_progress' flag
>
> Since bitfield operations are not atomic, concurrent modifications to
> the same byte can corrupt both fields. This leaves the parent device
> in an incorrect state, causing the system suspend to hang.
>
> Fix this by adding lock protection around the bitfield accesses to
> ensure atomic read-modify-write operations.
>
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  drivers/base/power/main.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 189de5250f256bdc1cdc33006b2c386d0794485f..561e24c257d779db51a0f0d50dcfee61e98de64f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -633,7 +633,9 @@ static bool __dpm_async(struct device *dev, async_func_t func)
>  	if (!is_async(dev))
>  		return false;
>
> +	spin_lock_irq(&dev->power.lock);
>  	dev->power.work_in_progress = true;
> +	spin_unlock_irq(&dev->power.lock);

Thanks, it is really hard to find this problem. I just worry about if it is
enough.

for example in __dpm_async(), if "check power.work_in_progress" should be
protect also.  And does other power.xx need be protect?

Frank

>
>  	get_device(dev);
>
> @@ -656,8 +658,11 @@ static int dpm_async_with_cleanup(struct device *dev, void *fn)
>  {
>  	guard(mutex)(&async_wip_mtx);
>
> -	if (!__dpm_async(dev, fn))
> +	if (!__dpm_async(dev, fn)) {
> +		spin_lock_irq(&dev->power.lock);
>  		dev->power.work_in_progress = false;
> +		spin_unlock_irq(&dev->power.lock);
> +	}
>
>  	return 0;
>  }
> @@ -698,7 +703,10 @@ static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
>  static void dpm_clear_async_state(struct device *dev)
>  {
>  	reinit_completion(&dev->power.completion);
> +
> +	spin_lock_irq(&dev->power.lock);
>  	dev->power.work_in_progress = false;
> +	spin_unlock_irq(&dev->power.lock);
>  }
>
>  static bool dpm_root_device(struct device *dev)
> @@ -1407,13 +1415,19 @@ static void dpm_superior_set_must_resume(struct device *dev)
>  	struct device_link *link;
>  	int idx;
>
> -	if (dev->parent)
> +	if (dev->parent) {
> +		spin_lock_irq(&dev->parent->power.lock);
>  		dev->parent->power.must_resume = true;
> +		spin_unlock_irq(&dev->parent->power.lock);
> +	}
>
>  	idx = device_links_read_lock();
>
> -	dev_for_each_link_to_supplier(link, dev)
> +	dev_for_each_link_to_supplier(link, dev) {
> +		spin_lock_irq(&link->supplier->power.lock);
>  		link->supplier->power.must_resume = true;
> +		spin_unlock_irq(&link->supplier->power.lock);
> +	}
>
>  	device_links_read_unlock(idx);
>  }
>
> ---
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> change-id: 20260206-noirq_async_suspend-645bd6b8305e
>
> Best regards,
> --
> Jacky Bai <ping.bai@nxp.com>
>

