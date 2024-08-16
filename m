Return-Path: <linux-pm+bounces-12285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD3953FE8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 05:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5BFB23400
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCD535D4;
	Fri, 16 Aug 2024 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv8FdpNn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25E37147;
	Fri, 16 Aug 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777220; cv=fail; b=TVc61ZqyNOHs4PlnsYADHNjXa6QdhVB99gGfBgMFPQ2wac+InFqQLxszuypjf1inzdVkR3oG/3jrnngef2QmDtlfaj1j3PRAtZEFKqdP39bo92dgFEH3gYCEnZoM8/BRo5j3t8zrtkToleSWP237/qBNwS9oZ++WrRYu467E3u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777220; c=relaxed/simple;
	bh=mN42aeTYJupMVTOyl8yycn/ShET+44q+UlDhWcdykAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McgMmk9ri8IsLQW4FrSHHYV6AEYhTS0JAWj34qQlHAhWOpg+yJs4Y+NArP+Xp0uUtHh0lw3s8au/Gv1tqMgx+RCBRqvqR0uiftpqjjy2ShdIG9gBFT/wUiEx+9LX/ZG5QjV9VV7xadTjagpOvrUsldVGJkzznkoUeDxS1BQCKm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv8FdpNn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723777219; x=1755313219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mN42aeTYJupMVTOyl8yycn/ShET+44q+UlDhWcdykAE=;
  b=Fv8FdpNncSAj+yAJu8GYXcE7w7e+jAlUhayQ0u5Air2xdZWqlSLuVsU9
   A/YmzOe8mTNuiWdZTADqaF4HhdS1HkXL8MeVyzzB3IgC9CEfw+WtuMbvm
   G1Tz+JbzMYUzPMOM3XIUYrSy0qJmZ3A3Z6kL4GeCsYYKLE9hT9da3NG5A
   BmUlnjNy6NxX8EIYJo6bhYZ4jZHrgNvYL1dycEIUwm6wWfhD14thbF2jt
   0SeOXIj9xfmBIXDYpeB4ZuF5E4W0rbJqLcQ0e/lzGHo6SxvLguGjCKcuZ
   lf0el5L6nSNslkBHOZpmRzXkiQn9Fg1Hv+vQs/SboeD0WG54kIxMg2Q2h
   A==;
X-CSE-ConnectionGUID: Mmg9myrZRv6HkVYGWoSWXQ==
X-CSE-MsgGUID: wiJhwT3BQ7q+ZwPHfbJ7aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22032838"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22032838"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:00:18 -0700
X-CSE-ConnectionGUID: 2GrEBAk2TOGsXG4QqzXdpQ==
X-CSE-MsgGUID: NswsIh0fT/6V4mrJISnPxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64435335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 20:00:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 20:00:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZB+zXgR7lPrVhZmPNdCcJbQSKFnA0eI64374geaAL6w/++nPtl9cHbhf/eFQ+OYWvN9ms1H3RB6Rtb5GPNCcj8Vae0VNgelI0BuCxNRb341HblhQnv+Dfpsb/0HnWBv3wfMkAdR8pNuJ/g2XC/zHwfIXuFC4+nM7XTqpBx1zq+i4kuWakDsjSfy+uIrMnowJ0pmLdwGPrS5I413wcvnoRiiewS8e990iheaUuWYPrgQ2fUs0Wvh6FVv9P4XYKh2iZVr4P9YN86LxQ+2/WAvoQVm1Ku0n57QIq45bNYIMyeskUEocaErunBBWdjVuOUJKgGdYCUOJaU5tZy0ffSt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN42aeTYJupMVTOyl8yycn/ShET+44q+UlDhWcdykAE=;
 b=S5XmhE0AWZmCHRhuVAUveGSR/dXGKs/cNnydMN6iuKqRC5WNBlkdQFlN6QN7QeE1jUP1nugfx0o3oudO1VFPELmZhGp6sM+vcsomFQAmadJ+K3YG90SQoE6wqbnAeb8PSvVnTS9cto0rg97taUgGs8RCwmYvAkbR+arWauDemhBmatvb5xudPLvZ64s21bHzEcoxZQu9AcfL5HXu0UMwh/l/KnbUTLyeQW6KQgh53V8gnA+pOVzPqWcUmyjz/p8E3ufuQFxKicH//nudX4feryoCciKZzqz5oRorFDD0euaG8GA8wRd+BmyFYM2K1Ox2ThWxMkPrlVkbM2yWeB7zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 03:00:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 03:00:13 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net"
	<peter@piie.net>
Subject: Re: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
Thread-Topic: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
Thread-Index: AQHa7Y19BQ1UG0KHaEeGPGp12zgXZ7IpNbcA
Date: Fri, 16 Aug 2024 03:00:13 +0000
Message-ID: <3d67c7d9a0f4aec1c2f9836abc95abdd8a20fe56.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <8419356.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <8419356.T7Z3S40VBb@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: be3a35c7-277f-4265-ed36-08dcbd9f8cc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzBQYVVjUGJuNURzRUo4K1d4NHBkb01zbStZTUp2Y0ZjbnBqRG1tWDBHNFNT?=
 =?utf-8?B?cWpsUGJtVnZIM0g4TXFtM0pkOUt1MkRGdHdrTGlZeklvSkh0MVVneUVJZEFz?=
 =?utf-8?B?ZVE4UmNqek0vdmxDMkdTek1lNWNYa0hjMGs1V1M3YVgyZ3FrSkdLcUp3MjBJ?=
 =?utf-8?B?WHVjaFlKNmNPUzlqUzN1QVFMWDJmVEJTeWs5dUZqMWxVK0F1VDlEZjNVSlpC?=
 =?utf-8?B?M3VHM3lwZ29TS0hrMWxzL00wVXdwYlFRa25lM0hHQ0puSzdZbC9SVkRJdkt0?=
 =?utf-8?B?VEZrdUM0QTFwbmUzNGN6YWZqR0QwTXMrMnlDTUJ3Y2F5NE1sZU1hV1F0MHJO?=
 =?utf-8?B?Y25EMkxBcmt0RWhhRHR4NURRaWtEZ2VCWnNWUEh3VVJ2aU83UFhleiswdEc5?=
 =?utf-8?B?U24zMmRTY003KzlxWUptWDV0bTdrMi82STNDQ3lLdSt0UitUV2MrOFdJNEgr?=
 =?utf-8?B?UmFTQml2YktxdXcwU3RBd3hRWmYyeHBnbnIyQVBBK1FIT25heG0rVEdRcExU?=
 =?utf-8?B?SzZyVG9KbWswY0M5T2ZJWCtxSEZyL1JTNlJSTCttMFk4SGNtbmtiZDlwblRy?=
 =?utf-8?B?OXZZb0wxTTZZZDI4SHZlTmhLTzdsT1JYU0c2Yy9uSDMyM2F0SVFxT3RFaExS?=
 =?utf-8?B?aFFydk5vUmdFVEV1UDlORG53OEhjTTU2QmhwNlA1MHZhNis2aW41bE0xdjZY?=
 =?utf-8?B?dmJWTVJEVVVkNGR5VWVqQ0J4SUZZeFNLb202ckpuc2RoSUV0NjlNMVdJdkRK?=
 =?utf-8?B?RFVlWlZwS0NIbkZQNk9WWjFVUWtvTktZaTNsMUlIWDN5aE1iTUdzUEg5cjJl?=
 =?utf-8?B?azFEL2M5eUxtUG9FTFJnU3k0ZFlSUlFzLzhJZmxYVHBWbUJmc1BLWmFxbmd6?=
 =?utf-8?B?emFZVDBPb2RCU3dpRDhvMnM3V0NiTnJvRW9OeSs1c2R5dy9JeUhIZGpjbW8v?=
 =?utf-8?B?M3ZDZ1NrUjJyWDRQUTJGM0pndkpWc0tkODRVUmZVR0h5Wk42ZGVvWm9JbnRl?=
 =?utf-8?B?dk5OYzcrbzRTS3U3bURQcWZJeUlYbmlMUWxpMGk5amoxZ0RqVk4weHZlSHkx?=
 =?utf-8?B?ejV3WC9TTDBxSzBuQmx3aXhlUUZDNFVNbkp5U2tXZXpGSzl1QzhESlhvb29E?=
 =?utf-8?B?cnF5MEJhZ2p3RjFzNklSY2g2RjRCNmVSZEFSdmRyUTVkSVJ4MTRVK1YzRFdN?=
 =?utf-8?B?cjJ0bjY3Y2JGSkp6YTViZVZRSDdtV0ovMU4rYU1NZm95UGVjdzRVQk5Ba21U?=
 =?utf-8?B?L0ZpV1BDZGVnTVZSa3hhdk41Unh2MlMwNWhyeTZFaCt4bENRcC9xWXpycE45?=
 =?utf-8?B?anlvTWFFNExiWkpzYjZjMnVMTXBGWWYvVCt2dTQxUlR0aFg1Wm5JTmVWcWlV?=
 =?utf-8?B?YUkxUnhnZ2lvWGVFZDV3VEVkNDFMamFudThOUFlBRkpGK2duQTQ3SkRkYkJD?=
 =?utf-8?B?cGhya1p4d1ZUTmdjRDZ5NjdyQVIwSXZESTNZclpCZGRDME9Xa1JBMklETnBj?=
 =?utf-8?B?cW13YzIxYS9uOHlHS2FEbkduL1hGUnlRdlZYazR4US9yRUJWcU1Ua1lyeGtY?=
 =?utf-8?B?NS81cmI3aExUY3JWYmhqWlBYTnk0ZXJRYVJISHZXU2ZUZWRRL2E1bm9NTjJr?=
 =?utf-8?B?dmQvTXFadGlTUHlqQ2w0bXVadUhEMmhZdDdDaXQ4dVprQmYwTDZOSUhUV21s?=
 =?utf-8?B?cjRKWFB3ZHFReCtlWkRMck5tSjZXVE12dmRKcmZTVXFjTEt4V3lJZjgzY1Ru?=
 =?utf-8?B?S21EbHBtU1ZsdG1GalNtOTJoNTVySTZla2thTmowSXpYSzcvOHB1YmtMK0tw?=
 =?utf-8?Q?VQ8FBiECj/19RThfOmmv6OeL7L8r99mtCfgAg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3RkNThtWjBHNVRUR2FoZXpocjBoZXlFNWRuMW5oYXhSdW5HZmRla0JOSmhG?=
 =?utf-8?B?RVRwTk9TQnBIQ1lla2Uvczc3T2tTWitpWU9HeEtKbEczYi9TMlBvd0hNNXRk?=
 =?utf-8?B?NG1DWGZ5SDZnaFNTbE9ySndYSkhOeDZXRGJWb08wWXhlTnVOOXJ0MEJCRzlS?=
 =?utf-8?B?WkxPa052MGJycEsyNXphWHJrTXFWYjYzeXpCcmg2M01QajJRTHNJdUtwK3li?=
 =?utf-8?B?dHBqd0hHTGVwY0lTRHdrWnoxNVpDQkpzSVBEYjlWTXBFQVFIV00rTW10b0ZC?=
 =?utf-8?B?UHJtOUErYjZLVzJyd1B5TXhjWHR4b0lrS2htTjQ2S0N5VXg3OEdJVmxMRWNR?=
 =?utf-8?B?Q0QweFJaeVNPRFNoSHJINlN2bjA5TDVndWVUNUpLVnBQWkFMNVVGK0N0SjR0?=
 =?utf-8?B?QnFhaWVBT3hCQmpjN0ppRHVLRXpERFNKSVJPQ3BjVlg5ZjJiWlQ3dm53aGwv?=
 =?utf-8?B?VlY0bU5xeUtGT2Q4R01MQ1IxZTVBc2Y1RHN5R0IzNUF4bllHYXRnV0wxUTg5?=
 =?utf-8?B?aGsydDI3c2RidGFTQnFXWm9RRFVoeE1Uc2dIK05tNjZNM2Y1anEwUWtGQ0Jn?=
 =?utf-8?B?R29ONnBiUUN0ZXBZUkxXTnU1WTJzT2pNcS9mdk45TlN1WSs1VEVhOU9pcUI2?=
 =?utf-8?B?UDdHeWwyTXZBWHA4N09SZ2Z1Smp2WFkvY2ZLelFDRzk5aTJ4eVBkd1RFbG9w?=
 =?utf-8?B?L05TL1hjYUNoTFZlWVZOeG90bnRaK2FDT2l6YUpPVnhuU1laaHBJM2NXOVR0?=
 =?utf-8?B?anFZekpyNkZicUVoK2FvRVBJVUU3ZmxRZGliUjZQV0hNSnk1UDlhRXNaR0pC?=
 =?utf-8?B?bStPYXpiQXpkNjZtZXdSa2c5cXg1SGdNcldWdzFZOHp1SHhCMGp3eEN0U2FX?=
 =?utf-8?B?cVJoZURWeWZ3eHp6cGdqN1BLbDdRZkRld25pTjRmQnhtREszbnN6bDBSK1Q0?=
 =?utf-8?B?UXVmc21GNnliczE2NFZMVVh6RmhHYXg4WDBNcHlkSXVyeHJROWM3QVVpanF4?=
 =?utf-8?B?ZDZ0cVovYWIxWkxOa1VqNDY3aXIyU2Q2SmlCMGIrYUQyY1NYZVl4WFdSaHpl?=
 =?utf-8?B?N3ZSOVdGQ0hNcDhlQ09tZ2RzK1pIQ3lrNDlWbTNja0dxM1c3YlNJaHlLOTNq?=
 =?utf-8?B?MGFPS3BZK2Fkem81SVlXNUdIUTEwMFJLOVZGalJMMDhDWXlvRGpjSnAvM3Vt?=
 =?utf-8?B?UUtYdUhhT0pSRXFtWktRUDlzZnlWVEFRbkdiellBS1RGY0YwV2xVMVRhbEQw?=
 =?utf-8?B?TGdQcmo4OHdwV0l1UWg1VSs3MWdKVWV3Tjl4TWNvekJkdlhzZHBEeUwyZFNO?=
 =?utf-8?B?YWg4NHVuZnh5U05ld3VJbnhMZEsyaWQwY0tqRm9EKzQxQXpaVVRGUGNUTndJ?=
 =?utf-8?B?VCtqZC9meVZDRE1pM0s5eDE0SmtqM1V2VkNOVWhSNVViaW1ZNnRod3VZZW1v?=
 =?utf-8?B?V3BGRGpRQitKR2NOOTh6U3AvQ21xVUQwSjhIcWdIcGNuRU0vVElaYkV2Uks3?=
 =?utf-8?B?WEFQdlFtdkFHR05MTDk5L3ZEV2RlbXcrWUp4dk9qTmVuOEhxVEtqUEdybDdq?=
 =?utf-8?B?SDFtdVY4aFIvMzNPeEdyNmlXVVBRK0E1Mk9XU2RPZC9nUUQvWmtLREZqTTZT?=
 =?utf-8?B?T1owVGVJWGZJSm1GVGlSeTZONTdEeFlhc3ljelhqSEk3dHd4MnpvQ3ZOaXdH?=
 =?utf-8?B?d1JEVDJKelVMVWYwaVZvdURLUjE5YlVOQk1PQWRUZEJPKzA3aGZCdmRmbXFm?=
 =?utf-8?B?bEFobEU3bzV1SXJ3RnVjb010b2JtRkVFemJFMklMK0lza29NM2E0L20rWitH?=
 =?utf-8?B?ZE5Hc25hWFhnUWYrWWQ5U2pPeGswM3V4anJmSXZHbFhsUTVlNDRLamhsYVhj?=
 =?utf-8?B?TFNGdkFaUXkwZWhEZHlIczNwRkZzbUdHUDFoMy9FT2ZOclQ3UHZvNWMxSnlL?=
 =?utf-8?B?c3YxY01YVDFrcmk5NS9TaUp6dnVndDJGVzNPUWdkOGpVeDdvQkdKdGJQam4r?=
 =?utf-8?B?UVRRbFprWllydXZPcXgrVG9sN1lpSDllWWFiV1lRMlJrSGFDU3NqZGYxZC96?=
 =?utf-8?B?ZTJTS1BxZWFrMTNCT2RRMFg2N2ZocGtJbGZMTmRLOEY0TzcxZjFvZkJucHB3?=
 =?utf-8?B?TDVyclg0M040cmtiMWpnem9RODFJa3ZxMFN0QTJoalM2Y2x5dnhLVUlFTXFB?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1DB30C5F33A7A4CB8C863B7097E1E87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3a35c7-277f-4265-ed36-08dcbd9f8cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 03:00:13.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsK1qXXpKcgfX062M6/JxxDykDDOz8GrVuTSOc/dTOtcTABzBVAKvE8wqPkinMl6G4ip8/DOORz7V+4/P4qBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI3ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gQWZ0ZXIgcmVjZW50IGNoYW5nZXMsIHRoZSBCYW5nLWJhbmcgZ292ZXJub3IgbWF5IG5v
dCBhZGp1c3QgdGhlCj4gaW5pdGlhbCBjb25maWd1cmF0aW9uIG9mIGNvb2xpbmcgZGV2aWNlcyB0
byB0aGUgYWN0dWFsIHNpdHVhdGlvbi4KPiAKPiBOYW1lbHksIGlmIGEgY29vbGluZyBkZXZpY2Ug
Ym91bmQgdG8gYSBjZXJ0YWluIHRyaXAgcG9pbnQgc3RhcnRzIGluCj4gdGhlICJvbiIgc3RhdGUg
YW5kIHRoZSB0aGVybWFsIHpvbmUgdGVtcGVyYXR1cmUgaXMgYmVsb3cgdGhlCj4gdGhyZXNob2xk
Cj4gb2YgdGhhdCB0cmlwIHBvaW50LCB0aGUgdHJpcCBwb2ludCBtYXkgbmV2ZXIgYmUgY3Jvc3Nl
ZCBvbiB0aGUgd2F5IHVwCj4gaW4gd2hpY2ggY2FzZSB0aGUgc3RhdGUgb2YgdGhlIGNvb2xpbmcg
ZGV2aWNlIHdpbGwgbmV2ZXIgYmUgYWRqdXN0ZWQKPiBiZWNhdXNlIHRoZSB0aGVybWFsIGNvcmUg
d2lsbCBuZXZlciBpbnZva2UgdGhlIGdvdmVybm9yJ3MKPiAudHJpcF9jcm9zc2VkKCkgY2FsbGJh
Y2suwqAgW05vdGUgdGhhdCB0aGVyZSBpcyBubyBpc3N1ZSBpZiB0aGUgem9uZQo+IHRlbXBlcmF0
dXJlIGlzIGF0IHRoZSB0cmlwIHRocmVzaG9sZCBvciBhYm92ZSBpdCB0byBzdGFydCB3aXRoCj4g
YmVjYXVzZQo+IC50cmlwX2Nyb3NzZWQoKSB3aWxsIGJlIGludm9rZWQgdGhlbiB0byBpbmRpY2F0
ZSB0aGUgc3RhcnQgb2YgdGhlcm1hbAo+IG1pdGlnYXRpb24gZm9yIHRoZSBnaXZlbiB0cmlwLl0K
PiAKPiBUbyBhZGRyZXNzIHRoaXMsIGFkZCBhIC5tYW5hZ2UoKSBjYWxsYmFjayB0byB0aGUgQmFu
Zy1iYW5nIGdvdmVybm9yCj4gYW5kIHVzZSBpdCB0byBlbnN1cmUgdGhhdCBhbGwgb2YgdGhlIHRo
ZXJtYWwgaW5zdGFuY2VzIG1hbmFnZWQgYnkgdGhlCj4gZ292ZXJub3IgaGF2ZSBiZWVuIGluaXRp
YWxpemVkIHByb3Blcmx5IGFuZCB0aGUgc3RhdGVzIG9mIGFsbCBvZiB0aGUKPiBjb29saW5nIGRl
dmljZXMgaW52b2x2ZWQgaGF2ZSBiZWVuIGFkanVzdGVkIHRvIHRoZSBjdXJyZW50IHpvbmUKPiB0
ZW1wZXJhdHVyZSBhcyBhcHByb3ByaWF0ZS4KPiAKPiBGaXhlczogNTMwYzkzMmJkZjc1ICgidGhl
cm1hbDogZ292X2JhbmdfYmFuZzogVXNlIC50cmlwX2Nyb3NzZWQoKQo+IGluc3RlYWQgb2YgLnRo
cm90dGxlKCkiKQo+IExpbms6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMWJm
YmJhZTUtNDJiMC00YzdkLTk1NDQtZTk4ODU1NzE1Mjk0QHBpaWUubmV0Lwo+IENjOiA2LjEwKyA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA2LjEwKwo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBK
LiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KClJldmlld2VkLWJ5OiBaaGFu
ZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Cgp0aGFua3MsCnJ1aQoKPiAtLS0KPiDCoGRyaXZl
cnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMgfMKgwqAgMzAKPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCj4gCj4gSW5k
ZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMKPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYwo+ICsr
KyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvZ292X2JhbmdfYmFuZy5jCj4gQEAgLTI2LDYgKzI2
LDcgQEAgc3RhdGljIHZvaWQgYmFuZ19iYW5nX3NldF9pbnN0YW5jZV90YXJnZQo+IMKgwqDCoMKg
wqDCoMKgwqAgKiB3aGVuIHRoZSB0cmlwIGlzIGNyb3NzZWQgb24gdGhlIHdheSBkb3duLgo+IMKg
wqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgaW5zdGFuY2UtPnRhcmdldCA9IHRh
cmdldDsKPiArwqDCoMKgwqDCoMKgwqBpbnN0YW5jZS0+aW5pdGlhbGl6ZWQgPSB0cnVlOwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJn
ZXQ9JWxkXG4iLCBpbnN0YW5jZS0KPiA+dGFyZ2V0KTsKPiDCoAo+IEBAIC04MCw4ICs4MSwzNyBA
QCBzdGF0aWMgdm9pZCBiYW5nX2JhbmdfY29udHJvbChzdHJ1Y3QgdGhlCj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoH0KPiDCoAo+ICtzdGF0aWMgdm9pZCBiYW5nX2JhbmdfbWFuYWdlKHN0cnVjdCB0
aGVybWFsX3pvbmVfZGV2aWNlICp0eikKPiArewo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVj
dCB0aGVybWFsX3RyaXBfZGVzYyAqdGQ7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxf
aW5zdGFuY2UgKmluc3RhbmNlOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF90cmlwX2Rl
c2ModHosIHRkKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVj
dCB0aGVybWFsX3RyaXAgKnRyaXAgPSAmdGQtPnRyaXA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAodHotPnRlbXBlcmF0dXJlID49IHRkLT50aHJlc2hvbGQgfHwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyaXAtPnRlbXBlcmF0dXJlID09
IFRIRVJNQUxfVEVNUF9JTlZBTElEIHx8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0cmlwLT50eXBlID09IFRIRVJNQUxfVFJJUF9DUklUSUNBTCB8fAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJpcC0+dHlwZSA9PSBUSEVSTUFMX1RSSVBf
SE9UKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29u
dGludWU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiB0aGUgaW5pdGlhbCBjb29saW5nIGRldmljZSBz
dGF0ZSBpcyAib24iLCBidXQKPiB0aGUgem9uZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiB0ZW1wZXJhdHVyZSBpcyBub3QgYWJvdmUgdGhlIHRyaXAgcG9pbnQsIHRoZSBjb3Jl
Cj4gd2lsbCBub3QKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogY2FsbCBiYW5n
X2JhbmdfY29udHJvbCgpIHVudGlsIHRoZSB6b25lCj4gdGVtcGVyYXR1cmUgcmVhY2hlcwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgdHJpcCBwb2ludCB0ZW1wZXJhdHVy
ZSB3aGljaCBtYXkgYmUgbmV2ZXIuwqAgSW4KPiB0aG9zZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBjYXNlcywgc2V0IHRoZSBpbml0aWFsIHN0YXRlIG9mIHRoZSBjb29saW5n
IGRldmljZQo+IHRvIDAuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5KGluc3RhbmNl
LCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLAo+IHR6X25vZGUpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaW5zdGFuY2UtPmluaXRpYWxpemVk
ICYmIGluc3RhbmNlLT50cmlwCj4gPT0gdHJpcCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiYW5nX2Jhbmdfc2V0X2luc3Rh
bmNlX3RhcmdldChpbnN0YW5jCj4gZSwgMCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gK30KPiArCj4gwqBzdGF0aWMgc3RydWN0IHRoZXJt
YWxfZ292ZXJub3IgdGhlcm1hbF9nb3ZfYmFuZ19iYW5nID0gewo+IMKgwqDCoMKgwqDCoMKgwqAu
bmFtZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9ICJiYW5nX2JhbmciLAo+IMKgwqDCoMKgwqDCoMKg
wqAudHJpcF9jcm9zc2VkwqDCoMKgPSBiYW5nX2JhbmdfY29udHJvbCwKPiArwqDCoMKgwqDCoMKg
wqAubWFuYWdlwqDCoMKgwqDCoMKgwqDCoMKgPSBiYW5nX2JhbmdfbWFuYWdlLAo+IMKgfTsKPiDC
oFRIRVJNQUxfR09WRVJOT1JfREVDTEFSRSh0aGVybWFsX2dvdl9iYW5nX2JhbmcpOwo+IAo+IAo+
IAoK

