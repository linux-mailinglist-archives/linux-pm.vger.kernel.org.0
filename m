Return-Path: <linux-pm+bounces-7078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87518B2021
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5A8B270A3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC885261;
	Thu, 25 Apr 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hYXnP2K3"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2096.outbound.protection.outlook.com [40.107.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54C8527D;
	Thu, 25 Apr 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044224; cv=fail; b=XctEyDV9kT0TPxy0ZqnwbltEVDmQ3xuFx1YgDu0Toxcahi8DyHmz2pETL+3Gd4iKUY/7JV87OxerPsFJ61nz8a+2rgxfOWnJEEd9NQMoHC2s2/mfKEb5dTW0eqP6tHz1pNhOC9d2KiKNYa9zb5dAnD9CcR8B91O0Yqsgure40Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044224; c=relaxed/simple;
	bh=CuxcUZ8888gJ4IOdSlF+Y39pizfTckyVLc7/K9YMWMQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ivd8vnSCgE99IPD/abCUTWygwDJsry7+kMtEpJ5ppmDBqLuIUPIP3c7tNl6rZSojlt0qM38t8FIAWjILNMsKSk9fwFJsN3fs0rRz1DG8GFIH1C3smax6/hD14NOUs6s2SEZzG49FwsMMgT0vhM1JFnXg/X+Ga09JDkR5nmz3cYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hYXnP2K3; arc=fail smtp.client-ip=40.107.22.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT+HgvBr8xkfsB7MjoeXJGjmSb3CqIKIBa/46Xg1PcVdTGbZG6bDwZpGp68tXhdwTRyaUootLV9PWa3fkjqhcKkRwyzS6aXg/bDvIfax/rsAvUENo/KbcRnRfTyngJevxNf69SzZpV/0tihLnsGXxNRgDnqvgyVllJRRtprrC79mDP/ZeqKmdzWb6YBXQ8PdISklsjc1/gzAwu0V2eQOZ7d3dLzRQomgaIKT6CbF4sjGKBUlkvE4bJMII21JW3OGs62h+cSzYa7h28qbAxiZxyZEJX3LwUW0MEFrVYWqercC52RUPGg8Xjma195haKBfy7K7W5A636R3PKEA8lCMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuxcUZ8888gJ4IOdSlF+Y39pizfTckyVLc7/K9YMWMQ=;
 b=cwgGrHsweybmVvePjMQHAaa9pdugKh512ZEmMMrGHqgkUP9juJp9TYve5S/5HexnQ/qVV+MN36pnMRHuNLgoT5n0SU1xP36Qy9FaU8GRkyunBZmBdU5PtTSBS8tFPRjk4E/bvxJl9I7bpNnhXB+UUzY/TocykAnl7IWqcIjAMNc6aPCX9T4s/vEKbfYdycyv15SPmnPcudDy5AZ2yEkS5ZYm0vUeOn0OcRp/Qczz1/B/h/aV6PsGbWbP2LBf8UHywfVD6FVVz0OPNR38r6qbiL03II6laeD6cR2Xah+nYB9Jtc+2/zBd32fB1/Y0s1wN5bLm1AHXfADblhqpTjwLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuxcUZ8888gJ4IOdSlF+Y39pizfTckyVLc7/K9YMWMQ=;
 b=hYXnP2K3tl5jkQDtTOkTJecwIMiid/BBLY58gZiBTO8Ug/Sd9/H1hy8BM3TnD8/q263gaKk3BbmZlV33LcM0b0lorQjYFZ+qyR/Oa5O2BVn3rSGT4v5NgLI1hd45Qf/1vvtA1rvJbdR6cF0WxdUs2hrCAXa+kryJumcWSRS9zR0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9499.eurprd04.prod.outlook.com (2603:10a6:10:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 11:23:35 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 11:23:35 +0000
From: Josua Mayer <josua@solid-run.com>
To: Sebastian Reichel <sre@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [RFC] power: supply: gpio-charger: extend for supercap charger
 ltc4041
Thread-Topic: [RFC] power: supply: gpio-charger: extend for supercap charger
 ltc4041
Thread-Index: AQHalwMDYUGbWQyWhUWjCi55tsTLpA==
Date: Thu, 25 Apr 2024 11:23:35 +0000
Message-ID: <9f01e84c-ef3a-4b77-955e-0bc1d95c9af0@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB9499:EE_
x-ms-office365-filtering-correlation-id: 2374cf28-42f9-4307-dd91-08dc651a2593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFRqZ0MzRjlGU1libng5bjh6UkhXc2NuWkRtSkl1UTE2ZUlNTFl6MHcyaGNp?=
 =?utf-8?B?c2hrSTNFNCtMZDRFY1lFbFEwV0NKejZlZVhXYkVKSGtXcW5DS2dsaWdkQSsy?=
 =?utf-8?B?bWh6UHlyWnlYMFduZGd4ODdtTE1qYzdGY1lXYzZKQmt0UHJvVm5PaG44NmM5?=
 =?utf-8?B?RTNjZXJzNzFsZGJnV2ZiZXdJY3BPVmkxZUFURVNiaExtYXpsSzZnNXpkcDY1?=
 =?utf-8?B?ZUFLY2dVb1JoTit2RDVmZXNlTEgrVkl4M0RGRWxia214TGoxcXJ0N2lZSHlj?=
 =?utf-8?B?ZDRZTjZrQkx0Y0F0Vng2aUVuUndiUzNBMm1GYXhiQ1UvVjVvQlBDaWVWOEFO?=
 =?utf-8?B?WU8zU3BuN2xqdVlBZmFPMXRRYk5EZFIzOWZmR3dFT1NIRzhtMTVuTjUrdHFQ?=
 =?utf-8?B?STFWYmxGam9KZFRQbnE2NnFxT1NiVVpoYmZPM0tVVzRtZ01PT3JmZmIzemZu?=
 =?utf-8?B?dDYwaThldUg4bENnT2pTM0hpTGZzLzNaaFBrU0xlemFpVVNLWjBQQnJkNDk5?=
 =?utf-8?B?WXIwaVJYQncwd2poUW9LdG9YZGV3UlpCNGc0T25uOU9NUlIzZUx5djFkZjJQ?=
 =?utf-8?B?cHMreEtDcXZjK0lTTmNocmFCQ2J1S0oyenphSXBTV2NNQjNwVmo1MWpIUEgz?=
 =?utf-8?B?YUtPeXAzeHU3YlZxWjk5NHVmaEU5SG01cHhFa3Z3ei9iMnh3V255eHkzS24z?=
 =?utf-8?B?d24yT3NXUzBaSlJyV2g0NGNXTWlXZW16Mld2SzVZQ2dsVmJPYTJMbDg1cnA4?=
 =?utf-8?B?NU01cFpZSzVGdi9TMHpOb1dEQ2JKQ281a3lHeG5OTFpVL3E3VTBDSXhpRlBa?=
 =?utf-8?B?dEx4bDRtcFNqS2Z2dytESnZwMEpjUjdaS3BpRklUSVZ4elFibDNGM2FrSERL?=
 =?utf-8?B?NWprMW45c3ZyRWdCRzF6OXBSWEFLYTk5QVFtVHFGVThENlFnYUJDbitkdGVX?=
 =?utf-8?B?TldNYzhaZysrQlp3dTRIUzk2dDVheGZVWlBmdXF6VE8rdENOZlp2Qlh1a1Fj?=
 =?utf-8?B?M1ppRUozZXRzV0Vsb3lGbWpabXdzdTJlVFBjOFBHdXhvWjVjYmZEem9CZTdE?=
 =?utf-8?B?QmhtNmk3UHpSYlpGTXp1WURRU2Mvcnp6N2Y4d1dNWjhxZ2JYVVhwWEJYckdZ?=
 =?utf-8?B?TWJ1dVVoZmF3VmdrTTFJNjVnRG8rU3NoTXJNRlA1b2RmK2k2Rk5wR2JOa2Qw?=
 =?utf-8?B?QXc1TmRWbUVHRXA4cGtqeGt1UDNweVdwMkwvRWlCQ1U4QWhOOUMwNEw5a2cw?=
 =?utf-8?B?a2htK1ZhSHpIUE1BdTBzZ3BDS2hUWGVhSGlnMHdveVB5bHN5SHFZMWtpeERS?=
 =?utf-8?B?WW5rRnQzZFdLaWs0OXE5VmJQOG9QV09jZzEwQnhRWEpQWWpsWG5FdW42eW9Y?=
 =?utf-8?B?WWZpYjBCR292SW0rWVVNTzFDUUlYcGEvNXl0ZjVTR0xFSDZ4aDI1Y1RQZjdG?=
 =?utf-8?B?MW5NamdDUkRyQW1qTXRqTGxkQ1pJRFFNNmg3WXlQbmdWTFkzc1UwVHBmb1Zu?=
 =?utf-8?B?OEV3cnh2MzJTM1UyU2RVakdYRzlyNE8zYTlvMmszMGFNRWdqdVQwZFBwUm0r?=
 =?utf-8?B?TDQ1QThJbUtFUUREdS9FWEZIUE4xQTJsTVZXT01zK05kM3JIOEJpdS9mNDNu?=
 =?utf-8?B?cGRocGZQUVFLR0MyNklTSFhNekRxU2VSbEdFbzZJSGVzZlZRcFFSNlpQTUNE?=
 =?utf-8?B?Ti84N0YzTGRITUJJTVdlVnVSKzFZcmFqekdnZ3ovcEdZK3Bab1RXdHI3QjVi?=
 =?utf-8?Q?lfDsTYTN1K+dhCwg/Vo2IHdil2HQ3tajKyT0nu5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWtySWMxNkhjUjA1ZlV4a2V3bXlxQnhRNVcvWGFZN2g3c1BQMEE5OWY2YkdS?=
 =?utf-8?B?RGduMnlFZFFJT1F0TldHVDE4WkxTQ0JlNkNQRktkaVFzMi9qdnB4UVlZM3k0?=
 =?utf-8?B?MGg0dGpTT2VwZHoyTENrYWJWaS9tU0JNZTRkZDgwdlJoQW01L3ZPVEJGRGVJ?=
 =?utf-8?B?VGZScjNsVktmbGVNWG1URUtpYncyYm9QazhMWnQrUTkrT0xGK2VPS3VuY3ZH?=
 =?utf-8?B?QXZaVWdPT3ZldVl1SXhRYTNIWmVPTGZCVWh1ZzZBcTdvRVREUmNVVlI0andT?=
 =?utf-8?B?Y09xTjEvZ2NSbVNwMWVoQ2UzUXl3UGhDOXR4eDlkWkl2UFQxcDk2QnhLeEhh?=
 =?utf-8?B?V2R6NVcrOC9sUUlicGd1UjNVdGNscjZpZHJEL3dqa2Ezblljb1dyWEhxK1FH?=
 =?utf-8?B?WCs3KzZxQ3ViVjFrN0tBUlBmYVN5RmlRb3hjUTFUYVQrVGdqcXovdlYvaDli?=
 =?utf-8?B?aVRmQ21yRkxDK2h2MjNUOUhraUdPZnE3RTBaRkdsM2pHVForbXpxTU1xTlVH?=
 =?utf-8?B?enZCeVY3QnVjdVRoc2lPOWtFV2xiVFRpTXAzWXVtWENvYzBXbmFOVGRZMThK?=
 =?utf-8?B?L1hXejNaWXk4bUsvK0xEeXJsWnJzTWlXVDNjT0Q4bDFocW02cWFvakpKWDVz?=
 =?utf-8?B?OUp3cnUvNW1SMFVvVHFZZEJCY3Z1b0lVQ3ZJK0RMVG45L3l6cGF3KzUyMmVH?=
 =?utf-8?B?RGErbGlqRldBZ3Y0N3hML2RFeGFOSU96bXFrTTR3N0ordzNoTHAyTzhxc2t2?=
 =?utf-8?B?a1U1Q2VrdzBqY0ViaHlzSWh1SzB1ZVpoRWhmalF2REpSdjdWUmZZY0hDMGZD?=
 =?utf-8?B?dDVjV1RvWWdnUjcvWFU0L20xQzF1MEhiaHBSZVNSSU9nTW5nb2ZGcElrQWNp?=
 =?utf-8?B?SEFxakNkQ0MwdmMyU0hMei9WVWtjNCtVTjQrWUt1RFRJVTArdVpmZHpFd3Z1?=
 =?utf-8?B?RHUwWlBpNWVlY2xxS3ZFbE5IRDJwSmtmUThIbis2djR4Y0FCQWxJMzZGOGxD?=
 =?utf-8?B?RjBZZm9mVEZlUmg2NWdVUXFWaVlDZ3NpQU10bm5BNDZFYk1OOTVmV1NCbG84?=
 =?utf-8?B?TVZZcW9qZ2hEb1I2ekFTb3c1c2kwNTFmTGljd2dUUklmSVdLb3NDamloWVU3?=
 =?utf-8?B?S3BTODlTVUVtQ1Z6dFAwZEhkVk9WaS9tcUVpT1JZZTRvM0lxZzc4N2J2QWhL?=
 =?utf-8?B?VWFvdER5MjF6a1lwbjJWWU0rTGNLQzZYR29VNHpEekJlOE40dkh4L0JieXJD?=
 =?utf-8?B?QU1jcHk1ZlQ3S0ROcFJuV1dMSlI2QitURGVaWDAvM202UisybWhQVGxwbjlU?=
 =?utf-8?B?SW53ai9RaUxzWmdBNGppRjhZdGRUOGlsMjJiOFIzQU4xelFRRGVocHZFWlpl?=
 =?utf-8?B?K01icG0vVnJMakZkNUF6RXZPMC9rNGFpR0J5UUtWZjFOTVhpY05Pb2FIVERR?=
 =?utf-8?B?UE13MHNSYWpTckNMR1Z6dkFkcUdhK0pFalNNcDA4dkord2Z0UW8rUCtiaEZ5?=
 =?utf-8?B?YnFjdk1OTzNpOVBDL0dvbnRVd0t3dktLZHdJSkNhZzd0YS9uVjJzOGxvK1hy?=
 =?utf-8?B?a0d0ZGVNMGlFTHJTeHo0aWJTVnk3dFIxMG04U0xnWVZJNUNUSXFicW10c1Fm?=
 =?utf-8?B?Y1pQejZIQkZOV2pBZTZGV3Q1YXl1WG95bkRWUnVZN0o5UzR5cEgzZkU3NnM5?=
 =?utf-8?B?dXVrQnBvanQ5eGlPT2hWOWF5M0c3S1ExWjVaOGVpSWdOcWNCOXJjUllxUDdK?=
 =?utf-8?B?L2k3bXVtMWFnaHY3R0tQZ0Vla2tnNUNOeUlQQ0tDY3F1UnJvYWgrazg4SmFv?=
 =?utf-8?B?T2ZOVGEvemc4WllHb3NqNE1wRnozcHhRR2VvSktVOVVZbTlkVm9OenZHYjVQ?=
 =?utf-8?B?NDRnNUszM2RFNE42MzQ5UVRVT0dZc1QvZ0pFYXI5VmozWUE5MktVUUFuQSt4?=
 =?utf-8?B?T25lUzBSUXRQdVVHTWY5N0dmS2FiSjl3c2lkME9lKzVnR29NVFh6U3NEejRt?=
 =?utf-8?B?aUlMc2dLaDRGcXp4NE1zTG5icGo3Z1RvOXZweGVwKzRyL0tjeVlPNHRNeEJk?=
 =?utf-8?B?dW5YRmNHa0xKM0QrcW9vLzdIY2UyK01mK09Fbm1EaUJnUDBQM1hEb0hnc0dD?=
 =?utf-8?Q?2LO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDD14E2062BC8944937E2D41CC021671@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374cf28-42f9-4307-dd91-08dc651a2593
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 11:23:35.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e76MpXbbjSax9Bw0ExGhIf+UwTNm5wiOcktaxyV2A2hSoBSlzNGXD22xSN2o1wMUb2r4R+wtcVLShvkzalE7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9499

SGkgU2ViYXN0aWFuLA0KDQpJIGNhbWUgYWNyb3NzIHlvdXIgZ2VuZXJpYyBncGlvLWNoYXJnZXIg
ZHJpdmVyIHdoaWxlIGxvb2tpbmcNCmF0IGEgZGVzaWduIHVzaW5nIGxyYzQwNDEgY2hhcmdpbmcg
YSBzdXBlci1jYXBhY2l0b3IgdGhhdA0KaXMgcHJvdmlkaW5nIGEgZmV3IHNlY29uZHMgb2YgYmFj
a3VwIHBvd2VyLg0KU2luY2UgdGhlIGNoYXJnZXIgb25seSByZXBvcnRzIHN0YXR1cyB2aWEgZ3Bp
b3MsIGl0IHNlZW1zDQpsaWtlIGEgZml0Lg0KDQpBdCBhIGNsb3NlciBsb29rIGhvd2V2ZXIgbm9u
ZSBvZiBteSBzaWduYWxzIG1hdGNoIGV4YWN0bHkuDQpJIHdhbnQgdG8gZXhwbG9yZSBwb3NzaWJp
bGl0eSBvZiBleHRlbmRpbmcgeW91ciBkcml2ZXIsDQpwbGVhc2UgY2FuIHlvdSBjb21tZW50IGlm
IHRoaXMgZHJpdmVyIGlzIGEgc3VpdGFibGUgcGxhY2UNCmZvciBhY2hpZXZpbmcgYmVsb3cgZ29h
bHM/Og0KDQooUmVsZXZhbnQpIFNpZ25hbHM6DQotIFBGTzogUG93ZXItRmFpbCwgcmVwb3J0cyBs
b3NpbmcgbWFpbnMNCi0gQ0FQR0Q6IFN1cGVyLUNhcGFjaXRvciBQb3dlci1Hb29kLA0KwqAgcmVw
b3J0cyB3aGV0aGVyIGNhcGFjaXRvciBpcyA+PSA5Mi41JQ0KLSBDQVBGTFQ6IFN1cGVyLUNhcGFj
aXRvciBGYXVsdCBTdGF0dXMsDQrCoCBlZmZlY3RpdmVseSByZXBvcnRzIGlmIGNoYXJnaW5nIHN0
b3BwZWQNCi0gQ0hHRU46IEVuYWJsZS9EaXNhYmxlIGNoYXJnaW5nDQoNCkludGVuZGVkIHVzZS1j
YXNlOg0KS2VybmVsIHNob3VsZCBkZXRlY3QgbG9zaW5nIG1haW5zIChvciBiZXR0ZXIgIUNBUEdE
KSwNCnRoZW4gZWl0aGVyIGdlbmVyYXRlIGV2ZW50IGZvciB1c2VyLXNwYWNlIHRvIHBlcmZvcm0N
CmdyYWNlZnVsIHNodXRkb3duLCBvciB0cmlnZ2VyIHNodXRkb3duIGJ5IGl0c2VsZi4NCg0KU28g
ZmFyIHdlIGhhdmUgYWJ1c2VkIGdwaW8ta2V5cyBtb25pdG9yZWQgZnJvbSB1c2Vyc3BhY2UuDQoN
CkkgdGhpbmsgdHdvIHByb3BlcnRpZXMgZnJvbSBleGlzdGluZyBkdC1iaW5kaW5ncyBjYW4gbWF0
Y2g6DQpncGlvczogPCZQRk8+Ow0KY2hhcmdlLXN0YXR1cy1ncGlvczogPCZDQVBGTFQ+Ow0KDQpJ
biBteSBvcGluaW9uIGRyaXZlciBpcyBtaXNzaW5nOg0KMS4gZGlzYWJsZS1ncGlvOiA8JkNIR0VO
PjsNCjIuIHNvbWV0aGluZyB0byBkZXNjcmliZSBiYXR0ZXJ5IGNoYXJnZSBsZXZlbC4NCsKgwqAg
RS5nLiBJIGhhdmUgQ0FQR0Qgc2lnbmFsIHdoaWNoIHNheXMgZWl0aGVyOg0KwqDCoMKgIC0gMDog
bGV2ZWwgPCA5Mi41JQ0KwqDCoMKgIC0gMTogbGV2ZWwgPj0gOTIuNSUNCsKgwqAgVGhpcyBjb3Vs
ZCBiZSBzaW1wbGlmaWVkIHRvIDAlIGFuZCA5Mi41JQ0KDQpzaW5jZXJlbHkNCkpvc3VhIE1heWVy
DQoNCg==

