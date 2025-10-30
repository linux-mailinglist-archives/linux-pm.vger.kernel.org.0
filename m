Return-Path: <linux-pm+bounces-37123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07513C214DE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768944202F5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F91E5718;
	Thu, 30 Oct 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G7fylf4g"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF212212559;
	Thu, 30 Oct 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842752; cv=fail; b=Q0J+X/vCmt51wpWbjVKkfoDtlrQ8BdEWBXqkX2IMEAg3mAINk4LamAYwHPPJbYyOuv0TmP4JUgZphgMDbhviaYn1GDEwvTVF6CwSImNIJj7tCLhd7SfaTpia9BnEfKK0YC8aoATFZL3h12w3NXx6BXfhPVYNVxtvb6e+46H2n6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842752; c=relaxed/simple;
	bh=YeL7sfBkeH6faV7b8Q8y/55Oi1mCLaCJdzWHDW+Y9Dc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoQmiKy2ExyjtCGUAB/sRA/o4yvIgOorqi0/Y1aiscKtykjQhnQo/PlaOtCiUgr/0H+nHmOlMB+3fSAk63zWbePb+Oi+lisa6T8xKLXGrqhWOWNp+eEZuY5xvL43/YtFtNKiah292s306WfjntRTnlYi+f5+HX44AzRKiHJr2GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G7fylf4g; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kul8i7MvFc0zoD9qdK/S3jzS2OVvxFC2YMkkCEKECP3VMKRGEG6TrmO3o1ZLMX8/ovY0UxzYoQOpWuWY2UTDuVWZg38ueWOXHRJLV6CSTwW1s14X21DBupiXa4uu1axUUzDeWz/FXxSPugF0JPOOsfkvXECBSIc4q7KV5k3xyToKrujT/zJzTzd68vzCTTq8sn7iAV3T2unQlkDiNQQc5G/D9RdIWGJWEkbHCuaXg73xEP1kNNnr7TXOf7FbmhHv9H8MaIUCia8ogWjJ/eJVZ6TM/roOZ5uZmfR/OuBTQRDELZ7MqTjPGZHqVv0AGjUrBivui25i+fma3KKqj67AbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1XrrhnIREuuD/+I8s3lPxrRfD84h+c/gtbw5YlxpQ8=;
 b=RaSvAJOgJbdRZsYU4eNiyShbAJPtN7LyycrUTb4Xgq1A9PjjoorrUlyjj93sXo25tgea4NUkdTru4+D1ltoRTmm+cptHj6UZDpLq3T2dv/237d7mmXZEkC+IVZ5eskx/ulQ/chFH6E/VhFKZcBHnB+ytQHhhINPH49RIOH9AayjnTzoWSqAfNYN3AUU7t4blnOhMW8RlVXlj0E+BQWSO0Arg98zDBUWRu8LS9o9pYf+soYrV1JLNb3772b98iRXM6mzKV307odfS8CGa1X/eMyrdZgJD48WZzYRBf2U64fUVOsnfWoKsLTTtDvzJEGyx1s4ut0v99cwlBQAMSW6PDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1XrrhnIREuuD/+I8s3lPxrRfD84h+c/gtbw5YlxpQ8=;
 b=G7fylf4g90y/NeEAQ7qlYgX7s3LmwcMkT0hEJxKNu9nKa3IMX+JxuJ2Ab6B3RNUAGmJQcEPpPKnEyiFV6URYUy+x0cQxDxm0dHhHaadmLDww0yS8Dh4040Z9+Lj9f594BOoasWtqCJ6OxQOJiCUpq4glDt9wzwRRYO2tg/EbaWI=
Received: from PH7PR17CA0025.namprd17.prod.outlook.com (2603:10b6:510:323::27)
 by DS4PR10MB997598.namprd10.prod.outlook.com (2603:10b6:8:318::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 16:45:48 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::e8) by PH7PR17CA0025.outlook.office365.com
 (2603:10b6:510:323::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Thu,
 30 Oct 2025 16:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 16:45:47 +0000
Received: from DLEE103.ent.ti.com (157.170.170.33) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 30 Oct
 2025 11:45:45 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 30
 Oct 2025 11:45:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 11:45:44 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UGjh7e2476028;
	Thu, 30 Oct 2025 11:45:44 -0500
Date: Thu, 30 Oct 2025 22:15:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, "Len
 Brown" <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>, Maulik Shah
	<quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
Message-ID: <20251030164542.atnhs4wgk6ggmmly@lcpd911>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org>
 <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS4PR10MB997598:EE_
X-MS-Office365-Filtering-Correlation-Id: ab38c51b-6c99-422c-b3ab-08de17d3c6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlpScm5HYmlvbm5RQXpXemRwenVmc2xFK2Y0RSt0RkJHTzhFMnRWMzh0U281?=
 =?utf-8?B?M0tERWpXU2dvTTRaQkExTDA1WE5OaE9RWHkrOWZBV3NHMHI3ZUliSi9JWWlR?=
 =?utf-8?B?OVdUSDVEcENSQTdmeGhKeDM0clNoMUlpS2VMWXlvZmNPOGxlWGh3bzZmeGV1?=
 =?utf-8?B?bC83dWlPV1I5NVVXTUdPRFJIQjZUdHJwMkZUYStqY015Y3ZWZUVjakRaNTBx?=
 =?utf-8?B?T1owWVpVM00yYTh4RXE0UTB6N3M2cHFhU2RQYk1GVFZGVENycENDQ1g1dkxP?=
 =?utf-8?B?U05kalJscUZVQjd5M2FnVFZMRFRRcjRPS24rcWFidkxka1l5Q254SzRkVzdT?=
 =?utf-8?B?RWJtc1hqZDVLNTZsdG9BYkVKVWt2cnQ5VC91V2F3K0tGNXlLa0JFVzU5TEZO?=
 =?utf-8?B?c1R4eVNsSHZpdEgvYy9RK2ZoVEpTQk9SM0ZYS1kreGV1aWQ1TFN4aXBGUWxm?=
 =?utf-8?B?aUVQVGs0d1d6VmgvL09xWG9SNHVZOVgrYzdvQ3lRcW5YMWNzV1pMMWZIR05n?=
 =?utf-8?B?NjhiWTNzWnh5ZHY2Y1JXTTZWZ1JTaGNGWndmSExmYU1scDRKMEgvZFFhZmRT?=
 =?utf-8?B?YlgwNGNMK1Jkb051NElKNENITXQ2c3d5UFJaYS8wYjhpNm5IMkEzOHlqYVF0?=
 =?utf-8?B?eTJxVmlLdEdyYWF2NWdzWkVobXJPQm5ocjlrc0pmZUpib3JxNDFKVnBWZ3My?=
 =?utf-8?B?dkFYVUpVa1lyQ3NUUlZiSHEwVXIzWUZjNSsxMU1LM0hmTkJETU9FNEN2M3Jv?=
 =?utf-8?B?dVZzM3kvVVVNTXRKOHBVUVZ3MlcwTmkycHphRG5xZUg2Y0VQZmQ1VVE1VzVY?=
 =?utf-8?B?Z2dUTWhrbysreCtrUWRrSnRZeGphdFUvbDlmVzUrdFp2dS82Z2dlTWk0TjNj?=
 =?utf-8?B?UmhqZDhPeHlXY3N6YTlndTE5VWhGcWpCZytkcTRKOXN3T0ZWSHdZa1Uzc0ZI?=
 =?utf-8?B?Qnk2eWQrOFNSRDVLM24rT3I4ZDF6UGxBUVYrTEpjNzlTMDAyWTdvcC81K25a?=
 =?utf-8?B?dk5CaWJOLzdkWXR4TDJVbFNXRDFhdnB4ZzBtbU1YeHpHZ3FLbFpPbGVCNHJG?=
 =?utf-8?B?aHh6MnlNRm8rRHdOazdwNEtaVy8vU2JmQUtmWU41U1UzbnM2T3VkaW8xUjIv?=
 =?utf-8?B?Qkw4TXRZN0ZMZkI5cWR3b1NmZFRXZW5HazFmS0NadDg0ZTJrWEdNVGI5eVRS?=
 =?utf-8?B?WVB6K0dGUWZybjBwbUMycGhxZUJMOXlpZW55RkoyV25laHQwaU5HeVUveENm?=
 =?utf-8?B?WHhjcVZhUXppVTBaWHFQenlaS1NlWXBUN1k2MDhZYkxHemhjMUhReEFZaXRQ?=
 =?utf-8?B?MlZvbWxSWWZqTmoyUmJPUXJudWpKcWNQdnVpd1lVZ2gyWHI1QkRUNDAvNTF5?=
 =?utf-8?B?L0hVcHplRWxSZ3RWMFFpUVVKVUlXbUhrTlRBYlZSOTZSblpBd3kwb3piYzNs?=
 =?utf-8?B?RGRxMVMxRGNpdUdwUnJYWEliU0xHeTR2MDBNdUVrclhKNWFYNC8zdGdueTND?=
 =?utf-8?B?b25Jd05iS3NyM0xoOENRamN2b3Yxck5tTmdhMlAvV0RLMjFvTXFnd2pvVTBR?=
 =?utf-8?B?Q1JPV2NoRXlYVXE0UUxVQldqLzYrS2IrdDEvaDdPOEgzMHMxMnE4aTFxTm5H?=
 =?utf-8?B?M21yOFpUemJRZTV3bVptWXJUV1NhdVNydHl2WFI4TUUrT2NFSStSNkN3LzI4?=
 =?utf-8?B?RVpPWlhQRTBKTUpxYW9NRTVkYnJRZ1Rob2FzVHBKbWY5aW12aEFiemJCMnE1?=
 =?utf-8?B?KzBXOENZclVSSWlFOEUxMzNXeVN4bjJacGFSVEh5SDF4RWZPYjRwMFE1eXJy?=
 =?utf-8?B?anZnWUFuN1d3clhiY2lPRzlyVGhqNUNDVkxWWVFqTEVWRzNHcHhrTTB6L0Fq?=
 =?utf-8?B?alpIU2FnakZqZlQ4K2NNVVlnTW43NVNtYVBNZ1RlTldSYkppWHFDT3VyU0x5?=
 =?utf-8?B?Q3VxWWdzY1d6OUJOOTBBMDlzcFhSMEZqODZTRXEvREd4WnpMcXhpcVREWThI?=
 =?utf-8?B?ckhrMWprMFBlZml5LytCT3Jia0M5c1lBZU1xK2oyUmgrdHBCZE54NndZM0l6?=
 =?utf-8?B?ZGRQQ2Q2Q0pWNnhlWllLYTd1OG1aL1BrSzdjamRnSWJOWWtDVkxoaE1rMkFq?=
 =?utf-8?Q?/Tis=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:45:47.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab38c51b-6c99-422c-b3ab-08de17d3c6dd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997598

On Oct 29, 2025 at 15:28:22 +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 29, 2025 at 9:10 AM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > Hi Ulf,
> >
> > On Oct 16, 2025 at 17:19:21 +0200, Ulf Hansson wrote:
> > > Some platforms supports multiple low-power states for CPUs that can be used
> > > when entering system-wide suspend. Currently we are always selecting the
> > > deepest possible state for the CPUs, which can break the system-wakeup
> > > latency constraint that may be required for some use-cases.
> > >
> > > Let's take the first step towards addressing this problem, by introducing
> > > an interface for user-space, that allows us to specify the CPU
> > > system-wakeup QoS limit. Subsequent changes will start taking into account
> > > the new QoS limit.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Renamings to reflect the QoS are limited to CPUs.
> > >       - Move code inside "CONFIG_CPU_IDLE".
> > >
> > > ---
> > >  include/linux/pm_qos.h |   5 ++
> > >  kernel/power/qos.c     | 102 +++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 107 insertions(+)
> > >
> > > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> > > index 4a69d4af3ff8..bf7524d38933 100644
> > > --- a/include/linux/pm_qos.h
> > > +++ b/include/linux/pm_qos.h
> > > @@ -149,6 +149,7 @@ bool cpu_latency_qos_request_active(struct pm_qos_request *req);
> > >  void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
> > >  void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
> > >  void cpu_latency_qos_remove_request(struct pm_qos_request *req);
> > > +s32 cpu_wakeup_latency_qos_limit(void);
> > >  #else
> > >  static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
> > >  static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
> > > @@ -160,6 +161,10 @@ static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
> > >  static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
> > >                                                 s32 new_value) {}
> > >  static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
> > > +static inline s32 cpu_wakeup_latency_qos_limit(void)
> > > +{
> > > +     return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> > > +}
> > >  #endif
> > >
> > >  #ifdef CONFIG_PM
> > > diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> > > index 4244b069442e..8c024d7dc43e 100644
> > > --- a/kernel/power/qos.c
> > > +++ b/kernel/power/qos.c
> > > @@ -415,6 +415,103 @@ static struct miscdevice cpu_latency_qos_miscdev = {
> > >       .fops = &cpu_latency_qos_fops,
> > >  };
> > >
> > > +/* The CPU system wakeup latency QoS. */
> > > +static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
> > > +     .list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
> > > +     .target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > > +     .default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > > +     .no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> > > +     .type = PM_QOS_MIN,
> > > +};
> > > +
> > > +/**
> > > + * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency QoS limit.
> > > + *
> > > + * Returns the current CPU system wakeup latency QoS limit that may have been
> > > + * requested by user-space.
> > > + */
> > > +s32 cpu_wakeup_latency_qos_limit(void)
> > > +{
> > > +     return pm_qos_read_value(&cpu_wakeup_latency_constraints);
> > > +}
> > > +
> > > +static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
> > > +{
> > > +     struct pm_qos_request *req;
> > > +
> > > +     req = kzalloc(sizeof(*req), GFP_KERNEL);
> > > +     if (!req)
> > > +             return -ENOMEM;
> > > +
> > > +     req->qos = &cpu_wakeup_latency_constraints;
> > > +     pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
> > > +                          PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> > > +     filp->private_data = req;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cpu_wakeup_latency_qos_release(struct inode *inode,
> > > +                                       struct file *filp)
> > > +{
> > > +     struct pm_qos_request *req = filp->private_data;
> > > +
> > > +     filp->private_data = NULL;
> > > +     pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
> > > +                          PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> >
> > Please excuse the delay in reviewing these patches,
> > I was wondering why we have decided here in release to reset the
> > constraints set by a user. For eg. even when I was testing the previous
> > revision locally I'd just commented out this release hook, since I
> > wanted to be able to just echo 0xABCD into /dev/cpu_wakeup_latency...
> 
> If you want "fire and forget", that would be a different interface.
> Device special files are not for that.
> 
> Cleaning up after closing a file descriptor is a safety measure and
> CPU wakeup latency constraints are a big deal.  Leaving leftover ones
> behind dead processes is not a good idea.

Hmm okay ..

> 
> > It seems an overkill to me that a userspace program be required to hold
> > open this file just to make sure the constraints are honoured for the
> > lifetime of the device. We should definitely give the freedom to just be
> > able to echo and also be able to cat and read back from the same place
> > about the latency constraint being set.
> 
> So you'd want a sysfs attribute here, but that has its own issues (the
> last writer "wins", so if there are multiple users of it with
> different needs in user space, things get tricky).

sysfs makes sense, then would it make sense to have something like a
/sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?

IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
set the latency constraint.
We already have CPU latency QoS entry for example which is sysfs too.

> 
> > One other thing on my mind is - and probably unrelated to this specific
> > series, but I think we must have some sysfs entry either appear in
> > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > state that the governor has chosen to enter based on the value set in
> > cpu_wakeup_latency.
> 
> Exit latency values for all states are exposed via sysfs.  Since
> s2idle always uses the deepest state it can use, it is quite
> straightforward to figure out which of them will be used going
> forward, given a specific latency constraint.

I disagree regarding the straightforward part. There could be
multiple domain heirarchy in a system for eg. and all these multiple
domains would have their own set of domain-idle-states. All of them having their own
entry, exit, and residency latencies. I myself while testing this series
have been thoroughly confused at times what idle-state did the kernel
actually pick this time, and had to add prints just to figure that out.

When implementing these things for the first
time, especially when one has complex and many a domain idle-states it
would indeed help alot if the kernel could just advertise somewhere what
the governor is going to pick as the next s2idle state.

Also, I am not quite sure if these latencies are exposed in the
domain-idle-states scenario ... 
I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
these:
active_time  current_state  devices  idle_states  sub_domains  total_idle_time

Maybe an additional s2idle_state or something appearing here is what I
was inclined toward.


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

