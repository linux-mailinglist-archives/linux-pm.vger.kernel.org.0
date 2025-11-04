Return-Path: <linux-pm+bounces-37349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F6C3059C
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 10:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175583AF9FB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF72D1907;
	Tue,  4 Nov 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K1p/BoKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A501286D4E;
	Tue,  4 Nov 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249596; cv=fail; b=DGFqQAOhmW3n/Bv3LJo7fSItBbvX1/BOqxz7mVJWUmeMzQUb/Mqrh35IyPJe+54jVqq+rQO2YdnEzFozHTPF3zgHj9/RSZ8a9QTx43lbME6Xyqi7liSqPFClpRwAY6rMNAak3v9tcJTQErdKbz70x7634nc5R4DC/p8SwV6QMbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249596; c=relaxed/simple;
	bh=TZznx5nJ6fY0oqaFnNLJ5OMAV74c0jjRMGO3RijXkuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhFaZbFh0VpNLJMRvWhDN8AbOnqnh37sritGjK/ejIaqb2OWGjK6TSblkHt/6qOfk0iSQOsJrfapNKerPsGTNtA9Jxsj8K9PWjxftMh48jdEELeDC14ioNg0smnpJXCjdgQxdj7gkUsC0OiRda0gh3iEop92b4kq+ZT5ifnmRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K1p/BoKt; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR6wstzddL7MEz2sj3xrb54I5t3JWU/ulI6E6NMbTC5FdLcv00hE2Sf20DlV/kEFhWWYj/XPtD9Lx08yU6PW/pPPUs6YBJ9lxJzxG7sJcaASC6REp7IEg+XiGOpt6c01zXTzEbiOV6FNG3jux7RTaiDkfEm7pMX6ZCl1QeNND9YZqQ3wwiw4AtMSZgFS+aVHBJbpMRPshyps7ANnEzy57Nmwe7HdvZMR1sM3RBUDaCThs0N8x8KuBAClJiK2CBpB2QPWQXeOA/YXup4xlQunGaEcF8qoqa9ntsiYYrHnliO43hqxQHBjVb6XnQdFBIVL+qzbQhfR/InbfNQVcgyMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZznx5nJ6fY0oqaFnNLJ5OMAV74c0jjRMGO3RijXkuU=;
 b=EZq2G37E0EYIgXExUr/ahR4lbxW3dMOXh7iUVUOG97o1/5Q/SofTvGdrnkWG9Q4uqFZ+K9bZW1bHNE20jyvJfVb0nuCBD/qqzYoIdjI9chPRtXg5uhBg4IFtXdRXPwY1uOuNzTQ4Hg4FIibf3xtbMnovwZ0orIl3ZT2A4NzYr9socwwuvhiFlyhjLstz+EqNx548xsX+IZzqyRsdzKaq0CJpKltr1zGWy/jScI8flnrCUuHlTb4Dgs/kBRq3qm3hlgBP1A+GcLeAtlM0N2fKA1UVZKWOUlvR8YHk3AUmAJsZF3l88m1T8n6EptSTlTYQEGvv2PjsCLB0l4UXgfgUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZznx5nJ6fY0oqaFnNLJ5OMAV74c0jjRMGO3RijXkuU=;
 b=K1p/BoKtSVG7ZVBDbwNH6+z84EAchZ+qhm/SaUbRtzEteHZ4EXFXt7IvUlWMpsuz/eKC2V+sxMql97WY9729FS4mge9gfyZzoMaw/WNkM1dJqHKagGzSqqnkS5mf7Vcmbt8fqy8OWNRM8cmSD5rAWxwfq/vBM9+h/ZRsLHQj3XoFoMi9sD/ABKRzlOttwMPTgnAidi/2JFDMTTi9aqGYQVRm58edyPxdyd9nkxbKFFr2rgLZmmc7rOe/ayMm90uT5uVor58Ru12RhkBl8HOQ+R5huxNrhRFlyThrOidqBLgAio9OkhG/dAIjih8fY9wLVFIdv4xW/YDA7OmYkwQeNQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 09:46:31 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 09:46:31 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: John Ogness <john.ogness@linutronix.de>, "esben@geanix.com"
	<esben@geanix.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>, "fj6611ie@aa.jp.fujitsu.com"
	<fj6611ie@aa.jp.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial
	<linux-serial@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Topic: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Index: AdxNWDvvSHwf8ruwQWK/6o5sXxny8wADMeQAAAJkdwA=
Date: Tue, 4 Nov 2025 09:46:30 +0000
Message-ID:
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
In-Reply-To: <87tszamcaz.fsf@jogness.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DB8PR04MB7065:EE_
x-ms-office365-filtering-correlation-id: 0d29ef56-e285-4c59-271f-08de1b870876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2I4BFSxB+wvefF7Nn+gSdxdVO0DZBAuyTA7CiNVuU7DZNVp7/yV0XZ0q7J5z?=
 =?us-ascii?Q?sO4LIiI6jCc84tABzIiXj1rUK2MnDCWC0ywoGj2jea1Y212bx41yWmzJlkdx?=
 =?us-ascii?Q?e/p2UHrg61L8Jn/Qn7W7qB7hy7YCEZeDU6K8KZlZK5EhZxJu2y0I2wXztyMI?=
 =?us-ascii?Q?YmwPy5XjvTTF95/8LwgfVZu1yCo7P0LxIMusuUimZDX8VsHrxrFikskNitFL?=
 =?us-ascii?Q?Jxvo5Es8P3/6hqjqph9xt3W1Ux7dOhKKTWoY4r/rBUOmsz9mOsdEDvN0fENV?=
 =?us-ascii?Q?57o1wnw4Vt9XGrbIhY6IQdVA4z8ZaKFFQLHUCSuIl/7mTkYAqF+LchGDwQra?=
 =?us-ascii?Q?Gg4WuBK1juG0xD+noFLia5By1HVZBVzek3bnx93U2WL7gHYxvwIUWz/6y+rq?=
 =?us-ascii?Q?gw6jM6MzhRziqjBAZeWRMDvSb+7D/zNvJFMUY1Cp9xsSjjJlcAb8u3N/Aw8n?=
 =?us-ascii?Q?KVuffoSOwbVHjkzRdD+mtFd1MlK7N4LFWaigGvb8m22T1iISJSaMKeoy3GSA?=
 =?us-ascii?Q?MK4Jtn/QrR49/yOGXtn2crAo0JYdeLlWhhzLnn2Di8cMjH1rnOanDgOaymlN?=
 =?us-ascii?Q?ADi9JGGfXnC9wHCAe1z7tDlE1AodaDSIEVadBk8BtVudYMGsTh81Az06CGxO?=
 =?us-ascii?Q?frG/ojIgIPYAD+OwozH0goVxA+Fjv7VmJzQRirCnJbA9V+Te20WELcuPCIiO?=
 =?us-ascii?Q?KK/xV5yq56S5an/AfjBXH29IBafDOhhFO+uR6fhd/3VvhmzDMknEENIgoGBT?=
 =?us-ascii?Q?2zA9HWb3taaniC2DhGkvWfDSVL92u8Xk1ttu4oOuswBVaU9imgOmEy8q5b1O?=
 =?us-ascii?Q?VGPSWTfE4rJ/YGrLFM8Uj7CKgeABSbb52oTthicga9c+8e/Ao68QeL+NvuBz?=
 =?us-ascii?Q?3c9Ih1/Ylkntj8fEMNh44mEUJbEQiQa4CTzNrxN7x67lLMSlhBp/USc7Zjs4?=
 =?us-ascii?Q?Hm7UqJaptnUhEFBCfP+XypP55UR8JrCFMAbxbjJUzaqOuub8+aKeNI5oFy+P?=
 =?us-ascii?Q?d9jT7CafJRwhSa0lu8k9zU6ujVKAehQ/U47ekpX2Yzs3gQl7fv/oXo8oQJKx?=
 =?us-ascii?Q?Mr7sgc6iuUhjjf4amr02XUu57jXVKJYzI6Fmn7yIFiJ8U6R8dAaBwFt0JVdq?=
 =?us-ascii?Q?S37iqTST+KuFLA9in+WeEVU0ih8Fcc9541NuIlgnDyhHOlCeUmXjAE2x+GWR?=
 =?us-ascii?Q?H6UqntEyU6Qs8q8MnH27PU5vpyWZNZaNl9yQvYNrl6vvC488rtbHL7nL9PUJ?=
 =?us-ascii?Q?XvIKwu1jA/8aeYBBozWncmBtM49fmZfK2moK65IarPtK/5X0DaPcMwI0NnnI?=
 =?us-ascii?Q?eIEXlyDfIj8Jsz0czxkF8ggEqqy5IPWEC29owib0g6HAquHQB6oL2BE1ozud?=
 =?us-ascii?Q?QeX6T4DmQn4yw3ljHtUvDNonQCoxU/aS0bhkrYh76hCSQ8Y/nqyWrPeHi2TB?=
 =?us-ascii?Q?zzhfgHM9RG+AyMTLoFiBptnaqVarpWGLVd+HKoAAqk9WGC3HuYY6sQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mm8FNswYVi57FqldSIGAqDeeLUBiY8KxEFvnkG9qAlfUq8XJcCpGrpf0CiOn?=
 =?us-ascii?Q?N3rCHuKJbKyppVuEOyDqAelk1L+jH0jMrsO+T5GeislhoZ2wGziN16gDvKRj?=
 =?us-ascii?Q?faD82fbxozE/8HgEHIBorMAiikgWYQK2rCnmr1vVIHmSDXFpDY/mJHNrYCT3?=
 =?us-ascii?Q?Cdehv2kal16HYkeejlX/t9THA9ToYzqkneZicQVbC3zP9ddteHxISfb7uEpj?=
 =?us-ascii?Q?I5fZhv2P67zun/Y26VSZUA+jvITmGxt2lscwRWBpHfcUo7oYVjMUrCjWwenf?=
 =?us-ascii?Q?TicHzj62yIMHdOWBscy9lzS8FgARQEItcUOgBafeJMUbSuqRjL2vPdXFkrOo?=
 =?us-ascii?Q?m7bwEU9py7Wp2mwJs8U+MeBpvoosCA/w5AGcCSMXn3Qpf00IEBPtlOYyPVHa?=
 =?us-ascii?Q?7r65IG3ylYaGFpPehObQePYn4gBHvRDLkABP1tQ2HxUODla9kg6C2D9w+hqk?=
 =?us-ascii?Q?Uy/6j4/sb9ZvBpaEYMWRzwgKsAn6Uf/kw6nnhxt4AD6Reut5d1YPbA/DC7Yw?=
 =?us-ascii?Q?pNe/irJEcUvbLkFOhi7bCj8ze0YMBEe3vtj6EVmlVPxxNo6wCKEtyOu68W5B?=
 =?us-ascii?Q?xLdefhS38D6lRhlgtSJK0PRYT0221eCLGUM3mVHm5zDBnrKgY5nzxD/uTX4H?=
 =?us-ascii?Q?5X99RTnjg0h+UyRaB81m6EGqwhfrjHfumZocb1ngj4HZsoIOnXl1916JMYC9?=
 =?us-ascii?Q?yGkqGYovuWgmUi3oHA67RMVaUiPa/VqbQcjIwfO/cmJwevZDnjifi2GHS3lh?=
 =?us-ascii?Q?NRFKnoPmZsS8ica6bKolXwJkoa2G5c8WNvjiTtjRT1yHm9kIHh5wZ0lSgWXJ?=
 =?us-ascii?Q?Qt9r/dWLxC6spZ+0y/QEmxr/m/5i7GoS4TsD5yzYyXqFgyps1F/wH2pkKw7y?=
 =?us-ascii?Q?O7YDlH6feu9TSxSLVMZN8mtnN4ScUBsINR7oNW+CFGgWLNnuKAS2KmYkaElO?=
 =?us-ascii?Q?p95soBizN9P45GDPnY+oPch8pJ/zDZBR/047KZ0soM5JJ2X8zX9vqw1WINo3?=
 =?us-ascii?Q?JrAJeb5lE1X3PnPNxsAZSwGnOC3lGX+uyOnEnTD2bjyGwfsE0t4CiLe+Vug8?=
 =?us-ascii?Q?9sa9DSAUhpgPpvOUvuNx3bqAJEtDBgzWFKFSjzAkP8c4DO0HKgMlSRYWVcoN?=
 =?us-ascii?Q?MsGovtTb+a5oUq51f5tIuOhZ7QiKO95oTl/wJF+nyRGqXGJnByTZhf1jCg1Z?=
 =?us-ascii?Q?PwC/kDYmV6xufZ052FCywVmteK8Zt8Eo8oebtjKEQpM0v7hNlGVAljcW6Loi?=
 =?us-ascii?Q?u8j4/JjjWvjM9qoPHhJ4zMH7vtDFLK/mnbkb50TveazLzP9j8mg2YYIqaUC3?=
 =?us-ascii?Q?k1Q1IiFJcFz1ojsHPfwu3QB7gwC9P+zZcD28h8AqLAsLaIGe7Yf4avBzuafn?=
 =?us-ascii?Q?asJmOT+6e5+a8lFRNxlqYh12YcgG4RpWAnMEU6yPW3U395IfF7I4av7DxFf5?=
 =?us-ascii?Q?6Fby5yh7ULKSo49IypQkB1jqMo/Imk2mAw9rbDX1VriiydOENLeS/em+0pc8?=
 =?us-ascii?Q?/WRQLrZ5PaXjsNt5KfLa2pk7/Ixxvg4/JrVXkPd/LNbLBkeq7yzQs6bvlJIj?=
 =?us-ascii?Q?DAtL2qRuC4oAH4+XAyo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29ef56-e285-4c59-271f-08de1b870876
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:46:30.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iD+ohXRXrXLNeTzYlkp6NzSweTWf065Aj128pdkY8iLh2ucw+9pqjKztPQCKyw6lm0bIPKQHC/CwgtVqkOxirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065



> -----Original Message-----
> From: John Ogness <john.ogness@linutronix.de>
> Sent: Tuesday, November 4, 2025 4:29 PM
> To: Sherry Sun <sherry.sun@nxp.com>; esben@geanix.com;
> pmladek@suse.com; senozhatsky@chromium.org; tglx@linutronix.de; Greg
> KH <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; Shawn
> Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> ryotkkr98@gmail.com; kkartik@nvidia.com; fj6611ie@aa.jp.fujitsu.com
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-seria=
l
> <linux-serial@vger.kernel.org>; imx@lists.linux.dev; Pengutronix Kernel T=
eam
> <kernel@pengutronix.de>; linux-pm@vger.kernel.org
> Subject: Re: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
> 6.18-rc4)
>
> Hi Sherry,
>
> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> > Since the latest i.MX UART switch to nbcon console with commit
> > 70acca67bdd3 ("serial: imx: Switch to nbcon console"), I'm
> > encountering a suspend issue on an i.MX8MP EVK board while testing
> > with Linux 6.18-rc4.
> >
> > The system fails to suspend when both nbcon is enabled and
> > `pm_debug_messages` is turned on. When `pm_debug_messages` is
> > disabled, suspend works normally. Additionally, if I revert the patch
> > that adds nbcon support for the i.MX UART, suspend also works fine
> > even with `pm_debug_messages` enabled.
>
> Thanks for reporting! I believe this is the same issue reported by NVIDIA=
 [0]
> when we tried to switch the 8250 UART driver to nbcon.
>
> We have been working with NVIDIA recently to address the issue. There is =
a
> patch [1] we are currently testing that looks good so far. It is based on=
 6.17
> but should work fine for 6.18-rc4 as well. Can you give it a spin?
>

Hi John,

Thanks a lot for your quick reply, I just tried the patch [1] on my i.MX8MP=
 EVK with L6.18-rc4, it does fix the suspend issue.
Now i.MX UART nbcon can enter suspend with `pm_debug_messages` is turned on=
.
May I know what is the upstream plan for the patch [1]?

Best Regards
Sherry

> [0]
> https://lore.ke/
> rnel.org%2Flkml%2F80b020fc-c18a-4da4-b222-
> 16da1cab2f4c%40nvidia.com&data=3D05%7C02%7Csherry.sun%40nxp.com%7C
> 223190eafeb045a646fb08de1b7c2741%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638978417234027264%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DPuIijva%2FcH8LBrPhAS
> PopGShQDJdoEBreIc8qGhR63E%3D&reserved=3D0
>
> [1]
> https://github/.
> com%2FLinutronix%2Flinux%2Fcommit%2Fae173249d9028ef159fba040bdab
> 260d80dda43f&data=3D05%7C02%7Csherry.sun%40nxp.com%7C223190eafeb0
> 45a646fb08de1b7c2741%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638978417234052653%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
> oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Doyqo8zAnUA%2FuAc5RuTtOCVRJMZc
> k3IexrBNvI5NpjzQ%3D&reserved=3D0

