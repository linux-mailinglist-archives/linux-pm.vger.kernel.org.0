Return-Path: <linux-pm+bounces-11956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BE949D22
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326FD285190
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730718C36;
	Wed,  7 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cfIJ98Jw"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD7F9;
	Wed,  7 Aug 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991915; cv=fail; b=HyWafXC/0NF0D9m93tHaYP9C3ke6sygcaMai5vP3F/TaWxsOyqo6g4t9X7qV6aeaBhxnrSDFm9yrn1VF+K+PTMuHjUmINCl9n+cwjvNFwh8N9O2SASma8QrAzIcPXQVqiezQG5s+ZcZtqeFk95JOjh2+lhoIx6EyDdJS9pTcw/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991915; c=relaxed/simple;
	bh=8SGzBo/iBE24yrhM/oJXcFVxocqyStXSjGGmATUattE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNgQ1TnxdZCThuKo8cQXAUjA4JEF0AHrwdCo835cds4Vsxss3Mlx3hlk4QVPg3s+4KpsUvG3kQmLQuNKbkQgGWPmQfiVZF8qVtXFesrIOyYjBNeZvukxLPED0R7XZ5bAV4GyTECldYUn4tVevvjNWECAY62K3V8HIuSon24dGxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cfIJ98Jw; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXqASx8VD05QM7epl6vqbhHzccfabDE0P7eqNvMa7Ql5ODP0Ub5i9Wh9FWDVyCos4XB7v+qeQFyFJ60uP0JfMYWdWvptyu9AmMFixSgr/54sHw4UGD9tm5vtmesnVROLrYdlNp8o7Vk9S8g4Q3/Uum5ZKJ4n/LH73GRvC3mReP9dF7UaHPdexBQ+SAQYAVDQHhsPlASocqqenqc5d5lZRuk4vceId2LRdt7nWFmEZsiHKjN79NGY8EDjRPfuB/tnGDtb4DyWcxPdl3Xr+5qpGuODkCQNOk0RlhUCeE9NFM3KxW9H26KNN4Bsix9zMPjbak9Lmu5nFgxNDu2b3+IUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SGzBo/iBE24yrhM/oJXcFVxocqyStXSjGGmATUattE=;
 b=QlCVhvrH41tJhB60W6PMAwMGtwx7LctLl07ZXN1fKJkXIZQjUiZ0gE3uJh3nBItlH/RIc4ZIPEOMeIxyFzdm2iCTagTC4capHtXs73P9akQ4FJpvOzV3684c2NSMzZzqDH79L3r3G3pP3kKHnKb5U7t0VGpDtIOkhCYkBeuNCIPQarRj5GdJ/WhRMPm+ecPO37NgDipz3vB0XS/xCp73wlyXUxG+8OxG/2axGXALYTpOahZH5PKSNZFWAAx3gsTEvExVrwjr8tihurryOLue3xdcRqw/DTQxkdoxw2ZyLZJSprsDPY2cloHDsLti0nWSx/2yhNm77fMAno3zpSf6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SGzBo/iBE24yrhM/oJXcFVxocqyStXSjGGmATUattE=;
 b=cfIJ98JwsCGaWhIdnk7Dw8laXfBJXs1e/UgSfwQNXjRULDTMa/MsVHSgfIDWF/uU+dHq/GxOLIGn1/5myq5RJZsvUgGN3wD9nFc2r37uzPKYmvwUgMNCb78tlmFvIt/e39ceu6A77SCI1jqYLA3L8oTUuixoqbhPMFo1TKNMGRAnMbnZnQZL1EERvBSFczWg61ima7V5WdghcUtXRwnMhoi1Zon0mZ8TUEyAGKkbAWhIZ8OSx/+1gjnapgJYhU33LNedYjK6f9OrHF5wd723/+CJnutJBhzGgjFkGHYfhOazxR6DFOv1CcdJPt7oK3NBkfZOf1BkRbV7MLV0c8g3XA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 00:51:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Wed, 7 Aug 2024
 00:51:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sibi Sankar <quic_sibis@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_rgottimu@quicinc.com"
	<quic_rgottimu@quicinc.com>, "quic_kshivnan@quicinc.com"
	<quic_kshivnan@quicinc.com>, "johan@kernel.org" <johan@kernel.org>
Subject: RE: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Thread-Topic: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Thread-Index: AQHazT9p6C0PxxkatEO4mequZ+3e2bHmYHMAgAEg5ICAAJwBgIAEhVMAgC6GfDA=
Date: Wed, 7 Aug 2024 00:51:48 +0000
Message-ID:
 <PAXPR04MB84596E444B690924998D734C88B82@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus> <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
 <Zofvc31pPU23mjnp@bogus> <48ac18f3-b831-91ab-4993-d82749052d8d@quicinc.com>
In-Reply-To: <48ac18f3-b831-91ab-4993-d82749052d8d@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8923:EE_
x-ms-office365-filtering-correlation-id: 27172eb2-63c4-408a-b64a-08dcb67b1e43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWhLSXdTbitDL1ZwZTRqdjZUWEVjTmdLQkdoK1pWWlJVQWJoUE45d2w1aFg2?=
 =?utf-8?B?Sk81L2x4ZWE2Y204YmZKR0phektDSUNnWG4veThRVHJKTnRaK21RTlY1N0R5?=
 =?utf-8?B?UHhFakhlNXhzaHFweXVPQThsNjIydEdGck9vTHFmYzhGdzAyYmFvUzAvaEYv?=
 =?utf-8?B?RDlacHhCaEF1bXo5c0pmN3NyTzFsbnRtREZxVDQvNUhyNlRHdGExbXV4Mndo?=
 =?utf-8?B?RWNpeWtZbVo0Y3dMc1lid2twVnRQclErY2gzclRNbldOUkdWeGkvTURXWk1j?=
 =?utf-8?B?UlVGNWx5ZGt6eldyb1BOR3ZYdWUvNFNuempBVVpxK1drRG9PVDl2MjMwWU9X?=
 =?utf-8?B?ZXBzVzR0NWc4bEJvTHN4ZUQ4WUd4OHRCZkJTMnJ6eWl6NUFMY0xLbTNXd2pU?=
 =?utf-8?B?MDZiQTRteUxqM25qVEV5ekxsRVMxSnh1cC9JbXRjM3o3cmxKSFh6Y3FQZnlu?=
 =?utf-8?B?U2hWbU1LR3c2dlNiWi9MMGNFWXVmWEFmQVN6SDN1NDFBRk4ySXRsWWVYOXhP?=
 =?utf-8?B?bVpkd1RPR0dqMmtCSWdtbDl0YlFXNlA3OXdpV1JjNkpQRWZINXBBS05tL2tR?=
 =?utf-8?B?VjNwNXd6RDRsUm9JVEhWUlFWNk4zeVRYYUg4OWNqODc5VmljR1BaSXBwYmR3?=
 =?utf-8?B?SzBtdVoxSmZFUjh0MUZzY2t6VzdJNml4VGU5TTV3VGJ6OXVzSmVRdXhIMzZ3?=
 =?utf-8?B?OW90RFRRbGJ0R3Q4bVRKQjVxYWdzREtBY2pIRmVzNnQ0MkFEazN6bDFzTzhs?=
 =?utf-8?B?c0NjVzZvclg0TkRQODE5OGxUNi81S2hiWEZjVXovdWFLMmFzdlQyZFROdzhr?=
 =?utf-8?B?VHZaZ29uMkkxbjlrbTkzVVBQN3FPeC9rVVN2cFJacXZraFRQU0hRRElCY0Ev?=
 =?utf-8?B?U0tXODRNdXV3L0pPSTlZMFFoZTd5NWdXSTM2V2VxK0lOaFJ6djNVc2RSdk5P?=
 =?utf-8?B?ejJrQjJHalA4eHNBdzVQcTd2WFl3L3BoeVFoVUwvV1NpTXlOZitJdHovRnFL?=
 =?utf-8?B?eTZjWEEyK1VPcmIrOFpwbGZDYkdIdFdKbFAvZXFyTU5qK3ptN0tXbHV1aUFL?=
 =?utf-8?B?SXBrVVhadk5kZUlqcmxyb09oS1hxOTN2RUE2S25HQ3M3aXp5M05wMWFSTlZo?=
 =?utf-8?B?MnJqemFRdGVvQjNFOHpTaFVkVW1kRFZTRWtKeUtrcFZ2bDNiV0RsVGU0NHhl?=
 =?utf-8?B?RERUV2JJYzIvNTZYbjBEeVloVjlkZTRCVlJCalV1SExhWnBlZlpCUnkxYk5n?=
 =?utf-8?B?Yk9vRmRQVDZGY0JUb3JwckZqa2lILzV2ZzVudXpKczcvMzFOdi9peWk5eTkx?=
 =?utf-8?B?UTlhY1VyZS82RC81ajZRSFp5Y1orVVRSVmMrc29uK3hvTUZWdTU4ZjdoZm9k?=
 =?utf-8?B?NlBSMjFlY2IxZjJrQjR1MklVZVlYbGMzSnJrdFRmSFZPdzNtMWh6QTZCVVl3?=
 =?utf-8?B?cFNKQ0k3ZHN5MlJ1cW0vZEpsbVhuWXhSbU9wUkJlelZqVzdJTjlaRmFOTXlZ?=
 =?utf-8?B?WFJxOE5FRnhhcGdJeDZSeXV6OW5Rem9KWm80QjM3eERGcWlXRUkraFBFKzFz?=
 =?utf-8?B?RWFwd1RvU2E4cVJSbzRNS1hENzRCN21Wbm1GdlBHN1lCZmIzZjJzSzhDcDcz?=
 =?utf-8?B?cEF5clRRSnlTSmljS2xvUXQwbUNJNXZJMHBabFZtUFZkZXp0L3l5ZU9FQXdI?=
 =?utf-8?B?emZNdjU1VENublpPZkFIYUFaQWZoRFBGa2dCeVFzQk95UnRpU1BDU3VkcTBZ?=
 =?utf-8?B?WTMrQTVEcm95eWg4UEJNa3NXS0tFa3F6WUp1VG9SZXJlYUZaUUFKTkVKaEg1?=
 =?utf-8?Q?uyT6mpxLCH//BTJdIBA2+zvTPv6jEKZ116rWI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFNEVzRGYkovQ2dPWkVUcVdBWlNreTBnQkd4L3pRSWx2VEFXcWc4UVdZeU8x?=
 =?utf-8?B?Zm1GSVFibWV1b0ZkT3pQQlpCQXJzaUJ1QU5IL2dGTnpKZy8zNG92TjFxSjhR?=
 =?utf-8?B?a2ZFVGl3UXVGaElvb1ArQkVTaHNmWUNaVEJ4akdEMDNQUmFVa200bUFxTldo?=
 =?utf-8?B?RktmMmxEVkl2VzBiRm1uV28wVno5SzQ1RzVQa1hJa2w2SEJRTGcweHJtc3kx?=
 =?utf-8?B?UHdpNTdqVmhaRlEwZkliQ1BpOVFRY3k2Q3RvK0dZdlpJYWdmSVRNMDVYYXV3?=
 =?utf-8?B?bU9iL0ptaVlOaTdBckRMdmxNMjhHa3NMSk5VZ1JaaGJHVkFIWHB3YWR6THlZ?=
 =?utf-8?B?UXUxSGRXdDhscmFRMHJiRG1TUUFGaUcxMi9YV3Z4VzBQZU5GeVFOb0pvYXFn?=
 =?utf-8?B?eGFJQXdXKzlPeVd5RzVZWkpua3NnZ1V6VDVHLzhWdXZCTzN0UXhzMHoyejFR?=
 =?utf-8?B?Y1FMN3JQMWRnM0RVTVdNbEJrd1h3d3VGaHQ5bWJrQk92blZXME1aeUZITWMx?=
 =?utf-8?B?cy8wc2VkVW11RGo4T0QxK2FEOEF4VXNSU1FiMExBaGdtMGRrK1JUWFNqU3E2?=
 =?utf-8?B?c3NKV2VuTlJPMnZ0ODd1Z0kxTHVjcE8zV1RuSzBDMzZYWmZqSmY4TUNaQ201?=
 =?utf-8?B?VDg3QkswVGx4UUtIc0RidmppaVY0Vm82S3F0SGZmRW56azFmQWo3ekdKTjU2?=
 =?utf-8?B?dk92RG9jZFBhZlNKdHFSSEhxMVdnNFV4SlVUN2VkcjRjcWVJZ2xYRHROTXBo?=
 =?utf-8?B?YjlVeEJUS1crK01YWjB4UHZFcEN5YmJ4MFF6ZFFya04veCtva3d4SFVVVDZn?=
 =?utf-8?B?QXJhSk9qSnFQYXdwTSt2K3gveFNMbHhrNmRGNXFuaCtmZFI2UndBSW1lNlVY?=
 =?utf-8?B?azJHR3FPVnViTC91MjhCMDVsNGlmb0oxUURLUktCdmdmcmMyRFR6dWE0Umdv?=
 =?utf-8?B?WnpZQ0pGRE5aVk5qeFNWb1YyYXFHT1U2UmJQL252TmlVR01xb2NDbTA3dUU4?=
 =?utf-8?B?NFdXOFVzSEptWURsUXI2N2hma3hsN0JxSTExdDJkOEpvenBoU2hmSkF4akJD?=
 =?utf-8?B?UVhGOTY1Z0VWd2xzMU0vQzQvWkdYNmlJM2J4RUNKc0V3dUdwUEE3UGhjYWJD?=
 =?utf-8?B?ejdKTmJBUURlUUxkcTFNaWhtQ0FScElUaFhvd0g3cGJ5WmdnZVhXL3lOakEv?=
 =?utf-8?B?Uzd1cGtLaGpaRVpONEZrTG95Z2VCeGNuelY1RUt6eUs0cmM2a1k5RmhqTUNW?=
 =?utf-8?B?Nm1NNjdRR3dWc2szSHVhSkVDaENwUlo2SnZjRDE0b0FDY0l6TFllbWdyOHRN?=
 =?utf-8?B?Y21CbWJYMllnTjF4RjVCZVdNUG9OV2paUkswZk1mak1qaW9xVGp4eWlrbVZE?=
 =?utf-8?B?dTJTdHFNYUNvN3V4SnNaZUtGYzFrS2w5eDlQcmtLbXRXNWp5SkREeGhPWEdZ?=
 =?utf-8?B?R0gvNVloeW9EWTRkWkdWNlhYckU4Z01mckVDUHlvbHl1cVN5d0RUVFpqVHlJ?=
 =?utf-8?B?WnBMUVdyM0dpODdIaG5ZZ0RKNURzQU0zR1F2MDZxS3JlZVBtSWdnVzdVY2dk?=
 =?utf-8?B?Q0ZWemJxeUFCTjNMUFFNcGF4REVHQUR1d1M2U1dxL0ZuSE9tUzV5bHRzU3BQ?=
 =?utf-8?B?LzJldFVFaXlpOEhWK2FSeHNnbFA1clg4ZWRBWDNaOWRvK0UxeEtFcktzVEpa?=
 =?utf-8?B?RVJSOWQvZmljTlpZcmhSMDBOTDVMSENKcTlxMVdKZmJjaHRSdjRrM1RBT0JD?=
 =?utf-8?B?NW9jbXdFT3RGSEhTdlFRWWtsRExNMjVsNmVMOHB1ZlQvVWlnTDdkOEN5OE41?=
 =?utf-8?B?Mi9WYnB3K294Uzh2aE95NmZFNUF2MU5JR1U4VEtSNGluaUFLVXlPV1Z4YkpP?=
 =?utf-8?B?OVJJcE90Q2tZUDZkODNhREY1RHpxdVJUd3cyWElVYldEeEswTlpFY2hFSVFr?=
 =?utf-8?B?emQxQ3FzMmxSOWNLUGprY2xwcTFRbXNBWEpxeGdpdFFVNGc1YnpjNTl6dlU4?=
 =?utf-8?B?Qk1Cb1pxZ0JwQkhNOFBXRHo3SVEwL0VuSlU3YmdtdzhQNGY4NUNjNmtzSEc5?=
 =?utf-8?B?TG84MEtFQWgrYzN4ZDdZVG1CNys3UHNIcWs2K29CU3FFRityWlFoM0xYZVEv?=
 =?utf-8?Q?Qs04=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27172eb2-63c4-408a-b64a-08dcb67b1e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 00:51:48.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxJO+fFAkOOwNf/KJG7neSGRAXiLCO3JCNMLVnkYXj5h9XWSL9whM2Tu1FmMSC+5mHY1CKqbiJwqT6fvpb41Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwbWRvbWFpbjogYXJtOiBGaXggZGVidWdmcyBub2RlIGNy
ZWF0aW9uIGZhaWx1cmUNCj4gDQo+IA0KPiANCj4gT24gNy81LzI0IDE4OjM0LCBTdWRlZXAgSG9s
bGEgd3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMDUsIDIwMjQgYXQgMDk6MTY6MjlBTSArMDUzMCwg
U2liaSBTYW5rYXIgd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDcvNC8yNCAxNjowMiwgU3VkZWVwIEhv
bGxhIHdyb3RlOg0KPiA+Pj4NCj4gPj4+IElmIHRoZXJlIGFyZSAyIHBlcmYgZG9tYWlucyBmb3Ig
YSBkZXZpY2Ugb3IgZ3JvdXAgb2YgZGV2aWNlcywgdGhlcmUNCj4gPj4+IG11c3QgYmUgc29tZXRo
aW5nIHVuaXF1ZSBhYm91dCBlYWNoIG9mIHRoZXNlIGRvbWFpbnMuIFdoeQ0KPiBjYW4ndCB0aGUN
Cj4gPj4+IGZpcm13YXJlIHNwZWNpZnkgdGhlIHVuaXF1ZW5lc3Mgb3IgdGhlIGRpZmZlcmVuY2Ug
dmlhIHRoZSBuYW1lPw0KPiA+Pj4NCj4gPj4+IFRoZSBleGFtcGxlIGFib3ZlIHNlZW1zIGZpcm13
YXJlIGlzIGJlaW5nIGp1c3QgbGF6eSB0byB1cGRhdGUgaXQuDQo+ID4+PiBBbHNvIGZvciB0aGUg
dXNlci9kZXZlbG9wZXIvZGVidWdnZXIsIHRoZSB1bmlxdWUgbmFtZSBtaWdodCBiZQ0KPiBtb3Jl
DQo+ID4+PiB1c2VmdWwgdGhhbiBqdXN0IHRoaXMgbnVtYmVyLg0KPiA+Pj4NCj4gPj4+IFNvIHBs
ZWFzZSB1c2UgdGhlIG5hbWUod2UgbXVzdCBub3cgaGF2ZSBleHRlbmRlZCBuYW1lIGlmDQo+IDE2
Ynl0ZXMgYXJlDQo+ID4+PiBsZXNzKSB0byBwcm92aWRlIHVuaXF1ZSBuYW1lcy4gUGxlYXNlIHN0
b3Agd29ya2luZyBhcm91bmQgc3VjaA0KPiBzaWxseQ0KPiA+Pj4gZmlybXdhcmUgYnVncyBsaWtl
IHRoaXMsIGl0IGp1c3QgbWFrZXMgdXNpbmcgZGVidWdmcyBmb3IgYW55dGhpbmcNCj4gdXNlZnVs
IGhhcmRlci4NCj4gPj4NCj4gPj4gVGhpcyBpcyBqdXN0IG1lYW50IHRvIGFkZHJlc3MgZmlybXdh
cmUgdGhhdCBhcmUgYWxyZWFkeSBvdXQgaW4gdGhlDQo+IHdpbGQuDQo+ID4+IFRoYXQgYmVpbmcg
c2FpZCBJIGRvbid0IG5lY2Vzc2FyaWx5IGFncmVlIHdpdGggdGhlIHBhdGNoIGVpdGhlciBzaW5j
ZQ0KPiA+PiBpdCdzIHBlbmFsaXppbmcgZmlybXdhcmUgdGhhdCBhY3R1YWxseSB1c2VzIGEgcHJv
cGVyIG5hbWUgYnkNCj4gPj4gYXBwZW5kaW5nIHNvbWV0aGluZyBpbmhlcmVudGx5IGxlc3MgdXNl
ZnVsIHRvIGl0LiBTaW5jZSwgdGhlIHVzaW5nIG9mDQo+ID4+IGFuIHVuaXF1ZSBkb21haW4gbmFt
ZSBpc24ndCByZXF1aXJlZCBieSB0aGUgc3BlYywgdGhlIG5lZWQgZm9yIGl0DQo+ID4+IGdvZXMg
dW5kZXIgdGhlIHJhZGFyIGZvciB2ZW5kb3JzLiBNYW5kYXRpbmcgaXQgbWlnaHQgYmUgdGhlIHJp
Z2h0DQo+ID4+IHRoaW5nIHRvIGRvIHNpbmNlIHRoZSBrZXJuZWwgc2VlbXMgaW5oZXJlbnRseSBl
eHBlY3QgdGhhdC4NCj4gPj4NCj4gPg0KPiA+IFdlbGwgSSB3b3VsZCBsb3ZlIGlmIHNwZWMgYXV0
aG9ycyBjYW4gYWdyZWUgYW5kIG1hbmRhdGUgdGhpcy4gQnV0IHRoaXMNCj4gPiBpcyBvbmUgb2Yg
dGhvc2UgdGhpbmdzIEkgY2FuJ3QgYXJndWUgYXMgSSBkb24ndCBuZWNlc3NhcmlseSBhZ3JlZSB3
aXRoDQo+ID4gdGhlIGFyZ3VtZW50LiBUaGVyZSBhcmUgMiBkaXN0aW5jdC91bmlxdWUgZG9tYWlu
cyBidXQgZmlybXdhcmUNCj4gYXV0aG9ycw0KPiA+IHJhbiBvdXQgb2YgdW5pcXVlIG5hbWVzIGZv
ciB0aGVtIG9yIGp1c3QgY2FuJ3QgYmUgYm90aGVyZWQgdG8gY2FyZQ0KPiBhYm91dCBpdC4NCj4g
Pg0KPiA+IFRoZXkgY2FuJ3QgcnVuIG91dCBvZiBjaGFyYWN0ZXJzIGFzIHdlbGwgaW4gYWJvdmUg
ZXhhbXBsZXMsIGZpcm13YXJlDQo+ID4gY2FuIGFkZCBzb21lIHVzZWxlc3MgZG9tYWluIElEIGlu
IHRoZSBuYW1lIGlmIHRoZXkgY2FuJ3QgYmUNCj4gYm90aGVyZWQgb3IgY3JlYXRpdmUuDQoNCkFz
IFNpYmkgcmFpc2VkLCBTcGVjIGRvZXMgbm90IGhhcyByZXN0cmljdGlvbiBvbiBuYW1lLg0KDQpM
aW51eCBjaG9zZSB0byB1c2UgZ2VucGQgdG8gc3VwcG9ydCBwZXJmIGRvbWFpbiwgYnV0IG5vdyBp
dCB0dXJucyBvdXQNCnRoYXQgTGludXggaXMgZm9yY2luZyBmaXJtd2FyZSB0byB1c2UgZGlmZmVy
ZW50IG5hbWUgZm9yIHBvd2VyL3BlcmYNCmRvbWFpbi4gVGhpcyB3aWxsIG5vdCBjb252aW5jZSBm
aXJtd2FyZSBkZXZlbG9wZXJzLg0KDQpGb3IgZXhhbXBsZSwgZmlybXdhcmUgbWlnaHQgYmUgYXMg
YmVsb3c6DQoNCnN0cnVjdCBwZF9wZXJmX2RvbWFpbiB7DQoJY2hhciAqbmFtZTsNCgkoaW50ICop
cG93ZXJfaG9vayhpbnQgaWQpOw0KCShpbnQgKilwZXJmX2hvb2soaW50IGxldmVsKTsNCn07DQoN
CkZyb20gZmlybXdhcmUgZGV2ZWxvcGVyJ3MgdmlldywgbmFtZSBpcyBzaGFyZWQgZm9yIHBkIGFu
ZCBwZXJmLg0KVGhlIGZpeCBzaG91bGQgYmUgaW4gbGludXggc2lkZS4NCg0KPiA+DQo+ID4gU28g
SSBtdXN0IGFkbWl0IEkgY2FuJ3QgYmUgYm90aGVyZWQgYXMgd2VsbCB3aXRoIHRoYXQgaG9uZXN0
bHkuDQo+IA0KPiBPa2F5LCBJIGd1ZXNzIHRoZSBjb25jbHVzaW9uIGlzIHRoYXQgaWYgdGhlIGZp
cm13YXJlIHZlbmRvcnMgZG9uJ3QgY2FyZQ0KPiBlbm91Z2ggdG8gcHJvdmlkZSB1bmlxdWUgbmFt
ZXMsIHRoZXkgZ2V0IHRvIGxpdmUgd2l0aG91dCB0aG9zZQ0KPiBkZWJ1Z2ZzIG5vZGVzLg0KPiAN
Cj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gcmVnaXN0ZXIvZXhwb3NlIHNjbWkgcGVyZiBwb3dlci1k
b21haW5zIHVzZWQgYnkNCj4gdGhlIENQVSBub2Rlcz8gDQoNCkhvdyBhYm91dCBub3QgcmVnaXN0
ZXIgZGVidWdmcyBmb3IgcGVyZj8NCg0KR2l2ZW4gdGhhdCBzY21pLWNwdWZyZXEgZG9lc24ndCBj
b25zdW1lIHRoZXNlIHBvd2VyDQo+IGRvbWFpbnMgYW5kIGNhbiBiZSB2b3RlZCB1cG9uIGJ5IGFu
b3RoZXIgY29uc3VtZXIsIHdvdWxkbid0IHRoaXMNCj4gY2F1c2UgYSBkaXNjb25uZWN0Pw0KDQpZ
b3UgbWlnaHQgYmUgYWxzbyBpbnRlcmVzdGVkIGluIFsxXSwgd2hpY2ggaXMgYWxzbyBzY21pIGNw
dWZyZXEgcmVsYXRlZC4NClsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDcyOTA3
MDMyNS4yMDY1Mjg2LTEtcGVuZy5mYW5Ab3NzLm54cC5jb20vDQoNClJlZ2FyZHMsDQpQZW5nLg0K
PiANCj4gLVNpYmkNCj4gDQo+ID4gLS0NCj4gPiBSZWdhcmRzLA0KPiA+IFN1ZGVlcA0KDQo=

