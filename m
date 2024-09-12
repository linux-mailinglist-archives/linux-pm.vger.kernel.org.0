Return-Path: <linux-pm+bounces-14088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41F97692F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1DF284383
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAF1A00CF;
	Thu, 12 Sep 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QdNCstQo"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA021A47;
	Thu, 12 Sep 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144273; cv=fail; b=X05sljbNiYbAEt/hv5gsTZqQwM/DrtwQ3F63g+xxl00Rbk+omrfeyFV+XkROuFBuDuDVd7FUccP5BQlMgFqIJTfwJWQXlpIZQJdBeMVhD5n4OuJDuIXbn3wgr5hUC/d8YYb+RKAFshHjwJERPdT6t9Jg3mNlaoXuW01oVTnEbVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144273; c=relaxed/simple;
	bh=KMpdzdWKr+E1zzzkP+HAzBO6+CTnnrtHEOOeo0tr0c4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lUHRD1SL88K2D2rlM3ND1xq6Qkif37L9yRC5wDzmyJ7j1ot/BhWR+dIRkWIK1Dn6N/FooYR+KrJjS24MJlFw/tfaWJRIDLyALlUWXz38/WaSn5qtHUZDzi8aPeyOYGj79pRodrFeIdjuWkMxBEvDYRWNXY3plYIqiVjpTPDkBg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QdNCstQo; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whaURcnguVfjbTGyTYPLRpg7aQPDXuLB+gBQ2pGutjczpHT4GISap4w5e7oFDzh79gipWZ4lq3K8spSNdbKdmp69LUrVR1QhOgRbAhKh9tYvvaAuHvWYZVYTBDzS2QPgBTSJhphSvXD1AVXGB1OOsCmED8vRw+YHcy6uNLQorYbGtmuwwWERv0CIaDnTL3pnMdDJY1P9e9CT0KNqAzmBlQHb3sMw559gBI0DuEYzSqYpQ0jtnrE0kQ9E/9d64XaOZGVF6FxZ7jfHf54JVmdaAKP0Q1LngsZNBIC9j7aOWw8H4EyvfoD3ypMbnnVR6sKyK9tBO6H7gR/ilB3cZRgrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMpdzdWKr+E1zzzkP+HAzBO6+CTnnrtHEOOeo0tr0c4=;
 b=lT0q+GU+zvWJBcVoXIsDc5DXMTMSFWuxlFpRyE6qefFRzIc5rsk8gm42C3ofW60G744FeY1NbwsU0M2q8mWElJAeS7/dzjUbe8cXGUIMFTXJdljLGmfy+J2cg+1I5PFJXEQ8HZvXBctjE8XwsRTuL+R/vKK8d4BAOqCBQIVdMge2VNWiwZ795gr1mLovRZWxu7yrpzKE+7XVRoXn/zx6d5TypfygibA5QifWAOLQZdPzE3A19j4HIp50nEjDfND4BYh7ae27i+DuGYFPrm7pzxyF5hUmErsPmsc5FS3FWctG2KQYJSgZDWaPzu7m/j6bd53nWSpFgre9viGcufJePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMpdzdWKr+E1zzzkP+HAzBO6+CTnnrtHEOOeo0tr0c4=;
 b=QdNCstQo5J9U+tScU9cgcweuBe+96q5OIBs3bDGwrjvne7W30VtA1PFxAoc3jhpMj3CrT7Mw6BDxag1NMuMgaim/4CahuD3dJMxJpDCBwXAPCy27LBIYFxCgz9AGcXlZx6ZQVgees64QCRmQYK/vBgyJW5mjpmVrggHcad36pBWnpbi6+PPWmbrcMvb8pBUFXSaVVVewLM6Ts8sMmGOr+Xgmjy25vZsTsTpD7J8EhGpwmH5xaVw87ws6fYripniBzUPS/+clvh5gpbwoLoYARShEs6fhBxvk942hnAPSjFLiT2fbjTdmbcPF7JPSk14NSu52jIjq9Ra9zlrwF9//Ug==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 12:31:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 12:31:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John
 Kacur <jkacur@redhat.com>, "open list:CPU POWER MONITORING SUBSYSTEM"
	<linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Thread-Topic: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
Thread-Index: AQHbBLNWC31a55JN0EKkRuDK1MOc/LJUFQYAgAAALVA=
Date: Thu, 12 Sep 2024 12:31:06 +0000
Message-ID:
 <PAXPR04MB8459B7E460A05A0DF07615FB88642@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240912013846.3058728-1-peng.fan@oss.nxp.com>
 <ZuLeVCUx4S8mn-2z@rhfedora>
In-Reply-To: <ZuLeVCUx4S8mn-2z@rhfedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7937:EE_
x-ms-office365-filtering-correlation-id: 5d0db83e-d19a-42e7-e2b8-08dcd326c643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gj8lKBmVogOLgvyLVkO48GBOjlttypLTBy7a2kXUGspnL4AnTBDQSR2bFIhR?=
 =?us-ascii?Q?v3E0LJB+Cmz/uHcUPsn0nQnb1PPtnPvygZ2qyXhxZ3GN3el4iLbDN4w92bBx?=
 =?us-ascii?Q?h5C7HO9q25iGC+myfH1tzK+GrqfE3lSydi8P4Bd6gg98Mgr8Csnl7dlsASLH?=
 =?us-ascii?Q?CNMde+bFT1Fwbqz7zJ7CBld1QyQVxGyShZHTh1SE1WLYs7af/VGOZ/FKewTP?=
 =?us-ascii?Q?w7xE2N86Qq0g6hg82ktizeHGg/r4zS6gi62P8QiEU9+Em95g4k1Q2rYjMvdI?=
 =?us-ascii?Q?WwQt+7m3d5KkyJ+H+bp4toyA9COl5HKM04kznVqPn2V1Qdyjc3occ+Z3Zb/x?=
 =?us-ascii?Q?NpsD48JrZSZMuDJtQrIxBW7F4Wh90N//+8ytAUrjOqbr4dOF9eX+8xCBnm7g?=
 =?us-ascii?Q?tjM5qlerPM+AbouiZc40tad1onvk7+Hu6o9gxL3sKNCy1vTjilvw0g6fbblg?=
 =?us-ascii?Q?1EvViPCl63sgiy/uAF98/NwC87UJzOuJLABj3KEWeMXvWFKJDGxZXfvLSL4R?=
 =?us-ascii?Q?yV06orNg+TgFlMI4Aidg+V6fJqK83Vu0JqELrH0p5us085OgFjAvx3A/6f+Z?=
 =?us-ascii?Q?or4O9NHXEE+ME2B2CoGeEG21DwhJYMq/lUmEclhzGH74WHNcxd+kxA3IvnR2?=
 =?us-ascii?Q?K/4yOh1kejwtlSSvlLgWM3lzaRweF+RCjkTfxqywTVBITF7OosY3Dkw1o8Ug?=
 =?us-ascii?Q?xW9nLeKeCzf3htc3Mxl6t1rXNvZ4CEEToCw67nCiBHfcGkstG4kTm5LQ/+MR?=
 =?us-ascii?Q?uRpv3xEiQuGI9ak6CRe/ir/HQeiy5hewNr/b7RUx/IxXMH9EULpuBNWkk3r0?=
 =?us-ascii?Q?B59CW/LGl8nZMuzEo82bOK5czac4M9et/B0E0D6Ub3a5AL87wIEQuSj59G4I?=
 =?us-ascii?Q?Vp70dmTqLobBHW3F0ksUDoKtRtr+gMXfrPYFIknVIDpJE4Li/E1w8be4brN6?=
 =?us-ascii?Q?HjfJmyOvaNp0CDSTSOYx4iSWoW2GvCfs5VLly/fXN+W3k23CxDoNey75ENQS?=
 =?us-ascii?Q?2M2MAxUuPD0uR3fnbCjdP+XNDooNZCaKkFamIKhGQd/hPeFKht+ITmYYTWmY?=
 =?us-ascii?Q?KLNcCe0cRiyfMNMcUmOR4JoU8V7Icg80oZbgmIV5Qf90ecr5Ljs7wYvMwBAp?=
 =?us-ascii?Q?arFeEC+djDDkDOqwitXnyXMJ9QmIIPUqnc40B1pE1PR4lQ0fMwPAKwqy6dlK?=
 =?us-ascii?Q?KY9KcNgz/f1oUhlWotgzcu8TDpfFzkHE9n+4KuB5kNiFxIxUAzqEEk6rCtxk?=
 =?us-ascii?Q?vQxSAy5pFrUAdN73cBF0Cf/+xZkeV58nenfbSA7zpe6ewF0AqX7LCNyEYhAG?=
 =?us-ascii?Q?UnDjCGsB6IF0XsvNi+DliSv8kdsHIZdyYaUu5XbEphTyXq0RBaaZIEBsrNLV?=
 =?us-ascii?Q?MDyvN/U/eUDTMiq7/LMIkjG+oaTBoZqPtNhO+p/6ZZ7X3ds3ZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cGahToKIJxdKNG+aIonPaGOg847dqib1M7mnSDElYjL66beE5axsFWo1l9cF?=
 =?us-ascii?Q?MwerOOCHIY4skgd1AoDCxkWDIRbprY1hgtyueqhK4p0JB1WgDvjMq8IsvGxw?=
 =?us-ascii?Q?GjuBs3tyrcYWTuUXuahV/RBryILtHGATWA4E7aNWACEvg71PmZK7edmlmExZ?=
 =?us-ascii?Q?/RiBWxkWyhDgDCH1yjR8RAK0teTA22aIfY+vvCwn9KYf203ZiVRtjwb/ikVe?=
 =?us-ascii?Q?ddZK9YcYQatEMyyEFbvVM08RJbpH68mIgZC9jNoOhrxZ3YqIYC1IGadAsto1?=
 =?us-ascii?Q?knQOKq0oO/vMA2qHFAxobFfRTNsIeHlfvDu76cYkIMJto136cDMh4NbwLf9n?=
 =?us-ascii?Q?8D8hFpCi1r9ThxTft/nEfpP/gA9XBQ7KDJAhHOvlMNKKf04YZ4MsJxeZG6Eb?=
 =?us-ascii?Q?dDsQbrC03Ib3x1TZGH5rxIukaL9zJMJgm9r/sb2tJFhoKnqmZxV+vWlQoYXE?=
 =?us-ascii?Q?R3cAfv1QWdEmz8PBj+TzGaEsSlBjhJwoKdA6TNhpLi4dLth2lFMo2JJHouoq?=
 =?us-ascii?Q?bF362aXFKp9Xu9XTlqACSaOf1SFL4TtDId1RihhrlThkoedNXsl9RrfojixA?=
 =?us-ascii?Q?OYfGR0ylvixQyg28ygi3kz/W2VFgUP+lBVciCUMZe8pS967JE72A+gDPJdWu?=
 =?us-ascii?Q?ahiPmpv5Q56MDNSO35md5EyifhtVlpL/Q4QpBwObRbFKcR1gDw4bXEh/6K2p?=
 =?us-ascii?Q?MQSa7MTfK0lbvI3SopHtbJtHUVTboda3dG+bpYLEFLd329JewfNHBuTJEBg0?=
 =?us-ascii?Q?qLBJUDuwFwDyVewMxbHJOkvOLvbBV9biExDFXBxz6mEK3gygYL7WUP5i8tTQ?=
 =?us-ascii?Q?XrNTmla51M3B6lID9N2PIGRcjHkwVtPDJGL7oAoEwQug5U6FbxMOakiqit/A?=
 =?us-ascii?Q?c3gaqFQ7xIxfEnF1SSGKbCR3T5ldXXWed9pzx/iH8hHvXHuuWoakurPPYxB7?=
 =?us-ascii?Q?tfcZ+FwgOaI7dD4FM8lEB5S35Zk3abSpONYdJgGH56lAAQLumSSUxkQyKFl6?=
 =?us-ascii?Q?518XxtnwqqxCXIDkPhoXhO/oge8ZzJ9zZ/AOqoAJUBqisdEMAKpIyXzKa/Xp?=
 =?us-ascii?Q?CCjf7tm97DO1iDkZyova5Avqg7mpg6eZ4yinyRbC3j5LHvNS1mktcYFJtdpM?=
 =?us-ascii?Q?bysqvmDCCoAbQXw8qwLmS7CEVjmThOIQqFQ09bDw1x4Y/ny+tBvYPG2yCbjZ?=
 =?us-ascii?Q?1gz0ov1Snw8mHLA3d0hAHT2Eyo6UPX8tAyEicKWLe1k0aLUCMn/8JEbyBH7f?=
 =?us-ascii?Q?R0hbbkO1gkVQ844785xiY906/wIui7O0sYDy9rMEl8ijwQbyyLR8WyVt2EMI?=
 =?us-ascii?Q?KlqvOcYioJ56ymlSlRN6T5p8BTCe13DcjHsbk1zDZUZ1i5QLCyJEiqBMeMBo?=
 =?us-ascii?Q?gUN67JttFh0G+rzkkizrhoXM+qk8UU78ZnsYK3epjaeSXajn5uNf/MkeO3oE?=
 =?us-ascii?Q?OQC4Ay2uriLHk2/N51WWmQQkS8JL6VtVNJvUpvM+LbWaMrHBwcn4Pzp65bkO?=
 =?us-ascii?Q?fafobLst4nv4rcVWAuM4uDz0SuFir5eIyJmnYP9V+vxUaem/GoojkbW2nMu8?=
 =?us-ascii?Q?TZWTRgO2zZumsIonfWo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0db83e-d19a-42e7-e2b8-08dcd326c643
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 12:31:06.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVvbP1qcFc6X6oYAw88TwxuJY+R/U2NL7hcEveDAnEmfhb40nXpiJ6wVd+L568mFtgxz/6c4hXmCRNRKnQyxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Hi John,

> Subject: Re: [PATCH 1/2] pm: cpupower: bench: print path fopen failed
>=20
> Hello Peng,
>=20
> These two seem like two separate patches and usually a series has a
> cover letter. Did you mean to send them separately or is something
> missing?

I think the two patches are just small patches, so send them
together and not write cover-letter for them.

I could write the cover-letter in v2 if there are any comments.

Thanks,
Peng.

>=20
> --
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat


