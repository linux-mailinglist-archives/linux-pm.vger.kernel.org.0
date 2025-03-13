Return-Path: <linux-pm+bounces-23946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D1A5E973
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 02:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E2718982B9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 01:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE821C6BE;
	Thu, 13 Mar 2025 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HiWyTrc+"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013023.outbound.protection.outlook.com [52.101.67.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F288C1E;
	Thu, 13 Mar 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829691; cv=fail; b=nIXQYQliwjUj4/5ayp/esv2NE+l0dKGXxYvhLYX17mM+W6ussC3466KHeuGX2i6RfOvx+g/6DAwXSo40wkbqrtAtfQRZb/xxomonNbQj1z8Y//fZDTpaAoxrNLG8nKEVRKZBJwBpa5/buwmvdvscn/uMPcCmP9Q5V0n1v/Uf1H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829691; c=relaxed/simple;
	bh=avaQj1Fv+k6TSlEPVjOSBhDPDfCtiRTwohJYHIPtDRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=skKg/3iRceEGpB1QTMdlr/6PaEjriCWvJnDBNxbuiWCVUWino4HqjhgSLz9+wuTQagouZ5yjYoAinbyx7sVdBjG5OryhmNbn5OLrU7nR/4f2ueBoxzGWztAQKH+oe+JjqLisZulq8ZL+XFjyS115jx8yyW0B5XWnspwfzYTFAIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HiWyTrc+; arc=fail smtp.client-ip=52.101.67.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeuyyOjj/aYI3Xd0ddjd9+8siD3DEB7H4PLgV5u1D58IlBi7qHQZ1iLT83lAbBtNQW+bgUjPx2lTIcHTBJA9Qm2LrHWYh75KciCPVLK4iyR16WDGGK+nLyrIxn9vP35mvIUb9RDM/nWwAomtd0u4rpJSdAgahKgwHNr0PHFhSZUC4n6Ln+XYvt91y5wWoGfSYBGf+YyUlW6eP3pVADO3LIVzwWoUi+jqWG4x4GX+WPQ511W49SEvdeIq+/XHHRI4qog71FEH/VUBqsMi9yICF+jQTSGFqQXzBewK7x6cw5jyaH8rFuKMg1v1Uqut84obSqoU6R5fFhGmy2PzGvFUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIxWB1oFpJU0PvcGNXpylEjB/3ILykawA6bOyDDlQdg=;
 b=IV6aE63YDsTeAdwnDzWDrZxTvIipCnCquo6LArx24kUAo349x4yLgXwxwe8BHrwUbjXSsDJivwrt5+n1DfmToLUqGV/P6A/2/p8H39Gg6+IHMhzwYkJt9Q+d1x0UkGkNZGWlzvO9BjjjIOu1IuOymiR5aLEUW4MNUYILFOTQr/H5gxWza+Dq/J3619A8MmHEQbc3xyxFDdNJOh9eNS4i5kIAMcCCU+YBRLqEtQe+/QHISivB9lUM23DRMqA2Bi1tYpiQH63jzhl/ET12Acu1iEU3HWBaS7YQqRi+IrofRIasOUjyq9fXfxfXEIhiEHebVz0plngZzkBsUjDFK7rl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIxWB1oFpJU0PvcGNXpylEjB/3ILykawA6bOyDDlQdg=;
 b=HiWyTrc+UOAz/NEm1ryewvWQJaKWgxBbUOEHCIZu5w3H7xfgnsmcGBsodrrfNZ4EtRkEEnOV/UDp/M9mGA3UnkOuCvSE67nLEHAHCAO/ila/MAYdg2+204y+W2Wk/DwpBoAxrxc14QzB9va3cpTvWafssyhogqCQDR+SdftgsC8zIJcwKLEo9n61PXvQNY8QhnW0PfmakUQDXhH3DhjFZRDVNQfudQUAUDTOUeY8E9YOd4vewPGjBzKrqwrx0LrkbxQu/jeh5f2tHobNsAJqYcwohPDhfHeB6aTqgc4OyVaF5Zo2pnZNdV+K2eDLSc/aJpQ8xSIXmlNgesMPmc1GQg==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM9PR04MB8969.eurprd04.prod.outlook.com (2603:10a6:20b:408::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 01:34:45 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 01:34:45 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "ilia.lin@kernel.org" <ilia.lin@kernel.org>,
	"tiny.windzz@gmail.com" <tiny.windzz@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2] cpufreq: Init cpufreq only for present CPUs
Thread-Topic: [PATCH v2] cpufreq: Init cpufreq only for present CPUs
Thread-Index: AQHbky/0KSeUltDKz0CFnAfJF8SBRLNvQheAgAEHiyA=
Date: Thu, 13 Mar 2025 01:34:45 +0000
Message-ID:
 <AS8PR04MB86424CF1B1006B70025FCB4C87D32@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250312092127.357316-1-ping.bai@nxp.com>
 <Z9FY-Uu-7R9eWEQ7@bogus>
In-Reply-To: <Z9FY-Uu-7R9eWEQ7@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AM9PR04MB8969:EE_
x-ms-office365-filtering-correlation-id: 242e5f7d-3279-4a88-1d4e-08dd61cf3c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FcA4dYJtQATqBGWADsleeA1QWQVxn6fP1OeZYhmxaaQBVnLR4qUb13qTfjRy?=
 =?us-ascii?Q?medskK0ytRGCA7ajRoJFaO2H2VhVD8jMlZBVNASViO+vTFjjaKHRJlf/6D+8?=
 =?us-ascii?Q?ijPuKLOZV9AKS+wjLwWQH46H77B9Ob92WgDsOhP5ijvVVJgzU/Ydxq6BdHOa?=
 =?us-ascii?Q?Dd8UXwM39vnKpNE7yrO5lICJHFYjWBbTVWMHrg6NYg4qShMSLS339RQlNs98?=
 =?us-ascii?Q?86NKvz2KiPIkzzj5B0viGSyhTpVfwO8AYZC2M1VH1cVUBRP1fUHQV5e05KJX?=
 =?us-ascii?Q?Hez4xHb+qckfU4wK/7rQqX/GOsNCDb/OME9hOIBCL56E9oH9CRUiTxVl2/Ps?=
 =?us-ascii?Q?ntkcdFstHknWEARhsDJfzUDfxKRXwp4bpbC8ZMdaBgVMP+B7vnciXhi9Cp1J?=
 =?us-ascii?Q?pr2fGleHSKuFJ812C5ZdJQ2v7qiVPQCoazCp7p++DprOrmDwrJUmQjB4mnC8?=
 =?us-ascii?Q?iNAvPTEmdtK4IAbhSBLzaooKXmvibrmU0xg2r35LGpgNTomiY6GFxr6H+s7z?=
 =?us-ascii?Q?MxdVE2pjT0xvb0auqF1zhc4dMwXgY7cR4oIMUd6Xb4vHaEWlbfcOpDCsBo4n?=
 =?us-ascii?Q?y32seoufwywi3U65QYTlOm0IxNCCav/g46rcJkOWreqOaP+4CXIOPwsZaIwJ?=
 =?us-ascii?Q?eUIvJiLrA/G8/YpapHS3ecauvgYoNIq8KWPbg55XlMtNR+kbAXOwajgV5iwo?=
 =?us-ascii?Q?ZMnNh6YB4JjLv7VbevKf80EMpBMf5zruO8rRG0k2x77QodO5xOGoqnCgiigq?=
 =?us-ascii?Q?EKxOQkwrmpXujg4fIP8qqA/c6PpeldvZMxPXZGjJeIl1iHMsE19dvHBTo7oW?=
 =?us-ascii?Q?gFaGzWk8pGkHdqE+83P1b/JEFVmeciTBHIneAlmf4ghWGl86WOc77rxth1+g?=
 =?us-ascii?Q?XJ+vfN4QgS31iCuvj8Kti+vpmFBZ0wEpCTX9JGOFreTi+Zia4z00WabZ6Cwg?=
 =?us-ascii?Q?okuMUs7t1V5ULHJC1XBgrLXIfYa9nusll04pbnzF41OEdWVnFciqgLVsUzEB?=
 =?us-ascii?Q?K7AjyYD9dzCCQA0+3ZfPgAWWHsu/C33pOlGo/rsOa9PV2FMkULjSyY2QnoNp?=
 =?us-ascii?Q?F06KuXRWL3wXR0jJ0JlTNxIacyuD20mpU8uJw0tfggq+7zRbxEVH6vHBz2m7?=
 =?us-ascii?Q?iJu6qnmrnFKmuaEIdDl9fgOMAoMGTeHNbM7yUcuO3dsAenDLxfws9ykD8qZC?=
 =?us-ascii?Q?uFz9vMkOeYD37NaqejyqzAZBt7MuENTs4kChehlBzC3d1bxngIM9WuLDwlHR?=
 =?us-ascii?Q?Xe6K5aYtTmr8wltX+YPtaIsTkTD3geeA0fzoos2tVVloQgYQM6kqgRQiu7Jj?=
 =?us-ascii?Q?a5icAVPQJWSYKW1XkyT0MsizU+BGBtmfvw7X/aoZ9lcY5zk931msBCqOBDHt?=
 =?us-ascii?Q?Uff2bTh8kuDqBgCwADHHiPiWUZul+a5+JfGJq/rfSMa6cyPY2COa9EvZLWlQ?=
 =?us-ascii?Q?vLiA56XHLFGdBjvwQ+pIf2p1j5nE1sNI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EWgx1i8NKfgo+DLHzM0FUPkTtgfujHqVKQlmuPxxetLqMSp7SOXy1jEGbqvi?=
 =?us-ascii?Q?dHCMQcQCbIDtLxQfcQJmAYsaOLhgE8x8mKw7jABw1Voohv3FimCnDuX9LZAp?=
 =?us-ascii?Q?Hl7G+bnmTjyvTW8/+HNq8ptBrORsWhzW7ovpQtgldgBlrf1xADKDDuHeHit0?=
 =?us-ascii?Q?ybtToMp7dY/EjcbTSgKd29NVVCG/SwFn4IZgHG1j7LCUET4XqoWkOlX3yV6i?=
 =?us-ascii?Q?b8Q10r8UDPvQIuN+6to5UUEpOEG+5+WLk+rwhbE3vCuK7SSpA2fFpEG3vBqr?=
 =?us-ascii?Q?I3INWKglnjololM9+BBYEjDGqOye8ciQHIJx93HnhSUHqpUjGAtV5sTpXy57?=
 =?us-ascii?Q?hMQpRbg6csx2Cq46efYPyMXRAXYDQEF29sDc6+csVdWva87l6iMcGCViPxYQ?=
 =?us-ascii?Q?uMTL20QPDFTlELkQKuu+vQ28TXiRdya/bR/SzrlyzLEhj6k0wQPiXaI3qIUx?=
 =?us-ascii?Q?Q4vg9wmnATkoSCjwjs/kMn5eMfVD+RMZmWIv313n2rZXZxJUCFp8TDz++UOH?=
 =?us-ascii?Q?aIPt7a+N8s7tK06qW4joIWm037cAmfka5tR+IM4CR6wMBmcHOyTg8nZXhVxg?=
 =?us-ascii?Q?DQX59dCVnlSutch9fY4YeTHxiN39f2iVovJipB73kUuPq+2hRwKSIFM7hZlk?=
 =?us-ascii?Q?FWxLaj/lPc737TjFEPEbaYGdncf1vYO17GmDKAcFx5CBNwg/bfqmqpSe3AdX?=
 =?us-ascii?Q?XNPSmzTivTENhbl6OCGqSEc6pe4jg1UVedqBn7/QDg/V9b996j+V8OVzLgJv?=
 =?us-ascii?Q?yU9l2JjSpYBITsLpJd+13lHJRfE/AYDKdC7Pl5/cQYTeLMAeXT2GUBPiu+T8?=
 =?us-ascii?Q?UutnxAk+WnBXMFJLH1M3f7JxygdUqQDILyX7pQbdEYoU78Vo+46i8jL1bhko?=
 =?us-ascii?Q?wlro3w3Js7gi2UKTTHOyRKI+NvMxa7zMiiWBj90hBI56MSc1tXFTotwHUndA?=
 =?us-ascii?Q?cu7PVSxbdDaZ9EVJuRntu9IfZNyfIzn4tX7dPDbBUX/VHUZu+SEYFVfaJp0l?=
 =?us-ascii?Q?1WiIrRmR7YRxhy1Vzbq1q6ci7P0KVxSlC/5ij08RtVBHcDRYWzn9Oj9sHWrD?=
 =?us-ascii?Q?o0WFUWGWyJTbJi0j0zGQjCNMgwN1A0g5OVpZr/i0u1aaQI7oERjSppYLFUdT?=
 =?us-ascii?Q?P1XaSCnQj1dHqEGrLVBTxmh99AmJJsh//yN4tnSGWwnCLrlAaBGvlm+88nG5?=
 =?us-ascii?Q?XBax5AqrfAFUQeisZNW+sWXmg4BNVgxJAfVNL/HfloDgW5IU1qKkFMB80aAQ?=
 =?us-ascii?Q?Rjl4Zjeq269DeEpV0G3fcBQMGOW7sNfPosOZzGUdQ267mo15vGvjGaNSrCna?=
 =?us-ascii?Q?TazfWNnk8eQ8xuQPlTrI3h6WuDi0eJgGeX9rRJL0Hr7eP17+itSNtLui74VF?=
 =?us-ascii?Q?vwfqrZ4EIevdsIyYRmdtU8DPiaJUZVj5aM/0TP6I1x/CBjSZp4pSEUhvBWkX?=
 =?us-ascii?Q?TDN54dlKsOprPHrQaSZdYnfzhf4oe9J9Wx/Yzh3qY/KEoyKV3jgC7PJns2sO?=
 =?us-ascii?Q?TLT3g/KnijQ46gtEFe8OGiAx6le6PshfnFSu29lv7/52Ab8Dx3gnZkSi2wLq?=
 =?us-ascii?Q?kzD/sOGfDFOs7WrdhZc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242e5f7d-3279-4a88-1d4e-08dd61cf3c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 01:34:45.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFIBMJEZ2ffQtYGAyQhpX7TXQPfFt3Fgo33bgn8Vh6JcIh43/JZyKMn1fLa0l4+JqZKj9nxq4Yx2hSMPQqjWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8969

> Subject: Re: [PATCH v2] cpufreq: Init cpufreq only for present CPUs
>=20
> On Wed, Mar 12, 2025 at 05:21:27PM +0800, Jacky Bai wrote:
> > for_each_possible_cpu() is currently used to initialize cpufreq in
> > below cpufreq drivers:
> >   drivers/cpufreq/cpufreq-dt.c
> >   drivers/cpufreq/mediatek-cpufreq-hw.c
> >   drivers/cpufreq/mediatek-cpufreq.c
> >   drivers/cpufreq/qcom-cpufreq-nvmem.c
> >   drivers/cpufreq/sun50i-cpufreq-nvmem.c
> >
>=20
> Just drop this list, totally redundant as diffstat must give that anyways=
.
> You have already made it stale as it doesn't match the diffstat.
>=20

Ok, will drop this in v3.

BR
> With that fixed:
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> > However, in cpu_dev_register_generic(), for_each_present_cpu() is used
> > to register CPU devices which means the CPU devices are only
> > registered for present CPUs and not all possible CPUs.
> >
> > With nosmp or maxcpus=3D0, only the boot CPU is present, lead to the
> > cpufreq probe failure or defer probe due to no cpu device available
> > for not present CPUs.
> >
> > Change for_each_possible_cpu() to for_each_present_cpu() in the above
> > cpufreq drivers to ensure it only registers cpufreq for CPUs that are
> > actually present.
> >
> > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in
> > GENERIC_CPU_DEVICES")
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  - v2 changes:
> >   - Add changes for armada-8k-cpufreq, mvebu-cpfureq, qcome-cpufreq-hw,
> >     scmi-cpufreq, scpi-cpufreq, virtual-cpufreq.
> > ---
> >  drivers/cpufreq/armada-8k-cpufreq.c    | 2 +-
> >  drivers/cpufreq/cpufreq-dt.c           | 2 +-
> >  drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
> >  drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
> >  drivers/cpufreq/mvebu-cpufreq.c        | 2 +-
> >  drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
> >  drivers/cpufreq/scmi-cpufreq.c         | 2 +-
> >  drivers/cpufreq/scpi-cpufreq.c         | 2 +-
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
> >  drivers/cpufreq/virtual-cpufreq.c      | 2 +-
> >  11 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/cpufreq/armada-8k-cpufreq.c
> > b/drivers/cpufreq/armada-8k-cpufreq.c
> > index 7a979db81f09..5a3545bd0d8d 100644
> > --- a/drivers/cpufreq/armada-8k-cpufreq.c
> > +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> > @@ -47,7 +47,7 @@ static void __init armada_8k_get_sharing_cpus(struct
> > clk *cur_clk,  {
> >  	int cpu;
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		struct device *cpu_dev;
> >  		struct clk *clk;
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt.c
> > b/drivers/cpufreq/cpufreq-dt.c index 778916f89a51..e80dd982a3e2 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -283,7 +283,7 @@ static int dt_cpufreq_probe(struct platform_device
> *pdev)
> >  	int ret, cpu;
> >
> >  	/* Request resources early so we can return in case of -EPROBE_DEFER =
*/
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		ret =3D dt_cpufreq_early_init(&pdev->dev, cpu);
> >  		if (ret)
> >  			goto err;
> > diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c
> > b/drivers/cpufreq/mediatek-cpufreq-hw.c
> > index aa209f5527dc..74f1b4c796e4 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> > @@ -303,7 +303,7 @@ static int mtk_cpufreq_hw_driver_probe(struct
> platform_device *pdev)
> >  	struct regulator *cpu_reg;
> >
> >  	/* Make sure that all CPU supplies are available before proceeding. *=
/
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		cpu_dev =3D get_cpu_device(cpu);
> >  		if (!cpu_dev)
> >  			return dev_err_probe(&pdev->dev, -EPROBE_DEFER, diff --git
> > a/drivers/cpufreq/mediatek-cpufreq.c
> > b/drivers/cpufreq/mediatek-cpufreq.c
> > index 2656b88db378..f3f02c4b6888 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -631,7 +631,7 @@ static int mtk_cpufreq_probe(struct platform_device
> *pdev)
> >  		return dev_err_probe(&pdev->dev, -ENODEV,
> >  				     "failed to get mtk cpufreq platform data\n");
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		info =3D mtk_cpu_dvfs_info_lookup(cpu);
> >  		if (info)
> >  			continue;
> > diff --git a/drivers/cpufreq/mvebu-cpufreq.c
> > b/drivers/cpufreq/mvebu-cpufreq.c index 7f3cfe668f30..2aad4c04673c
> > 100644
> > --- a/drivers/cpufreq/mvebu-cpufreq.c
> > +++ b/drivers/cpufreq/mvebu-cpufreq.c
> > @@ -56,7 +56,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
> >  	 * it), and registers the clock notifier that will take care
> >  	 * of doing the PMSU part of a frequency transition.
> >  	 */
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		struct device *cpu_dev;
> >  		struct clk *clk;
> >  		int ret;
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> > b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 4b3b3dbc7d38..8422704a3b10 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -306,7 +306,7 @@ static void qcom_get_related_cpus(int index, struct
> cpumask *m)
> >  	struct of_phandle_args args;
> >  	int cpu, ret;
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		cpu_np =3D of_cpu_device_node_get(cpu);
> >  		if (!cpu_np)
> >  			continue;
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 3a8ed723a23e..54f8117103c8 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct
> platform_device *pdev)
> >  		nvmem_cell_put(speedbin_nvmem);
> >  	}
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		struct dev_pm_opp_config config =3D {
> >  			.supported_hw =3D NULL,
> >  		};
> > @@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct
> platform_device *pdev)
> >  	dev_err(cpu_dev, "Failed to register platform device\n");
> >
> >  free_opp:
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
> >  		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
> >  	}
> > @@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct
> > platform_device *pdev)
> >
> >  	platform_device_unregister(cpufreq_dt_pdev);
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
> >  		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
> >  	}
> > @@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
> >  	struct qcom_cpufreq_drv *drv =3D dev_get_drvdata(dev);
> >  	unsigned int cpu;
> >
> > -	for_each_possible_cpu(cpu)
> > +	for_each_present_cpu(cpu)
> >  		qcom_cpufreq_suspend_pd_devs(drv, cpu);
> >
> >  	return 0;
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c
> > b/drivers/cpufreq/scmi-cpufreq.c index ff2897789797..c310aeebc8f3
> > 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -104,7 +104,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, int
> domain,
> >  	int cpu, tdomain;
> >  	struct device *tcpu_dev;
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		if (cpu =3D=3D cpu_dev->id)
> >  			continue;
> >
> > diff --git a/drivers/cpufreq/scpi-cpufreq.c
> > b/drivers/cpufreq/scpi-cpufreq.c index 048dc43a9997..17cda84f00df
> > 100644
> > --- a/drivers/cpufreq/scpi-cpufreq.c
> > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > @@ -65,7 +65,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct
> cpumask *cpumask)
> >  	if (domain < 0)
> >  		return domain;
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		if (cpu =3D=3D cpu_dev->id)
> >  			continue;
> >
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 17d6a149f580..47d6840b3489 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct
> platform_device *pdev)
> >  	snprintf(name, sizeof(name), "speed%d", speed);
> >  	config.prop_name =3D name;
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		struct device *cpu_dev =3D get_cpu_device(cpu);
> >
> >  		if (!cpu_dev) {
> > @@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct
> platform_device *pdev)
> >  	pr_err("Failed to register platform device\n");
> >
> >  free_opp:
> > -	for_each_possible_cpu(cpu)
> > +	for_each_present_cpu(cpu)
> >  		dev_pm_opp_clear_config(opp_tokens[cpu]);
> >  	kfree(opp_tokens);
> >
> > @@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct
> > platform_device *pdev)
> >
> >  	platform_device_unregister(cpufreq_dt_pdev);
> >
> > -	for_each_possible_cpu(cpu)
> > +	for_each_present_cpu(cpu)
> >  		dev_pm_opp_clear_config(opp_tokens[cpu]);
> >
> >  	kfree(opp_tokens);
> > diff --git a/drivers/cpufreq/virtual-cpufreq.c
> > b/drivers/cpufreq/virtual-cpufreq.c
> > index 45becb92aa4a..7dd1b0c263c7 100644
> > --- a/drivers/cpufreq/virtual-cpufreq.c
> > +++ b/drivers/cpufreq/virtual-cpufreq.c
> > @@ -138,7 +138,7 @@ static int virt_cpufreq_get_sharing_cpus(struct
> cpufreq_policy *policy)
> >  	cur_perf_domain =3D readl_relaxed(base + policy->cpu *
> >  					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
> >
> > -	for_each_possible_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		cpu_dev =3D get_cpu_device(cpu);
> >  		if (!cpu_dev)
> >  			continue;
> > --
> > 2.34.1
> >
>=20
> --
> Regards,
> Sudeep

