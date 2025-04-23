Return-Path: <linux-pm+bounces-26042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEDA98C5A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A44460E5
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D99279793;
	Wed, 23 Apr 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpoiAYY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCA27978C;
	Wed, 23 Apr 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417120; cv=fail; b=YZ9Udt22Tgw8wDvvYt9r+C59EV/uy0elpbjZjcQnjBuLx21Y12RcJaKJOPhmDfu5NlFC+kYuPE4Rr01FzLSNg345royVp/TaVhjnQvtzQcqKz9IqhBjujEuU2BdquSW3srnyX4YV4ra30fUQWsPfrYHFlfTTOQvOcHUUN4HMMQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417120; c=relaxed/simple;
	bh=jmv/6aUBDHZk1BUCWdTG26lJT6/JhWJ0co9j7S9uDc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TjL41yb50bxH40M8lD8bGaW4cZajrWaZBX1L2aE2CGC2/n22JzmiJuL6rh5VIO0PZPHeEg6FnZM5+6HKhmWF/EUltpnI3Xij9zWSGAeRP+ol1u+WsY76qu1pVbR09vVX3WfFNxd5mNGzLPkFUKR7EiKChFmuNd1iWIYcLFBeghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpoiAYY8; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvqFmzP5lFGBz4cLpyh/mPOiRrXUkAP694G/6GeJtVvdQ26VyUMMSXFiV0hSVVHO74B5WTP1zY/4XMg6v/Bsf1ysl6l2wpnBooDxB6Pf5iQ2a4hSVT7kMeP2F/QCBjuU/pkIlWI/aLOOGGNH3rKVRWX5VGhD8kmduXbRLhf+0jMSdhSxgUBNL5+M+U0T+dnX8pbEVM0CKQO5KyxKxjNrPq17CKHQ5wGXX37mmY9ht/wmAmfhPIvz8+DFrdpsHNnEIUpM3RdgOTbaLzwuCYcnPILT7vNU+GdA0Zv9y81bEvjD8wB2SvYR/7BbQr+8rZG0JAp8cc/LtKhLseXAGqoWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcdhKplhbjVOzYYBjCgfCOSr8lmB6VtVFDdkvusD+ZU=;
 b=FZBmdGwD+oTL2rWzwDQDctZPKzFnDbc+K1zVtfAoDZLb4MF2ewxjGzOeJWuDMxlj4GZOCyiZE8dp33jhNTWqvsa9PqZ8dE9fQYW/RKrX5/GlaThUv2yjyDXlyG58pZqBSEMblaudrPOQffrFodDYswNawjvyxPYO3pRBopCXX/MBqVIom6jR5mW/ByFn6PRW3R445AnuXyWDcaMY19Pp4nmQAGXyVzELV2AfzXYjzmNwQf+kX4ng4NrzuAVQ3gP2szcYMS+I5m7Qo6QyvJW/JUWD+1rgXc4R+TR78bK5mIbJssQqTsH/s/nHCmOacn7nccfWuvoZmlcL6hGAmuKFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcdhKplhbjVOzYYBjCgfCOSr8lmB6VtVFDdkvusD+ZU=;
 b=kpoiAYY8dN/mp9OM6Cfgb1JeaY8JjXtGvqTrXtgBprKLKxywu9B2qWHKxcl8rUxsOXJU5o+bgGLn2/hVDYj+9UM+QCIPOU7gU+PTGe7+klWMAVhuZ+Qxp8CsOGBiTuD+ZYrV3xijIs6HKArod/1VAoV/BW6b4GJYlMS5i8Np9ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 14:05:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:05:13 +0000
Message-ID: <0f784d8d-7141-4e35-9a61-e8875d0a8f11@amd.com>
Date: Wed, 23 Apr 2025 09:05:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
 <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
 <eedfe953-7468-4b4c-934c-4589de601fa2@amd.com>
 <5b4b11d7-197e-41ec-82b6-8279125a95bd@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5b4b11d7-197e-41ec-82b6-8279125a95bd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:130::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d0b191-2b0d-45f5-9fc4-08dd826fde13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENmYlVMcjRDMytHeUsxSmxrOEt6MW1NOGUrN29ibnBZSUZTY1F4empEM2tx?=
 =?utf-8?B?RTNCZDk1cHdsRzJLSmlhcWhVQzIxdThtcmpESm9RWUE2d3RQakgxYmU4QWRm?=
 =?utf-8?B?SGF3cHV0blo5eXhhY3djOElSZlYvcVNTbUVaV05TWUVzRnVvMUpRM3UvNmRs?=
 =?utf-8?B?c3I0dWxKQmNDMmdZcm1MTVVUM0hKd3ZmM1hpNlNsaVhHTUtMVi9HMGR2eHVP?=
 =?utf-8?B?aVU1ZjF5ODlGL2J6ZGx3R0p3RXdkTVYvaWpoNVNlSzRyTldQd3dpMyt2TlZ3?=
 =?utf-8?B?bjFEeTFSS2FFSlRFbkRsSFVSV1huSWRsakxnQlFjTEFDZDBrUWdYNmwrcWR2?=
 =?utf-8?B?ZmZIci9KOWEyZGVjZ3V1Zy8vNDY5dXZsQ0ZlR0ZzQXVXemd1a0pDcWg0ZEpE?=
 =?utf-8?B?M3VaQ08rbmxrSGlTWGhheDU5RUk3QjZPbHVDQ281V0hUT04wN01iaDRaZ1ho?=
 =?utf-8?B?YTZZME03L253OXB2ellrVE5senEvSU1ER2NpaGpoL1NJMzNIcktJVkZtdzBi?=
 =?utf-8?B?cFBnaDVheDJOTEFzOEx2dkJlSXVGOGV4Uld3Q0dqWFcwZzZVcjJvcjJOekV5?=
 =?utf-8?B?L0VyTERTajExVHVZNFN3am54YnkveXZBQUlTK1lzUTVlNDBvYWZqZm9YWity?=
 =?utf-8?B?VHVzYXRFSFdEM1RON0FsUnIrZXQ4RllYN0lQb3gyekZOcXFrRC9CWmwwYzVK?=
 =?utf-8?B?eXNBVXFlSDc2cHJsREVaSFJmelBoSW14MEdQd01GeHlIQlVCcE9vMWJJSFhl?=
 =?utf-8?B?c1dVV01mRlBwbmNZU2JXa3JiWHlVdU1JQzhPZFhrMzRvajE1dEszOGFlQlNO?=
 =?utf-8?B?NnZZbmU1eFUzbFpSOXI1UVJvdGNDU0cweW5TSlUvdW5LTWYxeHR3bW9YUmZP?=
 =?utf-8?B?MFh5NFlFZE9LYm51M2cxSjNKSUY4MVViTk9ocmJ4UFUvd3ZlaWZ1SmV5WHRq?=
 =?utf-8?B?M2NUNTN6Nk5IRUlZcEFlYkduUEs2MUJ0SW15KzdLOWZ1ME1sZDR1amk1d00r?=
 =?utf-8?B?Zk9ZT01hVkVxVHgvdzR3OWZ0c0VkbG1XVWZoU1E3NHhmWlRlNDdPaEZHVlRC?=
 =?utf-8?B?SGhzZkoxdkFUN3lYMmRKb0UxQ01QZGZkRlN0SnJJSEtLakVNcVB6bUl6Nlo4?=
 =?utf-8?B?WUl3dVV5L1BaUE5scmlKc0RGcGs3bm42bUhxZjdmK2xSVEN4ajlUZXMzN0RD?=
 =?utf-8?B?eG5nZzlzYmh2aWhDcUlDeGt4MDBvYTJrcktXQmxudWxMOVI2N2hZQ0VmM3Fo?=
 =?utf-8?B?dndMS05KYnoyTVJhUkY2L3orOWJtUnFoSkJrSHpxYjZlbHJ6M2ZsbTBTOWgy?=
 =?utf-8?B?dTdhbHJMTjZXcEpNT3VYRTRoR1B1aUFoTmJYZGF3aStwbnJPVTJWZ2cvYXox?=
 =?utf-8?B?aGg5Qml6WlFOZ2h6TXp0ZVUyUjlHSlFIeEFKaWpkY3NoUTlKNy94ZG0zajhp?=
 =?utf-8?B?VXVRbWdhTDl5Nlp2bmRVWlNaT2l0UlJ0Q1NQWjAxZDNWR2YvR2pscjhwU1dw?=
 =?utf-8?B?dFdFSTNOc3NTOExBUElhVjBCRUJ6aHdIcEdmSTV4eDJLdVROcEVuR3BoSGdo?=
 =?utf-8?B?U1pKZ2JReFR5WFdUcThvbjA0ZnZ1VTkvQmd2L25RSWJtaEF3NUxadmhUWGJU?=
 =?utf-8?B?bFNQWlM1QmhYM2RGQ242ZklNcnYwM29MSmdpR3FRWmI5MDRsTC8xSlhyTjFj?=
 =?utf-8?B?ci9yZnhUTEtidmdKVzhWYUhOV0FzVDcrRkR4QksrZCsyWU9telRHU0oyS2xF?=
 =?utf-8?B?Q09OOHZpdHhMSFdHWFZkOXNXOFk1Q09rK0pXNWQ5ZHEyWVcvQzdock8yNW15?=
 =?utf-8?B?ald0TlkwRDh4YU94RlA2RjRTMUpUazdob1JHVUpyUS8vS2xnTDZjWXUvbWJS?=
 =?utf-8?B?NVlyK1p2U0h5OEFCZk8rVXhDd1E4V3puMkpaeHNoRnJmUkVRQXJTSHhsd2NV?=
 =?utf-8?Q?hkH+SqgaW/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzR4eTlSemdsMzN1NVdOTlV0ZVRDMkYzOW9qbFNiQjRoV0dDakY1Y3JBTGpo?=
 =?utf-8?B?dU5pSmU3azdJNzhNT3pEeHVtU1ZzSGdtM3UrWCtSWUZmeFVYQUwrMFpVZmJM?=
 =?utf-8?B?OUxCeUNDVC9CYW9MeWRqL0VoQjdHbGZhREFNUEJDWW9YWDFRMGVjaUorYVNl?=
 =?utf-8?B?dXZINjRZTzJPaklBT3ZDNmUvaUJIalV0RnpPbjRaUmdZYmQxSzhZaGJwVnBj?=
 =?utf-8?B?WU05TFpGRFdQRmF4alB2eEpxRmtpU0lUNG5PcmExd0Z4aUFickVzVDdIN01G?=
 =?utf-8?B?a2dQQUwvcDV2clY5ODM3RVRKcUQ3UFRnNC9jSTVEK0hMNDhmQzBUZXBWM1Ix?=
 =?utf-8?B?TURZQmtXUjZHRlBsUTNIaGRvamR3d3BFZkdJUzVUWTdBZDYvVjFCRjduOGJ4?=
 =?utf-8?B?QnJiQWpIODZVZTZoTU4vL1NSK1U4azY1ZmpmYlY0eGxvTER2bWw4RzJ0Y1BF?=
 =?utf-8?B?SU5xSmxNMkd4VTZhOFlZWWhTbFNId3JCVGNsWVdVVVk0Y1RyL1BsZ2d1Y3hh?=
 =?utf-8?B?bStIbzJWWnpGd3cxTWJnMlRQdmltbGNRcDQraXAvZ3ZXT0JLYTY2cnd1L1Js?=
 =?utf-8?B?cU0yWXRQRENDenZUa0ZPckdrajFUNTZBbVYvRTJZTy8zcUdzL3ZDNldRV0dp?=
 =?utf-8?B?T09DQ2E2SU1WZXlTMXdZQjRxY1R1TTBUSDljdVNjV2ZMcnZOQkpiTzl0UVBF?=
 =?utf-8?B?L2Z3YkYxMkVhRTllNHdlMERWMmU3WmZTK0NPZVROUXlZTG5CenBmOW5mUTVl?=
 =?utf-8?B?Z2xadUxKK0hwT05YSlQyMHZjcitiKzE2VHBIQnNnYnNzUDF5QW5JdjAzbkJm?=
 =?utf-8?B?TElZWDBqWUk4dW5xdkwrU0tURkc2a3FoanFBWGVzS0dLTnlGRUNLNzM0enVR?=
 =?utf-8?B?NnMxZ0EwSmRXRzZzaTBGaDFWelV6L3NrTi8waXRyV2NOa1BMTGlIbFRrSndP?=
 =?utf-8?B?U3d2dVU3bXJOTXVkcnZpNzBtdkV1bzBTdjNPTlpWdlFZV244QjRMZUZPVkxL?=
 =?utf-8?B?R2hnV08rZTcraFNXNmhOL1N5bmVsdWV4MzdVRUkxTGorQmlFdTczbUppU1lH?=
 =?utf-8?B?L1NNU1pwbnZFMGN1ZU85UlRCQ1BtU3cyNjhHenRkaUNiZktidEVXeml4RDlO?=
 =?utf-8?B?SEZEMFYrZUx1T1VTZjNhRUpSU1FHb3huaGVsaUh6L3pNYThGRHNJQ0R1c3d1?=
 =?utf-8?B?NE5rUG9VdEloOVQyMXZHdnEveE4xdjU2RGovSGgvdU5kY25ueldZZmptUXBs?=
 =?utf-8?B?cnYrR1FIckllMUE0UnVjTUppUmZpbm5nL0Jhb01GRytVWG5qaUxqREo4S09k?=
 =?utf-8?B?anBSZFFlVk9WZlBjR0hqVWVleE5GdXFPUXNlcmw0Ymlxbm5WUXliRGliS1FZ?=
 =?utf-8?B?NDE3VTZrL3VnYytHVTV1Q0k1Mk10aW1lK0pLdnBqTDFPdk15L2ZoQVVHNnpB?=
 =?utf-8?B?ZkdJUjRGZzJCRmJIQnBPaStHZVpiZFFtSllhWmhVVGpKbGRnZms4VDI1Wm9C?=
 =?utf-8?B?anVyci9ZL2l4QzF6T3pxbG5QN0RRUFFZSitxRGNaajVFZXVIOEdFcG9BYnFZ?=
 =?utf-8?B?c2JpRGZORjJkTlRBbEc3OTdaUzRrYnZmOTFnUjdRcE03UTdUV01BN21iZ2FP?=
 =?utf-8?B?ck5YQkdhZzgvVjNPcHh0QTZQWWswSFdtTjVqZ09DeFIzbFgxN0lBSzhWbGg1?=
 =?utf-8?B?WlNOQk9EMjljdW1lUitwTEs2Ui8wK0taSXJuVm9iYnhWdkRoOTNjeXNoR2dZ?=
 =?utf-8?B?WGpob1ZkNFVmU3FyYTZYRzJzbkhMUjltSFFBSS9ua3hrUUdNU3BWZSt0T1Jm?=
 =?utf-8?B?ZG9kdW9seExjcGhHektOL0RPaHVZZlNpQWtrb3RYelNGVVlpZEU1ZXAwekZB?=
 =?utf-8?B?dVB3akE3VUptNGhwcjlMVDhJVXNNZk9GSktvbCtEMEVwckhUZm9URm9vSnQ0?=
 =?utf-8?B?UjlsOVZsR2dPQnBzcHdyaXlpSjQrUlJjWC9YRVdCYkZMRjJNOGhXeTlsTUpL?=
 =?utf-8?B?Q2JyaVNWTWR3N1R5ajRTTG8zKzB3YkZkc2Z2Y2dlZFRzcURSNzZ5WGtWTU5J?=
 =?utf-8?B?cDFDUjFWT2loMlhodjRJUnpLMGt2RlB6OXdNZE1oR285WlcvTHRCeEJkbGtu?=
 =?utf-8?Q?F3at8DwdfbY5vgimCYK//2KRU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d0b191-2b0d-45f5-9fc4-08dd826fde13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:05:13.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mzDsLsVmEnbPMrOEy4K2BFSvDD2NL4X0nzvXSYLhiSmkxUUpcxtsv6eT2/jBK+l95YZ6xssieCFTcpw+LeY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

On 4/21/2025 11:02 PM, Dhananjay Ugwekar wrote:
> 
> 
> On 4/21/2025 10:23 PM, Mario Limonciello wrote:
>> On 4/21/2025 3:04 AM, Dhananjay Ugwekar wrote:
>>> Initialize lower frequency limit to the "Requested CPU Min frequency"
>>> BIOS option (if it is set) value as part of the driver->init()
>>> callback. The BIOS specified value is passed by the PMFW as min_perf in
>>> CPPC_REQ MSR.
>>>
>>> To ensure that we don't mistake a stale min_perf value in CPPC_REQ
>>> value as the "Requested CPU Min frequency" during a kexec wakeup, reset
>>> the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
>>> exit and suspend callbacks. amd_pstate_target() and
>>> amd_pstate_epp_update_limit() which are invoked as part of the resume()
>>> and online() callbacks will take care of restoring the CPPC_REQ back to
>>> the latest sane values.
>>>
>>> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>>> ---
>>> Changes in v2:
>>> * Modify the condition in msr_init_perf to initialize perf.bios_min_perf
>>>     to 0 by default
>>> * Use READ_ONCE to read cpudata->perf in exit, suspend and offline
>>>     callbacks
>>> ---
>>>    drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++++++++++++++-------
>>>    drivers/cpufreq/amd-pstate.h |  2 ++
>>>    2 files changed, 56 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 02de51001eba..407fdd31fb0b 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>>    static int msr_init_perf(struct amd_cpudata *cpudata)
>>>    {
>>>        union perf_cached perf = READ_ONCE(cpudata->perf);
>>> -    u64 cap1, numerator;
>>> +    u64 cap1, numerator, cppc_req;
>>> +    u8 min_perf;
>>>          int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>>>                         &cap1);
>>> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>>        if (ret)
>>>            return ret;
>>>    +    ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
>>> +    min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>>> +
>>> +    /*
>>> +     * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
>>> +     * indication that the min_perf value is the one specified through the BIOS option
>>> +     */
>>> +    cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
>>> +
>>> +    if (!cppc_req)
>>> +        perf.bios_min_perf = min_perf;
>>> +
>>>        perf.highest_perf = numerator;
>>>        perf.max_limit_perf = numerator;
>>>        perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>>> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>    {
>>>        /*
>>>         * Initialize lower frequency limit (i.e.policy->min) with
>>> -     * lowest_nonlinear_frequency which is the most energy efficient
>>> -     * frequency. Override the initial value set by cpufreq core and
>>> -     * amd-pstate qos_requests.
>>> +     * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
>>> +     * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>>>         */
>>>        if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>>            struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>>                              cpufreq_cpu_get(policy_data->cpu);
>>>            struct amd_cpudata *cpudata;
>>> +        union perf_cached perf;
>>>              if (!policy)
>>>                return -EINVAL;
>>>              cpudata = policy->driver_data;
>>> -        policy_data->min = cpudata->lowest_nonlinear_freq;
>>> +        perf = READ_ONCE(cpudata->perf);
>>> +
>>> +        if (perf.bios_min_perf)
>>> +            policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
>>> +                            perf.bios_min_perf);
>>> +        else
>>> +            policy_data->min = cpudata->lowest_nonlinear_freq;
>>>        }
>>>          cpufreq_verify_within_cpu_limits(policy_data);
>>> @@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>>    static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>>    {
>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>> +
>>> +    /* Reset CPPC_REQ MSR to the BIOS value */
>>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>          freq_qos_remove_request(&cpudata->req[1]);
>>>        freq_qos_remove_request(&cpudata->req[0]);
>>> @@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>        struct amd_cpudata *cpudata;
>>>        union perf_cached perf;
>>>        struct device *dev;
>>> -    u64 value;
>>>        int ret;
>>>          /*
>>> @@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>            cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>>>        }
>>>    -    if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>>> -        ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>>> -        if (ret)
>>> -            return ret;
>>> -        WRITE_ONCE(cpudata->cppc_req_cached, value);
>>> -    }
>>>        ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>>>        if (ret)
>>>            return ret;
>>> @@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>          if (cpudata) {
>>> +        union perf_cached perf = READ_ONCE(cpudata->perf);
>>> +
>>> +        /* Reset CPPC_REQ MSR to the BIOS value */
>>> +        amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>> +
>>>            kfree(cpudata);
>>>            policy->driver_data = NULL;
>>>        }
>>> @@ -1575,12 +1600,28 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>>>      static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>>>    {
>>> -    return 0;
>>> +    struct amd_cpudata *cpudata = policy->driver_data;
>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>> +
>>> +    /*
>>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>>> +     * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>>> +     * limits, epp and desired perf will get reset to the cached values in cpudata struct
>>> +     */
>>> +    return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>>    }
>>>      static int amd_pstate_suspend(struct cpufreq_policy *policy)
>>>    {
>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>> +    union perf_cached perf = READ_ONCE(cpudata->perf);
>>> +
>>> +    /*
>>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>>> +     * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>>> +     * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>>> +     */
>>> +    amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>>
>> In EPP mode this appears it would be OK because the perf value should get reset in the resume for amd_pstate_epp_update_limit() but in passive mode won't this never get reset on resume from suspend?
> 
> In passive mode, on resume, amd_pstate_target gets invoked through the code flow mentioned below,
> 
> Cpufreq_resume()->cpufreq_start_governor->(cpufreq_driver->start()&&cpufreq_driver->limits())->amd_pstate_target() [this is for _target() based governors]
> For schedutil, start_governor will register the update_util hook and it will be called at every util change, which eventually calls adjust_perf()
> 
> I tested these scenarios using "sudo rtcwake -m mem -s 10" (suspend to mem for 10 seconds) on a server system, within 1-2 mins of the wakeup the CPPC_REQ MSR
> values of all CPUs get updated to sane ones. It would be helpful if you could test for such scenarios on the client systems as well.
> 
> That said, there might be a small window between the resume and governor trigger, where the value in CPPC_REQ MSR would be invalid. Are we okay with that ?

For server systems it's probably not much of a big deal since servers 
aren't frequently suspended, bu this window of time seems untenable for 
a client machine.  As a user that would mean effectively they have wrong 
limits programmed after wakeup for 1-2 minutes and could potentially 
have performance gimped as a result.

I'd say let's just flush the right value immediately after resume and 
then the write 1-2 minutes later becomes a no-op.  With the checks we 
have in the driver now I expect that they don't even turn into MSR writes.

> 
>>
>>>          /* invalidate to ensure it's rewritten during resume */
>>>        cpudata->cppc_req_cached = 0;
>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>> index fbe1c08d3f06..2f7ae364d331 100644
>>> --- a/drivers/cpufreq/amd-pstate.h
>>> +++ b/drivers/cpufreq/amd-pstate.h
>>> @@ -30,6 +30,7 @@
>>>     * @lowest_perf: the absolute lowest performance level of the processor
>>>     * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>>     * @max_limit_perf: Cached value of the performance corresponding to policy->max
>>> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>>>     */
>>>    union perf_cached {
>>>        struct {
>>> @@ -39,6 +40,7 @@ union perf_cached {
>>>            u8    lowest_perf;
>>>            u8    min_limit_perf;
>>>            u8    max_limit_perf;
>>> +        u8    bios_min_perf;
>>>        };
>>>        u64    val;
>>>    };
>>
> 


