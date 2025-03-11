Return-Path: <linux-pm+bounces-23838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66783A5BF49
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084BB3B2E2D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B49253B46;
	Tue, 11 Mar 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="f4xkSULB"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD321D59F;
	Tue, 11 Mar 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693126; cv=fail; b=Tjt8Ljx1WIs4EPcIP/JmEr0ulia/RjrKZKBoBJUyZPO7mJMTuuM/E5R/lxTRiwjEi4kPYnEokgzHfAusGUgzkqzGVm+dhvpY7lNAOrDubHXlau3WRZL7NVuW+OiFB1MjQMrag6cxiB7pGiNgY0De8QFn+Ldp+X7mcWMLsCRS8oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693126; c=relaxed/simple;
	bh=qwSQnUSqP2zoAwe6d+6olsW/QNM+XEn5/Mjlib5+gt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrlOkWZ4AkpW2N7mKVrPCW65EIeFHCTAyF9yyKZyHY09Z0mmvLVNch7yWpwQ8LozQv4rmtIysk5/zUiLn911yv6SR5EtPKkSZuDn7MHcqx4K+ON0oGmmRZtvKGuMxiXNkEojeswE0T+Ab1TvOePNJNgybfh5jw59wQnQfBoQz5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=f4xkSULB; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv8Axxt8Vw6uQtzik/j810U6gUdaVfzblaXi/agJXfubmfOBM3DDd5Yh0Jfvosl54I7Y2Zs/goODNFyCLBV+SMATk683D5IOloutSysZtgSSCHcxxWZpbNkRRT22bkQCbphilT3PKFAoNd09jy1j6oQpQaFvVJxEK1DemdVKhqwx9FqwnxjmehvD9Hb2f/K8tWc25Uofn0v3OSUt8UdM10tvbvhqqul4RPKtXU9XOKDrP1GfvpTzSVWYgtJunYD4z9PQx8VL1kWBNMpMwIzAeZFHm1yEId+qmQYhd2AqoLDfSnl0apzQSFR/CriA3+H48u+FE5QHR2PTpad0aQMv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwSQnUSqP2zoAwe6d+6olsW/QNM+XEn5/Mjlib5+gt8=;
 b=qw9I5wgAMDiVwxiYAK0+iIyiS3WsGt4bQ/802xfugtKRsQyG1K5bnHj2X4qQpHWD+MEK0XVhSdSZFPFZ4AUZjsSQ7mEcWuNPGTWoLC4R1tzAbsR0/ARwpSKcOr/iOa+UkYop3UP7jF+IL1NcRInQC0RSJ45CH9GqavtOnBbX4PgsuhQpbCNTr0sw+bJkQGoGTKfnjtk3VDYazGCNRvydghFVXuIamLUtBd8vumdP2zdGVYZ1fLhCD4+o+vjqqWvydXVDWze7QnsKJUeWoFS6wviVciDKNB4IALFgy3ZOaaSQ+PsxUL8Gv3H5ubIg8XXK6xpVt6ddtu+w3ijZP+Yy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwSQnUSqP2zoAwe6d+6olsW/QNM+XEn5/Mjlib5+gt8=;
 b=f4xkSULBSZiiChsLqdfmjpTYHXAHYRQkG7E8uh6Qopy6LaBIiPvbnHiOB/KjB1n7MBq5D8LKw5RB9LIgNKncbs/rEGnDb+jn94liozO+ELxVR/FL6LtOuYHy5Ly1qABK+4X4HoS6VCq9AKdzGbBZe4qGcJKn50FA66kJFTnI4Xs=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TY4PR01MB14780.jpnprd01.prod.outlook.com (2603:1096:405:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 11 Mar
 2025 11:38:40 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 11:38:40 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "geert+renesas@glider.be"
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
Subject: RE: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling
 driver
Thread-Topic: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling
 driver
Thread-Index: AQHbkOyzMk7go+0SS0ecPf0EBnfnzrNtjR2AgABD9vA=
Date: Tue, 11 Mar 2025 11:38:40 +0000
Message-ID:
 <OSBPR01MB2775448875E8591C80AA40FDFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
 <424c0acd-61c4-40d9-b39d-f3b6dce2b3f8@kernel.org>
In-Reply-To: <424c0acd-61c4-40d9-b39d-f3b6dce2b3f8@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TY4PR01MB14780:EE_
x-ms-office365-filtering-correlation-id: c3265460-1cc5-4427-fb6b-08dd60914539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWlpRFYxRWhZb01xU3R5d2g4RlZDcmtoVGNQVWxGcjFQdEs3Zkh6dkl0eERk?=
 =?utf-8?B?VkF3WWpaSE1GWkQra2dwK2FaY05reVJWaDJDRFB4MVZpQ0p5M1BUTGpsSGlB?=
 =?utf-8?B?UTB5cFU5ZkxTeU1WUHVidXh4M1I3ZjZjaU9HamYxK3ZYMTdUOXBmcUgza1Br?=
 =?utf-8?B?Sy83UHhla2kzM0w1c1ZUclZvaE9KTWJtb1gwK2pMa1d6SEhTRXhJUDgyUURw?=
 =?utf-8?B?eVMzUFdBVzVUVlM1dWhvYmJTelY3Mzd6cFpiM3czeGpUWlVjeXpRWTVZb2xj?=
 =?utf-8?B?cHdJaEpiYy9SWFlRWmlmWHV5cnhLSWI2TU1xOWk0S0w5U1c4aGRsaFpNakdX?=
 =?utf-8?B?L0w3VGh2dERhU0N3VXVkMjh1cEZLaUxqMzdUU0kvK0Z1WDJidGFGeTU2Y1cy?=
 =?utf-8?B?N3FpT0k5d2VpeW1yT2FVRFBwdWhrQW9DM1NMVDhqdVhBV0Z4OGdZdTFYTE0z?=
 =?utf-8?B?N0s1eEJwSjloREVUdHdZRjVpL0Q5aC82MHZzeGRwWWdka1hSeitlUzFYYmcw?=
 =?utf-8?B?T0dFUlFWckZIVm5mOHQ3V3BMbWdzNGFWcWw1WVl6a0lON3hMbFVMbHRHVHN0?=
 =?utf-8?B?VDRPcmhtSUU0eVY0VXpNOTRJT1RLZnUwWWpuR1R5QjJUaWljTCtYU2NsdXl0?=
 =?utf-8?B?aXpXRCtKZ3J2RytTQ05nRTVhVE1sOUxTc3B1czliOEt4ai9RWDJqTzNoVXJt?=
 =?utf-8?B?QUdoRSt4SDRKY2l1bDZzcjUzZ3o3NnEzdGRXNXp2VVp2eEk4NXlTTEdvQm9X?=
 =?utf-8?B?cFB1di9nMkdiN0FCSFJHaHluNVc5MTgxRXdySForVkl5YUp5ZEdzcS9qbnF6?=
 =?utf-8?B?K3NsR1Q5ZnhyWXc0NlhQajhtalhwcVRNSGJTajYwL3NmdHBPVFVCazJjMzZT?=
 =?utf-8?B?SlFVRnowcW8yTElIQy8zbzhJMDZRWHZyK01iVXM0QytXNnZlMm1mbFg1NFRi?=
 =?utf-8?B?Tm1KTFVjQVA4S1ZzYy80ZmdBbyswUXpiTmUveEhqZHhtcy9ldUErK0t0TjJ1?=
 =?utf-8?B?NWxuOHNCbXY4SFpySjJ0NmU1dytpY2k1Q3E2YksyQlF5NTNxTC93YjFKTkk3?=
 =?utf-8?B?aXJBcktGVWlPZXViSTNTaFhFczhwWDdaQlN1VmIrTGdld0FhSEdYaHRmakMw?=
 =?utf-8?B?R2krdU5TUnFNbzNoaGZhVEZFR25oMmkxYWVXKy96TVkva0N6UkNtTzMzYk5F?=
 =?utf-8?B?eEZqNkYwSzhPNHNEY1ptYUMrcWVBdW1FQzQyWklPQVFWazhLUGdsQWhVc2Mw?=
 =?utf-8?B?Y25lUkliVmlQcXROeGEzUmhPNXhHQ1NLZUlJSXhreU5yR0l6ZUZaRGx6UmtD?=
 =?utf-8?B?TURBMVBTbElrTVUrWWhKVEFCcUliSCtmZkd2a21wcUU4MHBDdHA3NTFUcHMz?=
 =?utf-8?B?VjQxZ3gxc0JHTGM2RjhxRzVVMExJb3BTTDhhNmx3em82UEhNQVA4NGtwY0tx?=
 =?utf-8?B?a1BseGFPRk1OSEhaM3A5OTRTL3kyZXlBUzJiWUhjSGtNV0FLMjdGcHFqbUtB?=
 =?utf-8?B?dUhxYVB3ZDQrYkhOcTNqdDUyLzIydisvdTgvV2FkdkpoSWZMVDV1Y3JjVG90?=
 =?utf-8?B?YzVacys1azVQd2xjZk9sbitIL3dCclRHS1Izb0o0Mk1qdU4ya2VVZjJPaGpn?=
 =?utf-8?B?bE1LeU9lWnJZbU5ac01wb0tSNUNNelVKSDRBUU1DSDVvWjRpT21ydkROVnUz?=
 =?utf-8?B?K1BjbGdBUW1BK0NJRXorWFp5Vm00Q3BpZFdhVnBGek1KcVVMZDBEU09hQWQw?=
 =?utf-8?B?VzdBS25qblAzbWNSTkR1blR1VVVIT1hGWTVVYy9ETUVSUGo1NUpiWkUvL3B3?=
 =?utf-8?B?RCsrdlhSSGM2clUwb0hhWnA5S3I3ZUVBa3pHVlpCZjRCVEZLMTRwRHZ6eWM3?=
 =?utf-8?B?M2JWY1RrZG1NNm4reTJ5SDlRajJoU3pLOUY2U00yWmR6STNLaTdBUHZ3bFhm?=
 =?utf-8?Q?dYrJRe2SU0VvZWjGW2O7W43sDEQAJah8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUl1L0gxVEpRa2NCT3poMTNiR25JT2s1NHZKcEJFSVZMdWx2MHE0TThMR2ZV?=
 =?utf-8?B?aW9nZGw0K2cyNnpsV1lncUFlU1MvMG9panQ5NDhCQnFMd3pRWll0bENlNVBz?=
 =?utf-8?B?emUveEZ4SGVSS1hkdWJlUGVwTlJTdE1RenZoNnJVeEcyaXNJMWYrN3NkVUxF?=
 =?utf-8?B?TGFWS1FsRUZXS29lSjJmeVdzamZTeFRsTUtaZVZnckNiN3JTZ3RTVmxidW80?=
 =?utf-8?B?bVZYcHRrRithd21VcGg0QWk5enJNdzNueDFWaTYxaG9vT1gyMGgrZ3NiYmFr?=
 =?utf-8?B?OHV2QnUwTG1QM1NkbExRWDVyMDRIN3p6bjlIMStGRzIvUXpRbXhFNVRTd1BK?=
 =?utf-8?B?VDhDUThyc0pOYzF5NUg0REdGMDg5R0dILzR0eFQxcnAyY3NxUU5IVjVNcUdE?=
 =?utf-8?B?eFZ5ZGVpQ0s3bTBwd21QTlErL1lkL0tuU3hJcUViVWg4anhUejUyS0hhdVR6?=
 =?utf-8?B?ei9UaEtRS1pucEJMZDRka2tkQVdnblVRRW9aS3lvRDA0Umd3T241VXcvK1hn?=
 =?utf-8?B?TVVMR09KczQxVWovS3I4cmRNeUQwMVM1c2FjZjFtWFU5U1JvSDU0STVza0xz?=
 =?utf-8?B?a2tyc2ZGTVl2MjRnZHBsMTVhSDljcUp2SnY4ekMvSU1ySDBMOU0rWVlLNTlS?=
 =?utf-8?B?eWd2MjVPYzZHMVpBSHZiRktORFJRTEQ3U0t6NUlMYXllNGsxQ1U4RGpmUXE3?=
 =?utf-8?B?NExySGxSOC9iekZpbTJMb1prbU11dW11NVpWZUNGd01Kak1YZEQzR2ltRWtS?=
 =?utf-8?B?VVY4Wlprdk5aS0RUYzFHbG50T1JGdTdQdS9RNng0bmVVOSs3WW5iemRSa1Zh?=
 =?utf-8?B?bCtRdXNQMnBQcXVyR2JiZnEwb0JWOXk3YUhYaTZHTzUvVU5vMy9sK0gycHFs?=
 =?utf-8?B?Z1Ztb0NzbmRVYnpkLzBiTDRXMmRsdnZmVVc0eit3RmhhN3p5VEs1QVpBL0c5?=
 =?utf-8?B?SVNJQS85MkdRcVFEbHpzeFZGa3U1b2JobHVvNnZWZEVHeTQ3TFcrdWwzaGxT?=
 =?utf-8?B?bUlyQWgvSk5NcTV4OE5GSGV2blpaR0hueDgyVllMSW9PRDA4cDUwRGliUGlr?=
 =?utf-8?B?RW9vYjF2YnJFNHJ6NzluemM3ZDJSeEVFNlhTOGphWUdUM3RRY20zdlNxQTZo?=
 =?utf-8?B?eVhxeWxCSlFPTG1FTUhVVWN0emVKTVpucmtUREg4SGpidXNVOGZSZzgwQW4z?=
 =?utf-8?B?VktaL0ZDamlsRmpSYTNZQm5QL1dPaHJudUlwcE53UnNweXJGSmdMNTFsQnkx?=
 =?utf-8?B?MEF2UmdPUTlISzRYeVZVMXo3ci9PekdtaEx2b2l6QnFLeWppMHhFMGZkbHJR?=
 =?utf-8?B?VEN6NlF2a3NHaS93RUo5R3lUbzlrMDRtTzFBazF0YzZ1aXBwMytUejgzQmZY?=
 =?utf-8?B?aFZkS0Q5b09JVnNEdk1vVVg1bDJuRUx4K0h4V3N0NWE1S3lvWTJEUHFCdXdP?=
 =?utf-8?B?TENmMDBDbks3bXdWSldnQ3liV0pKU3BML2Jtd2Rmc044S1ZkUWwyTzhjdjBF?=
 =?utf-8?B?eUdSeHZIRURLdnVVbVFna3EzK0o3OGRJdlh0Q3loNjl0bElUQU1ZYWhvQVRp?=
 =?utf-8?B?anRIbEpsZFdkSWpMcUdqY2QvelNWaHhPcjdQMWF6WC9YckVUTGtxRkZqRkdx?=
 =?utf-8?B?bml1R1pkU2RwM3czOFgyMEFHRGtFZ2dsR0dDTkQ0cDl2bHNVNWZ2R01CYVYx?=
 =?utf-8?B?NktNRk9hckx0ei9wRmtWVWtNKzVaNU1XZGJSUVhsakZucUVGMkxIUFNoMC9K?=
 =?utf-8?B?VE5oMEFjcE0rdXZ0YU95Y2NSdE93VFZWRHNnUWs0OFBRRExaakpPeU9HSFc1?=
 =?utf-8?B?aFJPRTJoa2VwTmRjYmFwU0RWd2VBUVJ3aEtsbFhjQTlaRm0wVmpEREFKeGJm?=
 =?utf-8?B?MWZBTVRaR3RaY0szbnhpcy9CSG9udHpUWTZ4Uzc3ZnZ6NzAwRW40cmJuMk5E?=
 =?utf-8?B?ZXEzeThSbml0N09XZlVRNEdCTEVjKzM4eVkyTytxQ0UrMVdhNHRySXF2aW1y?=
 =?utf-8?B?TWVQUDg5bm9QWjdqd1JFM2l0SUMvb3hyb2tNV3ZIMlV6MWNKb0ZiY3RUNTQ3?=
 =?utf-8?B?Y0lJOVgwQTNMYXUxc29vN1gvdlA5ZjlnNFR1dFovd1JxaHd1TWdCRVRiOEcz?=
 =?utf-8?B?R3BFUUFIRm45bEFLRWFSSm1FdFVxK3BtRmtFVnNDWVdTY2ZHQmt2dWswOXRJ?=
 =?utf-8?B?VHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3265460-1cc5-4427-fb6b-08dd60914539
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:38:40.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXiEKpI0eYiCRzIwkR7HB6pMRiTYD4/ZbZIPZgD76/RqNMId4maDL4Z/2GyySy2gUgYU41BCEzxXdCJcxT/ySWx5VfsK0BY2ldLx/6yI3Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14780

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxMSwgMjAyNSA4OjMxIEFNDQo+IFRvOiBKb2hu
IE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+OyBnZWVydCtyZW5lc2FzQGds
aWRlci5iZTsNCj4gbmlrbGFzLnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVjaC5zZTsgY29ub3Ir
ZHRAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IHJh
ZmFlbEBrZXJuZWwub3JnOw0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUkZDIFBBVENIIDEvM10gdGhlcm1hbC9jcHVwbG9nX2Nvb2xpbmc6IEFkZCBDUFUgaG90
cGx1Zw0KPiBjb29saW5nIGRyaXZlcg0KPiANCj4gT24gMDkvMDMvMjAyNSAxMzoxMywgSm9obiBN
YWRpZXUgd3JvdGU6DQo+ID4gKw0KPiA+ICsvKiBDaGVjayBpZiBhIHRyaXAgcG9pbnQgaXMgb2Yg
dHlwZSAicGx1ZyIgKi8gc3RhdGljIGJvb2wNCj4gPiAraXNfcGx1Z190cmlwX3BvaW50KHN0cnVj
dCBkZXZpY2Vfbm9kZSAqdHJpcF9ub2RlKSB7DQo+ID4gKwljb25zdCBjaGFyICp0cmlwX3R5cGVf
c3RyOw0KPiA+ICsNCj4gPiArCWlmICghdHJpcF9ub2RlKSB7DQo+ID4gKwkJcHJfZXJyKCJUcmlw
IG5vZGUgaXMgTlVMTFxuIik7DQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyh0cmlwX25vZGUsICJ0eXBlIiwgJnRy
aXBfdHlwZV9zdHIpKSB7DQo+ID4gKwkJcHJfZXJyKCJUcmlwIG5vZGUgbWlzc2luZyAndHlwZScg
cHJvcGVydHlcbiIpOw0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
Kwlwcl9pbmZvKCJUcmlwIHR5cGU6ICclcydcbiIsIHRyaXBfdHlwZV9zdHIpOw0KPiA+ICsNCj4g
PiArCWlmIChzdHJjbXAodHJpcF90eXBlX3N0ciwgInBsdWciKSAhPSAwKSB7DQo+IA0KPiB0eXBl
IGlzIG9iamVjdCwgbm90IHN0cmluZy4gV2hlcmUgaXMgQUJJIGRvY3VtZW50ZWQ/IEZvciB0aGUg
dHlwZSBhbmQgaXRzDQo+IHZhbHVlPw0KDQpJJ2xsIHByZXBhcmUgaXQgZm9yIHYyLg0KDQo+IA0K
PiANCj4gPiArCQlwcl9kZWJ1ZygiVHJpcCB0eXBlIGlzICclcycsIG5vdCAncGx1ZycgLSBza2lw
cGluZ1xuIiwNCj4gPiArCQkJIHRyaXBfdHlwZV9zdHIpOw0KPiA+ICsJCXJldHVybiBmYWxzZTsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
LyogSW5pdCBmdW5jdGlvbiAqLw0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBjcHVfaG90cGx1Z19j
b29saW5nX2luaXQodm9pZCkgew0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICp0aGVybWFsX3pv
bmVzLCAqdGhlcm1hbF96b25lOw0KPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gKwlpbnQgY291bnQg
PSAwOw0KPiA+ICsNCj4gPiArCWJpdG1hcF96ZXJvKGNwdV9jb29saW5nX3JlZ2lzdGVyZWQsIE5S
X0NQVVMpOw0KPiA+ICsNCj4gPiArCXRoZXJtYWxfem9uZXMgPSBvZl9maW5kX25vZGVfYnlfbmFt
ZShOVUxMLCAidGhlcm1hbC16b25lcyIpOw0KPiA+ICsJaWYgKCF0aGVybWFsX3pvbmVzKSB7DQo+
ID4gKwkJcHJfZXJyKCJNaXNzaW5nIHRoZXJtYWwtem9uZXMgbm9kZVxuIik7DQo+ID4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogUHJvY2VzcyBlYWNoIHRoZXJt
YWwgem9uZSAqLw0KPiA+ICsJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZSh0aGVybWFsX3pvbmVzLCB0
aGVybWFsX3pvbmUpIHsNCj4gPiArCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKnRyaXBzLCAqdHJpcDsN
Cj4gPiArCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm1hcHMsICptYXA7DQo+ID4gKwkJYm9vbCBmb3Vu
ZF9wbHVnID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJCS8qIEZpcnN0IGZpbmQgdHJpcHMgYW5kIGdl
dCBhIHNwZWNpZmljIHBsdWcgdHJpcCAqLw0KPiA+ICsJCXRyaXBzID0gb2ZfZmluZF9ub2RlX2J5
X25hbWUodGhlcm1hbF96b25lLCAidHJpcHMiKTsNCj4gPiArCQlpZiAoIXRyaXBzKQ0KPiA+ICsJ
CQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJLyogRmluZCB0aGUgZW1lcmdlbmN5IHRyaXAgd2l0
aCB0eXBlPSJwbHVnIiAqLw0KPiA+ICsJCWZvcl9lYWNoX2NoaWxkX29mX25vZGUodHJpcHMsIHRy
aXApIHsNCj4gPiArCQkJaWYgKGlzX3BsdWdfdHJpcF9wb2ludCh0cmlwKSkgew0KPiA+ICsJCQkJ
Zm91bmRfcGx1ZyA9IHRydWU7DQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQkJfQ0KPiA+ICsJCX0N
Cj4gPiArDQo+ID4gKwkJLyogSWYgd2UgZGlkbid0IGZpbmQgYSBwbHVnIHRyaXAsIG5vIG5lZWQg
dG8gcHJvY2VzcyB0aGlzIHpvbmUNCj4gKi8NCj4gPiArCQlpZiAoIWZvdW5kX3BsdWcpIHsNCj4g
PiArCQkJb2Zfbm9kZV9wdXQodHJpcHMpOw0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArCQl9DQo+
ID4gKw0KPiA+ICsJCW1hcHMgPSBvZl9maW5kX25vZGVfYnlfbmFtZSh0aGVybWFsX3pvbmUsICJj
b29saW5nLW1hcHMiKTsNCj4gPiArCQlpZiAoIW1hcHMpIHsNCj4gPiArCQkJb2Zfbm9kZV9wdXQo
dHJpcCk7DQo+ID4gKwkJCW9mX25vZGVfcHV0KHRyaXBzKTsNCj4gPiArCQkJY29udGludWU7DQo+
ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlwcl9pbmZvKCJGb3VuZCAncGx1ZycgdHJpcCBwb2ludCwg
cHJvY2Vzc2luZyBjb29saW5nDQo+IGRldmljZXNcbiIpOw0KPiANCj4gZGV2X2luZm8sIG9yIGp1
c3QgZHJvcC4gWW91IGFyZSBub3Qgc3VwcG9zZWQgdG8gcHJpbnQgc3VjY2Vzc2VzIG9mDQo+IHN0
YW5kYXJkIERUIHBhcnNpbmcuDQoNCk5vdGVkLiBUaGFua3MhDQoNCj4gDQo+ID4gKw0KPiA+ICsJ
CS8qIEZpbmQgdGhlIHNwZWNpZmljIGNvb2xpbmcgbWFwIHRoYXQgcmVmZXJlbmNlcyBvdXIgcGx1
ZyB0cmlwDQo+ICovDQo+ID4gKwkJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShtYXBzLCBtYXApIHsN
Cj4gPiArCQkJc3RydWN0IGRldmljZV9ub2RlICp0cmlwX3JlZjsNCj4gPiArCQkJc3RydWN0IG9m
X3BoYW5kbGVfYXJncyBjb29saW5nX3NwZWM7DQo+ID4gKwkJCWludCBpZHggPSAwOw0KPiA+ICsN
Cj4gPiArCQkJdHJpcF9yZWYgPSBvZl9wYXJzZV9waGFuZGxlKG1hcCwgInRyaXAiLCAwKTsNCj4g
PiArCQkJaWYgKCF0cmlwX3JlZiB8fCB0cmlwX3JlZiAhPSB0cmlwKSB7DQo+ID4gKwkJCQlpZiAo
dHJpcF9yZWYpDQo+ID4gKwkJCQkJb2Zfbm9kZV9wdXQodHJpcF9yZWYpOw0KPiA+ICsJCQkJY29u
dGludWU7DQo+ID4gKwkJCX0NCj4gPiArCQkJb2Zfbm9kZV9wdXQodHJpcF9yZWYpOw0KPiA+ICsN
Cj4gPiArCQkJaWYgKCFvZl9maW5kX3Byb3BlcnR5KG1hcCwgImNvb2xpbmctZGV2aWNlIiwgTlVM
TCkpIHsNCj4gPiArCQkJCXByX2VycigiTWlzc2luZyBjb29saW5nLWRldmljZSBwcm9wZXJ0eVxu
Iik7DQo+ID4gKwkJCQljb250aW51ZTsNCj4gPiArCQkJfQ0KPiA+ICsNCj4gPiArCQkJLyogSXRl
cmF0ZSB0aHJvdWdoIGFsbCBjb29saW5nLWRldmljZSBlbnRyaWVzICovDQo+ID4gKwkJCXdoaWxl
IChvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncygNCj4gPiArCQkJCSAgICAgICBtYXAsICJjb29s
aW5nLWRldmljZSIsDQo+ID4gKwkJCQkgICAgICAgIiNjb29saW5nLWNlbGxzIiwgaWR4KyssDQo+
ID4gKwkJCQkgICAgICAgJmNvb2xpbmdfc3BlYykgPT0gMCkgew0KPiA+ICsJCQkJc3RydWN0IGRl
dmljZV9ub2RlICpjcHVfbm9kZSA9IGNvb2xpbmdfc3BlYy5ucDsNCj4gPiArCQkJCWludCBjcHU7
DQo+ID4gKw0KPiA+ICsJCQkJaWYgKCFjcHVfbm9kZSkgew0KPiA+ICsJCQkJCXByX2VycigiQ1BV
IG5vZGUgYXQgaW5kZXggJWQgaXMgTlVMTFxuIiwNCj4gPiArCQkJCQkgICAgICAgaWR4IC0gMSk7
DQo+ID4gKwkJCQkJY29udGludWU7DQo+ID4gKwkJCQl9DQo+ID4gKw0KPiA+ICsJCQkJY3B1ID0g
b2ZfY3B1X25vZGVfdG9faWQoY3B1X25vZGUpOw0KPiA+ICsJCQkJaWYgKGNwdSA8IDApIHsNCj4g
PiArCQkJCQlwcl9lcnIoIkZhaWxlZCB0byBtYXAgQ1BVIG5vZGUgJXBPRiB0bw0KPiBsb2dpY2Fs
IElEXG4iLA0KPiA+ICsJCQkJCSAgICAgICBjcHVfbm9kZSk7DQo+ID4gKwkJCQkJb2Zfbm9kZV9w
dXQoY3B1X25vZGUpOw0KPiA+ICsJCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQkJfQ0KPiA+ICsNCj4g
PiArCQkJCWlmIChjcHUgPj0gbnVtX3Bvc3NpYmxlX2NwdXMoKSkgew0KPiA+ICsJCQkJCXByX2Vy
cigiSW52YWxpZCBDUFUgSUQgJWQgKG1heCAlZClcbiIsDQo+ID4gKwkJCQkJICAgICAgIGNwdSwg
bnVtX3Bvc3NpYmxlX2NwdXMoKSAtIDEpOw0KPiA+ICsJCQkJCW9mX25vZGVfcHV0KGNwdV9ub2Rl
KTsNCj4gPiArCQkJCQljb250aW51ZTsNCj4gPiArCQkJCX0NCj4gPiArDQo+ID4gKwkJCQlwcl9p
bmZvKCJQcm9jZXNzaW5nIGNvb2xpbmcgZGV2aWNlIGZvciBDUFUlZFxuIiwNCj4gY3B1KTsNCj4g
PiArCQkJCXJldCA9IHJlZ2lzdGVyX2NwdV9ob3RwbHVnX2Nvb2xpbmcoY3B1X25vZGUsIGNwdSk7
DQo+ID4gKwkJCQlpZiAocmV0ID09IDApDQo+ID4gKwkJCQkJY291bnQrKzsNCj4gPiArDQo+ID4g
KwkJCQlvZl9ub2RlX3B1dChjcHVfbm9kZSk7DQo+ID4gKwkJCX0NCj4gPiArCQkJYnJlYWs7IC8q
IE9ubHkgcHJvY2VzcyB0aGUgZmlyc3QgbWFwIHRoYXQgcmVmZXJlbmNlcyBvdXINCj4gdHJpcCAq
Lw0KPiA+ICsJCX0NCj4gPiArCQlvZl9ub2RlX3B1dChtYXBzKTsNCj4gPiArCQlvZl9ub2RlX3B1
dCh0cmlwKTsNCj4gPiArCQlvZl9ub2RlX3B1dCh0cmlwcyk7DQo+ID4gKwl9DQo+ID4gKwlvZl9u
b2RlX3B1dCh0aGVybWFsX3pvbmVzKTsNCj4gPiArDQo+ID4gKwlpZiAoY291bnQgPT0gMCkgew0K
PiA+ICsJCXByX2VycigiTm8gY29vbGluZyBkZXZpY2VzIHJlZ2lzdGVyZWRcbiIpOw0KPiA+ICsJ
CXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXByX2luZm8oIkNQVSBob3Rw
bHVnIGNvb2xpbmcgZHJpdmVyIGluaXRpYWxpemVkIHdpdGggJWQgZGV2aWNlc1xuIiwNCj4gPiAr
Y291bnQpOw0KPiANCj4gRHJvcC4gV2h5IHdvdWxkIHlvdSBwcmludCB0aGlzIG9uIE1JUFMgbWFj
aGluZSB3aGljaCBkb2VzIG5vdCBjYXJlIGFib3V0DQo+IGl0LCBqdXN0IGJlY2F1c2Ugc29tZW9u
ZSBsb2FkZWQgYSBtb2R1bGU/DQo+IA0KDQpXaWxsIHJlbW92ZSB0aGlzIGluIHYyLg0KDQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogRXhpdCBmdW5jdGlvbiAqLw0KPiA+
ICtzdGF0aWMgdm9pZCBfX2V4aXQgY3B1X2hvdHBsdWdfY29vbGluZ19leGl0KHZvaWQpIHsNCj4g
PiArCWNsZWFudXBfY29vbGluZ19kZXZpY2VzKCk7DQo+ID4gKwlwcl9pbmZvKCJDUFUgaG90cGx1
ZyBjb29saW5nIGRyaXZlciByZW1vdmVkXG4iKTsNCj4gDQo+IE5vLCBkcm9wDQo+IA0KDQpHb3Qg
aXQuDQoNCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gK21vZHVsZV9pbml0KGNwdV9ob3RwbHVnX2Nv
b2xpbmdfaW5pdCk7DQo+ID4gK21vZHVsZV9leGl0KGNwdV9ob3RwbHVnX2Nvb2xpbmdfZXhpdCk7
DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFA
YnAucmVuZXNhcy5jb20+Iik7DQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigiQ1BVIEhvdHBsdWcg
VGhlcm1hbCBDb29saW5nIERldmljZSIpOw0KPiA+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+
ID4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQo+IA0KPiBXYXJuaW5nIGhlcmUNCj4gDQoN
CldpbGwgYmUgZml4ZWQgaW4gdjIuDQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFs
L3RoZXJtYWxfb2YuYw0KPiA+IGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfb2YuYyBpbmRleCAw
ZWI5MmQ1N2ExZTIuLjQxNjU1YWYxZTQxOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9vZi5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfb2YuYw0K
PiA+IEBAIC0yOCw2ICsyOCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHJpcF90eXBl
c1tdID0gew0KPiA+ICAJW1RIRVJNQUxfVFJJUF9BQ1RJVkVdCT0gImFjdGl2ZSIsDQo+ID4gIAlb
VEhFUk1BTF9UUklQX1BBU1NJVkVdCT0gInBhc3NpdmUiLA0KPiA+ICAJW1RIRVJNQUxfVFJJUF9I
T1RdCT0gImhvdCIsDQo+ID4gKwlbVEhFUk1BTF9UUklQX1BMVUddCT0gInBsdWciLA0KPiA+ICAJ
W1RIRVJNQUxfVFJJUF9DUklUSUNBTF0JPSAiY3JpdGljYWwiLA0KPiA+ICB9Ow0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX3RyYWNlLmgNCj4gPiBiL2RyaXZl
cnMvdGhlcm1hbC90aGVybWFsX3RyYWNlLmggaW5kZXggZGY4ZjRlZGQ2MDY4Li5jMjZhM2FhN2Rl
NWYNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF90cmFjZS5o
DQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfdHJhY2UuaA0KPiA+IEBAIC0xMiw2
ICsxMiw3IEBADQo+ID4gICNpbmNsdWRlICJ0aGVybWFsX2NvcmUuaCINCj4gPg0KPiA+ICBUUkFD
RV9ERUZJTkVfRU5VTShUSEVSTUFMX1RSSVBfQ1JJVElDQUwpOw0KPiA+ICtUUkFDRV9ERUZJTkVf
RU5VTShUSEVSTUFMX1RSSVBfUExVRyk7DQo+ID4gIFRSQUNFX0RFRklORV9FTlVNKFRIRVJNQUxf
VFJJUF9IT1QpOw0KPiA+ICBUUkFDRV9ERUZJTkVfRU5VTShUSEVSTUFMX1RSSVBfUEFTU0lWRSk7
DQo+ID4gIFRSQUNFX0RFRklORV9FTlVNKFRIRVJNQUxfVFJJUF9BQ1RJVkUpOw0KPiA+IEBAIC0x
OSw2ICsyMCw3IEBAIFRSQUNFX0RFRklORV9FTlVNKFRIRVJNQUxfVFJJUF9BQ1RJVkUpOw0KPiA+
ICAjZGVmaW5lIHNob3dfdHp0X3R5cGUodHlwZSkJCQkJCVwNCj4gPiAgCV9fcHJpbnRfc3ltYm9s
aWModHlwZSwJCQkJCVwNCj4gPiAgCQkJIHsgVEhFUk1BTF9UUklQX0NSSVRJQ0FMLCAiQ1JJVElD
QUwifSwJXA0KPiA+ICsJCQkgeyBUSEVSTUFMX1RSSVBfUExVRywgICAgICJQTFVHIn0sCVwNCj4g
PiAgCQkJIHsgVEhFUk1BTF9UUklQX0hPVCwgICAgICAiSE9UIn0sCVwNCj4gPiAgCQkJIHsgVEhF
Uk1BTF9UUklQX1BBU1NJVkUsICAiUEFTU0lWRSJ9LAlcDQo+ID4gIAkJCSB7IFRIRVJNQUxfVFJJ
UF9BQ1RJVkUsICAgIkFDVElWRSJ9KQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF90cmlwLmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX3RyaXAuYyBpbmRl
eCA0YjgyMzg0NjhiNTMuLjM3M2Y2YWFhZjBkYQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvdGhlcm1hbC90aGVybWFsX3RyaXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX3RyaXAuYw0KPiA+IEBAIC0xMyw2ICsxMyw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICp0cmlw
X3R5cGVfbmFtZXNbXSA9IHsNCj4gPiAgCVtUSEVSTUFMX1RSSVBfQUNUSVZFXSA9ICJhY3RpdmUi
LA0KPiA+ICAJW1RIRVJNQUxfVFJJUF9QQVNTSVZFXSA9ICJwYXNzaXZlIiwNCj4gPiAgCVtUSEVS
TUFMX1RSSVBfSE9UXSA9ICJob3QiLA0KPiA+ICsJW1RIRVJNQUxfVFJJUF9QTFVHXQk9ICJwbHVn
IiwNCj4gPiAgCVtUSEVSTUFMX1RSSVBfQ1JJVElDQUxdID0gImNyaXRpY2FsIiwgIH07DQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3RoZXJtYWwuaA0KPiA+IGIvaW5j
bHVkZS91YXBpL2xpbnV4L3RoZXJtYWwuaCBpbmRleCA0NmEyNjMzZDMzYWEuLjVmNzYzNjBjNmY2
OSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdGhlcm1hbC5oDQo+ID4gKysr
IGIvaW5jbHVkZS91YXBpL2xpbnV4L3RoZXJtYWwuaA0KPiA+IEBAIC0xNSw2ICsxNSw3IEBAIGVu
dW0gdGhlcm1hbF90cmlwX3R5cGUgew0KPiA+ICAJVEhFUk1BTF9UUklQX0FDVElWRSA9IDAsDQo+
ID4gIAlUSEVSTUFMX1RSSVBfUEFTU0lWRSwNCj4gPiAgCVRIRVJNQUxfVFJJUF9IT1QsDQo+ID4g
KwlUSEVSTUFMX1RSSVBfUExVRywNCj4gPiAgCVRIRVJNQUxfVFJJUF9DUklUSUNBTCwNCj4gPiAg
fTsNCj4gPg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMs
DQpKb2huDQo=

