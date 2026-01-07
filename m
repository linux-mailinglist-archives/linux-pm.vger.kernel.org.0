Return-Path: <linux-pm+bounces-40392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E4CFF60D
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 19:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76A830DF3C9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A29C318EC6;
	Wed,  7 Jan 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="m5OoLuOT"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824E1D9346;
	Wed,  7 Jan 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806235; cv=fail; b=koOGaSLNTElhaQCjnH+Q+rb5OmuoEhmOatTtTIYklVrsHe7ZwDamd/qbF7P6UUw0Sw+gB8Y5huYgbndN0MkSgL1ez5xW0iLKmZ0HuKu/Hi/TAUEl9pV5FRvguY9nsHbPE0ne79lnqKVZXK6Jzv5Sfe4eBU/zZvNYQico6wLk4Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806235; c=relaxed/simple;
	bh=Su1qgqYvVKP+02xkxbN8kOsx/GwDwVTWLmyhYAMFdwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bYy5FiqCXYWOVwGelXD8qk7bpMj+ly8gpmF4Etf97QtSaUtP0yf5bDrBsFbsB+H/X2D4V8+rGWEmpkV3Vi7Tje0mxF1hrNOBhBlNnpXj6v4qhEFneozQgEStf1xxdCERPq+xQL5xzYNKlTKcPayu2W8c+9YBgItiAq48VRy5QH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=m5OoLuOT; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRIjdxINd15fvAyyiixuLQnsxyfIpVEAmR0LDF7vIP/6jaCRdzoTN+0VInFiKCUqQuSmvEacA+V0ZduJ+gJiHUeZ0s6I6iNrT3OR9G6Hp1XE9Ict6ufZ+jYM7PljymfT4ENRXGp930jAFoMZ8QWs6xDl33DNYrfmFdRc8yWDAttavUBDxs25G1+gmreDSzLCv8d4pisvJz3uvc5nBVJCou+o6x633cwbog3r7kuGisIe6P2UB9gsWlcCgTsNx6JfunxkyNuxL70QoQxQPiaspBmLN2zlbWvyty7w7vxahTGo9Qj4B998r8EsA6DZsGgg5PjxL0UD5AscRHhJLwwjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su1qgqYvVKP+02xkxbN8kOsx/GwDwVTWLmyhYAMFdwI=;
 b=vW/p4JSZmeDqr4MmfmTg50Tg4vbntp5zMu4rMwRcput3K+K0Qq6WuMSx+MwDMjc+W5XW1pfSLHYLe9zHT62LRfp5Wo+JBo54+nBWZjE+E/HoZGcs9Cftuc/bbFKANkndi9zCx/Il6HpUKBLH28Y1sUPJYlLXoLPrdB0gFyfvMane+i3WXsyrkMRX+xu82GKbhwdH74/IwAyoFFQ08whP0sAM9zI7kanL6id0VKfqFB4hacSg7hOTtpfSoofL7aGXdLPlrF5aqAJebfY7h/V+85xf5HsywYFpb31p/708fgml4PpJrugj+JsUyhXIFo1LgPOMKFWaoFO6Zd2a+8M93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su1qgqYvVKP+02xkxbN8kOsx/GwDwVTWLmyhYAMFdwI=;
 b=m5OoLuOTYYf8cDLWNyZEnPO8GEsgNniU0NeI8a7/m80titv6i8X2r325vIEH4HZcCbsFx+EAt7R4fGMXgtfSUjoNeZ2QzdLVofFk9pFbMBfUrtPx4O2JVVM6bW1OPogM89Vqhcic7LknEeu90WyhQWr6Pj8iZ26Sg2WRgggCN74=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB16982.jpnprd01.prod.outlook.com (2603:1096:604:41c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Wed, 7 Jan
 2026 17:16:59 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:16:59 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Cosmin-Gabriel Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
Thread-Index: AQHcXtU9h1oHyHUJHUSskIYzSK8LRbVDiFAAgAOiF4CAAAo0MA==
Date: Wed, 7 Jan 2026 17:16:59 +0000
Message-ID:
 <TY6PR01MB173776E5372C2D86EA872DC7EFF84A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TYRPR01MB15619FEEF47DF01E9FFD57BF68586A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <a6c04e69-b0fe-43b1-ab7b-3326f6980471@linaro.org>
In-Reply-To: <a6c04e69-b0fe-43b1-ab7b-3326f6980471@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB16982:EE_
x-ms-office365-filtering-correlation-id: 47c54865-dfd6-4907-d7ea-08de4e109122
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWM4V0djc3NmVFZKNWVGY0VPZG52U3B5amNYeEhkd21Sam5SZnFaaDNWcmE4?=
 =?utf-8?B?RmtuYjZianV0VnJMbHVkd2NjSkdFZkdBYVNNbVhEVytPdHd0V3RJZEU4cFp4?=
 =?utf-8?B?ZnlEbEZWK2NRZ0t3MlBKWFpBVzBYSHZUSC9uMm41WlpPekY0ODdpRE9abFAw?=
 =?utf-8?B?Y1l6QVVtK3NNeVk0Y0VwaUEyeGZJRzM1S2hHVWNybldjdnVJa3kydjRhN0VW?=
 =?utf-8?B?MlBGY3U3bEM1SXJjR2FsOGF5dXVlVkxRWXNlS2dYaitsUGN6ZzBiZ1FYVEt5?=
 =?utf-8?B?ZTZVMnFwQXZWMW9JTWQwdUxBL29COGFTSDZoS1QvbmNlRklCWU1waHFLWVls?=
 =?utf-8?B?LzVrbnNNaDBHNW16YjlXSXZHSEZ0OWM0Y0JDeVRIM01JcEo0ZGZLZDZEUG0r?=
 =?utf-8?B?TGlDcm1ub1hrT1FETTR0YU9pcXoyeW9oUSt3TThabXFsMngzOFQvN2haL3RL?=
 =?utf-8?B?WDd4d052MlA4LzdFNDhvVHVqSlc1Y3FhNTJQNHVHT0tGMjVWdXlXNEVVd1pP?=
 =?utf-8?B?NXBuM01FQ3NDRkUwVG1yYTdkbW1FWk0zK1pFT09Jc3BkcGxvOVRPS29Xa0RD?=
 =?utf-8?B?enZtNW9uM2gxcko5Z3pZRDVqNEYzNTZqTTNUakh0b2sxdVpKK0pCSmI5NDl1?=
 =?utf-8?B?MVhCZi9EYUZZZ3JGOFJubDdQZHdkZlRVMXNDWGZLaEpLTzl5Nm9BM3VoTlNp?=
 =?utf-8?B?SjZwTHBZNFRNZVdjNmQ2UDNRVElRdGVETVloTXAyMDg3YXFubE1vL1RYY3dL?=
 =?utf-8?B?ZXZEOHZTanoydWowOUlNbTJyZ01HWjhHNlBDdjBqOHQrOHVGdEhub3pDZXhI?=
 =?utf-8?B?WXpXWDFBQXB0czVadXl6SkZ6Yjh1Y2hHQXFrVWJycnY3WDJ6cFd1Nk0zbGNG?=
 =?utf-8?B?YzFRbDljNXV5UFh5SzRGUEpicDl1SlN1N1p1Mmx1RVlvb205T0pJSmNwVERU?=
 =?utf-8?B?Q2dmS0VSTHRGWS9hR2xqTndwTGNCZG9qUG1lMWR4WVNyMFh2QSs0UDlRNFhi?=
 =?utf-8?B?L0txWXdqNk1ER3luNFdLY1E4Uk5sNzJSREdTeS92RWU1WlMrKzdzSXhhZTMr?=
 =?utf-8?B?MmNPbDBqa1dWMTUrZEhNU0NCcjRZT1paR21RLy91UlhMd3lTTmpHV09LVGVB?=
 =?utf-8?B?TElVdmtzSFJKUmxqZEwra09ka2lDbGpKVkNqTmh0ZVphQm1GMVhtaDU3QW5t?=
 =?utf-8?B?d1B1S1BiTkFRbWsxN0Jtdm5Ra2s1VVFkRjF4bnBxcU10U2xEMGhHZndUazZy?=
 =?utf-8?B?TFVneU1hYm0wWWl0UjZrREowWjA1M0grNXdTL2tyUmZNaTAxSDdrWGNxcm9k?=
 =?utf-8?B?QkxoQnJDUEFNeUJZUms5eklzRGdVWmdUTFE2VnlnZXh2VVRFRzI3My9XemhB?=
 =?utf-8?B?Q2NGdWJ6U1UrOUZYRmhFREFxSjJvek11aFZ1KytCZGRUOWVEOXlLTjZLdDNl?=
 =?utf-8?B?RjZBckJ6YUg0Q0lNREZBNnJQTitkVCtGM2pGNTZwQ3Q5YURqSG9LU2s3NmhO?=
 =?utf-8?B?dEdFV0NObkh0L0liNjd5OUY3b0IySXAxNnVKVnVBQmRCNFdpNExvMW5ZbVFp?=
 =?utf-8?B?M1c1UnhzcElrWmY1c01DREtEUVlrNUdkemhVajRoRVF0eitOTzgyMSs0Y1VZ?=
 =?utf-8?B?RW93ZHhiVGw5Q2k0N2ZId3RNNit2cURueGpQbXFubVdXS3JYVDRYQlBKVkJI?=
 =?utf-8?B?N0JCMFVzN050Y04zNE5hcHpsdFE0K1ZiNmxRR0NWYVpXUTFTcWNNVWRyV1pR?=
 =?utf-8?B?V2MvMFNqUThpbEFPdERpcldTTk5BTGVjVUJkVVloZGtpY2hwTE5Mek1vWGRp?=
 =?utf-8?B?VEF5eXZNeDFRb2kyakJJa0JudVB1WDJkNXJmYnYwSlAvcVFZd3NCWnhVejZM?=
 =?utf-8?B?OVlkRmpFVXhxNm5tOGQ0VnY1NGRIUTJXTi9OSFc2d0U5OUQ5VVpuMGVFaVNF?=
 =?utf-8?B?bi9lQi9NaXVONjNNdCtuSkQ0TW82NE90SFdEeGN5SnhPbkt3N0psS1hRdEdi?=
 =?utf-8?B?TVZ0MDEzYWpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M200WEx0a1dCT29NTXg2eE1xZSs4cTJLUmdlTm8vTjZOT3AyQVBkellYTmRL?=
 =?utf-8?B?NmxiY0ozbnZTZGRmNVlnK0RhUFpZTDQyVyt1WG54OFF5bTZnMG00TFpYc0NN?=
 =?utf-8?B?K1ZqQ1RLZ2VXOXlRamIzTnRYY2d1N2FJSzE4aGhJc2pFMjh3aVdJTXBUYkdh?=
 =?utf-8?B?eGFUclFJb0p3MkZKTjdmWXE2ZkZCT1dKeXVwSTZEdmQ4VFNFTVhTT1dEQ2tY?=
 =?utf-8?B?Q0xkc2htUXJ5SWV0d0N5MFU4NUNWckxLV2tWYmFZNWIrbmk0NTg1ZFlwUHFy?=
 =?utf-8?B?VGZTc2V0M3h5NTdUSWNnT05ITEQ3SG54Rm01dlJWK1VqaE1qNDhJMlByTURz?=
 =?utf-8?B?L3c4MTFQK3lwTzJzQ1BSQk9SNk11T1BlZ2NCazRiNDkrdUd5aWhFK3QwME12?=
 =?utf-8?B?VkQyU1U3eEZmZmt3dFJ0R0Z5QU83M1g3VnNVYlB0OVQxSVNnS0RkY0RocHFT?=
 =?utf-8?B?YkRJNmlPQkxadEJQWTlDeURrYVVsVTMxMTVEMXNVaE1kbnJ1dG05N0oxeURQ?=
 =?utf-8?B?QkdMWjdtcUFkSWw0TldlbWRFamcxNkJSQmxRSVMrdUtqUVN6a2tSNlNPRUcy?=
 =?utf-8?B?WnoyUFJTcVp5RGpmUEd4d0VscTZ0RTc2NHVpMjlKdmd0MGd3dUsrdm5CQnNp?=
 =?utf-8?B?MHRxeDBpQlF3cUVMRDY0R2FQcjZ1NlpUSlVuZ0dpdFFCNU1meUxFUmZoN3kr?=
 =?utf-8?B?YzVpWnVkcmZrY2x1NmMrV2tEUkp1b3RSSU4yNWFSb0wzbTQ2cklHaDQvcHRz?=
 =?utf-8?B?azRKNnRQeDhTVW1VcUxqdm9oV05qdGxtSVJIUkRkY2FDV1ZCcmFlVHVZR3lX?=
 =?utf-8?B?bHUya0o2cExKRzgvNUxKbXhoUlFUN3ByYnJLdURtTVdvVkd0VDJRQUV0S1ZZ?=
 =?utf-8?B?SStkVjlqMWxkVzJ2aG9XVE50VU9vVzZkZXhyYmhsaldRVjlOQ1NjeHNwTSsw?=
 =?utf-8?B?cVRwYWRKN01pTXhKK2lZamhFRlZFRlQwNUhTdG1TVnFmVlhzRW5qREdDVUtu?=
 =?utf-8?B?S0J1Z0h3QVZXUFdESjFveFNKamRhcWlueWUwQnI2WHdZN1B4WkJQTkVZMTNG?=
 =?utf-8?B?Nk0ycnVEeHlHSlQyUG5RV3F5RWdiOHp4Y3BSVHAvTGtQOVhremZaNGRaTncv?=
 =?utf-8?B?d0x0UU1iK0lTTzJXc2xCaDZNZ2VxejlGY08xa1BXbm13YjE3TGI0RUN6a0lt?=
 =?utf-8?B?T1NwbjRoZEswYnJ0cHlNZmE1REQzQ3FoNDZPYzE3cGt5d2lXTFFlVW5UQytN?=
 =?utf-8?B?b1lubzMxUUhhc3YxaWxPNmJlNG9hQStzNDJnN0NsQ2pJaHdqRnBZbVh6TXRB?=
 =?utf-8?B?UFcxNXpXRXhKUEVKaEgxWWpsdzFyMEIvNEFuV2lDU2RnQTZhd3E1NnJUbm5Z?=
 =?utf-8?B?Yk1nSTMrbVo1ekNkY1FDdW96dklldEVEMjkrWCt2M0t2clFkZDBmRmtjeGhS?=
 =?utf-8?B?c3dpOWlneFNnWGdDdVNMbUNhM0dkRktCSWpINlVGa3VCTzFRb1F2cnlCdG1Y?=
 =?utf-8?B?UmdWTkhBb1pab21oQXBEOU5tZ0lZa3RLay9JcDBWYkRTT3c5K3FnaTl2bVc1?=
 =?utf-8?B?b0lrRFVYakI5NkpCUW9WRWlVaFFUS2Q5QWNtTStFVG9FVEV0WXBMUWNqK3VG?=
 =?utf-8?B?QUFzZEVyYnh0UU1HdVRqQVlDSjM2ME5xOFZvZEZjbUJ4amtKSlpuRTVxbEhC?=
 =?utf-8?B?VjM5Vk1uNjhpWTJPU0Z1eHh3Zks5VU1sSEtieTQvc21SM2REZmZVdnBZdW5h?=
 =?utf-8?B?NVU5ZXBlNWEwUTdpNis2YWpCZklGZHMrRzliS2owaFRkdnRqT2JhbEpoRHJj?=
 =?utf-8?B?UEJJVVFRbjN6bVQ5eXMwWElUUFF1cUlTenVNcDhSZlcrUzFSY0hnUXdKbXhZ?=
 =?utf-8?B?bnkrQ1huSWxkcDMvMDJzMDJseDc0b2JDRFF2NndyQmI3Y1hIR0xTWjFWQm9u?=
 =?utf-8?B?dWtMTkFCSUt6VkJpOW1WcW02TWFVTUNZOTFsUVpRdVpSRm0xbGhUcGtKemFH?=
 =?utf-8?B?VnlvaUovWllsbXhwZS9TZ0JENHJNb0g1MXdpcVJRUVR1RVFmWkRhaksrRWVX?=
 =?utf-8?B?QUZQc1Job0NWNC9QM0krMkRZTTFHaGlkS3FlZ3pEdWJIclRscFNKWUQ1VXpy?=
 =?utf-8?B?MVoxcU5pM1UvVHE5UlVJOG9ZdjMyemtYWUhEWjVPeExhaWQwWGordTJ0ZEdD?=
 =?utf-8?B?TUNUTDV2eXJnd2ZwOGc0TzRuUEViZkJvVWJ5KzNhTWpkL1h6L1N2YjJyQ2lv?=
 =?utf-8?B?NFBZRWxIRStoc2IvK2wrYlJxWEEzOUR2RE95SWdBWUY5WUIzYVQvZWdSZ1By?=
 =?utf-8?B?aFBuV2tWVTh2VjJ0ZWVLc2ZtTTEwaktFYUFxQXEvSDZFWGVTMmRRZWlIb2h0?=
 =?utf-8?Q?/FM+tXvPHN140JYE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c54865-dfd6-4907-d7ea-08de4e109122
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:16:59.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5t4gDTHLVGoFrFfRLQqGXoZNCrt8XAloPb7KBKXiX2vSIdRbNTjlU+v86QrCl8uWKuTXn1xaT+/hDu6t0M/NLNhCNJhcCuPkU8YOEniToc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16982

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgNywgMjAyNiA1OjM4IFBNDQo+IFRvOiBDb3NtaW4tR2FicmllbCBUYW5pc2xhdiA8
Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+OyBKb2huDQo+IE1hZGlldSA8
am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kNCj4gPHJh
ZmFlbEBrZXJuZWwub3JnPjsgWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPjsgTHVrYXN6
IEx1YmENCj4gPGx1a2Fzei5sdWJhQGFybS5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgR2VlcnQNCj4gVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT47IG1hZ251cy5kYW1tDQo+IDxtYWdudXMuZGFtbUBnbWFpbC5j
b20+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBPbiAxLzUvMjYg
MTA6MDksIENvc21pbi1HYWJyaWVsIFRhbmlzbGF2IHdyb3RlOg0KPiA+IENvdWxkIEkgaGF2ZSBz
b21lIGZlZWRiYWNrIGZyb20gdGhlIHRoZXJtYWwgbWFpbnRhaW5lcnMgcmVnYXJkaW5nIHRoaXMN
Cj4gPiBzZXJpZXM/IElzIHRoZXJlIGFueXRoaW5nIEkgbXVzdCBjaGFuZ2UgZm9yIGl0IHRvIGJl
IHF1ZXVlZCB1cD8NCj4gDQo+IEF0IHRoZSBmaXJzdCBnbGFuY2UsIHRoZSBjaGFuZ2VzIGxvb2sg
b2sgZm9yIG1lLg0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiANCj4gSm9obiA/IEdl
ZXJ0ID8gTWFnbnVzID8NCj4gDQo+IA0KQWZ0ZXIgdGVzdGluZyB0aGUgc2VyaWVzLCBJJ3ZlIGFk
ZGVkIG15IHRhZ3MgYWNjb3JkaW5nbHkuDQoNCj4gWyAuLi4gXQ0KPiANCj4gLS0NCj4gPGh0dHA6
Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZv
ciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNv
bS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwNCj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5h
cm9vcmc+IFR3aXR0ZXIgfCA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby0NCj4gYmxvZy8+
IEJsb2cNCg0KUmVnYXJkcywNCkpvaG4NCg==

