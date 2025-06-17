Return-Path: <linux-pm+bounces-28862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C8ADBE8E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D8E3A6799
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFF1B043A;
	Tue, 17 Jun 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dQ09R3Pm"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959521891AB;
	Tue, 17 Jun 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750123785; cv=fail; b=jwhNTFs7UfFi3jeIv5W/irtH9wdTHFld5sMGcUDOQNEZcLU7hUsI5+7yWWUIOrKhypMbfhpU5hhJwQD9UK3+8OzrohgZ+ZzWa1azuuER12zUiUvVd6lB1szK9XIjb54x3Qv3V8Q1/ORX7aXroGdhI6wgOB64abaSu0H8zRn7raw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750123785; c=relaxed/simple;
	bh=3zh3PQEpggW+kToDudJZax7UzIV8oqnf/qorP93CRFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qliZ8VBf9jhIZkF10AUBfwOCHLu4YTKCQRy07HxSw3ooc8VEFpK7OPc8Ie4GleYR7OH2QKYJW1YOVmZ3jMoDBfk9cIVQLIFLnyqmIQV5D3y/5tCFF/FvXoGic/72A1obbppf8AiFUvXnPymjh/O1IggnrwAuCYz/CYJ0VHiXuzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dQ09R3Pm; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsmVh3A+PRMS5x8sK+5NOKlnJhtg9BLKd1WDet7EgbjjESNMBSgwQZMSqSs64VaEyk6Qs3qosPOc5wdL73Qo5rbQpbqcxewR4tzjJcrXqfFTSENR31fI4w/G5qvmdo0PxsfmRHR8gyMXo1BWPNI7E9pL0AivYZKwjsb4ZYylsygC0Hk5A1DVuKFzUff+elSM41l2l+AYAIHpB8UV/lQ1L9Ynb0jLYm2cPgwn6YRgHX5VhvFBraAichwQ7EtF9kXsLN5Gc2c7rdVIr9TuM+rkHylWYTwem1SE3wjvvCwohfOpXg1S9K+Uo0n8n1AcYG9cBH12YRAc7nSYC4JoD2YyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PE1NQ6R9kuqPymcbW0Ltwli3bEDZ0hBI3RvWISW5+Rw=;
 b=SkAOSkHYZqkay1qyS0r4dlqlCaRYBCJxAbvMxMOM81xZ/g4KTNOd2fh0VRnwUtJcm51l94y8y8VoghnCoABKnDx3xA9h6hDDVjPzYQgPEW8qkptQSI/DFaBO43c5gOy3iOuDAbKfvkKAXiab9H1JNLd8FKpIsJLKxY8iF9s3Skv+neU7iI9nkWOsJ5xzCKIyB7iWAUaiktrrmSWyVM5n1EKIOXXtMebJUBA+iweF6dOhqwDen0Qs7cPjVfI8DlmgE5Ub26/mVZHhf++/yiDXMr4A8jSeK9blYPmRil9BDMJH++rQZds2Wc18BjkCBzMvFM5KoQYnv4YZb4X8p+TMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PE1NQ6R9kuqPymcbW0Ltwli3bEDZ0hBI3RvWISW5+Rw=;
 b=dQ09R3Pm49N8qc5btkFrQyEef5V5COAjLHgy9JmXcIk/Ns9Ccn9t2fqv8YaVxnwI660qPiUBH7OJGBIDRSZAlC3g1/MYVH5+cX+RTyyiudV9oKm8H26T8Q22Wd4/AJy0BtZj3Vz40x2whtxLuNS2A62WLkqcqpu9bhJMbwVCwQ/rgwt7oZgaq4rLt/nx13dBDeIR0zO9ZKFt+enEQsGsjquC+L/Zl8ZjJUzqRha4pvhlsdBJ2qdl2hgfMMlAsRF8DT663raelfGezD0QnHWINlRF1G0KvueFkAMSIlJUtcxpzskcHdWwj4+LiEbQA3+/BB9wSLd7s00KfysE+jIG7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 01:29:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 01:29:40 +0000
Date: Tue, 17 Jun 2025 10:39:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <20250617023958.GB30636@nxa18884-linux>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250609173115.qecc2noswkcgr3hm@hiago-nb>
 <PAXPR04MB8459F651D1D0AC8C51F292A48875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250612170317.k3cok3utmiy5ptq3@hiago-nb>
 <20250616160511.wynya4ezbj6nafkd@hiago-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616160511.wynya4ezbj6nafkd@hiago-nb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5c3f8c-a4d2-47bd-ebd7-08ddad3e6e45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcgfLnEgjMTUplT8tFoOsVm7F30CP7EocdKtkuwl4qBEo6doBvDq5rKIFlkQ?=
 =?us-ascii?Q?nqfFaLaqqYDmARB7X4Gh/VcBqBPkWdeR/g+JDjxA3FwHfFO/2AqynWiYgyIH?=
 =?us-ascii?Q?/X6k0BVwTpRnrO3MGx3hOQnRPKasaZ4Ue3eaFnE2r8IdGFCdEf9N8RYkrC+9?=
 =?us-ascii?Q?tB7argyyTJpCa2WDnMlwdFu67FUi2ytBs0vmDFaZJdFNUYeOrUNmHDF0fdS8?=
 =?us-ascii?Q?4nrO4Fxza1fM7TlHpi/AMdhESfU8QrZVHSAyrzH0DlH5KQWZdfmns6JZLt/m?=
 =?us-ascii?Q?ypq9/n+YNub/CDaZPtka24RBY17X3m7pAVpPo3oc24ODEwhdO6wXT1Pn5pXP?=
 =?us-ascii?Q?FZ0yBZK8kSyYXxLMROzDDXrQTDSzL1LxldRlVJjTsCOy7OV+e6P0mUpDrb5X?=
 =?us-ascii?Q?DLhwQOabz8Vpf8p3Fzy0gzU1OVVrmjG1gu7Totch6oBFbwC+Re1BAugzW9n6?=
 =?us-ascii?Q?1egfruwzEW6IvFALVGaQnxBEA26PuTzVmxFKNu8rrNkNpAjtLuQFJaQhJxqL?=
 =?us-ascii?Q?+i0QowsusS4wFKB09ZqNf2WF8Xwg+srxj/JO7rg/cZqQXBwG6ywVsfDZ3wpr?=
 =?us-ascii?Q?6uAWLAKlJU/q1CSswyB+wOU/SqPbJCKbM5MEO6jsnGXAkxQbwJ4NLy/APdWL?=
 =?us-ascii?Q?JHOjKWBWHVdlTVKVqUXznH79OXJF5YgAIIwl590pV9OEldRqfocx1klzNmwM?=
 =?us-ascii?Q?C+h55n2eWPj6LIlX1SwNtXTr2tYKkFAhIli5z4ut04vruNDLV+3vJVhu6jSW?=
 =?us-ascii?Q?JF8yTHqOnThvm56kJlWGXElEmJDXG7VtjwzXLusa2SyszfF69z0n1fF/KTFk?=
 =?us-ascii?Q?xrLNiWDyafwpN19cuQH8U9MxFyegrHyuNqX80Z/acQ1GduVES0szh9ewLh0+?=
 =?us-ascii?Q?hiznQpC4zwokopvAcsHtZ2SIz6761m1ovefaf0f8rkLpaGjw3EaW+MKzmsrM?=
 =?us-ascii?Q?ykYSVwoUTQpR5koDLAVPUrfmtykCO4fi4/6Mb3Sv6VkIgXcfopA2cvNySyXe?=
 =?us-ascii?Q?KmmI0/CoKwVktojBJLX9WMLT7BGwl2I0nnRWpr9MJ1hLiHRZF48CDOsPrOFA?=
 =?us-ascii?Q?846Joou8ONGwgiMqMEkKrhgA5g6gX+yNPKZTWti7TUW4wvSXhd/Swl1VVJKl?=
 =?us-ascii?Q?Ylz8tyhemr9oVto2e9/MEGY6h2nqACzL11IE9Rwo7gn0k5v6q/e5nhlI/JcC?=
 =?us-ascii?Q?P6d4r39F1cUS8cEPuzZLXlABzjcuBiiB8plZINnB4HB68q8STUQR/zo97+nU?=
 =?us-ascii?Q?SfuxvZq7zVX8baA3weJ2rOdARLgxM5WBtkPlmGAEdvFYUG0kJIUa1e23X9cj?=
 =?us-ascii?Q?vedf/+aEb3LInGS+uOFag6QCBCIw9IpmC1EMZWNsyf85u4kxKdggJ9wr8Hns?=
 =?us-ascii?Q?Gp9Hz1qQplFjnzQY9nuVmRvIJXGRG+IYH3kLb5VlfdpwGzjqA3jNMvsooYrE?=
 =?us-ascii?Q?dJBjFb/jt8kvSAKE1DKlIoqBAP0stCj72zLd1wXBbOIDfreyP2ax6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8dFVfZlMhw11/ddVQHyKSSaukO+UEh9wZ9ukeYbwJ6pf9kJfL6j8Br88Bpw?=
 =?us-ascii?Q?bg7ieCgvLWLlTWRvwFgKa6Ueeq6U7Fw3aCGpxeSQv7Jl+09ETZjIBWBvNOGI?=
 =?us-ascii?Q?RrNrtuybo0LeTQWvOfBZRFOVNtdBQtaDtecAreKW5huZgYk9hPAEDXgs2UOf?=
 =?us-ascii?Q?tIDCTU5KS/18r9mhWEIZ0AKqDBqdUQ9L2OxHpRThAfqx0RWMLOb7rBVodQdO?=
 =?us-ascii?Q?c1NrOuGqtLfeMs9GXru9OefKZvC4SSrczLocl2Mc9W1EsumdSeirGqEse0m1?=
 =?us-ascii?Q?zT8IlA0M/BCsdJvQU2E0ufTcsc+4g80pbE479pe/VO6BeRXyZ7vUxyrr+22j?=
 =?us-ascii?Q?d3/jb0+Ad+6TWqX8VXrWbyxs/gWBxgJJHJ3HPPilCy+h+lBvRpvosyELX/6/?=
 =?us-ascii?Q?MSNqQczc/BX8qSgHCdt8/9M8sliHJRhzkPIRXGZ5qfQPcM8F6aMkvZyYogAG?=
 =?us-ascii?Q?OEfYmZbaHDWkgFVaQI1GQIuURf817d2FK8g5hSxhWvjUp6tXWli4t/Kpdw0n?=
 =?us-ascii?Q?bNKhRmZZaXAFFjxrsz1UqVrTVhLjAAR3ChPzBMK8yhnX+S3BoTv3L6MgLGx7?=
 =?us-ascii?Q?2Jx1zFUbk4TFX88RT51QA9fJnNX/VnFh8iFbuWhcBEbJy4vIWOpGscK3KCyx?=
 =?us-ascii?Q?/mrBEeBzNQZ9tbKWuOqXSe5aZd9u3N+5RbfaXrs43OcTroXGttT6RO61suG7?=
 =?us-ascii?Q?wyeoFBGGuYmUArSg7G9m1/VV96HHnN5QJ2piNEQdlzrg8svYgVMfY/1AtjTK?=
 =?us-ascii?Q?jWf0axCO+FI5AVOrb1y57oKvSpf6y31htPvXA1ayD6rxMokyF8JiLotkb4bP?=
 =?us-ascii?Q?LmJFTfM6DdgPQtt+ZqNXNmQKfiLez9D6526aF9KWqgGfjBsbsX4JomYTZEoL?=
 =?us-ascii?Q?O2NwHQtMdHg74g2Qiz7nCnUvhRDCCZo9usqu2lMSvovgIOABexO1ECUm/StA?=
 =?us-ascii?Q?k1+1qBDp4DLhA68WV8SOV+DBpZSDEVG9xLNzbykIxRcxP1id7NpBzHtR+HRO?=
 =?us-ascii?Q?pdB1SY4o7FB/IAeovvtwiGMQtsiqdmkh+oINqdXLSpMFIdMXUrMoLdF1myle?=
 =?us-ascii?Q?KHpasJWA30/yGP7Qpgic/5dd9ZYCoj1I66zOMq4zQO82WxNHwbNZ4IZjwVkT?=
 =?us-ascii?Q?qAuJpi8Fjt2p0viHY+tHFRjJv8AfEfIWNIXzDAjyKQMK5xC1GPRzD4YSEuyG?=
 =?us-ascii?Q?ZPzyCELtjw4l5FpuL64iN1lfqKKvFU2IUTAmgDr0uYDYyTF2CN803geGr/u/?=
 =?us-ascii?Q?rchladgqVRHvpWkvT4nG4gr0n81AZA5AHQzcdJ4ZJ0r4wkvjruMXvU7Ll1fI?=
 =?us-ascii?Q?w751Eoul/yMrGmkr79XRlzCdSAUAPVnL1LLMKdLlZJN0vJqTVH7ZzTQuQD5R?=
 =?us-ascii?Q?FbchSq1jWEIQ9CVD2p/vuoHa33DybEQBSvzyeKXHj/m2Ub7oK/DXyBjzmQvj?=
 =?us-ascii?Q?w044/ozB74KD+G+0cGy0SRvkJpJMscbBRxgc8l2xAoqxKQE8TwzQ5LlA6trn?=
 =?us-ascii?Q?JbKBE9poPWT9sl5t5XxL1ng7jZtbvyxl2PFd9UsncGzbkWBcxADylZMg+JAh?=
 =?us-ascii?Q?/SYENOpIdxXcevaPbokuHFA21qRJ1iS2QuGpVePo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5c3f8c-a4d2-47bd-ebd7-08ddad3e6e45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 01:29:40.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RLS7XH0+cAhnLaieZxMLFn/AuDsVQbPB7P8xxbziQt8Lv4ZKB/mczCn74coSW5+AtuiPRgkXQPlvVEe9Kt85Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

On Mon, Jun 16, 2025 at 01:05:11PM -0300, Hiago De Franco wrote:
>Hi Peng,
>
>On Thu, Jun 12, 2025 at 02:03:17PM -0300, Hiago De Franco wrote:
>> Hi Peng,
>> 
>> On Wed, Jun 11, 2025 at 03:27:09AM +0000, Peng Fan wrote:
>> > > 
>> > > Sorry for the delay.
>> > > 
>> > > I tested it now and there must be something missing on my U-Boot:
>> > > 
>> > > Disable imx8x-cm4 rsrc 278 not owned
>> > > Disable imx8x-cm4 rsrc 297 not owned
>> > > 
>> > > It removes my nodes from the DT before starting the kernel, so I cannot
>> > > attach. Do you know what should I do in this case?
>> > 
>> > In separate partition case, UBoot will check the permission
>> > by checking the rsrc-id, saying power domain id.
>> > 
>> > You may need to remove the power-domains property
>> > from M4 node.
>> 
>> Without the power-domains property, rproc gives me a kernel panic:
>> 
>> [    1.253234] remoteproc remoteproc0: imx-rproc is available
>> [    1.258501] remoteproc remoteproc0: attaching to imx-rproc
>> [    1.263950] Unable to handle kernel paging request at virtual address ffff80005ae57d39
>> [    1.271812] Mem abort info:
>> [    1.274575]   ESR = 0x0000000096000005
>> [    1.278299]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    1.282581] mmc0: SDHCI controller on 5b010000.mmc [5b010000.mmc] using ADMA
>> [    1.283607]   SET = 0, FnV = 0
>> [    1.293701]   EA = 0, S1PTW = 0
>> [    1.296815]   FSC = 0x05: level 1 translation fault
>> [    1.301699] Data abort info:
>> [    1.304545]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>> [    1.310079]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [    1.315073]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [    1.320367] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000096bf3000
>> [    1.327061] [ffff80005ae57d39] pgd=0000000000000000, p4d=1000000097085003, pud=0000000000000000
>> [    1.335750] Internal error: Oops: 0000000096000005 [#1]  SMP
>> [    1.341373] Modules linked in:
>> [    1.344414] CPU: 3 UID: 0 PID: 47 Comm: kworker/u16:3 Not tainted 6.16.0-rc1-00024-gfe5d6ab20714-dirty
>>  #857 PREEMPT
>> [    1.354932] Hardware name: Toradex Colibri iMX8QXP on Colibri Evaluation Board V3 (DT)
>> [    1.362837] Workqueue: events_unbound deferred_probe_work_func
>> [    1.368651] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    1.375601] pc : rproc_handle_resources.constprop.0+0x78/0x1d0
>> [    1.381421] lr : rproc_boot+0x368/0x578
>> [    1.385242] sp : ffff8000819f3990
>> [    1.388542] x29: ffff8000819f3990 x28: ffff80005ae57d3d x27: 0000000000000000
>> [    1.395671] x26: 0000000000000000 x25: ffff0000016ee038 x24: ffff800080f3c680
>> [    1.402793] x23: ffff8000813d6da8 x22: 00000000d999ad39 x21: ffff0000016ee000
>> [    1.409917] x20: 00000000266656c3 x19: ffff80005ae57d39 x18: 0000000000000006
>> [    1.417040] x17: ffff000002020600 x16: ffff000002020000 x15: 4addd15cca11c529
>> [    1.424164] x14: 73ebceed5d6cd787 x13: 4addd15cca11c529 x12: 73ebceed5d6cd787
>> [    1.431288] x11: 95a4e33b6b190664 x10: 9e3cdabdb09ca345 x9 : ab3734eafdd6fd1c
>> [    1.438412] x8 : d58a055de4cfb385 x7 : de97fab1791acbbe x6 : 9946d97107d0dcda
>> [    1.445535] x5 : ffff0000032b2c00 x4 : 00000000000003fc x3 : ffff0000032b2b80
>> [    1.452659] x2 : fffffffffffffff0 x1 : ffff8000814bd000 x0 : ffff8000814bd000
>> [    1.459786] Call trace:
>> [    1.462215]  rproc_handle_resources.constprop.0+0x78/0x1d0 (P)
>> [    1.468036]  rproc_boot+0x368/0x578
>> [    1.471510]  rproc_add+0x180/0x18c
>> [    1.474898]  imx_rproc_probe+0x3e4/0x540
>> [    1.475274] mmc0: new HS400 MMC card at address 0001
>> [    1.478799]  platform_probe+0x68/0xc0
>> [    1.484628] mmcblk0: mmc0:0001 Q2J55L 7.09 GiB
>> [    1.487400]  really_probe+0xc0/0x38c
>> [    1.487412]  __driver_probe_device+0x7c/0x15c
>> [    1.487424]  driver_probe_device+0x3c/0x10c
>> [    1.493941]  mmcblk0: p1 p2
>> [    1.495392]  __device_attach_driver+0xbc/0x158
>> [    1.495405]  bus_for_each_drv+0x84/0xe0
>> [    1.495417]  __device_attach+0x9c/0x1ac
>> [    1.500468] mmcblk0boot0: mmc0:0001 Q2J55L 16.0 MiB
>> [    1.503906]  device_initial_probe+0x14/0x20
>> [    1.503918]  bus_probe_device+0xac/0xb0
>> [    1.503929]  deferred_probe_work_func+0x9c/0xec
>> [    1.509863] mmcblk0boot1: mmc0:0001 Q2J55L 16.0 MiB
>> [    1.511117]  process_one_work+0x14c/0x28c
>> [    1.511132]  worker_thread+0x2cc/0x3d4
>> [    1.511142]  kthread+0x12c/0x208
>> [    1.511157]  ret_from_fork+0x10/0x20
>> [    1.517964] mmcblk0rpmb: mmc0:0001 Q2J55L 4.00 MiB, chardev (241:0)
>> [    1.518770] Code: 8b36c033 9100127c 54000924 d503201f (b9400261)
>> [    1.518777] ---[ end trace 0000000000000000 ]---
>> 
>> Currently I have the M4 partiton defined into the SCU code:
>> 
>>             /* Create partition */
>>             BRD_ERR(rm_partition_create(pt_boot, &pt_m4_0, SC_FALSE,
>>                 SC_TRUE, SC_FALSE, SC_TRUE, SC_FALSE, SC_R_M4_0_PID0,
>>                 rsrc_list, ARRAY_SIZE(rsrc_list),
>>                 pad_list, ARRAY_SIZE(pad_list),
>>                 NULL, 0));
>> 
>>             /* Name partition for debug */
>>             PARTITION_NAME(pt_m4_0, "MCU0");
>>             
>>             /* Allow AP to use SYSTEM (not production!) */
>>             BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_SYSTEM,
>>                 pt_boot, SC_RM_PERM_SEC_RW));
>> 
>>             /* Move M4 0 TCM */
>>             BRD_ERR(rm_find_memreg(pt_boot, &mr, 0x034FE0000ULL,
>>                 0x034FE0000ULL));
>>             BRD_ERR(rm_assign_memreg(pt_boot, pt_m4_0, mr));
>> 
>>             /* Move partition to be owned by SC */
>>             BRD_ERR(rm_set_parent(pt_boot, pt_m4_0, SC_PT));
>> 
>>             /* Check if booting with the no_ap flag set */
>>             if (no_ap != SC_FALSE)
>>             {
>>                 /* Move boot to be owned by M4 0 for Android Automotive */
>>                 BRD_ERR(rm_set_parent(SC_PT, pt_boot, pt_m4_0));
>>             }
>>         }
>> 
>>         /* Allow all to access the SEMA42s */
>>         BRD_ERR(rm_set_peripheral_permissions(SC_PT, SC_R_M4_0_SEMA42,
>>             SC_RM_PT_ALL, SC_RM_PERM_FULL));
>> 
>> I believe this SCU code is correct, at least this is more or less what
>> NXP provides as example, right?
>
>I tested the same SCU code and DTS overlay (removing the power-domains)
>with the current master branch of Linux and I got the same kernel panic.
>Maybe this part is already broken? Can you also test this on your side
>to check if this is currently working?

Does your M4 publish a resource table when M4 image built in flash.bin?

There is no common method to verify whether resource table is valid,
so if your M4 image not publish a resource table, there maybe garbage
data in it, so rproc_handle_resources may crash. NXP downstream
added a sanity check in lf-6.12 Q1 release, you may give a look.

Regards,
Peng

>
>> 
>> Best Regards,
>> Hiago.
>
>Best Regards,
>Hiago.

