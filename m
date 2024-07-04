Return-Path: <linux-pm+bounces-10585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2E9271A0
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32EDB21281
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEAB1A3BC6;
	Thu,  4 Jul 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OvBr/r6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2014.outbound.protection.outlook.com [40.92.107.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A411A0AE1;
	Thu,  4 Jul 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081528; cv=fail; b=FVT8iknuFtbU9XJf0U2JMtnTASPs0RQEZUJbe2zUchy+p1iJ/IXfD0WycRYU/800T3ldeiRTHrOuOyCec5YhdKpeRLb2KtBjVomNVoIxIxSmFp0XNkoh33ftQBszm1xQ9nTFq0Dbo0lMJYMi2ULVCXyazPAAPwt/ZG0HCZWDtps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081528; c=relaxed/simple;
	bh=QK18plmTg2BlOtoj1Fb+/02rnri3VkTB1xdwWQjaXHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J6I0oP1QHd/zljbOYglYmFlj6JdlGVKnkf8spqOmHbFtH2jyh/YBmz/PJx5+Kf4BIpRjtHdNU7QOpQzTKpOi7RIkVSFzKSijJrhd/nzwqcyKqWRcGA912rmXuZmgOfMdsEr7OVc/uWCMLJOWs9KUSw+1ddqYDTtpPk9PYq7dub8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OvBr/r6e; arc=fail smtp.client-ip=40.92.107.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJhHaQ9s59ca0JuWPGFWPsxqZoUYw9T/SqLz7nRLOalj+VqcQiN6qGIyjMICcJKble1Eb5kHgcvnr/JszFLN1qOB9poGZGxlAUJheCbRrBPogxr7QAOK2Al4GIQaGQKdbcZaE7WDzZiDm87J6wTyoPPGJN+wIuSzHMzoC/8c0Rn8Lkjxzg00nLGpo+0BZaqLBOuzaeouby20+7BkJ1Sb6d50/ZUG5jYxi3amKvcrA+fEFllC6poTwu3lGiosIT6YXgMpw3GjWHX5Y3BPcTmZAS4PwhilDx15/YOtst7lNioWKtb9/b78gBaBWfcf5qX5hAQ/iZ3mHmNLJzbBq3lkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD11hrxaN1fVPtS4IvPg21+IKRi+5bTinwortJwHFX4=;
 b=ZkxuLj419lIwVH1OXFIOTyqDfwIrol4RPmxT3lVeZG8lJAc7ev+TnaYi8qdGrz2ojXL8vkJ1x5G0z40aFUPkx9HEieDTB4PhHzq4HsJ8SjgC4uN4KEjF/MY0coeSAUwzXwi3yOpAbZdJJclO6heXs2eJLPfGCUKcwGJLoRKmEZjn7C3IRgbbjsSo+T558zbjbCvdsmNJYfI5T3lLQL9YpMnk38NvGfiz/reHa4mBo60vjto0W3Cqe5TV2kaWZzuoHlnfY5FGndtaA9VM8mRbizMW6kPR6kfHSzU066RIvqAGF9Lj1sUB0Lqho4FwRdHN9IfS1ftWsojbye6aWG01rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD11hrxaN1fVPtS4IvPg21+IKRi+5bTinwortJwHFX4=;
 b=OvBr/r6e0Y5keEY9EgSFacUcWBV94RzGStQpVRs5fbhcdU/Ai9XbfcmWnX+y+GNqc6hUiNT0AYV6Ia6sj72sfaiudyiuyzjCS7fE1YOiIIia3zcuP21oo67KPxMjYYHlkh6FmB/ykJGdfYJTx16IdUEeW7OsVSTC0G7dKE6L1mmvEjAW0P+xdNY/ii1EC+hl8gBGruVAgo+GOoO3WC3E7rINdHWgGMbSw68WKNTP10hV8glt7Y/fYQcmcbCS6V0sn7uQs5++sJXZmnux2pdIHBn/8nOYZz4KpfxQOgDRFehwFm4aJOvGleqqa6dybU+PFk/wQEB/ZjRrwMbVqr2LJQ==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4504.apcprd01.prod.exchangelabs.com
 (2603:1096:101:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 08:25:17 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 08:25:17 +0000
Date: Thu, 4 Jul 2024 08:25:10 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID:
 <SEYPR01MB4221C23C14DB53299E2E2F12D7DE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB42213F3A032C60C6AF5EB677D7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42217228213F5F2C739088DED7DC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <20240702-aptitude-overripe-8ac9aa3c6b90@spud>
 <d4b71376-2864-45af-8ad9-92c8a7cde291@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b71376-2864-45af-8ad9-92c8a7cde291@kernel.org>
X-TMN: [lZI5nQzC7oq0EPAHjeIZBqjy4HTNnJfd]
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZoZcZqgI2flzBJ1N@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 9856da1d-482f-4485-b0b7-08dc9c02d5d7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	qEvZuUdP72xF0ebWPV3hNwWHuvo85DpteMJr7LqKPry3JT7Rx4j8BctA/0tFYZD936G7cyMUtyDYnLir6AJ+EqelofMXBbXREdsBPbJIEPVZCAZfZBWcwkd572LBZlNlx7Vf5/beDwyz4lWyGnqwuOAz/+e4Fh/6d0Jty14BcBCaocnnI+UQ8Ov2MRgvv62wsVC/uTXMuGC8yk+hOl/4YNfVXaM9iMToq+2yjqfp0KFhn6zlEeXB11ZUS/eRJaefhzVAmwA7Ly5HMLDm+c4zNSa0BgjkRu6m/8aRDlNYaKMolMIdYVyxFHqxI33WTrAqcAoqBTr8YxnCzFoKT8q1bgcBmwllsWNO8lmqfv3fjggPDYMXII7xQ8HMfPs4Wwnb15r9J7DYzHjUncXfTTzg32CqyVFCahw9bxBGQkpcv/UConMZ9SIWJGwW+jgxWAA2usEt0D0urrQjLI8TnXWiUFKl7pQvNon2CIF1Wq9bDorh5xpO1bMkpE08G5XWpWgu6rkEp8YqNdVEpsLOFImO4N3gr0urMt39TQQogYJ+OkbxrztNtSUHhTow+wdw7MXa0L5V0YLyb8OI62bNjTvaaB8p4zgVnSJHVlRMo4kBeBNnDu2VQO2QADMF1EZhM3oT3295FzC3Ty7cfw+x5+O55nIu1EFBkCIljEQDtp3Tcrhun38l24jlc0aLmY0z6rWeP5QUh1Ceev7Em+M8KYnAGDbPg6EFWTzmxYsoPJrUlHo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zy/aijjHp6kxmfhvroIQ4KNsS1RInR3QwAOcUJYyIbMvwTilDsAoj2vqMY0l?=
 =?us-ascii?Q?Yr0pTnNBk8M+JOYaPy35RUNoiZgifEOjrcNA3pI2jdXHcoPz7+f4dyBB4EDE?=
 =?us-ascii?Q?ADR5xEHYXBNfO2t06Jp+tOndXX3s330PuCz11AVd5PkNt69yXQK8Mzsrt6LB?=
 =?us-ascii?Q?BLZlBjpgAKe1ccH1pYhFhKwQ+glOwGi7Vxcyr9bD2jm9XFyhnxU6izUmdh7h?=
 =?us-ascii?Q?zTFFZIwj/uxfi/O/6EZMXSLLk7/qGbfiaf9ioGpX6Pl6vmin22p5cC28I1FS?=
 =?us-ascii?Q?uyHPzN1Fy3/tDtuAlsznC+moNmKcnogSay0Ytteuj8TQZh1/XOsHcp/dFfCa?=
 =?us-ascii?Q?RhwKCjAbeXTRjtlOJX4ZNIrG496InU6bp1UpgGKxXO8gNVFwOtcU+95f0aTk?=
 =?us-ascii?Q?A3GWEBbxvjkePLvZ1YLXYmvxVUoWGAUiDn1AsF+XCMcEXhSNhtFi0y2uDUvt?=
 =?us-ascii?Q?d8NIKn2yCtTOLGST7VvcLaHoMCkhUjK7BL25DisyMqNjbJxfA3WuMsJHAhWC?=
 =?us-ascii?Q?/UgA6bdaL7oslvDulOAEf+xlk7kZRxP9PqAzWY4tJVET9iWzwKNUwFwRJqKO?=
 =?us-ascii?Q?dOvyCQ1w1Lhc8S65Mvt5ZzFDRiv5P9g6O/XM80/LIcyySJ+3Dc1E49okDGRj?=
 =?us-ascii?Q?QGQ4TkrvHVI4CcjHCjgkxgj7emNXvEmzIXfuRA5RZ6XubhGRIuG1nBXlJ9eC?=
 =?us-ascii?Q?V0FOORgiWJluGR7GvThH/v/4nDtg9nqcwclm3TJ7E0A21RkLqW4VGyb/8GVR?=
 =?us-ascii?Q?BCMli73ANPF4oFINyEwWkmAtlUwwgPMAtNdHSHzGFCGHy9HTzRYwBh5N6166?=
 =?us-ascii?Q?G37mYFBn/5YzT3w1kOV6wY1wkaPvR9GwlaH80aOQcDtNF3tTfzAmeHnY590B?=
 =?us-ascii?Q?EhPoMfEfxAP2WJgF/TZz37zuBIVOg6kuO96Q6rBTV6TgA8Nj2RNRh0rOgJfc?=
 =?us-ascii?Q?E8US06OEREYViEv0f+cGAsPfRJrte7ajdF/NYPifUJbUy4+iTIC3akeZCWal?=
 =?us-ascii?Q?1PNQz21UeMJvHmCJ9ozd5Gsa/bKE7tdf3FbHLv213F7k44tsbR4+DAw7oyyC?=
 =?us-ascii?Q?3jwrQtexwPjk/2f4Kh8fgFtAwO3xp7APJHK90em/ttZwRNygxDHUKOcnNJ3x?=
 =?us-ascii?Q?BsVQXgR/t9EPG62KzjAlOzWvqGnOtM2Z/1q8pRwghb97L5V3LYsRjZh/pdqC?=
 =?us-ascii?Q?iME8kmlJ7QZ4yyNt2V/PIK7+xCGM92dFiQ6ECzBlYJZpCLJ5yaQ2ffZqs9A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9856da1d-482f-4485-b0b7-08dc9c02d5d7
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:25:17.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4504

On Tue, Jul 02, 2024 at 05:09:35PM +0200, Krzysztof Kozlowski wrote:
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - sophgo,cv1800-thermal
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    description: The thermal sensor clock
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  accumulation-period:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: Accumulation period for a sample
> >> +    enum:
> >> +      - 512
> >> +      - 1024
> >> +      - 2048
> >> +      - 4096
> >> +    default: 2048
> >> +
> >> +  chop-period:
> 
> period in what sort of units? Sounds like time to me, so this would
> require proper unit suffix.

In clock ticks.

When setting to 1024, a time of sample takes (1024 + 2 + 64) clock
ticks. The clock runs at (25MHz / divider) and the divider is
configurable.

> > 
> >> +    description: Period between samples. Should be greater than 524us.
> > 
> > The constraint here should be "minimum: 524". What's the upper limit?
> > 
> >> +    default: 1000000
> > 
> > Rob/Krzysztof, could you comment on the suitability of the three custom
> > properties here? I know if this was an IIO device, these kinds of things
> > would be controllable from userspace, and not in the binding. I
> > mentioned this on the previous version, but I'm not really sure if
> > thermal devices are somehow different:
> > https://lore.kernel.org/all/SEYPR01MB4221A739D0645EF0255336EBD7CE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com/
> > 
> 
> Why would different boards have different values here? Does it affect
> accuracy? If so, how much?
> 
> I doubt there are any boards with different values, thus it sounds like
> unnecessary tuning parameter.

Theses values affect accuracy in a minor way (about 1 Celsius degree in
my test) and could be shared between CV18xx/SG20xx SoCs as they have the
same design.

In the first revision, fixed values are used, and I was asked to add
support for all possible configuration[1]. Now I think this introduces
extra unnecessary complexity and should be avoided, since this is a
simple thermal sensor, tuning seems to be useless.

I suggest renaming "sample-cycle-us" to "sample-rate-hz" and dropping
other parameters for simplicity.

Best regards,
Haylen Chu

[1]: https://lore.kernel.org/all/IA1PR20MB49533177BEFC431FC16D1AB8BBF32@IA1PR20MB4953.namprd20.prod.outlook.com/

