Return-Path: <linux-pm+bounces-36538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA41BF49D7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 07:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0552C18A7EB1
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAA49620;
	Tue, 21 Oct 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OymD/feU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577B63CB
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023158; cv=fail; b=Yvoh6JxW3sDx6ONo/R6D/XaC6/NV0FzriFFnQaQt6LzZf8auBjz4F/lD66rXncRuyMQ611UGAyNX/t/CL7JdzyA+gwhp+1OZi/w4bSkmW718Bg3aRVdYVYwdHdmkXLJk//O0l4NQUS4d0mdAzCGI9ibz0T34+UN/XtmMe3r6lq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023158; c=relaxed/simple;
	bh=BNAjxNZWhV1rAklHcJsWOCv284h0IpGcVYauHZ9JSJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8YolGGinezZVXSAZ14E4WMmKa6vs7T7ULHoQjps+tpgNFXo6dvjyXuy27G3YyWvscLkUm5/0RG5QBmu3ROKbK8GyFMySMT5+r4f29uM/e5DHa5yDCcUnYQ3kwCfuyMqbDvYeAEPHvNNFykzMO09ND9TP8s9Txhd6Wg9v49E1m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OymD/feU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761023156; x=1792559156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BNAjxNZWhV1rAklHcJsWOCv284h0IpGcVYauHZ9JSJ4=;
  b=OymD/feU8y5JiR6ADqcH6tU86djkres/54oPOuA+G2ZBfMtczNh7dOhG
   RNnF69Qmi+8qQnDmRhMi4JCW/uZVu8YNFhCS+45EhZjnkJ/ADQCQmJlif
   hURhodFFAGsbDzvP2pG3BuPv4FV5YV0TUSftDUGz0z8EzAFvcSRyttIWR
   PKlP/IFpQRjpY6Bew+iLWgEowRDH6aSiap9b2zfPKGOc3+zzrWvnBN7Lf
   uOz2dGlsr6Arp9gUwtuHvFaGle43QIuD2g6hcItQOc3otAfAUI+kbuIhy
   P0YwgNQJeGf/ev4QHXvkl360kkPwwjC0pq5RKWbgpFzPBtuddWDg0kegy
   g==;
X-CSE-ConnectionGUID: G9FgeGZoThC3oiES9Xniyg==
X-CSE-MsgGUID: VFhexYrkT3+Hx8gY5QgPYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62352324"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="62352324"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:05:55 -0700
X-CSE-ConnectionGUID: yKYvbWPVQE+Vyr+Fkogkvw==
X-CSE-MsgGUID: iNFRPAlkT6eq54oHC4lzJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182647031"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:05:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:05:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 22:05:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqnp6ETHDHlDuZ/0n+/QaA3KaY3mOJEIqGzSPok7Ed6GYyyycdfbaQxol9m/VXj+OAV5syxu4QtTlDUnDPcIpbq7LwN+2DYg0qNUjCmWQUHH75kfwpzxGAtDaIKdWjCz6L4beBmyS99QK+3UC0195z+XaU43JCgauij/E3RTlPwh7OgsglR1BoQqRLL4xdgxLFOr+T37jgFRe8gtn8PhL08QMbIy3HycFKZpqas49U8jrhJI+7Q3QhRjsctUfCjOYRWNX+wTz+/bivjMfnqseAoPa/Xa4Mti0xGg/5Zy2m1lKC7BWSpcl6or0LwDfxfDjvIQwj8pRLECAGzorwiYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNAjxNZWhV1rAklHcJsWOCv284h0IpGcVYauHZ9JSJ4=;
 b=ZkZIl65i5RyInD7LFmiLCsQ/q260jsW6KpT2TBt4Z/wp/Z4Mbo/6BUSjoKVe6JQVZj3cay9Lns1idjhQk/mhKqannuveOXM5OrQeyYgavut5fkyqBBwyXyJ5zIVRNfgg/d5kYU9uLkKGGeVTlJLDYhj298x8EtaLCI8c+S0bRkgZw6ojnWiJuBo4Zao1zI/iaZHoIiU3omcABTIc2UShEBRwtP91k+Qg0ovkLBhCVhvbU+1CtKpATQyg9tRtEjQhT/xlDKxUVblho8jf/4nkDROFiZZyYnmwpnNwyIeOcn6GV85hzg97J9fRjtkf5CmN2fvFHcRoPkJncWobSXk66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DS0PR11MB8229.namprd11.prod.outlook.com (2603:10b6:8:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 05:05:53 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:05:53 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2] PM: Delete timer before removing wakeup source from
 list
Thread-Topic: [PATCH v2] PM: Delete timer before removing wakeup source from
 list
Thread-Index: AQHcQevGKt9du9sQMEOw8D/lJI5SLLTMC7NQ
Date: Tue, 21 Oct 2025 05:05:53 +0000
Message-ID: <LV3PR11MB8768D0F5FA35447A22CAE898F5F2A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iYUeaoTRr3nowwL-pzXCD1UVoXrhO-hjsuzCif+-JxaA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYUeaoTRr3nowwL-pzXCD1UVoXrhO-hjsuzCif+-JxaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DS0PR11MB8229:EE_
x-ms-office365-filtering-correlation-id: c97718ad-73ca-4937-8615-08de105f82b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S1dmT2EvaWk3aEovdjJqNjlwMFBJVVN0TDBKY1JaZlFxNjFTc0NPT1VOSXhW?=
 =?utf-8?B?dUVZRkxBUG0xSURUWlZWa1ZaNlc2VSttNFgwbGRJVnR3QzAxTU1SZXZUcmUr?=
 =?utf-8?B?V1J1WERwOHFzREE4UUtWK2RtRWRnVi9qSnAwbjdQNDJuM0s1cmNpa2ZaUFo1?=
 =?utf-8?B?Si9mbGU3NWRQQk1zZ210N0NSRjhRaHhISi95ZEFtUVAydVV6aVJyRmJjUTZy?=
 =?utf-8?B?bUJTdVlmdVlPVm16QnFuaU9zNU83Y1JKZlFqTU9OcFYxWHFCZVZwZWhCU1RE?=
 =?utf-8?B?VGhkang0TkJPa1FZQ1ZHcDczZWRJQlFyVk92KzRIWk5Ob2JGUmV2T3UvK0xn?=
 =?utf-8?B?aVdTS3pnSWVtbk01cWtUS284aW5VcmhzNlRkQWV1UHVFc0Y5ZXZ5citnWS9r?=
 =?utf-8?B?aWFOK09ZYkpSTDVWQ2ZtbnlIcUFtM0JpL0VVaHVQU1dIdktIb1pOVCswck9Q?=
 =?utf-8?B?akExM3FIZXBNTzJYNENtNlJzajE5S0xBdUtnOGxQRFlWRjk2OVFOUVBYaHlJ?=
 =?utf-8?B?RDlJK3NNUk5SdWpqWkR5MzZscGYxbG1Ldm5NSWxMb1BsdjB4MEcvVUlTb3Ja?=
 =?utf-8?B?ay9ocGp5S3hLVm1aTFlYVWczMGNFcWhibzQ3N014ejdIcGtwNVRPcGR3NFFa?=
 =?utf-8?B?Nkd2bXJZMi9yZ0hkT04yVWRnRzBRQ1RaQ1ZMZmNHdVZpaXlGc1FvTE9saE1q?=
 =?utf-8?B?ZWVxdEhYazFrdTJzKzhRZm9zUko3ZTEwcFBYb2FKc0lSalIycnRpK01NNE95?=
 =?utf-8?B?NkFhb1JFSGM0ZUFRVHFrbkdJTStqdFBjUlFTTVYyVzRVQ1RBcEV2dVFtekpa?=
 =?utf-8?B?RCtYK3ErUEE1VDlzckM3NXpYZzh4L1pBRHF6QS9yek43MHcrcFFNdWF2RHdm?=
 =?utf-8?B?S2hDdXB0d0JibzVlZUt2LzlvYnIyTllXeS9kZkJ6bjUwMlJsdDFEU0lYbnNa?=
 =?utf-8?B?WXZSTkJEYXIvZWhhNG1BRzRleDBETXZCSmg2M3BjbkRnUlFNQml4WVdaeWdj?=
 =?utf-8?B?YW9ocEJEOEp6U01SeUp3YlNlYXlEbDF3emdRS09tejUyVTVVbXV3RElkUTIx?=
 =?utf-8?B?QlI0a0RxeldEaHo2MXIzbDhIQ2lPakRZdmgrMnZFS0FqZTB2U3M0eHFCL2Ex?=
 =?utf-8?B?RnRjc2d1K0NRL08wSHhRUzExU3BhK0hCd2hIQWQ2elhMdDI0ZWgvRE55MDlH?=
 =?utf-8?B?czhNTmtLUnJCMnVFazFFZnZPMHYrRjRYYTZWK0lTVG1Ja0hXb0R1S1QzZTV6?=
 =?utf-8?B?UVFBbG10UGxwSFlTMXFlVWdGQWZxNGMxenJNakJPMFlpWXEycktUNURlVFd4?=
 =?utf-8?B?NDdYS1dnS1NqSWhlblF2N3VlUGdmZTRPYXM5UGZyZkEyYWI0bTFxSmt0M0FT?=
 =?utf-8?B?cS9tMlUybmRFc3JkZm9pYkFqNVdDa3h6UWFwY0orcVRwY29sN2VYb2JRVzdB?=
 =?utf-8?B?RUZ5dFlack1Za1F2YzZIeG9FNFVlQzBhdlNrZ2xvM3oreFBKQi9xTXZPaE9t?=
 =?utf-8?B?eUlySkZvdU9xSXYrSEJXMzVBeFNBdk4xd25jSXVPblZxK1VQY3BheTk2ekQ1?=
 =?utf-8?B?UktlSFpOc0xabk9FTGhQbkJHaGN2T0pDV1V0bUJnUXY0UHNqelErblcwLzhX?=
 =?utf-8?B?dE5PWUU1dWk1WE9KQVlUSHdBWk5BVnBHV1BmREd1VjZGVTFzaWVtaUkwbElN?=
 =?utf-8?B?RC9vVHdwMlhEaHRJcGh1dU1ibVRvSXFybXlwaUJrWnVRNlRsQTRucXFXUmFq?=
 =?utf-8?B?YVFSSjlBcWtxRmxTK0xlYlZ4RTBjVmhmTm55RFFXelgzMUYwMitzTnlrSE10?=
 =?utf-8?B?TnZucGJuOEJBUHNUdTBBeEh0L1E3eVZuVjI0eVgyajZhaENiY21DcHJZN0t1?=
 =?utf-8?B?VWVNWUM5Qy9sQ0g3Z2lFbm5TMHZMOUFSZG9YRjhVTU13dDMrcms3VGwzenlK?=
 =?utf-8?B?ak42V1ozcGY3WDNBb0Q3ZW9CTDVYVGRMS2pCWWNiTWVPSUszSndTK0R0NjYr?=
 =?utf-8?B?S1d1OGlwQVlYc3AvMzFld0txUVAydXhzRTI2bTJKMUppQmpyb1d3YnlJWmtT?=
 =?utf-8?Q?Eafg4c?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzAzY3NNR3AvTmJmVnNIWmMweXd3RUxCZXZzVGV3UnJiM3hUZWJTbkpjbGxs?=
 =?utf-8?B?NGlUMlRSNjU1VVhEZTVhWWRlWnE1a1JYWUZGMzVlMlJNd0RMWmJDcUw4NGFn?=
 =?utf-8?B?cENyMEpjck9oNzAxVU9qOEQrdThnN2lvcmV4NnZKRVpGZU1CTlRNa3VVYWtC?=
 =?utf-8?B?OE1MZFRyWTBUcDkrSmNEbWpjYi9KRkU0SWwwc1FQazl6dC93MEdlelllRktR?=
 =?utf-8?B?d1BtTjNxQXdtUm9xclFra0s2aHdOSE5GRmZ1SkU4NTNvb1p0SUh0VGV2VHZm?=
 =?utf-8?B?Mi9zTkFKU1JaUXVJY09PUzA2Rkk0blpyUmJ1bEZUckNKUGh1VUFSTWp6Y2tz?=
 =?utf-8?B?NHEranc4SFFmQXBlay85dFNhMjBIMndKVUtEMnB5K29WZVNzSExUQlF1QlI2?=
 =?utf-8?B?S2x0V1lORG03VGE2cERQb29kQ3d2Y0doWlpnSU5aaDhpTjF3ODVEck1HZ0tB?=
 =?utf-8?B?SXhDR05mQ2g1T2pjU3dDQTYwL25OdHNYeGw3NHg3M0tRV1E3d2tEcUdPdS91?=
 =?utf-8?B?M1E5dFZoR3hyREQ2TUZaSGM4Y0tMRzlvbDJITEo4eWZqbTExU1IydVVDd1R1?=
 =?utf-8?B?aXZ6N0dNdExaOEtKbDF0ZEJKamphcnpNNnFSZFBMaG9DWjB1RS9lSWZXclh1?=
 =?utf-8?B?Rmk5S0ZReVVIaFg4WXRCOEFIbFNIUXpWa3B6c0NhOE5kN1NsN3FDcVRpUGJh?=
 =?utf-8?B?YWdYSGRyckZKNUFhL2FxbGg5UDNielhySk9tM01kUjFPbk9MajlJZmZNb243?=
 =?utf-8?B?ZjBEVTYxQmxrWkFocDlXTksrc21CUGV4bnA0Y25TRDJoYlYyd3ErajJnSDdS?=
 =?utf-8?B?c1FLWk9kMjZIMStjK0d5ellRcjZKVC9MK3E1SGFuQkNuMjdvRUwrQlplSVZM?=
 =?utf-8?B?ZVZ0VDVaZ1gwU1ptSFhPNG1tM1NUbVA4UEk4U3A5RC9EY2laYldsL3htS2hU?=
 =?utf-8?B?M1hqa1JFOHhtUWVFVWdHN0VIWGt4cUJrQmV3NGRQalllT2hqR0xjNXI2bitl?=
 =?utf-8?B?YVB5dkw2anVtSFcxSXd0em1lWWJ2bGJNNGhhalJIZkMvNnlTR1NWRWE1b1hZ?=
 =?utf-8?B?emp5VGl6dWZ6YjNjOFNYWldybVZIU3BnL2JNa200T2N3YStrVWVWNjNibEc0?=
 =?utf-8?B?c3l2SVZuN2dXcUx5M0hyWUxNd0FvdlJNaDZ5TUhKdlpTNVNXSUsvdHQyYnRi?=
 =?utf-8?B?cU9aalBXRHRLTndpSkdDSzk3T1p3L1ZiaU5BRVQxN0VaV0NlWE5QOFpmZnMr?=
 =?utf-8?B?bDlVdHJpeUl0dkNEbWJLTDBRUkp5emcvektYS0FDbXE3SXFYdGRHTDB5Qmpa?=
 =?utf-8?B?UnpvZG5jUWV3akhUSVdtWk4yOTFxMFVLbW9hWnF3ZXNPMWFtSlR1TWs0L1pK?=
 =?utf-8?B?VjQ1SlpzMmFYNm5LWVJXZTM5Smw5QWRrNlNhcnNTeEhpakhrRkRKMW41Nlp5?=
 =?utf-8?B?RmFNN0IyVEg4Qlg5QmJqSmxQMXBlNVN3cHJIS2tucVBqSjlSR0lXQXJPV3F0?=
 =?utf-8?B?S2p3NFNwZThKNE9ZcTI5WkRhemJYQnU5R1VScTB4M09xZmRRVXA0OGpWckxi?=
 =?utf-8?B?blU4QUNpdE1kZkRrbGRIMy9HUnkxblg1Q083emw3bFlTcXRSYm56ZGJhNEZw?=
 =?utf-8?B?TjgwcTJLQmx4L3lGTjYxWEFVbjY3eHRma2RKQXNQeTFBYkVBaTB0R25xZEsz?=
 =?utf-8?B?RC8yTjVEZjNyN0MwWEdOWC83Mmdua0hFS0JaU3QzbTgrS1puRnVaSnFldjZv?=
 =?utf-8?B?b3BWRTdLazd0dy9BSFBiK0ZPQ0lRUUFkRGx4YysvN2lPcDV1MmpHaDg1QVN1?=
 =?utf-8?B?ZjRvVFB0SXpPaC9JemhpMDRqeVZXNVRwUFVNdlZGOFNKNVFXZGRINm02Wm1r?=
 =?utf-8?B?N3JHRmo3K08rQk1iMEU1VGtwVVJlaHhhMTVyR3l6MnJybzBKMHBqdlYvU2wz?=
 =?utf-8?B?dHppUzZ6dWlWanMwd0RDRXU5eFI0a1o5UXpyMk1YZ2IwekE0R01sSGlFek9o?=
 =?utf-8?B?TWpSeGQ5V1Q0SHRncW9KUzEwUUprQTJ2QmxhT3lNWlJIT2IwREE2M0lDenl1?=
 =?utf-8?B?THIycHJFMDZCOGI2UGw0VGNCbUROT0pnYUNzMGYzbThUN0tSSmN2UlpxUlJY?=
 =?utf-8?B?R2ZaSXRMNzZzUWg0dXp1UFNOK3FqZVdRZ2pHdFoxSXdtYVo1NWJ4TEJ0VUI2?=
 =?utf-8?B?enpKK3lWc3FFbG5CbkYvUldZckRaalVxT3ZtUmlkMlRpN3BVUDZPREdaR2Rs?=
 =?utf-8?B?VHgyK3hUUi9vSzNkeEpyZ1hHMjhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97718ad-73ca-4937-8615-08de105f82b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 05:05:53.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h86u/PoFAw4foczsGcqjj/VaOndi/ZhJH1gOTY42TZfWfZsW8grCqNSJZ69ISSlEvw8iYwStcaTG/f01VTlNZOHInfR25YI+ny5ZWAVkIUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8229
X-OriginatorOrg: intel.com

PiBEb2Vzbid0IHRoaXMgbmVlZCB0byBiZSB0aW1lcl9zaHV0ZG93bl9zeW5jKCk/DQo+IA0KPiBU
aGUgY3VycmVudCBjb2RlIGd1YXJhbnRlZXMgdGhhdCB0aGUgdGltZXIgd2lsbCBub3QgYmUgcmUt
YXJtZWQgYWZ0ZXIgZGVsZXRpb24sIGJ1dCB0aGUgbmV3IGNvZGUgZG9lc24ndCBndWFyYW50ZWUg
dGhhdCBBRkFJQ1MuDQoNCnRpbWVyX3NodXRkb3duX3N5bmMoKSB3b3VsZCBiZSB0aGUgbW9yZSBh
cHByb3ByaWF0ZSBoZXJlLg0KV2lsbCBjcmVhdGUgYSB2MyBwYXRjaCBmb3IgdGhlIHNhbWUuDQoN
ClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIQ0KQlIsDQpLYXVzaGxlbmRyYQ0K

