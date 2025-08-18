Return-Path: <linux-pm+bounces-32571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FBB2AE6E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7356617F646
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9C340DA5;
	Mon, 18 Aug 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dDeBbDA6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2036.outbound.protection.outlook.com [40.92.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B1258ED7;
	Mon, 18 Aug 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535395; cv=fail; b=XqFNEHamgBkrccPeRF0758Vb6coPdTItKUio7/0sxdfekCSFZsia/7o0QXEim6/3DQvvphSy/sdf+I0hBfVinXd4B9K/Fmq79IaJybTxp9KXaROD6QO+nydsyUY18OH1X52DSSx1ZWyAlf21F9kfpUCw6RCW6mhsFovMX3dOLlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535395; c=relaxed/simple;
	bh=zJIPZtYxJKGSMe78PEuQBmWe2yhgGZgwHmIU2FesFMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VC1KR0xmcZYsdVil2B7YOwkpCs2WUW+jcqJRWAqIgV/ISMAxA6Qa46At1j4/owL7UkrgFHta3gewCRJuNyqXhLzE/61e0Qv8gYeENbiegMnOl0IFYGGFRtqqb5+NuM8Db36eXHRYp80QQoLYCB8MNvtGYkCaVXF1m298vwOUak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dDeBbDA6; arc=fail smtp.client-ip=40.92.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOcjqUiWhdzP+oyBLmJ0gAi68IOvM+F0lEs/MoONrxwrwfVRup4bvZ9g+c9GV/GG/JP4CLp/klbp3x055A/a659gBAx7T1SfEEs1179oYEd+sprNHD4GcKsKWhko+fTYQo0to8cufRI3RUjU8JdAZ4hdFtzg1bfvtop9cw65GrEOfz3E0yABrr9bf9YXorPQzIpJFuQAw6YCMl6JZvY/GsXqRTQAfyY3RKbhdCZoa/hlwT+ZfS+PGJ2yHCvXw96mQqIJ8ubMdW78e1kUNEpyDdReKNh4GZN8pDnjk+qppkPwQSCUPWKVzayG03kptmQL/HrxAYhOAKMlyRId01uy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/uJPo7TXCAycPYaRNOytX3CUsKzzYD4MQS3KKZiHlM=;
 b=ZG9B4/ffwY6AFOs8HyNMsqgcVd87B5czpxuxyrZ7L8qpZOcjJT4HGnkwFTKYyniv8qgNG20b5dm96YFmbnhBM97qG3y0KZhvO7TmdBj8bJoIgu0uYT4Zkri/aIi86uZM8K9IondeLccQRPHA4ZYdbhKTUUpSEqMrcEmjHH70AuPVKZcgrHdzWxRokdSpWoOEQmMTRTkJ/L3tqSPC5t/SgIATbSC05UcXEgBRFLhDijZG5PQRr88Sdme0VhdWQDr+QxP3S1RAeg95ZR2qcUaJAWtGoE3fkyHyaohXVDnQgfT40vbQpUAxrnFPCqOh1fyqdH/JLxNv/DONYrMSRY6XeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/uJPo7TXCAycPYaRNOytX3CUsKzzYD4MQS3KKZiHlM=;
 b=dDeBbDA64k62tP+zM6x3OJhEWoh0/FIN6qaRsb/S9bWDMxOBhvDcJLncrjfbSve2ZLo7Amrcyq53X9NhQkRmExYftP+YzX3ISrAV3kLOsJhMcCBX+jXaXCmC8nBuBpySepminZJurgocnI+6u1jreGQgIGKwHTzy38qr9hNO94qCUTTMa9sSkez3JMple/1hox39ofDCeJoTIhF1LaSkgE/pXBn2e6ze5oHAIhmsQS5yTOYOFvJ7eVJkzP6MDUU72qVJv7t1hzQ7HI5gXVYYmrGEX2ZfflTPfJSrfIXYr76eg1+RamTK7A+rYKIfn5TO3szWV5y1kxvrj+08OSGjnw==
Received: from DM5PR19MB4646.namprd19.prod.outlook.com (2603:10b6:4:a9::21) by
 SJ0PR19MB6813.namprd19.prod.outlook.com (2603:10b6:a03:448::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.23; Mon, 18 Aug 2025 16:43:09 +0000
Received: from DM5PR19MB4646.namprd19.prod.outlook.com
 ([fe80::11db:b5b:1230:2947]) by DM5PR19MB4646.namprd19.prod.outlook.com
 ([fe80::11db:b5b:1230:2947%4]) with mapi id 15.20.9031.012; Mon, 18 Aug 2025
 16:43:08 +0000
Date: Mon, 18 Aug 2025 11:43:00 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lee@kernel.org,
	lgirdwood@gmail.com, sre@kernel.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH V6 3/5] power: supply: bq257xx: Add support for BQ257XX
 charger
Message-ID:
 <DM5PR19MB4646929CD183E2B110B6AD5AA531A@DM5PR19MB4646.namprd19.prod.outlook.com>
References: <20250812214300.123129-4-macroalpha82@gmail.com>
 <202508181503.GrRD2T4C-lkp@intel.com>
 <aKNGCg2rWT7GLNnt@wintermute.localhost.fail>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKNGCg2rWT7GLNnt@wintermute.localhost.fail>
X-ClientProxiedBy: DS7PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::17) To DM5PR19MB4646.namprd19.prod.outlook.com
 (2603:10b6:4:a9::21)
X-Microsoft-Original-Message-ID: <aKNYFH905R_dhubG@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR19MB4646:EE_|SJ0PR19MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 572e74aa-f249-463e-690e-08ddde764f8a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|461199028|5072599009|6090799003|41001999006|23021999003|15080799012|4302099013|3412199025|40105399003|440099028|51005399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWUzS1RNQVAwY0RBYW1YSGRVU0dEWjFsalFRNkhkRmFIZnJkYklhSXNsWXI0?=
 =?utf-8?B?TldRTjU2T3gwMit3eXpzREEra2J5ajB0aGd3NVdLS2djZkJyNGgxb0lTSGdP?=
 =?utf-8?B?M0ZtN1p4OEpyOXJYV01jTGV2bkxqbGNhTjd2WmtqbjdKTThWTFlJcnlYd01O?=
 =?utf-8?B?TFdSSFBIZVQveHJaOVpoa0NaNkRJQ2JjZ2hVUHUwWWU4b0ZwSkdQKzZ3VjlF?=
 =?utf-8?B?YUpoRW8vdGdORkF4TWZodURqQTZ3aTNPaWxhdkpldWpkWWRCQ3dmM3pqcDhx?=
 =?utf-8?B?MTVEazBYdjdlN3lWZ0QxdGhzTlZrTTNFaENYREtQditWc3lKVXBVcHFHSWlv?=
 =?utf-8?B?RzNKd0lUUHpqYklKZHl0SnlERlNUQVpXbGhiVVZxRmRKanlhajVGUENFVHN3?=
 =?utf-8?B?QWhkd09tZXhPdDBvRFFabjBWQlRFRU9vS0ZDekRLRlJJS3RrZ21MVUN0Sysr?=
 =?utf-8?B?VmFvSXI1ZkhRZ0pjc3FHVVljd0dNOEpwRlZQZGlLVVlFclZyckV5VVIxS091?=
 =?utf-8?B?Rk1pdnFTZExkemVCK3Z6M00wV1NGRzNXZGRZVE9BZSt1L2pDTnE4WXlwNy8y?=
 =?utf-8?B?cXF5SThZR2ZXdmEwMlBMeEFpS1c5TEVQcE1UaVJDM3BGN2U2YXlyQkVzVlFy?=
 =?utf-8?B?RjQ1WVM0YzZXUThZWEhQNWpnMS9oUHZOZW9tbk5tV1MzeGhONVI3d09idkZI?=
 =?utf-8?B?VHBPU2xiZjhFQlg2amxabms0YVZEMEFVYXJIelV4M0tHMzdla3JOWDRieWhl?=
 =?utf-8?B?ZjhPZ014VFRRTnEyVzFzUjl2YzlEWE1Fc0VQMHo0T2pzUzQzSUUveFlBTGUr?=
 =?utf-8?B?WVJTR0dzc1M3ZTk3TDRvZVcvUS9xYkF4MlkrYmhVYjdhdHpUWjQzdStIS28w?=
 =?utf-8?B?OFArZFVZU01sSkdmOFRJL2VLczBqUDM1V3V1bmhocmZFYzB4NkhpdkNWVFpv?=
 =?utf-8?B?WkJkRlNvaVpsM0pmaWFDeFRteW5QempLNk8xM3Z0bUgzSnlqaUs0NGN1YUF0?=
 =?utf-8?B?NmhZR2l2YWh2aDBaY2V2S1FLcndYYXlueEcwSUhBTVdrVkV2b0FiWndFZ2Uy?=
 =?utf-8?B?TzFPbVIxUnovbTlncnNPZisrREh0UENFcmxJUEhPeGh5dTVLZVR5MERaSmFE?=
 =?utf-8?B?cGZscGNlcnErT1haclMrU3BnL3Q0QUQxVGpudHNoNk8xcWRXampqUVZONHJJ?=
 =?utf-8?B?S3RCckk1NkRZcEtlOHE4cXJNN3JRVFNjalRIN2E0c0V2NmxISHhTQ2hVWlRC?=
 =?utf-8?B?SVRyeUdQOVRQc1ZXcmpraTZjU0tjMTFzRG4yS2R0WkZ4czZRQ2FmOWREWUFE?=
 =?utf-8?B?czlqK2ZDaWROQ3M1TXFvZkdMS2hJYktVaTVsZ3VHVXFtUTRsdWgxVHZsTXVz?=
 =?utf-8?B?SU9NVmh4dCt4VXV1RUd3MzYvc0FINTFjdit0T1UyL2lSL2NNMjd2ZTg4TU15?=
 =?utf-8?B?YnQzeDRVMTVzcXB1U2hzamZyeE93QkRYNVppcDl2VmtCNXNHdHVsUUw5UlRG?=
 =?utf-8?B?cXU1dU9UQkphN2x2cWEwdVZST3M3ZHBsQ1hZdm1IeEpleGI4ckUzS3N2eDlL?=
 =?utf-8?B?V0dEb1BuYkFzZUpkMFV3OWJZSWhCZE9JTzAwNlI2OXV4S1RmbVF0T2R1dWVp?=
 =?utf-8?B?SXhsT05YK3BoK2g0WDdqVTlpa0xjNjA3RDRId1MwTGwwdEo0bFJ5c25KMHVS?=
 =?utf-8?B?RkVmNmljc0NJSFphcThTdW1CZVdCR2hmYWxEdVhsQlBqTC9rVmppTmd3bHlp?=
 =?utf-8?Q?AYUwrt7Lx3hWczsarAQR6ned69RygwF7g5bcnj9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXNOSVJtRGg1Y0NidHI3bko3TnB1RWVScnU0WjRjN3UvcTM0dzJVZC9rVi82?=
 =?utf-8?B?K2k1dkdVdXR4Q0RlNmY4SFVENS9BSFBNYjZaUGpld1B1U2NJUnlzaU9pNFkr?=
 =?utf-8?B?TllVbGUxTGtHQXVmTHFZck9OSiszMjkxZDVYVWN4TU53bTlYYXg2VjRGVmJJ?=
 =?utf-8?B?NzFlVWI3UnpIbzRLNnE1Sm9TODlzeWZ3NUdRRGszS1pid1hETW1RWEZMOE5K?=
 =?utf-8?B?emxqcWkxOWp6N00yTmw2c2tCUVhJa08ralFmZ1dmRmZrL2d6enBwdjJYYUVB?=
 =?utf-8?B?UGU5NjZsdk95YVlCU2xMMUFPd2hkb0VBeUYwSWhYZW1YNUtVaEg3VENBREo3?=
 =?utf-8?B?ck1vU3M1Q2h1WTRNUm9pcC9yc3pHbks0REJnVHJBcW5YeEw2MTlzcm5mdytB?=
 =?utf-8?B?enRiWWhkamFONWZ1N1AvZmVwY2FpQmh0UWZDUzlOMFd3Rm1jU0d5K2JsZStt?=
 =?utf-8?B?S2Jaa0pYUVM4V0E4SUlVckw5M29TOXRPZGJnSUEvSGVzYUJ3bVF2dFFpSFli?=
 =?utf-8?B?d2hUUWJlMFQzOEI2S001K0VJakJCaFkrUHdlNmRGVUN0eEpZeWJZZmFvRjRt?=
 =?utf-8?B?L01TdDU3SUd6KzNtTUdka0xQQWJsTlZ6QXZLcnpiWDhlUXZhL3laUm5ndzZa?=
 =?utf-8?B?dXpIaUxlTHk2TU02cW1KM2ZGdTRyR0E2MGZsMHZQZW1vRXZLWFVXMm4wU3dj?=
 =?utf-8?B?OEhHcXo1V3hKOUl2Ry9BQU01K3cvQkEyNWhGZlN4R0w5MnowOW8rL3pWam5L?=
 =?utf-8?B?aEtvU2l6NDBUUVFGZWlUVU9QbEtSREtjVkxqVFZybnpMWHlvL0VBQ1V1UGcw?=
 =?utf-8?B?ZkJ2dEhYUjkzYXpjSy9KSjRtc1JKc25SZFpWam03QVBocTQ1STFmUU95R25n?=
 =?utf-8?B?cC9rYTR3ZENiakFZZUVrMktkc3N1ZGtaY0tOUTJuQmNKdnd6Q01uczlvU1Qy?=
 =?utf-8?B?bVM1MFhOYUthVGxDNTBUTi9ZRHYzVWRCaTErckdEVmIySHVWZXhFemZ0MUo1?=
 =?utf-8?B?bFRsMlA5Tlg3VS9TRXhvL3RWWFF0UEpsMW5iV3Q3RUhlRFRKOGdFaEFQRmls?=
 =?utf-8?B?VmhnWGphaWFmcVBIQVk5Wk9xWVRQYk83M2FocklUM2NMOHZKTlh5S0xZWUl3?=
 =?utf-8?B?Z3BHZmdlOCtBc0lmRTVKblRKNjhxN3lESWZDRnRjRitMZVZwSkJ2a1NSMmdZ?=
 =?utf-8?B?NU9zUCtYaCtUWWdiVm9YMDd2ME9kWDdCM25EeWx5NklHNkx5enFGS1ZMazdD?=
 =?utf-8?B?R2QzNDMwRFpwVk56eC94a2lzbnRnSWxBbU1Cdm9BMU9hdFp1bTZLZGR6U2wy?=
 =?utf-8?B?SG1jMUoyZVFOMWg0MllQWGoyK2RzNlFGQUNJTVI1MVRxYnNMSUJRTG5EWHJ0?=
 =?utf-8?B?bUVNcHpPWUFUcVRObUdZanVyZi83K1NPOW9KOUFuMWRpV2F1M040bldrNDh4?=
 =?utf-8?B?SUhCTlVoTWpvQmUyL3g2RmlmckhRbDNJSFgzTXBVN2RON0MvL0hDN2dxVE02?=
 =?utf-8?B?VENOYjBQTXNJRHdhVFVNVjhNMFl2Vm1rMFJxMUR1UkVRN3JjZ0FPdmZVRXg5?=
 =?utf-8?B?R29Ca3VkR2cxWkNVZmRxS3hIZVpCdG43TSt3OEJqNDgvVGxMYlRET3IrMFVT?=
 =?utf-8?B?aTJNVWw0VXcwTVM3SlNSaGE1OVk4SHJ4OWdnRnlkdDk3V2Ywd2M1S1BWQWVS?=
 =?utf-8?B?OG5sZ1FIaUJXdW5wem1GMndQNUg0WWNRV0lSd2lMenRFVkZqNGVBR0o4Tnpl?=
 =?utf-8?Q?yERIxx4nfzapzmHZpWEB6+Ww9Gn+VFtE+KrUGaG?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e74aa-f249-463e-690e-08ddde764f8a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR19MB4646.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:43:08.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6813

On Mon, Aug 18, 2025 at 10:26:06AM -0500, Chris Morgan wrote:
> On Mon, Aug 18, 2025 at 11:22:35AM +0300, Dan Carpenter wrote:
> > Hi Chris,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-mfd-ti-bq25703a-Add-TI-BQ25703A-Charger/20250813-054704
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> > patch link:    https://lore.kernel.org/r/20250812214300.123129-4-macroalpha82%40gmail.com
> > patch subject: [PATCH V6 3/5] power: supply: bq257xx: Add support for BQ257XX charger
> > config: parisc-randconfig-r072-20250818 (https://download.01.org/0day-ci/archive/20250818/202508181503.GrRD2T4C-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 8.5.0
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202508181503.GrRD2T4C-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/power/supply/bq257xx_charger.c:392 bq25703_hw_init() warn: potential ! vs ~ typo
> > 
> > vim +392 drivers/power/supply/bq257xx_charger.c
> > 
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  365  static int bq25703_hw_init(struct bq257xx_chg *pdata)
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  366  {
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  367  	struct regmap *regmap = pdata->bq->regmap;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  368  	int ret = 0;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  369  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  370  	regmap_update_bits(regmap, BQ25703_CHARGE_OPTION_0,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  371  			   BQ25703_WDTMR_ADJ_MASK,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  372  			   FIELD_PREP(BQ25703_WDTMR_ADJ_MASK,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  373  			   BQ25703_WDTMR_DISABLE));
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  374  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  375  	ret = pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  376  	if (ret)
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  377  		return ret;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  378  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  379  	ret = pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  380  	if (ret)
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  381  		return ret;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  382  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  383  	ret = bq25703_set_min_vsys(pdata, pdata->vsys_min);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  384  	if (ret)
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  385  		return ret;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  386  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  387  	ret = pdata->chip->bq257xx_set_iindpm(pdata, pdata->iindpm_max);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  388  	if (ret)
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  389  		return ret;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  390  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  391  	regmap_update_bits(regmap, BQ25703_CHARGE_OPTION_0,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12 @392  			   BQ25703_EN_LWPWR, !BQ25703_EN_LWPWR);
> > 
> > Yeah.  This really looks like it should be bitwise negate ~ instead of
> > logical negate !.
> 
> Since BQ25703_EN_LWPWR is defined as 1 and I want to write 0 here (to
> disable low power mode) I was under the assumption either should work.
> That said, I'll happily switch to the bitwise negate (~) and resubmit.

Sorry, hadn't drank my morning coffee yet before I sent the last
message and should have attempted it first before replying. When I
make the requested change I get a compile time error of "conversion
from ‘long unsigned int’ to ‘unsigned int’ changes value from
‘18446744073709518847’ to ‘4294934527’". What I'm really trying to
accomplish here is to simply write a 0 to turn off low power mode, and
do so in a manner that's easy to understand. I think since a bitwise
negate gives a compile error and a logical negate throws a smatch
warning, the most sensible thing to do is simply express this as a 0
instead of a defined value and write a comment why I'm doing that.

> 
> > 
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  393  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  394  	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  395  			   BQ25703_ADC_CONV_EN, BQ25703_ADC_CONV_EN);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  396  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  397  	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  398  			   BQ25703_ADC_START, BQ25703_ADC_START);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  399  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  400  	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  401  			   BQ25703_ADC_FULL_SCALE, BQ25703_ADC_FULL_SCALE);
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  402  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  403  	regmap_update_bits(regmap, BQ25703_ADC_OPTION,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  404  			   BQ25703_ADC_CH_MASK,
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  405  			   (BQ25703_ADC_CMPIN_EN | BQ25703_ADC_VBUS_EN |
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  406  			   BQ25703_ADC_PSYS_EN | BQ25703_ADC_IIN_EN |
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  407  			   BQ25703_ADC_IDCHG_EN | BQ25703_ADC_ICHG_EN |
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  408  			   BQ25703_ADC_VSYS_EN | BQ25703_ADC_VBAT_EN));
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  409  
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  410  	return ret;
> > 7f3b6f1e51a925 Chris Morgan 2025-08-12  411  }
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 
> Thank you,
> Chris

Thank you,
Chris

