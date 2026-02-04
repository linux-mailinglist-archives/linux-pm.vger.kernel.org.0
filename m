Return-Path: <linux-pm+bounces-42028-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNr9AkirgmkMXwMAu9opvQ
	(envelope-from <linux-pm+bounces-42028-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:13:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C59E0B9E
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56B6130C4216
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 02:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F495295D90;
	Wed,  4 Feb 2026 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZZAZhg4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CB23EA86;
	Wed,  4 Feb 2026 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171204; cv=fail; b=QD/ZlBjKRKonegfOD+j/GV5mb0oUIDKFT4p+qyeuMhi+hN2tG7VRzflEi1OTxstibcs8rXPFUwQ8J7W7sJUzKpUAWtP/mh3LDtGnmU2I8JSm6sDfYQqfsw0Vvd3FUYPhlrTYCLc1HQ+X1mPAR1F4FkVnjEUjbkI6Bz2QjbltH4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171204; c=relaxed/simple;
	bh=y9Z3NL/ddPRooA2cTs391cpH3W3em7+fnHC5hvHVoFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lje15LgaVx0Fq5AqKY7fdlbVBc0Vl0PILmaKsMVW8qqOAg8WxwCGlM1ECabCn2QWY44EkVeEbg8pI5AoJnPsqNd43lc7ubV2vrX7GF76tWZgd+YUptQtth5eJL3MEDa9zel5oAon4rDfaPZ61WqIwJaWARbCUbq/aKW9dXiLZbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZZAZhg4H; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTL+2X7fIPe6E3ZMynZk7OWmHuEECZE1+JZurjcZkNDOCNP8xDe8JQzaVZpzMxTTIzKrXjoibRotGaesnSXI6hEOR+sM3CsbwUxLbZzSkTR2Q5b/tdEa+OSO07A09DjSj8dX1tTCoE5GklPdmxBJ8HYnob0N2rckHP1e6B4uahH2JApR5tmLhvKT7ettQE5aUGgvyUc1ssam6hgzo2eUGECpzPeNpsP9xauIRx92H6Jb8sSRPFBtwpgikJVwjGuaUGXf+pZ1ZyBrlSTaxwovyk/xt2K8FXhR9wkBXw7AbtFe5kNcGBKYnp7O5gZ6xIhwbAE8gilwrO1flkyH8fip6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke+i0dbehpY4i2aJOJj10LXom+LcE4OeXSswKJtLlW4=;
 b=yAFQdr++D6pHoVifD3UTMFVr6UprWd+b1h5bGjVx3rTFBTQLRJmMecSQCP/oIdRd+GiOTBkBKGe+DOGhFYDxZ3ATINdzkd2Yz9ylq+iJHT6E/hOsRO8fDTcmKsBxwb5W3xAqCwDc+G1FlcRRMK4In2HjOkhABrsGniHS2uWjvyTnkXu7cltGbXqypf532LBSzBJhUJ2NeW5fbVUhZrnnruNNQoMZE1nol1oUY309416qUm6lzl0gHHgbN+ajv06+AJPXcQS8DlN1komSDsyYgU62EF8vImJk0N4UkRWor+4cf9717eqBKT0Rfz5n3volu1zje1lUmVcvk8vogmi65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke+i0dbehpY4i2aJOJj10LXom+LcE4OeXSswKJtLlW4=;
 b=ZZAZhg4HgEbi5+U/K6zgLqJ4N/vmz08j1yZ/R6kthqo1rG9SEewTms9gFkSHzIrzgi0Ij+6G1smap29R8M7WgjhrBNGy35wsBntbpcZHkZBt2Fwgh7IiUEponpl62DYaet6mwcLuayriz3DJ8EK2bLUG0RDG5HxxVMUJptvuNvuQq3OZLv8ufoPREG5c5Qf+n/0dsbLXC5oSt9RvOARK8pfMG03MjsUaDtjvWtl8ErLke3xHpEms/Wir640mZK99bAvInk18YR2V9a5qHJVpiWP1s0XcNIAhVe//hWP0TcE8+AxS6RUdlFBWv5SHDRR0UaU40mSFGh6VG18xuVP3vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 02:13:19 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 02:13:19 +0000
Message-ID: <39e9729c-c4c2-48cd-9795-79ecb31b8560@oss.nxp.com>
Date: Wed, 4 Feb 2026 10:13:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-media@vger.kernel.org, imx@lists.linux.dev, ulf.hansson@linaro.org,
 Frank.li@nxp.com, peng.fan@nxp.com, festevam@gmail.com, robh@kernel.org,
 benjamin.gaignard@collabora.com, sebastian.fricke@collabora.com,
 linux-imx@nxp.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 eagle.zhou@nxp.com, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, krzk+dt@kernel.org, shawnguo@kernel.org,
 l.stach@pengutronix.de
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
 <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
 <20260203083110.woan3gmc3qdh7nmm@pengutronix.de>
 <cd07dc6e-1f19-4a59-8ee5-81a36d51bf1c@oss.nxp.com>
 <db9016a39f612cc93ee070c1eba4e4471a89a5cd.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <db9016a39f612cc93ee070c1eba4e4471a89a5cd.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM7PR04MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a75d5d-eb65-45e6-e75c-08de6392f675
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czNXSm9PNnhtdnVYZ3pYRVNGbm5oOGNLSUdvTUlnaDBEL0RtdDBVVVM0Z3Ri?=
 =?utf-8?B?dXVGVEswUVEvU05UK2FCK0hnSFNBWlFxdDl2YTRZcXdmUDJIZ2VuNHppNjNw?=
 =?utf-8?B?bTlwYXllKzd5SCs4WFBYQVlhWFVNMDZEOFRoU0R0UXBrSkpoUXhzRUtiVHpt?=
 =?utf-8?B?SHNNUDJFVndsUFowN0VtR2xqSTIyNGVkN1A4SG93MzB5NFBicnZMbDlmS3pO?=
 =?utf-8?B?V0JmbDFTNExDM2pEL1FJWG9QZkU1WlJhd0NaeS84cjFsdVcrN05WcFB6cVVu?=
 =?utf-8?B?czNVM1UzUnZNYk5sWk14a1YyMXI2QzFGRVhvbEVhQWRjTDJnNVpCL3dQOWZD?=
 =?utf-8?B?b0JiMWg2djA3ckhEVy9sSXRaNi91TEZjRThaT1hxQ0hYSU5OdTlMRFpBOEtO?=
 =?utf-8?B?cnJXOUNBbFErTWtHVURWdVpNTjlaZ0hjMEtkK0ZqN2J0MXpSKzRWN2RsNTdj?=
 =?utf-8?B?Q0ZXUkt0TWwveUFVWEpacTFmNzcvaDY3UDczYVVUVThWV0JSMlJDNm9iczdN?=
 =?utf-8?B?d1NuSGd6NUQvYjJWQXJ3MytDYmlQR2ppRm1FK0VmU2NHM0NQZkJFcGp6Nmpj?=
 =?utf-8?B?bk83akxwbTJ6OHhtQmVJaGVwdVNjYnpLUVBhcXU4S296ZUF6b1M0WVlDZzBr?=
 =?utf-8?B?L3pkdXdDNVorWm5OTWdYelBERzhFUUhDWk1OVkVadlg4ZkUxWGVVU2Qwc0Zw?=
 =?utf-8?B?L25JMWJYd25CaUQ0UERSWjI0OEZsY256Qy83NzRsWkdnOTUyZTllOXNzcnlv?=
 =?utf-8?B?aG8yL2Z1SkljRUhyMGhqVG1JMUhpRy8vMGZEK3hFdjFNS015YjZ4M0l1M1hs?=
 =?utf-8?B?NzVlazdVbGpHdWo5QUtDdE56dnY1WmNzeFJ4MXFFdDYyUkxPZFNHR1hMcCs2?=
 =?utf-8?B?K0NwL09GL1FsUHJmUWprazVvUy9RY01iYnY1bkI0RnVYbGZDOEZ2Q1Z6Wm9t?=
 =?utf-8?B?TkVLN1RuZklGdmV1dzlxbUk5enZnQ2hUYTdpUXN0dDNLbWU2bUxSc2lHWDRh?=
 =?utf-8?B?cEp1ODY4WStLWjhmNlZ5cm1UU0R5VzVxTk9tTXhJb3ZiaHhwOEU2YVduVzBN?=
 =?utf-8?B?NkNuZnNnaU5DQ1d5NFpZRUZKZnRLeG1ybm9vbkhZZVJKYzcwVzd6eHBVTmNX?=
 =?utf-8?B?T0RHdVpUMGJOM0lhWUE4RXZ5Z2lNMFplMnVhWTFYVy8vMnVSY3hiZEhZc0Vh?=
 =?utf-8?B?ZFBNcmdrUzdweXZHVXc0TlV3dVNBY2RvVjVkMHlRS1pibGw2VFNHbW5Ncjhm?=
 =?utf-8?B?VjJmYkloekNaLzNIVUJYTGhWZHNnT24xZUE5VjBVTllyMDROTFpHc2FtazdC?=
 =?utf-8?B?c1NQa1ZrMjFpMGNRcVI3VGY5OWxwRzJaQjdoNlhZdVBUMDhrQVgybk8zOXVY?=
 =?utf-8?B?UXB2UTZycnJzNW5QYzBpTDNkSXRWQ0h5ZHNCTy94RUc4QkQyVytmU2x6ZFJv?=
 =?utf-8?B?U1FMMzk5YTlBTEF6bk5vL3B2OVpRa2VWRXdoNnduSlhlZklwN292K1E0R0xU?=
 =?utf-8?B?VzkwbEFLN0VyWWZqWDNwcEJZVDR0L2t6a0VscVRvYmdSR1BIZ2h1cmlCM1Zm?=
 =?utf-8?B?UHV5MFFnTVpPT3hMY0lWYUFPd0IwVzBkZWQvSHJucFNaa05kWnU0MjRsbHJ3?=
 =?utf-8?B?SkhpUXlRSG1VUlVCVCtnaFVEZEZNSk10SDEySXpDejJ6UVlnZWdoUWF4WVlI?=
 =?utf-8?B?SFZTdnlKSnF3UFduaGZmR3B3MUhORWpabkxXVkordWtRQ2V4NmtuSFFrK0tQ?=
 =?utf-8?B?RDJ2dlY5NTVsOUdjTk4rdnpkR3JwVVJkTEhSQWRwSjc3SUd4VS9MTUdNVXg1?=
 =?utf-8?B?NlZrNXNxRmJxNVhXRlhlSjh2dHFmZ1BjZ0JHRDJTeVhXNzFYcU5zZjJmc2RK?=
 =?utf-8?B?VkVnYWU4RlZqNUVod2gwamJIR3dlYmZHY2ZjbVhzZktIZWxlVk96bGhlUFha?=
 =?utf-8?B?SWszY0U1a3U4VXNXSDdGWFhheE0yMG41SWhmdzFZcXE1WGU4ZUdxM0RCeFVr?=
 =?utf-8?B?bitoRW9Pa2xrL2hURm9wQzBOYlU2YW9aMFZuQXBXNkFRZndodE9BUDZKYlBS?=
 =?utf-8?Q?MNgN0B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlSOHRPSnozN2ZQODgwTHRPM0xJdlZCVk0wMmxraDJCc3I5Mjh3cG1DQmhs?=
 =?utf-8?B?U2dLNGQxbDhEczd4MnpuTXZUWTEwZU51Vk5MYUkwcW1qR3Eyc08raG5pQUJz?=
 =?utf-8?B?NHNxK1dlQldITDloUVRnbTgydUhuZitROFBzSkUxRlRURGx3YzloTlMxQ3BI?=
 =?utf-8?B?a1dqRGFrbEFJd25OQlp4dkttNjBVM3V5VVVhNndkay9aY0JreGprSlZsV3hh?=
 =?utf-8?B?S3lDaVFZMWFaano2RjR5MzRmRmpHYmRPR2Q5ZjhmVmJxQ1pzQStDOFZYMmVJ?=
 =?utf-8?B?azR3azB2WEcxL1ZTWnBoN2NkVzdXejFPL0pjc3E5anhNZngxc2h0NXZDbFhT?=
 =?utf-8?B?d0RlbkVhU0JmK0VCemFZWHpCZTg2N09EejROTzk5MUkzcFpMMGsySk11Q3h3?=
 =?utf-8?B?cVVqVGZMbTBtOWdTQ3M4TFFtQ1pLWkhKQnRlbTl6K0I1TGloNk1BYjBGb01t?=
 =?utf-8?B?OXZuZk5CUGxPZS9Sd3RvU3pudE5wRzAwaGFxVldKSlFaczh4QWpJTERySDF5?=
 =?utf-8?B?VDFoOHdONXQyQ2FibUFOb0VoMERXRFdZTERaVXZXM0R0QzVUZURDMGtWRWdE?=
 =?utf-8?B?MzBGaUxzaVp3cDhNMnUrY2tlakd0anhkMGJOQzFUVmZxaXZ6d0Mwc1JxdWVV?=
 =?utf-8?B?STREVHhaZXFEZVVOZlRvTFcrcFRzRXVJQW0rWmc4WFRqQndKQStVMTRXRmdW?=
 =?utf-8?B?MjlTT2pCSzFRSkt0ZkdZTVhEb3NUanhtcC9mQy9NcVJXOE5YMEVJNjZoNlpO?=
 =?utf-8?B?N3Z0WlI4ai9QQlJ5Qk9wZEM3Q1E3L2R1eUtOOHN2SjI3NGF4WVQ1U1h5WFo4?=
 =?utf-8?B?b3VLRW9Db1V0ZW8xbHpWR2huL3NhMUprQURHTmtwR0pndHl4c2NUMS9rQjdM?=
 =?utf-8?B?OUVIK1Mvd0o1MUxCanh6SGNXbkptakdSeXJSVU02bjZEZUQwZCtwbW9lckxh?=
 =?utf-8?B?ZDhoeTN1SXEwZEZUWFM5T2dnOFozUU4xRCt6ZWlnUENtTmFGUW01dEp3R2Zi?=
 =?utf-8?B?VmQyTFlRQ2pwZnZWVk5XbEtKRmdQeUpoT0ZGOGxxQVNFeXNQZlN1L2dnR3JB?=
 =?utf-8?B?VUluT1gzRnlUSE82MmptK3lEYmtRdlJwd1ErVVZGQjRhZ0ZUcENweFlFNXBZ?=
 =?utf-8?B?UnJuMXFEdW0wTW1ncnFvQjd6ajNUS3pzcC9VMFNGZFpNejRHQ2NNOVRuYW9l?=
 =?utf-8?B?OFllUnh4R0tzZkNRaUdKTU9Va1greTFsSjYrQzhFUkxWVStXL3E0UUtSRkYy?=
 =?utf-8?B?MkhqVnU4R3NXTkNlMVRtNnA0bk14OSs5U2RCRUZxUWx0alNUVEFIbEU4N1NT?=
 =?utf-8?B?Mk9Hbi95aTVsc2t3dmZSaTRFV1lZRE5ueFFmTVRvaUY2TGtCUFBJQnI4Vm55?=
 =?utf-8?B?VEMrQnVLQWdZVjJuNGRIdndtYWxxeU0wWjJjVzR4ZklQei9mb3J3dDVEeEpV?=
 =?utf-8?B?UTNVdW1TTmtnYnhxNjdCd1cwcStpVUFvbDdRVjBxR1hGQnFQNENHTnhJbWpz?=
 =?utf-8?B?RTZJQmZlZWdOL3pOZ2pIVXlJeWVybXk1STJBNy9tYVFXMVdlL2UvdU56NVZ0?=
 =?utf-8?B?WVJIeTdBWVhCMGp6cTBxVEJ0ekFkWnE4RTU4bGxjL3dPcEJ5TTZwelIrTi9o?=
 =?utf-8?B?clNYbVAzMU8rY1lUNUQ2djJGdjk3WDRBUHdBcC96OVNZQWJTY0pJYS96YnV2?=
 =?utf-8?B?dGJZYXJHUmRTUVhMTkhJUmtXck51aUt6ME5CcGgrZUdlbGhldVJpV2E0YUFo?=
 =?utf-8?B?aUlzVk5DYlN3emxNMFBwZ3dnNmtoR0tHTjUzdGpWTXhYdm5xV0FDVVlOM1ZM?=
 =?utf-8?B?R0pPNnlUOExoYmlOenJsb1Q2SHhCcXRqNTMzMUR4Y1RzVEFMSHlNbDgzbXFo?=
 =?utf-8?B?aUtzb2t4bE54bTNIOVQwSEJ6QnQ5SzNySFZuTEx6Y0xJcVZIRGF6cUpGQVND?=
 =?utf-8?B?MTEvMWlNcmIwWU5zQnhpWklkUzhvK0ZPN1Q0K1FsMmswdXhJUVVCVzNiQUNP?=
 =?utf-8?B?THpHTFl1UXI1QnJBWWovaTg1L1RVNktKL0cwTHV4TTd6S0d4MG1YZUdTR2xS?=
 =?utf-8?B?VHVwcXMwTHJFWFNTVkR6bWlDUFQ2Qks5cnBXc1NoSEVhaEdvUG5vOGxhUDNk?=
 =?utf-8?B?eUh2ZWViZEVTYXBxRUxaZzJ4eko1WThzdjc0aDU0TllLM0Rac0E4SVVHQ0dH?=
 =?utf-8?B?N2pYanV1ZkFRc0QraFFMbFduMWRPRitIdGVDMkpaM045OXo0QnN6NEpNa3Ay?=
 =?utf-8?B?cDNvQmNVVkFZY1hCanREY3NOSGIxZHNJRmUxck40WUhnWEU3QVdBcnI4SjFm?=
 =?utf-8?B?TkFMVUpjR0pYUkhwaDVIY0oyNExHTUJjTkdiTCtUL3FGSUJjTXg3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a75d5d-eb65-45e6-e75c-08de6392f675
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 02:13:18.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUQt49XgV2hAfL3qY35QmxtVxmBs50snTPGhkwgmHvzqP9veYob/zaHkVOVugIGctF3mgEgfvvsuF8I6JsYORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42028-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linaro.org,nxp.com,gmail.com,kernel.org,collabora.com,pengutronix.de,lists.infradead.org,xs4all.nl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:mid,aka.ms:url]
X-Rspamd-Queue-Id: 72C59E0B9E
X-Rspamd-Action: no action

Hi Nicolas,

On 2/3/2026 11:40 PM, Nicolas Dufresne wrote:
> Le mardi 03 février 2026 à 16:53 +0800, Ming Qian(OSS) a écrit :
>> Hi Marco,
>>
>> On 2/3/2026 4:31 PM, Marco Felsch wrote:
>>> [You don't often get email from m.felsch@pengutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Hi,
>>>
>>> sorry for jumping in.
>>>
>>> On 26-02-03, Ming Qian(OSS) wrote:
>>>> Hi Nicolas,
>>>>
>>>> On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
>>>>> Hi,
>>>>>
>>>>> Le lundi 02 février 2026 à 13:44 -0500, Nicolas Dufresne a écrit :
>>>>>>> This doesn't sound like just a VPU issue; it's related to the display or
>>>>>>> DDR.
>>>>>>> If not displayed, do the fluster test cases yield different results at
>>>>>>> 600MHz and 300MHz?
>>>>>>
>>>>>> Didn't you run these tests before sending ? I can try again, but in my
>>>>>> internal
>>>>>> notes, I wrote:
>>>>>>
>>>>>>      > Tested that, and everything becomes unstable
>>>>>>
>>>>>> That was before I figure-out the IRQ handler didn't handle exception bits that
>>>>>> didn't stop the decoder (or dry IRQ, which strangely is common from the G2).
>>>>>
>>>>> Ran some fluster tests now. With this patch the results is not consistent
>>>>> anymore. Then I ran it with weston being started, and in the middle of the test
>>>>> the display turned black. Matches my past observation. We did reproduce this on
>>>>> BSP kernel too. When the display goes black, the recent hantro drivers reports:
>>>>>
>>>>> [  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
>>>>> [  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks were
>>>>> decoded.
>>>>>
>>>>>
>>>>> I have local patches to reduce the cascade of errors, so it likely survived
>>>>> longer then last time. I will send these patches soon. The "not all macroblocks
>>>>> were decoded." is triggered by a bit in the status register that is not
>>>>> documented in NXP TRM. I found that bit in some VC8000D documentation (the
>>>>> sucessor of G2). I concluded it was the same meaning after looking at the failed
>>>>> buffer visually, it is indeed missing couple of macroblocks near th end. Each
>>>>> time we see this error, the DCSS gives up and turn either black, or sometimes
>>>>> other color. The second case has been tracked to a DCSS Scaler underrun, the
>>>>> first we don't know.
>>>>>
>>>>> Fluster command ran (two threads, never completes):
>>>>>
>>>>> ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j2 -t90
>>>>>
>>>>> Nicolas
>>>>
>>>> My test results for fluster differ from yours.
>>>> On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300MHz and
>>>> 600MHz.
>>>> And results remained unchanged after multiple tests.
> 
> After more testing, the fluster test is stable for NV12/NV15 tiled output for me
> too. I'm running the tests with linear NV12/P010, which imply an extra set of
> buffer. I will check if I can give you a easy way to test the linear formats. I
> also have couple of streams that systematically breaks at specific spot (high
> complexity scenes) with the provided patch. As most licensed content, this is
> not sharable as-is. I will try and see if I can find a way to share something.
> 

That would be very helpful. Thank you very much.

>>>>
>>>> I'm not sure what caused the differences between us.
>>>
>>> Once it comes to system stability, you need to ensure that your
>>> bootstack is aligned e.g. same TF-A version and sometimes same
>>> bootloader since there might be workarounds/erratum applied by the boot
>>> firmware.
>>>
>>> Regards,
>>>     Marco
>>>
>>
>> Thanks for the reminder, and I agree.
>> I think we need to align our board environment first.
> 
> I do likely have slightly different bootchain, and of course all the HDMI
> component are downstream, but I can't really isolate the dramatic issue of this
> overclock without a display component of some sort. Its a huge differentiator in
> the bandwidth consumption which is the main challenge on this SoC so far. 10bit
> videos makes things a lot worse fwiw.
> 
> We did review latest IMX vendor firmware package and can confirm we are running
> the latest memory training blob and HDMI firmware.
> 
> Nicolas

Since the datasheet clearly states that the VPU G2 requires a voltage
increase to 1.0V to run at 600MHz, (I thought it was already like this,
but it actually wasn't.)
I think we can align our test conditions to this.

I will increase the G2 voltage in V2.

Regards,
Ming

> 
>> Regards,
>> Ming
>>
>>>>
>>>> Below are my test results:
>>>>
>>>> 600Mhz, 0.9v
>>>>         cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>>>          SW1C                             0    1      0 unknown   900mV     0mA
>>>> 825mV  1100mV
>>>>         cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>>>         600000000
>>>>
>>>>         ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>>>> 90
>>>>         ****************************************************************************************************
>>>>         Running test suite JCT-VC-HEVC_V1 with decoder
>>>> GStreamer-H.265-V4L2SL-Gst1.0
>>>>         Using 2 parallel job(s)
>>>>         ****************************************************************************************************
>>>>
>>>>         Ran 139/147 tests successfully               in 505.434 secs
>>>>         Ran 139/147 tests successfully               in 505.350 secs
>>>>         Ran 139/147 tests successfully               in 507.540 secs
>>>>
>>>> 600Mhz, 1.0v
>>>>         cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>>>          SW1C                             0    1      0 unknown  1000mV     0mA
>>>> 825mV  1100mV
>>>>         cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>>>         600000000
>>>>
>>>>         ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>>>> 90
>>>>         Ran 139/147 tests successfully               in 506.901 secs
>>>>
>>>> 300Mhz, 0.9v
>>>>         cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>>>          SW1C                             0    1      0 unknown   900mV     0mA
>>>> 825mV  1100mV
>>>>         cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>>>         300000000
>>>>
>>>>         ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 -j2 -t
>>>> 90
>>>>         Ran 139/147 tests successfully               in 506.063 secs
>>>>
>>>> Downstream v4l2 driver
>>>>         cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>>>>          SW1C                             0    2      0 unknown  1000mV     0mA
>>>> 825mV  1100mV
>>>>         cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>>>>         600000000
>>>>
>>>>         ./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2-Gst1.0 -j2 -t
>>>> 90
>>>>         Ran 136/147 tests successfully               in 460.435 secs
>>>>
>>>> Regards,
>>>> Ming
>>>>
>>>>
>>>
>>> --
>>> #gernperDu
>>> #CallMeByMyFirstName
>>>
>>> Pengutronix e.K.                           |                             |
>>> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

