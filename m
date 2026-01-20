Return-Path: <linux-pm+bounces-41160-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FEPAAN7cGktYAAAu9opvQ
	(envelope-from <linux-pm+bounces-41160-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:06:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC495294E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC7E3C55
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577740F8C8;
	Tue, 20 Jan 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QI4gwtT/"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C540F8DB;
	Tue, 20 Jan 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906833; cv=fail; b=RiSzUicE5OXHnnLhk6od36QTuGi3LhE117c4CMIm3x/TvaMBCRhAEcbTQw2YPvgvKdjhvUQQ21EMYM675b1P3tZtCmfexek9iX0hKbzTtaXV8bMBBrAn3Ga2W8wgAm0sEMMWy2yhs9eC2Wosi/SVC5uxqkZVIw38k/U6WaD+9W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906833; c=relaxed/simple;
	bh=SbzkNatmnAnT8C8w1Mw8y6wUOK+PwQWacvrF4Jx0HkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEhWFu7ff634/+dhT6ljHxkvDNT6k8Hy6CdLaXD2GHLW2O8MIs6/s+pw52p6ZtTkTzhi01A2b6rFbEgUIXVo34evRxQN5i6k8x9KcbRlBThqv4QlTyBjWM3CjYgLDmHJCSexc9P+4Qxa5tknwQJnbRKjyOY8zT6fv8kZxZ9BhoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QI4gwtT/; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB8+580OtZ19ZIv+9utQk0wfvbN7bWdMnvGT57HkwO6fICyivKHLV9JDGyxIraavj521+hL/QPwmLllMxRaBpgwafted1BF7a2arxin6oCO4jTQxSt+QdCGuU2C4VjEHpj6SMLDNGVZ0HQ7aCRkbafAvyQqsJj+I0S51LnGJxQbZeuEAF+l1Z8eftlJ0Mijnt0CP0anH8+PtCnY+Ll61uT9d4OetXl/BlD889i4Q5O+URn2ulWJTTJdCyQ1eAeVV+1u2qFGuNmDYqeV0uncwLbjhu3wkVDA8Rw5cIjPi7biiumCaPmExL+7pCHjyOCW+wexqO8xYYhBQiWZxzK/nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWe04Fwk9y4+IrgHRZf7yvvT6HeI6UZ0CPEsD4zcmiI=;
 b=mFrc+W2xDnc2qH1Tmc06a41KjabeNyeRKVanwiSBhwKkqA7nDTl3EZcIu2B3402kX7tdSnbO6brjmw3Bpmkjo4bC5s9zG6ZchmbNWX6/UwD2/0dpHPEqIMoiHQ+1jf3kV4MZmTOqsx2br+yhjJyHAFjJ79i0/8GLBEnzqMLb7KCo9edMIQ+ju08mlZGLax4w3vJaHnEFrk5euBFNM7vdRFGdyU2TpvcDIsuRF4abU2jvcnLTqwEB3yCwIRCVBUvzibyoBIF2r1jVXu3Vo0jenkSFgc1Lz6L+9b16pr+ucEQG9WZgPcEeFJ9y44di4JAzJn0nduwa0si3J0JYobZ5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWe04Fwk9y4+IrgHRZf7yvvT6HeI6UZ0CPEsD4zcmiI=;
 b=QI4gwtT/ckCqXmKIyxPKdYLyHuafPJT2l805UL0GXyFAdDvJbk8XVnfZPCnNTW4bp9iUADf0kj2VFPVztO7sVOSI75Aba1QHapisHLfG5uNRJYGkgUGw3qK+KZrYVP9vrA5+qphX79O1tf6N4H68nDs/ScBLab2GMMpPjIcW1s0=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:00:29 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::6f) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 11:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:00:29 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:00:27 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 05:00:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 05:00:27 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KB0PFw1099148;
	Tue, 20 Jan 2026 05:00:26 -0600
Date: Tue, 20 Jan 2026 16:30:25 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof
	<bb@ti.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
Message-ID: <20260120110025.sflker5d236ineqi@lcpd911>
References: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
 <20260116-am62l-cpufreq-v2-2-eac7e2e78d29@ti.com>
 <ba251d2d-9319-4a4b-9ccb-f7681869617b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba251d2d-9319-4a4b-9ccb-f7681869617b@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR10MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 350bcdc0-04a6-42fa-ba0d-08de58131faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aLv8miNG+Qc433LCizT9XMDnFxtqelLcKgEx+HhMj1lTxa4pq0fVsZI4y63f?=
 =?us-ascii?Q?GlkMA7JVC+NyNNMZoCTmQwhpiwAFkwddlTWC4FxfMvNLiZRKqBD0S51LhBXm?=
 =?us-ascii?Q?kUbzIuHITbGhVJA6YiNhVoy3ILydSUD2OCVKrgD8r2QA3Peo6LvFOxJgw1Lf?=
 =?us-ascii?Q?/UsqIsIAU/ZFrCRAPNYvZLz3kv3ZL/sSb2X8gc8Xx/5xszYosV5oiZ+4ST7+?=
 =?us-ascii?Q?E3pUbuFPxTYAxCNFJM9C8wOhv53Bm8ugxJztFg3zvuBuBV+DvVsg8Ti2o/om?=
 =?us-ascii?Q?MwGXuw6Fx2PAgbaP+AE0xYXYC1ZYUT7EqWDPdemWCp/+Lf0OrC0wOKzUuejF?=
 =?us-ascii?Q?beYoqp6+K+c6ZddVXrv3VVGniJP/8TIAII+xuO2EbEMWlMt4kamUgAh9TZHS?=
 =?us-ascii?Q?KZzzFJCmmU/7kdsQ/sgZ9/L0RDE32V3tfYrFFOgLzDAHF/h+PnVLTSxBsBsi?=
 =?us-ascii?Q?9X+i0sAk1OLQArkbBNq0WipL5xxvAIUDGcGJpIBNfDtcJYqoUuoWuCo7J0f0?=
 =?us-ascii?Q?g8Gcu4m1IlEjkX590M0Z+4BVglRUKD9o/BYr64u3/NSaYntP9aG8E8UhfdgN?=
 =?us-ascii?Q?eLRAVHTR+eyIQ9pNxkVVQzAw6z7MgxbruoSgElwJU+PelHAj4C7WK26HDf4+?=
 =?us-ascii?Q?hbHMq0q4DejmlQnyKiUMIcteho7qkwRqyEQU7+Bx4C5LxkS6eQz3sxMbFO3p?=
 =?us-ascii?Q?SRjo3AeWa5xfwwVl+gJgfkvH1o27WXiHwsTSCV2UNsV4N/OsLL3J9CGQ49YD?=
 =?us-ascii?Q?WGT1N/1nhOgJ+Nd8Rxpj4Jr19qWJUpglESMD6fP+OQnk/oSLf9NJZYMLPD//?=
 =?us-ascii?Q?3rd2oGq+Iv9hSY3xOXzZMA22DupDY1+uhwelvYoSoRGy129LppDHi1fGCCMo?=
 =?us-ascii?Q?Eiowzo2y3Rvwh+ny9h7TOh8HaSGewpanACw6Db46ZonRkkZWOo4eSMEFDzdt?=
 =?us-ascii?Q?TR6nfSwDPPT7wpTP9szb3ZexGGmaM67YVFJaOecFKIM/TpJvNt6iJ/6z+ei/?=
 =?us-ascii?Q?AmTqIRsaMErUjRpr2LyyNnHdmaATX/NXLE0UBtj0suthfaiQ6ThYr84eNUON?=
 =?us-ascii?Q?RP3mtOXTN/PFv4DT3lrgRRJJzGc+40ScDFoUQhLnAiyVRkuL+yXV8da5CmgS?=
 =?us-ascii?Q?SYRfj2PZDC3F5a5wiQ3lu7ZQl72UG/f07evJGKZiIyb2Ila+oKROyX9sIppK?=
 =?us-ascii?Q?hq9CnNjmSTZxGVHwqEH63ez1U0pM+7WM/SeFE27q7E6CR0xWlqIQ1jl8dx/h?=
 =?us-ascii?Q?tQI24LuoJQ+miIDYG+MvThqV/j+j0mg/I+ooDxg0ELEIh8xJpYvMidCxNyS9?=
 =?us-ascii?Q?eH/dWfEosX5xRM/2ZHUUSgsIXfLe8fHTY0FQpDigzEeDNIEDfMq5xIj0yuKB?=
 =?us-ascii?Q?i9n0fhLVlFn4nVuxObGmnQh/iimFzlW2gt//+sGJa8ngRKI4Y6zXfFCy5JfJ?=
 =?us-ascii?Q?STWGIvptTotTXgmHQzG3CT6/qlnScFcmVdJ1oYNad9rStNNWo2mQH29qcAj1?=
 =?us-ascii?Q?3AIQX/nOz+7wAzGXcHJloNKCCqd/x0bvhRoSTrWUUjshFS3xbQcljUhdhXje?=
 =?us-ascii?Q?2U3FCqplQFXnvfrVZMj1Ta1wYmDvk4tUmiTuavXzALcBF/9aLVeqUUsBK9po?=
 =?us-ascii?Q?p9YsfYw4+P2cT3MlVc30uJwdNKWHHncyuUYL2K42kJ70wGQNQlXWCZovUpxg?=
 =?us-ascii?Q?cpTcwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:00:29.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350bcdc0-04a6-42fa-ba0d-08de58131faf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-41160-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:url];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-gole@ti.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5CC495294E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Jan 16, 2026 at 15:15:29 -0600, Kendall Willis wrote:
> On 1/16/26 04:21, Dhruva Gole wrote:
> > Add CPUFreq support for the AM62L3 SoC with the appropriate
> > AM62L3 speed grade constants according to the datasheet [1].
> > 
> > This follows the same architecture-specific implementation pattern
> > as other TI SoCs in the AM6x family.
> > 
> > While at it, also sort instances where the SOC family names
> > were not sorted alphabetically.
> > 
> > [1] https://www.ti.com/lit/pdf/SPRSPA1
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   drivers/cpufreq/ti-cpufreq.c | 34 +++++++++++++++++++++++++++++++++-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..4e65e96b784ee908716c63316bb54eb1ac1efc49 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -48,6 +48,12 @@
> >   #define AM625_SUPPORT_S_MPU_OPP			BIT(1)
> >   #define AM625_SUPPORT_T_MPU_OPP			BIT(2)
> > +#define AM62L3_EFUSE_E_MPU_OPP			5
> > +#define AM62L3_EFUSE_O_MPU_OPP			15
> > +
> > +#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
> > +#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
> > +
> 
> Shouldn't these defines for AM62L be placed after the AM62A defines to
> maintain alphabetical order?
> 
> >   enum {
> >   	AM62A7_EFUSE_M_MPU_OPP =		13,
> >   	AM62A7_EFUSE_N_MPU_OPP,
> > @@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
> >   	return calculated_efuse;
> >   }
> > +static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> > +				       unsigned long efuse)
> > +{
> > +	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
> > +
> > +	switch (efuse) {
> > +	case AM62L3_EFUSE_O_MPU_OPP:
> > +		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
> > +		fallthrough;
> > +	case AM62L3_EFUSE_E_MPU_OPP:
> > +		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
> > +	}
> > +
> > +	return calculated_efuse;
> > +}
> > +
> >   static struct ti_cpufreq_soc_data am3x_soc_data = {
> >   	.efuse_xlate = amx3_efuse_xlate,
> >   	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
> > @@ -313,8 +335,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
> >   static const struct soc_device_attribute k3_cpufreq_soc[] = {
> >   	{ .family = "AM62X", },
> >   	{ .family = "AM62AX", },
> > -	{ .family = "AM62PX", },
> >   	{ .family = "AM62DX", },
> > +	{ .family = "AM62LX", },
> > +	{ .family = "AM62PX", },
> >   	{ /* sentinel */ }
> >   };
> > @@ -327,6 +350,14 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
> >   	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
> >   };
> > +static struct ti_cpufreq_soc_data am62l3_soc_data = {
> > +	.efuse_xlate = am62l3_efuse_xlate,
> > +	.efuse_offset = 0x0,
> > +	.efuse_mask = 0x07c0,
> > +	.efuse_shift = 0x6,
> > +	.multi_regulator = false,
> > +};
> > +
> 
> Same thing here with the AM62L struct being before the AM62A struct which is
> not alphabetical.

okay addressing and sending next rev, thanks for reviewing.

> 
> >   static struct ti_cpufreq_soc_data am62a7_soc_data = {
> >   	.efuse_xlate = am62a7_efuse_xlate,
> >   	.efuse_offset = 0x0,
> > @@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
> >   	{ .compatible = "ti,am625", .data = &am625_soc_data, },
> >   	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
> >   	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
> > +	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },
> >   	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
> >   	/* legacy */
> >   	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> > 
> 
> Best,
> Kendall Willis <k-willis@ti.com>
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

