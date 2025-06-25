Return-Path: <linux-pm+bounces-29500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE7AE8262
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CAE188B29B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35A25CC7B;
	Wed, 25 Jun 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="OlF9Ijr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023112.outbound.protection.outlook.com [40.107.162.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB93074B7;
	Wed, 25 Jun 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853484; cv=fail; b=VbIXod82Vkm0xIOziNLi7OIO6nTUd1WELTJGzGGZ6G3xANzIiFK3mR2/DG560sJRLC9Ny9juO57c0444g0w/zpFX9J1hwwuF7a7E7vT8ECM8+4wkrW3t98ITldQRBYNuVd47jsR2IdDYnDdkQtgtuutgDKN/RnbjN2T6gH6ZTTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853484; c=relaxed/simple;
	bh=RXlXl9LtCCYsfPz3J/5T2Q0QVUKFuMEpGjyEwbb0Dzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/l1e2DXzkr4tP7zEiF3F6Q4hKB0CIchT4bkY2PWelvhj8LcdDb2oPtQ+cMgSpwgft7zs0JiPxqxGCMlfgawHDpx4JunrsRKFy06o4Jc81wreXgnSHfHkW26cmzOrU5M0NpR1W941lBQaMoe/FfFoox0bHTvpUEMPRrnIfEedgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=OlF9Ijr6; arc=fail smtp.client-ip=40.107.162.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF/OFdTU0A2Fsz8nPGRf5uC4Oj0v9Z7WOlZgrC7ebsV4v8RIbZK3jtYreCJ275dsaLBaIauDaMpDbzUsrOXGINpBOzd7GA7RKVa/gKTaz1WjMUHF4GpQaw9I5VDZ+PfTdvL5MisyyzYTsKsfdh4O+v7Uo8vn8QfvQ2ofKULyVowAH2PNJZIsrKUniJPcm0wA+qz9LY9Q9TviPrnnqs0kUdRofNGb+D2odk5wm9OC/LPUTYKrTuQFk0PzJpb51lNMGlMh5kHYr51/6/brrlEyOyQDvPUvEQNn+74ArFQDBMNrSJFVLeNAvbv/x2DGSfhF8OA2eIJBeR396kwaC2uYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCkCv5bH3L+Nz8/iiLF/0bpRHI0Sl0NhSmISL/9+jYI=;
 b=HR0M2BOtvJGwgjOKNLLuhtGlw3HHmQPsrsc8ehy+Nqj7v9ph4+vnCHoMyVV6ioEsW82l8iDDCLuSfxYiVoxahi3jLWxvPwYO7h4IEFylRpx+CTpwY9dU61WNtD5X7/wf6Pt7LZqLOOUTOnDLBrY4l4vor8PzBThTGZW4KeicLru6STFMWCCJrCf9ai9Q3yS3bSJQRuRh0vKZAwNfO7SoL+b5YMRFxiWoxrT9f7q6sBpn3gqxcTwIRwLZFSvK5L/CEB6YPRIl1Nj1P2QqUQUvh4lay8jiujjpkZq5HelvTbLdFrcansXCFrHQMfbB8F9+g0wGv20mm+bKetBr/pPryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCkCv5bH3L+Nz8/iiLF/0bpRHI0Sl0NhSmISL/9+jYI=;
 b=OlF9Ijr6NRXkljmeEQtJVtIYc3Q0qiLKUHVcyMR6m9+6PNayyuAnpp+a1nvnuzAeE9UF2MGC1MNv0ybCrKQtDqT2c+PpIBZiO+kiPMDEvzd07f4VT1SjRRs2eqdBvupD4DHVn15a2EdJgPToQv6AcmjZ7/lWViUsINldD2mU4sltyNIivlMrIbD8IPpzQb+37Q1Le4GW+SCxOLsaKqW8lk83tOxfrjY2js1qicSvYeH7ka8kx/JdeilzGA/crrCeFCOD40h4xFcb5QCq9ic8tewE/4c4u9TCxGk9mxr+p4upwqWcV2cKdB0XsyszbismJld9ZsIw6WPPuFri9zYD7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DU0PR03MB8853.eurprd03.prod.outlook.com (2603:10a6:10:40f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 12:11:17 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%4]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 12:11:17 +0000
Message-ID: <793c02e4-fa7a-4c13-bfc3-bb058e211b5f@uclouvain.be>
Date: Wed, 25 Jun 2025 14:12:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
 <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:208:be::27) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DU0PR03MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d06885-7c90-4801-e3f1-08ddb3e16339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWFNQWhBblAwcVExcnFtZ25MSUc5V2NoTU1RbDd5bzYwZHIzb2dZOWJETFlB?=
 =?utf-8?B?M3c4dm5DZVA0aU5Uc3lPM21ZOVp6b21lNEZsRU9UWEtyejNjOW1kS1RuK09m?=
 =?utf-8?B?WmR1NGlhOERzU0k1cWZsN3FLSUhuQUs5RkFPYXhxT2txUzREK256MHpSNUFq?=
 =?utf-8?B?Szd6b2dWRjh2TW52c0tabWFtNm9QQWhyU2xheVM4NzgrSC9rZEJ4emYwNUpM?=
 =?utf-8?B?ZWZud2M0UWM1ZzdWUVNzai9ZSWN4ZFBMMnhWZE5PekVrck1udktIUCtYdlZB?=
 =?utf-8?B?aTBpdzZUak04RHFIek95RzVtd0JRNXVnSjJsTTA5cmZ0YkNjVng3c2VUS2c2?=
 =?utf-8?B?dTJaL1J2Y0FrQzh3SXFPd01zRmN5SVVuVnRZaTZhRE1tSThjMXBUUWwxREpP?=
 =?utf-8?B?UkkrWVpVQ21Ycng3eGVFblF3eE5IYWd6TmNYZmdRemo0SDNhTlIwWmduZmRQ?=
 =?utf-8?B?bm9OMHE3aWpzR1JycVQvVnN5eUEvSmw1endKa2VvTjY1SkVpVU9JUlRvdlpL?=
 =?utf-8?B?bFkyZ3h1eHlaRlRNcXQzOFhlb2ZYWENydFRJWUtGS2VTNnpzdkdKNmdza091?=
 =?utf-8?B?bTZYb2VaTGtJM3cxVlQ0T3NiZFVkRXlMd3YvRE85TG91TGNCcjBTUVF6Vlhq?=
 =?utf-8?B?N0UzZGJpWmhiZ0d3VHJ6NUlNNVZybzR5OEdrRElibTlEckV5Mk5heHNSNzVB?=
 =?utf-8?B?bmMwSWVzdGdRTTNRdDJuaUp0dUozb1crM1ZQaUQrQy9mZUY0WlRCQXlRZ1J6?=
 =?utf-8?B?QjdVTVFZMU5HaHhRVDM4dDFPWTNiUmtHclhhVGdiVVdnOEdsN1k0WVRoYkpw?=
 =?utf-8?B?U0xyRWFxSGNLTmtUcVgwaDlGOUlKR3BpZzZiMnkrMitKWi81ZG9LQWZIcmE2?=
 =?utf-8?B?b3RkYjZHYjdQaEhMZXUxMmJCeU1SVjlSWG43WEg0S0h1dWNkTU9YckZtWGtK?=
 =?utf-8?B?STlIWmRUYzlreWhhN1puOWo4THNHbTBHUHRSYzV1ZGVJdEVITVdBbGh0N3JN?=
 =?utf-8?B?YS9JTXZRRStUdGtpQm9sVnM2QW5zRHZvYkhHUXNHMTdGYWM1a3Awb2p3aW8x?=
 =?utf-8?B?WFoxTDNzbDNuRUpXQVg0OCtHbDVIVVBWem9QMTAycDVRbGlnay9ydXlwdWF5?=
 =?utf-8?B?aXJqc01wRUxNQXN6WjRjQkFqV2RwSSswUnpRYW1McmQzR0s4V1BUb0RNS0dK?=
 =?utf-8?B?WllWSW9GQnluUk44Q3pxM21Kb3dGaDlLYkIxcVNTdkxNZk1QZ1EyOFpyWWpU?=
 =?utf-8?B?NHhHTmVxemlLL2dZZVc2cGJSYlo2RXA1UTU1RUVQUTNVbkVZbEs2bU1NU3Rk?=
 =?utf-8?B?SHMrVFFGMlY4aGsrUld1Uy9zK1Z2VnJ3M0NZSlRadWJQaFdydGtvT0N1NlFu?=
 =?utf-8?B?bndtZ0FKNXJvWXhNL01NSlVMWXE5ZzBYczgrSkNBVEdORVh5YUgvTDhHSEpC?=
 =?utf-8?B?bFRKT1RFVnlYbHJHejFQSmtHMXE1QmZEM1FlOThhSmduWXJMT2lwaTlkZHFm?=
 =?utf-8?B?V1VLelNKUHJQcUNkaTBpdTRJVkJURUY2bG9KR3ZRVTdhWjBDRVFJU1FRK2pG?=
 =?utf-8?B?NUVQUjVHR29xcGZPN0RPM291R3Q1ZXQ4WDBiN2pwRDQ3OGk2VkhPOTMzeFpC?=
 =?utf-8?B?VjdHYWc2WFhzVTBkL3lDd0NvdWdSWWhaRTRuK3hpTU0xbm1oRkg5azcyd1Rk?=
 =?utf-8?B?cGR4S0MvY1B0OXAyZkljVjV4S0hEVlFPZXpiWEhlVGdOaGtrc01QdzM2STU3?=
 =?utf-8?B?QThxaldQU2tKMzlyaFk2VkkxVkpNczMyM2hrZTBQRmdaSzFaMmRCVm56aGU0?=
 =?utf-8?Q?XRx6tfcF5i16iLDPIIaUcTEo06FtqOK5oYsTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEEwZ0VyWCtZdG1tMXlNdDE0OTN2aDFYTWU5M0gySnJyTkRjSkFrR2tweGlL?=
 =?utf-8?B?djZ1MkxCbWptUWJ3eE5ab1ByZm8xV05zYVZMVWtQUUQ5YS9GcmI0bzdmeWJV?=
 =?utf-8?B?a0xOSi9OZTlmblpIQ2RuOStaOFNWZFNxeGdIOU4wUFhzQmFEWFB0Y3hVa010?=
 =?utf-8?B?M0VFKy9IOWlHallLMXpIdjI0eURBdnFrdGVDemwwT3JNdlI3SGFkdks5SW5W?=
 =?utf-8?B?Qi92MUtSSm9wYVZxS0VmV21xbldxTG14bkdWZFlZdG1DS1JRTW9Rdm5ObHRB?=
 =?utf-8?B?ZVpNYUlGMEVyZGFyZDlaL0sxMHFXRE9DM051SFpvYWc2WXp2MklVeHc2cTBj?=
 =?utf-8?B?eTEwd3pXUEovVEVsRTF6RUNGeXBPaGtrZEV4VGhSVFlMSC9YRndaWXV2QUFh?=
 =?utf-8?B?V3pCbGg0VlIwcWQrbHlCcDVRSG9HK01iOFZzTHJaUXVSWEg5YWJVcStWMkEv?=
 =?utf-8?B?Q2U1R1JueVdQN0x4NnVROWlRYm81TEN1UlJBVHdNMEpoSE1RekltZko2aWF0?=
 =?utf-8?B?OFFaeUNYcXhiRHZESC9YRmMyekNWc0dxaDhNRXRmY2FKRHR0Qy80QU1Gc3VG?=
 =?utf-8?B?eDhEanZaT2pTRjYrU0ZtQ2dxSVkyQ2ZYb2t0UFNkN2JCbEZwcThUaExKd296?=
 =?utf-8?B?QjJQR3JZVDBlMmFhenVPUTNkdStZQ1BPQnFvbFk0akZ2ek9wQm43NDFBNTlQ?=
 =?utf-8?B?Q3haSzVmK3JDa1Mrckl6U3ZBV0V5ZisreFdXYUQ4aGNzQlY5S1AwWkpTSzNN?=
 =?utf-8?B?bHVIbzZsY0FDMEYxMXdjV1ZPS1VKUWkyVzVVQStRTG9QalFjeUFyRy94Y0JU?=
 =?utf-8?B?MXFNN21yeHJHcFpIT0RxZTgyOGpRNzBsd3RXQkpydXVhODlVQk9tZzNyTlJQ?=
 =?utf-8?B?Nlg4TWJmKzFPcld0c2NpN09PYVF4R2JPdSt4ekdvRW9ucDBCbjVZNVhaaGFF?=
 =?utf-8?B?djA5QWJjdGIrYys5NWd1eHpFcGdkODBnZHFyL0pyNm9PMkxUMFNjbCtTa09k?=
 =?utf-8?B?cGJkOVFwL0l5OFFudjRPYjFjZTdENzlWcFdQWVBHTXRDOGluN2RvRk5yaVhB?=
 =?utf-8?B?cE05bnd5UnFFcDlWb0tkVVBzU2g5dkVNc01xbWxXTXlsQnU2YVNaRFVMak9I?=
 =?utf-8?B?VTh4VEFKZkYyNUhoU3Y2Si9RUWFIdlBnM0NmNFovOWFxamNqcUVlNkRza2Qr?=
 =?utf-8?B?Y0RBNzUyd3h2NjJEaS8yZ01KalNIMkpLd1VtdDdxempIK1lmb0VMSFFYYlJG?=
 =?utf-8?B?OGJOREg0SHBraW1aa3dGUkxqLzA3MGFDb2Qrc2NtTmdFQ2JMdVZ0c1FxbDJV?=
 =?utf-8?B?OWZpOUs0d1BRWWx2cVJ1M3N5V0hoc205ZnZrUkZBMG1JRG1STlFDT2FQeXVo?=
 =?utf-8?B?N3FlT1BaTTJQd08wd0NoUEVTVC9XUmtnUk5lYmJRZndMMUp0cVpXV2NsMHA5?=
 =?utf-8?B?T0hCT0JWMlhRQm1uU1g3Zjhrb3ROTExvbGJOckNnak4wSjU0YVFrYUxDVFE0?=
 =?utf-8?B?d0hmT293R1ZwT3FkU2thL1FzcE1ZWlZObkx1K3R6d1NLbTJDcWRZMnRUZ2tR?=
 =?utf-8?B?am10TUNlcThPTjdKcWxtb2t0bDQrMVlTcy9CaU5mWjN4QkdIcWtUYXluaGNr?=
 =?utf-8?B?VDBHNWNjRnNGc3BVdzVkRFdYNmhTbDB1QTJISko2bzhIU1lsd0hGMG9pSkl0?=
 =?utf-8?B?MlhiTWFhaG9PMkxRSWhYK1BLWVVjbUZ4bEREcnRXaEJ6dVVibW54cHNrL3hN?=
 =?utf-8?B?dXBHYW0rR2M5QU05NGVOYk5HUXFFelJZZzMwbVFTSkFVeVRzZ2ZWNFFLckNN?=
 =?utf-8?B?bDYwVmEvYk9sWG9HaXZpL1lXcXdFaUMvL0RaQ2hKQWpmWGVtVXhJeTFKc2FM?=
 =?utf-8?B?QWFFNVlHS2JpZDZ6eDkzV21kT3RFR2lRaFg0SXF1dk5pNjRraE1kdTFkZU1K?=
 =?utf-8?B?Qi9ET1Z6USszRmdTbWZiK1dJUVJKSTIzUHJ4cWk1M0NiTUNPVndHYmlsY1Jz?=
 =?utf-8?B?Q0s5aU1uRGR2MTRFc01hZFZ6R3BIQ0tFSWRybjZZMEdEbUpCdXpIWDN6a1NX?=
 =?utf-8?B?Uk9kUTdGczlRZ0hkTlNvY1pWSjFOWDFjcnpaY0hWYUpqZllWd05IcTdOUm4w?=
 =?utf-8?B?MzNDMmFaeXVpNUpSUkFCL1BoYmltNE80LzI4WjBkWGh1bk5EUkd4dHk5ZHk4?=
 =?utf-8?B?NEpTYWcxRllSNmgrY0hkVlNxbkdOUFgwZ3UxRVFHSG1abVMzcy9sM01Sd04v?=
 =?utf-8?B?UHBDQWt5NVdRcHJMOTFrQnlvQ1pBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d06885-7c90-4801-e3f1-08ddb3e16339
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:11:17.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukYP/x7JwgDsgLUQNlzQxVWxjdhF2MsIh/Ko6FhZenfPqYQ/V95sFKJZBo5sgho3tI+Z0hlgvP5BYb0o4CyUpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8853

Hi,

On 6/22/25 11:26 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, May 23, 2025 at 02:51:45PM +0200, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The interface of the Maxim MAX77759 fuel gauge has a lot of common with the
>> Maxim MAX1720x. A major difference is the lack of non-volatile memory
>> slave address. No slave is available at address 0xb of the i2c bus, which
>> is coherent with the following driver from google: line 5836 disables
>> non-volatile memory for m5 gauge.
>>
>> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>>
>> Other differences include the lack of V_BATT register to read the battery
>> level. The voltage must instead be read from V_CELL, the lowest voltage of
>> all cells. The mask to identify the chip is different. The computation of
>> the charge must also be changed to take into account TASKPERIOD, which
>> can add a factor 2 to the result.
>>
>> Add support for the MAX77759 by taking into account all of those
>> differences based on chip type.
>>
>> Do not advertise temp probes using the non-volatile memory as those are
>> not available.
>>
>> The regmap was proposed by André Draszik in
>>
>> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/
>>
>> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
>> ---
>>  drivers/power/supply/max1720x_battery.c | 265 ++++++++++++++++++++++++++++----
>>  1 file changed, 238 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
>> index 68b5314ecf3a234f906ec8fe400e586855b69cd9..c9ad452ada9d0a2a51f37d04fd8c3260be522405 100644
>> --- a/drivers/power/supply/max1720x_battery.c
>> +++ b/drivers/power/supply/max1720x_battery.c
>> @@ -37,6 +37,7 @@
>>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
>>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
>>  #define MAX172XX_TEMP			0x08	/* Temperature */
>> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
> [...]
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> [...]
>> +			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
>> +			val->intval = max172xx_cell_voltage_to_ps(reg_val);
> 
> I haven't reviewed this fully due to all the feedback you already
> got from Peter Griffin and the DT binding being broken, but something
> that catched my eye:
> 
> POWER_SUPPLY_PROP_VOLTAGE_NOW provides the voltage of the whole
> battery and not of a single cell. E.g. a typical Li-Ion battery
> with two serial cells has a nominal voltage of roughly 7.4V while
> each cell has just 3.7V.
> 
> Greetings,
> 
> -- Sebastian

Downstream just reports this value which is usually a bit over 4V when I
record it.

Also from what I saw online, it seems that the battery does output
voltages around 3.86V as it is written on the battery:
https://cdn.shopify.com/s/files/1/0092/8133/9443/files/QeqxTLOL6eAp6OpZ.jpg?v=1728588266&width=2048

So I guess that there could only be a single cell in the battery? Which
would explain why they only report the lowest one.

It thus should be ok if we consider only the Google Pixel 6 (Pro). If we
need to take into account the possibility that the chip would be
used with other batteries, we could take from the devicetree the number
of cells and only provide the voltage if the number of cells is 1. Would
this be a good solution?

There is also a VSYS register (0xb1) but I couldn't find anything about it.
Taking a LSB of 156uV (twice the one of VCell), I see a clear correlation
with VCell, except for it being very slightly lower.
As it is mostly guesswork, I don't think it would be a good idea to use this
without any confirmation it is correct.

Best regards,
Thomas

