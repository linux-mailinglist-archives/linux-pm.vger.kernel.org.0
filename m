Return-Path: <linux-pm+bounces-14599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAF983B99
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 05:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50D71F2414E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 03:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E221B85D1;
	Tue, 24 Sep 2024 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aJadk1Zh"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28489EAD7;
	Tue, 24 Sep 2024 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148857; cv=fail; b=hmphSpgxbEVibtRANoKUYnrKw+Pnz4PA6BArx9KdFBGo4ANo5PpApyFNvc/9Bw0VOWvZFlyFJgJammEWSgB0/avFYbc74l+54Y694tBX92nRZagM0K+Xs/G1179Jazs7XA9K1mO2TnVoJthl6tG7UYCiwjnUwn0sFjWt6u+9fmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148857; c=relaxed/simple;
	bh=Aj5zW3ZBUeIbSi1yITAdxOC90mqgM/rsO7scwVe9CmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAZe0wYBrJMH7qrkkkhBM+GQdr0Mwjmyw4OdMkgYbalZ0jf1uqCj/VOP5sdyPO6vc3biNBc91manYLkdFHOZ7HksTrTsi4v36gvCUz8YZ9bgnC9/bxrWVURlDlttRe4jdl3AzGSMUqZhrx8qXIIapfNaYYDgao3HUEQXtiBl4PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aJadk1Zh; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixU/QE2zs06NjK/s2Fuf/4/ua5wkfUHS4BAFWs0ow9ym27pXf3Dcrgz+fZqmRIlTsgdYdt3KOfk2rdVcGnIFpvynAI+ZOxia/Resb2m6dd7QAjVwO6jywJfvMckBmrnQpOdjNgW+Yc6reYS4eSRrI6SXhonUczSHT2Jrlhj0X1OMrOw8EzzgXyI7pRiOZAeAYUToHnHCkITg21BhwVVibP/cUziNL792m9742sxX8mOWzbiSasgHMzo2AIXQT2QyVHgnDW2goJru4bbYyUZNz3VqQgQCZwyYH/kxxig54+Movh1trgbbl9OkKX7prflC1fhyEBDoBHChMPXJxRkCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQyaPfV/Yl7TbEi0Mm6M4TBk2trQsx0gq+7+BIeN0Ls=;
 b=TAzqKpJC3ddRjZ4MSTJ7bloq98IP/7XuX8jioAviTb5URd8nJdjAqUW2swNstTtsalTQPaWsDh444rP+nMnK4uCeOnM5Ne/HKQlb6u//c+9bVrV6QXSlPF1iYZj3l90jr5AoauBhb5xgPonuF0A+UcglqLh36JtGceGjaXu3vk8IP8I+fsb6J+UCki3xnN/36LEgMTthKMnhm7m+TckA+OnIreiwf5ZcDOsZul6KI1voE2Cxc0gPmZSRaJG1c2tiQcj/e2ZF1PSyYuAmk6EbezfE3wkRyB5nrzZtqToWEE8bPJm60i3LEd3sgtroPDRo+aYPyF6q2OXTHuFjxGjc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQyaPfV/Yl7TbEi0Mm6M4TBk2trQsx0gq+7+BIeN0Ls=;
 b=aJadk1ZhUiIjXTFQV/33nlvRnkcvxn1jzKmOP+FtiklDzVrwQDyTPmJtJ/7DZ6DaIe50JPPgi83I02DzwJB597KnOJAxIX+7twZaFib+Fayjo1m9Tk7cwojXRxwJ5gdM5y45u5F+047BRPjkJTcRXsjGQaNMZ4ZJ0LErgSWmni4=
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19) by AS8PR02MB6598.eurprd02.prod.outlook.com
 (2603:10a6:20b:257::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 03:34:11 +0000
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d]) by VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 03:34:11 +0000
From: Jerry Lv <Jerry.Lv@axis.com>
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Kernel <Kernel@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV when
 busy
Thread-Topic: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV
 when busy
Thread-Index:
 AQHbBbmt73uivc7As0OFguJznR12bLJWO/SAgABUg0yAAGMzgIAOHT95gACtEYCAAJEIoA==
Date: Tue, 24 Sep 2024 03:34:11 +0000
Message-ID:
 <VI1PR02MB10076AC00A9D65BEBBC1A0DC8F4682@VI1PR02MB10076.eurprd02.prod.outlook.com>
References: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
 <20240913212715.gmchsmmaqrhksmhx@pali>
 <VI1PR02MB1007663D83495B0594DE794C7F4662@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <20240914082447.mrxtfgazkpaeqetu@pali>
 <VI1PR02MB1007675ED9E1F1DBC6A915680F46F2@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <20240923181631.3plimohmg4vnjwtb@pali>
In-Reply-To: <20240923181631.3plimohmg4vnjwtb@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB10076:EE_|AS8PR02MB6598:EE_
x-ms-office365-filtering-correlation-id: ada1fdcd-cad2-4038-78a6-08dcdc49c163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5oyTARut75/kFIO08RxW+7gacL9fLHFUw/LA83idBe8mtpLD7okrkChFSq?=
 =?iso-8859-1?Q?TIp8YLN7RI0iyKoW/PoMPMh4zjj/8MGc/FAmaihBBCcpRGd4f3fH30sS/W?=
 =?iso-8859-1?Q?I8z953tUy3fYnAchyGqNsrY+qOxcJKi5SmNuN2/eb1o9uo43186E2jmb6y?=
 =?iso-8859-1?Q?CrSFynkqR1Seij5pR2pLTwsVo6wo1iJfEFvgg9srqSlC6pcyiZ2EC9QehN?=
 =?iso-8859-1?Q?fuuFIkVnqDvq2jajEELizg64Q3n/a5qb9d76C8zevyrymRx7xZMdLm6gkv?=
 =?iso-8859-1?Q?Ssbm9NFN9FaLVudb69wMu6llwqNr1jv2/mSEpeNwx4YrV+Hrw3PcRk0Kq7?=
 =?iso-8859-1?Q?EcS5+2U4XrdUcYjFPvzAix8szvdd7Xuzn05zS5/s8dsYDiYhEBdEz2sXKH?=
 =?iso-8859-1?Q?ZP9WlncfDGLlVYzZyTMnFf3t92pyMnbw6XlLuW3wc2hInC36xmnkL6BNoq?=
 =?iso-8859-1?Q?v+FbyFaMc22FIfZZjuvypsfEwbTlMKPaC6cGeRjfcYQ2N3v9iU39RkErH4?=
 =?iso-8859-1?Q?xPrOkle2hG8ni0/YdCfsSKD9EbTMoFM26h/5WFwPjLnwLfIhOFDPIbxWo9?=
 =?iso-8859-1?Q?gOgH0SuVbBxEv0qFj8sOWWMprx6n60WBNifBsA59ddfGhe7LRzDjvx6ttt?=
 =?iso-8859-1?Q?dP3y/DWy9RdqqpsDWwf04QrBTqqPfmg+ODxs/zdZIxflkYPJVb9l/sQesH?=
 =?iso-8859-1?Q?gx/IWc3/95Kgk/ADVN1n5+Pn/bhw5N8ZXOgotFRK5x3iUI02gbi+yI82Kw?=
 =?iso-8859-1?Q?QN2CZJRH9Me65+bHqj1Ul6+HA0bQ0t243c5Uef8mMkRP9uEzNJAJJLg5ru?=
 =?iso-8859-1?Q?5QAPnVTsxCVvtuNeSM+yWoMavkYMR1TYF71L/l1L7gvbMCO3Yysof8xd70?=
 =?iso-8859-1?Q?/htgffYkWEGOtemeW1rwdXVCatZOfBlmb4sYOZFXs+InJ7QNTM5W55eczx?=
 =?iso-8859-1?Q?d9SMhe/an+YeFaWzauHKkVfD8b/5cN94lX6IkJ7sN6gR9njQQ3qSCnBkjx?=
 =?iso-8859-1?Q?Majg9HSWd8NEvI/5f8vIWa8irEoX8Awd8o4jWL39q5cGhv1O+elBiWpuHm?=
 =?iso-8859-1?Q?AbwD5qNi3tdkh1aef018U9MTdk6NCFnFApa0IJKUxvxt101FKwbEW5dyfP?=
 =?iso-8859-1?Q?QBRmNoFSQUnxkXT3gAlyI/wBjB5ZuncswvsP0nAN14Cf+EAjuNXlvTQeO1?=
 =?iso-8859-1?Q?mbwHq336AJp+/mopR2GvchE1cC4jPilBJhBG0ISSfP+F6rVq7nDlcNgvnw?=
 =?iso-8859-1?Q?dP4m70leUzRdy6y/ILAAkezKJHaiMmIXqxWmUsHVP+HIXMS1dHnnzPEn9Q?=
 =?iso-8859-1?Q?Ow0jWngRpSAkfELUEeCYYSCoaDpIY0auWb/DMdMTzcyDzvNGs8Laoyjp4D?=
 =?iso-8859-1?Q?0iuSj9Z+6uxAQdeusQD68Ql7PWO2i26g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10076.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?69PY6i9Rhb7jg8CTjhLGzBuZ9rMeIMLYH6FX+H+Dd7dNc95kiU1mXCSkaC?=
 =?iso-8859-1?Q?A/jgOPZ7cVS8eNCN4Ue5bQnFqhUURNaxho1Jvczvw83KD+2Yv4h/BCYybI?=
 =?iso-8859-1?Q?gMo6PhA9ackTFmSUMGpqwBvDIAzJWuTeO53ZobB09VRj8l3cD3JnqBKAXR?=
 =?iso-8859-1?Q?SpAIPPa7EB+CLZJYSuqHPR7hVXdRmFk7omLEMnvkQW6udzfuikOaY7KGxS?=
 =?iso-8859-1?Q?FcxYT+mHKITpqjec+n5pbIZx8Xl3/ckBjLKkcvvlo6JGxt4EoUJCxcrXHK?=
 =?iso-8859-1?Q?VDjqqG0loT9NoDR0NHTm+xOVJWuYKQgjrSq/uAn3+/cpWwr+aQZfhkiZw6?=
 =?iso-8859-1?Q?X47flWL7FFk6QL3K2ArIYuseGC8RxB3SkVjXKA6hHGMhrdpuEbJopSeWvr?=
 =?iso-8859-1?Q?S3LkbDYCePpNnWikKbMqrf3jCjbDb8H7RUjG+C7aFhMrMoL/CI2c3J6LMg?=
 =?iso-8859-1?Q?O1CcQTxNR5/13fSy8XjYd9fRCCeVc1xm0HqZV1FUW1rLHAsNoa3csb6mA+?=
 =?iso-8859-1?Q?2QaWN7BWHzJ5KHQDQh++MAJn5WH53uGxnf2rIjLgen9u5jGpDUfcv5/KsS?=
 =?iso-8859-1?Q?3DvZBWlGckl4y+GB2cp4NZNAmU6mKPkc36VByHAxhugt6qPCPvpkPfqQbP?=
 =?iso-8859-1?Q?p6fxp+EA/ziEQgVpWkxSW2i8HYzYLcVu3sIvPrN8L7by1sWtfnU6HB5DYm?=
 =?iso-8859-1?Q?RgIU0Y5T4E96Btehst8CpWraBR7lMlfQQg38pj+IatSVSx/VCY43KTFh1+?=
 =?iso-8859-1?Q?WsL8tWPvzMcwtUrNQvNLXzD6xRAs8V3r7Eys1ZwHKWArHFBkL4HqtQocdD?=
 =?iso-8859-1?Q?lWiW28Wud+iJJ1CWCbgcsvm7WzuWRTA2ymFuy2zPRPYn5ZqOcKdf16hoA1?=
 =?iso-8859-1?Q?s/IrhOD+vBRC/Q0GcuQ7oRo5fV2QNre26ZHtaYrZOE7gVUom81sBoPpm5Z?=
 =?iso-8859-1?Q?GCLNOXK6+WDQ+V0F7tsyYuoZMlqAwMlROui9oYyc7kJazUdoeCvHVW2TAb?=
 =?iso-8859-1?Q?Crtkl4SJmm5TizA5d63soI19KCev3+z9oVsdYYw9gkqsDK97X5lw9IFhqL?=
 =?iso-8859-1?Q?qyoilLHJgD4rb/jNELcj7fwUBFR+1mi6yNZHfHIavUqt8PE7k45aDv4sgG?=
 =?iso-8859-1?Q?7ZW/91n55pi3yw2VRgsZfRyOrsW3Qt2/IeuuZ9kStIXeVQQ6EyWA+7s65J?=
 =?iso-8859-1?Q?rgRm92uZ1ayoTm/uMSdv4mll71iXOC16Tc+rqTgCZlnN/2APKQ0vXZ1uye?=
 =?iso-8859-1?Q?AeXyPbogBNTHCNmTQO1raiuWHGW0UAsjmTxWNB6vCLyErl5Tul7OaMzise?=
 =?iso-8859-1?Q?WCJNTm7Yl7KgRwMpF9U5cZFGDZrnlxaWl/Yd0+y9t+EMMDI3ueg9QFYZ1U?=
 =?iso-8859-1?Q?e76uir5Ha2fnXMhBOllPkmZhIZicipo3JPdxrqeyYzlK5J9tb4re2j0dj/?=
 =?iso-8859-1?Q?DPGXCua6X27AtQCGtxqmdIfJngPAWrJkUv/xkYjNmsV3k1cLbrLjbn5bdG?=
 =?iso-8859-1?Q?B9x6Rw1hYgVlFjYUORwnavl5VS1Cb4K4ivfcw6Aoy15Yy945gzqS8pZpGe?=
 =?iso-8859-1?Q?kzV9Ncpt2L+tWONPVOMhhGFEJ0ekoI/GscPl1AdeOlZxUfO38RpbLLR/gZ?=
 =?iso-8859-1?Q?Q89fxta+O06Zk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB10076.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada1fdcd-cad2-4038-78a6-08dcdc49c163
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 03:34:11.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /b1bEwbcGxeYO8V6NE2ZUC8ngjTjbSZhIBTPrRgQj8JFhEFX36tYzhoZ+E2L7i8SetEDSPCwehItAyg10OOGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6598

Hi Pali,

Just as you mentioned, when the gauge is busy, the other devices
connected to the same I2C will not response too. We rarely see
this in the normal use case, but sometimes see it in our stress test.

Since the gauge usually recovers from busy status very quickly, and
too many retry may affect other devices too. So could we just retry
one time, do you think is it enough?

Best Regards
Jerry Lv

________________________________________
From: Pali Roh=E1r <pali@kernel.org>
Sent: Tuesday, September 24, 2024 2:16 AM
To: Jerry Lv
Cc: Sebastian Reichel; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Kernel
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV w=
hen busy

Thank you for detailed information about i2c NAK. In this case try to
consider if it would not be better to add retry logic in the
bq27xxx_battery_i2c_read() function.

If it is common that bq chipset itself returns i2c NAKs during normal
operations then this affects any i2c read operation done by
bq27xxx_battery_i2c_read() function.

So this issue is not related just to reading "flags", but to anything.
That is why I think that retry should be handled at lower layer.

On Monday 23 September 2024 08:14:13 Jerry Lv wrote:
> Hi Pali,
>
> Thanks for your excellent suggestion, I will change the code accordingly.
>
> About the question:
> Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY indicated=
 or transferred over wire?
> --- Yes, we connect the gauge BQ27Z561 to I2C. When it's busy, the feedba=
ck we got from the logic analyser is "NAK".
>
>
> Best Regards,
> Jerry Lv
>
> ________________________________________
> From: Pali Roh=E1r <pali@kernel.org>
> Sent: Saturday, September 14, 2024 4:24 PM
> To: Jerry Lv
> Cc: Sebastian Reichel; linux-pm@vger.kernel.org; linux-kernel@vger.kernel=
.org; Kernel
> Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV=
 when busy
>
> Hello Jerry,
>
> I think that this issue should be handled in different way.
>
> First thing is to propagate error and not change it to -ENODEV. This is
> really confusing and makes debugging harder.
>
> Second thing, if bq27xxx_read() returns -EBUSY, sleep few milliseconds
> and call bq27xxx_read() again.
>
> This should cover the issue which you are observing and also fixing the
> problem which you introduced in your change (interpreting error code as
> bogus cache data).
>
> Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY
> indicated or transferred over wire?
>
> Pali
>
> On Saturday 14 September 2024 02:57:39 Jerry Lv wrote:
> > Hi Pali,
> >
> > (Sorry for inconvineient! previous email was rejected by some email lis=
t for some HTML part, so I edit it and send it again.)
> >
> > Yes, bq27xxx_read() will return -EBUSY, and bq27xxx_read() will be call=
ed in many functions.
> >
> > In our product, some different applications may access the gauge BQ27Z5=
61-R2, and we see many times the returned error code is -ENODEV.
> > After debugging it by oscillograph and adding some debug info, we found=
 the device is busy sometimes, and it will recover very soon(a few millisec=
onds).
> > So, we want to exclude the busy case before return -ENODEV.
> >
> > Best Regards,
> > Jerry
> >
> > On Friday 13 September 2024 16:45:37 Jerry Lv wrote:
> > > Multiple applications may access the device gauge at the same time, s=
o the
> > > gauge may be busy and EBUSY will be returned. The driver will set a f=
lag to
> > > record the EBUSY state, and this flag will be kept until the next per=
iodic
> > > update. When this flag is set, bq27xxx_battery_get_property() will ju=
st
> > > return ENODEV until the flag is updated.
> >
> > I did not find any evidence of EBUSY. Which function and to which calle=
r
> > it returns? Do you mean that bq27xxx_read() returns -EBUSY?
> >
> > > Even if the gauge was busy during the last accessing attempt, returni=
ng
> > > ENODEV is not ideal, and can cause confusion in the applications laye=
r.
> >
> > It would be better to either propagate correct error or return old valu=
e
> > from cache...
> >
> > > Instead, retry accessing the gauge to update the properties is as exp=
ected.
> > > The gauge typically recovers from busy state within a few millisecond=
s, and
> > > the cached flag will not cause issues while updating the properties.
> > >
> > > Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
> > > ---
> > >  drivers/power/supply/bq27xxx_battery.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/s=
upply/bq27xxx_battery.c
> > > index 750fda543308..eefbb5029a3b 100644
> > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > @@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> > >                bq27xxx_battery_update_unlocked(di);
> > >        mutex_unlock(&di->lock);
> > >
> > > -     if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> > > +     if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 &=
& di->cache.flags !=3D -EBUSY)
> > >                return -ENODEV;
> >
> > ... but ignoring error and re-using the error return value as flags in
> > code later in this function is bad idea.
> >
> > >
> > >        switch (psp) {
> > >
> > > ---
> > > base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> > > change-id: 20240913-foo-fix2-a0d79db86a0b
> > >
> > > Best regards,
> > > --
> > > Jerry Lv <Jerry.Lv@axis.com>
> > >
> >

