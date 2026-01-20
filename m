Return-Path: <linux-pm+bounces-41159-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLLIBZe/cGmKZgAAu9opvQ
	(envelope-from <linux-pm+bounces-41159-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:59:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CE56663
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B70F5E67EC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927040FD89;
	Tue, 20 Jan 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WR9ae14e"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E540F8E4;
	Tue, 20 Jan 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906807; cv=fail; b=nmX2wm9olt6/mN1NYkTJmrK7XEzaoaUNNh4CvZMz+ju8tlswUyTMcRXUItlIy4ACzNWPX//URtd+FxA8zRu+FO//GwuXhJaKKLcB9UdniemA/FIyN2M2ARz7JhicHCG7NjgzvOZXD3C7w/84O07r+olY/s6nmVrvtAE9Qvme+Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906807; c=relaxed/simple;
	bh=82V96A1hWePyqfL0/F55y9IMF4gMZZOFvgYJKVd3MuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZfKc0+4GgiZe3Fz38rbE5n5XnGKz6HpyY+JXUHKs+ViyHjeRTYpYufoNae4G4sbQDps2h55S5vsHIJaZtBXLr+rUWNoO1JlzxJ/jB1iCMUSA9QbsiDoNpmjheoRdikfDmFTeImA6NpZEGCjaZDy+/WRNvBWNoLOIDYogQ101SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WR9ae14e; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf85s2Ngxpz6sRQHFZRUXkdPssGXNJjN2UD1niK2XoSCuk9gn1EBMCI2e4R5i+GO3kjWdZsB+cdvN34gpJRjw+hYI5lluK6DAVvtijUkJ4gbQaqjcQ3kK2Dldgm7IWOxSmglheQXuNHFpoLyW8nNlIHNk9q7vM0qms4D+1GJ50Tp/b9X/L2hU6MEx9WrbbNeTbh5YTB3bh+Gsx4/PN+zSQu+aTYyCxpZXTc+z8fSR53deyI3vLYKKuNc7ckGYlcDCYHedrEKQINnH3a9Kvwe69p+s2pj/2HptsNXVVaMrs3fEsAjI+Th/tGiMIZtH7zB756M/H0YmPE37I+N15LX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhM7353DALglHSoEre/dlpldjlrhhQPNp06cWpV02Xs=;
 b=v6Zuw3IM72r2bEVxgNeHi18TEwjVIv8eERjzhD44UtaVm8jY/xl9a4XRYjw2QMcLtNXFgcjtgxPXfvxBrjayOKZxkqACWIJRI0FvnzV8x+N22xKtApCiLohTvfQs8yQ/2M4sOylOX+PahG0bYKU5Fmh/7CZVN2KY+LaMIFZJaOb7uvZ2Cvw2mHLAKOPAvtxTWjUtZ9SHkLbjfIGLoibn4RJbkH6c/0HxW+uDcUk2T7svJVRTWo88gg8/yYDzrGWAnLe86JUwn2WRFAUA3gEgzauS0SH8OWhMhGUmgfAyD5wFqKTwq7AliBOVsVzYw+ulumze36RCvxPefPnZt1ljOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhM7353DALglHSoEre/dlpldjlrhhQPNp06cWpV02Xs=;
 b=WR9ae14e6BymlqphgIEdRw9GwKsK47dMk9AUhqVqGjT3yGGxEXJB/+06vQq1z7ohLtmRJZ1CDMcdEVqYYOHMpBJiYYfrlH4cUSWqKuc0ars5Aej1TGYj1zB1e2acRQZunlSGCjspEj6yUMqbb2JhjYVkLjlPtN3i8vRPBtpqPkA=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by LV8PR10MB7821.namprd10.prod.outlook.com (2603:10b6:408:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 11:00:02 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::70) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 11:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:00:01 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 04:59:59 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 04:59:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 04:59:59 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KAxvQt956077;
	Tue, 20 Jan 2026 04:59:58 -0600
Date: Tue, 20 Jan 2026 16:29:57 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof
	<bb@ti.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
Message-ID: <20260120105957.73p2belbi2wrxjn3@lcpd911>
References: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
 <20260116-am62l-cpufreq-v2-1-eac7e2e78d29@ti.com>
 <c4ab2e7a-6d58-4ab0-a063-23a779e1c1ab@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4ab2e7a-6d58-4ab0-a063-23a779e1c1ab@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|LV8PR10MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2f70c9-facd-4632-da2d-08de58130f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zfidVPEDMa7DJa1boO6t9vKhoQVh/8U7xGh/TxQb7/loX9YgW65vRad7xm9U?=
 =?us-ascii?Q?+Mw5X0fgUZPD0oO11W+UtkaMb36WbEuBlTB49he1HdauEir4aKHIlIW86H6E?=
 =?us-ascii?Q?jkBqZgEGC7/dAKlDV4C1Z0MafE69sHjvf8Sa6YseQRfVDOvh+Q0jyZGkuuEo?=
 =?us-ascii?Q?6M/s1JnRBxrfjW1EW6AU/Fsqa2M//tKbmWvAFd+DQkXoqL1X+M2c7E7qrQyH?=
 =?us-ascii?Q?WZNk81sfcbvYuwG+i3uWiqHQc1vlM4YxXAbcsrLCbmDE8FI7Vlrm1+ONXh5h?=
 =?us-ascii?Q?iK8i1KAcIfurglrJLieO9aIopxuhHmoK8oJFTKgdGrehXmacgZkax6x8QRhi?=
 =?us-ascii?Q?6WvHiQHrEryE8vlf1Ba+0TaylmvW5ToKADJxrgN2GGHkuV5D2aVyqlVcZM3W?=
 =?us-ascii?Q?QP0afvzBciqy921onTatMdbfHUfovVwn9JSHPtOwkaA+G3uktuk3KlDPkZNZ?=
 =?us-ascii?Q?8jWqAOTJY1NMNdFaPFG7XN3ZdgA1wzskE2yMFeXo+hTMQTByXUx7uybOoAUo?=
 =?us-ascii?Q?g2ox+5Z/iGKIOFi4MG1/WG3nAdQgXPmiqm3RJpudDopc7DodewugjMRiybKm?=
 =?us-ascii?Q?9BEoKzTXbLCYOtRLlo4Vcw59nT+VRMrr86ch1gJlxE2D483oylU29zv/Njhg?=
 =?us-ascii?Q?xgwHo+D8mPSV7YC6KQ/ik0S4wtKSAtjjhY21dvhJIKQMSjhilmvEGgFPNBVS?=
 =?us-ascii?Q?s3SfFzcL4D7Huuve3Ch9esZUYBv8T0NUmmIA/JpDAfYA9oJHAq29hW0M4AZg?=
 =?us-ascii?Q?+Db1rloHpwDtA6iTI9raaYyrEox6DBiltiVem98a5xaQ5XVBMFkHmTKuqVE+?=
 =?us-ascii?Q?hV7MrS5HcZo4z3S8MrCWu5NoiiVaoLtJCC0pIqSM5pwUl2+nSwqmB4uis1aL?=
 =?us-ascii?Q?wvEsFjwGoG3ZIDxo5CXJK48ut5/txB5zJ8oEDVr9NLod3/F1JlZq/KCP5Z5F?=
 =?us-ascii?Q?6nwfYtZRPyou5S9Wqo5OA3kTbJEEvs3H+/fcTXCxWTJ2vjT+97lPpJEhWDgZ?=
 =?us-ascii?Q?b7oAJZ+kwYdOMXBy2TJjntPacKtHM+K76D9hhWW+j0pAZRy26cndW4+LOpNL?=
 =?us-ascii?Q?R2q/WRjxtSesb4YxcL5fnop0zw1/EvYluYJApRAbQxXvIYKCZEIz7sYM5/Nl?=
 =?us-ascii?Q?PyPhJFeYlylOk2EBHACVtct1bVaegQs2E99tiYfQ/c6qmSDAh015R3DAhwv5?=
 =?us-ascii?Q?IWxxkn75PBqWTkWrpAX4VQsI3oh9LNBNaRgRFLWtK+vMwCr5ByWremqJ6ZwZ?=
 =?us-ascii?Q?lHQtiPNRdG7E+zWzOqOCSdbyxK3li95NXjkQNFXQuq1cvSu27v+oTEDP7HrA?=
 =?us-ascii?Q?bSI7zCp9TWGVeLNvlKhLK09PvoAm42eiC26A38JJACFYBU1VbBVnjCTRWjSw?=
 =?us-ascii?Q?tES065EsqoD81f/5mr7EjHIxNozEhQtOYwOasfmHifT/BPWHRr+VOZWxs/C/?=
 =?us-ascii?Q?X6kQWCp8AhtXIHTlgteEu7aamgV6iKDdzt5/Z43hAhzdbNdRIxfk7LRNLYQY?=
 =?us-ascii?Q?wtU5DaYblo20Y0vQDIWrL2itlXVf/ygYW6jLv7gg/HLaik/bYMzzJpXlUjQF?=
 =?us-ascii?Q?ak/ggzsLTYdEbFcmsOdYKkPO5eSkUG5T8PdYF/KnOBenSRNJ0+liNoWS4jNG?=
 =?us-ascii?Q?UBOVtnb2IPDgdxXyUdO1Tc1sTtwFlGDFhQANeoLwIKMFuT8yGDYGQdyE4yZX?=
 =?us-ascii?Q?Vn7wWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:00:01.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f70c9-facd-4632-da2d-08de58130f27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7821
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DATE_IN_PAST(1.00)[24];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41159-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AE4CE56663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Jan 16, 2026 at 15:16:01 -0600, Kendall Willis wrote:
> On 1/16/26 04:21, Dhruva Gole wrote:
> > Add AM62L3 SoC to the dt-platdev blocklist to ensure proper handling
> > of CPUFreq functionality. The AM62L3 will use its native TI CPUFreq
> > driver implementation instead of the generic dt-platdev driver.
> > 
> > This follows the same pattern as other TI SoCs like AM62A7, AM62D2,
> > and AM62P5 which have been previously added to this blocklist.
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 1708179b2610bca6035d10f0f4766eee6f73912e..16310e190d9ff96af3d20cc5d98dc0e4af4d1bf1 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -193,6 +193,7 @@ static const struct of_device_id blocklist[] __initconst = {
> >   	{ .compatible = "ti,am625", },
> >   	{ .compatible = "ti,am62a7", },
> >   	{ .compatible = "ti,am62d2", },
> > +	{ .compatible = "ti,am62l3", },
> >   	{ .compatible = "ti,am62p5", },
> >   	{ .compatible = "qcom,ipq5332", },
> > 
> 
> Reviewed-by: Kendall Willis <k-willis@ti.com>

Thanks!

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

