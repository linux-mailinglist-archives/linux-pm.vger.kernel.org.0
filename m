Return-Path: <linux-pm+bounces-32962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75DB334D6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 05:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EAB165C59
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 03:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A81231A21;
	Mon, 25 Aug 2025 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P5P78QuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362A28E7;
	Mon, 25 Aug 2025 03:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094179; cv=fail; b=gqSuU0A0edMpFiFpSQoRs01gh58uHofjtVGUDULK5OQSSwckyOPp8vqfwupmhOusv5IIJ5MnoWTKtrAGO2cAcTV+W9QD/MVNWzyuUeVfluJz1yHf3o7upSxYBlPc40DINGjbU4Dojcy11WS17z/4muSkwKHmXFhgFDwb/DUi18I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094179; c=relaxed/simple;
	bh=GUtZPYDMMFcSiKatghB9vqXXijjSvs494UmM7jemV5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzY9ZQZITKPAK9XbLNecVz62JXYhX1PPcZY5wJ+zkDLq7+DBrsTdtzXpm3iQ6O6ZmoexOjqCPhXunlW52EvJU1L7iwe9Lx8xeqrdp7aEI3GYq1yXlbCKHsnjnJlr9YzD6nWC3W4ku6MBiF7p5iFqYv0I5aYe1889nM6rC2nzfDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P5P78QuH; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDmLpi1IFKnAKfiqKRItJUTw6uLdNhkeHMT/4jUSAaesHwxU9YOLwzRZxg5ucFrNuGAL6c7Uec6jUq3FmfS137XK4vmQMmOc9BLV7XMyUPULoQYBe4+sKECtZibnw3NWe5ICjVUmQg0kplBb2oklgS+jIV6X+GNhCm/9yPn+RP2a7Xtxq480aMuaIus3NZwxNgoL/wZt5ZNcnZYv03auKouzOi4iQ+m3T/IkFqdk/CGWvrvqx9eB5lnosZaRP2tfpBjvPeKLTqzzi9IaNUBnopUwdOWP3OfMxhOsdSF3ajpl9jOjD2wjNzCZkWJNSp73rBNTYBNdnkfORWvWnWP9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixbLX894lFp9hdv5FsRAUKa5zVSkRKWKwwvNNeDXdl0=;
 b=V9LW1Ct6sf3ASSMxib2l/QQbRSK/OHdD06l4lEIO2D34y7QAj2EJCjjdFD99GcIEW63W1yDKAQkX5vKBKUvfUCmd8Zcm6BMB2UbFzpfV4aw4SYHPoHtC43qe+mc2CAQgyfl0HLdVv7+K5ix6P8zZLVT00BPL5Kl3nUK0Ts0kN/OnU062MAXA00dEZEU28feNKzOB7TrQ8fj/tslXQOG7rrrZ8HnEz5ClHPZjmIGG6livwmzXRM89czaiH9a4zmH7iyQXGUDw7yhSe6wwWxWKeFywMiagl6x5BfuYzT9tuaHXNBg2HGOTZGjHUrzewQXiwnksPRIz9Iceqq4DTugzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixbLX894lFp9hdv5FsRAUKa5zVSkRKWKwwvNNeDXdl0=;
 b=P5P78QuHbrmSD5xiGizQcnwEnDl32v9lc0qE3GmNXKujeopoqRw1K6C3gbs4KzawoIZ7es8rnce9+Q9yh3wScxmzQVBI0HisRrgM3Yjo+7V+pRCMisHejxcxd3cXLpAetGV6P91s2RfltMjoaoiKXQvBWXpfcyC/EnA/umbdir+8Lv6VSOkeb1s5TOux5KcTgRPSlLBevNtDHagwzHSFfsSt+GZU/Hxfh+Im0akI9jU9JYLAS4yehplrcdo+76w19BR7Ta75aa+drOdyNLS+wBw09Cl3NPnRew14O7VmnQYsFu9F+OBxTukd/BX8gleKWCys/lOYl7Xp+v5sn0jgpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Mon, 25 Aug 2025 03:56:12 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 03:56:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
Date: Mon, 25 Aug 2025 12:56:02 +0900
Message-ID: <2395520.irdbgypaU6@senjougahara>
In-Reply-To:
 <CAPVz0n0zuvXxT=G18ujhV26nbvuCKtyXNC3cxenxGuj8wHWZ8w@mail.gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com> <1914341.atdPhlSkOF@senjougahara>
 <CAPVz0n0zuvXxT=G18ujhV26nbvuCKtyXNC3cxenxGuj8wHWZ8w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::16) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5924872a-47a3-4881-173e-08dde38b54fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXpWbUl3enVxaVhCWHBFbWpvdEpNaEpINDFrWkhhOTRDYm96alp3STZsT0Vi?=
 =?utf-8?B?UGcwNXB6Zk95eHp6NFU5VEY5OWo0Q3RZTnR4VUJ6a1FldFM1VG9oR1B6SXp5?=
 =?utf-8?B?VldMMS9VL3hraEtCMXZTZkhvOUFob1pYMFlTTjlSUkNhODZMUXZJaDV5cUcz?=
 =?utf-8?B?OWJmVVJzRndSMi9HbVdpdWd2V3VOVVVieEEybHl0UjdJcU1zTFd5SU1qMEVI?=
 =?utf-8?B?eVdtRjVObHdMK1k3UWNhU3VKN084cXl0RUtGbXY1SXc4VUt4VExWVS9MODR5?=
 =?utf-8?B?VFZzMjVQVnFwb2MraEVKL2U1VXZGVzR4SjZDUWhiUjc3bWtPayswam5xSXE5?=
 =?utf-8?B?aEhSbUNQejZmTUlxYS9IeGp2N2FUcjAzU2hhNlJEYWYyRlU1OTk4WGZPaGhC?=
 =?utf-8?B?Wk5aVk1hcFBENzNOdFc2aEdCSFEzUFhIanNwQXpoY0NydDZMTlM2MjNUc2dn?=
 =?utf-8?B?ZnhtYUFzQldGdTBXTGhVSlpJNlc0UkZocTBwbHE2NHdHT3ptTWhkVXVVS2Yr?=
 =?utf-8?B?cXR4MjU4cmcvYXRsUGg5ZlFKZlpVMmhXck44ZzR3b29HWTZYejUxUTZZU3Nh?=
 =?utf-8?B?TFFmRmtsNC91UGNieUpsMnB5N043b0JlNmdHd3dxT1Fvc0NvWlBrOVhtbTE1?=
 =?utf-8?B?OCtqQzg5NjFub3g0dHlXVXI1MXo0c1M1ajgva3luN3luRmhpN3hZdmp4Nyt2?=
 =?utf-8?B?b1RwUktrN053elE5WDg2Vm80NXR1WFNJaVBwL1lXaW1tcVFoVGR1QUJqakZn?=
 =?utf-8?B?RmxyRmIvamJ6Nm96Vm9vMGxFR2wwSW90V0w3MXRJbVhYdFhsVXQ5STB6QURR?=
 =?utf-8?B?SEVJbDdWTUp3QU1pVWRaTzR5KysrbEdwdHdRbUM2RHRINHVFMGtLZTR6K3pZ?=
 =?utf-8?B?bU92dFplRHJJYXplOFoybTVLeUpOemlsMzZOc0thOEIrdUNwUVVxVXkrMnRs?=
 =?utf-8?B?VGdnNVhnOVBIUHNRZXp6QzY3azE3bGdhVkJQYm5kNmVqK3dvQ2JOOGVPV2ZO?=
 =?utf-8?B?c3JoRVBXeUNsMlZLZW9ZWnNzU3lnRXpVRHNzMU9aeXVOVGIxdmE2Q0U5RHVF?=
 =?utf-8?B?MURMZDIxdElibG84czJRbldva004SmNzbjFjd2Nzc2ZkaTY0a0VzdGxLTnB6?=
 =?utf-8?B?LzI2UzhVQkZQVTlzd1JXWnVac3FiMWxhSmp1a1hPRERJMTJLVHZPYmZsZUxX?=
 =?utf-8?B?TENwNDdtanZraWUxbmZpUTRDOUlNTlp5dnVPZGlNVzdVL25pUXgya2RqMDRX?=
 =?utf-8?B?b1kxNERvY0V6a2tYWGt0NkxETmVVL204NzQveGdoRzUxQXpBcys2OVJjd3Uy?=
 =?utf-8?B?MkhDQXpSOU1wTCtYYkdXem8xSUVBVmd2TW91My9KaWlVY3ZpWW1uRjJEeml4?=
 =?utf-8?B?TzRsbUhQR09zTk5BdTlDVm5ic2VoRWVJd1U2NHNsT2VNWG5PWktaOUxLVWs4?=
 =?utf-8?B?dkFJck9XSWZLS3liVUxiOE1KUU9ra2dCdWk2ZkwyaGY5NmRRdVlSbzRrZGo1?=
 =?utf-8?B?M1U3bjAzSFc1am9JdlhReEY2Q1VUaDBGRDNvNjhHNzBLRVdVbSthYnRQR0pj?=
 =?utf-8?B?SnNIZStzZ05NVlJ1WU9JbzlyMmhreXlvSGM2SG9vdW93azVnOEU4NkVFWUYv?=
 =?utf-8?B?bWxuQXZGWUdFTWVTL1RyYUF2MUMzWllHYU1MUW05SXJuMTZqRjBJZXFUeFA0?=
 =?utf-8?B?TzJVY1lZUy9YSnY5bGxTNnVrRDZNVDVhTDdjdkJMU0Nuc255cjJMaDZxenJp?=
 =?utf-8?B?bDVXOVRRUTVScXVhdTY3eHUvcllLNnk2dk1vZWFMVmdCWkdEeWdCWExoQmRC?=
 =?utf-8?B?dGtjeCthMTBBOEs3eUYxYWx5V29WMGhzaGw1emdPMnJLVE8wcE5HYVRscWt0?=
 =?utf-8?B?dDVsWTVpSDQ4R0tsSk1RZ2xlOTQ3MDdORGVxWXI0UzdpampLakhJYk11Tkp4?=
 =?utf-8?Q?/BG6nF3XV3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjloLytEeXdBK2o3NmU3Z3BMc2tnSkRZcTBmRjM0VHVxTlRrcVN4bXVtbGdo?=
 =?utf-8?B?VllWS1BObUlRbkZqZWRVRDNBaUVSbVM0Q0RpYkNCdWkvQng1enJkVFNub1Zv?=
 =?utf-8?B?NGd2NHN6WnhnVGtpQzlMWndRNFRNT28vbVdiQWFxWDhHV1FseTE2VnFpc3Q2?=
 =?utf-8?B?clY5NklwYVZwVU9YUGp5M2M4aXRkT29xSDZSbFFJSlpPdWtPck1XT3RKRk42?=
 =?utf-8?B?TmNaQzZWUEltMW1MUXRJZURwL3JOOVRESnpLR3NXaXQ2Q2hQd1Zzd1FwcVEx?=
 =?utf-8?B?MFE2YUtjMWZhaDQzckxKZzRuZVJjU0g5eGo2TmFVUVhUV2N6Q0xHdEI4MDJr?=
 =?utf-8?B?dDJDNkxSa1M0VDJHWGFFa25Nd3J3SUR0Y0lDeG9pL2tDNVdOcTNyQlMxQVds?=
 =?utf-8?B?b2VOeHlDZzNFa0M4QUxMaTAzYkpBOHBZQ2w0T05hOXVXOUdsOHErQmVlb3FZ?=
 =?utf-8?B?d29wTUlyTUU3Ry9UNm01bEQzUlMwS2JwNHRGazdGY2szUEtqVVNSTU1yd1ha?=
 =?utf-8?B?aFVmQloxRGFjN3kvdFJkL0o1eVl6Zyt5YlkwTU00elE3a3R4R2pzMUI2cm9l?=
 =?utf-8?B?M1ZzcXFONzFzNElXUERxQ2FvcmFYa2FhbWZJVEZEOTN6aHBNQlZLYk4wY1c3?=
 =?utf-8?B?c3RzOVIzSzFKSTI1TmNLcVZSUE5iMGxrSVEzck9qZlRBTXk4Z3lRdEo0ZHQv?=
 =?utf-8?B?ZU1mNjRyTzMyajd3N0pPYW0vWGpqYVQxaUR6RHNTVXNaQVJRUFdab1JvQnBF?=
 =?utf-8?B?OHZOY2ZBb3JQWTBManA2SnFLWHBORXhNUHgwZXhFNEh2RTlRbE9BelBYUVVI?=
 =?utf-8?B?K0hLY0Z2bUNTTEt6OG12NEtqL29SaEg3Q1hqVWtxODJNK1h4cHdYR0REeHdM?=
 =?utf-8?B?Z3VnVzZsNGsxM0l0UmdvRTVMV2hWdVRYak4yV00yOHpLUU1CYytETnMxOXgv?=
 =?utf-8?B?WEs3MEVPT3ZlT1BnQ0FxYUhad2h4byt5SjMrVmpSMkR2WnFTMXV5ZGlPZGZh?=
 =?utf-8?B?aGhHL3dnTjVINGxpZndZd2w5ZWtBTHlUYU13aWRiaWdkNnFxejROVjhTTWJw?=
 =?utf-8?B?Q0t0eTBia2lvM3pQQ3d4RmVrL3FJaGE5TE5wRFV1WWZraEcyWHhreERDeWhO?=
 =?utf-8?B?a1pBdStnYSsrdkF0VzBsUUhUSzRYRmtSandxbGxHVW1hakh1MEZWd2ZiNzM2?=
 =?utf-8?B?ak1lY3JFYUFkclJrT3VLN3pFRnlxOE1ydlJlQzJPbTE1VzNwZE0rUTIzSnZh?=
 =?utf-8?B?QUlvVFpua1NhUzBGOE9QdTFWdlRCQktDek5rblJBKzg5bEc4cGhqOFBYWlho?=
 =?utf-8?B?YVk0TlNObDV0Q2xuRUVuVE9JVUFJaFJMeStFOEdhVWhhbUYva0t1OVFwVFp1?=
 =?utf-8?B?Q1VSZTJXSlloQ2ZZeGZabTJsSTllUnl5bGdYd2JhZU1XYldGUEczbGN6V3VQ?=
 =?utf-8?B?aGNqR0MvSnorSmkrdmE5dW1BYk9Ha1pRQk4xUjhHTElacm9ZYTNCYzBWOUJ1?=
 =?utf-8?B?dkh5N2t2NkdTNmdlNkVSalVrNkR3TERaUC9IWWlNQXZ2QVhxMi9XMUY5SFlQ?=
 =?utf-8?B?RUI0WGtmdnJjN2VmU0piQjdRWk5STmhPb3NJbGdaeVNTTTB6RjY5Mjh6dUJC?=
 =?utf-8?B?MFVRZUhPbnU4cUZkbHdSNnNwWHZCL2hmOG11YnVyZHBtSTZ1eXZtaTdsUE1y?=
 =?utf-8?B?bzZEZUlWRXUvSDRXZUI3WGhKNWpYb3ZzRTh6dEtBNXhFakFtTFYxSDhMN1Zp?=
 =?utf-8?B?VitrcHVhZTlKZzI2RG0za0M1bnYwNW9FUzlJc1lPOC9rUVpva1l2WGJmV2JV?=
 =?utf-8?B?VjZsMGpaNWlEK2U2T0Fud1dKWVpiUGVCUTZBaThxblQxSGc4Nk1mSURMY0xu?=
 =?utf-8?B?UytqRWFnVlZtNXdVSTF2ditqa0tERm5pQnlNUEVMVVZ1R2ZiWS9OaVdabUl2?=
 =?utf-8?B?OUlMSzhJWTdiRVptYXdJT0E0Tlk0bklBL2ZCS3JpKzdWMFpvRGZMdWoySkFT?=
 =?utf-8?B?TkZWaEM1bjlacklpM1RCejhLUno2NCtCaE9maVI5ZWkvRVFMd1NXc0dSV0Ew?=
 =?utf-8?B?dHZiZTNlaVNQczlXZXc4Tjc0ZldmQWRaRTNDREdJbCtSVlVxNVVLRzdlZktK?=
 =?utf-8?B?NlV1bzB5NDdHN2hXTnRMem53S1hsSVZxa2dlVlJSNUxWdEtLbkFuQzRaUEU1?=
 =?utf-8?B?SEl5dTZEa2tsbUp5TG1CTnlyOExsektaejFZZmY0WG13WmhqYm9sVnIxVE9Q?=
 =?utf-8?B?dlVOWGdIQ0hoV09odUdqN092TUFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5924872a-47a3-4881-173e-08dde38b54fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 03:56:12.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvncah+JXWqehO+5S3Qvu5wg7rz7gdX7LqXnZ6JCYnrqhGdI0vAZKibipYxZ7QJUod0wrGrZUEW9+U+Jw4qGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

On Friday, August 22, 2025 2:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 05=
:58 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.
> > >=20
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >=20
> > >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> > >  drivers/cpufreq/tegra124-cpufreq.c   | 5 +++--
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > b/drivers/cpufreq/cpufreq-dt-platdev.c index 18942bfe9c95..7d15a1224d=
37
> > > 100644
> > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > @@ -140,6 +140,7 @@ static const struct of_device_id blocklist[]
> > > __initconst =3D {
> > >=20
> > >       { .compatible =3D "nvidia,tegra20", },
> > >       { .compatible =3D "nvidia,tegra30", },
> > >=20
> > > +     { .compatible =3D "nvidia,tegra114", },
> > >=20
> > >       { .compatible =3D "nvidia,tegra124", },
> > >       { .compatible =3D "nvidia,tegra210", },
> > >       { .compatible =3D "nvidia,tegra234", },
> > >=20
> > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c
> > > b/drivers/cpufreq/tegra124-cpufreq.c index 514146d98bca..6ff2ccc08e5e
> > > 100644
> > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > @@ -189,8 +189,9 @@ static int __init tegra_cpufreq_init(void)
> > >=20
> > >       int ret;
> > >       struct platform_device *pdev;
> > >=20
> > > -     if (!(of_machine_is_compatible("nvidia,tegra124") ||
> > > -             of_machine_is_compatible("nvidia,tegra210")))
> > > +     if (!(of_machine_is_compatible("nvidia,tegra114") ||
> > > +           of_machine_is_compatible("nvidia,tegra124") ||
> > > +           of_machine_is_compatible("nvidia,tegra210")))
> > >=20
> > >               return -ENODEV;
> > >      =20
> > >       /*
> >=20
> > I also prefer using Tegra114 and Tegra124 in the commit message, perhap=
s
> > with the marketing names in parentheses, as the chip IDs are more
> > consistent and (IMO) easier to decipher than the product names.
> >=20
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Yes, this was applied in v2 already and all other my Tegra patches,
> this exact commit was already picked from v2.

Ah, sorry. Not sure how I missed that.

Mikko




