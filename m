Return-Path: <linux-pm+bounces-2356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440018322FB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 02:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79423B22350
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0522FECF;
	Fri, 19 Jan 2024 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WBeew6ce"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B3ECE
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627916; cv=fail; b=iBxm7BEoa85P+GCualkZK30dGoVm5/oAdTK6S3inci0SImGb31XEicW1YSEJUhMVeSJILyv4gHqW3ohnEZw8pHVUjoJceHd1eGgkSaIY9aRv4V+0N9KmYCRI4lQVeGm2jsvMPCKuBda5dn0MsjwNEbuXz+Orf+uAXZq+i8OHXGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627916; c=relaxed/simple;
	bh=LkibhIYnWTp4u3Na+KZj+piDdA/NgjYTBGfrKyb2Wac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHieGCB3QfUn6mbZZv1mx3S1XIJ3JuSLILqSxcMWKc2U6VA6fnYRK18sgPHMweCs5udxrV2tlrvIU8G1rPikL/Nfxa6s1nyLZj4xlmMxSqeoMwXTPDRj/WqvPVORJveEy2bN4434vH122E/cdi6f1Rua5qjno/rkOiaFXSn48So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WBeew6ce; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY+NaxQnVHmXdgIUdW0g4Yq+wssS2wz2DANXPbRH7WLibBf7u5wyfl0znwkoP17Ol/oY98K6UW2tGQ1F0AtSHPzW0rRpAQALrUys+y7PTsbJx5p0FAtn1V+2fhSr/kKPr6eEtrNDxEXucE8aHe+Arp61sc+K9qriRC9wl+4LrAn4qg7Wi0lMYJfdZVxuGgb6/JGYQXBEoZquZROFFlWDJNS1PyS/3KUOG0+ZekGOeALGvYGx1sv9CVuxge55O98MFJOIACgDGjVteMXXWcCYgnuVKjz0XMmthGJ9OYAcwPF+/+oe7gj4Qh9jz1/Rv+E4k/4kuFgMHxzlmUbREqUdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkibhIYnWTp4u3Na+KZj+piDdA/NgjYTBGfrKyb2Wac=;
 b=RA4i0n04sl3Pr0hUPMapqeQYlNhYV8d0c6Xa72GIAPOacizky4Ll8gI/jkbDQEq6oDnHDaZdj1wNA/CPfBycXArDkH14liCdNW0ZxIDFKQ1ucar4Ta6+PBvYN6iYaDXokwWqwY18tbWqlUD3MPjZG+7PqqJ/m5GfhYi9IgfEqZJytFDUcDkz6cQn0Yug0kngJ7gCXzYDM5hT7i/k5DblvI0WozUQK+8XaJsFkVsPhu0/52tqT+V3divOskF9M+pqZ1EWfb82ffBkWJjHcdodFUrPEAg7EYSCVh3TZL0eQ6yI7/oFJMfmwDtAD6XpOJ+aS4m3RbK4vFDy0jKw5jDHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkibhIYnWTp4u3Na+KZj+piDdA/NgjYTBGfrKyb2Wac=;
 b=WBeew6ceaVMe+4SwRaJGHlZqQlJU3sQ58EcrSk+M6wK2lE2YO+fFYOM1qQKHS+6KNpn2LRUHXODN6bdfaV+zjyIqnt+TlaLVaKsq7tejL2sblquSAvhU60XeoSknQgte8VNIwcswmWB9Yo0sW4nXrwLDLfwtBzoM7J36XfodLPY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:31:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 01:31:51 +0000
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
Subject: RE: [PATCH] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out if
 domains are missing in DT
Thread-Topic: [PATCH] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out if
 domains are missing in DT
Thread-Index: AQHaSkJWpubcljYIPU+yKO4gB8uQtrDgWZOg
Date: Fri, 19 Jan 2024 01:31:51 +0000
Message-ID:
 <DU0PR04MB941707AF8D5A2261CAB4189488702@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240118191235.145549-1-marex@denx.de>
In-Reply-To: <20240118191235.145549-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8955:EE_
x-ms-office365-filtering-correlation-id: 1c2b721d-fdd2-4b52-3088-08dc188e6988
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xG5fme1AGcmzB2Jc19JlAbgyjZ5ogbA/xb6jCrBiJfOBzDuOAcCvPEqgdg2RM5Sd0s/vq+A7BHO1UFS+pQvtSeYHO/9uLR6ZliQGkBEz+j+y/FLtvS67FGQ9aASPby/U2hcFYOZAKvRjMFDRXEtXiihHhVf/mcUKBIe/tSh090em02+XNCgHNuhQ47U6ONGlc/7Auhhj0YYSfr0/3TfxrSUa7LQR0DedW/NhI3Ky2b+lCW+z1vk3QfbYdF+7v0RxATwf33zsJ0uWGfyXKJRZTbb1LyaHUxa+J3ITzPIpvuj8w66hMlcGJLk4yMpYlas07cf9KM4dpaVM05rfF2WmCQF5pSNistt0PBMbcpwoK2SpQ40qb0XI4REkTRWN3PWh2itxU4PyhByePkTIva+7FRQ+FyZ1EOoWhcXM2SgC4w0Gkpog2Gj84OlZmDotgB77tLJh7Eczf5jWziaYSlSRbmxfBX0jrBgZvo82fNB+jCwg4VTd7BAqjgdbIpmcusJPWLiBTq+Clb0DE6cQicxGb4WYvLjyzNDwp6yuOC5bIV6tS241DyAUQuVtoMVAwWvLdjMT0RkovMI6gGSxuPA4C74eDmptrvOm7SE3LJQtrGP1k+H9qPDBtKBWKkba49F1bRqyhRn9tksaaoBk6G6gtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(7696005)(478600001)(6506007)(71200400001)(9686003)(83380400001)(4326008)(66574015)(5660300002)(41300700001)(2906002)(44832011)(52536014)(7416002)(110136005)(8936002)(64756008)(66476007)(66946007)(54906003)(316002)(76116006)(66556008)(66446008)(8676002)(33656002)(86362001)(38100700002)(122000001)(38070700009)(26005)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sjk1Mm90c1ZyU2Z1UG5UUkZTeGRRMmxkZWNBdEtKb3BNRG9pZ1phUWRlaWM5?=
 =?utf-8?B?emd6TTd4VmhXT2tLV0VTYmw3Y1VLOGxUNzV4d0ZWMENUWVdObVJocVZsQVQv?=
 =?utf-8?B?eEo0enpGZEZJbHhvTDl2SzBIK2hhWklRdElGUVJvMDNyejZHMjRHR3R4YnRX?=
 =?utf-8?B?emV0YTVVL21lZk13UThvTllITDduTkdxMVFjQ25yNlF2cEd3YzdhVXR3VEE4?=
 =?utf-8?B?LzQrdGpsZ0d6Wkc0MkFHSVVBL1kxNWI0SXlXdEZLcmZYTHhydy9iNFlZTTlQ?=
 =?utf-8?B?cDI0eHhWSm9BNEZ5dU5XazE5anlyT28xaXJ4Q3U5NzFuaGMrSDJReE85Q3NN?=
 =?utf-8?B?Rjc3S1cyeElFcWplTUpuL1diR1NJWTVnVGlMWTJBekZMOFUvNGp3L3JxeTVP?=
 =?utf-8?B?VERXbGhKdmhsS3dWd2FISG13Qkk4NzY1L1hFYnMrWUd3Ni9VV1BFWWNhdzdU?=
 =?utf-8?B?VzRkUWhLcm5IbzQyTkVrRzNTUW5VM2htd0JGT0NDVVNBK29SQ2V0M1RBNTFt?=
 =?utf-8?B?WlpLelVueldqaWxRM0JlVjFFRkpxTnN1SUJBV3F0dDNHTDd1TzNreEZabGNz?=
 =?utf-8?B?elJURHJqNCs4Mi9WKzA5bHhnUVREb0N2LzNlYjlTbVpYSUVrYWdpWjc5WXpR?=
 =?utf-8?B?MGRVWm5YRHFhWm9ONU80cUp3MlM3MFExRlhxT1NDaVFDL0FNSmg3dFpicEd3?=
 =?utf-8?B?WklYNktHSWVITFRRWnIwYWxvTUZmMVJUQmE2bHljRmN4MUR2dHFrbzd1UFJt?=
 =?utf-8?B?aGFtcFFhWHFYYXNrQk9PdkFCSVJJRXByV1BSSFZGODNaOTIxWnd4ZjkyaE52?=
 =?utf-8?B?NHlSbEF0bWlQY25zYnlVV3JpQVh5bHNWZWhmV0VpbHdPYTBUVzZYR204ZUxC?=
 =?utf-8?B?K0lndnJBSmprL2ZYc21ZenpvVzJDYnJZbE53UDJ4ZVFtNkNCaHpiWHl3bHRk?=
 =?utf-8?B?TWtXc2dJWUJOcVNBMGs2Ymw0eTAzT0F5dE1jSC9QY2pJNHhzYzh1eGRiT2h6?=
 =?utf-8?B?SU1iUjBuY2QzMGtrYzdnc25BMlFjdkd4SC9RWWt0Tk5ndFE1S3I2bTYwdjha?=
 =?utf-8?B?T2NxL0ViWGszMGQvYUhQNzV1ckRlWlF4VDJQT3c5L0JtWWxPRGg0dVN3R3JG?=
 =?utf-8?B?M0d2ZkJpMG15RVlNcWhDR25vNHN1MlJIcTVwZkZ6ZXdXZmNsR0NGU2h5WnF2?=
 =?utf-8?B?eW9rc2laVXFuN0l2NUJySk4xTlRIM3Z6aSt5bHVWb01wTUZabWNCVzZNVGgx?=
 =?utf-8?B?KzgvUXpqNWg2eVF0NFdYK1luTXRPVEY0VlhKR0pBODJpOEp0U2w2em5zV0cx?=
 =?utf-8?B?SzZPMDJtKzVMbXZMWU1wUHZjWXN5emFqLzRRZUxIamVLS1JROGhVWXZuVXBk?=
 =?utf-8?B?Y2U3bzhXdHIyQ2lkeUgrbHg5dVpuT1pIelE1b3c1RlNGb0lpNFpMZmpmRVM0?=
 =?utf-8?B?VXg3T1Q0ZFlWSkd1bjhvRDhVU0Nxb2hQRWk2TlJzZWtuOGYwRitaeDhXUldI?=
 =?utf-8?B?WTUrYURhV1lPMWZsdzd1NVkwTVdnelpvTTRVVUpQaDhhT1NSMjBEamkyaEFh?=
 =?utf-8?B?VFVJNW85ZG04QzdpNWVMbGMyTE5nL0RMMmNjRlR4V2dwbzhTWTM4R09CaFBq?=
 =?utf-8?B?aVh5b1lBUzlDMW4vR295S20xUVhWeVdlWllVa0ZKWVJlUks5TXE1TnhOMndn?=
 =?utf-8?B?TCsrNWZGaWpQV1hVQ0pYTkdGZ0ZkV0paV1NqYmpRYTJIK1hCZnJtZEphcTEv?=
 =?utf-8?B?Vk00cnlReG9KczlGd3d6WWZEOTFGRDF3RXRwZVZZZDY5RjFvelcyY1pKSTdP?=
 =?utf-8?B?c28raW9Kc1BreUJqZXJSam9EYTl1dWRmOGhVNGFYSythOVh5YlZBU0VvVUtx?=
 =?utf-8?B?bDJNV1Nmb0RqUDlQZjNWVHhnTUYwb213MUZ4V0QrOXdvZlJDemJQUkxxVDlU?=
 =?utf-8?B?ZEs2TWdybTNtNmVNRDJibUlaaVR5Z0cwUmV2TVdsSjFQdzV0TFQ4S0NjWk85?=
 =?utf-8?B?Zy80Nmxza2g1ZzRiRlE5ODNrZmEwVW8yUllWVm1yMzF6RGsvN0poNlBYTU4z?=
 =?utf-8?B?ZkxiMFRkbVlaMnRVS2lBODJTQkFhc0JRSEJBajh1MndKOUVSbW5PemZVN1hS?=
 =?utf-8?Q?P0cM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2b721d-fdd2-4b52-3088-08dc188e6988
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 01:31:51.4312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnlqrdeyVntY/b9W2VBAxUb4HGFjO5aFREh4bLCF/U6hMCaiVPb3QGSquwtm7Z4zU23oJG58v+hVPdLLRs0gzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

PiBTdWJqZWN0OiBbUEFUQ0hdIHBtZG9tYWluOiBpbXg4bS1ibGstY3RybDogaW14OG1wLWJsay1j
dHJsOiBFcnJvciBvdXQgaWYNCj4gZG9tYWlucyBhcmUgbWlzc2luZyBpbiBEVA0KPiANCj4gVGhp
cyBkcml2ZXIgYXNzdW1lcyB0aGF0IGRvbWFpbi0+cG93ZXJfZGV2IGlzIG5vbi1OVUxMIGluIGl0
cw0KPiBzdXNwZW5kL3Jlc3VtZSBwYXRoLiBUaGUgYXNzdW1wdGlvbiBpcyB2YWxpZCwgc2luY2Ug
YWxsIHRoZSBkZXZpY2VzIHRoYXQgYXJlDQo+IGJlaW5nIGxvb2tlZCB1cCBoZXJlIHNob3VsZCBi
ZSBkZXNjcmliZWQgaW4gRFQuIEluIGNhc2UgdGhleSBhcmUgbm90DQo+IGRlc2NyaWJlZCBpbiBE
VCwgYmVhdXNlIHRoZSBEVCBpcyBmYXVsdHksIHN1c3BlbmQvcmVzdW1lIGF0dGVtcHQgd291bGQN
Cj4gdHJpZ2dlciBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IFRvIGF2b2lkIHRoaXMgZmFp
bHVyZSwgY2hlY2sgd2hldGhlciB0aGUgcG93ZXJfZGV2IGFzc2lnbm1lbnQgaXMgbm90IE5VTEwN
Cj4gcmlnaHQgYXdheSBpbiBwcm9iZSBjYWxsYmFjayBhbmQgZmFpbCBlYXJseSBpZiBpdCBpcy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiAtLS0N
Cj4gQ2M6ICJVd2UgS2xlaW5lLUvDtm5pZyIgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZT4NCj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gQ2M6IEppbmRv
bmcgWXVlIDxqaW5kb25nLnl1ZUBueHAuY29tPg0KPiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU+DQo+IENjOiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4
LmRlPg0KPiBDYzogTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPg0KPiBDYzogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1
dHJvbml4LmRlPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBDYzog
VWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0K
PiAtLS0NCj4gIGRyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJsLmMgIHwgMiArLQ0K
PiBkcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYyB8IDIgKy0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJsLmMNCj4gYi9kcml2ZXJz
L3BtZG9tYWluL2lteC9pbXg4bS1ibGstY3RybC5jDQo+IGluZGV4IDEzNDFhNzA3ZjYxYmMuLjFi
ODNjOWMyZDViNzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJs
ay1jdHJsLmMNCj4gKysrIGIvZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OG0tYmxrLWN0cmwuYw0K
PiBAQCAtMjU4LDcgKzI1OCw3IEBAIHN0YXRpYyBpbnQgaW14OG1fYmxrX2N0cmxfcHJvYmUoc3Ry
dWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAJCWRvbWFpbi0+cG93ZXJfZGV2
ID0NCj4gIAkJCWRldl9wbV9kb21haW5fYXR0YWNoX2J5X25hbWUoZGV2LCBkYXRhLQ0KPiA+Z3Bj
X25hbWUpOw0KPiAtCQlpZiAoSVNfRVJSKGRvbWFpbi0+cG93ZXJfZGV2KSkgew0KPiArCQlpZiAo
SVNfRVJSX09SX05VTEwoZG9tYWluLT5wb3dlcl9kZXYpKSB7DQoNClRoZSByZXQgPSBQVFJfRVJS
KGRvbWFpbi0+cG93ZXJfZGV2KSB3aWxsIG1ha2UgdGhlIHByb2JlIHJldHVybg0Kc3VjY2VzcyBp
ZiBkb21haW4tPnBvd2VyX2RldiBpcyBOVUxMLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0KPiAgCQkJ
ZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZG9tYWluLT5wb3dlcl9kZXYpLA0KPiAgCQkJCSAg
ICAgICJmYWlsZWQgdG8gYXR0YWNoIHBvd2VyIGRvbWFpbg0KPiBcIiVzXCJcbiIsDQo+ICAJCQkJ
ICAgICAgZGF0YS0+Z3BjX25hbWUpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbWRvbWFpbi9p
bXgvaW14OG1wLWJsay1jdHJsLmMNCj4gYi9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxr
LWN0cmwuYw0KPiBpbmRleCBlMzIwM2ViNmEwMjI5Li4zZDY4ODhhZmI0MTZjIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYw0KPiArKysgYi9kcml2
ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYw0KPiBAQCAtNjg3LDcgKzY4Nyw3IEBA
IHN0YXRpYyBpbnQgaW14OG1wX2Jsa19jdHJsX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+IA0KPiAgCQlkb21haW4tPnBvd2VyX2RldiA9DQo+ICAJCQlkZXZfcG1fZG9t
YWluX2F0dGFjaF9ieV9uYW1lKGRldiwgZGF0YS0NCj4gPmdwY19uYW1lKTsNCj4gLQkJaWYgKElT
X0VSUihkb21haW4tPnBvd2VyX2RldikpIHsNCj4gKwkJaWYgKElTX0VSUl9PUl9OVUxMKGRvbWFp
bi0+cG93ZXJfZGV2KSkgew0KPiAgCQkJZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZG9tYWlu
LT5wb3dlcl9kZXYpLA0KPiAgCQkJCSAgICAgICJmYWlsZWQgdG8gYXR0YWNoIHBvd2VyIGRvbWFp
biAlc1xuIiwNCj4gIAkJCQkgICAgICBkYXRhLT5ncGNfbmFtZSk7DQo+IC0tDQo+IDIuNDMuMA0K
DQo=

