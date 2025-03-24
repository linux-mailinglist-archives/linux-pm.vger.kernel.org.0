Return-Path: <linux-pm+bounces-24444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B539A6D66A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 09:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675C91891CC3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 08:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EE1F3D5D;
	Mon, 24 Mar 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OzF39lC0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEAFC1D;
	Mon, 24 Mar 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805574; cv=fail; b=Fl3IFD+822jfjWlXNA09VsD8ENgKKWPKuNP74Ah/HEYQ8HEQ3s/seVGyeHlDWVecRnTH+7A6Mx1UQ73zOh9vqO99uBHYQjP8HCuqcPrqP0pRQ2RCJUuGra6myAzrjmtFD01PHALdaC22gx9b8Tm3M0Iexy+CcBPz8neumqZhuhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805574; c=relaxed/simple;
	bh=NKADs4cvGxXj80o32CwmeSR2A33Yptq34PWNULLROIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTSTImpv0WH29eAAP2lJFJOah6KlUoIK65ThcgGeV2wsUtkZp69qK7vE/f/EoCVH5wVcHqx6WVqHmXiT65vHDIXihyCTUwNHNSFtpDP07Q3zxSVxwmbdrkVe9DvUhctqxF1esyYZLjnUEgiD24CQTYEZXRTPamQMua1zsveJBto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OzF39lC0; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNjrFiG8Pkteg0vM9Q3IlP93KS2n/05bFElYRi9zmobMylZgkawHrHf5+fwOslR7aLdCN5lotg7NMoVk2CkPjirVyriR1ipbA9h1Vdroj9ZnXObEi8KXem+MZVxmBpqMWCl2vFqzOgSSIKRYp6z388ZOKtLIBW9+vkWrbrKRuzHmAyU/dqXYCxiGeZM4UT3uwPRpe+VjzmfaBL/TqThrBzvH5rQDZJUlNiF26u/4nuj5+euOXaek/jpLCahqXY55rZmNIx0Uk0/uZJzTBE2YGescConGzuLWxiKj/ZcfNI04IOv8kVQmPvvPOmk7Esk8MzF4UgkYkmDBXK0/vXf4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLGV4Be91qh1Yag1WAPlrupHHy0d5SYe5SmDVBXZ12A=;
 b=JxyZu+I6ysvFAD+mUUOG1LcJihEpR7WyChp1j13rvifrnhmyE1Ley0Wej4aq9zaMl8hdGQTJukCawD0WUW3cSuoSLoGcA2iR7H4IlGBAQOI4OOQocdG3Z1z+5jXgBGhF4NHK6PT6wgQJzNlRIEQXzLf2mfm2dazPQbQMDU1i9Yi6tBSgdszuoBDt1HER6uFVC5JWsLsIJSM6Tek0wLwoVtnE0fQY/0QlomRBxqSm8Dxlt+nam0TknrazTo2MI8aZL1WojzyCv/WG4vnOvftPA+GIAwPD+RoBM8QXCUp6WqMQ4dm1MF/SF+1oImx8rVrNVc26UCQP4Rvi+pLibdibtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLGV4Be91qh1Yag1WAPlrupHHy0d5SYe5SmDVBXZ12A=;
 b=OzF39lC0mUblWQkwBwgdpuoL56pVpoJWuWVPpbsgeZ63tOAY91p2s8eBbZfexEmHvJyJ192jo8Bv9OMkmu9qMuyhxdvGYhQDK5C+SxtGMnt4iYWjcsDR1Dx8oUMbgwnt2NRxBpSGo10EoTgXzVd152jqS71nUNNaS70YCUoMTFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:39:30 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:39:30 +0000
Message-ID: <8cc2631b-275a-485c-a507-b79db3934d63@amd.com>
Date: Mon, 24 Mar 2025 14:09:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] cpufreq/amd-pstate: add kernel command line to
 override dynamic epp
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-3-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250321022858.1538173-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: a4786d65-57d5-405e-9362-08dd6aaf64c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmRrRlo1b2haWm9taExYTDhWaVFUMUVtd0lncWxXQkdvUnM0M1dFTmx2L0NB?=
 =?utf-8?B?TDNHYmswR0RzNHF6UGRONFRmaG4wcFJBWmlBblJBNjFRbE9IM25SQjd2cXBz?=
 =?utf-8?B?a1kxNjdkdW5oUjdwQ0FWM2w2ZnZFY1dyQmVBUG1HWmF1WFFNc2NERHhjMjVN?=
 =?utf-8?B?cnNMRTVxQklOUlVGNmRTdWFBTmtzOEh6cGEyN0o2bmFXYVM4RnNkaEFKT2kr?=
 =?utf-8?B?anl0am80dytkOWdpSW0xTGcxVWhYZ0FPeWQzSFJIM1MrSUdOQS9JOEtSUXN6?=
 =?utf-8?B?bGFxNmUrcUxVRmdlZHlDUW9DclFsOHJBMy81bW52RlBjVE9VelRMenpXUisz?=
 =?utf-8?B?OGN0OStUbzF0N28rLzAwN3NadjlBa28vN0htRzNxemtDRm1RbzdZS2JBMW1Y?=
 =?utf-8?B?NDhWVFo2ZEQ4ZGxWNVVueVZxMDZHZXRXcm9Ub0JjUWxjbi9xMkk0ckVCajZy?=
 =?utf-8?B?WUpSeXJmOHFqWWhsTzV5eGV4amlpM3I5dmgwVk5QUWZZSTFKbGRxdExZTHE1?=
 =?utf-8?B?L2k1Uzl2RzhIT3lJbU9FYktqd2plMTlhTHc1b21nc0pwcWxxdHZabm5jb2Zw?=
 =?utf-8?B?cHFZa1FhYmJsOXVDMmk5cEdsa3ZabDljK0xscmZVZmFzQUFmcWtOSW43UHFk?=
 =?utf-8?B?dkF6VitVUkN5LzhnZVFmMWo2aXZaaERPZ3c2a1JxUUw2dkpGRlIzY29PT21H?=
 =?utf-8?B?cHRNV3JCZmNKY0l2dzdmNkZzWm5BRDJ0UUNXcWRETmRtWm40ODQzZDFrRkh1?=
 =?utf-8?B?a0NqZG1YSkFxVWRDQmR4MUVVVFNzY3JxcUZCU1FBOWhYN3J2ZlZPQk9ubUdQ?=
 =?utf-8?B?QkRJZGIyTHpHZWFHVnZnN3dKMnQ3VFpZbWNKQURhd2JqNkE0ZldmS2xocWtw?=
 =?utf-8?B?WUk2NTdJWmpPVkpmcnRxMk1DSERDM1RzUTFkZnhkMXFoVkljanRxdFdqVk96?=
 =?utf-8?B?UEVLenVFSStJQ1htSVphZXVhQStzZytXTFVHV09abmNWeWlsTGpLKzlvTEdv?=
 =?utf-8?B?S0NpcDYrc2xRbnByUFZLWkhlcDZvcVcrd2tMV0cwamxzNXA0R2FUSDN1aCt5?=
 =?utf-8?B?R0pVeXBza0toL0lPRElVSzJHTkdROElBMnd2S2hvdWhldXhZZkNOTjBvZHZF?=
 =?utf-8?B?c05ySUdDYmdySHM0Sy9XN3JoSU1QeUNnRWx1SnhoSk5FaVJzUzRrck5BcVg3?=
 =?utf-8?B?andBRWRYZkNoK3ZLUEZncUkycHVPTmE0Qy9Dd1Q3a0xIK3BtZzI4b1ZOVVNM?=
 =?utf-8?B?N0xMOHdqWWxSMTBWeE05Y1NsaWZGS1RFN2Zwem03b2o1OWhkbnk1cm9sNE44?=
 =?utf-8?B?RHhHaEp6aUpMeWVCdDhGNTZVL0lwSEhYNzNSdUh6VjB6eW9TUUN4bzVJVmdB?=
 =?utf-8?B?bEszZnQwQ0hVOVRIcWc4ZmpTVHYrZ0ZWcjNNczlGOEttU21UNVpyZGp2QkFk?=
 =?utf-8?B?bWNiVm1OOFNMSzZ5cWVsaWxzNzFQK2Y5VkhRZWF3TGhINnA5U0xBSXBtcEJL?=
 =?utf-8?B?ZjR3TzNwWW15RGtadHEydWR6eEdoWW5uODY3NlhtWDVrSStPanF1dkpLVk1E?=
 =?utf-8?B?QkxRUDMrZDlJZEVQK2J1YjgwNXNUemRTcGhmWnBRQmM1b0QvOGpPVkp5VlZ3?=
 =?utf-8?B?RW1ZeElqTkdHNFN5VmhDV2R5OTVvcjhqOE9wTStVblBpU2ExRmRkZnB6ajYz?=
 =?utf-8?B?OW5XUXRJekhpaU1BOEVGbDR6c0Rld2RYMW1kVVl5V2VDaHQ0elY0WXN0TlV1?=
 =?utf-8?B?b1lTd2Fmd040KzljVDRFS0N4aFJWYXNsbnEyemN3QTFBTnlVZExBY2hjc3FW?=
 =?utf-8?B?dXh5WDJtY1R0cGF6bjFXcFl6V3pydTh6anZLalVZd1pWVUc1RXBtaGFDeHNV?=
 =?utf-8?Q?0XRRc5jD6X3yV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3FOYmNjNEFVRnN6THpXRmgvZlFhYXgzbEVzckxuU3VSRjVLMitHM3VkUE8x?=
 =?utf-8?B?bzNKWFhoQmVKemMzaUJyaVIzbmZTMUsxTFJ6bERuMkRseGlUM1Z0bVV6eCtF?=
 =?utf-8?B?Y1AvbVpsL2hHTVBFbWZpY09HdlA5b0tyeDliZUtCWEFOanE5bysvdDc0ZFE5?=
 =?utf-8?B?WjdYR1d4Mmg4RGJOQVp3UTBYd0dnSDhPbTU1M0JqYlNNQ2VnM2Y1U1U3Q2hE?=
 =?utf-8?B?ZjhXYlFBNzhCUjJNZGFERlVKTUdNRFVoK3dZbW52c2FKeEdkemEyZHhpakIw?=
 =?utf-8?B?akk3aVVqTjRKamdFaXFBWC9mM1lJVi8xOFdOSmdtbWMwUndLalhrRkRGYnRG?=
 =?utf-8?B?OTRVcTNJQVk1NjR2dGx5bWdRYXJQeks5QWQyaVFzZFpGaURNOTQ5a3pUdXhX?=
 =?utf-8?B?YTBxNGNoK1JhbVNsWElsV2N3T1o0QmRGQjVGODZNVmZpNzBNTjcvWEJ6YjMr?=
 =?utf-8?B?ajdZUFlHSktocjN0dmlCcmJzNEE5cjZzek1RSnZvV1BablBleXNOODVYUVZm?=
 =?utf-8?B?ajJYaGsva2xCT0Z1MWE3VTgxcEF4T2tZUXRMbm1sbzFuREt5MTk0MzAvVStt?=
 =?utf-8?B?dUVsRjBQaUdla1FoM3VRUWNZNDRsQnNhaHMrK2hqYmFMdDFmaUMzbFI3MXVW?=
 =?utf-8?B?WW16VXFDMW96dlNxVTB6bE8xSSttdE92TUR1aHNRVlg0VGcvQzhQKzltM25B?=
 =?utf-8?B?WDdPcDZYaXB6WGM3Q2YzeUUwVGNrN2paN1dCbDlJbHdKNWRqWktrbERocFZR?=
 =?utf-8?B?cUVqZVpheUZxeUxwdnl0M2tsaDFmRGpzSFlWbnFEWlZwMWpFbTkvV0RXRWdN?=
 =?utf-8?B?YVdWOHRBNVcvQmNJblhLVU40NTAwMVI5ZThzRXBqT09RajFGWDMzQ3IrN3d2?=
 =?utf-8?B?Tmh4Uk81b2NmaThHRE8xcjZISDRNT3JGcEVhVzh4am0vTmpEdGNHYnJIWVAr?=
 =?utf-8?B?T1BUY0VaZ1oxTGxEY3VOSXdqaGtXS29rNFRBVmFDRzgxanNKaC8yTmZiL3lj?=
 =?utf-8?B?MGNnK09EdEo3eUc0bi9FdE44czBFbGJPcERpTVA4S25oYU8vaXc1MmxSN3RX?=
 =?utf-8?B?OHc0VFBCRTNjUFcwejdVY2NjNGFlVExpa2d6VUlEZDZIV01ZSnpqOWNreVhl?=
 =?utf-8?B?eGpJSE1DWnduUTc5TXVQSVNHeEZtUkVWamlpcmV3RVFnVmlmeDZjYTAwN1Y3?=
 =?utf-8?B?OUZreGlSRFdWUXlsMjJQMllvSGEwdjNETnlwa2ZucXMvTWVnRWl0bnloZTY2?=
 =?utf-8?B?K3Z4WVZLWWtFTHBiYkhqZnNiSjFsanB3ayt1a3dqRlBzYU9HZTFWTHhVL2Yw?=
 =?utf-8?B?c2NLZ1RqQmVDWkFKNXBmdXpIVkY2RHRQWFVIcXJRTFY2VWI4WHh4aFA4S2VQ?=
 =?utf-8?B?eFJKd29iTDczb3g4QVVBRXlyQi9teWdXQnpOUDhpeUJoWldrYURxTFlUYjJB?=
 =?utf-8?B?eEpmME5NSkxFRWxRd3R2cStlbUlITTNlN2tKT3NBN1ZlY2dPd3Q3VWxsV0xi?=
 =?utf-8?B?MTd5TVJiR3pxazJITGhJKzZpRDJGU2dHajlHemNrK3NMS2xtTE9iYWIwTnFX?=
 =?utf-8?B?bjQ5ZWJYbDFoMFl6UDRZZ3pUM0diMStTeW1mUUg0K2NkcWNrK1h1RG51b1pj?=
 =?utf-8?B?bEc1R09OajV2Rmp4dlNsU0Z0enVZUWpsYmxZY2FxaXJTejVvU3AyUzFVKytM?=
 =?utf-8?B?enVyNTdRVFZMa0VGa2RUbXhCMnFMN1NBbURFS3dMdk1NYUFSckwvSG9jNzJn?=
 =?utf-8?B?MnN1cUdWcVp5a2ZUbkVDdmg1bHQwYjlGeXFTYUlQWEgzUmhQN1djQmVwYXBy?=
 =?utf-8?B?bEFEMTJNZ1pGZmZiUmdybXJHcnF3cVlRRGNnUEU0dVlGMFFUUFRxa3lkR3M1?=
 =?utf-8?B?eXp0TVI4OGdzZk1DSURGODVMQVk2S2llVEpya0o5clZQUGg1VUxReXJMOExo?=
 =?utf-8?B?MDhjV0cyZ3p6MC9VL2VqWDZMbjBHSFYzaWQ4OFdhbkI1b0JGcm5kN2lQbjgw?=
 =?utf-8?B?b3J4L3lNSlAxaDQ1QVFNTFd4YVhjM2hmcjcybWJqWkV5aVBFdXA4TCtkc3BJ?=
 =?utf-8?B?VGh2U3NYNWxkR2dmd2tnWkh3WVE2ZklHYi9kbk9ZcFlmbzBjSEJ3bzdDaGJL?=
 =?utf-8?Q?59/XMubwtaUexwlJ3BQFYvGUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4786d65-57d5-405e-9362-08dd6aaf64c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:39:30.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oAItXjg/GOmVFtM0Xk2d9mnjQKJyq+m+5vQFXoLVd1WdD4ZwPy1NhzgBSYpV9rmC5VOzELzNUGUg49uj/3l6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

On 3/21/2025 7:58 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
> the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
> locally.
> 

Small correction below, apart from that LGTM

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
>  drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec85..1afe6d8ab09bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -392,6 +392,13 @@
>  			disable
>  			  Disable amd-pstate preferred core.
>  
> +	amd_dynamic_epp=
> +			[X86]
> +			disable
> +			  Disable amd-pstate dynamic EPP.
> +			enable
> +			  Enable amd-pstate dynamic EPP.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 2e076650dc77c..8424e7119dd7e 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -438,6 +438,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> +``amd_dynamic_epp``
> +
> +When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> +autonomously changes the EPP mode. The default is configured by
> +``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
> +``amd_pstate_epp=enable`` or disabled with ``amd_pstate_epp=disable``.

/s/amd_pstate_epp/amd_dynamic_epp/

> +
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7f203495f60e3..8172bd4b5952f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1934,8 +1934,19 @@ static int __init amd_prefcore_param(char *str)
>  	return 0;
>  }
>  
> +static int __init amd_dynamic_epp_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		dynamic_epp = false;
> +	if (!strcmp(str, "enable"))
> +		dynamic_epp = true;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
>  early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_dynamic_epp", amd_dynamic_epp_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");


