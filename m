Return-Path: <linux-pm+bounces-41151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8A8D3C04B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3124B3C27C9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138E37A4A1;
	Tue, 20 Jan 2026 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NkRRWnvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E238A2BE;
	Tue, 20 Jan 2026 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892873; cv=fail; b=eymHMZKndeo44uapXgexim6LymlXJd95DrGv0SHStEnJ57vcxd8OtcPAyvWZDV7Kc2KKvpFe+kffa2+/46Ae+4i1PgbtqRPG8iMtViXdQlVxFRXoWTPn7yQb0mGYVuDTRgNi+wqrp9m6hlVlLcUzF+041S9ed1N0gtxjtFJujkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892873; c=relaxed/simple;
	bh=vPzHd00J+noZ+04rpei7AevZwSGWD1Ur3y1pUSHpCjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ljzYr6BhoXW7h0K+jvR5EEM35MDlo4fLScwKD4/9guX1gziZrQZZ7SYpaHy8tM9vvZNS+VmVrO1hQIyVLR7+j8tBVNe/xMHuYpnIuW+EumQcS/3/kIQ+HP6Zr6cjq7WEAIENdL//cu24fS8jxPCNQkBAhpMYG2OFa4HrdoCfSao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NkRRWnvg; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+7YLp7Xyt8wC762gpm9Ls5Mfq3uPZApEQORNVdr8rtAtZkKpdKU+jENXlzmu6XW3FVeLFllgastYRJpof/gaftplEqLO9EjrcwBLMqEHfqEx7F/it3wT51DwKO2ZM9LJxbJZjKnCVWpxWUQ0VqtypjIALElI+0vB+iZ4Sp2tSACf++g5/ZcyX4Ny+dD5jAOKC1zVjvSJxEYIP4/6wFahMTY+V0NNAwN7hX5pk2s3QJKQOFmmhshrDn1Np2xe5DVaJ7ShC2CiKsmns7TMG+24U10e0WWB/0/OVlEXTBuIr13o4SFYpQN0pE27tV3REcvdaNcKI7jLKI8zcJ/OjeB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt2RggxQEjG2t5OD/WD5hAUUKCIPlBCtXIYCR7v4pkU=;
 b=JSUad9naxFH6VuTrsZS2iuC75oxsopotPQlMGENRXGwuwUps4pjrnacILFz1xbx7aImWD6RdL3kGnAFzXkUPL7okG+yVJEt8nQPJpbDhNeL2n/Cnxths4pOZ/0FKAC4lJT4+NunG2Z4L8jx3V2fpOe9PMDHiZKUPPWgdJ4GI7r/4OTB/1y/r4Ogi1TfS804dc2ytdny4x3zNPwrMiyMeuV+88BYMzWVYjghMEn6TF52ETVIRmB2h857uHX6d+kVOhpoqLP+yJn+6gPREB9jBCDoiL9BjgomGLhVTt2sJO15E1vEb9clFezOJL/YnHdA4rQ36BnNWRByNM8VWa1NGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt2RggxQEjG2t5OD/WD5hAUUKCIPlBCtXIYCR7v4pkU=;
 b=NkRRWnvgFXloBH1+WCxIWwnBiWi9WRxRo3AvpmtTHWgbXSmADByWQI+UiHw7C/fdCJuuPjt+yQT2E5f/EHY/f55+aIw2oklZ0F/LiGy9nIGqctKXNRNThCSyjWLK41VwpqedTJ9YswddLUwuMjhiC4P/6YuYPphbeK0GHUP1VxSMpx/4QWPqrETU3rCgMThMdoA26YoPEK/rkZIioj1808/QT7wESYci1f7SMACAiqPnpossHkCPnlQSPhTv7iRqAZkXk6VKLu1l/UhU9n0mKUQdrY5qeDUxBmdxXFAfV1XDBMlcxEVYIjWc3U8ib3hDAGtvBB2g5jVU2eaSdsl+XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:07:23 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Tue, 20 Jan 2026
 07:07:22 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 09/12] memory: tegra: Add Tegra114 EMC driver
Date: Tue, 20 Jan 2026 16:07:19 +0900
Message-ID: <4517133.R56niFO833@senjougahara>
In-Reply-To: <20251125120559.158860-10-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-10-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3f7d41-fc3a-47a6-eca9-08de57f28f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTBuUUkxam42REFGckRXc1I5OTRsaDdwVmord3c0T0Q4cCt3eGJUZGdqc0wx?=
 =?utf-8?B?bW14WjJxc0VZV2dyY2todWowZ1dCblJKZ2JId2FwVlhEVlBSWDl3c0JXYjlJ?=
 =?utf-8?B?UVlUOXU5MmNVaU4wZzdKdkFiellGV2NFcHA0ZFhXQWE1MmVNaC9wcnFqbTgr?=
 =?utf-8?B?N0hKZ0QyU2lVR1JsWWNnWEM3WVFZSyt4cjU4MTlBbkdiVmo3aHppelA4RW4z?=
 =?utf-8?B?dDRXY0hKMGlvSXpqeEhiR1lrZitZS29ySUZIYW9IdzdDRUthaFZMMHQrUWQ3?=
 =?utf-8?B?Zy9Jb29ra2FrMnVqVXVxcUNzejhNZ2haQmhzYkZic1h2Z084SlNkSkdZRFNH?=
 =?utf-8?B?WXo2TkFWamI2RldFY3czVjBiUVgxN0ppWXBPZzJ3VGsvT0F4OTRmakkvanJN?=
 =?utf-8?B?MWlYRGd5SDluV21GWTZJNmZJODc2MEtFUzBad21ueVFEU2xMSFh2alYwS0th?=
 =?utf-8?B?REtqS1BWbmNFUU1nTkxHWkswQnZGNzM3NDFMMmlZQk94Y2RuSmtCQ3BlWnVs?=
 =?utf-8?B?SmplNm5jMmV6UlpibGVxc29aRlFOVUVhMTlxWnpXZXpyK0MrVGhnVXgrUVI2?=
 =?utf-8?B?dHNXbTNKdzVrd3FSYXVtMVc5citkc2lEK2RhRDdLNno4NHcxNkcySUdxU0p4?=
 =?utf-8?B?S2pnVlBMVkVTd3k5N0lDdkEwQTl6RVQwM3NvRzRjM2FZU2NUdVcyVVlKZ3J4?=
 =?utf-8?B?TEo3ZllDbFdDQndRTEdPaEp2d1JvMU9kUGM3WmpMckV5cThZcVJqWU9pM1F0?=
 =?utf-8?B?ZXZyTVZpcDIyYktGMFRsNy9rclFzdE5XTmZxVlR0ZC82UjMrSjkrZ0I5NlBz?=
 =?utf-8?B?NWJUSzRPR0ZidzZMYkxTUS9HQ1Y0REZUM2hOcTczQzU5YVh0aG5pMzlUYkp2?=
 =?utf-8?B?K1BYaXFJZWpta0ZIU3l2L09CYWtaQ3hTMkg5aHRUbUg0Q1Z6YkRxdjl5Nkhs?=
 =?utf-8?B?aTRrMzcyeWltU24yMHFLaktaakFJd00vemlTRkhvUDhySXFWMEZZK0FqMHZK?=
 =?utf-8?B?aWxxRlZ1STdTYXR0MGZBWmJxMVlQbkZrRVpWd2puZGc5d05WaEFoVVNIQ2wr?=
 =?utf-8?B?Y1RKODc4KzEzZm5naTVsNC9TWnlUOXRaTC9LSHc2WHBFT3hQd0Q5ZXNtaGFJ?=
 =?utf-8?B?RDUzOEJBQ1RUV0Q1amI5NzllTzVhZjl6cE1UNUs3Y1N2c09xVFZrbXZtZ1Vv?=
 =?utf-8?B?clBRMHVobjR5UW82MHZ3V3VhZ0QyUTBZclloMFNxb0JxajAwazNWZ0NWNUlH?=
 =?utf-8?B?R0xoTVdWVUtnNVhWcVhRamhPQTBHNGJtL3RhOTBaR1U1NzRUUGR3bitvelFL?=
 =?utf-8?B?QTlaM1hETWN5T1BrYnR4a05LbktNL0ZPc21leHprQkh1SHl6STNXYjZPZVo0?=
 =?utf-8?B?QWVpSFlEUFJHdERkcnBOdU1LQStUN1Z6NStpQW9vM0IzbUhBMDYvaXh4UWFM?=
 =?utf-8?B?a0wyRGlxOHVDMWFmbVJ4SkpzUWJiQmRCYWsxWDc1aDhiSnFjbk53S2FhUGxK?=
 =?utf-8?B?QXdnS0Fkckhqb3NhczJLTUl5cm44UHZ5T1VwT3Npb0FmYnFiSjgraG1qeUJi?=
 =?utf-8?B?eUZRQjR3N2Y2T2NUdktVVytIL3BqV081aDRuL2ZqZEVWZlRFTzMrSHRadnVo?=
 =?utf-8?B?eWxsdmFIa0lLdWVpNDlPUGFzMFJSZGp0NmIwMjZkUU4yUFlyT2FZdUpLak9Q?=
 =?utf-8?B?MHZnMlZsVUlQazFiT3IwbS9oNEpzUzhMOE53ZlJ6eEVDbWhCbitzcThIb3F3?=
 =?utf-8?B?NlZhNG5HZ0xTRE9GTUwrWHZzNUZUVFRzSE1IOFlRMnF5bFJqNUpRd2JwTFc5?=
 =?utf-8?B?SGtCek1sSEhZRFdjZk1UMUlSNXYzN0h4T0ZXNldWNm1KbTgvc1pHanJNNFdt?=
 =?utf-8?B?YmpEK0tyWDRrU0IvUmdEMEQyVXNwWUc1Z0diY0w0Mmc3UUlrVnJ0amljRS8v?=
 =?utf-8?B?VXBuS01iYUx2S0dXQXpWdVFESDhwYWsrTlFVazJob2EzelJBazk2bm5xTm5G?=
 =?utf-8?B?YW5BTzdleGxkbEJOTTJMZW9nVTRPSFE4bTlVSTN6aFBRN0tSZDFDdVNsL0pH?=
 =?utf-8?B?TmZNcWJyTG80bzZzbHlTVDJ1MGJUZ0VDSTR1N1BqaTh6N3d1SWNESUhiLzJj?=
 =?utf-8?B?OSt2d3RVMVd0VStHckxzdXhjcDE2ampnemZ0aGx3THdNc0VNT1hmY0UzNGNM?=
 =?utf-8?B?QkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJuRmNES0s2dXYydU9EWTdpQUhaRll1aUZTcW9PYjdwZUhIZFpVc0FwaDlX?=
 =?utf-8?B?WUg5aldRMjVFTER1MjVMRlp6OGIyWnp4a0Vla1hHTkhvZy9KRHNsbVpuQ1Jl?=
 =?utf-8?B?OTR5eE40WXFmaFNNMWJrMk5vbGJES1hmN2s2VDFzY09xMWtwWS82OUppNy93?=
 =?utf-8?B?OXRWYXo2U3VxYkpVR0ZmMEpTTng4b2ZSenQ2enRnME1sdWdLQ1VGNkNSbUhz?=
 =?utf-8?B?N05uRUxpTDRpMW9GRDYrL1BrNmNGenpEUUNDQ2FETTliWVpsN1NSN0VOb05X?=
 =?utf-8?B?OGJwNjVPYmFyWk5pRWRQK0VwQ29tV29vRVE3TWo3Z2YrcHVTYW1mdVBIY21Y?=
 =?utf-8?B?WGRpQ2lmVUkrMk14YmZNY1NDVkVZSDN0SkVuTi85ZlhDUUdRQkpQQythdUlQ?=
 =?utf-8?B?blpLakFUY0tiZEFPZ1lMb2kyYzlTZzB6S1BYNjlJeWNpeCs3Ui9jcXdQUmFJ?=
 =?utf-8?B?VlVNTVY0YzR3V044ZHdrZUx6OC9wd2hST3c2dUlGVDFYVjFIbXNpcEl5YTZH?=
 =?utf-8?B?MVBib1h6YWZjK0JzQXo5b0c1ZTZFcGdpQ1hGamtHQlVHNVJ1Z0VIWHFqelJH?=
 =?utf-8?B?TjVWT3pBTVU3dGZjdml0T0ljS3ZYQmtmOGVJU1d1UEhLWTVwRmtBNEJtdU90?=
 =?utf-8?B?TkdyRWZ5d05LYmw4SjU1Y3JUSjYxK1hsVHZUc1p2Z05lN0VwcGdBSXpCL3Na?=
 =?utf-8?B?SmNUczVjdmQyRlEvQjh3cXZUTjNSZHZkd3FNeGhiY0F1Qi9JKzQ1Y0F1VVFr?=
 =?utf-8?B?bEs2TG9rQUtEWlJXc01WcHdENWlDaEcyZnJHclFtVzh3WDREVXh2UW9hSy81?=
 =?utf-8?B?S2M0bVBacFlXMitKTnkvU2tuQ0FsSGtKbFozY0VKRnhHeTdtK0lodlJ0aW4x?=
 =?utf-8?B?SFljTmlaNUVvWlBQS3FpaHlYSkVvMWIrWEYyZ2VZK202dWxER081UnRXeXMw?=
 =?utf-8?B?VmYrYmg5YVcwSjhXWUdzQjNNbFp6bysrai9ZRFRFNVE4MHdQcXZlZHh1OWp6?=
 =?utf-8?B?T0VaMXJ1VnRobWZBdWJPQU9oaHI0SlhZWlZzTTd0bzl0dlpmSlFzaUVDRHln?=
 =?utf-8?B?a24zaXpyYU1HVGoxM0J4RU85RkJ4eXF1RHhLTk1LUnhMWEs3V0E4dEd5RHNL?=
 =?utf-8?B?cVVNM1BBTGJQbU85U0dMUmoxWjhMRXFGcEY5WDdvbitQUlVsM1NwaTlBZG4z?=
 =?utf-8?B?YW9YSUszSW1ac3o2d0dRNStFZzgyS09KYSs2MW1rTE1ZMnVOdkdGSHFUSjFH?=
 =?utf-8?B?RnkvUUI0ZThiNGlETEo5Y045MUN0bzI1dUllWWVLMjBYOWRZeXpCNkE3TU1r?=
 =?utf-8?B?QVZwWlVlWUxheE1kdVEzY0tqVXJuSm9JQkRGKzFIanZMN1d3NWlET3Q2cTgy?=
 =?utf-8?B?SE9IRksweWlNdXVhajlTdUkrcDNvZ0ZnKzNyK3ZlcDAzaFN6Wm01TWhuU29J?=
 =?utf-8?B?STYxZW04TUozWXk3UTNSdmVzQTF1eTQwOGNuR24zc2V3QVBIV3lQRndKa2lP?=
 =?utf-8?B?SUNLRDZuek9jYlh5WXVJMGNKYTRVOXRTY2J6K0x0ckR1UUhFc0Z6eE55K2Y5?=
 =?utf-8?B?b0VrNFkrNGNEOFZVYXVxR1d6KzRNN0JJT1E3azQreFQ2UWQwSUFldlloYUdW?=
 =?utf-8?B?THA4cWp3cXlnMGN2UU0vRE5lalpNQWo4eGFtRnE4ZFRDcVdYY0tRbTQ0Qks4?=
 =?utf-8?B?Qi9MQncvQnVRc3Q1aFA3NU1vblNVYi9rOVRRM0kxVThEcUhOeWJ3Q05oYi8z?=
 =?utf-8?B?RSt4RHcvOWhweS9wOEtNOFpRMXRUVVpwaGlaaG9UYXVLN2hVdmlYejlIUTNz?=
 =?utf-8?B?MUtFekZwb0RqNEZKdXR4a1hNaGtkYWFiYnRCSlA2Uk55MlFvMjdqc3dpQTRx?=
 =?utf-8?B?UEFZanNKdHdxcWRzMzI4WnA4UWtpbjJrUklQZzNsSU1wMGswbzh2R3ZWaW96?=
 =?utf-8?B?UWVYTytXM3VFV3J6V1BDb0VaUExFN1dhOUl3MjNwVndwSjlGb2lSbEZGdmFZ?=
 =?utf-8?B?YzVGU2oyRU5sVklOUXN2L2tjQ21WRFFwT2g0ZkNJaDdrWTZZNmpRbnFRZE8x?=
 =?utf-8?B?RDk4NEIxN01VVmxLUUpDVU9oVklRMlhjcnh1M05BRHlveWx6MHVWRkFPa0tm?=
 =?utf-8?B?VWQxTmVUaGJsc0JGdnpZL3FKS2Rpd21UeG9JejllaysyVmdzenlYQmVJdFVL?=
 =?utf-8?B?Uk90UHh1cnp0TVVNMjRSVzU1MEVkTy9rdDd6dGlHVytuSlVvaG8rNStsSjVS?=
 =?utf-8?B?S1dyL1RRM2JFQlVScTUzV2VjbjFSS0I5YUNIaUhWSnRJRWZnL0JXSW9oOGNm?=
 =?utf-8?B?dllmYWN3ZVdNKzMwaDIrWE84LzB4VDloUEFiZVhPY09mY2VDSGV5dEVTZEN4?=
 =?utf-8?Q?e4H352Nnls1gCkpthBBFT4b5vJUw+c4ZLkGYVLGM7nVFq?=
X-MS-Exchange-AntiSpam-MessageData-1: pacovCj4QrNyeQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3f7d41-fc3a-47a6-eca9-08de57f28f08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:07:22.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVTdba/vwXtKhMT8uy666CQW3KmV4DzM/D3Lr7sdmFFVOoOf6Y6Xpz414Ssa65e90/l7IjkXnd4T0hjb7+gBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Introduce driver for the External Memory Controller (EMC) found in
> Tegra114 SoC. It controls the external DRAM on the board. The purpose of
> this driver is to program memory timing for external memory on the EMC
> clock rate change.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig        |   12 +
>  drivers/memory/tegra/Makefile       |    1 +
>  drivers/memory/tegra/tegra114-emc.c | 1463 +++++++++++++++++++++++++++
>  3 files changed, 1476 insertions(+)
>  create mode 100644 drivers/memory/tegra/tegra114-emc.c
>=20
> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
> index fc5a27791826..11e7cc357d39 100644
> --- a/drivers/memory/tegra/Kconfig
> +++ b/drivers/memory/tegra/Kconfig
> @@ -35,6 +35,18 @@ config TEGRA30_EMC
>  	  This driver is required to change memory timings / clock rate for
>  	  external memory.
> =20
> +config TEGRA114_EMC
> +	tristate "NVIDIA Tegra114 External Memory Controller driver"
> +	default y
> +	depends on ARCH_TEGRA_114_SOC || COMPILE_TEST
> +	select TEGRA124_CLK_EMC if ARCH_TEGRA
> +	select PM_OPP
> +	help
> +	  This driver is for the External Memory Controller (EMC) found on
> +	  Tegra114 chips. The EMC controls the external DRAM on the board.
> +	  This driver is required to change memory timings / clock rate for
> +	  external memory.
> +
>  config TEGRA124_EMC
>  	tristate "NVIDIA Tegra124 External Memory Controller driver"
>  	default ARCH_TEGRA_124_SOC
> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefil=
e
> index 6334601e6120..6b9156de4b66 100644
> --- a/drivers/memory/tegra/Makefile
> +++ b/drivers/memory/tegra/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_TEGRA_MC) +=3D tegra-mc.o
> =20
>  obj-$(CONFIG_TEGRA20_EMC)  +=3D tegra20-emc.o
>  obj-$(CONFIG_TEGRA30_EMC)  +=3D tegra30-emc.o
> +obj-$(CONFIG_TEGRA114_EMC) +=3D tegra114-emc.o
>  obj-$(CONFIG_TEGRA124_EMC) +=3D tegra124-emc.o
>  obj-$(CONFIG_TEGRA210_EMC_TABLE) +=3D tegra210-emc-table.o
>  obj-$(CONFIG_TEGRA210_EMC) +=3D tegra210-emc.o
> diff --git a/drivers/memory/tegra/tegra114-emc.c b/drivers/memory/tegra/t=
egra114-emc.c
> new file mode 100644
> index 000000000000..789b8e959a68
> --- /dev/null
> +++ b/drivers/memory/tegra/tegra114-emc.c
> @@ -0,0 +1,1463 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Tegra114 External Memory Controller driver
> + *
> + * Based on downstream driver from NVIDIA and tegra124-emc.c
> + * Copyright (C) 2011-2014 NVIDIA Corporation
> + *
> + * Copyright (C) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/tegra.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/sort.h>
> +#include <linux/string.h>
> +
> +#include <soc/tegra/common.h>
> +#include <soc/tegra/fuse.h>
> +#include <soc/tegra/mc.h>
> +
> +#include "mc.h"
> +
> +#define EMC_INTSTATUS				0x0
> +#define EMC_INTSTATUS_REFRESH_OVERFLOW		BIT(3)
> +#define EMC_INTSTATUS_CLKCHANGE_COMPLETE	BIT(4)
> +
> +#define EMC_INTMASK				0x4
> +
> +#define EMC_DBG					0x8
> +#define EMC_DBG_READ_MUX_ASSEMBLY		BIT(0)
> +#define EMC_DBG_WRITE_MUX_ACTIVE		BIT(1)
> +#define EMC_DBG_FORCE_UPDATE			BIT(2)
> +#define EMC_DBG_CFG_PRIORITY			BIT(24)
> +
> +#define EMC_CFG					0xc
> +#define EMC_CFG_DSR_VTTGEN_DRV_EN		BIT(18)
> +#define EMC_CFG_PWR_MASK			((0xF << 28) | BIT(18))
> +#define EMC_CFG_DYN_SREF			BIT(28)
> +#define EMC_CFG_DRAM_ACPD			BIT(29)
> +#define EMC_CFG_DRAM_CLKSTOP_SR			BIT(30)
> +#define EMC_CFG_DRAM_CLKSTOP_PD			BIT(31)
> +
> +#define EMC_ADR_CFG				0x10
> +#define EMC_ADR_CFG_EMEM_NUMDEV			BIT(0)
> +
> +#define EMC_REFCTRL				0x20
> +#define EMC_REFCTRL_DEV_SEL_SHIFT		0
> +#define EMC_REFCTRL_ENABLE			BIT(31)
> +
> +#define EMC_TIMING_CONTROL			0x28
> +#define EMC_RC					0x2c
> +#define EMC_RFC					0x30
> +#define EMC_RAS					0x34
> +#define EMC_RP					0x38
> +#define EMC_R2W					0x3c
> +#define EMC_W2R					0x40
> +#define EMC_R2P					0x44
> +#define EMC_W2P					0x48
> +#define EMC_RD_RCD				0x4c
> +#define EMC_WR_RCD				0x50
> +#define EMC_RRD					0x54
> +#define EMC_REXT				0x58
> +#define EMC_WDV					0x5c
> +#define EMC_QUSE				0x60
> +#define EMC_QRST				0x64
> +#define EMC_QSAFE				0x68
> +#define EMC_RDV					0x6c
> +#define EMC_REFRESH				0x70
> +#define EMC_BURST_REFRESH_NUM			0x74
> +#define EMC_PDEX2WR				0x78
> +#define EMC_PDEX2RD				0x7c
> +#define EMC_PCHG2PDEN				0x80
> +#define EMC_ACT2PDEN				0x84
> +#define EMC_AR2PDEN				0x88
> +#define EMC_RW2PDEN				0x8c
> +#define EMC_TXSR				0x90
> +#define EMC_TCKE				0x94
> +#define EMC_TFAW				0x98
> +#define EMC_TRPAB				0x9c
> +#define EMC_TCLKSTABLE				0xa0
> +#define EMC_TCLKSTOP				0xa4
> +#define EMC_TREFBW				0xa8
> +#define EMC_QUSE_EXTRA				0xac
> +#define EMC_ODT_WRITE				0xb0
> +#define EMC_ODT_READ				0xb4
> +#define EMC_WEXT				0xb8
> +#define EMC_CTT					0xbc
> +#define EMC_RFC_SLR				0xc0
> +#define EMC_MRS_WAIT_CNT2			0xc4
> +
> +#define EMC_MRS_WAIT_CNT			0xc8
> +#define EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT	0
> +#define EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK	\
> +	(0x3FF << EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT)
> +#define EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT	16
> +#define EMC_MRS_WAIT_CNT_LONG_WAIT_MASK		\
> +	(0x3FF << EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT)
> +
> +#define EMC_MRS					0xcc
> +#define EMC_MODE_SET_DLL_RESET			BIT(8)
> +#define EMC_MODE_SET_LONG_CNT			BIT(26)
> +#define EMC_EMRS				0xd0
> +#define EMC_REF					0xd4
> +#define EMC_PRE					0xd8
> +
> +#define EMC_SELF_REF				0xe0
> +#define EMC_SELF_REF_CMD_ENABLED		BIT(0)
> +#define EMC_SELF_REF_DEV_SEL_SHIFT		30
> +
> +#define EMC_MRW					0xe8
> +
> +#define EMC_MRR					0xec
> +#define EMC_MRR_MA_SHIFT			16
> +#define LPDDR2_MR4_TEMP_SHIFT			0
> +
> +#define EMC_XM2DQSPADCTRL3			0xf8
> +#define EMC_FBIO_SPARE				0x100
> +
> +#define EMC_FBIO_CFG5				0x104
> +#define EMC_FBIO_CFG5_DRAM_TYPE_MASK		0x3
> +#define EMC_FBIO_CFG5_DRAM_TYPE_SHIFT		0
> +
> +#define EMC_FBIO_CFG6				0x114
> +#define EMC_EMRS2				0x12c
> +#define EMC_MRW2				0x134
> +#define EMC_MRW4				0x13c
> +#define EMC_EINPUT				0x14c
> +#define EMC_EINPUT_DURATION			0x150
> +#define EMC_PUTERM_EXTRA			0x154
> +#define EMC_TCKESR				0x158
> +#define EMC_TPD					0x15c
> +
> +#define EMC_AUTO_CAL_CONFIG			0x2a4
> +#define EMC_AUTO_CAL_CONFIG_AUTO_CAL_START	BIT(31)
> +#define EMC_AUTO_CAL_INTERVAL			0x2a8
> +#define EMC_AUTO_CAL_STATUS			0x2ac
> +#define EMC_AUTO_CAL_STATUS_ACTIVE		BIT(31)
> +#define EMC_STATUS				0x2b4
> +#define EMC_STATUS_TIMING_UPDATE_STALLED	BIT(23)
> +
> +#define EMC_CFG_2				0x2b8
> +#define EMC_CFG_2_CLKCHANGE_REQ_ENABLE		BIT(0)
> +#define EMC_CFG_2_CLKCHANGE_PD_ENABLE		BIT(1)
> +#define EMC_CFG_2_CLKCHANGE_SR_ENABLE		BIT(2)
> +
> +#define EMC_CFG_DIG_DLL				0x2bc
> +#define EMC_CFG_DIG_DLL_PERIOD			0x2c0
> +#define EMC_RDV_MASK				0x2cc
> +#define EMC_WDV_MASK				0x2d0
> +#define EMC_CTT_DURATION			0x2d8
> +#define EMC_CTT_TERM_CTRL			0x2dc
> +#define EMC_ZCAL_INTERVAL			0x2e0
> +#define EMC_ZCAL_WAIT_CNT			0x2e4
> +
> +#define EMC_ZQ_CAL				0x2ec
> +#define EMC_ZQ_CAL_CMD				BIT(0)
> +#define EMC_ZQ_CAL_LONG				BIT(4)
> +#define EMC_ZQ_CAL_LONG_CMD_DEV0		\
> +	(DRAM_DEV_SEL_0 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
> +#define EMC_ZQ_CAL_LONG_CMD_DEV1		\
> +	(DRAM_DEV_SEL_1 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
> +
> +#define EMC_XM2CMDPADCTRL			0x2f0
> +#define EMC_XM2DQSPADCTRL			0x2f8
> +#define EMC_XM2DQSPADCTRL2			0x2fc
> +#define EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE	BIT(0)
> +#define EMC_XM2DQSPADCTRL2_VREF_ENABLE		BIT(5)
> +#define EMC_XM2DQPADCTRL			0x300
> +#define EMC_XM2DQPADCTRL2			0x304
> +#define EMC_XM2CLKPADCTRL			0x308
> +#define EMC_XM2COMPPADCTRL			0x30c
> +#define EMC_XM2VTTGENPADCTRL			0x310
> +#define EMC_XM2VTTGENPADCTRL2			0x314
> +#define EMC_XM2QUSEPADCTRL			0x318
> +#define EMC_XM2DQSPADCTRL4			0x320
> +#define EMC_DLL_XFORM_DQS0			0x328
> +#define EMC_DLL_XFORM_DQS1			0x32c
> +#define EMC_DLL_XFORM_DQS2			0x330
> +#define EMC_DLL_XFORM_DQS3			0x334
> +#define EMC_DLL_XFORM_DQS4			0x338
> +#define EMC_DLL_XFORM_DQS5			0x33c
> +#define EMC_DLL_XFORM_DQS6			0x340
> +#define EMC_DLL_XFORM_DQS7			0x344
> +#define EMC_DLL_XFORM_QUSE0			0x348
> +#define EMC_DLL_XFORM_QUSE1			0x34c
> +#define EMC_DLL_XFORM_QUSE2			0x350
> +#define EMC_DLL_XFORM_QUSE3			0x354
> +#define EMC_DLL_XFORM_QUSE4			0x358
> +#define EMC_DLL_XFORM_QUSE5			0x35c
> +#define EMC_DLL_XFORM_QUSE6			0x360
> +#define EMC_DLL_XFORM_QUSE7			0x364
> +#define EMC_DLL_XFORM_DQ0			0x368
> +#define EMC_DLL_XFORM_DQ1			0x36c
> +#define EMC_DLL_XFORM_DQ2			0x370
> +#define EMC_DLL_XFORM_DQ3			0x374
> +#define EMC_DLI_TRIM_TXDQS0			0x3a8
> +#define EMC_DLI_TRIM_TXDQS1			0x3ac
> +#define EMC_DLI_TRIM_TXDQS2			0x3b0
> +#define EMC_DLI_TRIM_TXDQS3			0x3b4
> +#define EMC_DLI_TRIM_TXDQS4			0x3b8
> +#define EMC_DLI_TRIM_TXDQS5			0x3bc
> +#define EMC_DLI_TRIM_TXDQS6			0x3c0
> +#define EMC_DLI_TRIM_TXDQS7			0x3c4
> +#define EMC_STALL_THEN_EXE_AFTER_CLKCHANGE	0x3cc
> +#define EMC_SEL_DPD_CTRL			0x3d8
> +#define EMC_SEL_DPD_CTRL_DATA_SEL_DPD		BIT(8)
> +#define EMC_SEL_DPD_CTRL_ODT_SEL_DPD		BIT(5)
> +#define EMC_SEL_DPD_CTRL_RESET_SEL_DPD		BIT(4)
> +#define EMC_SEL_DPD_CTRL_CA_SEL_DPD		BIT(3)
> +#define EMC_SEL_DPD_CTRL_CLK_SEL_DPD		BIT(2)
> +#define EMC_SEL_DPD_CTRL_DDR3_MASK	\
> +	((0xf << 2) | BIT(8))
> +#define EMC_SEL_DPD_CTRL_MASK \
> +	((0x3 << 2) | BIT(5) | BIT(8))
> +#define EMC_PRE_REFRESH_REQ_CNT			0x3dc
> +#define EMC_DYN_SELF_REF_CONTROL		0x3e0
> +#define EMC_TXSRDLL				0x3e4
> +#define EMC_CCFIFO_ADDR				0x3e8
> +#define EMC_CCFIFO_DATA				0x3ec
> +#define EMC_CCFIFO_STATUS			0x3f0
> +#define EMC_CDB_CNTL_1				0x3f4
> +#define EMC_CDB_CNTL_2				0x3f8
> +#define EMC_XM2CLKPADCTRL2			0x3fc
> +#define EMC_AUTO_CAL_CONFIG2			0x458
> +#define EMC_AUTO_CAL_CONFIG3			0x45c
> +#define EMC_IBDLY				0x468
> +#define EMC_DLL_XFORM_ADDR0			0x46c
> +#define EMC_DLL_XFORM_ADDR1			0x470
> +#define EMC_DLL_XFORM_ADDR2			0x474
> +#define EMC_DSR_VTTGEN_DRV			0x47c
> +#define EMC_TXDSRVTTGEN				0x480
> +#define EMC_XM2CMDPADCTRL4			0x484
> +
> +#define DRAM_DEV_SEL_ALL			0
> +#define DRAM_DEV_SEL_0				BIT(31)
> +#define DRAM_DEV_SEL_1				BIT(30)
> +
> +#define EMC_CFG_POWER_FEATURES_MASK		\
> +	(EMC_CFG_DYN_SREF | EMC_CFG_DRAM_ACPD | EMC_CFG_DRAM_CLKSTOP_SR | \
> +	EMC_CFG_DRAM_CLKSTOP_PD | EMC_CFG_DSR_VTTGEN_DRV_EN)
> +#define EMC_REFCTRL_DEV_SEL(n) ((((n) > 1) ? 0 : 2) << EMC_REFCTRL_DEV_S=
EL_SHIFT)
> +#define EMC_DRAM_DEV_SEL(n) (((n) > 1) ? DRAM_DEV_SEL_ALL : DRAM_DEV_SEL=
_0)
> +
> +/* Maximum amount of time in us. to wait for changes to become effective=
 */
> +#define EMC_STATUS_UPDATE_TIMEOUT		1000
> +
> +enum emc_dram_type {
> +	DRAM_TYPE_DDR3,
> +	DRAM_TYPE_DDR1,
> +	DRAM_TYPE_LPDDR2,
> +	DRAM_TYPE_DDR2
> +};
> +
> +enum emc_dll_change {
> +	DLL_CHANGE_NONE,
> +	DLL_CHANGE_ON,
> +	DLL_CHANGE_OFF
> +};
> +
> +static const unsigned long emc_burst_regs[] =3D {
> +	EMC_RC,
> +	EMC_RFC,
> +	EMC_RAS,
> +	EMC_RP,
> +	EMC_R2W,
> +	EMC_W2R,
> +	EMC_R2P,
> +	EMC_W2P,
> +	EMC_RD_RCD,
> +	EMC_WR_RCD,
> +	EMC_RRD,
> +	EMC_REXT,
> +	EMC_WEXT,
> +	EMC_WDV,
> +	EMC_WDV_MASK,
> +	EMC_QUSE,
> +	EMC_IBDLY,
> +	EMC_EINPUT,
> +	EMC_EINPUT_DURATION,
> +	EMC_PUTERM_EXTRA,
> +	EMC_CDB_CNTL_1,
> +	EMC_CDB_CNTL_2,
> +	EMC_QRST,
> +	EMC_QSAFE,
> +	EMC_RDV,
> +	EMC_RDV_MASK,
> +	EMC_REFRESH,
> +	EMC_BURST_REFRESH_NUM,
> +	EMC_PRE_REFRESH_REQ_CNT,
> +	EMC_PDEX2WR,
> +	EMC_PDEX2RD,
> +	EMC_PCHG2PDEN,
> +	EMC_ACT2PDEN,
> +	EMC_AR2PDEN,
> +	EMC_RW2PDEN,
> +	EMC_TXSR,
> +	EMC_TXSRDLL,
> +	EMC_TCKE,
> +	EMC_TCKESR,
> +	EMC_TPD,
> +	EMC_TFAW,
> +	EMC_TRPAB,
> +	EMC_TCLKSTABLE,
> +	EMC_TCLKSTOP,
> +	EMC_TREFBW,
> +	EMC_QUSE_EXTRA,
> +	EMC_FBIO_CFG6,
> +	EMC_ODT_WRITE,
> +	EMC_ODT_READ,
> +	EMC_FBIO_CFG5,
> +	EMC_CFG_DIG_DLL,
> +	EMC_CFG_DIG_DLL_PERIOD,
> +	EMC_DLL_XFORM_DQS0,
> +	EMC_DLL_XFORM_DQS1,
> +	EMC_DLL_XFORM_DQS2,
> +	EMC_DLL_XFORM_DQS3,
> +	EMC_DLL_XFORM_DQS4,
> +	EMC_DLL_XFORM_DQS5,
> +	EMC_DLL_XFORM_DQS6,
> +	EMC_DLL_XFORM_DQS7,
> +	EMC_DLL_XFORM_QUSE0,
> +	EMC_DLL_XFORM_QUSE1,
> +	EMC_DLL_XFORM_QUSE2,
> +	EMC_DLL_XFORM_QUSE3,
> +	EMC_DLL_XFORM_QUSE4,
> +	EMC_DLL_XFORM_QUSE5,
> +	EMC_DLL_XFORM_QUSE6,
> +	EMC_DLL_XFORM_QUSE7,
> +	EMC_DLI_TRIM_TXDQS0,
> +	EMC_DLI_TRIM_TXDQS1,
> +	EMC_DLI_TRIM_TXDQS2,
> +	EMC_DLI_TRIM_TXDQS3,
> +	EMC_DLI_TRIM_TXDQS4,
> +	EMC_DLI_TRIM_TXDQS5,
> +	EMC_DLI_TRIM_TXDQS6,
> +	EMC_DLI_TRIM_TXDQS7,
> +	EMC_DLL_XFORM_DQ0,
> +	EMC_DLL_XFORM_DQ1,
> +	EMC_DLL_XFORM_DQ2,
> +	EMC_DLL_XFORM_DQ3,
> +	EMC_XM2CMDPADCTRL,
> +	EMC_XM2CMDPADCTRL4,
> +	EMC_XM2DQPADCTRL2,
> +	EMC_XM2CLKPADCTRL,
> +	EMC_XM2COMPPADCTRL,
> +	EMC_XM2VTTGENPADCTRL,
> +	EMC_XM2VTTGENPADCTRL2,
> +	EMC_XM2DQSPADCTRL3,
> +	EMC_XM2DQSPADCTRL4,
> +	EMC_DSR_VTTGEN_DRV,
> +	EMC_TXDSRVTTGEN,
> +	EMC_FBIO_SPARE,
> +	EMC_ZCAL_WAIT_CNT,
> +	EMC_MRS_WAIT_CNT2,
> +	EMC_CTT,
> +	EMC_CTT_DURATION,
> +	EMC_DYN_SELF_REF_CONTROL,
> +};
> +
> +struct emc_timing {
> +	unsigned long rate;
> +
> +	u32 emc_burst_data[ARRAY_SIZE(emc_burst_regs)];
> +
> +	u32 emc_auto_cal_config;
> +	u32 emc_auto_cal_config2;
> +	u32 emc_auto_cal_config3;
> +	u32 emc_auto_cal_interval;
> +	u32 emc_cfg;
> +	u32 emc_ctt_term_ctrl;
> +	u32 emc_mode_1;
> +	u32 emc_mode_2;
> +	u32 emc_mode_4;
> +	u32 emc_mode_reset;
> +	u32 emc_mrs_wait_cnt;
> +	u32 emc_sel_dpd_ctrl;
> +	u32 emc_xm2dqspadctrl2;
> +	u32 emc_zcal_cnt_long;
> +	u32 emc_zcal_interval;
> +};
> +
> +enum emc_rate_request_type {
> +	EMC_RATE_DEBUG,
> +	EMC_RATE_ICC,
> +	EMC_RATE_TYPE_MAX,
> +};
> +
> +struct emc_rate_request {
> +	unsigned long min_rate;
> +	unsigned long max_rate;
> +};
> +
> +struct tegra_emc {
> +	struct device *dev;
> +	struct tegra_mc *mc;
> +	void __iomem *regs;
> +	unsigned int irq;
> +	struct clk *clk;
> +
> +	enum emc_dram_type dram_type;
> +	unsigned int dram_num;
> +
> +	struct emc_timing last_timing;
> +	struct emc_timing *timings;
> +	unsigned int num_timings;
> +
> +	struct {
> +		struct dentry *root;
> +		unsigned long min_rate;
> +		unsigned long max_rate;
> +	} debugfs;
> +
> +	struct icc_provider provider;
> +
> +	/*
> +	 * There are multiple sources in the EMC driver which could request
> +	 * a min/max clock rate, these rates are contained in this array.
> +	 */
> +	struct emc_rate_request requested_rate[EMC_RATE_TYPE_MAX];
> +
> +	/* protect shared rate-change code path */
> +	struct mutex rate_lock;
> +};
> +
> +static irqreturn_t tegra_emc_isr(int irq, void *data)
> +{
> +	struct tegra_emc *emc =3D data;
> +	u32 intmask =3D EMC_INTSTATUS_REFRESH_OVERFLOW;
> +	u32 status;
> +
> +	status =3D readl_relaxed(emc->regs + EMC_INTSTATUS) & intmask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	/* notify about HW problem */
> +	if (status & EMC_INTSTATUS_REFRESH_OVERFLOW)
> +		dev_err_ratelimited(emc->dev,
> +				    "refresh request overflow timeout\n");
> +
> +	/* clear interrupts */
> +	writel_relaxed(status, emc->regs + EMC_INTSTATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Timing change sequence functions */
> +
> +static void emc_ccfifo_writel(struct tegra_emc *emc, u32 value,
> +			      unsigned long offset)
> +{
> +	writel(value, emc->regs + EMC_CCFIFO_DATA);
> +	writel(offset, emc->regs + EMC_CCFIFO_ADDR);
> +}
> +
> +static void emc_seq_update_timing(struct tegra_emc *emc)
> +{
> +	int ret;
> +	u32 value;
> +
> +	writel(1, emc->regs + EMC_TIMING_CONTROL);
> +
> +	ret =3D readl_poll_timeout_atomic(emc->regs + EMC_STATUS, value,
> +					!(value & EMC_STATUS_TIMING_UPDATE_STALLED),
> +					1, EMC_STATUS_UPDATE_TIMEOUT);
> +	if (ret)
> +		dev_err(emc->dev, "timing update timed out\n");
> +}
> +
> +static void emc_seq_disable_auto_cal(struct tegra_emc *emc)
> +{
> +	int ret;
> +	u32 value;
> +
> +	writel(0, emc->regs + EMC_AUTO_CAL_INTERVAL);
> +
> +	ret =3D readl_poll_timeout_atomic(emc->regs + EMC_AUTO_CAL_STATUS, valu=
e,
> +					!(value & EMC_AUTO_CAL_STATUS_ACTIVE),
> +					1, EMC_STATUS_UPDATE_TIMEOUT);
> +	if (ret)
> +		dev_err(emc->dev, "auto cal disable timed out\n");
> +}
> +
> +static void emc_seq_wait_clkchange(struct tegra_emc *emc)
> +{
> +	int ret;
> +	u32 value;
> +
> +	ret =3D readl_poll_timeout_atomic(emc->regs + EMC_INTSTATUS, value,
> +					value & EMC_INTSTATUS_CLKCHANGE_COMPLETE,
> +					1, EMC_STATUS_UPDATE_TIMEOUT);
> +	if (ret)
> +		dev_err(emc->dev, "clock change timed out\n");
> +}
> +
> +static struct emc_timing *tegra_emc_find_timing(struct tegra_emc *emc,
> +						unsigned long rate)
> +{
> +	struct emc_timing *timing =3D NULL;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < emc->num_timings; i++) {
> +		if (emc->timings[i].rate =3D=3D rate) {
> +			timing =3D &emc->timings[i];
> +			break;
> +		}
> +	}
> +
> +	if (!timing) {
> +		dev_err(emc->dev, "no timing for rate %lu\n", rate);
> +		return NULL;
> +	}
> +
> +	return timing;
> +}
> +
> +static int tegra_emc_prepare_timing_change(struct tegra_emc *emc,
> +					   unsigned long rate)
> +{
> +	struct emc_timing *timing =3D tegra_emc_find_timing(emc, rate);
> +	struct emc_timing *last =3D &emc->last_timing;
> +	enum emc_dll_change dll_change;
> +	unsigned int pre_wait =3D 0;
> +	u32 val, mask;
> +	bool next_dll_enabled =3D !(timing->emc_mode_1 & 0x1);
> +	bool last_dll_enabled =3D !(last->emc_mode_1 & 0x1);
> +	bool update =3D false;
> +	unsigned int i;
> +
> +	if (!timing)
> +		return -ENOENT;
> +
> +	if (next_dll_enabled =3D=3D last_dll_enabled)
> +		dll_change =3D DLL_CHANGE_NONE;
> +	else if (next_dll_enabled)
> +		dll_change =3D DLL_CHANGE_ON;
> +	else
> +		dll_change =3D DLL_CHANGE_OFF;
> +
> +	/* Clear CLKCHANGE_COMPLETE interrupts */
> +	writel(EMC_INTSTATUS_CLKCHANGE_COMPLETE, emc->regs + EMC_INTSTATUS);
> +
> +	/* Disable dynamic self-refresh */
> +	val =3D readl(emc->regs + EMC_CFG);
> +	if (val & EMC_CFG_PWR_MASK) {
> +		val &=3D ~EMC_CFG_POWER_FEATURES_MASK;
> +		writel(val, emc->regs + EMC_CFG);
> +
> +		pre_wait =3D 5;
> +	}
> +
> +	/* Disable SEL_DPD_CTRL for clock change */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> +		mask =3D EMC_SEL_DPD_CTRL_DDR3_MASK;
> +	else
> +		mask =3D EMC_SEL_DPD_CTRL_MASK;
> +
> +	val =3D readl(emc->regs + EMC_SEL_DPD_CTRL);
> +	if (val & mask) {
> +		val &=3D ~mask;
> +		writel(val, emc->regs + EMC_SEL_DPD_CTRL);
> +	}
> +
> +	/* Prepare DQ/DQS for clock change */
> +	val =3D readl(emc->regs + EMC_XM2DQSPADCTRL2);
> +	if (timing->emc_xm2dqspadctrl2 & EMC_XM2DQSPADCTRL2_VREF_ENABLE &&
> +	    !(val & EMC_XM2DQSPADCTRL2_VREF_ENABLE)) {
> +		val |=3D EMC_XM2DQSPADCTRL2_VREF_ENABLE;
> +		update =3D true;
> +	}
> +
> +	if (timing->emc_xm2dqspadctrl2 & EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE &&
> +	    !(val & EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE)) {
> +		val |=3D EMC_XM2DQSPADCTRL2_RX_FT_REC_ENABLE;
> +		update =3D true;
> +	}
> +
> +	if (update) {
> +		writel(val, emc->regs + EMC_XM2DQSPADCTRL2);
> +		if (pre_wait < 30)
> +			pre_wait =3D 30;
> +	}
> +
> +	/* Wait to settle */
> +	if (pre_wait) {
> +		emc_seq_update_timing(emc);
> +		udelay(pre_wait);
> +	}
> +
> +	/* Program CTT_TERM control */
> +	if (last->emc_ctt_term_ctrl !=3D timing->emc_ctt_term_ctrl) {
> +		emc_seq_disable_auto_cal(emc);
> +		writel(timing->emc_ctt_term_ctrl,
> +		       emc->regs + EMC_CTT_TERM_CTRL);
> +		emc_seq_update_timing(emc);
> +	}
> +
> +	/* Program burst shadow registers */
> +	for (i =3D 0; i < ARRAY_SIZE(timing->emc_burst_data); ++i)
> +		writel(timing->emc_burst_data[i],
> +		       emc->regs + emc_burst_regs[i]);
> +
> +	writel(timing->emc_xm2dqspadctrl2, emc->regs + EMC_XM2DQSPADCTRL2);
> +	writel(timing->emc_zcal_interval, emc->regs + EMC_ZCAL_INTERVAL);
> +
> +	tegra_mc_write_emem_configuration(emc->mc, timing->rate);
> +
> +	val =3D timing->emc_cfg & ~EMC_CFG_POWER_FEATURES_MASK;
> +	emc_ccfifo_writel(emc, val, EMC_CFG);
> +
> +	/* Program AUTO_CAL_CONFIG */
> +	if (timing->emc_auto_cal_config2 !=3D last->emc_auto_cal_config2)
> +		emc_ccfifo_writel(emc, timing->emc_auto_cal_config2,
> +				  EMC_AUTO_CAL_CONFIG2);
> +
> +	if (timing->emc_auto_cal_config3 !=3D last->emc_auto_cal_config3)
> +		emc_ccfifo_writel(emc, timing->emc_auto_cal_config3,
> +				  EMC_AUTO_CAL_CONFIG3);
> +
> +	if (timing->emc_auto_cal_config !=3D last->emc_auto_cal_config) {
> +		val =3D timing->emc_auto_cal_config;
> +		val &=3D EMC_AUTO_CAL_CONFIG_AUTO_CAL_START;
> +		emc_ccfifo_writel(emc, val, EMC_AUTO_CAL_CONFIG);
> +	}
> +
> +	/* DDR3: predict MRS long wait count */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3 &&
> +	    dll_change =3D=3D DLL_CHANGE_ON) {
> +		u32 cnt =3D 512;
> +
> +		if (timing->emc_zcal_interval !=3D 0 &&
> +		    last->emc_zcal_interval =3D=3D 0)
> +			cnt -=3D emc->dram_num * 256;
> +
> +		val =3D (timing->emc_mrs_wait_cnt
> +			& EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK)
> +			>> EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT;
> +		if (cnt < val)
> +			cnt =3D val;
> +
> +		val =3D timing->emc_mrs_wait_cnt
> +			& ~EMC_MRS_WAIT_CNT_LONG_WAIT_MASK;
> +		val |=3D (cnt << EMC_MRS_WAIT_CNT_LONG_WAIT_SHIFT)
> +			& EMC_MRS_WAIT_CNT_LONG_WAIT_MASK;
> +
> +		writel(val, emc->regs + EMC_MRS_WAIT_CNT);
> +	}
> +
> +	/* DDR3: Turn off DLL and enter self-refresh */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3 && dll_change =3D=3D DLL_CHANG=
E_OFF)
> +		emc_ccfifo_writel(emc, timing->emc_mode_1, EMC_EMRS);
> +
> +	/* Disable refresh controller */
> +	emc_ccfifo_writel(emc, EMC_REFCTRL_DEV_SEL(emc->dram_num),
> +			  EMC_REFCTRL);
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> +		emc_ccfifo_writel(emc, EMC_DRAM_DEV_SEL(emc->dram_num) |
> +				       EMC_SELF_REF_CMD_ENABLED,
> +				  EMC_SELF_REF);
> +
> +	/* Flow control marker */
> +	emc_ccfifo_writel(emc, 1, EMC_STALL_THEN_EXE_AFTER_CLKCHANGE);
> +
> +	/* DDR3: Exit self-refresh */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3)
> +		emc_ccfifo_writel(emc, EMC_DRAM_DEV_SEL(emc->dram_num),
> +				  EMC_SELF_REF);
> +	emc_ccfifo_writel(emc, EMC_REFCTRL_DEV_SEL(emc->dram_num) |
> +			       EMC_REFCTRL_ENABLE,
> +			  EMC_REFCTRL);
> +
> +	/* Set DRAM mode registers */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_DDR3) {
> +		if (timing->emc_mode_1 !=3D last->emc_mode_1)
> +			emc_ccfifo_writel(emc, timing->emc_mode_1, EMC_EMRS);
> +		if (timing->emc_mode_2 !=3D last->emc_mode_2)
> +			emc_ccfifo_writel(emc, timing->emc_mode_2, EMC_EMRS2);
> +
> +		if (timing->emc_mode_reset !=3D last->emc_mode_reset ||
> +		    dll_change =3D=3D DLL_CHANGE_ON) {
> +			val =3D timing->emc_mode_reset;
> +			if (dll_change =3D=3D DLL_CHANGE_ON) {
> +				val |=3D EMC_MODE_SET_DLL_RESET;
> +				val |=3D EMC_MODE_SET_LONG_CNT;
> +			} else {
> +				val &=3D ~EMC_MODE_SET_DLL_RESET;
> +			}
> +			emc_ccfifo_writel(emc, val, EMC_MRS);
> +		}
> +	} else {
> +		if (timing->emc_mode_2 !=3D last->emc_mode_2)
> +			emc_ccfifo_writel(emc, timing->emc_mode_2, EMC_MRW2);
> +		if (timing->emc_mode_1 !=3D last->emc_mode_1)
> +			emc_ccfifo_writel(emc, timing->emc_mode_1, EMC_MRW);
> +		if (timing->emc_mode_4 !=3D last->emc_mode_4)
> +			emc_ccfifo_writel(emc, timing->emc_mode_4, EMC_MRW4);
> +	}
> +
> +	/*  Issue ZCAL command if turning ZCAL on */
> +	if (timing->emc_zcal_interval !=3D 0 && last->emc_zcal_interval =3D=3D =
0) {
> +		emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_DEV0, EMC_ZQ_CAL);
> +		if (emc->dram_num > 1)
> +			emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_DEV1,
> +					  EMC_ZQ_CAL);
> +	}
> +
> +	/*  Write to RO register to remove stall after change */
> +	emc_ccfifo_writel(emc, 0, EMC_CCFIFO_STATUS);
> +
> +	/* Disable AUTO_CAL for clock change */
> +	emc_seq_disable_auto_cal(emc);
> +
> +	/* Read register to wait until programming has settled */
> +	mc_readl(emc->mc, MC_EMEM_ADR_CFG);
> +
> +	return 0;
> +}
> +
> +static void tegra_emc_complete_timing_change(struct tegra_emc *emc,
> +					     unsigned long rate)
> +{
> +	struct emc_timing *timing =3D tegra_emc_find_timing(emc, rate);
> +	struct emc_timing *last =3D &emc->last_timing;
> +
> +	if (!timing)
> +		return;
> +
> +	/* Wait until the state machine has settled */
> +	emc_seq_wait_clkchange(emc);
> +
> +	/* Restore AUTO_CAL */
> +	if (timing->emc_ctt_term_ctrl !=3D last->emc_ctt_term_ctrl)
> +		writel(timing->emc_auto_cal_interval,
> +		       emc->regs + EMC_AUTO_CAL_INTERVAL);
> +
> +	/* Restore dynamic self-refresh */
> +	if (timing->emc_cfg & EMC_CFG_PWR_MASK)
> +		writel(timing->emc_cfg, emc->regs + EMC_CFG);
> +
> +	/* Set ZCAL wait count */
> +	writel(timing->emc_zcal_cnt_long, emc->regs + EMC_ZCAL_WAIT_CNT);
> +
> +	/* Wait for timing to settle */
> +	udelay(2);
> +
> +	/* Reprogram SEL_DPD_CTRL */
> +	writel(timing->emc_sel_dpd_ctrl, emc->regs + EMC_SEL_DPD_CTRL);
> +	emc_seq_update_timing(emc);
> +
> +	emc->last_timing =3D *timing;
> +}
> +
> +/* Initialization and deinitialization */
> +
> +static void emc_read_current_timing(struct tegra_emc *emc,
> +				    struct emc_timing *timing)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(emc_burst_regs); ++i)
> +		timing->emc_burst_data[i] =3D
> +			readl(emc->regs + emc_burst_regs[i]);
> +
> +	timing->emc_cfg =3D readl(emc->regs + EMC_CFG);
> +
> +	timing->emc_auto_cal_interval =3D 0;
> +	timing->emc_zcal_cnt_long =3D 0;
> +	timing->emc_mode_1 =3D 0;
> +	timing->emc_mode_2 =3D 0;
> +	timing->emc_mode_4 =3D 0;
> +	timing->emc_mode_reset =3D 0;
> +}
> +
> +static int emc_init(struct tegra_emc *emc)
> +{
> +	u32 emc_cfg, emc_dbg;
> +	u32 intmask =3D EMC_INTSTATUS_REFRESH_OVERFLOW;
> +	const char *dram_type_str;
> +
> +	emc->dram_type =3D readl(emc->regs + EMC_FBIO_CFG5);
> +
> +	emc->dram_type &=3D EMC_FBIO_CFG5_DRAM_TYPE_MASK;
> +	emc->dram_type >>=3D EMC_FBIO_CFG5_DRAM_TYPE_SHIFT;
> +
> +	emc->dram_num =3D tegra_mc_get_emem_device_count(emc->mc);
> +
> +	emc_cfg =3D readl_relaxed(emc->regs + EMC_CFG_2);
> +
> +	/* enable EMC and CAR to handshake on PLL divider/source changes */
> +	emc_cfg |=3D EMC_CFG_2_CLKCHANGE_REQ_ENABLE;
> +
> +	/* configure clock change mode accordingly to DRAM type */
> +	if (emc->dram_type =3D=3D DRAM_TYPE_LPDDR2)
> +		emc_cfg |=3D EMC_CFG_2_CLKCHANGE_PD_ENABLE;
> +	else
> +		emc_cfg &=3D ~EMC_CFG_2_CLKCHANGE_PD_ENABLE;
> +
> +	writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
> +
> +	/* initialize interrupt */
> +	writel_relaxed(intmask, emc->regs + EMC_INTMASK);
> +	writel_relaxed(0xffffffff, emc->regs + EMC_INTSTATUS);
> +
> +	/* ensure that unwanted debug features are disabled */
> +	emc_dbg =3D readl_relaxed(emc->regs + EMC_DBG);
> +	emc_dbg |=3D EMC_DBG_CFG_PRIORITY;
> +	emc_dbg &=3D ~EMC_DBG_READ_MUX_ASSEMBLY;
> +	emc_dbg &=3D ~EMC_DBG_WRITE_MUX_ACTIVE;
> +	emc_dbg &=3D ~EMC_DBG_FORCE_UPDATE;
> +	writel_relaxed(emc_dbg, emc->regs + EMC_DBG);
> +
> +	switch (emc->dram_type) {
> +	case DRAM_TYPE_DDR1:
> +		dram_type_str =3D "DDR1";
> +		break;
> +	case DRAM_TYPE_LPDDR2:
> +		dram_type_str =3D "LPDDR2";
> +		break;
> +	case DRAM_TYPE_DDR2:
> +		dram_type_str =3D "DDR2";
> +		break;
> +	case DRAM_TYPE_DDR3:
> +		dram_type_str =3D "DDR3";
> +		break;
> +	}
> +
> +	dev_info_once(emc->dev, "%u %s %s attached\n", emc->dram_num,
> +		      dram_type_str, emc->dram_num =3D=3D 2 ? "devices" : "device");
> +
> +	emc_read_current_timing(emc, &emc->last_timing);
> +
> +	return 0;
> +}
> +
> +static int load_one_timing_from_dt(struct tegra_emc *emc,
> +				   struct emc_timing *timing,
> +				   struct device_node *node)
> +{
> +	u32 value;
> +	int err;
> +
> +	err =3D of_property_read_u32(node, "clock-frequency", &value);
> +	if (err) {
> +		dev_err(emc->dev, "timing %pOFn: failed to read rate: %d\n",
> +			node, err);
> +		return err;
> +	}
> +
> +	timing->rate =3D value;
> +
> +	err =3D of_property_read_u32_array(node, "nvidia,emc-configuration",
> +					 timing->emc_burst_data,
> +					 ARRAY_SIZE(timing->emc_burst_data));
> +	if (err) {
> +		dev_err(emc->dev,
> +			"timing %pOFn: failed to read emc burst data: %d\n",
> +			node, err);
> +		return err;
> +	}
> +
> +#define EMC_READ_PROP(prop, dtprop) { \
> +	err =3D of_property_read_u32(node, dtprop, &timing->prop); \
> +	if (err) { \
> +		dev_err(emc->dev, "timing %pOFn: failed to read " #prop ": %d\n", \
> +			node, err); \
> +		return err; \
> +	} \
> +}
> +
> +	EMC_READ_PROP(emc_auto_cal_config, "nvidia,emc-auto-cal-config")
> +	EMC_READ_PROP(emc_auto_cal_config2, "nvidia,emc-auto-cal-config2")
> +	EMC_READ_PROP(emc_auto_cal_config3, "nvidia,emc-auto-cal-config3")
> +	EMC_READ_PROP(emc_auto_cal_interval, "nvidia,emc-auto-cal-interval")
> +	EMC_READ_PROP(emc_cfg, "nvidia,emc-cfg")
> +	EMC_READ_PROP(emc_ctt_term_ctrl, "nvidia,emc-ctt-term-ctrl")
> +	EMC_READ_PROP(emc_mode_1, "nvidia,emc-mode-1")
> +	EMC_READ_PROP(emc_mode_2, "nvidia,emc-mode-2")
> +	EMC_READ_PROP(emc_mode_4, "nvidia,emc-mode-4")
> +	EMC_READ_PROP(emc_mode_reset, "nvidia,emc-mode-reset")
> +	EMC_READ_PROP(emc_mrs_wait_cnt, "nvidia,emc-mrs-wait-cnt")
> +	EMC_READ_PROP(emc_sel_dpd_ctrl, "nvidia,emc-sel-dpd-ctrl")
> +	EMC_READ_PROP(emc_xm2dqspadctrl2, "nvidia,emc-xm2dqspadctrl2")
> +	EMC_READ_PROP(emc_zcal_cnt_long, "nvidia,emc-zcal-cnt-long")
> +	EMC_READ_PROP(emc_zcal_interval, "nvidia,emc-zcal-interval")
> +
> +#undef EMC_READ_PROP
> +
> +	return 0;
> +}
> +
> +static int cmp_timings(const void *_a, const void *_b)
> +{
> +	const struct emc_timing *a =3D _a;
> +	const struct emc_timing *b =3D _b;
> +
> +	if (a->rate < b->rate)
> +		return -1;
> +	else if (a->rate =3D=3D b->rate)
> +		return 0;
> +	else
> +		return 1;
> +}
> +
> +static int emc_check_mc_timings(struct tegra_emc *emc)
> +{
> +	struct tegra_mc *mc =3D emc->mc;
> +	unsigned int i;
> +
> +	if (emc->num_timings !=3D mc->num_timings) {
> +		dev_err(emc->dev, "emc/mc timings number mismatch: %u %u\n",
> +			emc->num_timings, mc->num_timings);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < mc->num_timings; i++) {
> +		if (emc->timings[i].rate !=3D mc->timings[i].rate) {
> +			dev_err(emc->dev,
> +				"emc/mc timing rate mismatch: %lu %lu\n",
> +				emc->timings[i].rate, mc->timings[i].rate);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
> +					  struct device_node *node)
> +{
> +	int child_count =3D of_get_child_count(node);
> +	struct emc_timing *timing;
> +	unsigned int i =3D 0;
> +	int err;
> +
> +	emc->timings =3D devm_kcalloc(emc->dev, child_count, sizeof(*timing),
> +				    GFP_KERNEL);
> +	if (!emc->timings)
> +		return -ENOMEM;
> +
> +	emc->num_timings =3D child_count;
> +
> +	for_each_child_of_node_scoped(node, child) {
> +		timing =3D &emc->timings[i++];
> +
> +		err =3D load_one_timing_from_dt(emc, timing, child);
> +		if (err)
> +			return err;
> +	}
> +
> +	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
> +	     NULL);
> +
> +	err =3D emc_check_mc_timings(emc);
> +	if (err)
> +		return err;
> +
> +	dev_info_once(emc->dev,
> +		      "got %u timings for RAM code %u (min %luMHz max %luMHz)\n",
> +		      emc->num_timings,
> +		      tegra_read_ram_code(),
> +		      emc->timings[0].rate / 1000000,
> +		      emc->timings[emc->num_timings - 1].rate / 1000000);
> +
> +	return 0;
> +}
> +
> +static struct device_node *
> +tegra_emc_find_node_by_ram_code(struct device_node *node, u32 ram_code)
> +{
> +	struct device_node *np;
> +	int err;
> +
> +	for_each_child_of_node(node, np) {
> +		u32 value;
> +
> +		err =3D of_property_read_u32(np, "nvidia,ram-code", &value);
> +		if (err || value !=3D ram_code)
> +			continue;
> +
> +		return np;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void tegra_emc_rate_requests_init(struct tegra_emc *emc)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < EMC_RATE_TYPE_MAX; i++) {
> +		emc->requested_rate[i].min_rate =3D 0;
> +		emc->requested_rate[i].max_rate =3D ULONG_MAX;
> +	}
> +}
> +
> +static int emc_request_rate(struct tegra_emc *emc,
> +			    unsigned long new_min_rate,
> +			    unsigned long new_max_rate,
> +			    enum emc_rate_request_type type)
> +{
> +	struct emc_rate_request *req =3D emc->requested_rate;
> +	unsigned long min_rate =3D 0, max_rate =3D ULONG_MAX;
> +	unsigned int i;
> +	int err;
> +
> +	/* select minimum and maximum rates among the requested rates */
> +	for (i =3D 0; i < EMC_RATE_TYPE_MAX; i++, req++) {
> +		if (i =3D=3D type) {
> +			min_rate =3D max(new_min_rate, min_rate);
> +			max_rate =3D min(new_max_rate, max_rate);
> +		} else {
> +			min_rate =3D max(req->min_rate, min_rate);
> +			max_rate =3D min(req->max_rate, max_rate);
> +		}
> +	}
> +
> +	if (min_rate > max_rate) {
> +		dev_err_ratelimited(emc->dev, "%s: type %u: out of range: %lu %lu\n",
> +				    __func__, type, min_rate, max_rate);
> +		return -ERANGE;
> +	}
> +
> +	/*
> +	 * EMC rate-changes should go via OPP API because it manages voltage
> +	 * changes.
> +	 */
> +	err =3D dev_pm_opp_set_rate(emc->dev, min_rate);
> +	if (err)
> +		return err;
> +
> +	emc->requested_rate[type].min_rate =3D new_min_rate;
> +	emc->requested_rate[type].max_rate =3D new_max_rate;
> +
> +	return 0;
> +}
> +
> +static int emc_set_min_rate(struct tegra_emc *emc, unsigned long rate,
> +			    enum emc_rate_request_type type)
> +{
> +	struct emc_rate_request *req =3D &emc->requested_rate[type];
> +	int ret;
> +
> +	mutex_lock(&emc->rate_lock);
> +	ret =3D emc_request_rate(emc, rate, req->max_rate, type);
> +	mutex_unlock(&emc->rate_lock);
> +
> +	return ret;
> +}
> +
> +static int emc_set_max_rate(struct tegra_emc *emc, unsigned long rate,
> +			    enum emc_rate_request_type type)
> +{
> +	struct emc_rate_request *req =3D &emc->requested_rate[type];
> +	int ret;
> +
> +	mutex_lock(&emc->rate_lock);
> +	ret =3D emc_request_rate(emc, req->min_rate, rate, type);
> +	mutex_unlock(&emc->rate_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * debugfs interface
> + *
> + * The memory controller driver exposes some files in debugfs that can b=
e used
> + * to control the EMC frequency. The top-level directory can be found he=
re:
> + *
> + *   /sys/kernel/debug/emc
> + *
> + * It contains the following files:
> + *
> + *   - available_rates: This file contains a list of valid, space-separa=
ted
> + *     EMC frequencies.
> + *
> + *   - min_rate: Writing a value to this file sets the given frequency a=
s the
> + *       floor of the permitted range. If this is higher than the curren=
tly
> + *       configured EMC frequency, this will cause the frequency to be
> + *       increased so that it stays within the valid range.
> + *
> + *   - max_rate: Similarly to the min_rate file, writing a value to this=
 file
> + *       sets the given frequency as the ceiling of the permitted range.=
 If
> + *       the value is lower than the currently configured EMC frequency,=
 this
> + *       will cause the frequency to be decreased so that it stays withi=
n the
> + *       valid range.
> + */
> +
> +static bool tegra_emc_validate_rate(struct tegra_emc *emc, unsigned long=
 rate)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < emc->num_timings; i++)
> +		if (rate =3D=3D emc->timings[i].rate)
> +			return true;
> +
> +	return false;
> +}
> +
> +static int tegra_emc_debug_available_rates_show(struct seq_file *s,
> +						void *data)
> +{
> +	struct tegra_emc *emc =3D s->private;
> +	const char *prefix =3D "";
> +	unsigned int i;
> +
> +	for (i =3D 0; i < emc->num_timings; i++) {
> +		seq_printf(s, "%s%lu", prefix, emc->timings[i].rate);
> +		prefix =3D " ";
> +	}
> +
> +	seq_puts(s, "\n");
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tegra_emc_debug_available_rates);
> +
> +static int tegra_emc_debug_min_rate_get(void *data, u64 *rate)
> +{
> +	struct tegra_emc *emc =3D data;
> +
> +	*rate =3D emc->debugfs.min_rate;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_debug_min_rate_set(void *data, u64 rate)
> +{
> +	struct tegra_emc *emc =3D data;
> +	int err;
> +
> +	if (!tegra_emc_validate_rate(emc, rate))
> +		return -EINVAL;
> +
> +	err =3D emc_set_min_rate(emc, rate, EMC_RATE_DEBUG);
> +	if (err < 0)
> +		return err;
> +
> +	emc->debugfs.min_rate =3D rate;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_min_rate_fops,
> +			 tegra_emc_debug_min_rate_get,
> +			 tegra_emc_debug_min_rate_set, "%llu\n");
> +
> +static int tegra_emc_debug_max_rate_get(void *data, u64 *rate)
> +{
> +	struct tegra_emc *emc =3D data;
> +
> +	*rate =3D emc->debugfs.max_rate;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_debug_max_rate_set(void *data, u64 rate)
> +{
> +	struct tegra_emc *emc =3D data;
> +	int err;
> +
> +	if (!tegra_emc_validate_rate(emc, rate))
> +		return -EINVAL;
> +
> +	err =3D emc_set_max_rate(emc, rate, EMC_RATE_DEBUG);
> +	if (err < 0)
> +		return err;
> +
> +	emc->debugfs.max_rate =3D rate;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(tegra_emc_debug_max_rate_fops,
> +			 tegra_emc_debug_max_rate_get,
> +			 tegra_emc_debug_max_rate_set, "%llu\n");
> +
> +static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	emc->debugfs.min_rate =3D ULONG_MAX;
> +	emc->debugfs.max_rate =3D 0;
> +
> +	for (i =3D 0; i < emc->num_timings; i++) {
> +		if (emc->timings[i].rate < emc->debugfs.min_rate)
> +			emc->debugfs.min_rate =3D emc->timings[i].rate;
> +
> +		if (emc->timings[i].rate > emc->debugfs.max_rate)
> +			emc->debugfs.max_rate =3D emc->timings[i].rate;
> +	}
> +
> +	if (!emc->num_timings) {
> +		emc->debugfs.min_rate =3D clk_get_rate(emc->clk);
> +		emc->debugfs.max_rate =3D emc->debugfs.min_rate;
> +	}
> +
> +	err =3D clk_set_rate_range(emc->clk, emc->debugfs.min_rate,
> +				 emc->debugfs.max_rate);
> +	if (err < 0) {
> +		dev_err(dev, "failed to set rate range [%lu-%lu] for %pC\n",
> +			emc->debugfs.min_rate, emc->debugfs.max_rate,
> +			emc->clk);
> +		return;
> +	}
> +
> +	emc->debugfs.root =3D debugfs_create_dir("emc", NULL);
> +
> +	debugfs_create_file("available_rates", 0444, emc->debugfs.root, emc,
> +			    &tegra_emc_debug_available_rates_fops);
> +	debugfs_create_file("min_rate", 0644, emc->debugfs.root,
> +			    emc, &tegra_emc_debug_min_rate_fops);
> +	debugfs_create_file("max_rate", 0644, emc->debugfs.root,
> +			    emc, &tegra_emc_debug_max_rate_fops);
> +}
> +
> +static inline struct tegra_emc *
> +to_tegra_emc_provider(struct icc_provider *provider)
> +{
> +	return container_of(provider, struct tegra_emc, provider);
> +}
> +
> +static struct icc_node_data *
> +emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data=
)
> +{
> +	struct icc_provider *provider =3D data;
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	/* External Memory is the only possible ICC route */
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		if (node->id !=3D TEGRA_ICC_EMEM)
> +			continue;
> +
> +		ndata =3D kzalloc(sizeof(*ndata), GFP_KERNEL);
> +		if (!ndata)
> +			return ERR_PTR(-ENOMEM);
> +
> +		/*
> +		 * SRC and DST nodes should have matching TAG in order to have
> +		 * it set by default for a requested path.
> +		 */
> +		ndata->tag =3D TEGRA_MC_ICC_TAG_ISO;
> +		ndata->node =3D node;
> +
> +		return ndata;
> +	}
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct tegra_emc *emc =3D to_tegra_emc_provider(dst->provider);
> +	unsigned long long peak_bw =3D icc_units_to_bps(dst->peak_bw);
> +	unsigned long long avg_bw =3D icc_units_to_bps(dst->avg_bw);
> +	unsigned long long rate =3D max(avg_bw, peak_bw);
> +	unsigned int dram_data_bus_width_bytes =3D 4;
> +	const unsigned int ddr =3D 2;
> +	int err;
> +
> +	/*
> +	 * Tegra114 EMC runs on a clock rate of SDRAM bus. This means that
> +	 * EMC clock rate is twice smaller than the peak data rate because
> +	 * data is sampled on both EMC clock edges.
> +	 */
> +	do_div(rate, ddr * dram_data_bus_width_bytes);
> +	rate =3D min_t(u64, rate, U32_MAX);
> +
> +	err =3D emc_set_min_rate(emc, rate, EMC_RATE_ICC);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_interconnect_init(struct tegra_emc *emc)
> +{
> +	const struct tegra_mc_soc *soc =3D emc->mc->soc;
> +	struct icc_node *node;
> +	int err;
> +
> +	emc->provider.dev =3D emc->dev;
> +	emc->provider.set =3D emc_icc_set;
> +	emc->provider.data =3D &emc->provider;
> +	emc->provider.aggregate =3D soc->icc_ops->aggregate;
> +	emc->provider.xlate_extended =3D emc_of_icc_xlate_extended;
> +
> +	icc_provider_init(&emc->provider);
> +
> +	/* create External Memory Controller node */
> +	node =3D icc_node_create(TEGRA_ICC_EMC);
> +	if (IS_ERR(node)) {
> +		err =3D PTR_ERR(node);
> +		goto err_msg;
> +	}
> +
> +	node->name =3D "External Memory Controller";
> +	icc_node_add(node, &emc->provider);
> +
> +	/* link External Memory Controller to External Memory (DRAM) */
> +	err =3D icc_link_create(node, TEGRA_ICC_EMEM);
> +	if (err)
> +		goto remove_nodes;
> +
> +	/* create External Memory node */
> +	node =3D icc_node_create(TEGRA_ICC_EMEM);
> +	if (IS_ERR(node)) {
> +		err =3D PTR_ERR(node);
> +		goto remove_nodes;
> +	}
> +
> +	node->name =3D "External Memory (DRAM)";
> +	icc_node_add(node, &emc->provider);
> +
> +	err =3D icc_provider_register(&emc->provider);
> +	if (err)
> +		goto remove_nodes;
> +
> +	return 0;
> +
> +remove_nodes:
> +	icc_nodes_remove(&emc->provider);
> +err_msg:
> +	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> +
> +	return err;
> +}
> +
> +static void devm_tegra_emc_unset_callback(void *data)
> +{
> +	tegra124_clk_set_emc_callbacks(NULL, NULL);
> +}
> +
> +static int tegra_emc_probe(struct platform_device *pdev)
> +{
> +	struct tegra_core_opp_params opp_params =3D {};
> +	struct device_node *np;
> +	struct tegra_emc *emc;
> +	u32 ram_code;
> +	int err;
> +
> +	emc =3D devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
> +	if (!emc)
> +		return -ENOMEM;
> +
> +	mutex_init(&emc->rate_lock);
> +	emc->dev =3D &pdev->dev;
> +
> +	emc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(emc->regs))
> +		return PTR_ERR(emc->regs);
> +
> +	emc->mc =3D devm_tegra_memory_controller_get(&pdev->dev);
> +	if (IS_ERR(emc->mc))
> +		return PTR_ERR(emc->mc);
> +
> +	ram_code =3D tegra_read_ram_code();
> +
> +	np =3D tegra_emc_find_node_by_ram_code(pdev->dev.of_node, ram_code);
> +	if (np) {
> +		err =3D tegra_emc_load_timings_from_dt(emc, np);
> +		of_node_put(np);
> +		if (err)
> +			return err;
> +	} else {
> +		dev_info_once(&pdev->dev,
> +			      "no memory timings for RAM code %u found in DT\n",
> +			      ram_code);
> +	}
> +
> +	err =3D emc_init(emc);
> +	if (err) {
> +		dev_err(&pdev->dev, "EMC initialization failed: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, emc);
> +
> +	tegra124_clk_set_emc_callbacks(tegra_emc_prepare_timing_change,
> +				       tegra_emc_complete_timing_change);
> +
> +	err =3D devm_add_action_or_reset(&pdev->dev, devm_tegra_emc_unset_callb=
ack,
> +				       NULL);
> +	if (err)
> +		return err;
> +
> +	err =3D platform_get_irq(pdev, 0);
> +	if (err < 0)
> +		return err;
> +
> +	emc->irq =3D err;
> +
> +	err =3D devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
> +			       dev_name(&pdev->dev), emc);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to request irq: %d\n", err);
> +		return err;
> +	}
> +
> +	emc->clk =3D devm_clk_get(&pdev->dev, "emc");
> +	if (IS_ERR(emc->clk)) {
> +		err =3D PTR_ERR(emc->clk);
> +		dev_err(&pdev->dev, "failed to get EMC clock: %d\n", err);
> +		return err;
> +	}
> +
> +	opp_params.init_state =3D true;
> +
> +	err =3D devm_tegra_core_dev_init_opp_table(&pdev->dev, &opp_params);
> +	if (err)
> +		return err;
> +
> +	tegra_emc_rate_requests_init(emc);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
> +		emc_debugfs_init(&pdev->dev, emc);
> +
> +	tegra_emc_interconnect_init(emc);
> +
> +	/*
> +	 * Don't allow the kernel module to be unloaded. Unloading adds some
> +	 * extra complexity which doesn't really worth the effort in a case of
> +	 * this driver.
> +	 */
> +	try_module_get(THIS_MODULE);
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id tegra_emc_of_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra114-emc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
> +
> +static struct platform_driver tegra_emc_driver =3D {
> +	.probe =3D tegra_emc_probe,
> +	.driver =3D {
> +		.name =3D "tegra114-emc",
> +		.of_match_table =3D tegra_emc_of_match,
> +		.suppress_bind_attrs =3D true,
> +		.sync_state =3D icc_sync_state,
> +	},
> +};
> +module_platform_driver(tegra_emc_driver);
> +
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra114 EMC driver");
> +MODULE_LICENSE("GPL");
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




