Return-Path: <linux-pm+bounces-43660-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPvpH2NJqWlZ3wAAu9opvQ
	(envelope-from <linux-pm+bounces-43660-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:14:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0135920E173
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10B8300F518
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B55374186;
	Thu,  5 Mar 2026 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bfdDqqaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C772305057;
	Thu,  5 Mar 2026 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701725; cv=fail; b=qAq2colu55N6ZpczRNCeMxowqKgWSoUmXzIVbfM62ybIJd0my3E+t+qo9pfGL/JB4rrAlq7uGBETr0IvrTCBsztsHgsRHt/K/AHvwclqdzM+rKUI/N3tubdMELO/vlHGOB6vFPCjARu0u/d/4+pmC3fJPsH1Y68yS6+zAXdD8iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701725; c=relaxed/simple;
	bh=i/+MfBz+oByOIaC60X5qdl9HPtk1vRvftA+iEt1OknQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B6qGzs8oAecZv/3lpnIoRSE0qiQfcgAS1DuQvnII20o6CHFjP5T38RVTeQUpfKKvkRicDhD7FD3sO3+Aiq7i8VPLYR/fGD7RX8RbEuHZbu83SrVAt1zbHI5jJl2e94ANSjV5HMx5Lo5YW6o031Kl0FNXBLazr+VQV9UVKHybPAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bfdDqqaV; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+Qc+TZf7xIXHYbf6UJy1Pqe/KTnZ15XILTc2HkTjsa3vgIYyZ2Y3eOsEFi3dvXmCeOKyCf0Ef1LoktL65iYUvCMyaRidnbxxx+ZdCp5UlWP4sMCyj125XUBKmvjf+YuS8da/tHxa3snmNBoG77lYHyq54aQea40D6XbOIaTAfUDGHJ+wf3eAL2XWxnQFQXeonLPw7JKahhq/Arw73AburAdjrzgDKOAqcrrw2Ebg/TagukOgXq6uvpMSvw+8Hbvo1WkZnrXzEo7hiYBxnc5GPQNoZPh1EuJJ789VgXuoS7F4B3K9Q5mV1A/OWQeIy3Zz8dUP3Te3Azmhyp9DgEP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt4q+UWyv6ZbVOPI7uRT7EGLswtUy6ThAWj1jQih/o8=;
 b=U3ZpRtfmPqRj0R6u2extbklAs00zphxfO+jnM0JhTG3A1c3rOiOy7KzQZw/+6iSj2sl3pasLnqDLnHr59WiLHtLK7udAduSpwiAXHcmEE4JPaihQLplDuiwHq+3RGs6MdhQ4ChptZXHFJHN8Cisu7Ly19lVpg8TlUQ6Ozqe0/4Kw7+GkluLXj8lxMp/XxZRmlI7KO4vrs7yS5SXVl/CtyGvfS+8LiEcl4GHp+VqfxkGcPx+kVPjcrxysOgy7Tp8dnO+lQ/yKku8Plz4+SpzLBGf6lYQYeJKZLDUCG7KePOn2wglP0G6/DCjj5OuUWCX9Z3ZwCpxDTrsAwjCOenTivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt4q+UWyv6ZbVOPI7uRT7EGLswtUy6ThAWj1jQih/o8=;
 b=bfdDqqaVcCSP3lnCR0/qemYDbOyiNLTjon1nk+ILTUHIxHRKxalE9PkV9nud1PSh1ogZdrDaEnLJ/eBh00UAHPgc0LuwFExU73f3fqSV8as90R84T+96wMaTtbcBlAeAnjSe3RttSAETtEuORhZxoa4zlx1HEXn44KbQU9So+QyYVlzEompnzS2c6pxof0g2BtlodY3iyLvZwzwpXdOxM3JsT0bzqBHKc7Lb4F6kxW+weLuVkk7W2uXMc1N1ZR982m6oROtZEoznTVQMgNtNvF47VsMvxkviXv5tkP02KTHx56qvTAk3lAtyZBUPcLrFEOgcr7hzLp0SvsXQdzlfaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AS8PR04MB8360.eurprd04.prod.outlook.com (2603:10a6:20b:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 09:08:40 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::20db:4017:28ea:911b%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 09:08:40 +0000
Message-ID: <e09587da-a9ca-4b2b-bd4c-222e1df09b8d@oss.nxp.com>
Date: Thu, 5 Mar 2026 17:08:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: verisilicon: Fix kernel panic due to __initconst
 misuse
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, fra.schnyder@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com,
 peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260305080354.639-1-ming.qian@oss.nxp.com>
 <j4h65w6rwsd227gooa437qfp43z3vtiyaegehbe5md3f22anae@lprbmtart3km>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <j4h65w6rwsd227gooa437qfp43z3vtiyaegehbe5md3f22anae@lprbmtart3km>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::12) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AS8PR04MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: b72d025d-d1ee-4707-9628-08de7a96cacb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Nas5GRkb7AHpGZ1M3E08Kj7NdfRjrR6k5kLc+keq1Fnj6jj+zYW2syBYIpGXgnO3kVsDTIWVGl11fGFErLyx1SN52tHyQVcFwLOr5LdS3JvrgLzYs3IolZk0JGjPol4p8RpheYff6P/WBW176YuXGT24iJL0INSDzqk9uB2lVmCsGFBwg0poZYyvU7PLGHDh5E0rcow76YJaal6FsM6nY3fhoVPmdPlgemafuR+aicNS+nR7J8pHysKhe1HyDP0ejoqChyRBzXPS60PrSLAAj/MlCDJbLHWi5vEUfxkC9sJe9TJQUU4ogoCABK8tvHBhuXqYy1O0lfEEsZbI9FbTOsUQzbNuxd3zcW5AobTHzfJqDYImIpU56/lh8FciAmX341h8bXxMNfVGkfgd0lC3wO0eStfDvQYtJGzNLx9GjN+qObQJAeXWBt5rufIc0DIRUt8BMDsozPb8JVzCqRhDXSbhzR29J8FwwNiafBQCODR8aOYqeuyblRIv1tlxZo6rebuSddyhLK+j+giTlSsBmgk+8ZWY489LgN5fUIS4Yq1ddaf5rgnL4n1SGNggoGuX0GJWa+cP6TnkiNIHIdg/Ev6zTrRmP90+sKWgwauByPiTLNg3CjYbe/oh2tbKdY841pakX+okbBibQXDV2U5d1EJ6FI9DLKGYI+cz5y0Pe88bt/dMhY+YjxRQcVaVC5t06TVDnvw6F9PaHg+fwnhJwM4eYlzYktmHzsTAGo6YIL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekhWT01XYkoyL3Q3Q0FIQ2NzU1BaR2NrNUlwNUo0Y3dDVXBmRVpZZlF5NW9m?=
 =?utf-8?B?SUZ0T1pIS0JMQ29KNTFMNkVQcldVdGtIY2pNUU9mVTFaMDNpNW1CTmRhV284?=
 =?utf-8?B?YnBMakJwczFlNzJFWjd0VXZZcTgzdGtEb2xOenBzdTJ1TGJCdFYwd0VvcU8r?=
 =?utf-8?B?VTJhd2NsenhsNXRFY1F4QVFpTzBLTG4wN3NiSnA0bkVuZFgxNmt4bHY1cFRy?=
 =?utf-8?B?MnlJREVzdndiYjlVRkIvOVJYa0FPK0tyZGJBY3pHbGc2aElIUEFlaWcyaXJy?=
 =?utf-8?B?RjV0N1N3SVZLWnVVa1Mrb3FLdytSWUNhWk1TbC9NeERFN1llM0laSVNmZjBF?=
 =?utf-8?B?VGFJZXZMS3VtdENTYVNYNnFKY2RGTmZlZDZHNEl4VlZ4VS9TbzVmcWF2blp6?=
 =?utf-8?B?T3JodGJOOWY3RXVaN2RzNGtzTGJORFRPUm5xVS9YbmdxeUc1TEtmZlNCZ0ll?=
 =?utf-8?B?VUo5QzgwUWlpOVhkb3R3R0xobWl1Vk5HQzB5S2JBN2ZXM0xnb0oxczN3MGd2?=
 =?utf-8?B?cEYwUFRGWVFZaVptK0xKYldOZjlIZDdiWmRRRnV5dG1JWDJiblhSZ25Td3FC?=
 =?utf-8?B?TkJrK2U0cHdHZ0xOM1M0Mzl6TFlua0FmdFJ0aEs1Y2hRb01hREhBUGxqT3Rn?=
 =?utf-8?B?SmpqeGtpTFJEcURXeUkyblBDMHFrVGpqejFHNjdYLzNHL3JkODRYeHQvdGFM?=
 =?utf-8?B?dGc4R2ttdUx6T0Y1ajRYZ1huREdBeE9EWlozdElvV2NFdWQwNDB1dXEwMlo0?=
 =?utf-8?B?clRlRmplQUNiNGc3LzczUm9iUEhxY0s3b05XSmQyUGxuTHl3TWljVzJSWmJl?=
 =?utf-8?B?eWc5U21zTkY1WjREQ1kvUkNmdXBqNWFjcG5uYzlsaU1yZHN2dUMxR1ZCb1Rv?=
 =?utf-8?B?bG9NaytYS2N1L3htWHd2cVc4TDZUOGJvZ0xHWXhhemZJZDE1cWhMVGVvWUU0?=
 =?utf-8?B?TE5qalgyMk1RR0hNa1h5LytsTEx0bVlLNEpUVVZXNldNczBUUnRoZ2V3Rnpl?=
 =?utf-8?B?ZlhJNUh5TDlwUG5PMFV4ZU1XQW1HalNaSGV2YTVNSHN0MkpZNjVWMU1Xb0JH?=
 =?utf-8?B?bXFVRDBqRlpTNjlFWnpkR2tSTG5Qa1QwSzlSaDEvWUtSRENvM0tQdGsvRkVV?=
 =?utf-8?B?VjM4ZXoxendQNHlNNWVUQ2Y3N3JDWm5ZK3ZuYjY1T1RwMDNFZ2pFcEFtZWdD?=
 =?utf-8?B?R3pIUzFPcXhHOUtoa0l0cm8raGxRWW1UdU9ZU1BrQmE2RS92NjFGM1RoWkdn?=
 =?utf-8?B?Y3N0UjVvRTg1NVM4K1FYZ0wrcldaVzlhZjl3UDZERFhNVG5zd3hldHhZNVRZ?=
 =?utf-8?B?bEVRTVFtbzJwZHdMN2dFNXVTY3A4RER2bThVbExLMUJZYkNSVEZ2cVFBSi9K?=
 =?utf-8?B?OXN3WkZXcCtRRUpaMnRQTC9QYXFlOG95bW4vRy92SVFzTkFxbk9BcUR5elNJ?=
 =?utf-8?B?dk1wbUU5eUpCNS9JTG9NQS9halBodGU5YUM4ZGZNRCswUnhWS1dLb0JTMllU?=
 =?utf-8?B?aDJlVFR6eFJTTWRJVEJ4UUFQR3R3RjF5dU52OVhQRTR3YzE0NE1jWFhmbEM1?=
 =?utf-8?B?ZldsOVRoLzRkM2V5eEl5dmF5eHRtdnJTcFBpL2tBYi9ZVnhhRStFUWdiU2pk?=
 =?utf-8?B?RlJmaXpSemJtekR6TlVYbGc0cVVDMDU0Y210TkNvVVNrTllJODdFZkpaUXBB?=
 =?utf-8?B?TXBZZXlleU5EU1kreFFidm11QmYxTldVU25xam15a1B2Sk1CMG5USWZHY1c5?=
 =?utf-8?B?MHAzV09YVGoxdG00aTM5YXJwQlFWY0pXTk5lZ2xtK0VVcm5Oc2M4d2VKZXRq?=
 =?utf-8?B?QVVpQjVlRzVEeEo0TFUwRkI0RkJ3RytDbndYNlBvOWdEUHIzUmkxbWpMMG1v?=
 =?utf-8?B?RHpuVWlNV1VHQU5ZMGhFTlpqR08zNVhTY1R1LzU4eE5PMGl4ZDFjYjNyTitz?=
 =?utf-8?B?ZHNqZk1OaXlaTEhqK1JDVnNuZFJMLzJ0R3FUQ010YUZwTkwwRnBiamIxMTgz?=
 =?utf-8?B?QjF3WXhtSDEvd1ptOXBBUDhpM29iWjJ2dXJWaHphaHRuL0Q0YllJR2dzTnlz?=
 =?utf-8?B?WWtmencwVnJOb3NnWUpRaXhpbzc2bjdib2J1ZzFJMmQyMXozQysyRTh4OWtu?=
 =?utf-8?B?QXdOWm1zYVpRendHNGlrVXpLc3o5K0hyM0czaHlUbnJzeTdZVWZKVGdKVTl2?=
 =?utf-8?B?TWI0Y2hndmJhS1Bpc0tHNjVwMkt3Y1Nycy9OSy9DWXJVVDdrdFdmblQ0Q3Jl?=
 =?utf-8?B?UmpEeGM4Z05RajUvOUtiY3dIdlZHNkxISEF4VVAzZEF1MGJuQVhEYVZUd0U4?=
 =?utf-8?B?OXJpemxrK21RN2hYb0NUSXhRNHFEOGQxYTVqWmxaQ242TEtPMHpPdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d025d-d1ee-4707-9628-08de7a96cacb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:08:40.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeaHuW//y/evDM6eR9x/IBJOT0LnQCNj584jPlGmkSWa4ifNXw7h22jpWUOCeMgtiGpdyxT6uLD1UGX9hXV0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8360
X-Rspamd-Queue-Id: 0135920E173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43660-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,pengutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Action: no action

Hi Marco,

On 3/5/2026 5:01 PM, Marco Felsch wrote:
> Hi Ming,
> 
> On 26-03-05, ming.qian@oss.nxp.com wrote:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> Fix a kernel panic when probing the driver as a module:
>>
>>    Unable to handle kernel paging request at virtual address
>>    ffffd9c18eb05000
>>    of_find_matching_node_and_match+0x5c/0x1a0
>>    hantro_probe+0x2f4/0x7d0 [hantro_vpu]
>>
>> The imx8mq_vpu_shared_resources array is referenced by variant
>> structures through their shared_devices field. When built as a
>> module, __initconst causes this data to be freed after module
>> init, but it's later accessed during probe, causing a page fault.
>>
>> Use __initconst_or_module to keep the data available when built
>> as a module while still allowing it to be freed when built-in.
> 
> would be nice if I get at least some credit for pointing to the correct
> fix ;)

I'm sorry that I forget to add your Suggested-by tag.
I will include a Suggested-by tag in the next revision.
Appreciate your help.

Regards,
Ming

> 
>> Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> 
> However, patch looks fine:
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
>> ---
>>   drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> index 6f8e43b7f157..fa429e6e8281 100644
>> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> @@ -343,7 +343,7 @@ const struct hantro_variant imx8mq_vpu_variant = {
>>   	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
>>   };
>>   
>> -static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
>> +static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst_or_module = {
>>   	{ .compatible = "nxp,imx8mq-vpu-g1", },
>>   	{ .compatible = "nxp,imx8mq-vpu-g2", },
>>   	{ /* sentinel */ }
>> -- 
>> 2.52.0
>>
>>
> 


