Return-Path: <linux-pm+bounces-20423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E622A10BDB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549E2188A66B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EDC1C3BF0;
	Tue, 14 Jan 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WK3tvJbY"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24916EC19;
	Tue, 14 Jan 2025 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870959; cv=fail; b=m33oIoMnk4Bfl/pYw9DLbNvovuEpX5JeHdr691/JzrJXY97pq3Oux/4M0pY464EE1wSdmZDCePqsU+tuOFJs4KQnY0xMccuOZH32br3dJN30col4aYypfTnneYvp3uoMK30fnh+2YCp1KZFS1KxZAz1Vp37/dzISt4/uFmmka/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870959; c=relaxed/simple;
	bh=oA00vxaN1sdDinBN2EiYFFW1hXK+NycIva1rpWobVGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hk9oZv41jZW4A2mvaYBXUgEakqlSA0x2NU+08xeUb8aFxvr69ZvcgNd6zPVp7tqFvncU6+KT++Q864Aas9z3JnNHRofjoCs7bOQIVLHpAoK+2NLmo6O7/zVUaf70rkAmK8x7IzexcGoxA6bT3jGpnrp5f+urmv51IUGBumWpZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WK3tvJbY; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFC3Qr5wLHyqqrgRGoxppyzTMxa1HTraw66IfflVZbDJdl3VKEOo66nBGVOXWhbo/AFsypc78M8AoeTrE0c+xyJeoKW4X1qB8olcJZUUk6T8PlydgSVJJLvigO+bq1Blhjs17xX+Zf7bMqjglA3bVt574DvByprHyC8hmlU/nnwxqM2X/+eM+CcOz0PowWBUnoTEKEkGPUaGs0twzZuZET9LqD+Y7K7y41UjR7X2Gsxug2J/BoK1nZ2MPGMXjV2S87CJVBGyOKLxldy6QcO/sYckkMrgHN6uRsFm21wyPtop7IAOpuoni2wUxCw6ciFsXPwRCoMkqaHbiDZFgP/MIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFUoEtz0XiDEGb5seTALpvooz/jGIUCzq+KDfobbpv4=;
 b=lq4dL3OZvDWkRPX6QxU5fjsWc52IVgzXt3Pr2Ubt3PmGaZRHUG+SAhJzQE5WOELbY5yTejF39pnxMK3k+z8/0bjRuEimQP3dJJqIrGW/AMBM03/AP696tRiAc8dsKUtXw3MM5oD2UjgKwMsRq/mA2t0rQFl15QhXcrqwWSEzM/MNpPm3wK4h7toz1RXpAEJo44DvOnbEN1bhvhJresJwJ7E49t/WNiX3RKUfie5dxP3rnC5FA8nwa6VVfxuAEBtsQbnoXC7v7nn9w91vh3EO5J9PTyJlcplkK2mKMhUkB/kxWMEp5hZjbGdNmvX9jesnpSYRodEOOdMivRQWoMoFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFUoEtz0XiDEGb5seTALpvooz/jGIUCzq+KDfobbpv4=;
 b=WK3tvJbY/GhSALu52uOYiJsa7k8r+0vIy2F2hKULVifveqjznnaV/EapSii2j7SIr1yiG4M6/J8RWwsqpXAFuMfvSif5Twkc4QPVFXidQGf+IkByqmP1ENC5wnbvkAWMkf7J51fAFSaUwhwaJXlOm9TtJItRC/MGb0FSKkBTLmCd90CVdofdWDn2W1Pvby2FqLwInE6t0YjpD4x7Sf82/ulok4KLNr32HuzPVJ+S9m5LrtjgKNkul4/bYzQdH+D3zjBJtv8aOAGUF8FE7XDsQOV7XT+bSXfUCaYkKDAy5Wr/gKO7hK+sh0+cEXgsq4pbmpME9ZHCVbR7mYCAazNWcg==
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by VI1PR04MB6895.eurprd04.prod.outlook.com (2603:10a6:803:13b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 16:09:13 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:09:13 +0000
From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index:
 AQHbZa+EYgINd2mhkUSyLwfM7XAfOLMUuHsAgAAaEzCAACEAAIAAJ0wAgAFKc4CAAAqJcA==
Date: Tue, 14 Jan 2025 16:09:13 +0000
Message-ID:
 <PA4PR04MB9485507CCC21354B5ED55C3792182@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4aBkezSWOPCXcUh@bogus>
In-Reply-To: <Z4aBkezSWOPCXcUh@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|VI1PR04MB6895:EE_
x-ms-office365-filtering-correlation-id: 6df97e09-64a7-452e-6afc-08dd34b5c9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bTRqwsPrDDftJjIHxfV1XLHieoZb2SUN6Cmzos3v4Opf57taT8SuKP9+R2mN?=
 =?us-ascii?Q?b7K/qmz3mm2l2KZdQ7xsNpl7E3SZzM4cwpwPDznrFxIlXaekUldW/sL67H0q?=
 =?us-ascii?Q?qIrtqprs42/S2nhV+J2/8EOuUICTAMReRqdH08gs3iSEANPCKvk83SzQRH2n?=
 =?us-ascii?Q?IsbNDAcv88RBRs4FzD8R5sqKFuLSBUzEjSLOyR/YBz6RHfY8GV1B5e31eTh/?=
 =?us-ascii?Q?0+MeKXdWhU5bxreYMX/qz/BsxXYhlDgRkY3dDbFRAxg1AoXmibMyJLnn05G7?=
 =?us-ascii?Q?fgwIhnMFxpfMWeiXCKKkK2tI3gfw69ciwUMRhrAk8ssm+sByhf3Awbp+n4Cx?=
 =?us-ascii?Q?971MvIU7yQsyt8O9MfkoIQArSlWoCdolBZ3mBEsHPKVisVGM84IZZdlG4idn?=
 =?us-ascii?Q?z1kK0Gtyv8RMJqP3gyDsLdd0MRNlhqH3yecI5908RDtUHjOztxqPb31bJ/26?=
 =?us-ascii?Q?bKUbgxe9Skhb5RnT437S8emDr/s8bFyIpqFjC7r7RmWL0Cw8SvUPPr1oLL9K?=
 =?us-ascii?Q?xwH21sQhikrPEJVwAqKXzIPHubkwFTJjbbjH/HPnjK2RurLh4ylqgoJvQPiJ?=
 =?us-ascii?Q?SRmzyA5g3IuV/MFNwvW2spp97mwFMhJsW7RpwCZfAEGayplU9+hoRLjIPi2G?=
 =?us-ascii?Q?XNCqU/99kCje4m4f46WOdlqUmth1WO/xX9Vo+ZWNT49TxTcBJ8SzkR2FpLnq?=
 =?us-ascii?Q?2UctT0159ZfI9LfVIjj2YjhBhBZ02/Gy95LMCz7PgFFnqt+9RobAj5/2jMwj?=
 =?us-ascii?Q?IH0wpFntUaEA695fgViIGaMrAk/se3BaKEXXYCF3xSNXYIZduXcCSfXdNs+D?=
 =?us-ascii?Q?dEnfgtRV+dinyVRAFkfOrEFs/G6tZLdBvZwxhskPlUYSfQ8HkfHKYFUomNMa?=
 =?us-ascii?Q?iV/MXqVIHYMAdeN7VoVn6X0ZpIV+4fnmwI5WoVggoYBC0RlgXxKe4ADajwtc?=
 =?us-ascii?Q?UO8tATJkY5l6LSYZ9MLE7c8q3r39JAtYpaKp7obbxT78IJLqqbM5ET8Xm62s?=
 =?us-ascii?Q?ubUMBsl4Cdr/DuNPxYjd0BxHYuEz7A5SIx0GCzmQcnTPz/J9S8hWRAvkHwVz?=
 =?us-ascii?Q?Xzs0ix+qvmUkP2xhCKL9t6Wkb+dMCvWnKq42sbiU1FQ5aNUp689fegsOwAbX?=
 =?us-ascii?Q?6xv/8LWl11FYAVAk6V4Mst1JMoM2/NIwUkMys9z4lpquOaXOKPb63XHVUXId?=
 =?us-ascii?Q?KQKsMwZxLgLmBKQUvxrmOwnk+oRONJJ1CJrVIszgkA5+ZUuo3Tl/Ps4k/0M+?=
 =?us-ascii?Q?DMjOXBgN9rtAaRLkKRI4MED+KMH5R35a1Gs23v3Xl1TgcfzVHXDxY/xuBcH+?=
 =?us-ascii?Q?7wBg7WuyysnzsnhPkBqArrt5o9Ab07KKnSj+ABSLHireibuOYp0mlopN3QIg?=
 =?us-ascii?Q?5sTO0Hgj/25o7ANtDWs+49GjZeJRLcVi5NE1hLRaEr6W8+2D4nvayicrLhQI?=
 =?us-ascii?Q?VtnmwRXzz9UkPMzpGRRDc+uDEsUtE0bO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F5M2V+gDt9nLAuwclREW3kxFvUkBIZiKrfHEWxkfhR7/2XXVcwq/gWIDlkf6?=
 =?us-ascii?Q?iKY4LIMACJkMt/yfKZxaowZ8crxcSQXCM5o+np5Gsf2aQJ09d+mQRvybgAK9?=
 =?us-ascii?Q?NDpQgiWi6de2KGZ0weIzbwhodltn+WzvPv1jZPibMSAUznUe9pRSmQsqmAnR?=
 =?us-ascii?Q?HxmKA0nZEps6V27248A3Rz+prfUAOM/naDNmkFHwP1i4QDpq2SFk8vhYZifp?=
 =?us-ascii?Q?EpeN9ypLU+rl2gXp2ebywCJAc9feq4kx8HFaEkJ+YjtCW74NwlXacNaq7nOF?=
 =?us-ascii?Q?3/R2e101dK3ygARLMB7YUrxDvWf9p3PYAr2C1d8iezkDAwCCeFqiy5gOpH5I?=
 =?us-ascii?Q?n++n+9WmSz6aUii16adyb2RGLH1ExxfzQEaj00YDYP3j3P9op1OCnfcH4QEX?=
 =?us-ascii?Q?jxsWzoQrdqz4ggcarJVtUU71l9ahG178gjBp9cngKAUaWbMNrMIDMISnoyJq?=
 =?us-ascii?Q?BF6KwPSGuHW0T8fAzINEo7pcYfZZt5Ou1jtpIisadALmoREFC1sUYxd51LWY?=
 =?us-ascii?Q?rRQip+jKF75iPtcQFcPlVLiXE5THjIC/NwmyKhncdQ/Cpb4/YpNDtpGfSBVy?=
 =?us-ascii?Q?Qxes5YqgBPDy4ZpUUSo19BomH5YR6X4wwZ2TsgAKatMvcwhwaMSUH+6lNO5L?=
 =?us-ascii?Q?OPPCWhCsaZ22QUVdfYk5EIe5ecP2HXgwK7cFy59y733P8W/VpSLqpsUVmlj9?=
 =?us-ascii?Q?+zDA1WO7PYbIFeQ79Z4yxOjbZIWnoTVGJsHiu5POAmzgskl7YZWPvGNdumx3?=
 =?us-ascii?Q?CQFpO0H1UQvlQ/nvmVO1Gd+3koo4MuFghSWL9ARJtprFAwCzf/2pfjnmEJ4V?=
 =?us-ascii?Q?Qstnmls1KYGpUd5gd8WEW9THN9SyhrBB9wJztJHy3kRNO8kBQorhck9K47/b?=
 =?us-ascii?Q?RM5RW9+ocWKUV/p03wt7GveXPgRNth8CQeZ3BaMFImARK2iaNxjyAFSoktWZ?=
 =?us-ascii?Q?KE1vNlUm9mbR2c1DYPGe1qYN7DwaJqCj00hdwYBWdn1WyXTG6ATudZBfWW6S?=
 =?us-ascii?Q?sqOCX9aw50IldAaeAzauhn2GtnqxO6CAstwspuMQkWIyqF+v3xgHTEYAbiWy?=
 =?us-ascii?Q?Yp2Bk3UJ5Sk27aSGhUsgvVdjTw7rDrlpjXQ2Z3reBJssg4qc4l0xxnUXjpZQ?=
 =?us-ascii?Q?jJelaMxMNBc4DCPLIWckFnqA19nHsP960qDQ4A5OO7UYS0Mwnia7zotHiiK3?=
 =?us-ascii?Q?5CSGa3+kYMZBPKfvqOEbzvtM/LNsZxVdjyEQQBhJ/ZmtD2uIW/V7au+gwk+g?=
 =?us-ascii?Q?C4E2V7vHHxCF12FmgJ1SbPo12LqweLB7rZ4dmQ6x917UE8fBmVHoJbliXwrS?=
 =?us-ascii?Q?POm/Zi52yjuK3qxJHZgolI5ElGVjL+fwhoAoQs1kjuDy9pVItUAdGiq2SDmp?=
 =?us-ascii?Q?aSLlIICmgglFOysSdfTPOCES2cQJVsEGmJm0Ab7ppsmseIuPhDxjTkK2wmqn?=
 =?us-ascii?Q?H1MvlPvenhxEDkBz051uMSE5z3tBm9TibrJIMcZaMJ3HNOe9wIgxUBAQQnR7?=
 =?us-ascii?Q?qSugcfY5rUDVTESFLKYVa3a+1NgwsAguHuzVeCiLK5/kGn7ppbuOih5T+kW4?=
 =?us-ascii?Q?BYrwsg7qGb90U8ctEcDCyQkGEsqgkyTvgRgTWR4D+uDKaCtceEn8/vfN3NrD?=
 =?us-ascii?Q?BA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df97e09-64a7-452e-6afc-08dd34b5c9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 16:09:13.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGKNzg6TWn+24x5H9oilrHsIdfZ9YMilClMi4gLrv3C4W4YbuwXHW9Mduv6nrcAyqSmJT0/2dIqIs1Vhtd4Vuft1jmSBjLG7uXyTfcLYS1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6895

Hello Sudeep,

Comments below.

Regards,
Ranjani Vaidyanathan

-----Original Message-----
From: Sudeep Holla [mailto:sudeep.holla@arm.com]=20
Sent: Tuesday, January 14, 2025 9:24 AM
To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; cri=
stian.marussi@arm.com; Sudeep Holla <sudeep.holla@arm.com>; ulf.hansson@lin=
aro.org; arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; li=
nux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize st=
ate as off

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Hi Ranjani,

On Mon, Jan 13, 2025 at 07:54:06PM +0000, Ranjani Vaidyanathan wrote:
> Hello Sudeep,
>
> Will try to explain the situation we are facing.
> 1. We have multiple agents running, Agent-A is booted up first before=20
> Linux is booted and powers up a shared power domain PD-X.
> 2. Linux boots and gets the power state of PD-X. And its already ON.=20
> And then PD -X is initialized with a default ON state.
> 3. When the driver that needs PD-X  is probed, Linux sees that the=20
> power domain status is ON and never makes an SCMI call to power up the=20
> PD-X for Linux Agent.
> 4. Agent-A now is shutdown/suspends. Linux will crash because the=20
> platform disables PD-X because it has no other requests for PD-X.
>

Thanks for the detailed explanation. I understand the issue now.

I would like to discuss if the below alternative approach works for you.
We can debate the pros and cons. I see with the approach in this patch prop=
osed by Peng we would avoid querying and setting genpd all together during =
the genpd initialisation which is good. But if there are any genpd left on =
by the platform or bootloader(same agent), it will not get turned off when =
Linux tries to turn off the unused genpds(IIRC this could be the reason for=
 the current state of code). While your platform may find sending those com=
mands unnecessary, there was some usecase where SCMI platform kept all reso=
urces ON by default for faster boot and expects OSPM to turn off unused res=
ources. So we need to support both the cases. I hope my below patch should =
suffice.

[RV] Linux can still make the call to disable unused power domains, even if=
 it never explicitly made a request to power it on. The platform will aggre=
gate the request from all agents and will power off the resource if no othe=
r agent has enabled it. From Linux point of view it has disabled all unused=
 power domains.=20
Your patch below may also work, but feels like a workaround to artificially=
 (for lack of a better word) enable a resource. And also makes unnecessary =
SCMI calls (expensive) for every resource immaterial of it power state (may=
be can be improved by a conditional check).=20

Regards,
Sudeep

---->8

From dc755fa02d351e71c727da1c396e2d346b496096 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 14 Jan 2025 15:08:44 +0000
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request to=
  set the current state

On a system with multiple active SCMI agents, one agent(other than OSPM/ Li=
nux or bootloader) would request to turn on a shared power domain before th=
e Linux boots/initialise the genpds. So when the Linux boots and gets the p=
ower state as already ON, it just registers the genpd with a default ON sta=
te.

However, when the driver that needs this shared power domain is probed genp=
d sees that the power domain status is ON and never makes any SCMI call to =
power it up which is correct. But, since Linux didn't make an explicit requ=
est to turn on the shared power domain, the SCMI platform firmware will not=
 know if the OSPM agent is actively using it.

Suppose the other agent that requested the shared power domain to be powere=
d ON requests to power it OFF as it no longer needs it, the SCMI platform f=
irmware needs to turn it off if there are no active users of it which in th=
e above scenaro is the case.

As a result of SCMI platform firmware turning off the resource, OSPM/ Linux=
 will crash the moment as it expects the shared power domain to be powered =
ON.

Send an explicit request to set the current state when setting up the genpd=
 power domains. The other option is to not read the state and set the genpd=
s as default OFF, but it can't handle the scenario on certain platforms whe=
re SCMI platform keeps all the power domains turned ON by default for faste=
r boot and expect the OSPM to turn off the unused domains if power saving i=
s required.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/s=
cmi_pm_domain.c
index a7784a8bb5db..255c8c36a15c 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -96,6 +96,8 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
                        continue;
                }

+               power_ops->state_set(ph, i, state);
+
                scmi_pd->domain =3D i;
                scmi_pd->ph =3D ph;
                scmi_pd->name =3D power_ops->name_get(ph, i);
--
2.34.1


