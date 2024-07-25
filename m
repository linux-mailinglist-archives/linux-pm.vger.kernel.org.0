Return-Path: <linux-pm+bounces-11384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4793BAC2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 04:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B04282459
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB263C7;
	Thu, 25 Jul 2024 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zks/zM4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B254405
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874434; cv=fail; b=FfuAzJ3ViSL2AvxxGUgsERxnswv+8m8hiru5NDpio1AtqyLq/7XvT3caOFoUHETRlAlOWEf9leqC3d/Ptg85Hy8o7FbpWc8gbJYOGYDBTCCmWjZgDVZOwGi5m+ruYLhrIqEZO/iDcefulgWE2/DS9SVDc0DD5ibZmmUuE+3l4qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874434; c=relaxed/simple;
	bh=3QYy7t8sGs3nYeM/bCKwL+cJ+Vjj2DQVBXEW0Y12JS0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AZL0RRpQPDoZVClgKbEyf/1SBEHC5MUjMMVrPR9JyJyzNRSCYVK8T7JmlkPVKy7uKj0nvfk70tj7abIRZIH5X5kOlIdjULww7O2uGpD8iTfN2d5oVz3OVmuXcUA4Uz6kkcDR9so72NKNXfVxPo7hgyKOejeG2EVtMf6dohM3mW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zks/zM4H; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezRSS0qi40ESlCUhahNyojOs0G50go9mEm3mUDdaXtZ1k+rLwqvz6ztokuyI9FXSEhf/dcVGenCT9PEjEi2D8VAYoHHmyr8tz1EMrqT1AS+uWJW4KATUQpnIsEqSvmoTBY+7kFUEztDID9MNVzAbc8t1tHOC8vZ7lzvzXePQ4bZk2XlTo6XrU6FojGJqqhgwyDZxDz/q7HMIm4ydWxjF9sE5redwGvvXmiRZfX2AG+ppGKe2oZLr+hvwE3n77tsCPEzp7/JPRHjrpyP7Sayxgs02d2qh2MLbz9GUz8c0FnmzPlhhJoEW23q3NAgupzFXRQuK9p8QTy9S21Tkj8lL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QYy7t8sGs3nYeM/bCKwL+cJ+Vjj2DQVBXEW0Y12JS0=;
 b=kGwO5MWQwi16mY8A9PCLu+sdyoRpwuyOoQjzGmqHD43D/Z0MorU0kNawC6+Qo/BBAszgbjlR86v2nF9PPZjicSN5RLL7a0/Zrvk9APoF3ngR2hLqSXKAGuCis5pfNxQsDcidXy04OGd4NY91d8+GBxnVT9d9OiLNOvFVEyzn3gnpOO5eC+80GJ1tWdE2pG5VdwPUBnRalvGEaxSdQwM/Mmtlc4O3G22BJWRzzsqge2H925daT0sjedcBLkaqz7QuqE5CsHI0dXyw1iRTDKIsjYwNkU//UZ34TzAM/zW/pdfih1bLYrKtlKTQkaiNH4y+/t9I+pGq7Vk6OsjeGIwipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QYy7t8sGs3nYeM/bCKwL+cJ+Vjj2DQVBXEW0Y12JS0=;
 b=zks/zM4HN4spm53iJLmaTd2YnY/6w4MaUqvxV9VIGUL4uPiKNNu84yffPL/w0ofumGO715CNUaeCXWYZ2YX8vVaBXQeE+uUZ+3kfEHpFvD582FDnpe9weJrVe8SL29wmpYPDcQS8anj66D2vqbOkhZ1ZXvqiNtA/YBEQKXytEgY=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 02:27:10 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 02:27:08 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Handling inconsistent Power Domain States with Deferred Power-Off in
 Device Drivers
Thread-Topic: Handling inconsistent Power Domain States with Deferred
 Power-Off in Device Drivers
Thread-Index: AdreOYiDSGuQm4FdQ3O9zbKSmfHoPQ==
Date: Thu, 25 Jul 2024 02:27:08 +0000
Message-ID:
 <LV3PR12MB9260352B1289F152CD3554ACE2AB2@LV3PR12MB9260.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|CH3PR12MB8852:EE_
x-ms-office365-filtering-correlation-id: 3a1a50d4-fbcb-4716-3f71-08dcac514831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bUOMRcNoYH5QyKE40duyPYn8I9A1D6zcgFPz6zttXIcj/gC64ruoN3L8rRzL?=
 =?us-ascii?Q?JJHgCUJn+0WXMpYmIvUBkCilv/aB529xHDkrC9MC8FS9AEAJj7ERD7/bFqLm?=
 =?us-ascii?Q?/EIZyn6qGsbceapy14tkxyC3KNh9aoWGQhS9Hb36DysffGxSK6R8FdNYQPNQ?=
 =?us-ascii?Q?T6dppqSi/mQ9D5pXyN/0FK7Ex2BTlXGhCsHi9FJek38L6k/nSCRvCjJhOzRh?=
 =?us-ascii?Q?TK5kaRYXIMKY1AzoCm14LIZ62CUNd0U7/uD4ZrGo1os2tGZa9JeBe7EuvDNb?=
 =?us-ascii?Q?CFXebw5g5nBuZ+y77FFNR3Iz3un5YJrrR8Pl1Ve2jdpqrla3cR0eP5e0/1H0?=
 =?us-ascii?Q?Zq45+i5It67i0EB/vNu2yrkDzGh0+Sra5rgVniWa3pO5F4KYX3828jXemSYw?=
 =?us-ascii?Q?3NO6oeuo2g0IzjwVhHJkGF0v8lvXz4H/ZrXdVi3GuaqNc4laZYfXrlWZKyU/?=
 =?us-ascii?Q?jv92icRtkgLZ/s6MZuTGPVyXOIrzvmZLWYeOz5i4clKsSjk8XiRrKP9yagMj?=
 =?us-ascii?Q?BEH92zm/ARzmCcerl7jN++Df4G/oW1o09mjwqH8Bm+P4R8DBGWM3pN6jf8l+?=
 =?us-ascii?Q?qQ5IR65PypUMsGCNtgH8zvkjsR17B6vo1IEaHlbyd7HkRUESzskwzHtmeK4Q?=
 =?us-ascii?Q?AnPyYyen5A8YooT78EB03Lb9Cj6d2aqI0WDaUM9XSm9U/0T+K7fG1cm1vk2u?=
 =?us-ascii?Q?UGWFu2QX+2vXLmbvK3HmWr3qoQ7KmUuylCHgsBZCptdcLqb3uG0tvD7zePWJ?=
 =?us-ascii?Q?MdQDxHAKJF9iGLzYsG5e29qumKCHHKLAca+ibYuMH+yNBRhuHXhnkjuJRWlj?=
 =?us-ascii?Q?3n4gnxSSvmjvUPEvOl40NNCJchB1EjAkp7WtqRzG4NYjZLRu+T3lARvU+saq?=
 =?us-ascii?Q?rcxG7G31u1iREyOSx6jQKGWPe+vi4UC1xLRmsaan1BNb/PyBOlFfjtdWDuHI?=
 =?us-ascii?Q?2khJkj5uvLhJHjFopbcYSQiEK8x29+9fHAwN1URD8MyLYuHuu7zFPcgF4p+p?=
 =?us-ascii?Q?ICWB/SrkhYu25YSy6PMAvayAdi+iQQ/4NNJ+091Fo3i0OPENSKZqwPtiRBly?=
 =?us-ascii?Q?+r4OZixoK1YWOtdsKbibPppNsojKUwtqOOBYinDlVbi1yACLMrP29wU6iMWg?=
 =?us-ascii?Q?q4G8mUS1M7oXiKn4RWo3WsnjS+z7JEZHPwITYveoVsnkoVGaVyt8N+zSUV97?=
 =?us-ascii?Q?pRzoQvvmj0PkcnzR5UQfro5M0lv/X5Hd53rfe3GlSaaMmHdJxLIH3S9FspjU?=
 =?us-ascii?Q?q6ojYYsPo5T+2cpdNUvQlAzrXLo31HuGAWzUTMKuWlk2QgvHQQXmJTl2rTaE?=
 =?us-ascii?Q?ZW4QJYVYsQteLUjR3qpMCrq1WfXXvGttOWoV8/HBEtgMz49dbfhPupH0XnaY?=
 =?us-ascii?Q?Nf0R5O0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K/ivBDYj7sk3SnhT9jCnEym9dAOE2jc2+IaE7dnPw6jQh0pM5bD4Im5UhTwa?=
 =?us-ascii?Q?u7NWZuwiETrOhNnvmZtkSis1398Y/VLE70XkQlHS5JtdiMw2afgsevSOOi+t?=
 =?us-ascii?Q?cBltqH2s6ZEpYDBcpU1U1QIHv+d/wnFPVzrMsvuzqyGIJVb1m3ysFSTTOKpt?=
 =?us-ascii?Q?coo+ZqPHdiZHUgVqn9e+GBRZbe1NAE8Lyh72Fo2SBViLUeKh6ps5XQyBxlMl?=
 =?us-ascii?Q?jjq9yp7CFXCDNHn6s0pAu49goPGwrZ8N0MHsNAo2J+DMxq0qrYnaIflWa0oN?=
 =?us-ascii?Q?zqoZCtnF+yHxrw1V23k4Pp4N+3xvsblppzFWyx+0R95e4ODcdoL8oPLu0CWK?=
 =?us-ascii?Q?0eEu7cFrkIW/LVfxq+6UgjgoXSs7uY5+lMvO6swWGH5qeso3/tZzNc0fQlOM?=
 =?us-ascii?Q?Z94wmBzFkpDX75UCeeS/dmEZYJVTG2wz4vbZ0+BU88ftiavC4Xxt+5pQbDeC?=
 =?us-ascii?Q?AQwyC0oCxLZ7EFU2+IjIpEbNg1FEuOO17ccpsP53GlT+vh87N2OT2NY1SWvz?=
 =?us-ascii?Q?KE4U+5wx8AiEOOWAURM7u/Kw8VvjQicRhoBDhusGCGekIbUTXfrSRyWXXIuM?=
 =?us-ascii?Q?NN0nA5gcMeUJsrARdhGMWWBW2uQlw01Wf4/EEt0Ez3u5K/Vs/zYTj7cLSZUg?=
 =?us-ascii?Q?P5IrO59pOGg970Cp205nJ9/LdPCAO55MJYMAqUf0S56vkgt6v0dc9/US4xlP?=
 =?us-ascii?Q?EbDyWHb9UefyNsC/RTjvQSEbvcvhIKO4wtSgUUVqj4D4T+DHT+UOo0ZhE7cw?=
 =?us-ascii?Q?kEcYV1NQ3J84ud6sy9lE0AvjGYr8aQbWZWo6suNgO+XhJW/pgPLY3wqx2SyE?=
 =?us-ascii?Q?9L/5AwnNMW/RIE7JWyhqGDgJV/rFmLFceRxdUhb4YUV2RW20YYqCnsRA9jLj?=
 =?us-ascii?Q?LGqLxpe6Xu6ubwy3MH4btgpPcqgPMRKvPx+rRgDu28ZFUSMq3igHul0fnqmS?=
 =?us-ascii?Q?TewbcKSmDVJzswuU9zIDi04yGSYpcXzz2xiwAl2MG9JPHWe5zGqu9A5mNPkM?=
 =?us-ascii?Q?nLf4TgWGF5LcvOUjpTd2Zu8Sp/5nzKBJNiLQ4Lw981HflZ1IRKPXr/9W839c?=
 =?us-ascii?Q?SFq+cGP8LVfrF3YbOrCzOMRHMRpOwrofgn4y5BCFIC717kvZdba7n0fVHKQw?=
 =?us-ascii?Q?FqP5mik9y/sarjTqzWlOsHDOJMbq5IZhRO0RcXfBP1dRiI16MrpR7Joey9lP?=
 =?us-ascii?Q?1g/Hi0wyA1UqJYQtPf9H+803vzdBNWWOKDvvhgx3bzXQR2m7xKCSk6sSx/bY?=
 =?us-ascii?Q?bCJ7tsvSVkaspqgV2o5KdcYK/zMW92lg4qhT/ZEB+vICUAs7sFvMqlK5Dzfc?=
 =?us-ascii?Q?S3BhbhlLDXnT5XQm2C/r6Wuw3aR9O//nwBG+fysLS6wd+PkWjr1jPwLb5QjN?=
 =?us-ascii?Q?wv1+fWX3ICw8ynG+3ryOK6d6/FJ71cpXJPejyevPBm15LeQtflSf0SBJ8V/P?=
 =?us-ascii?Q?XnX94Kp/U7p5pjMVAv+MeKRdBycfWxB0Vk057qlVB1R/2hHwtZP27N0T46c8?=
 =?us-ascii?Q?r1OV1D5O1vHH5+4kwfyM9bAAUp8Ww8dBLH1Fmb/yWzuZQWvd4PvvpifA1l3i?=
 =?us-ascii?Q?gtcgOpz/MLnxDtSWuiI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1a50d4-fbcb-4716-3f71-08dcac514831
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 02:27:08.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG43PGP4R2tjfFQtaiBk+NaXvlp/TMXKjUUHGTIKg8LNOSgCpcQCp/NUZdZHmTrep9VBu8U3L9vSPhszMhKfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

Hello everyone,

I'm facing a challenge with power management in the Linux kernel, involving=
 the AMBA bus driver and the UART PL011 driver.

### Scenario:
The issue occurs with a UART device, where two drivers are involved:
Driver 1: AMBA bus driver (`drivers/amba/bus.c`)
Driver 2: UART PL011 driver (`drivers/tty/serial/amba-pl011.c`)

Here's the sequence of events:
1. Driver 1 (AMBA bus driver) attaches the UART device to read the peripher=
al-id. This triggers the GenPD to power on the device (`genpd->status =3D G=
ENPD_STATE_ON`). The attach happens at [line 141](https://git.kernel.org/pu=
b/scm/linux...c?h=3Dv6.10#n141) in the AMBA bus driver.
2. Driver 1 then detaches the device, scheduling a power-off operation usin=
g `genpd_queue_power_off_work(pd);`. The device's power-off is deferred, an=
d the status is not immediately set to `GENPD_STATE_OFF`. The detach happen=
s at [line 203](https://git.kernel.org/pub/scm/linux...c?h=3Dv6.10#n203).
3. Before the deferred power-off occurs, **Driver 2 (UART PL011 driver)** a=
ttaches to the UART device. GenPD finds `genpd->status` is set to `GENPD_ST=
ATE_ON`, assuming the device is powered on and therefore does not power it =
on again.
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


