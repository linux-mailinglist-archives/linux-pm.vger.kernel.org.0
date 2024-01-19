Return-Path: <linux-pm+bounces-2358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FB83232E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 02:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898C11F214A0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94ADECE;
	Fri, 19 Jan 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M4FozWle"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0101391
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629267; cv=fail; b=osf0MW8J7zPqB3LZN7FoKrnXVsvoCxLhtU1KMim3gvRIcpJPkEDci0fgzOyX8BKjFIKPg8+gr29pCv8DekE185kO+08lDyDxLaBh6S2VLxkcumDglrUh7ZrrT+jKHUmGUWStRFjzbnv+IiU+vQPUhpoB7ThdNm7DkmIYTKIHgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629267; c=relaxed/simple;
	bh=U756TuOTXWuBsDq9qI4+Ny6Y/WmSt594G+uBqbQGiDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9/XrEOM+qaiu1/3pocWW2lem6R8R8KGLET/pvUUKw6gwuj3qLDQi6Nyd3qmAoxiZXMt685yijTkEBAaPywtMH3SrrQTr7e68XwLIn+CVKhuCSchQnUA+k9byb6YVHXmh2OJ0ddRfe+/Kk1npWuqxyOD8MMuN+NJiczbuIgvfcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M4FozWle; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA+vKBjifhTsrPXXkWAX5SPHg3y+t0l/zM0yRe2LLvyTElG5EDsrt+ZvYgrrSNUFxcmwUjeUdIa4GptszV1/GgAxIE96uQCMj8HM1QuocYC7hcIkMElGEq/mjL6lrw6AKnNm6kS4jDlXlFlCRoU+Q/Wlaoc9DzONfuqGniewd+OmplW5KujVdI/8GN0cX6U3O5QMBGoRDhGaU2Td87btS/kexjZonuRgWAbb09M4t6An2MPvbI60iozQn7YbVeCkV1fosbticFo3LETPL8n8FTKyun6Maq7+AIe6NlqIrgLiR9UXTBbZbcdhH0jzHsRNXi9Bt7VsJMmDjpLIQM11/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U756TuOTXWuBsDq9qI4+Ny6Y/WmSt594G+uBqbQGiDg=;
 b=KRdJBluAydUCAxiC+LuOcy7HvBjFnmGiK7hKdvH3dkjCgleC3aKwc7qIQd8wPVGHk2Rwp9tHhi8kp6OwntUx2dBq9xhKvDhD4FEQ7sxWmi6yRF9xgJ9xyKwIJ8frVMO5EXYTfqMUUo6lREOKlKngRoHE0RxfMXOlW01moTWPrfqADZw+PwHalWRVfJr27fd3LvB0wBVMRpzpz4tz+RULLedgwI/MxUMypXBFo3sho6UfuYjEbLSPxDNrdP8FovMJqZvJTp/QEqPp84cm8zHmi+BfwYINpFJ/bVnKjoAufxDcDKR+ec7HMCt1VTMGh5vBscWxm1WL8jSDcty8f8yyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U756TuOTXWuBsDq9qI4+Ny6Y/WmSt594G+uBqbQGiDg=;
 b=M4FozWleddBQ4tHYA4rWQwguxfmu1fc7S4ph9bvNAKVvUSj/u5MjTA/Q5FRIXnYOXFZ58oBfdQLzCcWtKJclJt5ptct9JfV+rAr+aUap67Y6EekAbAzCQ/Jm9UQs3YGtM/yFX0axArMlVx1KXKco3zFQgxpxSvaiq42EUq8aXTw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:54:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 01:54:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jindong Yue <jindong.yue@nxp.com>, Lucas
 Stach <l.stach@pengutronix.de>, Marco Felsch <m.felsch@pengutronix.de>,
	dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out
 if domains are missing in DT
Thread-Topic: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out
 if domains are missing in DT
Thread-Index: AQHaSnmU8eYWZGwFB0KubseBuTtBKrDgX8jw
Date: Fri, 19 Jan 2024 01:54:22 +0000
Message-ID:
 <DU0PR04MB94178F47DF4B40C010C44A7288702@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240119014807.268694-1-marex@denx.de>
In-Reply-To: <20240119014807.268694-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8164:EE_
x-ms-office365-filtering-correlation-id: cc72f9ed-bcf9-421d-5be0-08dc18918e9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YuXfqvygx7HtDJhHGP2qe2fJfPhzh7zxz/7B0beupuY4hTYAqEzAmeIy6YlIL5sToZpd2VQCqVWjhTfXrr4P3MmXjfq7mytI6Grnd+zCR240+E57n+N3S/GmRGV3rZdiCc4QEJ7j8hPb5moCqjYhEkPGBeiXRR0oP7jqzvH+So1Sx63HGJ7AjXrK0+QcHeUJiPykHsHyFucBizULj1IMRPnFaNC4IUFbNi4MJNUYItgnhxrLPCtfypz8xsSE0zjsMJzPZM1rLRa/y6GlGaHMPYi8/9GWNfFbBq3N6pLTgMhlWYcTqhQBKprqMsFs1nU++kYD3470iD7Se4IJmat/E2O9ugxEXUosEBF6ikgAvxP8C0YJrBxUXljItm4QZ4L+4yxc9qzacx1FtVd/GLgV5qC/aWVEghkip6uqphGcwpa/2MJaVdXrph0zhaTOQaXBID1vbr/KzejEquAwl+SlxHNahDFYmuqCZ/+BrxlgzStbzN8MjDK2aJgr4fMmncxgeXdyKxINoJ/tBxUe3bhjnkM3CBrv1Q+0p4qk1V7EtgbEYSF4dhY1NosRnhd4WlrQgVdiP9zwxH0n5soQM3qTelJNpSKLT3v79igtpacNWnWiRdgkk2ilESu8USsaANn0QmiVKM2J7u6Mo5OnVdAmfA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66574015)(26005)(83380400001)(9686003)(6506007)(7696005)(54906003)(122000001)(38100700002)(7416002)(8676002)(4326008)(110136005)(5660300002)(44832011)(8936002)(52536014)(478600001)(71200400001)(2906002)(316002)(66446008)(64756008)(66946007)(66556008)(76116006)(66476007)(86362001)(38070700009)(33656002)(55016003)(41300700001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjlqSEtZczlKRlNDcVdGMFdab2YvOHJhVGlhME45Mjh4Tk9rQSt4UFBGWWNV?=
 =?utf-8?B?eWowTWNxUUxMaWdVQ0ZINTRFcVZGbERYbzNMRndmeXV5ajd1SzU0d20vUWZF?=
 =?utf-8?B?WkVrMkFLZjl6WVFNbTVnbVk5RWRpZUlDc2dJNkNQa0swa1ljTFVvaFN1S3pE?=
 =?utf-8?B?U2dnSnJ2SUhjUHZ2RklNWVQ2M2Q2SGxaSkhMMlVFQnhwa3RjQmtnSzhrZzF2?=
 =?utf-8?B?dzRpaHJ6aXdjVzVDR3Q2alFKWHd2d0c1a012cWpld3JVajNZWlJKc0FQVlhn?=
 =?utf-8?B?SmFXVWVFT1E2MGIxcVNBd0ZkcjgzZDJQQXl3MEJMa2MrbXg1NHV3eEY0aWw4?=
 =?utf-8?B?WDFlQ29HeG1lZVhleUFNNUJIRzRUeS9TS1lsczkrZHMwOFdpSFNGN2tlQTdC?=
 =?utf-8?B?bkFsbU83UE9MV3Z2NmZRVGZucGlyaDlRRUtqc292anhYWkpJeC9vTVpYVXdZ?=
 =?utf-8?B?TUkyaHF0aGs0L3JxZTM3bVA3alpJTytyNlJzd3dtdUc5Tk5uQzE4T1dQUWcw?=
 =?utf-8?B?TnQ1NW9rMFdqVERSKzhvb1ZlSVM3YnJURnF5bVA3eVpvN2g1VXBBL3Y1VERL?=
 =?utf-8?B?T043WHZJY0pUVDBubTFoYXRjQzBJSkdRVDJMN2lrUzB3QTdzNjE5TFlnSVpP?=
 =?utf-8?B?U2dOdnhNaUFQOUpSMU5ZMmhXQ2l1RVg1SG4zTjQxWUdiR0ViNERVRWdDMjFV?=
 =?utf-8?B?ZnlmcS9WTDhTbkRpbXFVQjZvN2JkV2pNYnAwemVTaGZiYU1XeTlLSGp0TjJl?=
 =?utf-8?B?eGZYV3FGNkdmN3ZNbWZpQWs3WlhYeWM0MzhpcEZBVGNyc3l3N0hNckI4WmR4?=
 =?utf-8?B?Y2ZGVmdyeUR4QXE0UFlXL1cxWGJISmtHeHVtZ0E5QWhiNWIvL28yRjRoUWVK?=
 =?utf-8?B?ZTBNZnExK25YSEV6RXRqbXZZdVZKUXFza2w0K0lqNkRtMjJhMXJCM1RTemtZ?=
 =?utf-8?B?WlpGa0JJUUtmcTJtcFhMVitJN0hFUWs3dmVmb2p3bFpyakRIQ0hHb3k3UUhE?=
 =?utf-8?B?TDZRUnZ5alpaRzdJU1lKTnpheHN0c3lhTXJ1L084ejdZOGltTXVLVG5GbmpI?=
 =?utf-8?B?dlhlZ3cySUpZa2piMkRCeFBpcElROGpYZ0swLy80dkJqY1A0Ti9TaGlSYkE4?=
 =?utf-8?B?OG13R2F2RWVWZm5NVnJjaldnTk1MQ2gzL2dHUHBvekdpVUVRMkh2dVVQN2Q5?=
 =?utf-8?B?cUZtTFZoMWVMV3hxZnI5NTg5YVhDU1BqUTlFNkNvUlBIdjNvRGh3UEt4VFNO?=
 =?utf-8?B?V296RG11K3pYL0xrSWJwUTJDejM2ZkFiMU1teldkbXM0MFBveDlBUmFUd2Vk?=
 =?utf-8?B?ckR4UDRvcWh2a0ZtemVpOXAzUU5FRGx2aVlNMTBMaTAwQ3VndHYvTElhVHZC?=
 =?utf-8?B?S2pmanByRHNrV29idTNTS216TGZoK3U1c3JtMFV4Q0ExbDVGVCtHd3dZaU5z?=
 =?utf-8?B?b0Nxa2NObis2VmZid3JURVBFa1hZdkFwdmppU1ZnRHlxS0N6bnpQTGZxSnRD?=
 =?utf-8?B?T0h5L2YvT0NSVEkxUkNCb3gvSjlLS1NYeWdQNlQ4YU1zWGMwYXg0VEpPUWhm?=
 =?utf-8?B?MEdWQUpBb3BSTVlSR3RGOURDTTNwYnIwUWl4d0tjcStWMS80eEhvNUtjTmdk?=
 =?utf-8?B?ZVRWaDNNdG9UcnBJN1JSTk1XRUZ0eEdxM202YkFNK281Y0xhYmQyRGhCdWFn?=
 =?utf-8?B?VWFjSjVmU3RnRjJXemsyMFowbWJSWnFvSkRaMXJpblpnUHBUMzk5Vkx2anNz?=
 =?utf-8?B?UnVZM0FkcDdEVGM5UzNGYy9BY2lXaXF6Tm5ab2JORnYxdGtpajkzOHQrczZo?=
 =?utf-8?B?OUJkMG1GR2VFMmRaQmJNQUR6cjJXS2FPS2Q3NXNENGY5b3QxNWRMZWJjYXUw?=
 =?utf-8?B?eEdUZllKeHNrNjdYNGhwMGtaWithZGhxTWVCQm16cUxwRStIdm1zWUVNeE9p?=
 =?utf-8?B?cS9yQWdJSDNjNTM5R2dqa25uSWVzdU1SQytwdW5UTythQldCK01tYTc2UHZY?=
 =?utf-8?B?YTVOaEdCV0hNQ1VEeDFVWlVYYnNHRHhRTDlSZkZOaW5LZ2l6NkVYRUdRNFVY?=
 =?utf-8?B?ZGVpMEtQbjQwS0M0RE1HamlibTFDckUrNTBxSWFVVFdSdithWlBSOTNSUU9W?=
 =?utf-8?Q?9wP8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc72f9ed-bcf9-421d-5be0-08dc18918e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 01:54:22.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1mkIODB+O9XtKKhg989juq/969CKpfYopp+XYTYXrfLA2tOecrj8Yl6QS1Y2v6SfEATT61bO9yLIA+/HabcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHBtZG9tYWluOiBpbXg4bS1ibGstY3RybDogaW14OG1wLWJs
ay1jdHJsOiBFcnJvciBvdXQgaWYNCj4gZG9tYWlucyBhcmUgbWlzc2luZyBpbiBEVA0KPiANCj4g
VGhpcyBkcml2ZXIgYXNzdW1lcyB0aGF0IGRvbWFpbi0+cG93ZXJfZGV2IGlzIG5vbi1OVUxMIGlu
IGl0cw0KPiBzdXNwZW5kL3Jlc3VtZSBwYXRoLiBUaGUgYXNzdW1wdGlvbiBpcyB2YWxpZCwgc2lu
Y2UgYWxsIHRoZSBkZXZpY2VzIHRoYXQgYXJlDQo+IGJlaW5nIGxvb2tlZCB1cCBoZXJlIHNob3Vs
ZCBiZSBkZXNjcmliZWQgaW4gRFQuIEluIGNhc2UgdGhleSBhcmUgbm90DQo+IGRlc2NyaWJlZCBp
biBEVCwgYmVhdXNlIHRoZSBEVCBpcyBmYXVsdHksIHN1c3BlbmQvcmVzdW1lIGF0dGVtcHQgd291
bGQNCj4gdHJpZ2dlciBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IFRvIGF2b2lkIHRoaXMg
ZmFpbHVyZSwgY2hlY2sgd2hldGhlciB0aGUgcG93ZXJfZGV2IGFzc2lnbm1lbnQgaXMgbm90IE5V
TEwNCj4gcmlnaHQgYXdheSBpbiBwcm9iZSBjYWxsYmFjayBhbmQgZmFpbCBlYXJseSBpZiBpdCBp
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KDQpS
ZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBDYzogIlV3
ZSBLbGVpbmUtS8O2bmlnIiA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBDYzog
RmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogSmluZG9uZyBZdWUgPGpp
bmRvbmcueXVlQG54cC5jb20+DQo+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25p
eC5kZT4NCj4gQ2M6IE1hcmNvIEZlbHNjaCA8bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IENj
OiBOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVu
Z3V0cm9uaXguZGU+DQo+IENjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiBW
MjogQWRkIGV4dHJhIGNoZWNrIGZvciBkb21haW4gYmVpbmcgTlVMTCAodGhhbmtzIFBlbmcpDQo+
IC0tLQ0KPiAgZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OG0tYmxrLWN0cmwuYyAgfCA5ICsrKysr
Ky0tLQ0KPiBkcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYyB8IDkgKysrKysr
LS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OG0tYmxrLWN0cmwu
Yw0KPiBiL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJsLmMNCj4gaW5kZXggMTM0
MWE3MDdmNjFiYy4uY2E5NDJkNzkyOWMyYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbWRvbWFp
bi9pbXgvaW14OG0tYmxrLWN0cmwuYw0KPiArKysgYi9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4
bS1ibGstY3RybC5jDQo+IEBAIC0yNTgsMTEgKzI1OCwxNCBAQCBzdGF0aWMgaW50IGlteDhtX2Js
a19jdHJsX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgCQlk
b21haW4tPnBvd2VyX2RldiA9DQo+ICAJCQlkZXZfcG1fZG9tYWluX2F0dGFjaF9ieV9uYW1lKGRl
diwgZGF0YS0NCj4gPmdwY19uYW1lKTsNCj4gLQkJaWYgKElTX0VSUihkb21haW4tPnBvd2VyX2Rl
dikpIHsNCj4gLQkJCWRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRvbWFpbi0+cG93ZXJfZGV2
KSwNCj4gKwkJaWYgKElTX0VSUl9PUl9OVUxMKGRvbWFpbi0+cG93ZXJfZGV2KSkgew0KPiArCQkJ
aWYgKCFkb21haW4tPnBvd2VyX2RldikNCj4gKwkJCQlyZXQgPSAtRU5PREVWOw0KPiArCQkJZWxz
ZQ0KPiArCQkJCXJldCA9IFBUUl9FUlIoZG9tYWluLT5wb3dlcl9kZXYpOw0KPiArCQkJZGV2X2Vy
cl9wcm9iZShkZXYsIHJldCwNCj4gIAkJCQkgICAgICAiZmFpbGVkIHRvIGF0dGFjaCBwb3dlciBk
b21haW4NCj4gXCIlc1wiXG4iLA0KPiAgCQkJCSAgICAgIGRhdGEtPmdwY19uYW1lKTsNCj4gLQkJ
CXJldCA9IFBUUl9FUlIoZG9tYWluLT5wb3dlcl9kZXYpOw0KPiAgCQkJZ290byBjbGVhbnVwX3Bk
czsNCj4gIAkJfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDht
cC1ibGstY3RybC5jDQo+IGIvZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OG1wLWJsay1jdHJsLmMN
Cj4gaW5kZXggZTMyMDNlYjZhMDIyOS4uZTQ4OGNmNzliODAwNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9wbWRvbWFpbi9pbXgvaW14OG1wLWJsay1jdHJsLmMNCj4gKysrIGIvZHJpdmVycy9wbWRv
bWFpbi9pbXgvaW14OG1wLWJsay1jdHJsLmMNCj4gQEAgLTY4NywxMSArNjg3LDE0IEBAIHN0YXRp
YyBpbnQgaW14OG1wX2Jsa19jdHJsX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+IA0KPiAgCQlkb21haW4tPnBvd2VyX2RldiA9DQo+ICAJCQlkZXZfcG1fZG9tYWluX2F0
dGFjaF9ieV9uYW1lKGRldiwgZGF0YS0NCj4gPmdwY19uYW1lKTsNCj4gLQkJaWYgKElTX0VSUihk
b21haW4tPnBvd2VyX2RldikpIHsNCj4gLQkJCWRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRv
bWFpbi0+cG93ZXJfZGV2KSwNCj4gKwkJaWYgKElTX0VSUl9PUl9OVUxMKGRvbWFpbi0+cG93ZXJf
ZGV2KSkgew0KPiArCQkJaWYgKCFkb21haW4tPnBvd2VyX2RldikNCj4gKwkJCQlyZXQgPSAtRU5P
REVWOw0KPiArCQkJZWxzZQ0KPiArCQkJCXJldCA9IFBUUl9FUlIoZG9tYWluLT5wb3dlcl9kZXYp
Ow0KPiArCQkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gIAkJCQkgICAgICAiZmFpbGVkIHRv
IGF0dGFjaCBwb3dlciBkb21haW4gJXNcbiIsDQo+ICAJCQkJICAgICAgZGF0YS0+Z3BjX25hbWUp
Ow0KPiAtCQkJcmV0ID0gUFRSX0VSUihkb21haW4tPnBvd2VyX2Rldik7DQo+ICAJCQlnb3RvIGNs
ZWFudXBfcGRzOw0KPiAgCQl9DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K

