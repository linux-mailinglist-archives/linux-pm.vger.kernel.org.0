Return-Path: <linux-pm+bounces-20251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C3A09656
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81DC7A4A83
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE2212D90;
	Fri, 10 Jan 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="crDX1GzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3512063E3;
	Fri, 10 Jan 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524041; cv=fail; b=J61NolY+b3vUNXFbA6RJxx/ouJayV/je/oTCGrQQ7K94s/oOzcZRW0wLh4VEvINpEbZrPmfqsOelsbdYhruW2/Wng4r6Jw5dJbhfmAwQnuCnLBJ6tpwx/Zkw2QiV0wFjlqOw5t8To0LkJB6new2ZZ8FMz2iZO7TM75NA2OMVRWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524041; c=relaxed/simple;
	bh=n9kRkCEa6JxKktSBbvh3bDLI+FDS9kEbWDgq4m0dFqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMjyK+Hs8wvTCWbnluR6MAJUN/8PlED8/2g/U/5PG/hlfx6ju3SFPOBih63LwaAr4yDE7RfErpOLkdw+CHpVgLJN1tAwWCzqFJE1UF0pg415Tj0ndkgnRvSSz3Rn3Hg6AoLz85gV3Ip5CTRA3j3YtngyzKw/bQNb8HqTLcT06Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=crDX1GzS; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPeAWsUb1Jtu5/eLdjUn1Ae9lOXC3lidiZJNutrU1DKO76nk8i3xZIW+fTd62rPHfKInP00Q5S77Fj7ugMjHeKh5Cyd85tcoe1SrXTIKJddcPX0DSx2Fk50XP2z90MfoP/fJliZNQ4zp10/rbPw+CckMuvE9NGe6AWRCI5WuhMq8QzHqMaELlDLILohu39TeqxOFLQAR+IZkW2PLWa15yqw6PiOLwJcClAuFRC8Og4IEDnpDR5v2UqS24TuAdty2iRsfIYB/UptEVxZ/t0WIDNiEhTBpunC5jPgKnoRgDaRKTWy1aoBSbaQFuY+afYq6SWFnOx3XdmD8TuvLZaZtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhxoiiPHpotfRnD9Mp9FAVuk9XmdM1W6QbSmUrzJL/w=;
 b=Zce8iHA/AF9MT/pfBpUh5HEs7T+jRY0FFO9HtjE+ZX3TlCs2/TzFVSucfznyNRC7WXHESzV8MflfO+fYGPRBG5ZEbmujOsXzA4lQTxe2vlb5aAHZJ7DCritaJPsUlfjdoHtIyljsXGHOb0MdU9ZTSSVTzH4nrrOduTexoF28s1t9dj8g7B1WnZrB+RtzHjN5bINnSXkovibGgUhsX/RREu7ij8WoSmk5UXOKyzxwce8v0+HfFr8SAfd16BGQkRvCs+4ggNky0S9DWGG2DBSx3zcEUB30XHHgnYmKB0yOVcvCuvPLN7g6QbGY9E9CoHqEu3inYx1wMXLtxYCGmf/DsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhxoiiPHpotfRnD9Mp9FAVuk9XmdM1W6QbSmUrzJL/w=;
 b=crDX1GzSx/+DW4Rg+tIjXQU1BgsaU1lwp0gynnbRJ7Des/lgrTGnGg4IIo4bD1Aelf5qv5KfbG7cSYMAV4oBh/AQirXyLFxJPhN0nkQSiQ9aYrP6YPOdHfVZc0GzjTE6MLk3ZbUfT53NCm1z2TVtsgz/HEt7jpjpGzUtQ8+mUFACKx2Ia/hC5NKu48F9vK1dSplCL6sAP888wSobAQMK/hj6paKr2vxZa8302n7wVIf8YX+YYukoY57HD8RzjKdFcD2kij5DqyVnlZ9toOUritXL3FLWNPh5JnXKLWvi/Qupd2c4M0NoPqI8PqrpY9fJEdVo3Kv54v4O+zROhQkvXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB9PR03MB7195.eurprd03.prod.outlook.com (2603:10a6:10:1ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 15:47:14 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:47:14 +0000
Message-ID: <4ee4d11f-069c-4f64-aeda-3de22b821b29@uclouvain.be>
Date: Fri, 10 Jan 2025 16:46:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
 <6abdef3d-95cd-4afc-b5d4-880c58f60e9d@wanadoo.fr>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <6abdef3d-95cd-4afc-b5d4-880c58f60e9d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::6) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB9PR03MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f98b3-74ee-4cf8-28d4-08dd318e0de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2oyUFZLVmxaUFBWbjBwZmFrM0NweWtiQUY2RS9JT2p1NFo1akhJVGZFbG5p?=
 =?utf-8?B?NEJ3OC9qS252UGo2ZnVXYmdFQ2NkNkM1SERVUlY1b2ZZZVN0T3VVcXZCMmFB?=
 =?utf-8?B?b2ZHSzBiY1FRNkhMcEt0bnpLRHJLeWN1SkdmeTBiSnBpeS9EZ2xNNXM3TjVQ?=
 =?utf-8?B?UHRLbmRZN0wzSUtpTGRYMnhPRndwbVc1QWdtUElHQVpiQmRjT2ZVUjNndDVn?=
 =?utf-8?B?Y0FSSXJyK3Y4aEM2L0tnL3QveGk5LzJLa1phaXF0M3R6aEZIQ1dPN0Rxc1Q3?=
 =?utf-8?B?bWVLdWc0UnJOSEgxNE9BR1h3OE9pT0NqMGRGdkdrWDR5SHp2ekxhK0NwNEJS?=
 =?utf-8?B?ejE5Umx2NWJPSVU2dmdEL1lpcUhnK2ZnbFlEOEN2L1JDUUV1NTFLWnRTREFz?=
 =?utf-8?B?UHhVdkQwWmVXRUViNmxoMkRwWVpGQWVWdk4vS09ZbGhpVE85aUtzK2xDcW9Q?=
 =?utf-8?B?WlEweU1NZUUwV0hNSXhXMUgwa2owdzV1TmNkTEkxTnpUK21WRDZsUS9yM0JI?=
 =?utf-8?B?eFpzTUtkUlp4Qk5XUWRaRXI0bHJqRzlrT29weVlsZ0VuQlhYVzJtbnNOcEx4?=
 =?utf-8?B?UVNSVE5NRlRoYWtSVkNTNGpFcGNIckZEZ1Vkdm53YWNuelZrOXA3ZVJnRkE1?=
 =?utf-8?B?bjkzUHRmblNDS2FTY1RXU0NrNFZCM29RU1YwdHF5RVlQQ3FnS1h5bGYvYzlm?=
 =?utf-8?B?T3g4bldvVmdRQXpVVzd2QkkzZ29KWFRGa0ZlTGRHdkszUEJOVkg4ZHRFMmIz?=
 =?utf-8?B?Z1NHd2lCQ2FSbW9ybTdTY3ZiZ1RpNFI0dWtpcUVrem9oN3J6c3ZteDZlUFNq?=
 =?utf-8?B?SUFuV2RMNHV5WlVaQXcxN3JZZ2pWcmtVMkJCWGtHTnVlV1J3YkFSOGhnOEFC?=
 =?utf-8?B?ZHlkV3NxZUhRWW1CVkZ1ZGxxQmNxVytQV2lUMVBjSHM5ZThac3JoaVB0Ty9B?=
 =?utf-8?B?N2s3aWR4cGtGeWhRdExEcSszNHZ6L1kyYkw2Vmxoem1qR05pTTkyMWpvN08r?=
 =?utf-8?B?NjRId2hORVR3YmdGdGFRanZpSnZvZGczVFRSRHZRQjNCZVNzWWZjZy9nTnlt?=
 =?utf-8?B?RzRSMlZSZUlyRVdXREhBMm5QcUgxWEZ6QnFnV2VIVFJ4Nnl1TFNqblUwYnhz?=
 =?utf-8?B?SmFMcUUzbGRhNjVhdkFFSjM3RE5BSXF1eE0xU3c5L3RTdnMxczdYbTFoTFda?=
 =?utf-8?B?OWQ3UlpwRHlmZVR2aEVrLzd6aDFUZWt4cHlQcDlPWXVrNm01TlBFOEMxdXVU?=
 =?utf-8?B?NWFMMEtTbGs0Z256dU1ZVm00SzBxZDIzZC9jRGJhUjh2YU5BWGJqQVVxSmlI?=
 =?utf-8?B?QkZRSUZ4Uys5VEVleG5pcmR1VU5tQlFVS00rL3FKNE8xYTV5RUZYc2xOeDZn?=
 =?utf-8?B?R2N3Z3F0U2U1OGt0VkdGUlAyZVdRUDRaNmlHVkp0SE1RNmhIK29NaGhuQ1c1?=
 =?utf-8?B?ekFJblIyZ3lwRzJmTDh2YWd1RnA3WW9WeXE3TEd3WmFpdkc0OWJYOFIvTWRw?=
 =?utf-8?B?ZHNueWlQZlhJN21NTllvekdKdGtWMmV4MW1pQW1peE84VmdtcFQ1L1pzbVo0?=
 =?utf-8?B?K2tjWXpUTEszc1FIdTJrV1ZZUk5TQUNkSHR3VGpvZXhVdmFXTEZnWFprbVdh?=
 =?utf-8?B?TDlWZnFVZ05DbmI0cWdGalVIWS9rMWh1V2pCaGpLcEQrVEF5RGhWZzhYeTlF?=
 =?utf-8?B?NzBwdzh5Misxekg3U0hGbG8rVDl5aVh6enNkcmxtR0dqRFhXeDJodWREd3Zl?=
 =?utf-8?B?VldMeVQvRGQ2Z1RkbDVqb2IxUUdzaGhJeTJYRUVrZytXRVVWaXUwNXJuY2lP?=
 =?utf-8?B?Tno5L2tReWhrWnZkeGpQZ2pqUlJaREtDQlRJSFdJUWFuVnVhS3h6c0JZT3Vj?=
 =?utf-8?B?MjBJSnl1bFNZNmhpbUNzTnNaSUdoQXMvMXZzeXJtaVVwNHBZM0U4Wjd5OVpT?=
 =?utf-8?Q?ngiQ4xTTRT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9hODNVeE82dTUvVmJDekFWN2I2ckNzcVk5Qk5Rd3ZiZXNWVUtxZ2Rnc3RQ?=
 =?utf-8?B?QTcwcHU1L3RxSTlMcUw2d2hTWmc4R2t1NmJvOU0ybmF6LzFhWGczTklTSGRs?=
 =?utf-8?B?ajRPQWJsenJldVdRTzR6L1VNZ3BEdnFkamQzaFZsRjh2Njl6bUJPeWd0Y1N0?=
 =?utf-8?B?Q3ZkYjc2dWNaNmYxaE9hODJxU1YwQm93NEJWQWxrYXNQajR1WjN3dmwvanFK?=
 =?utf-8?B?UjhZRHBKQlpkYlV2Y3lScjBFbVc4Q2pNV01XdGlJUmwrdlB3OHVWTU5qNHNQ?=
 =?utf-8?B?OVFjZUZ5V2doVGsxTVRxMldQYXQ1YnFHNnFGMFIzNG1WSFhHOVNmL2F0bllp?=
 =?utf-8?B?Y2NLeWx2cXRucitQUHNXWWFhdUsrRUUwbEpIWXYvbU9SWTZxWGgvdnRYakc4?=
 =?utf-8?B?QnlER3FLbzNiTVVjWThEU2RDdThKV0hjZmxaWmpNKzA2b0pFY2lZdUV4aWpE?=
 =?utf-8?B?a2poRFNla2FWdm5tRlZrNGoyRzRDQU9seDFHTS9wV0VML0tBRXRhY012azFU?=
 =?utf-8?B?SVlCcmQzNnBPZld3czhUNHVSQno0WkRZQUF0WkRxaG5GblJKMXl4T0ltbVZs?=
 =?utf-8?B?UEM5b0ZWRGcrTDNFNW1EVGc3SUp2SENEOTAyN1F1TXpuUWtBaDNWZElTUFpY?=
 =?utf-8?B?N056ajZobDV6VkI0RnYyclVuQnNNdWRKWE5zOE9UM2F3N3ZBejRqZWF5dm5C?=
 =?utf-8?B?eitYSWVLMmU1MlJFMXBHa1hrWnFnSFJmU204N1NQVkg0YWt6cGI4b0drSERW?=
 =?utf-8?B?VWpwUFZOV0QyTFRpYVVwbVdVc05NSnhtTlBQNk92OXlRZC81SkJESGJHNlhI?=
 =?utf-8?B?TnVFb3RoS2lZYi9jSWRBVm5xVkdKdVY5WW1wR2hrWEI2SzE5WWYzcUlEZHkv?=
 =?utf-8?B?WXJPTlNWd3RMTm5SZzljcXFoc1U2aTJrek5IM3M4aGdVbVJySWNDVEpOZ0Vw?=
 =?utf-8?B?OTEwdWU0WWcweUFqN3ErVWhnK1NmMEVnRTB2NHlnWTlLRCtubzBJblZ3N3I2?=
 =?utf-8?B?UmhJdUUvNC9VZjc5VDVwVEwwYllXZkZQMWRvNTBnVXZlVExLRk1qUmxITS8v?=
 =?utf-8?B?SFhTWWNGdUduZmlNRG84bGtLUlZqUlZnL01EdEQ1N1JkNFNQeGo0akJpQWlk?=
 =?utf-8?B?WHZqa0txeldvbVBQem9mMDFyakNjV29aekN5TG1hWFlPOVVFK2xNc3pPa0Zz?=
 =?utf-8?B?VTZVSmxFZ05XZHpsQ0UyMDVGZG5Va0l1ZVhUNUlOa3ZETzI3OVNvVm95MXp3?=
 =?utf-8?B?QlhRcE5jSFZQc1g0cG5yYzZNN0xIbVl1VnBSbTkyYXA0M2hFcVBQb1A0S2ds?=
 =?utf-8?B?MWtONjlQYU5jb05BRW5BdDdYUmZudVphd1dMRXppWmp6aUJEajVNR0hZak45?=
 =?utf-8?B?c3Zyd3NXOTZLeitYcm93aXcrVjZwTVN0ZmRKaUxUc21nbVVUQUc5Z28vcklB?=
 =?utf-8?B?RzFCWUpoTTZlRGdGdlA1YVNrcE45N2lPb2hsYit5eUhLQjFTY2h3cW0yRFgv?=
 =?utf-8?B?NEttdHVGdHp1blNGVjkram4rcklwZFlPbTZhUzBWajhVdHZ1d2ZUZi8yUXJq?=
 =?utf-8?B?SERINThkU3E4TGlnRWR2ODFzY2RremdYMzhFR3ZPSytCL2FlNjh2bkoxbEU5?=
 =?utf-8?B?c3ZTclNkU1ByV0x2UElMbjg2eDQ0Vm5LaHFzelpKd1ZLQkJuTXhiV04zQThT?=
 =?utf-8?B?bkxkMjRWTUFQQlMzUHcvTVQrNUh0YlJRb2E0NmZZb29idDBNb09lQm1WMGMx?=
 =?utf-8?B?azI2ZTBUUnppQkY0U3FSOStzNW0vRGxYaTcrNkdSRTJSRHU4b0lSNklGS01M?=
 =?utf-8?B?SE5mUC9SajZsUUFxUWRudzRPU3lUSlVjRlJVNTZQQitidzJrQnUwOGlUdlJ0?=
 =?utf-8?B?STZGWkVkcy9JZVJIemt1UjF4aS9rdzNPYk9EMm9DYVRGQTc3ekNzdEQzb1R3?=
 =?utf-8?B?ckFBMUl3c1FaMEhRS2NMcmwzMHpoNEJteC9BWDhTeWUva1V1a25xY29oOFpS?=
 =?utf-8?B?RWhKV1BBRzViMnZ5UHJSUm5uMDVlVnFVQ0lQWFBobmxrYndZMzRCb3VNVTZl?=
 =?utf-8?B?TjZBSXpSL1dCV0V0eG5SQlg5N1RnaWZ2V2lYbXZuaE1uVGVvL2lDU3NUeG9B?=
 =?utf-8?B?Z05CeWRMeDVyQVdTSkdwYURYOGl6SEo1QVhiUVZmZjQ2RHFldlZPVWZseTI3?=
 =?utf-8?Q?yzPaIghYoVbP6gcUxMnFkZrKlI+Mvez3oEbI9qRgFsTd?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f98b3-74ee-4cf8-28d4-08dd318e0de7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:47:14.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVjMaIu+0G6noNzy7qieGVEBKgvwuOAnisyvE8TG+9z2uJQRKvagawLrrWOBSFOSkc4ZbL2FyGKKJudeN0YAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7195

On 1/7/25 19:10, Christophe JAILLET wrote:
> Le 02/01/2025 à 12:15, Thomas Antoine via B4 Relay a écrit :
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The interface of the Maxim max77759 fuel gauge has a lot of common with the
>> Maxim max1720x. The major difference is the lack of non-volatile memory
>> slave address. No slave is available at address 0xb of the i2c bus, which
>> is coherent with the following driver from google: line 5836 disables
>> non-volatile memory for m5 gauge.
> 
> Hi,
> 
> ...
> 
>> +     ret = max1720x_get_rsense(dev, info);
>>       if (ret)
>> -             return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
>> +             return dev_err_probe(dev, ret, "Failed to get RSense");
> 
> Missing ending \n.

Hi,

I will fix this, thank you.

Best regards,
Thomas

