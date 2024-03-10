Return-Path: <linux-pm+bounces-4812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550C8776F4
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BBB1C20934
	for <lists+linux-pm@lfdr.de>; Sun, 10 Mar 2024 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48E2628C;
	Sun, 10 Mar 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iyla9WTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582A25747
	for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076572; cv=fail; b=fEjqg80MM41ST3wk9cszeUOnM2p+7o86B888H1BbBf5MkuIPT7/e7OBI1OSlKrfX9AbStDgWrvoCg//qNI6Df9sXHowjZ8C0z8qdEY2Y/qEtzKPNVbfrtITAQFfnDVhE41n+2mhm0lJxjpfRAfTLnm/xCKG7Wgr3N3i+HmK8aPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076572; c=relaxed/simple;
	bh=7YUhZSWc7Z5SdSZb0ReXNp8a98Nt7CiArjz5BxKBDj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfiRyB00fX5u1eOq4mH1rZVOiD87DHWmBl7uAGRrXkNVab5zB18JAwBORH2lNikmSqq+Tcpt4X9OtXvHlx1DY7joCbal65HM/9z0GHKQdsioj/dPfeyT8EEubajfnlQxGRXO95PsBAc8E5gJ9m6yX8PpM3oS5XVJZCgDwzBsb4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iyla9WTf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710076570; x=1741612570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7YUhZSWc7Z5SdSZb0ReXNp8a98Nt7CiArjz5BxKBDj0=;
  b=Iyla9WTfkWgDUWzYtzNBIlawKXjcw/LZq/abUPBsPVSINmcLZWxGZa5z
   S2xRLv6s4AM1YrPai13cNvj+LrmqSLmnhMKTxTpaE+9nLOhlaqvh/4HgG
   jzutFwXdvHYjgynbRDrCdei1RSz9rQiZBHHk9J7M8x/0u9Va0ZZOZ3l1b
   QxdOXgw7wkhWJjrlnm8ltUhlXVvF3xS6UoslreOyEFssESxxE6lTB9ocg
   4oxBBsyee/lPij3aise9pKvPx+nrYXJwbe0gjWqo0kOznkuKoG0oNw9Ne
   A83/SP9hNw5S/jCg6VA3JlLieirI2JrlR57/yDGrD2M6CT/f7gZrwl4dA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="15308785"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="15308785"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 06:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="15502195"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2024 06:16:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Mar 2024 06:16:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Mar 2024 06:16:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Mar 2024 06:16:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfJlp/0ugDXtBsv024MEbtczzhplf8IVIYiq8RWg974aJhTqqAObc9GkoUVA9k25rb7gKBPKGxkqPnskrY6GtGu3MvnJCGqQIHlEesoirVkuRH80rwtNErNjpKi6F6XBdRCagSwKcp0k6G4dTscniN7CBKZerKukla/W5kCA4llAAWBAV6G9CdJNjv/hDFZ44uAg5sXdSJTsBcdQgNFj3nFMZLNjUf1SrPjzFZExUwIqTi+IQkH4O1M7RjXcds2afsonIkwIAVud+wFntHHywHrt2+TVhruOPupzFyOhYPiuatBpiVpITHMKcyj+LZ/QWoLSMhSayQdCg1CptVXxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YUhZSWc7Z5SdSZb0ReXNp8a98Nt7CiArjz5BxKBDj0=;
 b=mQ2TEQqc3Y043L289mS3s7tHplEpeWoukr7HFnk9BP77F4pPeyAAJn5Ck4zAzRnMVc0zfTFfN3B9khqC96G/17h3TpctOjKICp5eF4K/sjAmI6WPv5YSSmxF13Ua10a8V1TWqbxl/VAvai4h2OETVUrFwxD1aIWZoouQUyIAHQZc7i28XjTSos+zjfOVGuRo9ksfH5KjIaejMOJxapu8h74gqqbsXSasGjLoahtjF49QnJBPvwieqMZgjWZyTUdRcl2baCN5iTXSYgLb1KFxz2t5wsRh1APF7TPrNV2gKrGbAeVvw354EwK4ab65r5cvhxE5VZb6NX/YicVPtiICKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Sun, 10 Mar
 2024 13:16:03 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7386.014; Sun, 10 Mar 2024
 13:16:03 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] powercap: intel_rapl: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH] powercap: intel_rapl: Convert to platform remove
 callback returning void
Thread-Index: AQHacTXshuAX1UPm40e+mBpRuDnV/bEw98WA
Date: Sun, 10 Mar 2024 13:16:03 +0000
Message-ID: <82b55fc7b94fe96e41e3b907a72c85523f15e745.camel@intel.com>
References: <98afe4627bcfbddedfa36fb5631bb47913f5fa94.1709886922.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <98afe4627bcfbddedfa36fb5631bb47913f5fa94.1709886922.git.u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO1PR11MB5107:EE_
x-ms-office365-filtering-correlation-id: 1c614da8-03a3-4ac7-6d64-08dc41043cad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DttNx+SxDkMeumlmQUieGPlDYBNl7GhAHnnMEBqZOHAOzrOUpObjlhh7kbZmE8TsZldd4ctq5YUpzDRgmBXbcMpmuGeJXiji1gSBshSBimRtIBqFrS6PnxAD9SlGOXsjlCGLoqJQjUcJmN8MHitawuIFZ3OyJ8VDX8mFZHRmfalDm7DqY5Iz78w1HxBND+NzIw/YexUukHB2zUOAHc1K6D3qovhcfpqTNK2Ptu443QC3ehUNc7Cge/qwV7ZVfcXVvrU99Bkhmtv0DOGkXBMaYqDp1X8rENqDkOR7Ki4IIGBrOUE/oAofjnjTQeNuUBWaD6SjZt9m+kgPbkYO2zTZToDWZnBkgfosTd5Q0fYNNAs+sa85VMXNmrLTNH6Tal/ed//oNasVHr1Dr+xlASFvv+p07MrU7xvlRBsIzxu16pZ7YuOgju6bsiC3CBfDxOyhSdCEHopyJkBN3IQaQhdY8iwHLrfT4z5REJMfOxFV7mHCcKL2wiU1XvtYBSIcYMBBPAhLPME9MelDj04DbUpRa91dfZwHyX8z2b44fZ126mrlkEtW4ruIDJMEhqfaWw4uMuVjj5HBvbE2xrXaD2RGC5GAVvG+5WjIz0NZFz6u4Gd40l1g8pTOJqD4fFsjiU42A1Hy0sFL7znrdjrra2jqpczTNYUPx8WK91qNz7dmySlvkURP2NpJiR3VgoD746oBKxiNVomL5wzfdrNqLkTclcb3L+TsYNl9IWMMJuca2HE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2xlUEtZRHpFSTBCNWI4VEFiMmduSHlyQy9KQmtXOUk3bnZCVHRXWE9xY1I5?=
 =?utf-8?B?M2IzLytsS3Q1NnIrVDgzUmtXbTlnS2crOEJEWk5iQ09JcENNMmMvN3pLdFV0?=
 =?utf-8?B?Vk5rVkliWER3QVZydkVxeEQ5Z3I1aVhqcUNnNndFWi9MSzN0bit6NG9OdGoy?=
 =?utf-8?B?ay9INnIxdHdVN2xibDFNb1BkeG1kZ3M0cVFTUTFsVWZlZE9wZThzUHhLRE1h?=
 =?utf-8?B?dDIyeXFrZFNQUCthU3NFR3lxdFRTNUk0ZG8rU0JKOXV5cjVMS0VlZWx5c0NY?=
 =?utf-8?B?RmN5VitWelhIRkRTeC82ODJSTnUyWmMwaXZNQU5mdE5XVnZnV2lEUTJ6NnJo?=
 =?utf-8?B?TVZkUFVFTHdIWFA1VWloWk4zREU1SXo0eE9IeERKTC9TeWFYVFJ3ZVlsM2I5?=
 =?utf-8?B?V2VPZGJqRVdYRGk2Z0lCNWtDS1pUNEVVbDA4ajR2Z1VYZmR3TGw4UWRqR0RB?=
 =?utf-8?B?c2c3eXQ2Q0V4cUYrUmFob3FSbFV4Q1hsdjVlNWttdWJQN0hTVExyMmZ6N2U3?=
 =?utf-8?B?NklxMDJhNlo2TkYwZEpsT2ZQSGU3N0lXUHlkWi9mVmxXUzJ0dlREa1VEbHY3?=
 =?utf-8?B?aFR4QTF3L21Wc3I1VUNxaUpuczRkdzVrT0hPcUo3YzJsQlRWMnlmaHlQTHdJ?=
 =?utf-8?B?VDFBVkE2V0xINUM3QW01aEZ2Q0kxRU90THpKSFdlOWo3V0lERndMYWx3Rmtk?=
 =?utf-8?B?dXZySVNTb3VyYnlzc3pKY1FFMlRYZHFzZ1JYdVZSWVhQWUtkU0hDSTlMcGZY?=
 =?utf-8?B?dSs1anNhbWVpVjBQYXoxZGF5Q2NMZUVQWjZsU1RoMGFzaWd5ZUE0bXVlQTY1?=
 =?utf-8?B?QjdJUjlDTjZGTlRUSWF4STYxTzlHRW1FQ2J4dTZ3cEp2c01idHJldmVTcDFp?=
 =?utf-8?B?VW5lemJmQmNkWTBkbzZXelVrczdKS3liSFo1dDBXc0d5OGVCdEdVOGtHbXR6?=
 =?utf-8?B?OEsvNFNJWjFyWEgxYTEzYlN0WU9zVi9FSGt4Y2lxVjhhbHJpTmVmdkloQldz?=
 =?utf-8?B?QTZpL0FXaFBoWG5JcldCMm9uVE1vaEo2Qkx6T0pQUHNxVXlYbXZxR25pRjBp?=
 =?utf-8?B?bkg3endCOVViOUJEbCsxa25Ga2ZZV0lBeTQ0RVJlams1enRVcVFad1RLM2xq?=
 =?utf-8?B?M2wreWZ4Rm5BeEErY1NRalNDTmhEY2dCRVB4QlpoTXhtUkQ2MGx2cUtwUWNq?=
 =?utf-8?B?OVAvVEU2TDUxd2JSL0hUdHk5TTFrYmpIb2V4MEcvamFybXpSd2tyRmErTHJh?=
 =?utf-8?B?NnpZYzBhcVJwWjlrOThTRVRJRkQxVzVlL2N6Vmx4K2xiTlZKNTFLc1FrSk03?=
 =?utf-8?B?RTNacEZyZm5peEZrNUtBUjhWK2piY2kva2g1Sy9MbFNGU3RXQkVDc3QrWVl4?=
 =?utf-8?B?UnRUb0wycEg4aUNKRWFuc2tlSWNRN1lrUis4bmFraDVtV1JmR2VDR0FRRld6?=
 =?utf-8?B?cjJhMGpzcHdYN1pQV09tMS92QWZRQUpYUmNzTHdHU0NDUmJYc1ROcW11ZlN6?=
 =?utf-8?B?R1pjcW9NbU8yNFNqUGttcG5PQkNRK0kvS1c0bWdnT05nSndKcjd1WEFtU0Ez?=
 =?utf-8?B?ZDlNN3pDUVVpWDB5NUF4Zm5FeCs2RUJBSnFReUh2bTBsS2VvYktNbEtIc2RP?=
 =?utf-8?B?UGppUFpHOG1IRUZ4THRoanY5MkozS1h6RXJVMXp3SWI1NVhwcVMrUStOWlo4?=
 =?utf-8?B?RGpZZk5Va1dYSy96YUFiODFSU2k3dWhpM2ZIZStjNXlUTGc3bU9vaVhQTzBq?=
 =?utf-8?B?YU5OL0RTcExzMHlJZ1VLanhUZkxTYWt1RU9QemdqcmdwUm03eGZNQ0F1S3NP?=
 =?utf-8?B?ak1GYkN6Q2lnVnhoZXpDK0RYYzhPamVNeExUN0JYOHdGZ1FxTktETXFUTjlp?=
 =?utf-8?B?RjlHeTYvWnNDU0ZVekh0Y0FKMGpibFdMaTZpdFVBME90TVJmQjJ2VG5qbEhZ?=
 =?utf-8?B?YUJyMU1mUXNjcU1GZ0Q2V0M4Ly81WWZ2NXludUY2cmNWcG56N3RFVlFLa1ZW?=
 =?utf-8?B?bUVFN0REWUpnZ2FsUDBYUW41Zk9WbUdRanRtQUVDK29XOTh1Yi9hWll0SzF0?=
 =?utf-8?B?dDFkeVpJZ1VhVnB0eHhCMFhYanFSc2FDUUFSUEc4NDFGbGxpOHI4Q0FnWTZ6?=
 =?utf-8?Q?hClf/02poG7pdcGjvbv9rTnq5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D8AF8B651A5C242BEA064B5BF113CA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c614da8-03a3-4ac7-6d64-08dc41043cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2024 13:16:03.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpVu5jPWILEVW9b1sI0jh9hy0G5hSydikfbu+lTSFIwQH19RqCVJSRKXfCgvlJkEzS6cNABt+xLlDCXJrlrTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTA4IGF0IDA5OjUxICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBmb3IgYSBwbGF0Zm9ybSBkcml2ZXIgcmV0dXJu
cyBhbiBpbnQgd2hpY2gNCj4gbWFrZXMNCj4gbWFueSBkcml2ZXIgYXV0aG9ycyB3cm9uZ2x5IGFz
c3VtZSBpdCdzIHBvc3NpYmxlIHRvIGRvIGVycm9yIGhhbmRsaW5nDQo+IGJ5DQo+IHJldHVybmlu
ZyBhbiBlcnJvciBjb2RlLiBIb3dldmVyIHRoZSB2YWx1ZSByZXR1cm5lZCBpcyBpZ25vcmVkIChh
cGFydA0KPiBmcm9tIGVtaXR0aW5nIGEgd2FybmluZykgYW5kIHRoaXMgdHlwaWNhbGx5IHJlc3Vs
dHMgaW4gcmVzb3VyY2UNCj4gbGVha3MuDQo+IA0KPiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUgaXMg
YSBxdWVzdCB0byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuDQo+IHZvaWQuIEluIHRo
ZSBmaXJzdCBzdGVwIG9mIHRoaXMgcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0bw0K
PiAucmVtb3ZlX25ldygpLCB3aGljaCBhbHJlYWR5IHJldHVybnMgdm9pZC4gRXZlbnR1YWxseSBh
ZnRlciBhbGwNCj4gZHJpdmVycw0KPiBhcmUgY29udmVydGVkLCAucmVtb3ZlX25ldygpIHdpbGwg
YmUgcmVuYW1lZCB0byAucmVtb3ZlKCkuDQo+IA0KPiBUcml2aWFsbHkgY29udmVydCB0aGlzIGRy
aXZlciBmcm9tIGFsd2F5cyByZXR1cm5pbmcgemVybyBpbiB0aGUNCj4gcmVtb3ZlDQo+IGNhbGxi
YWNrIHRvIHRoZSB2b2lkIHJldHVybmluZyB2YXJpYW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0t
DQo+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX21zci5jIHwgNSArKy0tLQ0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX21zci5jDQo+IGIvZHJpdmVycy9w
b3dlcmNhcC9pbnRlbF9yYXBsX21zci5jDQo+IGluZGV4IGI0YjY5MzBjYWNiMC4uMzVjYjE1MmZh
OWFhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfbXNyLmMNCj4g
KysrIGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX21zci5jDQo+IEBAIC0xOTcsMTEgKzE5
NywxMCBAQCBzdGF0aWMgaW50IHJhcGxfbXNyX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPiDCoH0NCj4gwqANCj4g
LXN0YXRpYyBpbnQgcmFwbF9tc3JfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICtzdGF0aWMgdm9pZCByYXBsX21zcl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBjcHVocF9yZW1vdmVfc3RhdGUocmFwbF9t
c3JfcHJpdi0+cGNhcF9yYXBsX29ubGluZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBwb3dlcmNhcF91
bnJlZ2lzdGVyX2NvbnRyb2xfdHlwZShyYXBsX21zcl9wcml2LQ0KPiA+Y29udHJvbF90eXBlKTsN
Cj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHJhcGxfbXNyX2lkc1tdID0gew0KPiBAQCAtMjEy
LDcgKzIxMSw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGxhdGZvcm0sIHJhcGxfbXNyX2lkcyk7
DQo+IMKgDQo+IMKgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW50ZWxfcmFwbF9tc3Jf
ZHJpdmVyID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgLnByb2JlID0gcmFwbF9tc3JfcHJvYmUsDQo+
IC3CoMKgwqDCoMKgwqDCoC5yZW1vdmUgPSByYXBsX21zcl9yZW1vdmUsDQo+ICvCoMKgwqDCoMKg
wqDCoC5yZW1vdmVfbmV3ID0gcmFwbF9tc3JfcmVtb3ZlLA0KPiDCoMKgwqDCoMKgwqDCoMKgLmlk
X3RhYmxlID0gcmFwbF9tc3JfaWRzLA0KPiDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlciA9IHsNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJpbnRlbF9yYXBsX21zciIs
DQo+IA0KPiBiYXNlLWNvbW1pdDogOGZmYzhiMWJiZDUwNWUyN2UyYzg0MzlkMzI2YjYwNTljOTA2
YzlkZA0KDQpUaGlzICJiYXNlLWNvbW1pdCIgaXMgbm90IGFuIHVwc3RyZWFtIGNvbW1pdCwgd2hp
Y2ggbWFrZXMgaXQgbW9yZQ0KY29uZnVzaW5nLg0KDQpTZWVtcyB0aGF0IHRoZSBiYXNlIHN1cHBv
cnQgaXMgYWRkZWQgYnkgY29tbWl0IDVjNWE3NjgwZTY3YiAoInBsYXRmb3JtOg0KUHJvdmlkZSBh
IHJlbW92ZSBjYWxsYmFjayB0aGF0IHJldHVybnMgbm8gdmFsdWUiKS4gSU1PLCBpdCB3b3VsZCBi
ZQ0KYmV0dGVyIHRvIHJlZmVyIHRoYXQgaW4gdGhlIGNoYW5nZWxvZy4gQnV0IGFueXdheSwgdGhl
IHBhdGNoIExHVE0uDQoNClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5j
b20+DQoNCnRoYW5rcywNCnJ1aQ0KDQo=

