Return-Path: <linux-pm+bounces-19271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3269F29AC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 06:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D27A168A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 05:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C41C4A2C;
	Mon, 16 Dec 2024 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+vN6So3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456F1C3F0E;
	Mon, 16 Dec 2024 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327799; cv=fail; b=ftcFw18uGIRazJLGQDrEVB41uH5QUX3UbOWtzsIjXDq1LnmVDGiheNPFB3Z3cWGTAstuGxkxrt9fsW3BwLBYivzAW/LPrJcHE2F0h0XDfdctpWSZHThUqfcSasmdUcp2raUpuiRV2e+qp9z4eMuX276EWpWqQpJIrmUMjMdBCsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327799; c=relaxed/simple;
	bh=k609KnFB+YrBM1OW56O9jm+ez78OJDcdN7YPJbmaqc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qg71/VQ2EK5xdYqZMxigXMqt55QuHewgIgMLc730QApwJ6FRBpH6/pof+ype+FFT9ygWG/s/b7ZDQ31CA/NytC/zeQxNKN+3tywxmfbqbuB820Hkhofz9cSwQQPzrfzkndwtGH3WQxkPHA6oD4+RaAwjYdKG7c3weO1NhOxAX8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+vN6So3; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sn7X0kGExorb2tztAVYZX2VdiyOIuZaW69hCiuW9CiUofT1h05qYSqkDxMrSy7ru463UQGMjtNXJUDCdMd9Z7rmlSBOZ1DseRGj5JKYmAHsgnnJHikLSDmIU4eLM7VuxrUkfSPKAjpwDac3PnCx1w5Ry2l3+wMANsTCCI6H60gX5Vd5IVh+2iS4+irtp0lcH3CDZTptxIQ/O4IfQzcOt9ODHN3Mb4oowj8043p/bHPvjCwmJE12MyWbGKH+SXldep360gibUAIZatTrCBTmYDi37wtV6vWnhA5mGo2anxbgW+JXViaHEnhbQ67XObzniHGUH93+dNRaHFqChuka43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKE712LNTnq5OnoswiWWPkoFcG2Yq5+YIV5fgh+FYjU=;
 b=J0fsicavv9hrZdg2BCjEKCC9/kLiFmie7sBilg7u8MbnsvEr0gk7JC/e1zf6HF1IgyQAKIDE3qY6D3hF0yTbXmmr1ZMynLUMeOTLZK+IcwVX7rZ+jTL0s98KS/Uz0pxuTr0ctB2aiT7sPhlHLXTlYLVPn8hKozYoJWwXbTR9NZqWA+Rp8ZPugAKwujAXKNr3kbfMG7mTPAB4sNv30hIcBjsHu5FiOu9j/jKGTE6WOgPTVgVtu9/fU3L8u0j9Tqtpltadn/MU1zogjG2mfUIXDXXEud4NvLvWIyheEAAVchnNjrFIg8JFMiIAewUoa0XscefUuGFQOxJFoI1s5JKmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKE712LNTnq5OnoswiWWPkoFcG2Yq5+YIV5fgh+FYjU=;
 b=Y+vN6So3Xg3Kznvr+rnLoZ9k0jsvvfU7IlTym7pZEV/sSmGwuyH6hlaajkoEJFmWGFjag8fW3ZYurAJOcbR5Cqkh02Uoi0CyjOQH3nuK7YR/AswibXW+Yen/IccJGNT93As6VGyc33UYFqSpzCaL3VBVRqefJWH3hUO/TWRACQZjLzBI1fK0+6SzvWgm3BgrsBRsgzGabUmOmyKlGzTJDXL3kka8MDVTClMNk1qd3AEWAK8QJXpaF9/JdoQ7Kx+iz/Q4Edr51uoTFDejAxqpshAYuo67qzk32H3K0M/w0cA80T9yn6oj27TCta3eF3tWq0FD2E0wQK6wxWED2Snv3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 05:43:15 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 05:43:14 +0000
Message-ID: <3f19c5a8-9ee6-42fe-8b4c-3a66c65c8d35@nvidia.com>
Date: Mon, 16 Dec 2024 13:43:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
 catalin.marinas@arm.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: sumitg@nvidia.com, yang@os.amperecomputing.com,
 vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
 zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-doc@vger.kernel.org, Carol Soto <csoto@nvidia.com>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <20241206135600.4083965-2-beata.michalska@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0a2187-970e-4d05-77e8-08dd1d948852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitiSUMwNWJyQjZCcGhrSnJuQUpqUHFUVndGR0pjYjRON0N5bDE5b2E0Q1l2?=
 =?utf-8?B?cEtBUVhaSWhwekJhQ1BOdjJBTTNEZ2ZvZjhOTVBrZ016VG00TmdEUmdlT0lY?=
 =?utf-8?B?WTV0VGp5c0VJQ2d3dEZmZWFIR0lJZE5QaVJvRDRWNGpJeXRkSkM3b05VdGhx?=
 =?utf-8?B?UXFhNE1CVTFvekFmZm1NU1RSdUVDc0hWdzI4V2FLTDFYaGhkeEJ6dGYyanBn?=
 =?utf-8?B?VHVqc25yRDhDd1V5S0xJSCtOQlVoMy9tVEtHRSsrR096Nmx5b2tRZG5zUkg2?=
 =?utf-8?B?c0swNGh5Mnd2eVJUR0w1THdMdVZNODFtSTZzcDY0eVV5SGJteVkxdUNkdENZ?=
 =?utf-8?B?MHVPaGVvTWQzZVlRM0pVYThveEZyWG1XVUo0aWx6cVFCSTBBL21MTWpHRG4w?=
 =?utf-8?B?a0pGSmFIT3VZYnRPN2xmeVFEYTNaV3I1WjFWZjIrSjdsaTFRb3F6R1hqSW84?=
 =?utf-8?B?U1dEUGs1V2FlY3M3SGJ6VldFSkhiT0cyblprVWM4V0RBNXRJamdGM2Q4SmhL?=
 =?utf-8?B?ZHVDbjIvUTdPZnpqZUxMWGJtOGY1OTJYOThjWk9ITmVJNDJRTE5EM1N4U1Rm?=
 =?utf-8?B?UlppYXM1ekxtdmhsYnJQSzZXUSsxQWhUZU4rTjd0OTRGbEsvZ0JhSGlxbXZz?=
 =?utf-8?B?NGdFMTVqR1RqR2Z5QkxsQXhEYmlFVTRPS2lzb21qRmhNVDZPSEJVQ1E3cTJj?=
 =?utf-8?B?OUc3aTR5ck5sWFlXNTJISHhLTVUxK3c0aUxnQU4zL3ZJcDFmN0VWUGpERGV4?=
 =?utf-8?B?RDk1bjZlQ0lyblRrT2g5bW9BNlc2amJQeG1oUDFIZStCaDc5cGpHYndrU1dV?=
 =?utf-8?B?bnlyL3p5ZWxSbngxeXMwdW9yTnNFdXhYSnA4K08xVnZYT2ltNk0waVVCRHRL?=
 =?utf-8?B?LzJEZWk4bWNTSVhmcFB2UlZEOWNLbGpZMnNXUEdaRnhzQlBTbml0U1ZqUUxM?=
 =?utf-8?B?SW4zQ0hCbVl4eTdmYitqUW9DRzdFbVY3anJ5eERyc3VqK1VrNkZBK0MyN2xj?=
 =?utf-8?B?UW9WWlJYM0xaVDd3SkRtUUo4Q0U4cFY3NXhXSzhuK1hsOUE0dGliK0srcjRK?=
 =?utf-8?B?L3c0OFNnRnloY01SWnpKb0dkelB3K0VLNGtSMkY2bmJVYkxnL2I3NnNVMlZG?=
 =?utf-8?B?VitLc0c1eTYydjhKRllyNGtmNHF5TVJxWXBTcER2RDFtcWE5K0t3OEU2d09K?=
 =?utf-8?B?enNQVk9uSkEyV05kMzl4b1ZjUy9LQTU3S2I3cWw5WEJrQit6ME5zWTEyUUE4?=
 =?utf-8?B?LzZBWW5DMzN1MC9WUzRqWUgzVHNwdThWQndReVBmK1RFUElXcU5RMnlQdUxh?=
 =?utf-8?B?NXlLK3dIS3V0THdTN0RYLzNJL1dzaTU4WUsxWkZaajIxOTRLTGppOHBQWGxL?=
 =?utf-8?B?R0c1OWFYQkttYkxHM2lLT25UQ3l1bE8vRDRSdFhGZ2dFQWVDQVhqNktnRjc3?=
 =?utf-8?B?MFZvdXVzMnBzbjRPYTZ3Yis0UzhOdXJhdXJpSG1QZkMrcWoxd245U0txOFFK?=
 =?utf-8?B?Mmh1UU5BU2xjNmFOT0k0R3k4bXF0RnQ3RWxTZkJwVis1NjErUVorWU9SS05v?=
 =?utf-8?B?L2hkUzlqYkZ2MXpWQ1ZpZGJreXVRQkdIdkVHN1NrUTJad3VtZG51M1JlSnBa?=
 =?utf-8?B?T0RadUlYcmR2eVArQUJYblp3LzRXNE0wSDlNNjlxT0hYVTZycTdsWDJKa0xj?=
 =?utf-8?B?UjgwMzdXUE5LbGp1eTkxS0xVbzNEN3RUcUlMK05HUkMxUVk1cFBGbWlsWXUr?=
 =?utf-8?B?K1U2WG5wZ3p5NWpFbVdlY2piRFBoODZNejArd0R2d2U2NWYwWjJXVkd2Y2VI?=
 =?utf-8?B?SERFTDdQUVpjOHNhZVV5QjNsOXNwdk80RDllamcrS0tnNUo3VkhTTHdGQTBJ?=
 =?utf-8?B?czJDU0RtYThKUDFIckNyMHJvVG9jbHBZcWt6RkdUOUFXenFKZzN1MjhOSkJL?=
 =?utf-8?Q?u3PcZdl0lBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJzM0trU2VkNUV2UU4ybjlSbGJMVDdSQ2VEWmpwQnpONzZKRHVCRWNLOXZu?=
 =?utf-8?B?RXFRaDgzdCtqWXcwcHFHZ2pZZWVQUVVmeTEwMmFSN3lhaFNLSSttUGpKcEdS?=
 =?utf-8?B?bStOQUlEanQzcy9QMHYzTXZlSG82amFTU0xRak81N3d6K3VaV09BZFNTZ2p1?=
 =?utf-8?B?bjFFUTVLN3VwNG13aFMxdXdaVWJPS05DRnlTc01weFlUdHVDTEFKSjUrTUI2?=
 =?utf-8?B?RG0vYVBHU0h1bERkalpRaGgrVm5FT1NabnBVZTVWcTZ3d3NiTURSYlRaSkl6?=
 =?utf-8?B?elZoeURJQno1cXpoTDNNWCt2N051MkdTbE4vbXk1UWlWa3ZRZUdCTHNsYmdI?=
 =?utf-8?B?YWw2YzFqay81UktmUmFCYXgyMFI3UTlIK2liMXhIYUNHVXJtOUdsVWd3SENN?=
 =?utf-8?B?ZCtKL2N0SnN5K2FheVRjS3JCUlNzOUUwUlVtenZleENGZnFLcDhWaU9oK0NT?=
 =?utf-8?B?YmpvWkFKQ0JmNnFEQWxZYXZSWjBvamd4K0M3NFA3d3lINlJRb0U5ZGtjakVm?=
 =?utf-8?B?NUZ3WHpHZG1JWHF1NnVpWldpdjF0aVpMaThjaDl4cGlEaXM1ZXBzV1ZDc2pK?=
 =?utf-8?B?QktBd0h1TXRYNEtZVmxYdzdoNTF0Ty85WjkvOFdPQzVyVTl1QjJGUndLWjJM?=
 =?utf-8?B?MENjNElUQlRldXlGU243emsvd1UrVTVoUkUzUnNPczQ5WEFJRVhIMU9EZ2k5?=
 =?utf-8?B?MVVMWTkyazZJbTQ4R21NbzF6cjJKa1JiaEtGK3BWVGFBcWZvcG5LZFNTek9m?=
 =?utf-8?B?Y05XYTNoWit2Wm9DTE5IQTY1a3FYWlk5VlRmNTVORkNTYXVDLzZscCthaVVR?=
 =?utf-8?B?TU03cWdWS3hvaE1COWVuVUsxUHluMTJzUnIyUWtFaU5NSzYwS0p3a2FweXdp?=
 =?utf-8?B?emh6K0gxOUkvdWthNU56MnN3UlJMekdBTEpCakhtdzhEbmc3eE0wREt6Uyto?=
 =?utf-8?B?Njk4blJ3QUV2MVBRd1NKNWljOUgrZ3c0MDZRSWVzN01WZ2lDQkd4eGV1Y01n?=
 =?utf-8?B?KzN4cXFNNXJzaThGdHBGcWlGSnptN1QzYmpKbXp4eGZRdEk2UVAzWllNQ3NX?=
 =?utf-8?B?VFg5RGlraksxWUN3QW13S0NTUE94NlFyaDI0cXltUUlVS2o4MXUvNFc3amk5?=
 =?utf-8?B?OE1xTTU4TERsZWFUcjgreTQ4ZVVOWnhZdSs4Vm9KWC9aOVRBbW51c1hBclh5?=
 =?utf-8?B?WDdNelNIeUd0dEpscExVZSs2OFd6SWd1ajJJc1BROG81eWtReUxZSlNpeW9z?=
 =?utf-8?B?azBWd3VtRTNRdkRNQjQ1Z0t5KzZrZE0yUEtjYUlGNTZ4dm9BNlVMa2dIYnZi?=
 =?utf-8?B?a0hUZUNtdjllUFhlWWNOUVJyei9YNW52cXkxbjU0V3JHb25jQjZyMFd4Uk11?=
 =?utf-8?B?ZFcwbm45NnIwdXVqVjR0RU5WSGxHVVh2TGdtSzZ6bUVvYWR6NEFDZEx6OEpq?=
 =?utf-8?B?WlM2WTRzM3o4MVA0bXRKMlRiTWtxaHBSUHRwVUI0TUkzT0UxRlNNM0FmeUp1?=
 =?utf-8?B?eDJEbG5wbTB4VlQ5RjhqbEJhdWNGdmxPY2VRa2hOc0I2T1h3OFYwcTY5VllC?=
 =?utf-8?B?bThqbjVNUWNmZkNUWjJaYUZhQm9XWGw5NUNFcDdoS0xmblE1ZmJ4MzlNaWR5?=
 =?utf-8?B?RXBtbG9PaWZWRUkrRTdsS0VhWnBaWHExVXJJbkJpbStMcTBvZVZlWDVOY1M4?=
 =?utf-8?B?bTNCdGlJdkloZys1WWZZWXJ3RUREVU1iODdtdGt1VkdacFEzcUlmTlNsWDdn?=
 =?utf-8?B?NzhHeHFYL2hXRHU0dmxUV0N2VGZIQnZieXBVRkpSdDZjdU9rSWtsNWY1MXNu?=
 =?utf-8?B?R0puUjN6aFFsV1BsQ01EeXhxMmJkTjQ1OGRkajd1dEtXSFlIUHJSdE1oRlFw?=
 =?utf-8?B?VG42cGlRUkkxZUNqSHR5Z09VQlBpeEJSMDhXZkJVTTNXeDdGNGU5ZVZSNUxY?=
 =?utf-8?B?aVlJeHVvQ0VQNEhIY1MxTFVjZ2MrUCtqM1JGaXo5c1BpMXBUVmxUQjRZaFJL?=
 =?utf-8?B?cGIvSUlHaWJWNUllTHhsZUt6YlNFMENNWWFyS1B0cnRzSTFRbHozeENlOXFz?=
 =?utf-8?B?VE85b2RhVnRmZGFIZlc3TC9EZnZrRDdhdGEvQ3A4MFJQcFd6SWNDQTFnVU81?=
 =?utf-8?Q?UlYYk7pybXPdHbEK9gl36b5t8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0a2187-970e-4d05-77e8-08dd1d948852
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 05:43:13.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRnZc2KxpzcKiZHRC1d5f4JHKQRniNOXA2PIps2lVRUO+3+Dafl9lrgDoYXez1Pg65e/mlBdehMswRPw8WE23A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

Hi Beata,

On 2024/12/6 9:55 PM, Beata Michalska wrote:
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
> 
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
> 
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
> 
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.
> 
> Note that under the hood, the new attribute relies on the information
> provided by arch_freq_get_on_cpu, which, up to this point, has been
> feeding data for scaling_cur_freq attribute, being the source of
> ambiguity when it comes to interpretation. This has been amended by
> restoring the intended behavior for scaling_cur_freq, with a new
> dedicated config option to maintain status quo for those, who may need
> it.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Phil Auld <pauld@redhat.com>
> CC: x86@kernel.org
> CC: linux-doc@vger.kernel.org
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   Documentation/admin-guide/pm/cpufreq.rst | 16 ++++++++++-
>   arch/x86/kernel/cpu/aperfmperf.c         |  2 +-
>   arch/x86/kernel/cpu/proc.c               |  7 +++--
>   drivers/cpufreq/Kconfig.x86              | 12 ++++++++
>   drivers/cpufreq/cpufreq.c                | 36 +++++++++++++++++++++---
>   include/linux/cpufreq.h                  |  2 +-
>   6 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index fe1be4ad88cb..76f3835afe01 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -248,6 +248,19 @@ are the following:
>   	If that frequency cannot be determined, this attribute should not
>   	be present.
>   
> +``cpuinfo_avg_freq``
> +        An average frequency (in KHz) of all CPUs belonging to a given policy,
> +        derived from a hardware provided feedback and reported on a time frame
> +        spanning at most few milliseconds.
> +
> +        This is expected to be based on the frequency the hardware actually runs
> +        at and, as such, might require specialised hardware support (such as AMU
> +        extension on ARM). If one cannot be determined, this attribute should
> +        not be present.
> +
> +        Note, that failed attempt to retrieve current frequency for a given
> +        CPU(s) will result in an appropriate error.
> +
>   ``cpuinfo_max_freq``
>   	Maximum possible operating frequency the CPUs belonging to this policy
>   	can run at (in kHz).
> @@ -293,7 +306,8 @@ are the following:
>   	Some architectures (e.g. ``x86``) may attempt to provide information
>   	more precisely reflecting the current CPU frequency through this
>   	attribute, but that still may not be the exact current CPU frequency as
> -	seen by the hardware at the moment.
> +	seen by the hardware at the moment. This behavior though, is only
> +	available via c:macro:``CPUFREQ_ARCH_CUR_FREQ`` option.
>   
>   ``scaling_driver``
>   	The scaling driver currently in use.
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index 0b69bfbf345d..a00059139ca4 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -413,7 +413,7 @@ void arch_scale_freq_tick(void)
>    */
>   #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
>   
> -unsigned int arch_freq_get_on_cpu(int cpu)
> +int arch_freq_get_on_cpu(int cpu)
>   {
>   	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>   	unsigned int seq, freq;
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index e65fae63660e..34d8fb93fb70 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>   
>   	if (cpu_has(c, X86_FEATURE_TSC)) {
> -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> +		int freq = arch_freq_get_on_cpu(cpu);
>   
> -		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
> +		if (freq <= 0)
> +			seq_puts(m, "cpu MHz\t\t: Unknown\n");
> +		else
> +			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
>   	}
>   
>   	/* Cache size */
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 97c2d4f15d76..212e1b9afe21 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -340,3 +340,15 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
>   	  option lets the probing code bypass some of those checks if the
>   	  parameter "relaxed_check=1" is passed to the module.
>   
> +config CPUFREQ_ARCH_CUR_FREQ
> +	default y
> +	bool "Current frequency derived from HW provided feedback"
> +	help
> +	  This determines whether the scaling_cur_freq sysfs attribute returns
> +	  the last requested frequency or a more precise value based on hardware
> +	  provided feedback (as architected counters).
> +	  Given that a more precise frequency can now be provided via the
> +	  cpuinfo_avg_cur_freq attribute, by enabling this option,
> +	  scaling_cur_freq maintains the provision of a counter based frequency,
> +	  for compatibility reasons.
> +
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..70df2a24437b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>   show_one(scaling_min_freq, min);
>   show_one(scaling_max_freq, max);
>   
> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> +__weak int arch_freq_get_on_cpu(int cpu)
>   {
> -	return 0;
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
> +{
> +	return arch_freq_get_on_cpu(policy->cpu) != -EOPNOTSUPP;
>   }
>   
>   static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> @@ -757,8 +762,11 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>   	ssize_t ret;
>   	unsigned int freq;
>   
> -	freq = arch_freq_get_on_cpu(policy->cpu);
> -	if (freq)
> +	freq = IS_ENABLED(CONFIG_CPUFREQ_ARCH_CUR_FREQ)
> +		? arch_freq_get_on_cpu(policy->cpu)
> +		: 0;
> +
> +	if (freq > 0)
>   		ret = sysfs_emit(buf, "%u\n", freq);
>   	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>   		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> @@ -802,6 +810,19 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>   	return sysfs_emit(buf, "<unknown>\n");
>   }
>   
> +/*
> + * show_cpuinfo_avg_freq - average CPU frequency as detected by hardware
> + */
> +static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
> +				     char *buf)
> +{
> +	int avg_freq = arch_freq_get_on_cpu(policy->cpu);

We are seeing issues when reading cpuinfo_avg_freq on an ARM64 system:

$ cat /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq
cat: /sys/devices/system/cpu/cpufreq/policy1/cpuinfo_avg_freq: Resource 
temporarily unavailable

The CPU is in idle state, so arch_freq_get_on_cpu() can't find a good 
alternative source for frequency info.

One way to resolve this is to have fallback methods in show_cpuinfo_avg_freq() 
so it will look like this:

static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
                                      char *buf)
{
         int avg_freq = arch_freq_get_on_cpu(policy->cpu);
         int ret;

         if (avg_freq > 0)
                 ret = sysfs_emit(buf, "%u\n", avg_freq);
         else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
                 ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
         else
                 ret = sysfs_emit(buf, "%u\n", policy->cur);
         return ret;
}

But that also makes show_cpuinfo_avg_freq() pretty much the same as 
show_scaling_cur_freq().

So is it possible to consolidate show_cpuinfo_avg_freq() into 
show_scaling_cur_freq(), by making CONFIG_CPUFREQ_ARCH_CUR_FREQ also available 
to ARM64?

Kai-Heng

> +
> +	if (avg_freq > 0)
> +		return sysfs_emit(buf, "%u\n", avg_freq);
> +	return avg_freq != 0 ? avg_freq : -EINVAL;
> +}
> +
>   /*
>    * show_scaling_governor - show the current policy for the specified CPU
>    */
> @@ -964,6 +985,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>   }
>   
>   cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
> +cpufreq_freq_attr_ro(cpuinfo_avg_freq);
>   cpufreq_freq_attr_ro(cpuinfo_min_freq);
>   cpufreq_freq_attr_ro(cpuinfo_max_freq);
>   cpufreq_freq_attr_ro(cpuinfo_transition_latency);
> @@ -1091,6 +1113,12 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
>   			return ret;
>   	}
>   
> +	if (cpufreq_avg_freq_supported(policy)) {
> +		ret = sysfs_create_file(&policy->kobj, &cpuinfo_avg_freq.attr);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
>   	if (ret)
>   		return ret;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..a7b6c0ccf9bc 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1194,7 +1194,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
>   }
>   #endif
>   
> -extern unsigned int arch_freq_get_on_cpu(int cpu);
> +extern int arch_freq_get_on_cpu(int cpu);
>   
>   #ifndef arch_set_freq_scale
>   static __always_inline


