Return-Path: <linux-pm+bounces-43737-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIQ9C4lBqmlQOAEAu9opvQ
	(envelope-from <linux-pm+bounces-43737-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:52:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74921AC6C
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 161D8300D57D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AE367F2B;
	Fri,  6 Mar 2026 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wwyZ2As5"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3B1643B;
	Fri,  6 Mar 2026 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765571; cv=fail; b=g0Znd+gDGnLUphO4cdJzEKN3l81hGf5joXFAxlLaZejC2KxFw3UDtONuWBTtAmu0jwZ/GMHfUzl4UsfXKkLXUo3s2afhJ188+k0YqL5UE9qWItpsB+nuYfz/ubUVITZsAUsFcSTxjdRjPXE1fRNqRFzryIRWJtIwrdGltMtsH4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765571; c=relaxed/simple;
	bh=mcu6S5Q5lbMlSd8OdXY/awSy6N8qvvSbEiBsc5ljX1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsx3mTjhW2z8BP16FX30P5WtId0pRmKYOVLZmaAe/a5pOeHquzpwH3CVjp92QxYaMc9ttaHIHcmq7Lri4zs0CggEz3LevHNvNW/clwKcr6HrfCz289UU0ISV8evoN4NrwmkhwyLes2jPLFKOYzgLq5JQ0Q3RooF9Kodef3JLW8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wwyZ2As5; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuiyIOrXUhqwMAu8Iw6/B6/KeZqi7CSt1mvLUEwAcBZFVsfT6JMqNrNNSDqb/wj9hjYFtV56Jrt5eGFwGB76Vdn0N3mUI3S05vIwJR7p2aTXat2Bz2UZFSdacWB9ClTcUkGfHBbUaRjPtDA57u7MgJPzD8Ch8wxg/JoQrtG9BoKIThyE7gkrIdYpV7S5dHzhUhYHTMwcXJjEChmVJ7QyfjE13AlFIn7qd+yxyrW6VGi+LGAnJdyOn1OkfBEpUBrhmskAfM7c69+2+oxGHmMIZ+jGNRyJnkdT8GixpmwiPXe/CQ+IxwtWc498NKTSH5aabgTObj7ohuEz1GurbqeoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnuQL4Bt41sQZh+O3TYYEI4uzbfWPzeMvfFbMsHra9Q=;
 b=k2XYr31vZd4PhIcZrPn6l1wqfxleWaSimrATBBBAK7kahR37CuzQvbDUPTv9nzskChE83ge3Vs6BfH74+sHFoVWQOcDiJdhcTdAXgvoMQ8STLtpe6zR3gIIZdxWb7tw0vwR8FWUWpNdiEvhNV9OdovVKnwB0WaC31JMqm1NP0P35rAmdMnKPTC6r16ciye2WLnbVRDoxFRv2lturheK2o7V1GCRw+Yv11DZ7H/Z+/bMcKjGybaAzhbdQWifF/XP28JzQqD93ewkOfNgFrJdd9tyopwK6sNJRdwb+BhAm6gozEZ/Z+TJ5cOVTv2L+twN5EOV01MQH4sm9Bp//kmLq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnuQL4Bt41sQZh+O3TYYEI4uzbfWPzeMvfFbMsHra9Q=;
 b=wwyZ2As5PYTYh3Vznj/7Pg7MfylH3UU3bKpobcCWW3jq/egdYxrNjqCSyV07/ZNFbyV/lwol0mXYikPtD0i1nr3tcewuE6FnbwCuscN5Sn+N2/S4ol+zGyxBXCkZlGB9Dzp0+8Do4zfQw7/Gnkozna+6OxDw/jWEbmjUOPe+2ICl3/HByDGVrHAxohw7fJvM7KaYFvn5HKuxOvgaU0XTvyM7kiTuUMp2T3KdObk67hduUSQ8mQo67TQHmowfRrS2D2bE0wi5PYfDUuWruCagw8gwnvPAspg6WSOBkHQ/9QgiRq6Dbe2+gc1I7rO3DZAjt07YLkzpTX8gawjxfMShSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8137.eurprd04.prod.outlook.com (2603:10a6:10:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 02:52:46 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 02:52:46 +0000
Message-ID: <fa15db89-9bc9-4ce1-89bc-6c56e29725c3@oss.nxp.com>
Date: Fri, 6 Mar 2026 10:52:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: verisilicon: Fix kernel panic due to
 __initconst misuse
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, m.felsch@pengutronix.de, fra.schnyder@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com,
 peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260306022406.760-1-ming.qian@oss.nxp.com>
 <CAOMZO5BP2aLD+a1r7hVd3F4Qvfovxb8PgQfzcVRKknBHWYBmtg@mail.gmail.com>
 <61e260e0-4544-4c51-99bf-c4815367fa94@oss.nxp.com>
 <CAOMZO5AYRWBykSdvogO0Ea6JidjgY_h5drnBpcDNFrU_oo_L2Q@mail.gmail.com>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <CAOMZO5AYRWBykSdvogO0Ea6JidjgY_h5drnBpcDNFrU_oo_L2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 395ada87-ce98-4505-e731-08de7b2b71ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	5g0Or5CSCpxVSP0jZU/6ejclR3M+kI9fh7iDbSimwAqm/+khCfR8tGybtMK683j/x4tKAvdEvlC1PCL4tCWYFiTd4n9jQ89k5HLhwWSu815coW+s5nitb/NWvfyiuwCDJvWbQ8f8KHtFW+czQDENqp7mXbU/vtYyIcaPZPGFqmmZ9bYgPBMMswBL3UMLIttUslipciUdhvbdzayHVYHq2VKUMLcMPRUv60bgHf5SHVQ0+umgNc2DXwtbqwUNX+BY4zmNfPxtPlH1pCFxJ2cQEKbHPZI/lSyNBBdhZGHmIl27rSYgIT/SGgRwTt3u4xRk18GT+zCepuoF3Zxy//TY/QFvDd67V4itc0wURfS0Zvv7/rk1m3mu/P+jSRrdSZA3JieL03gA+1oJEYZ830d8CoY/gtQccx5ndkALYWxnQzEBOL1N21hs7lQ6f8mx6tw6hIXwNfFze7J/EPHBzJCSWZBICWpb/aMZ/6mhtCUhFKBJydiA+AtHCHbrEOA7OdxC853ngTCCJXqkiDZ3owl/Lli1XD0fWbeCpgFJwSwkhxlD8XKjelNVSFofChWzPrOn2SA/vKpbsC4IBnZ4DDwOHVhtBsRNJv5ALFk+pUkycJPFXjbnDkwavN5wUO9iUuj+yBt/DMXAZTGoo2TvMY8Qi6h47bI6khf6Z1MhAqS9e4wg0sq3ZgXcXjVK+Ipg4qCpxHgAjZMdf/QA0/9dpl089VCFe5a+XIYjRm7oPEmL9Ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVnVVVDa1VhQ1NLY1JsaWc1VkhpUnZGeHdhbzRpZGRMcEhMd1A1NEI4eTFx?=
 =?utf-8?B?d2pqcWRQSndVbmdkWnVWUVFPUHpxWHdkR1RyVkQrWndvLytlWTR4UTRMTWhX?=
 =?utf-8?B?MUg4MWFnZ2FuUUp2enRYN2kzQmFxRTR1L3luS1FCMGFkTUJKQ1MrK2hqQXhJ?=
 =?utf-8?B?a1BNU05XZFQ0a0huVEhxeFM1ODkzSHBKSWNkUldQK1pHa2RZM3hrN0hiSkN1?=
 =?utf-8?B?Vm5FQVpNUGRYSTFvcTVzTXVhd0g4cXhxOFhqK2NYaWYxOTVOZFBXaWZmQTFq?=
 =?utf-8?B?c1pLdFViOG1WS2o5cjdHNmZYY0FIcjd0L09MR3NUdzRDbGw3bUNiNmpZLzgw?=
 =?utf-8?B?V0pDZFJzN0kzQllSb0c3b21iVFZpaDNab0ZpdVF6MG5KT2xMZ2QzeW5Wc2Rl?=
 =?utf-8?B?RDJBSlIvVWQyMGZnVmZCQldqSUVyazE0eW9iaVVUSkhYY1FuMWxQZTB6R2wy?=
 =?utf-8?B?Rlg1L3NEb0Zoc3RGcko5amxCQTlydTBQMlEzOEYya0kxVmxqajZ2bW5BNS9Q?=
 =?utf-8?B?Z2M2bitVOXhZUURzQnJVNU9uckt4NXhjZzlhek5qNkZabFJMY2x6UHhsazFS?=
 =?utf-8?B?emNaV3NnbHNNV2VnZmNESVcyazVKMDZmYXBGTjZGaE5HZ0pTLzk1RXJoMmdL?=
 =?utf-8?B?ZjZqYmxjdWovakFaWWRFUEVldks4L0hNMzJ2UHlzYzFLZXN5Y0pGN3g5eWln?=
 =?utf-8?B?WEJGaWdLejR5NXpwQWRnbEZPS3RkbHYvRVAxQno0eHFwSjhxOWFGMkFYbHlL?=
 =?utf-8?B?T3RPeDV3RFl1S3FDUFFKUFJCOWFGSmRmQXZBRGhTT3lnbHRpUEhsOFRVcVlu?=
 =?utf-8?B?NVNOSEVyM1U2UzZSaXJoNGdNRGFwQTV6OE5IUVJib2w5c0t2MFBWcytyVjlC?=
 =?utf-8?B?VThIeXNpWXM3Z1RhVmhmTUdvaFZVWnQyWEZZWWdaMkwxQlVVQnBZM2hUVC93?=
 =?utf-8?B?UFAyMDJRdDQwbzJGa08zN1dXRXFaUU9aZmdaNzREUk56RTZyaWplWi91WmVX?=
 =?utf-8?B?eVlZdWdWN0xWdDl5WVhiWDVXOVpVc1dwdWZRcTVDUXFlVUJEZ2NJZlEwZXh5?=
 =?utf-8?B?K0ErUXZqcE9sRWhqNFloL05aWk5kZCtTbU5LN2pUelhBZjJYK1RVUk9kMXRo?=
 =?utf-8?B?RFlCanVhQStsNkFlRmpIRlNEeVgrNGpsRG5TeU5KYkI5ZnlYWVZCcGFYczRo?=
 =?utf-8?B?TE1TanVHZmtQR2MwMjdBaWdObEhqYWVza3JQRkRJOWxFSElwc1l5QlBaeWdJ?=
 =?utf-8?B?cUNxTWRFLzdaVmMrK1o0bzlWK2J5RDNURVVSYW5QTXd5OTd5RXY1Tzc1MmN6?=
 =?utf-8?B?SU5ZU2JLTDIzallCU1FtVnNUUHJlU0orWkhoS1BOandlaG83eWxGT21lVUgy?=
 =?utf-8?B?VTlpYnBzNVNaS0Zzejcya1BSdkUyU280Z3dueDRGV2hLQ3lRM1RnQmdNWlNl?=
 =?utf-8?B?dFBiUDNXWVA4Sk9DK2xkZHJEd2E4L25pU1NiZE1jcFE3b204eVdRS3ptY3ZH?=
 =?utf-8?B?cHBMTmh3cW5TWnV2N05NSjhFZWR2SXBCdTVneUF5UW5mUkJMUGNxekVCWDhD?=
 =?utf-8?B?alhtbEYrZzYzKys1OVhENWtpNHBqTFFxNE1yVUljMWhFVzZZQ1cwb0hPQ25p?=
 =?utf-8?B?eEo0V0piYXh5c0VuWC9PLyt0Z1NGb0I1ZmtvOXEyTEtCK2ZyNFRPQ2dYbE9r?=
 =?utf-8?B?ODRMZmRGQWJqaktmazBGVjcvL2QwbEkvenRmOEJWVEFVNkJCTDE4MnNtL21q?=
 =?utf-8?B?OWN1STB1bFdLWVp0QUxSU3N4dmFuMmxtRHFaQkpaNzRLM2xRY3d2RXdzT1o3?=
 =?utf-8?B?V2lhWGpRUkRIN0ZRbTNWeFpuKzA0c2lFVEhtWVZPUVRwZWJSQkF1eDltclRr?=
 =?utf-8?B?UEp2OHpGeEE1aVpacnFlTW1wajlZcGZ3bHdLR1loNXg3ZnVlUzB6TTRkMThY?=
 =?utf-8?B?TzA3TERQek5XMDZoQXk2Z1dzQUIwd0l5eVBRMFJQR3JNT0tzcVBBditaWXF2?=
 =?utf-8?B?VmZlNjFWNW12Ukh5aHFqN1FuQkg2Nk92enJqT2hRcm9CckRoMFNlMWducWww?=
 =?utf-8?B?Tmp2eFdqSndNWlc0d2tJR1VXOTVMeTVBOXhDVVowUSthOTVUZWYwSVFpNDhz?=
 =?utf-8?B?OHVOenZzYzR1eWdCdlpyRXE0T3dwRS9kYVhiSXAxUmpVRVcwbFRnWUhrMjRC?=
 =?utf-8?B?TEtwNWRRbE4vYm1PMFk1ZnNIOE1MR1BRb1lRamV1QnRXanVqQzI4dWIzWi9G?=
 =?utf-8?B?WDNZMnh1ZFFWM3Z3dTU2WkZSMzBMNFJVWFJFWTBpVW0ySVE1MXV0Tm13dkRF?=
 =?utf-8?B?dmFPcysxNXhqekZjRkpsV3ozTTgrZXNpOTdZSUlFSXpjNWcxd0ljZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ada87-ce98-4505-e731-08de7b2b71ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 02:52:46.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1xs9ZHeWQkfCO1TOVFLL/ixwuGbvb5Kpn1UHGu5vgUCvntKiWhfLvQTkL36WdP4aprcERRLRyhPT9X2sTvi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8137
X-Rspamd-Queue-Id: 2B74921AC6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43737-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Action: no action

Hi Fabio,

On 3/6/2026 10:50 AM, Fabio Estevam wrote:
> On Thu, Mar 5, 2026 at 11:47 PM Ming Qian(OSS) <ming.qian@oss.nxp.com> wrote:
> 
>>> Drop this change. It is unrelated.
>>
>> But without this, the checkpatch.pl will report error:
> 
> Please do this in a separate patch.
> 
> The goal of this one is to fix the kernel panic. Don't mix other
> changes with it.

OK, will do in v4


