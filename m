Return-Path: <linux-pm+bounces-35309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E10B9C3B0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 23:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472143B3B0F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2827B4E8;
	Wed, 24 Sep 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2kscQExZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8E24679A
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747932; cv=fail; b=NB1rbmPKmXcARVQFoGY40QsIMtc/MUJ6iIH9ldHwAb8jwtHDQIhlp/oW2DkXv9gP7LX5DKtsC4fKEIVcvDx2YGAI8Nb3/p15/jNwR5/7qA5CBM6yWPbE0Af9SNOCzbdNaCP2OYr/+v5QshQpQA5/NRoWYGFrWPwhuzerCMqZfII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747932; c=relaxed/simple;
	bh=UZp+toyN/SPRy1nUiolzFIATixshIv5czXTkmLgXFfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kq83tBwXpofC/9aDb7rV+QCkVO/8iKF6zxsDNMFVII/KtIoag18p9i75qyTf1Tk2vj5N9+to1w1a3wbUmI70nULE3YA7lcIowCQnAxvwx40e8aAO/tkPGwg43e1MgdWl9xkcAH0egCbtPY8oelG6jISyD7zKAecJq22XILybjEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2kscQExZ; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcXUVijeFC7MxiMc0rFki9lKIlWaHxfPnh6JNb+6mBhKmoqO2r74wQniyAa6SLu+3EXpx7GvsQHeRwLDCoLOBZQgou/wyx4DP38q1wxae/RbEjDiJG2w5V+6UpyJOrwLuEgQYV/e3egwkKOfT29lDZeu41oAZ8dehvha2xnvm9Qea3v3thW+R3uhfsiqxlMRRPR8rMy9T1h7u0hLFVUgk8eDOcuCR/MgDPQgL4OWgF9aHCEhHJfIp/zvt1O1me540A9dVUJPR6HiAxWU+QaeW4Ek0CJWaTdl2MgNxk7WPLRW9Aqk9z1NnLlBaOEsdKJXI5SDi6mR9aPHDn2f9DnyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+u/YVMTqyWirOKuknt/IkOlccuKCFu22reBdAQpMC0=;
 b=Ob49PyxPbqVllaPkEmw0K+JP9SUNhV3VGZqJI1TdbJJnEoi2PHbRIrZf4MPBCd62EqhxNXSgpmLME38e9A5vMwkajRFp9tcf6u1MkPwvOHfvLYNl8GYZBCcuOXh3oFgbIJAjTgld5KdK6h1v+OG5abSNPz77k0l0g7XT8y66UF0OGETw7LwiPAtMfFdZ19iA3jYJhKrSdOMurOMXW2jtLkIoUD3lZRQU/GmjeCwP/sF/2YGWBOIhRrnuvrh3yAlkBcIGmlMBPjwdVbqURq4z6b5+hs+goFL9WIy+t0VM/toJ8d1IcELmIYEzK8VoO63MXIDvvIqiZy5q91+ZygQOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+u/YVMTqyWirOKuknt/IkOlccuKCFu22reBdAQpMC0=;
 b=2kscQExZxozyrhxUa0lz/fXkSm5I8wdqnqMsXZ/Ff3ap5hnv/0HowXPoTWmttrSchlU+IKJflt8VwU3GmJwJB6YL9VQM2LCvPhdQQn0QPC3ihCh7TnqwUKeCsS/d12zN/W/qSTZDYCWvjjBJP16wvrbUUR8/fIl7QsQ07u7lllA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Wed, 24 Sep
 2025 21:05:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:05:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>, "open list:RADEON and
 AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:HIBERNATION
 (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita
	<ionut_n2001@yahoo.com>
Subject: RE: [PATCH 3/3] drm/amd: Fix hybrid sleep
Thread-Topic: [PATCH 3/3] drm/amd: Fix hybrid sleep
Thread-Index: AQHcLZUloZBter6O60GIfLpv5HdE5rSi0nSQ
Date: Wed, 24 Sep 2025 21:05:25 +0000
Message-ID:
 <BL1PR12MB51444E3CC8CD7F3DD65F7115F71CA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250924205211.1059571-1-superm1@kernel.org>
 <20250924205211.1059571-4-superm1@kernel.org>
In-Reply-To: <20250924205211.1059571-4-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-24T21:04:37.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB6710:EE_
x-ms-office365-filtering-correlation-id: 2361dca3-8481-46e4-d7fa-08ddfbae153c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3/cEGsjgVBGdhUo/p+URF5sGq0pegZUU759dXB4wziepzLXM63ux3WssOjS/?=
 =?us-ascii?Q?QZ9R6tmhF9TduyUWEAZ8ry+W3N4vmY08qJ7dB3H32fCnLEDoCUo+BKD8l2pl?=
 =?us-ascii?Q?aKUxlk885O/YZ2n/FKR+E638UzD0BLNI/F1DxOXcUheONYlr1Hk1bF3nDS3H?=
 =?us-ascii?Q?+5nk8PlK1CFC/PogBlibi5IaDFmNJ0wzstMzNcxBuUb8x9lfWxJAvgPhxLtj?=
 =?us-ascii?Q?UEiZm09gLuEDaM+aelErUieONIfD69ET6VO3Pv1AQGv8iIvOshEV7evNyXWC?=
 =?us-ascii?Q?BUapkjv9y6WTocn3LKfLIWe+9YZa5WBQ08V+ovp2p/IsgtNaG1BFV/3aZXFK?=
 =?us-ascii?Q?fLoz6l81s8f031kzF5vJxnnXjZTxKtIOFy0Rx51YiWi1f5pw+qukhY100x8Q?=
 =?us-ascii?Q?0PnqWK/r2rQqkDQEZW37EiJR0z8Ykbx6Kc5R7Zzld0uU48Opo3JMUrhseXQR?=
 =?us-ascii?Q?tu/tbr8zQI2RlLqZdSiBj0u37wxB4YtLIOTDbFK4Pjg+fDLM5upC+oB13LjH?=
 =?us-ascii?Q?1BaDeJWf0tHkRAtG6xnrhnQs41N7DxaViX3jkYXnnsFxB/t3l/Lu+7AgdCc8?=
 =?us-ascii?Q?OvH+NBN5EYNOewO1o28CikAssJim5UBxluuzsgFalXiRjGSebnHfyBpQkyAn?=
 =?us-ascii?Q?A9ShJD/uoZMwdawnHpngQVo8svF4vuA6/pkaeOYxnIb8EFDn/qvDGCjQT8wk?=
 =?us-ascii?Q?kWcq5noP57lYz6aA1/FExV+gcpnQkcMzJebRZZ4W1EdklsXiY0EmlLR/Blg6?=
 =?us-ascii?Q?F6rR8Op1e+UY80TIXP0v6ZMAm5M5+3jeThlNN1el9IzJLeuBWkhWDbq8oRtI?=
 =?us-ascii?Q?rDgEK8sGk2ZNOlN45Bp4gJ3gpmMQutkSCT36WLNNY66elIjxPVDuZ54+Vcdg?=
 =?us-ascii?Q?fGUuCt3Y0C+YG+bHU3C599INphu2V91zIRFiY2kmQdQUd/f/KHpkVtfvC2or?=
 =?us-ascii?Q?WiN5gxNs6R9wCi7XoOLbNJ9QvG23CvV64lnsRqTWu3PwyClxISIDWA1WE6Sh?=
 =?us-ascii?Q?O8XGibSvb0/scMgFHV+DkSjkgkmDy1NTf9ypZdcyPD4kyKGFFfdg3ZgGmU05?=
 =?us-ascii?Q?IrpbvlZFtaDJWBqxqEN/RBFEkILjbrTCoNr/oOg834SD39wP9oYkQYTF3+FA?=
 =?us-ascii?Q?WNU/GOdBua7dl4iFBqToIzKr3qELy3rKTPGBX285AQSz8YI0w1DBt66b4+CT?=
 =?us-ascii?Q?6E5yZN3OtILA/BU6OLW1e6zSdsIdE8Ok+q4nEu8WvRiQU2jkMGJ3oSJuj42C?=
 =?us-ascii?Q?dhq1yT6Y2E4CCQmA0taJHE+pU8IMmHLFtQZiXi0pgS3W+QazDMdc6ISqQVHe?=
 =?us-ascii?Q?48WGaxkyP8MCoNcVLQz6wnZYRRFZaaxjU+t7VCWgJC/fi/MEEHJcFQdmSOWg?=
 =?us-ascii?Q?z5lwQTkddzGGA7M4WVaWO2WS35rSiOZKQIqNUqoebyWBXRrfbFMUQ2PZQiEn?=
 =?us-ascii?Q?seW9RgfHnDc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4hBSa1MsUB2Hv6gx81Hy3zVZR7hNkMNAVikyOvJa0DESABA3s5pHL2ZWyGpx?=
 =?us-ascii?Q?ajQBo2McuuwbSdfhUDvIvfdfLDtLCRzI12d+LDWsXr3CGhTsSCL/HBaEcwHX?=
 =?us-ascii?Q?ZLLBryJ1MX38h4a1sGoqh8qvEh//Phsd3mKaDxBmNJ19QN+EcHophorGHgkW?=
 =?us-ascii?Q?u2VjMZ/t3A2oOL8jUJgauuqVXavpBp9B7HHwbY2Wzbj+bUUSiV1gvsB5KlXt?=
 =?us-ascii?Q?itjigHuX+S0HJjXctHZk67ibZoY9SfXI20nVo7DcOKiK+bzir/vLeo3jSblV?=
 =?us-ascii?Q?2IGggLq7RgfGGkUeNZsRXoS/lO9fK0n/VzBxf62tpZIU/NkjEyzdkKzgnF/K?=
 =?us-ascii?Q?YesS6yF1bHVNBtj5HIqeTVZKNi0Gliwa1wbcdZNSUBS/a2GbJ8NkeP5Sb4YF?=
 =?us-ascii?Q?Hmm++eex1ZDGYCdDsegwv3mdlgJ4xxo615emj9BqFmOis+LuutSC+N2DrXxf?=
 =?us-ascii?Q?2pgbYhfirp9t3yPR2jkDJi3mR+kz21MB4UCKmFtWEVnoK/zc+YZgAO43SuW2?=
 =?us-ascii?Q?lcvKlHzMwJOJh3QPTEN1zGn230jwYL5zFC2ndBEaAsU9xTOJHOcBcv/r2yUc?=
 =?us-ascii?Q?ZB6uCOlyVdLq0gzM1iYzClyQ/0jNnEPMKpbsbWaOZ3xHZbKsQlpkZcIcmnrI?=
 =?us-ascii?Q?J646S5cyJ4CRxXeOv4ytXp5rt2Iu8zF1mmevW0PxX8gzJluRpmBPOEeVOEKE?=
 =?us-ascii?Q?1D0nVMgo8ajXLFKm5A9EZODs1LLo/9aPb+wMzDCCdCDq+nGCgcfcy5XMKsDz?=
 =?us-ascii?Q?TxwCwA13dHqeHT2QnGQzljqdl1qkduG2aPZaDLqRF4dZgoNLTFx0jIuRlxeO?=
 =?us-ascii?Q?nC+T3YAwbUWIc0SiDcx1cuSr2TnV5QD+Cl8Z310lWqwMgqWJnwLZeHUpaqnw?=
 =?us-ascii?Q?BJaWHXM0z+9Kwfl38YpXbhe+3bOwEMwrV8n4O8mxBHMinNrW9ywpvq3KsQ9U?=
 =?us-ascii?Q?/82BM3OWTe6pS2NB8tcvN5BkOO8onwann/wa+uU4VVQi+jaYzG0BbgPqGqWO?=
 =?us-ascii?Q?4i7AQSNLmbMMM0N7yQ5n2jEV1H7HwUNIm/FH9Wr2n4Bfr6qMo9pAm8bwksPy?=
 =?us-ascii?Q?TeDpyvuH53z2eHqLlTw6mTVVWcBRS3McGiCYBFpcdvgSWuTxlydE2le64kHL?=
 =?us-ascii?Q?q4Wqra2HJh70CtVLdZfuEm7tnV1B6FrmAwTPagsU2YPsKPUMOcQJZcX+dwha?=
 =?us-ascii?Q?wKJVOilRWzEf+g/F7wNADlQXkBhRkbq0zmTXHwILfLRLAgXxaiDZCW7uNCRx?=
 =?us-ascii?Q?t2ZfTLzt1Wd5ukG+Lhw12XjZEbZDhxJbVHLl59QCLSQib9neebiSruk1AuJL?=
 =?us-ascii?Q?aYy9wocaXMn0LzSYhVrRnus2wxyDNCjcXd1p828Ri97l+ShETG8Ny2E7VtdS?=
 =?us-ascii?Q?YGBCcrhpHDXV9CJuiF8iO6PQw6FmZKkNtDuSXqiAzNtZcoUEdafJSeVa6X3+?=
 =?us-ascii?Q?m0D65gcaaMDPPqSv2vmqsWGYsp1CwMgtnw1IFp8U7MrsGUlhaIMrBaiMqAdx?=
 =?us-ascii?Q?HYZTAHA3EdhNmT1zpbG9f8yCHKBU/5eU+ONhuRB8o5J1X/bue5Swi91N9oIz?=
 =?us-ascii?Q?DP3oiRhIT5RLvxXVoqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2361dca3-8481-46e4-d7fa-08ddfbae153c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 21:05:25.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyuGlkeUWoRRbDMpe49RuDhVssh7PMU6HFfPNdgmvNawz4UbxpTPBY959/f9LpzFOhpbAGCO8vxWz6xiT0J0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Wednesday, September 24, 2025 4:52 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Rafael J . Wysocki
> <rafael@kernel.org>
> Cc: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>; open list:RADEON and
> AMDGPU DRM DRIVERS <amd-gfx@lists.freedesktop.org>; open
> list:HIBERNATION (aka Software Suspend, aka swsusp) <linux-
> pm@vger.kernel.org>; Mario Limonciello <superm1@kernel.org>; Ionut Nechit=
a
> <ionut_n2001@yahoo.com>
> Subject: [PATCH 3/3] drm/amd: Fix hybrid sleep
>
> [Why]
> commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for norma=
l
> hibernation") optimized the flow for systems that are going into S4 where=
 the power
> would be turned off.  Basically the thaw() callback wouldn't resume the d=
evice if the
> hibernation image was successfully created since the system would be powe=
red
> off.
>
> This however isn't the correct flow for a system entering into
> s0i3 after the hibernation image is created.  Some of the amdgpu callback=
s have
> different behavior depending upon the intended state of the suspend.
>
> [How]
> Use pm_hibernation_mode_is_suspend() as an input to decide whether to run
> resume during thaw() callback.
>
> Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Fixes: 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for norma=
l
> hibernation")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Feel free to take it through the Linux pm tree.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 395c6be901ce..dcea66aadfa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>
>       /* do not resume device if it's normal hibernation */
> -     if (!pm_hibernate_is_recovering())
> +     if (!pm_hibernate_is_recovering() &&
> +!pm_hibernation_mode_is_suspend())
>               return 0;
>
>       return amdgpu_device_resume(drm_dev, true);
> --
> 2.51.0


