Return-Path: <linux-pm+bounces-31950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C3B1B083
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16A27A9EFE
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0225A2CC;
	Tue,  5 Aug 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="S6rjsQda"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653D1EDA09;
	Tue,  5 Aug 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384000; cv=fail; b=kQvy/wxbS6SBFbegKfhM+lGEeECiG1EePdMl4cz24l8Y/N/hhSfKljsBUqBWlKTLzc69H607IQsSFBrkunzu3xYdXB2zUuofv3ifjN/EnL3OlTPOZhBsX32IzblPfJtEZMoHF5jJZNdIax3T8fhPPh/E+yGAIelEVUKPnHJ/jBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384000; c=relaxed/simple;
	bh=Os1PheKbu+e5817zY5wgw2uNFAEAuqxSXVtePs0bLto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qqBxOsJkHvpKTTY5B4NSpRmBEX9fkQNWhMqwCfOricqNW7T2rnGcRp++ZFHjOYQj/ROiH40UtL6sXO+Y/ZVay/scLCTywRTHJ6JJYRNriLZ6Dx0YQeK7yNeTU7NB07euf7d/FjUNOtngRHAXT9mLotnXgvSWUIjxMIHDmMK3wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=S6rjsQda; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNohF8cKRPrSxGNAv3y1EB76GSAzufCRwc/4DvBwexfsM0t1RBtCcJIRar14TE5WiELfhSrPqok7xF2uWvdsD5fLF7oi9niMH9bsnnLuiF/m/U6Zm7WE3St4gR0O+tPYIBj1yzhxjXvDa58OeWsC+XJkR1SC8Zvk+X0iQq9d/FqpYbum42hEVQxeM4grJ/YrmWYALyYWqIrJ1sIyZRS3oG99MNZRQkGm/GcbYFkmKChVPJ0cW7c3ksxKc9R/ZzaWLzEW9w57RXfbBgrsdGN8JARLyCXgp1XiFvs5qs7y7KkHJKITZS5NsjeB9ce3oE/6Qw4EXHCMyqXXVpSyYIj+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uk6tslYzv2BQI8W+kF1mVS58SqwdQx15kzEQRpO9MA=;
 b=gfNRkCmapmzlwoaeHnZq+pbboK30E++UHoZCake8cIFb1f0Ikl6bCEfbg7UMMby+pQpsQrYt5bikU+sw1y148p+V/w+oTIRauOg6xNRmjx32OQSFSkLJ4+jDxXOj8oHUvOU21CTFg3n3NpdBuYB87h+rcs9akhGEBLgz2o2Xxxp1ZpGvH58NwuvICjDLFzhP7YbbL4Qg3072tHs/d/j8PH+MxX3f2A53pZz183f2MdhToblqMKCcwv/hkswEBri71ohGjHhsMVSUWyIeaQ+sfCLOJ/Ar4BTktx8IqqGGhwBz5qN/QbtnqFgCbL2iq5CLY7R40UW9z3a0mtTnYrmYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uk6tslYzv2BQI8W+kF1mVS58SqwdQx15kzEQRpO9MA=;
 b=S6rjsQdaZilCgGKUbrUhw6blCFe8/+EFHT2SyA6tD2o/0BQAdfudgMX4r1PhPrUjGKBEoI89GiJJWkalJMPRiVEwPcF0s3liaGUvSJXBdmW6n+Rclw5rBbXvqucnGSQigsh91O/Dq7IegUi+YN5beHqI9CJav1vwX6fAIAfQkww=
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19) by VI1PR02MB10442.eurprd02.prod.outlook.com
 (2603:10a6:800:1cd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:53:12 +0000
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d]) by VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:53:12 +0000
From: Jerry Lv <Jerry.Lv@axis.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel
	<sre@kernel.org>
CC: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@pyra-handheld.com"
	<kernel@pyra-handheld.com>, "andreas@kemnade.info" <andreas@kemnade.info>,
	Hermes Zhang <Hermes.Zhang@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
Thread-Topic: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
Thread-Index: AQHb+j2XSICoRNMPaUyT5h0UlspWErRT1uSR
Date: Tue, 5 Aug 2025 08:53:12 +0000
Message-ID:
 <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
References:
 <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
In-Reply-To:
 <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB10076:EE_|VI1PR02MB10442:EE_
x-ms-office365-filtering-correlation-id: 167eb1e9-7785-4b33-c517-08ddd3fd8241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|42112799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5iuLCpNDQIfQJWFyQBoCE+ZsYTyFcfc1gOFyHF+r+TjsclfqfANm8U6GlW?=
 =?iso-8859-1?Q?babcCk1c4eP44CqmsgZAWdWbVWea3M4uS7ZNERsgJXLboaKBzuzykK+Y+2?=
 =?iso-8859-1?Q?trqwlx5JLqgd7E6ToBtpKHf9HpEjRIGvAzZbuNmQCaaFVYu29lW9KkL6G+?=
 =?iso-8859-1?Q?flPi17uoiwQ/EwWnPZlkfzZSPQPHpzBDiELH1MCNeYbzLwAA2naQolpKzn?=
 =?iso-8859-1?Q?S3XxVCa6357SjOVJq1WNVrNeDLUh+5fERUujp/Ll4yN7hTwZ4CFSVw+zTA?=
 =?iso-8859-1?Q?uidgYH3n0CuT0hBekdtawlCQ8Gzd6rusIbtmROpIrVC8VjslViIDh6NiQf?=
 =?iso-8859-1?Q?k5uUTZ/jT0shBlMQyiTK5cc7tD/7Ls2pFcK8Mh8PJFOkk6rRlTdxVOraen?=
 =?iso-8859-1?Q?JNeWDnpA/iK5edtBERV7L6/ynTgekdXzjvLMpuiIXNymwJesMXMeA7aLRC?=
 =?iso-8859-1?Q?HH5SM46nkJEL+FNHxnfckG5q5tnZjUqzxm1b3VNYfH+FZoosD/qvf7Izsj?=
 =?iso-8859-1?Q?QrBwq1NcXMxMBqlSwx/dhZt++MRLRwN1cOY3Y3Tu3qKOJ7q8q0qMHki2LQ?=
 =?iso-8859-1?Q?4oPQUYoLZj8OdLtIE8RKxXMcpD3kZbk8DYQwK1kIchxBNcsVaZpfPDMSaM?=
 =?iso-8859-1?Q?QNyV11Y4R1Nd0D2i4bl3tqrMjPtOccIZzW33JdVVDmembviBd5FAIvEYlU?=
 =?iso-8859-1?Q?gAN+CgQZn4CTXPEqDop1JLaoRAoaxGQgIAQgXuoATx3fvZrzsDuPtetKHI?=
 =?iso-8859-1?Q?+Mzk9l3SAIeIauVA0r1oVughx4ULEO4OHF085pMMdaYFr8CHIZ6w6cqpbn?=
 =?iso-8859-1?Q?athJ/3qG5ic1MS4NjLp3+6BWS35OUskHFpYeXWQt4KV+smr2985rF4R7Wj?=
 =?iso-8859-1?Q?ydrX0yAwSKvLYuB/kKYoypSe5l1mkWcrpF+q4CeCK5wtfiE45DCYTE1m8Z?=
 =?iso-8859-1?Q?JkbD2POSAooHiV8dpaflUvafUOqePRcp+mUKnyNoOHy/K63Li2rMRZmMhm?=
 =?iso-8859-1?Q?iA4WJPshmjNspcVtIeDeNWJB/J0onMXRP3XZRIu41IzDEWK8S9jyKXO6zd?=
 =?iso-8859-1?Q?ybKfBSNKP63WavHh6jvzFrGShsonX++1flEz8S/eC9pSacF2tw4tuFyHe5?=
 =?iso-8859-1?Q?s6LQI+LUcwkRVP+F1ggF29rkp1NXKxORfYOXZUMO4G2n0URxYUHOo5IfnN?=
 =?iso-8859-1?Q?32p373rvHroM9ONOFF3fdXfXN9BnQYkQoSQN2nbKD7cNq+eNqsm4je5MAm?=
 =?iso-8859-1?Q?NcbgorgKeSftOqEcEjSGUE4vY70C0vMsyuBjkoluLyHXf36i4cUn05YLaX?=
 =?iso-8859-1?Q?d/eI88mPSp5Wh7OUL6eGqbQwXBcC0LbmGvkC4kQ7MRxuDmAxVIvWkYfyuA?=
 =?iso-8859-1?Q?68QtEvy2PNrai+zI4lScZv7+cgDhWfNyPXydAHbEwIGPLYg/XpTn/to2XA?=
 =?iso-8859-1?Q?dEIt5aKY87R0Ofq075UpxRsjshhhQlJax9ajFjZm+1/GLJSZXuqcGdux6a?=
 =?iso-8859-1?Q?vktXIeCjD28WLQ9rviAbs8Y5wEmltkZIT/qnLE4+4YZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10076.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(42112799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?K/xfndGw0j69WwvVQkg3UU2CXj1XXImfo4i7mH/OJeYjAsofepY4dEUnsZ?=
 =?iso-8859-1?Q?Ad8uOckFOwq1JhrgbOuryLjg07jVuNu340ZO/6Er2So1RlanvXkNNO93cw?=
 =?iso-8859-1?Q?WUHk3W1JcFsqOpYwuGUTxc3ogl91evaCsjD/ETtKHM1Ekd8D8vHIAJ7DUM?=
 =?iso-8859-1?Q?wvXBWxcgTVm65kwB+YnMHWQcWhnB7KW0bc9SMJ7rEYPmELzbYs+jBd49zG?=
 =?iso-8859-1?Q?j2ZjbqK248F2UQw22D+hCftZbLZ6RUg39fH70LZBx2YJ2OHq6XTroEFzoM?=
 =?iso-8859-1?Q?9BcwRclqEqzEWLzcK26PzL7KLSKMVllWD0zQK23Ih5awoWDdflpp72Ytqo?=
 =?iso-8859-1?Q?YQMhsUtjLrxjzYYBsotcaQ+5UYMnRyWbE8zbPOphbv+r0Y77dd3feyByKQ?=
 =?iso-8859-1?Q?sAyQm1LMepVxH1CGJHv+D5lBLB46xuq9rs7ZrNPUVEOz1BQa5gn94tguas?=
 =?iso-8859-1?Q?nRqRjDlrmm7kd20JDIUr5MoF0CZ79RPEVAkJXPf4pRnyuZAhWrHjsG4es9?=
 =?iso-8859-1?Q?bcUoQ1dx6RT6IC8ArUMdj5sCippBVYVAo7503fQOncz5IZZrArAniiVZRW?=
 =?iso-8859-1?Q?7+hAWK4KzoUeYNa21iJPCRdvN9Ezu7A6ZimEiOI6oBdi+EV0ZQE7hszlWY?=
 =?iso-8859-1?Q?+5xLyhgvSIG9kZweRwGvm8LZTyUJnyaOFrVgAUXonCPJfz0AAveJ+NmQSO?=
 =?iso-8859-1?Q?U7lqnJUhgcDiAZlkSW//zPZ6mkg40/b6lpSe6donRb1PMF/adYnn3ZZbpc?=
 =?iso-8859-1?Q?hKIObns4aBT54NHPYo7MLuXbjCr5SfTxQzXt95f25o5aH5aYhpuxMQQdUl?=
 =?iso-8859-1?Q?dWenLr0ALAo9AgkrpMZdHwcmITDHap29lxLe6LzBlPGZYd7bXfhB3nJfvD?=
 =?iso-8859-1?Q?lo2Pt9qP1Bo9jD6MWTIx5hhwu8v1LVcn+2TEgIVcY389EWMc0wNtIz1jJF?=
 =?iso-8859-1?Q?zLWS3mZOGB9S6MnZXk4uf368T2wdxTWcb3MZZp/mPtCXt33Awv08IVI3ci?=
 =?iso-8859-1?Q?9a7tbyAa+jBvAoQpY5FYWXRwp0FTZEZ9DyPflwB5hcp39DLiiLcZrgU+xM?=
 =?iso-8859-1?Q?gJ0PyJpmG/pt2olT2vpjXP/Qea+dZktQ9UWoYm4XDK9GAf79h3UnO03MA9?=
 =?iso-8859-1?Q?nS4lMJo8BDUS03zS80Fci9havOAyvC2mdHPuVUCs9QGx+HHDEvNo6pyTfQ?=
 =?iso-8859-1?Q?wyCRl4o13Y38oDbmwE4+/VE36crB4R0LGQie2MjmTOxZUQlcGSmebv+fFF?=
 =?iso-8859-1?Q?uL+xgXPuilb4avtCKhkRvmbWyhk2wMstTPSCKCHz6oVcJO0Jdl4y0FOLIa?=
 =?iso-8859-1?Q?lwxx8LtES5dNxFOoYmZP2EGYTqu07wYCqYMwkJMha504ot6+dgkNiEXk8p?=
 =?iso-8859-1?Q?QNutV8PXkiU2+/ZQLcyZcLGe1BJXu/F1+NOTjVK8XDVVtWUkiSbobvJo1j?=
 =?iso-8859-1?Q?w+3ajwoSdLfFq2eZNGE3tlJm//qOUKS3YDSc9FXlQn1wxOwLcuuVyoaYfV?=
 =?iso-8859-1?Q?fFJ4EfT06Z3R08Xt57ch3ZmLea4k5WVlVYYMPXJZ185Zxlxg9VnekjsIYR?=
 =?iso-8859-1?Q?F3fxm+tUBan/wyOfsLldZX4cASa140bVUJ3Omhwvi8Aqdbp4e0dssog/lT?=
 =?iso-8859-1?Q?Mhxam76sScXlY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 167eb1e9-7785-4b33-c517-08ddd3fd8241
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 08:53:12.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52vo2MkM+fNAEU5uKqdGEMfw+OPswRLpF04TKLPs1ZijYKpH0G1dGDqzk61PTGTuBvIB+GY0/RXdn3VcKrRwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10442

=0A=
=0A=
=0A=
________________________________________=0A=
From: H. Nikolaus Schaller <hns@goldelico.com>=0A=
Sent: Monday, July 21, 2025 8:46 PM=0A=
To: Sebastian Reichel; Jerry Lv=0A=
Cc: Pali Roh=E1r; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; l=
etux-kernel@openphoenux.org; stable@vger.kernel.org; kernel@pyra-handheld.c=
om; andreas@kemnade.info; H. Nikolaus Schaller=0A=
Subject: [PATCH] power: supply: bq27xxx: fix error return in case of no bq2=
7000 hdq battery=0A=
=0A=
[You don't often get email from hns@goldelico.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
Since commit=0A=
=0A=
commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")=0A=
=0A=
the console log of some devices with hdq but no bq27000 battery=0A=
(like the Pandaboard) is flooded with messages like:=0A=
=0A=
[   34.247833] power_supply bq27000-battery: driver failed to report 'statu=
s' property: -1=0A=
=0A=
as soon as user-space is finding a /sys entry and trying to read the=0A=
"status" property.=0A=
=0A=
It turns out that the offending commit changes the logic to now return the=
=0A=
value of cache.flags if it is <0. This is likely under the assumption that=
=0A=
it is an error number. In normal errors from bq27xxx_read() this is indeed=
=0A=
the case.=0A=
=0A=
But there is special code to detect if no bq27000 is installed or accessibl=
e=0A=
through hdq/1wire and wants to report this. In that case, the cache.flags=
=0A=
are set (historically) to constant -1 which did make reading properties=0A=
return -ENODEV. So everything appeared to be fine before the return value w=
as=0A=
fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, triggering th=
e=0A=
error condition in power_supply_format_property() which then floods the=0A=
console log.=0A=
=0A=
So we change the detection of missing bq27000 battery to simply set=0A=
=0A=
        cache.flags =3D -ENODEV=0A=
=0A=
instead of -1.=0A=
=0A=
Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")=0A=
Cc: Jerry Lv <Jerry.Lv@axis.com>=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>=0A=
---=0A=
 drivers/power/supply/bq27xxx_battery.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/=
bq27xxx_battery.c=0A=
index 93dcebbe11417..efe02ad695a62 100644=0A=
--- a/drivers/power/supply/bq27xxx_battery.c=0A=
+++ b/drivers/power/supply/bq27xxx_battery.c=0A=
@@ -1920,7 +1920,7 @@ static void bq27xxx_battery_update_unlocked(struct bq=
27xxx_device_info *di)=0A=
=0A=
        cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag)=
;=0A=
        if ((cache.flags & 0xff) =3D=3D 0xff)=0A=
-               cache.flags =3D -1; /* read error */=0A=
+               cache.flags =3D -ENODEV; /* read error */=0A=
        if (cache.flags >=3D 0) {=0A=
                cache.capacity =3D bq27xxx_battery_read_soc(di);=0A=
=0A=
--=0A=
2.50.0=0A=
=0A=
=0A=
=0A=
In our device, we use the I2C to get data from the gauge bq27z561. =0A=
During our test, when try to get the status register by bq27xxx_read() in t=
he bq27xxx_battery_update_unlocked(), =0A=
we found sometimes the returned value is 0xFFFF, but it will update to some=
 other value very quickly.=0A=
So the returned 0xFFFF does not indicate "No such device", if we force to s=
et the cache.flags to "-ENODEV" or "-1" manually in this case, =0A=
the bq27xxx_battery_get_property() will just return the cache.flags until i=
t is updated at lease 5 seconds later,=0A=
it means we cannot get any property in these 5 seconds.=0A=
=0A=
In fact, for the I2C driver, if no bq27000 is installed or accessible, =0A=
the bq27xxx_battery_i2c_read() will return "-ENODEV" directly when no devic=
e,=0A=
or the i2c_transfer() will return the negative error according to real case=
.=0A=
=0A=
        bq27xxx_battery_i2c_read() {=0A=
                ...=0A=
	        if (!client->adapter)=0A=
	        	return -ENODEV;=0A=
                ...=0A=
                ret =3D i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg))=
;=0A=
                ...=0A=
                if (ret < 0)=0A=
	        return ret;=0A=
                ...=0A=
        }=0A=
=0A=
But there is no similar check in the bq27xxx_battery_hdq_read() for the HDQ=
/1-wire driver. =0A=
Could we do the same check in the bq27xxx_battery_hdq_read(),=0A=
instead of changing the cache.flags manually when the last byte in the retu=
rned data is 0xFF?=0A=
Or could we just force to set the returned value to "-ENODEV" only when the=
 last byte get from bq27xxx_battery_hdq_read() is 0xFF?=0A=
=0A=
=0A=
Best Regards,=0A=
Jerry Lv=

