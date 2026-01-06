Return-Path: <linux-pm+bounces-40327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59143CF9869
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 18:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AFC63005196
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194132936E;
	Tue,  6 Jan 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="u9xBo0Fu"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023102.outbound.protection.outlook.com [40.107.162.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD0283FE2;
	Tue,  6 Jan 2026 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718540; cv=fail; b=AQi+vA+uPLY+XNt+pzxsvVyaEhRpG0MSpgAwwcSYhZwgrWo5WQrH/lmpogc51owPH9BrsCq8a2uOmSouHM3rzY4yDC4Q17+WL6fBkddCqRgSQxvOwnMVcts2IvhR06MeEQ/LkZrtRHgr/20wyMCb99szeGaq7UfjLNsVj/0ndK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718540; c=relaxed/simple;
	bh=UoZGExVrTzjVp367nu7FHMDnTf/YpiYCXkNX/ZXOXRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JI8H8qirFLtudbuairvFwpNP4atgT4bkk/QHWe/NBWRnzXFUYwBEBOnbZdiK4m/S94KANQ62pXpSO9FtdWfk9TIo0cWPxgTQQfTgPUxHdoZ5WReMwYltnkbhW7vXSmD9r0xtl/3LYxjNRexKi8Udq6nEIvpdjpi4bvUMSRDKjz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=u9xBo0Fu; arc=fail smtp.client-ip=40.107.162.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8WvXhPDVt6kF8YHi0lcZb4CgwuqdUC+Oiblp/7NM6/Lijq7xFb1htYL2BIvucLL5gPBYqmcRNDotJ1XDz74SWRMdpt4KQcxjQGx1e52s/LMwiycdTPVdSZJPHBDbp2+6qE0o3MZH4/w5sz3mrcRwefrpxoqWyHDkkYPtkyShSJ11BivZhP2E/1Z1C+iAoyL/8nWGeeox2wqyx1eCmWmNqyFC7NZjJ68XGPXrE+guUjbS75CRqmJ1JhRmnJV1Jjvw1YUUcegNbGToxYhXGph0GQLJaHGyDlllh12HsNzlrfPiqGpFf6LbZS++CmhT5S5QuzlFf2W9+t1AapHLNzUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YAjO6U9/qn9/WNB084xJDILbwyC08J6XzN1gDgCa0k=;
 b=aTEYhetAOz8rNE0mI45uSnlu2cXhX0RVT++/r1McLIAYpc+geGD3dHjS3BCKFtmn3XO0oJ5GcjbNPNbXq99A+VgZVy907rfDhnDLSPVnr/V2ImIRBi3CXs/XQkgK+9v1zoAOMQKD7S1MQ6vrNt7mx7kwFwTdW7lV5mw9W/qbR+ZezV5wCa99wwaZlZ478tATAp2I6N0LEZiyHZAb5SOEmmG7YLQSgZ6YGGq1yHVETT7aDutvHYmCKrkIBqWMi9BCv8uO1ZSXIhxEgAHRh89a9McSKT9uoVUCWaErWJ8u44De+rt9EI17Gs9SqNvKBcOQoWqL+Y/tHGTetyMl6CXI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YAjO6U9/qn9/WNB084xJDILbwyC08J6XzN1gDgCa0k=;
 b=u9xBo0FuoJ8CO+DiKMnbvdXL/1nCalL0S1vV3rF4TPzBRDA9+sHpGuaGYxFk/rR4YFiotu3rOLd+7UgIaXDOZZl062JFX2vmdd++Kih9YoFNqWSn8HcjuswCXvG/c0Qcpv3U24PWjR1008mIpeCwVA17CDXTdx/mpX7sc/Bo5zeALRyOuGAJT0qHNCLEB67WAGVDt4N+CY0qyGdUPPnMAZBq9p2SYBZ7qC8gthCNC8/Sw+W6y3DPxD04TiUiQ+h9YRMLgOqMzs06810Z5dWWGUGVaDEnln7MX0/UYa/4XMyBP5BpuHs/qQnVs89iPmyxbnDx7F2aSA5x7D85yR1vFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DU4PR03MB11117.eurprd03.prod.outlook.com (2603:10a6:10:5f3::10)
 by DU4PR03MB10621.eurprd03.prod.outlook.com (2603:10a6:10:58c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 16:55:34 +0000
Received: from DU4PR03MB11117.eurprd03.prod.outlook.com
 ([fe80::45be:33d5:812a:47d3]) by DU4PR03MB11117.eurprd03.prod.outlook.com
 ([fe80::45be:33d5:812a:47d3%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 16:55:34 +0000
Message-ID: <a6f5c448-d0ab-4119-94ee-201bc3027e84@uclouvain.be>
Date: Tue, 6 Jan 2026 17:54:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] MAX77759 Fuel Gauge driver support
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <8385a4fbb6c10cfe643c2f310f6a67150e260cf4.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <8385a4fbb6c10cfe643c2f310f6a67150e260cf4.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To DU4PR03MB11117.eurprd03.prod.outlook.com
 (2603:10a6:10:5f3::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR03MB11117:EE_|DU4PR03MB10621:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dccb2b3-029e-4bae-3b4f-08de4d446840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|786006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2I3bzc1OGxydWYwUHdPdy9xb1BuTXpRNHFXQkk0aFExNVhKUDhDYzFPYkRC?=
 =?utf-8?B?dVVDUDkyZEk0L1I4ciswSDVFbk9QekFjWFhlb0dtMEFKNExyeXNkaGdwQzlk?=
 =?utf-8?B?TXhwOStiNW9pZk1taW45VEQrdjRDaUxERFR5MWlLV05OQ294cXNjWThtRXVW?=
 =?utf-8?B?VGtPYlNYdW9kT1UxMWtoN285RVBCMDM3OVFYeDBwZG1OL21Cb1JvWHVqU0hs?=
 =?utf-8?B?ZGtXbjQ5WEtMN2VnMnBrcXg2OHNnYVJWMkhFd2RQUEFvdXhIWTVJdDlEd3FR?=
 =?utf-8?B?OWhzazBOUS90MzEvNDRma0cwWXc0T2htdGJLOFBXSFdCNlpmeG42OWpQNHJK?=
 =?utf-8?B?NFcrOXdPdGdVZms4NlhhdU9ub0JyWHZFMkZ2ZituTzA4aEdYMWx1SkVvMTRz?=
 =?utf-8?B?Z0xWS1RLS01hbENYOFdPelpkK1RreTgxeVU1UVlpOXlZK3JuNlJVOFhETkJa?=
 =?utf-8?B?N1NFRWNDMWRWbjQyT0xqZVAzVEsyMjBtdTVXMFpkdDVRY0xUVDNxd2RzdkRS?=
 =?utf-8?B?aHZtckZNQTRRNldJQXcxbUkwbHFtOUJ6eXM1SWhwbWUrSHRyRjQ4RXBxVTZx?=
 =?utf-8?B?blZvZ1piOGVOVFN0bjZVRTExN0RXaE5LZ1phcWF0ZnZ4a0dwRE1hT0ZZNDI5?=
 =?utf-8?B?dU5wR1crK2orSnJpYkhYaWtRaDNaSzRjRlYzY2FmUmlnVElpcHFDaEZrdFNV?=
 =?utf-8?B?TW1tcG03RzFuVFYvL3QyM004TDQzWVJXNUpBVTQwNUVjeE4waW1xeFJjQXVi?=
 =?utf-8?B?VFRlL2xtSGszSzZiam0waEVvcno3NEJtOTJNSU91b3NEZW9LWkl1Q1YyZDV1?=
 =?utf-8?B?K2VJMkJaNFlwWFFObnFSVm1wUm1iTkZNOGJHUnJ6S1lpMzNjN2RMaldlVDQz?=
 =?utf-8?B?ZDY1Wm5zRnVhdVEzSjhHeFRLbWpEaWNQbWtPdmZRcnJFakM0Z3pyNDhzS1dF?=
 =?utf-8?B?K2E5a3dsQ1RDMWNGOURXQW4yZXlpYmx4U0N1akxjZ0VwTWtIS1llT1pjTVB4?=
 =?utf-8?B?UG5DTXo3SkJpMzFobzhZa0NFVXJ5R0lTZW40K1NwWlJLTmltNlV3clR2bVo2?=
 =?utf-8?B?ZkZwd1ZDUzdFamdESCtOTG03QUg2d29Ecnl2b0NPZnAwVEMrZExjbUozeGlP?=
 =?utf-8?B?dkpPT05tbk1YYWkrNjhNTHBUMW9yS2VjTVFteTZQbDRTVzV3aEJ5a3pBRDMz?=
 =?utf-8?B?TWU2K3pVdkRZOFlkbGV0UDBsMFJFaEcvR0QrbVBNT1FtaFdva3FBMjMvbUpm?=
 =?utf-8?B?OG1HcERjcGZKVGEvL0lUN1BLNjlrenVzRzU3TWt3SlZkR3dDOFdaeFJZUkcr?=
 =?utf-8?B?SG0zck92MWxnQ0t6UlU5SHA2Y3J3V2x3anZ6RkhqamZOVFBVV0tXblN1SFht?=
 =?utf-8?B?NWFjSGhUY1B2ZW1KQ0NUalgzUUZhVzBTWm9VWjByZDNRRHdsKytXd3dlbHFH?=
 =?utf-8?B?ZHRyUU41ekp4b2haSXpaTlVVdzJZWGRsQUc1UVlWTzhZRHdWMzZiYTNlSjdN?=
 =?utf-8?B?djR1elNiTUZUWHgwaElSMXo5ckhNSWlPd2dtNXkxeDVNdHl6ZVJxZjhuc3l3?=
 =?utf-8?B?YjJESW9ieStFSTRnS2ZIeStobWgyMW1teUZIdjNBT25VMWN6V0t3YlpFbTU2?=
 =?utf-8?B?VE9EL2VVWWJCd01qSU9EQkxIOVhPbVlkalVkUFhLT2o2c2RuQnJOUng3MWZV?=
 =?utf-8?B?V1Q0NG0vejJnMFZ0SWdpR3JPZXhQSGJaNHZMSklGd0VMMmROT0lUb0tFMmYv?=
 =?utf-8?B?UDNvdlQzdHBqVElHb1pPY290Qy92dkw5M2ZxM1J5aDdsL2psc0dOMGFmb1Bt?=
 =?utf-8?B?dlBLakhFZnZZME1PTk9PYVl0bTFpS3dSMFkrbnpzdWNrb3ZXNG41NkcwMFpp?=
 =?utf-8?B?ZldhbSs3VHlOUjRpTWdadnhvR01rbzQ1NGJ3dEdHak93bW9QTzR5WjlLRFo1?=
 =?utf-8?Q?Lxy+o3Lk22i+57yDQTzowo+3y5F93k3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR03MB11117.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(786006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdwNWF1SXU2NkNmRWhnVURJWFRMaDRtMTVoNnF2bUErSmw1R3doSjZ6VXZ3?=
 =?utf-8?B?TlZxSkh2NkhiazhOejNGc3FIandJSzViNFNXS1RxT05xSmtydnc3MUJPRlpo?=
 =?utf-8?B?anN6TXkrYkMzMkxOV3FrQTVuZGNSTFhINzhnOXU0TDVmYmFZc095emlTZmJa?=
 =?utf-8?B?UG1ydGtNL3JCRjlQRkdrOEpkS2picDU4TFFuYXA4MnVyTldtMDRHNEZSWDUz?=
 =?utf-8?B?Q0lWTkYxc3AwMU01NFV1Uis0dzg1Zk0yK1V1RjFVbm1nK1hTcDR5QmNIT0ps?=
 =?utf-8?B?b0Z2QmpJdTJVM2pEaHRtd3gxVEVZeTZ6REpCenZ0VUhjNkFRSTZNWjc1Znpy?=
 =?utf-8?B?RDcyaGVrNUh1WEtPT2tCajVGVWhvblFZZU81MlphV0VUOU1tWkh0MlV6OXE5?=
 =?utf-8?B?L0orc01aSklYb3dHU1JKUGNVYjQ2bEJQZXlpS0R2NGxFL1VvcmoySTBlT005?=
 =?utf-8?B?T04zQ1BaN3d4Q3dNVHk1bGJzMVRwT3Jmay9TVEUxa2xyR3d4ZFl0a0VKdjAy?=
 =?utf-8?B?MUJ6Z1hWNTJuU0puTWRCUzRrVHp1dDNydzRGYU1Lc0pNc1lkS3ozcFpDY2xi?=
 =?utf-8?B?K1diZXV4NVpMWHV4cUZJbml1RUd6eWhkUEZzai96YXBFRWxIc1VSN0oxZHZB?=
 =?utf-8?B?UHdjK3JkTk4vaTFOZzRtQ3dyaysybDlqbVR4VnlqU0F6dmU5eS9KLzVhWW9w?=
 =?utf-8?B?YS9hK1RWMUNmUlJLZi9DSmpRcnJNendCTEVkVXhCZEtXNExYYm5PTXc3SHc1?=
 =?utf-8?B?NW1XcDZNZGtja0UrUE55V0VVeFdDcTRMQUVyTnpUZ1FvdlhXWGgrcjVsRVdB?=
 =?utf-8?B?U3lsbUxsTnMvRFdMK3d3Y1BPMlpvY1lqOWtodVFZTWl4QmM0ZEFOMStXWVp5?=
 =?utf-8?B?Tk95TGd6RXZ1RXB6R1BodGNLZ2hvZXgxSHoxMzdDR2VJM3hEZUpzMjVBYkJM?=
 =?utf-8?B?UTg0MWdjbEs5VFI2ZHdLQm5rQk90d2taNDhiUGRxc0pJNmVGTHFkdkJESUJh?=
 =?utf-8?B?aTd6ZmdUdEZSUnBITFJ5bk45cWVvWW1kR2s1RXFhaVZjZ3RRMCs3U25rR3c5?=
 =?utf-8?B?azNEV1lDaWV2WVBFeVBERDZaSFZDZUxNejRzbTNENytDUEg3ZTJKcENYNzZ1?=
 =?utf-8?B?THRna3FjVkJrcjNzTVoydnYxOTdlT0g2bXM0UVVrWGRqZ1lLRnJDU2thdS9z?=
 =?utf-8?B?bWZQTVJtc0FEY00xVDBBSGJrQmZPZmNSSHZNVEg3bXdnek1GMU9RRGFGTlA5?=
 =?utf-8?B?WEErOVp4Z3BhcVQ0VEcxT2wyNmFUY2IyVXFvWEZWOFQ0WkRaT1B3b3lsT3JU?=
 =?utf-8?B?RXoxV1VzUk9RWm91LzZwam1mT04wQkIxdmwzd0p1ck1mTUI3eDJqWDY5VXhY?=
 =?utf-8?B?T0p3dVZhSi8yTWF1Mlp0emk4ekQvN3BuWHV6NGZOSHhFQmZvdFNlZ3RZTlVw?=
 =?utf-8?B?RGNZNjZsU3N2bW14dlNYOWRxVFM5eDFBaGY1L08wR2hPRGpXOGtrNVAzeUZ6?=
 =?utf-8?B?RGkwaXR2S2wxdUFTYmhkelkzbkxoNU1ZaWRDemxMNUR0MytmWEtPYXB6TXF5?=
 =?utf-8?B?K1BqZ2hOeDFWWm1lY3UxQWJLYmtteE9OK0NrOHlaOTVtTTFwNkxVdllLVnpG?=
 =?utf-8?B?TEpwRFgzZDVRZm5zc2FueE1xdDNKYmo0dEtOVW96dGNDemhzd2diUXEwTUN6?=
 =?utf-8?B?allPaGhFWDlta1hvaU1qQ21qLzQ3NmFYcGtydExPbUlLQTVTVUVaMDZ1a2Yz?=
 =?utf-8?B?L2hkMitOSnNIdVpOblJvQlZpUEk1b05nUWRPR2F6c0Z6ODRlbitmdkNDSHN4?=
 =?utf-8?B?NmVLczJQK3RvQisvWkpoNW1oU1g3aCtvTDFvNUxUVXoxbjNZOXpLSytnR2NN?=
 =?utf-8?B?VWx3VkR6Y1lUc1VVcGxOVHpXMzNMeWlsS2FGN3ZHOTYwWXhROFBmTlhVUnE3?=
 =?utf-8?B?RDNaM1VscWpwK242aFJSTnNYcG5YTVVxRzNOSjZuMFJ2TllvUTdCdFZuOU5z?=
 =?utf-8?B?VmxIUTJtV1J5Y2RrazZmOXYxOURoZ3JrSTNjRFIxNU5YUXplc0FheEJCTlNI?=
 =?utf-8?B?V0crR1dxd3ZYWW0rR1daWWJpU2tFRHNnQ2htQ2MxT1ZCcjdPQXpYZU1aQStl?=
 =?utf-8?B?L2kyNGxKeitKeDVNVlFRaENHTlhKYndLNkRxb2VTVU9Ud3laZWZQV3g0aHBL?=
 =?utf-8?B?aTgxZVJzdXNiSStna2diV09yTk01bHFWUjNiZnlNV1VaUXlNd0t1QlFxdThj?=
 =?utf-8?B?TWxYRWlxdDZtMEVIdHpSRlRWRXdBLzkzSVMrVXNERFNVWDFhYW5XK1Zrd3la?=
 =?utf-8?B?bnFIYXV3RWtFNGhHZENMdldhcGpLUEE3ZVpFdkN2U3NYSklyUCtWK0lKMVor?=
 =?utf-8?Q?Bxk6dqERjHnvQmFxLsJd7ZHPNnqfRLGXbE9dZNshSVy/h?=
X-MS-Exchange-AntiSpam-MessageData-1: odVHZ05OQTuXPw==
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dccb2b3-029e-4bae-3b4f-08de4d446840
X-MS-Exchange-CrossTenant-AuthSource: DU4PR03MB11117.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:55:33.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEZhMoUhksJUAPSbq1X1A7/K3R4S8jXQH5Lwi/FKzkpaGyJ+isNIAI0rPpZTcbhYhBvj+T9Bw574X5aaPs3LjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10621

Hi,

> [...] 
> Are you still working on this? Are you planning to send out a new version?

Really sorry for the long time since I sent anything. I had some personal
issues and had to focus on work so I could not work on this.

Moreover, after rechecking the files, I noticed that the support for the
MAX77759 should most likely go in the max17042_battery.c file. There is
already support for multiple chips (e.g. max77705, max7779849) and when
I looked into it a while ago, most of the support of my last patch was
present with some things more.
I don't know how I did not notice this when I first started working on this.

I can rework this patch and send it by the end of the week as the change
requests were pretty light.
However, I think the cleaner course of action is for me to attempt to
integrate changes into the max17042 file and see if anything causes
problems which would warrant a new driver. I think I can take the free
time to do this by the end of the month.

What do you think?

Have a good day and happy new year,
Thomas


