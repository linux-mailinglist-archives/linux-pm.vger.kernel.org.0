Return-Path: <linux-pm+bounces-20065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B3A04BD6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01C31880931
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F691F3D23;
	Tue,  7 Jan 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LQtIRmKv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD51E0084
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285862; cv=fail; b=BwrtMeKrAUswatrEytK4Y+RaWgSptbzFS6+cbvyByfeZaPVrLkR0ZDKcfGlrTFYtM6/So09v8STtwy2Y5zpF/97N1ML2i3hldncg1FSpXYf62shyIjroPuwUxNKGpp8It1DeMWichJ19HIXYhFQMA3VpHr3xCGtXvvaZplnZgCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285862; c=relaxed/simple;
	bh=IeLpO4zsu+QaNFco/uVjFgmnf3E2ERDp/+uzCipew7s=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=PbRqUXWbcPABASowon+0RqUhifugq51hUTMv+QZZAElZX7lRDuOJEIBr2FabWkiwkIUk6kxLWZmhx3c7vyFvnZ5fXxoteG0sxxdSSZXA+0mf9apYn+n+HqO2PLj7kl533UnegNLx8oloYDOerSyoJt5nd9vvjwG/P5Y5VTDYyWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LQtIRmKv; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1eV9Mf5Di7NvHEeFPqw5q8nWuXZ6SguGmEqJXgSLBRxL60gs7iqMeWG2pSa0AcgTjKXdCvz6ArB7U9uiIQXk0/H6u7Yq7xoH9nYs2O+IJGdCczRXXIqZTx08K/YEa9p235U1s9YRLMjV/c0sETrOFcmXtILVSoXRRaVwhIZhc4Bqc5Eumovm5TCpG0hbiF9kH/zvqONUdPI5oPX/MjhlIicR+NqzAz63I4TVPwFMlgZo6pJz550Hm5UZGrWpO8zAp+73JD37ix6i5Uy6LtcngXAKoj7FjRySe3Yq9yKIZVBptM8DrBDP7h8AtaHuq1sKnn4pKupB6KhXixNfqrm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQJxAclhJjJNeVg28wHaq9uicLDzplAgqHYpoVJ0WZY=;
 b=I19n3vFQMuG6vbTBkklf2zW1VUk8J6lCY5JhMC3GsGg+rveEZuqn0I+5vqxX/9mwuHcEoZfVeY0Z4Hs9gKZnOzWVL5pca9y4Dm5ceF3xr82wwvufVqv0mpllYC1f8VV1pxjr8NcJkyKYCVhVY1JX1YCvoho/W0SISQot12kpvH0c+JtJM4cKpX3ePyIji4PU2cBEBv+ZQwOb1RktKtGWVRQ2HDJhjX4ExKNHLsPt8QGvVM5X2RRY1QJUMm+3py5vzVtr7ynQKAURCgSwk2ZANYhRAAMgZ8mNom0vqvV0vILvNxZ4dTUPzSI1Cyznwr6M3M9vejZqTsW6oKMNjK4JCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQJxAclhJjJNeVg28wHaq9uicLDzplAgqHYpoVJ0WZY=;
 b=LQtIRmKvvU7G0yDiCZCNFPhFWXojqay+WejQWcu+Buxq6oKhnpYn6oTLM4AXaR62fl1YOQsvCa+DHPzXJr2c6u6dBzWcq+JAK5x/xsFcjkyHShRyj4W5RLEXyajWuFNRyVmcJPyY23OrEUjAtAsKlm8Kp+8gzwG8IN/aUHJJtEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 21:37:38 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 21:37:38 +0000
Message-ID: <913e9c94-4e3b-4c1e-b626-4f2c64068bd0@amd.com>
Date: Tue, 7 Jan 2025 15:37:37 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate-6.14 content 1/7/25
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0160.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::15) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b86858-34b9-486f-c9ec-08dd2f6381d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlBpamVpUDB2ckdWbEFRd1ZkbjFabUtmUTNDeFZzYWRxTGtENGhnejlDTVQy?=
 =?utf-8?B?em5kc3ZCT2ZTaTFhMnh2eGpFRmE5LzNJbm8zZFMrSXhOemNmbjF5bVczalpV?=
 =?utf-8?B?bzVPQUdjdy9Eby93WWl2d0FKNzJySDMwaSt1eEl6OFNOa09WMkE5Ti9aWDB3?=
 =?utf-8?B?SDU0cUxSc0FERUtIY2RWZUtSK05DajFSMnkySkNLL2ZaVS9FbExTMVVvQlFp?=
 =?utf-8?B?d3U4Q3NaZ0NSQVY1RUtPY1IyNUptd2s1R1NWN0Y4R2xiT2k2ckVlS2ZmdG9Y?=
 =?utf-8?B?NVA5YXFNREpwTURpeXd3eG5EMEhEM1JNZkRUR1VJbW9MV3ViWnovRVpoeFN0?=
 =?utf-8?B?amt2dW1BakpNOERMTVJ4M0lhWEVZd2FKL29hbnpYdy9wc1Z5aFhrdFNkWklp?=
 =?utf-8?B?bXg3VkZQRENsaTVIT2dmRjRoSFFndVhDMGVNNjg3bi8renVORElhYnI0RU5l?=
 =?utf-8?B?N0FBSXVuTUs0WXVYZkVrYitWMURHUUQ5anNSNENkMGg5T2dDZ29YaE5DWG1J?=
 =?utf-8?B?eXgrSlprSlJFVVVTZkpqWW1CZHRRb1V5ellGcFVVeE9VRWFpR09hUGpNdFJk?=
 =?utf-8?B?SCt6WXhvaFZuNHhSckVmMmltbHY3clJEdEVLdGo3OVRlQlFOZW9yZzl6WFJ4?=
 =?utf-8?B?WWVLR3c5OEdUanBWYVVWN3J0Mm85UmJobGx0SEkxVHo2elNuTHRDTGZ1N2pO?=
 =?utf-8?B?clo3alEvdUZHK2NkWFJLOTcvYnlkbXEzZk9lWjlEdXVjSTVhcEljdU0za3RL?=
 =?utf-8?B?RmlIa2lCem1YVXZ3KzUrak9ac00wb05QVW9yOWZjeFNWTlFXQ29uL3JOQlRw?=
 =?utf-8?B?b0lpdnJUTDh4ck9qSThRZEl2QXl5dkcvWXIxWkJOQ0k5a25VS3F5bTRoenV1?=
 =?utf-8?B?V1B5YTlyZi9XeTdpRzRzSkM4NUpoQWxtSE9zcDMzWEIyQjJQTFBLS1JJcW1y?=
 =?utf-8?B?emppM2xxcWhVZ094dXhwMFQ4S29ReFdLanFqVGhLbnRRdTFOUXo1Und0OHMw?=
 =?utf-8?B?STN3Y055S1dyU01CNmhSS0FwVTU4Q3Qzdk5MWCttMGUzTkMvR0pFSjU4VGRs?=
 =?utf-8?B?dUJ2OEREN25JcFhCRE96cHJLUjlHcjJHUlMxUlFTUThXcjJEMVJuVWhXQTMw?=
 =?utf-8?B?Y2xUZU85eE5wTnFwUWxIbENmRUxtaytKYkpXcTdySklSaDNKOVoxSFJBTUw0?=
 =?utf-8?B?NitweEdKSGVacG1xdTlHejhnY29QaTBJMjU5THlrVDZQNmtBRXZKY3BxU0ZV?=
 =?utf-8?B?Y21Uc3VuUFhjbDNlTzY1emM4aitVVkF0d25hVnJDZTV2WXFPVExuVmtVUm8v?=
 =?utf-8?B?bHgyUVhVK05VSTVKYTQ2UVFyWHpYbmFFQUZKREhtdXZCUkI3Wmg5UEhycE11?=
 =?utf-8?B?ZTdSL0J5Tk1VeWFhenh2SmpPRmhpcVVDV3RVek80bmVtU1dDb1hZUEN3UjB0?=
 =?utf-8?B?MllsTjNFclRMNTN5aldxNTJ2LzNNNW1Jd2dpWDEyYUhqSVl0MTg1bFhoZGFZ?=
 =?utf-8?B?T2JXZ1UrWXAybFdlcHBBNVU2bGNRR3ZyUnlkb3hpanJDd1hSQnUyemYxemRr?=
 =?utf-8?B?cTd0OHRwTDB4d3hIYkI2ME1aR0l4YlcvV1NaZEhKNzdPWVRQVk1jV1MzMXJV?=
 =?utf-8?B?aFM0REZGQ2NIVHJFdlNsZE8vSlMyOUpERUxkZE9JQkgxNEdiU0xOcU5zTlZ1?=
 =?utf-8?B?eWc2ejNTamhaaEtHYXlIWGN6cjBoL1phUi9LZ2t0c1NEQndGTG50bDZiOGVF?=
 =?utf-8?B?UWtCMUlaOUJEUk90MnMxRFltcEt1RlVtM0xWUktMK2NZQnJIYUw2aXFTOHBF?=
 =?utf-8?B?NDJPcWl4M2VoL2doWVJzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1lsYVRXTjd0eHNCUXE4bkQ5a3ZDcUttWkVSeWdSS0RHeml0b1ZIREoyUE13?=
 =?utf-8?B?WHdsY1REVnJwTGIvMVBhUnQ4U2h4QmMzTFFuTWxHaXU4S1pUcDhjM29lNnhs?=
 =?utf-8?B?czRRcTNVb1JsV3EyM1BHcUIwTkcyL29POUVKTVY4QU1tL3AyZ0RXaDVUcnBz?=
 =?utf-8?B?TFB5czZZS3JjMDFoSkJVVjhZNTdoRTk0WWJ3TkhLWU1ISGpPWTFDV253YzNI?=
 =?utf-8?B?NERhNzZjSnkrbWZrSkJxVU5WVnlZMDB6SVBJWEJjeU1vNTlibUZncE8vU2hp?=
 =?utf-8?B?cWhuai96WUNoL2c2b3o0YlZYK2IrWnhwY2lURGNhYUFndWljWDlFbGFOSXRE?=
 =?utf-8?B?T0hFQjRBSDZYVjhmZjFhTGZNSUVYbFBVQXlNK25FcVVMa0FUWUt3amVCc0JL?=
 =?utf-8?B?dElPRDhQMHZNYlJ1dEIwbHJMdTBmKzhJMFhPOHV1Mk12bTdWL1lWT3MyRito?=
 =?utf-8?B?K0JsbkgrZzZPWmtUMkNqckFoTHAwZ043WUxhbkRLa0JXSWFGZTV2TCtnYU0v?=
 =?utf-8?B?dmxDWENZTGRHQ3ZGWUVkaFpPWWhUVkwvREZMNmNFblR3ZFY3R3JnNFVwNzl3?=
 =?utf-8?B?aWt2cE1maXpMclN1TVlzK1V3cEJOSG1LMG1OdHZ6T0tBOE5HU2FwaXdTQUZ6?=
 =?utf-8?B?RkdQMlMvTEhTeVhac1dsVG1YTjBFQnpnQnFNQm5seG1hcHVody9ta1N2eGhy?=
 =?utf-8?B?T1pMNUtSTlovUkxaMmY5ZkJzUFVJTjRGZjl0UVNETWw1MUxnK0dqaWpqeUcx?=
 =?utf-8?B?Y25tYVhCdmV3dlF2eCtqS1VvSGhGNlcvYVZQdXJueER4UUlNMTB0bm84K0Q2?=
 =?utf-8?B?ZkIycHF1b3B2Y3BDVFJaaDRNbXFzM2g0QW9pUmhmemNtWVpFMThOOTBGZDdF?=
 =?utf-8?B?WUFaR3BxMFJmcmpqenB4d3FQTERLQlkvdERPSnowd3NOT3ppL21VdlBhME5m?=
 =?utf-8?B?anRmcXpXbEhUT0pDeWs5MER0QmRlQk9temcrTGNaN0RuQUQzYjBwTDBGQ3dh?=
 =?utf-8?B?U3N6MWcydG5jT2s2bW9ybHZ3LzI0MjFpZm16Q005V0drOTJvSitUZGRNV2pE?=
 =?utf-8?B?MFg2cGVDT0U2Wnk2aHdpTnVBMzVLMFArNjlZbzJDajdWQjJ0RTZ1OVFYZzU2?=
 =?utf-8?B?MEZCbjFGMjVxTnhWaDk1d3pUMU5aNkpJTWhXemIxQlp4TmZvZjcvOGlKcWtZ?=
 =?utf-8?B?NHVZK3h5LzE4TEJKM0kzVWdyK05TSXFOTDFvZEYyWVE1USs0RktLUmtaMHg4?=
 =?utf-8?B?eC9EMVdiRmJRQVVNdklXbFU4dWhBU3ArZnNCOUZlemZqWUJPbkcwSnprODJn?=
 =?utf-8?B?VkdOL1R6VGZHMjFJM1h6TlB5Q0NhOG9IT0Jzbmd1akhGZFZaaVZPS2FhUlhW?=
 =?utf-8?B?OHM4bVgyTGswYW41UWZkRytZRy9Rc09qY3J3elNrald6UlpCWVkyZXpuQVZK?=
 =?utf-8?B?OG9zUjV6YzdMR25WU3NjUGo5VThUMWZveWJMTHd1OFQzWXl5QysrWWRWRkI3?=
 =?utf-8?B?ZjVPeTYwZlNqcmdsNVBsQWhBS09DOUplYWJ0eHV4OVN3N1lOaFFPMFZERmtX?=
 =?utf-8?B?TEY1U0pSY0tZaktJSENKV0MzczV1MlhtVVJoZEY1Ky9pWXlEeXpIaXVCMVFY?=
 =?utf-8?B?b3VZQUxsemh3SjMrek1Pci81cnl1MUsvSGF1bExuQ1BCUzZmS0lhajFRZGR3?=
 =?utf-8?B?clhuSmZreVVDajI5U2ZjOEFGUm9jajNxRnZpQzJqMmdGSC91THkyZ0VtbVlE?=
 =?utf-8?B?bHhtaktrRVlaZTI4YldMc1dueFJiVXkzeXZnbU1XbmZma0xIMTBEOHM0RGx2?=
 =?utf-8?B?bVlvd201dUk4TFk1aGhBM0RSbFBRZVJNK2xvRWtJelE1SDI5TklZdFVONnVJ?=
 =?utf-8?B?cG5uS0FNVVlEN29SL0xhRCt3UGZ1QzU1ME5jdmdRNExETmR1c3pwL21YdWIr?=
 =?utf-8?B?dExFNWZ5bjdNWTkyZ1RSaUtXMjRXakRidWpiUDlVYW8yWmxCTXdGSWpKS2k5?=
 =?utf-8?B?Z2J3RVlVTE5SZ3d4Mktpa3FjYlBxNktJUHJRN1pIeUlsa2Q2dHBhTnVTYmtx?=
 =?utf-8?B?ZjB0ZnhNMitmZHEvd0FSRitQb3BkN3hSMHNFUENIL3Z3d2lrMk5MT1QrSHNn?=
 =?utf-8?Q?12LoiPGX0/nJORhJl2U1uYRIg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b86858-34b9-486f-c9ec-08dd2f6381d9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 21:37:38.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyib3N3vqV9/06my6Yxtfqbn11DpsBJzvradm6aYY0xDXMACO/QvtAlwqjZIk2GO+pNXmkVNZd1K5wndNWXf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201

Hello,

The following changes since commit 95fad7fb58cfaa2a295aa54a1f001a16b9324963:

   cpufreq/amd-pstate: Drop boost_state variable (2024-12-11 10:44:53 -0600)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.14-2025-01-07

for you to fetch changes up to 857a61c2ce74e30fc3b10bc89d68ddd8d05b188c:

   cpufreq/amd-pstate: Refactor max frequency calculation (2025-01-03 
23:44:07 -0600)

----------------------------------------------------------------
amd-pstate-6.14 content 1/7/25

Fix a regression with preferred core rankings not being used.
Fix a precision issue with frequency calculation.

----------------------------------------------------------------
Mario Limonciello (1):
       cpufreq/amd-pstate: Fix prefcore rankings

Naresh Solanki (1):
       cpufreq/amd-pstate: Refactor max frequency calculation

  drivers/cpufreq/amd-pstate.c | 15 +++++----------
  1 file changed, 5 insertions(+), 10 deletions(-)

