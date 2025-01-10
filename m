Return-Path: <linux-pm+bounces-20248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC8A09622
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D288188ACEC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EEF211A00;
	Fri, 10 Jan 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="Gj/PDm3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2124.outbound.protection.outlook.com [40.107.22.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEF211497;
	Fri, 10 Jan 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523792; cv=fail; b=gloEXsCCmsBGYkts5mQETzxJf+f9HhthmQC/p2D9FdHVhz0GZw6Jvzl9+3e6GG/WEgJCz0qMG26l6Nj/3I4KwvMxbJCdGRucNvs9CtMepganYnE18/frNhvkg6dsMimFZDzYJQJGJYrU1fumBKZS3/9XtTg/HLkhgVHqGpup27Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523792; c=relaxed/simple;
	bh=LItaeG8jeKaIHSKESrQOcDSFST0MpSwZKht1dq3AAEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=boYrfbvNhqrhICUgGdeWPCIupbrZdzM5lgkuqSXApGohdO79aaOnuc1hXcIQnRZ7sBiToN4CVWakfankMzd8+CimGt+b4N50HJqxs1oFCytdlLWG9gQ0GTNWKgo5wK3xi/zeOf1fKJQNl9mucrQ4d4MUdx2mWuEXk8nyMsHu98o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=Gj/PDm3e; arc=fail smtp.client-ip=40.107.22.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYTXt9fU7cuitySgXp9UkeeM8asfgEk/jkPUL3spPtJC4p7zEEjK69S7kT1s2sZ99HKIX5WHgqUmFcEBXLcrn+IObVsGQlNFtTt86bf1OqrP2PfP0E/aFdpDihgbnop0F3D/XHRSPJnWTTmkIypVi2V8AvfAaF5LO5kxgbDVf5xh1ayR4SET0p9ifCVRrd4nyMZdA0ecXVwI0GU3kq22vXPNMHsyY9cJS3osAvivbYykhXsiMFDpaHichbrBc/CmBsJYtdW4Eu1i69u7g/1QFbkKGyMWCYBaFHLP81AcNaw6qaE9rJrVi/YH1Sg6aTb0RjB8dRzNdSjE2n5LVXvgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1K0zYdHPGQUZZsiUZVo0z58uPHv9FJmkPfbhVyEk8o=;
 b=VV55bQ61EY0GbOlx/EKOjsDnTRgjAdKftGdCQjAT301UkhpUhsEcqfMnWmirqL9pjb7lwv/i3kv8Ap7VLAgOaQBA6/CNYhRxavzdvYcO0hD3WMZ8YDwSdrafftKiz51tll/pOsHk/bKO/MFmkxPgEvc5X/BbwBKTYsfMCNfP0UevspbyRfV4zYINvsXCBUy3rbpLSjI7ILOyJ4nAUeGr9LFJXJUlTorcHvPROlFrdHqrdWsdM3Oyyl/1bY82brrTOKjVzIj0eX6ItlAUh77pkSxxBDVXya5JFB8ahFVKe6rI+fXAKFzmkMKPbpv24j7RlaPkuJ6I3+bkK0mMPTwgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1K0zYdHPGQUZZsiUZVo0z58uPHv9FJmkPfbhVyEk8o=;
 b=Gj/PDm3eJXw0pey6lYcUzBAhOH8Lw8nabiEAfqa+fNSi4XoXiI8UuWUwPZojT5Dgx8LAX8VqGWzGjZiYAbn5wyZnWAps4ObNtdWjkxl/MX+jfSeTmStUwqdIVrGPpEOzSuMpnNQSItxbf7PUGGC/woAzK4Y3HpjDjsOqepzVDoWOqqrKgtfzg1zVSLkIJekq4zW7cbklfYThDFGz6ZWJYj8NZGJs6KZXiCsXuvGf7SIpqvAR52/gkMtsVebCNsKqDEmDATCn/0Sxz6TRDCWV5wPDxdxMcjqy9WGLUKeWIq1mrALOr3Ofv9wzgcdpXYN98CIsZh3VrZnb3FucFXxpjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AM9PR03MB7073.eurprd03.prod.outlook.com (2603:10a6:20b:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 15:43:06 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:43:06 +0000
Message-ID: <5e10998e-92cb-4073-9c2a-3b816bbd52bf@uclouvain.be>
Date: Fri, 10 Jan 2025 16:42:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-4-87959abeb7ff@uclouvain.be>
 <74430be84cb49dc0a7413656a2923facc021cd15.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <74430be84cb49dc0a7413656a2923facc021cd15.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AM9PR03MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b644705-a128-47d1-91df-08dd318d79f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGt0WG5Gd0Q0N3psZnNFYTBDcUR5VmZjOERzWlQxSXFHMHlySnlxT0hhc3BF?=
 =?utf-8?B?NUN3MXVhdDZ5MTFiRVNrUE05aWVoSVJHQzRqR0N5aTI0YzBwYnR6b0owbVBV?=
 =?utf-8?B?OXROTlVnREQrWmxzN3RYdWVEKzZMRjIvNE4zZWI2Tnd0dHVJQzVUQzBkMjZx?=
 =?utf-8?B?blg4K0NKV2J4RTY4c1pTTU4wTGZNblNxREpGK0lUUkg1S0hLTTI2TGFPZkll?=
 =?utf-8?B?NmF1dzV0UFFHcVlJN3Q1aGlXSko5aWxQemZkQnBLZlFTR3FTZTA3NmpIaG5D?=
 =?utf-8?B?bzl0UWMrdjNvbUYvdHdCZE5NOHNNSDFKMnRKU04vbThLaDNEQ1pUNTh2ajNr?=
 =?utf-8?B?ZW1DTVZ2OENFRlZSbnZjOXBndTF0RS96RWRkVGhuT3R6eXc0SUpGRkpFeXVI?=
 =?utf-8?B?Wk5iTHVNc2cyc1NER1dxckJyZ0FEU0NxZTNZa1VPMlEvem5qQldJeVFDVS9I?=
 =?utf-8?B?bHA4ejYzekZCOEx0SkZENENCQlBaRXY0aDYySmk4YVVYMkpVQzFPdE1jQWZV?=
 =?utf-8?B?SldMNSswL2p5OGkwaE1FQ0dySlRXQ3lFdEl3TytCTVRFRks4bTFZWVJ2Q2NI?=
 =?utf-8?B?WlRLcG9UUnB5UHpTY3dqekJPaksyd2ZPNGo2QzRuY1JMNnNkQjhVRjlXSkow?=
 =?utf-8?B?SFNFNjJqRnR2dG8xU0N3VUt4OGUwUU9rZ1BJS2NXUkMveC9mRHpuWGJZemww?=
 =?utf-8?B?K3YyL0owOXRJRmJzTzhOcXJjd2xDR3M4UzBseWpLM3ZlTGFJT0gwSmpUYXZ3?=
 =?utf-8?B?bXlvQ0FLY2V3WnRUTlUwaTE2U29xalJ6bDRSOVR5Nzg5NzhOMkh5Z2RFcXBS?=
 =?utf-8?B?YUlFUXVYcllUaXI0aEFTUWxsT1EvVy9sZXo5ZU40cjIzVGJSWmpnR1BBbGpL?=
 =?utf-8?B?U2IzQXlteTZVT3dlbld1a2hKeXplQ3ZKNXNNTFNva0FIcEIrS244SzlZYTEy?=
 =?utf-8?B?RUprTFlWbGk4a0ZPTjBhTmZERFNCbFdFd3dnbXRRRHF5UE1zODZhRitMcURW?=
 =?utf-8?B?L0VLMzZibkNvYUo1NzZjaE1ZQ3ZJNzFTVVFzUEdHaG94WTVBZDBzUzZMUlV6?=
 =?utf-8?B?ajhIZW1ER00vTlB3RkhGQ2pwemJaYmllTnlvV3FwUStWamlmTTRXdGhwalcr?=
 =?utf-8?B?ajgrU0pKK09CYWtEVTZDOGx3Wi9rb2YrbkpJSnh5dys3dnJjWnkrQUVtc3Jk?=
 =?utf-8?B?bm91MkJOam1CRjhZN1I2dXMzSEFjSTdtNldWM3FvTE5nQkM2Z3JBVGp1RExa?=
 =?utf-8?B?RWN5TXFvZDJac01Id1BuZlJTV2plbTU4SUV3QTFZSk93eTFVK3NtRzMyRmFI?=
 =?utf-8?B?ZW5mMXNBU1BMQmhPSFNxM3AzYTNUTlh5M1FTK0NiYlV5end6WnhGN3FDTEtF?=
 =?utf-8?B?RU5GK1FMMmxMRTljSkVMVy96MW1JNmNDUThaSWlNV2dhN2tnK1lWdElld3gw?=
 =?utf-8?B?K3Z1a1c4QXljWnFrWmF4L0xheTFuWmxubzZUeWVjY1htbVorcTZhMEZ2cmFo?=
 =?utf-8?B?V0lsU2hQTGFObisyL3kzNGhEK28zY1BjK1ppVERPV3o3RVNneC9acFZyNWNP?=
 =?utf-8?B?dktXV1VFbXB2c3Y5R3FTYm0vZ3Y0OE5SOEJzeTVlU0s0NURFNnBYbm03VEV2?=
 =?utf-8?B?ZnJxK0cwZVlTc3J3aERvWmd1amRYR0JZTDN3WVNxYUcrZnhlUU5SRmF4WXQ4?=
 =?utf-8?B?T1gzUEJlMGhOUU5uYWdxbW1wSjZuTjg4djBwa1NXeFlQNEZYUjJpdTNPdmx6?=
 =?utf-8?B?R2MyaGdkOUdleUd6QUVuWWRMZmJrQSs0RXBxWmlwRExFTjl3ZFVJN1U3am85?=
 =?utf-8?B?M3Nwc1NkcWtOYkRaQ1dDSURiRUtxYUVJcWJFbHJiSUNDV1VDZStQUStKV0xp?=
 =?utf-8?B?am1zM3hWN2NJUUE5b3ZRRVM0WklYSGNnNGkvVDdIQ2RJZ3ArTnJnbFdtTFZ4?=
 =?utf-8?Q?A39X++4uy9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEV4MHdXUTBuSmZscFlXMHlnWGFCTXU5UE1DSm9xMDNROUxMRVI3YjJ4bitx?=
 =?utf-8?B?UVphRjBGdWx6ZFFqSi9ob3VNZnMxbGl0Nnhqd1RGdDlscG1MT2pXU1BiT0ln?=
 =?utf-8?B?OHlQMjhmanF5bjNQMysvT1hhWmtmSm9JSjZhMzU3MmJzNDVsT1JRa2tDOGxI?=
 =?utf-8?B?MWhWNExpZUdyNXFtL3dnUDF4SlpFZFBMT01tY0ZUb204WDFUOVpGU3lyOFlp?=
 =?utf-8?B?MVR6Uk93Rk8wOEkxTEZGeTlveUEyZkdMbG53WnhsTUpyTGV2ZE5MaTNFVnk4?=
 =?utf-8?B?UEw4clQyTlZPYXUvaHVuejBJWnVIUlpUV2s4alFiUnZNeldYL3VER1FJc2Jj?=
 =?utf-8?B?TWNuczh1Q1pzTjl0MFFPd3NYWkM5bTZxTS9RUEJxVEM4Wmg3RU9ZcWJ0U0cy?=
 =?utf-8?B?MWdEVlBlbGZMd2xLWkdPcDFQUGYxcWFrRDVua1J5ZGhTUFBORVByc2hKSDZC?=
 =?utf-8?B?M3lPVGtuN2VhcUhBcHgvQXo4a1R1Ujl6YWxBTU5sMzJ1L2Jqc2YyTUV2cGxl?=
 =?utf-8?B?SkZSU0FlUUNhaHFaellMaEplY2lNQUY5c3VQdFM3QnBnWTZ3L2ExK3BsL2xN?=
 =?utf-8?B?RTVqRDJzZzBVNWZvaG5tQ2JKZWEzSGZ5MzVIVkl2c1M1eFpFb1BFOWVVM01x?=
 =?utf-8?B?L0Z1dVhPd0U1RGZOZE0xS0RCRFhHeGhZUUhWclplbDk4WEJObDJhMTl2T0xQ?=
 =?utf-8?B?WWdhc3ZvR0x3eXhCeHdEeGU0WDVhWVRDWENCYlNwbGFyc2lYTmR1NkdyNG1Q?=
 =?utf-8?B?YzdlT1JKdWJRRURQa2NRZUFzUTlJN3BITUY5MXBBZ0x4VDRpaHowdFV3OFhQ?=
 =?utf-8?B?SHNoVU5YMnFCZHBPVFMwSHo5bEQzYXJVZDYzNWswNmgyU1ZndnQ5NkNkdEZo?=
 =?utf-8?B?Q2t1dkdsWFNQK05XQSthQlp6SDc3UE4vRE1VZjVsUWVBN0RuUmkyWmE2ME43?=
 =?utf-8?B?MWU4NTlWR2NESjYxWDdiNWdLWEkvNk5iZXNoMUN6OEFYbUdqc0h5N0NXdkNU?=
 =?utf-8?B?dEd3ZDhpSUJPUWV0SHg0RGFoU0Fwa294TFZ4V1pETUxsdVhPMVNxTllRc0RX?=
 =?utf-8?B?VTBKMUtsREhQVG52dnhDRUdxSXNVcHlKQ2w3NTFXTUxMMWdIRVBRbjNYN3pJ?=
 =?utf-8?B?ZjFUL3ZKZWQ0Mm1kdlFrL05VajlicFBwS21ZaC9tWEI0TzlSbU5KbU55RXFq?=
 =?utf-8?B?ajk4OE11NFdDZDBpOHl3V0M0Q2V5VzR5UmRPQnhDWmdUcG5sRG5iQ3VES2or?=
 =?utf-8?B?ZnVLcHpxTTJKdW9Hb0NESkxLZDlGRW9VemtTbnJFcDB3TkFTbUZOb045eVJ5?=
 =?utf-8?B?b1k2cHArQ0FXSWNFUjhseGVWeHk2TjVDWXh5K2czSTJUUmpxTU8yOHdCSmMr?=
 =?utf-8?B?bXpxcDRtVVI0dTV2bjBMY2F0ZDNuWk9VdGFybmZ6aFNoV1d0SzJsdktLZ1FJ?=
 =?utf-8?B?SXc1NURFc2orOUQreWZCcS9hNVVvSldEdmRRNW1RQ1Q0V09nQ3hrUjVRMkRk?=
 =?utf-8?B?NlFmM2w3S2JJQnJWL3lOT2ppamF2MlpZOXNKRXBFY1AvVHh4amw2eVBHYm5u?=
 =?utf-8?B?Vm1mb1JRRndiL2Jtc1hvVkJwRmF6NEMwL0VBWVJMa1VaRVB3eHhLazdzKzhO?=
 =?utf-8?B?ejd4SVhBSHpLZ2tlMlQvS0htVGdUandvUzhpbWJERVRpYVRiNFkzU0ErcWVj?=
 =?utf-8?B?amJkUU0vTGZlaVVoVGpJWEhjQzdidWxMSzUvVG9reEVOb2xETG1odWFEeG4y?=
 =?utf-8?B?ckFRN3Zzd2U3ZDRGQUNGQXNleGZncmwzWkczZkFacFJTNnFsR1FFRHlXUk9u?=
 =?utf-8?B?RW9VUVUzS0F2TGQ5Z1hjcWd5U2lEYmJjTWNoNlk2OHBhZE8rT0w1WHpJaDhI?=
 =?utf-8?B?WDlDaHliWjJ2RGJFb1UyWEhkZHpDTDJhVzVWU2RNeE9xN3lvWksyVWJ3VlZC?=
 =?utf-8?B?QTVXQmloZXF5czkwMDIrMlh1d2RndWI4RzUvWVExOFdRT2pSS2ErVjhvY3A2?=
 =?utf-8?B?UnNRRGdXRGNTczJJL2pQTVBlemhLMFREZ3RHblVBazdlVzlWNDk2QUJYUysy?=
 =?utf-8?B?a0V2MW11V0tOdTZPc2FxU0taZ1BRcnBmWFZaQUpMakZ3K09JVUIwRlFjNUNt?=
 =?utf-8?B?SzhqamNtNlA3TnA5cE5GTkE3SHoybzhvRExEcUp6bERIL0dkc0kzUm5XREtQ?=
 =?utf-8?Q?hiJuI86wKLEBb9YpftzMnVHFJct5mm21CfY8l7t/9AKc?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b644705-a128-47d1-91df-08dd318d79f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:43:06.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6L7Gct8l/yhSduzsD4Opd/GHkCvbFT2Z0p+ileocqS68DnADrPPhEMR65QHup2Xp4fOrAdgfgcuRbrtABNvUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7073

[...]  

>> @@ -90,6 +91,15 @@ eeprom: eeprom@50 {
>>  &hsi2c_12 {
>>  	status = "okay";
>>  	/* TODO: add th
>> +	fuel-gauge@36 {
>> +		compatible = "maxim,max77759-fg";
>> +		reg = <0x36>;
>> +		reg-names = "m5";
>> +		shunt-resistor-micro-ohms = <5000>;
>> +		interrupt-parent = <&gpa9>;
>> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +	};
> 
> The order of properties within a node should follow
> Documentation/devicetree/bindings/dts-coding-style.rst
> 
> In particular shunt-resistor-micro-ohms should come last in
> this case.
> 
> Cheers,
> Andre'
> 

Hi,

Thank you, I will fix this.

Best regards,
Thomas

