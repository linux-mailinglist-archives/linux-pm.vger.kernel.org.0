Return-Path: <linux-pm+bounces-14553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0897E752
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A42281701
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F118859A;
	Mon, 23 Sep 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Z72++AFX"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518A18787C;
	Mon, 23 Sep 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079268; cv=fail; b=SCtklSoAt1ib0jnMJbtBiAGewN2BCe8fEMz55rSGhULD+B0ktU9x7NhB2qyrEQFf4vyac3e1IvrFOwHU1a8Fus/iqlxJm12ph2Moi7/zIloraXpNWTmyfcBTKZ+YsYtkswJcbzzcf62Wt0E4zCDsVUFG/qZgOPsf/1yNSHA8uHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079268; c=relaxed/simple;
	bh=/t408rVhXxjtJVl14U3h9j6MMTGf+jloVK9QyGKXSI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbGmFkey7Mt82pYTIHVfr9Xjgdtc+d6nSkUKlWJi8FehZ6uD4HFXw3Xhb4HpHNPg4On0G1Vu9aydkqVO1m3bq4rNn05y6KO6kFQvhpIAnp0lUlfp0Hg7RkWvoGNTCuDehk4sT8D3U8SXfgACJyrTE2nIH/aXkW3TSMFaPxyu0Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Z72++AFX; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjESoOlqFQxYzPc4kvz6fr0OfpJiAoxTyLpCJQp1OkAZCWlV5JxASK4aRxBcL8LKlnwxuPg+jy9er/oWOLCmo/lYHItnKwbpbaioMnkGi0FoQ0XyWjDsEuMg9t9lsazrFnXVuUt4SfDenouVYgF0m668VpnVVTGsbEe8R8wXKDnhfLZAg9DkkrYIxzCKB7XWLqD7FZb3vtzlVpc8kiWYgNSuQKiQqMvyGTOgJ7j4d/E0o2xrseuqFYYwMY5vbGyyTsoLCma3CLbD6+jsXVH9GDD4o78LOAa7xVd/glaGgmNDLbUEmbJLMpV4VBTl/m1Vv7j8q5nWjxfaE62DL0tjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kORLTrD+klBsx6cMAay4UK+tcglaLRioYHTZFDThPsM=;
 b=amAvUBnO2HqdvEGuwOGhe4yhAI9LlOKq7wp/XtjpqEa4WQaxK7Gi3ZYbfiA6h6OU+zqjDG0x/Ba4jGXpXLTy3CtMjUPNRZiefLiFR2/gquOdLPRFqUpUGKPjFqFW2ACuUzdygJ3SwjzA6uw9jcqXVTJ8sCGzJSSp3qYvzMqSfI/Dc63dLW5K12quJRhgMjVRYMEWF34PaG0PPyM8s6K6i6MuEk/0b/daV2nCyn42I9z0buVsEvt9Nwbx4dospikbrrkvDqYhol5M4D9eFGEJJWkj1bWLDq0LZsG+lMVl+sEdlZcGa3DTObznnZFgJggFL7bRt323uns6NCIntfTrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kORLTrD+klBsx6cMAay4UK+tcglaLRioYHTZFDThPsM=;
 b=Z72++AFXCTio+BZphJq0ooiysG+smTVo9ui9KBiX2APoWzz5SGgogk/AHdSSvUbEzB4gIx/Dpzjlshp+AdaDgzU3iCMkOwlHMubrzBeN//i+4/h6g72MfIIS+T7217p00EHUxErwztkoNqrSsIFVbVp9ETUQsGyp5tM2sct9xnA=
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19) by DU0PR02MB9941.eurprd02.prod.outlook.com
 (2603:10a6:10:44a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:14:16 +0000
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d]) by VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:14:13 +0000
From: Jerry Lv <Jerry.Lv@axis.com>
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Kernel <Kernel@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV when
 busy
Thread-Topic: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV
 when busy
Thread-Index: AQHbBbmt73uivc7As0OFguJznR12bLJWO/SAgABUg0yAAGMzgIAOHT95
Date: Mon, 23 Sep 2024 08:14:13 +0000
Message-ID:
 <VI1PR02MB1007675ED9E1F1DBC6A915680F46F2@VI1PR02MB10076.eurprd02.prod.outlook.com>
References: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
 <20240913212715.gmchsmmaqrhksmhx@pali>
 <VI1PR02MB1007663D83495B0594DE794C7F4662@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <20240914082447.mrxtfgazkpaeqetu@pali>
In-Reply-To: <20240914082447.mrxtfgazkpaeqetu@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB10076:EE_|DU0PR02MB9941:EE_
x-ms-office365-filtering-correlation-id: bb3c5194-472a-4f63-4f82-08dcdba7b59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Hpm951OaC+Fd033+aS67tpCmVL+cI4jyWyw7T1abaa7RW5sswv3M737B0V?=
 =?iso-8859-1?Q?zGg+3TkXBkdGYO/pyrvR2Sut+QdZnr0Z0TTSGZP2sTkKK9AhFKcEAk/jN2?=
 =?iso-8859-1?Q?lzlf6i81uvBvG7/bq7jDPa1huIzi6FrlZxTZN/KvFsNRGJYHoDFXXep8E6?=
 =?iso-8859-1?Q?NfKrByS6IebzpksPV8+vbiJccOsKQADpBeqQL22JPNBLswk62iwn44xtdf?=
 =?iso-8859-1?Q?9K/8EuNS6bMLDzM9ZmPTU7Z9DHwTKldqJhzYA2kJUxczzAAn27SdxsDMUm?=
 =?iso-8859-1?Q?bIxx4qQ80FE6vhJsRnE1NfwYRO9X291de+JOeO8xcfTI50pwjgN5HweG+s?=
 =?iso-8859-1?Q?xS70VvmAuxQceDbIMY7WvuOSbkui3UnGQehu/X1lwAKm+7zu8eimf/8mNM?=
 =?iso-8859-1?Q?JiEMW85+r5SUNKqRZpIV5DybdTjdRzgsR5qA15RCMqiY9FC5fIloT7Iuxj?=
 =?iso-8859-1?Q?Mi40lkgMaVrzH4R/p69F7ZmUanGJ85oSK0HZcL4LIGwTIV+MDA44I7z+WP?=
 =?iso-8859-1?Q?mOA92PcsoBu12O1sqtX/MxH0nx4V3r5zuqbYdkLPc5KIiNz7DdI+6Zfuk1?=
 =?iso-8859-1?Q?2QBJRoXiuH2sADW8WtMLXelJ81k6PzFkiVtJ6w6F+XYC2s7lZ/kqYPdQ4p?=
 =?iso-8859-1?Q?z5Wkj6egJzW7LUNSBPDS2gRBOEbdk3XI5gKgyEjF75N4XzDUDERupl1X9f?=
 =?iso-8859-1?Q?nx+LPSSfKc08iR1ywh/p+crCi4sH0TUSWy7/SOHkUskCK5kILAo5nmB9wM?=
 =?iso-8859-1?Q?MNzOuB3uPINbFZ8/Zh1u4UvOGJxliuLcTr6PThd231j7RLz1ATct87W7Q6?=
 =?iso-8859-1?Q?jgTbGsj5Y9tVDufZhHe/5nrKixHaECSzDKwAwlb53OYhZLQsw76LnZbKu5?=
 =?iso-8859-1?Q?DRKoMfQv2RCG0ldKnNNL4Qp8us0pwKS09Zsm/Zoe7Hr/kXMRcyGhYbkr62?=
 =?iso-8859-1?Q?SG0mMVOVcasANk3t1+4jS88Jk/RlpVagFYpNIwkRZatY2CwNHH7tpghWEs?=
 =?iso-8859-1?Q?2NxE4Q0KDCaZZpaeArHmmlm/7P0ASMbW7PEVnqkZ9aDyQsCqQTkHReYMJG?=
 =?iso-8859-1?Q?uDD0jf738bz4/Urq1WNgYD7UpiyvB/nmnVmANu0Jf1gdnaV67v+MfuKinw?=
 =?iso-8859-1?Q?8nKoy1S8JQF/WEF61sJMhB2wYKF9zB9mzGAGnewdRbR4soNsSxees7XuR6?=
 =?iso-8859-1?Q?5QCml8FCv/wtsnPp0a+TYM85EUo+GMU6AsneJqKuQfXoVCoyqNRibers9z?=
 =?iso-8859-1?Q?67ZgUluWc4K/ctCq3+msZd4Am/SbzntZ+IqmCYH6gLpgt4OKEE7Ub42wFp?=
 =?iso-8859-1?Q?2fHFeyomaprJkwu/zq83xqpaneNgAhe9oOvXQbaH5XJyNjLwth95MpOAWR?=
 =?iso-8859-1?Q?uiEGokN0qT/ntvybWLikD1yEqbXkr8tA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10076.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uPAHMLzd3RQb0DUcH5gdTLmoQ3BVhHOP1I0Szy4eJ4ONLkFkWdgHWOzk8r?=
 =?iso-8859-1?Q?zDeetDYV1BM+jxepjCHFEzpvlwl/H0hUtkhJEfPu9LIY+s3dxaBy8IzXxl?=
 =?iso-8859-1?Q?YMA2/xK+TkUsT9rGFJixyskaCnZS7CiO9UyKGEKnB61cQcLEQ1RtIXmfvv?=
 =?iso-8859-1?Q?xGiSW3YVbx89azXn7rq5vd6LUtZQybZ6rMNOJCWVM/McVcjtar0XbU0mMi?=
 =?iso-8859-1?Q?HwIhbXmC4lNEZdMPFFboFJOtm48yfRjFtJ9po3F6VePT0gledLINdFwh2y?=
 =?iso-8859-1?Q?sSt7Rx2/ZlpFuXMWzpAnR77sngcTS0QVGXlPLv7dIDh67prDt1E9O6ZfFn?=
 =?iso-8859-1?Q?7spzgw0iKYXekAxuINF8fYUxSy39xFTJfu9834T54wJWsUSZWkpL28IERY?=
 =?iso-8859-1?Q?Cwf5MKlCLxhwtCCp0NTMbYe8QJCgs2Af7tfUsfZPApKP9iZbFPYBI+uono?=
 =?iso-8859-1?Q?J6g4zKgws3ueMWmDTqdAyCuWAak8gEv9P8ftbhxVUSf0+IXYGS6zJpZHr6?=
 =?iso-8859-1?Q?hd0iBP9Hf+3h+3FOD4Iaum7OE20WyQbQu0mJFqkdWK8y1dzhm23Ou0qIOA?=
 =?iso-8859-1?Q?5oDSYhDei/oT64QMHSlW04z2f1dwCINau9+OwkrpgOn08WgGcsRc9H2/gJ?=
 =?iso-8859-1?Q?wPlZvaes/mAudkpS1HROQfUi0i8IgtkWj6uzzsRZSM9Kw5vnx9dUiREBDn?=
 =?iso-8859-1?Q?VSZvSJuzxUqwFIVdyrnKVqEidpICva2rjc5x4lwoTSTT+N7dvUTecdOrtm?=
 =?iso-8859-1?Q?kQtG9/bOoWW0BLK8wN7m2sswrkuPY99iXyvy0uYqLPFObB4nh1GLIJg5Zw?=
 =?iso-8859-1?Q?fVlZvOI2adaOyztqcaPSSmpj/ZkpbTRRcBgqXvXsCRXH2XGCwhCCDrevfC?=
 =?iso-8859-1?Q?DP97Kh/buD866ToNhKId40w4o0V3XzHE3uU/NV4WkUwhlUzumJ+/OhgvRa?=
 =?iso-8859-1?Q?VgjdSEsjfRMg8smQCk8KgNalyPUWzsIUfB/zmXytPpCn2/dnmA7KdlUFXP?=
 =?iso-8859-1?Q?WXi7IX64ZIISal4rCpQsdtfTpkSAiQvwBQaJxd5y6vjtC3IZaZxbaVPkEE?=
 =?iso-8859-1?Q?vCRLnDWeRxnh7g1cDn3roVQKbg/FvRyq1w92isuI2Wt7yDXvw2gP6OZYdk?=
 =?iso-8859-1?Q?BYvQjcZSsZDXS3kUkALjI4Ocyy0EyyhQXkId8L02ilKtNmEaUAQyiEYeI3?=
 =?iso-8859-1?Q?EZCZcy/po8W9JNtQzU+XPSGfn2iukp4Er/i0lOgGTYeZFaNRsuiNF5nNtX?=
 =?iso-8859-1?Q?TPQnXuWMCmSfzLQeVX+TZnCffn8HoW1cJkr/a2Ce3Z6bKthHXYMQisq6Q7?=
 =?iso-8859-1?Q?vuJ9eQemOf3n4GWx9La7HgvXUFoJRkN0xN3B6Hb0AbX4brs0xqdrMRyhac?=
 =?iso-8859-1?Q?60jPn5Wk3d3HWpv13Gvt9iLOWxZPAY+aHUAr5q/HklwlwmyRVLQIKbXKG7?=
 =?iso-8859-1?Q?nWZJsgMOCcJEwi8XC4V308SwqzKXvZdIR8SY5bneUpWWwjdX1OWOfCjk3V?=
 =?iso-8859-1?Q?GPJ26/aXXNSwrHORD8PIHtlgfi7Ygts3fL1uUggVKoHgDgd5QaBXVBcy1+?=
 =?iso-8859-1?Q?M6uKa3rK350xX2GAwS5dGCrFZnnUs2X+u+mnAwqER+M7pfbaq9aFiTeZLN?=
 =?iso-8859-1?Q?K/jXI6M9VzDxQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c5194-472a-4f63-4f82-08dcdba7b59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 08:14:13.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIUq/TBaVpX97w9cFaTHXCq04GR5owVsypwK+UDuiXLG5lKjmCiYrhi0sF/hsEsbNgLotBKPB/FWsdoTQi+Asg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9941

Hi Pali,=0A=
=0A=
Thanks for your excellent suggestion, I will change the code accordingly.=
=0A=
=0A=
About the question: =0A=
Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY indicated o=
r transferred over wire?=0A=
--- Yes, we connect the gauge BQ27Z561 to I2C. When it's busy, the feedback=
 we got from the logic analyser is "NAK".=0A=
=0A=
=0A=
Best Regards,=0A=
Jerry Lv=0A=
=0A=
________________________________________=0A=
From: Pali Roh=E1r <pali@kernel.org>=0A=
Sent: Saturday, September 14, 2024 4:24 PM=0A=
To: Jerry Lv=0A=
Cc: Sebastian Reichel; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Kernel=0A=
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV w=
hen busy=0A=
=0A=
Hello Jerry,=0A=
=0A=
I think that this issue should be handled in different way.=0A=
=0A=
First thing is to propagate error and not change it to -ENODEV. This is=0A=
really confusing and makes debugging harder.=0A=
=0A=
Second thing, if bq27xxx_read() returns -EBUSY, sleep few milliseconds=0A=
and call bq27xxx_read() again.=0A=
=0A=
This should cover the issue which you are observing and also fixing the=0A=
problem which you introduced in your change (interpreting error code as=0A=
bogus cache data).=0A=
=0A=
Anyway, which bus is BQ27Z561-R2 using (i2c?)? And how is EBUSY=0A=
indicated or transferred over wire?=0A=
=0A=
Pali=0A=
=0A=
On Saturday 14 September 2024 02:57:39 Jerry Lv wrote:=0A=
> Hi Pali,=0A=
>=0A=
> (Sorry for inconvineient! previous email was rejected by some email list =
for some HTML part, so I edit it and send it again.)=0A=
>=0A=
> Yes, bq27xxx_read() will return -EBUSY, and bq27xxx_read() will be called=
 in many functions.=0A=
>=0A=
> In our product, some different applications may access the gauge BQ27Z561=
-R2, and we see many times the returned error code is -ENODEV.=0A=
> After debugging it by oscillograph and adding some debug info, we found t=
he device is busy sometimes, and it will recover very soon(a few millisecon=
ds).=0A=
> So, we want to exclude the busy case before return -ENODEV.=0A=
>=0A=
> Best Regards,=0A=
> Jerry=0A=
>=0A=
> On Friday 13 September 2024 16:45:37 Jerry Lv wrote:=0A=
> > Multiple applications may access the device gauge at the same time, so =
the=0A=
> > gauge may be busy and EBUSY will be returned. The driver will set a fla=
g to=0A=
> > record the EBUSY state, and this flag will be kept until the next perio=
dic=0A=
> > update. When this flag is set, bq27xxx_battery_get_property() will just=
=0A=
> > return ENODEV until the flag is updated.=0A=
>=0A=
> I did not find any evidence of EBUSY. Which function and to which caller=
=0A=
> it returns? Do you mean that bq27xxx_read() returns -EBUSY?=0A=
>=0A=
> > Even if the gauge was busy during the last accessing attempt, returning=
=0A=
> > ENODEV is not ideal, and can cause confusion in the applications layer.=
=0A=
>=0A=
> It would be better to either propagate correct error or return old value=
=0A=
> from cache...=0A=
>=0A=
> > Instead, retry accessing the gauge to update the properties is as expec=
ted.=0A=
> > The gauge typically recovers from busy state within a few milliseconds,=
 and=0A=
> > the cached flag will not cause issues while updating the properties.=0A=
> >=0A=
> > Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>=0A=
> > ---=0A=
> >  drivers/power/supply/bq27xxx_battery.c | 2 +-=0A=
> >  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> >=0A=
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c=0A=
> > index 750fda543308..eefbb5029a3b 100644=0A=
> > --- a/drivers/power/supply/bq27xxx_battery.c=0A=
> > +++ b/drivers/power/supply/bq27xxx_battery.c=0A=
> > @@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,=0A=
> >                bq27xxx_battery_update_unlocked(di);=0A=
> >        mutex_unlock(&di->lock);=0A=
> >=0A=
> > -     if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)=0A=
> > +     if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 && =
di->cache.flags !=3D -EBUSY)=0A=
> >                return -ENODEV;=0A=
>=0A=
> ... but ignoring error and re-using the error return value as flags in=0A=
> code later in this function is bad idea.=0A=
>=0A=
> >=0A=
> >        switch (psp) {=0A=
> >=0A=
> > ---=0A=
> > base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63=0A=
> > change-id: 20240913-foo-fix2-a0d79db86a0b=0A=
> >=0A=
> > Best regards,=0A=
> > --=0A=
> > Jerry Lv <Jerry.Lv@axis.com>=0A=
> >=0A=
>=0A=

