Return-Path: <linux-pm+bounces-11417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5993CE55
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E3EB20F67
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AC157E7D;
	Fri, 26 Jul 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jflk7YKg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9AE57E;
	Fri, 26 Jul 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976862; cv=fail; b=R+1YGOnB25CwYOwtSh+Kl8FZI+dgbzSjNp0e1tTtw9cX6JLebriBS3zKfYTrcIruRa0ey+GkNTvjoFImpqwbd5688W8h6rzVAgFMRusnIxXWBZr4R3+jSgBukDGtRSyQj5gfqwPX4WYu0zC6dv7neJcfUlUJjQHwlZf95lFEitg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976862; c=relaxed/simple;
	bh=S4YYUXtfKwQj/xxCTdhA1IMAEZegmk3CCVYVxzzF3NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/vwMKp1zL9KHLk9l2VS/bckoy+SAWWsF25juFGVDmlS0FYZzc8P7csACK0s6VsbhszM+Ibg4GjR2T+/OnzvNUjCXuF03ugYDOmKkUzqhakeHu/i4uATmu8eIKNxwyplVq6RuVdEq+9UFdPJ0bTEcb3ped145BHTZFV/c2smdH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jflk7YKg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721976860; x=1753512860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S4YYUXtfKwQj/xxCTdhA1IMAEZegmk3CCVYVxzzF3NE=;
  b=jflk7YKgvtBIYjRbWlp14MDRLxxJD03+FfjyKCmZUvGHnS/A5g3YjR+D
   Q+6QllquqAgzaFvgX0YptVh4nQPhWuuI0YemQC91B4hWiTOLKrCPulYRp
   lNd95zeZHI3n8cfRc6FHUgNkBtOGXZyEVKkyZhJ35DZWXSwPauQMazvI0
   LnDMNf/iv4X0Ib7MrJEPPS+NbBN45zs59HCCBIj36fHihenr1DkF1gpQG
   rDbQwItW0AbxSedi1k4v0vXsYRMjZrdqhUSBuBaCZ6KoOCKP2E2kBJQ1u
   a1EQWb1QMH1tArdUI2fSz+pFHQeugPiEmTdjGBlNWaM44ugcHCHxKGynB
   Q==;
X-CSE-ConnectionGUID: mKzgavCkR5SWsBBp1bQ21g==
X-CSE-MsgGUID: gQ8n6ug0T8aLJXkyl+p43g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="37271261"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="37271261"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 23:54:19 -0700
X-CSE-ConnectionGUID: F3I5d3cLQxmLOd2gWCl6Dw==
X-CSE-MsgGUID: sxSVHTvMSO+GmLNJYBB2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="83804544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 23:54:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 23:54:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 23:54:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 23:54:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 23:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy5eeeJD7ilJjY5SaqYE/U7aO/sDc45iMFy3dT2P7AqZG7qAh4G6ofgtrJWH5D76PB4PH0V1Yjud9SiKzLiKYnlrHSS+QL8WSA/cSTXm+my+1DsQGTmjKrcdQJ4CKz9G7BzrQOv7WzMTn9OMNWPZjFXrZVFMMdohJrCGhjOGbaeWIe9B6gyjL+DJHsa6FIW7qT8CXMEsJ54+OXkMdSD5jJPc7rf88N6l77e27XXk/+g73q+N0FE6MfazBelgwqJOxxFsZ+ucyXT5Zj/D6rHjSTL9QFPyJmYmFturd6awxF7df8nGbuxz7/2z3qXeE7SYHRDZN7ekSLQhhdUHtJytSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4YYUXtfKwQj/xxCTdhA1IMAEZegmk3CCVYVxzzF3NE=;
 b=A58M6BDTeZb+T3FFcceQhKQKou2kvsduenBx7vYAhwfclOdaPEMD3EgEbunpUHp4up9UvbhaBEQHf8Mb0gXLhdt/CLJkDszTVcO/fO1AFcjcOm5POrmzBH8X2bEJTZNgOZhpqDwfvK4AAjjMqiLZ5NmvLi0fYgadfOGoJa+oLXbRBdTM3GBpovUWUNsioZPUIKfWNIIOidtjyffoYr5NCoi8CcDDYCLQBcw/2mP0EJUvuKoTOZAPG3FRHJiPeiUdRgYjXALCsUTZBesE0EKUPbmpjT29ZawE50tT1oMqEMNCruleX8q96OME825TdzNUV15fp8IefMMpuuqLM/ScZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 26 Jul
 2024 06:54:16 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 06:54:16 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
Thread-Topic: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
Thread-Index: AQHa3yYADg47xNnD9ESjcTXoQSGHhbIIkkyAgAAAqAA=
Date: Fri, 26 Jul 2024 06:54:15 +0000
Message-ID: <c9e6b86e359ee46ad686a60acc36430c3ac61275.camel@intel.com>
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
	 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
In-Reply-To: <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 2e8d91c2-ce67-4f94-0314-08dcad3fc3d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVU4V21qcFdNSDdlemtxSDg5TVpFZTJjdlVOZlJtbUV5S2ViMTJWdkhYdnVx?=
 =?utf-8?B?L2RsV29LS2RNOURqazRUS09tVzlCbzc4U2d2UFJFNWdhWUl3TE1jeVlTL0p4?=
 =?utf-8?B?bHFTemE3ZE5RY2FQTnlGMzI0NlNwNjhDNDBQVXllMHBqdGtXTWJVbnJKd1Jj?=
 =?utf-8?B?TkFwUmw3aWhySGhZVnVBYUJPWE8zYXN1YjJTVDlPL2daRkRNTHA3TlRqZllM?=
 =?utf-8?B?Q1o5cGxjZHR6bjFkS1c1WEdIY3RMK1luMTBDZVNWT0RhYUJ4ZmhFYTQwa21F?=
 =?utf-8?B?a3dWaWRNTkpwb1l4a3lJYnF6T1JwYVIrS2JUOHRzT2ZYMnl1cEl1TE1hd1Fv?=
 =?utf-8?B?T0ZIR1kvVmh1bTZqTGZ5b2tNQS9KZDRjUWFGd3FDajU3eTJjSVUxalZwMFJv?=
 =?utf-8?B?cVVYY3RBU0YweEltTFI1RkhqN1pHRkZnaVcweC8xRi84L1pNNTI1STlvRHlH?=
 =?utf-8?B?SldwU09nVEdBOEJGWXhnMGVrdmc1TzhuaS9SczVJaEZaNHM1L0I2ZThScmhP?=
 =?utf-8?B?V29UM3VudWptNDRXbm9VK1lWVlFZbUMxeVpIbTRoWU1xVVIrYmVaTlhBVGNV?=
 =?utf-8?B?cytnTDNyUThvRlNwSDdYOUJMUExkbitZQ1FJWWZmamM5VngyOURUdGFTemVs?=
 =?utf-8?B?SDlpSnJKTFBWSmN6WWhEVldRd09rNFNTRU4ralBTU0lxLytJUGFBRXo3SWpI?=
 =?utf-8?B?MWxRVEJyZit2S2Z1UldmdmEyS1BDRmVkb3g4RVV6UnMwOU9yNkhKbVdvNzJW?=
 =?utf-8?B?ajh5SG8zSHR4L2M2aWN5VFNhc21WU1hoYzhPZUJoUGRSMEFYOFBnaFZPd1Np?=
 =?utf-8?B?R2YzU2FQTVZRMnZTYTNmMC9TbVRvMSt2QWY1Q3gyVkNONWRZMXJNY1NkUzBV?=
 =?utf-8?B?UjNMRUhPbWgwSXoyOTlkMEx2dVN4aHA5NTFtcmVWYUVHMkovQmd1TEp6aXM5?=
 =?utf-8?B?aUVVWnA3ZTB6ZjRzNFo2ZDVaSTZmTGFDUEFFdXBLRWNxclJaOUhNbkc2QWRZ?=
 =?utf-8?B?WmVEV1JnQldjYVpDUDlFaHNMZE1iU0ZSUFNHZFZ6TG9TY1VBcCs2RHMvQmNa?=
 =?utf-8?B?aG1FYkVUTUxEc0oxUnlPcDd5WDJ0UHBUaWgxTGZBcGhFeXZrZU4xbWYvVlpC?=
 =?utf-8?B?NHEwOUhxeElrNkRhd0p3a0tlTFVoeFZ5QlRBQjIvbnVTcU9JYTFhL3hzMStm?=
 =?utf-8?B?QXU1Q0VsRE1iems0dTM1RTJVWElwUTA4NXZwYkJNYW85SjZsa08wakJhSktX?=
 =?utf-8?B?SEd2cVV6STl0MmN2ODBsbUtmZ2Q4NXBVNkhzdGhWKzAxdFZUV2tyNlorRlk2?=
 =?utf-8?B?WTREYTY2OUVjeWFIczRrRXBVakhzZTBsQWE2NmtEYlJwR2F4My9RY3Uvb2FS?=
 =?utf-8?B?NU43Ry9DU0ZPaVl6d05JZ2N0ZkN4dDk1ZDFJSjQ5eFc3N0NQa1RlbTlxZGRh?=
 =?utf-8?B?Nkt3alpZLzVlVituamtVUytsa3BteUZyV2ljLy9UeldwTDFSV1VHaEJHWG5z?=
 =?utf-8?B?REtTY2UzdGs1QTByK0toZXJ2bm1pbUh4V2Y5R0pOZVJYY1NjRDltQmpsTzZj?=
 =?utf-8?B?SHlTNU9NdFZXZFdXWUkrYllyL1krYVdjUG81allXeDllQW0zMFhGUHRLYTg0?=
 =?utf-8?B?VUQ5bHREWGY5Z0VKTllSMkpMb0NMSUVrQUtjZ3MwclBTT0JQNUU2emQzQmNO?=
 =?utf-8?B?Q09yYTY2ODkxRndTcGh2TmQ4NVl6MlFaYXBGekVBL2tmbisxcTQzVFNlY1BZ?=
 =?utf-8?B?MDFkNk14QnltdVZIVFN6eHZscm9BL3JaU3FpVkgxTWVaUG1xWmwwT04rSXU0?=
 =?utf-8?Q?ub5Sc7DBMERb9kF4ABKKQHMKRSvS9wp8SRrAk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZZekZwRGNuSUpURnc1UUtxNWxPUkFzUU9Ubm1aNDltaStObVI0ZG1IVXcv?=
 =?utf-8?B?Z1drRHpQY0x3bnFsUktYVU5ZazdZalo3bjhlalhiaWY0a01kUmwrUUJoUERy?=
 =?utf-8?B?cUJ5WjhlNWhER0xrb1dxdkQrV0RkVzF1UzgvUEJYaVhsaUhoWXRvQlhFbWdT?=
 =?utf-8?B?UDRnV0tLSTA5V3ZkUEdsNXJKNkx0czYwd3dEditxejgxOXE5ZTJyejN4Y1Z2?=
 =?utf-8?B?Mll2SjFWYW5oSytBL2hTV2hrL3JvajlqRkJwS2tVNXRxQXJ1VDdqeUs2YmhV?=
 =?utf-8?B?VG1SQ2NUYm1RTk9KbTNSUVFQTnpoZHFrUDBOaHp2QkRZUll6WGkvaUVaUGo3?=
 =?utf-8?B?aWUvTTFBRHo3MnlRMXFtZVZSWGJyTHhaVDJLdFVtKzJqVzRoM0ptMG10blNT?=
 =?utf-8?B?TXEzSzNQZVpLcFQxM1BEZnpoU0FRV09SSDNBN1hVOFBaZUtMdDNVNjBkYXpY?=
 =?utf-8?B?VGp4a0M2dVpjOEcweUFHaFV3U2NOQktDUlhDVlluN2NiZXdtMzR0R1RDZTNT?=
 =?utf-8?B?aTFzNzdzTW4rQkxLRS94L0tkWlEzU1RXWWFsTG9RVUp6MmZQUGJZNllSWlpZ?=
 =?utf-8?B?eXp1S25lSXFsdTRPaVJCYm95TFk5Vm5iRFRBTTBKTzM5RG4vdGcxKzZJS2lL?=
 =?utf-8?B?VkVBcWpVUFRpbTc2TlVZRVlHN285NHEwOFF1UWFacnU2TGRUQVQ2enpyc0xZ?=
 =?utf-8?B?RHNJODcyc2ZoNDVPMEFQdUQ5TnlKWkNVSGQxdURGalJjb3FBTjdkejVWTC9j?=
 =?utf-8?B?QzZVajc3a3VwdXBoSGJTaEFyTCttOTVvRjc1UmNzQWR3UGxlWVVqenRRcUxQ?=
 =?utf-8?B?UFQ1VEtYOGppcHRGdDgwQ3RteXpROXRkUU1rS1FOek1XWTVRTHVta3JqUk9I?=
 =?utf-8?B?Z3ZDZnlGcDZXeUUyOWN0dHpoOFBSRmQ3T2g2TS82b0hWQnVVc1ZZTGpWWGk2?=
 =?utf-8?B?Nlg3bU5nUzY2by9lVzhpWUphMC9ubGQ3ZHJVM1ZpT0hSQ2srejUwSGN2dmlX?=
 =?utf-8?B?YWVnVVk5eW1pWmZHWEc4d2FwTlZwTXB2YUhRMndkSTJ5RjBabzVCeXA3MW94?=
 =?utf-8?B?WUZGeldDMFMyRUJvbFduaGRjQW13UVRhVnpiZklUTzU1WVNaVGtMb2JJaWF5?=
 =?utf-8?B?anhXcGxqSGxJVnR6emNScEZvd1o4eWk3RDBOYUd3Q1krNU5MN1lSbzV4aHJY?=
 =?utf-8?B?Yk8xNWVIdVE0TWljdmQwRExRVzJxTDR6dHFNemJmYm5xbXBoOXN5K0JiZ3VD?=
 =?utf-8?B?TzlGeW5vREtaQUZKN2EvdzhyVENaUFNuNUJpRERHdVdFbnBhdHZEdFNPc0J5?=
 =?utf-8?B?ZCtRRTVwNlphbTB4WEFYcVM5eGxMd0FUME9YL1ltTmFQKzZNQVAzbExyYzdT?=
 =?utf-8?B?VEtJVjlPdjZyTERrMVdGeWJOK1VBajhDLzZMcFhpSlpyR0lodE5jS0d2bDQ4?=
 =?utf-8?B?Zmw4V1RBcTcxYkFaSFFYUkErNFljQURWZ3BXKzYyN01xME1NK2RmQSt3V0RZ?=
 =?utf-8?B?czF2TkFsQUdQSFd5alYvanF2emdLcFFySFFrMHdoRG1naTZ5aUlDSDh2OGVt?=
 =?utf-8?B?cjRaRERpRnBYYWwzOFBKTWlhamx3dXZpMVEzOCtIdmJqNGVPeVNrUmt6QVhm?=
 =?utf-8?B?UExUcDJOWGZ5TkdueEtxeVVUek9leWxjQjBSMDF2MUhVVHdIeTNRUGhMa1JW?=
 =?utf-8?B?dUNvekxBNmYySjFFSjRZdDEyOTRDVUJJalRmdytFcTdFMlhPWVpjT1ltRjlJ?=
 =?utf-8?B?Uys4bnZnRmVYb1V3QWpTNzJZQmQwTE16czlSWWdaVmFQTzJhYmZkYkVnY0Zv?=
 =?utf-8?B?MzluM05HUFVWU0Zwd1pVbStjMDl6TTFrdHgxWWZhUFZHVzhERmRUdmhPNmtx?=
 =?utf-8?B?WWw5QnMrNFo5dTh4WXFReXVpczhxSEdjR1lPRk1YV1dWZGFuRXFaWXZUUlY1?=
 =?utf-8?B?QWs1YXlYdlpiMHd2SXRvNFE4RFFPeVVqazRGY0JDOCtSbVNPYWdxMVdEaGhz?=
 =?utf-8?B?YjJYSDVvTjM4WlZOL2p6MGc5Ti9IVXo3Y2lwV0tEd3BCd1JKQTZJZUgzNjlF?=
 =?utf-8?B?RWljUGI3NERBb2tVUkdyMktFLzBRdXVEWW1TajBJcHk1bEhFYnJqTGhrUVNX?=
 =?utf-8?Q?WoJpxTU62S0XOgY2R872JalVb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B110124CD9A764E9E07A4E1A3F95603@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d91c2-ce67-4f94-0314-08dcad3fc3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:54:15.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJdzVREBrkXDkJ451PVow3qzisHjawEq8LZrXxdXwOptv1j9W+jvgxCwxKjNFYLmLfdtXkqIvLkL9/RWfm+nnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com

QlRXLCBBZGQgUmFmYWVsLg0KDQpPbiBGcmksIDIwMjQtMDctMjYgYXQgMTQ6NTEgKzA4MDAsIFpo
YW5nLCBSdWkgd3JvdGU6DQo+IE9uIEZyaSwgMjAyNC0wNy0yNiBhdCAxNDoyNiArMDgwMCwgS2Fp
LUhlbmcgRmVuZyB3cm90ZToNCj4gPiBXaXRob3V0IHByb3BlciBDLXN0YXRlIHN1cHBvcnQsIHRo
ZSBDUFUgY2FuIHRha2UgbG9uZyB0aW1lIHRvIGV4aXQNCj4gPiB0bw0KPiA+IEMwDQo+ID4gdG8g
aGFuZGxlIElSUSBhbmQgcGVyZm9ybSBETUEuDQo+IA0KPiBDYW4geW91IHByb3ZpZGUgbW9yZSBk
ZXRhaWxzPw0KPiANCj4gU2F5LMKgd2hhdCBjc3RhdGUgaXMgZW50ZXJlZCB3LyBhbmQgdy9vIHRo
aXMgcGF0Y2g/DQo+IA0KPiBjYW4geW91IHNob3cgdGhlIG91dHB1dCBvZiAiZ3JlcCAuDQo+IC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZSovKiIgd2l0aG91dCB0aGlz
IHBhdGNoPw0KPiANCj4gPiANCj4gPiBUaGUgZGF0YSBjb2xsZWN0IHZpYSB3dWx0IHNob3dzIHRo
ZSBsYXRlbmN5IGlzIHNpbWlsYXIgdG8gQnJveHRvbiwNCj4gPiBzbw0KPiA+IHVzZSB0aGUgZXhp
c3RpbmcgdGFibGUgdG8gc3VwcG9ydCBDLXN0YXRlIG9uIEpTTCBhbmQgRUhMLg0KPiANCj4gc28g
eW91IGhhdmUgZG9uZSBjc3RhdGUgbWVhc3VyZW1lbnQgb24gdGhlIEVITCB1c2luZyB3dWx0Pw0K
PiBjYW4geW91IHNoYXJlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgbWVhc3VyZW1lbnQgcmVzdWx0
cz8NCj4gDQo+IHRoYW5rcywNCj4gcnVpDQo+IA0KPiA+IA0KPiA+IExpbms6IGh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE5MDIzDQo+ID4gU2lnbmVkLW9mZi1i
eTogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KPiA+IC0tLQ0K
PiA+IMKgZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyB8IDIgKysNCj4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxl
L2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gPiBpbmRleCA5YWFi
N2FiYzJhZTkuLmViNjk3NWExZDA4MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lkbGUvaW50
ZWxfaWRsZS5jDQo+ID4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiA+IEBAIC0x
NTM4LDYgKzE1MzgsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQNCj4gPiBpbnRl
bF9pZGxlX2lkc1tdDQo+ID4gX19pbml0Y29uc3QgPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoFg4
Nl9NQVRDSF9WRk0oSU5URUxfQVRPTV9HT0xETU9OVCzCoMKgwqDCoMKgwqAmaWRsZV9jcHVfYnh0
KSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BVE9NX0dPTERNT05U
X1BMVVMswqAmaWRsZV9jcHVfYnh0KSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZG
TShJTlRFTF9BVE9NX0dPTERNT05UX0QswqDCoMKgwqAmaWRsZV9jcHVfZG52KSwNCj4gPiArwqDC
oMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01fVFJFTU9OVCzCoMKgwqDCoMKgwqDC
oCZpZGxlX2NwdV9ieHQpLA0KPiA+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxf
QVRPTV9UUkVNT05UX0wswqDCoMKgwqDCoCZpZGxlX2NwdV9ieHQpLA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01fVFJFTU9OVF9ELMKgwqDCoMKgwqAmaWRsZV9j
cHVfc25yKSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BVE9NX0NS
RVNUTU9OVCzCoMKgwqDCoMKgJmlkbGVfY3B1X2dyciksDQo+ID4gwqDCoMKgwqDCoMKgwqDCoFg4
Nl9NQVRDSF9WRk0oSU5URUxfQVRPTV9DUkVTVE1PTlRfWCzCoMKgwqAmaWRsZV9jcHVfc3JmKSwN
Cj4gDQoNCg==

