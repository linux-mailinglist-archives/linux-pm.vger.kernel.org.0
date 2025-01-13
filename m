Return-Path: <linux-pm+bounces-20321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC64A0B5D6
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA083A1251
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2522CF0C;
	Mon, 13 Jan 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltanpgRs"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9522CF00;
	Mon, 13 Jan 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768250; cv=fail; b=IS0cdfiQQS92BwwCyUcZiwjjdjG8U9DYHyj2Vm3WNnYSLD0siIei1gcZBqC/efb5fj8aGcxWRFIE4qAqTm4JGyw6yTO6vYgTNjhd4R8ZtwI3kY/yfA7uK+nCXBuH8LfsQA8BLATkFj5t6UudOBWv2sajsfC/JsZ2lKIReoLfpc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768250; c=relaxed/simple;
	bh=1wOr+QyrX5yxcT7d2QM5eAx6iCn3ARXiVZwzDt/1eYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOG5paYMLPWB+uz0L2539ZgdRFnEOUDCWylFzWRvNsjqeqHzcQK5Zxq/ec6pJqlM/5RLgmtu8FPwS/LTAqRrskSTii9WWsn6sCGRsVQPzp8Rl1d0CkjuXjcYlWDgLfSJ1QI9VIg+xQdWVsdhb9DzfKEUlteDYnb/nyJBAScbn+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltanpgRs; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLQBIfE/CQtblevhJ+nct8PgNZna9v4fjhn9zWVn4aETmywuLLfbAsMLJOJqJDoRnUbtVuriXm1EwivUr5ijJ0DlRzV+GtMU6mKB1xPcHgNa3u8m+lOBNJ/hmX6HDuXYM7MI0V16IZOBrMqz9tHDV9HXWkbhw78cE8he25qXTF7FW64XDPrjbG00z48U5lSBYmjwHvpBEe7f50H6d02qe/sodepI/HcDgToQrpLbKwlnAcNrlH4MBnS/Z8tlmOGqIb9vvStl1y4S0gn3dDkKRVTCx/nnRv5Slo0+WgbEASihm/zAtjQkwK/GWwLZjv9JJipzIzAu15JOc5qgQOe5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wOr+QyrX5yxcT7d2QM5eAx6iCn3ARXiVZwzDt/1eYo=;
 b=YplMxk+O5RYX7BstHUY0ABCkNAPQ6mjlr64YbeLUl89jJnH75EfV93aWbvKp2iIxiydxHHjKRljerKudQ1tKtANqdg/l4VXsMi7WsQi+dQCdmoNOHXiLUr6mpNBzmFv4W1OqNASzHZXi7AWlA2FT+SyzBNFJpVTAL86nfulW3DSgicmmXu7P4Cmoshw2TnoSq9rX5YKjR7THFijJMw2ilUj2mv7t+uPKak+HOM7GtCvMxvGv10P/UAGX22cZ7newdtlpf0TGJMMWBFxDul0bPv5MVyWWKR4IUrjw2MoLL2ezJfhSb6RooW0WwB9G5hDUlnKb7J7jIasrnkDRpmjdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wOr+QyrX5yxcT7d2QM5eAx6iCn3ARXiVZwzDt/1eYo=;
 b=ltanpgRsHG/bjEwE0GVITlD2K+GV1fSB0rmPCTTDTRq8lB+vqHGY1il6acv0hTZfaUDlb4N0NCanMcxicGBdh3AO856tNmhqC81Lo7rr61ZoqlVfGtLy/InCDCG6/bJj4NvKNf5iVBR4rDUuMlFJa22iYXwNMuYcFC077AXMU1cqbi/WsAdHkseK2jr+rlffKFYgO9k/yUq6z+D6FRJOdXll6tQ2iyYf1QXm86KYDsLUxfN6GxTRqhTWsEFpTf5a5HI23r0NBB1Gx+CDiW8UTFeWBSBXqcKMRxAoQCBtDFONqbRq++CPqw8eEE+1GsIfInl1jkZ9U0XH9xkOalYUuA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7626.eurprd04.prod.outlook.com (2603:10a6:10:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 11:37:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 11:37:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ranjani Vaidyanathan
	<ranjani.vaidyanathan@nxp.com>
Subject: RE: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Thread-Topic: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Thread-Index: AQHbYybo8rOmeh/en0qIMyX2XTiTxLMUhkWAgAARnlA=
Date: Mon, 13 Jan 2025 11:37:23 +0000
Message-ID:
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
In-Reply-To: <Z4TreQ5bA9qiMTgC@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7626:EE_
x-ms-office365-filtering-correlation-id: 7697b2b0-f7e6-4c1e-7592-08dd33c6a60f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c+R7M70Tn6byx0gslYWRkdyTJoQs4ZO4Xq2uhdox0FV20UGFQ/XfXiu86msR?=
 =?us-ascii?Q?34DU1JHJWGI0Q264wcD6qV5NxsAe0iH8rbvvrkd/7GM1g1i0YMxKDx7y98Hu?=
 =?us-ascii?Q?9e6vElDv2Ls+u6eHFb6a0ciaPKCDCCBLAqQDRG4bQJNyQt8N0V/W0tELVL3N?=
 =?us-ascii?Q?GJ6ERnoJweWygjsONF4f19wKcgBzPJfJmx9kZcMYn037eH7M3h0CpXq000fU?=
 =?us-ascii?Q?TeJoNibFVj5BHRd/ZxVGI8Fi0cBvlA3PGuDIlywcLd3+2soxP5RFbtpZtq2n?=
 =?us-ascii?Q?hrowWngXGnl6ZIHbt8fUixJZE27QkCVhSgxpXg0k9RCjmVUWL8fEiyBcpx6t?=
 =?us-ascii?Q?OoF2pvcA0Vm+ZLJfK/IDqa+5JCtLAMwKWXoPVGmdl3M/XpNmPmnKz+qObnsq?=
 =?us-ascii?Q?uGYjlx+/qS/2bja8Q/ovapihCmmEOXtFwVjxHN/WhwP93FBLyopPaIgyCfLU?=
 =?us-ascii?Q?c/LnhBZCQQ3cJaf89rdQFUgj323fKh2noPnRe0K55iW8RX6bHrPpZUzhc0eU?=
 =?us-ascii?Q?vVPNQ7xia7hrIk0+ygFO8hFjxm2J0QT4nnypkBPSZswbgUqxtkztVlzHnynn?=
 =?us-ascii?Q?1JEb0mknC8+nupTMmqof4KNIPCgqsz3ixEhIz+rme0qi17Zc/a1YlVS6ZNh3?=
 =?us-ascii?Q?tgjvFkhtyhCRkh/weS9hwPeN8oEelVRhFNdrR6ltq0whTx4WHmCO2ay/PHlJ?=
 =?us-ascii?Q?sHbmPZ4DJksEbVKxSvJxnqrc7lsY7wdTcyMfAuQ/NHKpocN9YVRVndNyvM2H?=
 =?us-ascii?Q?xFch0cPEvo1JptCqCTkfIir8d3F0i8XNnnTwByW423Bj74cSUh5Zmw30cYm5?=
 =?us-ascii?Q?A0F60HWNqWS19NarDj6MmnrlyUeRb9AsB6///l9fB5T1yXk/5o1RTnqPXyWB?=
 =?us-ascii?Q?6hOHH/OFDZ7v/HZxbxZQIwC6zJyI8hqG2WusUq3l+cKLHixcd2FKIHPqN6oN?=
 =?us-ascii?Q?DAyyyAqrh3AM71BADfafCEuK+TzDHpYJRZdY8newSHB1EKYidf56YGGNneeQ?=
 =?us-ascii?Q?7HtcASDrZ6g4efLyAgZx9wryto8VAuTt0vI7Hy6Bdm3nRZa8+7dnwVjlPUBe?=
 =?us-ascii?Q?P/UC9Xq/kcTpiYeURRT8WtQyElZZuewX9CNkt0CgUZ4CtZjqN+apWMg+r4zr?=
 =?us-ascii?Q?ZH5X0eXL6YbNp0Y07O/tfV71l44susmqUal4EJgro8D3ZV+hOHUjmfG9j2Ma?=
 =?us-ascii?Q?CJPnaG40eQxdKXqfsVMZyIuphu1DYi0ftekYa+cWu8uP4vN9yhLaphVBcMe1?=
 =?us-ascii?Q?YoE8DFflBgC9+mdIaJqIy+Oj0H8V60CBBTQtK9/HhgSQE6KbA4L6e4HZPq5Z?=
 =?us-ascii?Q?ulFtZ5fcy7VaW43sio8cs1SWnqUWFYboLkrPszwtCtmtpeA8tNbYERAjAFkk?=
 =?us-ascii?Q?nCQ8a2Hnw0TcIEnqBLA20k35UcutpKjtw9iKnI5q/rc52+AT+n18zYhhTD0b?=
 =?us-ascii?Q?7sS4k+8JLIObdsRO/GfIaGBYze3vDVcm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RP93KBir1VoF1u09HCd2b0p8XRy0mZ9JUr36ir5kOBwuxilzz61XyxdIGoT5?=
 =?us-ascii?Q?DgNJ8AfY22fzFcBa/jloQfj3vQdL1t6MZwfZR8/Nwh1/CUygQDZaGEhLbEGE?=
 =?us-ascii?Q?ovWAkwUEibjYldeHIIbVk8nyHeQCaWnXYSPBKj7bMlVSZ0pO81OqnbHRPRG9?=
 =?us-ascii?Q?VfKD3a/+di0dswJ7XeiZyGPKTEqn2E5k6j/GarOb95nVyCcXBqCSJJJTXkf5?=
 =?us-ascii?Q?eOiK766ZA2l8qhuKvlTijAx2cnupdhOcoOPSd+j02/oKKkjWLDV/5ecIsWQB?=
 =?us-ascii?Q?zIuF0h25FNUyHOZRoPY8f/rdGdxjTis4fdFZAUX5fby9Zu2ZBxDM0p5ZwPsj?=
 =?us-ascii?Q?8apaOYxRZ8LqMliKUgimBm5/jI5NZexKXhuMQGNnp4vIOm7wztK9SnfMlmxA?=
 =?us-ascii?Q?GolKoAMbuA84eeAJ1RibxvaGHpkUjR5F2pXh1unYkr0vpFyOe4wLvJHggQZV?=
 =?us-ascii?Q?Grxp/AuC7vlGSU8gnKPnqsDfPCI3kD4Z2eLVP6V1yFCViEDsYS96sqWnmF6v?=
 =?us-ascii?Q?NA2OEnhmofkeCusNvBwqHyni/QD7e5j/6ffWDtlUUlazgNTh4YvQRSqIwK7R?=
 =?us-ascii?Q?82lDYi6AMhbSlkvSIAKPKHqIB3xp3IRmTIebnyly0Mfo7Lbi/Skhhg3uJ1YE?=
 =?us-ascii?Q?MmALiWyJdteJnW6W6QWdiYM6jPUbgotTJYQ9F7kdakMbjvowYAZ99JA5Ii3s?=
 =?us-ascii?Q?uvnhvCSurgcJ27AS90z5Lxfr1IQskm55RjuWTaUYhgqFA7D6jFw+1YEzlViD?=
 =?us-ascii?Q?m5bz7oc+ygPYXSbdATa711RbhOIXDDnFJKqE+YkNeNkXzRBsBdQIPKtIiZ6D?=
 =?us-ascii?Q?t5VQ8/2FZff22Qe89veMLvNO3Si8RpT4+GI3YtWWUhZfMMsCi70Pc40yh1ud?=
 =?us-ascii?Q?eESP/4rAwmSaGr7JDUfbwqQCTh8782il0qZ6w8+ooyxij2ugfZQdx3c1v+5P?=
 =?us-ascii?Q?Bzg5tMaznulGBYobpHcOVB81AijTyBZX3MVB7SCAD3tt7ib0eCvMlHAC60XQ?=
 =?us-ascii?Q?pequWxNf3ewYL+FThHkNxBFul9RM0zWNsyBL+llWuruXeCYrxI5L/iblWLQL?=
 =?us-ascii?Q?Tlc82uM7GXb8eD/zWZOQ5TNI6j5qalQ9xNcuR3Eu5hBia/OaWlzaS3svhlv5?=
 =?us-ascii?Q?6hWXxV+Uh2CzComRg+KH4ujWC9yOkHC0EhofjhnLp1i47el4HYunfimNDzu0?=
 =?us-ascii?Q?tRfsPFnixWMykvXx307CvSN6HjzXOeF1HAdeEs16zDnOs/iimqKNsO5LvwOQ?=
 =?us-ascii?Q?n9hgVZv6n/jKXbU+Jv0jYEzVsVbBPTQI2oZi4gA0SxpyKYigZRo2YaPglobx?=
 =?us-ascii?Q?uYpzoRQTq5Yiu8a/eg7TfIqFeuIqUYLdwJaNVhTomJDs85caA2J+H73Kcepm?=
 =?us-ascii?Q?FyhcV0rCp/SPjnPgNmLYvLOCLO9bIZrB/Vi/4rWseeQBZub8rAdL1UzzbjP7?=
 =?us-ascii?Q?J5Xms9T+3JEd+geLiijAS6fbCESO906Spdz24ud5PqcwqjzOTFQ4FAVZsp4v?=
 =?us-ascii?Q?n27ToRucaXzTFnrG6qs4GOGrXC2Mxl4seygw7YzIaF8br6gfmKuV3aTD565J?=
 =?us-ascii?Q?fymVS48I91V5dpimGac=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7697b2b0-f7e6-4c1e-7592-08dd33c6a60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 11:37:23.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evruhrHdMkcS3Os7WzQacTZAzDtylwDVQOmE4+cqA/mjqL9LBU2I0rlkbp7DXWQBrX1WR/8lt5djtrEfcp3Jbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7626

> Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
> state as off
>=20
> On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a
> > resource if no agent has requested to use that resource."
> >
>=20
> True, but ...
>=20
> > Linux Kernel should not rely on a state that it has not requested, so
> > make state as off during initialization.
> >
>=20
> IIUC, this was done to avoid any transitions if the bootloader like U-
> Boot has turned on the resource and OS can just rely on that stay.

But if it is not U-Boot turned it on? Or U-Boot is in a separate agent?

> Anyways if the resource is not used by any driver/device in the kernel,
> won't it be turned off anyways ? What am I missing ?

Because the power domain is ON, kernel will not issue SCMI
to platform to request it ON when kernel needs this power domain
on.

But in case when kernel is doing some jobs that needs the
power domain ON, SCMI platform might power down the
power domain because kernel agent not request that.

Thanks,
Peng.

>=20
> I need to dig details, but I remember doing what this patch does and
> reverting to what we have based on the feedback IIRC.
>=20
> --
> Regards,
> Sudeep

