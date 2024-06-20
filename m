Return-Path: <linux-pm+bounces-9652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1679091002C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924DA1F222EB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72B19B3D7;
	Thu, 20 Jun 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRfjzZOV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADF44C81;
	Thu, 20 Jun 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875283; cv=fail; b=D+7MldBEqS3lZc/4QXjp1VYz7FLImlXbwVUZFvoV2e+LqAzcoxIjukzGlj9WW54Ee+FC+YBKWHTrfumXrfX6lmOrx3qbKrQQ1MU9qODW0ZEs2OF74Khro5DIdljJPKGXiy7b4fDyo9nD+COE/5bhua4o6R38wzGkacZr71KpQsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875283; c=relaxed/simple;
	bh=Q+6AguKlpAVZZ/T65gr17HA6eIdiQSBwi5xYYPOgrEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlG0YROJSl85Za8nQq3GWylvZYV0hcQ04VICZBksHM6BheVii30mRBdDL9ZJNRj4B1dcx1AH/RaPKbQZSmkcla6troyMb0sCZqELoUWPdrOsnFApEq5dJIpoUvpn7E8NcXBrSBnmU3V9J1lnABqz92v6Ra64y+rsuvlpTBRfjwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRfjzZOV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718875281; x=1750411281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+6AguKlpAVZZ/T65gr17HA6eIdiQSBwi5xYYPOgrEg=;
  b=WRfjzZOVXjYVXTukGLSHoo/ChNtpJBK0hLzxtcyWBuW8EY3ZyQTZrWz/
   tsFqhv2xZH66qXaQfFKp5FDMv80CvpBZ51ciOC3oGJ9hzgcQ/iAu1bMDm
   YWyfNXg2VvVg/14Qamdjze6J5g3WOG+7pcTfWkdsgQJdYGlqKhz5d9QvI
   e+j1o9a8TkM5N/Vmk02bCXEQSF9OXiYec1lP8KgQ73PNvO+XaTaC3ATb/
   c1KVcBYFqUD8SuvlnC7l97Izo9ry8Pfztoozt7mDOVmOpXboAa/D7bQZ9
   qIvzuxlrif3JBLHymyiOmje7rZSyeSDcrVf5WsnE5RJ6k+2Wi/J+KAbjK
   w==;
X-CSE-ConnectionGUID: ATB/fmhQTveneyffOLcA9g==
X-CSE-MsgGUID: xidzVlPAQXq6DJZ9mosOqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26527489"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="26527489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 02:21:20 -0700
X-CSE-ConnectionGUID: tchhqnFuT6e6c8ZQiBjpPQ==
X-CSE-MsgGUID: hCFUA5prR46tKsPObCfZaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42637199"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 02:21:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 02:21:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 02:21:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 02:21:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 02:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEBoguQiYnFllCdnNdT4NsYAUDzKc/s9AtDr6/503UXOrawYWCsJqm+Cplpsx1l0FNypGwzs2n1HczuwDru65F+H1XkhpLinPGzrVziwKxM2PRBnrsokfrHoRVhJONf/IZDoNQXIJZ3M+Nq+74otA+nKfziSOKxc/VrudymOLAGjNMiX8HvHUmD2YDfk5zjCJO30Nzn+s4FXmLmKSZAB3OByso46ked7ZAPSH2tg5w5VyPoq1bwJ9FsMz6eVybpgbNUpk3ebXPjRqfVvZhiN7NyY9mtEI1uyzP/3Hp2ZQjqFiv/QXxVvHU9TCZeYWZ7Oo4L5HypLK0+TjqwfrNmiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+6AguKlpAVZZ/T65gr17HA6eIdiQSBwi5xYYPOgrEg=;
 b=N/x/7WA6DQLSKgthhcQOhLCTv6CuoE1HYf8JjfjNd9FyC4+MrJg/uyyH6IudBZZQOR8kfimxy2hCS6kex0oWDBUwCebTVAcD8RGiihH01YvY3gfFk+oxawYpXYFgqNymK2+m8R0RceegPaPxsxWavpEoUGSWQ+alOOdT7XaOTnHn77l1JfQ2EHZeqzQrhK/gZPgWxrAPuFU/JXvlqXx8FNLk+o4aMz92kd4plM6CBEodVHOFa5UTNDVEYauSuKRxKhFdz3+CENdUAxZdXRI/XTW/t9SZHdyGBfrPpxzTSQ+vImZwpW+4z5vKGL5oSjC6EoLRSjXLk8JpSTQb4A0v5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6354.namprd11.prod.outlook.com (2603:10b6:510:1fe::10)
 by SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Thu, 20 Jun
 2024 09:21:16 +0000
Received: from PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd]) by PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd%5]) with mapi id 15.20.7677.024; Thu, 20 Jun 2024
 09:21:16 +0000
From: "Chang, Kaiyen" <kaiyen.chang@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@ucw.cz" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
Thread-Topic: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
Thread-Index: AQHawXj/yPD6Vz0RO0SPrSFEIVx3WLHNxpcAgAKaOtA=
Date: Thu, 20 Jun 2024 09:21:16 +0000
Message-ID: <PH7PR11MB6354DCC37B04CE407AD5B7F593C82@PH7PR11MB6354.namprd11.prod.outlook.com>
References: <20240618121327.2177-1-kaiyen.chang@intel.com>
 <20240618121327.2177-2-kaiyen.chang@intel.com>
 <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com>
Accept-Language: zh-HK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6354:EE_|SN7PR11MB6800:EE_
x-ms-office365-filtering-correlation-id: 0708f37a-fa5c-480a-38ea-08dc910a56a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?TXk2bmRHcnM0RjA3VHI2SHFVa2dObjZWNDZsTnFZTWkxUlU4SXBxUE0va3da?=
 =?utf-8?B?eVhuSm1hQllmWjEzL29WQ0VDZ2NtTEFyS08vQnZvZ3EzTFZzQXR3Vk9KRDRB?=
 =?utf-8?B?WjJ4cTdUQmQxVVZnZ1BTMlBUVmg0aXROVlMraUJHUE1kaUFQdWp6emI3UFk3?=
 =?utf-8?B?QnY3ZnB5YUN6TlpyaS94VDljY2lsQjZjQlBydVJaeWk1M1FXaVlaQ0wrMjN2?=
 =?utf-8?B?YVArVzRlcHQ5Z25CZDI4b28wb01Ba2l5T2hqVHBrcE55RW9NK0xlbzZaNUN1?=
 =?utf-8?B?NW9BM2RtSnlkZ1A5a1NuckpodW1CMHBVcVlSbEgwYm1vQW9qdGNjcnZsWmFs?=
 =?utf-8?B?Mjdhcit0MzFIdnFQTE5ySFZUbjdZaElBV0VXa0hjSGs0K3NrbVZEbUgzSTly?=
 =?utf-8?B?UmFIVXplZitMdUhVVkUwMU9nUFB6MWsvRDZhMmZsZkduZStjT3FLcGNjK0Jz?=
 =?utf-8?B?ckhDRXlUVWNOa3pROWtwakZKck40Z2lLd1AyRk9xNm5MNFJDUStXYVJOaGJ6?=
 =?utf-8?B?eU5XRVVKSzZxOWNZMjErVkw0Y2MzdFluQk9ydENjeVV0amFLb3RINkhVVFQr?=
 =?utf-8?B?eFh4bjZtUitaWnVycG80TTlFN3ZhY1N5ek1yZHlTYXI1c1lOTXNHY2NKQ2p5?=
 =?utf-8?B?Y2p1MnRTWXdZYWtyc2hhbVU5S2xzNmhRUjk0VEVUcTlNKytlVDZIN3FoaHpV?=
 =?utf-8?B?djV3bndPWnREcWl0SmpwcVlVUTJMTU92MW5ldXZ6ZEJILytBVm5FK2I3QjJ3?=
 =?utf-8?B?OFFlVFBGYjlQbzlVOGpVU1NJVzBDM1JLVDBkN21ENlJyanpEVWpnbjYra3hu?=
 =?utf-8?B?MTlaalJ3NWlGaGQ3M3g0RkJpTFlrVXQ5elN4YzREUjVLeVZHTlNMd2JVMXdI?=
 =?utf-8?B?Nlo1TUthb2tXS0xJTFNDT2ZyTWR5cUtXeWx5RzZ3aHU1YjRWZWxPK1lDeW1j?=
 =?utf-8?B?aVhXTjc5ejhITWJNV0RyRUp2cVJ5Tjk0RkVQTS9kREV2T3J1RmlyRUY2aXlj?=
 =?utf-8?B?TXB4cHpFVHcrSkhEdDRSb1cyTCtIUG8vK1prSzk2OGlTYmhqZWxhUWRmQzZT?=
 =?utf-8?B?U0NyclM3a1hvYWM0NzJoVVVXV3VEYzdFRitlM3A2M0t2bEhlVmtNWE5GcDhQ?=
 =?utf-8?B?OCtXOStQK0sxcmdKY0VBNWhETXFzVE1XOXBGdEk1OFd1WXVaSnNtSWh3SG1a?=
 =?utf-8?B?ZWo5eDB0T3hCelhSMWhKTWR0QjVRbnFNOXMxQW9QcVhoTG9UcGdJUlZBK3FN?=
 =?utf-8?B?TlhRSDB6OXRYejNTckxvTU15K2l3Qm1QeERvd2hzallMdVJFZVJLSmZ1L3BJ?=
 =?utf-8?B?dkRQeFIrZ3R4Zm0zL2dNL1RNeFEvdTQrS0ZnVVFFRUNMaStKTGxDdWd0ZmlU?=
 =?utf-8?B?M05NV3Fza2ZWcXFPY1h5VHVUbVhyMnMvSGVHN3QrbDhEZWJ0NTJteWNqVk1P?=
 =?utf-8?B?ZFF2MlZJdEE4TFFQTG5TRndQdXUvcnZpUFRtSmw1ZXl3eExlN1A3OXpSd1BI?=
 =?utf-8?B?TWdVQ0JCQkdFdXRuMUlnR2lhMDhlVTNWMEZlNTh4bXhDQ2VZMnY0V1dNUHRa?=
 =?utf-8?B?K3NWNTRwSzhiQVNzQ3pnMUFQY0lOWjNJRmE1REs3ZWs5b01CWHgzU1QrVXBh?=
 =?utf-8?B?ME81WWRQVFVHa05UcklQL21lRXNjWWN2L3lSNjcrV01WTWwwMmsxMGJ3RWov?=
 =?utf-8?B?R3FFNGQxZWVzUXdpOVg0UzV0K3VwckRFSkR3TENSOHJBdXR3WVo0THJRaTFa?=
 =?utf-8?B?djF1RXcwZVB5VjhmZ0hWUndrdEoxMURhVkhKODJnZmtuR2c4SFAxM0RuMjF6?=
 =?utf-8?Q?hmMg4jmHqB5KRA91f1CFYCT5I2lpgoxJwIrls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE5mWFFBaTFPNUIwWmJKYzEyc2owbGtyTTd5OEtTMHdveVlKL1l1TkRzWHVW?=
 =?utf-8?B?djJOWFlZQnlERHJmSlRRQnRmQ2EvekxZRXR4YWptMUhzVVVoQjYyRFhCbVk3?=
 =?utf-8?B?aHZFbEMydkNPUjF3TUZTRm8yZXBCWGN4a3BYdVlYckQwK0xWZUNHNDNWY2lN?=
 =?utf-8?B?MDBFUDlYQmNUVFBZTVpjMG9jR21UcmxHMy9vTlgwM2hVb0w1aklVTjd1ZktL?=
 =?utf-8?B?VU11aEhOcDFXQlJkMmJZRXdZK2FjQVlDcG40SXE5SktlaDFHelR4elV2Rnpk?=
 =?utf-8?B?SUxEekNWOUJKSU5xbDZrczFVUmswTDM4OE1lcUttWGNVNjczUlhnTWhSVnFB?=
 =?utf-8?B?TFBwYlNQN1JzN0IzbU5vdHhPMHZ5TjZha0lWOHFoc3c5Zlg1L3pPRUZ1Y0x6?=
 =?utf-8?B?N2V6TWFxZzdtNjE3NWw4b2d3UmZJeDVhUm5UMHNXODJ5c0k5V28vcXIzZnVp?=
 =?utf-8?B?eUxHY2xES2ZOdVluRWVPTi9lSnJ4SzY1ZHJBWFp3RDJRNWsrdm1lQkhYQStX?=
 =?utf-8?B?MnYrYTdlQ1RYd2loSHVjMVJWa2gxZ083RFJaZmhVRjBITWVnLytlRndvUGpW?=
 =?utf-8?B?eHRVNmtUTlh6YnR4U09VWDBkZGZaeWJVNlYyZkE3VXlGc2NZVWdTS3JudWth?=
 =?utf-8?B?YjM3MHAySEUxenBBRXpXazBKNFBMVlB3OFJucTZpZWtZN3hsbThkM1BFTTdP?=
 =?utf-8?B?TlJQNERGRkZEK0Vxc3QrWmtmOFhMWXlHYkFiVVZlUGVXdWtGUk9RZW1MdURX?=
 =?utf-8?B?U29UZGVoQ3JoNUE3T2RLcmxHTkozdlFSS2dxb2sxbE1KNGhPNzhqR3htQUps?=
 =?utf-8?B?VVpBeWpOTXpUUGg4dzA2RjU3Y2pveEo0RUNhbmY4VVBhNFdEanZvajk4RUZQ?=
 =?utf-8?B?bWplV2VzOU9BMy9yczBOaE9KajBRRjVBSHRnUlRIeUlIdEpWUWFpMUJ0V1l1?=
 =?utf-8?B?WUdPc29SUGZmMHdGdWk2a3pQZHlLWDhZSXdsUW5Nb0c3Zmdaa092cXRkaGJp?=
 =?utf-8?B?MlZKNzJqNlZLTmkrU3NoTjZ5WHMwZzdwMjNHMkN0U3g3dk9DbWRuUDFCNXU4?=
 =?utf-8?B?MllkUFphVnBSZUt4UldWNkJaVEdKZU1WTjFSUU9qN1hEaVkyK2xlaTc4eVlx?=
 =?utf-8?B?SHBmbTFBb2x1VDBUN0NwMXlvcmt6b2lWY29zd3d5WVFoaGh5aCtocWZma0d6?=
 =?utf-8?B?UUIrZkExWllWUys2c1JFdnpVa2NOdDhyTDh1ZFBYU3BDVnc1cmtPVGU1dzZ4?=
 =?utf-8?B?ckJzclI2S3RnZHN0Tkwvam8xTFRRRVRYT0o3T01kOEdqNGFhT09IQnR2TDBi?=
 =?utf-8?B?UkVLL2dGaFVBQ1ozRUZWenlwallWWkdQRG9TSG1kVGlGVjkyR1N1UUttRU8x?=
 =?utf-8?B?VjFjMGhGRDFVNm9YQ3ZjQm9reGhvRFhRNGpMVHB6TFU3N2dsQzBNMVdCWTQv?=
 =?utf-8?B?QmpmQ1hMaDN5cDZQb3hhRUdXcCt4RjZJTG5Cd1YrTWhFUEF3WndQNFAybi9Y?=
 =?utf-8?B?TFVoR0JQRGxIRzhQNVM3UHlXcVFDcklJY3RSRjZNb3RLWnNnOUlLUHlSc25y?=
 =?utf-8?B?bVVFOXpzZjIwM25lbXViY1I3WkFSSWpzNThSeGxpU2FrWm1SelBqMSswTGhr?=
 =?utf-8?B?WkV0N1U0bTBqd2lxUUVrU0dHUFpBTjZ4UEtnWDB5dDhHeEZWRUJyYjJTcjRW?=
 =?utf-8?B?aUgxZkFmbEp2dldrdmJyQjRmWHI1UEl3aFN1elpUTm1FUXFLbDBkWGUrN1Jx?=
 =?utf-8?B?aDdodVJBQmt3TWtWT1JlR09iQjUzWmFQa0RJTGZ1d2ZLajBjb0Iya00zMTgw?=
 =?utf-8?B?azI2dkVNZlllMGoxV2hNWUgzbnY2QzQyN3Q4NVMzUmhWREZlaEJGNnNxTC9x?=
 =?utf-8?B?eUZ1SmxrMnR5QWtnWjBNbDZCNTlPNGxrUy9VaUV2R0pmWk4yamdaT0RRUHA4?=
 =?utf-8?B?dlNwNWx3bHBPdzkyVGpaOXlWWXNkU3ZqbmZ4aUk4K1pTRUFORlNwY25CNDVE?=
 =?utf-8?B?TzhRMFVnSy8zcDdwY2pwRTczcURFeENmR2tjZW9VZWxpWDBmNjJrbjFObkFo?=
 =?utf-8?B?Z1VTaGZ2c1RPS3htSCs1aXJjc1h4amc2aERLbi9ZQ3pSVTNBdURwNWE5YU5Y?=
 =?utf-8?Q?JMB+mzsULzFi3gTFbkaoZB/66?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708f37a-fa5c-480a-38ea-08dc910a56a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 09:21:16.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mltds6h5BhXki/VKcHPCafMjdSp1aud8UrCQN9vpMMSaCyOc9UIVRbZay0Vh9NToILhyx4f4wq7u/63LiMI1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
X-OriginatorOrg: intel.com

T24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgMDc6Mjc6MThQTSArMDIwMCwgUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDE4LCAyMDI0
IGF0IDI6MTPigK9QTSBLYWl5ZW4gQ2hhbmcgPGthaXllbi5jaGFuZ0BpbnRlbC5jb20+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gQ3VycmVudGx5LCB3aGVuIHBlcmZvcm1pbmcgYSBzdXNwZW5kIG9wZXJh
dGlvbiwgYWxsIGRldmljZXMgb24gdGhlDQo+ID4gZHBtX2xpc3QgbXVzdCB3YWl0IGZvciB0aGUg
InN5bmNocm9ub3VzIiBkZXZpY2VzIHRoYXQgYXJlIGxpc3RlZCBhZnRlcg0KPiA+IHRoZW0gdG8g
Y29tcGxldGUgYmVmb3JlIHRoZSBtYWluIHN1c3BlbmQgdGhyZWFkIGNhbiBzdGFydCB0aGVpcg0K
PiA+IHN1c3BlbmQgcm91dGluZXMsIGV2ZW4gaWYgdGhleSBhcmUgImFzeW5jaHJvbm91cyIuIElm
IHRoZSBzdXNwZW5kDQo+ID4gcm91dGluZSBvZiBhIHN5bmNocm9ub3VzIGRldmljZSBtdXN0IGVu
dGVyIGEgd2FpdGluZyBzdGF0ZSBmb3Igc29tZQ0KPiA+IHJlYXNvbiwgaXQgd2lsbCBjYXVzZSB0
aGUgbWFpbiBzdXNwZW5kIHRocmVhZCB0byBnbyB0byBzbGVlcCwgdGhlcmVieQ0KPiA+IGRlbGF5
aW5nIHRoZSBwcm9jZXNzaW5nIG9mIGFsbCBzdWJzZXF1ZW50IGRldmljZXMsIGluY2x1ZGluZw0K
PiA+IGFzeW5jaHJvbm91cyBvbmVzLCB1bHRpbWF0ZWx5IGV4dGVuZGluZyB0aGUgb3ZlcmFsbCBz
dXNwZW5kIHRpbWUuDQo+ID4NCj4gPiBCeSBzdGFydGluZyB0aGUgYXN5bmNocm9ub3VzIHN1c3Bl
bmQgdGhyZWFkcyB1cGZyb250LCB3ZSBjYW4gYWxsb3cgdGhlDQo+ID4gc3lzdGVtIHRvIGhhbmRs
ZSB0aGUgc3VzcGVuZCByb3V0aW5lcyBvZiB0aGVzZSBhc3luY2hyb25vdXMgZGV2aWNlcyBpbg0K
PiA+IHBhcmFsbGVsLCB3aXRob3V0IHdhaXRpbmcgZm9yIHRoZSBzdXNwZW5kIHJvdXRpbmVzIG9m
IHRoZSBzeW5jaHJvbm91cw0KPiA+IGRldmljZXMgbGlzdGVkIGFmdGVyIHRoZW0gdG8gY29tcGxl
dGUsIGFuZCB3aXRob3V0IGJyZWFraW5nIHRoZWlyDQo+ID4gb3JkZXIgd2l0aCByZXNwZWN0IHRv
IHRoZWlyIHBhcmVudHMgYW5kIGNoaWxkcmVuLg0KPiA+IFRoaXMgd2F5LCBldmVuIGlmIHRoZSBt
YWluIHN1c3BlbmQgdGhyZWFkIGlzIGJsb2NrZWQsIHRoZXNlDQo+ID4gYXN5bmNocm9ub3VzIHN1
c3BlbmQgdGhyZWFkcyBjYW4gY29udGludWUgdG8gcnVuIHdpdGhvdXQgYmVpbmcNCj4gPiBhZmZl
Y3RlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaXllbiBDaGFuZyA8a2FpeWVuLmNoYW5n
QGludGVsLmNvbT4NCj4gDQo+IEhvdyBleGFjdGx5IGhhcyB0aGlzIGJlZW4gdGVzdGVkPw0KPiAN
Cj4gSW4gdGhlIHBhc3QsIGNoYW5nZXMgZ29pbmcgaW4gdGhpcyBkaXJlY3Rpb24gY2F1c2VkIHN5
c3RlbSBzdXNwZW5kIHRvIGhhbmcgb24NCj4gYXQgbGVhc3Qgc29tZSBwbGF0Zm9ybXMgKGluY2x1
ZGluZyB0aGUgb25lcyBpbiBteSBvZmZpY2UpLg0KPiANCg0KSGkgUmFmYWVsLCB0aGFua3MgZm9y
IHlvdXIgcmVwbHkuDQoNCjEuIFdlIGhhdmUgY3VycmVudGx5IHZlcmlmaWVkIHRoaXMgcGF0Y2gg
b24gdGhlIEFETC1OIENocm9tZWJvb2ssIHJ1bm5pbmcgdGhlIHN1c3BlbmQgc3RyZXNzIHRlc3Qg
MTAwMCB0aW1lcyBjb25zZWN1dGl2ZWx5IHdpdGhvdXQgZW5jb3VudGVyaW5nIGFueSBpc3N1ZXMu
DQoNCjIuIENvdWxkIHlvdSB0ZWxsIHVzIHdoYXQgd2FzIHRoZSByZWFzb24gZm9yIHN1c3BlbmQg
dG8gaGFuZyBiYWNrIHRoZW4/DQoNClRoZSByZWFzb24gd2h5IEkgYmVsaWV2ZSB0aGF0IHdlIGNh
biBzdGFydCB0aGUgYXN5bmMgZGV2aWNlJ3Mgc3VzcGVuZCB0aHJlYWRzIHVwZnJvbnQgaXMgdGhh
dCwgZHVyaW5nIHJlc3VtZSwgYSBzeW5jIGRldmljZXMgbGlzdGVkIGFmdGVyIGNlcnRhaW4gYXN5
bmMgZGV2aWNlcyBvbiB0aGUgbGlzdCBkbyBub3QgYWN0dWFsbHkgcmVseSBvbiB0aGUgaW1wbGlj
aXQgZGVwZW5kZW5jeSBwcm92aWRlZCBieSB0aGUgb3JkZXIgb2YgdGhlIGRldmljZXMgb24gdGhl
IGxpc3QuIFRoaXMgaXMgYmVjYXVzZSBpZiB0aGVyZSBpcyBubyBjb25zdW1lci1zdXBwbGllciBv
ciBwYXJlbnQtY2hpbGRyZW4gcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlc2UgZGV2aWNlcywgdGhl
IHN1c3BlbmQgcm91dGluZSBvZiB0aGlzIHN5bmMgZGV2aWNlIHdpbGwgYmUgZXhlY3V0ZWQgZGly
ZWN0bHkgd2l0aG91dCB3YWl0aW5nIGZvciB0aGUgc3VzcGVuZCByb3V0aW5lcyBvZiB0aGUgYXN5
bmMgZGV2aWNlcyBsaXN0ZWQgYmVmb3JlIGl0IHRvIGNvbXBsZXRlLiBJbiBvdGhlciB3b3Jkcywg
dGhpcyBzeW5jIGRldmljZSBkb2VzIG5vdCBkZXBlbmQgb24gdGhlIGFzeW5jIGRldmljZXMgbGlz
dGVkIGJlZm9yZSB0aGVtLiBUaGVyZWZvcmUsIGR1cmluZyBzdXNwZW5kLCB0aGVyZSBpcyBubyBu
ZWVkIHRvIGVuc3VyZSB0aG9zZSBhc3luYyBkZXZpY2VzIGxpc3RlZCBiZWZvcmUgdGhlIHN5bmMg
ZGV2aWNlcyBhcmUgYXdha2UgYmVmb3JlIHRoZXNlIHN5bmMgZGV2aWNlcyBjb21wbGV0ZSB0aGVp
ciBzdXNwZW5kIHJvdXRpbmVzLiBJbiBzdW1tYXJ5LCBhcyBsb25nIGFzIHdlIG1hbmFnZSB0aGUg
ZGVwZW5kZW5jaWVzIGJldHdlZW4gY29uc3VtZXJzL3N1cHBsaWVycyBhbmQgcGFyZW50cy9jaGls
ZHJlbiByZWxhdGlvbnNoaXBzIHByb3Blcmx5LCB3ZSBzaG91bGQgYmUgYWJsZSB0byBzdGFydCB0
aGUgYXN5bmMgZGV2aWNlcycgc3VzcGVuZCByb3V0aW5lcyB1cGZyb250IGR1cmluZyBzdXNwZW5k
Lg0KDQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGZyb20gdjE6IEZpeCBzb21lIHVuY2xlYXIgcGFydHMg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlcy4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9iYXNlL3Bvd2Vy
L21haW4uYyB8IDkwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIGIvZHJpdmVy
cy9iYXNlL3Bvd2VyL21haW4uYw0KPiA+IGluZGV4IDRhNjdlODMzMDBlMS4uNmRkZDZlZjM2NjI1
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMNCj4gPiArKysgYi9k
cml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jDQo+ID4gQEAgLTEyODMsNiArMTI4Myw3IEBAIHN0YXRp
YyB2b2lkIGFzeW5jX3N1c3BlbmRfbm9pcnEodm9pZCAqZGF0YSwNCj4gPiBhc3luY19jb29raWVf
dCBjb29raWUpDQo+ID4NCj4gPiAgc3RhdGljIGludCBkcG1fbm9pcnFfc3VzcGVuZF9kZXZpY2Vz
KHBtX21lc3NhZ2VfdCBzdGF0ZSkgIHsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsN
Cj4gPiAgICAgICAgIGt0aW1lX3Qgc3RhcnR0aW1lID0ga3RpbWVfZ2V0KCk7DQo+ID4gICAgICAg
ICBpbnQgZXJyb3IgPSAwOw0KPiA+DQo+ID4gQEAgLTEyOTMsMjYgKzEyOTQsMzMgQEAgc3RhdGlj
IGludA0KPiA+IGRwbV9ub2lycV9zdXNwZW5kX2RldmljZXMocG1fbWVzc2FnZV90IHN0YXRlKQ0K
PiA+DQo+ID4gICAgICAgICBtdXRleF9sb2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+DQo+ID4gKyAg
ICAgICAvKg0KPiA+ICsgICAgICAgICogVHJpZ2dlciB0aGUgc3VzcGVuZCBvZiAiYXN5bmMiIGRl
dmljZXMgdXBmcm9udCBzbyB0aGV5IGRvbid0DQo+IGhhdmUgdG8NCj4gPiArICAgICAgICAqIHdh
aXQgZm9yIHRoZSAibm9uLWFzeW5jIiBvbmVzIHRoYXQgZG9uJ3QgZGVwZW5kIG9uIHRoZW0uDQo+
ID4gKyAgICAgICAgKi8NCj4gPiArDQo+ID4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3Jl
dmVyc2UoZGV2LCAmZHBtX2xhdGVfZWFybHlfbGlzdCwNCj4gcG93ZXIuZW50cnkpDQo+ID4gKyAg
ICAgICAgICAgICAgIGRwbV9hc3luY19mbihkZXYsIGFzeW5jX3N1c3BlbmRfbm9pcnEpOw0KPiA+
ICsNCj4gPiAgICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgmZHBtX2xhdGVfZWFybHlfbGlzdCkp
IHsNCj4gPiAtICAgICAgICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0NCj4gdG9fZGV2aWNl
KGRwbV9sYXRlX2Vhcmx5X2xpc3QucHJldik7DQo+ID4gKyAgICAgICAgICAgICAgIGRldiA9IHRv
X2RldmljZShkcG1fbGF0ZV9lYXJseV9saXN0LnByZXYpOw0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgIGxpc3RfbW92ZSgmZGV2LT5wb3dlci5lbnRyeSwgJmRwbV9ub2lycV9saXN0KTsNCj4gPg0K
PiA+IC0gICAgICAgICAgICAgICBpZiAoZHBtX2FzeW5jX2ZuKGRldiwgYXN5bmNfc3VzcGVuZF9u
b2lycSkpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gLQ0KPiA+
IC0gICAgICAgICAgICAgICBnZXRfZGV2aWNlKGRldik7DQo+ID4gKyAgICAgICAgICAgICAgIGlm
ICghZGV2LT5wb3dlci5hc3luY19pbl9wcm9ncmVzcykgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGdldF9kZXZpY2UoZGV2KTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBtdXRleF91
bmxvY2soJmRwbV9saXN0X210eCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhf
dW5sb2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIGVycm9yID0g
ZGV2aWNlX3N1c3BlbmRfbm9pcnEoZGV2LCBzdGF0ZSwgZmFsc2UpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGVycm9yID0gZGV2aWNlX3N1c3BlbmRfbm9pcnEoZGV2LCBzdGF0ZSwNCj4g
PiArIGZhbHNlKTsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBwdXRfZGV2aWNlKGRldik7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcHV0X2RldmljZShkZXYpOw0KPiA+DQo+ID4gLSAg
ICAgICAgICAgICAgIG11dGV4X2xvY2soJmRwbV9saXN0X210eCk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgbXV0ZXhfbG9jaygmZHBtX2xpc3RfbXR4KTsNCj4gPg0KPiA+IC0gICAgICAg
ICAgICAgICBpZiAoZXJyb3IgfHwgYXN5bmNfZXJyb3IpDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycm9yIHx8IGFz
eW5jX2Vycm9yKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgbXV0
ZXhfdW5sb2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+IEBAIC0xNDU0LDYgKzE0NjIsNyBAQCBzdGF0
aWMgdm9pZCBhc3luY19zdXNwZW5kX2xhdGUodm9pZCAqZGF0YSwNCj4gYXN5bmNfY29va2llX3Qg
Y29va2llKQ0KPiA+ICAgKi8NCj4gPiAgaW50IGRwbV9zdXNwZW5kX2xhdGUocG1fbWVzc2FnZV90
IHN0YXRlKSAgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICAgICAgICAg
a3RpbWVfdCBzdGFydHRpbWUgPSBrdGltZV9nZXQoKTsNCj4gPiAgICAgICAgIGludCBlcnJvciA9
IDA7DQo+ID4NCj4gPiBAQCAtMTQ2NiwyNiArMTQ3NSwzMyBAQCBpbnQgZHBtX3N1c3BlbmRfbGF0
ZShwbV9tZXNzYWdlX3Qgc3RhdGUpDQo+ID4NCj4gPiAgICAgICAgIG11dGV4X2xvY2soJmRwbV9s
aXN0X210eCk7DQo+ID4NCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBUcmlnZ2VyIHRo
ZSBzdXNwZW5kIG9mICJhc3luYyIgZGV2aWNlcyB1cGZyb250IHNvIHRoZXkgZG9uJ3QNCj4gaGF2
ZSB0bw0KPiA+ICsgICAgICAgICogd2FpdCBmb3IgdGhlICJub24tYXN5bmMiIG9uZXMgdGhhdCBk
b24ndCBkZXBlbmQgb24gdGhlbS4NCj4gPiArICAgICAgICAqLw0KPiA+ICsNCj4gPiArICAgICAg
IGxpc3RfZm9yX2VhY2hfZW50cnlfcmV2ZXJzZShkZXYsICZkcG1fc3VzcGVuZGVkX2xpc3QsDQo+
IHBvd2VyLmVudHJ5KQ0KPiA+ICsgICAgICAgICAgICAgICBkcG1fYXN5bmNfZm4oZGV2LCBhc3lu
Y19zdXNwZW5kX2xhdGUpOw0KPiA+ICsNCj4gPiAgICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgm
ZHBtX3N1c3BlbmRlZF9saXN0KSkgew0KPiA+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNl
ICpkZXYgPQ0KPiB0b19kZXZpY2UoZHBtX3N1c3BlbmRlZF9saXN0LnByZXYpOw0KPiA+ICsgICAg
ICAgICAgICAgICBkZXYgPSB0b19kZXZpY2UoZHBtX3N1c3BlbmRlZF9saXN0LnByZXYpOw0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgIGxpc3RfbW92ZSgmZGV2LT5wb3dlci5lbnRyeSwgJmRwbV9s
YXRlX2Vhcmx5X2xpc3QpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChkcG1fYXN5bmNf
Zm4oZGV2LCBhc3luY19zdXNwZW5kX2xhdGUpKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPiA+IC0NCj4gPiAtICAgICAgICAgICAgICAgZ2V0X2RldmljZShkZXYpOw0K
PiA+ICsgICAgICAgICAgICAgICBpZiAoIWRldi0+cG93ZXIuYXN5bmNfaW5fcHJvZ3Jlc3MpIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnZXRfZGV2aWNlKGRldik7DQo+ID4NCj4gPiAt
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZHBtX2xpc3RfbXR4KTsNCj4gPg0KPiA+IC0g
ICAgICAgICAgICAgICBlcnJvciA9IGRldmljZV9zdXNwZW5kX2xhdGUoZGV2LCBzdGF0ZSwgZmFs
c2UpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVycm9yID0gZGV2aWNlX3N1c3BlbmRf
bGF0ZShkZXYsIHN0YXRlLA0KPiA+ICsgZmFsc2UpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
IHB1dF9kZXZpY2UoZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwdXRfZGV2aWNl
KGRldik7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmZHBtX2xpc3RfbXR4
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZkcG1fbGlzdF9tdHgp
Ow0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChlcnJvciB8fCBhc3luY19lcnJvcikNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoZXJyb3IgfHwgYXN5bmNfZXJyb3IpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4gICAgICAgICBtdXRleF91bmxvY2soJmRwbV9saXN0X210eCk7DQo+ID4gQEAgLTE3
MTksNiArMTczNSw3IEBAIHN0YXRpYyB2b2lkIGFzeW5jX3N1c3BlbmQodm9pZCAqZGF0YSwNCj4g
YXN5bmNfY29va2llX3QgY29va2llKQ0KPiA+ICAgKi8NCj4gPiAgaW50IGRwbV9zdXNwZW5kKHBt
X21lc3NhZ2VfdCBzdGF0ZSkNCj4gPiAgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2
Ow0KPiA+ICAgICAgICAga3RpbWVfdCBzdGFydHRpbWUgPSBrdGltZV9nZXQoKTsNCj4gPiAgICAg
ICAgIGludCBlcnJvciA9IDA7DQo+ID4NCj4gPiBAQCAtMTczMywyNiArMTc1MCwzMyBAQCBpbnQg
ZHBtX3N1c3BlbmQocG1fbWVzc2FnZV90IHN0YXRlKQ0KPiA+DQo+ID4gICAgICAgICBtdXRleF9s
b2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICog
VHJpZ2dlciB0aGUgc3VzcGVuZCBvZiAiYXN5bmMiIGRldmljZXMgdXBmcm9udCBzbyB0aGV5IGRv
bid0DQo+IGhhdmUgdG8NCj4gPiArICAgICAgICAqIHdhaXQgZm9yIHRoZSAibm9uLWFzeW5jIiBv
bmVzIHRoYXQgZG9uJ3QgZGVwZW5kIG9uIHRoZW0uDQo+ID4gKyAgICAgICAgKi8NCj4gPiArDQo+
ID4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JldmVyc2UoZGV2LCAmZHBtX3ByZXBhcmVk
X2xpc3QsDQo+IHBvd2VyLmVudHJ5KQ0KPiA+ICsgICAgICAgICAgICAgICBkcG1fYXN5bmNfZm4o
ZGV2LCBhc3luY19zdXNwZW5kKTsNCj4gPiArDQo+ID4gICAgICAgICB3aGlsZSAoIWxpc3RfZW1w
dHkoJmRwbV9wcmVwYXJlZF9saXN0KSkgew0KPiA+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgZGV2
aWNlICpkZXYgPSB0b19kZXZpY2UoZHBtX3ByZXBhcmVkX2xpc3QucHJldik7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldiA9IHRvX2RldmljZShkcG1fcHJlcGFyZWRfbGlzdC5wcmV2KTsNCj4gPg0K
PiA+ICAgICAgICAgICAgICAgICBsaXN0X21vdmUoJmRldi0+cG93ZXIuZW50cnksICZkcG1fc3Vz
cGVuZGVkX2xpc3QpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChkcG1fYXN5bmNfZm4o
ZGV2LCBhc3luY19zdXNwZW5kKSkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIGdldF9kZXZpY2UoZGV2KTsNCj4gPiArICAg
ICAgICAgICAgICAgaWYgKCFkZXYtPnBvd2VyLmFzeW5jX2luX3Byb2dyZXNzKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZ2V0X2RldmljZShkZXYpOw0KPiA+DQo+ID4gLSAgICAgICAg
ICAgICAgIG11dGV4X3VubG9jaygmZHBtX2xpc3RfbXR4KTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBtdXRleF91bmxvY2soJmRwbV9saXN0X210eCk7DQo+ID4NCj4gPiAtICAgICAgICAg
ICAgICAgZXJyb3IgPSBkZXZpY2Vfc3VzcGVuZChkZXYsIHN0YXRlLCBmYWxzZSk7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZXJyb3IgPSBkZXZpY2Vfc3VzcGVuZChkZXYsIHN0YXRlLCBm
YWxzZSk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgcHV0X2RldmljZShkZXYpOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHB1dF9kZXZpY2UoZGV2KTsNCj4gPg0KPiA+IC0gICAgICAg
ICAgICAgICBtdXRleF9sb2NrKCZkcG1fbGlzdF9tdHgpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIG11dGV4X2xvY2soJmRwbV9saXN0X210eCk7DQo+ID4NCj4gPiAtICAgICAgICAgICAg
ICAgaWYgKGVycm9yIHx8IGFzeW5jX2Vycm9yKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnJvciB8fCBhc3luY19l
cnJvcikNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsg
ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIG11dGV4X3Vu
bG9jaygmZHBtX2xpc3RfbXR4KTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=

