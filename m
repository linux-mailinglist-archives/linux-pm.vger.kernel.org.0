Return-Path: <linux-pm+bounces-11760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68A943366
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58F528582A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278021CAA9;
	Wed, 31 Jul 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rlZb1Rgb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2062.outbound.protection.outlook.com [40.92.45.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380017BA7;
	Wed, 31 Jul 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439964; cv=fail; b=MMUYlNYjxWlIJHtnyNOkPPV9CrRZZDnveI7abNn2FCA+mZCAtcJv2cuwew3u2J3/5jPoKPAMrwxS3a2Jxu1QwjPIGKCwjxK6AoiEuHvgl835z27+Cn92kBTmf3iVRrZojv76A0wXoZECpJMrqMt/kpcKOY7x7M9WtHSr2YytGrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439964; c=relaxed/simple;
	bh=aI8bhLaPzkGtPE96SmvuZt4UsHxXfdyvPbGIlG0cJEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKFVFx7xeRsov3o994hkmCt82pChnJaJYZlvgMwP6OrSZK+oZR5hZDBG5xAXkU2Z80UD21RwzvERaZTxly9hC1HhBmnBMqnY7LeNNj9xBWEdPk83Old08rpXLBTlRxuuyl26HVykw3REBx4Q6R8iTMw0OqW7rPobWWZRw2EY3/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rlZb1Rgb; arc=fail smtp.client-ip=40.92.45.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKaMGd4vwV0cQ2G62r/Bp9kD7ZICM7Yg9Uvb61xdGGxkFs1034QoY0WSgESCcEK8IzX/9HqS/ECKbhegLI4TRdsRYNxSFFzdjMI3E3gMN4ndZd3RRuk+MbsnnCdaFE0ipqhWbIACj3FSococQrl5SD46OnyjoBVyIXrRmWHzwipH0leKnKm5VYXohueMEpp9T0/BYKdG7iIuelNC3BnWs8AwAOGU8VX5tY+Pa5VOfsIi1Ar7tAGAKA0gRobWCelR2Kahwqfk+oS5BD5iUVGDal+AvuMDPfzKR3y2nTQo4/GaxblOLWo/2LwnrWUrp0X3toV02hzGPP1xu30GUqBg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xto606DjTSXXftNgyG5lr5egQUYx8B5klw5deADgLlw=;
 b=oHHqDXhnebVWdYnA6zLKXY800Z5O0yY/63W9/BoQz2DVpQg9omCNMwAOTBWfH6BagQzvFy2UdFMpX/cP7xmGOETmteTbOCfsJ+OeNTuyO7LQmPDt/qBMF0LWSFgV0io84G3BOltv1LtVZFmqpBlsAPY6WPJLvfedfnZg0WocIea++FKaoPHYQBEB2Z7PQwcX7d6kDJOKYOg32HEVq4/WxAX0UBtjWxVphVNTDJNI3BFB2Fv226rUg9TIe+3Hg1kkQV5q1/UTy+3xGL0hi0yoPm/OofLNZyZtYBVUnnDigkoc81niRRmtZa8Wlx9SM++sY3VUO9POx452K+54JF4y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xto606DjTSXXftNgyG5lr5egQUYx8B5klw5deADgLlw=;
 b=rlZb1Rgb8PmvExO/GSJurUb9IsfOmwECSzdtmblfbG1bjNkGLfn6vPGCjZNrzhZsKwxxp7Pn97HSwS62t9o+fvU0p9ue3JZqM6+jdGKv22lFU+mOc9dvrzd9HOkS8zLfMvyT4bbv7gSyyC2Y0KLxgOQuoW2wWCrE2ScgdJe5VguQvBWwJbLXEhzZcoqf3l/5pK2qUPEfT5KR0v5r5MGFrPNf95mxWQkIF2t842WiT07/ZTgqJMtdHFX7BtpXGkpUvSDkzT68SVWDISk2zAMPYKjcvFZBOSIBuQSopi7mUhmVLT3btdqTrYrvK/an9WfQxYZDJqWr9HBg+Ov20jRpCw==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by CH0PR16MB5253.namprd16.prod.outlook.com (2603:10b6:610:183::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 15:32:39 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 15:32:39 +0000
Date: Wed, 31 Jul 2024 10:32:36 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, sre@kernel.org,
	linux-pm@vger.kernel.org, jagan@edgeble.ai, jonas@kwiboo.se,
	heiko@sntech.de, krzk+dt@kernel.org, andyshrk@163.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, t.schramm@manjaro.org
Subject: Re: [PATCH 0/5] Add GameForce Ace
Message-ID:
 <MN2PR16MB29412320A3E3E35D9AEA0643A5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <172227904756.1346368.2529190213661296274.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172227904756.1346368.2529190213661296274.robh@kernel.org>
X-TMN: [eYLGcnw0iJm9MFXdDakv570SUJus8q44+3fif0thCSU=]
X-ClientProxiedBy: SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::27) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZqpZFB1xsxce0UHW@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|CH0PR16MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 91115bfb-3d66-45f0-b46b-08dcb17602ed
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j29eivOTv8WwyzVp/Gk/pryOGmyL7tpr3IZuhz3HYkcoLCe49eNW+WgnNG8kEUg/2cRx+jDc0Hw/k3PacV5yzlKbvvfizgWAyraWzTqN+irB3SYUvW0S3Kc7AcwusYRjlZODd6TiBFSmcf0EG/NqZmyctZ9PtLFwm0jTCZCcGPrkFZrwK02DvUzVAmgwbx0+e/V7nbwREY57jNrxhmiK1rkyJqG6bBzwotNM7OtyCsn0qMkL6uFPzezQRgtAGT4wBWmrVZMO9JISldMxig01BE99Ui4FrlSbL42rMyPn6qjrkQzLbFIcxQOPGc10JXk3WeFuM7xuM+aWJcL2mfmeLfA4y57mAztBgTLxn0f3M6NIiNbH/Evn6CuqrLbHF/RnoRCTpRb3RJS2VmmswlgjMxow8xBGyaPp7Age/cSFEqzQvOuGAMTALzhYGSHqms+PH8MQL+WUNThsdWrcp06IKQqgJT1rWkDk+G/QFE/LJFB5HEePyhDnGQFik98V/sw1higl6a62mT++RKb+OSYqpHDA8AXvjStoCNjWRbR1TzJ5WP3AhMTsaRLRXxshez7GZ/aPBjLmSxgy/D5MT+rMRfygwh8JmyiA7bicVuSLz8z9f7UKvG/M3FR49+dRHLjDaauOUvCN0nrQya75bH02rXSkk2zOtEaAW03rFDSJoDg0MOegCkbzoh1+dmPEXdn0s/iu1JM/SVe72hq1r3BrszjiJ2TRrBbXkouH3B44eA9YW4293pjDOFKoBBCjVOjJCxhuiNmWiN20Jqtk/ZKQnZSf0OVXcPvL3a4qXkgVwsyrubDTUhMRFEjj
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799006|19110799003|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	kwUgx8knaQj9MuChzoJAjDKx1xNzASSLoyTM+q9jlKoAE+Wc7Mez1Ea+wSyGTEFUa2KJUPvyyDA3BncB/R5e9NXECTtCfa7H5IbTG4n3tu1OIVMV7FEEpPMTo+s6JcvF521baZgqRrSi5SYuuAWlY4AitsCBXD+sl77zCk0+34kprC5uo6pLeyCHAi+v8KLQAs7wWS4IwgwtVWGLknO+Wmpv6CzR7NR6s4IeKI3R99k9FromIaQ+BrJdh7ewsVkvpWd3dlUte5dGAhnHqcD2Nxy+mZfQyB+WT0Cgnhy/KQ9YsjKnQs25a3AppgEzxFZa3eAtd9M4lh2Enlr2tHz/ZlmG2v55faSz5WfbI9kKfxAT07wbQk1a+7HVWlF9h9rCftSmos0ci6x4XitAhQjCrIQ/Q/gKhwKGtVqbUvApX0Z64JdWz3HpZNT0IWEgx1IV89SsMRxrkg1+1xrohGNurQBWb9y5V46CQ5BVZ92BxrHOuVZ9umoMkcUfbK5CffLiGKy915FPSGRVKxbWu9Yuotb2hv/IyLOTSjwStXXbE6F1iMlmwb3f5ptzoUbW3h8etk2waybm3e+NySC5pvM/lSRZBl/9KbNbnom9J1HAXrAMQ+kSeqx+GxW7vDDP7oYLbNA0EEwBOqHp2ryBZOk1/JVMD421LclZqDkhiI05Jt4XvWYwUEEm7oO7lFU4dN0aHhOkq7YCI4AsPhuA+n9hd+XidnTXNRa3Q1dTmYnZH32bPCfzlSCw7YyRel0M+hwo+j3p0fApvmZn0luh+Z4BLw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RabAczMQ4b/KOzf2Rxdl4JjpHKTe/0a6gbbG7dTVypqSzpYpRxnk7ZqkMxTm?=
 =?us-ascii?Q?UrBl9NFT1AUp3KomEYeT4ZTxBPEXycoxpJUvKywjDD3mejdS8mPYET4h3ZtK?=
 =?us-ascii?Q?sfZx3knn9/qv8A38BI09/3qYGpJbs9RtXnuddlTok9OxeHe5vt9WeOh0wvgR?=
 =?us-ascii?Q?QCVQIOLZhZmAkZUWeh7Q4oPCGat6uJAkMqwmiMDaXW/b7ui987VhVAy4C2yS?=
 =?us-ascii?Q?E4Gm0waFgcrhnetxxB1nKHWht6Uwb/d866hN3cFSeLH9NtF506Ud51hh/WgL?=
 =?us-ascii?Q?4PMeBEV6RYIMvWuga5m4tFbD/hRV3o0DKAyhyvCErJ9U++GNSV6bIEB4Ya32?=
 =?us-ascii?Q?B7yx5SiH36aHMN5AUsgBjT4fjkHPIWn34+fD/2OYvjlUGyI0vQJx5IdPI4/L?=
 =?us-ascii?Q?z6HT+JivSudU7BS0JN0wdmjIR434k6tVHB2zjHIisXANgFjBNwN84jybo3p5?=
 =?us-ascii?Q?t1dCjjrBvwqO/uxSF4CHQQ3y4fTHRkvoVaqaKPo3gCHeuBTWYWCbAbCtEjp8?=
 =?us-ascii?Q?j2bhiXPFQsDwX2HwN/3rqJRCw/KAoCQIvYD6qSguui+vtNG5bZEhj8IaOEqN?=
 =?us-ascii?Q?4X0ULNGCCYD72a/BU6w7rTjX4dq0/rL3XUiJzPgiBAZW5rEES6F21e2i6bMd?=
 =?us-ascii?Q?ZphkTblWsOrc5xnbzZmOqRmUSCH+Tvo5tXqUIytutyu3jqo2Tt4sK+1LCAVG?=
 =?us-ascii?Q?N1Ntp9xNLV+WtkaVzevp/W8/ztRutrt6Bx6FnGjLQqB2WwWttZVxhpHu2IlH?=
 =?us-ascii?Q?3VDtgXJCLSns4d01lL4jnV1JlVrl0S0RsTzoczKCcBuhLTxRqN3XiiSqzf5Q?=
 =?us-ascii?Q?egvFQKjSpK9y3l+sWCsh5W7Wgz4Xeu19KDxRupEqtBiewoYp1YxWEjj9nAd2?=
 =?us-ascii?Q?cGOxUQJocH/KJym/6ds0LnxEZBLDCbex4SOHLzokLruecpMd8ELX/N0sX4Ci?=
 =?us-ascii?Q?+nx9GCDs0a/64uwlzAab6jY1qc2Q7/QtPu1CsVbRARxGav9I8Scsx4BIjjQP?=
 =?us-ascii?Q?+zqwlzM2Fjt95EWgwe0kttVr859C0rPxvAOzFiKiaAMYMXFX1dP4CAHiwygg?=
 =?us-ascii?Q?trBX9hmedebBs922VcT1c+962AQ7A/LYBdLJ7g28+aD1QtSJNH1o5bEfnX7k?=
 =?us-ascii?Q?G3QnuqEF6k18+eLt5mmb2ixLx7iSKmg4QXx3VrKZE4Y48I8D7ov7Ha+I24+v?=
 =?us-ascii?Q?V0FrsqSo9SqOj7nXCBbbpEWNuHsU16qY9x251HOKwR3gjpRnRU/YLqo+zdCX?=
 =?us-ascii?Q?Me/0tu/+4mno0bnlfUVDqH4Pw6/xiETk7eTqKX/OAg=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91115bfb-3d66-45f0-b46b-08dcb17602ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:32:39.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB5253

On Mon, Jul 29, 2024 at 12:52:50PM -0600, Rob Herring (Arm) wrote:
> 
> On Fri, 26 Jul 2024 14:49:43 -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the GameForce Ace. The GameForce Ace is an RK3588s
> > based gaming device with a 1080p display, touchscreen, hall effect
> > joysticks and triggers, 128GB of eMMC, 8GB or 12GB of RAM, WiFi 5,
> > and support for a 2242 NVME.
> > 
> > Chris Morgan (5):
> >   dt-bindings: power: supply: add dual-cell for cw2015
> >   power: supply: cw2015: Add support for dual-cell configurations
> >   arm64: dts: rockchip: Pull up sdio pins on RK3588
> >   dt-bindings: arm: rockchip: Add GameForce Ace
> >   arm64: dts: rockchip: Add GameForce Ace
> > 
> >  .../devicetree/bindings/arm/rockchip.yaml     |    5 +
> >  .../bindings/power/supply/cw2015_battery.yaml |    6 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
> >  .../dts/rockchip/rk3588-base-pinctrl.dtsi     |   10 +-
> >  .../dts/rockchip/rk3588s-gameforce-ace.dts    | 1315 +++++++++++++++++
> >  drivers/power/supply/cw2015_battery.c         |    7 +
> >  6 files changed, 1339 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
> > 
> > --
> > 2.34.1
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-gameforce-ace.dtb' for 20240726194948.109326-1-macroalpha82@gmail.com:
> 
> arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dtb: typec-portc@22: 'vbus-supply' is a required property
> 	from schema $id: http://devicetree.org/schemas/usb/fcs,fusb302.yaml#
> 

For the moment this is expected, because the regulator is driven by a
TI BQ25703 chip that I'm still working on getting supported. Is it
preferable to either keep it empty (and cause this error) or fill it
with a dummy regulator for now?

Thank you.

> 
> 
> 
> 

