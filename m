Return-Path: <linux-pm+bounces-16340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF199ADB1C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 06:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB301F2208A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415916EBED;
	Thu, 24 Oct 2024 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u/4sXqWb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342932C8E;
	Thu, 24 Oct 2024 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745301; cv=fail; b=Sm2Ij7uCfsBFfTwjXhvWNvDUYvwxGBIHW3uRL2ksm5dGW0Z+7MI4W7VugAOKCsxwUgeeQ90R5UfXb3eNeMZm0GUtVKgGk6nTDmV8Veeidjj/CCzAq2vLV8LZjXFx2UgjpFkSW1/N4ve2X0oVsRajjVEumOBYI8jnOA8otQ0bzd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745301; c=relaxed/simple;
	bh=rtO2piOItVl1umlJmcQyqY2IbubhwX3aVuV1qRrld5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Trq0NisM5b2dF4FMbvtzOScWltiBo0gsdQ0dkW7parj5QReRynRHa9wRshGxUPuzzPtzdkX5BjQfj9pnxL6ehF72fcVWa/vaSaroo2qe73Zj/Hvvljlrx5vBsCNhHVUrp9s59GUw5OHIQMODCvtW8HWnDOQSizf9UQOUKHWLrCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u/4sXqWb; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErA9F5zqX5AHGVtH9Airx9j6RUKW4v0r1+74wyeAcy5VYpG4laHaYyfPt8CwQTA+CVxdfvWWMhn9vkzLnkr5/msTA0IAxhfDnAwwGy7oiarRd9gtNNq13iN4fx0Ks+WLHNYSoRu7U+hfdGrU5P6oXqciCo2Wn208j4caWRh2zlbR27hARVgPhWTMDwwW3aamss3s4sJzk6R6qzK0yVpQgcoU3752S6A+Y5j8+6lvu12ptp5CR0+CPb91+bJa/GArm9qKszn28PTTzgj41yER6DTel+BjvINNf13wif9Q0HGfx9cjuIQOMF8R2+yEgM8r8FStmGpusa6zr+jHu9PUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEj2ZH1KTn2uQfHIQKQw3hf7DWPrOeTjhLmf8b3l9yY=;
 b=D8/BW9oMnBJobuvLK+SF2+b5bawweqKJMIMpDs+q91x9FSoDVV7J3oUBMZFG2fOl0vAaJDkjhBdh7u7crZDczFA7DmZyF9jy6Dj74tofm9OGlebFpTA93EKqxUa6GtGRwU5p/XGQmLB4M2vBMDnlWMeSCkES3HnsleWIsaw3XMxMjC1qPQmwwH4Pw0o0d/g6xUUyiST5oc9fFT2T2GjsAc9QuGgrB7ZsYsLzg1JUd9AaOUbl3mocjdATuSKGYx0hoPKNcVVeQoVLpU9zG98dgiLQ9mZUROOpkqanlBpzo0MsYVjqhbPHBfFeQa5NVV3CK2eRxPQUwdMUNPk8UmN6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEj2ZH1KTn2uQfHIQKQw3hf7DWPrOeTjhLmf8b3l9yY=;
 b=u/4sXqWbktTdtygbQ8LwCQllqvLlXc+DuxjFyBQ2Cv1z0LNBX6OElYT5yAIMTu4Smu/scLjcnlrBeDtl1Vk3zJMmrEkVXpJipa+R5R2zlDYRNikuxuJAONcQITeWRGdTiW+gT9oe0M+G02l76n6zydj2m/LMFi6viCUHObqoYko=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 04:48:10 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 04:48:09 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: RE: [PATCH 1/4] cpufreq/amd-pstate: Rename functions that enable CPPC
Thread-Topic: [PATCH 1/4] cpufreq/amd-pstate: Rename functions that enable
 CPPC
Thread-Index: AQHbJTV0yADYwjhPIE6UJRRB0uayY7KVVOjQ
Date: Thu, 24 Oct 2024 04:48:09 +0000
Message-ID:
 <CYYPR12MB8655FA3363A895490E66F3A09C4E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
 <20241023102108.5980-2-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241023102108.5980-2-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daa71f44-07a5-4e77-91b6-5ad54bc47db1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-24T04:46:16Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB6445:EE_
x-ms-office365-filtering-correlation-id: 6cdb6245-f5cf-497b-cbec-08dcf3e70f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gYdpggT0VraIRdYIPoUXKJ0On83/w/4ecsYxnY/k6+XQe+OGll8ZdfQQxdMw?=
 =?us-ascii?Q?vz34040paivzIwPI4Q75jwQEKWwpXynR1U1eA3vR1Jkk2HXeL5OQiaZQ1nEE?=
 =?us-ascii?Q?vUN83dLcOSE195VE+2Oohd4kYsIPuNKu3fZioC8fs6ihK7YyhsdqD4TNUOhC?=
 =?us-ascii?Q?n1bM0v+nl3FX1zwk54LyrDgzdLUK3eO1gDMHQtY4g0p7lFRXs4t/rj1ml/NH?=
 =?us-ascii?Q?4Els4HQkxdh13++RB3EoFdSIA8xrPk8T92W7JMB7/po1LppGM/nujwZgZu2E?=
 =?us-ascii?Q?byGA34xeq2NMvtKLjiU8qlPLp+mJxWO0TkRMp/a6UE4e4NpiCIGAFVO39s6q?=
 =?us-ascii?Q?vyOk6+o4ZsOvi/SwBqLIYcr94oZQQ1w2R3vr8pNEfIMc3QuUA3zrq0mMj61N?=
 =?us-ascii?Q?QTvCvgYPstNMkdEPdk9avPIxKuPuBziy/W7GPSb70aBtWdzFYfRopk+e9eB4?=
 =?us-ascii?Q?QIQMRftTPw+vb8wKj6f7Nmsv6PQ/uY6jYnggDTtlOeijXKlBcOMvQuuf9rQS?=
 =?us-ascii?Q?PmfgqQvROAmWpJragg+14yTWXLZVtd81A/FzYRsb999G8SptnHCnjq6X+gSE?=
 =?us-ascii?Q?k7WHWJ7S+Xutd56LTnQ0Xg1PbOWvY1UEDqXhqf4/4+NkoalUjZpGKxCo2ZO7?=
 =?us-ascii?Q?NHXlRR+Ss0RAChJJnL1OJX2rf8krz61nYxlrEV6/RYoWs7CmeCS/4qw0wBQ/?=
 =?us-ascii?Q?W6XrUIBA3yMOTMO9N8Jwt6WnLg3EvPwJraZwF4Vur4tpqCQ7q3SUI0y7kwcE?=
 =?us-ascii?Q?EkDq/kKR0/l6z7HKc5aq8beQf3IYy4xTUhcioRUXqaPtLLpnwtSu1+JCphet?=
 =?us-ascii?Q?QrEJ+XZRjj9oG+CNcRpX8oeM8sDIsAf2oEWiJOW/JP597d8KvZJcOdq6WA81?=
 =?us-ascii?Q?JdQE8Yjowwsp5MMuiAK7UUZCnBNHbOP90u7vQWgAEVsJHrMuxZ4zk8qYFx5G?=
 =?us-ascii?Q?3TiEPQnN1x74PR6If/MBUMCjAh8Yrt9Pv912c+EKOpXGzdYAVeVbMpXtLIkP?=
 =?us-ascii?Q?rk3nk6aK4QlBwpVU5or0vRKf0tSeiTgTwagOtykFldFvuSAeVus8XJ9Bx3Jz?=
 =?us-ascii?Q?dwnpnvTDm9v//Uy2BkTU0y9iHcH+i3uJ5B2P1zQD0udIUZiTQ8zQEpb0mpkR?=
 =?us-ascii?Q?hjKbsEPUb27qHLf/G212emysnb1drXZ24Blf6N8X0J/tsdubh09qk9PuIRwv?=
 =?us-ascii?Q?Ldzse2M+SpJC/q4LcL0kXLD75jGTFVIkLc52c4XLEdRQcGRrqR+LiMwI+s6o?=
 =?us-ascii?Q?jtSLJPl36veI4RPETXYxDcBTnrf6oqlA89nCGX6GDn3b5wtfdAxohqMCdOfb?=
 =?us-ascii?Q?GPpAJy/tPEDDDOwumRK3jnoAr+aprfjDSCOso/FyZLm2VrBMVm+688fFRP/2?=
 =?us-ascii?Q?PvsWROQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dS3KB+ixXVo5AUeigNBbLPuDGv7hRnYKFIg9WP6lSiVLh8pi6PjDWK400TkQ?=
 =?us-ascii?Q?u3eiIErtL+FcLD6psSDP8l827uOTOz16EKHt4s3EthH0mwwmJdPCTk4sI4LG?=
 =?us-ascii?Q?E6EofizxE1X2mw/1UebCMtvgpWnLr0HevOdoEKMPmMD5RBcwIsK/3u7QpvoQ?=
 =?us-ascii?Q?XMij2AuUlzvz4nVkO+XVV/tR5QSOm6Arnlvdop1czprnk9J/iOk6KzdbmiCK?=
 =?us-ascii?Q?nxiNWN2cW7TD5MD0WWWDgKVAWKRZHcuQ9NL+4ZPFMIhMXEoi54b52Cu+5ezT?=
 =?us-ascii?Q?QzNcBCIHZNzuNF1UYHTOMFFshPK7JaJHw1AQ1amI11vPTykZRLEi2ELoOb//?=
 =?us-ascii?Q?A+MCzxBhSkULTyPmt5qRBV7QUncfWayaEBufCHw/UaeMwBfHwWjfpwAgYh6C?=
 =?us-ascii?Q?QNRkRe3if6w79Z5cfsssT/GD1FUpZ+FZt3OVGb/b893kh03+hT/5ipvPsI9y?=
 =?us-ascii?Q?KtiJSCfR/KJwMwWfRJ8Byg5iyG9OTf/NwWyTgUodNlNJRTjtwBcwIkW/QNbN?=
 =?us-ascii?Q?yT7rGWSod4JYgTYl48Qr4BJu1PYjxEjj6NlBzyELrn+Q8X+SA6S/gLfNcyGg?=
 =?us-ascii?Q?BS6aoESQnVc4NU87wI/BS422hQH1aTH2bqWnW4MIFDY4yNtRSkvggCdZiYrQ?=
 =?us-ascii?Q?qMWtyeLBFV36rJwGF/uPwJZssxX8l7/bjxFwiNLJcReexPFQklfxhSSZ1Z/I?=
 =?us-ascii?Q?BxPx4kp49VBtxc2zsCBfZ2TDmD+JncxnMhq+QFq3QHgFx9wXHARKzYj6VmQg?=
 =?us-ascii?Q?W6ZGno7f9v9JLrOvvDWPASIA4lVwKwD3wcownU4Hevra3kBA5htOGxXyG53x?=
 =?us-ascii?Q?9flKjmJyVI8VdNDyHBUpfwOV7o7kuxhvlUE/V8vlx2WSuJilcW/mIr25MJwr?=
 =?us-ascii?Q?/HfbPGjyI7KwI6Zv78NgqX+FcXp/9hn089JLm7TuL0yT5EQB8qDjrqSyg+Ig?=
 =?us-ascii?Q?7yoitk1GDZijIKxsI8OnqeujDBmK4GBT9NamHHxh0MxuWtGLojmN4O9WTyEk?=
 =?us-ascii?Q?o8XjtP9BRn7Cj3F839ooljiJYOTnnOLyzn1O0joCbqjiz8X6m/lFRgUdL7I7?=
 =?us-ascii?Q?Tye+/2X2FPky/4UxjWWXM5qnPO+lOmD80NJ22A1z7Zi7V1Ad8XOpT4gwsg3F?=
 =?us-ascii?Q?srgoe+NBEBYOWFMoe/ptY22duynqhBFqSfo1vDpl/6X27q1qSbhPqyIiJqPP?=
 =?us-ascii?Q?XT3d9/cJFq/CV+1h/xqF+skHaIe5mOMINb2aM2nIMHXOtQS8Pguh7V8WSpoV?=
 =?us-ascii?Q?FQIKCq0pc+iPNCVbdlnlJdI9GTdvZMl5EqnzwbIuK5L6PacnJgxBiMOP1Huc?=
 =?us-ascii?Q?iP2ZlRBjsgp12H2A/oAetSrySCkO9ZLdaIL2l+kCLpAkhLONG50KnzkHoN3+?=
 =?us-ascii?Q?o1ru4UZwzUbnOfg4NUKOhcWXDLXD/0d20y9Ih+zVsr5hXbnd1u3Mt9ZoFXzg?=
 =?us-ascii?Q?BFK0UhaJbnQxtsgkjHcTbRnf1Ouxfu6eDPvGgHLrsvTThPAN2ZlaDG02pMtN?=
 =?us-ascii?Q?nxQTceZzIwNNKMbHjpGT3aHlcNh6NWniq+uShKTQKjUJU4ucdivbI5IznQHa?=
 =?us-ascii?Q?aZu3KuGBU3K77YDSNd4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdb6245-f5cf-497b-cbec-08dcf3e70f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 04:48:09.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjEB8zJVYVAYgFTnEx+9IJCxEncKUHMzRjI9FpkgLSyz5o9BmttMIcEK+09mbVRpyfWZQfg6XzncUqL+6Zh/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>
> Sent: Wednesday, October 23, 2024 6:21 PM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
> rafael@kernel.org; viresh.kumar@linaro.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ugwekar, Dhan=
anjay
> <Dhananjay.Ugwekar@amd.com>
> Subject: [PATCH 1/4] cpufreq/amd-pstate: Rename functions that enable CPP=
C
>
> Explicitly rename functions that enable CPPC as *_cppc_*.
>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 3c14962adeb2..0b4a4d69c14d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -306,7 +306,7 @@ static int amd_pstate_set_energy_pref_index(struct
> amd_cpudata *cpudata,
>       return ret;
>  }
>
> -static inline int msr_enable(bool enable)
> +static inline int msr_cppc_enable(bool enable)
>  {
>       int ret, cpu;
>       unsigned long logical_proc_id_mask =3D 0; @@ -332,7 +332,7 @@ stati=
c
> inline int msr_enable(bool enable)
>       return 0;
>  }
>
> -static int shmem_enable(bool enable)
> +static int shmem_cppc_enable(bool enable)
>  {
>       int cpu, ret =3D 0;
>       struct cppc_perf_ctrls perf_ctrls;
> @@ -359,11 +359,11 @@ static int shmem_enable(bool enable)
>       return ret;
>  }
>
> -DEFINE_STATIC_CALL(amd_pstate_enable, msr_enable);
> +DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>
> -static inline int amd_pstate_enable(bool enable)
> +static inline int amd_pstate_cppc_enable(bool enable)
>  {
> -     return static_call(amd_pstate_enable)(enable);
> +     return static_call(amd_pstate_cppc_enable)(enable);
>  }
>
>  static int msr_init_perf(struct amd_cpudata *cpudata) @@ -1042,7 +1042,7=
 @@
> static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)  {
>       int ret;
>
> -     ret =3D amd_pstate_enable(true);
> +     ret =3D amd_pstate_cppc_enable(true);
>       if (ret)
>               pr_err("failed to enable amd-pstate during resume, return %=
d\n", ret);
>
> @@ -1053,7 +1053,7 @@ static int amd_pstate_cpu_suspend(struct
> cpufreq_policy *policy)  {
>       int ret;
>
> -     ret =3D amd_pstate_enable(false);
> +     ret =3D amd_pstate_cppc_enable(false);
>       if (ret)
>               pr_err("failed to disable amd-pstate during suspend, return=
 %d\n",
> ret);
>
> @@ -1186,7 +1186,7 @@ static ssize_t show_energy_performance_preference(
>
>  static void amd_pstate_driver_cleanup(void)  {
> -     amd_pstate_enable(false);
> +     amd_pstate_cppc_enable(false);
>       cppc_state =3D AMD_PSTATE_DISABLE;
>       current_pstate_driver =3D NULL;
>  }
> @@ -1220,7 +1220,7 @@ static int amd_pstate_register_driver(int mode)
>
>       cppc_state =3D mode;
>
> -     ret =3D amd_pstate_enable(true);
> +     ret =3D amd_pstate_cppc_enable(true);
>       if (ret) {
>               pr_err("failed to enable cppc during amd-pstate driver regi=
stration,
> return %d\n",
>                      ret);
> @@ -1599,7 +1599,7 @@ static void amd_pstate_epp_reenable(struct
> amd_cpudata *cpudata)
>       u64 value, max_perf;
>       int ret;
>
> -     ret =3D amd_pstate_enable(true);
> +     ret =3D amd_pstate_cppc_enable(true);
>       if (ret)
>               pr_err("failed to enable amd pstate during resume, return %=
d\n", ret);
>
> @@ -1686,7 +1686,7 @@ static int amd_pstate_epp_suspend(struct
> cpufreq_policy *policy)
>       cpudata->suspended =3D true;
>
>       /* disable CPPC in lowlevel firmware */
> -     ret =3D amd_pstate_enable(false);
> +     ret =3D amd_pstate_cppc_enable(false);
>       if (ret)
>               pr_err("failed to suspend, return %d\n", ret);
>
> @@ -1861,7 +1861,7 @@ static int __init amd_pstate_init(void)
>                       current_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
>       } else {
>               pr_debug("AMD CPPC shared memory based functionality is
> supported\n");
> -             static_call_update(amd_pstate_enable, shmem_enable);
> +             static_call_update(amd_pstate_cppc_enable, shmem_cppc_enabl=
e);
>               static_call_update(amd_pstate_init_perf, shmem_init_perf);
>               static_call_update(amd_pstate_update_perf, shmem_update_per=
f);
>       }
> @@ -1886,7 +1886,7 @@ static int __init amd_pstate_init(void)
>
>  global_attr_free:
>       cpufreq_unregister_driver(current_pstate_driver);
> -     amd_pstate_enable(false);
> +     amd_pstate_cppc_enable(false);
>       return ret;
>  }
>  device_initcall(amd_pstate_init);
> --
> 2.34.1

LGTM, thanks.


Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.


