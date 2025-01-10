Return-Path: <linux-pm+bounces-20257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47845A097F6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4D3188E9C5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86821324E;
	Fri, 10 Jan 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="LsVOetQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021105.outbound.protection.outlook.com [52.101.65.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707811A23B0;
	Fri, 10 Jan 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528241; cv=fail; b=hULFhlDCXxNHybx78/5WJNN+41No38lAiclaLotzryWJqoDGdD68nIHB5LVyonos1ALRMYPiDw0nHuRpgZHS+IMPri0Yk9F4dtAHKlocUf58u5iRIKbPGn/O+lFS5sjm0d6FVSiFtbdKgkf1L2CDASb8mqGy5F9p3CRelnmUb+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528241; c=relaxed/simple;
	bh=24Yi6/UgO4GJxZBKT2eUT6kwueAz4acMRfEraxMeSKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uk56XfA6geOLitHxL3Wv681SXg7WtfwJO8M9fanfH8c7jPwm7sQLIOtqj6H4dbOYvnxoYEjraXDdjWgdslvjhD/9g+koe5GZIpfdOPRsIOQovD1kmYQYhZpINisr2OwphRJ6U2ywqzhzmsyNSo9fH3v5EYkyGS5g3RcI6JNYt8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=LsVOetQv; arc=fail smtp.client-ip=52.101.65.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/ytcvnvseNC9sdrI/ghM3li98l6oT8Steae3Fb/DcjXixwPq4WsS3SWfGHtaY2N28K3+H8yQ5j1fUMpUz/8KqUmoJ6YSLlZA2rhHLcDoHdfbgVEpoy6x3tMNleC1yyWttqGdV/TMNU0Pz1VW4qjezfcFGyt8PSdmiOlwkHvv9UVP4DN4RC7cjsUmqbK62BCSRklA95jBWxzIY6Q1OdZSZeFe8uNWEAxSXu8gVEyLVoIEgMTOPLNgf190PvFj+lrZkNc3ZWKIKcqmiPJS1LkoOOa8zMKlSkfS8NFVSQa67qEKTmi5xXESLgLE4IL0x4x1Rg1LxZLQNwpzhLL9ZU+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fs2YrVjOPTfzRxvaipeCPKE6kil2NRiNW9BjOoPyeQ=;
 b=reLGn9vwCGrNEOd5yQ0FX3lH6lfI51QD1HcbabPOCi5KQaUVg97d/AbARk5RdvOCehxb+jSsUuKE52rhDBkGELj7z/8ttqBOnal3rg2a0WIjWT4Nh4Pp7mxKKfiqqzukRpAmrAbuPe5ODDIw8OWhWBdJQg2vtJfvNSflg7Gl7KJfedc5C1P/vaIpWZjmlvlgIuZfMLR1YUtsh78B/EVqRagD94nHMjTVRRbUrYR9KC5zw0wH+xbdFQQAmNW3ZjdKrMsmKhT2ubykamix26J7OVZrkuLKMHz+SP4NGr7KixZ/RiZbo8k7pG6i5T9jnLRSAyNTxc+RxdvE2G6jFuzufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fs2YrVjOPTfzRxvaipeCPKE6kil2NRiNW9BjOoPyeQ=;
 b=LsVOetQvv1CGwWGGBIxg7kNeopTeZKU8hTO19H+A5x3UsLSuKZ0TXXin/y8Cvse5SKbS2ncIS50T9ZyJ4rLleH5LARkClbfdjCcHNOlXL2g7EdOULbxSnvUc+GXw+qFgIRnCHBf5VqJPMIqr6OCz2NfldmhXLd6JpGB5u7S5zr2ThyKxdMN9NbvHc0U6ZKGf8r5rIVZsAhrOB4NDFFnggrA1miI2Ju5OoyQTKZJPMTHU+JPYBk/Fw5jQ5CApyz8VxNll+XCQVEbPO66ujcFNLHwKU9RjpgVBq24zRVWlouosSY80jDAIwJ18/OXZixZL6mYfVGOgiGT4oCqpYV1+Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by PAXPR03MB7698.eurprd03.prod.outlook.com (2603:10a6:102:204::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:57:16 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:57:15 +0000
Message-ID: <7d8d2406-fd49-446d-82e9-e088eaa7a9d1@uclouvain.be>
Date: Fri, 10 Jan 2025 17:56:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
 <7178eb322fafaf0fbcdc4b91d9f9a65d996e4e6b.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <7178eb322fafaf0fbcdc4b91d9f9a65d996e4e6b.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::12) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|PAXPR03MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 901b1cda-7c23-4ea0-0008-08dd3197d5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW8vb3RSa1NOQVE3L2tuQWVqUnN2V2JuNmVWOFpPSlZ2TUJjbmh1U1EvR3Ny?=
 =?utf-8?B?eXNveUxLSEZxNGhIU0pRSThWNlFaN0JjdjZxU0IydXd1M1V0bTRYLzZPdzFn?=
 =?utf-8?B?N3dwd3lvbjh1TkQ1RVJYNXNrVmRhendQeldjZlUwaHk5Y21aRHRra1lobXFF?=
 =?utf-8?B?RjZsNG90VjVGTnJubFFiN0dybU1mWXN2cElYb05FUzczT1ZDdGVkeWxsL3Nh?=
 =?utf-8?B?MzFQYllkTVM4dXlCM0lVNEl2Z3FuRDNJNkNYNi9oYVBONVpIWnNuNm9qUjdT?=
 =?utf-8?B?S0FSZG91ZDBaT3lBKzNDcXJ6SUlsS3NWZzBuRzlnbHoraVN6bU1UdFV0SHhh?=
 =?utf-8?B?a2RRYVpYMDJoWmFjVnhwbWY0ajdsRGpsc0x3ZFo4QllCQ1d2TytFVG9vRVd2?=
 =?utf-8?B?aGQxcTFsclJEd2dXUzczdDlONFNkL0toN1V0bTJ2U0RTMmt6RmhMZW1pTWdy?=
 =?utf-8?B?L2szL3hjV2VKL1NXQkQxKzNqMHczWEI5RTAyY2xQOFQzVTZBWUtZc0lwOURJ?=
 =?utf-8?B?V29IOWxnMG1UQUR0THVzMjlZS0NBM0Q0anYzZ2tsTHF3VDFYTFRPbVF1Qk1u?=
 =?utf-8?B?NllycXRMK0d1MDQwU3FJbTEwbUx3ZERPRXd1THU1Z1RVa29IZHdwc2w0MXZl?=
 =?utf-8?B?bTkwZEpZd3E3cmx6ZDNsNnltY0tML0FIU2lUU1lIcVh2elJ5aVU5Uk1vQUJ2?=
 =?utf-8?B?RG5LbTRiVGR3blljczZHWS84ZCtzNVlIUk1yNzNXOHU1MFE3eVd3ZWVDSTNz?=
 =?utf-8?B?S00xTzVGN3UxdmI4WWVaYlBEUjJ1cWI5U2s3d3BLRlM3QkRaZUVuUTlDQmNu?=
 =?utf-8?B?WTFoMW1YSVdyUFN5NjNVWkkvSEFUWWFTQnlLVFhiQmx3a2M3V0d1M2dHRWRO?=
 =?utf-8?B?NlRMclZSLzJFd1VzNzhnR3VkQVZEYVZsVk93dkhYZ3Y4S3FGWEcxZzhGR0hj?=
 =?utf-8?B?TlVQOWphRmM1cDZNY3AyOThqZE5yMEc2dUUzdmpYNTl1VTZmK3dvSTYxY1ky?=
 =?utf-8?B?dGJ5WUZSTFE5WXZseCtKZ3pnVTB0dGhtcC9MQ21KMDU4b0h1THdIdUY4WGcx?=
 =?utf-8?B?QUwwcFdSamZubUZUc0NzMFp0dHhzc01ibGlRNVBkNDlSaGdudEhoN0RMcExI?=
 =?utf-8?B?Wlg4dnoxdllId0toaUhESlFLQlM1ZHI4NCtjQlFSUStGd2ZjblhOVVhqUTh0?=
 =?utf-8?B?UXRxdU1TaFVGY1I5YUVWVjhPTEpQNkdtanRjaklCYVhabFJlSlF4dmxjR0Jm?=
 =?utf-8?B?TUhRaStHclRmaHkxcWEyKzBIVGx4d2RINzhBc2tJV0FOZGNaTlNWRjcvcnJk?=
 =?utf-8?B?MDVzTUNYOHdqWUVKYW9zcFBVUVNrOVdyZ0NlRU1pTk1NNDdJWXp3SGRUTUtM?=
 =?utf-8?B?blFlcmxmaHRjbDFXWXVsM1Z3aEp2b2VMZmkzUGRnbUpQc1ZWS1o3TjNEWDVp?=
 =?utf-8?B?QUZMSzI5dGRGTHVrVGxRcUtSa1lVemdkWHg1MEx0NW9BSnZ3KzhHQ0VKNkpD?=
 =?utf-8?B?QW9VV1ZRb0FUODFTTElESDRLRlBqdkU5TkFQVjVzR2gwV1NJSEU5Q1U4VTdW?=
 =?utf-8?B?T3hQZ051Ym85Yk1Pc3YxdFBJNTFzVWs2N1NSTG5jcDV0aGZUSytzbG43ZE95?=
 =?utf-8?B?WGhtR09wMnNManpIeVo4UWJjRE5oY3o4b0VSM1R6ancrb25hek1waW13c1Ra?=
 =?utf-8?B?bTY4ZW8zMXI2R2RkbzdHTEFQVEQrcDJ5elVJK2R5WXdKMkFKLzRDaEkzKzZx?=
 =?utf-8?B?dUs4cGxwb1hVWk1hZS8ydnpFZjlCWVV1R0ZCT080QVpRak5adWJFQnZFRkxn?=
 =?utf-8?B?VmhzSTRISzRpQTBjdGtybnR4VVFYTXBUVjdWd3cvVWxPdDZ4RitzM1FMRHA1?=
 =?utf-8?Q?WP9/X7HywBdX8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnJKa0JtZ3NVdjVZcEZRNkVPb2o0eCtNWmtUSEdEc0RlTG1RelgxK0JwRHE3?=
 =?utf-8?B?RGZWZlFXcXRlaFZBMThBdWN0U0RBM3BSZkdUNmlJVVdKTFhGOUczRnhWMDZO?=
 =?utf-8?B?RnFtSmlPczY1V2src0EwVmtvRjBHQlNiRzlpamx2dGpvZ3plbnJVeEkvbGQv?=
 =?utf-8?B?WGZRMUFFeTFyQWx5QlAzamNzeFo1Ni9OVEorNVdua2hjUGZuV29rSVFmNHVQ?=
 =?utf-8?B?R2lvUHRaWU5HeWRSVytRZ1dUc1o0czB3SzhEekJ5czA4VVJTT3dGdGJxNHNI?=
 =?utf-8?B?WWpCRFFscysxREduZUYrc1h3NXJmc0cweElaMm0xeHhQcENsRktwOEZqaW0v?=
 =?utf-8?B?QnlKaW1oZlZGNDRjdGRhbGhTQ01xOU45T0RvWVhPMndvRUN4ckZKN2dlbGhr?=
 =?utf-8?B?bmNZRTljTCtYNEdDbFpQODRBLy8xczNDLzNTdWh3cWJSU1lFVG52Z0tLYkNa?=
 =?utf-8?B?dDgvZk1rT2VIZjhybmFYMG1NRHUxbzI1R1BPcTRTZGtiNEoyakNXMEtVcmZC?=
 =?utf-8?B?RVNibm1nSExZWS9VYUtTcEpRalR6VVQxMGZzd1Y4S2IwWk1KMVFDNDBTTnVi?=
 =?utf-8?B?ZENKM3NTU3pHRFdyZVlHeXNwam9MUXh3NU15V0J2TEs4dzVkTEdGZURKUGh6?=
 =?utf-8?B?ZWs4Y1RPaDVuQUkrNWJza2NNV1dLQ0gzcThibzJZaUlQSGExaTVOaFhSZmVI?=
 =?utf-8?B?Smxhb1A2U21pRktKdzExU0d6eXUvZ3Njem8xM0ZvMjlWK0hQZC9lSnBzOUEz?=
 =?utf-8?B?TkdVRTRWd09MZGQwS1ZoSG9QSlRRS0lYYnVlUktZQ0ZkZTBraTZZTjVKckRV?=
 =?utf-8?B?QS9ZdC9JVW1tU3JhdkxCVkpPaUVkNm1LUjFKZFE5V2pFWDNFUHRZSWovL3dy?=
 =?utf-8?B?R1ZPMFkvdEI1YUFLRW9MVzYzUjQ3VnFYcFpsMDBGRUVqVTlEa3lWL3Z1SFZk?=
 =?utf-8?B?WTVOdE9HVDRQdXYxaC90dkF2aEI5RWw1VVJlRjljclhkMi9jZEcrMnNuVWJF?=
 =?utf-8?B?aTdJRUdoaEUxSHhPN3N6MWFnSmdTWW5PODBsR3QxcFh5bFpqZTNKQXFieU1r?=
 =?utf-8?B?Z1dnbGFVL0QyZmVjMnZWcVdyWHByWFVNUlFpaFNGYm1GQkpZUjkrUXAvZExq?=
 =?utf-8?B?TCtCeFVMaWFITTFGcWlmQTFobGRQTEtydXVYc0tTQ2dQVXdVQ3M4WVRVWHpK?=
 =?utf-8?B?ZkNUK3JqOG5oUDVSY0NpK1paSHNIN0JJOWVXazJPR1M1SXRiK1BiTGlzQ1My?=
 =?utf-8?B?bXhpZy9hNFpNY25KdFIxd2JEcDl0UjBmRzN6bHRUMzNpcmI1VFovOFhDNTI0?=
 =?utf-8?B?Y1ZkbXlQaGN5Zkx0TzJNREVPTVo0RldqLzczWnhyMytHR3NXcEg5SEZOT004?=
 =?utf-8?B?bC9kOWt2VEgzWHI3OUtkVis3VnROY29zdE9WaVl3YUR5TCtvVHh1akNyM3NK?=
 =?utf-8?B?em9ja3lPcTYzaEpaODB3b1JkYmxYNTFOVzRMUGFkM0EzRE9BZFZ4NmtPWFNn?=
 =?utf-8?B?M0RYVFNZZThQZDAyV3MvMll4VnJDcnlwRlgwS2FLcWhKa0NPQ0dZaVhqQ29y?=
 =?utf-8?B?SlRNYSt4dUx0dWNwVVBpOUlubkcrQ09NMEFIMzgzc0NwcXFjSU5TbXNOZEJZ?=
 =?utf-8?B?eUxwZFRTUWRabG9IbTVIM1J1UnQyOGNrV3hqOUd2SGFhOSt2Y1JsRzVBV0Fs?=
 =?utf-8?B?bmFqZ0hzUmsvb1ZMWHhLanlKYkZpd3BtZmZFU0IwY1dEQ2dQNW5yQWQrbjY5?=
 =?utf-8?B?eDh5ZStJdTZzSkxTWTBSSE5oRUFKQnJuOEJJeFg2Y0UxbmgrQ2oyQlVBa3Y2?=
 =?utf-8?B?NE9kajQwZ005ekJXV1l0bU5QNTk4bERaY1ZMS1ptTjNMcFU2N01rYXhBZ0VE?=
 =?utf-8?B?c3Zaa2oxV3hreVhadkhRbm1yVUtGYm9KT052VXRzQkg3by9oYTZOclc3bHVD?=
 =?utf-8?B?SnF3TUt4OC9mVnduZXZDZjAyakNwQnRFU1pMTG15am1leGlyTWVwK1NOaWdV?=
 =?utf-8?B?N0lKRk1pZzlsL0s5MGxWREhDK0hZVmN5OXVyL3oyanFiZnRSYkovVXljV1U3?=
 =?utf-8?B?bHNVZndnZXlodThLL2swd0FQWWVzci9NWlNRL1lsVGZ4TnY4Nm1BZlRiVUhO?=
 =?utf-8?B?UjJ5NDRmZDN6UmxlUEVlUnFLcTNMUFhrQnlPTnB5MW1GRjVJVHI5Qm16dWtC?=
 =?utf-8?Q?e8e3DrB1/2BeUocf3gTz8eDtHe9P2+axxxAvmHJgZz58?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b1cda-7c23-4ea0-0008-08dd3197d5e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:57:15.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bYbzP+duKVVJWCS0Kdj+kqsr+csA+4VW3AX2XhlbUXqVdNTjvo0zS/kD2gq/LFl2waivioF1UGlMOYsdVrdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7698

Hi,

Thanks for taking the time to test the system.

On 1/7/25 12:00, André Draszik wrote:
> Hi Thomas,
> 
> Thanks for your patch!
> 
> On Thu, 2025-01-02 at 12:15 +0100, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The interface of the Maxim max77759 fuel gauge has a lot of common with the
>> Maxim max1720x. The major difference is the lack of non-volatile memory
>> slave address. No slave is available at address 0xb of the i2c bus, which
>> is coherent with the following driver from google: line 5836 disables
>> non-volatile memory for m5 gauge.
>>
>> https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>>
>> Other differences include the lack of V_BATT register to read the battery
>> level and a difference in the way to identify the chip (the same register
>> is used but not the same mask).
> 
> It also seems the reported POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN is
> quite a bit off - on my Pixel 6, it reports ca. 1131mAh, but the downstream
> stack reports a more reasonable 4524mAh. Interestingly, this is an exact
> multiple of four.
> 
> POWER_SUPPLY_PROP_CHARGE_FULL is off in a similar way, and I suspect that
> related properties like charge_avg, time_to_empty, time_to_full are
> reported incorrectly as well.

Indeed, now that I check the code, the current computation is wrong.
In the downstream kernel, reg_to_capacity_uah is used to translate the register
value. In the end, it computes the value as follows:

div_s64((s64) val * 500000, rsense) * lsb;
Link: https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-5.10-android15/max1720x_battery.h#36

whereas the mainline driver does val * 500.
Based on what I saw, lsb should be 1 to 2 based on the value of the register
MAX_M5_TASKPERIOD.

Basically, if lsb is 1 and given the default rsense of the mainline driver,
the two functions will return the same. 

From the datasheet of the max17201, capacity LSB is "5.0μVh/RSENSE".
So it seems that the current mainline driver is only right if rsense is equal
to 10mOhms.

The factor 4 that you see should thus come from
1. a factor 2 because we do 5.0μVh/10mOhm instead of 5.0μVh/5mOhm.
2. a factor 2 because we do not take into account lsb.

MAX_M5_TASKPERIOD is reg 0x3c which is not mentionned at all in the datasheet
of the max17201. I guess this might be another difference between the two
devices.

I think the best course of action is to correct the computation to take into
account rsense and to then multiply by lsb only for max77759.
This would make the behaviour of the max17201 follow the datasheet.

> [...]
> 
>> @@ -483,14 +608,27 @@ static int max1720x_probe(struct i2c_client *client)
>>  	psy_cfg.drv_data = info;
>>  	psy_cfg.fwnode = dev_fwnode(dev);
>>  	i2c_set_clientdata(client, info);
>> -	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
>> +
>> +	data = device_get_match_data(dev);
>> +	if (!data)
>> +		return dev_err_probe(dev, ret, "Failed to get chip data\n");
>                                           ^^^
> This should be -EINVAL.

Indeed, will fix.

Best regards,
Thomas

