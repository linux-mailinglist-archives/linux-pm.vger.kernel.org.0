Return-Path: <linux-pm+bounces-27032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BEDAB2CBC
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C7171F84
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 01:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DC5475E;
	Mon, 12 May 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T5t+El5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011030.outbound.protection.outlook.com [52.103.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF436481DD
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747012665; cv=fail; b=d6btHL711zLn052YFf3wFMkWw25M/n1R01tUFXrUU0w8tzPWf3/jDzsYYkh5X2PnE4O52KRJNkahmxNW4GBfH5BbBK+QFMBNCCtdmAvlWHpy8irNdCaxPUOj244qVJDwaOaOvUY6bx8qkwIAZTnSI+yBvcDcuMQ+ZloaSc9uUPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747012665; c=relaxed/simple;
	bh=W9NzHwN0eI38gYgeM3b7GOExK8T4KyWYdsYxiexIKRU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ULs2uDYggcnyyB9BSBKEu17fEAGIIObxYUPK+Ph3OZL8+HG3r+aLXJ+00W2a0yuOpoEc8pz7vXUMJu4p6Yx45lGGk+Md7eiaKVOrR/vDx7TocZ2FzHhpnw5s2aYdLpHOU0QgwEMz9zGTnafx1yZazDLW5fcuUsYVcCL7Ib3Q1lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T5t+El5u; arc=fail smtp.client-ip=52.103.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2coOBaxXv71lZqtrwMKlVm7kClQ1bA26u5rXgyzSKP7H4ACAWILMVdJlVef9UCovSmyg18GQTAORtQR6v/VjQ3ZDMO6NM5BS5K18JNr2NbD2eTRkDUkRk2V2/6siQe/U+nTkm68gO2RCvGN2shkILJ24Ae8KKQiyYSEIed9bQ+K7jD6YMfJetZqVWspsYA+wrvdBuXIqd0up58Qgma5JEZxBVQdT8US/r8ylkdwXUfjRvslSzd9YF9AcUtd1uP2ZPWk8EPXnUl3T9xOZAbOYPzG4rQggsaANmvRwXrU2OdjPeZCUpQR1oA/tCiuThy5gz8D65CwSxYuUMReHJR3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9NzHwN0eI38gYgeM3b7GOExK8T4KyWYdsYxiexIKRU=;
 b=l45gIIBoc250RWXhXX7fQOF+72LbByy8nClvNTAZxiyJEJxRkUtQCGBiwzI8PzmyGCQwE5yxh0eRHbjEoOclKXSsRTjJBlXoCx7gKy13uRe08BN8MOvFcCTiuea9Z6mkTlfJ55Tpewf5man4xRFi88cIXn257QyyhNPT9GWyStsm2t3Ht1+o1QcOoRxaThxN5bnZrOjOrk9hnmAJa+HSS3Hl+bTpvH8U6iK3LmdGLPo4XDMMl1Xy0HDViLT1W17X/P0eRP+vpBNSPHDtKNQNa8OvO0aTeCgag8wtw7o4EeD8nn0abkpEU99fMC9dXB5aCWjGSc0nBaVxc97MKw59Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9NzHwN0eI38gYgeM3b7GOExK8T4KyWYdsYxiexIKRU=;
 b=T5t+El5u8gAuRmSBVclxW4l0/P+rC+Iz4RuFbc/Br8xK8W+MOUkbGdxY3JLIuQynr1R03F/QDhuECwJdsf2hc0AhxD0Z02dBCkzXfjNkgaljfnbirdjyWsYE2WALuvW2Fvyj7kPGjQ076ONA8RUL4aWgm7wiNGntRxXYJFYyL8/PE9TQF9Zt22tI1OLKkBCkztwniaWc4/Xwn/olkh6p5sHSdo3VoF/71IxUTLofRUOJIFnhe5SNHl6EhN+Rl/J+8nCum32sDKS1Jg34zDq/HGGZBnXHkL5Xty9sw3+PB3ddnx6O3tiX9Ul8CVEWRyCu5e+g++yUTnGy4Sb9Q62Tcg==
Received: from TY2PR01MB3786.jpnprd01.prod.outlook.com (2603:1096:404:de::14)
 by OSCPR01MB15033.jpnprd01.prod.outlook.com (2603:1096:604:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 01:17:41 +0000
Received: from TY2PR01MB3786.jpnprd01.prod.outlook.com
 ([fe80::7448:3c27:84e1:c974]) by TY2PR01MB3786.jpnprd01.prod.outlook.com
 ([fe80::7448:3c27:84e1:c974%7]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 01:17:41 +0000
From: =?gb2312?B?1cUgxP4=?= <zhangn1985@outlook.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: report an issue in x86_pkg_temp_thermal.c
Thread-Topic: report an issue in x86_pkg_temp_thermal.c
Thread-Index: AQHbwtssBUiu2exzQEaxa/eB1jao6Q==
Date: Mon, 12 May 2025 01:17:35 +0000
Message-ID:
 <TY2PR01MB3786EF0FE24353026293F5ACCD97A@TY2PR01MB3786.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3786:EE_|OSCPR01MB15033:EE_
x-ms-office365-filtering-correlation-id: 1d1bb519-5e5d-4fbc-88fa-08dd90f2c76c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|15030799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?gb2312?B?cUh1NTN2Nm12U1B3cGpOSURTNUhkVFVYdi9qNUJqSWg1ZDlPdkRjNlhMM1pP?=
 =?gb2312?B?dzQ5TWYvWTFucDNyYVFLUTdWQmJXbSs2aUE2VUpWQm5WUisvUXBnTUMwVERx?=
 =?gb2312?B?eWtxS3JuNUE2Q1RHczhFSHBSUnZrSkZ3cHVCcldWWVhyWjZGV3g1R3RXMG5Y?=
 =?gb2312?B?a3ZSTTJpUmpoUW9QWGxCcEdFbFhJTDFYaURUVmlTbndJcy9xSkcrM2taZi9j?=
 =?gb2312?B?S1ozYlpUaFMyWEZQZU5xY2tWdVpPMTN2QmFPdUxlMS9FRXQ5VDhTKzlFNTBi?=
 =?gb2312?B?ZHErdnkwdW4wVUJ5aGJacU9TUVQrRVpTZW54RURLbmNzMFZwZWpSd0FUWU80?=
 =?gb2312?B?bWpPQ2NqZHdrV21aYmo2cnQwam9NN0p2U1cvWlRnY0tQVWgxVndWaUttT1lu?=
 =?gb2312?B?aVd6cmYxR0NrcDJNREVXYXRBY3NhNHdIWkFUcUNnb2YyL09INVFiYStnUlRZ?=
 =?gb2312?B?ZW8yYkgvS29PV0ZuUENENmxKZmlQdGJmSGl2Y2FHT2ZjUEs5dEVxS1hRcjRq?=
 =?gb2312?B?Q3lmTit1YjFBVWl1cjhzMXcxbndHUE1xNTdrR3VGWWMydTZhVVFuQ240QmFv?=
 =?gb2312?B?enI3dkx1aHB1TThwbk1KZVVsbGVheWNZSHFPc2p0aUZHQ0RudmF0eXNqdU9P?=
 =?gb2312?B?SnFaSVBMNmRpVEgvYjB1MVFnTzNTMlF6YkM2c0ZQb3pkSGdwOGhkQ1ZYd3NS?=
 =?gb2312?B?WkZBallUSVVJbHhDckxTVDExQ3FmN1QwaVIwMEJneUhSOENlMU5HS3NzdGx4?=
 =?gb2312?B?YVJDL0VrRVdYbTBoWUttZkgyTGVVeXlCTGFOVDZTS3Zoa2lQTWpPVWNUU3Jr?=
 =?gb2312?B?VkJsVWtuQW1zbzMzV3U3cGxsODJ3THJ1SnM1eW9tS2E3Skowbk80cXRpQ2F0?=
 =?gb2312?B?Skt4WU1NR2tUOXU3RS9YQzVadkg2aEdveFJtM2RwNVZkZ0dqc0M5ZTJINFFy?=
 =?gb2312?B?SmVVMHlOVVJGVFVpSmQ0Zk84Wnh3a2w3ZmFLT21jZ2hrbm16Q2R0UzZrWFd5?=
 =?gb2312?B?dy9scXdsTklRbzZjODBjZ2lycm5FSi9SVlFvOXR3Vnhqc2I4UHZOb2VXRWxn?=
 =?gb2312?B?TE51TExpbGpvVHNaUmVFWjdNNjE2MC9lclpLbFEydVE2czgyYklWWDh5WWRj?=
 =?gb2312?B?bUsyQjRVdW0xN1ZYVnNFQmNsKzEreFZZdDBIY3R0a0QzV2J4YmZFOXFaMXEr?=
 =?gb2312?B?NTBaeXhCZ2JKdlJPc294TDkxbWRadlNsRm8xN3JjRkRGc2RxVkVCNmREN040?=
 =?gb2312?B?N1VvaFZGSkY1clBBbllFN2lEbVVnekhWN3YyaldicTE3aHdsWVNwS3REREJQ?=
 =?gb2312?B?OXFXUVdBUEJnQnVTaDVEV2xUUEw1NmdXWjB4S25KRWxMT2NZaVMxQWQySTV4?=
 =?gb2312?B?OGl3U3FnRnRxZGdkbW9YOW9xbEtONXMrR2IvaitaNGliUlJIUHJLRGsxZnNE?=
 =?gb2312?B?c3R5Q3lBWVl3djhIRG5MRWthYXIybEx4ekVON3lZajJ0UFVoZzBtRU5TeHlx?=
 =?gb2312?B?L3M4UC9NSjVkTGk5clBOcTBDcU51T3RoT0VVRmFaSW40dWJ5ZXhKMmdidElB?=
 =?gb2312?B?djlZZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K3hPUnBrb2pocEF4ams0cUlub2dSaTN5K2NDOWoza1ZKOVNudHZ1cnpvb3hI?=
 =?gb2312?B?Tm5Fc1lyMStsNHltNWoxcmVzdzFMM05HREY3REtMQmc0OEFwL3dqSHJTMXZS?=
 =?gb2312?B?MEZzOXVrbjY4YUEzOEt3ZWxjWlY2c3NML0pHazB5WmhSWElyZGorcDNBOC8v?=
 =?gb2312?B?eVQ2a2VNcTFvUkJVNkhlN2UwcG9pVlh5aWpkODZTbk01WUpZUFFmb283RWpW?=
 =?gb2312?B?aUlQNHlBb2hNUWF0dWkyNUozbCtDVDBlZnlZZHEwdmNMNVhscEl4WVBXRWhD?=
 =?gb2312?B?R2N1bVBocVV2Wis5L3hlMTdER0ZvcCsvSEpHNXFXNk9xWG9rSllENHh0SGpO?=
 =?gb2312?B?UGJyT1hqdE1vbzQ3VXJJeGZzWURjS2UvOXpaNGU3bks4enB4M29FdG15S2xX?=
 =?gb2312?B?eTZyTWp5aU95MHNFR0RCMjU4Ry9CWEhoVFBZSSt4cTNvbm1lMXF0SW1JL09P?=
 =?gb2312?B?ZEhzb1B0RUx4b3gxb2RRVW9PbDNtUG5PdTR2cjB2RTVva2JZYTl3VlovQm5M?=
 =?gb2312?B?NmM3eVRlekhsWkZ5ZnJXWU9oZzdMWG5QS2w2WHlLUG80eDR0TVBHa2VRVWt2?=
 =?gb2312?B?WjYvKzBvL09JQXhNZmdwejYyMU01U0JiSHM1TVB5cWJ0YVhUejlmYlJPUXFn?=
 =?gb2312?B?K0JCNGxSWFE2Y3prMjBWSTJJZENJbDNqWnFVdmFaQk5kN3pjWlZiWWxQMEll?=
 =?gb2312?B?UHlJVE5McWlVM0VNR2d4T2RvZ0swR2F6a3JrcWxLWWtpTk04Q0NzTytjc1dQ?=
 =?gb2312?B?Skw1cGU0c2xKekdRSThpOWI1aVZDZFJPemRVYTBPTjJick1STGtmT3NxMWFm?=
 =?gb2312?B?QXlNZFdqT3l5MjZUQTRGTkV2cENWazZsNEFYT0tSbVhwVjBpWGxRM1JPSEpr?=
 =?gb2312?B?RUpaYjJwVU5TNFhaalNnSlhrekRjY3JoWTQzbjBINlJvWWNMV3h0S3c5Y3Bm?=
 =?gb2312?B?YWNEaWYxS05oeE0rdUxDMWJQaXZJakRGODRFV2NyUkJrbTNZRDAvekMrSDFr?=
 =?gb2312?B?UlkxaSt6TUR4Y0pqMVJ0aVMwb05mVWI4VlRKa0diMW9GR25sSGRUcS9MZUJ4?=
 =?gb2312?B?RTZsc0ZSNlVzeXF2SzR4Nit3QjluV3V5OHNmaEtGdDBXSWVNam54QTRFaUdh?=
 =?gb2312?B?SXAreXlCbGlTLzBzbG5JTjVPVGoxZWV2NTljZ0lVSVI2RnVCempKRVV4U3FH?=
 =?gb2312?B?WlRnRkRaY1UxWXlxSnpYNkhybW9sdlFMWmIwVVN4VlhvdVpqVVdXOEhDL2VZ?=
 =?gb2312?B?eElqWXRuWWFCMWQxdWF6S1JBTEtZMDhudGthSzhvcHJBcExpbENYRFpvVlI5?=
 =?gb2312?B?citoanY3eE5BNlhNbi84dm1UWGMyYzNpS0R2RFp2cWhUcTdrVkRjQWVtNm10?=
 =?gb2312?B?SEFHQnJnWTEyK2VFazd0Z2YrNXBxSUdSajlkb0lwNzFhVFlxblJGTnlQemQv?=
 =?gb2312?B?a1kvbmJlaEw2emRIYW12Nllnbkx1L1JhMVpuWmRyUHNqY3lZUlFGSWJ0Z3pp?=
 =?gb2312?B?eDRQYkp5UVpPZ3Z4M1ZNdlRGTXhlKzNkOVRTMVplVzZOVUIwdk9PWU5DenE3?=
 =?gb2312?B?eGJiZktJVGtjZCt2RERBZmQrVWxLSkwxZy9mY0o3SUFhZ3hNVEJRTEZDWDYy?=
 =?gb2312?Q?4bNuxR6ACtZgGbpYtqiiSYHncwJBY6eP6ByxYMoiDhe0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3786.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1bb519-5e5d-4fbc-88fa-08dd90f2c76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:17:35.8560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15033

SGksIFpoYW5nIHJ1aQoKaW4gZnVuY3Rpb246IHBrZ190ZW1wX3RoZXJtYWxfdHJpcHNfaW5pdAoK
CQl0cmlwc1tpXS50ZW1wZXJhdHVyZSA9IHRocmVzX3JlZ192YWx1ZSA/CgkJCXRqX21heCAtIHRo
cmVzX3JlZ192YWx1ZSAqIDEwMDAgOiBUSEVSTUFMX1RFTVBfSU5WQUxJRDsKCgogdGpfbWF4IGFu
ZCB0aHJlc19yZWdfdmFsdWUgYXJlIGFsbCBpbiBDZWxzaXVzIGRlZ3JlZSB1bml0LgoKc28gdGhl
IGZvcm11bGEgc2hvdWxkIGJlIAoKCQl0cmlwc1tpXS50ZW1wZXJhdHVyZSA9IHRocmVzX3JlZ192
YWx1ZSA/CgkJCSh0al9tYXggLSB0aHJlc19yZWdfdmFsdWUpICogMTAwMCA6IFRIRVJNQUxfVEVN
UF9JTlZBTElEOwoKCnRoaXMgd2lsbCBiZSBzYW1lIGluIHN5c19zZXRnX3RyaXBfdGVtcCBmdW5j
dGlvbi4KCmlmIHlvdSBjb25maXJtIHRoZSBpc3N1ZSwgYWRkIG1lIHRvIHJlcG9ydC1ieS4KCkJS
LgpOaW5nLg==

