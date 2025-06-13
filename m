Return-Path: <linux-pm+bounces-28636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4CAD85CB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0853C3AFCCA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E092DA75C;
	Fri, 13 Jun 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A4020A2z"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D432DA751;
	Fri, 13 Jun 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804058; cv=fail; b=hw/tSvFYwVs3ZPYh7IgI0RGVfvwKnHIcNzCTYVPUBAWqRgw5yZ1Qlcj+HuBIVb7wTz/cY8/Xu0KU22N7fTiqJERY3I9B4V/NQ51QmVIxQcm/V3LbSuELRv5Rj0894lCR3rCdUKXPMoNxEvimjo/QV5tzZ54UKn7FmEjCmUUKY1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804058; c=relaxed/simple;
	bh=RRLj5HJPRNvuBdIZoz4qn8T/ET1x5W+HmK6BzQXgwZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phyEQey20r80whb58Y3/WrEOiadvHbxgc2/Fye53VUUzoQWT/xvNxuZFUAFPR8xiPqtNVqQ+tbyPknTOSOZ6j7x4dvHc1Jqh/pPV0DHyG5QH7aviTWxIioWLI7lb23vIRh1fN6TEx0wJdnOrfn8dTd2c6NVUL2lfKMkTxOO6z0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=A4020A2z; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idI/t7QSvI77rJ20b1sOePhmb6rOu+MyiAuwdbx/RrKd/1EsTwGD0Tw/VIwOv4app62a8xScSrt9pVC7eMSNohu3+UvmVWSD48MncWSYvTnKwilcYLC1aQX3uATzowExY19OKlVJ5Ya8tje9zfxVwldqQmB5eJiElencge9OCVIY9XlHzk+2EHeH1wj5VlKZM/TTMAkStALh9kXZWuALyYPqVwRjoEdEVNyohdPHFFnwjZExMIxIeJQFA/cheSGcdjB1pe79Ry90iJFfkwXOxB32CXdsnO0JZE/frOaKbgiZGOeCLD4iytVlca8EUgwJhlN/HJagx7mZ387uqYc3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDdCdqCYCkOyT79SgoVwKqY2YXBDTaZqB6PRwnJ1lFg=;
 b=TOcxRncLn8iXFuD8zwBKhhxyNSFEM3LmYFoKobpTVTZBlROZ3TdBW1gRUHCz8kSlexRxur0jHB1fy8oYZ6+knpKbC/RFjsqjzXJ5ziRITg+dIOOvycLpwfszbK+pLBUKglLLs/iPXLpvSlCS6rhu/JzuYGAcgFNnoauDUO6k7PT1uYYEOX1ptoHagmB3J+wdguIS5ch+YoKKvS+Q2Y/yti3586/tCHzVgDJ9ut5lKcIlKbmVUFDewhPHD72q/voppGP1jCjw419j/7kUsqePlIWmFnEm4HtHI9RaIaQZGNxDBNHdihsuhdqGqdv5jozjCQ7c0oV5pQgoOegKBfWcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDdCdqCYCkOyT79SgoVwKqY2YXBDTaZqB6PRwnJ1lFg=;
 b=A4020A2zbfrfh2t+mYEydUTLdqmQuSrKAlZ+CoG9YIBQ4J5J8ki5TEPkW8iPkd94lIIwRBWvlkm3eEBseZFqam0SRUKMuwOpixGM95fbXQxwuvzwIM8W3rU1SfsEaDPaWEQktmQHH3/5Y5KyVRbTLApgC6bufY5UZ/GVvjHv0pMg0ErwroQshy2vunsVCLH1dFKXH3y5XWpIPlFICexKLwx4TfSVadjm8iLvsMieXBxQcVP7T4MNunVoez8Ebt6R4WZbGFIP1LIFefeuacVxaBiDTwRRndzCaBU2cnAk4R3homAZBFsjJorYqbjgbdDUxKa+2MWvAYMK2W/nEoii6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 08:40:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 08:40:52 +0000
Date: Fri, 13 Jun 2025 17:50:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable
 notification only if supported by platform
Message-ID: <20250613095059.GA10033@nxa18884-linux>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
 <20250611-cherubic-solemn-toucanet-aac5af@sudeepholla>
 <aEmFnJVG8lXTDNmO@pluto>
 <20250612034351.GA7552@nxa18884-linux>
 <aEqsZWSlq9wKv10a@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqsZWSlq9wKv10a@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: ac83d4bf-39d2-4b3d-6ac0-08ddaa5600f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJDtVvmzpoPsUnrtyk8Qfn70l1acJnd+IWtwhiNdkv1wIeqeYRltyONsdgtZ?=
 =?us-ascii?Q?pQuBOoxF86WYbw8mmYvufnghzdikWRkQTUI+Ub+fHakdMf8AMQIMV2bZcDGK?=
 =?us-ascii?Q?vzbIHxeBY7tdx+6vFfz1L/jAzoMR6OQ2yG+cTfA2axn9i4lxdd1phQMwfKPY?=
 =?us-ascii?Q?sDhd2AWCdG9NTO3GgDuu75bpqRIxDt0huccne0ZC5thPHPlC3m97YLoaOeSs?=
 =?us-ascii?Q?J6P66PPUVV3RBNDmqxpS00C5d3nWUn3G6K8yoQrQVaiN5FnxZ2gRZhfcvU2Y?=
 =?us-ascii?Q?ubN89aVmoTZV6V1qU0jmD3XYzODIaf72UymSzXgvrEJjiNljmCgExpGfScU0?=
 =?us-ascii?Q?0dEbD2zBCkmGoiX+fo5PTesSK/GppXdq68GdALDcml2h9jEg1mIMqB/zAr5L?=
 =?us-ascii?Q?D83VgMX5+zpm/18m4+XhoEnjOljuSUyJskYW30ThMOySNsKP57T928EKX99b?=
 =?us-ascii?Q?ZfZPkvCUzabYCykjJ/TXvRjEMo3Ie44swEKEkeXsPSSS+lCuysDcM5wKmci/?=
 =?us-ascii?Q?lR/OpnGppsQ2tZe8PLlHtt/HKEAIg3eJfmf2ZQR4TBQmH8yMeIwULHJIOAjO?=
 =?us-ascii?Q?EZ517k3lixL4Hh1uqNiQpjS5HSXEU7MB0bcGfWZeMGaiRqFasNIrR5PqO0iZ?=
 =?us-ascii?Q?s8s1JK1ar8tIgVFSmCEK9t5jj2bc/rGw0v/t+ddcC3D5uO9lI5hKOatkf8Uj?=
 =?us-ascii?Q?DPC1IbEqG7rpV5ZbXz6MC85gZ9Ka8pWe8k3taCLVz59WF6EyJWThIkvnTIn+?=
 =?us-ascii?Q?G879PfB3p5lF1mI+ibI3UI+RqkcFwVu/xZlLu+ufs9ge+pZbVy0z/U9iNuI1?=
 =?us-ascii?Q?fHEtTVJJBTBSqfP5VNUK04hF+sAcPyc4DabGnSW9WmcUtAphrDwcnSDTxySW?=
 =?us-ascii?Q?bt5d6aIjexWT/YXmdx71Q+KNEBpsiKKvinn8RXEE0SwBnAhIe4hhHmaPf/tj?=
 =?us-ascii?Q?epDR82XLEJnMDeQmyaYKlItyxuRellNEZqsl4E1VxW1m9A5+gSLSZCkQH8oY?=
 =?us-ascii?Q?OpcR7Bx05MKHCNJmVDPQhM+AVEkhFk6AGlI8NDf4AAzJDZzPzWAIthYNKw7a?=
 =?us-ascii?Q?wkMsXnz63kdpYRF/9SbSTi5ga2626/IEHBt5jm92+8HxcVLN+GcrS/4OHJ2h?=
 =?us-ascii?Q?Mv6ElyeXvkbje0W49HSTie8zi17P5xdzjtIdHLOXIlDHGIxGNkTlh6c2qj1B?=
 =?us-ascii?Q?OpZGvvDGCdcPd5PBuMePP650CplpOzLbM6S6PdCB+TfmyrsJ5M91sLyzrpJA?=
 =?us-ascii?Q?byIlfOIJX/KhTB9BKsYdrN+u/v9Y68dxP23ctmtLLddmCmRVVhRYnL1UCClc?=
 =?us-ascii?Q?eZ3mCI8j5T1TBQGo3OUITZNxX7vBDCpFUE5DFaWr6RfHv425bBDlk9epv3gG?=
 =?us-ascii?Q?VUXmYa11lNoIUUqC14I9QiTaXlMpGj0M3VBhd36QOIgojaU3q4uM2mD2gBof?=
 =?us-ascii?Q?/DvJxhefWyOp+iQcOQv/zO+RpVkTHSearykBPdQBylbNMR7Gvw7krUdnnifm?=
 =?us-ascii?Q?UUL6txDpMtD3BQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8phz0OCVKtJiSoJUPGYE4WD+ZfQMqO28XbT806GXMRttH+YYeE4b8Zhed7v0?=
 =?us-ascii?Q?w9qgqIfgK6LIbIod1k5vQmxugKIfpFI25mn1jzR13IWJBDSwjkj/HzRBTrV9?=
 =?us-ascii?Q?VqLGvnmeU81J0+cbZFld/k3OW1Wj6AXxhJ0O535SLONkEGClt2d0WCYr0U+3?=
 =?us-ascii?Q?qhClYXoVde0qpmh9IV/pwLtSrzfOA7IheDmXhF52A40dCT6ka7tcLYNbUL2F?=
 =?us-ascii?Q?qGvDDZd1Xt+QfOLcTgDWjP3lWLTUdOwsBY7fapgNOr0Q4saN+cfEpUBa0dXW?=
 =?us-ascii?Q?Nn3UOOFkI2V7IkhoU1jRskr8DJ7ncl+aBB1TCoU9SN0375ezB2W85K7SERgG?=
 =?us-ascii?Q?uJ9V2typwi4+3+qMp8DJDJY0hI+4oYRS2dTZhC3ziJs2jlDZtRxJWedm69Qk?=
 =?us-ascii?Q?4TIPzPUeGyrcGWo0DSEjHw31yQ0CbtIboN9+AAhfx7zPUUluc1oC4u57dH9N?=
 =?us-ascii?Q?7zZBPQT4pjH4k9LMj5BnA3w2EsthnEICwEIp12gPKaZGXGCjQ8qSP1sM8KRU?=
 =?us-ascii?Q?qsXE+7zwCUlsoSpj3UJGKKBIe/bdQPkr0V9F60nwfXWrqihPIMf3VjP1bCiB?=
 =?us-ascii?Q?6xhzjpZnJWU5vox1jxngknUluK11CeRhyeDoBRVVTsY8Qq/qp9gw+rm5yKTq?=
 =?us-ascii?Q?us+cf320x7Psa+quFgKECq5e0wullhHzH3dgc8bpYlXNgI9Mgk0GAL0dTibW?=
 =?us-ascii?Q?n9Q1nMKSahXz/eTPjSXloAAy1qk/10R4u2SpMW1IVsxtrhnl7sBb+28x1w9D?=
 =?us-ascii?Q?qqhHr9Tkx7JvBzOr9k/++b3N5Zmako0uEDNp0IxnHYXD04+O5dibJyQLJqa9?=
 =?us-ascii?Q?atO5R5qPyO4H3pYhUW2vD/iku/BkLL9RtWzBzX25NVbaSeh00ZXOD6HPr1CA?=
 =?us-ascii?Q?BiPAGHbztv5LG0cvFDG6uYcKbiiYeBudlKoRJJEWMsTbbGphAoSvDm/+GBLm?=
 =?us-ascii?Q?1nzIiqfhXlezofNmkhKgZCuCb/VZYa43gAJIf9QOgVP9J8NtzVrDdE34QnjH?=
 =?us-ascii?Q?vHc1kgOyEFYXqgWuOKYukspCg7i/JvidPAgRRO1Cbnirv8JvyghJhD+ToIJN?=
 =?us-ascii?Q?irorYMbSib5Ih+7+3t9wJT98LSF4FNgseqALM4HmQ6rINaxPkZ78S5DCWzxo?=
 =?us-ascii?Q?GdOsC9HnOOxUj0lmRfp6ExBEy2SvT+FDSKLKN8FPD15QL8JDY5a3WoHxbcED?=
 =?us-ascii?Q?HN2sW5pDPc+JpdNv3jqY7B8ScflJHtSTfLRlp5A2xuc2so96tUtWMFTyZ6bv?=
 =?us-ascii?Q?cfJdDlFQhuyUiUWP8nRWKabUo6gkhP9Eph7fZY7Hk6DczG1E0iUMUV4jr4a6?=
 =?us-ascii?Q?rLM7b8nDdnky6577sMPq64UtZpDYAbRMe81kZfF2UBCgKDb7eYfx54xSeawT?=
 =?us-ascii?Q?74W8d3S9XwDt4bkECrIknFDB3xz/fl6KxBYobeNObHcs5v5EitdVcmOnSvBg?=
 =?us-ascii?Q?W82Gpookd6iYc/KWrSG/fN4zcP+Yeo/FFJ2jWoi+5rM+gdfjX9hOij0W8mc4?=
 =?us-ascii?Q?lXYDrbngTMbv2z8iunggHyRlZPCbnM0Oyyd9LZeK2uqEWlEocA0nG9jYgmdu?=
 =?us-ascii?Q?7AWoddkCY/U3hRzbTfgYz0ItAERvo5n58Duf94Nr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac83d4bf-39d2-4b3d-6ac0-08ddaa5600f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 08:40:51.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODTN+kHjpyF8OAXgHp3ZAPBsHoEbrla4wAp3O7eOJsjzSmX8rOUtHK+G1kj/w61TQU/AHfnM6naxCme58mUOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

Hi Cristian,

On Thu, Jun 12, 2025 at 11:31:01AM +0100, Cristian Marussi wrote:
>On Thu, Jun 12, 2025 at 11:43:52AM +0800, Peng Fan wrote:
>> On Wed, Jun 11, 2025 at 02:33:37PM +0100, Cristian Marussi wrote:
>> >On Wed, Jun 11, 2025 at 01:17:11PM +0100, Sudeep Holla wrote:
>> >> On Wed, Jun 11, 2025 at 03:52:42PM +0800, Peng Fan (OSS) wrote:
>> >> > PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
>> >> > commands. If use these commands on platforms that not support the two,
>> >> > there is error log:
>> >> >   SCMI Notifications - Failed to ENABLE events for key:13000008 !
>> >> >   scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
>> >> > 
>> >> 
>> >
>> >Hi,
>> >
>> >I had a quick look/refresh to this stuff from years ago...
>> >
>> >...wont be so short to explain :P
>> >
>> >In general when you register a notifier_block for some SCMI events,
>> >the assumption was that a driver using proto_X_ops could want to register
>> >NOT only for proto_X events BUT also for other protos...in such a case you
>> >are NOT guaranteed that such other proto_Y was initialized when your
>> >driver probes and tries to register the notifier...indeed it could be
>> >that such proto_Y could be a module that has still to be loaded !
>> >
>> >...in this scenario you can end-up quickly in a hell of probe-dependency
>> >if you write a driver asking for SCMI events that can or cannot be still
>> >readily available when the driver probes...
>> >
>> >....so the decision was to simply place such notifier registration requests
>> >on hold on a pending list...whenever the needed missing protocol is
>> >loaded/inialized the notifier registration is completed...if the proto_Y
>> >never arrives nothing happens...and your driver caller can probe
>> >successfully anyway...
>> >
>> >This means in such a corner-case the notifier registration is sort of
>> >asynchonous and eventual errors detected later, when the protocol is
>> >finally initialized and notifiers finalized, cannot be easily reported
>> >(BUT I think we could improve on this ... thinking about this...)
>> >
>> >...BUT....
>> >
>> >....this is NOT our case NOR the most common case...the usual scenario,
>> >like cpufreq, is that a driver using proto_X_ops tries to register for
>> >that same proto_X events and in such a case we can detect that such
>> >domain is unsupported and fail while avoiding to send any message indeed....
>> >
>> >....so....:P...while I was going through this rabbit-hole....this issues
>> >started to feel familiar...O_o....
>> >
>> >... indeed I realized that the function that you (Peng) now invoke to
>> >set the per-domain perf_limit_notify flag was introduced just for these
>> >reasons to check and avoid such situation for all protocols in the core:
>> >
>> >
>> >commit 8733e86a80f5a7abb7b4b6ca3f417b32c3eb68e3
>> >Author: Cristian Marussi <cristian.marussi@arm.com>
>> >Date:   Mon Feb 12 12:32:23 2024 +0000
>> >
>> >    firmware: arm_scmi: Check for notification support
>> >    
>> >    When registering protocol events, use the optional .is_notify_supported
>> >    callback provided by the protocol to check if that specific notification
>> >    type is available for that particular resource on the running system,
>> >    marking it as unsupported otherwise.
>> >    
>> >    Then, when a notification enable request is received, return an error if
>> >    it was previously marked as unsuppported, so avoiding to send a needless
>> >    notification enable command and check the returned value for failure.
>> >    
>> >    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> >    Link: https://lore.kernel.org/r/20240212123233.1230090-2-cristian.marussi@arm.com
>> >    Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> >
>> >
>> >...so my suspect is that we are ALREADY avoiding to send unneeded
>> >messages when a domain does NOT support notifications for ALL
>> >protocols...it is just that we are a bit too noisy...
>> >
>> >@Peng do you observe the message being sent instead ? (so maybe the
>> >above has a bug...) or it is just the message ?
>> 
>> Just the message.
>> 
>> arm-scmi arm-scmi.0.auto: SCMI Notifications - Notification NOT supported - proto_id:19  evt_id:0  src_id:8
>> SCMI Notifications - Failed to ENABLE events for key:13000008 !
>> scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8
>> 
>> It just make user has a feeling that there must be something wrong, especially
>> those not know the internals.
>
>Yes indeed it is too much noisy...
>
>> 
>> And from the error message, "Failed to ENABLE events for key..", we not
>> know which protocol, and whether notification supported.
>> 
>> I was thinking to propogate the error value, but __scmi_enable_evt
>> always use -EINVAL if not success.
>> 
>
>I suppose, if you want also to save cycles that you could mark internally a
>protocol, at init time, as NOT suporting notifs (if you can detect that no domain
>is supported OR the related notfs commands are NOT available) and then
>bailing out early with -ENOTOPSUPP when trying to register a new
>notifier (amd muting all the errs to dbgs....) so that the caller can
>warn if wanted or not...

Since you have more expertise in this area, do you have plan to improve here?

If no, I will give a look and see what I could do, but surely needs your
suggestion.

>
>> >
>> >> I wonder if it makes sense to quiesce the warnings from the core if the
>> >> platform doesn't support notifications.
>> 
>> If not quiesce, we might need to make it clear from the error message,
>> saying whether X events are supported for Y protocols or not, not just
>> a "Failed to ENABLE events for key.."
>> 
>
>Yes that was a very early and primitve errors message of mine...my bad :D

How about this?
-------------------------------
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index e160ecb22948..1e5a34dc36ab 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1184,6 +1184,11 @@ static inline int __scmi_enable_evt(struct scmi_registered_event *r_evt,
 							 src_id);
 				if (!ret)
 					refcount_set(sid, 1);
+				else
+					dev_err(r_evt->proto->ph->dev,
+						"Enable Notification failed - proto_id:%d  evt_id:%d  src_id:%d, %pe",
+						r_evt->proto->id, r_evt->evt->id,
+						src_id, ret);
 			} else {
 				refcount_inc(sid);
 			}
@@ -1313,12 +1318,7 @@ static void scmi_put_active_handler(struct scmi_notify_instance *ni,
  */
 static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
 {
-	if (scmi_enable_events(hndl)) {
-		pr_err("Failed to ENABLE events for key:%X !\n", hndl->key);
-		return -EINVAL;
-	}
-
-	return 0;
+	return scmi_enable_events(hndl)
 }
 
 /**
-------------------------------

>
>Thanks,
>Cristian

