Return-Path: <linux-pm+bounces-10740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F034B929BFC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4771C21359
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0182125AC;
	Mon,  8 Jul 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="dmKPgomT"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0014A85;
	Mon,  8 Jul 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419201; cv=fail; b=TjhspvjgZTRtBHLrb+QsmXYkvVc97wwi+vzEG0ptNkPpGtD/EDx/wTtVYGeRWzHdvVDLa0Gl9BNMxR4S70ldSw6AQP9hnF71DlE9rICB4U/xr6KBlZT/hRLMgZNG2MSbc6cUzAkHPbS2NZ3BiegwjwtBSREyaNO6S9LatlrLrnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419201; c=relaxed/simple;
	bh=xieq2hlrYH3O9UYEdo7/eIOpOmwEhiv9v7vxGO2Vy34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkYodKXiNG0SSOJEFHg+t20BFD2HIixNXpBLHiso0BWb9G380rWG6BvaGSRT9P3Fy3LhgTJdP0yawpegXYNYvs+ASFw2D+0gOASOeoNRXb/y75jEkw3PFzuZSei1TPl5p+niG9fuXCr3MegKRi3A2uzt2aCcitr8ZBnnXrwHTAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=dmKPgomT; arc=fail smtp.client-ip=40.107.215.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLAz4RTBqr7XzuOGlsaDKZ7wpDxqq6TmC4x9HqGMkl4G7PpMSVlvK4eNBFbSiaEd0vMrWqlSpb9RKyVPGMIiGkAOLh2j5ChdtZ5McNaD2/0FMfspzbUW1ntQ3iJL/4gx6zAzGOGkzruGHTrV+1T5utqqPwdMs1tZRBjoq/CmVQ16Hl67QQefdPwQq7tdBHw+0u1jzhugAqIg7d5QSA5LJLODmeGcLeFOxFdu07nM+YjdQE3mqtO3LAXPGEXrZNA5IFJ6F9FM8k1uABJuhYBrTVcvuXmglwHmpcEP6zcO5wUQbAnoR5tb+zjVryJoWRFd7P+qW8KA8nTmYAMqRBmo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Q9ZG5hTMrjTGKfes56hn+j5R7eKi92c/J7sqKaHF8=;
 b=LzF+KvTbPFQTwJdO4vxH90WEzGRii2/XR8psdcCaX7vHFo3ujSj6N1pQal77MWuADm/1LbOr2VaqJ082uHvdwsarKSjjJfZBwBRPPCjpQr4YR6KkQFPI5VOYpR8xnb4IHVgBH/vS6Ee6s9vyrhMCQC90ljn3n1Hj22Tp4/qqrPZiK6mzGTXC+taGHGQy6pv42eLzHeXxTvzdfcVq9sDuXXB5auqwB4ZAvHGcuNHzy4Z3wIaj6P996g2VTSqGx5cYUY9SaIXg5ukLXewFT4Pzz6bBSVf8aDVyfBlBO4Qy0Y0aL6ZGFc4c4dfiy6jlnkyFCoHEZFDVAdbZGhA25DqoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Q9ZG5hTMrjTGKfes56hn+j5R7eKi92c/J7sqKaHF8=;
 b=dmKPgomTh1LaT2Y8U5GIZV0pQRTRoovRF/T0rES+zrD2MNnHsXfQZIj+8oE2NaMmFx6YcfCVe5L6+4gBdTvkg6iPNcCluEOcJdeOtNy3Q86PYQOtvSNE8FhsG9fwtO5YIiMiHa72B0BfuWJRzXdL5tI+Tin8mrp+/43rXXMEJjwvJa9dXiIwghzdo3e/JfSrSy7VLuHNKwnQIWzMMO84HDyi8B5ZcbrJmrCDwh17DxO8v4DxDLTXGv1aAOc9lEd/jjgoGX7Yk9PZbKhvowDcVE7Y1zqYE0cW1K6YpmiBA0+Cc8hjNFqzrEclI8jueTsnSfeFm2tdtRrgx7crrT10Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7333.apcprd03.prod.outlook.com (2603:1096:820:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:13:15 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:13:15 +0000
Message-ID: <25ead9fe-0747-47fe-bf7b-0958706377c8@amlogic.com>
Date: Mon, 8 Jul 2024 14:12:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc
 WCN chips
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
 <CAMRc=Me+Fd_Kjgm0u0JhUatVEp=XS71xys82snAimpw2U5MQTw@mail.gmail.com>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CAMRc=Me+Fd_Kjgm0u0JhUatVEp=XS71xys82snAimpw2U5MQTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5aefa9-3e09-487b-f8b0-08dc9f150da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVpkOU5CQ2JPMkNXY0hqSDNvZE1uamhnZ25HaTBoNXRvc0YzODBJUHJoUkNL?=
 =?utf-8?B?YzEveitQM0hIZ3dtZ1V5aEcvYmpKYjgrYUNGelhlSUdYeFRBSHJiQmwrMnp5?=
 =?utf-8?B?S1dyd0h3aC9YK3dUekZFMkNZU1JmbCtENldyaU9jYnN4NXl4RHNoM2pPeFYv?=
 =?utf-8?B?SG9nQ21wSXNueDBuT3IvR24wclVtb3JCNUdaeVFiRFIwVmNuZFVjdzRIZUxm?=
 =?utf-8?B?YTRtdXlWQWNKKzZNc01kZG5CT09IK2tUYzBnNExZcXIrc3o0am03ajA1dFRq?=
 =?utf-8?B?ZWZKQm1TazUveVNtMnRuSEhjRXg0UmZLMHdzZWxBaWIwcHl5aGVPQkhKVUJS?=
 =?utf-8?B?WnZVZDNuRlZJdzlMMGF3QUdIVGU5T1BLN1htTXdrcDkwTDJLdTF1OG1ZMHBJ?=
 =?utf-8?B?bVFkU3NJUDh6M1dUYXlHVUtVOWdML1pIZnZsTUxWQlMzUmlXcS9WVHFScjh5?=
 =?utf-8?B?dXp5QW80cWw1aEREZ1Jkd3NGQzNwbzZYd3ViNC9JL3NoMGV0andMS2hFVUpM?=
 =?utf-8?B?MVYwbi9EVm5GT2QrMXVPTW03bzdSNnBaT0F0RGZRR0hEaHI1NitoT1VaQlE3?=
 =?utf-8?B?NmY3NnArRU9xVGluQkFPd095T2UyTGpCZFBFUm90bFFlMURkTnBobis4QjQ3?=
 =?utf-8?B?ekhCZ0F0alRhdnpMaDVMMHFFUUl3eXk3Ym43UWR4VUFDVkZvelBoeHdhRnkw?=
 =?utf-8?B?ZU1QN0xWUnpZeTFoVm9NUUR2NzFDV2hQcGY1cGFMVWFMUDVXLzl0ZHVPV2hq?=
 =?utf-8?B?YWhqb3RJeUF4OWt0OWNuOTBQczFibjJCRHRxNzVaMHJCWHRZdjFzQ0JnUmVK?=
 =?utf-8?B?eEkyV1Z5UHcza25yRnlTVldPSS93a0wxMmlOWVN3ZVZJaG5CRzcvZWJoU1hB?=
 =?utf-8?B?Zk1xK2JwSDcrMWRiaHNJay9MR2RqdW5DSk9IUmFGbmhPcFFLQWp3czhtaDZD?=
 =?utf-8?B?RjNFUkh3ZmxxamprUTVad1pZOFR5ZDcvZ0EreXcvREwwdDk2UGVaOVMrTnA2?=
 =?utf-8?B?SzBTQkNXbDVDUGJhN2dZRFplZ0txbThZZ0RRUi9RSmV6R21Rd29nUHdJZElz?=
 =?utf-8?B?MlRxZHFSQklZZHl1eloyWWFmNjBzTm4xcDk0djhwNnJLeDZkaXlkNVIrZFJU?=
 =?utf-8?B?RXNHb0d0bDlqTEMybFRSdnpOcVFXdFRzUURBVko5cE1nUXZycW9RWmJuOFNm?=
 =?utf-8?B?U1B6MHd3R0JveGcxbzkrYlo1VjhZSzhUWUZ0Zm93R3VCVnBmZTlaVzB6b2dR?=
 =?utf-8?B?NzAvaDJGUVZmV01RbHhVQ0IwZUpYZlFLMHJKaU9xKzNWaDdheUNnQXpFcDd1?=
 =?utf-8?B?QmNZUFZLTEtsZFRxcDh0dk50RWNabUlDSHdnamlVSTJheW44bUZNUWhva3ZU?=
 =?utf-8?B?NTd1dzRWbFdWWmNzN2FXYVZBdXkzcExNYnBMWGY2dHJYVGFtQ2w5dkU1UXBL?=
 =?utf-8?B?aW5PRVN0RDljSzErc3lRblpRMmhIb3kxYjRTSmFNZzlaR05CVGh1WHY2THpN?=
 =?utf-8?B?d3pVZ2U2KytJKzdjc1pqVEgxK3pFcWErYmNOLzh1TTYzOEdZZkl5UXJyZTlh?=
 =?utf-8?B?ZGd6WG9aNTIzY1VabHVCZThHV2RjMWFlMnFyN1RQcXlwOUFHZk85Zm93cXlP?=
 =?utf-8?B?RkdpN1MrZmd6eHoxNVJMYWFEclU2aW5pZk9YRjNwUStPZC9pdVlRcFRNNUFt?=
 =?utf-8?B?Unp0eXZNUWRjeERLTzl6cUVtci9UbCtnNEpuMElXOUo3RDRMMVQzRU5xSGNM?=
 =?utf-8?Q?XrIPcAkW5dIAlE9UvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SldrNmVmcTI3K3ZBVW9NczFTYjZJYmZSVEFHSHdFKy9SQkRQdldRd1p2QUJU?=
 =?utf-8?B?cnFGbzlYRHgrdUZUTjBWSms0L1FVQjI2K3J1NEVqZFBCYVEvc3o0RmduOFZS?=
 =?utf-8?B?SjJ4bTlzT3ZiUUxhNm5QWVdIVVFvb2tXTlEwclFDa0RXREtQMXVMakQ2NlZp?=
 =?utf-8?B?VGVmWUdmVmVZSGFqMVdpYURtRFJub2gwTHVMTmlmNCtGWW4wKzlsKzUwVDQv?=
 =?utf-8?B?c1Y3NGQyUEo1bFhqc0dwekFGcENaQng2Mis5czQ4cFJRcE83VmpHdkcxeW4y?=
 =?utf-8?B?clJQUTZ5dEtLMEwrYVE2Y0xEM0Fzbi93QVpzY3NSS1l3bHZtbVZrYVRyMTdO?=
 =?utf-8?B?U3dVU1RIKzFoaVRWWm5IWWFaODltdkN4cFUvcEh1eENzTTRPZk81NllhVnkv?=
 =?utf-8?B?U1FSM0NRVDVVOE85MXhGeHNJa3hmeDF6MWthZ25zZXB1RGRLaVFzNlZObE1j?=
 =?utf-8?B?OTFrRHZocDdOY3ZGcWNmRU1xempuSm4yOHpoNlZZeGRkUlQ0U0ZGbDgvTmJX?=
 =?utf-8?B?NitueDExMmpGQzJ0UG1hUldqMVVvZzNvSWdHN1FvS3psbnVMOE51RmRnU1U3?=
 =?utf-8?B?S1d3cUoyYTdvbWd5amZuV1RBN0E1Y3pjZVplL1E0YWkvdTRIOExRN1ZxY0dy?=
 =?utf-8?B?TUFEV1UxYlQ4bjBlcVVIV2xPOWdPYkIvTUVlM2EwVUFGa3Zsalo3em56bWMr?=
 =?utf-8?B?alB6dFdRQ1BOYTdLMlBXSTU1RVVEb3dGYkFIZkFqYnZjSjVpVVFmWExSbEl0?=
 =?utf-8?B?YmdVb3NlTFdJdis5MWpWOWxIbXJJbWZPaG9nL0NFejhwTDRyeE5XL3kweFlk?=
 =?utf-8?B?R29mOFN6WkVRMWFGQnhIUlZ4RGhDWmZhNDlPeXVLZzFRM1V3V1NVd0tWYUVa?=
 =?utf-8?B?RXJUZVQ2TUJCS1g5bHBxaEduNGFSU3JSK2ZWUFRNWXRweE5RRFdiQUNzZmlW?=
 =?utf-8?B?WmxYbEl4R2pLUkRwQlAyaVFOWTVGbTZmdXpDdUsvSWNrTXJnaTQrZXRMOE9J?=
 =?utf-8?B?ZGx6VnhTSDB6QVVtb3Y1YXFZYTlhdm9PMnhQRmhJYzgwNVc3d0o0c3hKQTZP?=
 =?utf-8?B?R2pFcHVYSzVrdXlXNHQ1UWNwR2owcTRrUWNQSm1HRHlhT1AzWkV2ZjUvcFdk?=
 =?utf-8?B?YjZUdVVOVGZ0d1ZXTkU3QlhMTXVVUkVtUkxBWG0ySWtYUDNvY3BZRXl1R2p6?=
 =?utf-8?B?bTR2VEplUVFOSitzeHM0dE9mMFRSaXZVM05CZHRGNnoxRytsdVgzN1dXTUty?=
 =?utf-8?B?MXMrYWhpSlhvZkM0RzF6RlVTM0hWOXFyRklOODIzTlBDZlFGWGNrQjd0a3da?=
 =?utf-8?B?NzhKWHJTYnJ5SlpYK0JzYkhOdkZBb1JLMmZxdm92RGs3MzdncG52M3dvcFZu?=
 =?utf-8?B?UFMwdjRBdlo1V1FHTlpTbVBhMmREc0JDODhvUmxMaUxhSzZzQUJvWE9yL00r?=
 =?utf-8?B?STFjRGkxSGhLTk1IQ0F3dVJSbDhZbHJjT24vaGo5c1Vjc0RwQmdrOTB5MDlu?=
 =?utf-8?B?cHZ6WHJ1aUlEOXlLbW81NmJLNTUrVlV1NVFKU3hOSUxJb1VQMklPaDY5ZTNN?=
 =?utf-8?B?ZktvdC96MENNM1B5WHk2bmcwN3pCdEJRWUt6WmRQdFNxZElkMGRMV2U1YmdG?=
 =?utf-8?B?VEV1Zk1sZnAyMWNCNDRqazZTYktXcmsxTExJY20zam1WamZhRjIwTlBoTnpD?=
 =?utf-8?B?ZmFmOERVd253Q0RadlNxdUlLSFhGc3UzM3ljTWNoaVNsZVowT2NCRkR6emJo?=
 =?utf-8?B?NlVVWEQ5R2V5cmNQNzZGMW9rZ0VSeTJCOTIxZHFOeWR2RmxNSGVRYldKQ3VD?=
 =?utf-8?B?akVoUE9NUFRuRmRNVDBrTlQ5eVRKampndFlXK2lKYTZrZ0ZORjJNeENUZnYr?=
 =?utf-8?B?SURvdFMraGdzemFVdFNUZzEzYkRtMWlJejNKTUQwOFY2R0Q0V1k3VE03RnF2?=
 =?utf-8?B?dFRwcHFRMno0K1VNRXZ5RlV3OCtQem1Ic1FsT2hpRFdURm80elR3eFFsZVpH?=
 =?utf-8?B?T0c1V1hVa0FkZkl3WXdwdVRaVHQ0a2tGQ0lYM3hzNW1wdjJkY1gyMUVrVkdl?=
 =?utf-8?B?OE1MZ2dQSXlUaUkveG5mWGM1eW1DRml5SkhkZ2VQalA5czZFVzd1YUNDWGd5?=
 =?utf-8?Q?yaWGj8MZ/L3uFnNbJU1Cz8Xa9?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5aefa9-3e09-487b-f8b0-08dc9f150da7
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:13:15.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/ObPaJ8OFYP3RCcOaJ9FIZaTtElWLgawrjHzA+wGvSuMWTS88hCjrJfewhkkVB6aFUka2bUx+vrEZmVVpfR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7333

Dear Bartosz

Thanks for your careful guidance and suggestions.

> On Fri, Jul 5, 2024 at 1:13 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add binding document to introduce power sequence of
>> Amlogic WCN chips.
>>
> Hi! Thanks for the interest in this new subsystem.
>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   .../bindings/power/amlogic,w155s2-pwrseq.yaml      | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
>> new file mode 100644
>> index 000000000000..f99a775fcf9b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/amlogic,w155s2-pwrseq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic power sequence for WCN chips
>> +
>> +maintainers:
>> +  - Yang Li <yang.li@amlogic.com>
>> +
>> +description:
>> +  The Amlogic WCN chip contains discrete modules for WLAN and Bluetooth. Power on
>> +  Bluetooth and Wi-Fi respectively, including chip_en pull-up and bt_en pull-up,
>> +  and generation of the 32.768KHz clock.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: amlogic,w155s2-pwrseq
>> +      - items:
>> +          - enum:
>> +              - amlogic,w265s1-pwrseq
>> +              - amlogic,w265p1-pwrseq
>> +              - amlogic,w265s2-pwrseq
>> +          - const: amlogic,w155s2-pwrseq
> The name is wrong. There's no such device as 'pwrseq'. There's most
> likely some kind of a Power Management Unit and the compatible string
> must reflect this.

Yes, I got it!

I will change "pwrseq" to "pmu".

>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock provided to the controller (32.768KHz)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ext_clock
>> +
>> +  amlogic,chip-enable-gpios:
>> +    maxItems: 1
>> +    description: gpio specifier used to enable chipset
> Why not simply: chip-enable-gpios or even enable-gpios?
Well, I will do. "amlogic,chip-enable-gpios" => "enable-gpios"
>
>> +
>> +  amlogic,bt-enable-gpios:
>> +    maxItems: 1
>> +    description: gpio specifier used to enable BT
>> +
> Same here: should be simply bt-enable-gpios.
>
> Bart
Well, I well change "amlogic,bt-enable-gpios" to "bt-enable-gpios".
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - amlogic,chip-enable-gpios
>> +  - amlogic,bt-enable-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    wcn_pwrseq {
>> +        compatible = "amlogic,w155s2-pwrseq";
>> +        clocks = <&extclk>;
>> +        clock-names = "ext_clock";
>> +        amlogic,chip-enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
>> +        amlogic,bt-enable-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>> +    };
>>
>> --
>> 2.42.0
>>
>>

