Return-Path: <linux-pm+bounces-7551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB38BDBF5
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F285B20AAF
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3578C8A;
	Tue,  7 May 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LLeAHoMD"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2089.outbound.protection.outlook.com [40.107.114.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229178C85;
	Tue,  7 May 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065146; cv=fail; b=i+l0QprXeCOLnTkmFS0eMYE1zL5ymKW+/ZjcEwM4W0REPMTM8rHcJElSCb0h3a/Dsm+y93u3DRgu6KLnE4Hu5xiWizlq6v/ZZ4hHEFuVgqYqgKZT/6tdILeUEhwiLArfcRQjWSFlyT2WiWFCV7ydTNH8PevA3Iiu10/3jggKH7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065146; c=relaxed/simple;
	bh=1XGHNII/F3Zyv46m+E1tSqlWQmNyxMjH2XFdQFhNtvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnza33B5HsGIdkjZME0bV56JoWaXDaFwelqmFvo+GrnY4vuhx0+Fw5EG403lpE5zO2l7QRbi9ozX/NH+strYCNBvEstieuatNlQIMfynSgjb8IX2eLl/udTwdGAWVNfQOadqH3guo4gXyREDqQ2DbvOoGycxpyquS6rHbbNPDzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LLeAHoMD; arc=fail smtp.client-ip=40.107.114.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr/LR7DLKpz4Af+AUgQqATT4VMIBwTzz9GxQWrK2ktt3s19rQDBGXvTcQpg7DDJ+lBxWKvTf+kAdAaIwz3zx/2SEDOAvdrAgIZeby6HhKLZUj/F54Ey8bSdmewPwtvYAsw6Kfp9edaqC54HtcH/kGALZfwDSR/3rZUjFByKi9/dcVFvkvU3SY6wBP5eEuDbwNAMYJ8TjJiZKMvx5ntPoADn1KwEcZXbEiA5U2czpqHgPlL5nLh4aEa8w/EDJ8Dt+JMHVbx/siQ82SeiLmXqSYg0dqN5oc5VXO4Sjoq3FpZfY4QXUIM1u4yAFwcSm7KCtWT2EfVuxXgFpFjFccYzB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGHNII/F3Zyv46m+E1tSqlWQmNyxMjH2XFdQFhNtvI=;
 b=EFWH5yvkz7KuSORUX+vO9J/fvbLWYYm62pd3F/t8vamqXI1UKd4vb/FlKkQdWn6ww2J4jG35mJl+/uJsDOFLSRK1K1yi5YyePdgZM40P+3QXRj+YL0/H3/QIUHOeaJaziFxXIPnOYaCC+n4I/JDPDdgA1crywhFrMhDaeoTTD76Gw7ypcSEg7fdCmin18JMCJ7xnnBZ24XgrSqqIAV2ZMjaImGe9vp/ff6CSbxGPnIy6p2ieUrdUBEVzB+XpQ+xc7jR6JFLkLMHv7vEreVaO3jOTcN1voqmZvHWdCjZpadfTOgeGK/0KbpM0Cr4XYxze05zD/jSAYKeHh1xUngIVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGHNII/F3Zyv46m+E1tSqlWQmNyxMjH2XFdQFhNtvI=;
 b=LLeAHoMDILE3URLWeCE56lkUDqZMTYFbV4j8ia1IffNDh5RVHwjLATWoFVtkmRdaCaGZ/OCFnVvhX0oQLFFd2t0DmYYUqae8+x3JDrl3i8g6z16hzRAD7lR5z1HWjDSmC3uPQqN1bRJynE+CXiOjGWHfMzSZKBJBsnXltujZuZ4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11685.jpnprd01.prod.outlook.com (2603:1096:400:378::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 06:59:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e%4]) with mapi id 15.20.7544.036; Tue, 7 May 2024
 06:58:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?=
	<niklas.soderlund+renesas@ragnatech.se>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/2] thermal: renesas: Group drivers and update
 dependencies
Thread-Topic: [PATCH 0/2] thermal: renesas: Group drivers and update
 dependencies
Thread-Index: AQHan8vRpexXaPlV7UqiiRgpLmZlMbGLWEMg
Date: Tue, 7 May 2024 06:58:59 +0000
Message-ID:
 <TY3PR01MB113465D9CD7906936C5AC6DD686E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11685:EE_
x-ms-office365-filtering-correlation-id: fe4dfc9e-4876-48a7-ea8b-08dc6e632bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0ZBMXVUazBkeGlDc1BTMlFLbUd5RlY5UkF1d3pkZDFkVWFESElOaGNEcXpP?=
 =?utf-8?B?OEFIYWx5VkJQM25VYXpuclphcTlVc1J3NWNETGw4ZURuODJnUjE4MEIyUmYv?=
 =?utf-8?B?Skx1NjVPaHZ2OWVMRHJvU29UejRmemRkUGQ1RjFQRlFaWDY0RUN1QzJmaWJo?=
 =?utf-8?B?UkJyY21sTmplRXBIVW1tQ3ExRnpCVDhZYlY1VnpDa0xEVExOakJyNmFZY3ZS?=
 =?utf-8?B?YVRpTVMrbnowS1IwOWF3YzFlMUdGM2E0ZDBCdVJNVEt1NFpVamh2RXNVcmRk?=
 =?utf-8?B?c2lYNDdhNk1DREhMNEk2Q25maG12U1MxRG82S1hVdTh4T2JiRlFadlhFMUhU?=
 =?utf-8?B?VWlLV29PZDk2ZDlKR1pTbjgydFh0eWdlcW1DVXR6Q2dqSFV4NU9LQjhna3Zz?=
 =?utf-8?B?MklIcm1yWEdDOWxoM2wzZTdJY1RrQklmczU0bDhQczB0OEtucnMvUU8yZ2l5?=
 =?utf-8?B?cGd0b0JwQ3lhZUVYODRvWDBOSmNhcm1vajhSRXFVUFJOZGJkRDhjWGZjVTZp?=
 =?utf-8?B?SlhjdUFwUmlEemJ0SnQyZlpPSEVvdEJ2dVlCVTFNUFlLcTVqNFVld25QTnU0?=
 =?utf-8?B?UllUYTNKUlA2SE52eUhZOEsvdTZtS2FFVXFnQXpkaEYwbDdXQUh6MVY4bHE3?=
 =?utf-8?B?Vzg2bjBCc0I1bC82QXlzd3d6dWVlM1dYSHBqWXVQR3JZUC9tdS9BZlpNVUM2?=
 =?utf-8?B?MlI2L0dSejlmOTVraUFnWlFadFdYeXlYRVovTXNKQVhITyt2b1VLMHRoTlVR?=
 =?utf-8?B?cjE3NVg3NHp4SCtEcUY0T1YyQzBEcUNpU0hLTHRaRzBHSkRJdFB5NWV0VkFh?=
 =?utf-8?B?SXRaZjZjcVIzT1FwQTd2TmZnTElzR2t6c0E0Qkg5QkJsWDRGbWVsUFZCRzgx?=
 =?utf-8?B?R2cvU3FLRDFoazN2bGpGaStBZGU4bmRCN0x5WmV6QXN0QXIrNGlOT3d3c0xW?=
 =?utf-8?B?K0Rqdi9WSTBSeHlwTmdqVTRBNWZ5Z3FhVkZLSTlvL1VIaDlpdTNaMHZYTk5Z?=
 =?utf-8?B?ZGphdjFkRTRTT0tFVUN5cWtTVSttYTVIWnBkeXR4bktWblBaZDc3NVZpYXZO?=
 =?utf-8?B?Zm83V2pUNlVOaXdPU1NZSjFiQVZKVjRLYzkxamcvR3BVL1hZZ1g5cVRCV0tl?=
 =?utf-8?B?bStSK1dlaDBEdERiazlBcHZuaUdvL1U3S1NhRm45aDZuNTdscmZVZlVmN3hK?=
 =?utf-8?B?cFA5NEY5cWwwL1RFa3c3MlJVTTVadDhwa0YwLytzS1hCN25KMTZSWjB4RGVm?=
 =?utf-8?B?K3NWVVNjS2FhQmhQWldmNUZWTUhPTC9lYkF5My9tYVRlU05nSWFJTjBIL3R3?=
 =?utf-8?B?UTE2c2IvL1B2K3grN3REV2liQ0NmN0I4MnVQNXNJQm1aTXRYektyeFVKM0Nx?=
 =?utf-8?B?Y0h1MjRjTnc2U1dKWnh3eEFmU3dXRGlncnRHTUVFTS9DcVZJWGNuelphMk9w?=
 =?utf-8?B?ZXZxTTJ3WnJGd3gzdE1lZlBGNlNkNWtvZjluWGpZMkUxcjUyOWxYcHRNY3RG?=
 =?utf-8?B?UVgvQ1Y3R0YvZ1hpOEJOODVaQmRIcVFvZ01IaGVNWCthMkxxV3MvYTg0YWNH?=
 =?utf-8?B?b0VBcmsrekdFRFJMY0k2aDUvZDZuTkYyUWJlVFRnUkVTK0xxejFPYVhPSWhH?=
 =?utf-8?B?bTNJOWt4QmFraUxXRDZjOHF0MUV0ZEx4YXRTbDdNVGVzRVU5dUFEbEE2aUFq?=
 =?utf-8?B?WjN6OTVLd3k2RVZxR3FENnVVdng2b1Q4RXVqbkdNSXBsQzdPVURWNlBVZDNq?=
 =?utf-8?B?SFErRXJHRmZ2Z09WNlB0Y0VPQ0VKWEZ5RXBqeTZLNm15Z0ljd2NDTGE5ZUR6?=
 =?utf-8?B?Q0t2TjlnZFNPTXVuazc4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OCtDVzJ0VnpHWFVaWDNTWHJaMFRZUTcrOVNNVStrYzBTb3l0WUUrWHY2Sm43?=
 =?utf-8?B?cXhML2xtVlRhdUJhTWtjSWpENFhneGsxVnJYNTVhMnFxYmtVSlUvamdXTWdR?=
 =?utf-8?B?WHRDeFdkMFU2cm5CNTdNMEZLMHY2elhLQjhLWnFEaWdlTDJKdVpwMVU4NzZz?=
 =?utf-8?B?V1hLVGc5RGtPQWdhSjBENnlkbW5ONjRvTTJrOTMwcS9sMXN0NW80dXQ5bWhQ?=
 =?utf-8?B?bU1WL1grSG5Xa0JzU3pqOTVLMm9WK2RDblRFcGlXUXI1RGUvdmZtYmJmU2N1?=
 =?utf-8?B?REJuSTNWUHpEZStSQ0RjWEpWaTZNZTd0WGFud1ppV2M3SHgwbmRBYjFiMW9F?=
 =?utf-8?B?dk5JOWNDcForNng1S2FvT0dSZ250dG95bHZoR0lMUHduZUp2M0FVN2hCUW1J?=
 =?utf-8?B?d2RCa05TTndRZEpZRkJXUGJmQ2w1U3o3anNGMStLMDdVdC94cUQyd3hPcTRB?=
 =?utf-8?B?RGFLby9CMUZSUnRxYUNncERVMUYyR2xTdi85bTFCanVZaldYSGxjVDR1VU1R?=
 =?utf-8?B?WkdpOVpsRUhsdDE2YlF0VXNrTzZGRW5VMlhFdkdiNE1JQTA2UWlwS1Y5TDJw?=
 =?utf-8?B?ZHNpRFZuM0dmUmxSSFBUcWJIbHNoNy9qbHZuWXdPOEVVaTZ6bWRvdWRvSHJF?=
 =?utf-8?B?ZzcwRXdyeFBsTUkwQ0g5dlhpNWI2c0FBQ1VmWTlKUGdLblloT2V5L2I0UStl?=
 =?utf-8?B?cFJjdEZZcWo0dVRzOU4xNVNSWDAzSVdrNkJoaUtQSGFGN015UHRNdHpKRjQ5?=
 =?utf-8?B?YWdibVZHODg1WE0vSlpFdzkwL21TamZWN056dEVWVGVidDR4TjdzTTQzWTVI?=
 =?utf-8?B?VnhzMTFXNllSNWJmdE1Zb3NhUmNwT3VBSnI2dUR5OXZwU21BdWE0TUdCcVc2?=
 =?utf-8?B?NmQ3Si85VGNhTXcvSE5nTEhIYmF3Smwxbk83a1FocUJBSWVXWFFZUkVteHhC?=
 =?utf-8?B?elRMVGNneGl0bXI1bnluc3MyMGJwc0d4c3Y3UGlSSWR2QXYrK0dyNGJ4eDE2?=
 =?utf-8?B?K3c3Z1pRZmhCVTdEa0d3QittQVIxRytmaFhTRTZVV2R1M2lTN0RuV1M2aGJK?=
 =?utf-8?B?M1loY3RxaXRGVXBvOVRPOENMOWI4ek56MStXb0NkcVVxQVIyU1YvQkN5ZlFM?=
 =?utf-8?B?dlQ4WFFLLzMyV3dXSnlvRUZsTlNjbGNUN2lpSnUrTEdCVmIzeXp4b2VpU21x?=
 =?utf-8?B?NDl0VEtNMlZOOFRKSGkrNk9McGFtYnA3cVpnaWFZbkROVi80ZVZuNkt4ck1D?=
 =?utf-8?B?Q2R6K2lKdnI1cjJHbEUxNWRUcjk4T0FaTnEwdFlDY2dtbS9NQ3lxWUt6NHBy?=
 =?utf-8?B?Yko0cytMVjF2QWZDVmlRZjhBemRIeWxZTHN1amE4T2lBbWpxR1JJQnE4Zk5m?=
 =?utf-8?B?bHBWVXo5YkIxcWk3NU5oNXIwVzNVYVE0dDBWLzczVjdSbHJ3MC8vaCs1Uk9u?=
 =?utf-8?B?REliRmIzQStqSm52ZUZ5NWZCT1NYbnM4NThxKytHeDBCOGtPNU9rRjBJY1RQ?=
 =?utf-8?B?RmRXdTdxTnU1aUFxLzBQNkI0aDhtajcxTm91RWVtTWM5cGplS2ZmZTdhSGNO?=
 =?utf-8?B?SENWMytJM014emN1YW9tN1E5OFFIZG9XZm0xcnkrTU4yK21HNkp4Qk1NcStt?=
 =?utf-8?B?QStuaGdsVU81Z2ZlUDZ4dHJUVEQ4cXh6Y0R3MHZ0aVptZzV1YWR4UnIzQ0Q0?=
 =?utf-8?B?OGZ5R2hSbkt5cXROSTZ6US9jTm5NYzFvRitYRXRuSVFGeHl4anZxWCtsRW84?=
 =?utf-8?B?ekZIMzBNL0tYTHRUWTdwbmJhZUpQKytTY0RtUTR0dVNyYUhidnRQTW4rY1pJ?=
 =?utf-8?B?UG1HYTdMQUlJbVg2dS9WaitrcllQY2xlRCtiRVdYTCs3KytqSWR2eVl6MVA5?=
 =?utf-8?B?YjZaWFRUdWVzR0xGODNSUm9nTERNVGM5T3lYajNpUlZUbVJXU2VLdEQ4U0s4?=
 =?utf-8?B?eXdhQWFMRUtTZ1Q5SzV3OVhidklkclZpSW9HUmJ5cVgvTEFLYmx2bXEvQWx6?=
 =?utf-8?B?enQ1UllHZkw0MWtyRGZzeXJoRVkvMUd6REhRa3ZIK0FEWm9WVS9wOEpTVEhu?=
 =?utf-8?B?ZXhOMUhDZ0FrV0plMTUwRk9oaDd3b0xPYU1LRTNtWGQ3UDJFS0FzZGF1QmRX?=
 =?utf-8?B?MThRM0VyS3dOK2hwNmVpY0tlM1RaV0tlZVl0RXFPUEJaY3owS1hzMnlySVBq?=
 =?utf-8?B?YlE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4dfc9e-4876-48a7-ea8b-08dc6e632bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 06:58:59.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbUTjWl+glDA//EA8juQB7dtK2L8mpCEkg73wiPpCs9ngDEZ61As1ojQGrQWd9DS6qtDG9BLKgMFHC6ta+GeyRKZEfK5rdDTrgjnEVKpv58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11685

SGkgTmlrbGFzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pa2xh
cyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29kZXJsdW5kK3JlbmVzYXNAcmFnbmF0ZWNoLnNlPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggMC8yXSB0aGVybWFsOiByZW5lc2FzOiBHcm91cCBkcml2ZXJzIGFuZCB1
cGRhdGUgZGVwZW5kZW5jaWVzDQo+IA0KPiBIZWxsbywNCj4gDQo+IFRoaXMgc21hbGwgc2VyaWVz
IG1vdmVzIGFuZCBncm91cHMgYWxsIHJlbmVzYXMgdGhlcm1hbCBkcml2ZXJzIGluIGEgdmVuZG9y
IGRpcmVjdG9yeSBhcyBkb25lIGJ5DQo+IHNvbWUgb3RoZXIgdmVuZG9ycy4gVGhlIGlkZWEgaXMg
dG8gbWFrZSBpdCBlYXNpZXIgdG8gc3BvdCBpc3N1ZXMgdGhleSBhcmUgd29ya2VkIG9uIGJ5IHRo
ZSBzYW1lIHNldA0KPiBvZiBwZW9wbGUuDQo+IA0KPiBQYXRjaCAyLzIgZml4IHN1Y2ggYW4gaXNz
dWUgd2hlcmUgb25lIGRlcGVuZGVuY3kgd2FzIG1pc3NlZCBmb3Igb25lIHRoZSBkcml2ZXJzLg0K
PiANCj4gQEJpanU6IFRoZXJlIGlzIG5vIGVudHJ5IGZvciByemcybF90aGVybWFsIGluIE1BSU5U
QUlORVJTLiBTaG91bGQgd2UgdXBkYXRlIHRoYXQgd2l0aCBhbiBlbnRyeSBmb3INCj4geW91Pw0K
DQpZZXMgUGxlYXNlLg0KDQpUaGFua3MsDQpCaWp1DQoNCj4gDQo+IE5pa2xhcyBTw7ZkZXJsdW5k
ICgyKToNCj4gICB0aGVybWFsOiByZW5lc2FzOiBHcm91cCBhbGwgcmVuZXNhcyB0aGVybWFsIGRy
aXZlcnMgdG9nZXRoZXINCj4gICB0aGVybWFsOiByZW5lc2FzOiByY2FyOiBBZGQgZGVwZW5kZW5j
eSBvbiBPRg0KPiANCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA0ICstLQ0KPiAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgIHwgMjggKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy90aGVybWFsL01ha2Vm
aWxlICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvcmVu
ZXNhcy9LY29uZmlnICAgICAgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrDQo+ICBk
cml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgNSArKysrDQo+
ICAuLi4vdGhlcm1hbC97ID0+IHJlbmVzYXN9L3JjYXJfZ2VuM190aGVybWFsLmMgfCAgMiArLSAg
ZHJpdmVycy90aGVybWFsL3sgPT4NCj4gcmVuZXNhc30vcmNhcl90aGVybWFsLmMgIHwgIDIgKy0g
IGRyaXZlcnMvdGhlcm1hbC97ID0+IHJlbmVzYXN9L3J6ZzJsX3RoZXJtYWwuYyB8ICAyICstDQo+
ICA4IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKSAgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+IGRyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL0tjb25maWcgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3RoZXJtYWwvcmVuZXNhcy9NYWtlZmlsZSAgcmVuYW1lDQo+
IGRyaXZlcnMvdGhlcm1hbC97ID0+IHJlbmVzYXN9L3JjYXJfZ2VuM190aGVybWFsLmMgKDk5JSkg
IHJlbmFtZSBkcml2ZXJzL3RoZXJtYWwveyA9Pg0KPiByZW5lc2FzfS9yY2FyX3RoZXJtYWwuYyAo
OTklKSAgcmVuYW1lIGRyaXZlcnMvdGhlcm1hbC97ID0+IHJlbmVzYXN9L3J6ZzJsX3RoZXJtYWwu
YyAoOTklKQ0KPiANCj4gLS0NCj4gMi40NS4wDQoNCg==

