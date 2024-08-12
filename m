Return-Path: <linux-pm+bounces-12114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816694F923
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 23:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0611C219B7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 21:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64051192B73;
	Mon, 12 Aug 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+cI2w+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4521586D3
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499488; cv=fail; b=GfJOwwrXcM6XFIqCetB1th0bnfyVEczKYqpHhTrAhtHNmbiCiOwVUwKZHiXEVKdsPArQDHKOb06g87wi9NLIQL94CCqCt6VKrjuAYWDY2LPGeARZvI5lXkwG+biohQzuF/6Y+Vjik9dwmbewYibkxReXXlzyK8M/B5Q55y9NbLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499488; c=relaxed/simple;
	bh=6bCRtJmyqJNAL9G2C2zfoCAPEit03XfSq/h6rCbyNaA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BOI/rEzTYV998eq8bMq/Gfwi3U3aiWJIXuiziWUgyFCnFe03kEiK6I6kn4Dn4ZG0Zca0BCiZKTGObMKpVeFmMggSV/evNvK8jXKx9tov6ib8JFYZI8P/Vbgm5PrnnhRGCU5Gt+HJdiFVV+nv8zA5TMNuq4ghGgF2ABxLs4xSNzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+cI2w+J; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsrxzIDwUXVhpGoGTRr5LUE+fgVmyVRoB8mn+vY9oWG22oHWMQ7fwGOps4uJftcLKghcyEjZF4gAV6IvakLQeTLWWZeDMzcdaE/WaalKwGVqTPy574VP3aXFiczjDok6VcXCBWbwUtWpAy1soTiL6SQ9JibykIyb7LBLhfp66Gs4iAdzpZFWIa95Rke92GVk1xINEC+EjP22RrXN/UX0NsStQJBSf7g0ai4XHYa6X+IawBA+3Mu08dqDgY5uhYhIYhU8yVfYauaYV9ZAddRpJhfoeMJ6MNKaYf8iyWJ5/I8ySobtBPnW4DAKh2CWuQsVrZ5F/dR0TuO5s7C/pgM6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bCRtJmyqJNAL9G2C2zfoCAPEit03XfSq/h6rCbyNaA=;
 b=pHZdV2Bqj2q7pVvmpzWZXq3Oo0sd+nbzTYLUlWBwqna6bT61i1iEVEamlP9EtnZ2DsuvDrtFpZPzR1jIIk1+NBbRELeGWAwXBGp4RHCTgQIllcLQkYfHBR5r5cmD+lxvJlPyfPJvv3LIZiu9Mvc5x3HPNxpnwArJ598fD0wg+oiXTt8MrNEJmvI1JhK+I29rxWc9K0N2sDJIatpvVaZEbpJtEH3hj+JD6zfQylcAT8XjDMeVEY5d1MkynvNOuk32AgV6IYyHkxuC5fD4zdifiqv7ShZSxKGTh1CGhCnL735nvBwSFUkmntJ9khF+eOe706RtsHeJfPaLMRkI+MH/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bCRtJmyqJNAL9G2C2zfoCAPEit03XfSq/h6rCbyNaA=;
 b=U+cI2w+JIuYGs3DEjtPuxZxe3d0WhIuC0rt+f0giVKc7S7MYriqLzsssKeOQ+N3WiMGnV5q3Mg2WollUu5cKlo7mQMdvuFVLrMtMWjV5kEuEjeKia7/Er8pl7geDVsYenHxBvMogGRK5sMbLq8N9yKkeE8wrmk9OSiRtIr9fwpc=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Mon, 12 Aug
 2024 21:51:23 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 21:51:23 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Handling inconsistent power domain states with deferred power-off in
 device drivers
Thread-Topic: Handling inconsistent power domain states with deferred
 power-off in device drivers
Thread-Index: AdrtAYxKacvox0qfSC+sZtezUCzIxw==
Date: Mon, 12 Aug 2024 21:51:23 +0000
Message-ID:
 <LV3PR12MB92605C42C4B7BBA277395534E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|MW4PR12MB7191:EE_
x-ms-office365-filtering-correlation-id: c81b10e4-dc50-42cc-7748-08dcbb18e889
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qu5JQW16GXy+6ZDP+nFoQ0WPIHLA++wuLgbmwkZL4i8whsOGvhd8UqwQLqDW?=
 =?us-ascii?Q?kFqXaC0pts8lrLYEV/SV2nRh7v/DwRYpFrZlFCqhXg2qTMpSdni2kJiEs5ei?=
 =?us-ascii?Q?gesrngiyXe8NZAlN8ro4P/dMwUix82GhioPmzLqlXfFz9pToVyEm/PejFsCS?=
 =?us-ascii?Q?5+/gNpHJ1+YaCmx/Q4ImhlivoS+1jylVXyjEL9LSJCKd9vBRrgrtJsTRfAmj?=
 =?us-ascii?Q?U1aKSf9+WWtqEdnGosDgVGR7RJOsqlHaNbQuDk/S3CuJvKFl89/SULlroG5c?=
 =?us-ascii?Q?R3OAAdP8DK5NkX04Z6BIuVq+BAcZz4B86ATNp0A12XyNf41mCCFJqXOop6JN?=
 =?us-ascii?Q?Dv7yWbwK2xqsDfEZX15HiKmUXk+sE0+q3euemAL6l9JY1FxSd2obDyK05dlY?=
 =?us-ascii?Q?g8/uDSf6f3LxLECUvY7PA4LNx0dKtzNdgzGcVmCVyI/rEcUAaWIgWtf68vhW?=
 =?us-ascii?Q?9qqibRACgeuH8HID7ZJoyYUrmvvagz3rZdYmUxJt24g0IC7Z0yTNzoEVYw6q?=
 =?us-ascii?Q?gPAvuoYVpCqRnPM/YQgojbyldCLRZ5blLOwe+sWYTbFwe6TbT0TlSnTzwp5Q?=
 =?us-ascii?Q?t3KKJyaVNDkx7QsvnPvsdYtKKZkCLAPGELfpQ2P4juV/1mIeLmmYEztAfd0L?=
 =?us-ascii?Q?jAjkzq5BbjRbJOixwNkCqc8yk1Y7cR1d9KCFmjGd/Q7Q+sBIc35RzTLkxZut?=
 =?us-ascii?Q?oZELjRAFed26DVWNOlcK1u4DBrNJ9p/SQwPyWWYttX8YYjxVJPtyvakVleiE?=
 =?us-ascii?Q?5YpdFx6GRQPYK81ptBCxPlA2DzTR7lOLAJpUm4r33JpCuzUPh8j7PE5Ip9ts?=
 =?us-ascii?Q?qh2YT4QRkAPUDkCLVZP/3x/BAzcgGmUOaknvkEKSwUJGO9VoFPpz9ztQzyd7?=
 =?us-ascii?Q?GZlycTh1scGNp3Npio7w8UgoJmvXiOGOvPLehksyYS/O+9zltt94aV7pcTeP?=
 =?us-ascii?Q?P8NcQ+QDgWUwZAW+pEZHyNa42s7yUYTYWcPZmf9vSOqsgdxOw1kNSPl1Tjvu?=
 =?us-ascii?Q?nOr8slewJtFVyRsq31rYUHrfpMr75MIohhU/t+NevqGJTtPiS9JXjhT61yU5?=
 =?us-ascii?Q?D8r6lDuMoQb6xWxLC28VPg16kPFunLGvSJzp1JmgTvPbTbX/7F00SaNeRwSU?=
 =?us-ascii?Q?JCI59pz2f6IxkP+c/BRywSyDSrzbb7X/8gSFqb+SoyWnx9vcnD6GL7ki0nzn?=
 =?us-ascii?Q?dsNpBjJjrzd1q84aSEaTFEEZ5WkjFl1FigFCcFBBOb2VqK2ssfwHlx6vj9u9?=
 =?us-ascii?Q?MlZl/5HO4/xqvb/2/p6WhiTvJ3KP1Kbu029nuUGkr9G0ZwCJOuHaglMDf6CJ?=
 =?us-ascii?Q?DmXsm9UAN0uRt/cGGLm3BPZZ49IvcPyXC3o+E88ht3jL6dft6ZofwDP91p4Z?=
 =?us-ascii?Q?/xbFxEM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZodAh13jUtHMFZITT3coRLfCMVxlqA8EjP5uf4Pl5HuHgFIDHU6DE7w3Smf2?=
 =?us-ascii?Q?4/4IXAN8HhDtw6eL2kfYej9UKIjV9GqMaSUuUEEgCFFjwr3na7GQGmFrBSKF?=
 =?us-ascii?Q?SqcOxMRL62YiPuE1TU9IUhlQ3U4lAuVWf2AiUavN3HJw51dr0NL/xjJM31if?=
 =?us-ascii?Q?4Opvy7C3qiyfqo+8FIuIDWK371qZy5UclRUJoMRkvpMbapRZMyYz4WtmQCdo?=
 =?us-ascii?Q?Rp0EdeED+XHqWIv2XedNNdcBOEimlpG2EAkOlaIGL2dluhOOQ90S8KJgOg+B?=
 =?us-ascii?Q?ikujsQ2jNmvq7srNnA6TRzNo1987dfCXelbz4mWYbs5Ri/BgYju4vadxMYmJ?=
 =?us-ascii?Q?hs+0b+VfI/tspssnIfwJts3+Bj6Y90IN5ec457CXThMIz0efsgo5Ei0OiFOp?=
 =?us-ascii?Q?St+MgZKLCWBTnN7DNknaEfFF5KX6ToQOhwZiMxUc1neUAVYPMVXyfy1VsOaU?=
 =?us-ascii?Q?Xq+DMh3AnjUE7ACcjLWrv+0rHpeoG5N2RVRcQU24zcZnaJyEGeGFlj+2sx8p?=
 =?us-ascii?Q?qVLBXCAYXFcpwneYqnI+EArOj5/Uw16lACUxLapiifmT5Mtr9oYp4m4jl8Dk?=
 =?us-ascii?Q?r2keHYFODQMWGC/Q/qxX5/xIcBYAZiDy4cUKu8QsH9x4pMy+IgyKXf9Xg/t6?=
 =?us-ascii?Q?hI05ZC6BidS563jNRUkLFVOlqAtFFVuCeGt/Gj+X+9MBz4RcLMgFqnirjCCS?=
 =?us-ascii?Q?TVFWqJn+W7Mv6g2m1votaZJWRrx0SetTXPGyERxsX1hMDOtpZciZ5RJ5PnCb?=
 =?us-ascii?Q?EjZ9ER4XzCwZB18i6XexgIMMfaATaRVFJpSdj4RHwI2KUfPdNmVLapjVMter?=
 =?us-ascii?Q?hNxcOpjcWdB315j42ySW0tLxu9cPnFfd+NA9qcJDfwpJWE0mHAYZGWKKGmF7?=
 =?us-ascii?Q?FnOYOGxlZGbngskLfMQcxk00gX+XjB47Zxn3W+2lq0lttRNiThQPmIjdyVye?=
 =?us-ascii?Q?PciSDpH8g1A/tnQFUPVDdSWOCK+Yn0Q9909CImlzrYKhaRk3P5MCtzE0Zdlt?=
 =?us-ascii?Q?+s5vwEYYfn9RZ7oXKvAm4ENMb0NS/irFUTQu2QbIxkdHB/BT3dWf/ZeUpKLj?=
 =?us-ascii?Q?OqaBiMVz28/0HtKHlWZqZzIejWeKONctlWURhaZ6GiheS5/SIIRRVrW3qI34?=
 =?us-ascii?Q?nPqRkBZmhP6VPmI8OhdYd01MMZV7TDdfZOT3CIuW2iHbpXH2V1EtBI79IWW6?=
 =?us-ascii?Q?Zmc9gRTBOff9z7y+MVC27g0dY5ph/eq/2/kCePmo6UgENjrUVDteXzX5duzn?=
 =?us-ascii?Q?fpU4k1YtjqG/UlwcU8whunscZTYbkSVSlVEy4RPPKemvyO9wwevuhoX9M87U?=
 =?us-ascii?Q?S8FfA116/AtMn4tsaUIyrN6nyt7Y7MJ2YNePheM8A+HHFVRsEfUIU4QKcWjA?=
 =?us-ascii?Q?DiykwV7J9YZtNqN91vkzsJ68r8dfEVYP+Uwk3tgpo/bboaxuhJHJvhXeNQ1G?=
 =?us-ascii?Q?HHQSwHeYydRLD6B22krpzquh4BnDtjuLD1R+ZLfZSOjVFHOhziE3izsG8MEq?=
 =?us-ascii?Q?1hgNimzbGWnwCL93Rou9tc7cdJ8DIsy25oofVHn4MIJ2vtyJF/imlP9QOqGz?=
 =?us-ascii?Q?uA4W4S9MIchGv6UiwA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b10e4-dc50-42cc-7748-08dcbb18e889
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 21:51:23.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yC/H6ahbPWzvA+Z04P8gd02r7sJovFOSUeOq63fAb/K6AZV7DtdfqEe3dJ+UkQ70rdoL/SCB3sCSAABnChACLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

Hello everyone,

I'm facing a challenge with power management in the Linux kernel, involving=
 the AMBA bus driver and the UART PL011 driver.

### Scenario:
The issue occurs with a UART device, where two drivers are involved:
Driver 1: AMBA bus driver (`drivers/amba/bus.c`) Driver 2: UART PL011 drive=
r (`drivers/tty/serial/amba-pl011.c`)

Here's the sequence of events:
1. Driver 1 (AMBA bus driver) attaches the UART device to read the peripher=
al-id. This triggers the GenPD to power on the device (`genpd->status =3D G=
ENPD_STATE_ON`). The attach happens at https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git/tree/drivers/amba/bus.c?h=3Dv6.10#n141) in t=
he AMBA bus driver.
2. Driver 1 then detaches the device, scheduling a power-off operation usin=
g `genpd_queue_power_off_work(pd);`. The device's power-off is deferred, an=
d the status is not immediately set to `GENPD_STATE_OFF`. The detach happen=
s at https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/amba/bus.c?h=3Dv6.10#n203
3. Before the deferred power-off occurs, Driver 2 (UART PL011 driver) attac=
hes to the UART device. GenPD finds `genpd->status` is set to `GENPD_STATE_=
ON`, assuming the device is powered on and therefore does not power it on a=
gain.
4. Eventually, the deferred power-off is executed, setting `genpd->status =
=3D GENPD_STATE_OFF`, and the device is powered down.

This creates an inconsistency: UART-Driver assumes the device is on, but it=
 is actually powered off after the deferred operation, potentially leading =
to malfunctioning.

### Question:
What is the best approach to resolve this issue, either by modifications in=
 the genPD driver or through adjustments in the AMBA bus driver and UART PL=
011 driver? I'm looking for solutions that ensure the power domain status a=
ccurately reflects the current and intended state of the device, even when =
deferred power-off operations are in play.

Consideration I have is:
- Introducing a transitional state (e.g., `GENPD_STATE_POWERING_OFF`) in th=
e genPD driver and return error to UART-Driver when the UART-Driver try to =
attach and let the UART-Driver return -EPROBE_DEFER to the kernel, so the K=
ernel will have an opportunity to come back and probe again.

I would appreciate any guidance or best practices from the community on man=
aging such scenarios, especially any existing mechanisms in the Linux kerne=
l that can help.

Thank you!

