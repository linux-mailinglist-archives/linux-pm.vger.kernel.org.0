Return-Path: <linux-pm+bounces-26276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D653CA9DEB5
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 04:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108321A807E7
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E51F63F9;
	Sun, 27 Apr 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hruYDkNo"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD085661;
	Sun, 27 Apr 2025 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745721741; cv=fail; b=hfuQ0WofcCQ7p924BIQ5OH3G9sn2xNCG2BWKnxkVpCndGrp7m/hVjBDR4XYr1tUYRpnZYsFHANkFUd9tyW3rfg8LJx20KkmQxxA2W/feVbjVgxAxcLUlUkbryINC8E9PAgXN7vcvNfFQlpTPFcD7Lzc+/Rw9C34Txie4N1Zv98k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745721741; c=relaxed/simple;
	bh=iuUVrBBPfIOAtnWj6MHr1rGetB/wX+xR1rq5ui0SOC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gpe9llFuWQlM+gYaN5GyvCF2OzOnC+/S5EsKG3ubebadeTDDKdyEZAzOj89+CUT2gcMXGFm9taNJd2T5actxwEg7LoSIDGzXBKOKxvmh5KuAx5pAlLfCENTwyvjuvIpCYZvw5HsAGjxD7LbcDNq4NqXaR8qHC0TwCsTgItikA2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hruYDkNo; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLVU2pusvntbCHRbJiOwVTGL35NF6srDzSFzSI82lW9XQvCVN1ylMA4TF3H3wqI2DSAJl+wVvBMOxdKiusDnS5jBfldmJUAbBdatb1UqsPC2LAiqxP3bFdfvXom8RTDRSD2uWdybAicAjOQUqHlOZo5CJYSq1Q0ypJR2cfYVypuuVUtlBBadodKMf6OzFUm5AKIgu16GLySDbfSLnvAh6WsGYegAUsz0x4y1YMBDkLOAP8DbN/ducdmomgpZ30BBl0ImBDKy2lYRkuuM1+QbUg3+U2OOurUguftAXWKONmWzkR2lT+A90TuijoWDIqmxyt8Epi4rY0z+YFGtGwMusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuUVrBBPfIOAtnWj6MHr1rGetB/wX+xR1rq5ui0SOC8=;
 b=O7e/hF1bIeTk94FEcCoAuU5+4/f7mNuw6xonRDjRGoE7HTwhoD/enkK9SFqTdGwOVOGlQcvvn+Cnewc6wZBBjt/arDp6i2ANQnejcLeSUqeEi+RzuRJQzWYdDq0Kf6sppn62+cDA/kOUmUVXTvR+1TvJgRj7kaWS6GncRbeIUCGBPw/6xGhTbTR1J+WOOLdf3p7YHhvZ88awXodr1SWIzEWkMexQeQtmq89UkjkgSMGD2gCUE2plnWzMrP+zNAewds3ex/Z/hduLxNuxwSKWJuhDY8WnR9P4oqAOE6CIbFNymBjQbGVN1EG13gtVpFW+MLdvF2T7tU+ktGpHBkgneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuUVrBBPfIOAtnWj6MHr1rGetB/wX+xR1rq5ui0SOC8=;
 b=hruYDkNoaTVzEZ+zHNmbEV6CvfE1DXLiMlGWGgx5t2WhNxJ+6s0DGCYvM39x1JzofAcXLNT9uwg2SKKeHGHfC6+wE1XaZ7AYHchUIsPkMZArtc6Rf7kO6Ar0IowKycVsR5IfSTT1S/AgEq97q9ejYZ/7wyiVUC9nL/FCjox4ZrtdqKoeuMN5bMlxWXK78/kZt+pSOeXVeFbWWW/81g55JGN2QjrFUnfJy1ogCykpkoUL+8pIgrfjNZ/BLj4ZI9dGbrQVc3lUWyFHB1RQaC3f6xsLLRRpmDxH3zE2LIaw5/EsIKjRbJVZuA0mbioyf0f5Qpy6AK4SkXkwX86P7wTuMg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10521.eurprd04.prod.outlook.com (2603:10a6:150:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 02:42:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8678.025; Sun, 27 Apr 2025
 02:42:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pmdomain: core: Convert to device_awake_path()
Thread-Topic: [PATCH] pmdomain: core: Convert to device_awake_path()
Thread-Index: AQHbtdbA6LGDs8aSlUyBabR3oZpxMbO2z+Pg
Date: Sun, 27 Apr 2025 02:42:12 +0000
Message-ID:
 <PAXPR04MB84594A2E80E5BF33C321E94588862@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250425113942.134458-1-ulf.hansson@linaro.org>
In-Reply-To: <20250425113942.134458-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10521:EE_
x-ms-office365-filtering-correlation-id: 7af477cb-323c-4b5c-8f47-08dd85351d5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r/bGpX8heneuhmKovGdThqvjIk3iPMjCK1kMPBDI5XKq2UjmSUmcV7BzdWWa?=
 =?us-ascii?Q?3DTmpb9qSw270MkwN1GDhGrTsUfKHCHEJ+LwfjnxwiqqkOWPHkOAAdibnKkD?=
 =?us-ascii?Q?Na/YCCCfPX/EVqnqHuwpE5T3UiLzVrTX4IhDdASbxtCTqrJ+xxNvhatynCux?=
 =?us-ascii?Q?Ev7gbSo15FkkM8o27300GaLzJpmuV0sLxjY+KiCFhcuVJQuu9In6uN7brpdl?=
 =?us-ascii?Q?DTgFQy6/uz82uuMn7H9W8CCCkK+p5YUjMr2gih3DHMy5QKwiCs+YhtyEWJNs?=
 =?us-ascii?Q?zN+wVS2KIJ4jgGFZl9BVNmQH8mgxTVTKXDDnppAbK+Cd4BPOYHtPkCMHsYe4?=
 =?us-ascii?Q?ZvKHOevtFGVXW6ioK5g9CCyLyLY0yyDul7+uVcA0WI0tgqVcWSeLglKwTFPH?=
 =?us-ascii?Q?w6LA85oOJmEWRvZ6Gi9FPaGxjxBcMY10j4R5GYrrLHe3jMAivfjYLUtF1wP7?=
 =?us-ascii?Q?NVFW3NjobkiCviLyLD4OAXVv1B24dftb0feP9v6IFehq6tdHbyPuyiZq7yqK?=
 =?us-ascii?Q?hRYycTBM92ZjyNsOM1BZHL4oHMTUb7xz+CYlCdfkG8txiHDG46p9QXaBFfu4?=
 =?us-ascii?Q?mBZTjDhk4taQwN0WbqI1ZSXF63eC88xKYHFwKNBaxet53WsVGJtm8zWv04CO?=
 =?us-ascii?Q?AImlGasJ6RMA2IhPO55HIPXjGd/JNO/ffIfljBwxDY0BRqXOTc9TshpP0Lmi?=
 =?us-ascii?Q?aYOlTfCcPkLpsE1bAfkdLJYlXg4SCNztF2xBF+U1uJUmlgz2CH2bOfLRdoKb?=
 =?us-ascii?Q?tk9lL/XC0fM5gaMIPx13pfbqSgbyE2t4vEJuR1/8KFdVfBxdGLHkbCqO8Z4X?=
 =?us-ascii?Q?PyKxURI629p7AiR27KjMQl/IDTaXrEBqkkovVQ6fycRbcQT4NZmGALPmcCAQ?=
 =?us-ascii?Q?v7+QtwAR02ydBbXIQoPmnDr4gJTjaKx0ZOQWVjDQCm0YL3DIqoKdmxrbYiXH?=
 =?us-ascii?Q?UKp3DW4jqc3rHckPAzAlNpejtUEE8/rzOV/5H/bF1sjIUEdbiPMWjp7KMvuk?=
 =?us-ascii?Q?nYXRmU+h2B1CtJj5XgSHf7HuBjxTwnqbIblIkS+r//0UNr2829J7IxWi1Iks?=
 =?us-ascii?Q?07EdlfRPgdtgEv8qV9IaTlckFkZEPKUU1WR6S01H1z71LMDRNbSV8b7NHIYM?=
 =?us-ascii?Q?EMxZLwvjj2pGLnndWm33OY0TL+zwDjqITMVA/lwpWqAlpFM1LVAjQJzgTHpv?=
 =?us-ascii?Q?awIWkwLGaDdIN6LfBDyOXUWt51PeegZD6ty7E3trmk8I2z19muL8/tcBOPpM?=
 =?us-ascii?Q?PEqdf2JfBhAKSQ8i5psxGSYeys37el5IUTMK3l4REi3nw/u6pw7UyoRUczet?=
 =?us-ascii?Q?TcwwnspWK7fcQlahm96b8BVXNnHaF/z0DwjOCFXT+Yi0LA1tbvtuDFg7PI4m?=
 =?us-ascii?Q?PQY2Oi0oiLTmnKgaHVznFkGGDcBbasNyU0W2Fj8MfDXJL/cXcBYZ1BAnxOFr?=
 =?us-ascii?Q?J0yJflVhy7PvRF4wztqeKzc4B9ug3lusGXbc4m6cOrEqs+4Nbj6um1IzQ9JR?=
 =?us-ascii?Q?cf5ep/MgwXneIYI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CMHAzAA1FzwohxgagDEDIQXH5PiWKlAmrQzOE/OxfdTLZernvhPf0hWbbu8A?=
 =?us-ascii?Q?XwnbwanFXZO6DfbmY9npTrWAMGkLOJUSgjBaHyCpoNSpTvi4/dGtK5/i7rSZ?=
 =?us-ascii?Q?LsiLMACSOjLZvCzz6R9bc6c1Dj+i69J5exqYvxVK6rbkB/HvREKjDMMBq6JW?=
 =?us-ascii?Q?NZOwTGPr+y8GUtWGLLO3C48gCH4Y7ZC4qKkkXWx12Jvg9b/2+jzPEtV3sEs2?=
 =?us-ascii?Q?zNq/xZleXEJIVbm4DKvL6cMPXVzF3fIRTXP4LLAD2pzFabPvbSunLkjpAQV/?=
 =?us-ascii?Q?cSqsVdIYcW+SSaE/EGNGrg+QVZkKpMnQNsFB+g9ycrdl3dK2Rc6uIiVqB/fM?=
 =?us-ascii?Q?Qo1QlbDS/PZtczjM3Nfwf6kN5Vtho+p2R+eCE9jzbH8NTv06RZN8TLPbtc/G?=
 =?us-ascii?Q?wZKIVpTlungEMKO181DtxecGnPo6xi+Xu+WJE0Cm8lMRpW+x2RPsBvUtT896?=
 =?us-ascii?Q?8V4MUQL2I9wFjo8Xe50G0uRqeuJTvZPYcXfFY6amfb7588wu3bqdMIagrf57?=
 =?us-ascii?Q?7jUjPP9DlHl50VnomXxSnruenTtgS1BtgzO+xiUq4fjQgP1r/PwbohcTCude?=
 =?us-ascii?Q?swLVOFZKrdN3gF2rTETAoQYWGoQ7n0m74XTOnsJYeOGYtoN/EKq0bxkR0/8l?=
 =?us-ascii?Q?Fh70ZmQ1KTNQcuBVrJtrTdgZ5V39V3DshbvbOGlVR1Hyfgp8yI7clxIIP3/Y?=
 =?us-ascii?Q?RXTM04uDTBFlOrXgAG8s3W/KcngjHqTbOSyqBh6f/vWD97Djud/DR/Vq3v13?=
 =?us-ascii?Q?zDn+/rIzh5TJ4C5BGm4kg+GYKR4f29+vd6CddhTJBY1iq6Rq9reb2QMkQQOC?=
 =?us-ascii?Q?cvHiBJmrsq9XWQKbJz++4xr1VslmIPlt5Tsj9YRI/5djpFFxIhIeNR9dBBKB?=
 =?us-ascii?Q?AZ3SEVYQglfnnKqDSndshy6oIdF6bBGV/oN8HtLoFkIF3EC1nEkpLdbpodDw?=
 =?us-ascii?Q?V/3ugYkDOU1kZuQud6cmxpFxUG5dJlnSwDIiGcQ045f2IlXduIZmpYP5PynE?=
 =?us-ascii?Q?uCG9vcgnb0tHFEcIrJDKmUPggvjoXfW+z5kCBF1aONvJbn/yRx6fN+SFfEj9?=
 =?us-ascii?Q?X8P+n/KOieMnUzHObgKW3E9lXwdOq4X2HogXTd1bsEIiRUQyMR1IwUM1PpZA?=
 =?us-ascii?Q?lkLIREh11EpQ1/LmA6DeZTqH/j/X/uq0rzj8CLYGL5aAeE052R+WrxL+B6iF?=
 =?us-ascii?Q?jpYTTMt0tG4Nbk3aupeTn+64FIamSY/eYO1W6n4fy+W1ZizOTutAAQHdD3Ls?=
 =?us-ascii?Q?Twmd8wOYLX5n0s8U998DvieqY7bhMVKotCZ4ULoxWa4TaWEg91O+NCQqGPeE?=
 =?us-ascii?Q?iS/UrhNRnnIwoNCNnMWaxW1j/AeO6VAtIx0E6S+8pZ5xYFCXCrtBAxD5S+Zv?=
 =?us-ascii?Q?57e3BtJM0ISVQv0KrvxPMvq7s8BoEKSGHHPQk7GOSwz5Szb97wy8b5LfSxM5?=
 =?us-ascii?Q?Javo1vOe9Fqe6wkCmlvaOzIQou5xU7HkgXFqK6HUEx/OgCq+NPvMvSArUPMn?=
 =?us-ascii?Q?c3UxUbhA38pyFtmczNhUvcbFJEcs3v+jntOrhRo4mkiSoEhgDpjvlN4GMpbr?=
 =?us-ascii?Q?u9y8s/WW5Wq1yMtxGvM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af477cb-323c-4b5c-8f47-08dd85351d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 02:42:12.8664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UfP07jyLvODZ1qftLBUTQnws92MESYpN49CghfxAvaM30UtBgrZoGg/YtvCN8H+8OyVNY1k+qPLnIw9vzeYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10521

> Subject: [PATCH] pmdomain: core: Convert to device_awake_path()
>=20
> As device_wakeup_path() is intended to be removed, let's switch to use
> the
> device_awake_path() instead. No functional change.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for Ccing me, I need update patch later.
 "pmdomain: core: Introduce device_set/get_out_band_wakeup() "

For this patch:
Acked-by: Peng Fan <peng.fan@nxp.com>

