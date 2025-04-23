Return-Path: <linux-pm+bounces-26012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC48A9818C
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B6B3A7AA8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19426B959;
	Wed, 23 Apr 2025 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="oAsYc4zC"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9ED270559;
	Wed, 23 Apr 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394542; cv=fail; b=Gkk12lx7gd9Z1rSD56arbjkjhR4bqDH4zndGzlWboEXiqx+xLBdAeznVBOEy8VBRbDxRw43gvmIK3SqGq1uXVnG11V54e/cAanoWrbiB9iVhsfw5oNdPX7kTF0+ohec4tjw1To+btb5+lqFRXJmxF9oJKRw908xP1/HgeNoqfdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394542; c=relaxed/simple;
	bh=bWFK/JJGitzioILdpcravCYIHz/C+iRMZhVCFH2Y57U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRCwmcx/mQPKqdtxDuqezpNI3vGtbAl+h9GBovX5X6Ir0u+QGOGsSJGskVavudt7gfYkH8l3MDypagxpVy+3zYAykfCJQWeMPvT6X7ZrtFuTc/UlJXvUe2SFpodHY9TmDg/5jSzX3pf+9TONRV15POC/VYWFy/mTtQNocz+AP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=oAsYc4zC; arc=fail smtp.client-ip=40.107.21.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBZH+Hl1zpnhFk7h0j0157g6rHSI2oYFhbmuhZiyHHfatBT6M0tefLHPkw6VMvfftPQydP0LsS2TFNed3CgXJwy8zISeePDYOB+30y+8gRn8LWvMuI6Msyk4TNK9wnabVdc4BbjozTKVmjTG24xDz1Lwtp0+lIoU9hD5d0U1gIMHjgfka4Pgpdh38DByiditbjJY5qrVCA/RTAyzk7teyrpIH1LtPlhefZB/307OvT9o9WmaITLhs0sxlsjBZXq99Iln77TBbM1WiWTk2nsB0GBoj/jSbNn1V8D9X5PDAHCfcvcwE5Jzqaz6Q0g+/ykpSl1WRyAmYLjzii1aN+SN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg4tAyStmubLUNoxLtd0J9pQMsszWRSiC3AlKLsQ55k=;
 b=Flc5Q/Wb31mjevIzg1Yiq980BU7Qu4UE2eW1nyVM3JhWzEN6vWkkKOmpeeR5MnXvjchl05mBdtPNM39PasQFAw8m+yimoG55LdpoP0umS/KXjkb3KzF07jVRsND2XIZaqg0Vs7OrRgeNNAUELUNJX715Bz/IyeWCxVClF5A3PPRpkRiffWcz1rYMqcdudZy3T533ZdpgUmQu+/eTjaPpzYT872XaAwaofFUC/WZg5EF3GfIm74jAZiJyCNl/tKitg5M0eryP2dK/wvAuO7b+l+FSOeNUpfaHfr5toHyosX2fdj5LGSvGPNQMVu1NQDOppfTCRcCuRVLTGg96T6HGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg4tAyStmubLUNoxLtd0J9pQMsszWRSiC3AlKLsQ55k=;
 b=oAsYc4zCsmLHgotDwRfh891EUdo1cNlRoKztN54qC8vynmDYzbWUYrnr5seOYgtkzvTLBJHm+lWtRBq2CCw2iPy2+s5KIf8xGXwLJ9qGLxCV8vAlioROMCXWHvjEEa6Yzja1FVsdq+7/5odbVXzykYblgC7gxi6cugwBCBIJ69DaCkysk/euSN7Nw0eVhE8juIsD1/UR60VyjudrvSGncAisNugRpD7Rzxy97lP7NsIdVE/icSDYWtKj2rmJjiEu/EqN6I5K/PNWrJMgXFvA0KcR77UFKSLiZ0vhvAL+VkDf+730c+og6uqNdbf1sgZ+cdJKHGCwlYYB6Z70hTEmqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AS8PR03MB9485.eurprd03.prod.outlook.com (2603:10a6:20b:5a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:48:55 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 07:48:55 +0000
Message-ID: <b972f2db-b67b-41e6-9f41-b3a0fb5f4da2@uclouvain.be>
Date: Wed, 23 Apr 2025 09:48:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] power: supply: correct capacity computation
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
 <20250421-b4-gs101_max77759_fg-v3-1-50cd8caf9017@uclouvain.be>
 <20250422094656.GA159257@legfed1>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250422094656.GA159257@legfed1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::33) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AS8PR03MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 864c2097-a2b8-4325-451f-08dd823b4c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0VlREU0SjVONmxmdks0aDdYeUtmcE5teTgyZkEzT3ZZeElNa1lBMDRKS2gx?=
 =?utf-8?B?NnUyT2QzOVVyWlVuMEljaWQrQWU2Z1RFd2NrZGd4eXltUU5hcWlSdXZLY0NF?=
 =?utf-8?B?WTV2SGw3bHY5bHRPN1NPNmlaTXkxMDcvMUp1TnJLcmRyTXpVVUtNOERWSlNI?=
 =?utf-8?B?VmZ4N0RJVE91V3JJMUlONWpsdXBNbzAzRGc0MjA0VzVtRFdFL1RIRXpyNFN6?=
 =?utf-8?B?R3VIV2VDVWI1QUN1NHNVL0RTemlVMHhQWlBndkw0YmZrMmdZZzk0Sm1Eeks3?=
 =?utf-8?B?ZmRoQ0tOWXZBTWMvSWtVaUxDMVNXeFFvTExWTnVCcEdaY0EwQlJ3OW51L0tG?=
 =?utf-8?B?YnRENitXN3NBZ09PaURaTU1RTjRTcmltc0lGQWdick9jaVZDN01ReEFzb3Rm?=
 =?utf-8?B?UEdPcmRzM3RxVndndG9VL3RXdGVmanFManBoVlAyV3ZuZlIvVG1RN2kyRkxv?=
 =?utf-8?B?ZEFsVEdxaFFIZzdEei9SRjJ4amg2RnBuU1A3VDdEMU9CVHFydTN6ZzJ4cnYz?=
 =?utf-8?B?NW1OSHhjSTM2aEJaTmxJRk81dENSQmJQTXZXWWxWT2FkSm5oTHdBeXRUeHhF?=
 =?utf-8?B?c1E2UUtITmtHekcycDdVLzBtN05XUTVpQjMvSEIyRytLSjhjZlAxMlNPS1h4?=
 =?utf-8?B?VWdDOFFkbnA3QUNYaGdsMFBiUWgrYlZ5Q3YxRkJtYXdvZmRXTVRUbnF4RkVw?=
 =?utf-8?B?WSs5eGpkNW1DaS9RdDJiOGp0M1VOSXdGcldzMVNRdmpNUk41VzFSYjdUQ3N6?=
 =?utf-8?B?KzJELzk1S0kvZzRCdDR5ajE1ZGFIdVRHWHp5NFp3QmFVajZkbFlpcjJOcm9j?=
 =?utf-8?B?cTVZN3dRZlZSVXFHbGtzYUtNNkFIanl6UnhLNS9Xekd5TmdqcG15ejA4TVdy?=
 =?utf-8?B?cWdSVEgxbm95V2JjdnZqVkExM29KRXIrTWlEUUZMazZMZUJkbi9rdzlzdDQ5?=
 =?utf-8?B?Wkd3dTU2R25LTk9OQ2RvVngzNXVPdStRNldNQnpGdHc0L2E1Z0kyV3FvZ3ky?=
 =?utf-8?B?NzRYck1La2o0RWN2U1ZkUU1GZUVvbDhwMTZ1bGJkeVA5SUxKUjBZb0lFMkpv?=
 =?utf-8?B?VndwNXNIdWtVZytZNFlHVTR4cVczd0pDY0RBcm5DdXE0V3VuYmozSDk4MkpS?=
 =?utf-8?B?YUNvbWQ5UWo3eUZnWUZWYjE5VzVYYjZIbGZtSzZqVnEzcjROZlhvTEMvVjNC?=
 =?utf-8?B?OHhkUEtDTmhRWnM1ZHhVUU02NHhDUFViakVjT0hPenc2MW90R1R2OWdOTjRw?=
 =?utf-8?B?TDVmbnVtQ2cyWnFpWW9JRU04SnRCbGVXaTBHS2NZZFdhYVQvTTRINHpSdzUy?=
 =?utf-8?B?S0JTSFprY3NtUEY3VitRUVl4ZXlHcnJBMGlBMkMxd2xQd21YZm96RGpRb1pB?=
 =?utf-8?B?MWdScCtSTG1YbWlIRTgwV2x3QytkWDF5Z0tzc09EWjNkdmxzU3pVRzdmYzIw?=
 =?utf-8?B?SHQ0QUEvTGwwZG55RWJXSVR5SkVYdmlJSkFzZXBmOHJHQlNaL0dZVnM2YmNt?=
 =?utf-8?B?TGR5bGNsUlVvbnlBNk1LMEE2TlNDTEtHSDF3U0FnYXdRRU93ano5OTR0UXp1?=
 =?utf-8?B?Tzd5dWRMTzhLM1lLb0EwVVlKellWWk5wTko0NmRsMDRtRzcvZk9WQzZNamtv?=
 =?utf-8?B?d0FJSkxmYjRRZTNyYW4wQ3VDQ2wvZDY0UmxxVFIwaURRYVB6dStITkpUWkk3?=
 =?utf-8?B?TktKRExwbTRNcVV2OHp4dnRiSWVmaGZaWGVtTm1wTUluSjZMcmczT3NneThm?=
 =?utf-8?B?Smp1M3hYNDgxQzRaOTVxY1ZJNnBHdG9uZnEycnQ1eHByMEZzcnRaQ256VFBx?=
 =?utf-8?B?QUc5dnpNS0FMVWFFVG1KK0d2bVpMc1NtcTM5YTZSdEwycU1lTzFNOXVTbDA3?=
 =?utf-8?B?cFBMSjFndURqaWRndWUzOXQ0TERIVlJoL0M0alJNcTJFTkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVdDdmNxWHBUQjdiVGo3TnRpbG5aSERJa0JLeGp3RWUwTmcwME1RdzdTRXl5?=
 =?utf-8?B?SDlhZ1hzQWpIS0g0T1Z5YkFzMGZFWXRIelluT0RkRmlOZVJvc3RKTDBRTUR2?=
 =?utf-8?B?N29CMGNwb2RMZGZ6ckxZVW1va2E0RUgyUGpTMFIwdmtPYTkvbUdTdEt6a1pn?=
 =?utf-8?B?WDltV3BiYnNGNzQ1VE5PbWFiVzRmcm5YVWJYWE5YamxuQytiT1Z0QVNoR0Fn?=
 =?utf-8?B?TmV3YkZ0S0tFUTF2Z1EzRkROSDIwaEJjWHdxSjBVSG5oQ0Vtd3hvYTdzSmNM?=
 =?utf-8?B?Y1lZS1ZlYy9KTHlKL3RsemlTTzdXQUpqL2NYU3VEdnNmL1dHNXRVRlN0SEJm?=
 =?utf-8?B?KzhDcW5GV2pzcXhOc0RZTDlaUFpwdE5zWU1JUUo4UzhKKzJoNElLQ3lRU1Jp?=
 =?utf-8?B?M0dOZHFTRW01d1FqNTkxTFpYME01SkRVcHFTZlB4R09Jak4rYXk2c2gzRVRu?=
 =?utf-8?B?MFZkQUoyeEsxSzlwbnd3VGl5TU9jbEFablRpT3lxZWJhZXhHcUsxdjRGMElj?=
 =?utf-8?B?cXF1K1ZWcTByU2REU1hmeCttZkdMN1lCR3graVZDYnhJTmFLdW1yRThSMFFr?=
 =?utf-8?B?Nm1tNWhVR0J3QnpucmFBSWdESVhIcHVjRkpzRWpiNkowbHR3aWpyaEFLRFFq?=
 =?utf-8?B?OGFzdWN6RjBycGxlajlPY0hPS2gzY0dLeVZZZmw5Q2p3TjRlYktJUkhFVWM4?=
 =?utf-8?B?T09TWTZJb0hNM2YyZ1Uveml2Y2xLcTlPOWo2UDI3RnAzZWhzc0M5VnF3K2VL?=
 =?utf-8?B?L2ZnRHd0RkM1RU5PeVE1dEN6REdad2FPODdjY0tpcnhWSnpNb1BPWFdFTlFR?=
 =?utf-8?B?UGxzRms1aThJa1kxeFZLdmdYUXFyYzBXYVVQY0NveTFPdkdYU1p3MkNqSlJ6?=
 =?utf-8?B?SS9wckN3emU0VW0ySzgxSkcrTXNHcUhUUVFVdDBaYWdjMFV1aFlzQU5HeGlZ?=
 =?utf-8?B?TGRva2p6UFZDdlFGbjJpV0ttaTJVOHAyV3hOSGltRDJ2TWJCMXd6aDgwaEpw?=
 =?utf-8?B?UWd3MloyZlVCMWo3MXBoeHdKQUZsbjdkU1NzS2ppd3g5REtoSFE0cTBxN0Jx?=
 =?utf-8?B?amd5eHo0eklpdGp5WEV2YzI5MExYaFhCcjMvY2tKcCtqME9WRk40b2o4RndU?=
 =?utf-8?B?cEs1V1ZraHhOK2hEb2l4UHJnMUJ2eGYxMENON1lYRXVmdEhoeGdtRXBWL3NY?=
 =?utf-8?B?a01nZmlnNXNJV2ZpbnJlZXVMWDJIQkpZN2E1TlJZcE1RcmxzRytvOU9rcnlC?=
 =?utf-8?B?cS8xNTNTYXpWR1lvaDJXZkxaV0lWMEIwQm1FZjdTSDhWSDVWN0t2VGl3RkQr?=
 =?utf-8?B?MzR5TWxZYzBrWUpyQWI2bkpGWGFINEdzNy9FVmJYMmJOTVVMSkJaeWU5TDlp?=
 =?utf-8?B?RHlzU2svR0MzS1ZOeERHd0JSWHRMdnNtWml4UGlCVWxOUVJxRDR0aUFJbGtN?=
 =?utf-8?B?cGJpNnUxYjRhZDJ3dGNrTnc2d00rdU5kb0xPSCtGaE1zeWU0emFEQXFGTWVt?=
 =?utf-8?B?amdiZ0hUTjNDNU9HSG1WdzlIVjlIQXc2dHEzQVN6UlZkSHM0dVprYzdTZ2pt?=
 =?utf-8?B?VHg2ZXl3QVgxUlRFdkdEV3BpdFhHczVkUVNaZjg0Mm91a2l3NUNJQytiWG5E?=
 =?utf-8?B?ZTBuQW5pUUx6WWNLMDlJcGo4VFhYcmd0V2ZnV3dWRnNTNFExcklQdDBoam1k?=
 =?utf-8?B?b3NicEdhNHNVaWg1ay9SMGhBc0hTdmtHbmp0UURYVFplejhmODhsNERPRnFt?=
 =?utf-8?B?K0htMElBcFVLSngwbFJobmo2OU1Yb2ZOZzVvSG10MEY5Zmd4eXlIbWZqY081?=
 =?utf-8?B?TStoQ3lYMGx5RlpJVy9Ta0hXVm1oZjBUTEpNbUo2MW1KU1RNU2ppZFkwcjhM?=
 =?utf-8?B?VENIZzRId2ZqMzFwY2tMa1M1bnJsdTd4aUNpbFRlSHBDanVpeUtDampMODBG?=
 =?utf-8?B?azQrOFBqWGZZQXMwQkdZNEtRTUlZTE9UWFJqdStGL09KYjVtTHFKbVMrbFVw?=
 =?utf-8?B?OE8xdmh5dHp6cytWMWlIa1E4dDZWQ0ZXRjBYSkdmWVpFell6c3ZybmVuek5D?=
 =?utf-8?B?ZmM2QzBVRmVLM2tRaGN4eDJnTTBYODMwWm1iNlZ6L0JBMmRiSncybEhrbnJp?=
 =?utf-8?B?bkVxZFNaVHpaRlZ1SkhGUHNIWWZKK0FCck1sYmszSFM1cTl2YnRUSEh6Y252?=
 =?utf-8?Q?hfKMQkCqFqhiYaQCOWbV6SKlJ+oQ2JMVLAybhMWm9a+6?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 864c2097-a2b8-4325-451f-08dd823b4c22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:48:55.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCRdkNVcB8l+KkBUAg67ywu9oyRjfo9j/TEBqCFbi/A5lCKhAiuyQH2Pl4O5LfPqzIPcyMkro7iM0VBuaCm3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9485

Hi Dimitri,

On 4/22/25 11:46, Dimitri Fedrau wrote:
> Hi Thomas,
> 
> On Mon, Apr 21, 2025 at 08:13:32PM +0200, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
[...]
>> -static int max172xx_capacity_to_ps(unsigned int reg)
>> +static int max172xx_capacity_to_ps(unsigned int reg,
>> +				   struct max1720x_device_info *info)
>>  {
>> -	return reg * 500;	/* in uAh */
>> +	return reg * (500000 / info->rsense);	/* in uAh */
>>  }
>>  
>>  /*
>>
>> -- 
>> 2.49.0
>>
>>
> thanks for finding this.
> 
> Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Best regards,
> Dimitri Fedrau

I just realized I forgot to change the function calls in this patch, it is only
changed in the next patch. This will not compile as the function call does not
pass info as argument. I will change this in the next version.

Best regards,
Thomas Antoine

