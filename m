Return-Path: <linux-pm+bounces-12195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F5951462
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 08:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB94B1C209D4
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD19524D7;
	Wed, 14 Aug 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqF71kdB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB181F94D;
	Wed, 14 Aug 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616307; cv=fail; b=Da+fmNAfQb3XI8dyEQUfXXkoEblOORq7kzYOBeaWSp22f9XbVbT3lGP72fBsQgGCCrzSVTAbgweDERWxcJY7eTcYAtmqBCNZGWp0S+3z9nPNHZGnu6gYXaGmPsZpkwBuZuun9In2jRk3JOIMluIoHKDcllmvdwwOxqKbtrwRfoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616307; c=relaxed/simple;
	bh=WJTsnNbPsKwOZRkRwOy4hpIUlGFVHJBNsUn/qD6oLq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKXxIhB/0wMt5MzBbXVwRfwQFNI88IeBaTEg77X2zkv9DFrd/GzZjq1kMUntan7cy9oOVs+PKh9i+xRE3fdFsw0/AftmPRJoji86WvOwyqjEsgXDassJaFSy3Q4u5fC/duTZnCMrEVuOaDT5ieabDstgXpU0xuRKdpLEVKvJcAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqF71kdB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616305; x=1755152305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WJTsnNbPsKwOZRkRwOy4hpIUlGFVHJBNsUn/qD6oLq0=;
  b=MqF71kdB75nK0Nh26B/PEj8Fdrss2GUsiQ5FyLC6kUv8gvkX7C/nPrgD
   e27QwY4TB0lSMRPOhQXoaccpbFaW4OYbZcm9NL6B8EM1WJTNiJjdpkY2D
   u3fizfVv6ak9rl+GUIowYGtpZd3bzFrVUKIEsc+v9VuvGwKb87f1w9RbH
   G91Pt31VJQms+5wcm8slWLXmPYdk9FsCPfbJKYb7gYntKU+ysz05HJ2XR
   fSVFI4C99o2ncpaR+lCVv7w8/yktjBWOivaFba0FUc6MIX/CHkGlXnlYp
   obXIpFCRpButoMFTgiB7tMTHuuYi3wBkjOWPfcSR1plX3Z1+F9HTihUsq
   w==;
X-CSE-ConnectionGUID: iLkPJdmVR3mxWsbrLS4tCQ==
X-CSE-MsgGUID: LHijhEAITl2HO0fgwf50ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32387398"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="32387398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:18:24 -0700
X-CSE-ConnectionGUID: 9/BstnOdRgaclPajjB91CA==
X-CSE-MsgGUID: IZ8jrnKVRZKjacn0OnxEPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63842450"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 23:18:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 23:18:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 23:18:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 23:18:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 23:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c65J7n6pE60CpPueb+UZAeD1pKuYUUwGu25MIcLyLTbtBaqCKKbnxJuAX64SaGXLA0d2BSdpf0xuyACYX8v65aD/ID2CdC6N6cCMzITS3AAWNj2tKTnIK10LFiwoeOgW6qyC0y3UvC3BG1f6enmMUXwit4qgfbccMsYLyBo41si55/kwAcLnaPRnOrD9LOIq1AMIqxIeg3oKfLNp6fLhRf8QR8vJkWm0i/kpV+SxKnQJDfWFff47U1aTdW2w6ucpq44y21XbjiHnue3B3qkMB8vxdXKA3D/ez+gKhOr2p4XwHpqattXunBffH2+oowmPhs4oRjyVbfXfhP9N9JoxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJTsnNbPsKwOZRkRwOy4hpIUlGFVHJBNsUn/qD6oLq0=;
 b=n8qz0oZgqjo0ft8yMr3O5blgn0eExwpfIwVjSQTpsgFRHpKm4MlbnTY+d04XLFmDHpN9+H5cnum5kRyfD0mkt0mZF5VgY5H7FKyjckPknNhpz10KEvQ6kae47+z2/3SxXmbJ19lpj04EVnOjRHF8LNf/6qAOdmt3S7CsCd17ePI7E+viFPU28Ozp9VsOUSR3p1erqSP72GD4udjlHHaJUfllWybn7DD/6+2u3B8v9jtiEm0Xs2L4oHPOdQBj9DIzPquqMwmYE8/sWKqtE+Pjngpw8bLlpUFDvYgW0VdQplqqFz3W6H7NIUkefdh4mi8edp3EIDRswwCdPwAEbRuNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 14 Aug
 2024 06:18:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 06:18:20 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net"
	<peter@piie.net>
Subject: Re: [PATCH v1 1/4] thermal: gov_bang_bang: Call
 __thermal_cdev_update() directly
Thread-Topic: [PATCH v1 1/4] thermal: gov_bang_bang: Call
 __thermal_cdev_update() directly
Thread-Index: AQHa7Y5F+xqDs8VhGUyX2qEbC7cmALImSGcA
Date: Wed, 14 Aug 2024 06:18:20 +0000
Message-ID: <28c4f62c7f4ae2a94c2bb36e82f9827332b8205f.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <13583081.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13583081.uLZWGnKmhe@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: 1ffe286b-0fe9-4fa3-4fb9-08dcbc28e51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: fncKTvt8YwD3F7lHyQdJzN1ZKDdyLq5E7XmhpZD34oOrH9n8OwkY3Y5rzyKS3Rm39FukInLGYDKWfnUtsNdO/QOCaZmorwXUggWgrYUgrdNasAARBbFXbtzI2TgQCMFr8okh/Ok6gqDnRsfFR6FzqplXBqNOMoN+1+P5FJC4CdinX220oa9am2zzUdUFiJ0r2On9Vb2LyIYj/TuwwkMBktVtRB0PTCsoPFO+mOvhL+SYhPmWW9RZN3YYwXpgonKQTH1vn1aaHmPximVyE7Vx6F1THlUZWXqS4tVeinc0YD6KRlnBMmdb+KS4AczGLZp/MYZTpSB/Z0y14S8P8jrAzT9P9KiYFa0t8htD73iVL7PXwrAQNGj78KzVJVFHOICTxGeQqYDdHTNbR2PX3Lwfgl8F72QHcTCsoFYCQjBLfSGO0wDcqKjs7TrrPl7MbEsDikw5wPguQoZVvmaMpRuoTqVzbAi0686VejQr9XGGKP/0+tlAe8TI0QUsdv9QXKU09n5sv2pr4Yfa0nqPpscvA2cTaS5aKMJ0cmwJBWcKoc3xnXDC/ZyXNmYdZ4iOKkt7oUD+pGW83fAk5abLly4k6b1eVElxTaiIR1xkG3icbNjFyZ7hj/9a3JIcFcLsEzRPHBpcYvZ4vwIObDmrVlOduL0cMZQzDF3FxfJFldxxzHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RMU2oyYVhCZEdIdkVMa2ZQbTVyS3ovOUliMmdKQTZyNWl6V0FzNEttNVAx?=
 =?utf-8?B?NWZ1QXVIcktDK01mUlhpejFmQ3hJR3Y0U09RWUZkWWNSSnRLOFF0QjlDZmFn?=
 =?utf-8?B?QzJxSEJ5U2hKVGhHRDlmZFhMSVNRMUFCOVBTV0NCYmZ0ajh2WnZhOUd3R3Y2?=
 =?utf-8?B?SFdKa0RoelJtcWZKMy9lNVhLNXRQcjFPUGY1S1FFbC9sRWxpaENjWGNCZUYv?=
 =?utf-8?B?VWcvY0NiSm95clFBa1BFMGphdnRBaFp0RGZNeEJreXpRQnpKUWtzbzZKTEpW?=
 =?utf-8?B?N09za05ibzVETnhadmx3UFk5dVgxSXlVMGk1amJxK3cwSWdiWnhreVg4SDFH?=
 =?utf-8?B?ZUlTNVl0YzBwNEY0YVJrTFBIWXFodnFOdmtpZDNSOU5mRHpQVXhXRXRodnU0?=
 =?utf-8?B?Z1Yyc3Bvd1hqRnlpWTljSEhLUFJ6MnpJWWJTTXJCaTFVdlo4U1V3akRXN2lM?=
 =?utf-8?B?cGFVWXFzQXYvaGcyNDVVa2FhTXNWa0FLNWpTOVBKT2pnekVRcmJNMmh5ZVRD?=
 =?utf-8?B?SDVramxucS8zUXZ0OSt4WSthT1dvMWI2WWg5cnRUVmU4UC9xQ3BFeXVlTk5P?=
 =?utf-8?B?YWc3SnJCQkhyWFZrZXZaOTZIWm9GZzJHcHlnUE9EQ01Pa3FMVzR5Q0VHODVE?=
 =?utf-8?B?MzliTHV5TUJacWpUK0Z3THpRZWUyUUN3Zm9uTWNHYlpMcG0xTjZodnlZR0Z5?=
 =?utf-8?B?Y3NjMkRkbVl2L1FwNVQxWi9rRFJmYTFFNnF3NmVnaDAwQkFtZnEvWWJnZ3FD?=
 =?utf-8?B?NmREOWIyZkIremZPeXUvK1lveUE2cHNnSnVCMjdRam1GQm5rbHFsM3Fmc2Q3?=
 =?utf-8?B?NnVJV0x4S05Jdlk2NDk4eEthQlArbEI5WE41bmNHcktJS3dHaDlmeTFEQlgy?=
 =?utf-8?B?TkxNMFNVdXhtazROT1pTdGdmZDVaYjFYK3FVWDRDZFVmeGt5Z1kxSjBBbVdB?=
 =?utf-8?B?RGV5VlJrVXBnNUFsMkZ5VXkvVEFQNEZwR21oZDN1VWNSQzZibU1xQmNqdC9C?=
 =?utf-8?B?K29vTWNlVG00a1lBeG5PTGxvdWNRSndQL3J4SVBiL2lsWWRLNVJqanltdGZz?=
 =?utf-8?B?MWhLYnorbWlZZm9tcDNQK1FLN2pwQmU0cUhFdTJ0RzhqdjRRd1lHZTBlcE5H?=
 =?utf-8?B?UjJicDBLZEk4b1RsRXBWc3p2S0lLZjZVVGEzaktpdU5jWDJUQzZrZUVxRTBW?=
 =?utf-8?B?ZFB0ZmNqR1dJSm50YUkvTS9qRUY5a3RvZU5yWjFPL2lGdFZWV01Ib0VkSkJJ?=
 =?utf-8?B?UGZFbWF1eVM5OGZQZmQrVUIxVFhGa3VBTnNaMm5BejcyRE05OVhuL2Z1c3Nx?=
 =?utf-8?B?a0JuaElRcG5GN1RZNG1XV25WRUM1dFppZmV6c1I3ejhoazhOVVViRTRMRVFy?=
 =?utf-8?B?dFo2R3lUOStVTlNQZ01wbnU4ZjlSSGd1d0JaZ2xkWXVvSUFOejVLRytwbzBT?=
 =?utf-8?B?QUNYbHl6N3pXNHJQM3hDVnVBN3V6NXpUUERYK1I2NVBEUGM2Y1ArNy9NMnZB?=
 =?utf-8?B?dHpPYTRFQllsNmRDWGU3MTZZa0hIOEhjUS91ZXlRd1I4RjVsMzF5ZS9QTzVm?=
 =?utf-8?B?ZW1uSUZ3RFBsdlg3amxMMlpmSzhsejNmbFhyaDEvcEJYVHl5aEh0dStmOUpj?=
 =?utf-8?B?aDN3M2prTFdwSGcxR1B1V3F3dkhlVm5EcEMvcERxbmNMcXNIa1lSU1FsN2tZ?=
 =?utf-8?B?QzdrTldXNStnTVpZVnNNTlZkcE9oYVkyeVVKVE50VmYyU2pyck5FbTBwQ21D?=
 =?utf-8?B?allFS2l0YkZNWFA1RExabUN4MWdzN2RTWlFtVFBaUkoveFhMVitBTlpDYVlh?=
 =?utf-8?B?Q3hMa3RHSGVpSFZURDNSbE1BbmloamlIRTZCNU1zYjBaTTRyZ1Y1UHNBZ2dS?=
 =?utf-8?B?N3lYZTU1USsyd2JzaHZFWExOOE04UStPb1VGbXE4cFhKZ2FrTjRHNkF0SHdG?=
 =?utf-8?B?UHZSWXptb25aTDJxQmR2V241REZXRVJBbjk1bWs1NUpUNUo0ejdJeDB4ckts?=
 =?utf-8?B?SFF3cnJCOTdEdXplY0JUb3lMVHRJaTBmWHVEWTB4RFpxclRuZUsvOGNXQXc4?=
 =?utf-8?B?OFpkTExJSFIweHp2ZmpBRkpyNytLMFhOR1JUcVR1WWNxbFNxTjVOLzNTdGhM?=
 =?utf-8?B?V3RvWGFSa2FSZWIxRW85RjU4SzY1Tkdjc3ZjYmJvdFRHSmkxV2VzZi9EdExO?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C75BEEAE44D1234A9798FB60C12C318D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe286b-0fe9-4fa3-4fb9-08dcbc28e51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:18:20.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aut7RAt59f3Bz6Q6VEkGpzthqw0jA7DHlBl+b6OVE/KGsKitRGkKhotcW7+C3bj+72p7IUr8VL9oscnWYKSrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSW5zdGVhZCBvZiBjbGVhcmluZyB0aGUgInVwZGF0ZWQiIGZsYWcgZm9yIGVhY2gg
Y29vbGluZyBkZXZpY2UNCj4gYWZmZWN0ZWQgYnkgdGhlIHRyaXAgcG9pbnQgY3Jvc3NpbmcgaW4g
YmFuZ19iYW5nX2NvbnRyb2woKSBhbmQNCj4gd2Fsa2luZyBhbGwgdGhlcm1hbCBpbnN0YW5jZXMg
dG8gcnVuIHRoZXJtYWxfY2Rldl91cGRhdGUoKSBmb3IgYWxsDQo+IG9mIHRoZSBhZmZlY3RlZCBj
b29saW5nIGRldmljZXMsIGNhbGwgX190aGVybWFsX2NkZXZfdXBkYXRlKCkNCj4gZGlyZWN0bHkg
Zm9yIGVhY2ggb2YgdGhlbS4NCg0Kd2l0aCB0aGlzIGNoYW5nZSwgd2UgbWF5IGludm9rZSB0aGVy
bWFsX2NkZXZfc2V0X2N1cl9zdGF0ZSgpIGZvcg0KbXVsdGlwbGUgdGltZXMgaW5zdGVhZCBvZiBv
bmUsIGluIG9uZSBiYW5nX2JhbmdfY29udHJvbCgpIHJ1bi4NCg0KU28gdGhpcyBlZmZlY3RpdmVs
eSBjaGFuZ2VzIHRoZSBub3RpZmljYXRpb25zIGFuZCBzdGF0aXN0aWNzLg0KDQpJZiB0aGlzIGlz
IG5vdCBhIHByb2JsZW0sIG1heWJlIGJldHRlciB0byBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRo
ZQ0KY2hhbmdlbG9nPw0KDQp0aGFua3MsDQpydWkNCj4gDQo+IE5vIGludGVudGlvbmFsIGZ1bmN0
aW9uYWwgaW1wYWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3RoZXJtYWwvZ292
X2JhbmdfYmFuZy5jIHzCoMKgwqAgNSArLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3Ro
ZXJtYWwvZ292X2JhbmdfYmFuZy5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcv
ZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy90
aGVybWFsL2dvdl9iYW5nX2JhbmcuYw0KPiBAQCAtNzEsMTIgKzcxLDkgQEAgc3RhdGljIHZvaWQg
YmFuZ19iYW5nX2NvbnRyb2woc3RydWN0IHRoZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRldl9kYmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJnZXQ9JWxkXG4iLA0K
PiBpbnN0YW5jZS0+dGFyZ2V0KTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBtdXRleF9sb2NrKCZpbnN0YW5jZS0+Y2Rldi0+bG9jayk7DQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpbnN0YW5jZS0+Y2Rldi0+dXBkYXRlZCA9IGZhbHNlOyAvKiBjZGV2
IG5lZWRzIHVwZGF0ZQ0KPiAqLw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX190
aGVybWFsX2NkZXZfdXBkYXRlKGluc3RhbmNlLT5jZGV2KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmluc3RhbmNlLT5jZGV2LT5sb2NrKTsNCj4gwqDC
oMKgwqDCoMKgwqDCoH0NCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5
KGluc3RhbmNlLCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLA0KPiB0el9ub2RlKQ0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF9jZGV2X3VwZGF0ZShpbnN0YW5jZS0+Y2Rl
dik7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBzdHJ1Y3QgdGhlcm1hbF9nb3Zlcm5vciB0aGVy
bWFsX2dvdl9iYW5nX2JhbmcgPSB7DQo+IA0KPiANCj4gDQoNCg==

