Return-Path: <linux-pm+bounces-15592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE399BF0E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CC41C22FED
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49513211F;
	Mon, 14 Oct 2024 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3laeT8h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA4140E50;
	Mon, 14 Oct 2024 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728879023; cv=fail; b=bCuCVdgogVY7N7XSV3uZNFq0ESInWco8ryItrngVnD2/mwP7kIgv1DGa0fVQZ9QUlBbd1qitcYE3lvDu/kJ/urUgh2V9rFjKWs9vp/vYuTmlUUQ2U1PamwrQs8H5dc47IFYnvEuUDjHX9bXWVVyGtg9/IszG5hMwehdRUm390yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728879023; c=relaxed/simple;
	bh=UgcJzFcz9Nyh2U4JU00XMeoa7yMFUOUITgF8AccFKa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVaGOkGn3CxEMt+LAguaJ34NXDzyQhnav60xi7d21e+SdXSz6qBbFqyW9ffFdPLsC8zAvrRaHt//BAijgdjBNvWYcrtb/MWs6i6/9+8dUURJGLDk60WWjkowKZxt4y4nGKi8ZFlsdXP+EFRwTgZqnITeu+SskgQD/4FijvH6W2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3laeT8h; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728879021; x=1760415021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UgcJzFcz9Nyh2U4JU00XMeoa7yMFUOUITgF8AccFKa0=;
  b=S3laeT8hRQmY/NZT9r/PIs/Kmg9V3OxNEfc7I24p9LdaRLPeUCPW1Mf+
   xj5flP1O+jA7DqN2/YTfOHmOODiaAqt7TI8EN4Opk+iAUKQXczVIRJBuO
   xI2qyIgOBYRJ7gurqSmbaFGATZdoAXhT0FCAI/eqiXPJLeEr3zZbDmzBK
   hSivzSOCixEMsfjEAC7lQu7NGBiMo2DoxVypbs8E9iDkdT5iVwkvaH/yd
   SZ7YX8N7SpHPUOUGmOnWemAIaI7Rv2korOLM1oMKZQs3rHqqtUtVGVj3N
   H+GwN/vwNIYZR2Frp/j7Vb/nsOx8iCmYRQcohtznxxmjw+bIhsYnn7/mI
   w==;
X-CSE-ConnectionGUID: q+W/70/XRFuHfkkDMxnA6g==
X-CSE-MsgGUID: lNRg6D+tTtKlt1kXgW4EKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38855686"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="38855686"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 21:10:21 -0700
X-CSE-ConnectionGUID: 9ujDuVCqTYuDYQjFTe9NPA==
X-CSE-MsgGUID: dRD3t47dR5yhc2bXv3904g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="108206577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 21:10:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 21:10:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 21:10:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 21:10:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 21:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYm8aimG4YfhSqSCvKHNk74nzWTWZvsp+MBOYH2ZYLeVhnyVb3+VbCDCd7Gx7iKcEO3PzvqFWWuMNCVMTtefQuJjC4G7Baig0v5b543MrkWrxXR8s/u7Ur8HjsQIVuzIritCK2yNh3SdiHfCE1yJbPFH/ztOOK4i2ekiD6M+4x4Vc2TGHaGH4TAIIcu4gxDJZa40ZW7i+yYeD6ncpX2GNMvBxO37nbdZKUM7wjL24CKFDg05erEVgUIjMReMun5AjcAtRLe3H/5EZv/eWY00JixzdHXFetptJ0AkvftGzXn+vwt+5IRt3YSBITPdQnGNt+UzTB6091lJrMOmCurJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgcJzFcz9Nyh2U4JU00XMeoa7yMFUOUITgF8AccFKa0=;
 b=tItlXhqGjXji4RY+NhtTh26lERYPW5Y9XT833rAqA8UwjaLLGqLFPw9j9KYxmhjFQpydpT6BrV2irMmZ7DGhqsllPmC/+TZ3370l6nHpvW+/yyebS0Y0eyjvXI/uxDLshm1iuFWfWva4xA5g/0IYTBSbm23qKqLMv28+0d3LV3nZQoiinr5yDNP1tffknTVlxbPlK7tlL5lh5Jo/MlaJDXMqa2eXC8P1kbQ1iHVOyu7NbMwoyJh2dWjTJF3J3NKDoIbKRaiPYSlVSksMFw0fZALLd2zYvysXKpr8IxJ7rjro3c5S9lfroUCiMsIELi1MiXLqxBrwYi1KDdOWoPR6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 04:10:14 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 04:10:14 +0000
From: "Gopal, Saranya" <saranya.gopal@intel.com>
To: duanchenghao <duanchenghao@kylinos.cn>, Alan Stern
	<stern@rowland.harvard.edu>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Hongyu Xie <xy521521@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"niko.mauno@vaisala.com" <niko.mauno@vaisala.com>, "pavel@ucw.cz"
	<pavel@ucw.cz>, "stanley_chang@realtek.com" <stanley_chang@realtek.com>,
	"tj@kernel.org" <tj@kernel.org>, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: RE: [PATCH] USB: Fix the issue of task recovery failure caused by USB
 status when S4 wakes up
Thread-Topic: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Thread-Index: AQHbAAnZn0I78z2Rm0CO/hcA6/JbFLJQy8GMgAHlSICAANSWAIAAw06AgAJWrQCADn2pgIAB8KqAgBbZsYCAAN5LAIAA7Q0AgACMa4CAAL4fgIAAzDmAgAFO4ICAAFadgIACRQaAgAApDsA=
Date: Mon, 14 Oct 2024 04:10:14 +0000
Message-ID: <DS0PR11MB74571AF700D26D36EED5C2CBE3442@DS0PR11MB7457.namprd11.prod.outlook.com>
References: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
	 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
	 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
	 <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
	 <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
	 <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>
	 <74848334-7cd7-4ce1-ad96-5dd29d70d3bb@rowland.harvard.edu>
 <eb119532f37c84aedab32df9169e64abf894f006.camel@kylinos.cn>
In-Reply-To: <eb119532f37c84aedab32df9169e64abf894f006.camel@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7457:EE_|MN0PR11MB5963:EE_
x-ms-office365-filtering-correlation-id: 4d1a7cd9-269a-43e1-09c8-08dcec061ae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkVOQnlHRWIvM3dNVnBPL21tbVFQV1BHWWd3K1ZxY3c0T1dRYlBHdmk0QTJN?=
 =?utf-8?B?aERnZ2x4M0hQRUJZVi9DbGdVQytMT0M1UXBvVFJaKzBIUHhNZ2tDa3NpVUlo?=
 =?utf-8?B?TUc4WmdCcW03cjgwK0E0M0VvSE51ZWlhNWR4NFFYdXFMZ252dDBpYjRXZndy?=
 =?utf-8?B?a1FVMDk5SlcxNjFVVHo2T2RuK242MDBQbUdlc0d4dUNZanNGd3FsL1dIQ1Bn?=
 =?utf-8?B?M0tyY0tLTFlrbnEvMjVHaUNibzNzaW9qd0xjcU55QnhBV3RTaUxZaExIS041?=
 =?utf-8?B?Z0R5L0N3OGVVckFSZXpYMlIvM1BRUnlJdkJzOHI4ZC9La1lmZFBGdThPVW5a?=
 =?utf-8?B?eWl6aTdWaU5nQzZMWnE5S1YzMzZsbGhpcnlEenQ3bFk2cDAvNnFkbnpNS1Nj?=
 =?utf-8?B?TzNocHdmUGN1bithSlhJdFY3SUVXalBnTDNNZEhncUcrSytEUjVCbVl3Ri9Q?=
 =?utf-8?B?SUZQMW1jT0p4VStDOUwreU41NjN2akFUMDdESXlDbUZrcWpkbGlMRTdmQWpM?=
 =?utf-8?B?eGo4UHQ0d0hhby9MYkdjZjlyT2w0QzB6Nzd1aHJFWCtYdnh6RGxoQXdZbHZy?=
 =?utf-8?B?ZGQyVWcwNkg3M3VRMnRCV1JscndOdFVuUlFDbG1FdW14ajNaNGhKK3NsL1px?=
 =?utf-8?B?b1hzY05mSHVSNzdZdXZ1QXRnMEd1NzFUYVlNaS9OMEh5V0c0SjIzS0JCNzVr?=
 =?utf-8?B?empxR1hHVENTbmMxNmF1TlhlK0hlQTVzdUJ4SXpMNDRBa3hqbXIzcmpwc1p4?=
 =?utf-8?B?bEZHWHJ6dGVoeXhqeDdtNXkreCtzQzkwenRLNGVGSGlvMVZENGZSVzlLdm8y?=
 =?utf-8?B?OUx5NVFtK2xZVXpJU0o2eE92dVpVQ0tSM3ZkbEFrQ0dzY0ZOcHZTaUVhaVQv?=
 =?utf-8?B?bU9sdjFBZGZGdEpLR0RwZ0JwS3I1RXdlOUlZZHI2OTZmeE5sNGZJd2dlQWY3?=
 =?utf-8?B?WHB1alVhY2FtaFZWU21wbjhVWkh2empLeHJKbk1CMDllbElzN21pdnZoUUc4?=
 =?utf-8?B?S1RPL3JtNHdFNUU1UWx6TmRtY0NoQXliVUsvc2NMLzlQS3dWRXBTaVNncWVu?=
 =?utf-8?B?ZlJVZjZCTm1nUWlWMEZQZG53bGQzdzEzVStpUnlsTzI5cHlWUGQ1UGNSM1ox?=
 =?utf-8?B?dnNRSXN6KzRDOE0yRi9sdmRLTnNkZnU5NnZwVkFyeVVUeURUWDNsN2owYlJF?=
 =?utf-8?B?c1VOK3N5K3JRUEpJcFc0Q0JTNHdGcWpSaVFaQ2s2KzhKYnpYNGVEVFkrMURk?=
 =?utf-8?B?YlcydEdtL2ZBWEoyV216NVhydFRoQzFuTXk4Nk45QTVCbkxjTUlHZlJ6aXEy?=
 =?utf-8?B?Zklkd0NPL3RuYmxvTWlULzNBZWZueE8rUGhmcTRpbDVrRkdTMElYTWFxSHp5?=
 =?utf-8?B?NWdWbTF2QVU1R1JxNXY5dzMvamNHdmJsV0hmOElSYkpCVlg4bFl3QXc2YmdZ?=
 =?utf-8?B?aVhzQTB0cUk5QUNrSUhQTXhqSjUvRzh5U1Uwc28vTm1UcXdFQU9JdEFCanYx?=
 =?utf-8?B?TGtLUkhFeGFjOXR5MmxrTnJyUWVPZmp4THRab0RXVFVWV0lVbkIzM2RVRjAx?=
 =?utf-8?B?bUVlS1JBcWhVc0d1WnQ2eEw0ZXdkWm9UamtPY0FLU0ZCVy8zOEs4QkVkMlho?=
 =?utf-8?B?MEJCbGc2b0NYNi81S091ZUVSWnU3U1hGS0E4U1c4cnVhU252c0JQQWNocWxL?=
 =?utf-8?B?RFRJV09MSDRkYWo0NlBTTlFSN2pGaVFLK0dURWw3RW1RM2FXWHdiMUJ3K2ta?=
 =?utf-8?B?Umgzd1QxSDVpeUp0bjJhM3pJak1vb0VLUmhTcjNHeElSdjRaakFDa1M3RE1R?=
 =?utf-8?B?TUJEc2M0K2hKSU9sOUNYZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHQzaFFNTWRZN0xzU2dTSG80aU9mU1RZdVVGNFliTy9KYVBaVHVpRXRzd1RX?=
 =?utf-8?B?UlRSWFBsVDhJZmF2d2hCSXlBQ1JHRGdVcXVtb0FHMFVHd1EyVFZiajhRdFNH?=
 =?utf-8?B?S29pSVN4VitmNVZvVS9wVDJRbXpSaEhHWVF0dnlNcVlGSGJwTFlwbHRPbVFR?=
 =?utf-8?B?MUpzTis1dGtvcVFoRUVJdTk5QUNMQmNLQVRWZUpveXlqL2VEWXpkcDl4ZXVL?=
 =?utf-8?B?c0FHQzJVZ0NMeUVjWHg0bXNwT3JETEw5YVF6aCt0R2E2Q3FNU3g2K1lGcVZT?=
 =?utf-8?B?QWxtRFY2c3g0bVdXVE9BVmM5UFRvYTlZS0FNenlCdThGYkJrMEFva3NsK0xS?=
 =?utf-8?B?cnBTSnhKdDY1eVpLRlhhTTFaZERSYm9oQTFUbjV0ZlZUcE1JeTVsdWRVY3dN?=
 =?utf-8?B?UjN2MmNYcC82OFg2UWkvUEJCQS9lSjZBRXhZOHNMVW02R2ZLUDd3N01KVUJ4?=
 =?utf-8?B?eDlDLzd4T3VDTVdPRTFKczNQZTYzdTBORW41ODJDeHltWUh5VW8vZ3FqZlpz?=
 =?utf-8?B?eGFNMTA0QzVNM250bkxmRHRPV3BSMzExYnhsYmF1MENHRE1HeUZZSEFxZ1Va?=
 =?utf-8?B?QmRQM1A3RDhmUGM2SEpIeTE3U3JsTjRQTlhPaXdBVXo0bmU5MW9uSG81NW9F?=
 =?utf-8?B?b2E0cXdOVlJNcG5mQzQ1STZEMVNEUngxdGIxMFE1MGV0cEdtVnYxaklzN2xn?=
 =?utf-8?B?Zi9rdUpIVGFXcUVjb2JBclNFNFUrQlRNbEljelpFb2xrWmtpSE9lQ0Jyencr?=
 =?utf-8?B?cjdHU3ZEdk9qTVF4ZERxUFA1YmVDZG1VK09taGxORC8rVEcwTW1kdXpFQ1da?=
 =?utf-8?B?TnJteVh5dEdZdDZKRFRqaU9hZjQ5eGdQWUJrUlpvMC9EN2F1SE5lNFFhMDV3?=
 =?utf-8?B?NDVkQXVmaUZseXZGRVJqb1AvZmRHYmxzZDdBcHVQSEVaT0p6Q2o2dTAwcEw3?=
 =?utf-8?B?UExtNHNtL0FDMUpaUk9JS0J5WjcyQ3BaazdpUHlNejdJdmpjSzlCYTRoemha?=
 =?utf-8?B?ZE9TNnZiVEIrMndEeDIyZjF3Qm9BZGhORkpxbkMwWE1OWkk1R0Q4V0R6ei9h?=
 =?utf-8?B?emtZKzJEay9PM0gwTks0RlJSaXEycHhtTi9LTGhkVWUrTUloMFdTZ1Zuemdx?=
 =?utf-8?B?NC9pV1NSdi81S2o4UEdkUEJBVXlYRVZ3Mk9MMHp6L055aGZqaE1SMnB3Q3lQ?=
 =?utf-8?B?ZHBPOXFDZ1MySnVXR1laUTZ6K016eWZ3WExjNzBpdFF3S0d0WE5nYlZ5alBt?=
 =?utf-8?B?aW5tUy9HdjdFZlNGQ2hOdm9CeFYyOHFsWHNENUovVUFVcG1uQ3NzTkFuUE1C?=
 =?utf-8?B?TGNFUkhCeFhMa0tDd2JMNzNXR0Z3Nmx5YzRDUlZWTGNwbDM5SVp5Tkk5V3pU?=
 =?utf-8?B?YlVRZlVNeUxNQ1NGNElpMkpiNzFZZ3pNMnpmc1JaMkpKUmtPSzlycmoxZHZY?=
 =?utf-8?B?RXh1QjVaemNOY3ZYU2kvZTlwNVdNK3E5WUszUFZPUXY4dVk4cEdQS2c0NmJL?=
 =?utf-8?B?Y0U3Z20xeE1CcEFEZklGOTNpMEovSlJqcGJxcWpucks0WU1DWG82OHMxamIw?=
 =?utf-8?B?RktqUGVlQ2ZmSWpvdnovcUxMU3pvMUdrK0kyVHNWTHhvRmM1SDY1QjlIc2tR?=
 =?utf-8?B?V2E5MXFabEpCNFdyNmIzMnRJZ3Y1SlVXTzcwOEU1VDhDV3R0RjU0VVdISmdw?=
 =?utf-8?B?cElFSUJnRXRQMEx2c1lvUDhGVUxuRFlCU0RaUFJwOGl2WjFoeUpwSFRmSEd6?=
 =?utf-8?B?MTN6K21WSWpTZWNCaksxNG9oeUxQWGFWRWdyelp1am5WQTFadkdRZ2dWbjdu?=
 =?utf-8?B?N1RzMEhmaTgyOXJ4cUp1YkU5WnUrVnR2SVBYSFRQSnMwakR3NUY2UEtkb3d2?=
 =?utf-8?B?NENRYnR1ZjNlN3RTNFBIdFVoWitraFVjaHk4TUJlZFVOV0ZvSWU0bUFtSFBq?=
 =?utf-8?B?bHl1dHJRZ3J2ZDNxbHAwM0hQdnowWGpTcG5PaUNscGQ5YnZ2dHpyVkR2VjY5?=
 =?utf-8?B?NzkxZjZobFJCbjllbGNhSGxRd1h0elNuT2k2KzQ2SUd3amxvT3RVeXlWSU91?=
 =?utf-8?B?VkNrNkxiOGlKYU5vQlNxRU56ZGc4NGwwMzFmdzdBdk1zREszM0tBcXNGcHhK?=
 =?utf-8?Q?QLQvFeinCOzcNGv52jgiascLp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1a7cd9-269a-43e1-09c8-08dcec061ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 04:10:14.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEerpjbV6/3XSJoMZePil1H12Lo8JjJccJgdKoeLf0cdIG7cfwoouJHE8G9cJ5EQwSeEBER7IwsePnSKoIyY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com

SGkgRHVhbiBDaGFuZ2hhbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBkdWFuY2hlbmdoYW8gPGR1YW5jaGVuZ2hhb0BreWxpbm9zLmNuPg0KPiBTZW50OiBNb25kYXks
IE9jdG9iZXIgMTQsIDIwMjQgNzoxMSBBTQ0KPiBUbzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFu
ZC5oYXJ2YXJkLmVkdT47IEdvcGFsLCBTYXJhbnlhDQo+IDxzYXJhbnlhLmdvcGFsQGludGVsLmNv
bT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEhvbmd5dSBY
aWUNCj4gPHh5NTIxNTIxQGdtYWlsLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVsLm9yZzsgbmlrby5tYXVub0B2YWlzYWxhLmNvbTsg
cGF2ZWxAdWN3LmN6Ow0KPiBzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tOyB0akBrZXJuZWwub3Jn
OyBIb25neXUgWGllDQo+IDx4aWVob25neXUxQGt5bGlub3MuY24+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFVTQjogRml4IHRoZSBpc3N1ZSBvZiB0YXNrIHJlY292ZXJ5IGZhaWx1cmUgY2F1c2Vk
DQo+IGJ5IFVTQiBzdGF0dXMgd2hlbiBTNCB3YWtlcyB1cA0KPiANCj4g5ZyoIDIwMjQtMTAtMTLm
mJ/mnJ/lha3nmoQgMTE6MDEgLTA0MDDvvIxBbGFuIFN0ZXJu5YaZ6YGT77yaDQo+IEhpIFNhcmFu
eWEsDQo+IA0KPiA+IE9uIFNhdCwgT2N0IDEyLCAyMDI0IGF0IDA1OjUxOjQxUE0gKzA4MDAsIGR1
YW5jaGVuZ2hhbyB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBBbGFuLA0KPiA+ID4NCj4gPiA+IFRo
ZSBWMyBwYXRjaCBoYXMgYmVlbiBzZW50LiBQbGVhc2UgcmV2aWV3IGl0IHRvIGNoZWNrIGlmIGl0
IGFsaWducw0KPiA+ID4gd2l0aA0KPiA+ID4gdGhlIHNvbHV0aW9uIHlvdSBkZXNjcmliZWQuDQo+
ID4NCj4gPiBZZXMsIHRoYXQgaXMgd2hhdCBJIG1lYW50Lg0KPiA+DQo+ID4gSGF2ZSB5b3UgYW5k
IGFsbCB0aGUgb3RoZXIgcGVvcGxlIGF0IGt5bGlub3MuY24gdGVzdGVkIHRoZSBwYXRjaCB0bw0K
PiA+IG1ha2UNCj4gPiBzdXJlIHRoYXQgaXQgZml4ZXMgdGhlIHByb2JsZW0/DQo+ID4NCj4gPiBB
bGFuIFN0ZXJuDQo+IA0KPiBJZiB5b3UgaGF2ZSB0aW1lLCB5b3UgY2FuIGFycmFuZ2UgdG8gdGVz
dCB5b3VyIGlzc3VlIHVzaW5nIHRoZSBWMw0KPiB2ZXJzaW9uLiBUaGlzIHdheSwgd2UgY2FuIGpv
aW50bHkgdmVyaWZ5IHdoZXRoZXIgdGhlIHByb2JsZW0gaGFzIGJlZW4NCj4gcmVzb2x2ZWQuDQo+
IA0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KSSB3aWxsIGFycmFuZ2UgYSBzeXN0ZW0gYnkgdG9t
b3Jyb3cgYW5kIHN0YXJ0IDE1MDAgY3ljbGVzIG9mIFM0IHdpdGggdGhlIFYzIHZlcnNpb24gb2Yg
eW91ciBwYXRjaC4NClBsZWFzZSBub3RlIHRoYXQgaXQgd2lsbCB0YWtlIHR3byBtb3JlIGRheXMg
ZnJvbSB0aGUgc3RhcnQgb2YgdGhlIHRlc3QgdG8gZ2V0IHRoZSByZXN1bHRzLg0KDQpUaGFua3Ms
DQpTYXJhbnlhDQoNCj4gVGhhbmtzDQo+IER1YW4gQ2hlbmdoYW8NCj4gDQo+IA0KDQo=

