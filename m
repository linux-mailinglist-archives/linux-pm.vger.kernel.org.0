Return-Path: <linux-pm+bounces-11721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00A9422E7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 00:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B30282D74
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F818CBFB;
	Tue, 30 Jul 2024 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GLpQHLa3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07782157466
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378420; cv=fail; b=Xtl6drLptSxDJXMHrnbiidwrYqX3b6pUJGWSEg/wZjERlCZe28Sk9o43Te61j0LKdUw2aJh8GiWeidAebwtkDaOlEjEASZTYcTlng7tsATNcrR56E0FwPw3ylp0OO9Y5SZsSSM4Mub1dVqweT8ErSjjo7ibngv7bLmaCcYFqurE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378420; c=relaxed/simple;
	bh=2zWDiZmxiJWSqioZWur3Kk2UUzv+wicmYkjGKQymmys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=obDayHIBhd5idCPkdeMl7nOAGwBlA0C1CaCmHJ3WG+/yTBsEcxIixa7NIBg1xFgmAUG5khzaz11fzCbIYgR+PmAD6ILJMLNL6Tdx6DI9rzzy0sgTu+hJLdjRLDjUL+jAqEo2bFpBqTmG92BEeK2K8ZMjg4s5zPI5GwYtlFkQULU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GLpQHLa3; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUy8vBhjLD9CrY0wsydDu6EzPAIycEs2/ZsQ9Vvz+VIMl1mx66FLw/BJIyY3RDQ/HOZc9fFfJsVNc6nZ4GrVHwSeF4X8l73iZI23JovlCUPIZKaKORnGamJCFHl1xlRMotPG/qjghkspAtxrN51jZaYFqJRNWjVxm37IOBL1TJrdSD8UT+gPikyd7MIaNjIAhNIg7rPJKrWsJ3VeZ1f/2w9kPXC2gIl/KpwKN4J+ohoatUK8AGamfBIh98CYiefX3bY2regMHIQpm9LD+Au5VqZ+McW3C1xTe7/yMXWhVlHp4HdgA4R1aypxWXoa5JARwpoPjKMktymXy9MGf0QRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zWDiZmxiJWSqioZWur3Kk2UUzv+wicmYkjGKQymmys=;
 b=SwOBb7S5I+kLidcysre5z4OwGSYrDBObZ8xuQ3pfAbdBOBo+WrycfcTr65q54S5OqGvf0C79yUkL/4Mq6rtzF7tq7SOPTAZskgBeusTJzjPTyY1bHIq9b6zvChbt6bWbph2eIZ1c2v2wpVIOIprSgbkvcBdGkd1/CIgFjTK0bhEtQ1GxickyCTDNk2kRDRFdw5yB5Pma46a044RNPmKSp5SzzFo4iQZL0LwCRzh12ev3/p2YQLGiTRJDpRf6wvO37eLfgMqfe8eL5zGiRsM1N5f0p/okQhSp2E4vuDstgTgci0szbsDGb3vwGPzcoR74/PtF5cA86Rk6l7QA4BzWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zWDiZmxiJWSqioZWur3Kk2UUzv+wicmYkjGKQymmys=;
 b=GLpQHLa3n1pPGp1qVwmQ8iebxRie16NLol2gVBR5SUDNYBcTIKh0YSspREBZaLT3Bm6sk9iFTNShZmRRX0K9/bvyJ/EZQ4Etmjb884esMNh0nHSLlaunEmhfthjoTug4NuUoSWdH0uY1ESP4ybPBOsL6FDjh7iXhLEacCrOe8OQ=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 22:26:55 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 22:26:55 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: Handling inconsistent Power Domain States with Deferred Power-Off
 in Device Drivers
Thread-Topic: Handling inconsistent Power Domain States with Deferred
 Power-Off in Device Drivers
Thread-Index: AdreOYiDSGuQm4FdQ3O9zbKSmfHoPQElZYJQ
Date: Tue, 30 Jul 2024 22:26:55 +0000
Message-ID:
 <LV3PR12MB926071C5E0E23514586C4695E2B02@LV3PR12MB9260.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9260352B1289F152CD3554ACE2AB2@LV3PR12MB9260.namprd12.prod.outlook.com>
In-Reply-To:
 <LV3PR12MB9260352B1289F152CD3554ACE2AB2@LV3PR12MB9260.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|MW6PR12MB7085:EE_
x-ms-office365-filtering-correlation-id: eeec8bd0-8ddd-40c2-38a1-08dcb0e6b813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i6ptHyeXMgFoeKl7NbTXXC1ieX8FuYsuPCnk1T+GDuKcRpFr8qCatpjtvvV5?=
 =?us-ascii?Q?7fGLNsNiF2jLmATNBTnrePdP0BywQH63Ou4vt7eyyEW+gL966VuwQHLUp2hD?=
 =?us-ascii?Q?Bw/KyzVxW75ukjXMbv6M0mt9W0p14B918htf7T+Ngt4MzfjglLW6HJtt3Ft2?=
 =?us-ascii?Q?hKgbx/pc56Us+akphpJceSrzCP+uwVkHRQiic4VlgpX/2PaYyXhi0wxWPX6f?=
 =?us-ascii?Q?7QB8bsduYqoTqbL64vTaGLTV5TNOfCkEB5vNeZQsGpSv+9bx52+Y5UVLJyQ7?=
 =?us-ascii?Q?3CDtSOzPs2dO0NeT9+IK1qnyoF49Nhgqjk14cmqCrx3bKWRmGnJ4pOm2Z+b9?=
 =?us-ascii?Q?OJGNnX3ffE0smLw5xmHWKrQapW+5XG1gQ8hQ7lkUTU163ay03dgcTEa0SF8F?=
 =?us-ascii?Q?TSgKIuzYpxTv85JLu7an46pW2BFvfSkaiBHBQxocETdVE8AcmTRl4CGECvGZ?=
 =?us-ascii?Q?Sxl5nTd0Z9IbRit8OvVraXCbMfFF0yNclfBSm8/uMBhldGHw7nL4fiML+IwY?=
 =?us-ascii?Q?cJDTmZcKFSXRl3auM+rPn/MOtGwZBPybpFimOwKkB3LQvOgGVi03eWX98fje?=
 =?us-ascii?Q?xPM9FKQsXi0rfiA7bmEltz9XRE42hFVVy/eCA2vwrpdEmzxQZQDTU+gSh88/?=
 =?us-ascii?Q?tx+SLOMs4hvixgB9KUtOdYgfulF0vNggSzMySguWKAUQyCAgamMVBr/HXljT?=
 =?us-ascii?Q?f5V6FOxxxP9fltdIqWRQYLOePQMT7hqI6MT3fya4JY2206IbZQkekL851AoV?=
 =?us-ascii?Q?J6hhPw1RH/4x728uL3BBQTMGc0IsNlJXnB0jZ9/M5VKFQd/IA36pgWwaI+PM?=
 =?us-ascii?Q?kwMxgwXfxliYJrx2xQG8gggPn4lUSQVL4TVUZIYUHotX2nXV647jPbHY25fT?=
 =?us-ascii?Q?8G7gorJvNQaEtJsDTzN6uzrOvRrnvVtX0xza8JCJavSv8BrjLEHqf/fkUPUp?=
 =?us-ascii?Q?xA1bzQ1DziAsSpiulF682lgO/DVSFGClQIjIBERW0AZ4SjhE4z96u/yhDVEk?=
 =?us-ascii?Q?SIdU1cTxvleQ/S21/Qme/2rjIRV9GU6Lrld5mGpVWWtmzqNOzXOcgAGb9v3w?=
 =?us-ascii?Q?L5CylqMV1HlJtJyGVEAMqSBcogFEqx9ZCrFVCVnchYPWiC5NwiB+rEPtcWYE?=
 =?us-ascii?Q?5eM+o+8Q3wx0KMEw0tVdxrgGIHwtaiFOeIYJ4QjuliVVEc1JRrlmAlJ17VYr?=
 =?us-ascii?Q?kSXEqrZp5PJZoHFnZUhf0PaTrVeqLneRqKejmVkeQ6HKHRW9twMiJTclSZKa?=
 =?us-ascii?Q?qC5y7WFhCle+EJSOv7tJ32hYbkPGNiA44VJ42O0gsS7ZUR73rco9HK0dXNTa?=
 =?us-ascii?Q?P9OG80Sfi1XbUf59MMGJwqGi3XUs5I+ecIMYSOtksDvHgqTJ7+LByuvZqTNE?=
 =?us-ascii?Q?2w4yBCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?akz/sK33wTN0ssPnDT5aetpob2TyEvR0D2ZnjuUnxEjh8VysF0O9Gw2971Ph?=
 =?us-ascii?Q?0sXaTY86hNTXcfBwsZfI1QUnMZk5Slj//LvuhWGFLi3z9v5s8X6yIP32+PfD?=
 =?us-ascii?Q?fU73HiG1+NZlQUvS9qSeox6786AfymvozVqFDT0vAJ5iFerrvrhjpPvvxKvQ?=
 =?us-ascii?Q?AOrX7fW5ebDSRjv8Y8bn9t0UjpxUMl60GCZMYXsxw+A7SSat6gB132pYYbnl?=
 =?us-ascii?Q?/vvMdfruPafN/ZPrhcaFnGH7IPpnD+QBBb/x+zphIPqy40+x6XCztBT2NPZb?=
 =?us-ascii?Q?v+ieE9kAEGnOilhNVLABYrN5LvqD9a8s7ULUf+Kw3wU3MkvwZ7XAXh44hm2J?=
 =?us-ascii?Q?kOHdPoYW2mChENvvryZ0fLA/cbkBySBrkaGWvaOd2YwsB0dluVrrN+84IdnP?=
 =?us-ascii?Q?YknOethO3g5uIu52fe8FLrdjUj1L1AF9zFqbLn83SQV1x7mUvBSP6fHWXTe3?=
 =?us-ascii?Q?dTkoDC+c0Ip+EjeeAjMIte4lrZil83v8e2UzJ/6WMMTIzCF7sSDK6FtFHaYP?=
 =?us-ascii?Q?S28HkyAAalZZqGG5febANDIGno/eIfXJ7reUnTlAWu/nWwSVjB7f2/RJXRsS?=
 =?us-ascii?Q?B6v+xmp4L7sWCwk5HGK9ed1hoX9J6caY+BRrRfnsbf9/OxK89tUlW/X6MyOo?=
 =?us-ascii?Q?aRQZqwe7uzXkYrF0qnQuTTBVqTSLDv+jQq3EudG0Z3ThgcwpVXm/8tNW0lM4?=
 =?us-ascii?Q?VEeyr0dXNRK+gK/1ENYUSOBbBFKeaoE9BKpLAhtBx8ZZDhifMBTw5V8ck67s?=
 =?us-ascii?Q?IsV9xvVrIvocSzFpB8VeWXtqfu4VJWC0AcdnCLXOZZZ+UAGdP4Yt2afo6Vfr?=
 =?us-ascii?Q?dYdQBeiY6DesxeaEhaBg95xL9eteXXhY7lfEpRrrm047S0V7bTD1FrHfc/Vt?=
 =?us-ascii?Q?vXuLhj4f143O2jAvS85d+tkW1lkW5WAFIb0AGBjutwG/NvLUxU1fzvSL58F+?=
 =?us-ascii?Q?41snjObkxo9bFUd6UY6RwWxAuoLNZrZL9Ktfh2Os3Hau+/bB2lJ7zNsJ3XGr?=
 =?us-ascii?Q?/etRkdbD5rD1XthooEEz/d/KwpWvrMmvDEOLCmAC3ija//JluK00DSWUS8wb?=
 =?us-ascii?Q?NcIMH/xENJ82T8EXXdh/NHYSs7uaCV0yhhqW+BnO+rxy/jhIjcwu3TedCUwv?=
 =?us-ascii?Q?7rBwaBw4z4QGqjTvy5/7eTCk3dt2gZMUQFKtu9o1Skcz1qujvQmKVsE6l3rY?=
 =?us-ascii?Q?/DPOEXm6Toqs+I6ZnC4SgczAIlrIWbziIsQzpA66ZsH8Jayf/2YkAVBV/BoD?=
 =?us-ascii?Q?cny3WMRIlunbWP4rRovD/uotsvHbPf62jLTd4lsbJ/EvYNCVJE+G8MBuwIry?=
 =?us-ascii?Q?RjprTfIT7E5fKGOUCn/BFZOe10M9YMWRFcAp4UDsFj6YAVHINhWAaL+4EZdQ?=
 =?us-ascii?Q?lIC74k7bBy3c8zGXfljE1/UgvC/HZGlwux19AS+X8RoDQfXfWlwPvWe3IHLj?=
 =?us-ascii?Q?Zr6b1pQqyIpB0N641IYcNTV5BJCdz5Xp3piaECAY2a5xu5IkC1DDTPFzFHVm?=
 =?us-ascii?Q?Y1R3v3p+wNRjMHtX2F2SVt5H1YfuCN1Gusde0IxPnkCM8FEwG3J4djiOdkcY?=
 =?us-ascii?Q?wlKdovbCAigkg/Y6EeQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eeec8bd0-8ddd-40c2-38a1-08dcb0e6b813
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 22:26:55.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3d7XRFpcKr1tWGWzbmQO1/gTp05txU2r2x/pRP7x69soa4/eNTx7IE0KgWFqEixf9N+VoDFsEwy+sr1k3z57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

Bumping the query with the maintainers list for this file/module. Your resp=
onse to this question would be greatly appreciated.

Thanks,
Senthil

> -----Original Message-----
> From: Thangaraj, Senthil Nathan
> Sent: Wednesday, July 24, 2024 7:27 PM
> To: linux-pm@vger.kernel.org
> Subject: Handling inconsistent Power Domain States with Deferred Power-Of=
f
> in Device Drivers
>=20
> Hello everyone,
>=20
> I'm facing a challenge with power management in the Linux kernel, involvi=
ng
> the AMBA bus driver and the UART PL011 driver.
>=20
> ### Scenario:
> The issue occurs with a UART device, where two drivers are involved:
> Driver 1: AMBA bus driver (`drivers/amba/bus.c`) Driver 2: UART PL011 dri=
ver
> (`drivers/tty/serial/amba-pl011.c`)
>=20
> Here's the sequence of events:
> 1. Driver 1 (AMBA bus driver) attaches the UART device to read the periph=
eral-
> id. This triggers the GenPD to power on the device (`genpd->status =3D
> GENPD_STATE_ON`). The attach happens at [line
> 141](https://git.kernel.org/pub/scm/linux...c?h=3Dv6.10#n141) in the AMBA
> bus driver.
> 2. Driver 1 then detaches the device, scheduling a power-off operation us=
ing
> `genpd_queue_power_off_work(pd);`. The device's power-off is deferred, an=
d
> the status is not immediately set to `GENPD_STATE_OFF`. The detach happen=
s
> at [line 203](https://git.kernel.org/pub/scm/linux...c?h=3Dv6.10#n203).
> 3. Before the deferred power-off occurs, **Driver 2 (UART PL011 driver)**
> attaches to the UART device. GenPD finds `genpd->status` is set to
> `GENPD_STATE_ON`, assuming the device is powered on and therefore does
> not power it on again.
> 4. Eventually, the deferred power-off is executed, setting `genpd->status=
 =3D
> GENPD_STATE_OFF`, and the device is powered down.
>=20
> This creates an inconsistency: UART-Driver assumes the device is on, but =
it is
> actually powered off after the deferred operation, potentially leading to
> malfunctioning.
>=20
> ### Question:
> What is the best approach to resolve this issue, either by modifications =
in the
> genPD driver or through adjustments in the AMBA bus driver and UART PL011
> driver? I'm looking for solutions that ensure the power domain status
> accurately reflects the current and intended state of the device, even wh=
en
> deferred power-off operations are in play.
>=20
> Consideration I have is:
> - Introducing a transitional state (e.g., `GENPD_STATE_POWERING_OFF`) in
> the genPD driver and return error to UART-Driver when the UART-Driver try=
 to
> attach and let the UART-Driver return -EPROBE_DEFER to the kernel, so the
> Kernel will have an opportunity to come back and probe again.
>=20
> I would appreciate any guidance or best practices from the community on
> managing such scenarios, especially any existing mechanisms in the Linux
> kernel that can help.
>=20
> Thank you!


