Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB0721AE1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 00:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjFDWfW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jun 2023 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 18:35:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38776AF
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685918120; x=1717454120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NwjG6VKZCGSBMofHG0ZdsXeCJL7Y0r1sStjFlWHB/n8=;
  b=Wz5IHCldspwhSckzRm06qvpzZeoUz5ATphTNiVAbcCirgjX/NW3D5SpX
   O0IB3jhhZ/jM2HMDBJJ0WRpSike1r5rN2OgOZPvuzk75vIeNpQk5HncZx
   23vdL9JBwYhuXAFfCslyL+TPvtO1maSGS54gXfmzFYAcSH0GJMlpms4YZ
   4d1oqT9ds29hFMsPWhq8YJWsrDMrfzz0LGIXeu9Ui4kUXzZtJKELbEbwF
   SSgPKnngjSY7Jxg6RimQ32yVWFGAPBZEOUjR9ZagYzEsYEvM+feDcWEaO
   3aeA1GcGXsjAJ30Ujgn8Z6LB3TCDhg26VukaluwleU2E6HVP/RLuQSvx0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="442610051"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442610051"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 15:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="778328253"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="778328253"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2023 15:35:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 15:35:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 15:35:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 15:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcZf/81RNbUlH43BIl8WHeV7+DemzZQ4kwzH706lOLqxQtOAD4DGoRhau4/U19sJpytR8uGVHR4Mg5Co8XenZADxHkJOwSnb7ucUTWPPA/7JS98wbSlrOFD1SVXf+0YL5b1LohLtAtQ1mxxU78qsc7qBU/S7UNhVrtyAtlDJQoIzxg9Nw1NDiNtiV0PZ4IniJE1n+XyTT4oakk36kxxePzx3tXfrQsSjF11PXkTEV2MCtvFEcSNcIp+FXfzhCBvz+Lqk+TELpl1CDi0OLnxOPkSHLJ9fg+uizsuf+janljY2ZmIppwIMi07OqRyQxYplbcd7L6i/MQI6YqiOlvb2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwjG6VKZCGSBMofHG0ZdsXeCJL7Y0r1sStjFlWHB/n8=;
 b=ni/JDF2j5nbIWXPkJokb663gcEWWqpcrl68MEqVVL7c3OKdgGjo/PkNqSY7c8tzulAT6EEZU4m2EzHKgRJ5Ne+SgjdUG9lRW8opvblawbypT0Fejub2qYfR6QRooo4T3yrtPtuGCUVN90NDwESheEJvcaKM1d/oK0fM503ZyAFLP2TQB8vHE+Z6ancnOikw90O33b0mijGvDScGb2Xfs3F3wWi1hDBqZAyvNEoh+MY7D2M50fFX1tuimY0Y01QPim0C8NpasLdj2/w8+b9FeUuvEWN9/6RW9jqmVFNrhOyENXnYLbSA7HHj/bQk495E+FJd2/nuOw7QOsqr4bkjrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5719.namprd11.prod.outlook.com (2603:10b6:8:10::6) by
 DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Sun, 4 Jun 2023 22:35:14 +0000
Received: from DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::58cc:40e9:37bf:6621]) by DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::58cc:40e9:37bf:6621%4]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 22:35:14 +0000
From:   "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: RE: [PATCH 2/7] intel_idle: clean up the (new)
 state_update_enter_method function
Thread-Topic: [PATCH 2/7] intel_idle: clean up the (new)
 state_update_enter_method function
Thread-Index: AQHZlLbeGLE696XDAUqK6pOdDuz1u696yqyAgAB08WA=
Date:   Sun, 4 Jun 2023 22:35:09 +0000
Deferred-Delivery: Sun, 4 Jun 2023 22:34:24 +0000
Message-ID: <DM8PR11MB57190365DEC9A6355631B27C924CA@DM8PR11MB5719.namprd11.prod.outlook.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
 <20230601182801.2622044-3-arjan@linux.intel.com>
 <CAJZ5v0hO_WFnKpBaFay7NtUiemrS1rKKfh_0an0U7UC9FDBGOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hO_WFnKpBaFay7NtUiemrS1rKKfh_0an0U7UC9FDBGOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5719:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: 97f3b61c-b6bc-4e4e-a7b8-08db654bf725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugpec678W8TB5peZSjts5m6vAnsJMi+MxHlpDrvbMTC4Za+BoU3xSl7iXYnLwMccU3iKo3iqIY0X/l8tdanJ+5P4bdu49Krg0fQeKza/B+DdSZcyKR0FPrqMtWyIjmAuRPgAOpg5DqWGCqOFTV38N4tuRViWqJlzJ5F2StMR3arpvz2tkvTEEvDfV9vdXWq812axstwaQKIKihEVt+ocNJMDM+TvmCM/jhkvs/OW0bLNkQbq34NkQQFGIRxJfuW5yWBXt6eu+MY3H5SLlb0cMytz1rZJecuQm/CJ/XQh7enMuQbOhM/CDcI69tPJhGnYV1VfTYGHsvD9KXYoqxcVUt7CTLEaAR6fcb5+WWN3TwSePpHSFdsPCe+sdwgyWKFWSSzoIUPnJgFVidOQnjEcnScv58sVJHuDHE7jX4FMjOMDPGtyJP1nQ+w9vGgRdvlkgtibcrtTZ+nieEYl5PDNgn0FBYpxGSPC1mZJRPye/y1aNWcNYGzJs2WLYSUK+xkgdRVyzG/4Uay67l60ae4R7zLu8/Nzmka1eFXijAV0G9+b4jLT1a0GZVJ8kxxlef47SwXSuVzuum9gRVE8COfSTfCc46wzO+Vo7It+AbZT8UpUYVt2q32nBAuB7iZ5YOzK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(38070700005)(2906002)(86362001)(33656002)(558084003)(5660300002)(52536014)(55016003)(6666004)(71200400001)(7696005)(186003)(26005)(6506007)(9686003)(82960400001)(478600001)(110136005)(54906003)(76116006)(66446008)(122000001)(316002)(38100700002)(66476007)(64756008)(4326008)(66946007)(41300700001)(66556008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTdBT09keEtJU0ZsekVHRlNzcGtVYVlvRFg1YVZWNEhmek5UbkdiYkwvQXdT?=
 =?utf-8?B?Q2NCZ1FvL0J6elpxb0V5ZmJ1dHlYZUhNVEdSNUsrU1Y5RHVmZ2tDbXYyRWhn?=
 =?utf-8?B?Tmd0MHhyVjhyaEpXTjRkU0RVVTUvVWs1WGZUc1Fib0RFRTBET0JkZ1BwSGd3?=
 =?utf-8?B?Wi9UZDBFQk10V0FrOFMrbjIzdGRHd2V1cFp1djF2WEhvK3I4UGRHNEprdStW?=
 =?utf-8?B?ZU1rNVI1Y2FzZDYyMEVBREtHY21lNi95QUlxSmYxRGdCak8vV0g2NXE3cmtk?=
 =?utf-8?B?dHpXMWd1enkvRFJKWFcxbTFZdTNsY1B3OUR1WVppVlRrM05GMUgzRnJkcitG?=
 =?utf-8?B?bThKY2JXdE1RSGpZUXlTVGxMQi9mb05iTE5TM2ZVWGlIUjM5dEw2L1E5a29l?=
 =?utf-8?B?TUJuVmpZUkdLTU8vOFowTmdYd0FMNlJlTzJ4VHdkMVhFWTBNMU5wVEhTbXRp?=
 =?utf-8?B?VVMwYjRZWkFwSy91dkZ0TE1mTTArQ210Yk0rU1NQcGxkSXdwS1BGVUE2L0pY?=
 =?utf-8?B?eVZRZkxQT25sV3d4dUp4SDY3cUJEUWVlcFZFaWtNZEh4MTFHSlpEbGFRYWRv?=
 =?utf-8?B?cmwyTWNqeHFZT0NWbUJsL2lRekhmVFQ3VCs4T25VQ0x1SHFOSEkzYXJleGRY?=
 =?utf-8?B?QzZmaFNDZHlZSjBRK0s4UWlpU3FrQ2ZCWkdXMVRCcjdod3pQT2tUcUlkWVBv?=
 =?utf-8?B?cHpJeUYrK0dJMnFOTTdqSW0xNlNpdDBnQkhQbDlYRS9oWS9aZnpQZEUrUUho?=
 =?utf-8?B?Uno5OFpkUjBVclpRY004b2hlRHkxS0RnbVhtU2QxeStXWjdzOTBraGtYU0kx?=
 =?utf-8?B?NWNRRDhsbGJCdTNrU3lNekxqOHBOZHFuc3FEZW9iQjJlMGlTYUd0TGlVbWhF?=
 =?utf-8?B?VXpqaUhuZmphMnVzU2xoL25rdFI0c1hjOEJqYUVVbWZPNjNZNDBIU1BpSXNl?=
 =?utf-8?B?ZWJVK3piMzJFbkZ3dEREcUhBcXRpTWw0aUFDTUlwNG9iQ3FyMFYrOHdicWxa?=
 =?utf-8?B?czhBRkE1TkRJak8zVHIxVmpVYyt6MXJKWVFsZjNTR0NlRHYweXBxY2xPY29P?=
 =?utf-8?B?TmpCRlVIYlNrR2lDUVZhYWlOQ3ZRVm1IM1ZpZWtJVU5HcEs3SFdHSENKZUpE?=
 =?utf-8?B?eGZjalhDaVRDQmNUS1NBSmdKNXJ2NXlnbGJxREwrdXVwR0pyUzc0NzY2dVNx?=
 =?utf-8?B?VXdBN1hQT3AwM3NhYWxRcXJxM0xFZEtON1ZNZUdSYlBmOGNPWmJhYmdqSCt0?=
 =?utf-8?B?QXNqaTN5aExJeG1VZW5Wa1NjWTRvS2p5UTUzMDBoalVLZ3FGc1RnakszWEVC?=
 =?utf-8?B?eE5UZURiSjJXWGZxaHhnZG9uYUpib3NlekErcEJYZy90SlpvK0VqbC8vUEh5?=
 =?utf-8?B?bC9iSmZNVExZUHIrM3gyKzR1UXlOaDdOUllRRlZLK0ZEYzUwblRhY2dubndt?=
 =?utf-8?B?ZDRQNVNZSnlJbmFqQ1pRT1dsc2k0ajFHRDQ0UnZSaWVFRlJVRCtlZDdrcUZC?=
 =?utf-8?B?b0QvWVpJdFh1Yi9zZUhsWW83Zi9ySTcwdklBNEZWb0ZBcmRCMEF4U3JpcVJ1?=
 =?utf-8?B?eUhmeWNXT08xVUlrWnVnaVRxdUJZVWxjRWxlK0ZYNDl3Q3FZeDdpRllHNzZh?=
 =?utf-8?B?Y1JFelp5elRVbFVDclZ3Sy9QaW8zNzMzcHFXQk5QVExjb0VlZEZUMzM4OXBG?=
 =?utf-8?B?NXcwVXpNVHdDNHFUR05NTmJPS1NEZy9QM21XMTUyKzZKdmxmMFdRYVd4MXlt?=
 =?utf-8?B?TDNXWUEzYmFtTjhYdGtoVFJFK3pGbFo1aE1hNVcrU3o0WE5YZWR5dVNTRE9T?=
 =?utf-8?B?UG9lNU5ReWhuQUtreFAreGovaWNVSkh5VWpOMGdsY0VMamNmTmNyTHN2RzdF?=
 =?utf-8?B?dWxCV25uOFpISndqQ3pRU0J3NHlIM2kyQ2twSXBDR3dyazZkaGZ5ckcvdEE5?=
 =?utf-8?B?UHlML2xybzk5MUZkM3ZXL2VyTzN3Z2R3MGhWaVBGRnBqVU9weU5xaTJha1oy?=
 =?utf-8?B?dFVaR0lMOUJaTXdsUDlzUDZTWWNqYmFIQjF1cHMrY3NCRW5TWWJIaTJ5ZjFp?=
 =?utf-8?B?NkxFR1V0K0RNQU9sOW8zT3NQNUFZZlpDMG5BS2c0STNGRlltMzdXZ1MvTllO?=
 =?utf-8?B?UlhiaThjNG1tTis3bWFHMCs4SzVaVko3aXhBOG02ZE4xKzZmeUZVZHp3Y3hl?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f3b61c-b6bc-4e4e-a7b8-08db654bf725
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 22:35:14.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWis6T4kCc2AWn/5abMmXUlCYy3H/0O/Bh+DeNxw7tJhEL6+lqtPNXSRcSJcinmgba/6J0BGNEMjRcRLgm7bOaiSda9ecV19iXYNO9wC07A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiANCj4gVGhpcyBhbmQgdGhlIFsxLzddIGNhbiBiZSBhcHBsaWVkIHdpdGhvdXQgdGhlIHJlc3Qg
b2YgdGhlIHNlcmllcywgc28NCj4gcGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRv
IGRvIHRoYXQuDQoNCg0KeWVzIHBsZWFzZSBkbyB0aGF0OyBpdCdzIGEgdXNlZnVsIGNsZWFudXAg
ZWl0aGVyIHdheSBhbmQgbWFrZXMgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgc2VyaWVzIHNtYWxs
ZXIvc2ltcGxlcg0KDQo=
