Return-Path: <linux-pm+bounces-41752-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDpTMUVXfGn6LwIAu9opvQ
	(envelope-from <linux-pm+bounces-41752-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:01:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B9B7BD3
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353673011842
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D22D3A75;
	Fri, 30 Jan 2026 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gomkKqhl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD32874F5;
	Fri, 30 Jan 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756447; cv=fail; b=UerVHa3Rr0zrlm09YFlwt8xDm7T9lKjxAJSs+DdSo35uU3EJoHLsv2LVaj04Kg88Ou1URjkaBgbLSe1uPHGJSw0F+scaN4M86NlE3vem/HCHknMpkJFWteYynmVXUn0Vnrsyw3CLFwQ1plmvvg5qQ8tzN0rRDrRBzsEZFlxwk/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756447; c=relaxed/simple;
	bh=C+2weQo6YmdFfMUwj5foN8ghHCnKcIaPK5CvhRc3m/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZiEi48MpfDX8OddNubRb++YsLrkwr8jGo2ly9snzoBdnab1qMRyucREomewUj0shGS2cGSoja5B3VKw+goZ1GZ7IkfPg81kEBlXa5NfUEcN/1d0YLc8MuNE/cc9m/zt6u42WXjGB8QInaWsU/M0t+k5AYMrTEOCtlX4OPZfBIHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gomkKqhl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769756445; x=1801292445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+2weQo6YmdFfMUwj5foN8ghHCnKcIaPK5CvhRc3m/g=;
  b=gomkKqhlUfVvYXm7g2d+OxEQd2ZBssAikryRi03MOWoJ4TqtCJCKXneb
   DWxa/T7g0io8KX6MPb0jUf8ceZbepzQlbsb6IcBqY14T9h4JeuLYo+x3M
   lAzDBXs1aAZoHyrQi8v8oWrImRfmoRpIARqjoNq4f0BpBVfLuEivpmofa
   kq0qVeybFTQgCV/KHMaScpk6dXq7fvEM/9DXX9iCGDPyLqY2AZFylmGsB
   gN0MqNZ0DJqhgAExLoxdYknZeqwdYyw8FUTEFc0iJyueC3y14bajAG/UM
   BGUM3MO2TCKIT55EdXZNggxpZRa7HeQOzJyrBwkY5tlQxf6tGOv11S608
   Q==;
X-CSE-ConnectionGUID: BMpNC4N4Q0+RR/3QE57amg==
X-CSE-MsgGUID: rcOOwEm+Qyqs4/fWMxCSPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70910965"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70910965"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:00:44 -0800
X-CSE-ConnectionGUID: 8BwEThfQSdG4PWuSnMY/UQ==
X-CSE-MsgGUID: nUvkagQmR5uAreHhde6Duw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208380635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:00:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 23:00:43 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 23:00:43 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 23:00:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGoIBH8DgNb6y2WI5j/rawDm5Giaf68xAG3U2044F3CH/TLEy1fdDuH652CvkR2e6m3nRP6aIw1fyLfp/ByzwcBjQf3c/eMWA04dWzwDeK0vBHuGQo5+dU4TYopjjBs11eQDeLSfTdYNRCqFxpw/X4mESl5ubnqgsxRsW19JW4mxCBSgONrYmgOOnkhfq1+jyfBnu0mf+q2OjMt8OXYEKrT200pm/h0u5p2Oitd/GBQRsgWZ6LzWsDN+6CO3IP9aJ+gR2aHyCG99qiYzybiI1fFuSQ9BSIRaxEEqLTdxJeYsdg42EWcVXs8n2jcoCfco4T6JSSnCBfTayBHZLWVh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3LvbuNDy7MYvJTv6xWf6Gc50exDgi2o9Ktx/1DUIlI=;
 b=G2kJjrtL8S0hvJ0l1O79Tz4rcbpTBedSZ8goxjmQWzuFdCW4cIOI1QePxdGRajClfGZUdVAvC43tKN1MvnWcOi5oDLU6fK1obkq5+Icgc21nOgU8aGv085z9SpXiOJkN1qqBAr+6rL+n2oI7p7QsO0Ki0FAosZBEcsLFKcmHT7vW45Jwd9G2gUpb14CCXW3Ic5Qyf6TYIHdOGAv3L0bvF+JPhUE1zZAkF2hOCA9ZzITWaOdlRtrKLzd2U3Ro9Y5RYhEnbOgtYTaM4oJJd7IctveyzTEzVVsrt8bC7iQPgrHl+io187sJsfVbvIKkXsz7EFj2iWv9hS3wrp7POmwyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 07:00:37 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 07:00:37 +0000
Message-ID: <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
Date: Fri, 30 Jan 2026 09:00:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: b1548bc3-07ac-4366-2e72-08de5fcd4578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzAxV2lnQXpCZHNQbHJRZTI2Zk1jYzhMeHBGZkYwKzJRSFpiRWJPMkRGZlJo?=
 =?utf-8?B?QUpVZ3ZVSDJDY3dtc1BqL1JGbHBicU9NSUJiU2p5RFZvRjNna1Y3TXd0QzM3?=
 =?utf-8?B?ZUpqWlVSL3VEQUlwTVZSNXdqdE5wYnk0Y1lXdXk2UjRzZy80SVlPdDQybFRT?=
 =?utf-8?B?SzhYWkR6NlJISnhJTWE0MFRBMGJMVUgrQ1Vvd2dYT25sVTNDeG9DOWpLMlNx?=
 =?utf-8?B?RnF0YUtLS09ZQ3g3OFltOGZRUCswc2JkV1Z2K0liTEVVOFVDbDliR1VxZnYw?=
 =?utf-8?B?TC9nQlJFVGt6SUpodjhiV1Y0ZStDTnhoZlptaHladnArMGpFRVZuajJmUkU5?=
 =?utf-8?B?b1lPbmpTTUdvSkpjM2Q0dXFVUFp6WmtIdENCcjBOVnVqTmVFNjM0ZkVhVENa?=
 =?utf-8?B?cGZja2VHbExUclh5QzJ6V0FmNDJXNkQrdG1UQk5SakkxZXlqSTJDbktSK1F1?=
 =?utf-8?B?Ti85NUFFWEc2MHNTRE12QnZ0Y29qYjZVQTNMUWFndnZHS2w1ZDFFTEIyR0pK?=
 =?utf-8?B?NjJFWFNXbzF3NTJjNXlNZmwzNkxGZGNhNXV2dDhaaG9WUGtESDdMUXRYTFV1?=
 =?utf-8?B?VnVIbVZnV1BlS3ZRNFV4QmplQjZONHBycTN2b0JzdEthOUdtT01BWnZ5cGN1?=
 =?utf-8?B?cENhd0lIWWI5cDAvTUU3eEFkTE9uZjlaMXdVSVFFM1pxeWo1Y0ZaNjRjQ3Br?=
 =?utf-8?B?RGFTM0tWRk1QcThudGd5S2VhQVlhU1dvQmt3OUp3NFpUbUtTbDlhY2JrVVNP?=
 =?utf-8?B?anhjR2pKaG0zTm1oZjVPMVdTK0ZUaE5pK3hBeTJmYkZPSEk1ZHF6cEpwN1lD?=
 =?utf-8?B?ZGdsRkVQM0Znc2huRjVrenZrYS92V1NmUDBITWZnUUhPVVZmS1pOWmNIakFV?=
 =?utf-8?B?d3JqNndhN2hLTHlNTVRnekVibzVscDNRNnNvaVhsMzB0TU9Ceis2eG9Ebk1L?=
 =?utf-8?B?Q053UEI1SnBuRU5XaktjY09vdndOTTUvN0xscUFXeGxLWm9iSWZyVkZvYVZP?=
 =?utf-8?B?Skw0UEtKYzMwNmt3ZllFZUliazJBNWU3NHZuT1dVMXU3dG5XSkVvMytFd2NS?=
 =?utf-8?B?NnNmc1haUjZDMEpJUFdtZHFDTU53UTFSU1luNFl1VXF0SUVnRUlpdlRpWU9i?=
 =?utf-8?B?ejBVNjV0K0R5OWxEOFIvOHBKcGp3YUVVbHRiSGpDd1R5b1VEQmpuVFdacTda?=
 =?utf-8?B?aE4zeUNER1Y1L1NqWE1xbUt4MCtTazlzSVpra3d4Tnh3bWhnTHhyYW82N0dV?=
 =?utf-8?B?YmN3ZWptZlB2Mk1CV0loK2s0Tjhqb0pvREhpR1BuckVYUjBMcmxURjMxa2d6?=
 =?utf-8?B?MkxjVEFjMHhiUk1zQWxBZFVOZEJld2J3NDNqQ05kbmFpZXFZc21nYkdqTDhT?=
 =?utf-8?B?VS9iaDBOUk0wYVhhYkxNZXFBRG1MQVdrU0hacE9KMDB6cjFub01MTUNmT2Rv?=
 =?utf-8?B?RUNkZTRWS09lUWRteTNxN1AwdmRnVzNUdk1PTlNNY2FSTCsvcHA2K21oRVhM?=
 =?utf-8?B?aThMSXFZeHl5OUV5ck14L0tpSHBPMW5DTWlsUEpmRlNsejU5RTNRdnhVT01y?=
 =?utf-8?B?N1o1b1haQmtkRmNlbWFuREpSWlpDcTIwcjljZlVZS0hIbmVDT25YTVAxNGhh?=
 =?utf-8?B?ZlBxZC9jUWVaQ3luR1hJaWNoaFpBaDhHL3BWNkVTK2NINUFBUmJwVGI0eUpC?=
 =?utf-8?B?ZWJxeDNFNWtDa1MwMVNNNjdlc3dRZjRMUHY4cWJ2SHIwaXBRWmxDclA1ZXZF?=
 =?utf-8?B?Y2VPQ2ZpbFJZdHZWMnAxT3ZXSUpnN3B5ZlN4VEp3ME5kOGV4NzloQmZ0YTZD?=
 =?utf-8?B?WWc3T2JUL0N0d040a3l5cWhRQmI4WlFkNVhCU2pVRm8rMmcvVjhYNlFub0hr?=
 =?utf-8?B?K1haZEt1SGt0bDMwNklzdTBSN2prZG5yS1VmejJiRkpucFNYdkJxTlE3UkZB?=
 =?utf-8?B?MGpJUS9WdjJ6V0N1aEhPODl6bE1JNndkRUgxc3hWTERYZnZSdTQ5dnRuWDRJ?=
 =?utf-8?B?UGhxNmhKSDFwUzRobG5PeS9kU1ZkQWh3OGFEaE5GeVRTcXZSSk9JcUxVdjRu?=
 =?utf-8?B?RC8wK3BpdS9uclpCbWJnWldHNi9QVXdiWUQ0bkdxTGo2NVNjTUpjWndrQmpk?=
 =?utf-8?Q?am4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RYRHVueXRrbHI2NFFSSU92RG1zVGE0bUhHZmQvTS8vMzVLZWU3cHA0SUF3?=
 =?utf-8?B?NmJZam90Zk5nYnp3bUdBWWdxYkNFV1Z1UHFvaEExdXUvY3BkNUNSVHJyaTY2?=
 =?utf-8?B?ZE1MNlVJNCtuQUZSNzJaS1ZOMDQ0cndQWWNhcGkvMDdZQ000QWFGTnFkZUtx?=
 =?utf-8?B?RjNNcEJHZFkxQnhIRzBKSXFZd1BNU3E4bklKaDVwNDhmTEcvOEdHL0hydVRz?=
 =?utf-8?B?TjdBYkV6akdVdlFXelByNHpQT2lsdTZYUno1T29kMktqbmlTUkxrRXJZTEFy?=
 =?utf-8?B?WWxIRmU0OXVvL0o0a2lJUDVxYktOTkVTVUthYXk4YVF5cld2bjlxRGtPNlQ4?=
 =?utf-8?B?TWdueTZuV3FqblNSTlBSVWt0ZWpiTXJWT1BwNWVydGl1VFFPSTBzZk9mMFFQ?=
 =?utf-8?B?WG1sWkFHa2NLTXFPb09ld0JyTU5SZVl1dmZpUERPd0VFQWhZNWhGazZ2cXdi?=
 =?utf-8?B?U04wODk1V3hOREFZeVBWbW5ybm5sK3FMbUc1R0hLbWJJVzY5akRvckFEZGhF?=
 =?utf-8?B?dUJWcVowSERFNzlJWlczbkJDRW55RXlFZWRQU3FkOGdCR1J4RVhxNjdoZytt?=
 =?utf-8?B?WkdpMmdGd3lqcExJN210eG5WYm1HR1VDU2dLaDNGYlNGYzNSVGJOMW45ZHBW?=
 =?utf-8?B?N25SSExIcmxKVENPaWVyU0RpTjBlaVpBMWVMb2ZnYXNpcDIrOXlyd2RXeFU0?=
 =?utf-8?B?QzhIanRyMHEzRTBSS3V2dzZtUXZtMjZsdElGaWNqSFVBN0I5TTlmM3FFM0pB?=
 =?utf-8?B?RFNKY0tzT2gyK3g2YnFtVGJmNlFQMG9GNVUzT091dDM3ZENkZkFxN1RBcnEz?=
 =?utf-8?B?MVNWajU4OXNFSDUxSStjRTlYcGM3RjF1N3h3MElGd0phRUkwUURHQzdpeWVH?=
 =?utf-8?B?Y2JScjBpd0RJdUFNTWk2djYvMEZjbGlQcnZBNkhJS3ZCSlpTOXV2L29ReXdn?=
 =?utf-8?B?bUZYeTIxUlZpV1ZWSVNlTlU3ZGFUcVlLZmxDLzdZU2tJa3NJdUprTWdvcWdu?=
 =?utf-8?B?OGtRNmtFQW96Z0NrQkRMODJ4WWh3LzMrNHFEWEYyUUgzUE5jTW5nZndTVXJX?=
 =?utf-8?B?L3Z6Q0VZblBaVUFUcmVzWlBGODFLUUNhLzBETnBYaWNFRVJJUGl3S01DdWRR?=
 =?utf-8?B?bDh4UzNiVktpZFFKQXNtdElyR1R0aSt2V0xCbFI4WDlVQlMzcVBiWlVBQkFo?=
 =?utf-8?B?bVNQRjk4TXhBc0tOM0orTGR3S1pmNGJHUzRsQUsrMGk5RkxPTnJLUFYyb00x?=
 =?utf-8?B?RU5mQUovcUNMaklyL2lQVVBDYUhmODNlTTRidWMvaHR3djYydU0vM2JYRUtH?=
 =?utf-8?B?Qk85N2ZpVDNhaldVOFFzM1VycC9Kb1YzdW80ZE5qRUxOVGxxS1U4dDhrVHFS?=
 =?utf-8?B?Um9adWFQcmJnNXpVOGVkbDJ4K0JkTFlyOVkxYktkOGpYMHk0SWRJaTIwQk51?=
 =?utf-8?B?K29LemdNbFk5dDhEZEgrUGhsSlV0SENabVBtMUFGUms0ZTJJQ2VkVWlIN2Vm?=
 =?utf-8?B?Z1VvOTV0YVV6MmhMTG5xNWphUU9nMmNaWjZ4cTJybWRUTS9YcndBcDRucVNN?=
 =?utf-8?B?MmVqZW9aZmExN2FGSkR4RzZFQXJRakpaTWpXdzF0T3VLTVNVckRhWDBJZ0Nj?=
 =?utf-8?B?Tmd3T29yNUt2REduY3I5YUxhVE9HK3BJY2NVaDFOVzkrMk1HYkpMOWN5ZG1i?=
 =?utf-8?B?Q1VqS29yWUV0SlcyMGZSUFJuRlVBWXpzNWNUUWhPLzhiN01qbFJVVlpoMEtp?=
 =?utf-8?B?V0ZwTlkxcENxaEU1d214am05dld0dzZoaFFyUkU5VGtRZHVydWpUL3JzamdO?=
 =?utf-8?B?d1NjYmtOenBlYkdYaWFTcjJCMTEvNEM0QU1lMzJGVW96c3NJMG9PeGN0aVVO?=
 =?utf-8?B?QjhSK1ZGKytlWUh2VEI3Q3ViVkE4aldTUzdmNVE4VldoajROeTBPVFlHZjVX?=
 =?utf-8?B?RHBOK1NNQy9KUUhxVVJzNWxiMW1ERVhsQmZZZGVibjVyUlRrbU9hbkF2REQ2?=
 =?utf-8?B?VzVqdTg4eTBtZWt5dFg4c0o4SE41cVk1a3RMV05SRGFuWm9ESnlTeTM4SERM?=
 =?utf-8?B?RTM5Z04zZEtoLzJYTWJGK25pYm1YVnh3aCsvbmUrY3E3bE9lZVBYaFI1ai9v?=
 =?utf-8?B?T1AyeitlcDN4ckRtK3lyWVpuSGJKUlJ5SWI4YjdRV3dtaGlUNWZDSlM4ZHgv?=
 =?utf-8?B?cnAxQmd4UFc2L1pNL2kyTzMvRENDcWtRR1d3Z3c5ditpUStYMmRKNnV3Z1JW?=
 =?utf-8?B?SjlSWlh5SW5IMGdaTTZONWlwRVh2RElyajc1clIweHhwTUl1QTQzbU9CUXV6?=
 =?utf-8?B?MGdBWnFhK0haRTFaN0l5ZGVMQVA0dG4vRzNvUWRFdFhJeXk0L09odz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1548bc3-07ac-4366-2e72-08de5fcd4578
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:00:37.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JaQh8PwQUWQ4/dh4RbNEI9q0k5HW940W6YCCssu+ItGcMPlm51gud12z4LG7zKEQ2+qPEODHLmEvAgxzciwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41752-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 029B9B7BD3
X-Rspamd-Action: no action

On 29/01/2026 23:00, Frank Li wrote:
> On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
>> On 29/01/2026 22:00, Frank Li wrote:
>>> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
>>>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
>>>> where a single parent device hosts multiple I3C controller instances.  In
>>>> such designs, the parent - not the individual child instances - may need to
>>>> coordinate runtime PM so that all controllers enter low-power states
>>>> together, and all runtime suspend callbacks are invoked in a controlled
>>>> and synchronized manner.
>>>>
>>>> For example, if the parent enables IBI-wakeup when transitioning into a
>>>> low-power state,
>>>
>>> Does your hardware support recieve IBI when runtime suspend?
>>
>> When runtime suspended (in D3), the hardware first triggers a Power Management
>> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
>> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
>> the clock is started and the IBI is received.
> 
> It align my assumption, why need complex solution.
> 
> SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
> queue.
> 
> IBI work will try do transfer, which will call runtime resume(), then
> transfer data.
> 
> What's issue?

The PME indicates I3C START (SDA line pulled low).  The controller is
in a low power state unable to operate the bus.  At this point it is not
known what I3C device has pulled down the SDA line, or even if it is an
IBI since it is indistinguishable from hot-join at this point.

The PCI PME IRQ is not the device's IRQ.  It is handled by acpi_irq()
which ultimately informs the PCI subsystem to wake the PCI device.
The PCI subsystem performs pm_request_resume(), refer pci_acpi_wake_dev().

When the controller is resumed, it enables the I3C bus and the IBI is
finally delivered normally.

However, none of that is related to this patch.

This patch is because the PCI device has 2 I3C bus instances and only 1 PME
wakeup.  The PME becomes active when the PCI device is put to a low
power state.  Both I3C bus instances must be runtime suspended then.
Similarly, upon resume the PME is no longer active, so both I3C bus instances
must make their buses operational - we don't know which may have received
an IBI.  And there may be further IBIs which can't be received unless the
associated bus is operational.  The PCI device is no longer in a low power
state, so there will be no PME in that case.

> 
> Frank
> 
>>
>>>
>>> Frank
>>>
>>>> every bus instance must remain able to receive IBIs up
>>>> until that point.  This requires deferring the individual controllers’
>>>> runtime suspend callbacks (which disable bus activity) until the parent
>>>> decides it is safe for all instances to suspend together.
>>>>
>>>> To support this usage model:
>>>>
>>>>   * Export the controller's runtime PM suspend/resume callbacks so that
>>>>     the parent can invoke them directly.
>>>>
>>>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
>>>>     parent device as the controller’s runtime PM device (rpm_dev).  When
>>>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
>>>>     instance’s system-suspend callbacks from using
>>>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
>>>>     PM is managed entirely by the parent.
>>>>
>>>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
>>>>     by parent-managed PM implementations.
>>>>
>>>> The new quirk allows platforms with multi-bus parent-managed PM
>>>> infrastructure to correctly coordinate runtime PM across all I3C HCI
>>>> instances.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
>>>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
>>>>  2 files changed, 22 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
>>>> index ec4dbe64c35e..cb974b0f9e17 100644
>>>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
>>>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>>>>  	return 0;
>>>>  }
>>>>
>>>> -static int i3c_hci_runtime_suspend(struct device *dev)
>>>> +int i3c_hci_runtime_suspend(struct device *dev)
>>>>  {
>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>  	int ret;
>>>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
>>>>
>>>>  	return 0;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
>>>>
>>>> -static int i3c_hci_runtime_resume(struct device *dev)
>>>> +int i3c_hci_runtime_resume(struct device *dev)
>>>>  {
>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>  	int ret;
>>>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
>>>>
>>>>  	return 0;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
>>>>
>>>>  static int i3c_hci_suspend(struct device *dev)
>>>>  {
>>>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>  	int ret;
>>>>
>>>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>>>> -		return 0;
>>>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
>>>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>>>> +			return 0;
>>>>
>>>> -	ret = pm_runtime_force_resume(dev);
>>>> -	if (ret)
>>>> -		return ret;
>>>> +		ret = pm_runtime_force_resume(dev);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>>
>>>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
>>>>  	if (ret)
>>>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
>>>>  	return i3c_hci_resume_common(dev, true);
>>>>  }
>>>>
>>>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>>>> -
>>>>  static void i3c_hci_rpm_enable(struct device *dev)
>>>>  {
>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
>>>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>>>>  		hci->master.rpm_ibi_allowed = true;
>>>>
>>>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
>>>> +		hci->master.rpm_dev = pdev->dev.parent;
>>>> +		hci->master.rpm_allowed = true;
>>>> +	}
>>>> +
>>>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>>>>  }
>>>>
>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>> index 819328a85b84..d0e7ad58ac15 100644
>>>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
>>>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>>>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
>>>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
>>>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>>>>
>>>>  /* global functions */
>>>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>>>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
>>>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
>>>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>>>>
>>>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>>>> +
>>>> +int i3c_hci_runtime_suspend(struct device *dev);
>>>> +int i3c_hci_runtime_resume(struct device *dev);
>>>> +
>>>>  #endif
>>>> --
>>>> 2.51.0
>>>>
>>


