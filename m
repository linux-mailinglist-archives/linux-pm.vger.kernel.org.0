Return-Path: <linux-pm+bounces-9327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335490AD1D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9211F1C2149A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BEE194C66;
	Mon, 17 Jun 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kF5+P/wT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2021.outbound.protection.outlook.com [40.92.41.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552F194AD4;
	Mon, 17 Jun 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624386; cv=fail; b=S4nHB9CmcCzzdwo5t+g6lE6wuSnzrHdU3t2RaFokbJ4Cu019qsohKm5tQbNebRUcihFNoxLOB4fwU4Ie6SP8pkq6Ol1wEu4BcRHhwgQjZH2kJb+h6KSWP+VGDTBqzc0PuwTtlAhCprwCiZBguV/eFYW9+RzNBwitBFTdbiQTQGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624386; c=relaxed/simple;
	bh=EPOX79hYd2DB1kv84Wq4nmWCOsucOvSwVeF8QArjkoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lG5sNm8uaWwCPVeWZhNOxVpLPIz2X8cw7Y4gLud0RbEc2QWM8rvICzVfZ83W5sZJEdQLz7xwDa/pTvXzWJeOev1DR1ZzwJsGx8ebYbuEPLZAUXQyRPm/6FrHPIK37CxPzh6MQDbSX7EBePjWYeO1p8/b5HVZLZQlxvApd7sLgAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kF5+P/wT; arc=fail smtp.client-ip=40.92.41.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/NsX4PcK8rQMs3i21ecZPB8UEwCmjy3mQNwc9yOZMN9cBoiv3xj+v7xePsuHBKuqrT+jCAPUiZEDOpGZdKJxxNUZK3BepBCKpUeZepno6KLrKB3DDUgwc4i8DusaLkIlckOFMgbmv3iAbNtxmX7IEcLtEyNHax3cgHCLtPMzz+TuzfDlUy7L1zGwWcCLE8U9I58nzP/Kbv3gsNQuvDQvQoih/Otr9eFWqJVuahO/GKSB+Pzb59FQ9lPWDo5bXc6fGmN1jxjZaxY5yc8g3hITIl+MUDYs+q6le2YFzLowpuoJnHAkwSLKb0J36N8/SqrjSsKHBK9luvApe73fqhewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBLNLVyPoh8hE6Rn8rIX37gagepiFNxe7NLzmNC07UM=;
 b=mEwaMZP9uD9s07kL8v2PquMhxX/50ZmLiQ/7AL3aCezUoO6X/MLTR9bcaqq4pBrLuevQXIJU4bhCaywQLpjjNa3xNZ3+uB3+5mlZFzOi+7NbucYm6eu9f0YlaEMtmEnARcdVA7iusA7wbbm4emhrr1hoyuamcG1L7Fa5Lp8bUomOZIrCuIwl0AKJbWRoxr75QomV77RiVgCLfRErK/YX8AksO8lY1WLPGhnAPDyATUSFu2D6FNzO7He6Q27dme6sVJxmhMf3n2WCAX5QooTaPq6vIlJn0NC3e6jYZbghH1cICLreAqNTLVoAqFqNZZnH2iJTRfxnvd1Znx1OCofKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBLNLVyPoh8hE6Rn8rIX37gagepiFNxe7NLzmNC07UM=;
 b=kF5+P/wTfRamL1CuMCrrgEgaEIdmk15WI0XIGFnHRoxva5NFt/1zCIo1+EPjNOzJxh6xRVALhh+XqiWne0iK4wIM955//bp8N4Mql6L6UfQmzTKp0WHI/RdKgZt9lfmnB4GCv7HlakRZcRbtEiKVbVzYIgr59kABYwU/FZKIaL8AIcizMjwjXggk78v99t7DD/z7fxYYtwXZ3kMt0WCvjwFtoVlcAdUKbwCDg1sqsI/LM6l7jOk4YA020yMtCmoQFcXyBlVgHYbIEtXyyoU2nN8kDV8dl3k/PFugEIfFzi97qgUVUUB8sMqOR3OolFgOKy/Wq/6OJEQJVTwCS2w/zg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BL1PR20MB4609.namprd20.prod.outlook.com (2603:10b6:208:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 11:39:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 11:39:41 +0000
Date: Mon, 17 Jun 2024 19:35:23 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <IA1PR20MB4953143BAB9D9C82799F9C14BBCD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42187EC277384F84A3126F0DD7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB4953FE4721CA7DFB617282BBBBFA2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953FE4721CA7DFB617282BBBBFA2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [phNkvOyqhwK6kYwuZscN9nF08Y/9Bb2OKZCuOmJXiJE=]
X-ClientProxiedBy: TYXPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:403:a::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <h2zxewidgia7j56iflttiyk2ciwuhucdr5mtstyuceux2tcz6m@uksqfdcys6zt>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BL1PR20MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e996fcb-4545-427a-5fd4-08dc8ec22d2f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	YC/Q7H2asYpZMD5riI5T/mGOnGSwXPrX6/9xm4C5UnDhFrUAm1I7Zyt+z7hJ+aynJ0Y/I0Xz8KP03+Do5FtvJz3Y2WcetvXdRqufxQz62aTN0QJ5/k99L3G4DFFkW+2Oq6MEXIcrwk6SAvNEeYyrihKZb22jsZvz1YX6RYi4GEkjo03HIMWtTZUNC/AKBBBNbo7nHEHxCo8JAehVkRuAmJEUpfhTOzU9pdF7SEqOne8AAvgkueZAffCPhSp8xev6yyZwfex2xP7tgET2soNT2QRcWh74FJOF7JM76a1ZIKZkcD+0HRQOZ574Mw4bJtwIlwCKEWwcppvuhyHsYy5dE2wrExc6MvcamvN324LyqCUGtP8GwWA0bm7ANH4ipNUdOczgSMzPMALbvBqKvzZQyd1hEETTem12d/wMNdn3DTqVuXCWazDAMo6BcvIUP/E7jHisb5Fhg3zyu6WL6VL6FvImC34CbCqhcgJwRq+cGYmI/P1fDlzndQXgjxt1R/sjfTsyb6kDCu/KWmSJW8sINV46yAyS7mOJZ+9wfdToW6L+JCAJlG6ypMIHkwaNgfRS/73vwRyNE0Z47nX/rVqP6xLi9y61RRLJ738SG+aNy+M=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7dZMHjhy23sQH3hdh+WFhq7+jrG1Fsnlvfdeiu2xVYcqvcg5Sr/AcKdzkI3U?=
 =?us-ascii?Q?5eAJv6+WfhnCS496dpQTSWpkMs7Cm/uQxaQBnVzOKF7oIS7Yok1wKa2D9fzz?=
 =?us-ascii?Q?B53jvW/Gt2VGrfINMGhAf5gXAeVASwwjh4XQpC13JjW6FwfDN6ZSWHLnKS/C?=
 =?us-ascii?Q?daw3iUfm+qka4/PAIRWk0ETz7jiNh760bVGRdqFZnSSLQxrC/C4BJ0N0wUwh?=
 =?us-ascii?Q?m8EVOv92iu8N5Z+TsPunLNsBRWE6obqTrtkZ+2RtYf/dtxtDbu/SdpoxCQvb?=
 =?us-ascii?Q?cReGVrAaHsXehUvBJWNl7xU6qxYTNHN0P/uxBSOtEr/wJ78zMxfKbBRy+Buy?=
 =?us-ascii?Q?e6Gq/784yY9k3oH8m/AsOpj8SXM6J7+cXUKeGkkqjGJmGe5byj1mdO2rIgnX?=
 =?us-ascii?Q?s23XSUr8lAbPW7o6bs0OkabLBJahNjsjVyAha+0rV3S+9cr+EjcYX3djRh4y?=
 =?us-ascii?Q?HjlUoPbl6tVFE4L0gMRglPn6Ijm+5nevQc1DkSsE8mdJAIOQCNsYFqsO1En+?=
 =?us-ascii?Q?oTS4eL8F4MM3CuqTmGmkuGg/IC3BqKpMsSAZLQbvBjzCqwLCxBACvDUKKD34?=
 =?us-ascii?Q?B2ihpt8nDMD9R0Mgt9u8azHcVjCOGYJeeU7vojofZfNM+3iYL592T+BFmTNr?=
 =?us-ascii?Q?ipQYTxBSVThhWoY8iCzH+CBcdfHMKHLjc+KhHlSPo/kau5EXcVV5d0dEoCIM?=
 =?us-ascii?Q?t9P3vd+I73Lgpm74Xtv8k1Q+zARcRVbKXgEn9q1KSDdeLyRxGYg4tGFrwuVK?=
 =?us-ascii?Q?+AF7qGh/vi6jwKbvFm0JqoNRD4gBeFHXl9VpHZT1F75aEF/Qo8AnegdgbuMe?=
 =?us-ascii?Q?nu4s03O22gUNo5xO/JKlqqHg+aOocaqCx/OLVdWS0pJngXhkclwX6cf9u5Ub?=
 =?us-ascii?Q?OMcAEA5mDnRaOTvwUfuKd/p2YiGgXmNf91Ey2kn2offfxKBWHCIL+LzhJuGy?=
 =?us-ascii?Q?BbJGLSuUuq/CZIU8VfuqAjjNmmzKCX0iKhm/k7nUK6DlXnnIsjT36E/HF/gP?=
 =?us-ascii?Q?VXrxj1/nhDOWQyYrzNUbe8Co9FZ7EE6oNMT+rLrLt8UKdRYdibQSD29sDRw5?=
 =?us-ascii?Q?RfqmS0Gc1C7HtbsPDi2hkpglbbqN2EAdNRepZRh73IOZxdKU/lYypA/JKj6m?=
 =?us-ascii?Q?K8Z6+kYvIrpJx4ZRT9VC8zOWJXtxmaSc5Gufao7PPULc41HSOT7ltT46oVIU?=
 =?us-ascii?Q?+k3p9cQVl9e7Nq+Gr4SebevaT8CTbg5ybFvenW1Ci5GveLf2HzKIVFV8fTSV?=
 =?us-ascii?Q?4sihqnSe8NJkClQNRz+f?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e996fcb-4545-427a-5fd4-08dc8ec22d2f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:39:41.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4609

>On Fri, Jun 07, 2024 at 06:36:53AM +0800, Inochi Amaoto wrote:
>>> + *	Raw register value to temperature (mC) formula:
>>> + *
>>> + *		       read_val * 1000 * 716
>>> + *	Temperature = ----------------------- - 273000
>>> + *				divider
>>> + *
>>> + *	where divider should be ticks number of accumulation period,
>>> + *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
>>> + */
>>> +static int cv180x_calc_temp(struct cv180x_thermal_zone *ctz, u32 result)
>>> +{
>>> +	u32 divider = (u32)(512 * int_pow(2, ctz->accum_period));
>>> +
>>> +	return (result * 1000) * 716 / divider - 273000;
>>> +}
>>> +
>>
>> According to the staff from Sophgo, the original formula is just done 
>> by curve fitting. And the formula is not affected by any parameters.
>> Those parameters only affect timing.
>
> No, accumulation period does affect the raw register value of
> temperature. With the original formula where divider is a constant
> (2048), an accumulation period configuration differing from 2048T
> results in obviously wrong temperature.
>

Yes, you are right, I have confirmed. Thanks.

>> Although this is still uncertainty about how to calculate the temp,
>> I suspect you did not test your patch well, and the formula you wrote
>> is obviously broken. Please test your patch in all conditions.
>
> With the formula and different configuration, I get results with a range
> of about 1 Celsius degree, which should be enough for monitoring SoC
> status.

Excellect. I think it is pretty good.


And there are some extra suggestion for you:

Always reply e-mail in group reply mode, or others will lost your
reply.

Regards,
Inochi

