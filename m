Return-Path: <linux-pm+bounces-13043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5FC962BD1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 17:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9B1C203C1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268B1A2C37;
	Wed, 28 Aug 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GQpuMPte"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCF1A3BAF;
	Wed, 28 Aug 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858055; cv=fail; b=rV23cRyf0mX3vyZoA8q1pLMbeI2118k9B9zwQnVz1GCBmvRG8xnC0Tbtq9SVXSKOQOa4IN5x5RFGcupTWA0DFQ/ozpq29vJIssVqx07RrHHIjFd8wP76NBeIFaMZo4806BuY45E03feq1wzGIvI1pMwR995qdWadKIybipKj5ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858055; c=relaxed/simple;
	bh=/oz76VaNLFMpm6hvdtd6QPfUahEpubb3R3r1Emg1+z8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+h7W45dWqX3sheD4DmrdhdOwGmwPBBVyMjWgqU1JPaGPUxyk4CawOrZQO0fuTVXPF4545pxpbPV6d0TIOz0NDjOudJpku4l5MUGG4W4hwdwBON/4BO7Z8hRih1y0GZP/RXkOOYUbUqCfrT+7c62h7Ygb+mlHJdzp8dq0b+SFX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GQpuMPte; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkNj83ng/vATdlJW18yu7ddu64FIZd60jk5rNaLqB+n7rgACiOVCrv7PqZLDV1n0a/kFaj7HAZxioNTXsRTKjbH1a9CP7klz/9a5aC3u1OC9XevVn17MEoDR05z5ulhPML4oa41rBVWKhMj8TDb1UEEB0mHEQ32TsixavA04Z7kx8GYNCTpqoGe9hEvni7qCXjRMpFbGpKgqH+sKCA2uZGXaEoxXM7cMNewheZW38Y5kKxtKw9XPII8oyDJrwzXCyWjZrKn4aCjQUr4pRI2I291SixbEtSbKL6QI1IKk4+aeB/m9us22hWQ2mFn7nVvqQq9LbW6oUL51IjI4zpfOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et504fX92jD+Gm6/Tx7Rs8Ge0NXEtlL9tompwqaAbH4=;
 b=TkQn7+Jy4jsm3O5qa4R64feTkMFE+O3Xe9dpvD6qVNnhXWPoM2xoKRtAyxBLKdDR9/fq9bI6oVNj/beJ+lSdsquadHaXAXjRed/e8h1iq0onICQ4n5G2Pvs3KKQre9ELdkINZUfIpy0iLOSrqoJ8OqLrCJMcSvGYhXVLhXCmUu2b2meixfo7/ZzKz2r4/ED1Sr2HpZDy5vRrk8AC9aXMRiyKHLhqlu3zPSrGanemKOdpmcSXGLo1N7LcVFadob3D0pddmgyXq8DnHPEMvFPCdLYtd9klWZanFbIRq+DjHps+RoZtEIk22rybB2MQW82gdopBOA4as7YP88rNYKEJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et504fX92jD+Gm6/Tx7Rs8Ge0NXEtlL9tompwqaAbH4=;
 b=GQpuMPtebTfagEJ//OLW/a7qGCwQ6Wwr9qIP/hodn6u4qe+0sAndGG7mHb3t1kOP8CMpiFDNwL6N7a5xaOnfs3Yiz0qplhS+VBpl+Zv+dr3xtC3DQRrP5R8LR5DKgPyhTEux50V2mU392XamZVPoqcOKXEjKSsKA1H4uXftwdXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 15:14:11 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%7]) with mapi id 15.20.7849.023; Wed, 28 Aug 2024
 15:14:11 +0000
Message-ID: <69111390-dad9-429f-bfa7-79916d384c69@amd.com>
Date: Wed, 28 Aug 2024 10:14:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cpufreq/amd-pstate: Remove warning for
 X86_FEATURE_CPPC on certain Zen models
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang
 <00107082@163.com>, Xiaojian Du <xiaojian.du@amd.com>
References: <20240828101035.2099-1-gautham.shenoy@amd.com>
 <20240828101035.2099-2-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240828101035.2099-2-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::31) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 466a6f73-a5d2-4022-24c9-08dcc77411e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWV6QVRrS3hXMERiQkI5cXYrWFFlaWpoam9Da3VOaHJTVGtpMWdEdzh6L3c3?=
 =?utf-8?B?d2RIMzlhNk5xVVg3S0hETnUvc0xtVzQzY2prSm92QkkxSGtTNVorSWdYNllS?=
 =?utf-8?B?QVYwclRKOHJrMUFFdFl2cWVnbVBNamJnSERaZ0o0STFvT3ZxVEh5YzIwczla?=
 =?utf-8?B?S1Q0L1JjWHdnY2h5R0ZtMGo0WSs3S1pvenhId0VVR0VWUXFGZnhhTms4TVND?=
 =?utf-8?B?My8xRFpmTHNJZnVMNklVazdiZHEvc0VoT2svK2lYUTFYTk14bzFaMVRXL2N4?=
 =?utf-8?B?eCs1YVliNXQxSldaR1BQaDNTRkhGZG9wbUpwYWNLUkVlcmdTNHh4VEtQRFBa?=
 =?utf-8?B?RnZoeDU4ckswVHpNYUF0UTVDbG9UVEp1UlRyQ21ZNUh5a1V4Qytmb1VTbWcy?=
 =?utf-8?B?cUpGU0wvMUdlTHJJNlllWCtJS1cxTVllYWhBbVZSam5LbTM4YVA3L0JnR09V?=
 =?utf-8?B?dlBKVmk5aGNremFhd1lXdGsva2t0UkFaTGFOUFBIMUJxbTAweWU2cHAwYnhW?=
 =?utf-8?B?cE9xM0MvdWh1cHIxY0EzNmZmSjk3WjBNcUhHaHhWSzBzZjl6WmorL2VMTE16?=
 =?utf-8?B?Yy9pZnFUMnBYeTJvWXlRRHV6a1FWWnlBT2NsV1IrN3hab1BjUi80VlNsa1BF?=
 =?utf-8?B?SWk5cHNkNktMN1ZkNkc5ODZScTk5RWttbjl3NERkQ1N2clgxbkROWm1sNEta?=
 =?utf-8?B?YzgxdjdZK2lFbFVyNUlRNi9xVGhUcFFoblp0TXFlQVdUcWlBR1gxR2RiOWND?=
 =?utf-8?B?dWcxZU43MTNIMDFFUmx6bzlIcG5Yc1pCSEcva3hmUE5HWUJHYXQ3bmFWTmxT?=
 =?utf-8?B?Mmg1MzBqM3czb0Fmb3FJbHBEbmdHQUdlRWFjM0dLdG5lL3A1eU1ZalVRWlNY?=
 =?utf-8?B?aVY1ZXJWUkF6ZHpmZk81WllKYXhvMU5uOWJKcDhhdE9WK0pQQUR2WnZzVTdN?=
 =?utf-8?B?cktnTnBNM3c0SmZybFhnY3JDNTUxUmNjeHoxa2VVZURrT2M2L0dFZzVEcDVK?=
 =?utf-8?B?TmxqRHJxTlV4cm5yakZaZ2NYTDMrQ2h6aXNrU1RpM28ySmJDbUNyVjRPcU1G?=
 =?utf-8?B?SWRHV3F1OWc1VktPUk1uNGJ2TFRDMkYwa2pzZVBscGV0L2hvYW4ybWUzYTBI?=
 =?utf-8?B?dk11TVJBV0MwNUx3NnNqVHBHYXhJd2xwYjBFanlEQ3lHbGI4cXBJczEzNndF?=
 =?utf-8?B?cmZYWk0vTm53VldDc1pRN2FKa1V2R2tTcitWNW04WFBkWFU5Y3M0VlhOaFE1?=
 =?utf-8?B?Tlc4NWxLSXZ0R0gwektEZi9uNXVNenBlbDZDTzdIMVhrSjlmTk9ramFZYU1J?=
 =?utf-8?B?OU1sc0tpWE1xNDErRkxmMFZsR0VvQkViTXFnYzdydTdkbW80bFBqOEFQZ1dN?=
 =?utf-8?B?OElUd24rYWFCVzBjY3VIWGJHalB3R1FKMXdLSzVwdi9GQXRjNlhJaXRadUd6?=
 =?utf-8?B?UVlYQzRnZzAvZnFNQWJDM1pZaU9Ub0NiK1NHR0dmSXhTZkgxQUVBbUV2eDAz?=
 =?utf-8?B?clZyK1MraWErTkhtMmNWK1pPdnlsc3FqbUdXRUFBWlRLc1pKQ0RZa0pleEov?=
 =?utf-8?B?WEU5TWR5SEYyOEhsVjZRSE9ZSmt5c0xVaEo2elBvb1RaZGhDeUpnSVllWU9T?=
 =?utf-8?B?U3A1Y2poK3RzcWhSUmFCekZhNnRBbm44TU9FZUJBcEU5dXl0emswT2U1RldW?=
 =?utf-8?B?cW9RZjdsODVpd1FrNS9zeURZd2Exbko4WTZmQW5pNXVWRFRWeHBQOXgrM3Rp?=
 =?utf-8?B?aU54TGhtcXZoTk5LbVhwSmhaWGh5MWpRc0pTZWx2d05TK09aTjdadVYvYVd2?=
 =?utf-8?Q?EDJ0/4Fp0j48+dbx197I9Ww1ax51wSjN11+Mk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3E3Z2pJcXZtMkNvYTczQStFMnpweTd3MENrQytEVUFSWVQxajArSjFXandw?=
 =?utf-8?B?UEZwYWJ6ckl6SE9uNm5IRmo4NHBhTThCdWsvdzl0RGJsTzhnQkEvbVM5QzFR?=
 =?utf-8?B?anZ3ZzZSTFY4QjRPTUMweE9sWWl2b1VqTXJJNVhKRjI1eGkxV2krRkRWd3Ar?=
 =?utf-8?B?UU1BMnRSaEF1Rk02dlFGSStQRTZSbHJDUXQ0NjlkYUloa0ZDVFhnM1E2M2hT?=
 =?utf-8?B?RU9VQXc4ZmR0UHRlaW5HSzI2b3FrT25nWmRzRStGTWRwV0NEbkZoNkNwRElX?=
 =?utf-8?B?ek1jMXVmenBZK1EzeHdrbVhzWk9vTFE2bFZsSXVJYmVHUW1NWW90K1BHakFE?=
 =?utf-8?B?bURHK3RmcXFEY2hKZWlHako4TjdXTmVxSURKcVdmTXZjL2ZiOVVFRCtzd2pk?=
 =?utf-8?B?S1pZd2Z4dGdFeGhONVg2UVYxNWJoNGFpNW1WWk4wR3lUWUZ1YlVCWkE2OS9E?=
 =?utf-8?B?aG9vTzhRZGEzVm9ycHBjL0lJY1Nwbjh3cTNjSnNtUnJ2ejNuNW42eExkZElJ?=
 =?utf-8?B?ZHI1ZVlMTHUrQ2w4WkgxcStqK3ZlZE4xbW5zTW81SGJBTGF0NnV5NzlJYjJz?=
 =?utf-8?B?VWpnVFR1RjNETjFkbFNTNHp2aGF5Z1FXYnA3akEyQktMRkh6eEJWRmFhREtK?=
 =?utf-8?B?MWZtQWM0cFI4RG1ncHBQcEViZGVpcDFVR2R4ZnpTdDdiOEhWYzNneGsvNHZz?=
 =?utf-8?B?TTg2T3N5Yno0T1FnVU5iSTZ6SUhadjl6MHZjTUNTYjlQVCtkUFBZeWp2L1JF?=
 =?utf-8?B?QlFmdVlRdFlDS001ajVxZGJabHB5MVNRYmxCdXljZ2pzWGhmbXhYbUVCYkNM?=
 =?utf-8?B?akRFNVFaTE1XcWJTTDBQWFhiMWw0dHU0THRRSEtoVnZYZllTM1dNelYrdzNo?=
 =?utf-8?B?OGN2c0Jqc1NxUTNaNkRWU01XRVpsb2l0VFVnVFE0SWd1ZzlKV1VPSG5FWnRJ?=
 =?utf-8?B?Z3VKanVFM0taa2ZEemxGN3h2dVFmS3A1R3orYTU2d05jOS8vQmpiNHpCOW5j?=
 =?utf-8?B?N3Vaa1o4UEk4NkNWWVNiM0pYWWZORDNnWDc2VDZwNVhsaGtzdDNwdnMxb2RY?=
 =?utf-8?B?K2N2cmYzVFR0ZGJrQng3MzZ6cmZTVGxJOG1UWkRMYkg1V0lVbVZINDlvTkQ1?=
 =?utf-8?B?ZUpYRmNmWm5ZVnYrdHJHY01IREtISWhDZ1FZMUNKdXZrdGhNVFRVc285K2hB?=
 =?utf-8?B?OEtNV2RaQkswZXRUWisrRkxORzhGVUpaOXduMmdYT0dQTWFnOGxDdEc2blZp?=
 =?utf-8?B?S1NycFRVY0t5VzN4cGUrbXRDQk5ZTGQ3RktYemFaVU9lQ0NLQWtianpzcWtk?=
 =?utf-8?B?MlhLaUI2bkJzRHJYSzVGMnF6b3hwZzY1RGk2MXkwY1JPYlU4akYvakpWbzJZ?=
 =?utf-8?B?RTN0WWQ2eHMyTkcxMDlDQWUyYzYyYkdEaUhWTzZjMG5PL1hkY2xJSitpMXpw?=
 =?utf-8?B?NVdLdHBrWUpST0w1TmpvdlV1bGxuY3RFUUtPWmkrLzJKTCtGY2J2QU91Ym1R?=
 =?utf-8?B?MXBQSWVoRDcrYmtTK0M0SGkzallWOTFTTXZJWGlxRWVMTU5PU2kzTXNxTTZQ?=
 =?utf-8?B?My9jVGtNZTVxR0V3bCthRHpRMjZpT2h1cnJwWGFJbFFyNERaZzNsUjNQQWZT?=
 =?utf-8?B?NjQrODdKT05BS1lpMlArRkQ1SEpVQ3hMQU5iUlFNVVdRMnlnY3pWcmlGYWM5?=
 =?utf-8?B?NkQ2d2pPMms3eXhFcXVSWmhFNjl2ZTFPVDhjNUE3d0c0WFEyOTdOOWFJUm85?=
 =?utf-8?B?RGkvUmpadmFSVDBUdWgrY3dkK1BCMHdMa0FmN2c4MVRSL1Y4STAvQU90M1ZZ?=
 =?utf-8?B?MTVmRVBOMkgvYitmZ1JmRTVZUWFHeVd3Yk5ISkNKT0ZIbVpDS0lKWlZib1lB?=
 =?utf-8?B?N0tMZTZKYzFTMHdCTUlKSkhyT0RiWXBrSTNKYXJidkNYc1IxQUpkdnpCanJR?=
 =?utf-8?B?UlBmaFFRVGZNdUhOMGc4UCtwRzRXRWVXWTVjaDh2R2V1TkNnc1FSalRaRkEv?=
 =?utf-8?B?WHJDU2prY0dzeVcyNDhheHVoMExrV3dYVVpnM0dlNHRMNlR2NWFMWCtIaFpP?=
 =?utf-8?B?dWZrRDhLNEZZRnM4TkFCdnNIcDFnSEJhY3duUWpRQ1AzYmV0d3d3aHQzNVVE?=
 =?utf-8?Q?CppGtYBcHpaMAGqG1MyTwJtnb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466a6f73-a5d2-4022-24c9-08dcc77411e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:14:11.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEFOeuDlNjEVt3RcW2jS8Q1r7x7HVqQrBpEpFtpVNi5XsB9oGAFqgmYu6t6YeRyabweupYfoJiTXM4M0a+tpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

On 8/28/2024 05:10, Gautham R. Shenoy wrote:
> commit bff7d13c190a ("cpufreq: amd-pstate: add debug message while
> CPPC is supported and disabled by SBIOS") issues a warning on plaforms
> where the X86_FEATURE_CPPC is expected to be enabled, but is not due
> to it being disabled in the BIOS.
> 
> This feature bit corresponds to CPUID 0x80000008.ebx[27] which is a
> reserved bit on the Zen1 processors and a reserved bit on Zen2 based
> models 0x70-0x7F, and is expected to be cleared on these
> platforms. Thus printing the warning message for these models when
> X86_FEATURE_CPPC is unavailable is incorrect. Fix this.
> 
> Modify some of the comments, and use switch-case for model range
> checking for improved readability while at it.
> 
> Fixes: bff7d13c190a ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS")
> Cc: Xiaojian Du <xiaojian.du@amd.com>
> Reported-by: David Wang <00107082@163.com>
> Closes: https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Thanks!

Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Will apply to fixes branch.

> ---
>   drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 89bda7a2bb8d..259a917da75f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1834,20 +1834,34 @@ static bool amd_cppc_supported(void)
>   	}
>   
>   	/*
> -	 * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
> -	 * the AMD Pstate driver may not function correctly.
> -	 * Check the CPPC flag and display a warning message if the platform supports CPPC.
> -	 * Note: below checking code will not abort the driver registeration process because of
> -	 * the code is added for debugging purposes.
> +	 * If the CPPC feature is disabled in the BIOS for processors
> +	 * that support MSR-based CPPC, the AMD Pstate driver may not
> +	 * function correctly.
> +	 *
> +	 * For such processors, check the CPPC flag and display a
> +	 * warning message if the platform supports CPPC.
> +	 *
> +	 * Note: The code check below will not abort the driver
> +	 * registration process because of the code is added for
> +	 * debugging purposes. Besides, it may still be possible for
> +	 * the driver to work using the shared-memory mechanism.
>   	 */
>   	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> -			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
> +		if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> +			switch (c->x86_model) {
> +			case 0x60 ... 0x6F:
> +			case 0x80 ... 0xAF:
>   				warn = true;
> -		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> -			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
> -					(c->x86_model > 0x40 && c->x86_model < 0xaf))
> +				break;
> +			}
> +		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> +			   cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +			switch (c->x86_model) {
> +			case 0x10 ... 0x1F:
> +			case 0x40 ... 0xAF:
>   				warn = true;
> +				break;
> +			}
>   		} else if (cpu_feature_enabled(X86_FEATURE_ZEN5)) {
>   			warn = true;
>   		}


