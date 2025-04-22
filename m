Return-Path: <linux-pm+bounces-25825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B52A95CA8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 06:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F49166A26
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D191DFE8;
	Tue, 22 Apr 2025 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLHI6bYk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F9BA3F;
	Tue, 22 Apr 2025 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294539; cv=fail; b=P/JM0u9WXc4ZivSVUYph0cy6Sz+j+O8oaBV7ZZFLnxrxqsLMLsW1ljaOE6ceE44TAY6IR/jn0ReHwZPkjTDxXyyOPUrhgu2hyeXKf3iT1JdIIVNdp0m5UbwBaTe6q8FE9GasPbVLyJfQcVT3WgZfimj/kt3698NGxGNmO+clGAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294539; c=relaxed/simple;
	bh=YroE4bLWLrfeKwfwv+/03IntBLq4IeByb0gkqTuSfAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lzleaV1iVNOql23AE16A/LiMbEUVJ92AgF6Ha7ugxA3yMjr7CfxQ9cOZjblrrTs9AIt7nCfANHEijPZvIXAvQxIZuLZd6uceawniilE9ysyFsp+hdkswem8Ah7xV7M9Ei6mbak9UyGg6urBenfNBcCMoVI7kJH7gBUUnb44prGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLHI6bYk; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITgDKCVGgGhXAQnruh30Q+I9e9j5BCla5RgPz72c1sjZi3Sb/rBV4Eu8DO9vAl8RxJgMILl8xh1qFLRNSrHL+WI3gPmqVx7iYA/oM9Yo93PMzyrBTCmfFizgg6Szq2FAzYfPlbiIvj7oTxewxuQBx04UMd00fD7aLDKzr/3IdxY/XEKFzNMBS7sZo5GLPshctiHSPiCQxNm3Sh/fL8JuB/imJqqBEGYjuuXh5az3kP5nxs7eKubkeQO4SIxlbB/4fKxO8dD/elnEftEMz+AY4JBV0y/tLYFCyWaa42bdcbzAplMu77Ljr7y0jUrAY6GRcHooShGWuLuTAtmyaOqjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uao1nBZmi9T37mGdG7by4Hi4beZkJ4QRuh2Tu16MzDA=;
 b=T6GkXZEUkfQynPeic1+eyHlV2m6Wa4z1/N+4Hln7j6WQzs3aswDh1Cwfjhoyk/RfCtfE7rQBL94LeyOGQ8r/4Xa1P05Am8bezTHnKt3teFYSH9k1cJRphQOiHPmpt5wuIH/kdeH3cHIKT+zQhp0s8Qgx/oIfkGnbXWI7JN+gEa7MPWnl6Y9ebtG3qbQQWS4F1z7qWe+jwHNlzHRQH279WADDi+1cyXTUc5Wk9wb8LUdHcRCG4fp5ZEANunOsUE79V3ya0BlGAbGtSCJPsLnkxdgHun6FXct9mclbUhLYIdRUIjrvxsHXJykOqJ8XjoTT/ZprO4QIiqN+e0SWtAfmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uao1nBZmi9T37mGdG7by4Hi4beZkJ4QRuh2Tu16MzDA=;
 b=ZLHI6bYkI/OBu4fO0ZiJDuTKnqtix03YS95dXEtNal3UW6rdFnfmXOUnNsXqWnInc9ozdd/OO3OlCg04oRLSk7e2r0WqTBjz6/rJLhPt+Y0o4YEHuCR1NXf79BEfaVue24vmTSUUA9j5J3VfTislXqjHhQoh1ejRjLsa66TJF1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Tue, 22 Apr
 2025 04:02:12 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.8655.030; Tue, 22 Apr 2025
 04:02:11 +0000
Message-ID: <5b4b11d7-197e-41ec-82b6-8279125a95bd@amd.com>
Date: Tue, 22 Apr 2025 09:32:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Mario Limonciello <mario.limonciello@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
 <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
 <eedfe953-7468-4b4c-934c-4589de601fa2@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <eedfe953-7468-4b4c-934c-4589de601fa2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da91a90-af63-4247-3e49-08dd8152755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9HSFk0d3VpRVcxMngxTmZHWit1b1lMOGhFbkRxbGdQbXZZbGNYVk85L1lJ?=
 =?utf-8?B?L1lWc25kd0NWbkg0SUtKNTlCeTdRY2c2aGRyUnZyNW1MOXpTZDZ5YThTTmw5?=
 =?utf-8?B?cW1ucEttVlhxTUhyclJabGFmSzJqZGFuODduVzZ2SFZNdHMyZVFBaHcxS0l6?=
 =?utf-8?B?cnUvaXJSc1Vod3ZvcnZ4UjV2ek1RVWEvYXUxUDBLbE1jMnB0cmFmdEJ5MUJo?=
 =?utf-8?B?RjEvTnFqME5JcEQ3NENwLytldUorSWhkdzNjVzc3OXZOd213akh3aFZvSzNh?=
 =?utf-8?B?ZE03c3NLbTVqU0VaeG9Ibk5aaUFvd0RhajdSL25WTWdkek0zY0M0K0E2R3FH?=
 =?utf-8?B?SmMraEhRMC8rbEtFVGtkZHcvQlZjVEY1M09xcnM0dXNKZ0NQajNVTDhVWG40?=
 =?utf-8?B?V01VTk1INzBaQ09JZ2pLTHV4c1ZXWXFzVVpyRm8wRGpZamFneTFjOStHeUJL?=
 =?utf-8?B?Vy84SVpFb3BmRWNnWlZtZlBSbG9HbU9YbHlOQWJPVWs5TjlKWGVUcHgyTUFi?=
 =?utf-8?B?Y05JczFVTEtRcUVYL1N3VnpWVVJlYldqSXROV0tPTnZkQ0J4cXJwSWFncTJs?=
 =?utf-8?B?ZzMzZmZTdVI1ZTFyNm1Dd1lwY1dKMFY0YWwyWlUydVp3Q2VzWGY3dll1NmEz?=
 =?utf-8?B?cllMODBvc1lGZ2N3Y0JUdmtFUVRhblB4SnFVS0ZJUDdDUTJaTUFUQTc0VWN1?=
 =?utf-8?B?bWh3cmIwbkxla24rWlArTHgvVDB5UWRlZmdzVUh2WStMUkw3dkQrMlMxMnpT?=
 =?utf-8?B?dkNVSGFzdjFwQkJXd2FoRVlNT0MvZzFKcXFtcis2anN0TDFIZzR3blJxMS94?=
 =?utf-8?B?Ly9ybnpjdW1pUk1KTCtxWnNTTS82Z3ZxZTc3K01ldlNrQ0Y4R0h1UTNHVklw?=
 =?utf-8?B?QURINTRMazJicG5hVHY0R0N1aDNNVXNENHZqMDhKM3pid2Q3Z1ZsN1NoZngy?=
 =?utf-8?B?MUdLdHhHVzlmRThJTE5aUFdqUS92cnpVMUxvUDJmSkpkVFJ2am5FVk9LSmdy?=
 =?utf-8?B?RFVSd0pyU1BjL2VQRDNOOWZ3Y05oUndPako1OWt2QWdKNjBMZWo4MU1MNnpL?=
 =?utf-8?B?b25GbUhBOFUxbnpIL2d3c053VUhuSzQxaU44UEJ5WWVVWThxdXBzUnpSQ1du?=
 =?utf-8?B?Y20rUHF1bXNXTWJUZXQ5eHl5VHNubUtaL0gwbFByZ1Rub01DK005NzZ2ajdW?=
 =?utf-8?B?RTdpNG5YRDA3WXgzejh2UlFHdkZDTGRQZFB6M3dQVDcydCtIQWhoaGo5K3NY?=
 =?utf-8?B?N3hCUnlGSFNCRnlnSlJiZkZOWEh1M1NrY2RxcFNsM0FvK0FuSmd3SDR1K2lK?=
 =?utf-8?B?WTRwd1I3SE45dG50T1Jva1NpYVRoaWNYaGVyMnd3Q1B0YzljUlNLYWNicUts?=
 =?utf-8?B?SUl3NmczbGZhaGE2cjZhQ2ZncEhNOS8wbm15VGtuUW5KeGhCQnAwU0lhWVNE?=
 =?utf-8?B?alZrU1JBUzEzQ0lKTXlDaWVuOUpITDNLMXNKeGUzeitST1I2aGdwYzhFREpW?=
 =?utf-8?B?U3B3NUZCaDFqa3JBazN6bk1FUzJMSXlOU1RvYmVOZ1V5K2xFR3VaRTA3Skwx?=
 =?utf-8?B?ZFF2ajFhb0Y1eDNwOW1PNkxwcjJzU0tLcDlWU2RMOWM0aGxXK25zVGtMdEcr?=
 =?utf-8?B?M084WW0zVzJFemVVSE04M0JHMVBjSHkvenFxL3p3b1o5dFhDc0NWVW9YN1dn?=
 =?utf-8?B?c3RvdUxuUlY3bzA4ODJ4aU9MRzk3NndHd0M1enRKdGw5Y0sveHBld1dHZmxq?=
 =?utf-8?B?b0xsT0pzVHNjOHJXT1diMzEreWRQYzZvZnZKY3hGRUhLWENwcXJNMTZhcTkr?=
 =?utf-8?B?RWlyQU5GZVZjYVJld1ZqWXI4clV6V1RNanJkZTZLTHJPSXZSVFJXeDNxenZJ?=
 =?utf-8?B?bnd6SmZTMjJFSjZYaDM2blV6aTJjVHFMVCtIaGlqT2FrZjFhanI3elJjYldT?=
 =?utf-8?Q?1S1jJuj+cTs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVozZTBTWVg0TUFUaGxUQjRIRkE4WXVSSms1VzhHeGREc0dxajZhalNzZmpk?=
 =?utf-8?B?Q010bnRNSFBudEc0R1RhVnlmMjU5QnY1NU5ZcXp1OFVMakcrQVV1TlpZa3R0?=
 =?utf-8?B?azd4RnRyU29ERWtETWZWaDU1ZDZwaHpJWGpBUXhrOE5CNndJVmtJdFJPREQ1?=
 =?utf-8?B?TVFZSnFuajNXZUVnTndmVTMzcVJlT2JSYjBLN3JRQVYxNHQrV200WWxzWEg2?=
 =?utf-8?B?U1oyb3plZzBrTi9BK3pYTGhzcjdCMk5JTzV4cGU5OVVwb0xNL1pCWEZPZ1po?=
 =?utf-8?B?Q29zUjh0d0xVQ3pFb0JjYmo3Um4yMUkrb2tLdGs1c2pNOGxFT25QNmRKTkg1?=
 =?utf-8?B?eHJEeVBZVUd2ZVZlelNQY0dkOGZyR0kzaXdLQkxZVDZwUktBcitoU3hjRjM0?=
 =?utf-8?B?NEUxUmxzVUV5bloxWVZNYkJNZG1yM0twdUlPd2wzNCt2L1RIRkczeTlFR0d4?=
 =?utf-8?B?d21XUFY1d2ZMSUpldXAreTlQSnZiL01jK2JEdTBndEN4dkt4NmVwbnFOL2t0?=
 =?utf-8?B?WmlabzJXTUtmYXRUdS9ValpLRWt3eWJCVzZUd0o2UEYvcHZKQVFhV1NKVmNF?=
 =?utf-8?B?M0x4QTd3bGJReld2U0NIWUNMcWVBdmVxSjJIM1VIb2xNUVVTK3RXekp2VU9W?=
 =?utf-8?B?T0sybW00M1BxWUFTSURLL29FeWZjWG45a1l2RXRvdnZ0cmdCQnAvcmNXVXly?=
 =?utf-8?B?OFhGdG1LbExWZmVxdGVicEVqQjFjQnllWW9DeVV0V3F3SUtXS1ZidDJURkw2?=
 =?utf-8?B?T3JqVFU2Y3FUbXJWMktlcXEyWWcwSFZpZC9FU0VWSmF4Z3JYZ1E1NUJGZ3Vl?=
 =?utf-8?B?QnpML1M5VzU3NlMyWHZ1ekJINWd4bnRCQ09VQ1hnZHIvbExKUjhTZ3lZWjZF?=
 =?utf-8?B?TW5HWFFmV05vamgweGtWZjl2dkF6Nko4Wm1YSDZLREx4TzF4NGRiZzBIakVP?=
 =?utf-8?B?dHdBN3I1d3FiU2RUN0dnTUl5RGMxSmp0RHpXSTg2NlYydFVFQWc2VU1uV1VW?=
 =?utf-8?B?c0w0VVcwVDg5RnhlTTkzL2RhaVdrRm02M3Z2NEdESmd3azh4L0c5UUJTdEE4?=
 =?utf-8?B?bzIzTHpKS20wTjUzTjN5SFcvaEQzS0VZZGpWWVlKL2R4ZU40YXhEYVI0THpZ?=
 =?utf-8?B?eG43UlRHWWNEakVBbGhOaTNMeGxWaklzbHZNVzJMYmEzSEVxQjRHSkxyMFpZ?=
 =?utf-8?B?RFRCZmtsWVQ0cVhtZ2lDTDdFWW8xN29YVWlVZlVQU2FwdndFangzR2tQRXBh?=
 =?utf-8?B?TkptcGxTdk9uTWMwQnZOM3gyTEc0czdWd0txVHRPUW9LYTFEb0dTK2JiUHdZ?=
 =?utf-8?B?bHZnTnVaN2hMVVlEV2EyK1N5L3pGNWU4K29TcTVvQ2xHN0hCbnY5eENRczhT?=
 =?utf-8?B?Mzl1Tnh6Ri9lZFBJQVVMZ2ZoZE1hLzFDODZHdW9zWXlxdDVIWjEvUkhzZ3hh?=
 =?utf-8?B?dVJiR1NZRitxbGhGdXJockJRaEVFaWt6aEk5NzNCMXpRL3FnUWNYVkpxeWgx?=
 =?utf-8?B?S1Z3MDh5b01tZUJnZGhqUmJONE1nZDQxQ1hmTkRmWkxXaERqTlpuaTBtVDFl?=
 =?utf-8?B?ZDBPRlVYQmdraFdqVHJUZ1lKSU5MYVY5Ym1JMmNkdXpQcE5JZ1RmdjlNejlj?=
 =?utf-8?B?V1k0OHV5VlpVaC9HYUhsRlhuWHYwZ0x5cEtlN20yd3Q5c2dwVWV5NDVraGQy?=
 =?utf-8?B?Z1FaRHliM242bVhvOWVpOWN3VnY2SHdDZXZXRzlmSi9ZRHRIQ2RMbzVsUmR6?=
 =?utf-8?B?T2JwZEFKM1YvN2xWcWxjSXRzMjBIMWV3c0VhckhoY2JkMnJXSHBNQ1J3L21w?=
 =?utf-8?B?QmZIMk9NREd1NWV2YUpwSmJxNGRidTdMUEFpM3VzNzF5alFjL1gyNVVIa2VJ?=
 =?utf-8?B?WlNGcy9KMzZna3Y5VUp3cGhuL0JnU0M0QlcwSWFrS2lrQ0JlQ04yN2cyTVF5?=
 =?utf-8?B?N3BlOUl6QVBINUgyU3VJMEVnOTQwbVoxSFc3cUNJZURzcXdqZlA2bitXY3Ey?=
 =?utf-8?B?QS9tTk41WjlSeHd5bmhEOUYrRXdzMXNYak1HVkVlTlV5OEZjeEZNaUg3NzJN?=
 =?utf-8?B?N1Q1dGhQRGlMSi9OWDU1Z2dWTkFGVnEvQzRVTi8vSkJMZHhCelRrOHJZZy9Q?=
 =?utf-8?Q?skt+xpn/ycmWggF5IHIDiKa2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da91a90-af63-4247-3e49-08dd8152755a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 04:02:11.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lASr50HSyuVhpp7B1kvCr8y8DWv5vT0uKHtqaG8Vm30nILGsr8RPO8aDEDeriBYhPh3/tnS0rwJKLfiAb1hKOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958



On 4/21/2025 10:23 PM, Mario Limonciello wrote:
> On 4/21/2025 3:04 AM, Dhananjay Ugwekar wrote:
>> Initialize lower frequency limit to the "Requested CPU Min frequency"
>> BIOS option (if it is set) value as part of the driver->init()
>> callback. The BIOS specified value is passed by the PMFW as min_perf in
>> CPPC_REQ MSR.
>>
>> To ensure that we don't mistake a stale min_perf value in CPPC_REQ
>> value as the "Requested CPU Min frequency" during a kexec wakeup, reset
>> the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
>> exit and suspend callbacks. amd_pstate_target() and
>> amd_pstate_epp_update_limit() which are invoked as part of the resume()
>> and online() callbacks will take care of restoring the CPPC_REQ back to
>> the latest sane values.
>>
>> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>> ---
>> Changes in v2:
>> * Modify the condition in msr_init_perf to initialize perf.bios_min_perf
>>    to 0 by default
>> * Use READ_ONCE to read cpudata->perf in exit, suspend and offline
>>    callbacks
>> ---
>>   drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++++++++++++++-------
>>   drivers/cpufreq/amd-pstate.h |  2 ++
>>   2 files changed, 56 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 02de51001eba..407fdd31fb0b 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>   static int msr_init_perf(struct amd_cpudata *cpudata)
>>   {
>>       union perf_cached perf = READ_ONCE(cpudata->perf);
>> -    u64 cap1, numerator;
>> +    u64 cap1, numerator, cppc_req;
>> +    u8 min_perf;
>>         int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>>                        &cap1);
>> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>       if (ret)
>>           return ret;
>>   +    ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>> +    if (ret)
>> +        return ret;
>> +
>> +    WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
>> +    min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>> +
>> +    /*
>> +     * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
>> +     * indication that the min_perf value is the one specified through the BIOS option
>> +     */
>> +    cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
>> +
>> +    if (!cppc_req)
>> +        perf.bios_min_perf = min_perf;
>> +
>>       perf.highest_perf = numerator;
>>       perf.max_limit_perf = numerator;
>>       perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>   {
>>       /*
>>        * Initialize lower frequency limit (i.e.policy->min) with
>> -     * lowest_nonlinear_frequency which is the most energy efficient
>> -     * frequency. Override the initial value set by cpufreq core and
>> -     * amd-pstate qos_requests.
>> +     * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
>> +     * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>>        */
>>       if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>           struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>                             cpufreq_cpu_get(policy_data->cpu);
>>           struct amd_cpudata *cpudata;
>> +        union perf_cached perf;
>>             if (!policy)
>>               return -EINVAL;
>>             cpudata = policy->driver_data;
>> -        policy_data->min = cpudata->lowest_nonlinear_freq;
>> +        perf = READ_ONCE(cpudata->perf);
>> +
>> +        if (perf.bios_min_perf)
>> +            policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
>> +                            perf.bios_min_perf);
>> +        else
>> +            policy_data->min = cpudata->lowest_nonlinear_freq;
>>       }
>>         cpufreq_verify_within_cpu_limits(policy_data);
>> @@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>   static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>       struct amd_cpudata *cpudata = policy->driver_data;
>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +    /* Reset CPPC_REQ MSR to the BIOS value */
>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>         freq_qos_remove_request(&cpudata->req[1]);
>>       freq_qos_remove_request(&cpudata->req[0]);
>> @@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>       struct amd_cpudata *cpudata;
>>       union perf_cached perf;
>>       struct device *dev;
>> -    u64 value;
>>       int ret;
>>         /*
>> @@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>           cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>>       }
>>   -    if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>> -        ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>> -        if (ret)
>> -            return ret;
>> -        WRITE_ONCE(cpudata->cppc_req_cached, value);
>> -    }
>>       ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>>       if (ret)
>>           return ret;
>> @@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>       struct amd_cpudata *cpudata = policy->driver_data;
>>         if (cpudata) {
>> +        union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +        /* Reset CPPC_REQ MSR to the BIOS value */
>> +        amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>> +
>>           kfree(cpudata);
>>           policy->driver_data = NULL;
>>       }
>> @@ -1575,12 +1600,28 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>>     static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>>   {
>> -    return 0;
>> +    struct amd_cpudata *cpudata = policy->driver_data;
>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +    /*
>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>> +     * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>> +     * limits, epp and desired perf will get reset to the cached values in cpudata struct
>> +     */
>> +    return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>   }
>>     static int amd_pstate_suspend(struct cpufreq_policy *policy)
>>   {
>>       struct amd_cpudata *cpudata = policy->driver_data;
>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +    /*
>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>> +     * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>> +     * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>> +     */
>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> 
> In EPP mode this appears it would be OK because the perf value should get reset in the resume for amd_pstate_epp_update_limit() but in passive mode won't this never get reset on resume from suspend?

In passive mode, on resume, amd_pstate_target gets invoked through the code flow mentioned below,

Cpufreq_resume()->cpufreq_start_governor->(cpufreq_driver->start()&&cpufreq_driver->limits())->amd_pstate_target() [this is for _target() based governors]
For schedutil, start_governor will register the update_util hook and it will be called at every util change, which eventually calls adjust_perf()

I tested these scenarios using "sudo rtcwake -m mem -s 10" (suspend to mem for 10 seconds) on a server system, within 1-2 mins of the wakeup the CPPC_REQ MSR 
values of all CPUs get updated to sane ones. It would be helpful if you could test for such scenarios on the client systems as well.

That said, there might be a small window between the resume and governor trigger, where the value in CPPC_REQ MSR would be invalid. Are we okay with that ?

> 
>>         /* invalidate to ensure it's rewritten during resume */
>>       cpudata->cppc_req_cached = 0;
>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index fbe1c08d3f06..2f7ae364d331 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -30,6 +30,7 @@
>>    * @lowest_perf: the absolute lowest performance level of the processor
>>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
>> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>>    */
>>   union perf_cached {
>>       struct {
>> @@ -39,6 +40,7 @@ union perf_cached {
>>           u8    lowest_perf;
>>           u8    min_limit_perf;
>>           u8    max_limit_perf;
>> +        u8    bios_min_perf;
>>       };
>>       u64    val;
>>   };
> 


