Return-Path: <linux-pm+bounces-41721-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CAMIX+4e2k0IAIAu9opvQ
	(envelope-from <linux-pm+bounces-41721-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:43:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4AB410F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98AF13005596
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FD327C06;
	Thu, 29 Jan 2026 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N1P+gEqY"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A63126C5;
	Thu, 29 Jan 2026 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715837; cv=fail; b=mYqQURqT7qoIHiQ6Gy0jc+jI3JbplA6xCpv1pTIuYCFZdJgW7O5vU6DTogAy9PDDh/fKRmgmtxcVAlIwgTeFx+DjNrvqbEq1Lj61dVh6o3SacwYDy4qCrpmbumsgo1BiTQNWsqh65yeJ42B4U9SS8Xa2foQtCXewdijCxtPr7zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715837; c=relaxed/simple;
	bh=z2yNpjFD5/P9Fbx2E4yjOV2TlkTsIB8NDTHZ9F+haMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fMrVQBwxFgybIca7luS0kXdKhxN7CKMgrzH/xZ2TpB2XL7IAakvk21TTzOvxP7W2uUnhxbupQrOxqEHYPElCUBoRKgb71TtTkS7TrBmnIWE3RYnIPaTYJe8K8Nns1n1PySdooHyAzGA8p8eyZwDGeWXjTsbdkwStFv9J6qq71lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N1P+gEqY; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNqdOsaSDEw0gHg6JLqmJJ0FvUrW0BZaHDXtPFBnE+S+OYHcQ7NNhDVeglwokswMWFM1IMqK223ScvHBRYcOIG3bgk2E2QXJm0h4JEWhDO4Lrwbop40pOQSH6F/VW8S6p6/nHVFNpvt7R+YlORKrnQ2cIY69MQY6EjIrnt8pe3UigRr76K9f8LNZf1RwKsWWAASqMIFJHQ9AYCSaN+OGXAn3Tey4+R9PcRAFSU6Sk/IHcDW0PIZsRRSDQWU8ixbHijRcW/vw74woqwwkRbcBvkRMGGBbHw5puxUqf2dO+gaQ+8QrOzbqlLKrRtUK6pDFXk4RI01XjF4ZZdU+WFwtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjiIePm+TlXfL7AKi6+RDjZsO5aBHJBdKikjQqWxvRs=;
 b=l235oqxkg2oH3UWA8wiN5WvpKpDNELY461C1CjgRir+ows/0fJ0xBN5sbDflYZivzTl9Ejoi4i71Q9OQqaHzL6mVxmySS9mKwZAPmcn+FwGxMDmil7jY+mWsq4sfC9q2eII5FxsD97053AnkaAH1/QoHtcZk4fZd6pNYCnTvvAwnsu08QI5IlVO43v76luAqCzu3eSzhKOHV9GsOwD3vzB8nTwv9jVpipGlqw7GROEWDXiP9c+Sw2V9AxUZnj0nszp8e1iZesNUgzh1d8fdr3d/Mmq38j0W4NWe4gtkJbrGYT11Gv0ElrmlNGqWsmmTfz1CId8HZQY4oYSja1E7mEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjiIePm+TlXfL7AKi6+RDjZsO5aBHJBdKikjQqWxvRs=;
 b=N1P+gEqYphNO8edvRuuyq/bpYFtWFC7SfnBZpRPKbvij+/ueo450cMa6JkbhSgEVeen2LtPCryeCwIqTN045BveGXLzu4pZNIPI88PT8kkHOBuCFABpm+wFreJbFvCAUsOeUBoVStt32U7fq1tMoeV/Ixl7cvIaZgnbwLXpbmUPB5LDotbNhb9r4zqtjJkkHYSOEJwbQSDezd7u6NaouXCV9levOB+Z50Y6ybzuKyS9oQEbC9mDNbxfn25Pff1E19+jAuM3jRdXAsuFu3ODC1vwc5YnaAucZi3TOvkB2WCYxOFh4x1KPKIDh+DSkB5o2Z+jXs341qsTs4rKShhl9QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10328.eurprd04.prod.outlook.com (2603:10a6:150:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 19:43:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 19:43:51 +0000
Date: Thu, 29 Jan 2026 14:43:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for
 Intel controllers
Message-ID: <aXu4ceRx1bGViQ/U@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129181841.130864-2-adrian.hunter@intel.com>
X-ClientProxiedBy: PH3PEPF000040A0.namprd05.prod.outlook.com
 (2603:10b6:518:1::51) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10328:EE_
X-MS-Office365-Filtering-Correlation-Id: f829e458-b93a-4ce2-d1c4-08de5f6eba33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX29qIAwPvF6eRqM5GGL1TML0WyQC0aVTzsqltwBHY8JnMkvkY3vddihTdl2?=
 =?us-ascii?Q?BCdVJ97z0erVweEZaUqBTPF2lwQuUROEkn5bP6uR+urEqrTNerJ93AiiWKTn?=
 =?us-ascii?Q?B9L33MbvxhxOYNQUurlicrr0v32NPzBpoG6HhtPjgq8wW+satV5rdLnHu/JK?=
 =?us-ascii?Q?6s4mHyJZpAbgVHblbtFu3rMut7jrLHX7xiJNCHNml3mfU8tgWOslyB+nzRXM?=
 =?us-ascii?Q?lDBOMDlY07Sga0hSWOKg0BnNt0zQufiqWPMm/F9H+1O14ALMUYX/SD5p81Iy?=
 =?us-ascii?Q?63RqZOzeSEsN9ons2ed7D+5RkC3B2Oy7nhNcFrGy+ZmXoOKl7vSYeE4RuvIS?=
 =?us-ascii?Q?3bu6zUDThbu3wsn7kERZbdYrSbHGJOPhRuLBPT3+OGcp+8Hwo3SYdZ06VyV2?=
 =?us-ascii?Q?wPei9aHDrzF6636HzhIZggq6hdHXrzaF3fiVX/0Qxjw/YYM8UGBnJ93DggHr?=
 =?us-ascii?Q?QzC4Zxa/WNL7sd9K6FIUYmzJIPJuk1S0TvsYNYqNC/e3nAUMBlWwF1IAi4XD?=
 =?us-ascii?Q?td5+VYndzy+DXUrxKj7Sx7i3ELkWOiIZgdzsxUQFjZOfTPV8m+TfS3tlfpl9?=
 =?us-ascii?Q?aphI4Vz78XcLInFq8NNnxSEnV/FLTHaq4Tv42+YUTHzch7BJT+olCVDzaZVH?=
 =?us-ascii?Q?ERq4F02Yr39ffk/USyik7QBnTuU3rEDShCPnSb/JhvN2a+MnUON9RlFXheZr?=
 =?us-ascii?Q?aOsO9Y/hOZ5ITEu8dQsRz6P/JoPSyLclKoR+Hbq4OLnxwRwniDH2I3O+ePBA?=
 =?us-ascii?Q?+UdzryprZP8eOpAuLI9mbO48Tm27kI+2qWuolfQwF/rUyd6omSgAmYiOTCch?=
 =?us-ascii?Q?mUmQSlX3/bnUuczfuyPs99JAreXO18HouV6wmy8CSbHIgzPyURMkyfbET+uT?=
 =?us-ascii?Q?m3LLVheiZah4ymqkB53g19/jsB4QlA/tazPysZOcng7ioNTCsLQStpfbYBLN?=
 =?us-ascii?Q?DEGKiYkgSbk+xmc2MRCzph+AmC8ZUXxrYN8Xq/ABhqeh2mbkDOy6eLFZq8Gm?=
 =?us-ascii?Q?537ApQv9mVm5+tQq3GmffCTpCKx6XlNLdW9C38s4qaonmnJ/t6rpOYUa4JL2?=
 =?us-ascii?Q?1xrF2pqcIMcCrTZmHn5Grt9JkHfAC/7EoJ8k2O6WbgYGrntlOAPe/N9au5Vs?=
 =?us-ascii?Q?ebM5F3uXEi+jTcDCHRVszGOAvtIjpDf3r+Yo/u+tNCrOoZT0R8sRDSss7ej6?=
 =?us-ascii?Q?uAeyOXkdPRd/xtgy7lmJ/ccMkfJccCITOB+3+dYWoqwOiJ1soZzhQPDFZ+N8?=
 =?us-ascii?Q?ZMBA7isGUvGrR91RibKqFjkKP/leTHJP2yhZnkAYiCNw47KnbppVmbU1HFTU?=
 =?us-ascii?Q?JP2OXHbZf4kWWy2K0QDb4gijcT2iGQo65rir41llUBfApfQzKIM2iTd+tjqr?=
 =?us-ascii?Q?V45+GU0la4YgdUuqH67AbyjDWQjIXSNG+QiiGq0Syk4glQOO2bmCFAHsg+/n?=
 =?us-ascii?Q?Ld0FYF6QxiqmLgP1JEKuiPwYLmfPd0Od7CgtFVchv8D9MwKCatxaISfAajGI?=
 =?us-ascii?Q?ToDsFuNEs06sFYWWJCvT3NoaJZztoazXpNXOWDBj1vugIb7M0yk6QOYRQ9xi?=
 =?us-ascii?Q?A0WplD3ds/aiORTmBTykY7gPHEozJbDMit5WfLtjyEPIGmKZb6G7LCf4zOEp?=
 =?us-ascii?Q?vgpE82NnBHG6Wko8flsmAe0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkDiM5z9YY2/VgA069ub0eSuyuPbfPVJlBVmwuvU8B90cCu7y2X8oWbJ9Ige?=
 =?us-ascii?Q?Pvmv0QZGe3vSERFrgCA3N9o0+yCZfNJnaqdSzf35sH7ju5rpd8/UU15QFwr5?=
 =?us-ascii?Q?0/zIogCDgp0NvS2MPzQh3URleOuHQU4/9PCxtOf1+si3ai9kXtVdwaqjQT5B?=
 =?us-ascii?Q?SCh6OslFt4/nZu86GViUAqG+nYabkkPO9fGOgDmjGUQIm2wolhKF2m3OYD92?=
 =?us-ascii?Q?WqTSniFA1FInDikBGO96vwkUTIKtsPHnk1Ad7mN6bX4TNKe09I9u5i4sqmns?=
 =?us-ascii?Q?rpsfw5hf1+0OujkpbnsdJ826JiNwVDck5Ci5ZuI51i1X5cnQXom85ZOtmVAo?=
 =?us-ascii?Q?aSHuMhmXi4gGzDuWB7v5O6q20ZiAMjOcMmAS8BglTZ07RX6+w9S8YD4MorUz?=
 =?us-ascii?Q?OsOSKGSSRlNHKlADVG1CrIuZCw/qoLSTybQozZKcKGu4+TvP1v9c8fNu0isB?=
 =?us-ascii?Q?fNI+MX07QTb4cIzIELnYV7pYjCPcyxA42BNRdbMp7S3iqjonYoWzcQFuI3cY?=
 =?us-ascii?Q?rCRzgnu/AW5mBIN+bv0mI7NUBIog5aRwB+o0qNjAslYfK3qEiD52gJ/CjwAj?=
 =?us-ascii?Q?mTsT3GJk7gFtHyHvvLlgSeftuEVDyv4G3Mp9kW8FtFPEog2UdU4sLlwHgrUx?=
 =?us-ascii?Q?hNvVYQlwYuY50ahcmtQSauEwT9FCzsmWdEbT4+U6ZmLHs3jYNgyOBOw0Bvoq?=
 =?us-ascii?Q?oYcZiKs/yoYuxjb1iBoIiRN0C8ZzavOjUALNab6CnWmgtZ6Pq5lVgFNibtgY?=
 =?us-ascii?Q?DzKBh+zqwIdUaMlrByCy6t/9MuMMHfvgEdcIm05VsF2GDUMrNELJS7KWM9Ai?=
 =?us-ascii?Q?ZEBdKSsTkObfYC4UNE7ymdSM3cgLl8c/KCNt9TfnobV3UZI5JeA4PFA8B4GY?=
 =?us-ascii?Q?krTQ1Sh87eHump6PcwGQzKU300lTlPefKBJVctkaHtPJRrCMDusXta81CpoW?=
 =?us-ascii?Q?l0xRIAibG4G1oc/oQvuSQd5Rb54TN0Rabu/kTItBd16CY3OGoxlp0u2OAazF?=
 =?us-ascii?Q?rmYxO7f563BqPZs8f60l8O40+M+JcI4lKa/IR+akAIqkCkFXAS2VuJ7N8dNM?=
 =?us-ascii?Q?6keaWx2cZcIYwwAJ4TVfpTUiMWS9FeUJvzvwyoUw2/Vo/B3eE43LEJx78V7/?=
 =?us-ascii?Q?DU7yOtdib3o+T/s87BZP6ce875IrIsA4olRT3/SotGE7Tk7xTcYFqKIM1Qua?=
 =?us-ascii?Q?ZbzHSxlmZIipbEKrx/bo0FuTD3oupx3eoaCSaqKPNMaFJuuc7cELAzKZEb2Y?=
 =?us-ascii?Q?iMyp4CbzCwuHjizIaKqHkH95BxrWuFIWeJrh5jZPh7rW8vhmdwFDYLyHuH/f?=
 =?us-ascii?Q?23gHLhf4KseY5LvGfTG77nVsUtDkb/4cfbjhiSN55qneN/GDMje+9u1NiMv8?=
 =?us-ascii?Q?lyHRJm+zTzpqjnxXJ80rPWa+uMPow6LyoFo+0ouljqPuxDmY99diBj0XZEUS?=
 =?us-ascii?Q?0E0u5RjD2yBX3O703vn1upE0P/va9G73nvXJX3jTxHdhKp8SdqK5pTC2Ef/v?=
 =?us-ascii?Q?6TKXMJCr9/PrrPwrbNxWrLDLSI1wzM253/lcwiCH4YwCTfYBciowQ34Yl5No?=
 =?us-ascii?Q?x8yFNyHdU442fcjLImTY7fWjqoGsJlCg4xqOlIqhq82CNwNn1VrgnvC+CJQl?=
 =?us-ascii?Q?ty3573nMxsIaAEsGpecNEARjtu1JTCabOXZ3YxX3EG6XLW/c8vpxvNyYg/u6?=
 =?us-ascii?Q?29SlMRwQApkKPEXc1oQyH8iOdYpWbTrEto10wmUYofUbwgdw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f829e458-b93a-4ce2-d1c4-08de5f6eba33
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:43:50.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL/SAbROKWANta8A2dODmnpu+jWgcygCVZI5TGtuxVlYf0OZvc4RXpqr6ylfwb9WS7fFnKyzhjTKLZoK2XtInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10328
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41721-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF4AB410F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:18:35PM +0200, Adrian Hunter wrote:
> Set d3hot_delay to 0 for Intel controllers because a delay is not needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 0f05a15c14c7..bc83caad4197 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> @@ -164,6 +164,7 @@ static int intel_i3c_init(struct mipi_i3c_hci_pci *hci)
>  	dma_set_mask_and_coherent(&hci->pci->dev, DMA_BIT_MASK(64));
>
>  	hci->pci->d3cold_delay = 0;
> +	hci->pci->d3hot_delay = 0;
>
>  	hci->private = host;
>  	host->priv = priv;
> --
> 2.51.0
>

