Return-Path: <linux-pm+bounces-26015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B955AA98248
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF767A147B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAD270552;
	Wed, 23 Apr 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="vPogSizC"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023140.outbound.protection.outlook.com [40.107.159.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EF26A091;
	Wed, 23 Apr 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395397; cv=fail; b=IFkXL5pdLp2zbYgtl0flgMOi1TDD2+KRTHc35L6pJmg4Z6tNRc2L2E03DrBj18NC+Cxzd7WcDNCLBnz/yvXGkcpEui5VPkpKQM033n2LacKhFG+6RFp7XYZ5tm+FLAIYzF0I+c8AMaDJGJ5DjdkQwxtWwhcUeWeJCMztHxPbcW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395397; c=relaxed/simple;
	bh=i6LtnvFzmbfsgNlsbyyRhJpSkTRAG/SV0wBAUS79Tvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBvN18ncFagJrzs4mTPjXjgHLkEnPN/adQ1ohBMdRNP7XVvB3VQaxvm8HIyw3cCKfubBNZ3h3g2cJklJgz1BSBf5nsFboaCY1xirGmAi0Rcz4rvuBI31qrlUOjp+EozSctjdcd9EKZAvjIAiiinqp67GFOUT63bJmCue5hG+vJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=vPogSizC; arc=fail smtp.client-ip=40.107.159.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgkSwXN6TFVIF+jKJHrKHwdjUDsOJ3AcRskIwu5w82r4P2A5GLYia5t+Eiuf58qXukt1IUI4q4Zajm4UJOjbAPcxtjX9bU5B6dG8IO6W/ImC2F7kurDlhU9eL4i9jWwUt5NPro/T0TNjGIfthERg1UpSHadqkLN7vq6qSX/P+P2RB2CdOs1juR///nkeXjyjXsioo14RkEzQ/DUPPlqMJjoQACcTB6vQVe2IiX5wyRv7ke3ij7DzSYOU1LI5shYgOrFDViY7+OzrY9184dHUJ4fDmvLzHLu/ZY1V8asdYlfc3ieWvWgOzzzNnQaNQiiXOg/HJ5PPP+jV5n7zhw4XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si/BjLdgTECFe61XnV3RgTOIj1fXFgFcE+AI6i5Zfog=;
 b=tK6eElH1cjN0VDO9CqUNw1en1iqXd8x48reyRixq490gL1suDOjJBly4BX/7jZ3ikCBuIf6djw+c4RAJ75Ih3UtoSEo/yhWyoQPUdvpR84mNUjBhtkFId5p8uHzolnVGNzydgF14yHuzXH400LJWbxwCavkWdChoesXkDQjCIYVGUYvd2shkcMRcoRHg4sCXclWoYKXqWmmj9gg7y6yEsQuq1JPK6iOUwuvQ0XpNdA489ghwjSPxPaMZu/HdR2d8RBaSEFvEUtcCV5bN/Jtz31Ikl6RAL5eRgXoh4Lar3IiZJnBFg7FfBA9T2xiLp5WbcTyQhfL46AWuxYHY9cbcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si/BjLdgTECFe61XnV3RgTOIj1fXFgFcE+AI6i5Zfog=;
 b=vPogSizC3qbzWOwntnGEw6a18QBWlcOpzfEkdoKUjkX89HMxyH0dv3lzoZRqQZtnPkrngpPkV38LYLHCfzc6a6ms4/7usf8wvoglTf4Shr8PBo7mMjyzdOLm6yWm2IWqz/WglxDxDNsoCVqxDxRLT/hno2ies+hBTeHUGpurBn3pBsTZpJFywL/EC5IEqCYuO14WMewi2fMjYH4iW7Mc1SF9HzV9UlDp30sYcNQeIeEQ8fuNMT7gVIOLwlFur7iuck9zMDoEIRLewLhx+ZoAE943UwVUd+wKdV3HCtVkoBr7ClKL+m6/VzrY4HdB2vNXfDkoZh6Y7Qs7Y10EFaeGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS8PR03MB8570.eurprd03.prod.outlook.com (2603:10a6:20b:573::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 08:03:09 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:03:08 +0000
Message-ID: <e9f11aa7-f0a6-465b-8387-668bcebf4f76@uclouvain.be>
Date: Wed, 23 Apr 2025 10:02:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] power: supply: add support for max77759 fuel gauge
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-2-50cd8caf9017@uclouvain.be>
 <20250422184801.GA395455@legfed1>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250422184801.GA395455@legfed1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::11) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS8PR03MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f35597-e5b8-45da-f4ab-08dd823d48b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lRK0prNDd0bVJNTU9zYTloTXVzbXd4TXU5SWhERy8rTjd4QVRzNVJ3NEZ4?=
 =?utf-8?B?MzZGZlZLMFZVSWZJMzJUdFh6a0lOeFNWUnFxNExrNHlxMGRXLzRFWGdrd1gv?=
 =?utf-8?B?TTQ3bG83Q3FGSmxydGFVVjlaYVo2Vm1QTDc3Lzh6blBibVlqTll6TjZhTVhr?=
 =?utf-8?B?c01pZmdnUnY5UkFlOG1yMkl4dmdGZ29kWG1hSVNGeTVjb0tQbDk4YmNiQTJ3?=
 =?utf-8?B?ajNOazRYYjc3RGpKZVBHakZRWFJYbXNYNkdXVkRXLzNrcEdPZjB6NUQ4cnhR?=
 =?utf-8?B?TW5QaDBMdStsaEpQaFpEUndRVkk4ZUdVRFFsemxYbDZ3VDdNeXIxTjFoRmZq?=
 =?utf-8?B?ZWh1Z2luVlRIQ21DcFp2M09uTTJhVEFpdUVlRC9HL0JDd2RQYVVMbEk0VGI5?=
 =?utf-8?B?cmxvZW9YWjc4NGMza0xFd09vS3QzREh2dWNoS2Q0Zmt1SDE3b29DcGVxOE5U?=
 =?utf-8?B?cnVLU0M4VG9uRlBSODA0djVhcG80MXN2ZlZkcmxxQTFVaXlSOVZya3R2cXJz?=
 =?utf-8?B?MHpTS1JmMUp6Mmg5dGNzM0dUTG5wUWYwYTVPdUZDZ3Fhd1lDT25XS3dMaWlk?=
 =?utf-8?B?SjhkZWhTdkFaYTZmTGFUVi9VOFZIRG92TTVDdTNvSUJLWHBVektncUN0aUZ4?=
 =?utf-8?B?UzlFZHBkLy9jWStlQnVoZ2VSaG93L090dllSc1VtYjJtcnFTb2NSdXZtOTFE?=
 =?utf-8?B?QjMvT0Qrbmlmc2NCZnZFeVlsckcyd0VQaE5hQWxiNWY0b29OeVJya3dqN1Fa?=
 =?utf-8?B?WnFDSTU5bGpZNUFTbHNxQmd5ejMxajhJM3FneEorTUl1ZTlDMW5pRktwdXRy?=
 =?utf-8?B?SjB0c3hCdUhHZVlmLzJtcmxtcGZOVjQxWElpa1NVMW5rN3Y0dkNBbGVKUTl5?=
 =?utf-8?B?MnQyaWorcGhVT1IwM0pKOTJ3RjV0QkdwR2tkRVRZMVdQUkN5aU1xZlMwU3NK?=
 =?utf-8?B?Q3grc1JWZFJLWHVLVjBOTEE0VldtTE5tWHJvUlJVVWp1cE1pY2gxVkVmcXd4?=
 =?utf-8?B?TjRDUElZTDZVS2UrSTNnNERkdkFVcDFoY0IwRUV3dUVmUiszSVlTNE5yelhw?=
 =?utf-8?B?alVtTWNUbFZ3R0JYWFg5bXVYZUpEYzhNNlpKdHB0NlhqM2tKY09vVENlS2FD?=
 =?utf-8?B?WThPb3M5UCtlaWV3blFZbVVNY2l6aUx1YTJnWDVMcVgyUU9UVnhrWDNCVW5r?=
 =?utf-8?B?RC95U05jTmVrdzdTdDVDMFJESkJOSEZoWjdCc0xKK0h2cWpJL1NyT0wvS2xn?=
 =?utf-8?B?V1VUODZKY0JoQlhMOGZLOVo3cTl0c1NjdUpDYThZUDNxL3ZCbWpXMDlqZ05R?=
 =?utf-8?B?NEZham5FRTdmYTRCbVJMZ01LalNQclhHdU1aVi9xbW5LQ1NJZzl4emthNWdn?=
 =?utf-8?B?NUg1cTJpREprdGRkSWVnYkR4ZGJrZ0oyT0lDdGFSWXRxRzdZWVdsc2xwWVcw?=
 =?utf-8?B?d2NUTjloZlA3Rm8vZjhZN0RGbnV0cG1NQnlVTnIzRDZ1aUFQeWp2MHN6bkRa?=
 =?utf-8?B?T1A2M2s1cEx1NW9QUWx0NklaNmRralVWVUZmNjhyQ0VVOGF6MTVBSnoyWkNS?=
 =?utf-8?B?dFZXZHlmeDJnTTJtSXFzdmIzbmw0ZWRTdlExbnV0NTlMTzdRQkZaYVJZano4?=
 =?utf-8?B?dHB5b2thYXhpUkNiaTFBdWpLQzNqaTJsVXBtVWZjMGpJRkk3N0JicXp6SVlL?=
 =?utf-8?B?cFVPT2JiOSszZmpDVmsra2N5M2Vtd3p5eDV6cDYwN3kzMHFJTy9iNU9ERWk4?=
 =?utf-8?B?SGZnZEZsMU5HSHZ2VDNDblRHR09KY1EvRldaUFg0dnhLaHJzQ2lIemZrUXoz?=
 =?utf-8?B?WS9ieVZxaU5vYjd5dnduK2xhRFA0OGpXa2w4b0xHUERUclBvZkRZRm5KRVA1?=
 =?utf-8?B?a2xGbU51ODU0T2NNVUxXUmxGM2h2ZDhvZjdPU2drYVpjeDhDamhONFNYdVF4?=
 =?utf-8?Q?9ivrH+IjuQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlh2NWpnV2p2b0FXRUNZaUZKNklORGFnOXArY3UvQzErbGpDUnJUcTVnWXFF?=
 =?utf-8?B?OEl2SGp0NWFvWXdUYkJEMFRIMEh4ckZkT1lJYTJMVFJIaWpQU2xlZU5mMmdF?=
 =?utf-8?B?SmRiMG9vdGo4Y0ltT1ZEQWgwV0JqZ0ZvQXlWMmFjcFhENURNTS9XczNPMU5N?=
 =?utf-8?B?QUdYdThmb3ZHaFVRUktmUDlQS2xPamZoQ09XelMyMW50Zm9UbWJVWTJ2TEx3?=
 =?utf-8?B?ZVZ6cmZiam9ZTDc4QS80OXdzaWtFNitONEhLWjB0ekxRZFlTeEk0Sk4ydDBU?=
 =?utf-8?B?OUVxaUhFMFNnVGVNZ0JRc1VCdTNSYnBWcmQ5cjVzY1k2ZmtzQkFnT1F5azh4?=
 =?utf-8?B?NGRSbzVIbWE3RHNhWkVNd21uenFKUzhCVkZCTGJwQjJBajU4bG85ZHNwUFRz?=
 =?utf-8?B?cWhaYk9EN2dIbjVScS9mREtGdU44dmpVUU1MUlJPUHRCZlJYdlFHVzUxeFA4?=
 =?utf-8?B?dEVCMTMyZzFNUHV5Q2cwR3R0MDUzWi9lckFvQXVTUVNaejVNZXVuZXg0V29k?=
 =?utf-8?B?d3lKZS9JeGk2OW5HdkhrWGtYYk8va3dhR3EwaVBINm9TRWMyR3M5K1RTZzVQ?=
 =?utf-8?B?VEJFYldZZEhZdnliOUFiYU9jR0ZmeXNLRVlWL2M0eU9NQ1JRdlFuYVQ4ZkE5?=
 =?utf-8?B?cE5pTkdwSTdPQVY2UVBjam90OWVWQnV1MlFlR1JPTlhJRGxSR2dSaGtpa2dN?=
 =?utf-8?B?TXVudGVNSE9vcUgwaEJrd3JQeUcxNEo2WHlnbEhjdk55c1RJS3V3NVExOEF5?=
 =?utf-8?B?WGZYSHI0dHZaMnEwWVpqYnZBK3R5amRNdjBuWG53eC9UQzVUdDNna1NqTmx4?=
 =?utf-8?B?N0FQRENwbGpDNm5pcmZCZ3h1NW1kQ3pkYVlBbTB2YUp1ZGlqNFhWeHhscFhC?=
 =?utf-8?B?Z1l4MjBQTmtBQkd5c0gvNGFxTkNSMDNmQ2xXd3k2M0x5VWhpa3N6dUtzblVB?=
 =?utf-8?B?Q2ZxZFgraU15TmJlSGxjUzU2cG5ZWmsvNWNTWjVGTnFja1RwU3VhZDA4OTIr?=
 =?utf-8?B?ZlozUjdaRHZ2RWowaGF6bDdYanhOVE5sMzRZNXFVQlV4aituT3phWi9mWlRY?=
 =?utf-8?B?d2FWb1BmaFltcDhlanhGTm9NSlQrYW5IbGNuSWpKS0hkdlZaSGkvVmsvUzNt?=
 =?utf-8?B?YTNlVWx4SnVYL3JGeTUwZWQrcVV1WU1ZeVdrOE9CYlFjS3RzbzllNHMreGJx?=
 =?utf-8?B?UFpaMXpNUE5pVGx6RTQwNVZGZ3dSVVgvRmJLZ1pBcmRrekk2NWFQc3NJTE1Q?=
 =?utf-8?B?Qmk1bzUwUU5WWW5STHpKZ2s5Zzdha0t3T2l5UGllbk1CbjFlamJCZStVdUly?=
 =?utf-8?B?aFR0U2VienE1SlpEVEFwQ2FEMkt4Z2MrSWZVa096YmdHekNqcWFZUnZkVTlP?=
 =?utf-8?B?ZGdEWlZaRFpCRkwvQjJHb3ZPdW9nbDJ1Mk5FZkFTNmxBMFROQmRQL1JPRXFs?=
 =?utf-8?B?K1ZWOXRaQU9KVTVRZW45dGFVaVk1b0RXT2R4cE15cG5JRkU5SndjSW9nZ3Zl?=
 =?utf-8?B?dDRvTkw5NlRKejlySXQ2d0M5Sk96ejhEVEdWRTlXeTlZQ0o0RDMxTnVKT0Iz?=
 =?utf-8?B?Um5xaXhtL0JCQkZXdWlBb3ZWdFc0U1F2NWhGdmNmZUZlbU1hbk9WSHFKSDFX?=
 =?utf-8?B?bjdRNkJHa1JaVlRxaDR2amtaODZaYVhVQ0FBUWs3RG93eUNobTdKZFYyR2tL?=
 =?utf-8?B?azZ3OWxFYWhMNjJ4WjE3cUtEbmRhdGVpODd5R2U1SFZBcXFNZC9IODZjMjQ4?=
 =?utf-8?B?eElhU2lxdGxRSVp3SURmRmlXSmRRdWVRdXRUeUZOR1AzN1VNUGRqaTVLL1NC?=
 =?utf-8?B?RHZlOHBXTEp4RXpHTVl3NUVWaFdyZDE5ZHVKeTJMdGF5cnVRVytCY1dZK0hK?=
 =?utf-8?B?YXBueDdCdGlqR2R3WnhxMmxFcllLNmhNeHlyV0JHUzZuYVkzWm1Qa2Z6WHlB?=
 =?utf-8?B?NVA2RDNNSHRHU295djFjRFdEQTVyOGdxbUJ3cTc0U3I5dHNxWXl6dVN4L0Y2?=
 =?utf-8?B?N0hwZDFrRkVSOHV4OUtHVHBUdG9ROFVCNUFJblBMaHV6VzlyT2w5TGw3bnhB?=
 =?utf-8?B?dmExNml3Njlobkc3MU1jQ1Rlbk5yc0VKaHpNcDVyL0hBMmdPbStwbSszQU5G?=
 =?utf-8?B?V2FKU0J0TlNiZEJCZTc3Q3lxYlhIUVdQY21zbmRVc3pXeGU2TXV1QnlBaTZy?=
 =?utf-8?Q?tUapsxzv9zOevaQdghVHhH+extk6V0JYK8N+UFxHHSYS?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f35597-e5b8-45da-f4ab-08dd823d48b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:03:08.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV1utr0q7maTM3PC5gREnM2QxhJRf3A7uc0GKje1lm7gsIgV8GDACHtB6uxqn/1xq0o5rKMmEYwAN2kXkhjBqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8570

Hi Dimitri,

On 4/22/25 20:48, Dimitri Fedrau wrote:
> Hi Thomas,
> 
> On Mon, Apr 21, 2025 at 08:13:33PM +0200, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>

[...]

>>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
>>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
>>  #define MAX172XX_TEMP			0x08	/* Temperature */
>> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
>>  #define MAX172XX_CURRENT		0x0A	/* Actual current */
>>  #define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
>>  #define MAX172XX_FULL_CAP		0x10	/* Calculated full capacity */
>> @@ -50,19 +51,32 @@
>>  #define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
>>  #define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
>>  #define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
>> +#define MAX77759_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
>> +#define MAX77759_DEV_NAME_TYPE_MAX77759	0x31
>>  #define MAX172XX_QR_TABLE10		0x22
>> +#define MAX77759_TASKPERIOD		0x3C
>> +#define MAX77759_TASKPERIOD_175MS	0x1680
>> +#define MAX77759_TASKPERIOD_351MS	0x2D00
> I think it would be more readable if MAX77759_ defines are separated to
> the MAX172XX defines instead of mixing them up.

Will fix in v4.

>>  #define MAX172XX_BATT			0xDA	/* Battery voltage */
>>  #define MAX172XX_ATAVCAP		0xDF
>>  
>>  static const char *const max1720x_manufacturer = "Maxim Integrated";
>>  static const char *const max17201_model = "MAX17201";
>>  static const char *const max17205_model = "MAX17205";
>> +static const char *const max77759_model = "MAX77759";
>> +
>> +enum chip_id {
>> +	MAX1720X_ID,
>> +	MAX77759_ID,
>> +};
>>  
>>  struct max1720x_device_info {
>>  	struct regmap *regmap;
>>  	struct regmap *regmap_nv;
>>  	struct i2c_client *ancillary;
>>  	int rsense;
>> +	int charge_full_design;
> Don't see charge_full_design is used somewhere besides reading it from
> device-tree and it isn't part of the bindings. If not needed, remove it.
> 
Its a leftover of a previous experimentation, will remove in next version.

>> +	enum chip_id id;
>>  };
>>  
>>
> [...]
> 
>> +static int max172xx_cell_voltage_to_ps(unsigned int reg)
>> +{
>> +	return reg * 625 / 8;	/* in uV */
>> +}
>> +
>>  static int max172xx_capacity_to_ps(unsigned int reg,
>> -				   struct max1720x_device_info *info)
>> +				   struct max1720x_device_info *info,
>> +				   int *intval)
>>  {
>> -	return reg * (500000 / info->rsense);	/* in uAh */
>> +	int lsb = 1;
>> +	int reg_val;
> The naming of reg_val is somehow confusing because of reg. Better rename
> it to something like reg_task_period or similar and reg_val should be of
> type unsigned int. 
>
Will change in v4.

>> +	int ret;
>> +
>> +	if (info->id == MAX77759_ID) {
>> +		ret = regmap_read(info->regmap, MAX77759_TASKPERIOD, &reg_val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		switch (reg_val) {
>> +		case MAX77759_TASKPERIOD_175MS:
>> +			break;
>> +		case MAX77759_TASKPERIOD_351MS:
>> +			lsb = 2;
>> +			break;
>> +		default:
>> +			return -ENODEV;
>> +		}
>> +	}
>> +	*intval = reg * (500000 / info->rsense) * lsb;	/* in uAh */
>> +	return 0;
> nit: add newline before return.
>
Will fix in  v4

>>  }
>>  
>>  /*
>> @@ -306,6 +420,28 @@ static int max172xx_temperature_to_ps(unsigned int reg)
>>  	return val * 10 / 256; /* in tenths of deg. C */
>>  }
>>  
>> +static const char *max1720x_devname_to_model(unsigned int reg_val,
>> +					     union power_supply_propval *val,
>> +					     struct max1720x_device_info *info)
>> +{
>> +	switch (info->id) {
>> +	case MAX1720X_ID:
>> +		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
>> +		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
>> +			return max17201_model;
>> +		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
>> +			return max17205_model;
>> +		return NULL;
> nit: return NULL in else case.
> 
>> +	case MAX77759_ID:
>> +		reg_val = FIELD_GET(MAX77759_DEV_NAME_TYPE_MASK, reg_val);
>> +		if (reg_val == MAX77759_DEV_NAME_TYPE_MAX77759)
>> +			return max77759_model;
>> +		return NULL;
> nit: return NULL in else case.
>
Will fix both in v4.

>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +
>>  /*
>>   * Calculating current registers resolution:
>>   *
>> @@ -390,19 +526,31 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>>  		val->intval = max172xx_percent_to_ps(reg_val);
>>  		break;
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> -		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
>> -		val->intval = max172xx_voltage_to_ps(reg_val);
>> +		if (info->id == MAX1720X_ID) {
>> +			ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
>> +			val->intval = max172xx_voltage_to_ps(reg_val);
>> +		} else if (info->id == MAX77759_ID) {
>> +			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
>> +			val->intval = max172xx_cell_voltage_to_ps(reg_val);
>> +		} else
>> +			return -ENODEV;
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>  		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
>> -		val->intval = max172xx_capacity_to_ps(reg_val);
>> +		if (ret)
>> +			break;
> I would keep max172xx_capacity_to_ps as it was before and add the
> calculation for the MAX77759 after handling the MAX1720X case. Creating
> a function max77759_capacity_to_ps that further processes the value
> calculated by max172xx_capacity_to_ps or just inline this code.
> Otherwise the naming of the function is somehow confusing.
>
Will change for v4.

>> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_AVG:
>>  		ret = regmap_read(info->regmap, MAX172XX_REPCAP, &reg_val);
>> -		val->intval = max172xx_capacity_to_ps(reg_val);
>> +		if (ret)
>> +			break;
>> +
> Same as above.
> 
>> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>>  		break;
>>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>>  		ret = regmap_read(info->regmap, MAX172XX_TTE, &reg_val);
>> +		pr_info("RAW TTE: %d", reg_val);
> Remove pr_info.
>
Once again debug I forgot, sorry for this.

>>  		val->intval = max172xx_time_to_ps(reg_val);
>>  		break;
>>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
>> @@ -423,17 +571,15 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>>  		break;
>>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>>  		ret = regmap_read(info->regmap, MAX172XX_FULL_CAP, &reg_val);
>> -		val->intval = max172xx_capacity_to_ps(reg_val);
> ...
> 
>> +		if (ret)
>> +			break;
>> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>>  		break;
>>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>>  		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
>> -		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
>> -		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
>> -			val->strval = max17201_model;
>> -		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
>> -			val->strval = max17205_model;
>> -		else
>> -			return -ENODEV;
>> +		val->strval = max1720x_devname_to_model(reg_val, val, info);
> Wouldn't it be better to just inline this function ?
>
I think my reason for this was that this case became quite long and indented
compared to all the others. If you think it is better, I will inline it for v4.

>> +		if (!val->strval)
>> +			ret = -ENODEV;
>>  {
> [...]
> 
>>  	struct power_supply_config psy_cfg = {};
>>  	struct device *dev = &client->dev;
>>  	struct max1720x_device_info *info;
>>  	struct power_supply *bat;
>> +	const struct chip_data *data;
>> +	const struct power_supply_desc *bat_desc;
>>  	int ret;
>>  
>>  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>>  	if (!info)
>>  		return -ENOMEM;
>>  
>> +	data = device_get_match_data(dev);
>> +	if (!data)
>> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
>> +
>>  	psy_cfg.drv_data = info;
>>  	psy_cfg.fwnode = dev_fwnode(dev);
>> -	psy_cfg.attr_grp = max1720x_groups;
>> +	switch (data->id) {
>> +	case MAX1720X_ID:
>> +		psy_cfg.attr_grp = max1720x_groups;
>> +		bat_desc = &max1720x_bat_desc;
>> +		break;
>> +	case MAX77759_ID:
>> +		bat_desc = &max77759_bat_desc;
>> +		break;
>> +	default:
>> +		return dev_err_probe(dev, -EINVAL, "Unsupported chip\n");
>> +	}
> nit: add empty line
>
Will add in v4.

[...]

Best regards,
Thomas Antoine

