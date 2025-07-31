Return-Path: <linux-pm+bounces-31689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFDDB17196
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA82C1889F1D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C432C15BA;
	Thu, 31 Jul 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pExreLKF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07352C159A;
	Thu, 31 Jul 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966443; cv=fail; b=vERcQZkv8gDi/smJ1vXHi8K6XDoxCRGVhziIoA1CjgZ3/z4s3PIwi634QnojkMHia2L95sxoUIPalZ13Hlw4CWyaeJOGd/s7tC5IBFwvp/ElpIMutDUXBtPvfjAE6tknwP+XJ2oOdsm1CAOMIkX6p011nIkujspsquiUVK0vDuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966443; c=relaxed/simple;
	bh=MgHDXY5ctB6K+373k09gfYyM/GMAcPap/otd/b4sVTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqA3ofboDktc7pCFE/33i8mxMpkIEZNS0b02E9gY5SC7exDOJ2zGjGvR96A0ar6fdZcjrnABnFF4Qs6anmQ6VsE5aG5kr+H/LyJLzE+AA/CYuBtIC9i4wrQnkGAJ/VrKQNSkIgIcQyUH0nRMpO5u0lmULBh6kgZLxUre20EObJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pExreLKF; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENj+YGeGpkPYPqqpTC5xBvim5D1Vucc00PBrhF9yOZ1LOzJ5/ytZIENHgZ5QDeD1us24jRiM18I45UAPPZ9thCIApKI/ODMT3SLZO9UEp+++Va7t8uvrczGn/tkQFdcRHUGKIZTouEVuxom+m0g7COf5f5BK4DhbHiWh/glyutgODbFf/UcKqCkq/owRC85RKcU9W0RpIS2rASHWvv0l7Q2tQVr2sRDu84aT3PRww7EhBkk6dUuMKxVjWkImTd22MAJXiXHQc3h9fVUBGiKXtJE02Z2Lu7sD+wilU4y4D/0F/O7gXooleGHef15DqjGamArDOJW98QnlCoyppEe6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYPZcf18uAfROaQowgBEAF9t3ipA4Qs5fswxNxTJ0wE=;
 b=UoMYy4vcxWTXPikRNV4TvBHU+EZ03OWXHkWmnJmz7KvsbODVLJ90ZMCE3xl40mOPYsEwuAJ+VpDcaWEpTP1pGNrkWpwU6NtE19Bni9Dd71MLF3avST5gwHdZmsHJz4CV1OZ40j1vt8sZwUXDHmBLqeTMAG2tIBgKObPAaRBUhac+nMEwu38Ea5Xq5IyWOFsBycdKIq/Qa5khepegLIs1MC8Ix4bCyWwStC6IqpE+derPzIpOBxp109cPF/cMa9mWzi8ColkjKD/0iuBIVe4Fi/YP3EZQ712NaKdeXeQwDwaXPf5Sj3NWBAu01F1fjpsobjwbB6Ydr13tsRiZ5fzUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYPZcf18uAfROaQowgBEAF9t3ipA4Qs5fswxNxTJ0wE=;
 b=pExreLKFRAy0ihV10jf33dr08u+Iy8q5pd0gKpjuBldTQpB8ejrUeNHT8fUj4Qsz/CE209RUXU3ArLJWDQ7JkyUO+AndM4S8f17C28LUz3Bu6jzB0kWfe+2AxfpdrIuH8Gm3bFrRBKzr6l41EJ3lvhp21VBP7SOJvU6uq7lnfXYwlZFnv9saxSoYzksqVWQYdycN96hJvSXbMZ89zbyWXm3xeYrykm0GeKzmp2ytLwQLhyJ6UbHeT0qt6z07phC3o2u3zR2hHjtpwzPqUUtHipu2eVG4xMamV+04UAzkT/IxC6gMONxXinjUqsYIKIAnaDRP6WH6DcHnWFC+OZL9OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 12:53:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 12:53:58 +0000
Message-ID: <a29aa004-b4a1-43ce-8dd2-5b05f9999747@nvidia.com>
Date: Thu, 31 Jul 2025 13:53:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] pmdomain: core: Leave powered-on genpds on until
 late_initcall_sync
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CGME20250710122654eucas1p20f1179a9ff22d562d89252f924d34dae@eucas1p2.samsung.com>
 <20250701114733.636510-22-ulf.hansson@linaro.org>
 <212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com>
 <CAPDyKFrPOgWW_=ehCjtqAUR97HoLKmgFNO3bRT50-w6A1LgGFw@mail.gmail.com>
 <01646690-8964-49c8-bbed-556380844b14@nvidia.com>
 <CAPDyKFooYFVrzLEqOtwb02iyEf+c6qPB8+Us1--Y-oXbJVG+SQ@mail.gmail.com>
 <CAPDyKFq=6vZ4xbuduE9TvGB-NtCMpBKProYNRv-=c3cBZdTuPw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFq=6vZ4xbuduE9TvGB-NtCMpBKProYNRv-=c3cBZdTuPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdd219b-2f53-4914-d58a-08ddd03150c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU9iKzlKamVsNjlzU0RzVlhQWGxUc1ZwZ2U3cFNmTUNiQUdxYS9CekszREN2?=
 =?utf-8?B?NmNnclZuMW5ZMjZ2Q1N6Tm0zMHBkTDA1Z1NkMzNlTTNpUFdqZWF6Yi9ib0c0?=
 =?utf-8?B?cjVFK3FuY0xGYUFaVkZjQUw5c3BVc25QTXc5b1dXSmUyaWFxR2hiL3R4SHVL?=
 =?utf-8?B?ekYxM0F2VCsydTRseUNYOUFkWUJ3NTl4U1ozaG5nOUFYZEE0cGlQNy93K1Bs?=
 =?utf-8?B?SkExNU5HdjZVcHlQWUNsb1F5TyszUFplWWw2MnZUU1d4ZjNJMGQ1aW42NjFK?=
 =?utf-8?B?Y2pKQk45ZmxxL2J5MXZBblY5T0pCZWVyVGp0bmlpVVU0dDlGbXYzNVJhNVJm?=
 =?utf-8?B?blNWdXJidlZjS3docXNVRk8xSTFzblc1a2wxUFJib1E1QVI4U1ducGpCTS9t?=
 =?utf-8?B?cjJrd3RRRnJYM1pIS3QyR1k5RFZVQ0hkTlFRa3FlWU1LaGk3UHRoTVNmWHZo?=
 =?utf-8?B?alE0VEE4L3dDOWVWYkphS1FjUWdsSHlpOG9rY0c5cFpNN09tNERhRHFrbDR5?=
 =?utf-8?B?M0dua3pBbE91YnpqWXllNEFicHBWNWliOWFjQ1dnNExINFpNRjlqTFc4K2E0?=
 =?utf-8?B?ZHBHeHhBR3JzZGo5bEFkU1ZtclY1Q2Z2blpGT1l4N1pqQysvYVVodEZMUDRs?=
 =?utf-8?B?b1RVRFNTK3p6WHhyMVlmMUROZDYvMGZyRXU4b0t2UCtRTjJjUFlWT25vOUsv?=
 =?utf-8?B?bG1uN0trRTN5RmJCZWVaalJSRk5ycHVPTlp6NUZ0SDRQN0h2akZjc01UN25s?=
 =?utf-8?B?VTQ0TFA4bytISUQwQ1NvYktxTDZXZGQrYnA2aTNialhYdk0yQkIxOFd5V2Nu?=
 =?utf-8?B?dFMzd0tsZ1R6eHRWcDFtZCs5VDJXRDNROStHbjV4L05SSVRPMncvK3RGckhR?=
 =?utf-8?B?d3BuNHlWa01yakFaaU1iK2MzWkd2T2FQamxISGZlU0xnMjcrcFllbUJBcC9G?=
 =?utf-8?B?aDlkR2c4Vk1ocVRnWXlYMHoxUXI3NUtaamRFZS9LSkpqcVNoa2tBcjdLWURz?=
 =?utf-8?B?emdFN3pTbml4TlhiQzdlVFpBSFdtSFdmMnh2ZU5wM2lTNUM4M041T1Uxck8v?=
 =?utf-8?B?UFBMYjFyODdjTmc2WFREY2NZelNXMFF5RnFDSG5DZ0EwYkxuSDBqbG01OXNn?=
 =?utf-8?B?eGtnQVJ6dFhsK3JVcHlSaWdnV2pLeXlVYXpscWduZFlubUd0K3JhMDI2a3Jo?=
 =?utf-8?B?YisrZkFsOFMxNG9VVWFqM3NWV2NocUhzaXRneTlLbEdiZG54aWNIQmoxTjFu?=
 =?utf-8?B?cmI4dXdJMHBqclVkLzNYeVliL0VHclZzanJUOFh3MmFxUXFOTzdiMkhOMi9C?=
 =?utf-8?B?ZUxBaitpczNpUTV1cUxmT1lHMWQ2N0ZOZnpvOUk0NUFIcjJvblB3TThpRG9G?=
 =?utf-8?B?eTlIdDV3NWVSNllQSFZvVTc3aG9WenJQbjJQaS8xd0pRaEtFSlFCb0RzV0RZ?=
 =?utf-8?B?VWxmWTdtUVVRQVlNdUdabW4vRHdoL2lUMkR4QjdsWTZQMmMyb2g3b0tCbFF2?=
 =?utf-8?B?dnVucVhlZUszSVFKdWcwNWlLVXp4dVloUlVGK0RIRDJuWFl0RnZTeHRZNVhH?=
 =?utf-8?B?OXFjSWtVS012SDhYaGZDZjdDL3I5TXJVMFZjbm5SY0FjWUltRXVVZGNBbW5N?=
 =?utf-8?B?ZlhOS2ovMklia2NuUHQwV2NJdzZSS3gvU2wySGt5QnJSWDZNaGt6b1lnV3NC?=
 =?utf-8?B?UnZhMGdrZVc5bjhTNkgwekZxc2JtMlhmSEZGWjlhNnNGdXg4R0N3bEdNNGZ3?=
 =?utf-8?B?YjRtSjdjOFZ3Q0dJb1FjdjJLcWpXNVVnVWZ1VlhYY0JIRHhtMWlBZklrUVUw?=
 =?utf-8?B?cDhncUx1NnF2RW1yY3RFbGZxczV3Y3lvZFRIMXdEa1lwNEdBSTdGc0txNHpQ?=
 =?utf-8?B?WmZBSGNtcjJnNnJGeEEwelhteHFOM0pZZWZxdVdWN3p4b1FiVFpZSHBrL09v?=
 =?utf-8?Q?mjY903FLnlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpWS2hwRVhlaDF5TnRvRUxRVHoxSjMvajdYVHdDMU1pMng2LzQ4NmNKaW5R?=
 =?utf-8?B?OTI3Y1B4S3NjNnEybHBFL2tkeGFzbUY3T1R0TEJNLzNmK2sxMzlLd3RHMTZk?=
 =?utf-8?B?STJvQ3Z5elFoY1pPNmhnRUJGMGcvbXdzaHhPV0ZxQkNXQy96T25JdGd2dDBC?=
 =?utf-8?B?V3RkTTVYS2hXMURJQ0MyZU5IcjBkVEdpMERkVmRmaDcxUUVzSnY1UDJpcklt?=
 =?utf-8?B?a1Viem9hSHVjaEFMclAyakRKQWIzSTNaOWVYU1BJOWFiYTZFWUtXMlg2eGJx?=
 =?utf-8?B?dTA2T1A0TUM5bDA2RlJPN1FyNnRwdHV6cDQyV08za09iVlpWcHhZM1hzeVpt?=
 =?utf-8?B?dk5NVmwxb1lua09tK2xvbHdwekt0TTQ2WlM0TXF3WEwvT3Vab1dFQjlIYTZM?=
 =?utf-8?B?MW53RVdkZWlWam9kMFluUVk2TGhxajlBcyswd3RtUHhod0U1UTlqRFcrU1oy?=
 =?utf-8?B?ekdLSm5KK2VKRVhoemlIditCZitZU3IyU3Rtb2FDVFFFQXFkTHpxV2hOcVZM?=
 =?utf-8?B?UmNYaHBRYlRKd0xmSE9ReFkzY1FkUXJLd2REbUpsVVlORW5ya1B1cTRPWXg2?=
 =?utf-8?B?d1F3OTdhTnJsUVNWc2ZlMkI4SmllS1MxeEREMXpGVzR6UWRSNlNWSGdGdU5T?=
 =?utf-8?B?MkZpUU5DV0FWM1gzdzJ2V3JWZERBMzg3Q2lQTjhub1hsd3pXQUlpNFF3bTRs?=
 =?utf-8?B?bmMzOEtxRER1VE10TkM5UUNWRnhOM3crYW9pUnNPZ2NiaWF2eVhiTEFlVWwz?=
 =?utf-8?B?TEZDYkhMZlpqVmNxWS9hSkJVSGxUd0ZzMFNRZE54NXdyVFB6cmh1NXFqQnRH?=
 =?utf-8?B?aGR5TmkzWXU1ZUUvd3B5cFpXYnBxQU9RTC9FU3BEOFRtK2Q3M293VEsvc1dN?=
 =?utf-8?B?S3VJaDVTK0kxSFBCM012VnRTdEErdVk3QnNhQVl6bTgva0tLdUJuZ3JFTzMx?=
 =?utf-8?B?d0l3K1c2WGVsSmY3K2lkUktGZWswWDN6VElyVGY0ZDdYSzkxcTd4SEUvb2dZ?=
 =?utf-8?B?Y3hJc2hkTWNMc0gyOEZtRXRnNEt5OHNYUmhrWkk2eFV0TE1iSVNmK2o2V1Rv?=
 =?utf-8?B?dnpwcFBCSUhQTjFaQ21ZTXlhSDZCQ1RWTnZNL2FJeWk1TVVneWJlS1hSU3NS?=
 =?utf-8?B?Z05wNUlJbTNCZFpMMEI0ODFxRmFUY25IYTVnV3hhSlNwekhUb2hOaGxWK2RX?=
 =?utf-8?B?RjBnZUVrbjZHYll2VGxNVWxqekx4YnBJSmZOME1JT2FBQzBjUVIyYWdDSUhk?=
 =?utf-8?B?dkhrZHNidUV0ZE9waGFsbU4ySi9leDNyTDBlYVhBQ1ZKUDdBOE1md0s2V2Nh?=
 =?utf-8?B?aFk0QTZJNGdXeVNnbkMwWU9BbjR4SHhRT212UGdSeWZBT1lJc0ZqdS9aZzdy?=
 =?utf-8?B?Nm5EcDhZeDYvamc4SDNwMkZ0QzFBTGErUEUxWjg1aHZja2w3V3VRWDRzM05i?=
 =?utf-8?B?eXYvZEg0ZHZlUUJWSlhRM09GZCtQaGZKdXVHNTBZRWhzbkExS3dVTjJ3bzBU?=
 =?utf-8?B?V0N6RnJOOUMwOU9ydmpyQ0dHdzBFZVBqaUxYS0YxR1ZmMGRnTjgvQ2phcFFn?=
 =?utf-8?B?TmlKS0doRWpoYzJhbGJ3YjdtUEY5SHp5ZVU3cWR5Ly9nZGhCT1JLVWxIMFZv?=
 =?utf-8?B?QkxRcDVUZndHb0pIQVBtdlJwRkM3QXJVZHl2TEF3Um9SZzFlKzlvOUY3UW5E?=
 =?utf-8?B?dmRHWmZ6TzJtTCt1R2R4eU1vYzVCRmhBRGg5RkowWm9WTXF2eWpVS0xnd3Vq?=
 =?utf-8?B?bHFPemF1K0UvNWt2MWtlTktSY09CUGhoUGI2SEFicXRCcDVvaWVEckRPK2NG?=
 =?utf-8?B?SVRwM0lEbE9TMzBCd0tZc0xJUWZVQS93Nmc0M2RZd01LSjdlbERCdktnOHk4?=
 =?utf-8?B?VVNyOXR0K2hkVlovaG1Xa1ArdDlhZHlRTE9KNnRhTHY0eTZLajBKc3VLdzhE?=
 =?utf-8?B?eUpueWllQ0t5S0hkUlNMcXNWSXBTSVJ4b2pxZGJ2SlBVUGVNbEJZK1VkUG1M?=
 =?utf-8?B?anRMUy80WHFEVTUzQVhJY21pWUZNYjhjaE5WRFlNajBDdi9oOVRYYnNwZjBz?=
 =?utf-8?B?dnJINUhUSnB3MEQ4eUZrS3FpOUhVN0I3QlBWbkNVUmJFdUNnS3E3cFVVdndC?=
 =?utf-8?Q?kAnFKSH2l/KBlSS7XJf8WZYAT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdd219b-2f53-4914-d58a-08ddd03150c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:53:58.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ePgdbpF+uZSDmFkQ83bRZ9uY2F23uD7MQVWR3RgSU6MwadJ4MBS85L5WFocNJTbSJLVb3AETSwvgmYOEYv7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172


On 15/07/2025 12:34, Ulf Hansson wrote:

...

>>> Have you found any resolution for this? I have also noticed a boot
>>> regression on one of our Tegra210 boards and bisect is pointing to this
>>> commit. I don't see any particular crash, but a hang on boot.
>>
>> Thanks for reporting!
>>
>> For Exynos we opt-out from the behaviour by enforcing a sync_state of
>> all PM domains upfront [1], which means before any devices get
>> attached.
>>
>> Even if that defeats the purpose of the $subject series, this was one
>> way forward that solved the problem. When the boot-ordering problem
>> (that's how I understood the issue) for Exynos gets resolved, we
>> should be able to drop the hack, at least that's the idea.
>>
>>>
>>> If there is any debug we can enable to see which pmdomain is the problem
>>> let me know.
>>
>> There aren't many debug prints in genpd that I think makes much sense
>> to enable, but you can always give it a try. Since you are hanging,
>> obviously you can't look at the genpd debugfs data...
>>
>> Note that, the interesting PM domains are those that are powered-on
>> when calling pm_genpd_init(). As a start, I would add some debug
>> prints in () to see which PM domains that are relevant to track.
> 
> /s/()/tegra_powergate_add()


I have been able to track this down to a problem in the Tegra PMC driver 
where we are registering the power-domains and I have sent a fix [0]. 
Looks like we have been getting lucky up until now.

Cheers!
Jon

[0] 
https://lore.kernel.org/linux-tegra/20250731121832.213671-1-jonathanh@nvidia.com/T/#u

-- 
nvpublic


