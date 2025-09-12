Return-Path: <linux-pm+bounces-34529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC885B5443F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E7D3BB496
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6D2D3A75;
	Fri, 12 Sep 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYyATiRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E02D0C73;
	Fri, 12 Sep 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663733; cv=fail; b=DVzi4q9BV4j/DsehcJ1kqz/IDZ1p3KdFah2Jyj07OkPEWjl7OilWxMqXH2QNDmVdk3UV1f85cwelmqHlwGxGNIucBWGiqrL+7hyevmwSeJEsx+tu+0YsPiP0zYNhpMGeLIkYN06mbzuFFftVm+df4v1ygL/9kRNLYLuvsrYYdZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663733; c=relaxed/simple;
	bh=QQ+cd+hLaL2frxVWY5xX8+TrfLdxW9RPNuoDxENVCFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klNnA8gvvba7veKXv0dc033agrZaWFfCRE3sJd+MX+URtx2etvlaPTNbMG6KBhnA9AyUwYkLFYjxrMpm/LD7yn07CMZmXdBtuBGFY5plaPSInjZiIYq2OJTAsNq86WLMHTuGV2Uvlit7Cjkd8F3p8w5N9J3eIPTXCKzCzWlm9ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dYyATiRd; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auVZ63048/e1qCSVtEBPDO3V2UEjWTuIf3KZ8enzf2czyKNHEyomIruFLXalxVdssI6rlB6juuLtKWKpvt5v5yoGlOzI+ewtfRGtJX1HN8P6xMxgQ3gRmfml27RPubDRd4KLDdBWItB3ksyHESbtMwRGQhYachOrART90/avnjHY0KM4MvLoY8LGfeZhrENJ8kRTuRyEluovXiLtenAU9f+2ivD/VNPT+OI2HZD0GoPHH5fZZcOprwC2VMAXKXxGX7l1JSkznQstmcaoR/DvpuDs+YiS256W8ltAAMXJDbN4NQGYxFjlkMpQtZSXBXGmhdKZWrOxE4rVDxtc7HOJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIRDRAS4iOBNB/OLbouHuYJX3PHLSA5fPg2XhnjESVg=;
 b=F1Tbh0hWTmG+lyks1HYfOeVV0D3JKjTNqEYbMsfc5UIOIZ8UveS+WdtSUOJsIYYhcDDzQjFz2EwF5FuvK6y063GHdDy05m71GIeFoSAWZhrg58JzLwwyHDMAC2sxcpfuiRTybT6Nn4PCbHS+bFjKwuPcs/CQmgc1A1WKwp4Tmo71bIch1i/UCANY9q3fAwkYVzNhB7XIkEWxflocWpORaHvOlVLR++KcA9b0JwqN9bh22RP+u4IQCN0xV9IksEdHEZn8bl7hxX7D4knEm6SKrHXn3yd99JAR6kXm+0NNQq9Fub/uPqan57HrAfn+oznbfhM0wWhLXg9VXwUiPK+jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIRDRAS4iOBNB/OLbouHuYJX3PHLSA5fPg2XhnjESVg=;
 b=dYyATiRdLH7p/YVEZs/6kQRXMrR6IEiiGklxXz5FD3U3K5T4r5/T1YHz8IthVpxKt7ZkyHIwZS48J6+f0Vm30A/T33Op1MgNbVNS6UrxrwWDwenDuBd9Vzn+k0vP7ejHTgKuguhnZUSDIeBALRsYJtRdg4CL2fT4DspNuX/gKY7PsvlhXWTdk71epLUS/jlhrKnZEKwJYb0dCLEe58G5EVuezHlA6j0qeqZjnJEKzDk9moD2w1JAyoi9OutcvlUFBhcrc/PgCPpHh3B9olq2uGkBecQeyW3zG5djjaEq8KvcjG68nnHIPQj1ZecFLLL1/dzYMq5LyECjwATbTN/PLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8641.eurprd04.prod.outlook.com (2603:10a6:20b:428::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 07:55:22 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 07:55:22 +0000
Date: Fri, 12 Sep 2025 15:49:26 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: ryan zhou <ryanzhou54@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <3xjjx3dwqgtycasjystk4mcqzunut4mq2uzhc67ihr5eq6gcpb@r7ccsplb3tjy>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
 <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
 <CAPwe5RNZuUB0ri=cuO4yMUq2nAwTYy_qwNg+wgfXhTHBFO6baA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwe5RNZuUB0ri=cuO4yMUq2nAwTYy_qwNg+wgfXhTHBFO6baA@mail.gmail.com>
X-ClientProxiedBy: AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d2f1ed-7b16-4ec2-bd81-08ddf1d1b92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9hVm9mb01ZNTdMWFhwcFdMY0FHTTJsMENoQmJxUmRwS2NzUzQ3YUlocC8x?=
 =?utf-8?B?aHN3SG5zNVl1WE1WMmlnSytadm9aZnd5aXlORkxLYUVhTGp4ZEJOdEFobVNu?=
 =?utf-8?B?REFpVXpKNHBLbDJwMUI1dUNUeEUzb2FBUVBsRm5yR1U5UEpObFRLU3RNVnRi?=
 =?utf-8?B?RVB2alh2Z1lPTXluQllHRHVVRlNuZUlQS2hqZitmMmhNNzBhUGh6VU1IdEFJ?=
 =?utf-8?B?aHNHejlhTXRMazAxWjJhZ3l0U3ROdjdsaHBvZWp0SDdPcTljRHhVSURnTXN3?=
 =?utf-8?B?Y2ZyMFRTUmI5cmxjaFhFTlAzdXdyaDVodmZJMzBmV0FCaEZYYk5HekVqUS9j?=
 =?utf-8?B?M2lzOTI1endpc3pJR0JhRFZiQVJRYXZZcVpGQmxRaXFGKzBBY0xpSFpWZENI?=
 =?utf-8?B?cHFoTmxVSWRBS0JQWjllSDlpNlFSVWVUb3dEREd6cDFQekhQeGpPa3diMU83?=
 =?utf-8?B?akpwb3haRUNTbWx6aHRMSlhnQlg5T0ZId1dPOTMwdTVqVWVPVVhlZGZvU05N?=
 =?utf-8?B?dmlwKy95VzEzSFpaL2FubENFTEYvZ25mOWFwMld3dlFQQmRRZDMzY1JTb2JW?=
 =?utf-8?B?Ym05YkpQMzVGTStOSVlGeVZJNDRWeXd1a2tEV0RIQmErMUIyVWJOV1BTLy9T?=
 =?utf-8?B?YUlrNkhydlhMeDJ4anZMbEpPSmFnQnhyQzdHSE9WYThFai9LbmtXWVVreEUr?=
 =?utf-8?B?ZlA0QWdwZXZtZzNRL1Nnd3BQYVZPYjRLNCsxR1E1Nlp5UTl3dUtwQU5xQWNn?=
 =?utf-8?B?SU1pUHVnZTNXZG9VNXlaUDg1SnoyeG5hbndqeFNBbEhLOHM4UkJGdGNGb3lE?=
 =?utf-8?B?ZDAyWkdESEhWQzZXMXhmeTltR2JZaW90S2FyOWIzaVlOSzdIQ1hEVzFzMTJO?=
 =?utf-8?B?emxkYmErREo4UnQvQlB6TGY4UDRqUnVjbjdjOGkrRzhQMGJSZnRHWWlTdVBx?=
 =?utf-8?B?SU8zOUNqL3RHRForQTAvbC9WVXhOeVdIaGp2NFNNYWc0NGdTWC9Pb3owN1Bh?=
 =?utf-8?B?YStHUDJVWFVlTGhielN5eGlUb2lUb2g5S3YzeGx5Z29lNVpLTFZ3WE03dzhu?=
 =?utf-8?B?Y2lkcnY0Z0poSzVFOUZsLzViTkk1S2Y3WGN1dm5tRmsyTkFCb1JlcERjUnB4?=
 =?utf-8?B?dEVQVkhiUEQ5eXk3cjU4YUg5bVFHYnNRZm9EVGIyQTNMMk10azFqUkNqTTVt?=
 =?utf-8?B?QWo3WERMNDhac1A2RmlvM28yRUZTVys5MW9Gb3JiRlpiWkY1M0U1VWZBYU1O?=
 =?utf-8?B?bGQxR250RVd6Tmx3OGU0SFl3Q2dlRHluNkJvZVlEOWlmN3pUM05nRFBabUYy?=
 =?utf-8?B?eHFaemIxMU0vVXpKZ3hWSWtPQmVmNjBwU2ZrZEVaQ1Y1bGxaL3drclJGdWxV?=
 =?utf-8?B?bnViUjl3dER2VGUybE9zRFpidjYxVVRDT1VlY0dxbWdNMkhOa2dNYzZxeWZI?=
 =?utf-8?B?V1NWOFNRcmxzdEZ4MXhzTmFEMHZOeTZHaUZiR0hzMXB1b0ZpZFBvQVNHdUJj?=
 =?utf-8?B?QlhGWGl0dS9pamw1cFJ0Q0VCQ3pxSW1tdVY3RGlZaWdOa0VCQytadWh3N2ts?=
 =?utf-8?B?YjE4bk5hZ3FwSlgvQXAydEVzbHVhZlJudnRhMEFYNzNyc2h3VUhEQk41b3ZW?=
 =?utf-8?B?d0FHNjh0VGxsdkpkaERNbERHSkNsTXdHdjlFeExueHhDVmNMVTRVcU9xY29a?=
 =?utf-8?B?Z2hxNGdzNXYrWSs4aDA0MjkwK0s0WmxuNWVCcnpBZGpKcU9wWGlsTjNxWXRz?=
 =?utf-8?B?dVNJVWJhTnIwbGxlQy9VZ0ZvYmlGMWhkZTVzQVo3S05teVBxYzlkYVFzV2Rs?=
 =?utf-8?B?NHd1eGgwU1Z0dGJtMnl0Z3YxdThURktJVmYyZVJsYlBld0pZRlRFSHkwRVd1?=
 =?utf-8?B?aitBejVqQ29uc2NteUd6Tlg5TkZJZmN3ZFhETjQxSmI3eVhNYlFlT2pIdmdR?=
 =?utf-8?B?NHBiMjN6VGRPaVFwL0RzZmpBTzZQRGxUN0ZLbFEySXNsOExONncrTGRHSWtW?=
 =?utf-8?B?RmhNZWJFUFhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWd2ZDFXWjVvOHRwS1J5d3MxUUx6UnhNYjVPbU5ubnArRG1vK2E5YVp2b01H?=
 =?utf-8?B?eWpVTDQ4dTlyNk5WOUZrT2o5dEFaaWIxTUs4YXEwNXl4a2hoaHpDSmR6RGU4?=
 =?utf-8?B?ZGhTZjI0WjFyRjZXejBoNlF6OVJ3d2ZsS1BPVDRmUTdnSWw3U0o5Q1lTZzZQ?=
 =?utf-8?B?QUo4N0I4V0VZQlR4b29vZCs0VHpUYnExMmVhTjBubSt3RkgrdnhYU0RrOTNS?=
 =?utf-8?B?U2NQZ1A0UzA0ZThyclVGZXhZRWdzUHljSVM4MGM0UFBvWGJ1T0RQaTBUeWFN?=
 =?utf-8?B?WDZiNDNCcDdKaEE3cUNtUkMxZHFnVmVQb091dGxpNGhhNUFKazRZb3l4UlV2?=
 =?utf-8?B?MTBSd0QzWDFMbHJtUktoNEU1S2R4OTJjM01PelBMcEJLVjVITVFDb25vZWRz?=
 =?utf-8?B?bmhtWTBQN09VdDRWTWt2ZDNMSG9yWkFLamx5MHJ4Vk1nRE1RQmpFUlY0N3gz?=
 =?utf-8?B?RmduRWZOSFc0REdzaWpMNHd3TVJxek5iSmpPOS8rbGxlRmJjSWNXQ05PNVp5?=
 =?utf-8?B?M1Y0N081ME96WkNMcDBQT2N2b2pzQ2YwWjR5dDFCRnZDNnhxdDFhS3lnV2R0?=
 =?utf-8?B?ZlJleGQvbG5td01zcUQxQlRNYi9NM2tieGsrcFNmNEJjTW5KYWZRRE1IOE9v?=
 =?utf-8?B?d1duc0FGSW5hNDFPdUhhNGJ3VnpHSFZUMDZXdElkU2puaHRuVEVMZkZ1Mmow?=
 =?utf-8?B?WHhMMFQwUU9DWlVSSnFhV24wOXRQVXlnZ1RTelpsWW9HKzVjazFxNngzeElD?=
 =?utf-8?B?T1JoU3FxZjhyOUwzbHEyRkt4blZ5RjZWT215dGlhUWxTTmpNR0k5MVVrOGZG?=
 =?utf-8?B?bThiZEtEdEd1eTRkWEo2T3kwOTMycU0zdWJaajBnTmJLSklWVVUzSldsZm1U?=
 =?utf-8?B?RDQ3bFZmZHQwbWd3KzdodVIxTkdpK3JpdnRsOVZPR29YbzRyWmk0aHR2eEdl?=
 =?utf-8?B?T0NvbXQya2ZCQi9mRnl5S3VxYmM0ZUpVTlV3YW5SQzh2S1JteSthS01ESVpq?=
 =?utf-8?B?ZzVPQllYMlNGQXcwMit3M1BEUUd6bDJzWnZjMlNTRTd1TjJCSEp4bUpQSXBu?=
 =?utf-8?B?ZVN4VmNBYnV0c1pCK25TOURBZVp5bmRnc0RPWnZyY3IzUCtYdldra2NvTGxo?=
 =?utf-8?B?ZzRZeStSK05yUDN2dVZwR2k5S2ovajZoR3g2bTRHb0VLQ1A4U2J2RkFCdHFE?=
 =?utf-8?B?VXhHdHd4MzhNSHZ5SUt6MHhqMXkzbTlhZFkybCsxd3dSeDluSkpBNmp4Q05i?=
 =?utf-8?B?bTVjdXN3T2pVa0k2dXoyRVpDa3hIN2hQcnoyMTl4cStZMjc5UXFkdzduWlV6?=
 =?utf-8?B?NmtDWG8zVjNyUGZlbFpuN2E4RkZYNlBrMmt3dXBJTDcyRUIwZFlUdzR4Qm5I?=
 =?utf-8?B?eU0xOW5PRlA4YmVZOTBBVTNDWXpMMW5RSE5kdC9xODg5eForTnVjOXozcTRF?=
 =?utf-8?B?UVJ4eW0xdjE1bWkrVXNjNU10cHJWTFp2eGhmRGlUd2dIdFpPaFRWcnkvZUta?=
 =?utf-8?B?dXBUVkU3UWtld0ZqdnRrekNraFp2RWdNMzZTaXA0cGJBV3NLTUJyMDlwdERr?=
 =?utf-8?B?RkdrWDMrYS9lZFlsL01lUG9abWl6YmFXWFl2WEIrRHJZak1pY3J1NkVYdHZ6?=
 =?utf-8?B?Z0J6dm9oQ1R1N1F2bmpCY0pwSVEwNVN1MVJmVkIyakk0dEwzMTBzK2hlclBN?=
 =?utf-8?B?OXZrZ0dDMGQ0RDZxa2pBci9YSkJLTmNZbnFqUEpJc3BBbS9IUURtcnNLRE5K?=
 =?utf-8?B?YmpOaFU3YytRSWJJcTlkdVJMRklVWkpxZnpTYURIaldlZkE1T2w4V2sxbHJu?=
 =?utf-8?B?ZHIxNTVuc3JXYzdOZDlJZWZaeEJTdUd0bHMvUkMySDNGSSsrOUc3ZGczekc2?=
 =?utf-8?B?SVRjTGV3V1p2L3lWajVxOUUwZEg0RGFLamJTNUNERC9WeHI1cHpMMUkwUEdy?=
 =?utf-8?B?c2NxSGs5SUsxZy9EcndnZTJMY2V2TGowMnF0VWVkVUt6Wm52RS84dDRHUHBo?=
 =?utf-8?B?UU0yM3pTS0E0dmY5S0FnZjEwMGFRVDRpWnk5ZUZTa3ZMOCtGOFY1L2oyTzlz?=
 =?utf-8?B?QW0xbUVxOHdqSjJqUS8vRXl4RldMUndxanRvY0VmYWsxbkZRdjdwWnVxU0pF?=
 =?utf-8?Q?NmEa/srAfhRWQe2VX2yNdtRrD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d2f1ed-7b16-4ec2-bd81-08ddf1d1b92f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 07:55:21.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dY2rNsie2HHZiN+MNA3+SZT3jLGSk3df/HrF9hn6KCft55Gx4GMPBI6+2qUvRv8sKqEtDo2xZqxLu5C6Lb8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8641

On Thu, Sep 11, 2025 at 09:51:50PM +0800, ryan zhou wrote:
> Hi Xu，
> 
> Xu Yang <xu.yang_2@nxp.com> 于2025年9月11日周四 18:58写道：
> >
> > Hi Ryan,
> >
> > On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > > Issue description:During the wake-up sequence, if the system invokes
> > > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > > runtime suspend state, the system will generate an error: runtime PM
> > > > trying to activate child device xxx.dwc3 but parent is not active.
> > > >
> > > > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > > > is detected in a suspended state, the function shall return
> > > > immediately without executing any further operations.
> > > >
> > > > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > > > ---
> > > >  drivers/usb/dwc3/core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 370fc524a468..06a6f8a67129 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> > > >     struct device *dev = dwc->dev;
> > > >     int             ret = 0;
> > > >
> > > > +   if (pm_runtime_suspended(dev))
> > > > +           return ret;
> > > > +
> > >
> > > Is this a documented behavior where the device should remain runtime
> > > suspend on system resume? I feel that that this should be configurable
> > > by the user or defined the PM core. I don't think we should change
> > > default behavior here just to workaround the issue that we're facing.
> > >
> > > What if the user wants to keep the old behavior and resume up the device
> > > on system resume?
> >
> > What about resume the device firstly if it's already runtime suspended when
> > call dwc3_pm_suspend(). Therefor, the old behavior can be kept and the issue
> > can be avoided.
> 
> Originally, I also believed that forcing the device to remain active
> before PM suspend
>  was necessary. However, this approach has two drawbacks:
>     1. It prolongs the system's sleep transition time.
>     2. Worse, if a USB insertion wakes the system during enumeration,
> the system may
>     re-enter sleep before the USB device is fully recognized.

Can you provide more detail about point 2? When is the USB device inserted?
Is the re-enter behavior caused by pm_runtime_resume()?

Thanks,
Xu Yang

> 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 370fc524a468..1b8dbb260017 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
> >         struct device *dev = dwc->dev;
> >         int             ret;
> >
> > +       if (pm_runtime_suspended(dev))
> > +               pm_runtime_resume(dev);
> > +
> >         ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
> >         if (ret)
> >                 return ret;

