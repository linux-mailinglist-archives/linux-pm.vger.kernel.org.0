Return-Path: <linux-pm+bounces-19928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2699EA005FE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711C418841EA
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07761D4341;
	Fri,  3 Jan 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jWSlDaxU"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CE1D416E;
	Fri,  3 Jan 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893741; cv=fail; b=Ezo9ABnufR7nR0fXrZHXeyySKaVc59fk62IgJ4841RTbm8MDJnnSe7XKZCbr3tKApT2YrZxKXGDS+KkFvi3+NwpQeJR/9jmk4G7nDPgjERh6/YxBFi7BOyG53tm7c+FepouaJ3LXEdSvdF5IKn5PFE9T18tdAHiISvCWxniF4io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893741; c=relaxed/simple;
	bh=DNmSM/zlaiHe7y+SpoUtP9k7yyKM9LouOCBuhZSkcWM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T/H3ZzrgiUQDDClKAtB43PU88XOeE2fD38Oo1RqDqFL7m2mGmAt8S0G9jCRFPmHP43jNaJ/jz4Qm1A8fzCZZmfM38yVAEolsrhMGwZuWcYIODCsvtXB0+UEipKD2NtiTTIxSTcEYPhQymVmY1hI17BddXuxB3l2tpMv8mb6I53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jWSlDaxU; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1INAJ/bOnX7waGcQOg7lo1eI9rFoeSWtwOQGlYnLmwjeWgPOp7gf6HtI1fq/FBjkr4n2kV59rkDqf+MBpoG3cttcv17+m9nzwXmGHTw+rZztV1iRNKT3Xi7WqsIFFY26tck06O5gp4SfnMOy0a5EwqmH2s61vWw37rHOP/PYB1/3PSuob3ECeqz9fUrVpUjtDb7cy8hhaq/oAYpLuMI9dNE+Lg7uoeEawLOZwYkK1yW9lwqkIKhMSz1NB7E1x8D8D6CVdnQNQ3BntcOIdXhWpC8tVawaq1BlAlytFOhmcm+xo9d7nR2bdEZV6NEK79RBhsecqLsrt5zQIBZaJD5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS+DM8g/1DZ++lGRTiLrP/ykpiHku6xeI0up7+EwB9k=;
 b=G8pNF5BbMuGi/CHzERuc1+FxxvpeB0hnl60r2JKj0G4ZS9rj9L7yxg2uig/d8Q0XT8uH7GqOk7B252aGTRqDi0b+gF8aP5Aa+mHMsQ/IHLynrLVN0e8RgffBpCwmwJar+ct5mTKj7mXEmrFwNpCL2WNx0tiobGtN3Aq1PbByD5b2mR6nhzUFafOJpeTJDzi/L7Nn0j92LyE+WrlwJb1b8DKuY4F1gi+zJNrUy6wxbkF9RYEXnBkpW/JUbsyD49Rx1HqWaEgAggWxhdcvhNlfmy4EnRXG5j7W0g+JE3UaRUvuorjiJhbOGl2knwUQcCjVrvb4yhYiRvoUO0Mflood/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS+DM8g/1DZ++lGRTiLrP/ykpiHku6xeI0up7+EwB9k=;
 b=jWSlDaxUOQPubjn6YnL2IP/M+C+3hKl4+vaCFOPmLstSF89B5X4SBcyj0CPu9YCKlLrGY7socGCUmjUwMDi/79U4buZMFp3lHDIw4XHEJb80jokM0AqqnFqkmQBcSvqzd8CaXvMZ06ifKhkilWmPqZKgR0nNLyjFnvBdQE9zgpsmynnD+Ro03oI1u+84ClpdX1fSGCopZ116KYRdtr6BSv4PReC+FI1Gw08Z1juCKrFQW1eozfnVlXleyZs3Z1BLo1CvZPjBSpzXYMWzNkjwAPpmMY7X688/dz3tYWGNii7X3/Wkq2EwczsCBjtjABg2b+StvK/FIOzCNTRf/Lm3EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:15 +0800
Subject: [PATCH v2 03/12] input: keyboard: omap4_keypad: Use
 devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-3-e3aeff5e9966@nxp.com>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1365;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IYFb5BcVnaCb3uUN830r92UAprUHpPfeHJSpQKDJq+A=;
 b=6nu0OAi33ocm78dkg6STG8L8Ee09UFhiaBJdS99JJA6i/e2entTy3W6z8anPmAJRyKnEZnYOi
 xtZqte/I1oQBSVE2uCc1ceFZ+1I7C7kgC1MkG7VRwOXgQJV3b/Wu1qH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5b7492-0c39-4819-01b4-08dd2bd284c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z29PZ3EvbXBnd2xsd1FXczhDKzJlYWltU3JUSUJhUjlld2MyUjQyMWszMm5J?=
 =?utf-8?B?RmV4MUlvV0g3UzgrMUFEVHlOcXBzRjkvMDZ2TWZFN3hkaWY5RmltSXJDb3JQ?=
 =?utf-8?B?YUFlYkw4NzFKSWZpR2pvQWRZenpWRmxqeXVLRGtiYm1Wb1E4QzBoQk85UHc5?=
 =?utf-8?B?Yzc4bUlxUU43ZUlJRDBQNFRKWmxnUXBrMjc4REF3b0hpMmtsRmRhVUxEaVVW?=
 =?utf-8?B?SlAyWFZSU2hOdVBwSzIzN1dYQ0padlVKVm1jRlRCYnRndmRTbmxsbW45WjVD?=
 =?utf-8?B?RFpJelg2UEVZbmVkRk0yc2d5RXFZLzl6UXYzdWxGbjduT2I3RGdtME0ydjN6?=
 =?utf-8?B?T0tpNGRwZSt0N0thNmF6VHBPNjNmR2dPWkpOWTRpcWJwQjkzcGxMeHN0emEz?=
 =?utf-8?B?MmNSYjBsVDg0OTdZdk8xcm9QVVR3K0srR3JLOXU4czRGNUk2eHlXRTFyQS8y?=
 =?utf-8?B?cWlPOW1adEM2NWx5RFJoL0I4enNkSjFndWpSRTRtMmlmYVg1ZUVZQ1Z6eEhi?=
 =?utf-8?B?ZGNuVER2NEFUQ0VMc1JoRkVUVjh0UHpCbHVYZHI1VGJEcnR4SUNtdjJpam95?=
 =?utf-8?B?RVQ4Z2xtc1JjR1NYWlNEak9raDRqNUhxUHdjWkIzVVlEODBtRVd5cVdZc2Jy?=
 =?utf-8?B?ckgycWhoeGIrYiswNnpMMjZBV3cvMUtCcUZWTTIwYnQyVTdFbmVUcFZaM0h0?=
 =?utf-8?B?UmN0NHQwa0VaVGNDRE9XVXk4ZjcvSWl4RjVPL1RHUjdZTmx1YVMvdjhYVHZB?=
 =?utf-8?B?K2ZDMVZnRWZQWmprMjZaRk8veEtlLzY1U0ZsYTFUaFcvUmpqZ0pVTW9XTE5B?=
 =?utf-8?B?WGRPNkhBTmVMcTBkem1pQzE1dTNPZVZLamNiRGRTME15eXRPTmFyaFA2TzU2?=
 =?utf-8?B?ZHZuYkRFLzRXU0wvYW16ZldrTUtTNWVoNVZaenB2YkpnWDQySEN4cXBQdzI1?=
 =?utf-8?B?cmczQ1RoYVhGSE51UHhsWTVmZWZwVCtZVTdKNGlzekJOa1pRTVY0ZWtucFBE?=
 =?utf-8?B?NDM4UzFtWEJ3UGpPWGxleXZzNjhBRFc4SFovQzIxYlBTZUYzM2V5U1RYWEVx?=
 =?utf-8?B?aDFRemdTbDdOL3ZtRFlzR0lrMDhDR1NoWU5MenNYK0UycnhtazBJelAxRk9R?=
 =?utf-8?B?ZHlEWXgvdVh0ZGdYRTE0ZWx5bWxvRThGRnNQWjNKUmYzZ3BEWENZSTUvaVJJ?=
 =?utf-8?B?Y3ZpdmowSThKNktWcGNXSHJyL011TVovb0dEa1c1RXhxVDBNSEZoQnRBZHF3?=
 =?utf-8?B?TnpaaFR1ZEJmUDNUcXFNWGdtbjY2YlNOa1hzZm54UmR4RUJnb3FhdEtXMHcr?=
 =?utf-8?B?bmFWK3pIL0Q2MG9NbGx2WjIrdEptRE8rMzhWNCsweWY1R04vaUNUSmw2NHdn?=
 =?utf-8?B?elFzOHg5SDhnN001Z3RVSndHaWNqZEJCMEpCSmUzU0Flbjd5d2hmQ3lvVEFB?=
 =?utf-8?B?QmRwWUp0ajMrQktHeTNlOFFkeExGY1FWaVBsWkFqcUx6OUZCMHExNmhwKytx?=
 =?utf-8?B?d2hGbGg4YVo0VDkxV3BSc1FpNkJsV3hHdTdCVGR0UVRqbjJFZW43aEJvTW1F?=
 =?utf-8?B?K295WnFvbEpJWmNsSkVGS1hWSEZybW5WcmZyUU1ncUVEdjIxY0o4bzJ6b3Jm?=
 =?utf-8?B?Sk5RZjlpWk90U2hNdjFYVFdsQVE0L0R0cnJLenJ2a2dOK2t5aExtSG9PK3hj?=
 =?utf-8?B?MTlYNlRCS1hiR1ZJQ25QdjlTMWNNVGptR0REelhvVlYzWTNJdWlaazcxQ1hl?=
 =?utf-8?B?Y1puTWh1ek9Lbk1vejFqenZvRlo5dnNUUXlONWQ2Y1JIN3FwejA2M042bzc4?=
 =?utf-8?B?ZmxGRTcwbm1xMForM01RdUVzZ1U5VURFamE1ZGdmRlhtSng4blVqckMxQ09n?=
 =?utf-8?B?RVR4TEtScGpHZ0hpY0o0UStwakMxcjRxWjEzNnBZTEUwV01vOTFFaG1QZjd6?=
 =?utf-8?Q?W+1Vs4D53mCaagZSyYoeK35jnU/ROc2U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjhNOTlCY3ptbldjb29xU1kxaGxjdXJsQkRBSWZLUzV5MDF6NlNsRWpLTUlZ?=
 =?utf-8?B?NzE0SytNYlpSTVpDUWRwYnpKSWJobTRjekJZOW9wR05QUkVDRFp5TlFCT3Vm?=
 =?utf-8?B?aVpheTJPVUswNEsvc0FKQXZWMGJZQ0psL0tlQ1pnV2pDZEtOUm1ZMVV2RDdN?=
 =?utf-8?B?WG04NGdKTU5pM2gvaEcwcGZKME53TU1jcndVbkV4OXRhSlVkYys1akJ1Rk9R?=
 =?utf-8?B?NVM2dkZEclQ0dFN3Rno1WHhqOU9GVWxVWUVST0FaUmJOTHJINSt2N01wa2VT?=
 =?utf-8?B?YnJ3Ukd6eWUrT2xPY3MrWW9TS0ZJSlliWnNYY1AvNXU1Tk9DSldONThSd3pl?=
 =?utf-8?B?OThLZmRNOThYaFJuOXRFYWdFcGZ5K21qaXBzT2tad3NzWEtPUGlCbGQ3MWRy?=
 =?utf-8?B?M0o5T3dkZlBtazBHZTJ1cDNkTCt5VWtTeXlRdUxFMUVQc0dzMUxnM0J1N096?=
 =?utf-8?B?L3JRN2NDeDhtUTBTZGZ3bE9UYWdBNjk0Y3piaU9OamJJRHVlK0VrRVdGQjB3?=
 =?utf-8?B?Y3FJR28yZTRINSt2OTJ1eWYwMVRMUkdONmorOFM0bEZMY0UxMUpOOFRmdWJ6?=
 =?utf-8?B?ajgrUEN2ZkY1QzBGSlNQRHNCZ1ZVWW5ZTTA2U1VSMHR1d2lQNldERGRhNlhm?=
 =?utf-8?B?Q2hRZURSVng0R25RYmpodW5vSUxRaC9qWC9aM3RRbk41U2dYam5ISEFWY3Z6?=
 =?utf-8?B?V3phWEVVUUhRMjVISzdxZEZOd1Z6Wk03ODQ3Z3JXWGVpZmV5WXU4Ykx4M0tC?=
 =?utf-8?B?ckZGK3lwRGt1UElZMUljNkcrMTdyTVZ6Z0lKUXJ0R3FCYTViTzRGSVpCNTly?=
 =?utf-8?B?d0xpNjJWSDM3V0w0cXYvNEV0YzAwcndVTFpuTzRseG5RN1hESDU2L01lQzFF?=
 =?utf-8?B?T1FSSmJaa3hHWjhuTGViY083VWp6T0NyTnk2aDAwZ1hNaUpzWk9VYnVMQkNn?=
 =?utf-8?B?ekhrN2dQa3JKLzBSeTZMWG85ZHV0MHVhTE92TWR4WVpzMS9lcjU2eXlWTFhW?=
 =?utf-8?B?M1FQOEZRamg0dk5DOEZwbkpHWmtiaElPK3RIQUpTNUNjRUhPbFNMVXZsN0xL?=
 =?utf-8?B?dTBkSUFoMllmbmRvTnlUTkRsUE5BYVVQTGNnZzBvTFFHWk5wMmZrRm9nZGt3?=
 =?utf-8?B?aDZxNGhueks3SWdaOFFzdEJ4VW9qU0dtRDU2UTZ1VHVzOGhIems1aDYwanFR?=
 =?utf-8?B?SjhPcDFqd1BOZXArNUh2M2hwRU5hYjFEU293cWwxRUF0YW4rcXFmcEI5eVpp?=
 =?utf-8?B?WHgwb1RiQ25pcWpVS3JCcUtGSFRzenNhcDdDSzRKV3hVVGN5ZW9ZbmRxbFFX?=
 =?utf-8?B?cnBPSHhKU1Ayc2JrYWFrVE83cVF4STczS0FOS09QSG9JMXhNSnVIR3F6VnZR?=
 =?utf-8?B?V3BoZmgxaDZ4dEM2TWxEdlRrTStTTVlaU3lEd1RmbXFTd0ppUHlQOGprZVFn?=
 =?utf-8?B?UFgzaS9yVW1ndnBBT1N5ZVB2U2MwRnA4RFJNaUNOZERPK1VkOEpmRFhGaXpp?=
 =?utf-8?B?T0NFbFFLSXNDUkF1WGdJNXRXR1haQmVLZS9iS0VHRUo2cjlrTDhEQ2p4Undt?=
 =?utf-8?B?RVFpTDEwMXpEVjVkT2VkNEg2c1B6RTRadSt4bmRyeXlCVHpMWHBzYVpSYVhs?=
 =?utf-8?B?K29BR2RTWWthalkvK1Y5ZVVhZ2hXbWM0QXNObVNDRVh4TUZDTERjNytPMVJk?=
 =?utf-8?B?dEVZK1RCeTlmZTFyWkhQM0hmRFBrSjArU0ZiY3ViR2Y3N1o5c0htQWpnRC9P?=
 =?utf-8?B?VHRxVkJGWGlnNmE2RW9iS2RONmowR3FybDlSdHg4enpKNDFocm5DbjBybXo4?=
 =?utf-8?B?WDlmTFlMVXRzL09Vb2JzdVFEMSt0Q3ZMTzYxYWcraWtXWjdYS29VYUF0SUts?=
 =?utf-8?B?aWxJdnY2cTBxcGFMdklScllKU0FIT1JtY2dvdlVBYVVoQms0d2hVNWM1VGFq?=
 =?utf-8?B?K0tWMkFKVGhLeCs0dnF5OE5tUGh0a0NFdnBDcUdCaGc5L0dJZ0x5bzAyMXVD?=
 =?utf-8?B?aVpVa3BSZjl5VGcyUVl3ZUJ0SzRVRjBtZEtNM04rc1JESGpuUFl5OFpUZENq?=
 =?utf-8?B?K0RsQzEvZFZOaC9oZ1dKZDJmYUhvUkdXNjZweE1aZm9mTmtJM1lveEhRWkFt?=
 =?utf-8?Q?huFiG84gEMVSi/l0W8N5gxS4R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5b7492-0c39-4819-01b4-08dd2bd284c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:12.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Al1AcWcXpcHbku+hg+Ivet65cdghWEwt0RvJoVscmF2Q0J6rZ/3D66Ut26X+mtb8wegDuWZFl9vECayGhy7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/omap4-keypad.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index bffe89c0717adf9ebe5b33892efa4dc30b158f83..b7bd649d1628a6bf10db4135f73778f62db92647 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -465,18 +465,13 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(dev, true);
-	error = dev_pm_set_wake_irq(dev, keypad_data->irq);
+	error = devm_pm_set_wake_irq(dev, keypad_data->irq);
 	if (error)
 		dev_warn(dev, "failed to set up wakeup irq: %d\n", error);
 
 	return 0;
 }
 
-static void omap4_keypad_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id omap_keypad_dt_match[] = {
 	{ .compatible = "ti,omap4-keypad" },
 	{},
@@ -485,7 +480,6 @@ MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
 
 static struct platform_driver omap4_keypad_driver = {
 	.probe		= omap4_keypad_probe,
-	.remove		= omap4_keypad_remove,
 	.driver		= {
 		.name	= "omap4-keypad",
 		.of_match_table = omap_keypad_dt_match,

-- 
2.37.1


