Return-Path: <linux-pm+bounces-29994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D9AF6380
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 22:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931174E7204
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C972D63F5;
	Wed,  2 Jul 2025 20:43:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033C2DE6FF
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489028; cv=fail; b=UXe9Q2lBV+1WKiIHFiK++nzdonOr74HNBnMYRHy03SvMO0v8TTA4oPFJLec/pfqmAzOp2taNjE/YRq6hOQ+3KwMCMSZY65OC9/NbFZtob6jh7xhwgcTZrSfWYpoYRx1VQZTJ0kMFqAVYhVvmodYP7QsbaBa4uH5FIPp23+rsEvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489028; c=relaxed/simple;
	bh=kewWaFzKNEVZIVjZPbkNX9hwJP8qftSYjgKRl0xjx8g=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=mM7+gjIkD66upgcGDpmOfsapkrFK0mFysyzSuvY5wgHgcxFUNh8qBQtOuq4hps45O1uf3kGoIEmzQUzyH24cJryNo5410i1HclMGx6LR4Z6fdI7/XKBaxdnvBAFyGGsCReP3yJMN+8Bnoz8qQMh2LtzvJHYf8Jt6TVrr26spToc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562JoGjl012955;
	Wed, 2 Jul 2025 13:43:31 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47jbp4crax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 13:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL2wHoyFtJzhKkdnkH/ecy5p4j4SRZxtkefiJzs8R+vGk32YYr3xkLB44r9Yf06KEwi8dWPFvypHAwLI5pel+BObZ4ZqMj/UiNNhcNmPU768h4Lp1uBRmxu7znNN313TpmjskUeLCm5C2sYbTUaUVb4b0q4X1NHHcAiqp38Ym1tSox7JBlOlqbN2epJKYnh+8QHrAwyEG1GLbY4USfjpbZRF/ay4iBWYN7mJhltPAUFXFuMQ5p/9AZSE88uELINuM/s/uRp1XLaEj3mQlL7fUv2KWWSdDRQFDqZHy2VF4epDgcMmUU4eO/v5h6ElW2LWgXDvgmiynl9ZVzL+vdMkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbHCI7veG8DGy9DDpKrRhW06a3Yjc3mlOc7YDiUvW7w=;
 b=cNJIMlczO6ob9uwihLZ1RYrDPnFC26mPE66SToKb561dcWzNKp9TQuVEqb9lYNE93fDwrtvzFIBYfUE9HDs+8uqRedHkbTiN3T03HC0GRodqWNY24H6ZQvPTwc1Lv9oeq2Nksw4+YXhJb1M0jR4afo5N5OZDAXJYxnbsNZo9ytxoSAOfCW1rrLREXTt3oEfMUFvKbfX6bKzUk96tcF3NqIZ9DIlXsK2giSlvfqZlYJFR8a08UccAUDiMuURJfg1MjbmTKErp/uldew8gd5uHngHkAGGAdepG+DNIZiWjdtw69cPNZlB2ORFxoO7vfcL+VcrEK/wD0xywOiyVQOzvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 20:43:24 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 20:43:24 +0000
Message-ID: <da9ef8f6-ad36-4c85-847c-1bf8cfed8d43@windriver.com>
Date: Wed, 2 Jul 2025 14:43:21 -0600
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, kgene@kernel.org,
        krzysztof.kozlowski@linaro.org
Content-Language: en-US
From: Chris Friesen <chris.friesen@windriver.com>
Subject: huge discrepancy for latency and target residency between acpi_idle
 and intel_idle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: f767123b-5fd8-427b-103b-08ddb9a916e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0MzUXI0VGI2SGlSd2g3V09oNDZxMjYxb1k4ejRuWXR4djdOckJCM2RXbTBz?=
 =?utf-8?B?SEdzWkRaZUlObktFazh2K1MwMHZBUXpaNDJMNm1SMEZDMU1ZVmpRd1NjTGtG?=
 =?utf-8?B?UDc4b0pITnhZdk9seWdiRXYweGE3Z01EbElvd0pOb2NOZnFuTC9Cb0JoVThF?=
 =?utf-8?B?R1FvbFhuU2cwK1pGbGF5d21oR1A0Wm1ZNjVaZnBxYXdYVG43ckFBMHRZQ1NQ?=
 =?utf-8?B?d3ZLM1hwM3FKZ0U0Njhlb2xxMWwzN01pMTBYVkZ0bmsxaW9MYW96VUpqY045?=
 =?utf-8?B?amVkN2tqRWFSTFRMOG1jUWVHYUlMTVBob29RNHA3Q2Z2R2VicmwyVDZDT0hY?=
 =?utf-8?B?T3JNeGwvNkJIYitMdE1QKzk5dXlkSEhza0Q5K2Z6Z09oOFdPbFlObThGQ3c1?=
 =?utf-8?B?OGRxV1hoZlZVcFBCN3pZcjhlNmF3eEExeTVTQ3VPeW5JZ0N5S0VWUFJYdFdP?=
 =?utf-8?B?bUR3TW5zTUtBMlhtc0xOUW9MbzJHcXRSTkY3dTl5NG56WGVUSEhrdmx5bFhs?=
 =?utf-8?B?SXExdmw4Y2hWb1F4eXRuVFNIUU5ka1R1U2E3b0tXMlU2dnpvYlRkckdRSHFS?=
 =?utf-8?B?Z0hleDRrOE4yMURLSnNDMHBuaEZ5aTV5S3RtN1pINXdDTWJGVmVKdDYvUEJP?=
 =?utf-8?B?VEQxREJIRzFjUUFPbkFSRE0yZE9rNmEwZ0REcTVzcUVnWlA3SjVTVUQ4amtz?=
 =?utf-8?B?ZFAxdWJxMjIzWHhJZG5YaWZ1TTE5VmJONVFNZmRSR29wTWdMSkdBS2pMWFJu?=
 =?utf-8?B?RVhjT2o3THhia21GaUVlMlAwajA5TlB5M0lVZjR3Zk5kd2xPT1owelVnQnlK?=
 =?utf-8?B?OG5abTNMOXdYd2ZYeW0zVmc3THIrWXcyYTFFczNUcWxBQzE3ZlJDMHd3SGtz?=
 =?utf-8?B?a0hTZGU3eDk4YXpLNVdIRmYxK1M2dWNOb3pSWVkxUk9OZ0hDUFJkOWUyZStt?=
 =?utf-8?B?YW9uUys5NWhYUjJ4NFcvTkNGTEJjRjB1bXd4bVdqQVVRNGo4U1RSYi95dWND?=
 =?utf-8?B?STlQMS9sRG9QekdoU3NkVkJ3WFdjZEppZElYVENEWHB0dzFyd0cxblIvb0hU?=
 =?utf-8?B?bHN0Y1VQajhTbDFBbllpSlcxNTExMnJNUTRZaFVESGJCZDc3S1pZcytiaCt4?=
 =?utf-8?B?ZWhIaEw1a25VTGQ0OEUxTDkzaHF4MHJPT3NXODgxOXB6cWhsQUhoK0d3UXJR?=
 =?utf-8?B?aEIveEZ1ZXI0Zkp3eWdiRXJWZFF4Vmd5NEVJL0c4blRCNlYzNXdFMzRUZm5Y?=
 =?utf-8?B?bkZhMTNpL0dxakxxQXdCclFFcFJZSndVeHV1WmZYQjVvYXM0NEZZeUxvVTVw?=
 =?utf-8?B?K0VDazFOWmlTUFhyS0MxdmJIaWVvT3RkVjFLSitLZWlXY3JsQjdZOWVFOHpC?=
 =?utf-8?B?YWtVUXZmc0ZwUEpiR1pudnFmWHkvMGEremgxYXFGcFBwN1ZnVzR2UEVEK3ZY?=
 =?utf-8?B?bnpFTW5xZVJtbG5qcHpBNjZYQXZCMFJPWk1pSitXbG1wYUFUNlp1Y05KazQv?=
 =?utf-8?B?YStENFhDTWFMaFBSeUIrMlpLM1BvRzlLMU4vS2xHRjM0WUdkWEF3bldmaUZZ?=
 =?utf-8?B?M3cyZ0dseVdQTUswenNMakp6N3ZFMVdYTVd4MjFjTGVQWE9ON1AwbHNOK3I4?=
 =?utf-8?B?eEpGcWJDQVdSOWx6UXNOU2poQXI2UG1RRmw5eWVxakxqUU1yUmJIQ2JIN0w3?=
 =?utf-8?B?ekI4dzE2dmxpMUhPSS9DdDlGalplU2lPL1BmT3V4Q1BEblZUdzRITTdOOGhN?=
 =?utf-8?B?K09ISFpGSWwrUXdXVEkrT3c3RVpmYk5mZGs4a0tTNkpia3pJUVJ4TE5OVUgv?=
 =?utf-8?B?a1gxOVZmZTlWemc3NjRDUHlhNEM0cjA5c1Z4eWFpRnNqU1MxZ2ZLSzIyYWZ4?=
 =?utf-8?B?ZTRudzdwaFBLSklTNWFpa0FMQzZKT3I2cFJPQVNTQ29nRUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aCtyT3RzdUY0VXFkU20wbnBUWmRldStzWi9kdmQzZk9ZV2U3UXFMWW5lN1lR?=
 =?utf-8?B?QVpuQkJKRnlZUFN1RDlmOUZlZ3A0T2orMFBjSGcwc3J1VzdpT1FuMFd4bHBx?=
 =?utf-8?B?QXBNRmQrUTdnU1JSTllYNHp5S1BLcXdnczVwZDBPQW43UTU2MHNHTEE5Q3Y4?=
 =?utf-8?B?Nk9zMzk3MjVNUDhiWngvSHNPN2NxRXc5S3N0Sm93QXRmUlpvUkRxVm0vTkJD?=
 =?utf-8?B?ODF2d3VEdllWcXhDWlJGSUl1d3ZFUGFYY1IwaWU0U2p2Zm5kekx0SllRRk0z?=
 =?utf-8?B?YktOSmtWSGxSVGk2Z3NDYm9FaGZYR1YreFg3UmdVRGpPcVF3QlBxQXd5S1NT?=
 =?utf-8?B?K2xZVVJ1MGlmc1lGTEZmT0xKZExrTy9mQWpTRWl6L3VvbGRpQ250NDFGalgv?=
 =?utf-8?B?dnBZZVl4WTVrNlFhTUpwYUI3OC8rM1ZPUkdwdTdNUkhXTi8wZHd2d1NsQnFW?=
 =?utf-8?B?TXRDdGVMbjdwckMxWGdmOVl3MVUxVjNPSE5Vbm5HSmc0OE5LeHhMRktOV2Y3?=
 =?utf-8?B?RUVhaUdOOG5NdnBhOXNza2prL2pmcTZGQVZFcGRsZVo2elFtTkVWbDN4cTAz?=
 =?utf-8?B?YmtWZmpCRnBBb3pSTW9neW5YMGJtWks2d0hZQk90ZUFkQjRpNUNtZWpDL3FR?=
 =?utf-8?B?RE0yR2p0dFN2TDMwUVVmZTFYUGYyd2duWnIwTjVsK0s0SzRDQ01DcFhvNHIy?=
 =?utf-8?B?Q0craU1yL0dGdWNCQkxTdjBmeW4rR091OGx5cCtOWDZwK2RRVlcxbmtaOTRR?=
 =?utf-8?B?MnFSUTdpZTlZNjNLQjE2REMxMjFHTktZcERyTVdwektCa0tXSHh2QU9VYkdC?=
 =?utf-8?B?L0ZKL3hPY1hLRUhaK0JsK2h3dHBCWC9Mb0tvSnlvYnZuZUNRQkNMdUJVU3hY?=
 =?utf-8?B?VmpGSHJxT2M0NjZ1Zy9jWlpMdXFtVkxwcElWR01CS0RwTVBQalNremttMDNG?=
 =?utf-8?B?b2Q0MFJaZ1B4eXowbDl1TUV5R0NGR2N0UTVJUy9YeENHRU0xSFNUZm1BKzl1?=
 =?utf-8?B?NElrazFZaW00cUFyUzhyQUp4YkVGcUhyOTgzSy9LdmltOEd0cWM0UTdCTXhj?=
 =?utf-8?B?cUpqRWZUVVc4SUFSQXczTmJMVzgzanZnaFVmUXgranRKQkhabDFmdzd1RmVo?=
 =?utf-8?B?TEdVS2tJcE81a2FDY0syK1NhdnlWK3BxVGIyTVRaSlFrdkxKN2FiNW5IaXZN?=
 =?utf-8?B?NURDQ3pZSXhRZUNDdXl3Q3pRYys3eW1iTXRPWmJxaFlkM3dWQjlKZnlqYmMy?=
 =?utf-8?B?TWRpcGgxNTJJZGhOSEFmZk8xaUFLc1VBMERHbnpCUENEdVdJbUk3eTQ5SzUy?=
 =?utf-8?B?Zkk2NjdwemdOcmJFck84ZkcwbUh6c1FEekJxaHN5RmVHQkQ4NEdXRzF0dVp5?=
 =?utf-8?B?bExxbTlISUx0MkZlWW01V2ViSFA4N3JCQTRmUnVBYVNSSHYrSlI1bHVyeEg0?=
 =?utf-8?B?RkJTZUlkOTZ2SlRnNk9zWldlU01OekRRaXhRMWJjNjI0a3BKR2gvNWw0SUNS?=
 =?utf-8?B?QXB1RFpvcE5JOENwckY3ZGhmYzdKS3d3QldFZTN4dG1pL1dOQWhYMk1PcFZS?=
 =?utf-8?B?SEQ2dDZCaWdrSjBwSWhUanNYcXpqcXZJcU13N2ZCci9xZjVXcEwyZWtuOU9r?=
 =?utf-8?B?VXpCZ251bWFwSU9hb1QzeWNXTTc2VUJjWmw0WUdZWFpYejByWDNTQkZUNE0y?=
 =?utf-8?B?Z1VEeXEzTm9YaWVFTkxLakoweEhGbFl4Q0hNTEpiNVJlUkdndVQ4WFBOOEp1?=
 =?utf-8?B?cXVhOCsvZlM0TkQxVW5semw3aHZjelVIeU9vZnNPdHE3OEI5cUxFcFRWRWt0?=
 =?utf-8?B?VmRQN1pVdm43dFBXVm9nOTBSNnNIcjQvMHNHbUJlU3hOc0FaNmJ5SElVdTMy?=
 =?utf-8?B?OU1hd3V1SStFbHRNSGl6MVdVUDZRanY5RFg4NWwxNkh0T011WWo5dHZSdWRt?=
 =?utf-8?B?T2VCMk90Nk5vSHE0M3lvbkZaankxOUxtMlRBclJSMkdWdUxxcSs3dGxBdVhn?=
 =?utf-8?B?S1VsMmxMZzVJa0s3WFdDenk4dGtLQ0EyNGh6clZ1NlZ1QXhDY281OTU3V0pZ?=
 =?utf-8?B?YytoRFJ3TXA5UXlKV3pKWDM2TUMvZmVKR1ZHem8wbjA4S0VMM0dyeFVuc0N1?=
 =?utf-8?B?YkF2REwrcWE1bnNsNlJmaFkydjZHZ3FwSGcways0bTJldkpuYkxDOE5odm5X?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f767123b-5fd8-427b-103b-08ddb9a916e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:43:24.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe8grSZXEfLy25s+ExODKE+VXleeBhl4M9uO4MVgAIhsdDV1sfh+n8NSKkCUB0BM5LN++08e0dlXNNB08exLM1sCvWM91vmnXKACu7HkClQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-Proofpoint-GUID: tduOmT4CViUB2206ZOuDCALuOVECdb8a
X-Proofpoint-ORIG-GUID: tduOmT4CViUB2206ZOuDCALuOVECdb8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE3MSBTYWx0ZWRfX90FyJwsU//Sj 1M5AO8+KgdPkN7cF3po6ddrqVn0mqw0Qj+TJ3BGZ4PdissshwZlsJGIEJX+AfP6Eg45E6+87DGy OMzR49+xHwQZXWsnDnSWz00/kW630OAptuYfT3OF7kZwQJ5J6bN4Z9KBeZ1wVEoT9CyN6CDjLUb
 cTi5sLKW9wo0gfPwdgdtEgCaAdtOTFl3qi0SbwSUHShD+BoIx1r7drIoOx3tLZyzKWh5s1CCZfS Or2Mvwp1v0YH/F0+yWhfmBsOSAZ5RiVguFif35tW2cEd1fXjhIZfI/AkkSytdptu/F6bl03EjbU YRa/+0qX/gKizS/WGxRMto7s/kEOkM1DGO5xTcQ8qKcoXxvv/0WJMWu2Jum3sNzgRmCrxaey2vs
 4L6AvPT4xmFv61SWSOAHcDWHep+34p9Ic/ai3ftFrSlgpOAsLx/SDH0AbO6Tybx4oH1DktRO
X-Authority-Analysis: v=2.4 cv=JMg7s9Kb c=1 sm=1 tr=0 ts=686599f2 cx=c_pps a=Ubn8NgXdbfquypQWsLw3nQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oBFCjJhlzlbulGpcu-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=735 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507020171

Hi,

I've got a Sapphire Rapids server running 6.6 PREEMPT_RT, and the 
reported C-state latency and target residency for C2 (with acpi_idle) 
and C6 (with intel_idle) are *way* different.   I'm talking around 40/80 
usec for acpi_idle and 190/600 usec for intel_idle.

Is this expected, or does this system have messed-up ACPI tables?

Thanks,
Chris

