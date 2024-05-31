Return-Path: <linux-pm+bounces-8473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB948D632E
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63E91F25833
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C1158DAE;
	Fri, 31 May 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mlwv+AxA"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2035.outbound.protection.outlook.com [40.92.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA101158DA3;
	Fri, 31 May 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162636; cv=fail; b=bLKzVIZhTgS+E1alVDV+pbRunyhvj+6oW+7QosZInR9iJgu6KveUN79gRohJKgBPHte07pnqxqKdf45MJ3OcydJkfWaLlPtPO505PDG4olVtHzRDp02qVC6W2hNV90C2ZryRw28RTVHrKFR2dD8coY07uR3ip6jbyEMANHPbgt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162636; c=relaxed/simple;
	bh=nRjzIyUJt8sYsXdf8hcJuJk88727I0lkbEEkwb/RQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vln4jd8WNm5fAdOK8WPsC5klmPB4phUbN+W5IHmxeBe7mX0TUtTsmtyH3pi5WFzB/QOHD4KuFbuJoFsBwCfRLe+Mt1ACoY2p/NV/qzGn+v+1+Xm0i+qk+7e/5BQFqALqTQmFRWFv2gc76AAqjrzBjiPua/FYSD3AOxDnh53fFNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mlwv+AxA; arc=fail smtp.client-ip=40.92.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwL4e4zjjboXtaHU8JicBTSPkVNMm1Qe61v1iZSLcmSiV7buHzNIdDCF9pl4sr8wyv+qeg2YfODnTie4UMiHUhHuGTiIb4G2zHi6jVx+txhu94bxzkPB0I3FCJRiL0OjzeinUhVouqZ98O3cFuIoiLqX9y/ko5Prt41Z/uTZvxd3JI2IE9+34VK0w0ENHI6Z4jsRjN7mbfEqNvb9i9LqtclswtT+MPSMRiaVCZ0hhYL6oJCXXr7xYKXYeXuqKF+SUqaEyQxnprcQPrxgiXXdlPvtzSFatS6KFRtdF+hzzETIrobeQPM+SXF7voGWuEzn5nhvwHU2yy+We2sqy/Vxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9zxmRao9l9SE475DOEqCwqZFjIsiB7yZZBnk8dlHT0=;
 b=EqOmPKbCFUjw9z2VB/UbT1fKCEMRnwV3VQs1MzYbb3ySfh5gSvsEMimPVdEWva36MWxTquodn+h8R+HyxInvaQgFXWAtw9gTPRyw5t8GGCltDl7F+X3n6EVahcIPNDpVyLE2yZiF8rf2hPyZaR9De+pqs8v077QPCJ7BJBTzDXHUqDyP9VicfILrF2ZEPESkz6264CRca9VWdJfd8sOTtVmAX1T0MSn/1z/DClpcV9u07T55gKJOnpghsaUNGr35hQ7MWje+QfSsO9BMJRE5FtkpBD3hY4UO+kA9Rm6rW69SVf574ItUc7DNasB5tbOCNzmTB6Anl8W/t+Nk/rSC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9zxmRao9l9SE475DOEqCwqZFjIsiB7yZZBnk8dlHT0=;
 b=mlwv+AxAo1nkNehFmiGTgZ6buCe1bl0sKHBpZ7w4/INV+fCm8hPvIi4e4kQlXdZ2q2fWK3OdsE8oLX243Hw01EPZqGle1kH2LCKOp+3cAG4oazIgGVWukPrZ5utQtDtuG5B1EE3q8Pb1Jx8q+yL+WyHvT6mAmKnOe5nU5bbpO3wC4fNkruknLEN6PXU9cpwSNfmEud49jwgYB2ndB/9uA8IidQC4ozftfVzhdTDUCvMFXig/0uHXgMeELM/dei67M3DBqBJfup/UB8LwwX2UvR5M8cVTkwYVM0bgdObtr5VSy4F7+WsFI+sc+OwVoYLfFmqeqveZcRtw9m6vRQqiYA==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB5352.apcprd01.prod.exchangelabs.com
 (2603:1096:400:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 31 May
 2024 13:37:09 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 13:37:09 +0000
Date: Fri, 31 May 2024 13:37:01 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <SEYPR01MB4221A59D51DDA225207D23F6D7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BEBBF659F8495BF0E831D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49533177BEFC431FC16D1AB8BBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49533177BEFC431FC16D1AB8BBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [0rxHIWOowPJDrBHsEI5KBWG8UqX5rXCJ]
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZlnSfVBtz8mVQrGw@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2956057a-2179-475a-5453-08dc8176c4e1
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	pUOgQFPqvkNvIaZnq+jikw+H/9q4ZBjnQMKWK3UEXTMDDhGVIgVbVJicVxrEhujIbE0MQpxKpfILhJoLYI90+sKhQsh2Enc8rY8BeQ6bbPd1Ntp91GbZQYVYiZpEJ1Kza5bmSMU2bjqy+yQgUO+ilkGe+5+wmwfSG0SwHDrqJd2jFDJdHdbnx7JmPFosU2bE/jsF1j9z43Kqd3A2lP/eGrxh97GEiXCAoVMSSe6jmATDMeZNUomEbe9U+NsMGs88DdG/ix61Tcw0kAvGwPFrdjkjA5vSkmuYc9T0furxemNkLl/om2C3sJwGNKfs4wlqvw11xLHJnQBXRPn9afJGXDcn8rLTipdtu/UltGtU3dAYXgrTXVl6t6cWDw/y+0BOGqQ2K8ebjtsZGzwee2is0kQUk3CFv1krY6rk3ZeRWYimmpLt/R6c04a+yQWL8EdRx29NY9paZEDDwkr3LpOP65NEWsUsEOZp5jXJDF6FZuuUTCe7fE3FZ5x9SixDvvMc34CmI04FGMY47t8RV+7U0qgNm0Pq13YjqoghvMYtY2FZ2Sn7nUbSmLaQt45xXb/6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gQ779AlKCXe2PZogGI1XKB3w7peobAzjzzwz2bN7M5G3IWpuW8aeNVCx4WN?=
 =?us-ascii?Q?POYn1tQeHvirvS6BLRs69qWcNDaDP9QAs1UPovyFnwM8PjIzsOxUpmk2a37A?=
 =?us-ascii?Q?dCTmxnVFJWcmNtH3A7gn0yqGKEmqJcduDq5RxnlO3PeWLI1PC8NScbyF7m6v?=
 =?us-ascii?Q?oLpJsU4ltylGQ8x/CsSi1PNnng8tvfJpv5JN+MB/1vSnB1mHsll4mxs1haSG?=
 =?us-ascii?Q?de506ihI/FTvspV1ivsgxLOW8Q2kBRVo6b5dxv0Zdz9sNEV2zZYIYvXFQ/ji?=
 =?us-ascii?Q?DKu2UDpTf481gTlNZLV19/1PgyoTEYFWy8cvzKYyCaUtyIG2CvABe3iGVfq/?=
 =?us-ascii?Q?1vQTsHARJsTi5NnPSCz/J76bz9QvO1OEX5HiZ3TPJ3m3T2Q42oyP05AKtEgP?=
 =?us-ascii?Q?w27G0c5J+ezU4jFlL2wWd1GbjYmzzvROgCj+IopAoYBzsIcDHDIT8ujA9pf9?=
 =?us-ascii?Q?dzRPXM42WFDnVl8kMuyENqUgWHIa/oWL/zo/HI5PGwOIkAneQPbuWQnBNI3a?=
 =?us-ascii?Q?UXv29ceOhorByPI9iN8larKiV/4vuAmQoa72AMtEwLNKe4xuz6SBvBIblE9J?=
 =?us-ascii?Q?PTRvTr8PwuONWDmaYuXp9pgKS2pcNt33oAu0rLcJTQuJdSqvVjnx6lSNPJFT?=
 =?us-ascii?Q?bRGuKJbLqaTFCDiBHKcRBCp4CejVes8NtKR+9u3sFXTbiojDGw5MwyDyuuHx?=
 =?us-ascii?Q?xE67qVUhdKtD5S40CvywM0qjnCNh/nxYHD9SYfHu/419xSdh1p/Vi87WvDvX?=
 =?us-ascii?Q?NSBDKEkQpoOgSNL8bhyWyyqhjj/0DHxTpwN1tddIvCB3KwXAjNHyclvkAOX4?=
 =?us-ascii?Q?Nek8mFuOf1EUb55Yyitc4p8EadR4Rjsx06jeotZKJhWpeOP2Z1h0EGk4R1HS?=
 =?us-ascii?Q?hS2owUnr7jQrM0N4bieeWom96B796sqa5L5xX+mrt7bpgcoMv60eOF4Wlenp?=
 =?us-ascii?Q?8G9gOasVjEzfnQoiGsfQlzqMafVCis8pMesZs72ztpA1mYCYGoKdxW2CAUPK?=
 =?us-ascii?Q?8puLSatFcPFpsCbMG1z2Mpiz9UJVwNYyQZnTunRxZ/KtiRGHGqvFZyJ+Oikx?=
 =?us-ascii?Q?9WyNjup6nuYMeh5hXw76nBXP7niw3cs+v82j6HHCIAVOfqWs23zaeh31t4GS?=
 =?us-ascii?Q?+qcX/joIEni4S6oXJBGuCRUhI1RaiMfmovnp7PsooSwN6TJlQYnTjedV2zO1?=
 =?us-ascii?Q?4lnPe5+9tITb+h1s4z0omRAEa1RMrjwoqKqbBuLlu+32nwspjtymHsqhEck?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2956057a-2179-475a-5453-08dc8176c4e1
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 13:37:09.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5352

Sorry, I forgot add cc and to in the last email. This is a resend.

On Fri, May 31, 2024 at 07:45:37AM +0800, Inochi Amaoto wrote:
> The sensors of CV1800 support various periods, I think you should add
> support for all of them and let user select them. The configuration
> you use now can be left as the default.

I will make sample period configurable in next revision.

> > +{
> > +   return ((result * 1000) * 716 / 2048 - 273000);
> > +}
>
> Why these magic number, I have not see any info in the document.

Actually, there is no document of calculating real temperature from raw
register value. The equation above is extracted from code provided by
Sophgo.

I have figured out meaning of part of the equation and could add some
comments to document it.

---
Haylen Chu


