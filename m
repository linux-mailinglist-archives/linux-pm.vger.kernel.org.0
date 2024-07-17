Return-Path: <linux-pm+bounces-11196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4E933655
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B351C220F3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B7C2FC;
	Wed, 17 Jul 2024 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="URTJwbDM"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2014.outbound.protection.outlook.com [40.92.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AACAD59;
	Wed, 17 Jul 2024 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193563; cv=fail; b=phQt8JQTzQe6rmbc+Unkb/ofHYeoSzyS20RuqfO0oTwwPuYLi+BRVyrz4LN4E5PYGCpoyhNO2VWlctCEg0ZtOdwQaqSkxY4o4irTuC1StYxFuYggBMEJaZmAmmRwv2mLlu756Tl5X4VjCh7cpWByUIqYVLEcW5nA7I9dn0C0aZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193563; c=relaxed/simple;
	bh=qUrcqaEPM0hQQK3ab1qf5aW7PUgC2iGTXNY75mvSZCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OhRilwvK+GSoLGhfJxhB5Sth1OiOl2Nw1cBNQfYbQ3hKNUvLVt1jDTNHasVlpDg7VnedUH1qlO/GOVZavzNV3/ku69KMxj1Qd/3HwwAJKiWx4IPMQb0itDE5UrOue0ZfMY8u2CadxsS4O+ANQbTsLck+zkjaw3+yo78sXyurnoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=URTJwbDM; arc=fail smtp.client-ip=40.92.52.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYfP/VqoUnLeEfcfqSY3eisecP8QIUPqcqzebAcbKcGQ7nkusMLYkKW/dEJ/ocNzJ1TeB3L4XfLQw5HIEOm7Oh9ftQSsmXccwOHizQRN2NjsycIL3Aapb38ItthZA3z/EW7g7L4YW06lUrEu5Fji0qZ/bD6JNnWOSkbngCuH3pD9hImlxSyEOxxQRvUwDt5EuUcmWm6n5vGj06ZnGXtAtRQrjTESae0fx0t+h0PXMQam0gJyzc6/zxdJFGiENCSSBXsQw8sh+GvsBTWaY/lM4U777bLA7l9jvZXT6nv1Du6IX/pdH72DwJ3ZLxXLjj3x+fsJ8xK6iLmfRusTt6B9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3QV7V8g6AXJYlfpox87pgSIG865YhRVnRyi2+IZurs=;
 b=B+NtnAnTNxPz+2fG86bq64nzCDGT7iJWYqNnPznzfNz54eiAkKqvD8iT6dYq3paXRrelfjN9nGo74+fAKXry/GwOyT8y1udPJe8DkbFjKyXWiNc6pblhNEHw8U28c371x/OOvBDbPUp4NYCtGIF+UnmIDWjGSkU/52yyRLcsAptxjrhpobnbRk2leHW9ewc5ubJorX69V9yC4/78duN50dFfr3zaLgqLyAngtPylWew0LifLz9pbPsn+i0mvXCSld8wGyr0lkaIObk2FM+1udEDF/cnJAhvk4Q1TjzDeCOZ0TPTTPnlUnJebJ+zz9JYM8Xjf9TfvMDdFbUZsV4NW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3QV7V8g6AXJYlfpox87pgSIG865YhRVnRyi2+IZurs=;
 b=URTJwbDMVWW633yp/VrGkNUQlPn1rOH9UNdVMgA/2sy0YJPaLzzGWOngvVIXtPEDXJO+xET8rf1rlnkNpXFVE7DEMZhYNUXRMzDLN//j8riZPJUU5DFk8gsSbxXwYtl0v3iA79JUVSWTDVfBV1WrLNWVzcDY1g8eYPCTtMJN0wFw7CQE1Ab8/2LTIB7M1CtsWFHsZAOQZ2UJvkEy+1/cn6wKQKtsvxQm9JMlD8pz/sIhIkCy5lepJ5OMtju5DhTJqwbyxIfZofTSEb6zXVuo+mm1gy4uvCaG5sdKlTjSUJgXSPPg2bIXvvpVWipfAxyljgeTEgwlF0vj8RhYf7JrmA==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by PUZPR01MB5434.apcprd01.prod.exchangelabs.com
 (2603:1096:301:dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 05:19:15 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 05:19:15 +0000
Date: Wed, 17 Jul 2024 05:19:07 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID:
 <SEYPR01MB4221940059E23BCD8BA75125D7A32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240716-cloning-canopy-a6799dc7f3b9@spud>
 <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [fzj2PElkyNR6GTGcaTwlm50mb24HytX/]
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To SEYPR01MB4221.apcprd01.prod.exchangelabs.com (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZpdUS5G0HArAMuN0@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|PUZPR01MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfdf592-164d-4a31-38bd-08dca620001a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	r4b+dSQim10E5dv7/6Y2W1oj4f1EKV5OXXhcdEg9vXfkSgqMOH+SimwaSzWrsRMUX+crKabjacofk74oEb5K/nnnK3OmSbVmd6kVby0oc15moW4zCNMvr9sXMnmEoaZNIgd85H25IFagim+vkLxWhV3t/XVK7V9PNkRibgrweHyH/CVxrVSfg8ztngcDpvANPY5WrYmwqiQuQlVifGvzIO5FOKcZpEUgOnv2VbEOIITu9Gd7dI8xPe3Nelh9qbYv/4YrZQeCw71vLSVipeB5mQTfmCSB3SSYFVP50wY6Yf1XBQB2W3vMLnvPRf8U80R9rDmLrFrKW2QZrVdnoB8TfLiQkzAGQ53AOKCyG98UU6SPiDyPHsIjsdI0ZwWhbLADhGWuaKRfle0GSuE29fP0zMd1IJG4JtiRW1kArJdivGQEO/DxPed1I1z2Lwk9qeWeAWfkEcKnVnDRIrqF0o9CGummVhwWLsyKfQaemj3KhmPlwHpacd4KkfEZl7Ymc3Ur4Af66jjIOO3YoruraUSdZxTj2Dn3vzyt7SShGmn93TaicX3UFuXiYfdXq0FuhJm+r36JMt4Ts2Np8QP6uDW7KUoIdq8fgBql45nYkuzwy+QDQZqksy3cB/ziT+v/xppuTenXxMM33mtydKH7XT2sBA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fn41E9Sc9VJp0FgPgpbSOQ6u7jrEnfJBGzdnlzkh3V4xtvAzToCDTr8Hpqj?=
 =?us-ascii?Q?C1Er1W7C7I+T1hU5SwvvRkVPVZ75WmwDZ69x7R3k7SeL6ejgPt5QaZcenwWK?=
 =?us-ascii?Q?u6NpSdogPqnyA+BYy5CH3xH0TV9f9jXUcQm8ScL6XS35i0dCwCcNCVxcHt8g?=
 =?us-ascii?Q?+NA6wH6WMhJekQUcH+O60GK2x/8G1faMGDqsiaoCfLM4omX5742CQWoa0u09?=
 =?us-ascii?Q?bbBx88wau1HWs7OIQs7+y2xoesaLDz5HYbO2Yo3w2avW9JfqynSOF2zYnyww?=
 =?us-ascii?Q?AqpVSkMpFWZJmz9u4b/ucTqzlfV3z9Hrtsm7BmAs8FZx5isvzzJDjF+jEhro?=
 =?us-ascii?Q?lDrQGuRXKCiQDukeM/jDlWNR3Zd4/UDx2O/bDUls1XzJoaogYO0VpaUeMLSC?=
 =?us-ascii?Q?8FbfWTMWIxZ8LDXwY/wkBwxk/YrZ8ymhixCsiJsKhIxlEywpub5Rn3iCu4Ni?=
 =?us-ascii?Q?5HzjVcTk7YiyiNp4cEbJNs2xNlMMotjHFp7r04Q4/Cqn09cEASZKdM+zr+Zy?=
 =?us-ascii?Q?vej2CC8L95ucQbs93oDaN3kO5dyRNXtOZgO7MKoONODmZkXKy1VuEhAKF8eM?=
 =?us-ascii?Q?sRlQ7DdGJf5h+fdu7eupxGqUpuSZE4yTHRiwHL4d+WTZRowwV0ZEJNMbr74t?=
 =?us-ascii?Q?8tfQvTJWbT1tO+6k/D7pB+MeZuyAprj7f8pGAOlv96asIdt1WDehffGblWuB?=
 =?us-ascii?Q?vtpRr9VavudqSPUt14ZOfpYrFbuV65Fc583qByPwb7NAFicGCtsBSFdmQxL7?=
 =?us-ascii?Q?CVKucOJRUwGcqwnumAv32qIhudkqFhEQmRg40Kw9GFNI2sR0/ghUIwjDQv7u?=
 =?us-ascii?Q?ImGdHoJkmCx5I5VtoL1aqRcWOpEF3IdZBjgbm2tweMJoOaYBXxQhpbvex6Kq?=
 =?us-ascii?Q?BrU27scHBquea40eGgr3s+BAB32mGB4ePLztMeyM5OZVdQ13uojBXgKvi+qr?=
 =?us-ascii?Q?uhWFL79MPbAgxdWS2GCPBQGu7W2bDCYACle4GrgAHMj8k5IMnLDdMKHBO9yU?=
 =?us-ascii?Q?E4l2RgfCj8UD58YCbtCvGv2GKALuAnb0ZIUi0AvJKkIV9jPMqN77sf3KK/f9?=
 =?us-ascii?Q?+IFx5NGuLWrjlfY1C6YlWFeQvOxpLi/wOpfvA0zShFt1DXUWtxfQ592GVwVi?=
 =?us-ascii?Q?+GfOL+5xy6DR5UGeDZn8dO/wJTI25sAWvqV2r1n0aKZAp2kawSWOPzwx2JFt?=
 =?us-ascii?Q?3et2XuC9Hixiqj9h8E6zvi92ral/iW7CL3JmUqkIXiLTwspyA5ePfS8yocI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfdf592-164d-4a31-38bd-08dca620001a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 05:19:15.3364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5434

On Wed, Jul 17, 2024 at 08:05:10AM +0800, Chen Wang wrote:
> Haylen, so you want a compatible that matches an actual SoC and use it
> everywhere?
> 
> Or we can add ones for each SoC and have a fallback to cv1800.

I would prefer "sophgo,cv1800-thermal" and use it everywhere. I don't
see any difference on thermal sensors between cv18xx-series SoCs.

Best regards,
Haylen

