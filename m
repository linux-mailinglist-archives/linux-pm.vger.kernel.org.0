Return-Path: <linux-pm+bounces-27798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46DAC79EC
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBBD4E73BF
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A8218589;
	Thu, 29 May 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAKS1V8r"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0C21770B
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748504593; cv=fail; b=Sgc3yML0K9pJDklBbry3qNVG9KsREXd+iz4Zi9Q+klPOIjuq7msAXor9qOlVAvNXfayrJPwvEYTRJEViqfex4uB+mmeXZqS36Vh5jIXo3NUgThVyLl3JDrIoLq09dzAW67ljWWqD7klC3jA7s5lW0tZjhCgxMRXqy813MIBfuUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748504593; c=relaxed/simple;
	bh=sfZltoJlWbe78auzMuNdLKQQShBUaM+kSinmIyTVLuA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ok2cw0tDBXIhfY2O/hf1BBfDs4WVdZ3y8xnEwpRKRWZb4I3lmHhiU/jmaI986nqDfcoQ8TV0J6MhlTj88I16ucBubqXP9415UmgH1zYbSzvYVxJ4g7bSDDdvmlGWFCTis0RuRlbk3rE0ipHB/hfvMyAxvbNG0RSvY4LXEJhV52s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAKS1V8r; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGlb1833rYpzfJnjzh89HntY0dIgDGPK0lsXfPig6eZRbnU70iAEW/NPpi2sSduXtmyA1fSCaFqH0HlZzu4BcWUoTxIOMrHbZguZUTwRzdzyoXtO4tJMTtzbEKiFXGAVJC4TGB2ztmzjgHFRhQyyk7keOJ9HEZbgnwYnU+bk5+nLk9nlv0To3cFg3+YgAS2gMEQam2Wi/Gx02RyKsqEXzcXY68uaEfCWGNIHRQCD92Xn+x7Ia8nXK9CqAyd+LYVDU3X3bFzC3WiBz+MhhYK9FKF+c9RISSjyR4S+fa9TPglLx8bz27F0Wel3IQ6ugDXQVUSiJbEJiZNRj0er/y1qMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVMLhhsxODFpAVuTQwKrK7GWFUA33Uh6U6FzgTYnQKM=;
 b=PITgEdhNRRf6VXjEUFms3Xg/sBNWR8foglynU896Q0nOKkgQSkRXlRA9HcQo+4t2TQNkAtgsly6GNmCgtcPUNeFb+p0skgLLb3pR3FlHh+KHIqqlLD3rIDfsUHPmAzx6gm31mJ/q3h7RjmZy70ny1hjUzyQEGpVnyXGPjyFryBGMkt1Wi966dhP2VymacUjQngFMB8smwira8Brf5a1HBTTteO4rZzpz9/9vt2NRwr/hFBeZO3c2CEdqXxHDSRy1p1qMvQ1j9IjlaRng+noSWhz1dCYI7NEjDXKVYnfhTu+4Qdfq6oh0lfugFcg1LhuFcDoUNo0knBt+9l3jYZFSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVMLhhsxODFpAVuTQwKrK7GWFUA33Uh6U6FzgTYnQKM=;
 b=AAKS1V8rvODh63vc4Jpql9qPHElSo/L35PNrKjqeioD2nEhAHbWNBHJmiMFVn7vaepbd5RtYpTy1grWW/BllxT4F3ykRcLIF86zjeOFyoFLq+sngJokdDbziqg4xXryVlmha481MA2obf58bLtyaQRVUTEgQHrQzMifj5w/63LgIBYqPiMR4p6Op+eqBzbu7OUltk3O2QwOvt6BF7ppREeIX1Sij0vMNdfdsFSrx2dIw+NC0GeGcbZUqS41YTqKbrrEA8+bMHpClLPBtRJAq3hzkx0i6sH4AWaSkAMKySn5i4AQleE7OuaOIvZVgtliL3kAWSoppuOuvMb3AIK4VCw==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 07:43:07 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 07:43:07 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Aisheng Dong
	<aisheng.dong@nxp.com>
Subject: cpufreq can't scaling frequency after cpu cooling event
Thread-Topic: cpufreq can't scaling frequency after cpu cooling event
Thread-Index: AdvQa6t4EAQe8cPfTYqUIZcN255IZQ==
Date: Thu, 29 May 2025 07:43:07 +0000
Message-ID:
 <AS8PR04MB864266B4BF3B629C96464DC98766A@AS8PR04MB8642.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|PAXPR04MB8734:EE_
x-ms-office365-filtering-correlation-id: 09f5d180-30d1-445d-2b24-08dd9e8473f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iYDsl6U3QJGSfwVjXq2dZhAqn2mYbmb3aY3DcfKQfwHkzlWCbOT5c7Krvj?=
 =?iso-8859-1?Q?XkKxt7OJJoZbx9CYSt1Cc9akML2ukNd9R7QwE07O7ksq9H1rVpqn3OAJnT?=
 =?iso-8859-1?Q?Xpx/HqRypu6otk+24AQthRDG9ORBrkfaK9SlQ9j87ftLJnTDAbZS2jRZoj?=
 =?iso-8859-1?Q?P4sHt1M+bKK/efipZgmmlffwZTTZcYwdR4JEbv/7pcJQD96KnQsFLqrYEJ?=
 =?iso-8859-1?Q?IXAT4nagtx9suNo+WBOdCvGBj7GUloKVG3GefPtUiAvv9+NEpazL0bgrXk?=
 =?iso-8859-1?Q?iTVavbS/lD11sR2fM4rhey6QjmN6ZmoQK/BnuxNbSJJ1JY7vOgT4cZKhPr?=
 =?iso-8859-1?Q?P3FgowYcXhsEDxxVHcKeNewEgBMqvo1S0E+21qvFMlpwRFyXkff5BuIOud?=
 =?iso-8859-1?Q?TCFuSF5Urq54OecXIdOFly2oAjIVX/2TdQ6kujqg+/621PYU9CuTFEd88T?=
 =?iso-8859-1?Q?aFOnxV2qEE5VOV31tXQ63t/dI919vzqWUIoj7WQVDceoMiNoWc/vgUQ04/?=
 =?iso-8859-1?Q?OpMyN1Uk0tpfQ/vklqMUJb1OPhQS3xvnCNn7RH17ciGgis0eIu1SScx49g?=
 =?iso-8859-1?Q?mVb/VtV4rW/Ka2fhUIYxSl5Qys4OpvYVxqTIeebsOzFDHjn2m0BcvNxoie?=
 =?iso-8859-1?Q?zTMgISjO600ESQkjPeY2p4TMwomus/XK1n/jRFlsTdkX2zahRCZyvLHZy6?=
 =?iso-8859-1?Q?fnW1LD4+fPpWe++co9S4n0xRCRdtfsGvoS2AovNDbCRD7lh82aKrIrxopc?=
 =?iso-8859-1?Q?cPsiTs8C+O9WiyOm/HIUUpScj4cYmEItad7UsYqRL+s4iHtbmcpBHjJjzD?=
 =?iso-8859-1?Q?X7EU++63LSSkctfsXexDSCrnL2NEYPJU/kOEAlxvtfby1+725LZSDWM9a+?=
 =?iso-8859-1?Q?bTcghqQ8pV9yxfsY6quVf481y97MGs58qQkYCtfBETXZaz+lnRpr79vd4v?=
 =?iso-8859-1?Q?dpZuyMERW9o+xRdNE4+fFmdtxLOXP6A9YyepmNdfXZJw4T20VCnEbXRAur?=
 =?iso-8859-1?Q?dWFzcPQSbBK1fNqenJVpVjvCf847cdMPtcs80JxZ92tUfCIC4oPucr9fDo?=
 =?iso-8859-1?Q?2gcnu7YdIGEE1VV2wTALGLbmt+4D3eanQN/N/sPdceHo6T5BdPRUva+4J8?=
 =?iso-8859-1?Q?w31ISaj9v11WiFI8MC+55fU+QX0TrNQFAZvlLu4XcaygiOejAOGGd50N95?=
 =?iso-8859-1?Q?yrcWGRv1Iiu8NutJcszUKE1H7ONlqt5gABBM99Me0B8Ctt+IT4kottv4Ym?=
 =?iso-8859-1?Q?+4pcII7T5yyzYXzE3Il60IUVrDhNh3xl31mGvnc0+JQKXfGjfU9Jiq3jhA?=
 =?iso-8859-1?Q?UKSgrTnH76y8mZhnbGlc7ncGPv7UrpV8PpwzLBx6D+g+AjE1/l3L8/d/+o?=
 =?iso-8859-1?Q?NOaqluQyc3re74iAfhr1801C2GdKfLDR/0yuMg8UjI+JCI2S6pEZjsKynU?=
 =?iso-8859-1?Q?JNu5aJLmdKqA40vN8qS+CAIf6kMOuVEoXRQCcnAG7niEkFy1rT6vn9Pc0h?=
 =?iso-8859-1?Q?2pIJ7l5OilpcqsYPUJtWLaH0ukkHBV/QDLtUbEkfkbcr65gQHoZWaZmFJG?=
 =?iso-8859-1?Q?T5orjpc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xxkMa7I/0n1h/PD+9hypEFKu7mX0Fbd483vrLoOxLMa+EvzyABDpmKWFnu?=
 =?iso-8859-1?Q?ub+NA2KMj+esohDFtv2IgrF0kL2qlszj+Z4rHaUtVNuh7Isd/jrHY6u6N7?=
 =?iso-8859-1?Q?gvDTEmbPvPLWJKe0KEZADHXioKnD0Z4e9eDldEQd+c9NkbCOqr48VWIr4w?=
 =?iso-8859-1?Q?CEHZij0gZ3inY+1yckm5PzoWtw9aqAbM/Tw3zknWbxhIM88esncwuZuQJj?=
 =?iso-8859-1?Q?prBjhq5Qa1xlLc9LAiMqXa6e8giec9tocsxYhldJAB41NiOlDTcSXaMmBt?=
 =?iso-8859-1?Q?aWdAIih4FIVig4x3BEbgR6qtNeoEoDhTWjouu5wXgOz+Z6CAgg///b1+iU?=
 =?iso-8859-1?Q?qOvcXgS0f3l9BXAPLcy9GjGUdxfiQUfApA0Y/finci0Aro2wrggrT1D3Vy?=
 =?iso-8859-1?Q?Is2kkiqbUgT1s3WDs6Rol7xlGfCl8/J28eJNsK4mw3Ud9zcLj0yW3e1MFg?=
 =?iso-8859-1?Q?CuQB3PjX4orZtP6Cpk0Tc7e37g32vGpUQb8OT/IuaOALImrGFOiXK+TM9O?=
 =?iso-8859-1?Q?n3QC1r6QJmhA0QcqC6lzeKyo92j9M12ejLzDLXonwhKFStb91kjspDIxzE?=
 =?iso-8859-1?Q?yyXmi2e0o3RK3stHwJhnmVvXBdHGZXOT2l3+5GoLfl2oK5ne9QncwGbHs6?=
 =?iso-8859-1?Q?BpKqjk2L0m3U5Brtvou+5LTCuDUPvQ2b8huGBMk8ruN4+S+BU3PepbHDKW?=
 =?iso-8859-1?Q?5SuKuCNJBbw6d0oPAw4mmGcyE/ZJIwFI6S8DP8vEru87xq7b+oRzaA2/3n?=
 =?iso-8859-1?Q?aCPZP7/BhREfR0zBp5qfzORI8VRXR5X7tP0skRpsY2t4HYjIBqODWC8Hz4?=
 =?iso-8859-1?Q?P9Yy6QaiPb7tLvgiEuvcAsOO///htpsSP7+TCOyXjEn3H6K0E/AkmIAcHh?=
 =?iso-8859-1?Q?CrFdeBqu48x/wl/dlfY7aNRkUaxbJjTopdQ8vwrLkZuJ85+mpkGLewDU/9?=
 =?iso-8859-1?Q?94bet0z9zkLA9kyC8xUiLp4jhvXncBWzOFgrXekhod4PQua4lX1iU3zDEI?=
 =?iso-8859-1?Q?DsbCiZCSK1VcN2qVtakA0LH72Ax9d66GQFKuLPa5V9nFG1xRSu5KCMxkHV?=
 =?iso-8859-1?Q?oZ8PPGFhF4M14b3ZypaXhgvZcYe7p5GYx/Va3RYE681Yb1HO+rfFlbp7gh?=
 =?iso-8859-1?Q?k135BrcbaOXeDXnm2b6KPc3aFqajdsHdZEvITQytnj64D23QA+gMbERLmX?=
 =?iso-8859-1?Q?9b0wt10dY8TSot5iKHdZrRIcT/Vy7cZcyM6exqy1uPZKMMF5/e7LPaQ1Bn?=
 =?iso-8859-1?Q?hsBjkXq819LyU0iuv5cTQPcWGZppEDEtUSDv0AI/4BE+WaIvyY1ao6Rrt8?=
 =?iso-8859-1?Q?mg+LAV8VZUggG3r3sbLjfgngbNc5LY5HRxiYKKLSxd2XdnWAftBn3vjROe?=
 =?iso-8859-1?Q?kt93pHj5+vEBQ3H2CwscBxqNKwHsE3uyZHDDGGYVWJ6mnDb2LVuhi/cUpH?=
 =?iso-8859-1?Q?0ZlmzoLyITFfMzPhuHu6ohrCnnIO2FqsC7UtrZXmn3923DxNloRKmZ+Lsq?=
 =?iso-8859-1?Q?kpn0KwgSr70e+G2fyG+DMCeKcMnFBLoUjRQb0j86fhF8GTUb5Q6Be7zA+Q?=
 =?iso-8859-1?Q?xZaRm67TVodqkGvdamQYCnmp+J0NOBqCyB+BBDSUuWUhbSbKXwTC/Y8ONi?=
 =?iso-8859-1?Q?JpCRyG/r5vuQE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f5d180-30d1-445d-2b24-08dd9e8473f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 07:43:07.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjpljLQ2Hja884rvb1NNMcp3lmEerorA2OXgM6fGAwX+q412WlqOWVMwTb9NOBnSd8rZjJb1wDaM8rIij7qaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

Hi Rafael,

In the latest kernel, I saw below patch was added in cpufreq subsystem.

commit 4f751f25ab892810968ced5c10fa193dd16c4c6d
Author: Rafael J. Wysocki mailto:rafael.j.wysocki@intel.com
Date:=A0=A0 Wed Apr 16 16:12:37 2025 +0200

=A0=A0=A0 cpufreq: Avoid using inconsistent policy->min and policy->max
=A0=A0=A0=20
=A0=A0=A0=A0Since cpufreq_driver_resolve_freq() can run in parallel with
=A0=A0=A0 cpufreq_set_policy() and there is no synchronization between them=
,
=A0=A0=A0 the former may access policy->min and policy->max while the latte=
r
=A0=A0=A0 is updating them and it may see intermediate values of them due
=A0=A0=A0 to the way the update is carried out.=A0 Also the compiler is fre=
e
=A0=A0=A0 to apply any optimizations it wants both to the stores in
=A0=A0=A0 cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_f=
req()
=A0=A0=A0 which may result in additional inconsistencies.
...

With those changes, the cpufreq can't scaling the cpu frequency anymore aft=
er cpu
cooling event. The root cause of this issue is that below 'WRITE_ONCE' chan=
ges may
have some potential issue. When the CPU temperature is higher than thermal =
passive cooling
threshold, the thermal framework will trigger cpu cooling to limit the cpuf=
req policy->max.
For example, if the CPU supports three setpoint: 1.2GHz, 1.4GHz, and 1.6GHz=
. The policy->max
will be limited to 1.2GHz if the temperature continuously increasing and hi=
gher than the
passive cooling threshold. Then if the CPU temperature decrease and lower t=
han the threshold,
the cpu cooling will be canceled, the policy->max need to set back to high =
frequency.

But with below WRITE_ONCE changes, if the policy->max=3D1.2GHz, the new_dat=
a.max is 1.6GHz
or 1.8GHz, The__resolve_freq return value is 1.2GHz all the time, the polic=
y->max will be fixed at
1.2GHz forever even the new_data.max has a value large than current policy-=
>max.

static int cpufreq_set_policy(struct cpufreq_policy *policy,
                              =A6struct cpufreq_governor *new_gov,
                              =A6unsigned int new_pol)
{
...
         /*
          * Resolve policy min/max to available frequencies. It ensures
          * no frequency resolution will neither overshoot the requested ma=
ximum
          * nor undershoot the requested minimum.
          *
          * Avoid storing intermediate values in policy->max or policy->min=
 and
          * compiler optimizations around them because they may be accessed
          * concurrently by cpufreq_driver_resolve_freq() during the update=
.
          */
         WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFR=
EQ_RELATION_H));
...
}

Please help check it or suggest how to fix it.

BR
Jacky Bai

