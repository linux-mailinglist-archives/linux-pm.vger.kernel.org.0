Return-Path: <linux-pm+bounces-35056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB1B8A8F3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37A77C5DA7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C8321275;
	Fri, 19 Sep 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VxhZKjBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7831E884;
	Fri, 19 Sep 2025 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299145; cv=fail; b=cDmbM8zdKwGbRFRcKBRF1WH3yndsWQn2Q4UC11qiup7wq2rr49kaqC3tFm+aCgsS8Erjua896eiEUcYurgqzgJn4aVakAweb9bhXosiX2DgQbNE/RGLVOLjrDMUvzpBxSlDTudrP54xsuTwdjerWOMTNrTPqKDSDP4GKXRcOedI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299145; c=relaxed/simple;
	bh=l7uD6BrmYyWYaR0Blolg8aZM4RREwPNzUIuk0vV9jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bX6+nmG13we834fzqqi4+79inFBdJwompOOU/yAhqQVmCUVxC638sIS8tqNS0+w0W+Ceogx05LFIr68mgEGQ8PtJcFNsq49ycaVwaek4Mu17eNwdYCWw3zGknIX+qYUoyvH9Z6Hl4ch6FWd6NVO4CnEfykgR3dlaBkLv0fQTR6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VxhZKjBS; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ufupekn6Z/XmjuaIElaZ/4EXw+iFibZu94PrBdbXLPWVv7JHoEpGQivPiJal/FNC88c8cR73NhAidscAS3+aNYDzbY55meIQT7iBbuZnosxC7msP5jehU8CBafUthYMyXtzrIX/6VA4ZP+cSBasAoZmV4QNcg35bvhInwXWOHEwHpSFvWGgyeAp1hfcwAPoN3ziPU6rhqkUAJsxmSimvuRkV+eG/sfX1S9t0r0LaMcLfCLcF8Z887/mMhSUvrosBvfHk9cLTcKaEvK0wJPk3KEMn68QSAqPeVbojr+NSTs6K9v/ycjUufpeY8kjPszhd8FhGF7Bvb/TFtu/M+E6fOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26f1fSDASqrgbdr/sDmftEj7wsCrRPDvn2C708YFtGU=;
 b=SfrrUaCynxrKZ/cEJZ8EDMGKUCixggj1urb8V9ZRZp95UDODlP0gSzemx7S11+puiyH3bYGRzYw7hx3iZSzBZELze4D0g8KxaZHPLiQCCpo68s/9zxUTDKl16g69vgJ8IYuvZgnq+kzV2SS3BW3wY9B/xZGJd4eV/9WjPMDZvpIybQ/47mb0PhLqKdDn9muD3W7Be6zvDznp3HXN4y3Z0rAjRRFbG83vha8Meuppz4d3p3YkgrKajxd0VeL7fYOpw60TLdNlMl14LtWoSp03/FfAQJgwk8EzN1S7vedKl9O9l3Dh2aajKhTtsbD1z0phVOtJtxPTnwZYaF4BrQ1WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26f1fSDASqrgbdr/sDmftEj7wsCrRPDvn2C708YFtGU=;
 b=VxhZKjBSEqPVvzMyikr4bGiuAuJyYgDbotOERRscvFWiD1oSm2BzSdE1KH4n1t53eRC9YAoeLcGAt7WmlwV70YZmce4OIIuo+0CJyeD4CBZnyU+L/G038vf6J0xQ6lDwe7NByDfiAyXnqOhasIl9j/1tRjcE25QClQscYFBPrl6BctsHyL4UdX3ZN+zGbRW36zJPLVaptIFBBFfk/YvqD73ThxP4bIdeLVOPRYOGRoXrAmo1h9/Gp5nt7yhrUuE7QyyGwKfFJDnoTK/pn1KTeC5AE2ZCn3De/djjApyPcZbP5Uzb8DRiNgD7JrksEtVr1jHTi7uUJ9yAGXEyWxyGHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI2PR04MB10165.eurprd04.prod.outlook.com (2603:10a6:800:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 16:25:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 16:25:39 +0000
Date: Fri, 19 Sep 2025 12:25:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jacky Bai <ping.bai@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v4 2/4] thermal: qoriq: add i.MX93 tmu support
Message-ID: <aM2D+q/XCI38M9sp@lizhi-Precision-Tower-5810>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
 <20250821-imx93_tmu-v4-2-6cf5688bf016@nxp.com>
 <d9392dbc-806a-41df-8992-28c3d6132309@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9392dbc-806a-41df-8992-28c3d6132309@linaro.org>
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI2PR04MB10165:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f380b8-6318-4177-dc0b-08ddf7992b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVFxWGdpSVVlVkNiTmFLWjV4Y0pvWUtlYlQrYjRLdFN4dklLbnhiOGlCVEI2?=
 =?utf-8?B?ejMzUnoyZUVJL1RoYkFLMGJEaGVXT08xNm5yK2E1b3I3dGMyK0N4NFRSS1Mr?=
 =?utf-8?B?RVlWTzVXbjdSZDZDWVpQN0w1NHQ2TXRNZlY5VkRDRlRkdUt5T1JwdlVtdjR6?=
 =?utf-8?B?SU0zMVlOZVpuelNTbmk4c1BVblRUR1RRcHptb052dVBOdWM1eWlUNS9Eekhp?=
 =?utf-8?B?THVUWDhpMGY3WXNJU2RFN0dnQzRJeXM5anlwUGRjK3FJV3d3Q3JoOStDRTVx?=
 =?utf-8?B?dFNjZ0NyOWN2WXJDN0pMaEZHaTFHSW53Q3lXUFhQRUpmNkFmMk83c3JhY3Fq?=
 =?utf-8?B?ek92NTMvdTM4QjRXZG4yUi9ZSGNwSmw3d044OGl0aUgybm90Qk9yQ2ZwNnF4?=
 =?utf-8?B?dTJwZTNKazlkRnc0TGhJbWpkNEpSbGo2ZmxqR2hMQTV6S1VpUE9oK0FLcmFD?=
 =?utf-8?B?TUs4ckFvbC9jMU5wdUpPMlhOYWc1d0tQZm9NMU5rQm1FQnA3dEg2S1ZjcVVk?=
 =?utf-8?B?NjJxSnRTSng2TmRpOWt0ajhLRDJnWGc4bVFpRm9YS0JkWnRpajhxbVhUV3dZ?=
 =?utf-8?B?WjAxSlRidDFHeHhUeVg3TXkycGFiZ0VnWVhNMlF2UjB2RVNoc2FtQ1lJS0RL?=
 =?utf-8?B?UEY2TFl1bERxTjJKdUpPVFNrMzZwWlBsNG9iTzZOMkVMdm0xV1pCN09kazlx?=
 =?utf-8?B?TlpDVkwybDdIdHY3alpyZ2l1RkRCK215WHZWSS8xM1RMSTJsL3FTTnVNZ2o4?=
 =?utf-8?B?cWFscTJlUERpejdqUDkyMFQySVQwNm0wOEZRNGNST3JFMzhzUEpTTFZucWln?=
 =?utf-8?B?cWEyWU56M2tlQVo4elJEeVhlek9Kb0FZMEZmSDF4dHZMUm5FbC9LS29pZkto?=
 =?utf-8?B?YmpzaUl2aFdNVkNWUWZNVjlnOXNoNG8rSVdZZTRBdHlnOVZGbjVwQzhKUDZx?=
 =?utf-8?B?Q3NvS3VZb21FelV0SmZZZ0s5cG1YR3FlejV5eUppZWczVStmTDQ0ZmlGakdD?=
 =?utf-8?B?MGZVeXVJOHNoNWRPZWZFTWRCWEZMOW1ldFVuaWRCOURBTnBqVjNDVG5RTTlt?=
 =?utf-8?B?cnRrKzh0N21KZDgvNXpWbEVRWVVjN2VLdERUQ1daTVMvKzJlRXpuWUlvUmNi?=
 =?utf-8?B?L0JjdWUrYzdkeHM2RVYxblhaL3RhYTNRUnQ1RTVaUThWTXZldTlYZkhyQWNz?=
 =?utf-8?B?d3l2elljWjF2U2Q4SytwcXlCL0FkQ0tTTGVFTG8vVkRDbG5uUXpsUG5iMWJT?=
 =?utf-8?B?MUpSRTErSGR4VFFmTnFwN1loYUc1ZXNmdnhPZTYvMHFLZnNMWi8vSnRRQ0NB?=
 =?utf-8?B?amU3OG40bEs0NGJrdWZ2dmdyUlZCQitGUG9weXZraGhiK0kzTWxIR3BBTU5u?=
 =?utf-8?B?eXRCZlRwSFNuT0E4UFd3L3MwS05kOUdrSFkxREgvR2xWRFJkd0prNWFWNkpF?=
 =?utf-8?B?ZjRPSk5vQ2ZXMG9zMmF0RWJpajhHdE04VjZmeU52V3N0aHJxblFtbXN4bEJ1?=
 =?utf-8?B?UkZXclRFSmZZZjdoYVN6ekhFa09CVFprVlBZMlFPalJ4MU5pczVPUUpUcXh6?=
 =?utf-8?B?MVRkOVlRYTc2NkhUVEpkdnd3cVJUZzZEMWw5blFiTWVSeDNQMGdhWTFSUmZx?=
 =?utf-8?B?Z3Yzb3l3bDAxQ3hMdHhhT2gwOGRJYXp6VzFJZXVxNkM1TmpmMzZKcEwvSGtt?=
 =?utf-8?B?bGNRMlhURTZrTzdROU81RFpObVpHMkVlS05NUnpsVFpOaERDNmtINlM5aFdh?=
 =?utf-8?B?ZG5OK2hHTm9DK3dIclVnUk9vQ29xalFuS1IySmkxUFNIaWNIb3BobHh1Yzdx?=
 =?utf-8?B?MWhZUk9wY0dVVElrS1htT2tTZ00vUUFHanNudUljWWxyNVhBdTRMZmVQWTk4?=
 =?utf-8?B?anFIUHJnSmNBMWlXTGxTVy9vcXJ5N3R2WjBRQ1Zmays4OTZnNUZURU95bW4w?=
 =?utf-8?Q?lIWYYWJMP4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGU0eFNxU1BaRHVQZnZLUnJmZjFTQkRhUWhCb252SDFwVmpJNFAydVdMSlRp?=
 =?utf-8?B?QlIya0xGWmF0b09UMEdTY2FBWmdkVUZXZ2VtRW03WVBTL2lDL2NqUlJoNXBm?=
 =?utf-8?B?WVpRLzQ5Q21xaGlEa2hkWFdsdG9LL3pCTFdVWSttVFBkenZZWEthNi9NS081?=
 =?utf-8?B?b1hoUkhDWTNmdmgxT3d6SEFmblR4KzMrb3hrMFl5RmJXSHEzQjg0d0Q2MTQ5?=
 =?utf-8?B?UjAwMnEwTXFNQTloMXRoQVBnMFlzWGFGV2RkWC9YU0FQazFWaTRZTWZxR3Ju?=
 =?utf-8?B?aUNtY2hXVmxDQkdOdTNBbFU2V1MwY1Nyei9rSU9OWjZXSitpaks3ZHBSRnAy?=
 =?utf-8?B?YjlkcVp6UGNFS01lSTYweFd1VWYwcmdsaHAzdThEcTRIVnNQSmg5aUtIQkJE?=
 =?utf-8?B?VGJ1dFlEMkduS1FJS1FzTjNlQTRjbHkwZ1h5NVd4VU9CUXczNTJNYzBudHpj?=
 =?utf-8?B?ZGM1ODhNbzBJdEQwbnVKdG5oMjVpRHhiM1YrNm02RmF4SUpUMTFTNEpHUlZm?=
 =?utf-8?B?dXZHdE9ZTmIxOHkxVm1oNmJhelBWVzdybEl0SkowMjZMSVJQTkFiL1JYVmJO?=
 =?utf-8?B?MGpsZ25HaXgwQzZ3ZTNQUStvTElRRHZTY1R1c0RQK3BYK2x1bXJ6TWpldlQ4?=
 =?utf-8?B?K2tHZ3RxdDhkVEFPeUkvTUdWUkJZamhZYU9zRTEzVHg2bnF5eHBydnBHNFNE?=
 =?utf-8?B?SVFhb3JpWmMwKzI1MndJblVxdXJLRGFNcWZRQ3p3QnVrYWJKOW9lSUp0a3dx?=
 =?utf-8?B?NEZ0SzFPQWEyREl3S2pndndIYXJoN1R3VWZjZForWGlkY0l1QjBabFFpcW9O?=
 =?utf-8?B?ZlpGVDR1ck1seUtmVnBLbThpcFNPLzBKV3l5RFZFTXRDeHNtQ2RtaGFCMkEv?=
 =?utf-8?B?ZjdvbXJDUFJVSVZsbEZhZnNGYlNSVTB2TmhHMnBYN0pTTmRNMlZEbDNGSkUy?=
 =?utf-8?B?TFdoRStsOFFmNU85S1VFMmU3U0VpOG5XQWNsditoV25kV2xqRTYzMlpaREVi?=
 =?utf-8?B?aGZwdU9jZnRhTHhxbWJvamkvVERZVy8ra3lwbXdRZzZHTllNRWE0ZnNQV0lG?=
 =?utf-8?B?cFpkbVlRZldyZFFrdXZqcUgyeXdRRWZHREhBOS9XdkhoVGl5bDMzRzFsQ3JD?=
 =?utf-8?B?TnpPZGU5enZUNjIzUmxwTXNJUVZtMDlLdEF4TGZZYTFnUWl5R0kxVFZZc1J2?=
 =?utf-8?B?UlZvWjExRVBKTmVJNzhOdENjTWtJTzk5SUN0RmNtY0p3ZEtIRFloTk4yZ3Q2?=
 =?utf-8?B?bzdGckc0cWRJc21kaFEyTVB0bnI3M2RyNndOZ0tacVZjbnBYVmdaZkIxUHl4?=
 =?utf-8?B?eHF0cjlENWNEMlY3bERwWDViMXRXN2lOQnZWcVFQZHU5cVlPS1NKRWZ6TmFE?=
 =?utf-8?B?NzlIRGhBZVlpU3o0NDZaTUliSk9kZUdpOGMwdVNmVTA2ODVtTXRYYTRGUG9P?=
 =?utf-8?B?OWZoWXk0V3B3ZVAwcU5YekRqODlUM1pGbHVvL3VSWmtvV1JUdm9sMlRXMGJV?=
 =?utf-8?B?UVBjSm53ZTZONUhtN2l2aGNUUWx6dHRDTnFEdFMvSm8yakl0WTRQSE52em1B?=
 =?utf-8?B?dGJEanR3eUFnYkFIS3ZyMnp4Y1ZCZHhZL2Y0N3dsRThvUnUzZkg5UUFxZW10?=
 =?utf-8?B?TTIzdVNyYTM5Y0F3VzhVR25rcFhRMWRJYzVUMlhLUkh1UVdESUl3TlF1TEQv?=
 =?utf-8?B?V252aktZclAzdFYwT0Voc2crQVd6eDNrMkNJTVltckl5U0NPOTErcFcxTGkz?=
 =?utf-8?B?bHN3eVQ0VE0zK0ROTVF5S2QveDBOdXY2NEpPQ290akJxQnVEekFaR1JqL09J?=
 =?utf-8?B?R2RqWHh1M1d6WUZIZXo5ZDBEQWJoNlZVVjNVK3lHc2VYWm5BVXJ1TDh1WXZQ?=
 =?utf-8?B?UFFqWElENHIwRGdSZkVSVThBaHNvWUhId1N0eGdUcVpUZW8wbSszQUg5ckdj?=
 =?utf-8?B?dktteHF1VGxSSDVNaHNyeDNnNkdoVnAwbE4zYVRHYm5MeTlXNXNUUnpiMjNm?=
 =?utf-8?B?dmV6Qk51V3FBbFprcTVRZjZyaFFBU2sxc0FXSGhxQ1Q3ckIzQnVQeHpSMUlj?=
 =?utf-8?B?Z0ZLcVFpY2RFNnRJR2dTV0Z1UjNVMTFPcEtIcnkxcElvdU9RUU1ENmhGeHVK?=
 =?utf-8?Q?Pjlf5PBYuT7rrDUHelYA7ECTx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f380b8-6318-4177-dc0b-08ddf7992b85
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 16:25:39.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBUZOaxavZ+V0nGo6pqjbooni/87QXnawYibGBJ8Gm3oaDdK/oYn6i4GnfskPUAsYTxjtIxX4GqgReGMvovkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10165

On Fri, Sep 19, 2025 at 05:51:20PM +0200, Daniel Lezcano wrote:
> On 21/08/2025 08:23, Jacky Bai wrote:
> > For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
> > from the ID register is the same the one used on some of the QorIQ
> > platform, but the config has some slight differance. Add i.MX93 compatible
> > string and corresponding code for it.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >   - v4 changes:
> >    - no
> >
> >   - v3 changes:
> >    - use the drv data struct for match data and refine the code
> >    - update the copyright
> >
> >   - v2 changes:
> >    - use the compatible match data to identify the i.MX93 TMU variant
> > ---
> >   drivers/thermal/qoriq_thermal.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..b2e634547271dcf512c714907baa162921d2d527 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -1,6 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   //
> >   // Copyright 2016 Freescale Semiconductor, Inc.
> > +// Copyright 2025 NXP
> >   #include <linux/clk.h>
> >   #include <linux/err.h>
> > @@ -24,6 +25,7 @@
> >   #define TMTMIR_DEFAULT	0x0000000f
> >   #define TIER_DISABLE	0x0
> >   #define TEUMR0_V2		0x51009c00
> > +#define TEUMR0_V21		0x55000c00
> >   #define TMSARA_V2		0xe
> >   #define TMU_VER1		0x1
> >   #define TMU_VER2		0x2
> > @@ -66,6 +68,8 @@
> >   						   */
> >   #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
> > +#define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
>
> This is not adequate for code which will evolve. Please don't use this
> macro.
>
> >   /*
> >    * Thermal zone data
> >    */
> > @@ -73,12 +77,17 @@ struct qoriq_sensor {
> >   	int				id;
> >   };
> > +struct tmu_drvdata {
> > +	u32 teumr0;
> > +};
> > +
> >   struct qoriq_tmu_data {
> >   	int ver;
> >   	u32 ttrcr[NUM_TTRCR_MAX];
> >   	struct regmap *regmap;
> >   	struct clk *clk;
> >   	struct qoriq_sensor	sensor[SITES_MAX];
> > +	const struct tmu_drvdata *drvdata;
>
> The drvdata pointer is not usually used.
>
> 	u32 model;

I think it is not true.  Copy model here is not extendable if need add
new field in drvdata in future, especially need ops callback for differece
variances.

Just list two examples:

https://elixir.bootlin.com/linux/v6.17-rc6/source/drivers/pci/controller/dwc/pci-imx6.c#L173
https://elixir.bootlin.com/linux/v6.17-rc6/source/drivers/pci/controller/dwc/pcie-qcom.c#L286

Frank

>
> >   };
> >   static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> > @@ -234,7 +243,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
> >   		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> >   	} else {
> >   		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
> > -		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> > +		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
>
>
> 	regmap_write(data->regmap, REGS_V2_TEUMR(0), data->model);
...
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

