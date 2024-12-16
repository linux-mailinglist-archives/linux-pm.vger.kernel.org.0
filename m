Return-Path: <linux-pm+bounces-19274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA19F2A35
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8F188573C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED931CF5EC;
	Mon, 16 Dec 2024 06:31:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020136.outbound.protection.outlook.com [52.101.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43B1CEAC2;
	Mon, 16 Dec 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330699; cv=fail; b=rgwJ5p89R8YmFaI1tQLBMatHZIYrr4MENXpP0TqBQJo+BzPrwLsFdcwjx5IwTDdbJCQIRN9+JmZwDKJ1f5BS1kEGC0j2RfBn7n/IbW1gwednpQNe3KzCvuFBZjUjbksFIuFtp0j9cnlfae4ZO6udY+cKJGR3ipIYUtfbUkAz4d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330699; c=relaxed/simple;
	bh=vC1imlSSJ9E87XmREUNZgeqAbrRknqz6UgCT/WwbLNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxW/6G1OfqAjJUmludueDgtWH1OE0qhKuJ9OOLGxFdmbbbaqs/M7E8SS7ciRFm7rQf4zi/GdyGOsR9YSdoVJM1n5u9yZHL4/s/lYEl7L3TWlnFHyxyp3+GPumOHncxG/3oOrSknqXctJF60R15jNC/zz976jQHABN+7CXEGJfIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3amEoKviiMNSQ4XVRIFCFiqdDRv5B7XlF/dMCJ0/ObwDZ4w0dbFn0D3wACAJxjy4S0wcch2CHzSx393TBWnhwGMMzyh+NQp9hcfVxTAk6RRfE2AGytr0zA+mk/HvJCWO1lRFzZWG3fYw6px9CyR1BupeTZkjK5+Dmv4F+YWHYO/8kFsP1LYP11kI8NsbI5At/N7Xe/NDMIObXF45dZOxdg48zLpi8aTJWMECG3N1vpquETMArk26mYYSOEnwzaaYrzKDg5+hBdh2C2CUpfy24zIHj4IFiMA6RTli3IjLEEWEhOyLeN21Q0pHUBmQGsElmZi1EmBECCzY0+S/wRyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb8pYtOrssA3AN0thHgei6CHzNFOgoqW7893aMsvtGs=;
 b=BRUPCYfzU9GacTXW+VGW+czgawtoFoROJ4Bd4Dssz6W2iqW6l8j3oNCrn+cvwyZcGJSObeyIXYOibb82p8dkd3ykNHSQJGY3jW7UJzR/feGHMruJLTDilVskIgclZA05v5Id17fLCyy2UEVk20Wi3Ca7VIfcRFJm8ZidVbqm0HPOjSDbi9VgTx6469HDXxOS97Pp6V6PoMCPcOuEa9MfwsJ2Lj7LAQXMFsC2MoKysy+8DC7f1pbYpTH0BKX4UNb466bgmsx7XPuQztkH9dvN0HOSFd4ohRhn8CSIusAPYufrWjEC9YEkZGcba7XEzmKkZzTdDuwMbUws0kCZBa/9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN3P287MB2154.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:31:36 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:31:36 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Mon, 16 Dec 2024 11:59:17 +0530
Message-Id: <20241216062920.7228-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
References: <20241216062920.7228-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN3P287MB2154:EE_
X-MS-Office365-Filtering-Correlation-Id: 17604d8b-b608-43cd-9bec-08dd1d9b4a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YitLbDdIZ2pBRG9aRlQ4N2xBTjhCQ2JGVFlxL1RxYitKcGVHcGJvaVRIdWRy?=
 =?utf-8?B?b1lJc2JZQ2FoMUltWHhxL0VYSXJRYzh4V0tQNW1CVm95UlgwMldscFBMQkhU?=
 =?utf-8?B?bFVMc3YrNkpldFVWdWxjQlp3RjJ4Z3V0NE82dnQwRk15ajdzaWJTTitHZDMr?=
 =?utf-8?B?clc5V0xlMmZZVUM5bzlGNEVpNmxGNTNRa2FmMUZmUHpOTWJCUGMxZG0wMzYx?=
 =?utf-8?B?WHdnWDZCazRNTFpMT3FiU25vbk1oa0traWJWcjNyVFBTdXFvV2h5Q3haZVNK?=
 =?utf-8?B?TWhRdVYxUnk1akttMnlkek9PMEJyUHliWVZxR0JUOVJuYi9tNmZzMjg3VGtO?=
 =?utf-8?B?VWUrQlMvSkt0elZCSDBOdnVSYlNJL1ZhNDlONkVtSFUrZlV1b1dNWk5NamtV?=
 =?utf-8?B?UUxtT0Fqdi81dGE0dnVYdkVvd013QXMycG5WUmxrSmRaK1FURGJLK05rSkpv?=
 =?utf-8?B?NlZBQmpnUy9qQ3lkcWh2NmlHRXZQRXVIY1ZyYWdBT0JIaHRQZ0VUM1pQVks1?=
 =?utf-8?B?VmpXZ0pWSnRmWmp2UTk5QUlDZjZLdk53OVNBTTZwQk50MFlYQkhZb3pGZUdX?=
 =?utf-8?B?STQrL1dNZnhFN1R3MzVIMHVjNWZFN1UzVWNwSlNCdDk3NHJQaVBNM2grY1A1?=
 =?utf-8?B?cjJTclVqeFA4RGpVdXA1cEd3UjRTeUMvdER5elNaRUtzRXZpbGw2eWphK3Yr?=
 =?utf-8?B?R1ZERk1NSzJld1lHcU50enpqQ01wTHdWUk1naFNCQjN4NXBmQ0RLQVdYQmZB?=
 =?utf-8?B?TDYyZjNZVWtaNHRnWGNDZVU1bHJGQTN4dG55OWpONkdYeE5VMGFHakZXejU5?=
 =?utf-8?B?bTJoaEJkVU5TZWlQY3BKTGNVVU92c0I4VGZSbkRUdHBmc2sxZE9xVEhHVmVE?=
 =?utf-8?B?MmZuV2gyM002VVV2ZHQyMFk2SEVUK09rbGVRVzRBeUxlVVZqVnNVaXViQXo4?=
 =?utf-8?B?Y1hWSGtWK0VvS2RmU1dnbWZkd0piZ3dzT0hXOXMwT0RsUFFkcTY3VmEvMk44?=
 =?utf-8?B?K1p3cjJudmNiRUhKNVkrZjROY2EwL2QrUGMzeXc5Sy9hdmxaVzEvSUVhc1lD?=
 =?utf-8?B?UnNSNWdSa3NDaWtwQWJrZjZZU1FRaW9kVU5LbHlXa09VTEhKT2I4T1NQNkhB?=
 =?utf-8?B?cVZnS1R3WU9CNU5sN01kQnkyTEIxL1lXMnZyZXRIMUt2OUJPcW1qM1FUT0xO?=
 =?utf-8?B?UVU2SGRna3FBM2NzQnlDak14a1grK2RPNFFOL0V1WFFCWE9GV1lzMFcyVmpM?=
 =?utf-8?B?c0dLbStzNE1sellUS2FFNVBFY1lFNDNGNHR6bWEwNlpZZlJadEV4Q09PeEpv?=
 =?utf-8?B?aTZGcnlINVdIZ1JqSTdZQVdHSlBrRmFIVG1YT2NXU2VOTFR2Y01sSnUvNk9m?=
 =?utf-8?B?WnNYR3ZmSTY4UUJqSXYyaktxMnU5VkQ3SXEzMEd4TXR6c2pybEpidkE5cko5?=
 =?utf-8?B?cmcxTWl6UlM1QXJOaEd4bENBRkszUmVva3N0b0JnbjFFZFZpdkZKU0lZQXc5?=
 =?utf-8?B?ZGcrU3ZBb1FraGIxNkhEakFjTHphSVZCRlNBeHMramFGSWhmbERIdDY5bmlM?=
 =?utf-8?B?ZTVxNmJmZTFNdG4ydEpOZm16bDRIYjVzRURoTDR3ci8ySVRHNFZ6c1dwWUpl?=
 =?utf-8?B?K284V0UxeHd1Zzg1cm9Ra01LeHdST2pIL2JtNnh1aTkyYmpIVmdHa3REOEJ5?=
 =?utf-8?B?UC8xbG8xcjF1aHBvV1hrNUNVZUpDZDdJQXlwS0NKb0hNU1d6V2RjVGJ4QVB3?=
 =?utf-8?B?cUowbzBPU0o4TVFwbjVTbG5UNFBVak1UcjVqUWpTeFBhU2NSb0llZHU1WUVN?=
 =?utf-8?B?QStrak5qVnp1YytES0R1SkxTYnlmb0xyTU9pU1VSQmwwbitBbW5kUnozQ1U4?=
 =?utf-8?B?Y2JieWtnR2FGYkxBRmZtRDdnb3FrVExFSm91UEYyVmZ5VFIxL0ZLbjNVVHF1?=
 =?utf-8?Q?aOfEHC2On0ORDsGpdw9UGdtk9Vm5xKgF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZ0ZWxsWFRYYkpuN2l4akUweUF0MHRCMjdwcitlZ0dZZ3BsZ2lUSnk1WVNv?=
 =?utf-8?B?bm9ya2ZWay9oSkI4bWt5dzFOd0ZXazg0eGpOMWY4MEU3Qzh4cFZDOWVHN293?=
 =?utf-8?B?T0FQVDRyazl2Y20wdHlmd0RyU09oVUIzbGJuVGhIR290TXNsOC9lOEVlOFZB?=
 =?utf-8?B?bU1tV0hIRzJqVE9tR3F1RE9lWGZ2NTRJbFN1V1BmdkRxZjBONkgwYk9ueFVZ?=
 =?utf-8?B?UDBrdlBrTVdTUzllR2hIQUtTQVdGcmNhMHZhUDMveWp3YTBCMFFTWGIxMUpM?=
 =?utf-8?B?b1RsT0FBTmRUazU0R2V4blZiZjVDZm5tdTdlWU9Dc2pRTmpMakpDTWpESFZC?=
 =?utf-8?B?K0NCVjlkMUxCN2h2NVNFbUhqZUJBY09BM2d3WHQ5cDNaQTlnMW1mNkIveFNo?=
 =?utf-8?B?SXZ1dlFxY3RjS0h6eFhhVVdDWitsNHlESWlxeXlldDJsaGRuYzVYV0oxcnBh?=
 =?utf-8?B?ODRsOHNEL1VlT2NoUG5tSmJGSXI3ajVVcVpLNE9LUXo3L2FCNVpxS2lVWUJi?=
 =?utf-8?B?OFJUR0FBb2FYcG9MRVI2M25WcGpkMFlRaEdKVSt2UXFsMDEvRVhCUVZJOXZ0?=
 =?utf-8?B?aDNZcWI5Z1BVcUx6Qys3WEZMQzRvbUJWeURRemg2M3hJMkhPdDFHUXlGbnhi?=
 =?utf-8?B?b0JxZlkrUkdCdHhsOWNrT1A5SVhnZEdzVWlJb1BOWHRjaXlHMkx6MCtPbTkw?=
 =?utf-8?B?a0VxVVp2dEVTNHUwaUN6YW14N1RIc0s2QW9lNkdGWXhOVllCeEJ3VVE2ZDE3?=
 =?utf-8?B?bjhvb2JYZkt2NUF1a3VybHZoeHlGTmhVdG1JYXNRYkFXVnY1UjgrSW1LMjQx?=
 =?utf-8?B?TE8zZk1uUHFhNmEzeEZhcm9STHBvWitYcElTR05TS2RuVU51RFRCWHpmVk5F?=
 =?utf-8?B?UmNzaVJpZHJaM2NmRHdSN3FnOXordkJKblo2V1lxMTBEQ2pvZ211aUxGREYx?=
 =?utf-8?B?ekE2dWNQV3RVQjI3ZVNaYWh2YVFzK0dGRW9iWklUclVndHJrR2I2MFdnME1N?=
 =?utf-8?B?ZVV0c3gyS09HT0YwM3Bwam1jZVNUTmhLcUIrLzRpQkx3NGU2ZEU2SGpjVlF0?=
 =?utf-8?B?VVZ3VWYyc0ROci9tb3p5bVgwK09IaWlSclNGOTJiaHdnNitrK3ZxU3hXVmRl?=
 =?utf-8?B?V2ozMWdMbjAzWUZkeUcxRDN4eUU2OUdvOXVIS0l0WlN6R00veVZvdFRSK1ZY?=
 =?utf-8?B?MHJzZWVjQlY1aXMrVWlSYysycmZTMHBLTmNNNmZLRUorMTNZR0lJT0ZaMnEv?=
 =?utf-8?B?SFE3VEs3K1VGajl5cDdvZysvYTMrTDRuVEorVHhlaU0zUlBZNmliYUFaYjdJ?=
 =?utf-8?B?ZE5NeUc0M3lYZGVOV3BWMjRvNkowWlBpQ2hiVHQ3SGJZQVFjWVVjUDM1ZCta?=
 =?utf-8?B?anpEM25HTjR1NkNFSTdFQlFLRE9KT0NCOHhSZHV6UlRrbVVocUlxak1ocWNB?=
 =?utf-8?B?NTJ3eWJvcUFwT1F3OTJOTlVualdhNUxxdkp1NVg2TVdReW91VXNCNjZNdVVP?=
 =?utf-8?B?S1lXYmpvYWRmcnBjREI0Um1iRHdDWHlPeVdlb09wQUZLRThZVnRXWmZHUS9S?=
 =?utf-8?B?TG5Fc09NRDZ6bHpyczM3ZWFkMEZ3THUvT3pGaElVQjJQMzU4L3pmaUMrRjFV?=
 =?utf-8?B?MTUxa2dJYXdmYm5WandxNXFDMm5IbHpMQllYYzlOTUdGdHlmaDJIbFppUUdC?=
 =?utf-8?B?bk9sKy9EcGFSSG56Ritpc3ZZNVFFUGk2NGJhellLZ3FBZVZSdUQyRENUS0hL?=
 =?utf-8?B?WjdadDlxcTd3SHp0cjltdFM1NDFBeXN5d0sxQ1dBS2h2WDQ3TWt1bXQ2QmFk?=
 =?utf-8?B?VXE2Z2lsLzZhamFiRTMwam92T3RlQWNPcDRPaXRwMUNyYnMrV2xIRkJNQUlG?=
 =?utf-8?B?b2ZvcmVXR0I5SzQ3V1VrbzBoMUZpdEdPb2ZrSEVwRzZyTkgyMkphYjBvVUk5?=
 =?utf-8?B?VlVLU3VMK0E5TVFFNFVjK3dveGxBSWkxYTdKSnk3YXVDRFZDZnZkUjV6b1N6?=
 =?utf-8?B?R2lqSHlCY2FoZTR2ME1uWi9YTm0vempYb2pSTnhvSTAzc2VkQTJkQnp2L0dL?=
 =?utf-8?B?SEMxMFVRV2JKUXlIWlBkeFR2bmpkdkNmUmg0M1l5T3dLSUxUb0Y4SDgzSVFu?=
 =?utf-8?B?c2ZCdWhEajRpREJBNnpLMWJ4TkcwcncxMTZjRmZMaW9EWUwvbmVPaHlkWHBa?=
 =?utf-8?Q?wS6XRsDLXUVpYGv0TU07V4o=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 17604d8b-b608-43cd-9bec-08dd1d9b4a6e
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 06:31:36.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9xm0xI21cZ0WIauga+LIn7+ZnuEpobTOlglAYCk+iqH+5e8GofOjEHhv03/BqGqT8NCAow615y4n7V1Wjqu65uiph49vhaTalwJoZWSFuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2154

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 608 ++++++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..85e29690b9fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22168,6 +22168,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..0806f00058a4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..20e8890b9897
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/crc8.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define STC3117_ADDR_MODE                      0x00
+#define STC3117_ADDR_CTRL                      0x01
+#define STC3117_ADDR_SOC_L                     0x02
+#define STC3117_ADDR_SOC_H                     0x03
+#define STC3117_ADDR_COUNTER_L                 0x04
+#define STC3117_ADDR_COUNTER_H                 0x05
+#define STC3117_ADDR_CURRENT_L                 0x06
+#define STC3117_ADDR_CURRENT_H                 0x07
+#define STC3117_ADDR_VOLTAGE_L                 0x08
+#define STC3117_ADDR_VOLTAGE_H                 0x09
+#define STC3117_ADDR_TEMPERATURE               0x0A
+#define STC3117_ADDR_AVG_CURRENT_L             0x0B
+#define STC3117_ADDR_AVG_CURRENT_H             0x0C
+#define STC3117_ADDR_OCV_L                     0x0D
+#define STC3117_ADDR_OCV_H                     0x0E
+#define STC3117_ADDR_CC_CNF_L                  0x0F
+#define STC3117_ADDR_CC_CNF_H                  0x10
+#define STC3117_ADDR_VM_CNF_L                  0x11
+#define STC3117_ADDR_VM_CNF_H                  0x12
+#define STC3117_ADDR_ALARM_soc                 0x13
+#define STC3117_ADDR_ALARM_VOLTAGE             0x14
+#define STC3117_ADDR_ID                        0x18
+#define STC3117_ADDR_CC_ADJ_L			0x1B
+#define STC3117_ADDR_CC_ADJ_H			0x1C
+#define STC3117_ADDR_VM_ADJ_L			0x1D
+#define STC3117_ADDR_VM_ADJ_H			0x1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE			BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                     0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define INVALID_TEMPERATURE			250
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+};
+
+struct stc3117_battery_info {
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* current in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in °C */
+	data->temp = reg_list[10];
+
+	/* Avg current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			CURRENT_LSB_VALUE / battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv mV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int id, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity_mah *
+			battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+					  STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int id, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = 0;
+		data->temp = INVALID_TEMPERATURE;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data =
+		container_of(work, struct stc3117_data, update_work.work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp * 10;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	psy_cfg.drv_data = data;
+
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+					&stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+					&battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to get shunt-resistor-micro-ohms\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialize of stc3117\n");
+
+	ret = devm_delayed_work_autocancel(&client->dev, &data->update_work,
+					   fuel_gauge_update_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1


