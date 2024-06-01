Return-Path: <linux-pm+bounces-8494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82E8D6D2D
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 02:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF75E284FDE
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0231852;
	Sat,  1 Jun 2024 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pP93GMMB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2045.outbound.protection.outlook.com [40.92.19.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3017FF;
	Sat,  1 Jun 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717202088; cv=fail; b=aHO3M5g4jBQVEGPKS7fu8lkyfKqN0ZOov6pmom7eHdo1TuijBoIp6cGiZVW+/vQoohsvty9BFQa784LPYZWItqFKhzk03SYhB7X65vKnHuQLooLZDDlJPX51Lhr6xeNOh+NOLZ66HqfbI0NnYqUBZMgcg7rrypmOZUixjTwk0qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717202088; c=relaxed/simple;
	bh=UUp3zOHELAzk2ejzLoqesWFb4ASbeIcqiagB683fc/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4hB3ZIOczx2syK8uNz19PZCxMi1ladP9Gltgx9o7PdgaDHpDKwenGJ9d00ylev0YmBElIyjpBJEsCUxp9ZoMv0SyYXzQ/VJZCO4IDMjkO1llNawy0X8IULvJId04QXIGK+5Gn9BKjHoB206oGWrNpuGj6jvKSrENro6/cyuJZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pP93GMMB; arc=fail smtp.client-ip=40.92.19.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvJsQ+k3TAgQHtye1gsEDQz5cMUN25YUz2Y10xWlu7tJx/9Gc79Bv87GIpLfVtWYsOLu0A9BzB+A9FyJyOypjBazZ5CRSS9FSVLI9gms5tqh5USuS5M5DmYxCUfpwdGEudCw2b1FiROSw2KjT3bMRDbNNQ9rnx1DoirWXu9PN4Mn5A3qUWbqmCb0Sq8W5pMuaZmZ0DL2lo80kcSskXQEc+nhaBp05seFN8MQW6XGKhkGgydf6GQuLg8GjYA655Rv/OIhbo2bqnrx56wpK6TsCa1E8yk+kKsMwpjUKqzgXiM8V1PJQ2pBM2xGrlaPjlDlLLuFvrmbiDfq6Hrt4MytmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YihQBVyXclUgfsxPVeL93sGTTwxjm4OzDsK076sk8wU=;
 b=VqGOgMBp4rH33ludLiNaTuWZb22/vk97VTfX2R3dqZ7eLq+UtrsY/A00sosTMnAE6LtFJ0y6AVk1VafZbUiJdyg4lgtAHCoRWheYW8pUob9L9L0iAAZaOJRODPKSC8NLlKlFfIf7LzK2wBTF7Yr02CQv323tIKNKxDXpD1hbHwWl+UZUnuN8f/9O6/flSJrTvYJbuXtu+vvW7RxEiiswb43OdeEhuEn+TxWvRnOihsbTb/R9za4pJvMG4DOuo4nK++iQc9E/JARAAwTe7F8RPgsicOVyZqRJrjaO/0ExwsGibrRK8NN3tl8KdEOFduIgPp82Y+5/p4qQ4U6+WcN8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YihQBVyXclUgfsxPVeL93sGTTwxjm4OzDsK076sk8wU=;
 b=pP93GMMBFekCqJY03G6FvfuOJJanFak18EBFNBjubmIoimxwJVQ2SM/xIgp2s2fbTGTCjEWjxEQ0/0auBfOUKXfhqiGYdVbWnDZqhOPu9BhY53vFgYx1V1UKEu1yyCUUHnTXW5tazw5gwdc7SZ7PVXRMz0/J7tiWevsmsYkKToYOtLXFmiDYBWE/OJNxbCd6CYrPZQiA0MZ6I2EkON5dw5MTI23WzJP557OXJe2TvWiCnPGyrogqlxBqn/F8soJV4k9WakTLsNvOTLPIfrS7SUB/kNrPPlnf3gvLPqRdWURLfOZfDeO3LhLJFnTrXw0vgpuJCzJIVS/4/DsLuTA4SQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BY1PR20MB7509.namprd20.prod.outlook.com (2603:10b6:a03:4a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Sat, 1 Jun
 2024 00:34:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 00:34:41 +0000
Date: Sat, 1 Jun 2024 08:34:23 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <IA1PR20MB4953523D31D45463D5A5E5CCBBFD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BEBBF659F8495BF0E831D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49533177BEFC431FC16D1AB8BBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <SEYPR01MB4221A59D51DDA225207D23F6D7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221A59D51DDA225207D23F6D7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [SINP3Fmt+RUNu9TEIc1/YqjmpV4Aa/ALwMhOkxcdOGc=]
X-ClientProxiedBy: PS2PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <pd52sfhbqfvcicuyo43sgfjdafybznohsxldtpphlggmvwx46x@kyyg23wnl4c4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BY1PR20MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ac9706-139a-4fe5-9d5e-08dc81d2a066
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	Kl+PDBCBPVk+Fo6c+Bb3dy+oUPB0qpMvbXfAICzAHRSH328pK6v2ZMZwkG1DZosnbrLEx2pKLyaZ1t1bBXJ7zXgz+lseYnYw1gRizFoKo4nDSPFrL6M1WxZDkALnOqXAcxyQySIibMBlgRdGVBFIYXGmjAKYWwZ2GiEu/wOiRu/nKts2h3Er7+TB6AvAxRgPUulZ7jaBc8v1t72KiSDqzdW4kenNfnpSz8wiox923aCqB/vN2XmpzldjJHLJAgKQToPwUAF4hx84IJM7Uc+OU6fd1Tznyj+XN5w3iHMAD5w8z4W3y1FtcoLyukEyXXbTn49zH5RkDBL/mCW1AHU2Q9Xt/1EYcby1xYKYin2wvvsva2t7TsRMgrGEMQmPMuKB8PTiXIHFI5ZbHg68faiIjSGvQOkXT+WvvzIvNpPKn0HvAsCu29X+lDWJG8ZLY7TgfamNAtL9xf1koGB07PN5rhApQTMidmk7m6ShssYkHyFa4hCEr75xkaXlP3gJgpd2HwVeT7H8X0ydUpj7nt5mJE6SuO+9oGjlmGVH6j7lLpgGEJxFc8D/Yz0mg4Ai1o3Aga1OCLR6PH20iBU2Uv2sAmDWAccBK0YR3kDLxdrr/2caZlK10Qi7Ah6UNzDnXfug
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcgsEEmPFuMiRzbMmEGhcB9/qVP82Cl28163V+ftGA0BAEo6LzvTdj4tBsvH?=
 =?us-ascii?Q?iqOla57Yf6w/uoiNuvB3usVgtvxuAgWY4BtsgLhqY7MjIA5RCzyTjKZ249uq?=
 =?us-ascii?Q?20vigkfXhoUrhB277kHqXBTpQWUXfgX8Idj4ezmSfmy4XB+4HAG3wKZ8OEbY?=
 =?us-ascii?Q?Rm/ShieWcfZdMlqauIMIyNNIAfj9OhI8Lxi23nCBdAwTnD7g58ia7PGaXhU3?=
 =?us-ascii?Q?Bq055NClFN4aQ/miugSNgw2RbdmfE6P9fj6FPofrodKO7tM8m1NhkjJ5YWo/?=
 =?us-ascii?Q?nXHICnzagaOIYJKh/xlUhpCvLJr2eKm5Ew2dpz1F2Wjeb9Yy/fOfwxcq60du?=
 =?us-ascii?Q?4eqikapTgg2LI9uVIWbgcYOXyJMp4tMZSL1xFp2DhncrLj3pP8NAD6/0fC8f?=
 =?us-ascii?Q?x9aabyPxMc2WJKqzDAr2C4mBbyHervMQLevjtywJ8Ft2iuJ0t/N8LdDG+tQA?=
 =?us-ascii?Q?H5ms0CBzbwIs3NhcAYFahpTbZJYgVkyzi+OQYS+AnnG3DcKZl1MDAH0dLyW1?=
 =?us-ascii?Q?HTEaCaWP2pNN7t2nLRdTO2d51zhaPG0dODR9kMOOPyv0zvdoeUjvE4SZDAjX?=
 =?us-ascii?Q?Ou+VayORC5X+GmsrPaACyvziNILjjKteRAkuZBCUj7SftseFyrOzdW3DZbav?=
 =?us-ascii?Q?5GpyxtVTGtJjFsf7k+29zHShOCmva0g2ZxrhrwDDNluOVlsMuoY/ibK2Gj/K?=
 =?us-ascii?Q?lxD7CYO4gjQMdB9CzowSSVChXc0lie8WX+r+cntkzE7fllEKOig1NxGJc/Dg?=
 =?us-ascii?Q?Q4n1PGRhFuS3hlxI4YSQF8SZ5Ic/kzOorNRGPb5TZHcLe7kaci3Dpctwt7MY?=
 =?us-ascii?Q?pw73CRb/cOpYqS49qtaRZ2YYCIqhlfiCKLYb4/BD7Mh4KzoQWL0Yx+9J210y?=
 =?us-ascii?Q?lH5oqxi/jDS1eNwyDDbqktGFZ9ovzdV+WdExunrS9EBZm7RjpE+hKoBCmezN?=
 =?us-ascii?Q?xlNMGWeosw08WrA6mObfaE3Elw0gGAVCav0NobVvc5MdhCWSPCfpX1I0/yvi?=
 =?us-ascii?Q?HlW5NPiLAIqE96gybelwyiUxk+EeJvdHhY3c1PTPkPsw8UzI/wwt8CsO9VMs?=
 =?us-ascii?Q?ew4lV99u5QHYBu5/DH/YxWvgeGfVgEoYCfBvdVqdAuS9eBVAF3FjEx3ulB6A?=
 =?us-ascii?Q?KLRhNySWpENvq9b497HLR81lGXebRTC3zc3HfLqGsBZiCzLcaOn4n8bJ0SlY?=
 =?us-ascii?Q?3Fv62Th9zEuGsxpYcBfKGnDOBMuO1A8qvGFwSx+1Zy1do97yTJW0hl7ZpQ92?=
 =?us-ascii?Q?f4yeJx2l6Td4M8aQDxnl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ac9706-139a-4fe5-9d5e-08dc81d2a066
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 00:34:41.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7509

On Fri, May 31, 2024 at 01:37:01PM GMT, Haylen Chu wrote:
> Sorry, I forgot add cc and to in the last email. This is a resend.
> 
> On Fri, May 31, 2024 at 07:45:37AM +0800, Inochi Amaoto wrote:
> > The sensors of CV1800 support various periods, I think you should add
> > support for all of them and let user select them. The configuration
> > you use now can be left as the default.
> 
> I will make sample period configurable in next revision.
> 
> > > +{
> > > +   return ((result * 1000) * 716 / 2048 - 273000);
> > > +}
> >
> > Why these magic number, I have not see any info in the document.
> 
> Actually, there is no document of calculating real temperature from raw
> register value. The equation above is extracted from code provided by
> Sophgo.
> 
> I have figured out meaning of part of the equation and could add some
> comments to document it.
> 

I think you misunderstood. I did not only ask for the document, but also 
a formula that respects the configuration. It is pretty weird to use all
fix magic number to calculate the temp value since the sensors itself
supports various configuration, right?

