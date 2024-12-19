Return-Path: <linux-pm+bounces-19474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6F9F73AE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 05:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A02F18922C3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 04:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC12149DF4;
	Thu, 19 Dec 2024 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAFu9XDB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF33C0C;
	Thu, 19 Dec 2024 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582160; cv=fail; b=Ty52N6Zqcdr9wmvzpZ1Jbguin44k6kxmRa46iWhgL95sa5WqLX6oSkNEPzEGxbpvy4k34Mz90THjv6zNCTzDhVLzFIhFHadpIJCzHd0A3SfXJlX+0YbFC5MGwE08AdYZdM3yt/Jy6o1f8C2gdbcxjrGyc/LYF2RCsgrYzEs40/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582160; c=relaxed/simple;
	bh=G4KDz+smiVE/rZIR9B9Xhbr0Vt2DWM66fVtPXaUUZo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBMcnmw2exkOsgIslDKHdATw9q+Zmzs0odpt8gWHyps5LTIHgOx0GoY48gmUTWFKeSwbXiHpubJravjJb3DLszyP2CuHmuNpbthzlgF29Fg8KF7yVMDu3lMebhRTBT+CWCzsNuO4xjefW8qbjlxUQ3O6l4y9jgrHrIH+4PzlP0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAFu9XDB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMc4URVD8qCN8hHOHE8gWras4TuqubaAjcWGybNlGOMBZMIlzW5yhtOkjhBT+wRv7JqJmkembW5Sq5pI/h5UYVotjmgtEdZkH4REIoidl3dkhayTTQhDMO7CwMEo/MtiywWxhJAIb1D8iQahG5tWYnDIaF12ObZ5t+KkTrM0aGo6OVNbLBZKSNwFlGBSQuoSobJu2b2DakL+Bfldw4S6Fql/NAx9bbpboARULOGDfuVXfmz5fZzIARu78x2564F0cL8pLSk9z/VQ3W4nne8/fWIw+zwkbZ2KYQHWtBB5sszibX0Re/kVVWSAdGAB7ej8qi8wv+wTYz9hhrYoL0hbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwlWWnXAMT9XVIlHwKnlrCdcF9W4vmolXWA7ZPKlco0=;
 b=wCXVeKt8qZuQGba6/0n5dEWjWltlkbQNxb8R5YIwtQTHqdsXDWCtQfQzQVHga5B/Ae2Fa6iI0qQhZBqmr20pxzMvd9so3qa3oCb9WRABRVAS9YCEWw1+rcSHVfROhnwM7e5n0EBdxQwf/AfIXLJKRZOG/3nzW9Vy7Tp5mRatIMs4HiXOx8z9yjUntZJtXrib4MgEpVUU0LTkNyZuI19+9VucMwPBuKEc+m0n6NJR+I8KYwCJYNvFUJVNSIHuSDyG7rcGBZxNablO54pnokZ5GthSKUwcwNdsK20Y6yDHSMrCB5+yc2F3JHgyzcsBRq0ZujZ4ZXQl3VUQGx7Ds9YtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwlWWnXAMT9XVIlHwKnlrCdcF9W4vmolXWA7ZPKlco0=;
 b=RAFu9XDBaTc4845Q6cqkql+HxdzeclhBJdadymqtnIUA/ocztvk4ozep/6VX6NS22dz8whRJgnugC9Znx0ZMr6Tq+5V2erv3JYKpBuY05hg9X/qg+vhGyzalM/7VF1IBPh0u6gyWEvver/Cw6wHq5r+8JG75BxMiMp9s+bVuuPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 04:22:36 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 04:22:36 +0000
Date: Thu, 19 Dec 2024 09:52:26 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
Message-ID: <Z2Ofggrpkv/rxlJp@BLRRASHENOY1.amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
 <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
 <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
 <cfcbf8a4-7254-438a-8b0c-29807e07ed90@amd.com>
 <a3ef3276-a7d9-41eb-8307-cb0e61eed0b0@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3ef3276-a7d9-41eb-8307-cb0e61eed0b0@amd.com>
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 126f30a8-1da2-4436-165e-08dd1fe4c437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?pXT3QJN8mLCrL3lqXx/DOy9haG7/H8MbfZIR0559eB1vanepjqAXkMis33?=
 =?iso-8859-1?Q?1PAKKCv6HFLbcn8yzgmbhBoSs+YyzVKbzirivjJicJaQny0MWkUWtTenpD?=
 =?iso-8859-1?Q?qIyFVYcdPzvvQMZtQpYh8EEDeylN2ntBFWiguq+mU9XSS+OxNccWehNp18?=
 =?iso-8859-1?Q?iUU+gvVgQa0KvlgpuSsO/XQZGtaovyaC7t3cc74JEF9uBiEtoZEnzQRqVr?=
 =?iso-8859-1?Q?5wy3cD48OejPSicQHZEB7XuBxN5f+kwlDiDTPLtwvdGa3Q7gDFAK1Vn/l+?=
 =?iso-8859-1?Q?HYkSYwsLcyYEepYSP4/a/5nSNR+IZnYrnd37EqD6toBI0zE4GW7a6qmezj?=
 =?iso-8859-1?Q?6Be61Il64H6AWu6qLLHfcOqQTzcPq4Pq/eQN6j54cjSY3CmN42+/qxFVYy?=
 =?iso-8859-1?Q?+w4ovFdm68TziGsTbGrrY8OqKGhQ6ZsGzFsKgwBfS9NDSpK0bOhm201pTA?=
 =?iso-8859-1?Q?PGwkJ47TvKuDTEMEiy7IiPU+LEE7ruypkDWffZeaz7xnulHSafymI7a7y9?=
 =?iso-8859-1?Q?ai9+rQhbd17w2vf6IxL7OcWgHO9/kDCceI2CwdCIGw65AebejbWyf6KFok?=
 =?iso-8859-1?Q?G0HnvxEoz+ZQjVgYIYxV7Zy4YI1utjYWCny1tlHshI0KYp9RZkaE7rEtZ9?=
 =?iso-8859-1?Q?MfsJhQ6R+YsVhrgd+hfg/ruXqBYazRPAJIKamUAc9avJzur0us520uYypZ?=
 =?iso-8859-1?Q?Zial94d17Wsa+1GbDNyb8R5wRJlEM00aE+rvM9t7i0mCV8ZverM8DPrjfE?=
 =?iso-8859-1?Q?3jvag4AkSOOxiNwNePouYTcQATvbcabKdu5RJ4FD1+JvwpL/4a0jkHCw2O?=
 =?iso-8859-1?Q?62BDNLK/P9LHLycisp7zFI8OYIo+JL/5dshA9bjcP57vqBvZA2nvi5mhld?=
 =?iso-8859-1?Q?C76wuEzARktJfWhOd4ki/VXJfdjwJQPctGrzt9E8fThCGyhBOyTZYq1WnP?=
 =?iso-8859-1?Q?EqpOxcpnQBM1ftuRJoPDVl6l8Rhxp1AO8W2mxcxp51FuWbJc5ltqA11KAZ?=
 =?iso-8859-1?Q?ItpgOYOQtB/ECkt+DA2NiDklO86XblBwOBrah+pX+GM6rjz8NzpzgtPLhE?=
 =?iso-8859-1?Q?+USD+usN2peZGnbTvPtz4FCapD1vCWlJUEmaoG/mLThxbeFWHXQM/nxzan?=
 =?iso-8859-1?Q?M7olR0s5bu5Fr8cjKpYmUDQCTYDsUMGQkcjjFKUfdHZhqS6skdAzNzMfpj?=
 =?iso-8859-1?Q?29fO+4K9zRNu42qBExIex6inRYGv0jtBCmCBexnxsCRm7qRJGAHgJhxzaJ?=
 =?iso-8859-1?Q?yB+my+dsjeIXiVs/IRNEaAeiQjiF36H91Cn9hIq8C+rbuznScJKSTd9NQu?=
 =?iso-8859-1?Q?xwuQm7pzSJLiEBWGpfjkiVLSgtNw6Ptes24GY58hEBuJXV1XdXPiPsuezk?=
 =?iso-8859-1?Q?/XdoVB3lO7Uf8+oqd+4H1fZY4oGw2ACeKKWyM/vbtoyxlZ7rbvE4CFSauv?=
 =?iso-8859-1?Q?7JJSW45973PhNybH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CTjiPBpLRaFdkG/FFNN7ERJPFdorqQW8R2233JxmXRciZDg0M+YzHuksTj?=
 =?iso-8859-1?Q?z/e0HuQUPBMV8MBl8tlO/VYEb9+ZSR0IiehOw0yVjFED4hU1/LDcwjY+pp?=
 =?iso-8859-1?Q?h1f13CmVYd8jeb+qxNuebpHoWrzdz0Ss+4jfBAPtdIFY/RvsNjpU0MQjw/?=
 =?iso-8859-1?Q?O/OGTY365Kf0hR/xeOHfFVZ1VBADC7R/HQI7ZF7k/iH3X8ADsA4GnIx8Ow?=
 =?iso-8859-1?Q?YtgydYsWBpUl9fiezLUPG3HwvrZClKPchAbs05Oo5n9sr4tixgrF4eA7OS?=
 =?iso-8859-1?Q?eM8iIdMmkMa7YSvvzPMg9DoBQ+JvRDIad/uJbMsAi0xP3oQ+cnEbTrrRzF?=
 =?iso-8859-1?Q?6o5hNUA4qhG+GV2serkFEVq6LiKfWtk2zbVOCkb6ttMKQwtgzvrXpCbCqW?=
 =?iso-8859-1?Q?Md/Bkal9jIOPdp3VQqJq6AUvaU3UMXSOcFU0Q/httA2U9mEPnDlh8aWsXo?=
 =?iso-8859-1?Q?qDThLG9yJl8rh85PxmUY4aO5p9DtRY7b+aiF3X3wXU/Ltiv44KdW/UJPvK?=
 =?iso-8859-1?Q?QEX3jgmp2kiLhFlpnnoHfrq4xe2ytI3MJhlYWaqCM9Y0a3DvM3747ct3M9?=
 =?iso-8859-1?Q?VNLAlRdqB83D8LQZBtKfW1BFbTqgTdgPwVXVrMgL2xz3QQ5Z8lz72rGL65?=
 =?iso-8859-1?Q?6ivPvQq9hQQhQkLnTJMpHYz7ncHN1tpOQP3m2i+irl8Zf9hR2ESjA4muZW?=
 =?iso-8859-1?Q?BO7V/epmTCIZjGBvSTPIv2dvQlh0GZdTfkBxOeo+r4Z/2cDdk+KOvflRcx?=
 =?iso-8859-1?Q?QULYB8mdRiIxskhlkfq3/HWdNI6/B57XbRDtkMpOOkGL1JZPvWiSyso7Ww?=
 =?iso-8859-1?Q?aq1B6iTf5HR9+a74GGHnzTqHmpTJk8orqLuyQ3VL//s6UnhNBgThWRubkv?=
 =?iso-8859-1?Q?ewVSGQKABYEE3aBzUva27XZ6ig7P8nc6gbNBMD9/vUxpCLFUaCPxRtmarv?=
 =?iso-8859-1?Q?WPM74xS3M7Lm/0Mgj7+/GcrIPIWufibm7t9jZxkenjwLc1rHx8oxQSaEf+?=
 =?iso-8859-1?Q?9AT0LDYCtaZVM14uTJm5uto+ciNrkcwN0zsZHpicG89+0mtQ0WQ5utdT+P?=
 =?iso-8859-1?Q?YXiolAaTYhQ2lK7ovc4G2VihZURN+Lh6q9xQF7VL4Dhm9olhoVgZP4RGhM?=
 =?iso-8859-1?Q?RzVoJ2Y0K2vUbVcl/4SBQjjMn0gs7bRp1gnh3CfqO8Gp3zW1iqbeWEYsFJ?=
 =?iso-8859-1?Q?LaC1G2N81My9QwgAx2+ZFLSNVlan9oq5lNvK1yRowK12UmfKK0elK6BFMP?=
 =?iso-8859-1?Q?yH8ARQyoUTYCmnFrR8N4S0BoFFVmuwL8W1S/6bmZZverH9+TZpQxuKQ+Vj?=
 =?iso-8859-1?Q?sUAN9MxfEpqqKgBNssSqNeCSlgVW53hYVHttQ7EMHkC/ws0LomWr68GJrj?=
 =?iso-8859-1?Q?i2EpqpBI/WxzWrXS6RugBd499IIS7UILcQG4/vbZj2fz2OVPwaZyJPb9ry?=
 =?iso-8859-1?Q?sEKdOMS+Y41KwQqVUHfxyQzdZ/X4i7D0Kz4OcGrUzlJtKSZCowHRp8j5Z1?=
 =?iso-8859-1?Q?/5APF7z/15VfHASRUe00jciA9DjzlSF4lYhWILLg17FuQucfIftE3n3+8A?=
 =?iso-8859-1?Q?lAHsvXdL5toWGFx9qs5NokcmpsMINa12iSIfatJLuBdr6vWQkNVOuJxSPh?=
 =?iso-8859-1?Q?MIdZqOw59KqU3nLHOz4wk6puDbnJl5jdnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f30a8-1da2-4436-165e-08dd1fe4c437
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 04:22:36.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtLmvnLbppyKfZipDSL9IdNsLZI/hw/TnluysGnajZDb9+CPzx/qXY3RZ5JRozdvUcPc8NrxJgpi6JK3j8QWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

On Tue, Dec 17, 2024 at 01:44:47PM -0600, Mario Limonciello wrote:
[..snip..]


> > > > > > 
> > > > > > Please let me know your thoughts on this.
> > > > > > 
> > > > > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > > > > index d7b1de97727a..1ac34e3f1fc5 100644
> > > > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > > > @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
> > > > > >            if (min_perf < lowest_nonlinear_perf)
> > > > > >                    min_perf = lowest_nonlinear_perf;
> > > > here^^^
> > > > > > 
> > > > > > -       max_perf = cap_perf;
> > > > > > +       max_perf = cpudata->max_limit_perf;
> > > > > >            if (max_perf < min_perf)
> > > > > >                    max_perf = min_perf;
> > > > > 
> > > > > With this change I think you can also drop the comparison afterwards, as an optimization right?
> > > > 
> > > > Umm I think it is possible that scaling_max_freq is set to a value lower than
> > > > lowest_nonlinear_freq in that case this if condition would be needed (as min_perf
> > > > is being lower bounded at lowest_nonlinear_freq at the location highlighted above).
> > > > I would be okay with keeping this check in.
> > > 
> > > Well this feels like a bigger problem actually - why is it forcefully bounded at lowest nonlinear freq?  Performance is going to be awful at that level
> > 
> > Actually this wont necessarily deteriorate the performance, as we are just restricting
> > the min_perf to not go below lowest_nonlinear level. So we are actually ensuring that
> > the schedutil doesnt select a des_perf below lowest_nonlinear_perf.
> > 
> > (hence why commit 5d9a354cf839a ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq") was done),
> 
> Sorry re-reading I didn't get my thought out properly, I meant to say
> performance is going to be bad BELOW that level.  We're in total agreement
> here.
> 
> > > 
> > > but shouldn't we "let" people go below that in passive and guided?  We do for active.
> > 
> > Yes I agree, we should allow the user to set min limit in the entire frequency range,
> > I thought there would've been some reason for restricting this. But I dont see any
> > reasoning for this in the blamed commit log as well. I think one reason would be that
> > below lowest_nonlinear_freq we dont get real power savings. And schedutil might dip
> > into this lower inefficient range if we dont force bound it.

If I were to venture a guess, the real reason could to be have been to
gain parity with acpi_cpufreq + schedutil where the lowest frequency
would not go below P2. Nonlinear frequency was picked as a lower limit
because it approximated that. It may have been as simple as that so
that the out-of-box behavior with the schedutil governor wasn't
suboptimal.

However after Dhananjay's patches where the min_perf is set to
lowest_non_linear_perf by default, I don't think an additional capping
of min_perf is needed.

--
Thanks and Regards
gautham.

