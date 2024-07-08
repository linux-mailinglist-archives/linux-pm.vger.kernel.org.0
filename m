Return-Path: <linux-pm+bounces-10742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5E929C4F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B516280C92
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62E13AF9;
	Mon,  8 Jul 2024 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Pp1Jc2JR"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95976125AC;
	Mon,  8 Jul 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420499; cv=fail; b=hZ+qiKMwnCASVHr33FRABG/FDeBi3sAnJWEC4dGhNEV+keXtIDE2S5FJodHGTpMoR/EfoPmJG9fXoNaSdFIphWUKpyk7eRQgraWXCSZzjURsvRRMGtXtb1DaHVyQ+vSWgMD34kuqd1b8qSbAOkuZXd4w7CpHjoOS09LhI5X+TYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420499; c=relaxed/simple;
	bh=zCbqtuR2pLd0HlBYaGfdS/VI2GAXUHbwsBuTKxWbOY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJmKIFiBQ6HTd7fVnu4s3q5Suop/MUGR7r+cNYvnqCrd2cRnbrra5Disj98M1CPTH6sPOHYxPm7klwtAh0555i32RYXG8+j6nA6oytYTXjEszKIN6Eh9jNwIci3iQ2YPA69EDCArx3CP7wLF2VD6oz6BHT9swku+ldF82Z7ZkxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Pp1Jc2JR; arc=fail smtp.client-ip=40.107.255.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4TVDVj8XavVrFONe2LbiiMm0vyixhU2OK1ppVvVDR52ST8BUrJpFbbrLHD+5YvZjyIfhFvR2ewOJCCZZigGAXE5+te8KuOX9by+XgkupP8/ZghGBZ+LxZbd9BVwYTxwV9eCK8PGJoTnWrsZjxA6pLeCVRfaUcTTvyY8Ugbf6g/1mbgCYm7OUDQ0MxxrV07bnFY/ZRXMsB13B/qfmxZEHhgMq71F+c7bg51JHNnInlA1l3nkCKj7FEFCexOyeTxoQWiAW6OSsZdN4E2RTDChjSu46bQNImLhytQkB+wP6OsMkYbvTWb2+eQEhFcog4ylE/KvU71WGCHo1jBC1mHxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/lWXCpW+pzIk/tqEiNpFSUg+9JwUzlinmFELkrXN5M=;
 b=A2RFNVjInOJ0DCHw0rassWuqhJhXC4Q8O7R1ckHTIcZFVI/QHmsFI8/NK5OYMuKhp9k5tTDb3KOGsQVSYKGHjeqkJTOzpaP2BMDqXEzIfN3J0EtPA6054+k8D5NvrHZ6p3X8TUh7nU5pbqJT6He5l17ftq9D2y6+fH8JVnBOFXImW/KNo10l44iz94GW/EvwWaha0rFjw30ParUXOL1Xu2nycYSMqc+HCtdG6Vs1gy/8yM8n8rpZ/2+gqGKCqAHhA260a1vtBH3b8EUF8MgmkhAi8oomWChwstEEU5FLNboXaSxCRVNA7fCxetNTTucE26IKeoQgAFZgnvEvvt9Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/lWXCpW+pzIk/tqEiNpFSUg+9JwUzlinmFELkrXN5M=;
 b=Pp1Jc2JR4t9YFSugd4dSnpsx3yfb5yfGd2HPOvLuPIsLgW24pEeZALPTUh2jIgfydGPHP2EU7Qvx40/623LiJ9oNZj7x1ZbIQn7DZS6czL9WJVKXtHkBIZAhkzhXe5/6siAktiL/CpSSXUvNnCsmqlBctdE4Ah+o70h5MQR+9DJ7ucpbRURn7rVCCUyaKEHMXlTXu080xvBRY8mOzsFGVRl+qaQ2Eo6/6cj+ekgiOhSCd+zWSOKK4LE4XNGNkPB2cmA+BWLmAuQMv+Rysyfg9J5f/a4ceQCu5aVjXgJOjWX5wmD5xAZo+p0qogA0vO3VOl0UyLq8iq691wkhtSUYcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7670.apcprd03.prod.outlook.com (2603:1096:820:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:34:50 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:34:50 +0000
Message-ID: <2eadc423-074c-408e-a528-522c452d8186@amlogic.com>
Date: Mon, 8 Jul 2024 14:34:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Add an entry for Amlogic WCN power
 sequence
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-3-31829b47fc72@amlogic.com>
 <1bf25e5b-a9aa-42cd-966c-c5674dc502c9@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <1bf25e5b-a9aa-42cd-966c-c5674dc502c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d4bbbb-b068-462b-19fa-08dc9f1811eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1JWMGt4OEpzOUtwemgxMTlRMDhZQ2w1VmFxYmtyalVxaVh4eEdtVTEzUXAv?=
 =?utf-8?B?ZnFOT0ZBQWZLeTg5ZW92SFdIR1pEQzhEa29Vem5scW9DTDNmQTJiN0VzR3pL?=
 =?utf-8?B?dDRiMStTYzlib0VxaXk2cDdOMGtKWDYrOWZTZlhRTy9XVjk4MGNFbm1JZmI2?=
 =?utf-8?B?ZHVsbDZ2VTJybEZsRlB6QSs4N3NkUy9DUUNqWmpZQThVbmVyUGsyMWRmNlFP?=
 =?utf-8?B?alM4OUcxREpTN2JMYzhud3R0UEd6VTErbWRROG13QWRzWC9kdXdBOC9ZaUM0?=
 =?utf-8?B?ZFJuZHFtb25jdDVxN1hNQkE3RHkrcVJ0dUVSa3lFWlA1MHorZkhaZFNJajY3?=
 =?utf-8?B?UEhhbjJqeCt5OEFCT0RxQmNWMXJhRERCdStpaDF2WmMySUxuS3dKWlkwYVBj?=
 =?utf-8?B?MnVyMzBkMEl2aWR0N3VUQWV6TFAvMldYbVU3bHZSOHJ6UndHWVFucGtrYmZi?=
 =?utf-8?B?VE02Ry9pUzNOalAzNC9mVUQrWHpqVWhFTTlkSE9ITGZZeTBkM0htMERLNnR6?=
 =?utf-8?B?ektmRHFycDRWNXdxcG55dWFLaThCWXRtR2RWdzZHb2I2dFBJUURtaFF4U2FG?=
 =?utf-8?B?Rnh1aUNhbFplNlV6eEFZNVNWT0JnaGZKVnB0NWYxZDNwcjkzSHo1ZVVvaE9R?=
 =?utf-8?B?ekJGc3NiOUZZRllqQnpXQU40QUlEZGRhN0J1TnRUMm5qUzRaM0Nib0pQYTM2?=
 =?utf-8?B?ditwdTdaajlRWHhiQ2JmUzFIVThhNkVCQzNNamNLcE5uSXNuMGVPZG9MQzBi?=
 =?utf-8?B?Zld4MEV6ZVVPcWNBdmxvOVVjclo3d2owazRUN0ZlRThydndEU000L0toOUdm?=
 =?utf-8?B?MnlROUNNTTNKMmxCQTFqV1d2WFZKc0d1NnFEQ2xDU1NHTjk5azJ2dW9lR0xh?=
 =?utf-8?B?aWVrcVZTbk1HRW1RWTA2NnZzM290dXB6Y2loa3hsL2U1M2x4aWtES0tXVFZj?=
 =?utf-8?B?K3p1cjhPRmNjME92VFh4ZStuL21xRlNvbXNrL215Sjh6SzBscVNsVzZIYmNQ?=
 =?utf-8?B?VmthSDFsRUhkcFVTSVlwd1orc2ZhME5jZ2J4Mm9BYzlOSFlnMmlQUnZmVDBL?=
 =?utf-8?B?RDNYaTBGVGtYaTg5dVVHL1JQRG8veURGaGZqTkFsZ3N2alA4aWhSSWtNWlFa?=
 =?utf-8?B?SHluSk5uUnZnSzhhMC9iaGtDS08xSmM0TzU1NjB1d0hWVkU0dHFnNjBnLzkv?=
 =?utf-8?B?WHdXdmcvcy9ycVg4dnpYb012RitMbUNXaCswOU9IekxFWlB0WlZUUCtGQTkx?=
 =?utf-8?B?cmxEenNaZHhxVjRNUG52Y0QvY3RSMnpvVkpENGxqSHJBN1VGNHVnNnZHaEZl?=
 =?utf-8?B?MW44dDY4K2dhc016UkFLRmtpdmR4eUVFQVk3NDlHYXc4a3VPUzR1ZVJIMDFO?=
 =?utf-8?B?QlUyc3dIellwR2ZYQ3gwaWVMTWRoc1NIY3JxUWdLYXEzOTN4UEg0RjU5NGJa?=
 =?utf-8?B?V24yYmpPWGk3N0d5WEhrdHNyTnhtb0lJd1ZMSEdYZkZmOXFGM0lTNWhMOUVx?=
 =?utf-8?B?bzd6bUxkUk8xSE1ZWUNEZTRmZWhGcXVRNWRYR2lhVFRuUHRIRHZSYm4yWGZJ?=
 =?utf-8?B?S21iWFhpZmlHWnZyK3l0RnFzekdUQzE2K2dhd04wVGdtRmV2c0diVjV1c25P?=
 =?utf-8?B?OGtkN0tGdy9RMWE3L3NGL1gvVnBnaEpsMk12SXdObFFUSG15dDBTS3FuUnl2?=
 =?utf-8?B?aWVxR0hibFRLNFZnVlNING9WbisyWU90bHJ3UGo0VEorMEZsc2RJbTY5R241?=
 =?utf-8?Q?c3+Ih5RirUnjFG1Ty4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXF2ZWpzQ0MwY2hIakQzME1QKzF1TzQ5d0lZc2I0d2tIL1F0UUZEY0R1dmhT?=
 =?utf-8?B?TzlMTHFGdkQ0cW1sR3NsZ1VKeC95dk53Tmxvb3BiZDBFenovZzdvWUpvdVpz?=
 =?utf-8?B?OFdjN1Z4Y3lYV0xvOHo5Q0NpT3FYbE5FbWNaTFpTTGVkTjc4VExEdkt1T0FS?=
 =?utf-8?B?RW96Ukc5TTN1ZDFGNWxaZjl3aTBtOUp5WTdlQWlVRHBtOEcyUkNnSWF3UG9Z?=
 =?utf-8?B?bE5iNXdpVHpWVnVnSXhOTmdYVVVCS2xUSEV4bVBuTFJlL3haeUxQaW9vL3E3?=
 =?utf-8?B?VFlsbzJqYjlkajVVcTF2Sm85SmxyYzFZNGpmUFVPSDZtTkx3cW5kWEE4OWRy?=
 =?utf-8?B?azg0Q2pCK0hRVkpXTEJOc2lWZ1A1MkwzMEpJL1FzcGVRWXJoZ3MxOEZpclh2?=
 =?utf-8?B?ZUNRbktKdmRXeE56bXhDazVudTVxUDBOR3g4K1h1WHBGUDI2OGtqR0YxZllu?=
 =?utf-8?B?dEtRMlJ1aHhSV1JXOS85TGYxZTBkZCs4eW1kL0Jvek9FWEVEVzNnZjloa3NK?=
 =?utf-8?B?dTlVblFSaWFZM3pIbzhMVERrSDk0NG8zVW91VzdvaDhnT0FHZVJwTDBESmFx?=
 =?utf-8?B?QUZhMVA5L1d6bk1xbTIxbHVlY3A1ZVhOTkdreEJWU2svUkdab25ZVThMSGxN?=
 =?utf-8?B?aE1QTlp5NnAxemFVOHA4elVONVZ5STVvWEVTQlgzZVBiamU2NGkwUnRydkd0?=
 =?utf-8?B?bUVzL2ZOdlBHR01XMFlLTGNYVHlzbncxRm81cXcvYXdtNnQxRWcyQ0RNZDZt?=
 =?utf-8?B?Y0Z0Mjh5ZkUyeWV0MUczYlZlYmFYUEtsL3NuQXVTeWY4Z0x6bmU4UjYwNXk1?=
 =?utf-8?B?YklBbzJ3c0J1TzhPckxDQzRIcHoybXREbDNGQkkxUS93elBiR0NJanVlMWdE?=
 =?utf-8?B?U3BuK28xVXd0SmtDTUcyNURUVzlJQmp2UUcxdERUdEVkSExFVHFOaUlmNjI1?=
 =?utf-8?B?VlEzd2ZabytSMXpGbHdrNXhDS2dJcFlzRFZ1QURmMkxTT1FFTFQwL2R0QnZF?=
 =?utf-8?B?bjMzZzhybXI1NUtwK2o1T3Q3aXJhaXdwbkp0Mm5GL052Rk5UL3g5R2NYYWpz?=
 =?utf-8?B?RTV4MlNybFhVZUJhclFxVmVrbjVTQ2Y3WmpkYXIvYzY5U0pYdGd0VnlDbFh6?=
 =?utf-8?B?UkFldTFWOXp3YUU1aWIweDQ4QS9TNGJYdjcyY0FkWmVDcjg0R1BpQUloY2VV?=
 =?utf-8?B?UXkya0N4NGlMNjJ0Z1prcnJwZVhmZTVQcjExZ0NraFYwMit3TFJoTVlOZmNs?=
 =?utf-8?B?NUM5bGlYeXk1blF1Q2NQOGZoSGVRK25WbFpOa0daTmJWUWVWNVVxWFlwTEQ5?=
 =?utf-8?B?aW4wZys1blRDN1JQUHJyd3JBd2txcHFnNGJjSDkrQjljZE1TZURIUVZ5YUFk?=
 =?utf-8?B?aTRSMUNUNXVPanlqRWEvcEEvWlRSenBUcXZxTG1sMkVOZmd6Q1A5MUFvdDBh?=
 =?utf-8?B?c3l3c3N1WWZ6M1lsbEVGM3V0Zlo5Sk1BeGZMVFNRcGhLN05ZZUlSQ0tnejVO?=
 =?utf-8?B?bnViQ0tqSTZMYTVIV0VCRHdYeUw3M09sZHZQSzZ2dm1QaGF1WDJOS05BT2xT?=
 =?utf-8?B?SExhS3QxSlM2bS9iZVVtaXFiYmhzeENucVJONU9NaWxqSzlvbXl1eDB1OE11?=
 =?utf-8?B?WXZiQTJNL05ub0ErM1Rod2x5TlhrVk4wRTVKZ0dITHp5aGRqa2llTzAwbUNo?=
 =?utf-8?B?S1dqNW9WRGFmQ0J3d2gzcWVvQjArTGE2ZmhWMUNUdGdKTjFPNklNYWZMMUNX?=
 =?utf-8?B?UWNiVGp3OTlzditIVDEwOUVQN3hhZVJ0RFlpbDh6NjlrakI4dS9WVC9tTUNB?=
 =?utf-8?B?T2pPVUJuTGdwcHNlclFRRW1DaFplTGNZeGgxdWIxQWZ3dkNpWG1NRlcrR1NI?=
 =?utf-8?B?Y2F5LytTMzM4eUNJUVBNV2JJWnY4RE1mQ1duTjlMV2VxZWRnNGxtTDlJcVpl?=
 =?utf-8?B?QmhIOC9zU01NVnRhR3dhZEQvKzBYdkRzZS9JUUFmZStLcldFakh6TUIxRTJs?=
 =?utf-8?B?RmI2d2kzUUlwem14YnhVbVdTd1VqRXNBSGJFVFEwY3lZMnc4TmhzMmZUcFd4?=
 =?utf-8?B?V05IRGRiaTkyQWF1QWNRVlVEaFBBREorWW5DZEF0ZUpFbk9jbEQ2OFhGS0ZX?=
 =?utf-8?Q?Y9DbHYxXKDO+1a7GOFcw2q5+E?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d4bbbb-b068-462b-19fa-08dc9f1811eb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:34:50.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLop02kCPksf5/Rpg8/TUYNYFGL7oHShLeUG10EYaQ6Bk9o6x8x3PnU2lAAQPHZfryscPIUUrMaarzigrcdMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7670


> On 05/07/2024 13:13, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add an entry for Amlogic WCN power sequence.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dcb37b635f2c..0773f7040341 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1174,6 +1174,14 @@ F:     Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
>>   F:   drivers/perf/amlogic/
>>   F:   include/soc/amlogic/
>>
>> +AMLOGIC WCN POWER SEQUENCING
>> +M:   Yang Li <yang.li@amlogic.com>
>> +L:   linux-pm@vger.kernel.org
>> +S:   Maintained
>> +W:   http://www.amlogic.com
> Drop. It's not helpful at all. Don't throw at us your company marketing.

Well, I got it.

I will delete this line.

Thanks!

>
> Best regards,
> Krzysztof
>

