Return-Path: <linux-pm+bounces-19875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413599FF3B2
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584903A150F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2025 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9A12C470;
	Wed,  1 Jan 2025 10:41:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021143.outbound.protection.outlook.com [40.107.57.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3545003;
	Wed,  1 Jan 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735728063; cv=fail; b=HK1SwKtVm/z1PNgH6hDIs3Ov4xQ7nxeXLDKkPJcXkF1/AIWrgm+OErEN3PESwCIVw1OBYidIWnGqFfaiWbar/PVOrR1YLQzcjC0m6sHWXxyoXuFv/s5lxBmC0q7a3vD3cidPxTxaSmum1+lILeD2zYdXm00r8jYFVvCdf5T/0/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735728063; c=relaxed/simple;
	bh=/SLgxl342U8r1T5GNj3rNrOG3lov5a7+a0xJovp1Iuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ny0qgmDyhiuHSdWxOuZwX8uTas7fYC8Zdkh6LQioDOPeuNsGoBWfYEf1cgNeR/+2sCkJhq1TkukfatHFB9xKAPaiMjubJRBn3db9m/Xlft5hEdlC86+Z/YHzj1p0aebKC67X3CBdpzAdoUr6iFtRvvQjAcngmJLGomBNJB5sgGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj0/QRXEKC1CET4H6NKuDPi7RkkG3lta6oADqh7UaMyS8P6BDqaamTojcPt1dlz9rV7Zp3A923t3bWtsirhvow+NVlGzDyuw8cxYKVXw5UVgsXDeyaDCko9YqBUVO3/sbXlw+SoDdWGziqq6RYlKaEn/GO1jTd9G9mqhgdD6lxCPHNsyKQm0699Np4l8xNzHkeUVrWrfZvWToXwCSe2ajphY+ToRm/RlRhuPhExoz1oMFKEraEQxv6Vbtrpx+N34B9Ly5JjNJquSxwbG3KRHkO/VPfDdDwJUtikHJQWR9F7KNmfOlRv9v60n+v994CUFd1CvR15cDUNbvLc8jLLGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SLgxl342U8r1T5GNj3rNrOG3lov5a7+a0xJovp1Iuw=;
 b=lE758+LHfQ5VaB5hlqVto6wknQYykLxPuio8tKmDI0j1sJS7dH6vEMPYik4yitSheceYEtfBpcXwnIcE98E42xLtRoO4x9svc9s69gTBWLBz0196HGWb9wi9MY87HG+XEUmCh2q/N7PQLpgo/UJXhTX3oU06sD+HQhBF9HI+udFvyN8OenW+Yb2L5zd2RABVH5Y6XsRjLtc0Vb21xtPzDpJHzXg9Fqm6aztJgvmYiMgNPfDfj7GmirbRsy/5LqB84yLJ3fwZH1tmoovN2X6kHEGHErtzVLHrj/H3MaVIWIA7oM9iz/n7z3ajT6YIkJZRD+66qIJ2xj0JqKIZzJr8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by MA0P287MB1035.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 10:40:57 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::8b0d:a711:c10b:8834]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::8b0d:a711:c10b:8834%4]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 10:40:57 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, "sre@kernel.org"
	<sre@kernel.org>
CC: Tarang Raval <tarang.raval@siliconsignals.io>, Hardevsinh Palaniya
	<hardevsinh.palaniya@siliconsignals.io>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
Thread-Index: AQHbUrxWJv/SvofEtESOcPZEfihYvbLw26MAgBDs1Qg=
Date: Wed, 1 Jan 2025 10:40:57 +0000
Message-ID:
 <PN2PPFF679F9759585FA8AC4AE446848843F20B2@PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM>
References: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
 <173479644260.3359498.3393893755513748803.b4-ty@collabora.com>
In-Reply-To: <173479644260.3359498.3393893755513748803.b4-ty@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2PPFF679F9759:EE_|MA0P287MB1035:EE_
x-ms-office365-filtering-correlation-id: 9107a5cb-cb92-4e8f-3e9b-08dd2a50c667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?M2d3LrwF+QoC/OaXLZdDYR3zP+74dV3sWEnXUf2TF1sx5AP/m8aQ6CJJ8R?=
 =?iso-8859-1?Q?s7gBW6cz4pDbP7Yl96nJcRbWEb0WJyPxjJnVi+sEktNpcCGAcMjpWJV5KD?=
 =?iso-8859-1?Q?DZdUEBSZAnyzgKfG0CMgxqKLdQsirGu11nB9haMFwl/di48YpDP2fyMffy?=
 =?iso-8859-1?Q?qu7FgpiNTAL3emyMrQLeDIDgnIBmPKx/7P5/GaMmXaAOP6F0AIRH/vay6t?=
 =?iso-8859-1?Q?8Gh+osN0VgcEMLQSsVtjGgOMm+XqkbCzEiH1LBV2HW1c0LzEiPXh8cyioi?=
 =?iso-8859-1?Q?rMYe7yh/twsBfI+MGN7MPDJymoNflCezFcSOQgLkGjo+j7wSDe0WR87zaj?=
 =?iso-8859-1?Q?75cMtHthP6UX0HLXMwam1OW30EeSTV04/Ja5iB/FWjfNW3fhhfAzlrId7x?=
 =?iso-8859-1?Q?T9g7dzbIuhMbPbj3whU/s8Tw1iI12DgUyMUQuqlxtphQVzweTbOvqnEWud?=
 =?iso-8859-1?Q?E/Dr2Y3ilabbSXWjdzur3S7wA2bfpKlKnv3wNBwMmk8Tn5gfAn4H2DUl/R?=
 =?iso-8859-1?Q?wT3xpOCcT6CMiFFiL+9R/NhQ6APmOvMIwbPLfzB/tyPOAMyAYttTbZUR+0?=
 =?iso-8859-1?Q?Y55BwcMK5a4Q9yLspy2GfueJat5C64+5Q4XGGuV2T1UPmeaN+uHmLpGcj3?=
 =?iso-8859-1?Q?4hH7zTBGbCpmR1Tr5yKgQFNNSq13GgoyU4gEvGkMB/oVSDIDI2fd03NTly?=
 =?iso-8859-1?Q?5V5I0JdbyJMx4tY7HPf78Wngv+gUEGBequWXsgjtvCabcaHlF9wVILHPoK?=
 =?iso-8859-1?Q?RS/9RVSmsu5va2JVBAbRIZS+9UjAS1YDkHviXvfdQgeoJyt8noG+KD33kt?=
 =?iso-8859-1?Q?7XfaMoADnS9alicQFadTNCd8CawI87UaNWPNeVNZSA+ZQcWBVKee3vRqy7?=
 =?iso-8859-1?Q?okJ3XonDspb2/mKkkuSQaYZl4ZIGnlzj8/EC8UHUv9zY+CRkD3a4Bp3ROh?=
 =?iso-8859-1?Q?wzOG1cQLTMu3v76IblhGO7KDHCawtjT4HJAJPMbvKsTFaN9UIt2xG8FZNV?=
 =?iso-8859-1?Q?PXzwJcNGU/viSYFtlHkzPsQjGgO2TRKABJ4Rz6BDMLIuP00GsTy0S5KjBy?=
 =?iso-8859-1?Q?KtE55qUEQ0gSY37q6wFUEbN7iupWO3nfW/nxIqO4gCAGJRK0ih2AqmQQQp?=
 =?iso-8859-1?Q?ZMrAgdM3Wa1AmWFqoie6wSyyzIjTsTsZBlFfln2srUzh7PvoPRu6UH6S+s?=
 =?iso-8859-1?Q?+XKsJ0wrfcXUm8JPQWygL7+XpyksYYaC4UXJ/CTWxPo1rSXOrafx0qfkbT?=
 =?iso-8859-1?Q?xZe69hPuZjz6lJfJVkbU3aWgzElrrrjjOvlYFAHkf3EpkVgiRdlxhhFwAM?=
 =?iso-8859-1?Q?nypHm40YJioHgG9g+JWQi/+0FZg4VZDUBkzsmfRjDZDy8POQJVC8IAsxhn?=
 =?iso-8859-1?Q?IXquUl4Iw010Pu3JCj78SoGkbe44gW1debkGGLWtzNBbeCVCyh7mmP+puX?=
 =?iso-8859-1?Q?P936Eg8Y/B+njwVSHAcJcXNoiw8NRKYAhKFQSipDUJQMsHvxR6TNVrDzxP?=
 =?iso-8859-1?Q?kAZjiSpNoie/Z79ykXIHR+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1mbAehkoZ/Tc1BwRKkaw8Z30r6FX2sNJvn8cpwWjcgxJ8FTrOqYjW9us49?=
 =?iso-8859-1?Q?TzNQPp87J8YR7omn//aPzv8pi7WKwBfIeCYOLbvMQXiSxnyHbjJ8FvYdoN?=
 =?iso-8859-1?Q?JQ67bM8ycmvaHrXb7RLtQQu6IKU0P7U0MO3d5+AZriHd+L9yX0IGyzIpmv?=
 =?iso-8859-1?Q?gjs8UDiwmlcoWTocGqrBIb6+WlzYqvueuC/M5g3zWcIAg77IeDrIfOgLCZ?=
 =?iso-8859-1?Q?Tn/azmtEq2pVprQ/2KKub21gerpyxKRgLCseMtNPQStPIwl7N1UdWMMFW8?=
 =?iso-8859-1?Q?xhTCZhN39qAcQBZ3qnZLThZvIsR3/P1GdXWG3606rLUBbRlwhMoLVtfnqj?=
 =?iso-8859-1?Q?3mljKfUZVU1wsSUwID7z1pOsOkNcYy2IGPSs6XJQknBCeoZam/R0o+V0rK?=
 =?iso-8859-1?Q?YuwiyF2OHsAubtuwq6fYQv/jUp1axLG5USjHd4PEbGXv9qo7BrvqcGtlLr?=
 =?iso-8859-1?Q?tkw1lPQyJ9JSCYWOLVvmYhGbaZCI18v2oqF4F5sy8eTJ+qE9GOgIlOyEST?=
 =?iso-8859-1?Q?Cs53AUB4v0wFQ7Dp1cLN/kJvfSfo0Xirroij4pbQFhZl6SwYZ/TLKC205t?=
 =?iso-8859-1?Q?a0xDByB2hlEmjt/eR9Q66+JFTBRhU2GXfKEaD0rWDUQm3aWmo5Pzgjd2Mi?=
 =?iso-8859-1?Q?ZyHZ5cLK8L/QML93QjIudrmtAgwBIkxL13fM2H5KtoNLEMAR7gQ9zAyO2O?=
 =?iso-8859-1?Q?hxgqhiPUfCMPKo2RypVYpkfVBaQfKh/AbAiyXk/4Tmm/hZbUF+cVOdCvrf?=
 =?iso-8859-1?Q?zCZwszk6Vk1okKCLOZSnnjNG4Asgw6UhWBy/X04K8TDcU7KBmLQpywL5S5?=
 =?iso-8859-1?Q?EIsmLpyOSqvaeMo1wPa/KOUrKjujr/lc5v2/RvCjWPZB/bsde2pMHY1pVz?=
 =?iso-8859-1?Q?W44+cu5aCGWF8YaN11wCfbKkmML3RO2nzoZoexDRtcFgViJJcp1w/kMmO1?=
 =?iso-8859-1?Q?gwPQJ6EeEXNIe0DPyq8Vo1C8f2oYmgfj4fGWGR1UQmZkULgCYTlMJEIP27?=
 =?iso-8859-1?Q?6VFrmIjHojLetQDDrDQp3LP2ItiI2SnmRESXJP/dZSsfE+D45KpKzl7Evx?=
 =?iso-8859-1?Q?Z6Wf+2CEC6xRKh1nupV/wB6TAzG3HfJtZye58pT96Yu/LcsSqC0yuJm4WK?=
 =?iso-8859-1?Q?Qn6MTshI2YHGITmqmYOSVltWVAfvRebe1vQyjVckDthcCKm+5mPiM9F2Xh?=
 =?iso-8859-1?Q?Hbxj4F40ewqnyKiW2o9DatgcoDcsLsSIlidwVNEFsd4YsLdqoEpwp2vW1Z?=
 =?iso-8859-1?Q?zlpLNL5PJd+CQr9t1YuPDQ+X1WtEaxZHJ+lD8UVkyQ/ooZmyaZ20PLYCMM?=
 =?iso-8859-1?Q?CxOgztONf5DWEra5OnVHF2U9CEwvBznmmQzmp024utO2vpty8qUeFOrtHY?=
 =?iso-8859-1?Q?kmGpo1O3VIuPIw215dlc0uCcMlcArvyK7tDr8OlCObNXkIUnIr3lsfcmNf?=
 =?iso-8859-1?Q?Nn7eT/4RCE8K3wm+rYFYDRTz+cdjNGZ4ZZ4HZUaOx4nu1xwnKll515TK3Q?=
 =?iso-8859-1?Q?+HU2LO50vfuvPhYiwadclq2wZpUEszj7z1QZgv7mE3OfKghNLLhjP66ZsT?=
 =?iso-8859-1?Q?1q9tfvoTvOQGvhsvnMkGQXeD5rd+ggzoaqZMvOuHMlrE/74xRbCahHwmGK?=
 =?iso-8859-1?Q?7fKhqhtOeErSe/FPHIcDINlivAq2SQ1A1WfMXNeqpg+E5LbpdgxdMy8A?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9107a5cb-cb92-4e8f-3e9b-08dd2a50c667
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 10:40:57.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7EB3/2YBb/Q3So0cHMQzlo4TCYSBDxZDr6VR6m0QNpNxvYtEsBCEdpy+fOL7/9lUFMnZNjdVoozzlT32STuYpadsd6NCKi7iNZui3KEk+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1035

Hi Sebastian,=0A=
=0A=
The patch has not yet appeared in linux-next tree. Do I have to provide som=
ething further?=0A=
=0A=
Thanks for guidance=0A=
=0A=
Best regards,=0A=
Bhavin=

