Return-Path: <linux-pm+bounces-26816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D0AAE349
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640CA1884E6A
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA47289801;
	Wed,  7 May 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L9LkzVN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F5286D64;
	Wed,  7 May 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628788; cv=fail; b=nu+sS5R4I+KCYBCM51jEOR+nM4AoeP6Lts9eNtTYs9P0Tf7J/QW/2RimGpPdoaqkhtT2jObl8zD4VnvHzpk1Aen9duvvAr9r+Uc4VUmp6u8m1DPvZ9rYbN9aqdLCDBvmGuEPkfpx69ejY5xmgPSRmXqfrZUShC/WUmBYjKSizpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628788; c=relaxed/simple;
	bh=AcFLQOoXe+bE6f7KIUR8Ctf8sgntOwvwFTixwfo3QIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dHaUWhut/Tvm1Vv0Fzy7K7y1si09tsFnpchXdBAlKTF+Z3BP/3b9xxcdPDx422TsG3yENuydWK6xt3aPzVq20GNljKowhUYm6Zl9jpTMQy0+aoKT9oFtC986TBLnUiCltIuU+2pueM/zFzzyBw8G1FExG1sn+OxmaI2Lc5xSAWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L9LkzVN6; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN8Ne6/mWfUUcmg5o5jzICTkcc9kab/QSNQMvBluoMgmGVigSiDvrrZy7f/1qsMjz9d8+Z5apRmNt0LxMZDp3GIobdiMIvXJpyOe1u+O5f7hEw0Os5qB3DPXcMy2mxt8s9QJjz0m5jP8u+o235pg032uZ+BQmQuXl7upTRP5Vvm8EQHRW6o9BeKqvZOLPbg62xxD61NZcbYJYsxc0L+pYGQ5Ev9sR89M3yYHfJWSGefLl/7qGsHTAO441ZBNrKTPMKqkrj92m1nBTUyPXBW+IWrkGr3AruxHpfPBnfqst2ZszB60O8qC7W6YBsAt7ncaWYybctiJYe7Trz75HmBJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XNFUUXwNYk2iKx0oWmAZIEDeLzmrHqKmMY7GIGKbA4=;
 b=jQo/KK6NlcuARDYrMUa3Bba+Slgzd2UL4kOdV2ZCYYpdyF1B1q2xj/rnjxS33BBjwkupDVd/kp0xuVA4H8kb/HgQmtl40CRhYVeNLmS7EHQOe8oizzSLMJI9iMfXkm1cxkr0Q1PMv1IBosLh7j9qyfUhw6i9im0RuY1olMsGS+umPvz4/ic8ZCzKOC2R5kowa/tZ91GbTxLzWjlarRDyYHFavHIFK1kskTrfQJ+m06/qOVNpmqQgD7hh66n4SIDaD68z+Emmxj+qPMBEBvLHM5bgWRe//FvyzVnjBxluxgFC9nk2p1teKdnzqmwjdrlDX37Qgqx7WV65ZrtWEb+3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XNFUUXwNYk2iKx0oWmAZIEDeLzmrHqKmMY7GIGKbA4=;
 b=L9LkzVN6nT7hPamY3eCWFeDNqH0FkrciKOCp9eVfKo+VtjVPTx7MXY667ppH89/8kPHzPuQN3/+5EA3NQZekz4RmX9jtaU5z6SGsDKLXaV5WMvKUaBFA8uH5B8zojF4dBYGIJwk2b56o5UZr2EjnBf5lcgdgOUfXFxpL+qD3RY3CCsIVhxRrqqZuMZpXXrP4rqkKuFMjDnvlJwsKhjWShXlXqV6g8kKP3nrlygapPz+z+NkPE9/I4Plz5dQZRS+zt8AL2Ulvo5oF9jkW2VPRij5odYjLEJ2e9g2H8jnMYAVyV0+tUeBpANNr7z2fJ2Itu3FOykjFqrWrCAI8Ss5CQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:39:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 14:39:39 +0000
Message-ID: <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
Date: Wed, 7 May 2025 15:39:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
 <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
 <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: b42b6ca7-ffde-4b80-feec-08dd8d74ff05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjFaSDJtc1BjSU5IZ3NUUzdMZ3ZBMlhLYW1OZWxsSTJRcjVTN2YwOSswdmtD?=
 =?utf-8?B?ekpBWXBKN1ducytTcDVCRHNoUjc2U2h5RTJnblMzQ0E2OEdqNWZndXpvZ1dB?=
 =?utf-8?B?RG1BQ1gxRVVnQjFJNzZGY3RJMFBnL3VGK0oxQXZRZGJucU52ZldIQXZpU2xy?=
 =?utf-8?B?NGsyUzFCZEpSNGFaRmwvS1VhREhJLzdYRFhLc28vYnJTaTRzdzJxazlqb3Y4?=
 =?utf-8?B?NGZBZ3JwUE5YR0N4N2hHYTIvdWFmbGNUTmxTL2FJR0FSWXBlZ2puYXA1R21t?=
 =?utf-8?B?MTZjRTNPMVNKU0hmaDZEZ0xmT2hNODR4Qys0ZE1FZVl2L3IyLzNZMUwxbFMz?=
 =?utf-8?B?NHlzOG5mM3I2NE1iWG03N2dCeHNxVk5DMFRyREQ4R3JlN2Y5alNsMGMzZ3Qr?=
 =?utf-8?B?NVhvWk9OTTVibHEzQWlpNXI2dVJvbElIS2JLc0JyMXY3bEJzY0tydktJc3Bu?=
 =?utf-8?B?SThYRFlaeEJ0T3NpV2lnNUhJME9sQmR1R2NGWTIwVXU5d09HelFsOW5Tb2pG?=
 =?utf-8?B?aUJTM2RydkcwZFFmWDFBLzdvN1lKMTYzbmgyRm9Ga1RPTVBJVGs2WjR5Y0ti?=
 =?utf-8?B?dEJhL2t0dXJBV1FvdFJSRFk4NGZ1YzZ0dEw2T2Jtd3FjWVNXdW1mS2Q2Ylcz?=
 =?utf-8?B?SUZtWUZQTjY2bk14K1YwZnhXdGFDc3BINTlrVVN1bkdHQ2ZxRE5TL2lOeDI5?=
 =?utf-8?B?eHB5Qy93VlRFZnZsVS9lNlR3VGY0aS9LTTJVWllGeEZqWnpGVTZMem1kNTMx?=
 =?utf-8?B?cXRvQ243UUZ4UUZoSGtrMmhyQ281UFhlVW10VUNKZytVbE8rZjhxOHA0NElW?=
 =?utf-8?B?dUJMcmE0d3dMYkV6TkViR3dFanBHSjl2S1E2REVLcEwwcUFGa3VvVzVSMGRU?=
 =?utf-8?B?Q1Y3Z253T0lqKzNDRlV2QVVxZW9DTW0vczlaaGE1RmV4WGZOWXdGLzR4bFhT?=
 =?utf-8?B?VjVyTW9RbHRhM1Fac0ltUmVOeXlYd2RDNEV0aFhVV0FQL3NvbU1PSlRJaktU?=
 =?utf-8?B?bXA3YWU5S1FHdTBJaHg2ekl2YUdyUENVMnBiNnJ6T2IxNVh3L0pLR1ptWTdk?=
 =?utf-8?B?ZUpMdjI1a2ZBMTRleWNWTG85Q1V4aGdJTVNHMnN6Ym44U0daTktPRUJnaXM4?=
 =?utf-8?B?V2daT3NEWEhOZElubVVCandnZlRDMVZvZU9VVjdsNG9jb3AzUEoyUjJkNWJh?=
 =?utf-8?B?NjNHWWVpYVBPSmZmVytmeUZvRm56Nk96RzB3STByVTVLN0gzZTBGQkVXWi91?=
 =?utf-8?B?TFhhZnBtcUhvU0hNK1N6b3NoSnNWSEcreCtYWkg1QkJmclFrazNheEl6ZkF0?=
 =?utf-8?B?TmQ5Rlc2NkhkR1d5aDBtSzdNSW9QcWdaZEJxaTdybTBoVnY0ampIQmRKd09U?=
 =?utf-8?B?d3B0ZWhDdzhkcXlSZzBUOFNJM1VOQ0lFenh1WEFadzJONjRTVkt6T09vakM5?=
 =?utf-8?B?cjRUaDhjZWVLSzJTSmZQbG03MUZiRk9QWXJNeCt3b2dxYzFOZzBpVWJhMFdU?=
 =?utf-8?B?eE44bVRnYlZqNyszNEhHcDJ5R0k3bkt1SEdtTnhLckVIWTVMVGNsSVlreVpX?=
 =?utf-8?B?MHlGZ29yOTNKaHN6NzFnMjlYUFJjWlRNUTlvYlFPclphd3ZIM0oxUzZpd2Jw?=
 =?utf-8?B?SFFucWx4b0RUM2FqTzEwVjhiUHdodCtiNm5mVXRNYlc3V3MyWFJyZ0N1T0x5?=
 =?utf-8?B?Z01UOEUycGxnOGJJQ3E0OC9CM2VscGYzM3AwNkV2V3QrMldaRnNpd3lTU1Vo?=
 =?utf-8?B?N0RDWEtzNFMwdExUc3ZHVlhHT0tMaUpZWTdiYlY4Y1NDTkFrMHQ3N0dXbEpm?=
 =?utf-8?B?M1JQekpxSEFZNm1wdndSNG5icStSa25iT3JERFhkUzZIbWQ1K0k4c1JjUGZq?=
 =?utf-8?B?dnNINElYS0JFREZ4ZnpEa1FzT2VtVHJvbUx3QjNzZ1I1Tkc4ZTB0WGMyMUlT?=
 =?utf-8?Q?4Z64gCs4ICE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aCtEbkpkcC9LY2RnQzlOaFVVNWtXZDVIN21LQk5pNmJiK2xkZFVCNmlKK0o5?=
 =?utf-8?B?bU1zRDZuQjY3SlFkY1E3dGhRbDNOb3VXdlZSaDhjeTN4bit6d3JTWkwvZFZ2?=
 =?utf-8?B?SU9LNWxyRVgrZ3R3VXZEYzdaczF2dEhHV0VPM3YrKzZzb0ltZ0ZtNUp0YjVy?=
 =?utf-8?B?OStwYnZKKytrblVhVGdvbkk3czFvNzIvaW04bHFUcy80RmZHWjM1bzZZSmI1?=
 =?utf-8?B?ZVRxWDRQOGMyaFcrbDg2c2FIVkdWLzYwRFFoL296YmphbFF0WHlHVGRIY2Mv?=
 =?utf-8?B?VzVwb21yaXNuVnBORkFGZWk1TUJsQXM5dDl0dHN2Tll1VUFLUmU4TUJmMjYz?=
 =?utf-8?B?ZTFFVE5pYkVFWm9MMWlYbE1IbWdHUjNDZlJZNFpMSDJMQTA5V2k5YXlpOEJu?=
 =?utf-8?B?QkFCcmVCZlFPSDNWWW1Pblk2ZWRmUXRkdEYrZm9tNHNlV3RuUit1M2tlQUx3?=
 =?utf-8?B?WWJnd0JPUkJqM1MvU25HUEY0NXdlODFiMzBPUEdteERqdmRNODBEMXRCNXFw?=
 =?utf-8?B?TUhJVG5JSThNRHJCb29jeENGa3grZlpkMGM4TG1uRU1qc2Noci8xQVRVcXlP?=
 =?utf-8?B?Y3hiMCtqN0t3NjVWYkVxcEhpNGNrditTL2R5b05nWXlkWFlvNDR6NGk4dTJn?=
 =?utf-8?B?MUpEMGxUNHVtMkVWZWlNMzN2TlRMVnFpc0JwTTFPUDQzN3JFSDZtdThOSVNw?=
 =?utf-8?B?WWE1ZVhJWkNtNEJzZzgyNHd2TU1RRVdjdlRtdTlJc2tYa05SMVUxeXJrd3Vp?=
 =?utf-8?B?V2ZjUVp2dUc2amZSbGZ5cXhZV0IzTHM3UlBsV2RmdmhDUzIyRVhiMjVpWDBz?=
 =?utf-8?B?OHZJNEZWM1AzY2t6TDlDa2lyVC9CWlpoTDZvVCtNdWYrNHgzS05OQitPYWNS?=
 =?utf-8?B?OEd1WXB2QkliYURmVVJHT2N1L1g2U2RqZ2hzUkQyUHQzMjM4SVIvUFA5NjQ5?=
 =?utf-8?B?MkhmczdVVmlKb1BHOTA1NkZzeWFoN3JieldqVDJ6NlZleUdqcWVwZStTanJz?=
 =?utf-8?B?RDkrd0d1VElENWxjNy8rQUs4SzZHSkRsKytKYkxvUC85Vm5ZZStyTEpYU0hw?=
 =?utf-8?B?bDNaeHBHT0wrUGZRR2dMS3dBSmxPL2JqVEJoVjl2dklETlFjUk1IN01nZys1?=
 =?utf-8?B?YldqZzZDeTlOaXdyeTZUYXV0NkNEVHV2cllhQ1I3L043Z0x2TituUllPNWtG?=
 =?utf-8?B?NWZBK2NPU0ZJRERYQ0JMVmtiWXlqTFR2Yk0vYVNNcnJVZm53VTFzUlJtU2hX?=
 =?utf-8?B?RnlrL1YwZk5tSUoyTXA1N2FuMmNJbStEMFRvaVJnMGszMHVwRE0rWDNNYW1j?=
 =?utf-8?B?SERXamIwVTQzaDFUVVN1YjV3YUtCS3VtemlteDAvRDQ5K21JMTZQM1pRNDRu?=
 =?utf-8?B?RldTOG1PaUU5bjNCTlN1YWR6RDlEVmRETzlkQ2szM3lMcjM5R1ZUQ3ZYdmov?=
 =?utf-8?B?WkNPWjdPcEJ0QlRzQUVsM0UxUU5sS1h0TnVyVDdla2xJT1UwZER6SlpGRERu?=
 =?utf-8?B?ZVdtY1BmUG5pbDNNNUlBZG56dzVGVkkwaVRnckk1N0hvSWl6S3RwOW9NMHE5?=
 =?utf-8?B?MDJEMFNTRHhFTzlzeC9UUTduZUhHaDE5QUc4TEgxaStYZyswdlJwMXR0WVp3?=
 =?utf-8?B?MmRhRWpmVDI0NGdwaU84a09WUFFhTmxFdE15eHhEajlYQVBsQUlhRmg3M2FN?=
 =?utf-8?B?Z1JvOG9GMTdFcU9GZGpva2pFaUNocTdsWm5CeVhvZDNFdEFwdTQ5RzhWRnpR?=
 =?utf-8?B?UXJuMXNsRUx0SXJXbjRlYmlrV2t3eUxDVzEyYXVVR3lMN0JlNEVLa3BhY3VG?=
 =?utf-8?B?ZDA3UlgzRExqL2twSzc4S0lMNWZMVGNEbzNPeWNubE9qUTR2RXR5ZEVIQ3lq?=
 =?utf-8?B?dG5weFdpNjlud2lwbEdGaVpUd1IxQmJDaUhSYmlDZ2crQStENmRkaXRxSVpk?=
 =?utf-8?B?bWxwQWpuUFNEa3pXZFlydVNHejF4S1VZV2hIWHlZV0lNOTJteDkrenBrcTBm?=
 =?utf-8?B?a0l6UzVCME02eVdQZXg0MlBmbWxzY2QxUEtrWlhmWFNaQ3dOcjdncy9vR0o5?=
 =?utf-8?B?Y0ZQTHBsejlLVkFpL3RGOHNhaTBDc2FPS0RaUUJDSHFJTFhKVEJvV21ud3Iv?=
 =?utf-8?B?ZVF6MnUxNm5CcGp6MlMvUUorZVlDVUh4WXhqR3I1NjRnZmJNSUwyNkZLWVN4?=
 =?utf-8?Q?POXik1WTKSG69yeoahUxxp7YYz3/bp6fsuciHVxEVP6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42b6ca7-ffde-4b80-feec-08dd8d74ff05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:39:39.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcl9gwfsxDnUOEMAc6hoRvMBOqkpgD1C/x2XGDiwPPR9OJ68mBGnFJsalklFnZ8r1uyDQl9rweXwcxmid4jUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198


On 07/05/2025 15:25, Rafael J. Wysocki wrote:

...

>>>> So are the devices in question "async"?  To check this, please see the
>>>> "async" attribute in the "power" subdirectory of the sysfs device
>>>> directory for each of them.
>>>
>>> I checked for both the I2C controller and ina3221 and don't see any
>>> 'async' files ...
>>>
>>> $ ls /sys/class/i2c-dev/i2c-2/device/2-0040/power/
>>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
>>> control               runtime_status
>>> $ ls /sys/class/i2c-dev/i2c-2/device/2-0041/power/
>>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
>>> control               runtime_status
>>> $ ls /sys/class/i2c-dev/i2c-2/power/
>>> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
>>> control               runtime_status
>>
>> You need to set CONFIG_PM_ADVANCED_DEBUG to see those (and other debug
>> attributes).
>>
>>>> If they are "async", you can write "disable" to this attribute to turn
>>>> them into "sync" devices.  I'd do this and see what happens.
>>
>> You may also turn off async suspend altogether:
>>
>> # echo 0 > /sys/power/pm_async
>>
>> and see if this helps.

This does indeed help!

>>>> Overall, it looks like some dependencies aren't properly represented
>>>> by device links on this platform.
>>>
>>> Yes that would appear to be the case, but at the moment, I don't see
>>> what it is. The ina3221 devices appear to suspend fine AFAICT, but hangs
>>> when suspending I2C controller. Exactly where is still a mystery.
> 
> I checked in the meantime and found that the i2c subsystem enables
> async suspend/resume for all devices, clients and controllers, so the
> devices in question are "async" AFAICS.

So that would make sense given that the above works.

When it fails it appears to hang in dpm_wait_for_subordinate() when 
calling dpm_wait_for_children() from what I can tell.

I will enable the PM_ADVANCED_DEBUG and confirm that making the I2C 
itself non-async works.

Jon

-- 
nvpublic


