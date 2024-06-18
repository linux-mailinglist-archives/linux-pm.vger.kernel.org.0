Return-Path: <linux-pm+bounces-9413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D912590C6B7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D4828233A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463B19E82E;
	Tue, 18 Jun 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pXDgWWGX"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2096.outbound.protection.outlook.com [40.92.107.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639F19E7D8;
	Tue, 18 Jun 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697419; cv=fail; b=ctE3rRhjA2L8SaBPFpEVtRW0jEJgXQ+dm3qzU5qFy2Sxw8iuGMGv69Moj8J/B4MS7lwo5y5ZMJI67PU7X6QbqvvfEk6rpbRUdD6scAjjz8AvoeTptCKXCqok4Aiz9vRKQCGg8bH2UQIV4v1qOdtQCV3c/QTOvDhwu1TwM00/7Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697419; c=relaxed/simple;
	bh=sLKNYJMEIwFBgLtle/yzFaFpdLDZdTHh8NjIVY0DA18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IAXKp0zP3jwzH+vafFl8z3hVjLQYSz95+8npIFZc7OiTrmlbyy8nY6ECj6IDNI/nwJF0PmZeGI9u/4IuMBiXXr3NyZyK2xyEh2RQRJ+82YR76wTDbs0oc883KrdLfnLCPT+Z/mon6E+lJobbNuR5QGUr0osL/S5mGfCZmMfzVk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pXDgWWGX; arc=fail smtp.client-ip=40.92.107.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahcdyYxo4PMVCP3XNu1c9o+fzOg6lPZgtx8BXtr4Y4WjczP4KMiyYjYV8AkuG00S6xxO+LqOozDUnzka/Zu5TLBGJZqW1n9ny35zyWzSI3Uuy7SugXeCqwDpN+gq5uIRi+ZQIpHA18G08tUqq2feUYpBQOZeGefSDiLf3d1UvrJ4/FkWWYLMuKNTt0PR/k3vgRphPIvg4KYMukWIXOVxuDiqXLDGnch/6zTtBhNkLLkAQxPU763kOlLbzn58h/Y4VVU8KOB4gIO7Xu/s5NtXn6d6Mbt1KfftCtV0D1pQMzYoHTEfLrZ59VX6ngP/U7i6DrC0MD01+612v0ZIClKnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwfPlO/5RrSfM7eMyDj1n12oEj1ui5VmVU5X++uh9MU=;
 b=JLkYR0jdLJR/ejPMy0x8jmlNhC3mptSS7q9v/5APKE0hwCwP2HEN6HVyhRBfBypqvyZsqNGcGo0cPMtCwPBhGnzcgurJqbNCOfxc9u7GH7WIA/aE2XBMcG8uLOCTpmt6VgFTR2RxSTZiMHthqHVK0zY/4rgtb67QmBeHukKLy4J1moq5Teva+LTmKrn8UOsHKS0fYaGK34d4CT3dC8hl2YFNuLwkYJ68ZX2BVlYgA8177kK+naQCOngOiqLwpogSxTAzkJDRCq7Sk3sTtrmVuJH9i6f4muVZIdzhk1OJrJ1MJXkQXEaw4yozUXPv1FRX2DoD2WEiJO137r/ds3IIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwfPlO/5RrSfM7eMyDj1n12oEj1ui5VmVU5X++uh9MU=;
 b=pXDgWWGXc5Sti9T1yrHdKV29+FRYjHZ1A5pqi7h/aucIjsmXJqmmtLyQg17SiMQMJt6uyR4gM7DlAk/TKuCOsI9qNgkdgleI9lLHdDrpgitL0ShK/H82osjXpqtvrUWeVO0FfeYrUg7woTZ+fKmo57nOaRF4EApiOdLt5QUyO9C0eY+ucvbyyLNw/hRVjoGOomAMPXFaeCWF3z1YjgQR4m9T9gr9l0WuEKYKiM29drvkZdyZGnzszz587p89ekd1fkh4vbUwVq2zJtIO7G6VCv4ne0e6U8h5T33HB8yrFqAFbxlW6l95p0stjehTKvqGpAnwWSNh7L+XsdRDybzKPg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYSPR01MB5963.apcprd01.prod.exchangelabs.com
 (2603:1096:400:46f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:56:52 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:56:52 +0000
Date: Tue, 18 Jun 2024 07:56:43 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal
Message-ID:
 <SEYPR01MB4221A739D0645EF0255336EBD7CE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42189977B4172405F5704CC4D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49531F55C8D7DC5D0050CAF9BBF92@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240605-tightwad-janitor-82cfceb1469d@spud>
 <SEYPR01MB4221F0E46F600E013974F21BD7FA2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <20240606-reaction-thirsting-8c22d1b5ab72@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-reaction-thirsting-8c22d1b5ab72@spud>
X-TMN: [gdQ1kSMIlPm8UBCT49aEkLCr7+eUGyRb]
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZnE9u9we3i9rTkZl@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYSPR01MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab71bdc-a61b-407d-8827-08dc8f6c3706
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|440099025|3412199022;
X-Microsoft-Antispam-Message-Info:
	5+hCHJ3lJhbQiRpIKNkL3KjvU7upZDz+PlFnAcXg2FdctlYvgaWDUHNzv8TE4k+xo5Uwvy9iNLf4XOUtkdBNP2uKbVHZPLh/zQUhm22+0thp0QJaUWZicMYeEzGmbWXg20ofqKKsUlXDYoB2hgGNgtQPDFaTpszq2iyCEjIoUsIg95H67dZR8RK6lHS+B+nJ3W6f0yu7+OAD4OY0sSOf+yUiChx7c9DUvi69XCLKZMtBTyY49tObnFyTt1mejcgUyM881dW1p9YLU+1qiKM+NOiyk/2YIjeYwiwrv4wQGwj0xulxfmF1CslwjxJqFLFTIjoDZI1eYQpIyqkEmB1WDyN7Xmgq+NlFhK0Pb5nO8YNOawjXqZhRt5ya0oGdUdYIcNRjQq97G9zgY1z73fdPiyTtgGvHO5lcYjjxLyXy4xyZ45V2jJPSouZm1CTyrQwhXgbFBObvd/YJv6hui8KwwZHO8BLTuWpG0sbnQjYW9lSccjCW7gaMEH9a1gT0YUH18vFVQHuIyUDA4bH8IGZnZVsoZ4jutI4ZHec/GffWI62W83dObN7Kdp5SqixsJR6j
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/AZqUNs/k+h+wXjkftpffgM/+UsZjjlF3KC/Rnm83Y6NFCDYyr0TQKhum5TD?=
 =?us-ascii?Q?FqrQsu3riM9mXW4nPaKB3Je2fBYXTVlh/zlS85HAtlRgtAni/tNIt9HbOiIO?=
 =?us-ascii?Q?vIxlJcbbN71iQO2x2v1XAY0nQ5VsXxDcKL3wTNprxrhwmEFyPoFhldmG5Iqm?=
 =?us-ascii?Q?Uqndgv8YC2mkeWDzEjO5zrNZI2mqYEDIiCVeg3s+RRe3glqh6wm0IuavEBXe?=
 =?us-ascii?Q?LzE9OvgRXRQx+shDbS085FLpj80tAhc1e6nd8kcT0YI009l40IJREVCfoSMJ?=
 =?us-ascii?Q?pIkkCQUczxhzDT+7f88YqNY9TIFXS6LEoSB8szBYSMCHig2ZfeUwdcavpIxJ?=
 =?us-ascii?Q?c6U33TFHLMWhN7BpsyPIaxn4w8M5eGf6eMG1h3JfUu35H2xjENsV8qUWLT4L?=
 =?us-ascii?Q?FRRoOuQRLg0wxTSb7yE/96ALWXfCFXpvtNbKbcD9vyb3Crpovv+L5LdkkO7c?=
 =?us-ascii?Q?H0qqWWSKx7TNnBS0W/lsNWXZ7eviA6/tqqDfrRQ6UxW6cYXvTx8lsOz/DDRH?=
 =?us-ascii?Q?yiEMCAQna6Xt4zH8GPKO8M+ShCyofgr25XCGpzvxF6nPV6ITNsY/NXo+gbtc?=
 =?us-ascii?Q?/tZ9+uBiHoHwxf1C5H6H995JGwYoScLEh8r1sPOPvUoUswutokCK2iQg+qLc?=
 =?us-ascii?Q?n8o2Ue01KQp5Dnsw44u6h5qByIRDIyo00HBD4YacwXdGZ3zopYFvcrnC3Y8+?=
 =?us-ascii?Q?mkQviPkqYm2BiiBVg35H3cOFBJ+dchXpcIH/dvAhHLxwzWG7glMQyvWxWYLj?=
 =?us-ascii?Q?ixcbB1AJoS9663IPyYLdrdmH0pJyCqY1BhVRLIKgpDVas9fJTGrZjhAdcBZ6?=
 =?us-ascii?Q?ofNTKD8X4bVzDoWlN8EMjkTqyAGRMJG46syPcYZI+zTvB7Ba9GZcVzAJUo1A?=
 =?us-ascii?Q?Ru8bLzHfNRabjcYH8HQJCXnURtdoKYZicODnKzachP7oZph3jlElrg2ewk9r?=
 =?us-ascii?Q?/NfJPltUiMyLN+4s8cT7GQ6G31br8idgjpSb1NWkMXugjV4kw/wj8JKDn57r?=
 =?us-ascii?Q?KDJJkHf/XEURK3RqU6lPM6dQoTlI7Oc3LhW6WtF8uBkGvRKVrdhOglb788L4?=
 =?us-ascii?Q?5749uVLLio+cxLTfQ7cHAxXE4Fwc4GfbFUK8nQznC0eczYVp4/dJSvWoPAeV?=
 =?us-ascii?Q?KbMntzZRjubIOUVG6Yds1BpUlpKEFoNXOQf1s9bskwUMmVSuyX6Sa2nYadis?=
 =?us-ascii?Q?S8l0tQ5UcbyhLqmqAQOqDnL90P3BG5MW8zZKMl8imjN5CxaFa604S3WnO40?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab71bdc-a61b-407d-8827-08dc8f6c3706
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:56:52.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5963

On Thu, Jun 06, 2024 at 06:05:30PM +0100, Conor Dooley wrote:
> On Thu, Jun 06, 2024 at 01:32:46PM +0000, Haylen Chu wrote:
> > Both accumulation-period and chop-period specify how the sensor
> > measures temperature. Making these parameters up to end users brings
> > extra unnecessary code complexity. Being configurable for each board
> > should be enough and other thermal drivers have been doing things in
> > this way.
> 
> Other systems may well have properties for this, but something being
> done in the past doesn't mean it might be the right thing to do now.
> I don't really buy that this is something you set to a fixed value per
> board, but rather the use case of a particular board would factor into
> whether or not you would want to use a shorter or longer accumulation
> period.

Accumulation period and chop period do only affect the accuracy of its
result, in a range about 1 Celsius degree. Changing these parameters
does not mean much to end users, as this is only a thermal sensor and
1 Celsius is quite good for its usage. And users could always switch to
another configuration with a dt-overlay.

> > I do not catch your idea. These values directly map to raw register
> > configuration, which simplify the implementation a lot.
> 
> It should be trivial to convert them to register values in your driver.

Okay, I will do this.

> > > > > +    default: 3
> > > > > +
> > > > > +  sample-cycle-us:
> > > > > +    description: Period between samples
> > > > > +    default: 1000000
> > > No constraints?
> > 
> > Sample cycle is more flexible because of hardware designing.
> 
> It quite likely has constraints, flexible or not. Is the hardware
> capable of both 1 us and uint32_max us?

It should be a value between 524 and 2^24 - 1. Will document this in
next revision.

> Thanks,
> Conor.

Best regards,
Haylen Chu

