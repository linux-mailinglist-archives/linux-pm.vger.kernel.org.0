Return-Path: <linux-pm+bounces-33581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B0DB3EDE1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 20:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A2F7ADA62
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6422EC0B7;
	Mon,  1 Sep 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cKWCA4TV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cKWCA4TV"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0351C3F0C;
	Mon,  1 Sep 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751422; cv=fail; b=Y0kltyYqoLh15iHDyMkgCjZqk1bXw9Cf73GcVhcnqURPpccLRlr2KruT7E0eJe5DwrEWXlHlgWcxXfcBhY5H8xIYeN58tm/36PemDlHGcEYEY5H/lezXYtAFH6n9BtO0Ffcb/pE1DTxvkai1ckn11AClP8CmM5XIXtYwvvHwoYo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751422; c=relaxed/simple;
	bh=wazawv6BJTv/sZagiHiHvgwFnvFJEaTFEK+VKmv1cWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNVH/gQh8b4Wy3V6Vf+grnzqVr/FWTo3Upw6Y/3g2A4pT0kFfnTFx8cMXrlxk7urMaZ43iTmM0dq2NtQupry8D3BK8qmc454cPeQsK7zsYc+czp9RhnEGDavyUN8rGjEiPRUQQrmX985+StUaAZhVK5NgkAOPTpDVHpUOe8nL3A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cKWCA4TV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cKWCA4TV; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BRKMdENH5Dfg+XfCmfQY7egDIhsj7nwlCmtOXXmmrArsdynLcdBfkEdhfqAJt3yX94cRe6H1nIJbgBbBOfPU3Xda/8txrnLMqIt6hj0gxBF0AWx+zNuI7cL3OJspVwkCLzSfae30CRsbsEawM82Eh+5j/dKbywqoXq/33GoWZhDIOOkV5E5f3SYhmCBbdoeAHlXiVO7mwXXfhFBM3mioINaDvgx1+W5yI3GO0BNaxlwbgSGRxQuNko74/Zp1SGSpI+BrtRkEryzvAjJaKlLctcTfDHgspryo01ekDxUoXUJuxu0LTR3DLLYMpBhyPRozZvoaunyuavHEFKExKVhpTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPjGyvXoX22tStxlHYCUnEFuq76h7WWSQxyzpnYzGlk=;
 b=jTntQ2YxLRulp/sjfB80+IcdDV5SRV3YwWe5bQVfIhXci1TTBlvMV0hQGGBnJ55mE8R9kyN9bEYQPsaisHLwnB0SUzl1fENENNovo+thsJ9qCl3zcZ5CrvCxNHc9Z/RDhlmWJT/E/dq5tNfMqamMoGK2JUTpOEjTmj1FAx6kWGyA3t6fUzNtVP+6Jj0RP/5CUUXLaMsMjskuUsoAu92oh6nj4pBIfnpkJkiIof2wOT5gzIiq8URGbdZWA+VC/L1rrq+E/zCOdy2bOeZeU98RHUQQmXcB9pdk0sUARgLYWsweiihXeL47k23XW4uwuFwUdkUS1S44c3q0Gmv2tuLdeg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPjGyvXoX22tStxlHYCUnEFuq76h7WWSQxyzpnYzGlk=;
 b=cKWCA4TVZcV/gtRfuTKgUzcGNbyBfad+YZf3126okiNN7VROYeYvRpwLqgIGObPrO9soS+2KzyIJSnjNvmrboQodG8NoAtKRDUL8z2Ydf5TXkofquk54oiUygjSaw1r5A8n4WkgRjbnv7FOMb5woVDEYo8f9ikfNB1MvMtdXiww=
Received: from AM0PR03CA0062.eurprd03.prod.outlook.com (2603:10a6:208::39) by
 PA4PR08MB7521.eurprd08.prod.outlook.com (2603:10a6:102:26a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 1 Sep
 2025 18:30:11 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:208:0:cafe::a3) by AM0PR03CA0062.outlook.office365.com
 (2603:10a6:208::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 18:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Mon, 1 Sep 2025 18:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVzVy66yV/eur/GUEdeR5YqxlaBtFpcheVM1EZxlX1VHtyiXN2AdnrFiCGmtcxtqYL4yA1ps/1mN3OGqnm+UC+n1lC0/oz8Y1Mf0sEYtljfjvtJdy1Fwbby4MXfk51LlYObuJt8AYLt48qEWB7Iqjs86XowwfDT6fwbC1Ka3H+H988sBOdaejD5Dca7PCJeVbD5FZhrgNWosYTQ6Vz3LoWAq5JKnB6m8nks+KMEomZb27wALPSpHQFx8QqC7Kmrxwap8hiu+B8dafsurhAZF5rJRiwj1MWwQcufd5sIP3uXEY4SJJtcqDHI8Fxu2klQxZ9NljSt+NXA1JDfHnbvyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPjGyvXoX22tStxlHYCUnEFuq76h7WWSQxyzpnYzGlk=;
 b=HIUU7mPuV6vReXgoSxeYGS6vhVc/ORx9Eqy6aJ4Zvzarc3X3wy14Vl7+ynvG2jTa+QPWBePvYdQ6QsyAswyVVzFKWuWwXrUnCW4evnRj+GxRtWU6wpQ67edACJeBLMNQAvW5l84NBeahBivdS69CFRHcL3D/z2JSgOgou2kjLt/ILMDcng0lU83vgOtitE+n5eYLaaTIJ+f9v60GH2l9Ebb7RMbNimXv2hKD9ADudxFIDGM78Nlt0g6uAl4h1SU+QcDFhh95gsA0TKJdg5GhgWW7pKtPtxXwPGCGxjSOqz5haOHvBIQm1xeb8bmXOdqfwBFJxaK4RGUk1sXyC395LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPjGyvXoX22tStxlHYCUnEFuq76h7WWSQxyzpnYzGlk=;
 b=cKWCA4TVZcV/gtRfuTKgUzcGNbyBfad+YZf3126okiNN7VROYeYvRpwLqgIGObPrO9soS+2KzyIJSnjNvmrboQodG8NoAtKRDUL8z2Ydf5TXkofquk54oiUygjSaw1r5A8n4WkgRjbnv7FOMb5woVDEYo8f9ikfNB1MvMtdXiww=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB7812.eurprd08.prod.outlook.com
 (2603:10a6:10:3b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 18:29:34 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 18:29:34 +0000
Date: Mon, 1 Sep 2025 19:29:28 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/5] arm64: initialise SCTLR2_ELx register at boot time
Message-ID: <aLXmCJOuxCHVXEYx@e129823.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <20250821172408.2101870-3-yeoreum.yun@arm.com>
 <aLW4A3rTcJvA0c+j@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLW4A3rTcJvA0c+j@e133380.arm.com>
X-ClientProxiedBy: LO2P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::29) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB7812:EE_|AM1PEPF000252DE:EE_|PA4PR08MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: c35930a6-f4c3-4c12-4964-08dde9859599
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?UlWI/x+N1XY9ZDm3Qzd+y3dcpaxup2x6cUumcW+AxWPDf6WMnhDaViNIKv98?=
 =?us-ascii?Q?XImZHP7U4sQfUCTjHSGKX7xuaZMvzdqBUH+Z/qTV1e3B6x0JaB2XU3ItSIQk?=
 =?us-ascii?Q?zDZva+mEMtkNTmYhaFHC4fsIShMItrrekAAlizS6J9qmT0mGJy6y/dHcUrWE?=
 =?us-ascii?Q?ufxEREKkW5z9II3SPLSRp7yZTe/DvbbFgJVD0/Z/mMB7rGiXBR8w+e1LS1SY?=
 =?us-ascii?Q?gAvRHP7vdhbjkPp2Dmth/LvOPDPzH7abZcXLS9E5T6xYE5QXjp4TxJ+SI1Xj?=
 =?us-ascii?Q?rlyKwQnVsjy3MwzOumIwJtmCk5L/53O1Q8lTki/6AdluJNSEn9dIsLSVPWwi?=
 =?us-ascii?Q?mb8rVInYj5vULezq3iUfjQIkT1s/fi0zNJAKCJCQW6mkj08p8SAPf/OK9qdc?=
 =?us-ascii?Q?83ruBZ01Xk0FFaS6n4XE0/7ET0i1kRxrRpT5k+7nJGv6NgHoc4etb2Ce2qEY?=
 =?us-ascii?Q?gSJuv5uuZqqgYBw9sLEK0Rbekp7Z2rXS7XPIFz4PboehcxX7b1qYyzL9/tCi?=
 =?us-ascii?Q?DKtL1BYzNuYQKg0eqh/vrPmcyte97m2g9g41EtKPMFYJ+x6cvvigAuW9LIwI?=
 =?us-ascii?Q?S1FqZ09cQUyqX1vE+cVRY253Oo8qb/3ih6rWUbF9UmvE3fXCLY/nCTOIYEnS?=
 =?us-ascii?Q?1sTJkbueXhhcuFrV8xtvbMlK8mobUJJC73aFRouf+Sk3p0b/MHtHCjYQR1qK?=
 =?us-ascii?Q?fkaY1g1AohPFxHgnJawSXT2FJKshhnr7H3iuW9IA8ck/b0wxMpXgF7TKeQ6j?=
 =?us-ascii?Q?ffoc2W5/41ubI6GGeFbTm8KqK4lCcR6853i59oL1WwkfbRJJj7p70Sz3SIAt?=
 =?us-ascii?Q?vpHQGKr43VOSGTF0opbjtCfgYrdfvRrHkTSIfjpDo3ISzOpbVqQ939BlcECs?=
 =?us-ascii?Q?vpZeffYgNzmrbbvq8Eq67KO3gLx0qjgORcAKuaPuiaP3Uj/o/i3hLFfM/VQy?=
 =?us-ascii?Q?YdyedUMT2KJivaugvXGtw4L2X/ZZykmIglIE0oQSh3VoC9J72XoDjbQ8y/sD?=
 =?us-ascii?Q?WWvBOk9Tuh8HzjdZc+ZkauOLmjboB3dPqw6YajxG70NfllMla6OBGPigrh/O?=
 =?us-ascii?Q?a2g58I6hpAnGC3h+N2o48vC2wYdCHpTY6jqRvR7FU9vIWOq+TuV8lUbaT4no?=
 =?us-ascii?Q?W/tKkHUHuPLys9x5MVdgmRzEljsKs+daELuTAGGM8L1uzvN5By4lr5uOtypv?=
 =?us-ascii?Q?8/lS6r/ZNMYivA7ygDNelo3QcqakZkBlbtM2i1WEXCQhgpC+0QuSfj6r9kQY?=
 =?us-ascii?Q?DIlSSdEWB25rTi/HRnkra4Fz57TtoOOQ/t863L8KJXwbYSQ1hayxeHS//p9Z?=
 =?us-ascii?Q?TLW7ig3wewgwMkJrPtUDMJm+c30v9NiimsH5u1Oex1lGBE4e9vU69d6SECo/?=
 =?us-ascii?Q?hlteO5eSxSO40RP7j2Irw3RvKmz6lC9XLabDwa5g4ogZ4cdf1V0eiRbGIorI?=
 =?us-ascii?Q?/d4Tm+Hryts=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7812
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4df3815c-d2cb-4785-bb72-08dde9858004
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HbYI752y8GyCue21dS3HSRtZvwU75fT0poXLzNoPoZtZnPymbFxB9b+JGHce?=
 =?us-ascii?Q?7V4rAsoWCC1qrfyUlxFvN2fECvHQ+XBySzOb40ciojJMKSGpXcotD1a3tBZn?=
 =?us-ascii?Q?I4kKtiosBhaMh2LYZ9FAfKHzHl7ZWJNQuppEKHf7dqDqsk37/hGkq6NE+smf?=
 =?us-ascii?Q?mqGx21ZdXVO5+npBhGhTHV9DS8OqgioQirnXlbqdb6m5DK9weE1G58c/+YaR?=
 =?us-ascii?Q?Gma4RmleB+ozmjbbCNfEVgwSkyZE/aEBaPn6nq5LyQB6hByHm/eZOKQa5BcA?=
 =?us-ascii?Q?mfkwMnoBR0T344wIxobNkUkT3ZDx/mvaNY1kWSoWWYJ2r57fEnWk8xOxk+Y5?=
 =?us-ascii?Q?FzXOHvPtahGGg0+1zwpKoAbEEQ6pkognkPw+9EFwQTAjpF/Pa/OUiRs/DLEr?=
 =?us-ascii?Q?0FBErhCRLOGCBgudN2s3M2tpqwsqjdjAE3Q4itPSk1kGSnk+sDaxb5N3upt7?=
 =?us-ascii?Q?Nb6EVuN4wwRNZHyAxshhCFJ3igekSe6xJRfk60L5GFK/G8eIenaG8zWhOPBx?=
 =?us-ascii?Q?WXHHd/9zRNqAJ/PXpRGQyco70FWbVsKuqGF1feDV3skRancigRQYh118ASYf?=
 =?us-ascii?Q?rh+Oqecty03rfYUKlj6Ka2uuIujDTuZwB+gkgo36EXs9zgKYRomkV9sQsiWu?=
 =?us-ascii?Q?UQpAYjyUx5HMNDjBcvd8UPwTXohJFydGtEERESLzZ3eeL3EdI0Ll/jVtBfkc?=
 =?us-ascii?Q?/ttR1LWTdMbnbeQ5g6xYX0L5nO58krksqxXKQvdXMyAKTJ7TOMfQJKx68A8x?=
 =?us-ascii?Q?3imfOPkDj7UBOmcAJS0i6nr9QT5U2ErA7vioE+DaofZKZfeoQQdsP6N86zTf?=
 =?us-ascii?Q?DfVVFtrtBGCEmSZncBMRPwBGvZlMLBUBWe5evhT/n4RdF1kYdZEuoqJxyx55?=
 =?us-ascii?Q?BGDm9xJIUyUzzWvbPQsyPasboMKR6ICI9Dg+kkeqX2cbli3ewfzBZUWIpYGF?=
 =?us-ascii?Q?GYps+Bnu8LxHcpmEfHGK3HseGv1jjY22PcDBhOpn5mmEYtwJlB8uxYId1J4F?=
 =?us-ascii?Q?opyeGc05A6BSbi/FbEavgSDlJwEui5i9oxRTZarltumZnCIsfRkOB6SP9T8E?=
 =?us-ascii?Q?ARB9Wd/Go6ga5AlXTFZ8f0Xdf7vbnW5dxeS6iT4VdmkB2VKcQJsifpX5Ow6t?=
 =?us-ascii?Q?wg7UfBDUVbpQZeqTNwQ+QaxO7h+LnRQB9UrDvhnEfTcWSG+LJaLlNc6gn/yk?=
 =?us-ascii?Q?mZQprijl6tw3s3R2sO7O979IqNoJrQnqrLeozu4ZzKtZI2vVtunvHqrFL/Cp?=
 =?us-ascii?Q?a96JGMWbMeKKbD//v2bOGkSP1D6GJB4Ui+pGjRhxDBI21rd5XWMn0+f4LEGU?=
 =?us-ascii?Q?NaHUxKDCW+lYgpEk5n2Y5bqT2GTypPfb8elBcBBqWkoYzxeqfqK1sORtWn4W?=
 =?us-ascii?Q?RXMfB2xthIENseHDUsIhBZ26mA/2zSS++5Tx//CuESfkQQdhkVlDzzCvP+jE?=
 =?us-ascii?Q?+WBb0oCUoM4+XBA1eliMbjOLE3MQ13rvVepq53RbLDkHkYuvQIMF7ABqpJTP?=
 =?us-ascii?Q?/BdaK0kvw9qE4wAbiECYi78+t4Qa8tIN1ZHG?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 18:30:10.5241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35930a6-f4c3-4c12-4964-08dde9859599
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7521

Hi Dave,

> On Thu, Aug 21, 2025 at 06:24:05PM +0100, Yeoreum Yun wrote:
> > The value of the SCTLR2_ELx register is UNKNOWN after reset.
> > If the firmware initializes these registers properly, no additional
> > initialization is required.
> > However, in cases where they are not initialized correctly,
> > initialize the SCTLR2_ELx registers during CPU/vCPU boot
> > to prevent unexpected system behavior caused by invalid values.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
>
> [...]
>
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 23be85d93348..c25c2aed5125 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -738,6 +738,21 @@ alternative_endif
> >  	set_sctlr sctlr_el2, \reg
> >  .endm
> >
> > +/* Set SCTLR2_ELx to the @reg value. */
> > +.macro set_sctlr2_elx, el, reg, tmp
> > +	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	\tmp, .Lskip_sctlr2_\@
> > +	.if	\el == 2
> > +	msr_s	SYS_SCTLR2_EL2, \reg
> > +	.elseif	\el == 12
> > +	msr_s	SYS_SCTLR2_EL12, \reg
> > +	.else
> > +	msr_s	SYS_SCTLR2_EL1, \reg
> > +	.endif
> > +.Lskip_sctlr2_\@:
> > +.endm
> > +
>
> You were right that just doing
>
> 	msr_s	SYS_SCTLR_\el, \reg
>
> here doesn't work.  It looks like we rely on the C preprocessor to
> expand the SYS_FOO_REG names to numeric sysreg encodings.  By the time
> the assembler macros are expanded, it is too late to construct sysreg
> names -- the C preprocessor only runs once, before the assembler.
>
> So, your code here looks reasonable.
>
> But, it will still silently do the wrong thing if \el is empty or
> garbage, so it is probably worth adding an error check:
>
> 	.else
> 	.error "Bad EL \"\el\" in set_sctlr2_elx"
> 	.endif
>
>
> Also, looking at all this again, the "1", "2" and "12" suffixes are not
> really numbers: SYS_REG_EL02 would definitely not be the same thing as
> SYS_REG_EL2 (although there is no _EL02 version of this particular
> register).
>
> So, can you use .ifc to do a string comparison instead?
>
> If might be a good idea to migrate other macros that use an "el"
> argument to do something similar -- although that probably doesn't
> belong in this series.
>
> The assembler seems to have no ".elseifc" directive, so you'll need
> separate nested .ifc blocks:
>
> 	.ifc	\el,2
> 	msr_s	SYS_SCTLR2_EL2, \reg
> 	.else
> 	.ifc	\el,12
> 	msr_s	SYS_SCTLR2_EL12, \reg
> 	.else
> 	.ifc	\el,1
> 	msr_s	SYS_SCTLR2_EL1, \reg
> 	.else
> 	.error	"Bad EL \"\el\" in set_sctlr2_elx"
> 	.endif
> 	.endif
> 	.endif
>
> (Note, I've not tested this approach.  If you can think of a better
> way, please feel free to suggest.)

Thanks for your suggestion. Let me test and check about this idea could
be applied in other macro too :D
(But as you mention, I'll apply this for SCTLR2 in other patchset).

>
> [...]
>
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index 36e2d26b54f5..ac12f1b4f8e2 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
> >
> >  .Lskip_indirection:
> >  .Lskip_tcr2:
> > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	x1, .Lskip_sctlr2
> > +	mrs_s	x1, SYS_SCTLR2_EL12
> > +	msr_s	SYS_SCTLR2_EL1, x1
> >
> > +	// clean SCTLR2_EL1
> > +	mov_q	x1, INIT_SCTLR2_EL1
> > +	msr_s	SYS_SCTLR2_EL12, x1
>
> I'm still not sure why we need to do this.  The code doesn't seem to
> clean up by the EL1 value of any other register -- or have I missed
> something?
>
> We have already switched to EL2, via the HVC call that jumped to
> __finalise_el2.  We won't run at EL1 again unless KVM starts a guest --
> but in that case, it's KVM's responsibility to set up the EL1 registers
> before handing control to the guest.
>
> In any case, is SCTLR2_EL1 ever set to anything except INIT_SCTLR2_EL1
> before we get here?

Regardless of VHE and nVHE, between init_kernel_el() and finalise_el2()
the kernel modifies SCTLR_EL1/SCTLR2_EL1 (since el level in this period
is EL1).
and at the end of finalise_el2(), kernel switches to el2 and
if VHE, it writes the SCTLR_EL1/SCTLR2_EL1 to SCTLR_EL2/SCTLR2_EL2 and
initialize the SCTLR_EL1/SCTLR2_EL1.

Although there is no code to modify SCTLR2_EL1 between this period,
as SCTLR1_ELx, I initialize the SCTLR2_EL1 as init value for the future
usage.

Thanks!

--
Sincerely,
Yeoreum Yun

