Return-Path: <linux-pm+bounces-18675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5959E6705
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58141643C1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D2198850;
	Fri,  6 Dec 2024 05:54:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020126.outbound.protection.outlook.com [52.101.227.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA53EA9A;
	Fri,  6 Dec 2024 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464455; cv=fail; b=kuc9/sdenWzJbQpnWfQKRoTbYB59+gNFd/VS42rfGA9VrDhEHERFv22CC4b4D4GaqIZ0/mFjt9EBJTvMRq241tx99QO1THEnBp7POWhjOw6lj+KyHUm0V//41UvDGN/XHqJE1Y6C9JgZjTpJfkn4+yCHEOEOkVJI/AG2PBFo83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464455; c=relaxed/simple;
	bh=tkiMFk0nVLE8wiJUTSkAW/bwYbyv+5hA3QH3PupCH/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p2pBNoLAkp3006gTQtyY8QIdg9z/542hX9SIsGw17yzQz25nt9G6EJaMIvKr6N1vrLvBLXm2WyPRXFqbGqtUNq94c+Wf9pyTgmUsXTdVmVC3n4trW3FNvXa/r145Lyw1MvTF8frMpZAZ/wNRbezUnI3wiFl6qZkSubTsWEOCChY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUe/M/LfYsnE8Nrm1xTfAnIiJ3Pkt+7VSIzfLXTVZqNBBZtaQwiafS272JEzaLs9ynxkRZAdEYFG7ECfDMMVWQ8SUVDGfNKbYvGQWq6izirkhRq2Hmo/9jrwOboq7fvIRve0khZ0NkekHwWUfK26dMdPdTtaaM4Tbo7j9wZ7uEEswOV34T17+sNTcaPwNACwFVyr9FymUjY/nc1cXHL62mYIUXhUTiawuf8aZugp5hea7Y4G6SDeTD2c9PFrXf82UBOrgMzUZYYoT1xkzCGIdJOrCzqvvemQ20yR9w095cAaRdhXUsT/7shLPalRlykJDdxH1KsjYTt6eXjD9OVrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DfWHxFqn51dMvjcW5BSrD7il/VZrzUtzCSl52XFfBM=;
 b=IFGCJME0LGyW+Z5mgRpMlC6NkUPjDJU9xnEK4WgbKF+JkXn3barLxdX8WeTGpTYT5aBqgBoT/4JfieNxcl1WaEpN995nUk5SOhpnmnFqxrxc1eGp38DP0F0xEoxZ0E/ENYnuEq7+/lDnGN4HVPTbsMkkwVQmVrcv+mPcYMl7GT4EeFpBEOcPQTWehfNY5d0EMpwBIcW8KVxZi7/lpka3beXIq0i7HUQeE5f1OWhPGNs78cMxzhKYT4Dv64H0LnfSVMRcz5qzAzZuf2frOok0LxgqRBNVzxAjwOzvMNUsaADwN9KeyzsU6v3ZUujFQmSXOHkpha7RdC4TtsLHnVo4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB1677.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 05:54:07 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:54:07 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, "sre@kernel.org"
	<sre@kernel.org>, "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Topic: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Index: AQHbRJ7A7I57U+rrYE6HjLMEy0IXubLYucbN
Date: Fri, 6 Dec 2024 05:54:07 +0000
Message-ID:
 <PN0P287MB28431B1E62E0CD965F10074EFF312@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
 <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|MA0P287MB1677:EE_
x-ms-office365-filtering-correlation-id: 66d3e049-c7d8-4e5c-5687-08dd15ba65ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EGXm54ono+kExg1KY/6V9lo/m5/V2NqwErNpIQEpM04eJElsdL5DaUnT3n?=
 =?iso-8859-1?Q?LAMvYy2wsdBZfJW6ui1lAkhM2QEJvlDkdqMqxjBhNk6VpXTPg7l0ujQjf8?=
 =?iso-8859-1?Q?fMmoSNQUcQRZvDyJONU4nM98Kb5eW7v7yggtx4jLXXBLrPuGVgtqxdeNNl?=
 =?iso-8859-1?Q?G7hE2wffDiw5fdu4HNdoaDG0pYwikHhjxWrRuWJkIQThqJNrwLsowb0KfP?=
 =?iso-8859-1?Q?bD4q3AichYfm784dhhgJ2nriO+MIgNLyVF1+Yb3aotibwd+xAto+11XWHp?=
 =?iso-8859-1?Q?8xzs4mgPfwkusjY6t2JxRH7h6+PNO5Q1k/EfxQAaDYYzN6BGRkUMCr8lcS?=
 =?iso-8859-1?Q?lZ5TlRKpMnjGq/Cb38UPhez3IwtKi/gx+MXTOFExWglTRNa/2zsptz0bPY?=
 =?iso-8859-1?Q?wi55ieCoznZmZjWMtRCsAVcrr4gROn865guWcHvZJ7ozhDJZ5qrHPT5Y/q?=
 =?iso-8859-1?Q?sOVakurwFBKNN8FNScIFrBts/GJ43CKRDeXcn+LuKDMzdldqSEsL9l6ZY/?=
 =?iso-8859-1?Q?yJO25OSH1pEPJikibhBYzftmaKsTFYaSXBkaAJgwts4uRvdbUiHTczL3mw?=
 =?iso-8859-1?Q?5niAGfi4Rp/tJ9Ipviha7q9gO2w5TjRO2nugz9dHHMzk86kUcCVrRYMDKN?=
 =?iso-8859-1?Q?uNbbU75qDvYF4sNhVFdefLBNq93Qjzhsba/UzWEE0a9/ALSi1Pi2LoF0+x?=
 =?iso-8859-1?Q?xS5JpAtuPfb2nEZZJB1YBijTDBqwgpXSN2E8pJ8KoG/udWTxS3t9xpT9h2?=
 =?iso-8859-1?Q?eXZ7iUG16+s2UsfPLzUuh473dqE5kROAeMmJbXl31+dWMGgydZX+riu4YO?=
 =?iso-8859-1?Q?Bk4iug3mgOw+Tj/famRnpPdyJ45JCbAprR5dFN4+2hm7n19w0G03Gquab8?=
 =?iso-8859-1?Q?WvOU038lB+hITk591mURu3R6L3LWsJuVfhNIZSJ8Mq4y5E3vaDrvmATSWE?=
 =?iso-8859-1?Q?b+Ad+m304KK06jui40IXPdaDo3nGPMYIMT6MjrRnNbtOau5ZX17k2M1R8C?=
 =?iso-8859-1?Q?wTy1bdIjIGCis24N3wHUf2dXWYRgi0GLx7bZKDjlOgCh+AX9y0J7lCNxoP?=
 =?iso-8859-1?Q?ro80hKw2u2jvy+2kyN+xuzi6Ilu7Q4BHy5txxw7kez5su4b3qPeY4xzBpY?=
 =?iso-8859-1?Q?wF3zuT55AJiSFYLr5WqJFY6uxOPFSS0pUeqi+fFkeLbN9q2/wKt70yBMxF?=
 =?iso-8859-1?Q?YF2Owy6aHDXsHFZ6m8g1brfCuLb51qSrqQIiJPd4sAinfONa/onywmRDwM?=
 =?iso-8859-1?Q?jh3dZwwhqeKx/zfxy5CkYmeIM3k8cNsNgRSkkXMXX4ZC8UFuaP2p2il1U7?=
 =?iso-8859-1?Q?A62lhgZ3XQON20dNTSaJxBAtg8VtHagepGzHbW6QfcZW3srpgL0KqxxOQU?=
 =?iso-8859-1?Q?mW5Lw41veWiqwTnNvXYglUsjo8POEOGUavAkdM2kFRTlZ/Mf6VhzYCLAc8?=
 =?iso-8859-1?Q?mLXSqF5D337LOXVi+5oUVeX1d57H53Jaaj+jkA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yazrK4lnqVEyLJYoSe97x0GzLLVCbdAxrevV1V3z0zJaPlKIkfMnSExD6u?=
 =?iso-8859-1?Q?QwTXx0Cp0zCc01dhs5Ztd5IAvbmBYNz2u8K4SmBO3z08Ew2mgkeRK09K3/?=
 =?iso-8859-1?Q?aW3T6y9gsVfi2Yktw5b3qtjEvJ2ZZH0Zv4P7UT50lGb/X6g9LMkZh1nsPl?=
 =?iso-8859-1?Q?jhf3buHqqxAwirfQtXkX9vlbaIOSioS5xrcNYrn9auk5J2j/DT5LsvIyZt?=
 =?iso-8859-1?Q?WfHcZA4T6UYP1GC9esmSDh6+WLdz496q8L8RPBDdUwkPJYfpAvwXdK73/T?=
 =?iso-8859-1?Q?SoO4R2NHZCW6vLegrzckJFeK+huvv7Mjg5P+XXluDOkpQQjUCsCP5vdh8G?=
 =?iso-8859-1?Q?8ys5mlBq2llZy6GMAkjsjmjklfO7LypS036mZqdru21x84BJORHE0ZMbBx?=
 =?iso-8859-1?Q?Eeu4ObTZYlz4tsnGxKg/brKSS+C4itkGu/oqBZrqI0ebmFPh7gd7yYRVa4?=
 =?iso-8859-1?Q?8Oqasnu8HV/0siXTMIJk/VZZYGohzKttXg/86zeso47CpjVa4+ZXKDk0X8?=
 =?iso-8859-1?Q?/zncyxwwAcWs4vRgJOCeSkz2hSAnAD0I7Jgba2FERJHsRWtdgKTTNEDSXw?=
 =?iso-8859-1?Q?3CR39LLtURerUM4/NRrpQSK+y+Mvy6Q2oHN9Rt0xhvY09zSIt/c52WKWeH?=
 =?iso-8859-1?Q?QF7zLO3lgyZF5rLIvvRB1Q1G6EsLou/+gjBbg3a721bwVioqdaqVyYJQx3?=
 =?iso-8859-1?Q?x4S1kmZEnXK/EDwdywA+dso8+WDudJvgBZ2dtYIjoRqun+siE4giTw1An2?=
 =?iso-8859-1?Q?y0qRRmDmR7zJ9vYjyYQDkrkpan3huoFH4YwHQ/kdMJmRha5235QOexYaT8?=
 =?iso-8859-1?Q?zNQShbRt7wgZGdq2oiB08z/d1WpQMLOxS3nmkC9FI3PZoHlrCGIxL6f+2s?=
 =?iso-8859-1?Q?cW+pPHkqH0YuDmIHQKfsYs+47+wYpXvRfIeNxqjSUv0vKnuXLFFtyJWLFx?=
 =?iso-8859-1?Q?eg0/XctbAXTdwvVONtDAWx/U2uh2gi+u3KRyrsMUJ17FH0DvZvOkIqN+Yw?=
 =?iso-8859-1?Q?Vesk3gSKamrmKmEneEMcMzeWWtHcHvhTgd2ds49HIvtCfb0O3Ks8PEkBuK?=
 =?iso-8859-1?Q?aHRz56tEJapJP8rm3ty46/Jg5bI4eMMpTlTwuJxGQ5gc/GkIbMxOcFrmBQ?=
 =?iso-8859-1?Q?QKJ+HAi2Mnt6o1K0tnMbZ80CnHzDuN6pixYidQiKoSP8dcV1j+4y0BrDu+?=
 =?iso-8859-1?Q?nn6QylIw0wtz7Toi3/DUqTHNTZI4SrGQ4Qt82ti8f+anoMJhq7Zxg4pv/j?=
 =?iso-8859-1?Q?A865UHALK+e2X1IXT/hI+VIYNZTo8lewnm1F5EyYrlxx1anS+vOcX4uzdC?=
 =?iso-8859-1?Q?UtGSqRFnPYHzxFR56iQ5Ei149YS+K/f28c5VORJhYJySKTUbN31l7uR8Jt?=
 =?iso-8859-1?Q?FzDA9qnSTZDletITkSdLK5ukkSp2oNB8rU75M2ZtQZNa3+eiIitJQoBN9E?=
 =?iso-8859-1?Q?ewxEYw9HXXlJc088m1gvQKgA6GZ7DmVWnuo0zj8z+BPyxY336cYC875Thf?=
 =?iso-8859-1?Q?Uqrrdl3LdZh8YB+HfgYVk8oZ3k8lb+6mpnTshtoCMhentKvySbSqXFFc1W?=
 =?iso-8859-1?Q?cRVoIKXvvnjGNrFLe6vjiP2c6SqACI+X7O4miJfLS4SKblLBLhIs83CSUY?=
 =?iso-8859-1?Q?CWOCsuYpuaKra/jH0/1z622a06wvYTEu77xpiXEBJMFvkXbey7FJpwREhg?=
 =?iso-8859-1?Q?OgJgpnspTA9EcaSjoQ4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d3e049-c7d8-4e5c-5687-08dd15ba65ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 05:54:07.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcchsYqEYfruCwWdltlqDvQKZgHaRXe5HamiGuc3onGrtIF2MuUgWoAOqCgUBdsgU4ZFWC6hkJLviXLJVuxBMO0jlhQpeDhLeF0pvmhBbQDrrJy+LT7qgUbu4uoNSf3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1677

Hi Bhavin,=0A=
=0A=
A small nit =0A=
=0A=
> Adds initial support for the STC3117 fuel gauge.=0A=
> =0A=
> The driver provides functionality to monitor key parameters including:=0A=
> - Voltage=0A=
> - Current=0A=
> - State of Charge (SOC)=0A=
> - Temperature=0A=
> - Status=0A=
>=0A=
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>=0A=
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
=0A=
[...]=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver=
=0A=
> + *=0A=
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.=0A=
> + * Author:=A0=A0=A0=A0=A0 Hardevsinh Palaniya <hardevsinh.palaniya@silic=
onsignals.com>=0A=
=0A=
Domain name should be "siliconsignals.io" in author.=0A=
Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
=0A=
Otherwise looks good  =0A=
=0A=
Thanks=0A=
Hardev=0A=
________________________________________=0A=
From:=A0Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
Sent:=A0Monday, December 2, 2024 3:11 PM=0A=
To:=A0sre@kernel.org <sre@kernel.org>; christophe.jaillet@wanadoo.fr <chris=
tophe.jaillet@wanadoo.fr>=0A=
Cc:=A0Bhavin Sharma <bhavin.sharma@siliconsignals.io>; Hardevsinh Palaniya =
<hardevsinh.palaniya@siliconsignals.io>; Rob Herring <robh@kernel.org>; Krz=
ysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; =
linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; devicetree@vger.kernel=
.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kern=
el@vger.kernel.org>=0A=
Subject:=A0[PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver=
=0A=
=A0=0A=
Adds initial support for the STC3117 fuel gauge.=0A=
=0A=
The driver provides functionality to monitor key parameters including:=0A=
- Voltage=0A=
- Current=0A=
- State of Charge (SOC)=0A=
- Temperature=0A=
- Status=0A=
=0A=
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
---=0A=
=A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 +=0A=
=A0drivers/power/supply/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 7 +=0A=
=A0drivers/power/supply/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 1 +=0A=
=A0drivers/power/supply/stc3117_fuel_gauge.c | 665 ++++++++++++++++++++++=
=0A=
=A04 files changed, 681 insertions(+)=0A=
=A0create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index c1fcc56bf2fb..10ead03660d5 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -22125,6 +22125,14 @@ T:=A0=A0=A0=A0 git git://linuxtv.org/media.git=0A=
=A0F:=A0=A0=A0=A0=A0 Documentation/devicetree/bindings/media/i2c/st,st-mipi=
d02.yaml=0A=
=A0F:=A0=A0=A0=A0=A0 drivers/media/i2c/st-mipid02.c=0A=
=A0=0A=
+ST STC3117 FUEL GAUGE DRIVER=0A=
+M:=A0=A0=A0=A0 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
+M:=A0=A0=A0=A0 Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
+L:=A0=A0=A0=A0 linux-pm@vger.kernel.org=0A=
+S:=A0=A0=A0=A0 Maintained=0A=
+F:=A0=A0=A0=A0 Documentation/devicetree/bindings/power/supply/st,stc3117.y=
aml=0A=
+F:=A0=A0=A0=A0 drivers/power/supply/stc3117_fuel_gauge.c=0A=
+=0A=
=A0ST STM32 FIREWALL=0A=
=A0M:=A0=A0=A0=A0=A0 Gatien Chevallier <gatien.chevallier@foss.st.com>=0A=
=A0S:=A0=A0=A0=A0=A0 Maintained=0A=
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig=0A=
index 9f2eef6787f7..9f34a2a6bc00 100644=0A=
--- a/drivers/power/supply/Kconfig=0A=
+++ b/drivers/power/supply/Kconfig=0A=
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Say Y here to enable support for fuel gauge =
with SC27XX=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PMIC chips.=0A=
=A0=0A=
+config FUEL_GAUGE_STC3117=0A=
+=A0=A0=A0=A0=A0=A0 tristate "STMicroelectronics STC3117 fuel gauge driver"=
=0A=
+=A0=A0=A0=A0=A0=A0 depends on I2C=0A=
+=A0=A0=A0=A0=A0=A0 help=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 Say Y here to enable support for fuel gauge with =
STC3117=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 chip.=0A=
+=0A=
=A0config CHARGER_UCS1002=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 tristate "Microchip UCS1002 USB Port Power Control=
ler"=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 depends on I2C=0A=
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile=
=0A=
index 59c4a9f40d28..b55cc48a4c86 100644=0A=
--- a/drivers/power/supply/Makefile=0A=
+++ b/drivers/power/supply/Makefile=0A=
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)=A0=A0=A0 +=3D cros_usb=
pd-charger.o=0A=
=A0obj-$(CONFIG_CHARGER_CROS_PCHG) +=3D cros_peripheral_charger.o=0A=
=A0obj-$(CONFIG_CHARGER_SC2731)=A0=A0=A0 +=3D sc2731_charger.o=0A=
=A0obj-$(CONFIG_FUEL_GAUGE_SC27XX) +=3D sc27xx_fuel_gauge.o=0A=
+obj-$(CONFIG_FUEL_GAUGE_STC3117)=A0=A0=A0=A0=A0=A0 +=3D stc3117_fuel_gauge=
.o=0A=
=A0obj-$(CONFIG_CHARGER_UCS1002)=A0=A0 +=3D ucs1002_power.o=0A=
=A0obj-$(CONFIG_CHARGER_BD99954)=A0=A0 +=3D bd99954-charger.o=0A=
=A0obj-$(CONFIG_CHARGER_WILCO)=A0=A0=A0=A0 +=3D wilco-charger.o=0A=
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supp=
ly/stc3117_fuel_gauge.c=0A=
new file mode 100644=0A=
index 000000000000..ffa7e0d35474=0A=
--- /dev/null=0A=
+++ b/drivers/power/supply/stc3117_fuel_gauge.c=0A=
@@ -0,0 +1,665 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver=0A=
+ *=0A=
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.=0A=
+ * Author:=A0=A0=A0=A0=A0 Hardevsinh Palaniya <hardevsinh.palaniya@silicon=
signals.com>=0A=
+ *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bhavin Sharma <bhavin.sharma@sil=
iconsignals.io>=0A=
+ */=0A=
+=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/workqueue.h>=0A=
+#include <linux/power_supply.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/crc8.h>=0A=
+=0A=
+#define STC3117_ADDR_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x00=0A=
+#define STC3117_ADDR_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x01=0A=
+#define STC3117_ADDR_SOC_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x02=0A=
+#define STC3117_ADDR_SOC_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x03=0A=
+#define STC3117_ADDR_COUNTER_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x04=0A=
+#define STC3117_ADDR_COUNTER_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x05=0A=
+#define STC3117_ADDR_CURRENT_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x06=0A=
+#define STC3117_ADDR_CURRENT_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x07=0A=
+#define STC3117_ADDR_VOLTAGE_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x08=0A=
+#define STC3117_ADDR_VOLTAGE_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x09=0A=
+#define STC3117_ADDR_TEMPERATURE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0x0A=0A=
+#define STC3117_ADDR_AVG_CURRENT_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X0=
B=0A=
+#define STC3117_ADDR_AVG_CURRENT_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X0=
C=0A=
+#define STC3117_ADDR_OCV_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X0D=0A=
+#define STC3117_ADDR_OCV_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X0E=0A=
+#define STC3117_ADDR_CC_CNF_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X0F=0A=
+#define STC3117_ADDR_CC_CNF_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X10=0A=
+#define STC3117_ADDR_VM_CNF_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X11=0A=
+#define STC3117_ADDR_VM_CNF_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X12=0A=
+#define STC3117_ADDR_ALARM_soc=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X13=0A=
+#define STC3117_ADDR_ALARM_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X1=
4=0A=
+#define STC3117_ADDR_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0X18=0A=
+#define STC3117_ADDR_CC_ADJ_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X1B=0A=
+#define STC3117_ADDR_CC_ADJ_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X1C=0A=
+#define STC3117_ADDR_VM_ADJ_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X1D=0A=
+#define STC3117_ADDR_VM_ADJ_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0X1E=0A=
+#define STC3117_ADDR_RAM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x20=0A=
+#define STC3117_ADDR_OCV_TABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x30=0A=
+#define STC3117_ADDR_SOC_TABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x30=0A=
+=0A=
+/* Bit mask definition */=0A=
+#define STC3117_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x16=0A=
+#define STC3117_MIXED_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x00=0A=
+#define STC3117_VMODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 BIT(0)=0A=
+#define STC3117_GG_RUN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
+#define STC3117_CC_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
+#define STC3117_BATFAIL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 BIT(3)=0A=
+#define STC3117_PORDET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
+#define STC3117_RAM_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 16=0A=
+#define STC3117_OCV_TABLE_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 16=0A=
+#define STC3117_RAM_TESTWORD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x53A9=0A=
+#define STC3117_SOFT_RESET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x11=0A=
+#define STC3117_NOMINAL_CAPACITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 2600=0A=
+=0A=
+#define VOLTAGE_LSB_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 9011=0A=
+#define CURRENT_LSB_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 24084=0A=
+#define APP_CUTOFF_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2500=0A=
+#define MAX_HRSOC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 51200=0A=
+#define MAX_SOC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1000=0A=
+#define CHG_MIN_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 200=0A=
+#define CHG_END_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 20=0A=
+#define APP_MIN_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (-5)=0A=
+#define BATTERY_FULL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 95=0A=
+#define CRC8_POLYNOMIAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x07=0A=
+#define CRC8_INIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00=0A=
+=0A=
+DECLARE_CRC8_TABLE(stc3117_crc_table);=0A=
+=0A=
+enum stc3117_state {=0A=
+=A0=A0=A0=A0=A0=A0 STC3117_INIT,=0A=
+=A0=A0=A0=A0=A0=A0 STC3117_RUNNING,=0A=
+=A0=A0=A0=A0=A0=A0 STC3117_POWERDN,=0A=
+};=0A=
+=0A=
+enum stc3117_status {=0A=
+=A0=A0=A0=A0=A0=A0 BATT_LOWBATT =3D -2,=0A=
+=A0=A0=A0=A0=A0=A0 BATT_DISCHARG,=0A=
+=A0=A0=A0=A0=A0=A0 BATT_IDLE,=0A=
+=A0=A0=A0=A0=A0=A0 BATT_FULCHARG,=0A=
+=A0=A0=A0=A0=A0=A0 BATT_ENDCHARG,=0A=
+=A0=A0=A0=A0=A0=A0 BATT_CHARGING,=0A=
+};=0A=
+=0A=
+/* Default ocv curve Li-ion battery */=0A=
+static const int ocv_value[16] =3D {=0A=
+=A0=A0=A0=A0=A0=A0 3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,=0A=
+=A0=A0=A0=A0=A0=A0 3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320=0A=
+};=0A=
+=0A=
+static union stc3117_internal_ram {=0A=
+=A0=A0=A0=A0=A0=A0 u8 ram_bytes[STC3117_RAM_SIZE];=0A=
+=A0=A0=A0=A0=A0=A0 struct {=0A=
+=A0=A0=A0=A0=A0=A0 u16 testword;=A0=A0 /* 0-1=A0=A0=A0 Bytes */=0A=
+=A0=A0=A0=A0=A0=A0 u16 hrsoc;=A0=A0=A0=A0=A0 /* 2-3=A0=A0=A0 Bytes */=0A=
+=A0=A0=A0=A0=A0=A0 u16 cc_cnf;=A0=A0=A0=A0 /* 4-5=A0=A0=A0 Bytes */=0A=
+=A0=A0=A0=A0=A0=A0 u16 vm_cnf;=A0=A0=A0=A0 /* 6-7=A0=A0=A0 Bytes */=0A=
+=A0=A0=A0=A0=A0=A0 u8 soc;=A0=A0=A0=A0=A0=A0=A0=A0 /* 8=A0=A0=A0=A0=A0 Byt=
e=A0 */=0A=
+=A0=A0=A0=A0=A0=A0 u8 state;=A0=A0=A0=A0=A0=A0 /* 9=A0=A0=A0=A0=A0 Byte=A0=
 */=0A=
+=A0=A0=A0=A0=A0=A0 u8 unused[5];=A0=A0 /* 10-14=A0 Bytes */=0A=
+=A0=A0=A0=A0=A0=A0 u8 crc;=A0=A0=A0=A0=A0=A0=A0=A0 /* 15=A0=A0=A0=A0 Byte=
=A0 */=0A=
+=A0=A0=A0=A0=A0=A0 } reg;=0A=
+} ram_data;=0A=
+=0A=
+struct stc3117_data {=0A=
+=A0=A0=A0=A0=A0=A0 struct i2c_client *client;=0A=
+=A0=A0=A0=A0=A0=A0 struct regmap *regmap;=0A=
+=A0=A0=A0=A0=A0=A0 struct delayed_work update_work;=0A=
+=A0=A0=A0=A0=A0=A0 struct power_supply *battery;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 u8 soc_tab[16];=0A=
+=A0=A0=A0=A0=A0=A0 int cc_cnf;=0A=
+=A0=A0=A0=A0=A0=A0 int vm_cnf;=0A=
+=A0=A0=A0=A0=A0=A0 int cc_adj;=0A=
+=A0=A0=A0=A0=A0=A0 int vm_adj;=0A=
+=A0=A0=A0=A0=A0=A0 int avg_current;=0A=
+=A0=A0=A0=A0=A0=A0 int avg_voltage;=0A=
+=A0=A0=A0=A0=A0=A0 int batt_current;=0A=
+=A0=A0=A0=A0=A0=A0 int voltage;=0A=
+=A0=A0=A0=A0=A0=A0 int temp;=0A=
+=A0=A0=A0=A0=A0=A0 int soc;=0A=
+=A0=A0=A0=A0=A0=A0 int ocv;=0A=
+=A0=A0=A0=A0=A0=A0 int hrsoc;=0A=
+=A0=A0=A0=A0=A0=A0 int presence;=0A=
+=A0=A0=A0=A0=A0=A0 int battery_state;=0A=
+};=0A=
+=0A=
+struct stc3117_battery_info {=0A=
+=A0=A0=A0=A0=A0=A0 int voltage_min_mv;=0A=
+=A0=A0=A0=A0=A0=A0 int voltage_max_mv;=0A=
+=A0=A0=A0=A0=A0=A0 int battery_capacity_mah;=0A=
+=A0=A0=A0=A0=A0=A0 int sense_resistor;=0A=
+} battery_info;=0A=
+=0A=
+static int stc3117_convert(int value, int factor)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (value * factor) / 4096;=0A=
+=A0=A0=A0=A0=A0=A0 return value;=0A=
+}=0A=
+=0A=
+static int stc3117_get_battery_data(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 u8 reg_list[16];=0A=
+=A0=A0=A0=A0=A0=A0 u8 data_adjust[4];=0A=
+=A0=A0=A0=A0=A0=A0 int value, mode;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg_=
list, sizeof(reg_list));=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* soc */=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (reg_list[3] << 8) + reg_list[2];=0A=
+=A0=A0=A0=A0=A0=A0 data->hrsoc =3D value;=0A=
+=A0=A0=A0=A0=A0=A0 data->soc =3D (value * 10 + 256) / 512;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* cureent in mA*/=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (reg_list[7] << 8) + reg_list[6];=0A=
+=A0=A0=A0=A0=A0=A0 data->batt_current =3D stc3117_convert(value,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 CURRENT_LSB_VALUE / battery_info.sense_resistor);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* voltage in mV */=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (reg_list[9] << 8) + reg_list[8];=0A=
+=A0=A0=A0=A0=A0=A0 data->voltage =3D stc3117_convert(value, VOLTAGE_LSB_VA=
LUE);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* temp */=0A=
+=A0=A0=A0=A0=A0=A0 data->temp =3D reg_list[10];=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* Avg batt_current in mA */=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (reg_list[12] << 8) + reg_list[11];=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);=0A=
+=A0=A0=A0=A0=A0=A0 if (!(mode & STC3117_VMODE)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 value =3D stc3117_convert(value=
,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 C=
URRENT_LSB_VALUE / battery_info.sense_resistor);=0A=
+=A0=A0=A0=A0=A0=A0 value =3D value / 4;=0A=
+=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 value =3D stc3117_convert(value=
, 36 * STC3117_NOMINAL_CAPACITY);=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0 data->avg_current =3D value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* ocv */=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (reg_list[14] << 8) + reg_list[13];=0A=
+=A0=A0=A0=A0=A0=A0 value =3D stc3117_convert(value, VOLTAGE_LSB_VALUE);=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (value + 2) / 4;=0A=
+=A0=A0=A0=A0=A0=A0 data->ocv =3D value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* CC & VM adjustment counters */=0A=
+=A0=A0=A0=A0=A0=A0 regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data=
_adjust, sizeof(data_adjust));=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (data_adjust[1] << 8) + data_adjust[0];=0A=
+=A0=A0=A0=A0=A0=A0 data->cc_adj =3D value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 value =3D (data_adjust[3] << 8) + data_adjust[2];=0A=
+=A0=A0=A0=A0=A0=A0 data->vm_adj =3D value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static int stc3117_update_battery_status(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 switch (data->battery_state) {=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_CHARGING:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->avg_current < CHG_MIN=
_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_ENDCHARG;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_ENDCHARG:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->batt_current > CHG_MI=
N_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_CHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (data->avg_current < CH=
G_END_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_IDLE;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if ((data->batt_current > =
CHG_END_CURRENT) &&=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (dat=
a->voltage > battery_info.voltage_max_mv))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_FULCHARG;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_FULCHARG:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->batt_current > CHG_MI=
N_CURRENT) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_CHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (data->avg_current < =
CHG_END_CURRENT) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dat=
a->avg_voltage > battery_info.voltage_max_mv) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 regmap_write(data->regmap, STC3117_ADDR_SOC_H,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (MAX_HRSOC >> 8 &=
 0xFF));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 regmap_write(data->regmap, STC3117_ADDR_SOC_L,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (MAX_HRSOC & 0xFF=
));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 data->soc =3D MAX_SOC;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_IDLE;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_IDLE:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->batt_current > CHG_EN=
D_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_CHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (data->batt_current < A=
PP_MIN_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_DISCHARG;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_DISCHARG:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->batt_current > APP_MI=
N_CURRENT)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_IDLE;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (data->avg_voltage < ba=
ttery_info.voltage_min_mv)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_LOWBATT;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 case BATT_LOWBATT:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->avg_voltage > (batter=
y_info.voltage_min_mv + 50))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
attery_state =3D BATT_IDLE;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 default:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->battery_state =3D BATT_ID=
LE;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static int ram_write(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_bulk_write(data->regmap, STC3117_ADDR_RA=
M,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ram_data.ram_bytes, STC3117_RAM_SIZE);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+};=0A=
+=0A=
+static int ram_read(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_bulk_read(data->regmap, STC3117_ADDR_RAM=
,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ram_data.ram_bytes, STC3117_RAM_SIZE);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+};=0A=
+=0A=
+static int stc3117_set_para(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(data->regmap, STC3117_ADDR_MODE, S=
TC3117_VMODE);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 for (int i =3D 0; i < STC3117_OCV_TABLE_SIZE; i++)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->reg=
map, STC3117_ADDR_OCV_TABLE + i,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ocv_value[i] * 100 / 55);=0A=
+=A0=A0=A0=A0=A0=A0 if (data->soc_tab[1] !=3D 0)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_bulk_write(data=
->regmap, STC3117_ADDR_SOC_TABLE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 data->soc_tab, STC3117_OCV_TABLE_SIZE);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_CC_CNF=
_H,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.cc_cnf >> 8) & 0xF=
F);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_CC_CNF=
_L,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.cc_cnf & 0xFF);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_VM_CNF=
_H,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.vm_cnf >> 8) & 0xF=
F);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_VM_CNF=
_L,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.vm_cnf & 0xFF);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_CTRL, =
0x03);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->regmap, STC3117_ADDR_MODE,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_MIXED_MODE | STC3117_GG_=
RUN);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return ret;=0A=
+};=0A=
+=0A=
+static int stc3117_init(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 int ID, ret;=0A=
+=A0=A0=A0=A0=A0=A0 int ctrl;=0A=
+=A0=A0=A0=A0=A0=A0 int ocv_m, ocv_l;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(data->regmap, STC3117_ADDR_ID, &ID);=0A=
+=A0=A0=A0=A0=A0=A0 if (ID !=3D STC3117_ID)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data->cc_cnf =3D (battery_info.battery_capacity_mah *=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 battery=
_info.sense_resistor * 250 + 6194) / 12389;=0A=
+=A0=A0=A0=A0=A0=A0 data->vm_cnf =3D (battery_info.battery_capacity_mah=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * 200 * =
50 + 24444) / 48889;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* Battery has not been removed */=0A=
+=A0=A0=A0=A0=A0=A0 data->presence =3D 1;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* Read RAM data */=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D ram_read(data);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (ram_data.reg.testword !=3D STC3117_RAM_TESTWORD ||=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crc8(stc3117_crc_table, ram_data.ram_bytes=
,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE, CRC8_INIT)) !=
=3D 0) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.testword =3D STC31=
17_RAM_TESTWORD;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.cc_cnf =3D data->c=
c_cnf;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.vm_cnf =3D data->v=
m_cnf;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.crc =3D crc8(stc31=
17_crc_table, ram_data.ram_bytes,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE - 1, CRC8_INIT)=
;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(data->regma=
p, STC3117_ADDR_OCV_H, &ocv_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_read(data->regm=
ap, STC3117_ADDR_OCV_L, &ocv_l);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D stc3117_set_para(data)=
;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->reg=
map, STC3117_ADDR_OCV_H, ocv_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->reg=
map, STC3117_ADDR_OCV_L, ocv_l);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(data->regma=
p, STC3117_ADDR_CTRL, &ctrl);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((ctrl & STC3117_BATFAIL) !=
=3D 0=A0 ||=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ctrl & STC3117_POR=
DET) !=3D 0) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D=
 regmap_read(data->regmap,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_ADDR_OCV_H, &ocv_m=
);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_read(data->regmap,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_=
ADDR_OCV_L, &ocv_l);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D stc3117_set_para(data);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_=
ADDR_OCV_H, ocv_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_=
ADDR_OCV_L, ocv_l);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D=
 stc3117_set_para(data);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_SOC_H,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.hrsoc >> 8 & 0xFF));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_SOC_L,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.hrsoc & 0xFF));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ram_data.reg.state =3D STC3117_INIT;=0A=
+=A0=A0=A0=A0=A0=A0 ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.r=
am_bytes,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE - 1, CRC8_INIT);=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D ram_write(data);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data->battery_state =3D BATT_IDLE;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+};=0A=
+=0A=
+static int stc3117_task(struct stc3117_data *data)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 int ID, mode, ret;=0A=
+=A0=A0=A0=A0=A0=A0 int count_l, count_m;=0A=
+=A0=A0=A0=A0=A0=A0 int ocv_l, ocv_m;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(data->regmap, STC3117_ADDR_ID, &ID);=0A=
+=A0=A0=A0=A0=A0=A0 if (ID !=3D STC3117_ID) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->presence =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 stc3117_get_battery_data(data);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* Read RAM data */=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D ram_read(data);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (ram_data.reg.testword !=3D STC3117_RAM_TESTWORD ||=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crc8(stc3117_crc_table, ram_data.ram_bytes=
,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE, CRC8_INIT) !=
=3D 0)) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.testword =3D STC31=
17_RAM_TESTWORD;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.cc_cnf =3D data->c=
c_cnf;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.vm_cnf =3D data->v=
m_cnf;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.crc =3D crc8(stc31=
17_crc_table, ram_data.ram_bytes,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE - 1, CRC8_INIT)=
;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.state =3D STC3117_=
INIT;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* check battery presence status */=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(data->regmap, STC3117_ADDR_CTRL, &m=
ode);=0A=
+=A0=A0=A0=A0=A0=A0 if ((mode & STC3117_BATFAIL) !=3D 0) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->presence =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.testword =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.state =3D STC3117_=
INIT;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D ram_write(data);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D regmap_write(data->reg=
map, STC3117_ADDR_CTRL, STC3117_PORDET);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data->presence =3D 1;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(data->regmap, STC3117_ADDR_MODE, &m=
ode);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0 if ((mode & STC3117_GG_RUN) =3D=3D 0) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ram_data.reg.state > STC311=
7_INIT) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D=
 stc3117_set_para(data);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_SOC_H,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.hrsoc >> 8 & 0xFF)=
);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_SOC_L,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (ram_data.reg.hrsoc & 0xFF));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D=
 regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D stc3117_set_para(data);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=
=3D regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.state =3D STC3117_=
INIT;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &coun=
t_l);=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &coun=
t_m);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 count_m =3D (count_m << 8) + count_l;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* INIT state, wait for batt_current & temperature valu=
e available: */=0A=
+=A0=A0=A0=A0=A0=A0 if (ram_data.reg.state =3D=3D STC3117_INIT && count_m >=
 4) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->avg_voltage =3D data->vol=
tage;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->avg_current =3D data->bat=
t_current;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ram_data.reg.state =3D STC3117_=
RUNNING;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (ram_data.reg.state !=3D STC3117_RUNNING) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->batt_current =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->temp =3D 250;=0A=
+=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->voltage < APP_CUTOFF_=
VOLTAGE)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->s=
oc =3D 0;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (mode & STC3117_VMODE) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->a=
vg_current =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data->b=
att_current =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stc3117=
_update_battery_status(data);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ram_data.reg.hrsoc =3D data->hrsoc;=0A=
+=A0=A0=A0=A0=A0=A0 ram_data.reg.soc =3D (data->soc + 5) / 10;=0A=
+=A0=A0=A0=A0=A0=A0 ram_data.reg.crc =3D crc8(stc3117_crc_table, ram_data.r=
am_bytes,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 STC3117_RAM_SIZE - 1, CRC8_INIT);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D ram_write(data);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+};=0A=
+=0A=
+static void fuel_gauge_update_work(struct work_struct *work)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct stc3117_data *data =3D container_of(to_delayed_w=
ork(work),=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct stc3117_data, update_work=
);=0A=
+=A0=A0=A0=A0=A0=A0 stc3117_task(data);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 /* Schedule the work to run again in 2 seconds */=0A=
+=A0=A0=A0=A0=A0=A0 schedule_delayed_work(&data->update_work, msecs_to_jiff=
ies(2000));=0A=
+}=0A=
+=0A=
+static int stc3117_get_property(struct power_supply *psy,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum power_supply_property psp,=
 union power_supply_propval *val)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct stc3117_data *data =3D power_supply_get_drvdata(=
psy);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 switch (psp) {=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_STATUS:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (data->soc > BATTERY_FULL)=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->in=
tval =3D POWER_SUPPLY_STATUS_FULL;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (data->batt_current < 0=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->in=
tval =3D POWER_SUPPLY_STATUS_CHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (data->batt_current > 0=
)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->in=
tval =3D POWER_SUPPLY_STATUS_DISCHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->in=
tval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_VOLTAGE_NOW:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->intval =3D data->voltage;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_CURRENT_NOW:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->intval =3D data->batt_curr=
ent;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_CAPACITY:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->intval =3D data->soc;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_TEMP:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->intval =3D data->temp;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 case POWER_SUPPLY_PROP_PRESENT:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val->intval =3D data->presence;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
+=A0=A0=A0=A0=A0=A0 default:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static enum power_supply_property stc3117_battery_props[] =3D {=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_STATUS,=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_VOLTAGE_NOW,=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_CURRENT_NOW,=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_CAPACITY,=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_TEMP,=0A=
+=A0=A0=A0=A0=A0=A0 POWER_SUPPLY_PROP_PRESENT,=0A=
+};=0A=
+=0A=
+static const struct power_supply_desc stc3117_battery_desc =3D {=0A=
+=A0=A0=A0=A0=A0=A0 .name =3D "stc3117-battery",=0A=
+=A0=A0=A0=A0=A0=A0 .type =3D POWER_SUPPLY_TYPE_BATTERY,=0A=
+=A0=A0=A0=A0=A0=A0 .get_property =3D stc3117_get_property,=0A=
+=A0=A0=A0=A0=A0=A0 .properties =3D stc3117_battery_props,=0A=
+=A0=A0=A0=A0=A0=A0 .num_properties =3D ARRAY_SIZE(stc3117_battery_props),=
=0A=
+};=0A=
+=0A=
+static const struct regmap_config stc3117_regmap_config =3D {=0A=
+=A0=A0=A0=A0=A0=A0 .reg_bits=A0=A0=A0=A0=A0=A0 =3D 8,=0A=
+=A0=A0=A0=A0=A0=A0 .val_bits=A0=A0=A0=A0=A0=A0 =3D 8,=0A=
+};=0A=
+=0A=
+static int stc3117_probe(struct i2c_client *client)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct stc3117_data *data;=0A=
+=A0=A0=A0=A0=A0=A0 struct power_supply_config psy_cfg =3D {};=0A=
+=A0=A0=A0=A0=A0=A0 struct power_supply_battery_info *info;=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_=
KERNEL);=0A=
+=A0=A0=A0=A0=A0=A0 if (!data)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data->client =3D client;=0A=
+=A0=A0=A0=A0=A0=A0 data->regmap =3D devm_regmap_init_i2c(client, &stc3117_=
regmap_config);=0A=
+=A0=A0=A0=A0=A0=A0 if (IS_ERR(data->regmap))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(data->regmap);=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 psy_cfg.drv_data =3D data;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 data->battery =3D devm_power_supply_register(&client->d=
ev,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 &stc3117_battery_desc, &psy_cfg);=0A=
+=A0=A0=A0=A0=A0=A0 if (IS_ERR(data->battery))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(&client->d=
ev, PTR_ERR(data->battery),=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to register battery\n");=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D device_property_read_u32(&client->dev, "shunt-r=
esistor-micro-ohms",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &battery_info.sense_resistor);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(&client->d=
ev, ret,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to get sense-registor\n"=
);=0A=
+=A0=A0=A0=A0=A0=A0 battery_info.sense_resistor =3D battery_info.sense_resi=
stor / 1000;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D power_supply_get_battery_info(data->battery, &i=
nfo);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(&client->d=
ev, ret,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to get battery informati=
on\n");=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 battery_info.battery_capacity_mah =3D info->charge_full=
_design_uah / 1000;=0A=
+=A0=A0=A0=A0=A0=A0 battery_info.voltage_min_mv =3D info->voltage_min_desig=
n_uv / 1000;=0A=
+=A0=A0=A0=A0=A0=A0 battery_info.voltage_max_mv =3D info->voltage_max_desig=
n_uv / 1000;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D stc3117_init(data);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return dev_err_probe(&client->d=
ev, ret,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "failed to initialize of stc3117\n");=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update=
_work);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 schedule_delayed_work(&data->update_work, 0);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static const struct i2c_device_id stc3117_id[] =3D {=0A=
+=A0=A0=A0=A0=A0=A0 { "stc3117", 0 },=0A=
+=A0=A0=A0=A0=A0=A0 { }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(i2c, stc3117_id);=0A=
+=0A=
+static const struct of_device_id stc3117_of_match[] =3D {=0A=
+=A0=A0=A0=A0=A0=A0 { .compatible =3D "st,stc3117" },=0A=
+=A0=A0=A0=A0=A0=A0 { }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, stc3117_of_match);=0A=
+=0A=
+static struct i2c_driver stc3117_i2c_driver =3D {=0A=
+=A0=A0=A0=A0=A0=A0 .driver =3D {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "stc3117_i2c_driver",=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D stc3117_of_=
match,=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 .probe =3D stc3117_probe,=0A=
+=A0=A0=A0=A0=A0=A0 .id_table =3D stc3117_id,=0A=
+};=0A=
+=0A=
+module_i2c_driver(stc3117_i2c_driver);=0A=
+=0A=
+MODULE_LICENSE("GPL");=0A=
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
");=0A=
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");=0A=
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");=0A=
--=0A=
2.43.0=0A=

