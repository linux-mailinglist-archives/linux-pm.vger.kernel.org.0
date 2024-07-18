Return-Path: <linux-pm+bounces-11223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E6934885
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39F2B21AFC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD774077;
	Thu, 18 Jul 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P1SpwMaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2092.outbound.protection.outlook.com [40.92.52.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C18488;
	Thu, 18 Jul 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286289; cv=fail; b=J28PbfE8vNKiuffz+GYNJEAsmyMp5PKGcl45RvWimZ2OJ40wowo+F2Qx17iSOuOvTL7A/6Ffq40w8GgzeBQtDSBguB6+1Vys851np0Ij6sLTZklQnjRcUcLyQBGoW1tsEHj2VHMHf4D4k2UtyQodBj+zs2yLgXDeqm8MDKmHvio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286289; c=relaxed/simple;
	bh=gNBKP691WolSCJwdamCiuI2nr4ioa1cUZbsi7CcD/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cueZncEw70hKb5LBxluSA/XM76Ae/1B9+MgHMfmDVkNbje3FJ4SWSsgdGp2g8iNMkFNHpn/2p6ilkMaNeMkoovoxOeuG1PjwGxDYbIiXqyfqgMTFKEkTdj2WImu+RhlkCh901g2xEr8+5/x0Wo9J1dFtu9elqlHxIMU/mHoX6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P1SpwMaA; arc=fail smtp.client-ip=40.92.52.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzhJtP11ksi9fEbWDq58Wzx0rXmri9SIcWZyR7+2tzCvBhnHgUsAZfrtxeBPDBJa/HB7IwkP8v2JJ4rQiuRXT9JtmLNvweVM9quBojndrGguLSPeFrjhsMPPBc05pp8/eYOg1trjQ9Ja0s4sOJJjwyQRAfw/wOQk0fR0I0lYjcymlWCfUhzPFu/+8m09APLBEKZLNpWCGQZPbh1XadJqHB4zE9bG+Mv+dlDutGWwP5vG8a5yYbwQztpl4STU5kvNHseZ25AAo04hDdDbxNSR3Ib+xWRPqbnIL2vDeMxQ6+/YB/NpQy8caa9i2Rxzs/vyw4cQXTokRPJlcDIgmP2FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5auj5y2lzNCWipKBwXCxAnDsdpmcSFyJBdoh6ka9kI=;
 b=YVbhHtPw3EbctYiX34pcVbs5gsF3ICO7vRbTozYBam5GJC6n4Fxsu6tLxtIf7dzPQEK5WV+R5duempWX9aUjM38SpWPKidXge4H3+BKiA5T+BBYAFTaCXFKg9cGFgfoLgENe5h+PsJnkI4bbKhfvaeAHQni7K5dnJ0zhETKrTs7IPb3aWvMAU8fg66rniNdwYwzWFlGPVjVSOdjyUL4XULUdgBf6bOsHYf/FFhC+LU7kHVATouVFhjUbmGVWmJNMS8stTZP7mQaF0YNk98gAuCodMfP5FR5JjMRwz8uKVbX0lTRPZ3giUUdtWzbBBP8n4AJ+BsmFXzWuiO+jYyozmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5auj5y2lzNCWipKBwXCxAnDsdpmcSFyJBdoh6ka9kI=;
 b=P1SpwMaA+r7UPS9a9w/kSFhZKRmPpX6ptEdkt1KKFFuhFgKf3ABjxOmlpWIiTLXjSXcaLvqUSctDUc8bseuAPpdlyl5/+FHe2MAU0py59TSm3uueea0+htiAsMsBd22ud0TmGrAnZsBDR/dTt/pQqaABWGgzFUQ4Os94Jn/K9FrXfg0KV4OxS7jHHa5wc69RQCH+95CRO5kf7GfETgr5ZhsjS/dcWvZsJ+caImqJVSW8FHuNLSC07wmY7+1uXuqjiGwd5hDRpd+eG2VIlub6/M/ZKnwYgsdV9AVneszEjd/uGzFGOgVGsfPlCGd2u7QEVeWrjgGcDoD4tLC18fvElQ==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by PUZPR01MB4676.apcprd01.prod.exchangelabs.com
 (2603:1096:301:e8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 07:04:40 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 07:04:39 +0000
Date: Thu, 18 Jul 2024 07:04:32 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>
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
 <SEYPR01MB422112F63D19A0EA86726110D7AC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240716-cloning-canopy-a6799dc7f3b9@spud>
 <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <SEYPR01MB4221940059E23BCD8BA75125D7A32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <aee6eff4-4421-4122-be97-f258cfaa9f43@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee6eff4-4421-4122-be97-f258cfaa9f43@kernel.org>
X-TMN: [Fhu5y9x7YHoxkmcWymlrm7AUgmX2o2Jb]
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <Zpi-gAgAJ-0GdrPi@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|PUZPR01MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 7199b384-8ab9-4453-827c-08dca6f7e422
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|4302099013|1602099012|440099028;
X-Microsoft-Antispam-Message-Info:
	oCUAtI4wytXRAYNZC8CjXYCWD0Wng2zgDnu8r8fc8H4zm8+39wPgG58Y44CjYd/GnXIKlwCKo0FViOETtIUY29XrrO/MBl8l033mVDIWw5kJYUlRcsphE3IISONNi1t18lLnOI8rRRN3PnJaaAdSQJcQvo5Y8Q8OR1NQ0uX+B/BMa2JSNLEwfq/zaX7Jkxw1F2qj7/1vD/ULV98nmohcxm2b+6tuXqNAPQRFT9xHO/s/UwDJT5By4Pf+FU1ozW8T1VsU2TZPNr+FVONColUeHo319KED7EGsQqLLWiNbElzd4V5OhpjQXy74j9zLwSmubsuYdMUePRWch+ATf/21I+b3wlcvGQWWz5xmk0RtVu3iFaGeo23SO5GMiokqTEdT/XESUXe4Fy8jY+1MHUOWZHbFdFXttfeLK5N9Aq6SQFijZEHCkDoGp5TGBJ07+RJTd2y1VGVp7KCkUYjq557YT0Q7y8wGtr6tZYx81PBqYn7PmmG0wccn4kljCBOl07B3youx3KfPLutUpoLFAYdRm2kV5q6ROBZCBJZ07rMzwslmtR6loLI9giXyJLGhpRCPab6bf4NKNR702k5B47ld2FppeS2SPVmtMPyoxJV7RtD4C8sgLYcVi27g6uE1X3bjq1c2GheureLwDnQ+bH691zInqemVXi8eGnWLeeFoemfQSsa1fwDrN9LWfhw0phE3nkcvaI3fbYD8Ia/5xAStT3LbtvgmBZWfFiLE6rqKdrPvZh8xlyD1wQKJel2dOEeo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVM7k9Glh9P/2bQ3u6SAeb8NSY22kjw1/d9xn7zY28x7SQ5vICJ9a72VlS7M?=
 =?us-ascii?Q?PT8PmlR6AJYu3wR5W1MC84MKImSLPbnHQ0pfUVif6897ZL+sMWkZYPuXgqk0?=
 =?us-ascii?Q?O2I3IwZKC1casOQtmE1r1dWBOEjjw0ahf3IsXVF7jPe50t+GKQDbsYZfrh3Q?=
 =?us-ascii?Q?7bFy34hSDCFqX1ePzHf3q3tEL41UlWKXzJZrnKdAv4XLO3UlQVe901sM4WwA?=
 =?us-ascii?Q?NaV6BFbHCx46ey1uTonsRno7ecEQ4vh4ASPRSsBkqXMo7JPYeHoXYShSZVGC?=
 =?us-ascii?Q?eAWI58ySPddI8FD7oo7g13k3hz4PNpU+1TY9++lWVlqGQRGvQQife7ndNwxO?=
 =?us-ascii?Q?Wmpv0GmQjiixZm2oJ23gvcvXxRUIq9I7rfyKMp3G3Ht8aErESAZjDayuJk/R?=
 =?us-ascii?Q?o/yjJ6WMv6u/ghpZwDzxF3dDBAkIEaQcfYkU6iJHaclLeqp7Hfm9eo7IVk6K?=
 =?us-ascii?Q?cLaEBZbw3tq/8CtXe8sBfS5hy8r/6u4ryZRIzwzHJfsKftze7VD9JnRMZ9eX?=
 =?us-ascii?Q?XcCFWLVCh8dFFHZ3uzsGiPZpRcfYRhje8ITa+DlWGKVmO6UUOtFZrVnt1ZM7?=
 =?us-ascii?Q?fnFocwR+nnSWbZKLUSEvUusZTooNelUW1Ir5/ym2wzbrutxxjMvdTD25853I?=
 =?us-ascii?Q?Ben4qBlgJW4DM+gN4M2TVHtexqryCdVRWiWQ/uBvWIUya0EWXzHBgPWLYfXb?=
 =?us-ascii?Q?8/s3MteF9Qq0UMAeLXK3BPlsJYjM2lsJkUHbZI9VF/FY1Kl8gWxWnRjix96E?=
 =?us-ascii?Q?Bk5RNc652TwPXLIHAxWJOEMbk19/RD2j3r/Z7cajL00L+aHS9uHGMofUaXqf?=
 =?us-ascii?Q?/Di4odYz/gP1bARfiQfRZDciG1gL+bieH6zIp926GaoxjjE1+zJTV9GR1UJ+?=
 =?us-ascii?Q?pv9zdCpsHRzhF74MDVHk2mM2I9LrPEUUh6liSgfbiadDZSCez3tPIsV+geL8?=
 =?us-ascii?Q?PeE7TUxi7JAac3g+lQ1OZJUKlu3TWohnzUp345cIM7ibdL3U2q+eirH/fUoi?=
 =?us-ascii?Q?tt5L/PyMbDIuFnk4G6tDRnPoKFQiDkDLz3kbgpIyoTnXVWZ6lV/PtD4G7+kW?=
 =?us-ascii?Q?956F3hEVLoO9xq0aRdxoybYhA6JbItDNF+FHOnlSgeVBTOLYHb33Pjb942rU?=
 =?us-ascii?Q?sy4IP0jyGLtPMsf1WWkfUNhyefjCREikF5V8b2X4H90zuG62y1ClQpfh5e7L?=
 =?us-ascii?Q?qBYCkrEmIyRqHByvT81YxoTYJ1ypul4kOxWFqia1qDjp/n6VAtYX5p6uxng?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7199b384-8ab9-4453-827c-08dca6f7e422
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 07:04:39.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4676

On Wed, Jul 17, 2024 at 11:12:52AM +0200, Krzysztof Kozlowski wrote:
> On 17/07/2024 07:19, Haylen Chu wrote:
> > On Wed, Jul 17, 2024 at 08:05:10AM +0800, Chen Wang wrote:
> >> Haylen, so you want a compatible that matches an actual SoC and use it
> >> everywhere?
> >>
> >> Or we can add ones for each SoC and have a fallback to cv1800.
> > 
> > I would prefer "sophgo,cv1800-thermal" and use it everywhere. I don't
> > see any difference on thermal sensors between cv18xx-series SoCs.
> 
> Please use proper fallbacks - there is a very specific rule, repeated
> many times:
> 
> https://elixir.bootlin.com/linux/v6.10-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Just in case I misunderstood,

You would prefer different SoC-specific compatible strings like
"sophgo,cv1800-thermal" "sophgo,sg2002-thermal" added to the driver,
and each thermal-sensor node contains two compatible strings, one
matches the SoC exactly and one is "sophgo,cv1800-thermal" just as a
fallback, right?

Best regards,
Haylen Chu

