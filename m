Return-Path: <linux-pm+bounces-28788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8087BADA9B7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A5D3A972D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0C1FF5EC;
	Mon, 16 Jun 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lu085h85"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9D1F4631;
	Mon, 16 Jun 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059739; cv=fail; b=CS/OlMBIObL9IZk3KQuo3BedW3v+HXuvwiJNogjww2C6SfqoZaTqXyVH4HUOdUmb6gwz7IH7Y19qMixVb3OBleeYqpS2CYDi+9I2XQ6x0BvPcxSrAii1YYs7rLdYrLeiBS7XSWcqBixR1zT4K2CRdlr3ouKyCrZpJ6sdA/o817k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059739; c=relaxed/simple;
	bh=U8JRj9GBolMDAXO42TEtIUEXFSo8uBHLX577fB6t/PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFxZdQghBIcD5NV8HTv4YXVcnuzVQhtrtwyaLdS5GH7TAIA9Fl08+Doaj4bliCXctChYqwH4GZhEfnQLxVhFME99Le+//mbO/lXfTrmX2TQAYYpvycqmEPjJIrS6u5lLJZf+eoQWSal99wnr0iAMn6FJMnuvqdzy9CabGXJ5JxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lu085h85; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roZQ5+Jclj27VwXFWw1Oa34g5blAut/G0C2DDcfJGHepSPagPiVtXftzMq8BxD86RGJCWF1xRd1buypHpcSl/Rbx5W81M8OaMmNjGYAAcVtm1ezrfZpvWgmRfVj+YgggWCAJrmGihC7oPge5beX/BF1juXokDd6P3//k1WolozoKJoMQVNmRRJKWLS1FQQ1XwoyUMUmxFFlMKKw8+Ps4NcOwhNXGWzms6eZYIF7ikbKz0uyqM49tkGUC7AHdjrIFEMIx9+ATl6yPoVE1fj5yxQ2VIEThJqoN87IukqVsq06K/IpyiU0lL2ATBw4dAc0/IXm1YVBBt28a6iAXdM/Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8JRj9GBolMDAXO42TEtIUEXFSo8uBHLX577fB6t/PI=;
 b=h8v1AmSUS0oq/T3h9MgiawmyJ8bF+O6B9pS69x026m4NTjIvZyFXPA9ky1QRHfFN0f0hooWicjAF5Wea8NmDPPIbKY72ODDw43HpS4rjdVQWFB/9QxFE+c+h4QtPsIKPSMGGFtvwF6F91Cbx03IvzEmeHzSWL9mGqOtvDaNj+I+9gzUethYa5KD0XpaZb0zqcm2ehTDqGGRGRh0nsl1bgfPeOLe0THscoA98ubvahTke3zKNtqx1vU4vqG7djkCO+GZHYUxJuJOn+Q5eIXPICN7KKtbHfPkRi0ZC7CO8leQe4/+BPysfwZ/aBGdLkFyn6YhLiZ7Z9duIWpncFBszKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8JRj9GBolMDAXO42TEtIUEXFSo8uBHLX577fB6t/PI=;
 b=Lu085h85WJIjFdDU3isiPwER+7jOigGjztde62tAv46TBFAF1JqZuqwNrsJ752vZcqjvsSeBGNK1zA6CRLR50hxcJ6HSjDbnVYaQKvhwKzu52BCV7uQqsSKPTLryEvYZ5cToYLK87rcmeNzdUOAfTEokBxC5yuJQvdE6Edo8mhgXXQXUQrx/YaRs5FLvhl7dF7x6fLE+Izv2kH8QAmpdLhM0TEJJfbrHyMXNO0DDYnbpNP5xOLYcnEbexhaInuLtvR+pmJJ2ryL1fHzycI14SDg1NS5tjXYEmwSMalz7W7rPBIP9yht0jxzryhll24zmu/jjBIP8vkUgSxiujm4yzA==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:42:13 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 07:42:13 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Ye Li
	<ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE:  Re: [PATCH v5 4/9] arm64: dts: imx93: move i.MX93 specific part
 from imx91_93_common.dtsi to imx93.dtsi
Thread-Topic: Re: [PATCH v5 4/9] arm64: dts: imx93: move i.MX93 specific part
 from imx91_93_common.dtsi to imx93.dtsi
Thread-Index: AQHb3pIsdVClIJGtfka8M7xauxhJ2g==
Date: Mon, 16 Jun 2025 07:42:13 +0000
Message-ID:
 <AS4PR04MB9386F7BB0586AD1ADEB35237E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-5-joy.zou@nxp.com>
 <27ca7dfa-9dee-43f5-9e97-78de5e964f6e@kernel.org>
In-Reply-To: <27ca7dfa-9dee-43f5-9e97-78de5e964f6e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|GV1PR04MB10349:EE_
x-ms-office365-filtering-correlation-id: 4db7c5d8-fa10-410a-743a-08ddaca94f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?Uy8rTFhseWlGWDdtazRLTjZVOEhCT3pKZTl3OVhCMjRXUm5vQmtVR0MyMnBH?=
 =?gb2312?B?cy9ReWN0aVQ0anBnOXRLakhad1Fwb0FGMGthQnlTM29vMTZ4ZUNKMUlwZjdW?=
 =?gb2312?B?TlpDTXc3aERLT1RlcGFwMEpGelRlblF5QkRadFEwS29rUlpyZE9idWpLWTVo?=
 =?gb2312?B?a3VtYzRUODhJUWpQWDRtTnYxWGQ0YzI5R3NBVVNsRTJLNTJINDJ2NHlidkRI?=
 =?gb2312?B?cmFXK0hLRFBwT09oSkFkMXJxTm9DdmIwdDF0TUtyS3N4RC83c1BUL1BnT01U?=
 =?gb2312?B?UUtvbGdld3cvZFIzQTJQWUJMUmxXVHpWcUhKRXhDa09jQWZmWVJRVEwzRzFJ?=
 =?gb2312?B?NDJoSjlPNzJCQWZYQlRjNWI4Z2UvK3hkY0VqRE1FcTBicTY5bmMrUmw5OWt6?=
 =?gb2312?B?ZEpwOWxMSzR4c3VLOFcrVFFIL2dROGJReWhZanA3Q2JGMXRyclBCd25Kc3Nw?=
 =?gb2312?B?Z1hJaXRQN2craFcwNWk1VEhnbzZZVndYUXQ4MEpmT3N1Sitob2hJdFlMT1Y3?=
 =?gb2312?B?Y1E2WXpZT3JtSk9pSmhBTjhDWEZ5QmZtK2ZYNnNNdzduSHZoUUw4M1ltT2pZ?=
 =?gb2312?B?K3k2L3B4enZIbWtlUXBhWmNFVEJuTE9JMHFjMEVGS3Z5QjFuVG9xbXlVUzZR?=
 =?gb2312?B?SkxBMmpwNVBFMURXUmhSN3BvTm1IQko5a3BXUkVjSENYVndTQmkzM2NpSzR4?=
 =?gb2312?B?dmRDY3JiazhhaVI4cGxQN20yMEV1R1R1MVpxUnJPMmZjUTlHaGVoa2NvVWhL?=
 =?gb2312?B?WkVYOWR5c0pibHhnV3dOTitlN1lHMXV4Q1c5U08vcngxRnBTSG90S2loLzE1?=
 =?gb2312?B?NFZOcmJBYTZLRlJrQlgra1NkV3Z6YXFPUUpFbGVVKy84WUo5czVOWG1WMGZI?=
 =?gb2312?B?YVhqdG1OUTM5SWF0T1FMRC9MWVNpc0ZpQmdUbFU2U25Sc0dFa3JqNkdKSkc5?=
 =?gb2312?B?cWF0eUZuYWh4Nm80eXZEcmNKdVpGVUMyYklMZndENjBlVVQrZElja29jK0VV?=
 =?gb2312?B?K3ZiMXRqanFWdnFQVElrNEZzbllqV1BRWGNrSUkrSU9wL1ZUcTZPQTQxeldi?=
 =?gb2312?B?SEdEdDlvTG9NNW1WWWoyeHBTQ0UxS0h0eklOcHNXQXpDMWJFcWRqY1VxZUNw?=
 =?gb2312?B?czNmdkJUSWZlNjBTTERjQ0h4Y2hTSWhVM1U4eFYyYWF3dUZ0Q3JwU0Jjb2Rv?=
 =?gb2312?B?RUtwbEIzTWpZL2pNb1pDeHdnWEVPM2xBS0x2MkNNQnUwbGVPVkJLR1huY2pp?=
 =?gb2312?B?cTF0MVEzRjVTNG1QTE45Z2ZqQ0RFeE9uZTBjTW9iYzN4Rm0weTYvM0h3Zk1x?=
 =?gb2312?B?clROUXFzdFB6dkMrK2t3ZVBVSE1xcGRPN2ZsMXh3emJBS3J4VEQ5THc0WWt2?=
 =?gb2312?B?SERxVm1EcUkwcm0rWlIvOUk0b0VscHROaXNxSk5JaThZQWczYVBJdGgwdTFQ?=
 =?gb2312?B?ak93UWxJTDZXbi9rNExMdis1b2dGdXNuTEFoUmo4VVpUdWdudGw2cHVWeURP?=
 =?gb2312?B?b3A3T016UDUvVFlzSStVWGJpRzk1ZlpMOEF1ZlgvWmo2V0UvMTF0cGZ1d04x?=
 =?gb2312?B?bHhSd1I1dXJlL0Y3U0NRQ1NwNDJpK1NnWk5NUEdncit3cDFCQk95bXlZOWN3?=
 =?gb2312?B?YStrbnMwZ0JiL3R6R0lkSzhJWWI1STV1aktLcnFNbEtqSHNFL3R4eDYyeHdB?=
 =?gb2312?B?UEE2dGl5ZEZMdFR3bWVBWWg0bHNFaWI1NmpSNEpWUWx2RFVvOFpFOCtQcGIy?=
 =?gb2312?B?TXFPS1JKUjVuc2piRlNRY0Z2L3pSQ0FKNkZwK0toWFQ0QmhRRmV4TkxNVEgv?=
 =?gb2312?B?WDhETlpSUXFWNHU1YUtwUnhQODdTTUJyd09aY3JvVWZ5SHFDVUJnZVVKci9C?=
 =?gb2312?B?Tzh5azlFakRRbSs4dFJack1pVnYrUjAxeDdxSk1hR0loUXo0b0hQV3dqSVVM?=
 =?gb2312?B?VnMyVlFvQXFYNUtxMVduSXEwNGUvS0xiNDdSNGZpdXV3WnNwUitBYUZSay9W?=
 =?gb2312?Q?RUoRzLs+jvB7ONEYqh3L6sau4uu2TY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Vmx6UmVwTnNHclFvUW5pak9NOXdKSWFubGcrS3YvWm0zQlhPSTdnRnRYUGs5?=
 =?gb2312?B?aG1tQWQ0VDQ1dGF4ZmJwNTQrd3hFdVFJNjRQNG9od2I1SjNkZytHdlpOUzEv?=
 =?gb2312?B?TDJsY2hVbTlveUo2MWp3V0xCMnovMTZDTzNMMGVmZnJxdUp5N09HNDg2dmJy?=
 =?gb2312?B?NG9LOTNvejllTVZQWWE5R0FKQmNGUTA5VUhtTU96QjZPTWRkZExFT1lLMFo4?=
 =?gb2312?B?RGJ3NEowcDVTdTBhbTRQWjNudWJtWDMraE0wZWZSU1lQcExzaTFiUXMrZW0x?=
 =?gb2312?B?ZVZqTlRSd1VPb0ZXcEJSTnRrYUErMmt2bEVMNUkwamlaMFcrMzkwTlVjcmxy?=
 =?gb2312?B?L0t2SWJnbFNod2QwNUcxN2lPUUFOVzY2QWpBbDlVY1ZERU5lR29Fa1F4aEJM?=
 =?gb2312?B?T0l1bDJtelpxYnZiS3dscUtkL0ZRVERGL01VY2k5aWt5UTQ2R0dUUDB1c3I1?=
 =?gb2312?B?YUZxa1JXUDFTeGVnQkwvZFVNQ3d3dEp6U2g3SnRaTWNpMkg4SnpWZ3Rmcm1z?=
 =?gb2312?B?aWdiZFpTQjlOb1RvWjJwNlFEV0pIV0VmWDZoNE5hWWh1N3A2SHZsbWdhMGhO?=
 =?gb2312?B?WGJVMmF1bWpzbExvZnNBYVJFb0dxVy9Dd09HaXV1cG0zVkRpQmRrZHorV29Q?=
 =?gb2312?B?eGQ1S2tDcDhYR2kvRnNJUVIyaWNJVHlWZTRVdFF3eUpaZWU4WFRJVjkwVisx?=
 =?gb2312?B?a0xrLzdiYTkvN3JhMXRNa01TS2dLSGcydyt0NjByd1U4WlNtZEdHdjZ5VGs5?=
 =?gb2312?B?L00rY2swVVN3VDVDT3hmci93V0dDODdhODJubVZDWk9rUXJ6bjFXMHNFdS9w?=
 =?gb2312?B?TDdDNTdza1hJMFdVM3FPT1BETXdSdjI5aktqS20yRHJUbkp4R1dPaGJqa1J0?=
 =?gb2312?B?LzY3aGFNVm8vN0o1R0sxMDlGMkc3MEYrRTN4aWVicFZJaE5JczJyVW45MjB3?=
 =?gb2312?B?bXpIMGRMLzU2VEkvY2YvNzRyMVhvN01ya0FuNnhxSis5VER5YXFLcnlRVFR2?=
 =?gb2312?B?NFhJRXcwKzdsVm5JUWF4cCtPdEVJTndvWmtxclpjcXVIeVMrbGNVdHdhVysv?=
 =?gb2312?B?MXFHZzFrZDF0Wkk5N2ZBSDJNZmxRYW9jS01MV2FUbmpDVlFnMmZzWmpwZHNK?=
 =?gb2312?B?UVQ0Mi9MZDVodWljQURidlUvdHJ6QnB1VmZhSXZZRUlEVDlucmRQTjM2L0pi?=
 =?gb2312?B?T0ZsWTUxTEg1ejJOcTJoZTBVR0UwRzBReTJQSktWYXNkbWNEc3czUnF1WnNX?=
 =?gb2312?B?NFdiSkpPUWpZQ1VBRXJOQnpEUmZwN0lWYTJTRzJ0cjBGUmhDbUlmM1ozSTRF?=
 =?gb2312?B?MTNnbXRtTXVhN2VPMjg1M3pYbVhqb3VURGsrZGlTWXRFSERuUVFxN0dmZm1p?=
 =?gb2312?B?aUV3OWE2YnNTb2hjekY1M2xzUldZbXN2MTBNWmk2UU1BTXVTQ0VkZExBcTZW?=
 =?gb2312?B?NUtJSnErZ2UxNjQ3K09TRFBNNytHV2FSSnpBbzYyUklCbElKc0RGb001L1Zi?=
 =?gb2312?B?OEkxR0h3VUNOdlZXQitmczcybHoveVBOOWkwVWNsWDB5RW1nOGtkNlB0b1hl?=
 =?gb2312?B?NWNRKzFVaC9pZDROZytSd0syZDhvc1R6eWZsS2FWQU9neU5sRndFTnhPenBG?=
 =?gb2312?B?a2RwSjBsM3B2N2FQYXVZRktMOTNVMGZ4aktkYVZaNWJtOFZ6djBlSkZFb0hY?=
 =?gb2312?B?cjR6MU5hMHBBU1BDTkF0M1JwSHNEb0luQ1VBOTQybmF1T05nVE5ILzAyNkl0?=
 =?gb2312?B?N0JZQzZjMVBBK2EwWXlReENQd2xjTmlON1FNSU9sb045ZmFNM1MrSHBkV1hK?=
 =?gb2312?B?UEFUYno4c2NhSnhlMFB5SERCcEdjR29pWENodURLc3RzbEQwd1huT2txZlVJ?=
 =?gb2312?B?aEdwb1VVNjBSQUNmYmZiQy8rNUdzVmkwSCtvcWtPdGJ2bytoRWREdWFXQStT?=
 =?gb2312?B?dXpYaXo4alNQTjNrVkdYVFp3OHNYTXlUUjZZb1ZwQ3pYcmR2Q0dFYmZYMnFj?=
 =?gb2312?B?bkkrRkxVeFBWSXlzVXdhdGNJbW5tbDNmOE4rZzhGUURVS0orMUZhWUVwZ1px?=
 =?gb2312?B?bmI4WmlJM2U3U1lTL1FFRGcraFovYWNQNDczM3UzSTA0N2craXdxTDZ1V0Ny?=
 =?gb2312?Q?ich0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db7c5d8-fa10-410a-743a-08ddaca94f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:42:13.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy5R1EiP2vv/V/UzOrxoZr0vpcx2O6GyaFCCTsj3ZcZa2YTV78Gp70d1510uC5DL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNcTqNtTCMTPI1SAxODo0NA0KPiBUbzog
Sm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5l
bC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5l
bC5vcmc7IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsg
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbTsNCj4gYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNv
bTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBs
aXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJl
cGx5LmNvbTsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gSmFja3kgQmFpIDxwaW5nLmJhaUBu
eHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBBaXNoZW5nIERvbmcNCj4gPGFp
c2hlbmcuZG9uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvOV0gYXJtNjQ6IGR0czogaW14OTM6IG1vdmUgaS5N
WDkzIHNwZWNpZmljDQo+IHBhcnQgZnJvbSBpbXg5MV85M19jb21tb24uZHRzaSB0byBpbXg5My5k
dHNpDQo+IA0KPiBPbiAxMy8wNi8yMDI1IDEyOjAyLCBKb3kgWm91IHdyb3RlOg0KPiA+IE1vdmUg
aS5NWDkzIHNwZWNpZmljIHBhcnQgZnJvbSBpbXg5MV85M19jb21tb24uZHRzaSB0byBpbXg5My5k
dHNpLg0KPiANCj4gWW91IGp1c3QgbW92ZWQgdGhlbSB0byB0aGUgY29tbW9uIGZpbGUuIFdoeSBh
cmUgeW91IG1vdmluZyB0aGUgc2FtZSBsaW5lDQo+IGFnYWluPw0KVGhhbmtzIGZvciB5b3VyIGNv
bW1lbnRzIQ0KVGhlc2UgYXJlIHRoZSBkaWZmZXJlbmNlcyBmb3IgdGhlIGNvbnZlbmllbmNlIG9m
IHJldmlldy4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54
cC5jb20+DQo+ID4gLS0tDQpJZiBTaGF3biB0aGlua3MgdGhlIG5lZWQgdG8gbWVyZ2UgaW50byB0
aGUgcHJldmlvdXMgY29tbWl0LCBjYW4gZG8gaXQgZHVyaW5nIHRoZSBtZXJnZS4NCg0KPiA+ICAu
Li4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkxXzkzX2NvbW1vbi5kdHNpICAgfCAxNDAgKy0tLS0t
LS0tLS0tLS0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNp
ICAgICAgfCAxNTUNCj4gKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MTU3IGluc2VydGlvbnMoKyksIDEzOCBkZWxldGlvbnMoLSk+IGRpZmYgLS1naXQNCj4gPiBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkxXzkzX2NvbW1vbi5kdHNpDQo+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5MV85M19jb21tb24uZHRzaQ0KPiA+IGlu
ZGV4IDY0Y2QwNzc2YjQzZC4uZGE0YzFjMDY5OWIzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkxXzkzX2NvbW1vbi5kdHNpDQo+ID4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTFfOTNfY29tbW9uLmR0c2kNCj4gPiBAQCAt
MSw2ICsxLDYgQEANCj4gPiAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBP
UiBNSVQpDQo+ID4gIC8qDQo+ID4gLSAqIENvcHlyaWdodCAyMDIyIE5YUA0KPiA+ICsgKiBDb3B5
cmlnaHQgMjAyNSBOWFANCj4gDQo+IFdoeT8NCldpbGwgcmVzdG9yZSBpdCENCkJSDQpKb3kgWm91
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

