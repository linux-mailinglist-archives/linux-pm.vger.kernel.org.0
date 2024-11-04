Return-Path: <linux-pm+bounces-16911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160AD9BAC0F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 06:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F31281746
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5D1791EB;
	Mon,  4 Nov 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fu4zNAJd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5691175D44;
	Mon,  4 Nov 2024 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698256; cv=fail; b=ui6LCzSm+3n+K4C39vx0HofzsOx79GdAQQu47sHBdwe2DJX1wPX50x+0FrfXWeTscSU/FAWmqPAshrgu9VKqB62Txj4EMYpQ4AaDcXWnxvOVVUXMPsxGlmb8vTpnL2BOXaVlDmji4KKR8/EHduDeHstcgzZz5cqW4TmkT3h10PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698256; c=relaxed/simple;
	bh=JqaRtIWkNSd9B9KrfDECGMPTMUMkAYygYR5fbK5Hx1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUc2tJ57rVFf5GaIgsxRd2nXj9xObqjxAi+aV6cSjxID0gnHqR93vAosZ8N2077BxPEpbm1QREg0MA9/SaUcz2d1oPHKuVYoPaCsJ0Z5gBcsMZPs/oBiIIuL7AhTazHy1QAJNhCMwem5CQQ9V83pvc3limlNfrAkXtKgueT2G1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fu4zNAJd; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Njf06024614;
	Mon, 4 Nov 2024 00:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0pa/z
	9vdlvjAuXsH3eViEQ63zoKZSWnTjk5pgg1pe9k=; b=fu4zNAJdGVSZLgyO9hvWj
	nYymp7vW3c5JHmVUsazbbB/6vNvLB7zUIUan3BEybXtZESxgGw+yWjX7NsNsww/j
	ZFJNHsxG/6zVfHmWfQkorBE4+1Noi+mbKJJcIFfs0Vhi8CpCG1sbQHNgjKmcIpMY
	TKiePM/qNCGtKcg1RGc+4kgXaaqqRZbej5/WqjlT2PNCY69dC77TGZ1y/okfuVCZ
	WcZd5SVyYegSyAYmPCz6MLivQrNUTEbaTWH9dVVtNEwG3ABpLuvefvd9TaqmvRGY
	RPcNkFq32ApahI0cITX/vxEJhSWbW216hfGeGm+RY5ZAtz/sDCk/QLFqobmMU0XQ
	g==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42ndx1srmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 00:30:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/RFOJtxI7vAeZKY4TAghnO1k7VmDwWrsBVg5Q0d/7vI8CZbg6nlUX4x+NHPLTa1vgk7Ded2QPIT1nHhYHtF4ovk7aNnnJhGNiROgbl5TYjQoqO4DfZYMAMVfKsyVsa4vqd6qwloW6O1hxFipPY6tGqmUtb5TYwP0e/j0Y2MKxJV/YZe3eCKfJbYrfDG7SWXA1o9xShyFUMoUGB+L02z1mex8glMTIkKew6qHlUpFJiw60BvscemyGlgJvkQ6kJ4SslINa7dPDE0xTA2vFpFyT796/tXZ57yWrfrCiJqkcDAAlnrsAdIDKM+uQ5KBM06C7MtLpiPPHVmtmkTOFxXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pa/z9vdlvjAuXsH3eViEQ63zoKZSWnTjk5pgg1pe9k=;
 b=mB0IerLGUFA1uubftzb7y3JJ9BxJnqnAZgXeoiTnvjv68vwRm+o2XeSaE8rRSD9GpZbWDA3NwlYzXc18UBp3gqwsjGH+s5bv8h9T780SckfV8+uVJ3Qy0Apc8L7OGNh/c3OXOTHLqCR0Y/OzIT6NuGs2W+ogp9DfmOpxYBdU9wSwjbXzl/1G1QGyBbqwwR04o9xk8e/VcS62wQY+vNP7hMDNT79nB61AWKIeqrwx1+SyX4Ogl861PMGNsVF1iUtLjQmqYRzG8zA3TOY+KOGi2fqneT9oh7Ydlb67r+b2vRMceUxJcfCNvOQmlRzObIMrEJbOPwjuBCaoLGCtrv1+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DM6PR03MB4937.namprd03.prod.outlook.com (2603:10b6:5:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:30:23 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:30:22 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian
 Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: RE: [PATCH 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Thread-Topic: [PATCH 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
 ltc4015
Thread-Index: AQHbKMXUZUBfcPf8c0qms8MeicQd9bKmobSg
Date: Mon, 4 Nov 2024 05:30:22 +0000
Message-ID:
 <PH0PR03MB714141F88B33985BFA9C9707F9512@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20241027071852.56240-1-kimseer.paller@analog.com>
 <20241027071852.56240-2-kimseer.paller@analog.com>
 <20241027231320.GA217360-robh@kernel.org>
In-Reply-To: <20241027231320.GA217360-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcjJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lMTAxNWE3OS05YTZkLTExZWYtYWIwYy1iNTEw?=
 =?us-ascii?Q?ODc4NjkwZjNcYW1lLXRlc3RcZTEwMTVhN2ItOWE2ZC0xMWVmLWFiMGMtYjUx?=
 =?us-ascii?Q?MDg3ODY5MGYzYm9keS50eHQiIHN6PSI1MDMwIiB0PSIxMzM3NTE3MTgxOTkw?=
 =?us-ascii?Q?NDA5ODYiIGg9InJEMDJuMXdnUUZLRXkxU2hqU2dUWFR0Nmx5UT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RGFHMXFqZWk3YkFjeXhEVE1SZGFTaXpMRU5NeEYxcEtJREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBZnB5Y1dnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DM6PR03MB4937:EE_
x-ms-office365-filtering-correlation-id: 547387a7-43f0-4a82-cdf2-08dcfc91c75a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nan73t9bnQXmcYKakZPMmTuBukuK8Ukukt6v3egjgUK3y4Qu3uIr27xPechr?=
 =?us-ascii?Q?Ss7SOXVGJKDHAprJosVRwBB3l3Y+fOS73VYzVs+Nk1EQrg3yrJAaIBQtGfpJ?=
 =?us-ascii?Q?671RVdh/gPl8FPSg+05v/gk+MjPsGwJCeN1piA6hEp/6pQH9lChCNxTHu2kA?=
 =?us-ascii?Q?2ldYWwbtPPmTFgMPGihMqcQvfz7FrCphAelpfDhY8seosVU/dRPCI46fAEuW?=
 =?us-ascii?Q?2LkJWq4ItgmjzHOveVlgFd9rdvfSRRZgDsLMBrcT2bSIFRRr/5R2NjkXT3Kn?=
 =?us-ascii?Q?KSdKwk73ra0DcfcRA9ppU74eov6xckIKws112YyIKhjBtrqdVd5l8mTBSj0v?=
 =?us-ascii?Q?oiMW3eUfTu+lWENu0SYrtayr+d6tAgFCcKWEbtMsw8NxMNDK+g6HKX3P0cDg?=
 =?us-ascii?Q?vR1tqsijyoSMDmMCtF8ZVmTPLSmjCvy7VurBBEHDeLllHPJRk1lW/gsJ6TxB?=
 =?us-ascii?Q?DxAeGBhQU3Sk9qNL+DdI4IHeyfHHPEWnNAEz0euILqnknFhsPA6jxARYLo4E?=
 =?us-ascii?Q?1IzvSe0P/jAHQy5vVRno2kE7HpZ41bBNI7SX4dgzapXQDNBJ8Eng/zI1Evgv?=
 =?us-ascii?Q?VbjkvPkbyrLG1NlT4odYbDaUho2Zoa2Zw4tvHEYqp7w51ncCb1/4ovqOEBQt?=
 =?us-ascii?Q?x89Vcwknnz52NgCfRDJGEE5XpVmF+JnNVG+YbJJxsewWwb+uBZGpwSAAaeAM?=
 =?us-ascii?Q?k8KFcY8buSXJ7jAkQeG8vpjrZ2JVmpR76n8QCcPIiQG5DBf+3nyWSRu/8c4l?=
 =?us-ascii?Q?39YOT4WRiScDEqGC2OnAoJHCRS2DU848/THUJXejEWptkTgcLgbQly3T8kuk?=
 =?us-ascii?Q?eY8soECcg+QsUuV89hEKMqNkgO5AggJQC/pW5OwXe3suTeClKaW8xdCUhLwr?=
 =?us-ascii?Q?erHPURQKK4bDMA5l02GUPEZLp7DAMv77BfURWIsWDb9HUqtezX+No8sfU8gX?=
 =?us-ascii?Q?Ji21SI9S6dijU0XOComPfMoJtm4ayfpH4vRcJmahIrd0W39KYUmTP+x8KxFJ?=
 =?us-ascii?Q?pzQoAXgwV/JLpIcU9ROuQxis3GLKLoAor3bUGJAvdTbo2wsosIMh1g4IpQVu?=
 =?us-ascii?Q?WMwhRB7CNAJhvRSAstlFWrYE+Um/bk3AgzjjnZ4TesUdgjca4H5jbQvZ7GOf?=
 =?us-ascii?Q?kjEMLP+Fz398wfcpJJyd/b5oB7rP2ZMmTNSh28ibxgsklMYu0YwG50ZrEG4C?=
 =?us-ascii?Q?lSMVZT/Yz7xpbYHFZiEGVdDf2vGOOqRV4WDlZQICVjHKSg/Ru1i0NdXu8TtU?=
 =?us-ascii?Q?BTl6y6C00iCMHeM7+vQB0gQLeupsRVFPEBTn8ONXEIEyYHIWjHav6yovxNMw?=
 =?us-ascii?Q?Hi0lYtXzMvGLf17M/OU5iMdVHo74tC1WNccNEoE31NkM6rajsgsrkjFzv3qF?=
 =?us-ascii?Q?A6q5bbw3IIUqhhgsC5o4O7QCVDg4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KKjC5dj1lJQ9exrEJ2UHYpQBhM/oVGpvFWrg3ye1qCxFkEJt9zdHhPjmEoeE?=
 =?us-ascii?Q?kO+6HpZBGFCx1xPQ4cEF7TQywwmoTcmpShHVZviwiWdlQXTMNf2lOoB86q1h?=
 =?us-ascii?Q?7OUdMnvA+wCseP2DxY1jP4YZ9KF93M/fnRmSINuF2+v0ockQtjPAf5GWv0bx?=
 =?us-ascii?Q?l3A10w6BI0Zlla8vki1OYEYYxsFkN6mpp1tFt9ImqIEbAjqoVfNGms37WbDH?=
 =?us-ascii?Q?Cu/cdRpHT4MLetlrSG9sc9CoRUdrRo/QnT3GsW/Yxtw9ye9Q8ec0EFRp1WY6?=
 =?us-ascii?Q?94iwy+c1k39LHki67FpFqp5YYpXhqETffGblOW3jnZQp989Fd3UAp65DUUfQ?=
 =?us-ascii?Q?lLOqyvtCh6O4KXwsr4XkoGOGsFfVLz9AMKuMPcNCMtNOKozXsvFSQtUWGukO?=
 =?us-ascii?Q?/ZwB1hPkyzABywKo+e4ZEv/ysMoQR1vLdc7H8wLd5EjuoG6SecZWLMsQgxFM?=
 =?us-ascii?Q?hKMxvFZZJmZgRt0LALUI0J7oO3HR2kR2dnBj8kSUBEiblUUK+11BkBZh8nah?=
 =?us-ascii?Q?u36asEjjjqsJxbmfU3HZHLK7s/3azWtmeNiEX6/Yi2B7LAJu1KEG5HGY5oke?=
 =?us-ascii?Q?n8Jon/iIWTJZMQOY6zTEu3NusBvmNTTm/qn1v9/PA/egicWLYk2dd7EZVT9i?=
 =?us-ascii?Q?scAUHSfdwv1cW9pYZ1AVgTKA9gOK7NlX0ai1fdeO/PXrdX3BcRCcAzcK9G3R?=
 =?us-ascii?Q?HTRDG3WP356zuPEB/PaROpp8Dd9JFJL0Y/2jdFM2SPjgP9hAxizmM3UNtOKI?=
 =?us-ascii?Q?8SypRYgMw1ENgbEx8hrf2Fj3BgSFyRFRz2BhJeD+BfOsgKR0FK1AL4v4dtoR?=
 =?us-ascii?Q?zM7hzZZS40JUt3ofzIbi9X84PdulZ3HQ3D6MGsz5RenDdnP3j5hzhAshj/73?=
 =?us-ascii?Q?te4sS5i/HYLONlOkKDI69HKsWm8NSFbxFIb0Zz8rTE3Wi3XMW5iUBj/B6Z64?=
 =?us-ascii?Q?2Rwi0UkKPfaEpjI3SbTNWPEn0iH/7CMv7xvOqJOId/9BwTzRnnYq9/QBvVUi?=
 =?us-ascii?Q?rPLJ79pKsMaLmzZrmNeLdgXfUnWyQNXi2sP0H10UFagcBzBorfS+dLW48XuO?=
 =?us-ascii?Q?hOTTorbBWen7GJoHxyAkboX6ZeivY5m6SCIrnGfb10D9viDrmlVWAye1G73G?=
 =?us-ascii?Q?9+OEjoNXjOvUfRnKgGXwJG4Rm/uuc6MghjDicdTSSqxS+iW5pQIuiaMmSxTI?=
 =?us-ascii?Q?hVzGInmVqm9ZfMWBg3agFPub+GeUSjLUoxcppND/zWsGrt3MbmRS4YKmrA6T?=
 =?us-ascii?Q?PE+hIpRlFhWbDqfa/0sg53plXQy/mryehDi0nRgCmwA3hjkW01+xuTOXBXym?=
 =?us-ascii?Q?pQZFQnECsBqdEZA839W4zFM0yGmH5Z+ZF7qya0CjhPS3GUMMPjOnc1+/Ueqz?=
 =?us-ascii?Q?T1OO99OJSonyfAjCmQ3ZN/kquVIGlwx7dIPqM5O9OxqTZdLijhaHeyI1Oke+?=
 =?us-ascii?Q?i4ezxp+vBth8/FJg5PnPemH6hexGDsfzvm+IODqHjjHYKwOatqvreewUk/ln?=
 =?us-ascii?Q?CX9UMHFLTKtsjYVGnnhNw2600CCwRVQg62SM6ZOYr0ro8B1aCDwQw/yi3c+g?=
 =?us-ascii?Q?va+4A2SPIB+NuO5nfrT6A7p043uptmTWztl/Mp0J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547387a7-43f0-4a82-cdf2-08dcfc91c75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:30:22.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3QGIQhbsg0iq7Br2swtyyt4nqI80ny1mpePbXTGESKSkTr22C7nxd87XTDgwbQOlMolv+tjAJhxhZA00AAL40TcFWmNu9L/VD62Q1LtLNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4937
X-Proofpoint-GUID: AhPps7JZaL-57sNVoW_XU-MhoymTvRTD
X-Proofpoint-ORIG-GUID: AhPps7JZaL-57sNVoW_XU-MhoymTvRTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040048

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, October 28, 2024 7:13 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sebastian Reichel <sre@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Mike
> Looijmans <mike.looijmans@topic.nl>
> Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Add ltc4162-f/s and
> ltc4015
>=20
> [External]
>=20
> On Sun, Oct 27, 2024 at 03:18:51PM +0800, Kim Seer Paller wrote:
> > Add support for ltc4162-f/s and ltc4015
> >
> > - Add compatible entries for ltc4162-f/s and ltc4015
> > - Include datasheets for new devices
>=20
> What's the difference between the l, f, and s variants? Please make the c=
ommit
> msg describe that rather than what I can read in the diff.

I'll take note of that. Here is the difference between the variants:
LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

>=20
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../devicetree/bindings/power/supply/ltc4162-l.yaml         | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> > b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> > index 29d536541..9b546150d 100644
> > --- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> > @@ -17,12 +17,18 @@ description: |
> >    panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
> >
> >    Specifications about the charger can be found at:
> > +    https://www.analog.com/en/products/ltc4162-l.html
> > +    https://www.analog.com/en/products/ltc4162-f.html
> >      https://www.analog.com/en/products/ltc4162-s.html
> > +    https://www.analog.com/en/products/ltc4015.html
> >
> >  properties:
> >    compatible:
> >      enum:
> >        - lltc,ltc4162-l
> > +      - lltc,ltc4162-f
> > +      - lltc,ltc4162-s
> > +      - lltc,ltc4015
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.34.1
> >

