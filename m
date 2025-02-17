Return-Path: <linux-pm+bounces-22178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F1A37A08
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 04:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4197A2B8A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8F14D444;
	Mon, 17 Feb 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oLOsbCF2"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECF14830A;
	Mon, 17 Feb 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762062; cv=fail; b=FJRDClzskoOz23qfW1wkR2g6tXnvEbYolKqO1n9L/t8yXf/Z+khUEKHtKlhX17zvESOWWNdHsr4Cycfs3568n/NyoAUbRwxTNGKVqDu2JF2BXIdNRAKIEEGWERctjX72OmxMqj7HA1CZtu2S322470YBmzykXo8Fqn1aHuWGIbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762062; c=relaxed/simple;
	bh=aMo58fLYHm1Owhl7L8TA3D8F03OG9iJHkJYGwheJ6To=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cg62cK1OaUSc8uafGwL8RtWWzJpQ72Vlw20j+sY9V78EohXewTG3jfgOVeDtf9uosnSjvQrPwB4hDIrsEhfixndXLBXc8xYIr0C2kwZRRafpD1oQ9i3i19fptsY7gPdgzqY+qdo2Zm3coF+aTX2xL1n+OuShp3Jaf1MSnB4QGjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oLOsbCF2; arc=fail smtp.client-ip=40.107.241.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD0/KlhaHaS0cSZVt0t+QaUiMvpDcBHpxV/uMW+fUcVcDbzIn2Gvswv3OT3r6GkprGNWDeaikMVUbKK8UnD5HP8rshENZqUTtth6F59aLueaOLd6GVkjV9GK9TxGZCZzkAl8pll/oASz4FRUUBLQ9OqE0wirQ/1iKpROoyLLX9+PgE+3nihPDf0FEi7S1tI6S07/xccIftGJmEIYd6vqe/wS1mACfQ1KGjuiKx2wls8sWEBOpl+7cwuy0qDjjjw1Al1uKSqJGNu0ocx7ABEV/+A5r7x2Xmo4CqglPSdecnOMuoWPLU6vCJRJ+jLuG5aVXWyxgS4sb/UISwH0scFgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Js2JVHoJNz5Fx27p3xSLUq/uxlACJCCRU2jQ0UOAII=;
 b=t5f2Y2zsQdoCJXpWDRbkjBVQrrc5CFIPOouDe8QvtjUJPrr2zPJLhOqdNIT50X+kzjRjGPnAEk5nwFAIVlMzuG8LNcR7sj9dovlV2m8P9QIxt4pBPwaxIwuiz83Met1kR5bZxDemM2MeScFicyWgmT7M1wY+w7y4Bl8U9+Rf6tYTDoJ5EVTV+KjBuWRzgBkH3z4v57yxoWvOc+dFuRwa72VUV6CvSUYpSsgA/jRLOJj+JoFEAHgSTZLujXhwd+7mstiJi4YiaInfclZVKF1lc+mblAtXzNQ8FmVPeXqjFtEBrrVrAjDtaO9oIfu0Rsdo94QAWIxfKOUnG5PSGUji1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Js2JVHoJNz5Fx27p3xSLUq/uxlACJCCRU2jQ0UOAII=;
 b=oLOsbCF2uG1EFaliWeTEmVrHo4019OQMNlC1eOhRhy+WBNJn+SxUQKQ6+Eh4G3Y3xRcM2yID9IL7hmVOJetCJ+PfLRYDzgRZ0cViMUXmpnA6e95PMHeAgv1O0h5IzbfpFrcgJSy5cJ/nYQhI9MdLBJ7jkYfKZdK8//OLvpGHFIJRIdsZ9ujaa2ulwbdCY726LtN73Ctx1ldsl0KJZHmMlMVmBt9bVwQ9+wWpyXuhqqfe28+PmQ9/xZtAnWNYxPFxwKmCY+rIShfE6QHZfnzd8LaqsXXFRePkvieg+1UZm5WeG/vWaNCrCjftIdSmLX+0OZhHo0exAHtPy2bKGKgOkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 03:14:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 03:14:16 +0000
Message-ID: <f8de9c49-aee2-4ce4-b3cf-ee448f9fc293@nxp.com>
Date: Mon, 17 Feb 2025 11:15:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan+linaro@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250214102130.3000-1-johan+linaro@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250214102130.3000-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9214a644-3908-4a89-9572-08dd4f01294c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b21DeVBEYmo2aWExczB0THRtaXA4a0VGQVVhYzdmOHlyaUxUN0VoRldCc1VR?=
 =?utf-8?B?TlBXajZXNCtvL2lWZXQ1Q3hQNE5DWU4xcUNjME44VFZZdmVycDJqRFBFR0ND?=
 =?utf-8?B?OWdMSVRBTkxubmtsL3dmNmRoY3J2ME0wMFBUUHlSQllUUGZIR1g3MDl1MnlZ?=
 =?utf-8?B?OWhNRW1DYWJQeWdqZ2hham1FL2dkR016V0pjaE9NWjAwQlFvalVtRkpFekNO?=
 =?utf-8?B?WHdUeDVvWjNiVkIrS0x3a3ZTTHlnTUFFNXEzUnB5YXJDSlJadEQ2VndNTFE2?=
 =?utf-8?B?VURMWksrTStFRFpCT2lGZHRvYlF6VW10VXg0d0d1WHAxU0xOSTVTVzFXeTZB?=
 =?utf-8?B?OGZhRi9EdWdtTUt6cm8xK0VTaHJsZnhxRmhURzhGcUJKNzg1TklRT3NoQkIv?=
 =?utf-8?B?MVdKSU9BY0l6VkJBVTVEbUJ4T3oraHM1SkViNFltSTRJU3lIbXRWQzhtNWtN?=
 =?utf-8?B?ZU5EanBjNUhYNW1STjE2SXNOQXE0NGRSZmlDWEdURGZMT2xKUDMxb2YvWklP?=
 =?utf-8?B?cWd1L0JSK1VXZTdXS0IwMDZkZmRHbjFvSkdEQzNRNWxMNUpqQVBrcmMvVTRw?=
 =?utf-8?B?OHplZEtxTHlUK21DUjZnS3RwZXo3WEtNd1YybWsvSnZnbGdNMGxFaFUrV0lE?=
 =?utf-8?B?V25TSUxMRVhNekxQWTFrYzU3alBETzNmeVo0VTRMUDNmV0pWWkRkY3RBZkNS?=
 =?utf-8?B?NnJ3SWk3NFpCSzFSbitTYWIyMDRHVFR1Q2ZPY2NXdDJzRWNjd1JJS0M4NGhS?=
 =?utf-8?B?WVArdGNnYUlzaFN1SEhSaHpzYTk4RmZWWjhJUVl6SWpEWmpsODUyWVYxaFBF?=
 =?utf-8?B?dVZ2TlBPb2xXOGNPcTE5eEhhTnlyL0ZiWjNneXFGRGxNa0s1TmlLUUlndExU?=
 =?utf-8?B?cFZzRmJEUmdFM2pVWit5N25FM3ZOQ2xGQVhDckVmTnc2Z1B0VDgzWE1mOUl0?=
 =?utf-8?B?WWo4Q3l6WE9relN3dEFoSkZmeDc2cVp3SXoyZHdNelhMSitLdUhWbmpjN1R2?=
 =?utf-8?B?WlNQS1A4cWR4WXR1aHArM05tVUwwNFUvRlFpdVJaRkJwRUpEam1vZG9rRm5M?=
 =?utf-8?B?ZGc3U2hha003MkFCMVJna1FMUWtCeUZvcCtQQ2YwczcrY01OZVdDK2RGU3NY?=
 =?utf-8?B?S3lUUVZlUzNLcE54WE9CcWtMN01YMzBPWjhSWWtjcTJPK3ZOVk9lUFRYSHVw?=
 =?utf-8?B?UjhWTDFzOTBwQmRXbzltd2xQTzF4UmtqaFNaalBoN1FYYnljSUl2Nks2Nll1?=
 =?utf-8?B?SUlwamZWUXBkN3dPcFZFem15UkhqN0gvYjlPcFFXNWNkOGpiOHI5QlFrRlkw?=
 =?utf-8?B?UHA5U3pjMFV4Wm9ON0xyak82Y3FBTW5EdkxqZnRIZm41M1YyQkZpeUtUKzhX?=
 =?utf-8?B?NlFWS0hNV3BCU25PT3pZbkdsdUJBUVRtUFpwazRrc1pkWXNZd2VINWFYM1Rh?=
 =?utf-8?B?cmdkcUhLRm5ZMXJBNWp4UzdseHJLRUgyVWJNWG1CRW5rWTlqUkpYY0dZZEFT?=
 =?utf-8?B?UHVhRlNyY05YRVVHZnBObUV1UmVqNW1pYk5IUllHZnZZTGh5aGllNWNmTVVy?=
 =?utf-8?B?bm1Ec2xGMVFva3BOc2xoL3FSam5UWUl5VjhhdHdKSWtlSDk0WldOS2lUR3pv?=
 =?utf-8?B?T1crS3g1OFA5d3BYUWllUnBLRWZ5cmk1cXRERkVvQVZBZitrTjhtQXJTWGEv?=
 =?utf-8?B?QUlKY2xsOFA2ajJ6YnlCTU81cjRiRDlNK3lEd3hVU3dTS0RBdWkxKzdTcGFX?=
 =?utf-8?B?bW4wcUNIU1NoZ0dTS3gyZlp6dXFRUUpkQ3ZhQzE0OW51Q1gzMmxMVHBsRXhU?=
 =?utf-8?B?a0hTY2tIcW5UTWJUYkNZTVRCYytTR1hDSmM4bHoxMUVudGhPYTVkQm5ta2Ru?=
 =?utf-8?Q?Ut/j2nmiBUe/r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V252aVdTdjd4NE5MYVBzNDVXYUF0Q1p5aldrY1drd3VNRlNnd3pJNlM3Y0Zu?=
 =?utf-8?B?U0hqQmpTUC9Yd1ZzY3dMdmthSi9FWFJ5NXNzMWpWSkhYTldzTFJvZCtuenRw?=
 =?utf-8?B?aEJYTGIvODZ1RFdHclNNb2NJUFlSWVVzZnhFa2pCK25nanY5bTRqR0hic3ZF?=
 =?utf-8?B?bmtldlZrc0NCakVPc05mZ2h3M1VYaVpZUGZKYkZESWpmYWt6djR6UXlFWnp3?=
 =?utf-8?B?MHhrUlN2a21nNXo5S2M4bVpyRUFjaUlWdEZRbGtiZ1FMcitHU1dkdFBCZU5y?=
 =?utf-8?B?cDR2N0J2UzBzOWJzNHAxL0NvRFhUeXlVclVIUzlHN3NUaVI5NU5KaUJuUVo5?=
 =?utf-8?B?N3lqZEx1ejJ1dXJWaHpzSlVlQy9pNEdZdFNpYWJmeTNIRTZySktoRHc0dTdy?=
 =?utf-8?B?SFhxTkJnMllmQ3dnSEcvSUQ1WXlpbGYvSUZMcFRDZ2swajJpdkcvejFoOUhQ?=
 =?utf-8?B?SzZlZnRTSmw0UVdUZ1FVT3N2UjZlbHpNbVBCdFNUTng2dWc3TXV1U3pMSEcz?=
 =?utf-8?B?L2Z2MWRGbW9IUXN6cGxlcGI2UVYwL2p4dmxGaElCY2RWYWtEdkdtRzN5cXZ2?=
 =?utf-8?B?cHBTS0ttVDRvd3YwZG9iMjR2Z0lTeWRZdEJMZ2hKeXhkcWRWSXN5MVBsbzFp?=
 =?utf-8?B?UExpSmFIL1pNQkZLWEhyVkFweVpTUUgzeVlNT21Pb2NocWxRa3RJbEk3K2N2?=
 =?utf-8?B?MkQ2TlJZMjFVOXFnM0VtOEdjWGFRN0hucm90RTJLMllyczRyWnArL0ROMk9L?=
 =?utf-8?B?UExVUzVpUFZHenlQWEJjU2duQ1BnSXRBb3JPakIrd0xReFJRbk53WG9JT2Nk?=
 =?utf-8?B?a2o0YjBwTWlnbEc3TVNES3habWVaTFp1emU1YXJsTTNzWG5QdVU0RmFVK2Zp?=
 =?utf-8?B?Y2hZdkhBTTE5WExSTXpGTTNNeDUyOFhOUUw1MnQxRVdmanJSNXQrYTFOS3M3?=
 =?utf-8?B?aG14M001S2RaWG5TNmN3M2Q2cGJmS0swTGU0WTRMNjRycjhrVHhid0hOOXo4?=
 =?utf-8?B?eklxaDE0Z1ZvRzFRTVRMRDYrcmxKWFRNUmdaMVhGUDRpbUh2TjJGcmJoQjcv?=
 =?utf-8?B?VGNoMUt6bGRuQkpuczhqMHh1V2lidzNnS055anM1TjhNdHk3UFp0dGxEbWlv?=
 =?utf-8?B?K3pyQVZxMVZqY2ExalJHd05NYTduV05qUTVIV0JDMm1QdjNvREl5Q1V3L0NE?=
 =?utf-8?B?c214TmM3dFc4N3RoU2VGM2Q3dUk1OXRpSVo3ZDBSN2tYci8vN0JRUWtSTGFq?=
 =?utf-8?B?cUJGZnp6NjVuOHdTNmZTbnJaNlVlT2VQNGc2ODJ6azNZMHFUbVk1NkVpZ1RC?=
 =?utf-8?B?NTduQzdCN1RWY1VXTnhsdmZkN1FET1BHNHluSDhGUVBneGpReDI3c3JaRkhR?=
 =?utf-8?B?UVZoazlOSHdla3hmTW9hMytGcFk4UTJOaU5CUFF3WWlpSnUxNW1ES2h1bzBi?=
 =?utf-8?B?WERpSUFuT3hvVE4zNUlHbEkrYnVPSEYxT0NUQ2lpTFFWaWoxUHFoVldJZXRj?=
 =?utf-8?B?RUkrS3E0cENsdWdEZG5mM2ZOTFFVNWFEQ2MraVNpSFMzQUs3WW84K09hbzdT?=
 =?utf-8?B?TjVLNzVZSHprdGdSUEVQR1FIcGlvUks2U3l3OGNhRzhpaUg2VmNRSFdNMEJr?=
 =?utf-8?B?cm9CVlB4U1A5cGJCUDd3L01LY0lqeGJDKzFJam01ZVlTMVlyR3FSRmZZU1g2?=
 =?utf-8?B?RWNhSUxoV25KbkRwZWdCakVjY2dBMWV4bXZkVTVnLzBSZ2V5U3Jwalc5RElH?=
 =?utf-8?B?TzJYQ0pBYmVqVmFlcmMzUXYyeFRmaUp3bk80REVQYkxSamJpaUJ3VmFibFhF?=
 =?utf-8?B?L0h6eFh6ZncreE5JNjF1M0VGZUJBTEdpKzZMam9QWFZDS3A4dHdaYWRNVVJD?=
 =?utf-8?B?SGxWRmxoZnFXMzY1K3J6bFJob3JYbGpMM0lEc3pYTkkxNDNsL0hNRTd3MnVW?=
 =?utf-8?B?NHdIaWFBVERXYnlSd3dYaHNBaGdGWnlsbXNFM241WTdIRGg1bCtQWjVXTitP?=
 =?utf-8?B?bk55Ym1YWTNrQlNuZHcyb3hkSDQ3b0NMS0NqQ1h5MFlyMVI0SGl6UGpPRlJV?=
 =?utf-8?B?ZHFQYkxCOHR4UG5nUlpxc0lpemZqU0QxdlBUOEhHbUFFL3p4S0l5eFNZTmgx?=
 =?utf-8?Q?w6nSVQ6U/miEgGeei9Y4FmXim?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9214a644-3908-4a89-9572-08dd4f01294c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 03:14:16.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVgNk/1gy8e/yWpHUMRUxrwKM9BUusIkiamFYPu3zMB0ltFyFwcAozBndCqD6dW8lyL8fCVGZHQ/dpMuevmB7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043

On 02/14/2025, Johan Hovold wrote:
> The simple-pm-bus driver only enables runtime PM for some buses
> ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> pm_runtime_force_resume() during system suspend unconditionally.
> 
> This currently works, but that is not obvious and depends on
> implementation details which may change at some point.

Fair enough. It's not a good practice to depend on the PM core behaviour.

Acked-by: Liu Ying <victor.liu@nxp.com>

> 
> Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> future surprises.
> 
> Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")
> Cc: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bus/simple-pm-bus.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 5dea31769f9a..d8e029e7e53f 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int simple_pm_bus_suspend(struct device *dev)
> +{
> +	struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +	if (!bus)
> +		return 0;
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +static int simple_pm_bus_resume(struct device *dev)
> +{
> +	struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +	if (!bus)
> +		return 0;
> +
> +	return pm_runtime_force_resume(dev);
> +}
> +
>  static const struct dev_pm_ops simple_pm_bus_pm_ops = {
>  	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
> -	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_resume)
>  };
>  
>  #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */

-- 
Regards,
Liu Ying

