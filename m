Return-Path: <linux-pm+bounces-14369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D197B030
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2441C2265D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB1167D98;
	Tue, 17 Sep 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EYRkJ5JH"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013037.outbound.protection.outlook.com [52.101.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988D20323;
	Tue, 17 Sep 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576629; cv=fail; b=O6qCJufJXM8AwoAFGvsr4J1YKpcXieB0L1F8HQFQkGyZYRe4SvKIkkMT3Y702DyGFLOt6F6t4VdkrGI2z7zL8PyzX5e3dy3v60WM0ZkSODRi7zhmQH0u3P//s2rwjQNVF8/O7tFO6BjV7tJPPxRy4vg/Ycar1JKoCAHrOs6J20w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576629; c=relaxed/simple;
	bh=7ykKG+IunCP4qJ+isuc0V+Y0vPOqA04/yUZoxisou5Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBkdogxkthwO5hWqMkz8qJjQO+MRgyBH1+oG409rB06p5eQMq510m8TGAKUjFAz7H914AFvGiEH7T1fSgAqJ2hbVU5wsU0U7Pd/l9GzIBnbcXARope0UxRSaMp3guulbzS5IyYLNRbu+OOmGv8A7Rn78uoo+iC7rG8tqrYx+wKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EYRkJ5JH; arc=fail smtp.client-ip=52.101.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oydqe1QJ3VQoPc0B1LnY5oDtO6Xp4GvJbBGUDBPjbvWA94VFpYK6TX+Ek2CEQVIgM5ixm5CntbceJW5J8wsFdpNb0w5+wEfk4nr0R8JxGaMwD5bKphdZEmXsa7Qdb21nBlFbCEZUmyU29XKnkZIEvzjpIZhzluhJpzD/kMDNQi0toP1zXQRMSx0j0XxLj1l5LJCS24T37dvTU2ueAj4g4bKlcZuClQXvDx9BPJtYPRdaB6drORQexrYi4hZkzkiJATYXtC41m1jf7GqdVTXTYIZMsSOp7zF0pDLjjKwn0rtrvsCnVZ/0IAgS2zzgNTd0TpTamR/qB6/+QYe2DL9A/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ykKG+IunCP4qJ+isuc0V+Y0vPOqA04/yUZoxisou5Q=;
 b=PkuxApi96Nljs+SsyN9KhlaOztvCHtJrGWwjP5jz5M/Wg/FwG/qkwEV2nVlkt1V/g5QCm3+Ojf0URJa6Qc7CgoqAVA4dJWZf48HhkBG0g3ukbhQEz4D9h0Moo09+BPocO4zSDluZwnkqQ0Ao3pzjIP8DdHsl8NqUj8HYg56/FrZ4cRZXjDMfRO9ThBCR7eLOter8ZSMMY+oieCHf1REqz7aA2PtVC4ZmqDyv9ZqpjWtfpX2teGkVJggVzh9nW2nvCXlVjinjASWcssE+ik0iLgAgCRQBcUg5fVCpv5HAmhgoy0jy9UjoFU/D2U7XVL+b2rqjqOYEzqiLg7MTPTXzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ykKG+IunCP4qJ+isuc0V+Y0vPOqA04/yUZoxisou5Q=;
 b=EYRkJ5JHeylGFxajP0mtn2hxHkQq5uAkL1cPydrq2rHU+sFJujKTN6X0z4ckBKRaKrQpbHepf/kuMdON4Xjbv+nLELJriqv/54c4o1ETTwoyariihgnsa47xv6rd2asGbdaTrrH/U8te9tcIHXo4meVVNpF4Y7E6PA90pboYZmuRmLy21hh6LbIem4xt7DCsN8va0S+eGUjXSZBqysh5OT+cOeq7s8zbj3sHyZemLKXZXOeGhZfOpSTje6uZZCI8q0Ew3U/5IskpyoUhvXZ8wkBo/oXzMJ+iqRS6e7CSgWyvjw/im5zM+wykbKW+IzIyzR79o9OubJwIxDA8FvznUQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10878.eurprd04.prod.outlook.com (2603:10a6:800:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 12:37:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:37:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>, Shuah Khan
	<shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur
	<jkacur@redhat.com>, "open list:CPU POWER MONITORING SUBSYSTEM"
	<linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Thread-Topic: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Thread-Index: AQHbBLNWC31a55JN0EKkRuDK1MOc/LJUQ8+AgAeuyiA=
Date: Tue, 17 Sep 2024 12:37:02 +0000
Message-ID:
 <PAXPR04MB845993F071E47D0C2DC6D0A688612@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
 <e4d79b9f-3a8e-4e54-9033-cfb8998d06de@linuxfoundation.org>
In-Reply-To: <e4d79b9f-3a8e-4e54-9033-cfb8998d06de@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10878:EE_
x-ms-office365-filtering-correlation-id: edab3fdd-0c76-44df-547b-08dcd7156e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3o1bU9TYzVlL2xOM1loOWxrKzBEekdweldrd3NWZGRwRUQyWFRPa3RobllH?=
 =?utf-8?B?cmo1eStjL0RJMUVEM1RBZnNvTnRtamdkNEV2SmRIM3cxanoxN05ZamVjUVRa?=
 =?utf-8?B?UjZHZzNNczE0LzZ1TUExZWlKVk1LK2dMd253WVhsS0VmTE93WkFNNTR1NWpZ?=
 =?utf-8?B?c0xYLzY5SVdzQ3I2M2dvZm1lRHlXSnhxbGt1RWhhWm5XR1liNXhxOCtQNzhQ?=
 =?utf-8?B?c0tseElBalN1cjZXMjVpRWJ4VTdYeEZrN2xnZVRxMjhNSHJZQ1c1NVl1cTVC?=
 =?utf-8?B?UllWWUdGaC9yeW5ueUtzd08xVTJ3aTZ6Qi9ZM0U5TGRWNnJyby9ReThvMER5?=
 =?utf-8?B?b0hiUDJTS2xBclNZanIxYU0vb1FIODRmRTg3dGtyUU5sUW1PVXpEU3NySmxR?=
 =?utf-8?B?LzBxYkxtN0ZIRHpaZU9rUkk5VnRhMUFqdkx0dGpxQXY5VVVwaFFlS2k4OHlr?=
 =?utf-8?B?eXVFSExzRnVqWkhyV1J1YTVXSFJJSm40eUg5eWhIeDI2bEZqeXVpK0RhUXVh?=
 =?utf-8?B?aWdtc3ZEamI1UUQ3a2xmQmRCSGJJYmZvQ1N4eEZiRWpxVDV6MzhIdFAyR1lq?=
 =?utf-8?B?SVp2QjdpWUorSDVZTit6WHRZTk1kWGRvSHQrMndYQUJvQXY0TGM4U3hPbmpr?=
 =?utf-8?B?WEd5aFNqbFZIY3pQWW51TzhJRUxxaVU4Yzl5VW1Gd2dVNEdDU1pkbmkreEk2?=
 =?utf-8?B?cjkzclBxNUU1MU1FaTh0WlczcDRyMUZMWjMrYW1HRzYvVjlGLzdacWN2aURC?=
 =?utf-8?B?RDRqUkt6VDlWYlhEREFyZFBpc0l1cDJlOFBkNlVOWUJDQ1BxOXFJckVKd0Iv?=
 =?utf-8?B?Q2JyVjYxWTVrRms5ejVUdGNUMTZmSjBzNG9wS3dlbFFCcEV6SzJOYTBtaHVY?=
 =?utf-8?B?SlJVMm83Sk1lNTZYY2lNV2l4bC9vVVU3QnNPQUNadzNkTFJhYzZtcXRPbktD?=
 =?utf-8?B?bGJCaFpqVTE5OWlxNExWM1VpMmd4RVJxL0l4NVVpdENtWUZKWjlDSU5zQXRq?=
 =?utf-8?B?Y0dvL3lLMnZsdHpka0xqVEZNSW9tL2dkWm5ZTUZveTNLTHVMdzh3dnlEU2Vh?=
 =?utf-8?B?RVBVWGs1MkhHb2JwR2hoR0drQ0d5VHg0ZVJvOEYyRWNvczVwK3hMeTJmQlFZ?=
 =?utf-8?B?OWFHU3NQWjMrcU53c3lIY2RpMTJ5TmtjSlNMNllzQzFVNW1IQ0pMQ2xEWmVi?=
 =?utf-8?B?dVBLVHhFNzMyVml2MnY0L0JuUXVHaUo2bE1SZ0pmZjVnUHZydE1QZmh0SW5n?=
 =?utf-8?B?Z1NvUVpIdW5IdGJUc28yZTNMRXZ4STNxemJ3RFdSNm0zVm9raE5tTVV5QWNO?=
 =?utf-8?B?VE9tU2NOTGJWdW0wVmkvbm5FS3FwcVQ1UlYrTDhVSHNvM1BVZEJIODV0bmIw?=
 =?utf-8?B?VmtqaTFVT2NuRHJaMUs1TjQ4M1hySmc3cGo0Tko3YjZ2N1ZFOERhWjhBZUlT?=
 =?utf-8?B?VzM5aTFIQmF1dS9jcERzM1FxZ0QrSHFJeUgyQlZJVW1kdS9oNmttSXN3WG1j?=
 =?utf-8?B?d0Mxck9JaHQ3c3Q2Zkk3L0ZjamxOQUJ4SjBHR0hCS0pOY01sTkZudThrK0pl?=
 =?utf-8?B?YnlIU0FsbnpjWWJpRzNuY2hJdEVmajJzbERSdkw2SEk3cit1Y1phT2hHbmox?=
 =?utf-8?B?YlZ1WCtkM2QxWFRTNnc5UjN4QjJMOFhCcXZVenFjYkZKMGFKY1NBTzc4dFUw?=
 =?utf-8?B?QVF1TGxjRzlCSWhsTGQ0SVRDMkl5TFFqN0lXNlpKbERnQXhSK1M2OUM4bGVa?=
 =?utf-8?B?bUxuaDBwVG9kY3RhUTYza0FkR3J2bDdMM3p4bThsYVpxc29LWGNlU01TV0F4?=
 =?utf-8?B?WVhZUmNISjR6TmNNR0U2NjBScExqdTIzaVphcUZUTVFrTDdINlU5eU1yRG9W?=
 =?utf-8?B?N0tTYjZiV2tmRzBqeXNWOXRFazJ6bGZZZzhoSFNWV0d0Vnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a01yVHFxQlZxSXZoYklsMld2WEZ0YlZIMytvcmdvSDRjanZTNCtQQkR0MVMr?=
 =?utf-8?B?YllnTjMwV3N4NVErUXB0bjcvR3pBUFUyNU5NaFZrRTlBbFlIWnNRUFF6cE9P?=
 =?utf-8?B?a3BtZnhqN2o4TTFZT1I4bjY0NlJRUExLS056NHp4NnFicjhuRFUwdlpFU2Mv?=
 =?utf-8?B?dzBuRVNIdURCOWlIU01zcmNoL1lFNW1uN0l5SDhndVljQlZETVE1ekc0dEhQ?=
 =?utf-8?B?WDFkci9LRUtqN2Frd3lINnp5VTNicTVSNzN2MW1zWHZNZXpvejU1RzVEMXdJ?=
 =?utf-8?B?V2tOTUY1U2txQlV3MWRua2Ryb2ovWTU2ZjV5NGdLQmtEZXFkRzUvdmdQMlV5?=
 =?utf-8?B?a0kzWlk3M2hnV3ZkU2dSOWN0SmdOR1dGK2FpQXk2ZHpIcU5jRUJ0cDJwK0lw?=
 =?utf-8?B?WFZlREpYNHNOeUZIbG9kM1BIbXZDK0pqTFlrNkl3NDJHaDl6M0s1TFc2WDN0?=
 =?utf-8?B?YjhteEM2QWFrN1Q0WHZkeEdVM215TDk3NHVvTEU4djVsT3d1YXdjMjdFN09M?=
 =?utf-8?B?YUpiSUdLQWVHNnVRbktyMDhMcEJ4cXd6aUZyQWtBSnFuQTNJZE82MGZiMm44?=
 =?utf-8?B?MzhLWW5KVnR0RnBvWGV1Z0Zsa2ZzeVhpQndyUFZIUUdzbUpIOEdzajBEc0Nl?=
 =?utf-8?B?b3BWcHZETVlTdEVGcFlJTnVIRGVUVDhjSFRWREVnU0M5clAzZUh1emF3WHVr?=
 =?utf-8?B?bi9Cam9aa0M0NUlmazNDalBHbkwrdVRrQVZSZ3ZGU3hrZTJnTk9uemZPalVj?=
 =?utf-8?B?RzVacUNHMERJL1RtZlVXdGFNNDk3N1VnSGJrT2JBaWN0WFRLUzJwYjlIS1Ro?=
 =?utf-8?B?dXFKYXFhRyt3bWdaQXgwT29DbUkwN0hCMHJpT2FEbWF5N1dpMFRqRWdBUjRq?=
 =?utf-8?B?MGl1LzB3OE42Z29ENHRJM2lxL05aTnpwQWU2UmR3OFU3WVQxRVdtNDUzU0x0?=
 =?utf-8?B?VzRoSHBVa1BhaTc1WGNEYWx1TFpvS1ZPZFA4RWh0eUdueXZIS1VGWUF4bWJE?=
 =?utf-8?B?TVBwQzJzRUZWZngybnluSlZ1ZDdFUVF1MXgyOHNSZXUrYlhoZTBWK2paWlRF?=
 =?utf-8?B?S2laY1VlNUp5cHF2dnJ6c0x3T1Q4UkJ2OU5IS0V6VjExbzVOUi9TL29vWGpF?=
 =?utf-8?B?Q0ZCaVFRZjV1QVBETnNOckVwbGY1Z0wycmVwZzM5c1BnbHRmN2ZReEZxdG9m?=
 =?utf-8?B?dUtvNXZnSFNTbEhHcWNBeHVPWVFaZ05SMERVaGpGUEY0ckJOUXFJeTBOUDB2?=
 =?utf-8?B?V3hnS0N1ci9VdGlHVHRBWjh1SGMwS3hNWXdhWHh0MlVvUGZkSTV4ZVlLWkZ3?=
 =?utf-8?B?UXp1Slc5L3M4Q29BN0dTcW44OFdBc05jSFNpVGNzQ2tTdnI2MFliSk02Y2xl?=
 =?utf-8?B?N1dCQTNrUzRZTU1EZEVpengrVTR1blJlSm5uMTUyRE0yU2VFZk9jajQ0OGNY?=
 =?utf-8?B?U09Lb2ZyclVHaTUxWjgxeWZsbmxmZFJBRVdobWUxODVUdGJCeS92ckw2Rjlt?=
 =?utf-8?B?T1VsbTFicHZBUmxlelBZY2RhUG42My80Q0t4eGMvZnZJa1hoWWlxN3dKWGxM?=
 =?utf-8?B?TGpScmliUkhPVUwyQWJpSUxjUjkxcEdPdmlZWnBYbWFpWnBLS2JQL1hKTEps?=
 =?utf-8?B?QytZWGM3RmxPRUVuR2YrVUdEbHFZMWNRcmVsK3c5Wk9TM21MZllpQ0NQOVM2?=
 =?utf-8?B?K3Y2SlhjckJCMk0xNGRnYmtLMFUwbDhpem0vY0tubGdjRmpLb1VyT2tqTk40?=
 =?utf-8?B?TDNIbTFmRFhKK1o2MlM2K0RSSXF4S29lNHJ4VXMrYW9IRGJ1cFNXZDIvWlZu?=
 =?utf-8?B?aWhKMTFNaERhc2VlcFJWQi9kT1h3M1NkM2cvTHdsYTVySk5ZbkZxZ0Z6WmQz?=
 =?utf-8?B?aGU2LzdGUFBYUGpBWVQvOGpkOUdLUTBoVzNvMU5DR3JHbmd3Zks5WGVSTmg0?=
 =?utf-8?B?SUJtM2lTL0MrTGU5VWovK0xRYXFYek9KZmF5OFdCcmwzeDd1WEJPL1Y5Sm9s?=
 =?utf-8?B?ZHJabVhaTS9JQzY0bG5selNhT2Rlem56SWI4QVlLMmhOYncvQmRraW9zK01T?=
 =?utf-8?B?by9WRmlDYW43ZzRPQStZOFBqV0lCdFhuVWt5SXRXQmNyalV1c3B4MzhScE5F?=
 =?utf-8?Q?dr4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edab3fdd-0c76-44df-547b-08dcd7156e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:37:02.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWamb+IDO1a8zmRmRoYt5Ty6Z3R6DavUFJs0bPusNwxoGV3O7ZESBGEOupqrCwvjhP//Tf88PjGBybkLT3cS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10878

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcG06IGNwdXBvd2VyOiBiZW5jaDogcHJpbnQgcGF0
aCBmb3BlbiBmYWlsZWQNCj4gDQo+IE9uIDkvMTEvMjQgMTk6MzgsIFBlbmcgRmFuIChPU1MpIHdy
b3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gUHJp
bnQgb3V0IHRoZSBjb25maWcgZmlsZSBwYXRoIHdoZW4gZm9wZW4gZmFpbGVkLiBJdCB3aWxsIGJl
IGVhc3kgZm9yDQo+ID4gdXNlcnMgdG8ga25vdyB3aGVyZSB0byBjcmVhdGUgdGhlIGZpbGUuDQo+
IA0KPiBTZW5kIHRoZXNlIHR3byBwYXRjaGVzIGFzIGEgc2VyaWVzIHdpdGggYSBjb3ZlciBsZXR0
ZXIuDQo+IA0KPiBBbHNvIHdoYXQgaXMgY2hhbmdpbmcgLSB5b3UgY2FuIGluY2x1ZGUgd2hhdCBj
aGFuZ2U6IHVzZSB0aGUgc2FtZQ0KPiBzdWJqZWN0IGxpbmUgaW4gaGVyZS4NCj4gDQo+IFRoZSBz
dWJqZWN0IGxpbmUgY2FuIGJlIGltcHJvdmVkIHRvIHNheSBtb3JlIHRoYW4gZm9wZW4oKSBmYWls
ZWQuDQo+IFdoaWNoIGZpbGUgb3BlbiBmYWlsZWQ/DQo+IA0KPiBUaGUgbWVzc2FnZSBjYW4gYmUg
aW5mb3JtYXRpdmUgYWJvdXQgd2hpY2ggZmlsZToNCj4gICBhYm91dCB3aGljaCBmaWxlLg0KPiAN
Cj4gZS5nOiBwbTogY3B1cG93ZXI6IGJlbmNoOiBwcmludCBjb25maWcgZmlsZSBwYXRoIHdoZW4g
b3BlbiBmYWlscw0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmVuY2gvcGFy
c2UuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNo
L3BhcnNlLmMNCj4gPiBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JlbmNoL3BhcnNlLmMNCj4gPiBp
bmRleCBlNjNkYzExZmEzYTUuLjM2NmIyMGY5ZGRmMSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9w
b3dlci9jcHVwb3dlci9iZW5jaC9wYXJzZS5jDQo+ID4gKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93
ZXIvYmVuY2gvcGFyc2UuYw0KPiA+IEBAIC0xNjYsNyArMTY2LDcgQEAgaW50IHByZXBhcmVfY29u
ZmlnKGNvbnN0IGNoYXIgKnBhdGgsIHN0cnVjdA0KPiBjb25maWcgKmNvbmZpZykNCj4gPiAgIAlj
b25maWdmaWxlID0gZm9wZW4ocGF0aCwgInIiKTsNCj4gPiAgIAlpZiAoY29uZmlnZmlsZSA9PSBO
VUxMKSB7DQo+ID4gICAJCXBlcnJvcigiZm9wZW4iKTsNCj4gPiAtCQlmcHJpbnRmKHN0ZGVyciwg
ImVycm9yOiB1bmFibGUgdG8gcmVhZCBjb25maWdmaWxlXG4iKTsNCj4gPiArCQlmcHJpbnRmKHN0
ZGVyciwgImVycm9yOiB1bmFibGUgdG8gcmVhZCBjb25maWdmaWxlOiAlc1xuIiwNCj4gcGF0aCk7
DQo+IA0KPiBXaGlsZSB5b3UgYXJlIGF0IGl0LCBmaXggaXQgdG8gdXNlIHN0cmVycm9yKCkgaW5z
dGVhZCBvZiBjYWxsaW5nIHBlcnJvcigpDQo+IGZvbGxvd2VkIGJ5IGZwcmludGYoKS4NCg0KU2Vl
bXMgdGhlIHVzYWdlIG9mIHBlcnJvciBpcyBpbiB0aGUgd2hvbGUgZmlsZS4gQ291bGQgdGhlIGNv
bnZlcnNpb24NCnRvIHN0ZXJyb3IoKSBiZSBkb25lIGluIGEgc2VwYXJhdGUgcGF0Y2g/DQoNClRo
YW5rcywNClBlbmcuDQoNCj4gDQo+IA0KPiA+ICAgCQlmcmVlKGNvbmZpZyk7DQo+ID4gICAJCXJl
dHVybiAxOw0KPiA+ICAgCX0NCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg==

