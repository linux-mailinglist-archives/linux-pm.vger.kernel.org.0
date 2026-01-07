Return-Path: <linux-pm+bounces-40388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD5CFFEED
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E67B30EA2FA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922F35CBD2;
	Wed,  7 Jan 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="MNIbUT00"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931A331235;
	Wed,  7 Jan 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805506; cv=fail; b=Z9dNSofqju+MRaSOWjxfDwPQ8ClPcf5BP5FuYBv65pjFTQS5faAmmzQVIQ/yrKe8l/jBYkKDFRBo5NBPzMb7rW4qr5h+wMWjF/XjhG4gF/A/C+lEULWv70iT4YBztFNb5Z5myEq9Tl9PqIkuor+paqBHG45jOB3vJGtK5R9PA48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805506; c=relaxed/simple;
	bh=1xW6jsmA6Ng3lJ2mFGxJAI8OultiRfSXin1sIgph/4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pOpgctNmyhoMhxIXD1hNYPeW7ffHze4V9QmvlrHUbs5ECdoscwJ7dl8TK5v2x3oTUGDAeOTbQak4ewkyzl6aNnGveiJZysxNIlEZP+DQbO/uD5fWSCH0jVurnVG/XglnlqouOW9SjZ4SuqxhDUpwgEm/solqR/BuuyWrke83Vv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=MNIbUT00; arc=fail smtp.client-ip=52.101.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfoTCfSb4PHMD1q3MAaNPfrW1C5bR7I4S/hU0OXwgSnr1SnrgDC2UV56goG966Gm8bUL2w7cr6d96TpD4Rt+f4YpHkoOL8BtIdm3CAd+vnizkLgFrMT1NmQIBB6OrMY0cGR+hf0q1kK6FYUfe7SH3m2+SkWrgnhfnHtE4S/9ls8rXKiKYvGJSJi8gB7bPrAvY1ZmxwDWI8ZgXh6m672YmP2y/9SgGKDlcGDlDh6gh3+6E5PtwkTVxi7+O3MPS1T8G/ng34JZMaWf64KtuJm1zKTK7whoniuL8LqZH5jTNYKgwQO3P9FxucUVELi+tp7bzyj8TV7EF6Rb8qjwvdIkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwSLaWEFvfx0BOD3cxTGpDvy/hbct4Mqxk+gPFy7+YA=;
 b=Ln8Ya//br4OgItiR5R6+/O4g0Q2hdELi2p5VkO2li4di08WcuwOxEs7E4ZSOsOibBG+qKqqH6FDcQ2cnSsxgkmO8lEbEpSLV/aiS1XolaVDtb+3rfdY1vFX4E1fH5SlJOCjnHsyjOFOuncK1hpcAEc8pL16sPBP2ubvyGjHR06BP3aRjnCqhY4M7uD1gi+5QgBZD3EYP1jxI/n9EGwVlamsdWv7cHGxJLmR8K3OTyOPBhVlWaorJ6wOF3CGlAA/1iwqB31APPmSFvheicT2cK3jPCcXV5zAmlULeW9tTWx2THa1NTBSuhVZmaaHnyXpzt01oScGylXN3vagjY5ClDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwSLaWEFvfx0BOD3cxTGpDvy/hbct4Mqxk+gPFy7+YA=;
 b=MNIbUT00Ax4cRy+TnyQiD0AQFysJKHUY+eyO2AGaLsgv0U15SljvXWUEmoYEwlBSLlG/KC5WfY2imagFBU/VGTkscsTYQ4kOcMnelz78HxC9IoZZfuG5IsUnp01MUJAzc4WYm11/RzYaxcKhwbw3N+adZeEZVY2yrvtlOx5tvhY=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB14940.jpnprd01.prod.outlook.com (2603:1096:604:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:58 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:04:54 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 1/9] thermal: renesas: rzg3e: make reset optional
Thread-Topic: [PATCH v3 1/9] thermal: renesas: rzg3e: make reset optional
Thread-Index: AQHcXtVAFm47qfm2Ak2FGmMpsnMGorVHMP0g
Date: Wed, 7 Jan 2026 17:04:54 +0000
Message-ID:
 <TY6PR01MB17377EF4E7BDCB0EAAE6B8209FF84A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251126130356.2768625-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-2-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB14940:EE_
x-ms-office365-filtering-correlation-id: 7070d2e8-9768-46e8-795a-08de4e0ee111
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AAR0fa2IqaOOxhxszGucgLIeJiwK7U2dPKBjMN/PW+C/M0kMlXoJwxrViniI?=
 =?us-ascii?Q?CyQyFLWfOMNVR8qPo0hblts0FiMIaKENc+ypTxhSf1YUYapFmEIMgZZd7kIk?=
 =?us-ascii?Q?7IBcKCHyGzd9yRuVON6eEHWtQ5EVL0Uufd3JIaGItJVNIUOacA2nbeU0QoE4?=
 =?us-ascii?Q?PpHexgvI2SUYbFbiRemQK+pX79qYdrW7y2RNrslcbulCx2HYg/3jwEbaH7D6?=
 =?us-ascii?Q?IOV2ewbIXc+LQr7uMkAD2K7WPm1EIlbjXHxFAXyCqoVs9VCTcDWiQmgIrdTt?=
 =?us-ascii?Q?eyvXEBt4X4yD9Pmn6VW3SXK6v1IqNGOe2qecrg+KvxVzxdaqCQi8OLoMVa9Y?=
 =?us-ascii?Q?sOKuokQCt5x1xxt6pVqDoRvy6YM2LGIm714Pme+xAX1lRglXQUzcg1NkO+dQ?=
 =?us-ascii?Q?nfXj1Ayje0wUTKbbdozqqGcKWW58tBuTaWrbZkkLyzLVzdTRcvsBvz0Gdeb9?=
 =?us-ascii?Q?YzsCeqytBSzRbr1H5j0/m1at93lb6Ti38rsxslQRrXCKg9ZgH1Mq3DM41ChS?=
 =?us-ascii?Q?hfJEtbnoHGzp43Xte+6RSZRnKxt2sCH34S7gyJ5YgE8Q5bVaaddKRdnwC5Ly?=
 =?us-ascii?Q?CHhPaAQEExEsW4BUya/h4GrzSrYmT+M+qo7KbLz7snoX60kuaT06ask2NX36?=
 =?us-ascii?Q?+eefoIhljsaFbZzfZQg31pTuuDzsdg+dc5gHsedkW7Rks555NXynUOdIbTHV?=
 =?us-ascii?Q?Zr5f+CBxACoznH1ocnTtwwUxZBRYWRJOewp/jwV1PdVJJPdqzXHqN3xhLYvq?=
 =?us-ascii?Q?U32sY9yFr/CF5nxloLRan93oVuwRBnAfguyVBaxjouqEuoXc51vTuqVOlKAF?=
 =?us-ascii?Q?9Yt92JSAI+cQTSoU4ipiRnNwvNIVU2LSVc24uuR1prlpNWFLPkJaJPznlSSy?=
 =?us-ascii?Q?0pzAi+ofXMbFbIx/w5xoqZ9ozWJ4gbroXaE1iC7W39stE4RodHt0un9WW9MO?=
 =?us-ascii?Q?ryO7PzvBfU0q0sF2YrzSFt7wyC/wZu//DvXjWK8yI55wZXNxjLsN+cS0B6Jq?=
 =?us-ascii?Q?Z2/Vnq6qwn9hPEPbuVf+ILCROUb1pfixjwfrM+b5dgfokGpo6yU9+KXLWxS6?=
 =?us-ascii?Q?JzcMFJWnx/DBBLkM7Vh1euYrrIboVBsFAuXpzoVsw5XFmKXOEpoZZA7KglFJ?=
 =?us-ascii?Q?AzYC/q09lDOgxRjhoOMgU5K8ZpkF9x9r0M3v7MC21HusCSNoEN85J+tkW2P+?=
 =?us-ascii?Q?dVNSPYVLYlGkMTekM4Amps1V6xru/b62CgqquuJDgQMq3akQjAAeLTjkUHFn?=
 =?us-ascii?Q?LUUOxk/DX916Jilw9n69+/Keo08TEeKYMxqGnfmCsrOSRArqGKFPMyuCju2c?=
 =?us-ascii?Q?23l9o03/f+vhjYpYaa9FjkIDYh950snZObikwUHcEuVDbbvgNuCESKTCRtPi?=
 =?us-ascii?Q?il3TmqFjEickJa2/Q3ElOhKB04r2WQXRvL3weblqrmvu7NnlGmdraQIAcfw0?=
 =?us-ascii?Q?WmqpCd5sjc/bLR5bg9E3JdpuufjV7N7xnvAZ5t9+rQ4iiPxMALnZEGClKtN3?=
 =?us-ascii?Q?NrZyynyT/tlqwN2TIbU8ElneOoXhjo32CC7GKIQmd1P7mePsuiBrFnpt+Q?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5XuLGb6/N2YiSY1OViYK2Io8eAjP7PNvOcjrtcOAtT5LzLeoN0KR+OiIbvtY?=
 =?us-ascii?Q?8yOaX1UJYVe401Iz5OjdGX5dJsDrCzpiEylbeDvvlatTvJTptOQPezsPR0J4?=
 =?us-ascii?Q?a1K05GuBMCGmcdgSKf8aZCQWFUFFjvIzJchKI1HJLGqFMxeAdFnGjZWtw3zQ?=
 =?us-ascii?Q?6IX8m9+CnCXCecAgW3osDW/lOmfw7EeYrzPICGxTP0cK70jIr6Z96l3g9Skf?=
 =?us-ascii?Q?CNBv9o4Ughph6m/xWQeLr0CnhCkuxyVyZ6lhpPvoQfNnpWOGjXNKEpVFIY50?=
 =?us-ascii?Q?2SMcnuMO05bMe2jHZsOTUQTv2CJUmWFBogGYo0j8y/jkj08t95FtgT/J0mXr?=
 =?us-ascii?Q?nmhfQ6sEwy/+C4wdEpf1iyyozWkZiZUTRP6xtOnz/csAhMckkjqicg75DrsR?=
 =?us-ascii?Q?kyR+bSzY9Qqy771Nideva75D9fDWBy3j3iWe0Mun3BHj3HMTha72rBEzoICx?=
 =?us-ascii?Q?iwb5HZG4Pg4BfS5xqjxPWjWiXrsAzFF/pJY2Qem2XzzYFWBsQw1Mj4kghOTa?=
 =?us-ascii?Q?DUqKycwZO2X9PKfwNNhH14IditveZ7u2TfiIcJTdDeycrEiWbfdnqYFES/k3?=
 =?us-ascii?Q?KHayX2BojZSDh7gl6IfvlYCl42kt4ZbIeCoi4q9DIS53uErdUvX5d69a1Ea4?=
 =?us-ascii?Q?tJqAzE8qAVtNX+pXm6b85+4HitJ3VKQp+MEhDDKkECvH0wUPdU/UCD/8Q9mn?=
 =?us-ascii?Q?OsoO/aLpNTHGCUQ5mdW+t0yxvyyiAmzhjL7M7NtLBR7u57tY2hdzNMLaHwCi?=
 =?us-ascii?Q?DzS9QP8InqEhjsSSvqVlxxICvTBimJcpOsCy8mflPT0ol0Fgfkhf5+7edyfA?=
 =?us-ascii?Q?1pXqSoYvbcu+wZE+vkNCU8D8woAPLAo9b4HsFuDWFSnoTV/YV+IiqmQzPmdM?=
 =?us-ascii?Q?DArxoNj2mUXCUqLoJp77ds43kDLFMRFbCROi3LZaaE55ozqwNk5O7fKAx8Yn?=
 =?us-ascii?Q?9E4EjXsmtCnKWdsNAHHWWCbBSx6D0AuKds7rwW9FyvWs6tWZmZ6z6dPp5Sx9?=
 =?us-ascii?Q?LoEALpXcfKvzf5XbD2hZmn35yQuil7dB/cen/X0R4faXKHYYkYZmkuZLj2Xl?=
 =?us-ascii?Q?BbgWNUbNI1YcUpO41TwBX4uJllBrkUOEQ8ZpLexGmvvnZWLKuH5HlLspE9dQ?=
 =?us-ascii?Q?ZbI2IGtAddcDSljhmHehGziQxBZU4yWlXsMHd45UO/6Eu2I4NszHkmWcCL/j?=
 =?us-ascii?Q?yUs/ClJmEvDWTvWJig50dYvNUm4t802xJmIThAkFex0FKNRCIfWRFJdWCMyE?=
 =?us-ascii?Q?sUsa7n/0Db3MWDdJgWGIzWEVHSuuYpy24LiYOzQSKKXzfonF6lvLY25ESThS?=
 =?us-ascii?Q?m4u2Y3/RNQaSCx78outMNFiWKaTCA2l844LnVYip9iGFe7tGCQw5KwTEK+gz?=
 =?us-ascii?Q?po2wpHRSl6xZ+qTs/YqnnUTFgjR8FuuoQU9Xu/UZr83LF2gsni7ukvWpTeaB?=
 =?us-ascii?Q?qrHEE8Ry0YbtCki/AWcrTS7GAAXaQPDIPxyjrdZwiEXqSwNUtGL5ax48+qr0?=
 =?us-ascii?Q?1607nHPlU7FMsa7wv7ygmZuEY40pch6Wx8N4yGMa1Q4kQVVp7xBBq+mXfw2H?=
 =?us-ascii?Q?wVhUFQqyNN9mp4M49tNy8AT9Mcf35nawaEUvKMH8lsnYjV/NHI6wtinTZS+i?=
 =?us-ascii?Q?PcvSZlqHZaMSg5EPFotIaer/TzmjNdu3FiBF6U3/uZpaLTH65vNEEVj2ZpOn?=
 =?us-ascii?Q?WxhWAYo6JBJ5t9f3l4pj4OU+0NLfBWnyeoH0scmMqrXfJZ95SYC6v9U/MwDr?=
 =?us-ascii?Q?bz/4RipI3+ez14NHq/H0McIOeScvgA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7070d2e8-9768-46e8-795a-08de4e0ee111
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:04:54.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oMig6dWnz6cyyiD6KCaIOt7sx2cEAaEXBZZI4npnDhQIqEs8v/G7/cnyoHfl0BbqDN7xVYW0D0CEdlRw6CyFHfHCTegQ4QuzX2NkebaerI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14940

Hi Cosmin,

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 26, 2025 2:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Rafael J . Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Zhang Ru=
i
> <rui.zhang@intel.com>; Lukasz Luba <lukasz.luba@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> magnus.damm <magnus.damm@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Cosmin-Gabriel
> Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH v3 1/9] thermal: renesas: rzg3e: make reset optional
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
> reset line.
>=20
> Prepare for them by making it optional.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/thermal/renesas/rzg3e_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> b/drivers/thermal/renesas/rzg3e_thermal.c
> index e66d73ca6752..86c10810e5bf 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -412,7 +412,7 @@ static int rzg3e_thermal_probe(struct platform_device
> *pdev)
>  				     "Clock rate %lu Hz too low (min %u Hz)\n",
>  				     clk_get_rate(clk), TSU_MIN_CLOCK_RATE);
>=20
> -	priv->rstc =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
> +	priv->rstc =3D
> devm_reset_control_get_optional_exclusive_deasserted(dev,
> +NULL);
>  	if (IS_ERR(priv->rstc))
>  		return dev_err_probe(dev, PTR_ERR(priv->rstc),
>  				     "Failed to get/deassert reset control\n");
> --
> 2.52.0

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>


