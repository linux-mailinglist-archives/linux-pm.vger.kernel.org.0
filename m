Return-Path: <linux-pm+bounces-25257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9153AA85ED1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609B4163171
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923B137C2A;
	Fri, 11 Apr 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7iadoiE"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB02130AC8;
	Fri, 11 Apr 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377820; cv=fail; b=I/bGDgQGywyk+svuA/yESEzhZkQvb+3HEuWooAKLdZ9V0GzdRIJMttheCVI6tHm3ngwNYVXxW1LJTnnJHl1tkfrArqzG3rilrBo8HeX0o+swUWo7ytNx9tm4ufhYPMdV8n9TCnHZE4Tr0dK+0bGMq5+rD+FtBurMaN4WLfi+REo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377820; c=relaxed/simple;
	bh=8VMs933QJ+9asxhwWGwlkqp5ctY246DrYmulCxU2DiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oV1CKcQWMcd0WbREc+11IsM00UD9yh/uCyeWShg43pfqj8mQxAJuV/QvuCTnNB1FFDz6FpePUq2qW3rW5HN+pEhMtIq8YhWdmv9s8Xhui3bY5L4hh9pAcZIi4TEp1WfbDQGw95qv9yd+dm5iIQ3+VP6T1y2WPIrOpGIacq8XigU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7iadoiE; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaXbEfdO3+RPr8UT+pQGEM9de1/BEdVaIjyo9ZTREntGDEWgP7TkpZeJXkcNeuPB18ibanklPH6IWQf+KU9HQ1mqnEVk2LYrvDcB0Ak1n7agKPn5Xez/O0jxTNqAGkg0fCMgSWn5DAdiCmuDqGB6c5Cs7sFVWL6mREjUFFW+4r6GnoU7orVkDa9IB2LU+u4zD4yLwr+ndk0Ye02MtNrht6z2kv2npzbif2YynaivJQDenPALdsESkmMix/Eh7vIpqSFAqDLQ7iD08HFKjU7V0AegcB4j1PLkSSuO9nl2TWIKbbRcGiKPj0GqkCt2yhirzGjvLtQ57lM60/s2k35Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ifqa6N+2VsPbK0TdvsdwoEvR7+fGFe43iGVaC3mdc=;
 b=iH/Z7pGUdp4h6poTvQ0T89xCpew+UcEnOac5FAIoYx+kiSsdwQxyI6ZK5i/jIPfFLWBt/xmDsJS12FX2I3VOsbaHYxh6/85/99qIL2C+e2DMUPsDxvvTrC63Fhx3aInggLAU9kAxxTl9aIf+thPhWErtPQgLPI+kwynjtHs5H/4rH6Ego7UevIQFyZ6Ar4OFFBMS6Qov6iaLSmte8Dfl+CFRWu7apoLBVqVoefZuKHOuWgpu9CD/lTRBkHiiXQusdr+wg2saCQmL+6L2njfYZcEQ9AIWaTMJ5yp2pM8Os4JvDT7f9tqoKxA9StNwj5IpIoh1RbxdDSETIbZLq64Wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ifqa6N+2VsPbK0TdvsdwoEvR7+fGFe43iGVaC3mdc=;
 b=J7iadoiEsLs3KXyGUMhb2Y++cEg7UqcAQpIAHQJc4xDt4f/iMpnnWC21WAr61y6m1CFDcyFgqOhxFvkraC57ZwMs6CbsW4frl1DazFDwfONEeftXAOvisxG7GK8KICwrsr/wmxp7ypJIXQfqPFSyMy9AO6vJotUQzDaSag2rIBkH3I+6Gpooe1TvhAFBmD9Ht/yFcazDXWdy04SNaCihxl1alUNguY1L8Jllb3EiMGIjyGVlBqm7N9mtWa6BAr8udXFYqgbrqqSfum6Bcm3ddNb30IQnH1JAmYVmaoYGgm+UI7EBd+OgmllfQdPJJJrFnx5cGPr8zsv01sYzzigfiQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 13:23:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 13:23:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Hiago De Franco <hiago.franco@toradex.com>
Subject: RE: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4
 is running and it was started by U-Boot bootaux
Thread-Topic: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Thread-Index: AQHbpWxIyVwHrK1A2UqE7zPASmzQ0LOedbwAgAAHyXA=
Date: Fri, 11 Apr 2025 13:23:32 +0000
Message-ID:
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
In-Reply-To: <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB6811:EE_
x-ms-office365-filtering-correlation-id: c75b544f-b651-4a50-06ed-08dd78fc0e41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kGXjnapULFRiTBCrdwigZI1HWIupZrY++PUBn+a/WjWRdSJfzKOQ5xTse0fc?=
 =?us-ascii?Q?1hT9gRC0ldy3MhTbav463+cgCvBvWW63kDzmVuG+ERmHiLgs7NMMWjKB7Zl7?=
 =?us-ascii?Q?+jAcOse7lXQ7ZsBZzowxaYKb/cLv+MaFd1WO+0CLa9uJYbZfaGMcDVNFxnWC?=
 =?us-ascii?Q?dIYFUH7+Xv/eX3VFAzuzK3kpsVzLJvFkliLsAzgzlcJwHXh1xmIm9vI+WqQG?=
 =?us-ascii?Q?chcL7g28LBCxcVmevqvvz+k+uAWNIWqm4vPJvYN1UJnD0Ka3eJWy9Lj/leZo?=
 =?us-ascii?Q?pEM89yfnZpDvwIAFoxjGv765ER0lrbLS8Z8gAYs3StPL5RNEWRaYS0cUMqFl?=
 =?us-ascii?Q?h7EHgH9o4UriQG7SpgxMXFguBIq4Z0+EXC/fDvdYzB0WEkXY3qnHoCup/isp?=
 =?us-ascii?Q?Cf7HBneRgEdgMJjtygLYj/c7IGUapsXgD+ptcu3q1rgQjN2q4uC5/wGBQmdj?=
 =?us-ascii?Q?aEXmkILI2BwYLVR0qNlYZYEyy+aXU57dDvx6ZJoBAFArYni3SpC0JTo3VFlN?=
 =?us-ascii?Q?HxAE5+ziZs0WK6xfLqCiOdeS1TjpCfBC1SrTM5qNmMo25xqdaKzg+RlmLwRY?=
 =?us-ascii?Q?K/BnyvG0kpf9TJPbVeeVyT5z1rOA6zECVx/NUuGSVPB7WDxZbGKZe27h2ZO3?=
 =?us-ascii?Q?dSbUKc7JE9SfQlfpKEl7aaURGoLMOoaQmysDrFMCaNmgYJfu0HwOUXnVOzsS?=
 =?us-ascii?Q?OYpGn+hCnUaMx3b0bdlEajnmCplIPuRLVQFl/kRTWKtUuo7+N1g2chIFTsGg?=
 =?us-ascii?Q?1bWcaQAdg8YgVRAXFiLXnvXNNdu7xc6ISddxtwRXw6eI5a4u9R5mP/wD8c+y?=
 =?us-ascii?Q?PEsVDVcAihP0b159HaOLLcgARGlVOYqWLTOSOqq/4QJqDF/oK60ksKr1FcJU?=
 =?us-ascii?Q?KJy9iyReZQ3v43eBTIbqvdFkAD9Qiza/yVlh/UMI2zTXOTfrpDytAnjEnKJu?=
 =?us-ascii?Q?GrQvO3Sjkf0W7bVHqtQQstwDjXC1vXvV4ntFhT9fHOZfKZl5PhvzEkLaW7q/?=
 =?us-ascii?Q?2Q74Fxj9NjmxMmSx+LxSeJDirmqgqr8OqUsh562DBcQyVWHMTpcJjutra8z/?=
 =?us-ascii?Q?nXUv7Ux9z/c/zGIjs9Z555PKTUP14MjagT1+zdlqOi95ibYvQsXlV3HSfzZ7?=
 =?us-ascii?Q?0T51trXogBJrvnNnGZhNsb2ERt7N5vBAuql22hq3g8XYWbbFqmJFKN6MA8YR?=
 =?us-ascii?Q?jemH64DTkIbUszKldOG1pn6sKL0CKxx9WLay8DfdWetPtNnByNXvub0nWcP4?=
 =?us-ascii?Q?THCrGsEYA6Dn3rbDeZDrkJtXtuZrCx6tAyMqnt7LbD/FOgz+9TlJCBDgedKs?=
 =?us-ascii?Q?rRrJDO416/hbAkQovnKbn0z+ebpDwm1a6+Hfui/HgqHj2TmzIrIDQ4t1PCiy?=
 =?us-ascii?Q?Owg6OZlBPSskohQA2la2q/pQ5trNPrJgLFStGDRIRA8qBDGtBAjCN+Rq4Tr0?=
 =?us-ascii?Q?0au/fIeEB91ZQcEiPh47LnFvOXFlvW18UmMFOsF8+Pn5tNgoNCJ0zQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ORhBxP5OFDlryCHVIZF4GjZftOelB9A01HrtoQL5QvPer/Z7rdqSTY5+rlHz?=
 =?us-ascii?Q?idh7EK23/YX3R2n/pfd6ddgcNmhzLwQEcNxZ0Vnw0fxwmSz+eJNg1OoGlJ9C?=
 =?us-ascii?Q?cnqcO9RNM4b2NByCIMMSOi6eyTFGbBFdhG29lXRgldErYJ5uWP+9+6Wa/c6Y?=
 =?us-ascii?Q?Ux1rTMFUrVYreYz/zuEpi6Epq+bUVagwQMuzs228Fs5ZDkKNmQu8VwuBOn3Q?=
 =?us-ascii?Q?PRnvmol3S0vNFv3nxg8M1O/Dt0sMqBPsxaWiUfZNqXSGT/Hz9/0lbPZWheif?=
 =?us-ascii?Q?J41fpE7nienpv0SFebArjn7sVtAhEFx9vHXeAgaMMghgXlXndjFlJTQcmiGr?=
 =?us-ascii?Q?DJK+XzSNAMAmh6NWv4q23FDsWwIm5HL+0SS3NjyI293nGMab8l1Gm7L/8394?=
 =?us-ascii?Q?oqcD9UqWBjxNvuJ1+orbLGQ/JBW/jZ2RxQFLZAa4K6g+V5EVVi9PWpyx+Qk8?=
 =?us-ascii?Q?gneMaYQR8YNpZTmZT8s3pcQw3NRsoe3zeCstJbtJlxN1QlqBoXNVQtNnOUIH?=
 =?us-ascii?Q?UT+jn746gGQvA6YQxkQ29/I8JiMsF6S87W5uChIEGv65f63UByVveSmk7g3l?=
 =?us-ascii?Q?l7u2O4LivMFOOZ45kHlGMLjKVyziKbHnwbTBYjqsXOUiZqExA6b9dh59KcVC?=
 =?us-ascii?Q?xr0HoyXeLekfuPI9Ek5vv9Lem+EpKgplO4fmhKXCtLp5qqH2yRC4tU7AkCd3?=
 =?us-ascii?Q?GPe5fYywneDd6rCR89uvt0La56F4Xiu4+DOPXu/Ar32HLa8yQkrJ/7rVJdkf?=
 =?us-ascii?Q?vlgk+gwALGYiEUeSkO4q1Jxy/X2DdFDGPkHCo45WqrRdFiXHtGShvKYVYwFG?=
 =?us-ascii?Q?R8MXtIAnSvGeYNfGnai6puvS0keCO2pTTPu4ijyXdA/9pbOq821xLdpKhBq6?=
 =?us-ascii?Q?k6FWnRQU+2mf05WCJ5OKgLYsEOoD7GXgIoktAMX+63PkWzVql1YwGUmbT2dW?=
 =?us-ascii?Q?2RaaHw3cPXSxIkWDP/wROj0ppneim67DP1cBZF7pPie/PKY5aKT95V1NlOmh?=
 =?us-ascii?Q?m43tm6C9s9tzjNjhdU+tVTxvUZR9oMT5GdCJ9cjcFVRVxQE+kKXpTdkra9FT?=
 =?us-ascii?Q?9SKKnLkOSngsoTDji2siMcvH194LnAvHnIrokxPnLBP4nYyJIBSsW8oKBw7S?=
 =?us-ascii?Q?bffzsyl8x43TNkNS4rgQcDakGrirOQ5GbukMij9XtmsSL4CwyBeZLBg7X3Kv?=
 =?us-ascii?Q?r/ehWiq5InTk5GQiSI7g6grTo8JzSSLEvWJ6tDylFwxqiYKX5yqnTMWUvzY4?=
 =?us-ascii?Q?+HFdPoIIQ2Bw0KIrJFRu6SOdcFAKtdI4MCrtpJ+b6CqsiL6q+sQy3zgOuI9M?=
 =?us-ascii?Q?CNbsN1DfXoJLQOKN7OLPiX1a2eyjKN1I/KvPP1FSKnsjkQf5MY6Rjxfeia0b?=
 =?us-ascii?Q?nMGjROM+RnSCyp/DcN/d9Ja6ynzW3X0Lvv/KdV80Ji38XCNm0sjNPJBVJ6nY?=
 =?us-ascii?Q?do/UtO68wxRiYn95I9p0sjgk38Ch57eLGxPE4w/Lh62HBfeUnP+JaHEL63Sg?=
 =?us-ascii?Q?Jb9tbcyPuxv3xVzF9EdOw3cb2eaqDEZk0uII6lb+rj7dZqSI1/q3DAtsYXHn?=
 =?us-ascii?Q?ZD12DuObfZhWgfYws14=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c75b544f-b651-4a50-06ed-08dd78fc0e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 13:23:32.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOrFtEwNzGeIY4kmLq5VNo7af2nocDGa7r0ey7S5NG29vI/004O/e0iETpYOW3hMxQg8e76OKGkBBJ3A2lwRfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811

Hi,

Sorry for late.
> Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when Cortex-M4 is running and it was started by U-Boot bootaux
>=20
> On Fri, Apr 04, 2025 at 11:17:13AM -0300, Hiago De Franco wrote:
> > #regzbot introduced: 4f6c983261
> >
> > Hi Peng and all,
> >
> > Commit 4f6c9832613b ("genpd: imx: scu-pd: initialize is_off
> according
> > to HW state") introduced a regression where the Kernel reboots
> > unexpectedly (without any warnings, crashes or errors) when the
> > Cortex-M4 was loaded and running by U-Boot, using the bootaux
> command:
> >
> > # load mmc 0:2 ${loadaddr} /home/root/hello_world.bin # bootaux
> > ${loadaddr} 0 # boot
> >
> > This is a simple hello world binary that prints a message into the
> > M40.UART0 pin (demo from NXP MCUXpresso).

Which release is this image from?

> >
> > Before this commit, everything worked as expected, Linux boots fine
> > and the HMP core keeps running and printing messages to the UART.
> > After the commit, the kernel reboots at the beggining of the boot
> > process. The only relevant message is printed by U-Boot after reset:
> >
> > "Reset cause: SCFW fault reset"
> >
> > This commit was bisectabled, the same device tree, u-boot version,
> and
> > SCFW versions were used. Reverting this commit fixes the issues.
> >
> > For testing purposes, I created the following patch which also fixes
> > the
> > issue:
> >
> > diff --git a/drivers/pmdomain/imx/scu-pd.c
> > b/drivers/pmdomain/imx/scu-pd.c index
> 38f3cdd21042..0477b3fb4991
> > 100644
> > --- a/drivers/pmdomain/imx/scu-pd.c
> > +++ b/drivers/pmdomain/imx/scu-pd.c
> > @@ -539,6 +539,9 @@ imx_scu_add_pm_domain(struct device
> *dev, int idx,
> >                 return NULL;
> >         }
> >
> > +       if (strstr("cm40", sc_pd->name) !=3D NULL)
> > +               is_off =3D true;
> > +
> >         ret =3D pm_genpd_init(&sc_pd->pd, NULL, is_off);
> >         if (ret) {
> >                 dev_warn(dev, "failed to init pd %s rsrc id %d",
> >
> >
> > Test Environment:
> > - Hardware: Colibri iMX8DX 1GB with Colbiri Evaluation Board.
> > - U-Boot Version: 2024.04
> > - U-Boot Build info:
> > 	SCFW 83624b99, SECO-FW c9de51c0, IMX-MKIMAGE
> 4622115c, ATF 7c64d4e
> >
> > The issue is not present on: v6.5
> >
> > The real root cause is still unclear to me. Anybody has any ideas? I
> > am happy to share more details if needed.

Have you tried pd_ignore_unused?=20

I think it is linux power down M4 which M4 is running, then SCFW
reports error. So please give a try pd_ignore_unused.

If this is the case, may I know do you have m4 nodes in dts and
with power domain included?

Anyway, I will give a try on i.MX8QM EVK.

>=20
> Hello everyone, as this introduced a regression, should I send a revert
> for 4f6c983261?=20

Please wait a while, I think we need find root cause.

Thanks,
Peng.

Or any ideas that might help fix this issue?
>=20
> >
> > Cheers,
> > Hiago.
>=20
> Cheers,
> Hiago.

