Return-Path: <linux-pm+bounces-29812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3BAED22A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 03:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04AA16F24A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 01:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5271426C;
	Mon, 30 Jun 2025 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByYvqqow"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916715A8;
	Mon, 30 Jun 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751246319; cv=fail; b=XerdJDtKvR2bwtT11+OCcNAvTIMd2EB7EV6IZH0UceoD+IUuZEjDFIrmBPaCdsPd3SqYPOXxwWaQXEM+4BmPdEjIX8pP+gf6jqzvdvWgAGVesdJNlOieCKSQrQmUZoup/lLq1EG8oXMFt0kJ8ZICBI3cBvAk27t85zPluHaz+mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751246319; c=relaxed/simple;
	bh=Lvt23wu4WN5UnQ3NjmKlaBqo0+9t4ISOl5DaSWnodZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udJUtnDaI3+M4pANyxXCBp9t2BBDlLU6l3cT7pchgHVmzWbzxUl3mIz4TdeKv2vf0AW4oraBi49tkbes1V8H6U5D1gMHClCYezVrUnXg7nvFd+G2aGw6KDuIiEQ2AQkAkmsuu/DzLjZMz76uqOQAVUKTjR6dJrcTT44u5nt3WnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByYvqqow; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751246318; x=1782782318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lvt23wu4WN5UnQ3NjmKlaBqo0+9t4ISOl5DaSWnodZQ=;
  b=ByYvqqowpBBHPD/sm3Zfe20vegyGwR2AwV+qkmLh0jrNzHy4vXkgHVHh
   ZJyc2QxyN+f1PRfikyEWgxJqLPU73yxdc7BSKjYgaBZnahiFDK4lY1ulX
   s0FIwur1gZAtCh4c9ehY94Th9qkHp5NUrPvVZND217DvJVK2+sEH8hpWB
   QJ9Zx2E0zGkNZqPZFekQdgEQdIb3AIWLaPzuodz11ypoj3J9b67LisfdD
   5/HGHJfftjmeareAPRPBmSRDBwTfgFsqxa3ZEeQZrIOQWYxJo+ynsUaDD
   Jq+QOMdOIpRoxWz7zGC0asdt53izhbShmivzX4WWnwDgPYj6+T5eOcYGa
   A==;
X-CSE-ConnectionGUID: jn61AgXLRSSqYkv3K9XfXQ==
X-CSE-MsgGUID: U2rfBvxgRWKG+CjBUmGw9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53338502"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="53338502"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:18:37 -0700
X-CSE-ConnectionGUID: ShheEmP+Q1i5pBBsP4Smfg==
X-CSE-MsgGUID: xd56YbTrQCGC/6rsb/vbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="157341960"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:18:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:18:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 18:18:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQiWyi3bdxarZ0r61hnZNeSx8KqIOFmwtdf7F7NsVvWFMh1nqWULepCfD5c3NEd61p+/f1x6U+Ddlrc36KLozsekx8pzNr33JYj/hqeags8lJXe64TpF+YphbsIz2DIFfHc6bIZPpLdaGapnprpX5994q/a2dHaPc019oNLlCOfOjdddq6tQnkIxF8mIV5TuHcGuipa1bpi5wyCuK2YwxcewAtU5wX/yN6FqrFXcyWtIDHZ/I3klD+96Jr5t9rnNQtJ7UFwpeyBZSFCIrlMAktuwVFpca8HGHYa3XfBuZxGsCZyd18r/8GE9EcxdoYVKk/puMugxRg6Cz0pR0LpqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvt23wu4WN5UnQ3NjmKlaBqo0+9t4ISOl5DaSWnodZQ=;
 b=EI/l+rcQCvjOcmpUuraxLR5pWFG2ahz0mQjRnbXG2DvM9WMCJlqv/+8/McmxYmLwdmHjYQFFOZmXCH9eQDuoVDDDy9aEmgTopc6kdK+/yK6qJnphhHNzJxIJtPca+Q2Ltjfh7qg5plKjbu3oAYmlWZdJhvHANuIDrc9LvZE3X1+rAb05gzu0M9iKGlqXxM6rRjPjxfDr8HcVe8BlRmkHYPxMssbWfHRbtKHN4Ix/QCjW4WphCBBFBdKlzliOfXAPGiAB7ts7sbwLYWoUG8E6ZXZ836Xthlwc2RcPaFJpFa6UD9YjDU9w8eZ6dhN6ppu1m5CJXwF49wa9YNaEjOMOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 30 Jun
 2025 01:18:28 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 01:18:28 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "W_Armin@gmx.de" <W_Armin@gmx.de>, "benjamin@benis.se" <benjamin@benis.se>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Thread-Topic: HP Omnibook Ultra Flip 14 - power profiles
Thread-Index: AQHb54aI/x4TucNMjkG3sTXjdCBKkbQa6rUA
Date: Mon, 30 Jun 2025 01:18:28 +0000
Message-ID: <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
	 <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de>
	 <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se>
	 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
	 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
	 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
	 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
	 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
In-Reply-To: <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|IA3PR11MB8986:EE_
x-ms-office365-filtering-correlation-id: fe1467f1-5636-420a-43a3-08ddb77404e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dndmdWZaOXhIQUx2eVVQaEhRYUtJcHZzME9MQzl3MUNkakdXZEZWWU5aZk1U?=
 =?utf-8?B?TC9JMTcreldRTjIwSHVvRWZCNWFLU1J5UmpESzVTZlFsSlh1NVdIdUhwOXVF?=
 =?utf-8?B?YnRsRHUvVXhlQzRYdkducmVSTHVLNzM4Zy9SQkU5cy8rZDZBc0JaMCtCb3FK?=
 =?utf-8?B?MUNWMmhKUFhJVGFNc3djVEh4N2JJaWwrQXVlU01HS0pSSVlDaUxXejBlSHRB?=
 =?utf-8?B?YzF6UEJFbkRBcmtaV1l0bSsvMUlwM2EvM3F0cjVpWHpqeCtmdkNtTDY4WVNT?=
 =?utf-8?B?M2NTRWZuSFRlLzBTTHV4YVVacWsyRGk1blV4M24wOHRjRG1Sbll1aHRzYXpv?=
 =?utf-8?B?R3gvcTNjWFpIYWowOHF4c21CREtMUThVUDllbzVrUUozdUlQZ1hPek91MVdy?=
 =?utf-8?B?N21DanpPU0dZUjBIOWgvbkJNaFRsODlCbVBISnlCSmpEQ08vOVNBTWNWdk9O?=
 =?utf-8?B?Sll4L3N5OU5FNll4TSt6blgzY085MVJ4ZnFrUEpuT3FodFZGUUU3bjRIZXR3?=
 =?utf-8?B?WjRETTJuczhVeWNPL0hIYlEzVXVYRlFNZTdRZm1HbElCc1BYYk9CaWRTRUpO?=
 =?utf-8?B?SHNqSk5sOUV5NWpMNy9MYmJPZVJoT2RMakpVa0dZcXBqR0h5V1E2YTV2REZ3?=
 =?utf-8?B?UU1SWWllY0xPdk43WVBLREhJVGxrRnNnWWdXZ1hIQnRjUVV5NlJsZGZvclV4?=
 =?utf-8?B?YmE0U0hLRzk5aEVZSUVNZHhrZDAycTRQczFqajFOVFV2UFZ6eS90Q1llKzhz?=
 =?utf-8?B?Q244VUVla2NrUXhiVHExdGVZNXp3bk83cTdVWCtjQWMvcjRaWG15UjFtdHlz?=
 =?utf-8?B?UUFoOGp3MEZHVGZKeDJHbWFUU1VjYXAyQmNmUWc0TDB4ajEyOWhJMmVESXFD?=
 =?utf-8?B?UU5vZ1VwaVo4ZzZSbEp4NjN2YzJMR2xQMUt3YUl1NDVOYVhJU1Qydlp1Zk5v?=
 =?utf-8?B?OFBKUkMvU1VPY3NvbmlxTEZaVXVTSWdkc0wwM0RURUJ0eFNINXM2V283dGp2?=
 =?utf-8?B?cDZ2Sk5RRU5xVmNuT0I0cVFUZHRNMHNHdnBDRkhBUEg0eE9Rb0RYS1QrdjZh?=
 =?utf-8?B?VkhiODlUaG9BMXVzUGF1OTlTd2lBb0N3Q0wvWmhJbVBiWVVKSEhINlN1VDBD?=
 =?utf-8?B?ZC85anZINEZZNVlUVWRidnkrMTVkek1XOVdyb2NiaE1Ydjl0VXQ2RVRJNEth?=
 =?utf-8?B?QnF1VXlJRVJ1d3h3UHNGclBsUGp5a3RCZzZ6bmFXZGxWNyt5ZzFRTUlXczFJ?=
 =?utf-8?B?Z3VBVXhodjRYS0JWR2xFdVcyRWZWbk1iczAydHRmTkhYNkFsWHA2VUdJMStO?=
 =?utf-8?B?WFB6SUorOUIzdlNZbUFEM2dTdWd1VzJ4Ukorb2pIN05zWmdjQjEvUlV4RlpE?=
 =?utf-8?B?QmEvaXcxYTEvcHJyYXVlUGlaY1lYRXpFZVNLV1J2NWJvL1RxZGhTZ25ONDJh?=
 =?utf-8?B?amFDbEhGTUlsNTF6bDJNZW10OUpGUk5BZGN1NnhTM1Q2Q1JoMFNvOTJyWVVL?=
 =?utf-8?B?QW95a1d4ejl1MnA0ZVh2MERQOHRkcWFsNnZEM2dORUwwazFMZzY1d1hlcXk3?=
 =?utf-8?B?VHp4UnpxZ1diNTN1cm01UHJwS2ZIM0dtbzlPekIzTk1haDM3Sk1OVTFOUlVM?=
 =?utf-8?B?cnduTzlWTERnZ2IrS2dGMXViME9SNE83dk4vS011a04xWVp2U3o4Yis4V0Ft?=
 =?utf-8?B?MkdaUXZpRUFYKzJTblhtUUI1MU5KNzVjR2ROSldNK2xtcDJNK215ZWt1SC8v?=
 =?utf-8?B?NzdKUUkrZ3U2YUJGazJNRUJzY0U3c3E5UnlpVE1XMU16bEhHUkJyR2wzNnFu?=
 =?utf-8?B?eVRuMTRyTnJPVWI4K1NBYnZld3RVMVFLZ3B2MExUdjdobHEzSFI3Z3JjV0hZ?=
 =?utf-8?B?ZkI0WlM3Ty9yUmJHSjVUOFJ6TkFHeDdxSXF6YXRVRDlLSjVqeTJWUlNEekN3?=
 =?utf-8?B?d0Y1SHRCeGduMUVPWHN5R1I3NkxMNFlReVhmZUxkMlFLSDZ4Ui9SMENDNjNx?=
 =?utf-8?B?WnN3MVJRK2pBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1ZRWmtGbUtlVGFxN3JIUW9Xb0ZQLzlObTM0TFZoYWRMdC9jQit0T0tTWVk0?=
 =?utf-8?B?RzI3allIdmVkMnJYc2E1NERzS2JTM1pGZDJ3NWdpZ0FDT01VOXE4U3dYUGxL?=
 =?utf-8?B?SG84Tk5ycmpDRk9VVXhwMXhYZWVBOTFxamtlajk3QnZIMkIzdHVUY0tWeHNW?=
 =?utf-8?B?cW5QMXk4OFpwL1A3TTlER0FieHp3Ny9SMDg0UFJ2RExmVlE2MVYvcUd2K1Jq?=
 =?utf-8?B?U3NzMWJQVXZnTlZnNklkcnZjbFVXaHJ1MC93WkI3NkZEOWoxRE52bDYvaEFa?=
 =?utf-8?B?RnpEYmlsbWVxQjltSXMzeDVORU4zRmN3SGY3UUVvMDV0TGpQSERLUnpCL0dI?=
 =?utf-8?B?OXB4V3hIQkVkOXpDcXhvc1Y0SHJTRm4rZzN2UUgrSlQ2bm9FN0xpc0hSWWFp?=
 =?utf-8?B?ZUxnT0VDaTV3T29uemkyMklHZFBLeVdpNTBER3JhM2ZVbjFiMkdadk1NSUE0?=
 =?utf-8?B?WkdUR3BheTBqM2g0cXdEUU43aVcyLzlPbkpkUXVvNUVUdk1IZmp4S2tSYVBS?=
 =?utf-8?B?d0ZpRll3b3ZCcWp5OWZpMWQ4SlhCR2tRdERuNHhrbThQM0ZReWdyamx0VFl4?=
 =?utf-8?B?K2IxR2VsaG1TNWIwNEtVMWdqTVJ3dDdodkZwMzR3eEhFUGVXcDFDWWxneCtJ?=
 =?utf-8?B?ZFRxZHFxNEZvbytuaVo2S3BoNUN6MlFzaGFuM3BvMG9naElaaG5KYUlZRk1n?=
 =?utf-8?B?Vm85WU4yMTN5MDVzbnozdXNGaVFhbjNTRjhMVWt1b1RGN0tLbitPdW5FRzZv?=
 =?utf-8?B?dml3K3BhVm80UnF5YWFoTjhKSFhiUzJ0VnEwZUZjMHFFNWJYbzFyUlQvaWJJ?=
 =?utf-8?B?eDBrV3kzZDV0NUtEV0tHOExtc2tlL0E1bWdNbk9Eek5lclRPelk5ekxIV0NY?=
 =?utf-8?B?T2V0a1dONGx4Ukt3ZzkxTTNIb3d6SCtLZTdIa0h0LzF4TjZ4S3pJL3dUanhq?=
 =?utf-8?B?WjZuT0VkSExyVUdQWDVkbkZlR0tLVGZHNXI5aC8rVkpXSWN3WHBGQ2ROVEJ5?=
 =?utf-8?B?NlNLR05qNU43Z0lGTGFJa0pmd1Z3SVE2Q3lsdStjajBVbDN3OUlYUG9yK0Ix?=
 =?utf-8?B?VU0zY0VHOWlmZHlKRlY0a0hQNjdqWUh0TU5MZVlNM0VYeFJYMTVzMGFhcVRv?=
 =?utf-8?B?d2Y2ZG9aalFhdmc1bDI5NkIyVmJEdkxpOTNGaHZJQnhFSmc3ajYwSXdtNWN6?=
 =?utf-8?B?dXZhZXorR0pHQmIwVzkxMlR2b3M5WHo1YXlZYlZOZktnUTl4VWZwdGN1ZlRN?=
 =?utf-8?B?VVhSME1GSjRpR20ybnVvOG5vZVdQcDhYT3p4MXIrRzZlbUJuOUMweFhSR0Q5?=
 =?utf-8?B?MDUvRHBwNzRUeXVOTTREcTI1ZmtZT3RwSXUzWXNDSFpmSW9WRmVCek53dUp0?=
 =?utf-8?B?eTBZZnN0RVhZeXJjaStGOW4xVGRBR1VOWC9rckVWQXAvclhPZldCTXRaanMx?=
 =?utf-8?B?dURkMnhndnBoeEdXZE5vY2ZTS3NDdHQ3dS9yTURpU2JkNVhtU1VUOXVJZmJ6?=
 =?utf-8?B?M2FzVVVyejc1bjh1ZWFaTk5JR3RIMUs0WnFDSEREZnhkMDhYMDRldDVIMkhq?=
 =?utf-8?B?ckx2SXoxNVZPZGhHYjdmQ09LNEVqazdDZ2YyQld1ZlhvUlBWOGVEei9Ccm5s?=
 =?utf-8?B?N1VJZC9hOE9IWTRPT0kxS0FvakkzMVE3ekd2N2FwY0lWUVJnUUErbWZLNmRs?=
 =?utf-8?B?QkRZY0VDY3hqdjMxRVNFcEZzbWVYTXdPWlhvZ3I4U1N6RUhtSVE3a1hTUmdj?=
 =?utf-8?B?T1BEaTB2L0M2M1FnSzRKTmV5bkp5TWpoejVuMFFFM3A5UlV4dHFNdHU5K3ph?=
 =?utf-8?B?bXlHaktxZEZMcnNMcndRNEE0NnFVcTAyRTErY3pnT29XTGhPSjc1SGtDVkdS?=
 =?utf-8?B?a3d1UzZib2lDcm5tWUVCWkdvMFpsTVBXTTZpZ1J2VkJRMktFbmFxYmpyUVUv?=
 =?utf-8?B?Vll5SUVtakdrVzBEcUg0Zk1ESzcyZ0JKbTVsbDc0N0p4TDE2U21MUXE0OElN?=
 =?utf-8?B?bFhSbFRtSW1XSGNtK0h4Vm1qc1liM1JOa3hJamtzdEtiK0hleGFwMnFlc005?=
 =?utf-8?B?VCtxSU9SMHJKcjdXZHNpUldJVkZ0N1FuQnE4WDBaVTlEdk5QZ3hxMzBuQmhw?=
 =?utf-8?B?SUJ1YjVzT3REa1JnbmttZGpJZ01LUWpPYURMMVNuZVBlZ3hmZnhvQ0dUQ0t5?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C939E617A39E3C4AA7F52A239A96B0B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1467f1-5636-420a-43a3-08ddb77404e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 01:18:28.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTY8hMPfzo5D5LKYFeNxv5t83wSUY7OGfvH9OsIIcgY/BasbcVqbcS5Qwqmj+EKwVXftK5j2HVBrDHlUH+TYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8986
X-OriginatorOrg: intel.com

PiA+IFNvIEkgdGVzdGVkIHRoZXJtYWxkIGFnYWluLiBTbyBoZXJlIGFyZSBzb21lIHJlc3VsdHMu
DQo+ID4gDQo+ID4gQmVmb3JlOg0KPiA+IFJ1bm5pbmcgVmFsaGVpbSB0aGUgcG93ZXIgZHJhdyBp
cyAzNXcgYW5kIHRoZSBmcHMgaXMgNDEuDQo+ID4gDQo+ID4gQWZ0ZXIgSSBoYXZlIGluc3RhbGxl
ZCB0aGVybWFsZDoNCj4gPiBSdW5uaW5nIFZhbGhlaW0gdGhlIHBvd2VyIGRyYXcgaXMgNDR3IGFu
ZCB0aGUgZnBzIGlzIDQ2DQo+ID4gDQo+ID4gU28gaXQncyB3b3JraW5nLA0KDQpHb29kIHRvIGtu
b3cgdGhhdCB0aGVybWFsZCBoZWxwcy4NCg0KY2FuIHlvdSBwbGVhc2UgYWxzbyBhdHRhY2ggdGhl
IHR1cmJvc3RhdCBvdXRwdXQ/IHNheSAidHVyYm9zdGF0IC1vIHRzLmxvZw0Kc2xlZXAgMSINCg0K
PiA+ICBidXQgSSBhbHNvIG5vdGljZWQgdGhhdCBpdCBkb2Vzbid0IG1hdHRlciBpZiBJIGNoYW5n
ZSB0aGUgcG93ZXINCj4gPiBwcm9maWxlLiBTYW1lIHBlcmZvcm1hbmNlIGFuZCBwb3dlciBkcmF3
LiBTbyBzb21ldGhpbmcgaXMgc3RpbGwNCj4gPiB3ZWlyZC4NCj4gDQo+IFRoZSBBQ1BJIGNvZGUg
c2VlbXMgdG8gc3VnZ2VzdCB0aGF0IHlvdXIgZGV2aWNlIHN1cHBvcnQgNyBwcm9maWxlcywNCj4g
d2hpbGUgdGhlIGhwLXdtaSBkcml2ZXIgb25seSBzdXBwb3J0cyA0LiBBZGRpdGlvbmFsbHkgdGhl
IGRyaXZlcnMgZmFpbHMNCj4gdG8gcHJvcGVybHkgbWFzayBvdXQgdGhlIHBsYXRmb3JtIHByb2Zp
bGUgdmFsdWUgcmV0dXJuZWQgYnkgdGhlDQo+IGZpcm13YXJlLCBzbyB0aGF0IGNvdWxkIGJlIHRo
ZSByZWFzb24gd2h5IGl0IGlzIG5vdCB3b3JraW5nIG9uIHlvdXINCj4gZGV2aWNlLg0KPiANCj4g
Q2FuIHlvdSB0ZXN0IGtlcm5lbCBwYXRjaGVzPw0KPiANCj4gPiBBbHNvIHRoZSBidWcgd2l0aCB0
aGUgZnVuIHN0aWxsIHJ1bm5pbmcgd2hpbGUgdGhlIGxhcHRvcCBpcyBzdXNwZW5kZWQNCj4gPiBp
cyBhbiBpc3N1ZS4NCj4gDQo+IEkgQ0NlZCB0aGUgcGVvcGxlIGZyb20gdGhlIHRoZXJtYWwgc3Vi
c3lzdGVtLCBtYXliZSB0aGV5IGtub3cgaWYgdGhpcw0KPiBpcyBleHBlY3RlZCBiZWhhdmlvciBv
ciBhIGJ1ZyBpbnNpZGUgdGhlIGludDM0MHhfdGhlcm1hbCBkcml2ZXIuDQo+IA0KaG93IGRvIHlv
dSBzdXNwZW5kIHRoZSBzeXN0ZW0/IGFuZCBjYW4geW91IGF0dGFjaCB0aGUgZG1lc2cgb3V0cHV0
IGFmdGVyDQpzeXN0ZW0gInN1c3BlbmRlZCIgYW5kIHJlc3VtZWQ/DQoNCnRoYW5rcywNCnJ1aQ0K

