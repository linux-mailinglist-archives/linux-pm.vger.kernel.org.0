Return-Path: <linux-pm+bounces-16426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57069AF81B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 05:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D5B282F34
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 03:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DCA18A95D;
	Fri, 25 Oct 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQivXHxp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB53C0B;
	Fri, 25 Oct 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826603; cv=fail; b=LXmzbKwii8HQRX3YwlReZTXGqXrJ1T5Si5mMAtm7fDA1bxCdodqmbX8YM9pUgHU2ZXhrCxQmpTKMrf7O0Z6HHmuMaEa6ig4Snyxei0Q3rXv3ef0VtoZoovg43vjp5ZnAQxV0yEmV3FVgkctAN/tatn+i07kYrtKZh17Q7baoP58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826603; c=relaxed/simple;
	bh=twlrYLRHdCG/XZMSkJs54rXteWHltBvxvlCPmIvvVow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esQYNNZHjbijVd/9gqNwD0xMAIhBHWzdBl0Gtg8oo4KJZKrfymhkReM/bLZlu0D0guk/RphcIlsFSAKpz+5mpJbhnP1agOfehovxt8MyQLcbovvarBayMCGE6RHpoMzUpWC4z+DbkfOkIUXIC3e7TTeVz33KkB/vl886NFWzpVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQivXHxp; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izAHDheIeEQWvYtfwgX4EFz5msp/suI/N06fIESaBKHSOT7xKn9SmL2hzCn/v2mURWwGJzCPdlMYz2mj45+R2Y+XQguKz1xtbbf+Iz4WCOMu4472Te8RD++6CWAYtGombeV7cp5HsPvK7YXyEa4EC4Zmcd1513TlICyNVff+fGDKn94jHE4ru+bZB7L+1U0tgHd2mGk3I4icefygIo3Lg2x/pGUmWCaj7pgbkToi3Z5BLAgc5NsvVzdd7dpqN5EeIex2IV/jifkMIydwHIlwPNy7dxCeTL0qDR7MdpE0d1juu0uiNNLaMNXgiH94V6yPYF3AuvPpk2vXK8vn6l2Izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgIqKZRFVGpXl3sdpfr1ozh0zHwRGvar0UfiLRn9COA=;
 b=PWVEFR3ZZSsYsQAYM2z4cf7z4F5QpjWlZMwIpZD310W6H1HT+9VjF4O0yqDHXivEdl4U+Qk+Y2YLi6v3QACfOJhrtqNuT74sXZCgZlR/rwWF6aWRkI4OyyCChF9XCdQQZVfpVGhzfADQGGFjdDiE2Kz47Sq2xzKI8VTND/e80cenOfweM/XfyKEGW47c4FSo+PjytdaNmdzYvYp4LZZQOU9+/0rt76JB4p1sWG9HpeaYu+bRorJ5I9j6HUQVAAxAYL+qlJg3QMFtA70jhaUX7RgUqk+KYNR2XsdWBrueLoVZgONJg+78ifF18gM7b9hmizJ9/ayAVKmY9C01xBXR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgIqKZRFVGpXl3sdpfr1ozh0zHwRGvar0UfiLRn9COA=;
 b=CQivXHxpeWACUaM3sZ3Nr5NULOJysnQ11kmT9JhucQCp8rI71k3t96qt8/kLD6v4JC8faxwQ9/efbR+sto3OHxDmLk5k8BOybEfyZya6byQx7U3Qrw0tS6QEEH1F/NucRillirilrKm3F03K4Ss3svC2vFJnUXvuGFcAiDczoCE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 03:23:17 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 03:23:17 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Nabil S. Alramli" <dev@nalramli.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "nalramli@fastly.com" <nalramli@fastly.com>, "jdamato@fastly.com"
	<jdamato@fastly.com>, "khubert@fastly.com" <khubert@fastly.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in
 passive and guided modes
Thread-Topic: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in
 passive and guided modes
Thread-Index: AQHbJnoWVtFFKyOiEkW4ULgKWOXyOLKWzRPw
Date: Fri, 25 Oct 2024 03:23:17 +0000
Message-ID:
 <CYYPR12MB8655545294DAB1B0D174B2AC9C4F2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241025010527.491605-1-dev@nalramli.com>
In-Reply-To: <20241025010527.491605-1-dev@nalramli.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=100e99ed-828e-4d58-b956-6e0b1e1dbb7a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-25T03:21:43Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BL1PR12MB5730:EE_
x-ms-office365-filtering-correlation-id: de8c22e0-4aad-4abb-6c33-08dcf4a45e68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cM2p5IeMBDw1gKgNBbVbb3YCnE3pLyM78mnxYTKbUVLMH1jRz5rEQHRynb1X?=
 =?us-ascii?Q?+KCsUTm0DYMkFb5/aD3avb/W2N5HRhv+k5gkPqYob4EhyRmeDSXK1DKIkTqT?=
 =?us-ascii?Q?mkyDK4UByYznFca2aVi8eDhBge8AYkArSAKsJEY5KxBUVsyRdbvWR0SVVX06?=
 =?us-ascii?Q?+0utNeyq3VU1pxh6aisyE6uys5rH7QWkhH4p3at/wimCxK80H6zmDvnITais?=
 =?us-ascii?Q?ykCGkV6Ny5vLZzPH1X0VZdyz67QWB0/xd+3IkF2TjuCmufme8gpcCbM/l3kq?=
 =?us-ascii?Q?9VJxXT2/vWZEY9nkh4SM5W7kSwGs/BZ/VeXCSpdHc0SyANxNyfnyXKbXffIW?=
 =?us-ascii?Q?FISOQCfempSaPKRW4Nv9l8yeTIoRORRnAkbVz9BErjc2vKKHXGLeE9QA1BAY?=
 =?us-ascii?Q?I2Ii5zn2ac6f2ovcU2MwkKMsPTP4wCXf0cVwtJkuplrvOz58vJ0rb2/bj2zX?=
 =?us-ascii?Q?xJxZoxN9yWeQP6HeTQZa3znbRrzXmlNhk4NT5PfeH4e/jKXzm7+PGDDdKcNx?=
 =?us-ascii?Q?anrxRWD0jo5dRLAlSTqOIxRK2KEbjXFLTHY1aBkMENr9IYhJjbehjddeHSDG?=
 =?us-ascii?Q?xxBCA8XjZ8Bk0dWirute6o1ZfuJQardV+gANUyYmtJnljFAHiy21mtqp5arY?=
 =?us-ascii?Q?cTZmRiYaRrKiGzKBiJ2wwQYjjEYyXSn35FfG93GOaeIzL9KKZI07dRVkl1JG?=
 =?us-ascii?Q?OZOWU/rm3dEZAmFdMzKzBhAtFo08o1EVVZqI0wvQwOie+kFA21TF9VLfWjFT?=
 =?us-ascii?Q?giQ2efE4DoTK1nfyyDy3wzxw/sk+O86wfaGTG6Qdm0MJrIQHgFWRFInEDrG7?=
 =?us-ascii?Q?AgsdyRKeC6Rz7RPpc1xklBHIGJgMbzHz+ueA5E10CUnESGBWPqQez0JgaJp3?=
 =?us-ascii?Q?fcZiBFLlXddrketfRL2/CJeY/D0GIn3bo47UPoWsP1SqmuogI8nSNpYzbvfp?=
 =?us-ascii?Q?h3p6nP8I12ZSauKbvL1xE63TOqL1oPImPmQMfDHtsL3A82LLxRVeC3tWRE2+?=
 =?us-ascii?Q?MvB2jCe8Vp6EK2s9iBdePmubx4rnNlxnNCraMMX7CsBUj7QxYx9JoTAvrcNS?=
 =?us-ascii?Q?7pLtYmu9eU05FZgk5C7Q+aQgJ7sSN7Czyx43l8NMq3kJ1roiOC4fOjAVy9A3?=
 =?us-ascii?Q?3xEUa3L+MiEFYuXdRs5pmPbEstsjnX8ytMHnhorRK6vYVVOHtg7+z9NX56xS?=
 =?us-ascii?Q?aK9nhwF+ue7STQ09hXUgEdegXRi9ZfZtzhYELvG04pK2eDScN0G+PpCjZLgz?=
 =?us-ascii?Q?zAnsEsgURiISoTLhtTzLQKQF30i4awA0U9pTA4ga/8xr/9Xi1F8J3VFYFjb5?=
 =?us-ascii?Q?eu4S1i+ALTKV5YR0zVqTkm9z1jC89vg1GOgqTamVJfuGOpFLv0Iig7HMlPcl?=
 =?us-ascii?Q?aEHsdwg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZsVUcii0n7Pnv6GrxnT1+hMnQjFXjk7J5mt3LvrNyGcvpr+AP2CE3vK8Jw9R?=
 =?us-ascii?Q?pMkBqxp9SSv61YXk2YeW/sRWDMcSh8OpP8BwIT5AkHGfmLZkupMclyqMJq3O?=
 =?us-ascii?Q?R5q/HtfM8uT1BTHnMwjC4X0oMUEfiK5WHXCZ874qVgkfBMdFgUyc8GsuYPkE?=
 =?us-ascii?Q?DahPVdtzQA78DEF2uSVY+dAf0trATjlbpuJsPoyRomQVP74Un48gaJlo1tQZ?=
 =?us-ascii?Q?nR7WVypu0eceMD7nKW2ji51yHR3N3pI4zJVTYvkvRzDFbKm2yRi3Vr8iCGl2?=
 =?us-ascii?Q?2vmHodVtmuOrNwMUwVCpl1me0xEP5Tpeij20x1wQak/zKr0XC/bivTohhXgO?=
 =?us-ascii?Q?/FUobSOgtsIje+sVLFD7rtB0VZw2I5YBASILvK17wWKzWGi4cAbIh4ZYnl6k?=
 =?us-ascii?Q?N4ldt/SaY7jQM80uYurSV79C9xnbq2Iw1uBrQejZEtuWywvi2mT9jYGGhn8d?=
 =?us-ascii?Q?XlviwY5brCWC67ONOs8eEa/35SWxrxO6rJEEJ+ykzj5cGhnph8n8cWYoBam8?=
 =?us-ascii?Q?5DGRSFTiC8I2Du7Sw6hNA9lQ6VT6x6U7kikVJPR6jZ0iaYqGv2o1YgkEA/Rj?=
 =?us-ascii?Q?6tMn+7VTR8Nd3HnalFHtxhIUGwEce1EZmTfhDHDjmfBJHXnPXtdRxEHRCNX5?=
 =?us-ascii?Q?OJT6/apEJVyXMUjpgle/Pvmp14dDZg+JzWAV01QBr5/1FJwW85J32vJyN4ge?=
 =?us-ascii?Q?VBhpQxEt+jX+Sk9IB1TB0AiqamGO+5zVVuXfLq8/zb9v0fKn8V3hrkL+Es35?=
 =?us-ascii?Q?LVEVcUBGRwFIhu0fkEKbuib9XFvN7wfVz2GegQerlBYJ9/kiEjJaRCY5gLKg?=
 =?us-ascii?Q?apkUpNUE2S2PXlc3CMi3XYx3ZDFyOXrkrcejv2KR3bReJk2V2ab5qqt5t8rU?=
 =?us-ascii?Q?/waxR0uarrjmOd6tFTLFW5RndeCKN9oWf318ixGH0+FYO/1euwfWyFaHhp3g?=
 =?us-ascii?Q?BCNEUI/UxkkWvQvCahQo0qck/mLRrfX+iBpnr7csdGhehqZ2XWUE7yVuIO45?=
 =?us-ascii?Q?iO+MgebB3nYu+4lyOYzKdnsujrZHaZemwkhv7CHLyga20Q/LWzVkQvqgufn6?=
 =?us-ascii?Q?XXp8NpKjnS9dlEWHXWzoN8IOsWjYUVzVKs9vrixWGSlCE6nlKC2vMKBbDbtM?=
 =?us-ascii?Q?QHLcv7VmuN87NgPdKVm+p/ttku1j63Boo/SOz7U9ImzCJXPcPtTdxfuFg4Ez?=
 =?us-ascii?Q?aUonSGgapPuOhV0MyU/1TaNrPHnLnvP/Q3guRsLbT0DWmZCAD8ZPAUgyuVdZ?=
 =?us-ascii?Q?oZbvhSqXFshe6IN9hpS7vZf8MxFhqFKsMplFx9r/iMUsAlUzlKZxB97fa6vq?=
 =?us-ascii?Q?vIi/LKK3mVGVoCOahhQgY7sZx0uFLOAjvz9c8hTt9DByH7GwWkCDemK+dKNT?=
 =?us-ascii?Q?lPMqGoI9SbRf+khtKkSRuiERXA2HDcZRTohlGZ7TAtOHMYoFO/BwB8nAZRZA?=
 =?us-ascii?Q?NNUj8KGFTKga1XhKiVFJPGsn44zz/6FrarTIYtzAnV/ZATOf5dwb1aFKfE9i?=
 =?us-ascii?Q?XmoVGZWaCzNxyg4BGW1TOvNlSGtoauuHOa2rj2whVzIJwtxInQ77dhjQU6C5?=
 =?us-ascii?Q?Fz1TOh4zExuA6vPnEPU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8c22e0-4aad-4abb-6c33-08dcf4a45e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:23:17.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbdOPuGc53n8mIe9XA+NBwQzNo/FnAp4f1MyFFziqmCB2Ysw9lFxqWuJ6EVygROxe0/gntiIl1lIQrzCpL8YjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Nabil S. Alramli <dev@nalramli.com>
> Sent: Friday, October 25, 2024 9:05 AM
> To: stable@vger.kernel.org
> Cc: nalramli@fastly.com; jdamato@fastly.com; khubert@fastly.com; Yuan, Pe=
rry
> <Perry.Yuan@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Nabil S. Alramli
> <dev@nalramli.com>
> Subject: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in p=
assive
> and guided modes
>
> Greetings,
>
> This is a RFC for a maintenance patch to an issue in the amd_pstate drive=
r where
> CPU frequency cannot be boosted in passive or guided modes. Without this =
patch,
> AMD machines using stable kernels are unable to get their CPU frequency b=
oosted,
> which is a significant performance issue.
>
> For example, on a host that has AMD EPYC 7662 64-Core processor without t=
his
> patch running at full CPU load:
>
> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
>   do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
>   sort | uniq -c
>
>     128 2.0 GHz
>
> And with this patch:
>
> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
>   do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
>   sort | uniq -c
>
>     128 3.3 GHz
>
> I am not sure what the correct process is for submitting patches which af=
fect only
> stable trees but not the current code base, and do not apply to the curre=
nt tree. As
> such, I am submitting this directly to stable@, but please let me know if=
 I should be
> submitting this elsewhere.
>
> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
> amd-pstate: Fix initial highest_perf value"), and exists in stable kernel=
s up until
> v6.6.51.
>
> In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
> Enable amd-pstate preferred core support"), was introduced which signific=
antly
> refactored the code. This commit cannot be ported back on its own, and wo=
uld
> require reviewing and cherry picking at least a few dozen of commits in c=
pufreq,
> amd-pstate, ACPI, CPPC.
>
> This means kernels v6.1 up until v6.6.51 are affected by this significant
> performance issue, and cannot be easily remediated.
>
> Thank you for your attention and I look forward to your response in regar=
ds to what
> the best way to proceed is for getting this important performance fix mer=
ged.
>
> Best Regards,
>
> Nabil S. Alramli (1):
>   cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
>
>  drivers/cpufreq/amd-pstate.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> --
> 2.35.1

Add Mario and Gautham for any help.

Perry.


