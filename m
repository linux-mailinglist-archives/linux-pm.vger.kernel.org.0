Return-Path: <linux-pm+bounces-17094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CE9BFCD3
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 04:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5041F1F224B9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 03:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A4CA6F;
	Thu,  7 Nov 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="duO2U1H9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E716FBF;
	Thu,  7 Nov 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948572; cv=fail; b=R0svKr+0LLBGj6wPeho05uJTamf2phZb3oI0l6Mo4NJcvxLTWeVUeEuZbor0wT4WSy1s3oINTLEAkDOt3Ky1sU0J0H7Ujtj3opCjXIdAUP53CgWnWCPO14kwi6TQ7IkQ/wdkQ37pl9Krm9BsQZ2HUZHM9+cYpvCi9xOEgzEs6So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948572; c=relaxed/simple;
	bh=OG3gvd9OQzoKJ2r9ea+ikiRRc3S0BS4XAsHWDWAGY0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PSld60146wNNxUQJiYChdTbcxwSTiKmykBExyKI6uF6sGKPfDkw6j51SXBT1RuRRvTyx6KNyetgWMP2PSF+lhQCnM75oWTnxTkh9CH9b6nUHlt8R6bhSzx8UYeDd4etq9GzMhHLmQ+WxnMS246jh/OnQyc0yW3EbnD7ckQ6GLK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=duO2U1H9; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq041KSSOYQVdkmvb5JVGq10PI1g+EBlIZbIdRGSa9q/Sa7XU6jOhwBXoDHm5NXEjNJv3KpEIZrgM1yxc8RAhOO/uqUhO7rLqSyv47wk2sIwwTeazYjqo+UzKh7184hZlq7jQZa5SLs6sqrxoeOtn8HMaDAvSa2t6XxtMP9a53TXkfw558F4FcjeaC81KQ8kxOBLidh29U/INP9hdcMcl71+cEiY5Kmi+FemXJtMOwxKTkwrf6vmRDHGkxAWG5aoieT2xJdfsb5g5RwLLUv4FDCM1ox1lfaeuXKFBKLy9z6fL+9ecDjWZ52ZqsFcE89iOR5bYxSv1bpGNjleJ5QrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG3gvd9OQzoKJ2r9ea+ikiRRc3S0BS4XAsHWDWAGY0c=;
 b=yGJw84+3wfl/vwGd8d1sE+wQYZDaY/2t3RSl3+UUwuJakxIoZil5YDRO1kd8FbzR+lApdGATQRuJ99kURDv9BejYCzlE7B5RXI9zjK3mnil9iAsmBxeubzG78uVMSNFCVe7sTd+dH3J52nRLq1dce5wlOq1TEOt5FXS5Q/FH6Nah/mpyOZYGZh4VpMJwrk00A0bUlllKF9I49oiMpFwzt7j08ODNmwqSBn/lzw34Y5y2zW1xZmy0DcRu1tRH7NruGSfaqTvut7H7/Ke6WKDJNDSVvnKeizcVaIeceZnqKZD8VaZ9ZsG5Wpb2ux479vYov/xnMxgy/J+zPsoW5Z+YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG3gvd9OQzoKJ2r9ea+ikiRRc3S0BS4XAsHWDWAGY0c=;
 b=duO2U1H9ZmctaQbDDvBJ1Z2JJzyGuiK05VtNIr37nZQceBtvMMhiSRm8mAurNJmJWhZFNB6l9OwpvnYUVbp5GLtaN9lVnI5jEebjk7CjNiVR2uS3JCCQTfru4fYBFEhE+aMnYtxFsY1T5Y92S80F/gQOMaQi94Eu7nRfdSmlO6Y=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 03:02:45 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 03:02:45 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Anastasia Belova <abelova@astralinux.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6.1 1/1] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Thread-Topic: [PATCH 6.1 1/1] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Thread-Index: AQHbME9I27Xhvm+HT0mpRgUGmPOs1LKqig+AgACYGiA=
Date: Thu, 7 Nov 2024 03:02:45 +0000
Message-ID:
 <CYYPR12MB8655B12BE3CF07BFDD98FD0E9C5C2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241106132437.38024-1-abelova@astralinux.ru>
 <20241106132437.38024-2-abelova@astralinux.ru>
 <CB41EF06-3DEF-4682-84AE-7E74D6FB448F@astralinux.ru>
In-Reply-To: <CB41EF06-3DEF-4682-84AE-7E74D6FB448F@astralinux.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=abd25e6c-dfa7-4ea2-901e-b1f8325c0225;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-07T03:01:49Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB6705:EE_
x-ms-office365-filtering-correlation-id: 61312d28-da3d-4e6c-86ee-08dcfed8a754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vT108xk7eCtAFLV7FOw0C8DR8bEKlvtfJwsn4E9IsNEW4vCYI4DtuokdRLi6?=
 =?us-ascii?Q?nRq973I5/uoAJqMX8T/veuBKAwYLoClrZwvVJ6NVwEiDFy7QhwZZUU2fsePE?=
 =?us-ascii?Q?9dGEC5DhJjpqiI/uP8zWkYyCtScH+XYKREBguU3ohxyWprXkd+FGLUG4wNHS?=
 =?us-ascii?Q?Wp6DoyVCwZQaf9dn5mZUuU0LzTsZG09MVzxPOZT6GUEHRrkBAgxEPvRQI7Si?=
 =?us-ascii?Q?XljdDzKuM8n6110pRT7P3tK/ruwoJCWuvqFfTWdZU0ypxtj6drZ//EJrEI9W?=
 =?us-ascii?Q?aUZZJMJwzHtI2IPYF6QZO/2LpZaHPxxhyc9USZYtEiPDMdXwwAt4UjCPMH9t?=
 =?us-ascii?Q?4d1mDO/Ng+rXCmTfBkvC1Y6Sg/gpJsVgzrWf/72CggLUA3kGZOYs8XsDVr7C?=
 =?us-ascii?Q?vkAqGSttC6CD75CfwSrrJ5mz7puJoIUMRMQqrBQDuX6FQFFyq6lrX0vHPjc1?=
 =?us-ascii?Q?4kDa/cPUK0rNY7LdXX9Q4xT/beNf7QDbp/5r980BkM1/UiWMHPRtygakZyFr?=
 =?us-ascii?Q?7moLZYcrpv4dCS7P7NVi3bWjAX86LdlfR3UBxGuWZK7kp6iBSKB1VYznfQgG?=
 =?us-ascii?Q?pGhXGYrWtSDnmOI+1eL51WX+AfAeE7Hb+R69lyJrHtDQGU+Hmi6lsJZYautE?=
 =?us-ascii?Q?RiQvy5fyPQWie1wV4X/45841vOH1AKbuQ4k6aRtyip5W5HQg2VLhAAb1ple+?=
 =?us-ascii?Q?eLBhP1rOjotIATzKk/De6gr+CEut8dHs6c/DjMJ6qk5TqXy+R2vogkKg/WJj?=
 =?us-ascii?Q?JgvOADBjb/OTkSt4AOUH8eMw5T4KYWvKHU6MBGAeA2Lvdq40stManGHAC02p?=
 =?us-ascii?Q?zAbzGqUkp4e2XpQjvJfibeEH1RxeWlLehAWzGKOV2hLtTKDmfYn3m5WbNebw?=
 =?us-ascii?Q?sS4fEi4Ope1de78ho0AmSFhdyZFV2g7FotTG0mRZupk+HClMtST7JBXeR+sV?=
 =?us-ascii?Q?aM2y08M0ADg3yc0IU5mL6B+f5JPqSge1gnRGOBYyPexKdnqj8VXN3t94/YS9?=
 =?us-ascii?Q?3dh8/z5lqGjgaeGNnNxVYJVgke2wn0uRpfAe8Wi9kn2vPtEc553WvMVZXyzF?=
 =?us-ascii?Q?WqqVP/awO/n3gPAbgrE7VL3lJ1T/QMAmR8mM0Cs1BcYGqbHpX9nMEhlcEi+H?=
 =?us-ascii?Q?jUVB9+e9XgkJ8zruel46AVyYj6kJ1SScK53khvg66c/wqnzzX8nA6AM62OHl?=
 =?us-ascii?Q?8tza5tJwftj0hI33//BK76A8xyU+xTcOL7Z0DeCtaqKUNceh1kmFTLxf7BUg?=
 =?us-ascii?Q?6EwrnCw3U1nHwPEpIE6R2ERCHQ7DWlNzeT8tKxTc8jc6AIJGC4LOQoBXnHLO?=
 =?us-ascii?Q?KhBK5qah05so9ERBfGKUffXJMbx5f1cEUAmINVdQQID3mtXK5M34u+lgV75p?=
 =?us-ascii?Q?NEujgzM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YJNWKE4Abg/jHbTmfXje2dR5KIlKMAx947P4TgH4gJR/eZ+KWHgR0PjeuAMI?=
 =?us-ascii?Q?T0rTbppwQpnxz9Ql4A8x2txIB2IaSt3hnh/E5aG+z+UmC2XyDTY2nDkqKHlg?=
 =?us-ascii?Q?rADZ176v7DuuLRPO57pfv6GZCPNA/a7myeztbSNbS5idfPPJgzMSKaj02c5P?=
 =?us-ascii?Q?Z8//UJznvCjyVU6k+lv0l5ngPYiTSJyQtjiaqK5xoeSeo7XKi1rFNaZTjHLi?=
 =?us-ascii?Q?Vw9gCpBa3vIoDQo8AqwwA33LTLOah891Z+TtIug7nALV1prFf9KTRaDwHIq5?=
 =?us-ascii?Q?wAz1aPvfxZh4bFwMBtBjpBC633Kopm/jLPMkgBvSp4FcXFtu1eO/A+UAHu2A?=
 =?us-ascii?Q?tmTdh38nvfTQ4yNgSsNaVXmkvrI07J5k0wk2Hm+7/aLNEwbpKjCChoqKZbER?=
 =?us-ascii?Q?qIXPcVEHwT+E+j36ByOnReGKMCbqO+cFIRoiREYOonFryHBeY4sMxnG1Ghok?=
 =?us-ascii?Q?cO7q7loyG5dR+GNILLZX4Ea0Zt7OkfWG8VrUmkQ1pW07VgEK9yV39tqQMQwV?=
 =?us-ascii?Q?nsat6ooMU6CahkxzaBGsnZF427k0FYZ7xaKkK0ZLE6Q4NEbBofSfTZREkzCU?=
 =?us-ascii?Q?0PIuW54KypvLAFK0r6QWiHJ+OqOCoVfXlBHPcTRxP/KFWSHc37UdpmPSjii6?=
 =?us-ascii?Q?pUFx1GG1D4TDtSTCVGZuwlCWRPlk5dgLW6r54fjmWR7AEiFz1X9WvoqY2saF?=
 =?us-ascii?Q?k8KmCouNswX12b3/e8jrT7fIVlP1XSFNk6J4U4XFf75JH2ihHQxi15FL7T0b?=
 =?us-ascii?Q?njWpMlmWTA62OqkeYD5r7frstcu52SLr1a1Y0oRny30pn5hTkYBxAhiV72Fn?=
 =?us-ascii?Q?pMZcmUN4hF2bGvIozQ1sJHoy+2+UuQvcLf+atMMk04uvc8ECowc50O3M5pZx?=
 =?us-ascii?Q?CctHNhnnLEaw/UvjdNMqtZXcF70Gu3NvS1/1pxF5HkkUOrGQZIt1jNX9hizY?=
 =?us-ascii?Q?FABIpDb67KptQ0bb98tf80bDUJuK0wiRSP9qIF9krQblrRBjMMxDRLQoQyhY?=
 =?us-ascii?Q?wX5vn56hPayz0cgT6CM+FC+oMIIspFx85Px2z94/+NHMsEfrS/kOR7qV3Tsn?=
 =?us-ascii?Q?mD+5drRo6/YXscUMdCgkpYavKryY903bRBJXBmrCw67MrGS8/X20i0xszNBB?=
 =?us-ascii?Q?iQbVA0isY9dZYuFfot6IQ9dxbQoGv5foCHTQwKn+8JFIhgHH/bmrY2UCYkKC?=
 =?us-ascii?Q?gSNSYo2mfeK1tOCAoydo9Ta+0HJrJe0M3SVBn5wVzsTMw1fi4NiwMlruVZr2?=
 =?us-ascii?Q?G5SME/wt9yNWEgTkucldi/2SAIrPga/NVRQkMaNqlvpfceKyPakRtTFPh8p4?=
 =?us-ascii?Q?ePCA50la0Zb2hvI80NigXbmhTeq8vOXBMKcNf5QS8top1m0m/nqI9SjTJTCd?=
 =?us-ascii?Q?40AUMpDFMn+PEkJSqCQER4fGBS4K0R1HYsAFM8kfzFiUzL2Wj6CnDN1WoApr?=
 =?us-ascii?Q?KwOqNKktrsItnHaCN6nfFEUOC3cTewkVnvyQhaHQHLMfWA8HiYAZx9CXXgDh?=
 =?us-ascii?Q?hoHZuEKJWNm10Cxe4Fcu4COwtwzwGrG6enIbB4OB76IiOdFQVZVYzS0Si4Tk?=
 =?us-ascii?Q?rknLQkleRmz5ItMqvs4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61312d28-da3d-4e6c-86ee-08dcfed8a754
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 03:02:45.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frSIGmIZlvi3azkHhsVUwMiDinH5G+FzmLAzRB4UJnFrUygpOKxdx2hDH3fvTGg0RoPapFdfCDXvbCfOv2Eiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Anastasia Belova <abelova@astralinux.ru>
> Sent: Thursday, November 7, 2024 1:57 AM
> To: stable@vger.kernel.org; Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g>
> Cc: lvc-project@linuxtesting.org; Huang, Ray <Ray.Huang@amd.com>; Rafael =
J.
> Wysocki <rafael@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; linu=
x-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Yuan, Perry
> <Perry.Yuan@amd.com>
> Subject: Re: [PATCH 6.1 1/1] cpufreq: amd-pstate: add check for cpufreq_c=
pu_get's
> return value
>
> Hi!
>
> I found out this commit should be backported to 6.6 first.
> Should I resend this letter after it is done or I may ping it later?
>
> Anastasia Belova


+ Mario and Gautham for help.

Best Regards.

Perry.

