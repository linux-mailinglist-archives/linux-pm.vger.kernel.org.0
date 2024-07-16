Return-Path: <linux-pm+bounces-11137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99FD932304
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8BA1C20BFE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6AE197512;
	Tue, 16 Jul 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VQS6g1my"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2097.outbound.protection.outlook.com [40.92.52.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39529CF7;
	Tue, 16 Jul 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122888; cv=fail; b=C1G4zpx8fCd3Jy+6NY7BJtLz0lmh52ztih0s4feM8QSDL+Dcg1hG+ApNF5927pbCzF/uqE9WWMDigs9wrZm6E5AUgaozrl/o+KMdyhUcqW0/KHaU0FIxIyNApJP5xXROt0fcNl70hAQuF6iPZBeYpkpJc9dA/scawtNhvXRMqQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122888; c=relaxed/simple;
	bh=R5FCEvGcxjhl5Z2lSXbrnb92dKjdorj5PLGXMh6LC5s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EFjXcrzqV11AEqurLAVefY2rEkW836yz0g9MfbBmvt7IKzwO3t74lAlkDxEfYhlim1S0CJVUU9yxdv7pp3ajvpEK015MpU/NchUnaqJdr5jyLtLv4P/VPt9XkiT+xYiVLDqBBUrJLhJsrwKJEfapACYzG1aMdsA4fsk7tooiPrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VQS6g1my; arc=fail smtp.client-ip=40.92.52.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQcvtrJlMCyazTzJOE0/iM4vrYCC+t3gu1UXV5gVJkSEEdNjjzozU4lm8MdlAz0k70qORgv+V8bE3NTlrloHAIsOcz5eayxi1VXADXi23oh0sSY/6nItw5H+cA2BY6Rj0eWVhFvrekujB+NmQvR/RNbxOG2gsJRXI9aMop8QOm4uKj05efd/ErckMGAThnlzqJXoj+Dg3w0U2Br0r/O8RUUD5Bb+X8ZY3A0DpgAzT5OJO42kt/FSkgSWfV6CmS7w6AWJxci383+H+kYwXs6J1FeRVpeK0Ae2e3p6WOa5RUp5+kcEmuzISTD5yoLXalkDo13+1vFr0v6QWc8TZqxdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJGKZmCuOwjzP0/WiwmegjL56TxpXPptVO23hycSm58=;
 b=K0sIRmVr4Tg6lH6CbWmcXTxH7KlQoGszxtiNvUm8jiQ3ryByDcML/xSnMw04K61kOxqkLcv9arC0uFOBclC8v7UyU6YYFNV20ItKQqMAofz1VOM/hIjI/oj9qKS4JOlywfofSCztkzU8zQb2QkbW1lULHvUq0qXAC/gVT+wEa2nspntQYihrYqLfqDyJFtJqafZSKvR5lb+s4mxECTqetw+OcWHhBaTT9z7d+HfOewIFADAChfIQ0+iZN1StfoNYYHrY3hwN/XYuXwd+9pX2ErjHv3czg4/ErxQCxAqWUTaF9LO4gBS0E4QNAuHYlJNi99ehpzT7Djy4h17EGV4xdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJGKZmCuOwjzP0/WiwmegjL56TxpXPptVO23hycSm58=;
 b=VQS6g1mySe/GkrIpTitp7yvlcqHUSIy6FXaBEbRAWAdAcP9IF3QzPqF7Cvjj03b9Glr7CQu0Ked+vmLU4QEsGDX8V6cPqin8FveKTVM7c7cn3On9if/jGQGIlRXUBrCC0JROyb9FtCiUqFD/eZdxX9iOxdQAp3LzKc0Q+u8wXQLYHVajp5kUTfO0Hvq88qwvzpded+07GvaAjmzilAdwJ7eUI2eieKsGXtxgND0V/aJx+UeLADLVxy7s27cqnIsqxpOx3fubB5EtMYfbzRZ7b7h9reFIg73ghc/fNGYGjbhoP9wQfLSedLUItmFu6AgTWlQSaISbpINU875DeYsaog==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4895.apcprd01.prod.exchangelabs.com
 (2603:1096:400:281::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:41:21 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:41:21 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v4 0/3] riscv: sophgo: add thermal sensor support for cv180x/sg200x SoCs
Date: Tue, 16 Jul 2024 09:40:42 +0000
Message-ID:
 <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jOHthX33/v6T21reLR5ok0uxq7Rgoh43]
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240716094041.51406-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: baa07176-d49c-4bcd-0ae2-08dca57b72fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	Sn0q3dWCEbOEjf2Am1/m7eN/GADvG9Pp4sk1hgi/7m45sr09njMO0t/uvd2o1NXC+vwQo77DJ/VkJGDqjQM4PLZUJYHnd01CyWibE01S2Zl+hJNLFLjmr+nIitS1/qUX/qczG4pyTTb6JmVeVZJ/Nq3Xvy4TgZKefoy53if99oaPOgaqJiVluQCtoZk3butE0hlycnywwfm7ayhmh72cUedZV6iNxmLUyzhMP7ZapWrNIZsTBhOnEfZjrndo3MG6cpSFl4bYto4GmKjOu1oWz71BZD/gobQDNwxugKDsIqNZkinWkH/oT85tFgqCDaabWXiVkf2AsYUXKV8V1mWetuF/feu4IjAQ/buoc1XmPSu4EACkH9/jQQxeMLSczjz7pgloenaJHBD/JJQ7hPnWb6mmL7GqOLTRgwW82NiZtdjuq/nJvRhp8RMf/K2WqKdR2Gr5OBW9ujRthb5PXnjXwl7wPPCzBF9KmBlbp/gWMn8U13wLdZ/5y+Bu6l5hckjpqvBBsn5OGArVMYvZW/ZkWaPOxjXvwol7WxBm2IfkeYlXEqeZggufkh+aW5eRBZB/hRjyam9bZSDyW7oSpJQj8UARWWjeRi1Vb+QfiwK2zLvkLnEhDTjJYd8gS7umZ13S8Qlnwa6Z2QJMGFO1OVrzpMJewW7qViALseAJe6fG6Es=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/7SCdj8FGfSrFyv2B4BdhR3f0V4aX9T6faDEyUzd+PwC0rFz7vqDgGGZ4Ph?=
 =?us-ascii?Q?c0bspZAbXxd6QB05riM2gNv7pv2Wh+EqqjF87bI3jnaSeshXK8cf5JZbcd8d?=
 =?us-ascii?Q?B/CJxwFiZeeXBQqj1/sGK6BBHwEaltJJHLLWqUnYk+9UO8loIXK4ksTUybiX?=
 =?us-ascii?Q?e1H5J0YKpXXO/eRXhHc1kasooD9pHAfa6/fd2hat2unNa9JgS5l1cJmaAQCd?=
 =?us-ascii?Q?pVACqVbinaWfAee+al8BWH5Lp3mhUKx+HF8uUBSQV3s5oponp8jI6n1Dxsg2?=
 =?us-ascii?Q?LHNPlSVZB1GDpEOy8yxXHMEdJhGF2FytFnH4y8YIR7imkORz6U2T6AEG9qVs?=
 =?us-ascii?Q?ZJJp0sUHcbEV+NTQ8f/bSxZ+zgtZLdC8EFQqxvRv8qis5WVNgq3KTgMV+Ba5?=
 =?us-ascii?Q?iPikG77NoVOieE+WrQTgpysNABN75AwdsOtGWtbbuEYpyegkGoFG6An3iO1G?=
 =?us-ascii?Q?9rj88zyC9NnN5JWKXuWdeHtZ/HOfoJBmyVEIJm8XVow713GxKoCtCH8ZpzV8?=
 =?us-ascii?Q?BZbcRorNYQ4/AvHnOV2B8H6Lzr0ISk/i/hn3qZ8O0C+CFMkg2Mypjl1BDTwS?=
 =?us-ascii?Q?tDC6R9XDSqgOKATcYpoWo5yAhyAuUzIRZHncaMfMG/PDGb3tggqN4z0HySXM?=
 =?us-ascii?Q?B7HzyE0hkHxWaN1c0emm0DQJCrnLymcvJi9BJVzHh3E1nn/lq1304BybakQ0?=
 =?us-ascii?Q?F1oIpw/F/IwzAu9qQ3mQa84qouvbrfLDGD695XogEdyx5bTvc/9/SQtS873Q?=
 =?us-ascii?Q?cY9RMXxSWJOh+i5/e1W0/7tkwZjtqFeSpPsr5sSz7ogKmmxSiar1wBcGtCNh?=
 =?us-ascii?Q?nk07WHLi0cCZmx0E+1W+qaWfT9z1ges6CrEQYvcieDzZZuoza1iW/1G4Fb8W?=
 =?us-ascii?Q?fa8YByx7Ke8rzHIfbR4qtPQLNv5J00ioto5fZbDT+igC+3em7FZPf1VdYTzD?=
 =?us-ascii?Q?5clo0sQFODhqrrnHEDmz9KT30QtaeZwNxQHNDZ70i3LSL8z56fCJ1DumGRiQ?=
 =?us-ascii?Q?nagn68RikEZ6CSeCxFWVmqa5RhYXMRgWw3AoumacyI3VF7+lIt4HgyQvGXAO?=
 =?us-ascii?Q?QOH5AVuUN6n+rQf/ahYViWyr8v/dGfrXDa7DHIU7Iho8ymaRrxnizmJmthQI?=
 =?us-ascii?Q?ms4noVurcS29Wn9WReXkHD+m0jpe2ZNnznVaXyuSJ4ObXy7iPvYmk+sXpIZf?=
 =?us-ascii?Q?LtlZ/7u+4kU5fuCyzc0fMC9YUfIpLZHqk3o7sBJc2Ru39H7OsZwLEIuFxaA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa07176-d49c-4bcd-0ae2-08dca57b72fa
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:41:21.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4895

This series implements driver for Sophgo cv180x/sg200x on-chip thermal
sensor and adds thermal zones for CV1800B SoCs.

Changed from v3:
1. style improvments
2. drop unnecessary dt parameters for simplicity

Changed from v2:
1. style and code improvements
2. use human-readable value for sensor parameters

Changed from v1:
1. style and code improvements
2. make sample parameters configurable
3. generalize document temperature calculating formula

Haylen Chu (3):
  dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
  riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
  thermal: cv180x: Add cv180x thermal driver support

 .../thermal/sophgo,cv1800-thermal.yaml        |  55 ++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  30 +++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   8 +
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/cv180x_thermal.c              | 241 ++++++++++++++++++
 6 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
 create mode 100644 drivers/thermal/cv180x_thermal.c

-- 
2.45.2


