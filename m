Return-Path: <linux-pm+bounces-20499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747D0A12B12
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D02165BD0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328111D618E;
	Wed, 15 Jan 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhhG36ii"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AE161321;
	Wed, 15 Jan 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966572; cv=fail; b=fuKaowYi5JzzJ3aOA2tWDh5AYlr2ReK6N3hDkLn/A3Urvgp0vOQkdrF9O7RVJIEqH3YIHduiIp8+VB5EzBqLp/t/Cs3WjFEDLMWbjDSMXIdAoOMD1UYJB/o69kk8KK5ELenO/h56an5emQaBKLjlKklmYuXpNRy1PMcgkoE31rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966572; c=relaxed/simple;
	bh=3OEA9BjhfcRXSQbfKmWqSbccQUkoZ4Y9H3ltNSB8zGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dswRPayEHplH4XN4QH1+KemY6MLktz04K+OX5YTUUE34CYDeXu5qU32HkgvZapnLSEsD4d/UJlLs4DntpPDWUCBfba9tA0TNe7LSfPuGmxsiacz1SK6f8G9NGdqvsctTOWr14dHw0ac7NQkhxGyjOxcxWbRd+lWeMjICdGTMJ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hhhG36ii; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkRU5ZAoc2g4XA4wMp/t/xI3TfO79FS2vEp0GcjoiOHBr2vCB4cwAn3X0wbP792J0ozY5ZraTrAjk2wx3d1gmGsekbCN1MwjeyGukXsBKcWUcvUaTje1QUhcEc2UBMeCBcAoiG4xlmIWE3YUSba1sJvhN9PDsxvLSxbRL1SNbLPKcj8/zCpa1+bGW4CJf6KksZCLcyQrbs7VKW0MJXnbLsWSzVzhduE8sES1qiV8aN7h3PBf4VLuLHqxLHv+lkrP/4t6FuEdJJxOcD2+NgTZQPnwgaKvLQeU3AEmjtMljhWDVPBIEW9i/+KbgXTShY/mEFLXZIVok95LeqI/d+m8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q+jxp4q8tx9J14pB+uRYl8vMY07O5psov60gu/O/JU=;
 b=ldmLspnnSuDPSKSTkY/Y4t/+z5slaAuF2c6wGKdNct/3mzzeTFJQoSrwsp4CZtAhckfG3ID7ZN3V/DpMSrKra3tZ1g+VO9GNlnsG+6krqbqOABfYHH7KDy9wJqLhJ1bTjcTsIGWHrgFdlaj6kRNpK8wwiHqX0EaroA3iWkaL2g930Sb3N27kCIt7Q1o3OYxfFmmDvbny2UsOyGtWKc8u7PXuBYexlPad5ha0v46UwuMjsQ3mD5/Ca8+wjxUu+8CYn+0+35ALafJbaf31UrAo4EtWXLeVQ9qLgYN0UpoYYHBiKkrCWMRDHlMFHNnLJedNtCnWZERIc/oKoixjpqpGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q+jxp4q8tx9J14pB+uRYl8vMY07O5psov60gu/O/JU=;
 b=hhhG36iiJjy0xkaGK/jyWiKucVmjRqhNrHFpH4uqfjutw0rzQbZ8s6+O0ehnGsn0IYSvaj36cXdtCDY2+P5WCCKtncaxNeDOCAVAy0WIKttZM/Ug+rES2P+7FF6TCbHPM7INhSd3SRd9asEdhfdgKQD7wXcQjBjixyuH97a1cKMmJRatkR8ZukwHvviCaP1lpxuCkWc9Mh5eSJSuAXPpCxpltutmXjtBqdn5L4roY5+96VSLPgaEJBG0p1QiDvyLFTyrp1C0KvpvUqVIPMfllyigwn4Qoka971s26HYEzEPJmCHA/ZmzIo9FN2TZATyD8SarhTI/6DGawECAWDAymA==
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by DU0PR04MB9441.eurprd04.prod.outlook.com (2603:10a6:10:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 18:42:46 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 18:42:46 +0000
From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index:
 AQHbZa+EYgINd2mhkUSyLwfM7XAfOLMUuHsAgAAaEzCAACEAAIAAJ0wAgAFKc4CAAAqJcIABIL4AgACYcvA=
Date: Wed, 15 Jan 2025 18:42:46 +0000
Message-ID:
 <PA4PR04MB9485CC9D9925BB5D23EA629092192@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4aBkezSWOPCXcUh@bogus>
 <PA4PR04MB9485507CCC21354B5ED55C3792182@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4d8nrJy-h9EwzsJ@pluto>
In-Reply-To: <Z4d8nrJy-h9EwzsJ@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|DU0PR04MB9441:EE_
x-ms-office365-filtering-correlation-id: ba24aab2-2566-472c-2dc0-08dd3594677f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?98VIpBOXm4fjCSXNDMIa+WQmpKFmiqGNLHoaUvXP8wQouuWloYSFX4bt3AQy?=
 =?us-ascii?Q?mja5dXYXyWaeT6XeAICV+KN7wrzfv3caE2Wr5RvbSaqNJ/cou4gmYdB6E4rn?=
 =?us-ascii?Q?EkWOlhR4Wojk1kItEcyCSwYK8N3b5bTeKe/g4EohLhA5Ejgm3wZ/ZCu6mdbj?=
 =?us-ascii?Q?dIBfJnpfEVlmTnAabrO6pM1h1fNGAg0HzxsQ0/hQPrLTQeecA0T9fZAnQO/2?=
 =?us-ascii?Q?+gCAG1Pzhtv2XtTmuLve1PIKs225Pio4dn/UaEEx6T2BttHncnxONzU9UVId?=
 =?us-ascii?Q?fcLzGBgJbXwE+/OXD3TmoRuUQxgipUnyAiZNx/wwsGZfQnqxwVukPdWPGyXs?=
 =?us-ascii?Q?qbNdlKs2Rk8OO15PmL1zg8+kHTIp8aQH2yRW2Rm4XT7SF539nMBXfukOUbky?=
 =?us-ascii?Q?vcMKkE/+XPdsYsuz/TjToKybh08zTnwNyjGKRBRQ/lNMNWS6GUtSJWljK37+?=
 =?us-ascii?Q?qheFykK+Dmw5AHI00CenNa1eReDw1cEQrn/vv9u5UxEjfmAozbkFh3oOa3Pj?=
 =?us-ascii?Q?sOFWY6ei73Mxi1v5/MpyiX2qNPmPzYliaDIAOwFpNEyKUZmEr9Baod2JRGXk?=
 =?us-ascii?Q?lzIeG5R6ZpLbYn2JxdWrGs/4TRgtZr5mGvz1JQIetJvck2ZTDYOzbbJjR63c?=
 =?us-ascii?Q?+PJbEKFUCYtWDS8oTTCiS6nc7s3qWjzxhMb5vV/ys0cArvvfm2bQZl4DSiQ0?=
 =?us-ascii?Q?mBYVJDw7kpOAFhcB5Kp4kmmEWLb20ZnS7IfwQSP2Qte3tOCabyLp6HGogBEI?=
 =?us-ascii?Q?oExpDNt4pi3OtKMSowvYfGOewrG7NMxK/TMj4L2StwN8/s9nqdSJEkNtRzX9?=
 =?us-ascii?Q?zCLmemDIOJMgXoQ5FO3hiUSMCYBo4e4fJghxDqsgsiuJ3BNEf1qUouAWRBlr?=
 =?us-ascii?Q?1iOOOuFvaT1pl438iRKRV7YfCMdOpVgWV+X1R0wU3N/3lj6iBsC0mdJrw3Iw?=
 =?us-ascii?Q?DFhBejbdzfoNTuHvasRcxEw85efKCfSgvdxFnHDQgx8h4sYJN2p2H7gYKhRU?=
 =?us-ascii?Q?FNRDi8FncIa8x8k/VgH1u0SEjUfI0KN8EkTJaQdG8vpgRc/TzOOfe0TEJ+sD?=
 =?us-ascii?Q?QGyXtoqbIPcQ5HvfdzG1tcFHY4BpsafI+MKpPNfkzwr5gch4VdlEWeAepdZs?=
 =?us-ascii?Q?4w3bQr9EnlWND3TIq4dPXlrVa5+NIrLmpzj+w8QyDFjGHearrB6vtWVl0wvY?=
 =?us-ascii?Q?HbkZvU9scHnwRd3UAIPWdq/ZZTpTqDbctXMtKGrT90Itx/CsQzZnjAaV9pJ/?=
 =?us-ascii?Q?UYyPCqA3qteLZ4YJzOJUZWhNR8C+NUpMusUKiDvZ4us6FoTDh5Jpe5Jlpe2+?=
 =?us-ascii?Q?uYK8lhVb72C40/ujEWiGdoqqWlspD9YHHAPlo/CM4ouZuaXjNjv3SLXRm50k?=
 =?us-ascii?Q?eMAmJTJxamZtBB9k2fyxtFbEvq77uBSqL3cjYWHXjRsoYH5yvJQCMNI9Dtz+?=
 =?us-ascii?Q?Bq9v4qxtKUjuUj6KtvfIoIe8cnOWatKn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BhG2N+9Rl4otbn4kALqikHcDo/SQFqscReolsCFZBI963EyWo/mZV93X+k70?=
 =?us-ascii?Q?f7mpcB5h9EGNU9uFjt6HCn7DT3x/jswtYoq+no6gZZwlKxYJd8Ogv7Xz1uhp?=
 =?us-ascii?Q?fllynxvra5hBQXWboAbKVZOWgk9EUucrc2p/ZXV70FuWxRJ5CcUOxb+AU5bi?=
 =?us-ascii?Q?qkFzmK9B2FfVCmrm6lGL2tBRApqfVYTsYsrG7pOe2Fg2gHqfGpA+OVwDxOsZ?=
 =?us-ascii?Q?iGyHQgkZNQsJSIpnlTzm/YtqQ0zWXLgJL77zWPsM2GgOuNrOotU71XxKnKzL?=
 =?us-ascii?Q?sKnnz3oBZ2aEaoFOmhD6KEmDi3h8KwEw2B8udo8ChNtME8WDeGA78H6cffXB?=
 =?us-ascii?Q?35WtmWqHuiHXnWq+ihIU/IMy/VB+aVhGxHC4cTr7BmwSd6AkK6dpR7lFqSNj?=
 =?us-ascii?Q?J+MgZVQXdRyw9Vuc/3ou9h/OryZkRqIDDKIGznZmCdU2BHq1dumkkpz7G3QF?=
 =?us-ascii?Q?fnckEbv2teSAUi0Stvf03BqhX0iNrUN0Pec4WRUHYixvNs4+oJD4+iJfFiLI?=
 =?us-ascii?Q?+6xprXqdrO1Wld7sNEYT4J8ihvtdMRqkRNPAd9FHSqcGwKhj2CcVOSDtZgaI?=
 =?us-ascii?Q?CP5TbZv0Xw9fEdo+Q9CFzGMDEpghiWyGud5Zwt6SOQ3haWWIo30ZMIDGSNBo?=
 =?us-ascii?Q?FWKReiLuG//5saz3nSQ/KzSzJjX6Xfc6AtdIvIhw0JESKrzN797ZDlguYYh/?=
 =?us-ascii?Q?278x9Of4tlYgLjWNjbDdhYWOJeP8PJO+3xpnC1DiRc1VOdBuFOnFqT3Ix9lu?=
 =?us-ascii?Q?wWsTtFLS4YWbnmh81CeRgzA1Zf9pyK9bp5K7pd/VjclpsDPHckfD+pZ8te2y?=
 =?us-ascii?Q?KnSC6utHqveFUe0Qp7olI1Uz1LuqPqLjE9uzhcsmQHToWFfEU/yt6g+rUFI+?=
 =?us-ascii?Q?c12w3mRBrzpvbaLb9/K0DI5R9EIMtf9RMPOERHpb5KCQQNe0rsscCbcYeWT9?=
 =?us-ascii?Q?edMX2jhn0O5kvdJoIB+qu0J5dJKIk73DjFAPpGyW9i5ORxdH93n4zsm6Nab1?=
 =?us-ascii?Q?UwpAYgWZe4BeBW2FoErbBB/hNEGuNPbRgZSgSYDJ2YNWX1stDAD4B0ZKeLBR?=
 =?us-ascii?Q?3/2xtRAa0i/++W0S9q/dl+N1GBHXeTeA4ezf1nuDvV5Bx75MM+/SesdMkhkI?=
 =?us-ascii?Q?kv2sD097lFkD9dkS7WfxY8/JiB9mPiHQG/RcbcsqVAcZiIh7w6ecFvlL6adS?=
 =?us-ascii?Q?JQfswuxnTnBHfIuBde+HmtpqGtUhSsgnsi8ocQ+F4GurN+uTMyIqrHO4moVY?=
 =?us-ascii?Q?gKq8KJfzw56Ufk0nxNJPWhKB59yPmKn2AAEEgNepK73ocId6N/hjm7aWfBwr?=
 =?us-ascii?Q?m/5sddYy8+hiSigdMvMyVKfi+hd0aepg+4H+7jTZcVmoXZJVhT52aD6QvOqq?=
 =?us-ascii?Q?uw4JZIEZVEMdglEpuSCwugLPszfgXYaIo9TiEsfl9OHmtK/IItubA7nDPLuC?=
 =?us-ascii?Q?mzMD08Wl2Fp2zVVUKIU0g2r4HaRhxeeOCiWLFq/D4WjKJO9u098GbhmRT8BL?=
 =?us-ascii?Q?LfI+VQZOqfOfdq8UfMgwU++JgX39fUD6NXWkvkt7koHrGbjaFxSrD8kWnm8i?=
 =?us-ascii?Q?0QLE4wo94iFWZiuGezHnHtafgnSrF/F0MwjGlgB3Z6+agXqP9jqid4unbcBg?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba24aab2-2566-472c-2dc0-08dd3594677f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 18:42:46.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2tv+yPQ8QkZR9LJWNtW4M+5agCK+nAUEbCTJ5MGWHNFBEgzEVr5nUIhqNMfgtuBgm1QDxiCqNowWf7xuu551duitTSUcqifi4rc9nypKek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9441

Hi Cristian,

Regards,
Ranjani Vaidyanathan

-----Original Message-----
From: Cristian Marussi [mailto:cristian.marussi@arm.com]=20
Sent: Wednesday, January 15, 2025 3:15 AM
To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>; Peng Fan <peng.fan@nxp.com>; Peng =
Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; ulf.hansson@lin=
aro.org; arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; li=
nux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize st=
ate as off

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Tue, Jan 14, 2025 at 04:09:13PM +0000, Ranjani Vaidyanathan wrote:
> Hello Sudeep,
>
> Comments below.
>
> Regards,
> Ranjani Vaidyanathan
>
> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Tuesday, January 14, 2025 9:24 AM
> To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS)=20
> <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; Sudeep Holla=20
> <sudeep.holla@arm.com>; ulf.hansson@linaro.org;=20
> arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;=20
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain:=20
> Initialize state as off
>
> Caution: This is an external email. Please take care when clicking=20
> links or opening attachments. When in doubt, report the message using=20
> the 'Report this email' button
>
>
> Hi Ranjani,
>
> On Mon, Jan 13, 2025 at 07:54:06PM +0000, Ranjani Vaidyanathan wrote:
> > Hello Sudeep,
> >
> > Will try to explain the situation we are facing.
> > 1. We have multiple agents running, Agent-A is booted up first=20
> > before Linux is booted and powers up a shared power domain PD-X.
> > 2. Linux boots and gets the power state of PD-X. And its already ON.
> > And then PD -X is initialized with a default ON state.
> > 3. When the driver that needs PD-X  is probed, Linux sees that the=20
> > power domain status is ON and never makes an SCMI call to power up=20
> > the PD-X for Linux Agent.
> > 4. Agent-A now is shutdown/suspends. Linux will crash because the=20
> > platform disables PD-X because it has no other requests for PD-X.
> >
>
> Thanks for the detailed explanation. I understand the issue now.
>
> I would like to discuss if the below alternative approach works for you.
> We can debate the pros and cons. I see with the approach in this patch pr=
oposed by Peng we would avoid querying and setting genpd all together durin=
g the genpd initialisation which is good. But if there are any genpd left o=
n by the platform or bootloader(same agent), it will not get turned off whe=
n Linux tries to turn off the unused genpds(IIRC this could be the reason f=
or the current state of code). While your platform may find sending those c=
ommands unnecessary, there was some usecase where SCMI platform kept all re=
sources ON by default for faster boot and expects OSPM to turn off unused r=
esources. So we need to support both the cases. I hope my below patch shoul=
d suffice.
>
> [RV] Linux can still make the call to disable unused power domains, even =
if it never explicitly made a request to power it on. The platform will agg=
regate the request from all agents and will power off the resource if no ot=
her agent has enabled it. From Linux point of view it has disabled all unus=
ed power domains.
> Your patch below may also work, but feels like a workaround to artificial=
ly (for lack of a better word) enable a resource. And also makes unnecessar=
y SCMI calls (expensive) for every resource immaterial of it power state (m=
aybe can be improved by a conditional check).
>

...sincerely, both of these solutions seem to me hacks/workarounds to count=
eract the fundamental issue that derives from having allowed (IMPDEF) to im=
plement the get operations to return the real physical state of a resource =
instead of its virtual per-agent state as maintained by the platform, while=
, at the same time, having allowed to implement the set-operations to opera=
te in a 'virtual-fashion'...

...so, when Peng's patch forcibly set the state to OFF on genpd init, you a=
re indeed artificially forcing the kernel internal state to align with what=
 would have been the virtual-per-agent state of the resource in your specif=
ic particular configuration....
[RV] Perhaps it's a hack. But at boot the state should look like OFF, the a=
gent should explicitly request those it needs to be ON.=20

...on the other side Sudeep's proposed patch tries really to play the same =
trick, just on the other way around, by instead forcibly/artificially align=
ing the state on the platform side by issuing a redundant ON request to bum=
p the refcount and take hold of that resource from the Kernel agent point o=
f view...

... but Peng's proposed patch will broke immediately the moment you have in=
stead a system with an SCMI-capable bootloader that instead left the resour=
ce ON for the Kernel to inherit, since the kernel will now forcibly see thi=
s anyway as OFF, and so you wont be ever be able to switch that resource RE=
ALLY OFF in the future, if ever needed, because the bootloader/Kernel agent=
 will never see it as ON in genPD, since, at least in the genPD case, AFAIC=
S correct me if wrong, there is no callback to peek at the real state later=
 on:
so, after the initialization value has been chosen at genpd_init time, genP=
d subsystem maintains the PD state on its own based on the issued ON/OFF ge=
nPD requests, so your forced-initial-OFF-state will be, in this specific al=
ternative scenario, wrong and forever.
[
[RV] SCMI-capable bootloader and Linux should be the same logical machine (=
different agents). And the platform maintains the state per logical machine=
. So if Linux tries to power off a state that was left powered ON by the bo=
otloader it should bbe able to.

...I think at least Sudeep's solution could survive this scenario because i=
t is more general and can cope with both scenarios

I know this phys-vs-virtual state is a lost battle at this point, but the I=
MPDEF possible scenarios that derive from this choice now have to be suppor=
ted kernel-side as best as we can both ways...with the additional headache =
that, from the Kernel agent perspective, we cannot infer what kind of IMPDE=
F get_state is implemented by the platform we are talking to AND various di=
fferent subsystem in the Linux kernel handle this "initial-state-matter" in=
 different ways (e.g. see  clocks subsystem)
[RV] True agree. It would have been good if we had an attribute(s) to defin=
e what state the platform returns as part of the SCMI API. Perhaps the plat=
form can return both the agent and physical state.=20

Thanks
Cristian


