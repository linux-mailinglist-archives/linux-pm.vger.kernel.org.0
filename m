Return-Path: <linux-pm+bounces-12331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462B95447C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3069B1C211D1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B615137903;
	Fri, 16 Aug 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCGEmN+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645212E1CA;
	Fri, 16 Aug 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797238; cv=fail; b=EAsVTqVaao8uITB3nQS/uINWcqyCmMSh4YeGdKdfZ6DAf0ticr+CW04AM4wqZUuuXEC+JzCI3oM2usrgbdBUGpalRDVKFij4eaEnR1K/whdjNgopCohVuDLtQm7ynVuNyEyhPOhwMXaHTwYppr/poV+oeoV3Jc+GMnjl1IIzOYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797238; c=relaxed/simple;
	bh=68zsPaHEbNTJpk+CvS3OE3x1UE9RoveHRwXjduYYHX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCwmmy/AeMrU3UVEvK8MZ8nT8ybs3t93Y/AOoBV9rheE1l7aCah427Jouxonneuqc/c4goRQm4AtYqwTYjHyEuo+mbIkbRlKuu8GZSQfP7TrliZA4B1n2zIxk5023VnRWASxkNztrwffVT8SdDHRlYhwAusZcRwrD+O/48V+5k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCGEmN+D; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723797232; x=1755333232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=68zsPaHEbNTJpk+CvS3OE3x1UE9RoveHRwXjduYYHX8=;
  b=fCGEmN+DWDJXS3ME2aa9ktRn+geIqnniDYbc5EjdO89T2m+LNAO+q1sa
   M89fRTbJQlOLHeM21ArDIIR78luVMIodaFiiIJL+KhZh9eE63rci9MFkD
   exkVpLx2jQAI/n/0o8A1FtdfAAoKCkXF1jPXHwUcB9g7J1m2TIa+emv+w
   1D2HzQgTFhqO6Hf3r9YgTqc/S+kLZyDqxfqH7AwCHG/Qo3s33fb5w1E/B
   I/z+v+DZW+DvoSIsieWmpakm3wO8NKXyijM9vur31GCwKkoHFfNHiqgOw
   JHBvTWBgHEX0BZ3Fb9JtEwxtGx1jpP0/w8pBgaTxpqysUYI2RUFnT4PHM
   g==;
X-CSE-ConnectionGUID: cV6Ht+rmTUCBFm6VFcqXIQ==
X-CSE-MsgGUID: mTXwhxYqQZ+/JSdfGoqtTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21964999"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="21964999"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 01:33:50 -0700
X-CSE-ConnectionGUID: XCLeey/VQimB7hTSk85ddQ==
X-CSE-MsgGUID: bvDtLxzkRt2pK/RsadsGYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59570707"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 01:33:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:33:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 01:33:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 01:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alvcp52jbYVxy+QhSOK+xIr16umtEF83lW+pjRJqO2LgsWepSpi3zM9IO3BF4KA5aGkwQlM1vCr5ZwjzlsPL5AXZl8nD8DciKgeXr2vsT6gCMMjO108j2KGaB6r6w0+aK/DaknV+l3AfWVRLUSG0G1CJA7wtVAPl87AmjQIl4uzWaJPr7iLclJp45Ks8WwF8v04IE5hTZa8syK1xPzAiWAA/1Ez6wGfpsgs6pBse7jrqxOJYVuVVTzONrsXEWGjkf+3tx2tP3p3h9B4doXUK+MTb28vRGdA5wc7k8N8/YYCHIQEBf0Oe9VLWNv01KWK2OJl+6E9eHH5bJ2dHI0P5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68zsPaHEbNTJpk+CvS3OE3x1UE9RoveHRwXjduYYHX8=;
 b=dhJBECJeSHAXOVbNhWEKI/TWxlyIGcSmlnD66YipRIByGM+m/fJIz9i7bcgxSqfIgeKH4j5i855r08xoY+6kkEwqTs5zLVbD3nygF3nMQ27STctIzQCZN+OB4g2il7Up1fWJSgPpYkl42Djt6/GAsiEiMm/bDIPQbu+2TrJA+xlnZ0kEAmnbs/G+UVCLvwIgnw/1XgHPsbn55pUZ3MMq/WkyDWDzybRJ5LRMjCf2AJDY1opnOKaKWRX547jX2JDo8gOEWicy3c1MbJquBymcp1MqnooyeTdicdUVYmOpxMedunvrc403kf3qcD/7gyTnck899HUoBYCso9fbcpZTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6354.namprd11.prod.outlook.com (2603:10b6:510:1fe::10)
 by CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 08:33:39 +0000
Received: from PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd]) by PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 08:33:39 +0000
From: "Chang, Kaiyen" <kaiyen.chang@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@ucw.cz" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Todd Brandt
	<todd.e.brandt@linux.intel.com>, "Lee, Chiasheng" <chiasheng.lee@intel.com>
Subject: RE: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
Thread-Topic: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
Thread-Index: AQHawXj/yPD6Vz0RO0SPrSFEIVx3WLHNxpcAgAKaOtCAEyFXgIBGZoAA
Date: Fri, 16 Aug 2024 08:33:39 +0000
Message-ID: <PH7PR11MB635419A4AC11533F8F5791E493812@PH7PR11MB6354.namprd11.prod.outlook.com>
References: <20240618121327.2177-1-kaiyen.chang@intel.com>
 <20240618121327.2177-2-kaiyen.chang@intel.com>
 <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com>
 <PH7PR11MB6354DCC37B04CE407AD5B7F593C82@PH7PR11MB6354.namprd11.prod.outlook.com>
 <CAJZ5v0jo=9od9YCA=-bK83VhY196O2P6jHGnya9Xy=xM+Y+j4w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jo=9od9YCA=-bK83VhY196O2P6jHGnya9Xy=xM+Y+j4w@mail.gmail.com>
Accept-Language: zh-HK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6354:EE_|CY5PR11MB6234:EE_
x-ms-office365-filtering-correlation-id: 832df7ef-68c1-4ab6-2b96-08dcbdce20f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STVqVHZRR2k3OWFncUpramd5OUs2aHhtZ2FBZ0IvZHk1L3k0MWlVclc1WXhq?=
 =?utf-8?B?QXExZU9mZml1a0xPVFJiOG95VUFxMnhJamVaVnBQbXFtRDlUVFZvekRkYXIx?=
 =?utf-8?B?NW9WNVoyM0JSREYvaDhhWExUVUljTU4yY2tramZXVUZucmd1Rklzb08wM2oy?=
 =?utf-8?B?eEdXN1l2cU42YTZOMVFZWmlBR0RjS201L3RmL3F5YUdIbDZJMlpIbjVxd2Fk?=
 =?utf-8?B?MlFzYjcrL2p4eEd0ZmQ2NFpMVDVTVkg2M09MKzExYng1QmExUCtMc0tMTVlu?=
 =?utf-8?B?WmdETnp0K21YUHB2RlI2SXJoYWVobnNoNzNvWGp3SjJ3SnNSY3o1eWFLNktB?=
 =?utf-8?B?aDl4SDNHR0VDdXhEaThoeDdxTmRNZitVcWVwbnY0S0ZiMnk0ajh6dmtDa25E?=
 =?utf-8?B?dlZCUTEvNmI0RGI0aDNHWjhUSHhTMndPWTZIaHBVWDlaVFo2UHFNenE2Q2Ur?=
 =?utf-8?B?bHB3eFJaSkdVS2lSWSs3L1hvVVRKeHRpUjVrNkZJZ0xuVlhEeGFlYTRWSFA3?=
 =?utf-8?B?L0NxaVk4cXBndHRIQjdDSGFNdkFSWTkyMkpnejBLbXBGd3ZkZWhSYXg5UnN1?=
 =?utf-8?B?Ukt0eWUrcDZVa2Y0ejlqL2JKWjNTMU4xaFdkc2l6MXZpaStGSmExcCttSlEr?=
 =?utf-8?B?WDFsUFg1MkU1MHVEWWk5QnRWR25VdnVSdnUxRnBQemNERWdYanVJV09DTHor?=
 =?utf-8?B?TW5YSmlRQlhSeFAxQ1E2UVZ5OC9iSy9iY1RmZ1VLYkhHdGhGY2JBb1kxL2RF?=
 =?utf-8?B?bHhJZzNlVzZlWisvZHlvbnBld1RLYVNHWmVESnUyVEo5bW01VzdpbnZBM2pp?=
 =?utf-8?B?Wk5Lc0RteUdaQTZFUDUvWmRHUXpod0F2WThIcTJkdjZtekxxdUxvNndNNVVC?=
 =?utf-8?B?U1U1bXZkUVZZYUM1MUhPQXQrYjBpVlV1T0FsSFpMeDZGeXUyYVlRNXB6TFlo?=
 =?utf-8?B?clVGSXRlWFJYU045SGpiSHNzRFp5dmk5UVJwUjJ2cVFrNTNIaW1EY2pOQkhn?=
 =?utf-8?B?TlBzUEpnYjU2NFlmNkRqRzd3eWJwb1hkanB5OWZGaVlvaGVNZ3VxKzliOXcr?=
 =?utf-8?B?bFFPaU5aemRZZFlHS2F3YVFjT0M5aTdmOWQ0QkJWYXF4ZDBrQ3lPVTZkbHZ3?=
 =?utf-8?B?QTBHdXlzT2ZlNmpBQmpvbVI2dGNROXF5bmF4UHN3OU5FSzM5TEFyOU1CSGEy?=
 =?utf-8?B?Z1lUdFF1blhlZVpVZEtmYU9CT0lSZm5pVms4YlJFc0h1eWRzNDA0SHJuRkdP?=
 =?utf-8?B?dHdQNWRlRnk4ZkFGTGZiMzFYR1UwUW9yM1YvM2F4WGpScTlISmgvcUJaM2Y4?=
 =?utf-8?B?WHNBRk5xU3pMYXZUazkra2tEMWxWRGxINWNtbTJqeWVwQ1orblVrZVlFVjIr?=
 =?utf-8?B?N3ZONXhDd24yWS9FWitFek0wNVF6RVBBUnMyM3lFamwxUHlQMXNyS2tMcktn?=
 =?utf-8?B?bDFyelNqNmRiVnorRzlKNGRJcXZHMWV1UTExTGZxOWJ1WDlOTnBHOEsvQ3pU?=
 =?utf-8?B?RU5ZN2p3Kzg5VFE2QUhySWFGZWQ0YVVLTlN6bzl0YjJST21rOUVLWloxR1RR?=
 =?utf-8?B?VndsTUZ6NTcvcmNMa25xRmRkOHlqcWgyYi9MS3R6Q3hVS2xadEtRakpXU2FM?=
 =?utf-8?B?NERTMU8yQmF0SlZwRnZFR0VUWlZhSGxBdEV0dHlvc2hXVEdTaGU1eVJMRm9t?=
 =?utf-8?B?N2NWNldXb2liemIrVDBkOWJYdjFpN3MrVWcwRmlsNXBzVHIxMlF3Rm13bnV3?=
 =?utf-8?B?WlBQRXN3Ulc3b3RkcjlTK1hRSFlYempSTTUrb3Mxd2JRdGNwQzh0cllCL0NU?=
 =?utf-8?B?T2pXbGYyWXRLWWpjNVcvR3VIcDlJUUhPUHlRMndMU0YyMHFPczNJSVlTMENF?=
 =?utf-8?B?ZGZ6UW9ac29BMHBXRXNsWnVDSkpTMmNzSmRncWFZdmhhM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNUMUx0aU9nN3NBYXpOZ3hEZG45bGdBelQzZWJiYTlscThxWXM5SU9zTU0y?=
 =?utf-8?B?YmlGNUhaRWRFaTlUeDlEVmdHd0VHVmE4UDhoRmJPc3RkRjU4NVZibW9IRExj?=
 =?utf-8?B?TGNWQjRCL1I3aUZqQlRkMmlJbXlLZnFuQ0JBY2NhRDd4UGFxUklsZ2gyKzY1?=
 =?utf-8?B?Wm4zNXVnMHlnazZKZVlTVHZQMEhVelVhTEU0MU5qRzZFenMyNGk1Yjk4ME5H?=
 =?utf-8?B?bHl2Z0NZWTJlNzF1MDZodWI1aDRQUUlzTWhEZGZLYlNlU1BtZUlJV25IMmFi?=
 =?utf-8?B?SnJLQnhlTEpJc2ZJcTV5WVNVcUlJZ0ZMVGlxeVA1OUxWTFluWFNTN1lpRlc3?=
 =?utf-8?B?WHVRTEVwazRscTlHU3ErSXhSSnY1b0t2VlQwZi9nMlhLaTNJQ002Sm5NT1E3?=
 =?utf-8?B?R1Q5NW1XV0JlM3Y4cncxdHVFZVNwSG9kQnhkdTNVTVpvLzVNeUE3dC8vOXdk?=
 =?utf-8?B?anJaL1YreE54ZUdJWGRzWm9zU2NkL25nWU9hMVZ4V3hVWHdTZDZUSTlhM0oz?=
 =?utf-8?B?S0hlVnAvcUQ5YnA2eFJCTjQrNU5zUFFtVlhCS0RmdzVuM2g3cnNNRWE2Skxj?=
 =?utf-8?B?Q0tOb0JUaUk1cCt5REdBVWNydHBodkUwdVFncVkvZVlkNHNBTnBvM05xWnYw?=
 =?utf-8?B?a1BKSlRmVEtaOEo3eHdhM2lCZ245MndRWHhBNDdHU0J0RDBZKzhqNHpVdWFY?=
 =?utf-8?B?SkFoVzd2TjBQR2prTi9zZ1QrbkJtWGNhSG9mb3d3NklNcmx2bU5vUkhrM0s4?=
 =?utf-8?B?dURtcjBucTRUejFkZGxlaTRmeEIwb09Qa0ZJNHRUblU2NjNjYk9FOWM3dkFm?=
 =?utf-8?B?VFBvcmRkMzJNNWJlSkNWTEl6L3RGTUViNU5LTFZtRDdIWlp6YVB3UVcrdm9T?=
 =?utf-8?B?REdOWVcvVjMvSjJvM2NacWovQk1vTW1kK3BGSHUxWHVSZ05ISkUwY1oxR3Yz?=
 =?utf-8?B?cjdYRFBibmpRZGJuZGMxcWUwZ2xXdWdDYWhRK3RXdlJpbWl5Z2NXMGozVzJC?=
 =?utf-8?B?QkFoVC8ybWI3WHVFZ2lHZXNxMklWaUJSY1pPVElEUEpmc08rWC9ndVlmdk1Q?=
 =?utf-8?B?dFVETUFPdWl1WnFQN045eGNBczJxSDRzQ29FbGlhMURCYnFoSHR6UWZhZXRq?=
 =?utf-8?B?UzR6dk1uYlJwUXFyMlFaaVkvTzBFdlE1RUpReXNER2JwVDZzTVFkWkdwUzc5?=
 =?utf-8?B?NGtmM3V4TTllV2gzdmJJNzgrb3FiMnJvMlB5NkF1aXI3Y1huOXluYjdjZ3JQ?=
 =?utf-8?B?V0VuaElNY3ZtWmZsQ1NJRkF5K0VBU3NYaGJxTDJ2c1k2Wjdpb2MrWUNzT2xa?=
 =?utf-8?B?UVl1d1VpeWVmdWFla2ppRzJtSU9QZHdQNHNOaFBiWVY0anpuOWNxN1I1VFpz?=
 =?utf-8?B?SmpEVVNKKzR6YWVaVVJFeDZLZlRNUXJaUDhVM3dDdlozVWtpT2R5Ujg5dXl1?=
 =?utf-8?B?T2diTlA1UllGK0k3NjVpT1FDQVUxaVYrWjVyQWxwbTBoeGk1aFVDNTlWQVRl?=
 =?utf-8?B?aFE2d2RaQndGNjNXRVBJejJCU1Bpd3hxSUU5NUxKcmxyRGZJRXZTaUI5NjdP?=
 =?utf-8?B?bXVUaVhNUWlxb0o4ckFieEw0THF6OVVBS0JsS2ZZYUd1SmFkclQrckhrUHFS?=
 =?utf-8?B?SkRXRmUyMzNNM1ZSUmRQWWtyMUZEcGNHbnBJV3dSYzBtWXZIVTZ1MlJ4blFr?=
 =?utf-8?B?US8ydHRCLzRXK1pLQU9OMWJxYSsyeEVKeFRxVVpKYkxmaVJrRDVUYnpDYThV?=
 =?utf-8?B?dGFlaFRGVnl5Yk1TWi83NVZxSzhHNHk0RTRqM2cyZnVsNTY2S2NJVmlOY2cx?=
 =?utf-8?B?YjZMeGNJL1JGZmRodEkwS3VzbXB5bWpoMnFUbC9DZUw3eThrTWpldEVtQlNl?=
 =?utf-8?B?S2lqQ0syOWR2ZS83YU9OajVEUzRSYnk4WXgxSi94OUFSNXkvaTVuenVPVk5j?=
 =?utf-8?B?L0FEa3Y2aXVCOGhuZE1WY0FOL2gwT2xDem53Q3hIdm5KZjhyeVBoeWlYQzhK?=
 =?utf-8?B?ejVGMFdIeG9vQnQ2T3pwWlQ2aS9lQldCU0hCeVRIeFZHVlBBR09YUHVZSUZ3?=
 =?utf-8?B?c1dpQ0hNS1EzUlR0dzhheHNqUXRvcGNYcytoSHM3dzRnNjFUVHY1NDB4clBF?=
 =?utf-8?Q?pv/Fb8n0uJyI+GP/wEeGKrQCa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832df7ef-68c1-4ab6-2b96-08dcbdce20f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 08:33:39.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RH9CgfYiGh2NQxLYIKu9Qu4h2knUar7ubSG5T+qixzDIivTSDfVogQX5n/urnrttHxVTV8CSHIX5L6hM1JVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6234
X-OriginatorOrg: intel.com

DQpPbiBUdWUsIEp1bHkgMiwgMjAyNCBhdCAwOToyMDoyNFBNICswMjAwLCBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdW4gMjAsIDIw
MjQgYXQgMTE6MjHigK9BTSBDaGFuZywgS2FpeWVuIDxrYWl5ZW4uY2hhbmdAaW50ZWwuY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgSnVuIDE4LCAyMDI0IGF0IDA3OjI3OjE4UE0gKzAy
MDAsIFJhZmFlbCBKLiBXeXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4g
Pg0KPiA+ID4gT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMjoxM+KAr1BNIEthaXllbiBDaGFuZw0K
PiA+ID4gPGthaXllbi5jaGFuZ0BpbnRlbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4g
PiA+ID4gQ3VycmVudGx5LCB3aGVuIHBlcmZvcm1pbmcgYSBzdXNwZW5kIG9wZXJhdGlvbiwgYWxs
IGRldmljZXMgb24gdGhlDQo+ID4gPiA+IGRwbV9saXN0IG11c3Qgd2FpdCBmb3IgdGhlICJzeW5j
aHJvbm91cyIgZGV2aWNlcyB0aGF0IGFyZSBsaXN0ZWQNCj4gPiA+ID4gYWZ0ZXIgdGhlbSB0byBj
b21wbGV0ZSBiZWZvcmUgdGhlIG1haW4gc3VzcGVuZCB0aHJlYWQgY2FuIHN0YXJ0DQo+ID4gPiA+
IHRoZWlyIHN1c3BlbmQgcm91dGluZXMsIGV2ZW4gaWYgdGhleSBhcmUgImFzeW5jaHJvbm91cyIu
IElmIHRoZQ0KPiA+ID4gPiBzdXNwZW5kIHJvdXRpbmUgb2YgYSBzeW5jaHJvbm91cyBkZXZpY2Ug
bXVzdCBlbnRlciBhIHdhaXRpbmcgc3RhdGUNCj4gPiA+ID4gZm9yIHNvbWUgcmVhc29uLCBpdCB3
aWxsIGNhdXNlIHRoZSBtYWluIHN1c3BlbmQgdGhyZWFkIHRvIGdvIHRvDQo+ID4gPiA+IHNsZWVw
LCB0aGVyZWJ5IGRlbGF5aW5nIHRoZSBwcm9jZXNzaW5nIG9mIGFsbCBzdWJzZXF1ZW50IGRldmlj
ZXMsDQo+ID4gPiA+IGluY2x1ZGluZyBhc3luY2hyb25vdXMgb25lcywgdWx0aW1hdGVseSBleHRl
bmRpbmcgdGhlIG92ZXJhbGwgc3VzcGVuZA0KPiB0aW1lLg0KPiA+ID4gPg0KPiA+ID4gPiBCeSBz
dGFydGluZyB0aGUgYXN5bmNocm9ub3VzIHN1c3BlbmQgdGhyZWFkcyB1cGZyb250LCB3ZSBjYW4g
YWxsb3cNCj4gPiA+ID4gdGhlIHN5c3RlbSB0byBoYW5kbGUgdGhlIHN1c3BlbmQgcm91dGluZXMg
b2YgdGhlc2UgYXN5bmNocm9ub3VzDQo+ID4gPiA+IGRldmljZXMgaW4gcGFyYWxsZWwsIHdpdGhv
dXQgd2FpdGluZyBmb3IgdGhlIHN1c3BlbmQgcm91dGluZXMgb2YNCj4gPiA+ID4gdGhlIHN5bmNo
cm9ub3VzIGRldmljZXMgbGlzdGVkIGFmdGVyIHRoZW0gdG8gY29tcGxldGUsIGFuZCB3aXRob3V0
DQo+ID4gPiA+IGJyZWFraW5nIHRoZWlyIG9yZGVyIHdpdGggcmVzcGVjdCB0byB0aGVpciBwYXJl
bnRzIGFuZCBjaGlsZHJlbi4NCj4gPiA+ID4gVGhpcyB3YXksIGV2ZW4gaWYgdGhlIG1haW4gc3Vz
cGVuZCB0aHJlYWQgaXMgYmxvY2tlZCwgdGhlc2UNCj4gPiA+ID4gYXN5bmNocm9ub3VzIHN1c3Bl
bmQgdGhyZWFkcyBjYW4gY29udGludWUgdG8gcnVuIHdpdGhvdXQgYmVpbmcNCj4gPiA+ID4gYWZm
ZWN0ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEthaXllbiBDaGFuZyA8a2Fp
eWVuLmNoYW5nQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBIb3cgZXhhY3RseSBoYXMgdGhpcyBi
ZWVuIHRlc3RlZD8NCj4gPiA+DQo+ID4gPiBJbiB0aGUgcGFzdCwgY2hhbmdlcyBnb2luZyBpbiB0
aGlzIGRpcmVjdGlvbiBjYXVzZWQgc3lzdGVtIHN1c3BlbmQNCj4gPiA+IHRvIGhhbmcgb24gYXQg
bGVhc3Qgc29tZSBwbGF0Zm9ybXMgKGluY2x1ZGluZyB0aGUgb25lcyBpbiBteSBvZmZpY2UpLg0K
PiA+ID4NCj4gPg0KPiA+IEhpIFJhZmFlbCwgdGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KPiA+DQo+
ID4gMS4gV2UgaGF2ZSBjdXJyZW50bHkgdmVyaWZpZWQgdGhpcyBwYXRjaCBvbiB0aGUgQURMLU4g
Q2hyb21lYm9vaywgcnVubmluZw0KPiB0aGUgc3VzcGVuZCBzdHJlc3MgdGVzdCAxMDAwIHRpbWVz
IGNvbnNlY3V0aXZlbHkgd2l0aG91dCBlbmNvdW50ZXJpbmcgYW55DQo+IGlzc3Vlcy4NCj4gDQo+
IEp1c3Qgb25lIG1hY2hpbmU/ICBUaGF0J3MgaGFyZGx5IHN1ZmZpY2llbnQuDQo+IA0KDQpXZSBo
YXZlIHZlcmlmaWVkIHRoaXMgcGF0Y2ggb24gSlNMLCBBREwtUCwgQURMLU4sIFJQTCwgYW5kIE1U
TCBDaHJvbWVib29rcy4NCkFsbCBkZXZpY2VzIGNhbiBwYXNzIHRoZSBzdXNwZW5kIHN0cmVzcyB0
ZXN0IDEwMDAgdGltZXMgY29uc2VjdXRpdmVseS4NCg0KPiA+IDIuIENvdWxkIHlvdSB0ZWxsIHVz
IHdoYXQgd2FzIHRoZSByZWFzb24gZm9yIHN1c3BlbmQgdG8gaGFuZyBiYWNrIHRoZW4/DQo+IA0K
PiBJdCB3YXMgd2hhdCBpcyBzdGlsbCB0aGUgY2FzZSBJIHRoaW5rOiBTb21lIGRlcGVuZGVuY2ll
cyBiZXR3ZWVuIGRldmljZXMgYXJlDQo+IGltcGxpY2l0bHkgdGFrZW4gaW50byBhY2NvdW50IHdo
ZW4gdGhlIGFzeW5jIHN1c3BlbmQgdGhyZWFkcyBhcmUgbm90IHN0YXJ0ZWQNCj4gdXBmcm9udC4N
Cj4gDQo+ID4gVGhlIHJlYXNvbiB3aHkgSSBiZWxpZXZlIHRoYXQgd2UgY2FuIHN0YXJ0IHRoZSBh
c3luYyBkZXZpY2UncyBzdXNwZW5kDQo+ID4gdGhyZWFkcyB1cGZyb250IGlzIHRoYXQsIGR1cmlu
ZyByZXN1bWUsIGEgc3luYyBkZXZpY2VzIGxpc3RlZCBhZnRlcg0KPiA+IGNlcnRhaW4gYXN5bmMg
ZGV2aWNlcyBvbiB0aGUgbGlzdCBkbyBub3QgYWN0dWFsbHkgcmVseSBvbiB0aGUgaW1wbGljaXQN
Cj4gPiBkZXBlbmRlbmN5IHByb3ZpZGVkIGJ5IHRoZSBvcmRlciBvZiB0aGUgZGV2aWNlcyBvbiB0
aGUgbGlzdC4NCj4gDQo+IFRoaXMgcHJvYmxlbSBoYXMgbm90aGluZyB0byBkbyB3aXRoIHJlc3Vt
ZSwgYmVjYXVzZSB0aGUgbWFjaGluZXMgaGFuZw0KPiBkdXJpbmcgc3VzcGVuZC4NCj4gDQo+ID4g
VGhpcyBpcyBiZWNhdXNlIGlmIHRoZXJlIGlzIG5vIGNvbnN1bWVyLXN1cHBsaWVyIG9yIHBhcmVu
dC1jaGlsZHJlbg0KPiA+IHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZXNlIGRldmljZXMsIHRoZSBz
dXNwZW5kIHJvdXRpbmUgb2YgdGhpcyBzeW5jDQo+ID4gZGV2aWNlIHdpbGwgYmUgZXhlY3V0ZWQg
ZGlyZWN0bHkgd2l0aG91dCB3YWl0aW5nIGZvciB0aGUgc3VzcGVuZA0KPiA+IHJvdXRpbmVzIG9m
IHRoZSBhc3luYyBkZXZpY2VzIGxpc3RlZCBiZWZvcmUgaXQgdG8gY29tcGxldGUuIEluIG90aGVy
IHdvcmRzLA0KPiB0aGlzIHN5bmMgZGV2aWNlIGRvZXMgbm90IGRlcGVuZCBvbiB0aGUgYXN5bmMg
ZGV2aWNlcyBsaXN0ZWQgYmVmb3JlIHRoZW0uDQo+IA0KPiBXZWxsLCBub3QgcXVpdGUsIElJVUMu
DQo+IA0KPiBTYXkgdGhlcmUgYXJlIHR3byBkZXZpY2VzLCBBIGFuZCBCLCB0aGUgZm9ybWVyIGlz
ICJzeW5jIiBhbmQgdGhlIGxhdHRlciBpcw0KPiAiYXN5bmMiLiAgU2F5IHRoZXJlIGlzIGEgZGVw
ZW5kZW5jeSBiZXR3ZWVuIHRoZW0gc3VjaCB0aGF0IEEgbXVzdCBzdXNwZW5kDQo+IGJlZm9yZSBC
LCBidXQgaXQgaXMgbm90IGV4cHJlc3NlZCBkaXJlY3RseSAobm8gcGFyZW50LWNoaWxkIHJlbGF0
aW9uc2hpcCBhbmQgbm8NCj4gZGV2aWNlIGxpbmspLg0KPiANCj4gSWYgQSBpcyBiZWZvcmUgQiBp
biB0aGUgbGlzdCBvcmRlciBhbmQgYXN5bmMgc3VzcGVuZCBpcyBub3Qgc3RhcnRlZCB1cGZyb250
LCB0aGUNCj4gZGVwZW5kZW5jeSBpcyBtZXQuICBJZiBhc3luYyBzdXNwZW5kIGlzIHN0YXJ0ZWQg
dXBmcm9udCwgQiBtYXkgc3VzcGVuZA0KPiBiZWZvcmUgQS4NCj4gDQoNCkhlcmUgYXJlIHR3byBp
bnN0YW5jZXMgd2hlcmUgSSBtaXN0YWtlbmx5IHdyb3RlICJzdXNwZW5kIiBpbnN0ZWFkIG9mDQoi
cmVzdW1lLiIgUGxlYXNlIGFsbG93IG1lIHRvIGNvcnJlY3QgdGhlbSBhcyBmb2xsb3dzOg0KDQpC
ZWZvcmUgY29ycmVjdGlvbjoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoaXMgaXMgYmVjYXVzZSBpZiB0aGVy
ZSBpcyBubyBjb25zdW1lci1zdXBwbGllciBvciBwYXJlbnQtY2hpbGRyZW4NCnJlbGF0aW9uc2hp
cCBiZXR3ZWVuIHRoZXNlIGRldmljZXMsIHRoZSAqc3VzcGVuZCogcm91dGluZSBvZiB0aGlzIHN5
bmMNCmRldmljZSB3aWxsIGJlIGV4ZWN1dGVkIGRpcmVjdGx5IHdpdGhvdXQgd2FpdGluZyBmb3Ig
dGhlICpzdXNwZW5kKg0Kcm91dGluZXMgb2YgdGhlIGFzeW5jIGRldmljZXMgbGlzdGVkIGJlZm9y
ZSBpdCB0byBjb21wbGV0ZS4NCg0KQWZ0ZXIgY29ycmVjdGlvbjoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRo
aXMgaXMgYmVjYXVzZSBpZiB0aGVyZSBpcyBubyBjb25zdW1lci1zdXBwbGllciBvciBwYXJlbnQt
Y2hpbGRyZW4NCnJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZXNlIGRldmljZXMsIHRoZSAqcmVzdW1l
KiByb3V0aW5lIG9mIHRoaXMgc3luYw0KZGV2aWNlIHdpbGwgYmUgZXhlY3V0ZWQgZGlyZWN0bHkg
d2l0aG91dCB3YWl0aW5nIGZvciB0aGUgKnJlc3VtZSoNCnJvdXRpbmVzIG9mIHRoZSBhc3luYyBk
ZXZpY2VzIGxpc3RlZCBiZWZvcmUgaXQgdG8gY29tcGxldGUuDQoNCkhlcmXigJlzIHdoYXQgSSB3
YW50IHRvIGNvbnZleToNCg0KVGhlIGNvbW1pdCA1YWY4NGI4MjcwMWEgIlBNOiBBc3luY2hyb25v
dXMgc3VzcGVuZCBhbmQgcmVzdW1lIG9mIGRldmljZXMiDQpzZWVtcyB0byBiZSBiYXNlZCBvbiB0
aGUgYXNzdW1wdGlvbiB0aGF0LCBleGNlcHQgZm9yIGRldmljZXMgd2l0aA0KY29uc3VtZXItc3Vw
cGxpZXIgb3IgcGFyZW50LWNoaWxkcmVuIHJlbGF0aW9uc2hpcHMsIG5vIHN5bmMgZGV2aWNlIGRl
cGVuZHMNCm9uIGFueSBhc3luYyBkZXZpY2VzLiBUaGlzIGlzIGJlY2F1c2Ugb25seSBkZXZpY2Vz
IHdpdGggY29uc3VtZXItc3VwcGxpZXINCm9yIHBhcmVudC1jaGlsZHJlbiByZWxhdGlvbnNoaXBz
IHdvdWxkIHdhaXQgZm9yIHRoZSBhc3luYyByb3V0aW5lcyB0bw0KY29tcGxldGUuDQoNCkluIHRo
ZSBleGFtcGxlIHlvdSBwcmV2aW91c2x5IHByb3ZpZGVkLCBpZiBBIChzeW5jKSBtdXN0IHN1c3Bl
bmQgYmVmb3JlDQpCIChhc3luYyksIGl0IGluZGljYXRlcyB0aGF0IEEgZGVwZW5kcyBvbiBCIChp
LmUuLCBBIG5lZWRzIEIpLiBUaGVyZWZvcmUsDQpkdXJpbmcgdGhlIHJlc3VtZSBwaGFzZSwgQSBz
aG91bGQgd2FpdCBmb3IgQidzIHJlc3VtZSByb3V0aW5lIHRvIGNvbXBsZXRlDQpiZWZvcmUgc3Rh
cnRpbmcgaXRzIHJlc3VtZSByb3V0aW5lLiBIb3dldmVyLCBpbiBjb21taXQgNWFmODRiODI3MDFh
LCBvbmx5DQpkZXZpY2VzIHdpdGggY29uc3VtZXItc3VwcGxpZXIgb3IgcGFyZW50LWNoaWxkcmVu
IHJlbGF0aW9uc2hpcHMgd291bGQgd2FpdA0KZm9yIHRoZSBhc3luYyByb3V0aW5lIHRvIGZpbmlz
aCwgd2hpbGUgdGhlIG90aGVyIHN5bmMgZGV2aWNlcyB3b3VsZCBub3QuIFRoaXMNCm1ha2VzIG1l
IHRoaW5rIHRoYXQsIGluIGZhY3QsIHRoZSBzeW5jIGRldmljZXMgd2l0aG91dCBjbGVhcmx5IGRl
ZmluZWQNCmRlcGVuZGVuY2llcyBkbyBub3QgYWN0dWFsbHkgbmVlZCBhbnkgYXN5bmMgZGV2aWNl
cyB0byBiZSByZWFkeS4gT3RoZXJ3aXNlLA0KdGhlcmUgd291bGQgYmUgYSBwb3RlbnRpYWwgcmlz
ayBoZXJlLg0KDQo+ID4gVGhlcmVmb3JlLCBkdXJpbmcgc3VzcGVuZCwgdGhlcmUgaXMgbm8gbmVl
ZCB0byBlbnN1cmUgdGhvc2UgYXN5bmMNCj4gPiBkZXZpY2VzIGxpc3RlZCBiZWZvcmUgdGhlIHN5
bmMgZGV2aWNlcyBhcmUgYXdha2UgYmVmb3JlIHRoZXNlIHN5bmMNCj4gPiBkZXZpY2VzIGNvbXBs
ZXRlIHRoZWlyIHN1c3BlbmQgcm91dGluZXMuIEluIHN1bW1hcnksIGFzIGxvbmcgYXMgd2UNCj4g
PiBtYW5hZ2UgdGhlIGRlcGVuZGVuY2llcyBiZXR3ZWVuIGNvbnN1bWVycy9zdXBwbGllcnMgYW5k
DQo+ID4gcGFyZW50cy9jaGlsZHJlbiByZWxhdGlvbnNoaXBzIHByb3Blcmx5LCB3ZSBzaG91bGQg
YmUgYWJsZSB0byBzdGFydCB0aGUgYXN5bmMNCj4gZGV2aWNlcycgc3VzcGVuZCByb3V0aW5lcyB1
cGZyb250IGR1cmluZyBzdXNwZW5kLg0KPiANCj4gV2VsbCwgaWYgdGhlIGRlcGVuZGVuY2llcyBh
cmUgYWxsIHJlcHJlc2VudGVkIGVpdGhlciB0aHJvdWdoIHBhcmVudC1jaGlsZA0KPiByZWxhdGlv
bnNoaXBzIG9yIHRocm91Z2ggZGV2aWNlIGxpbmtzLCB0aGVuIHllcywgYnV0IGFyZSB0aGV5PyAg
T24gYWxsIHN5c3RlbXMNCj4gY3VycmVudGx5IGluIHRoZSBmaWVsZD8NCj4gDQo+IFNvIGlmIHlv
dSB3YW50IHRvIG1vdmUgdGhpcyBmb3J3YXJkLCBwbGVhc2UgdGFsayB0byBUb2RkIEJyYW5kdCAo
Q0NlZCkgdG8NCj4gYXJyYW5nZSBmb3IgdGVzdGluZyB5b3VyIHBhdGNoIGluIHRoZSBjbGllbnQg
cG93ZXIgbGFiLiAgSXQgbXVzdCBhdCBsZWFzdCBub3QNCj4gYnJlYWsgc3VzcGVuZCBvbiBhbnkg
bWFjaGluZXMgaW4gdGhlcmUuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBXZSd2
ZSByZXF1ZXN0ZWQgVG9kZCdzIGFzc2lzdGFuY2Ugd2l0aCB0aGUNCnRlc3RpbmcuIFRoZSByZXN1
bHRzIHNob3cgdGhhdCBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCBhbGwgdGhlIG1hY2hpbmVz
DQppbiB0aGUgbGFiIGVuY291bnRlcmVkIG5vIGlzc3Vlcy4gQ291bGQgeW91IHBsZWFzZSBhZHZp
c2Ugb24gdGhlIG5leHQgc3RlcHM/DQoNCg==

