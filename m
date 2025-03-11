Return-Path: <linux-pm+bounces-23840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E1A5BFDB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0937A6A54
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6AA255E3D;
	Tue, 11 Mar 2025 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TXjEScIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6D25484B;
	Tue, 11 Mar 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694244; cv=fail; b=sPYNiIVoTG8jbo+KGYM9Wfd7oUxC26eOT3CZ3m7sKEDVzH2r/Exdh/0jU8qMWL9sp3DNQevl94JsVNLKeoe0hBDEYQgQ1sZiUT6Fbb+WsC/b+8fHvTJZPNi3C93Wk6Z4IURkDbe0ePZeUg62KAQZwilJFurMIKQIAKq7NthzerY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694244; c=relaxed/simple;
	bh=KkqvMxwAccR8DUdhY687BJYKkf6iXnfl8gjT4rIBecs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msLpJYeJV/m5GkqzHmr9Og3GRYZgzlJhd1zAR8KFoi/1+A+i/aHdPlCbgRfHjqdnyQ0hLATOb8+GUW2dfM9O5dE/VSwLM5WiAhMQP1jfbquaI12iIE5wF56Cqf//Ev2Fv616hVKdVCeWMowa35x4/i2uRLH5OrwCzvU2KMJkMDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TXjEScIQ; arc=fail smtp.client-ip=52.101.229.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQDU3/BfDTNlWJd1xPhhRJ+wLo7bRGnGRhiidwdRTynERbG2hcBqdtf4H++tpkXOmmOVPv3I4jkIdyCXjM8ouqDpYfDdue1cnA5ozAds2b2bS3+ntij3MBCONMwFz+10aDvQwUkaxH1Ow18alvIv1EiyB1guVUE2YR7a/B2WamO63npnH1q9FOu46oQDvBX+zAHNTpvw5KVdQH0eoT4ScX94/39Yo0Ebf6LMV0kI47NwpYLz3GL7htPnUnZ3vHXnLtT/YJc/3isCsw4rjVWdQ0OBb+dZMyE81XNElFUn3t4OEwMg1cNHUJH3GljVMKlOBTvB1TOYo1gjGMiXnm3Drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkqvMxwAccR8DUdhY687BJYKkf6iXnfl8gjT4rIBecs=;
 b=oKoKPttVcNak+WBXS5aNwnvqUD+KPrOEW72f5eOseyQK5WTvceDeP8ry2WXnvGA5uxRhG69IGjlRLsvcPWj9rrdF5ud2sx8q55c3Dc6L8G2ID7em/8tfIknt3idr6UrLZi/FKtSQIRtRVsfYgHtfliHWjnFd7atsEWdjdrBQ2PLgFAa35O53kQqtguaaaGOlf7P6VsHYBVlXtnpwwM9U01NRodzriR4kIn484cxJDcDxTTVT370nnhbQjS69DCnAsryOCB/P2At9CzaJ7d+1i/AGL/YTf+PyyNdz+qD55fzbe2w9elyKy7+uiJ1gKlhC83Di596NCMKQl3TUN5rwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkqvMxwAccR8DUdhY687BJYKkf6iXnfl8gjT4rIBecs=;
 b=TXjEScIQNyt9S8TIl63Q4GOKOfxKXem1AswIbOmU31D9gXNfL24q/x8eju2p46hesJkQ/XhhOJfJ4q3ri6hwFdptnDFfoUFwIjyuyn/Dexd8TaA2LzSXFdKDCRYcG0XGxpeygEFHIeJ8odn6QSLul4Tov9Hk5zGSwcrcGNRVtS4=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYRPR01MB14166.jpnprd01.prod.outlook.com (2603:1096:405:21d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:57:18 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 11:57:18 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Christian Loehle <christian.loehle@arm.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Biju
 Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [RFC PATCH 3/3] arm64: dts: renesas: r9a09g047: Add thermal
 hotplug trip point
Thread-Topic: [RFC PATCH 3/3] arm64: dts: renesas: r9a09g047: Add thermal
 hotplug trip point
Thread-Index: AQHbkOy5jdJEW6PyoEqpYrN7rOJdZ7NtxasAgAANi1A=
Date: Tue, 11 Mar 2025 11:57:18 +0000
Message-ID:
 <OSBPR01MB2775232DECBB0A67D74BCE3DFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-4-john.madieu.xa@bp.renesas.com>
 <9b44d0ff-b28f-4d79-ad7b-b452db1db87a@arm.com>
In-Reply-To: <9b44d0ff-b28f-4d79-ad7b-b452db1db87a@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYRPR01MB14166:EE_
x-ms-office365-filtering-correlation-id: d8858d94-223b-4091-46f1-08dd6093df6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekRVdnEzemVsUGwvTG5aZjNhaXlveXZDazdRT0UxcGsvZTYxeUxTODZ1L2NB?=
 =?utf-8?B?V3l0K1ZMTXhsQXM4RjB5U3hQaEhVbDAwNDc5S08weW5LLzdLNVZQbisveTlM?=
 =?utf-8?B?cUZZTjNudEFZUVR2OENsakdselFuNTNRVFQyQWpZaVI0TmorTUIwd0VlUTh5?=
 =?utf-8?B?ZGZ3QVBQeks5eG5udzhQVnRYMHlvTzZRNTBVV1lxRE5DcTVMdm1uaHJQRWJl?=
 =?utf-8?B?bE9VREZkbzFIdU96Uk04MlFiQkZkTmNMb3M5N0NSZlRSREJRYkNGYlhicUlL?=
 =?utf-8?B?S3hDUjlYSUdsUFZZWFEwc0tYL3F5VE1aZWdkZ0svSWNsOEtJMnVyb0Z5SmZl?=
 =?utf-8?B?MisvMEtIRDhOak5JTGl2NDN6WmRhYURjc3BzcW9zVFh3SXJzc0YxWVNkR3Bi?=
 =?utf-8?B?S2FnWjZGbytWZFVLZlo5dDN3K0NsNUQ1WEZrMXdtK1BSV1A1TDUrRStQZ1Iz?=
 =?utf-8?B?UDlSNm93TEQycWUzYTRsa1hPUEdYU1ZEYjdaUmdDZlpSMWtHSUl6U1RMa29p?=
 =?utf-8?B?N2JNbUlXcTR6VjVQai90ZUNsWXVMRE1FSnhGMTF3MktmVHRXTmdmcTN0OEVu?=
 =?utf-8?B?d09xZ1FtZUZ2c1R4VHc5d1ZFVmVzK3A0MlBicVJpWWNjdkJ5MndleU8vNVJU?=
 =?utf-8?B?OFdCajQ4TUtOb01Oa0ZzVlVuVlhuVmljbzVIVUtURDE3R0pPdDFoeGViWGRI?=
 =?utf-8?B?V1NBS25DTFYyYTJzZ2pITFFPUW5XZ24xOUl2OFI5UCtMR1IyR2ZiNm9LSHdB?=
 =?utf-8?B?NG1MdUtFa3ZHQ0hzKzdJY0NrVUl0QktiYjA0emJuSGd0RmJYclVmcWMyLzJF?=
 =?utf-8?B?RkVUaGpXMC9FNXRDRE1KY1VKcGN1YlhDYUpIQlFPTDF6blplM3hpVlB5M2d6?=
 =?utf-8?B?NXpZc3piT1FtNGxmREFpRm5SaVRjMHFkSGh2S0U4cHJOc0NSMjU5WTRDY2l2?=
 =?utf-8?B?bjdyTnNGdnZYYXlCcU1yMVE5OEFna2xhWHR6dktFTThUM0lhL25RNlpLVkpI?=
 =?utf-8?B?d2szZW9NczgyUWZwVU5DQWxndWFndC8yaTdieTl5THZZZGp5aUUrdTB5M3JQ?=
 =?utf-8?B?YzF2YXE4TzIrU1pIdzBIQW54YXlvUkdWTk05dnE5dHhlNU13R25NSElXZnl4?=
 =?utf-8?B?eEo5UEtzWTdwQjZ0NW1sZEkydE5ldUVleG4ybU9kM1VNN1Z3QTVpWTh3c1Qx?=
 =?utf-8?B?Z2dReHhwSEtLS2duTVhPNDhuUm1GSXFvNUxBWGwrSEVCenNTRUpzMnRXelB0?=
 =?utf-8?B?RG1lY3p2ZHhVQmIxTGloZExMeHNSVC9LU2diUUUwMkF2bjJwY3YxOWxoVjdQ?=
 =?utf-8?B?TUoyeUdQcmh0M0FyTjdNRU5kUFNQeWhkOVRZT3phK3dJVTFicnd1YkwrQXhD?=
 =?utf-8?B?OEswQW5JUUlpS2NlclhXK1NVY3VxL2Z5NTNUVXVEV3JLZjhLWHp4NFZ1SXR5?=
 =?utf-8?B?VHZSbDRVN05Vcm5sbnZSM0IxZDZDSTA4UWhSWUphRFU3SWVmaHlmYkJyWk1E?=
 =?utf-8?B?L0ZZSVNYVUZSUWdjblQ5QllXV2hwc25tc1pnZzFZTld2WTNpWG5PSUZZblVC?=
 =?utf-8?B?RG1vOFEzSlM3YUthV3ZRMHNsNDQ1WHpabExJS0pwVjBNUUg5eXp3Tld3ekNM?=
 =?utf-8?B?NGg2NkdQeGZNMHYzYUlZaUtUNlRtcTAyTXhDeVNTVDhHNmRMYW90Wk1UU3Uv?=
 =?utf-8?B?aXRseFR3S0RROEpqODYwZHhwekZ2SkdRa2l6TXRMazQ5ZkFuaXdpZU1ySW9h?=
 =?utf-8?B?cm1sWVQybXVYUFFKbURVMUdBc3pqUkk5Znc3WEVhRkYzQ0YvbktBWi9aV3pB?=
 =?utf-8?B?UklyemM3NmtHcHBxZDN0SHpZblFYMFE2cXJ5VHdJN0RBUW9JRGdhdmVkV1Z5?=
 =?utf-8?B?elM2ZjI5dDVXVWhRTkRqeUVHMDd6Smp1cW5nMGpiWjJqLzc0Vm1ITU85b0RT?=
 =?utf-8?Q?NwESzM4Y+nHLRybeuOg7L2TmHcvYo9V/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVRDYWhtVkYvOXFkRU1EaVFjMHY0TWYrL0RwYXZubjlFd2V2bnBZR204QVZs?=
 =?utf-8?B?Z1VEQzF1K2kzWW1jY1RHWm1kQ1VEWTE5Rm5lYk5sUGoxOGx4Q1AxWVJjVE0v?=
 =?utf-8?B?T01MM0Erc0duSFNpQVc0UjZHNEdKd2dpSGlQOTlyRUtzNzhERkdSY0thUmVl?=
 =?utf-8?B?VlZQMldzK3JuUWxaeGwxS3ZRZzJVZWswaUdCRUxiMlkyUXhkdTl4cmxDZmdN?=
 =?utf-8?B?WThlUFU2b1dBZzVYZFNnK1o0L0h2WGtkMUcxbklCWDk3WVIxRVZVR1FhU2tT?=
 =?utf-8?B?QXZpcXN3ZngrQUhlenBOM2t1TWVHckpDT2VlYlVEUS9Wcml0blo3QTZxeEpq?=
 =?utf-8?B?Slk0SnF2QmV5Wkg1QzI4Q3ZJWFFiU2E0VGE4d3RIOTJSVk44di9Wd3ZJckpL?=
 =?utf-8?B?SHB5U2hKc1dZR0RLbW5tdFdGY1RwbXRrSUtVVStOc3RPbkhOZXI5VTJZVFR6?=
 =?utf-8?B?MmZMUDhEUk5GSU1ta3hpVHViMVRhOVVlQ1o2UFU5UGllYmhZbHpGKzhBWDB1?=
 =?utf-8?B?dEhWNDNRYXMxME03NHB4VXd0MUlkVDBDTGVZTU1CU0liWHYrSjNOdkhaaXRa?=
 =?utf-8?B?VGlyeDA3UTlhamRGZ0dFWFB3cjQwRkVaNjlpS0dZUnZGVjA2cnZaUnByUGFH?=
 =?utf-8?B?aXJUZFROazNhN2s4VU9jNzNJTEJ1c2RyNkx6VzZwbUIzNE9MZURXczJDLzl5?=
 =?utf-8?B?QUJmVkFXUmxGSmowMW1QS0MvalVLWUZSSGpJNEtWVEU0Nld1TXozSXNQT2p4?=
 =?utf-8?B?U1UwZzgwMlJHd3c0QTJRWFZLN2V6YTY5eCtRelE1cE96c1dQU3JsSy9IR1Ru?=
 =?utf-8?B?YU9ySVlNcHh4bDRvUnhycXFDbDkyZVllM2MrSk1WR3puQXUwWWx6dmFJelg0?=
 =?utf-8?B?QWp0eVRXNlJITGY2T2k1NTVaVkpKcEEvU3JHZURTYkdzdE9jQkZFeW5yNEdB?=
 =?utf-8?B?SXFSeHdOdUNyQWh6bk1qZGxMamJoT3BER2JGaFR5ZnZsQWVYS1dRNEI4dDR5?=
 =?utf-8?B?UUs0UDNQUXNUN0xOYTF4ZlRRWmRJenBwZ2NaYnIxMEJ2MkVaL0plN3RTWUUx?=
 =?utf-8?B?TGIvQVlCUDRCdldZOTh1YnFMZzFrZ1p4dEwyMTduSXpuUmpiMlZqbWxKd2NC?=
 =?utf-8?B?ODR6QStlM1RhdTdVSDgxVHNMK0lUdDhpc3Y5L2QrR0hOVnNQdHdvUjhRMExn?=
 =?utf-8?B?ajJiRjA2NGlLSEVRSitkejNkQ1g1VStyR29sMXY4OE5FV2JUYlAyNTJldGk1?=
 =?utf-8?B?dTRKeFk5VU44UDRVV0lmYVlGTXMzM0RtT3RNSlRVdnYvY3lpSjRuUk1za2Fr?=
 =?utf-8?B?eUcraEdPVGFkMDVQYVgrZXkrV3FMOTNIVjhKZmUvMThrTkJnWjZ4b2p0RmRZ?=
 =?utf-8?B?UjJsbzErQkU0OTQ3a3U3MDJZY0hXMzRSaFN1MmtUU1hiMVFMQi9ncis1Y3VP?=
 =?utf-8?B?YzUwMEFpUjNxdVBLTC8zY2xlL3c3a05tTnFXNFlDUUNTMXpMQXRJQ0lVVmt6?=
 =?utf-8?B?MmRsZVR3dStMTTNpR3ZNMElqMmgrZkFraHkwcEpydUVwMWJiSjBOT1NPNEZF?=
 =?utf-8?B?aVZhVzJLRU8xdXMvT0p6ZERidndoWEpoV1FhdWJwbjIvS2toQ2JvZ2tKQWtV?=
 =?utf-8?B?Qlk1bldLcjZULzgvQjQ3R3pmOGxzRTQ5WCtKVWxvQlJraEtCVURVdUp0emlB?=
 =?utf-8?B?VmFhNWdNdWdTTENpekFMWDI0aEhuWWRLdGd3Wkk1VmZZZHAvWEloRkx2MEh5?=
 =?utf-8?B?UldPMktUa2JHMnkvSG5ZQk11L05vRTRFVVlLSXVyM0JlQnJYbmF2SVNuVExS?=
 =?utf-8?B?UWpBekdSOWFIVDFubzlzZm1vUG1yUkVMbGFxeHFkM0hKbzFKc3pvOGNSdkhJ?=
 =?utf-8?B?c1FlSm5kcGJYbWxQdEpZVERQd2pUb1N5b29mZkRTQzZscmpTandPYUxoK3Vl?=
 =?utf-8?B?bk1DMW9zQzduM1pVWXFXR2RNcHk0VFgzM2t1V3Voa01kbmEwTWZBWHM4bm9E?=
 =?utf-8?B?cHd1dWRWVkt3U1g4MFFqQnBweS9oNzlWVVlQTERzM0xIRVBjRVNlakNtNnV4?=
 =?utf-8?B?d0xpT3A4UEVOVk1VVmNScjM3Um11K3lKTVRoNGRsZ1grNkdMR3pENkVSMnhB?=
 =?utf-8?B?Qy9VNUliWk5EclRVMzFqaVN6VElLWDJXeHRvTDFOMU9MWVoza2YraUJ2SjdE?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8858d94-223b-4091-46f1-08dd6093df6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:57:18.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ydIoDdZpnR5BMfLDgQNI20tJEWF/fk3ATbn09MmL7sb3OLTH+PUBRRP+Vy3tSIRkTR8dekmXVPKsrSNWJPAG45PRefZsZ92rQxIfc8Th+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14166

SGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHJldmlld2luZy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9laGxl
QGFybS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDExLCAyMDI1IDExOjUzIEFNDQo+IFRv
OiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+OyBnZWVydCtyZW5l
c2FzQGdsaWRlci5iZTsNCj4gbmlrbGFzLnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVjaC5zZTsg
Y29ub3IrZHRAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5v
cmc7IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnDQo+IENj
OiBtYWdudXMuZGFtbUBnbWFpbC5jb207IENsYXVkaXUgQmV6bmVhDQo+IDxjbGF1ZGl1LmJlem5l
YS51akBicC5yZW5lc2FzLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBqb2hu
Lm1hZGlldUBnbWFpbC5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsgQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsNCj4gbGludXgtcG1Admdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDMvM10gYXJtNjQ6IGR0czogcmVuZXNhczog
cjlhMDlnMDQ3OiBBZGQgdGhlcm1hbA0KPiBob3RwbHVnIHRyaXAgcG9pbnQNCj4gDQo+IE9uIDMv
OS8yNSAxMjoxMywgSm9obiBNYWRpZXUgd3JvdGU6DQo+ID4gQWRkIENQVSBob3RwbHVnIHRyaXAg
cG9pbnQgdG8gc2h1dGRvd24gQ1BVMSBhbmQgQ1BVMiB3aGVuIGV4Y2VlZGluZw0KPiAxMTDCsEMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAu
cmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OWEwOWcwNDcuZHRzaSB8IDEzICsrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvcjlhMDlnMDQ3LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNh
cy9yOWEwOWcwNDcuZHRzaQ0KPiA+IGluZGV4IDkzYjU3ZDdhZDdiOS4uMDZiZDM5NDU4MmUyIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDcuZHRz
aQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDcuZHRzaQ0K
PiA+IEBAIC01MzMsNiArNTMzLDEzIEBAIG1hcDAgew0KPiA+ICAJCQkJCQkJIDwmY3B1MiAwIDM+
LCA8JmNwdTMgMCAzPjsNCj4gPiAgCQkJCQljb250cmlidXRpb24gPSA8MTAyND47DQo+ID4gIAkJ
CQl9Ow0KPiA+ICsNCj4gPiArCQkJCW1hcDEgew0KPiA+ICsJCQkJCXRyaXAgPSA8JnRyaXBfZW1l
cmdlbmN5PjsNCj4gPiArCQkJCQljb29saW5nLWRldmljZSA9IDwmY3B1MSAwIDE+LCA8JmNwdTIg
MCAxPjsNCj4gPiArCQkJCQljb250cmlidXRpb24gPSA8MTAyND47DQo+ID4gKwkJCQl9Ow0KPiA+
ICsNCj4gPiAgCQkJfTsNCj4gPg0KPiA+ICAJCQl0cmlwcyB7DQo+ID4gQEAgLTU0Miw2ICs1NDks
MTIgQEAgdGFyZ2V0OiB0cmlwLXBvaW50IHsNCj4gPiAgCQkJCQl0eXBlID0gInBhc3NpdmUiOw0K
PiA+ICAJCQkJfTsNCj4gPg0KPiA+ICsJCQkJdHJpcF9lbWVyZ2VuY3k6IGVtZXJnZW5jeSB7DQo+
ID4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTEwMDAwPjsNCj4gPiArCQkJCQloeXN0ZXJlc2lzID0g
PDEwMDA+Ow0KPiA+ICsJCQkJCXR5cGUgPSAicGx1ZyI7DQo+ID4gKwkJCQl9Ow0KPiA+ICsNCj4g
PiAgCQkJCXNlbnNvcl9jcml0OiBzZW5zb3ItY3JpdCB7DQo+ID4gIAkJCQkJdGVtcGVyYXR1cmUg
PSA8MTIwMDAwPjsNCj4gPiAgCQkJCQloeXN0ZXJlc2lzID0gPDEwMDA+Ow0KPiANCj4gDQo+IEFy
ZSB0aGVyZSBubyBvdGhlciBjb29saW5nIG1ldGhvZHM/DQo+IEhvdyBkb2VzIGl0IGNvbXBhcmUg
dG8gaWRsZSBpbmplY3Q/DQo+IA0KPiBGdXJ0aGVybW9yZSwgY291bGRuJ3QgdGhlIG9mZmxpbmlu
ZyBvZiBzb21lIENQVXMgbGVhZCB0byB0aGUgcmVzdCBiZWluZw0KPiBvcGVyYXRlZCBhdCBtdWNo
IGhpZ2hlciBPUFBzIHRoZXJlZm9yZSB0aGUgb3ZlcmFsbCBwb3dlciBpbmNyZWFzZSwgdG9vPw0K
PiAoV2l0aG91dCBoYXZpbmcgbG9va2VkIGF0IGlmIHRoaXMgaXMgYSBwb3NzaWJpbGl0eSBmb3Ig
dGhpcyBwYXJ0aWN1bGFyDQo+IFNvQy4pDQo+IFNvbWUgbnVtYmVycyB3b3VsZCBiZSBoZWxwZnVs
IElNTy4NCg0KVG8gY2xhcmlmeSB0aGlzLCBJIHRlc3RlZCB3aXRoIENQVUZyZXEgY29vbGluZywg
YWxvbmcgd2l0aCBwZXJmb3JtYW5jZQ0KR292ZXJub3IsIHdpdGggInBsdWciIHRocmVzaG9sZCBo
aWdoZXIgdGhhbiAicGFzc2l2ZSIgb25lLiBXaGVuIHBhc3NpdmUNCnRyaXAgaXMgY3Jvc3NlZCwg
d2Ugb2JzZXJ2ZSBwcm9wZXIgQ1BVcyB0aHJvdHRsaW5nLCBhbmQgd2hlbiAicGx1ZyIgdHJpcA0K
aXMgY3Jvc3NlZCwgd2Ugb2JzZXJ2ZSB0YXJnZXQgQ1BVcyBiZWluZyBwdXQgb2ZmbGluZSwgd2hp
bGUgdGhyb3R0bGluZw0KcmVtYWlucy4NCg0KV2hlbiAicGx1ZyIgdGFyZ2V0ZWQgQ1BVcyBjb21l
IGJhY2sgb25saW5lLCB0aHJvdHRsaW5nIGlzIHN0aWxsIG9wZXJhdGlvbmFsLg0KDQpPbmNlIEkg
Z2V0IGNvbXBhcmlzb24gcmVzdWx0cyB3aXRoIENQVSBpZGxlIGNvb2xpbmcsIEknbGwga2VlcCB5
b3UgcG9zdGVkLg0KDQpSZWdhcmRzLA0KSm9obi4NCg0K

