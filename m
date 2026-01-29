Return-Path: <linux-pm+bounces-41722-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM9vEF+7e2l0IAIAu9opvQ
	(envelope-from <linux-pm+bounces-41722-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:56:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD23EB41C4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF0133013EF2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C582329C6C;
	Thu, 29 Jan 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoARsmDH"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C492F5A36;
	Thu, 29 Jan 2026 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716572; cv=fail; b=t5bO9McBAxrmmwqXnLF87iT7eLue7saBJw6Kz7kQK5mIxjI0obbnOb+C9dGrYlt7kyF1DtcQFXpcPqHU0oUU+t+QMUc3F+uhL22S31D+PnQRk3fdktxqqNY4xLhZKog1oYmLAHfoLOuujhEzYFXUqaF3F0H4WsN8GoBY5gl1pPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716572; c=relaxed/simple;
	bh=ItGEhvSazDQuPSgE4gdY6LSFXFMhVqPMYdlsKXbGQeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4iVAp0BZNnrRtOUZq9n6DhkfrZ8UDcmyHGTPXI6LOOgxp9Rpgewau/ScTnBD3c51ZsaA36ryCQP9siWXMs5C+89Q8nwF/RyOExbuybRz1SI0Ysiw5Kctk8uFL0hT7zghpqATUzBcdDIpH0yJkzWrRv7svHXloI4/+DdXKZf/Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DoARsmDH; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sw8HyViLlrKztFSiQlPa42rv0oOZkGM/2Nr54pNKq2Ph0FqFjQEl1fHhadErgfbnL+CqSH8X1a91Cer+aiP/ekYhn5qjCUeUuSzUS5IpjhzridFeZVbsPucogNVUv39HTdguzaJynVUhRQQLp20VTbSzZLozqatTss4wgBPP3CbvW0BoWLasvIyhKP781lLLf/6O0Mbm8jATqnBaj8KWC3J0XWOl4UY/UBuoyFwL3Li2+BK4x9eMWVTD3LSMio1dF0SOOYmmENS8g+40c8F6Nb6RHnUVrtBYu58Kk58bwcbPWgIOHyjZ5jvxVjVjU6mGwEKoa5p39RPBOE198GZq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D37giGDDhx719ctFbfnAomqPsdue5gOqPFsP1XV8kc=;
 b=irw84sQ8WV3xX7PIXcf6jmHwvm4bDS8gge5l7e8En3FPnqV9FWplK284rekDFh1cKiUdTPsbHfzc4oBgd+d7bajmcTfUDoIzqo9WTdcgUUFxPE7O7B/VJV9su4zv/uoZdQS1HF3V70rwvwUQ2kbDu1o5ChfrPJRZE1kGdqqsGOlfRPirnS0rdzOQzuOoZAjPnGB8nICrwfG51jaX/DidvgB5u4Iz/VxjswE6g3eK0j2+t54FdWedNH0qpWx+Hzh/zecfnQxs+sa2zwSGrSDqC314U838ZNdgLcbcmC8T08FquUZtkd26Pvm7w6FUEVQ3UCGCNYu7Y7lnF/3lzHHgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D37giGDDhx719ctFbfnAomqPsdue5gOqPFsP1XV8kc=;
 b=DoARsmDH5WCO3WqbYhEAMIq2osNrFEJbEe4uRMe3xPKPjGRm9nvmKIY3h+CS5uszWyLhKTyXw1+b65/l5OmHFpEjvSkQMsF/ZSwQTNfLa6y7plpCj0tjQgLgspQSwIfxy8fLekzz7VR6I2EzFNfyw23d8tzd7VGoHUK3hEUvsz9pmCp4qX0FjW6iXf/7vKkNhiOdgv4in+908QdowqCKk/Tw/vFL6a0FSwHnIdZhB7+B1T0gUUozox+2uBNJJmOluRh3vvwwblYAiugU7c8GTDfQvIN3Q81HEvvgFVcEpnV0Yiq7j1jz+kM+meXkICr0lUUDWPecUVuT7eC8v/ybJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 19:56:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 19:56:07 +0000
Date: Thu, 29 Jan 2026 14:56:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/7] i3c: master: Mark last_busy on IBI when runtime PM
 is allowed
Message-ID: <aXu7UduYCweVLxdK@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129181841.130864-4-adrian.hunter@intel.com>
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c55f42-c7c0-43c0-1bf7-08de5f70716e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWYxenlxbmIwRkhqNXA3QkpXK0RLM2E3cU9yVG5wSGgraFU0WWplUTdZbXM1?=
 =?utf-8?B?VnZGcVB2cWZDS2NXaVFjcGRqMUIyL2ZIdGFQbFpIV1diRSs2OHlVeWlmWEE3?=
 =?utf-8?B?MHJnQnpWRFFXRUdnWllkQlN4dG10TDNiUkZKcUM2VlQ4K3AzRnlTOWxnSnZS?=
 =?utf-8?B?d0VRV0dJSWJaR0NXU05tU2JvSXBpdkJXRkpsbFZiNGZQZWErWFhZTXgwZjNn?=
 =?utf-8?B?Q3gxS3EzZjdTSm5Zc2dva0JkbFBxYzZtcitxUVB4b2xJVERrRDY1OGNacG91?=
 =?utf-8?B?Sk9IbDhYZ1dUNHhSTlUxdENTNVRpVHFTVW9YZmluR1h2WHg2aXFQWXBYN3ly?=
 =?utf-8?B?Z0FVamdFemJzbm8zWTZTeVRUcGJZN1NCTm9tczZxQmhBaGRnbmFFdmQrQktC?=
 =?utf-8?B?aGl5NkdxSXRvSW9BL1VFTlRBdkxkSkJaVHBpclJsTjI5VTdpRUxjNDg1N2tj?=
 =?utf-8?B?WTFsbXRHQWZSYkYyN2VyQVdKYjVDWmc4Sy9hcUx0WWVyUDkvRE1RY3lhbkNM?=
 =?utf-8?B?d0hzOUhNQjZCU0ExRVl1aUVrVzF2YlBvNVFuRzR4UW56dXBlVnB1UVFKQUZo?=
 =?utf-8?B?aTRQSUNVLzI1UnllamdvZ0RxeXZOM3BBOE5PM1VtYVd0SE9nWk9EUkR2MXFJ?=
 =?utf-8?B?MHQ1bCtIVGxRWFd6bHFycU1xUVUxc1RNMk5DbDN4MWJvQ1VzK3RqNW8zQlVn?=
 =?utf-8?B?Tzd3aGJlUWc0enlFVHFBNmR4ZWRyWlBQbitjRmpmK3ZvSFA1dC9tamlvblpU?=
 =?utf-8?B?dzBjYmk2L2JnQlJFUGF1c0pjWEVlZFpVSmFFaW8zY1pZZUtKZ1EzUllpekpL?=
 =?utf-8?B?S3NBUVVJVFFwV0dscjMyeVZFL2Jqb0RlT2xlUkNkdXg3UVg1Z2VuRWFhM0hv?=
 =?utf-8?B?cThPcG9FWDVka0QyT25BLytWc3kxOVJveDhLMVM0eldQQmxsUzAwdTc3L1Zt?=
 =?utf-8?B?ZksreWlBV3E2VjEycnNaU3czRzBoWWZlNVFRY1dPL0FmUWx1ZlZ2VmljeThq?=
 =?utf-8?B?NVFCMTlENjI3Q2Z1OTM4bk1YY2VCeEM5TXdMY2NaYkdEMTJLY1pIWUZIbGlJ?=
 =?utf-8?B?bnJaVlVXUTBQZkRQRWYrcDNxeElSOUZxT0hJYzRPcUpkNy9vOVBPT0dFME9B?=
 =?utf-8?B?V0p2NmhlQjhtdWFvNlUwTURtNkViOXJtODNEMVkwL0hSb1gvUzNtM0M2dEpn?=
 =?utf-8?B?bGZyb01BcXFBZkwyN1hMd0tQd2JtOE1ZNkhrV0hhVitzUWxENmR4WVl0WUMz?=
 =?utf-8?B?Wk02ZFpHZmZvVWVqOEtZWmh0NUY0UE9SeFpsbml3N29PU1ROWjFocFpIbndr?=
 =?utf-8?B?emtTVW5YaFVFMDk5b3BSRUVhanNrR21NdVA5RDgyd2RTazJ3R1VVc1I1dkpS?=
 =?utf-8?B?MlVJaGFGSzZTN1dzZU1yVWJnU0VtNnQvalNzN1RXZU05bnQweGNtREVrK2k0?=
 =?utf-8?B?b1hVSWZYMTJ5ZkVXNEoyNVF0YVIxNW82RFAxY2lkeWZ6NVNrNkFrUVRFWnE3?=
 =?utf-8?B?aUFRRjY2Y0hISGhlRHpjNG83bUE5Y2s0Yng2Zk9JdkVTaGlKLzRQR3hubDdC?=
 =?utf-8?B?bnViek1WSmlGQ1FpRkxCVis3UHVHRUpHbWp0bWR3S0hzclhtL0hUK216SytF?=
 =?utf-8?B?WFpyT0NMZGI0MDdnSThwWFlZREppQUhMeS8xT3pKa2IrYWlFOUdrQlRXejlo?=
 =?utf-8?B?bHVjRHNGd1dHcTVBcnBIalNPdjVzSE9DeFU1UlZnc1QrN3dzVWM1LzcvUjZI?=
 =?utf-8?B?cU1YWXZMajZnOEhibmpMTzQ5VFdCSnhtSHlybGFjelFmaUdwdlA5SXNNQlNw?=
 =?utf-8?B?ODBGUVJ5RU13Y3d4WGdTQnpLVXBET2tQYTNNQ2FQckJqZFhtb1pLcEVIYWJv?=
 =?utf-8?B?c3FPS1EyRm5FVDZDTFBlY1BOTTgxWS9rTjErNFR5d1l5aVNlV0NQYllwM1RE?=
 =?utf-8?B?VXBWbDNWUnVKcmtVNHc4MnFJZ0o4a2cxQ29JV09YQ2tXVXp0UDRpM081Q01l?=
 =?utf-8?B?R0x4encwVHhzeXJ5WndvRlZhVS9FTzVQVi8vODlSRUlUaTZaRXJKWkVEYnpt?=
 =?utf-8?B?OXZNWFRhZ0JwLzJxTzJWUGJ5V0N1UXpqRmtOajkvaWI3MmIyQnNJaE0vWEpk?=
 =?utf-8?B?SkRtVUY4VjJDOXFzTmpSNTdNVG0vLzhXZU5QY042UDFrbUVWUEp3aDJ0SGl1?=
 =?utf-8?Q?Xg8KDQy4u4i4AJfehs3RrZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNsb1hYWmIwMEMvVkhGeFBUemlwVVVPR1IvUkxTMm1wbzlqWXNUUnFWQ0h3?=
 =?utf-8?B?YkNMRndPbjV0akloTnUvSERTRVE1ZTIyY3I0cU90NUJ3cUZRZk9jV0pMbUlZ?=
 =?utf-8?B?MTd2UWs0M3FVOEpsT3ZKbDBGNDBVeVdFVDBVN3Fsb2VRWjBybXVIQ1Z5Q2tj?=
 =?utf-8?B?M1FEWmxJN3J2SGNCd3NNcXdoK21GNHJscUV6Rk5BRWVLUFh5clA3R2l1TjVG?=
 =?utf-8?B?Nnp0SDNST3d1UEVIV09wTFlNRHhaaUVsZDAxa0hXRVJLYXFhSDh0NUxvRWMw?=
 =?utf-8?B?cnhtUG5ZSTd5V2VmUTZJLzdIMnlEQXBnY0VSS3c4QXVabkhDOGRyVXRtYXYv?=
 =?utf-8?B?WFlPZkIzUjVOMHpUbXF1eUU0dnZKNDl6V2xiaUdKTmdaUWZNMkJRLy9qdHFI?=
 =?utf-8?B?cHYwYi8vWlloZkI1UWFzWGt2QXVwenowMGVIbGpHQnVSOUlHQTRkS0M5dE1E?=
 =?utf-8?B?YWtqSE9PNU1DN25WeEI5eU1BZWRYQUJyZ2Z2RjZOb2xCdyt0RGxuMjBVUnEv?=
 =?utf-8?B?dHNKTXJRVGRKMFhWVzMrVE9DclJXWHNVa0pQNmhhUW5FL0J4WlkvbWhaUjE2?=
 =?utf-8?B?VmtmOFJMVTlodnBkL0phdm94TUE1ekN6VjJFdXJGbjZnd0xYcTcrdDd2Q1By?=
 =?utf-8?B?ZVBHUEo4T3k5SVdMamJ3Y2dBV2NJWFJUbHFNb3JsNVZFeGxWSS9zYW9tb0FN?=
 =?utf-8?B?QlJUVG0xL2FuYTJjWFBRcTFSZStMbzVGQmVZR3BpYUdRWTJYQjJtc1Y5bDhH?=
 =?utf-8?B?MUVTYkxrQ25jeWI5UXBFbWdYTExHV2UxakpLV2VCSzV4Y21WNVZtSHdqZmNG?=
 =?utf-8?B?dXdpWEFxQ25nYmJNbXc1cXJSbVkvRmNWNFl1cS9nK28vNnlYZTBRTmlDZTdy?=
 =?utf-8?B?SzYvaTIyaTdkL3ArVmg4WERZcDY0dkFTRzlLWFFhdVAwY0F2NkVrUVVacVJV?=
 =?utf-8?B?TllRSEtJZFBidnM2K2gxemZhNXBlUjRFT2YyOWdjTEVXclloSFpFTjZwZmh5?=
 =?utf-8?B?cnlaS0VCSE9mZzdlRmdFN1JVVXRpQ2JaYnRucGtWM0dpZ3hJaW9IVnRKVGFD?=
 =?utf-8?B?TDVqTWtxZGtLLzdHVGVQOUttaFpneDlWb05RWGVwbi9vcDl0UU4xT2JTOVNG?=
 =?utf-8?B?RFM2NlpZeUpsVWZXZVZkMHdGY1MzSS94ZnkxQmJ2UllSMFVSUjVkelFEV0FI?=
 =?utf-8?B?czhidzJJUXZvN2VoZW1YNXBzdmdseVJ4K29Pb2cvUHdTcmE5OE9BTGpTSm9T?=
 =?utf-8?B?cTZUR0NYd2NXKzlrV3A4V3Q3bDZ1S3lLa3NTRHJoTndyNU1rWmFxZE1mWGJ2?=
 =?utf-8?B?SjgxT294eTJYVE4yZUp0SWw3eWNmSysrbzJvNDJ4T3gzK0N4Nkd2R250bGtF?=
 =?utf-8?B?L2FtSVZIUzRQV1N6RVhucjFPemN1b2Q4V2taSmxPMnhkUTdOdnNNdTk2L3JH?=
 =?utf-8?B?azA2TFB2RDBITXhDcnZkWUF6ZFB6Y3FiQms4S0d5eEZLbS84b0RDRkxSWlYy?=
 =?utf-8?B?ZDNiNVl6cTg4TkxwZG43aGlReUNJQ2FvTjkvYk8vOVBVRUUxYk5PeDRCRHpE?=
 =?utf-8?B?UEFWdURkNjdxQ0F6SVVmcUhDTk5JY3MrZ0RSODhtcisxeFI3ZU1Rck1jWDJ3?=
 =?utf-8?B?WEZLSXVtbmk0WmYreTA0U3h0cUlCMlRQQXpXckgwQVNRK05yYlM4Y2lwYmZa?=
 =?utf-8?B?TFByMmpwcE5pYm9aZHVGaHBmaHMxbmNvZk9rMDBwMjBwczBFN1VHaHVnT0JX?=
 =?utf-8?B?aHZIWTVUdTJVb010aWRWcUJEMnE2SFVlK3BPcitNYzQ5VldZeXNCUFBOSW1N?=
 =?utf-8?B?azZNSWZRRWIybzFkQnMwV0JtNnFFT2Y3OEFuMzhVZEVMMTVnd3pnWGlWTnFC?=
 =?utf-8?B?eUF6bWcwa1JxSmJUanlxdlcwQWdyTkh6RmtxeGo1YmxDTThkUXFUK3JoTk9L?=
 =?utf-8?B?dGs4TjVEYlVSSUJtODcxdHJLY0pqNlR1R3RZZGRXNWJuRkxWWUxCUm1VT3oz?=
 =?utf-8?B?SkpuN0MzT282dDhna2JhYmpxTTlWNE5LdHB0VjB3bUZzWkJYZTBrL3RXMXo1?=
 =?utf-8?B?TE9FdHlQd0tRTUJFUE1YR280U0ZoeWNrUEdYSE1TM2lXTE9FNjhYN0pyVXhM?=
 =?utf-8?B?NXBzRzdNZ1JyNUJPc1lhWW14T2h2aDNZbFZrV1ptOEdHbnRCUGdjR2dMUFh6?=
 =?utf-8?B?dXFqTk9mbFJYenExU3EyOWdpTmhHTnpDMHU5aC9NMEVaNWJIVlg0QVdreThw?=
 =?utf-8?B?ZXdQczZYME0xeXQ5bkwxem9QMVlnZitkYkJ6Vkgxd2NCVVRzdlpHcld4OGxw?=
 =?utf-8?Q?8g1OHrZgszZjbQuFsv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c55f42-c7c0-43c0-1bf7-08de5f70716e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:56:07.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ldtimDj9zUZa6I4HNTa/FFsb/6Yv1iSBYjnmcDmxEouO4RStGrqNJaY0Jp9qGe6pg+CRV+tVMarUo7okxXaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41722-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: AD23EB41C4
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:18:37PM +0200, Adrian Hunter wrote:
> When an IBI can be received after the controller is
> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
> device is auto‑suspended.  In such cases, the runtime PM core may not see
> any recent activity and may suspend the device earlier than intended.
>
> Mark the controller as last busy whenever an IBI is queued (when
> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
> recent bus activity and avoids premature suspension.

look like this can't resolve problem. pm_runtime_mark_last_busy() just
change dev->power.last_busy. If suspend before it, nothing happen.

irq use thread irq, in irq thread call pm_runtime_resume() if needs.

And this function call by irq handle, just put to work queue, what's impact
if do nothing here?

Frank

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/i3c/master.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index bcc493dc9d04..dcc07ebc50a2 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>   */
>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>  {
> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +
>  	if (!dev->ibi || !slot)
>  		return;
>
> +	if (master->rpm_ibi_allowed)
> +		pm_runtime_mark_last_busy(master->rpm_dev);
> +
>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
>  }
> --
> 2.51.0
>

