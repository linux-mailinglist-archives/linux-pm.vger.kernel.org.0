Return-Path: <linux-pm+bounces-42244-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D1AUO+6EhmnPOQQAu9opvQ
	(envelope-from <linux-pm+bounces-42244-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 01:18:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F973104442
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 01:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37DEC3004D13
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC51DDC1D;
	Sat,  7 Feb 2026 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oPBdgXKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2C1A9FAF;
	Sat,  7 Feb 2026 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423528; cv=fail; b=NsV/ICr6OoNyVAJmBbIhMigzfstlaM35PO9/7F5HRHVo9mCGoO2w0iHHyswaqi09za2NPR/5xwVfSjNx/z7FTPopZEsKnTXO3l1vMVvJG9sDmfLtUovPfiBkFMxCPzGNjVuzdVJslbDZDn7SDCFnpyY1ypWUbfrvwE47TaxzE14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423528; c=relaxed/simple;
	bh=G3eVtTixoc1oHkwWTfL7buQ6IlIZ/O0AWWlYhuzVVRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2vh0phk+SzrsfwZwI2ccGQxNOt2kVBqsSAu4y9jWOib7xX2QFa2lqPEoKBbZCpwZi6eOO12O/xIZkXS6+ZzO3XairnI+esLZqxSoW3hkUBlHAmAqoBoulMIDihLpSrpC9dyZqFGiTGoBP37aizcYNOhHrd8KvqFKOIENYPzOR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oPBdgXKT; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E83tDGG7lGAuHGUBjAkzmmMq3WTc4m5S3Em2HG11bCh7WA069TFvsx6/oouXnVZBq1MFalMOWORvNk1udee0c5g+HNxrKN5w4bBx6mdHjyuxuZtWHYmtajha3GhdSy3I4ZB3zo0wnYJ2VHwQ+UgjzZgtED5YkZTJdAmVBTwtiDufHMbHec90B9OMFwITWykiVy0kppJfM5VTUegCANbLeQEFvZLfi2tfyiaAZ9+iomMmS0DhR1XpaxrRfxJ8sKZoPo4E3jovDFGnTcnEEzZh+LM0tzI7xYd2Y4AdnFUddvXT2bzbIjum6JhkeRm7P6sYJmGVo4zz40M96p7WC28FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5lFcQxghL6eRRl1lOfCDz9cB3QySsNRVEZ35R18Xuc=;
 b=eHH3iaWnxtyhkiBgVXkL7r1BJt1dxQYETMAYhxLAgT8Z9Wso0L1UEU6QBZPPH5Q9T0OmswP0xaNFWIdNeiT6WK0u/LO9GRrWTPqXvXw139f1TBvwt/C6RrjtXcSo2BUnDZd2qBS7wOIWO7lSN2xON0USVktEkNuxVw9W8KL1WL5uZWuvNrcGwi6fJSWoJxIhOyf6omHPgDaK5AVGRzzQhrGgtKbRsq8K2jnnh1iwe9G9Vnl3Ru8ZKFKP2U/psjuVGjyYUg47vnGXWzwNy4B1MkpB3OPF5CuVpqBL/bMPvpX+RWkzoMBqlHTGz+S9y8VEDPVR57onIjdBfUpdod5xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5lFcQxghL6eRRl1lOfCDz9cB3QySsNRVEZ35R18Xuc=;
 b=oPBdgXKTZTR/QwlHJV9kZZoon6VcLnMfPS6aovUHLAoyMMIFGs4f+Ac2rm4WduQBUKaCL+jGLl5fwOUYI2Aqc9n+Z56bfCOBZObIzblhTK0e3eiKv+zJjJ7woThsQtXzIWHl6t6H6APW/5GvfCK/ceLnX+fvTBqarpisSOAw2zvZTB/fLO0ON23b9ATeuSfad+J56grXSoCcHIPB0KNgPS67sI8Q+r8+7DblVb4autHeICzoS6pQf0b0qRMcuukhF0vr1a49Et+tU69djAt03Y/NIbIVNFYbdXhh7w2QofTsGYKPDFmlGVQGAHPZff4A4s4xKA4GWyrptJCmEmbvmA==
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by PA2PR04MB10088.eurprd04.prod.outlook.com (2603:10a6:102:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 00:18:45 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%2]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 00:18:45 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] PM: sleep: core: Fix race condition in async noirq
 suspend
Thread-Topic: [PATCH] PM: sleep: core: Fix race condition in async noirq
 suspend
Thread-Index: AQHcl3nHoGhvDVmtGEO1G6MsWkkzzbV13HeAgACClwA=
Date: Sat, 7 Feb 2026 00:18:45 +0000
Message-ID:
 <VE1PR04MB7213E7FE80A3D089291340C08767A@VE1PR04MB7213.eurprd04.prod.outlook.com>
References: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
 <aYYW0QbEVsnPsAaM@lizhi-Precision-Tower-5810>
In-Reply-To: <aYYW0QbEVsnPsAaM@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR04MB7213:EE_|PA2PR04MB10088:EE_
x-ms-office365-filtering-correlation-id: 443d8a9c-7aaf-4657-1ab3-08de65de74e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2C9LRWJWFdJTNdQQCONGzRL9FgQ7gSsPf1YOAH1dZ32gin+XsPCJuwHejYYZ?=
 =?us-ascii?Q?nc3RDLPlbaCfAFqlNHPOdEY/dIp5sAlp2A8c9H3AJtB9jh+4VlEEIkQHFrZQ?=
 =?us-ascii?Q?/+LJGpCLJv/vniPjk2eBz7TLukzU6GY/QJLKmfVk+y1aVmHfcc9ItRW56o0m?=
 =?us-ascii?Q?lUnmxe0ssIrfollCCA81gIAK+88XwsVW47ifXO0mvgYQMfmIYJnVIsJYJ3xb?=
 =?us-ascii?Q?AJDDheBcth8sbOw8Lz7zchtbhM+u4x2l1RR48oUh03bHz9xFQqH4CQ2HGojp?=
 =?us-ascii?Q?19+WG18cjT/Jkb3+8+mQtUjsFOnvowR6HX5cxjYwZEfCBDHEhq8aIc38cUSK?=
 =?us-ascii?Q?zgLt3FpRbO80xPvPR7S0aA6foE5Sfl3BIECDK2PxOEQayTQl42fVVIghtWqu?=
 =?us-ascii?Q?1MrloQnrsrpLIwnrTq1VdHgVKLCSqCY26saEE0rv3LOjdgNS9S+dCts7omcE?=
 =?us-ascii?Q?oNf13ZWgHJ/nGfzlxahqZyahcUGH7gFMppkItfH7/rH6Qks0FbhLZTevLHly?=
 =?us-ascii?Q?6ZX2luQXkOsbfRYoIB4Hc4RhfSUwtQNMJuQ5EfHHD0bvquEqmWs8XOs/gsAz?=
 =?us-ascii?Q?Blqlr+55/pCTrj9kYCn/HgPQRqDkznSnyYERjCGyLZf1BsNZiAUhxiPzbjqy?=
 =?us-ascii?Q?4WkqcJvUEiwlnQ5g7w8B9eewf/asbB2QkONswxXZZKYdqOzSKT022BCqeR9N?=
 =?us-ascii?Q?x8jn4r/PtQyOmbq5VSi82pK4QNr+W/5wnE2VLqMjy4RIUQ9JDyl4EM8w8ZP1?=
 =?us-ascii?Q?8Fib103rDfo07w8of35YY9BvrtFald35EkN2fl+IOHyk3kpNfe82aeQbPfyJ?=
 =?us-ascii?Q?lp/VX3yCMigYfAb1AUlk+ohkCxKtuZvolIBNAW7UuB9PBMzLDHonHB8m/Rgc?=
 =?us-ascii?Q?ns+LVSldN29caR7p+ZTg+YIZoTab26fVblkwZ+DOKPZ/gPzIPmCckThS6zkg?=
 =?us-ascii?Q?/PK/vWbSkrAcUF9yzDG20aTljTKGchzHdnosoeHOhtWYEZtKCt3oyyhfNhwa?=
 =?us-ascii?Q?iZ4+UZgh4phl/oVVnInSakyLtA0faXJ7TcVR2yuwyn7+3YWXp/o4wJJd+y1C?=
 =?us-ascii?Q?o+kXpsUA1lYI7ezdfW97XhsXIaM9cIT9KTFH0CCuWu/hp4Dm+81S48SMNAQ9?=
 =?us-ascii?Q?DbcExk8CdiQwIKCP/XDtj+Fw7JI0ZwzhSoBX+twIbVyKSCCk6mN0fMvKfrXp?=
 =?us-ascii?Q?HK9G6169giHTc+YP8b2blF1CvyHhxrTRC3bfTYzvx9AmCPbNLUZNJ8Am9r1T?=
 =?us-ascii?Q?4AbTojBKvgU50LNMp7gffn/8QM7Z/m0aW1f2LaPzFcc+xrxRQfwfTjg8Gnjg?=
 =?us-ascii?Q?sIF6VEgM7mpb4qbqk7VPOJLEUbLDrp8jRp6dVRrhTTsS4+5Iw2vyGTSj9TYo?=
 =?us-ascii?Q?oLWQlVm2fCAMHCp8ip5wvq1l6KuSI5Wm2sPzRB4h7iuA8Xer1bPWnmtZjWfM?=
 =?us-ascii?Q?AgS+nEZ2UOe5d7Cm9O2p16IUOSpE4FY3AM0324jvaby6w88Hp6DVAucH7Ut+?=
 =?us-ascii?Q?+FZarN2D6JFMgO5V41o/VFMnkUSJHo8qqQllAyJ7Tl7sn1zwyfOGNuOGefU5?=
 =?us-ascii?Q?D6DhPELRnqo8nK3OI35mBoUZorfGx4eWj4KBxVea8gaEmGSVFuOTSvwl5fQA?=
 =?us-ascii?Q?EeyHLK1mZkix0yQWX3pokqs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ehh96iotv5dDH1UsTM8iIjymv2uvOQwOcJ0B7gt0g2zMt9bpbxc/Ek/5GBh9?=
 =?us-ascii?Q?UBA3UeF/D9JL83yJRsq60w/Qr3rvla0vCUEDqQfhPoc/N9cN86nA+tCM2Cav?=
 =?us-ascii?Q?aYenMpAxj95pCKsi7+aNI7YdWnaxhskNFcWrq/A+G/8u1Lf2y/1SumjSCkeg?=
 =?us-ascii?Q?UXfRZZ3nFIwSg4qPz6G+MmFA9c2eyTQnxp6FbBKhX7fgV2a705Pvb6r7ewFH?=
 =?us-ascii?Q?nzzTpA6Kw3eY9xbuHYKgTVOIYkjbSwAyAhF0qor6JrPa7WRiBdJ24fFRAbCv?=
 =?us-ascii?Q?WHH8lJulkl9KLfUGX3h1fegdbEcjgV97e1eJQJNKHiWEZNv1Pr6TNZXwXFOf?=
 =?us-ascii?Q?JPTtxU66jse/jmvmanqgav/JEGDAMFUNZQI9HJxUzdqFn3RTfBT/O2eZ/Ct1?=
 =?us-ascii?Q?0Vi8D87pNcRmmFqMnzELSADTKT8ylrtsyDQ0W9wD1Sa6UfLN9TDQUHLDFsGS?=
 =?us-ascii?Q?WkLcEHeC6AHQTi3Fgv45jv7+aw/KDwI6ZwPRH1aqFJedo5JpV+VIvBh13gHl?=
 =?us-ascii?Q?wdfQVEWSnR1YIoVO9NPu9YiI72V6zOsqoPMhygKl04X8LB/9dIYggEF2BsJ3?=
 =?us-ascii?Q?uweEJCpGfvwl1gLdqz7VPcUiHnrVV/KJ4ATzFjLTpPO+vJ+MyOnQs0aZVHMP?=
 =?us-ascii?Q?KcWz+aogFVF9ApGldKF6e4QRPaB8WiHUokrTYHqD79n2vzMq6cR8IDB9U8oC?=
 =?us-ascii?Q?DISpYFEzj0gRT7gTC8QX9yRINg2AabSUexKZS9QSM2EXQVaj+GzMJWO2w06F?=
 =?us-ascii?Q?aYfAHHgmENjg/n2BpdpBvUSwBdrThpGz60DYIh4NmTn3EE67RejRGkVsE3xM?=
 =?us-ascii?Q?UZJq3jmGf74IcI3uCvZwlz4qnxmwnuqt0++BhWlSFN2xfKwg2Ik+6AD3n6dW?=
 =?us-ascii?Q?70C5Ph65invZeU1O7WLbS1S0HXlWRyJJrRKc1eIEWIwOuxRKOHiSR44NFteh?=
 =?us-ascii?Q?rDrlSWWD0DqSnsDTiCxnXQk8cVGA9q4083+iYzxrUEMgyvXV6WbEWQvy2yOq?=
 =?us-ascii?Q?wNwVpDIT7qk63MGWYxQJhApweyAS+FtCybv58fsd6G59hT2NuHN7gO73wWmW?=
 =?us-ascii?Q?3aa/jbUghw3FCxhz4FLxLVMEuH/CRsfRRDmqnMW0M9z9wjzyjCzAsbEpFYrC?=
 =?us-ascii?Q?vCtMjMgp8OC4ao+VOS/umx6Q+7CfFx7rAcfKf2zry4tYvnsyx1CaOid5O4yW?=
 =?us-ascii?Q?WJv1YBDI0hDusr2rp7CxVE3JqXRTL3GJuPpObDzdWBO1GQkUMoDmFtveGPqD?=
 =?us-ascii?Q?6fiufIO9FBtsrZ13/IhBMf55wXjojAoLXaUE947NPRB5ovD1NuQQ71ASL9/K?=
 =?us-ascii?Q?jYwE1SJYZ9iwiM42VpmqGKHk6TwIdAMe0a5Fg1x5uNxXKndNeeGtzdml/gY2?=
 =?us-ascii?Q?S0y9aXDe6/7ZG/6acJkJ6GtUPeetyVeMNH+Q7i0oYnRq0K+dhJBOToER7gbA?=
 =?us-ascii?Q?CGvZzk/67PgvquvpCsADzoduVomr/sy2W+EGt8SgZwXtwQkTRejdFXuL/ODq?=
 =?us-ascii?Q?zspjr9AUV01aqwQjkReOkgE3YTTibETdlLqqVpMm14T+xgGCWNqrL7oQ3upZ?=
 =?us-ascii?Q?Lm/NWUUt48HkiNkemJOphYRrb5AfesL7TvoMQbYKiJVdwgigrSuCO7MMrrwE?=
 =?us-ascii?Q?5JJdbNxhzTony+E4mSK2wOxKKF/H5RFINMeyGJaYZuOMSngLQCS4eADx+Bqi?=
 =?us-ascii?Q?ekU/RLNwmu6QMpC3GlB0AB8EsummrEZWCwkYydPEUG58lnQq?=
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
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d8a9c-7aaf-4657-1ab3-08de65de74e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2026 00:18:45.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYGpv0I4J+VNfz4LJt50HsMlLb2UEHeakuor5vBdEzJMFnF+9gZFJFJWpyRlZ1/vuJnwYjivzvGzAzWAdQtNCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10088
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42244-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F973104442
X-Rspamd-Action: no action

> Subject: Re: [PATCH] PM: sleep: core: Fix race condition in async noirq
> suspend
>=20
> On Fri, Feb 06, 2026 at 11:05:11PM +0800, Jacky Bai wrote:
> > A race condition occurs during the noirq suspend stage when accessing
> > bitfields in struct dev_pm_info, causing system suspend to hang.
> >
> > During async noirq suspend, leaf devices are queued for asynchronous
> > processing while the main suspend thread continues clearing the
> > 'work_in_progress' flag of other devices, including potential parents
> > of those leaf devices.
> >
> > In struct dev_pm_info, 'work_in_progress' and 'must_resume' are
> > bitfields stored in the same byte. This creates a race when:
> >
> > 1. A leaf device's async thread sets its parent's 'must_resume' flag
> >    via dpm_superior_set_must_resume()
> > 2. Simultaneously, the main thread clears the parent's
> >    'work_in_progress' flag
> >
> > Since bitfield operations are not atomic, concurrent modifications to
> > the same byte can corrupt both fields. This leaves the parent device
> > in an incorrect state, causing the system suspend to hang.
> >
> > Fix this by adding lock protection around the bitfield accesses to
> > ensure atomic read-modify-write operations.
> >
> > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more
> > asynchronous")
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  drivers/base/power/main.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index
> >
> 189de5250f256bdc1cdc33006b2c386d0794485f..561e24c257d779db51a0f0d
> 50dcf
> > ee61e98de64f 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -633,7 +633,9 @@ static bool __dpm_async(struct device *dev,
> async_func_t func)
> >  	if (!is_async(dev))
> >  		return false;
> >
> > +	spin_lock_irq(&dev->power.lock);
> >  	dev->power.work_in_progress =3D true;
> > +	spin_unlock_irq(&dev->power.lock);
>=20
> Thanks, it is really hard to find this problem. I just worry about if it =
is enough.
>=20
> for example in __dpm_async(), if "check power.work_in_progress" should be
> protect also.  And does other power.xx need be protect?
>=20

For other bits, it seems no chance to trigger concurrent access with the wo=
rk_in_progress bit.=20

BR
Jacky Bai
> Frank
>=20
> >
> >  	get_device(dev);
> >
> > @@ -656,8 +658,11 @@ static int dpm_async_with_cleanup(struct device
> > *dev, void *fn)  {
> >  	guard(mutex)(&async_wip_mtx);
> >
> > -	if (!__dpm_async(dev, fn))
> > +	if (!__dpm_async(dev, fn)) {
> > +		spin_lock_irq(&dev->power.lock);
> >  		dev->power.work_in_progress =3D false;
> > +		spin_unlock_irq(&dev->power.lock);
> > +	}
> >
> >  	return 0;
> >  }
> > @@ -698,7 +703,10 @@ static void dpm_async_resume_subordinate(struct
> > device *dev, async_func_t func)  static void
> > dpm_clear_async_state(struct device *dev)  {
> >  	reinit_completion(&dev->power.completion);
> > +
> > +	spin_lock_irq(&dev->power.lock);
> >  	dev->power.work_in_progress =3D false;
> > +	spin_unlock_irq(&dev->power.lock);
> >  }
> >
> >  static bool dpm_root_device(struct device *dev) @@ -1407,13 +1415,19
> > @@ static void dpm_superior_set_must_resume(struct device *dev)
> >  	struct device_link *link;
> >  	int idx;
> >
> > -	if (dev->parent)
> > +	if (dev->parent) {
> > +		spin_lock_irq(&dev->parent->power.lock);
> >  		dev->parent->power.must_resume =3D true;
> > +		spin_unlock_irq(&dev->parent->power.lock);
> > +	}
> >
> >  	idx =3D device_links_read_lock();
> >
> > -	dev_for_each_link_to_supplier(link, dev)
> > +	dev_for_each_link_to_supplier(link, dev) {
> > +		spin_lock_irq(&link->supplier->power.lock);
> >  		link->supplier->power.must_resume =3D true;
> > +		spin_unlock_irq(&link->supplier->power.lock);
> > +	}
> >
> >  	device_links_read_unlock(idx);
> >  }
> >
> > ---
> > base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> > change-id: 20260206-noirq_async_suspend-645bd6b8305e
> >
> > Best regards,
> > --
> > Jacky Bai <ping.bai@nxp.com>
> >

