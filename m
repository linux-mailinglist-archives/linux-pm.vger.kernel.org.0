Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD529691CA7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBJK0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBJK0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 05:26:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FBD6C7FC
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676024801; x=1707560801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rfZlmUFlvlfQWE/U1+JNeHcFPui6vCSpvW+qVn0JEGA=;
  b=WlRlCLk2nGpthtol37+pJSlmBeTUps4fUVeerDcdJgHHZO/Jn3lD/CO4
   o6kf0zP8dQ7CZSAbgM2bt6VBrTXOvdYU8qlQqusqu5E9Rdvwx4DnhXKM3
   ko+Z/gUL8zbW3fvIuBkOLCHqXotTwlZ3GepMU1Q6YstegdaysQPzR1xPg
   qmoD3Wk9QHNVy+QprE4xW6/59pn1K5ZMidtMDb0lLkxJ+vBtNGDZ6cYv0
   buPI716+jWicdy+UVK+o4x8BXN2mHMw4MH88QTRnp+/bo+ZxSTxwGu8Bf
   1iPH6UTHAyOIi96zHODwLU+teK9fAX68sXHG0M0msP2Pdd853PCjlvdVp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="314032950"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="314032950"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700428074"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="700428074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2023 02:26:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 02:26:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 02:26:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 02:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErFzB9Va3+9fElUzPv1I0iHLVonViy5rIa7w3tEKCF+AKwU7EydTrjdWlzNT6S2UXSaTq5VOnemYPzqLlT1N33XlpseMga1QETv0xxFBRFB+pWw6xudAtPU0eucu34Mt5l1u5JcGuJtRVowjziQ/dwQ7Agr4knaAyf4OzZxVCf6iqdbjypsw+qX4VjRutsSSJR69DmTMWadaJBxoQK4KlgAPxSNGnXXhmDFv3M7e7Nb1s2LTG4OhwtXjAccW+g9OrCD1vioxrmsmBpNx9aLdB4NF5YBh3U/ERqTOydWZduD4Gz2d801jTIoepMAsgbNvD4pMlcjGcGJZAc6KHoRa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfZlmUFlvlfQWE/U1+JNeHcFPui6vCSpvW+qVn0JEGA=;
 b=i61VS/cPvgI17q4qGxgbpy2/RC98SA6TAUm8rJecFPMNWtKMqpF+rlbEuK+4MrQSmiBM+W8LXl+qm3V8OeDcGG560vfc3VAqnnjZrVF5dO8qrz9aHpqlfBv5aKP+pNGrcQcdyY9dCfnXrWSXijtBEiubPI5ukVxNuOvBxGmF6xQDQ3iFnTkrTbQmfXd8LliT0vrUukm+e65ISBSN+4qVY2NlY/5ymf1O6ihcUC5I+SA0/sLPQj2zvnaesq09fiGv2tngrV1LykM0xRtVLHAsfBtQr/FgeVqlmBK1umpLpjIpynyDlcG/bsBhDG5qlIU3cxPNErqipCllYuwq3YlShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 10:26:19 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 10:26:19 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "hagen@jauu.net" <hagen@jauu.net>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Kumar, Vinay" <vinay.kumar@intel.com>
Subject: Re: [PATCH] intel_idle: add support for Intel Raptorlake
Thread-Topic: [PATCH] intel_idle: add support for Intel Raptorlake
Thread-Index: AQHZO9wENtCJ6mPOVEK7AKUVUGdWn67H/HwA
Date:   Fri, 10 Feb 2023 10:26:19 +0000
Message-ID: <ebae23dc5c016821bd88f40ff92283bdfc9195ee.camel@intel.com>
References: <20230208163934.6119-1-hagen@jauu.net>
In-Reply-To: <20230208163934.6119-1-hagen@jauu.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN2PR11MB4742:EE_
x-ms-office365-filtering-correlation-id: ab39e551-f27f-43d2-3ced-08db0b513fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZtVD7Y/IZPqNQZVv0bS3EvR7TEx53fd6JoT9pVBNqNQCzZgpkaH9Ob3cFbpYVchK0hpv8MF5OcMtMawQQF3yDdc0awwMvF4MFNGPXz6KXRQx3/M8g0FEjmUpfyReDN1B9Le8F35M+03Im0S+DK+ov9tNHOroDku9JawP+44VMK+uJfj/lH4dNKE/Ej1IgybTZlc/vbXvjn7rpLTLPLx7ji53BfV5YCGOLghZ8/eJAB33p7hYO1Kt3LvOrX28NGbWHghmaxCJzpARhapcbp/xQcrTtXLKhDXjtd4LP9c1iJMIr1ELoXu4Ce+OUbgQZ7sLY2oO/P0UwoIF4xHUzxhz0gCImzhT9h0R0YKtSy9xkvOFwCfqBFyWM3VUBobrkqyzFMv9uPhJfh9dTqhBp5LeaWorl3VhXNJRctpPNoVdJLSDOKBwjB5drAvIgp5zS2MjNOw6QhscOoWcZXlCy8WcTjkNSNQyVBaWE30JCWGtyQe4zcRtF5M0OWo2qXMHJpfF3d7sHklqiKfGLRmrOfrn2gx9ZAiy44BCqbn0If3YycbT6UiNn7Qaryk7HCIsSwVS/pexWotIrImLBI8lasEUuUhF2YXVVCBJmT3nIRX5t/DuacmMmgOaofxJ9OfJvh5TJw/EhHTh/0+ffUMMV/iMTucseeKrQOw+kaGJl5By4sTjDQ8oU/P5KYiZr/o7DWXaOJbBRNLh/0B/r56EHsnZwdQQReNDb8YhpkvyyXRg6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(2616005)(316002)(122000001)(54906003)(8936002)(36756003)(2906002)(71200400001)(6486002)(478600001)(86362001)(66446008)(66946007)(110136005)(66476007)(66556008)(38070700005)(6506007)(64756008)(76116006)(91956017)(26005)(41300700001)(4326008)(186003)(8676002)(6512007)(82960400001)(966005)(83380400001)(5660300002)(38100700002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhVRzJYdEYxdTNwc09kQkRGTGh4VUxvYjBUaHBPODFhdWxnbS90bDRvbE1K?=
 =?utf-8?B?SnQ2dWhYeEw3WjM0RDlib1NRdkRYSDd0Sm43NU9SRityakVmU2J5RlpMaXVk?=
 =?utf-8?B?Uk40aGtKdUNYd2VKOEJtaGpWZDl3MmxlY0dnSklINzBsem9lRG53ckc0M0tV?=
 =?utf-8?B?V20vWmw5eDRuWWdDajluNU1lSWhvZk01R3Flb080RXdDYWZweXpmREd3Vldz?=
 =?utf-8?B?d0FpeUVRWG50Qm5yaCtBZ3YzRU9mek1jUWZqNll5cSt0cFAwa04xYkVNUHZY?=
 =?utf-8?B?Y0NPNWJMb3QvTG16R05IQnBseGxuNkVvYVdwTzJ2aWZYQTZLS2J6VmxTNDhh?=
 =?utf-8?B?RmVJU1FXZUp0dFViK1cvTVUra3E5VVpxbXJYcVB5OWxEV256ZCsxU2ErL0d3?=
 =?utf-8?B?NDNEQTZESzA2V3VGUHZkbHpKL1RSNXhCV3cvdEdHdzhuelExNThaRmtXdThG?=
 =?utf-8?B?RFU2NmVlbVV3ZGVVZHRRb0RsbmJhdEpaUkZwbGdQbXd6Tzh4eFhGQ2VoQ0xO?=
 =?utf-8?B?b1U0SFRPNmFiWnFsSy9RRFIvRGc4MFFzM3lBWjFBWnF3WXFMYXB4eWJ2eWlT?=
 =?utf-8?B?M2pCQU55NFcwY0VIbHlreXBMUndFblNQcUV6clhYRzBJcE5kL3pQUW1LS3cy?=
 =?utf-8?B?am1BRjRtUmpPNlIvL05LRzc5ZDlpbTV1UlNOK0Z1UGIyTkdQaWc2ZGd6eDl1?=
 =?utf-8?B?TEVIR1Q2R0M1VUNlUGlpMWVKVGJpRTR2VEpVTk44aGJKK0h0T3BITW96bVBt?=
 =?utf-8?B?aDUxSXlIU0RpemdHVmFCTlRZOXlUWGo1UGFJK3ZIMnpDNVYvNUYxTEZleGU4?=
 =?utf-8?B?V2V2N0F3d3luQ3JhL1E1MVJPcldsMGcrRzRETlllSW1vOEpITU40eXdXbjhV?=
 =?utf-8?B?alZzdUxsMWcxTS9CdUJPSk00cW9LNmNHamZEMnN3ZjNaV0QxcXN1S1dpNDJL?=
 =?utf-8?B?Q0llclltbXlUeVpHLzBBNWUxUWt0TWZoekFrU2NsUkM5NEg2RThVRXJLNW5u?=
 =?utf-8?B?ZVZRM3oxS016M1ZXOVZBRzl0TXNWaUI2YXU2MmdDeERySUdsZ1AxQ1RvSXJs?=
 =?utf-8?B?VGpSQUtHeWpweUhidTJIMUVzVU5uQU9pOWEvbGJLbXlUdzRySjhrbHpOM01F?=
 =?utf-8?B?WCtKV2FQd0lLa3RwdEVvZ1dkYjV3QzdjeFd2cnIwa3Q3azZsTXl1ZU52cGk2?=
 =?utf-8?B?OXJFbDhaZ0t6MVdKeVQvQlFpNFZvV2JxbVE5c2Q3QXU4S0p5VE9zL0toeGdB?=
 =?utf-8?B?SC9ZZFBiWHRmVmJ1OS96TW5vczN4RmQrVGtkckx5YnUrTjVxRTJZSzNOL09a?=
 =?utf-8?B?UVRqc0RNdkF6ZmlmMjRWMVhWaVF5SzhwdWp0dURLczdZNDloZllkQ1F4NDdr?=
 =?utf-8?B?R21OMHBNck9QQjlmOUc3RmZQVUVQeHZQSDhDcGhBR3h5b24rQ3Z2LzBiQW5z?=
 =?utf-8?B?V1FXcFhCczArbW5sWGRROVlxZHgvSG1mc3VxcEhUMklkemZuTlk5WnBjWkxy?=
 =?utf-8?B?ZHh4Q3FXNXdRYk5uUUgxZmdnQXdiVWZqUWVmYU41WkpETUNZUGNxMnFvMi9K?=
 =?utf-8?B?NmtlTXI0dVpoQmNBMHpJbWoyR3J6QnBLWTFhS05vTFM1QVIzVU1VQ2dlRVEy?=
 =?utf-8?B?SjZCbVBHNFpBUFNoT0lMTlN5U2E4QlJPT0J3elhkTnR6YVlnVUladmZ4cWpZ?=
 =?utf-8?B?ZnQxUFdiaXRvQWNNYUF2Y243NWh0ckJ3VWFmd3d5NlJiK2p1Tk13eG9uRm44?=
 =?utf-8?B?TFE0OWt1d2ptV1NWK2pvK3NXRVFrelM0TEhnWXF6ZGhLcmx1WkFMNVFaUmVI?=
 =?utf-8?B?YWVkSnBuL0ZoYUEya3hxOVpBeEFGb0Q5NWZqVlpYd0Y5S2NVTCsvSm5lK0Fa?=
 =?utf-8?B?S0pWeGw0OWFYUURuYWpkczB2ZGE0VW1MSnl0QnU2NGx4dVE5NjFLaFdiSFdR?=
 =?utf-8?B?UUg3UVE4SDI0bWVtVHdDQUJYU0lwTHFsRzdtdWVTdElFdFR6T2VPNnFqSEhS?=
 =?utf-8?B?dXd4eXpFbXI4aFFjeDh4OHhKdVQ0UVU4K1ZiRjBNazhHei9HSnd0SjRiZEZr?=
 =?utf-8?B?NXZhODlHRWpHNG1vbUNkN2NoMEZ4dFhMdjVnVjV4SlVnQ3FLcFVXck94Y0w0?=
 =?utf-8?B?R2duNDZCSDB3M0tPdzhYWDUwQkQ2NTJhdmVJWTI4WVBUQmg1M2ppSjlvZ1lW?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43841E3EB3BB8641B135940274F8AE03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab39e551-f27f-43d2-3ced-08db0b513fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:26:19.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GoNcHVlXwWEyVUpvYriG9sPz1kfYK9j/NJ2QfyPZJP2kro2h9RDJR+vWRLA5y98YLGaVUMx/Tx6Fzv3900LHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMy0wMi0wOCBhdCAxNzozOSArMDEwMCwgSGFnZW4gUGF1bCBQZmVp
ZmVyIHdyb3RlOg0KPiBSUEwgbWlzc2VzIEludGVsIElkbGUgKEMgU3RhdGUpIHN1cHBvcnQgYW5k
IEFDUEkgaXMgdXNlZCBhcyBhbg0KPiBmYWxsYmFjay4NCj4gVGhlIG1pcmNvYXJjaGl0ZWN0dXJl
IGJldHdlZW4gQURMIGFuZCBSUEwgZG9lcyBub3QgZGlmZmVyIG9uIHRoZQ0KPiBwb3dlcg0KPiBt
YW5hZ2VtZW50IGNyaXRpY2FsIGFzcGVjdHMsIHNvIEFETCBjYW4gYmUgdXNlZCBhcyBhIGJhc2Ug
YXQgdGhpcw0KPiBwb2ludC4NCj4gDQpQbGVhc2Ugc2VlIG15IHJlcGx5IGhlcmUNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9lMTFmODllZmM2N2VjOTBiYTFmZWQyMWJiZmViNGFmODc2NDEx
OWU5LmNhbWVsQGludGVsLmNvbS8NCg0KQW5kIEZZSSwgSSBtYXkgaGF2ZSBzb21lIHVwZGF0ZSBv
biBSUEwgaW50ZWxfaWRsZSBzdXBwb3J0IGxhdGVyLg0KDQp0aGFua3MsDQpydWkNCg0KPiBCZWZv
cmU6DQo+IA0KPiAgICQgZ3JlcCAuIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRs
ZS9zdGF0ZSovbmFtZQ0KPiAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9z
dGF0ZTAvbmFtZTpQT0xMDQo+ICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVpZGxl
L3N0YXRlMS9uYW1lOkMxX0FDUEkNCj4gICAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2Nw
dWlkbGUvc3RhdGUyL25hbWU6QzJfQUNQSQ0KPiAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw
dTAvY3B1aWRsZS9zdGF0ZTMvbmFtZTpDM19BQ1BJDQo+IA0KPiBBZnRlcjoNCj4gDQo+ICAgZ3Jl
cCAuIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZSovbmFtZQ0KPiAg
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTAvbmFtZTpQT0xMDQo+
ICAgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVpZGxlL3N0YXRlMS9uYW1lOkMxRQ0K
PiAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTIvbmFtZTpDNg0K
PiAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTMvbmFtZTpDOA0K
PiAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTQvbmFtZTpDMTAN
Cj4gDQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+IENjOiBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IENjOiBWaW5heSBLdW1h
ciA8dmluYXkua3VtYXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYWdlbiBQYXVsIFBm
ZWlmZXIgPGhhZ2VuQGphdXUubmV0Pg0KPiAtLS0NCj4gDQo+IEkgc2tpcHBlZCBSQVBUT1JMQUtF
X1AgYW5kIFJBUFRPUkxBS0VfUyBsaW5ldXAgc3VwcG9ydCAtIGp1c3QgYmVjYXVzZQ0KPiBvZg0K
PiBtaXNzaW5nIHRlc3RpbmcgY2FwYWJpbGl0eS4gQnV0IGNhbiBiZSBhZGRlZCBhbmQgd2lsbCBi
ZSAoaW1wbGljaXRseSkNCj4gdGVzdGVkIGJ5IC1yY1ggdXNlcnMgZHVyaW5nIG1lcmdlIHdpbmRv
dy4gQ2FuIGJlIGNvb2tlZCBpbiBhIHYyPyENCj4gLS0tDQo+ICBkcml2ZXJzL2lkbGUvaW50ZWxf
aWRsZS5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMgYi9kcml2ZXJzL2lkbGUvaW50
ZWxfaWRsZS5jDQo+IGluZGV4IGNmZWIyNGQ0MGQzNy4uZDFhODhkZmRiYzUzIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+ICsrKyBiL2RyaXZlcnMvaWRsZS9pbnRl
bF9pZGxlLmMNCj4gQEAgLTE0MzYsNiArMTQzNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeDg2
X2NwdV9pZCBpbnRlbF9pZGxlX2lkc1tdDQo+IF9faW5pdGNvbnN0ID0gew0KPiAgCVg4Nl9NQVRD
SF9JTlRFTF9GQU02X01PREVMKEFUT01fR09MRE1PTlRfUExVUywJJmlkbGVfY3B1X2J4dA0KPiAp
LA0KPiAgCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFUT01fR09MRE1PTlRfRCwJJmlkbGVf
Y3B1X2Rudg0KPiApLA0KPiAgCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFUT01fVFJFTU9O
VF9ELAkmaWRsZV9jcHVfc25yDQo+ICksDQo+ICsJWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwo
UkFQVE9STEFLRSwJCSZpZGxlX2NwdV9hZGwNCj4gKSwNCj4gIAl7fQ0KPiAgfTsNCj4gIA0KPiBA
QCAtMTg2Nyw2ICsxODY4LDcgQEAgc3RhdGljIHZvaWQgX19pbml0DQo+IGludGVsX2lkbGVfaW5p
dF9jc3RhdGVzX2ljcHUoc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYpDQo+ICAJY2FzZSBJTlRF
TF9GQU02X0FMREVSTEFLRToNCj4gIAljYXNlIElOVEVMX0ZBTTZfQUxERVJMQUtFX0w6DQo+ICAJ
Y2FzZSBJTlRFTF9GQU02X0FMREVSTEFLRV9OOg0KPiArCWNhc2UgSU5URUxfRkFNNl9SQVBUT1JM
QUtFOg0KPiAgCQlhZGxfaWRsZV9zdGF0ZV90YWJsZV91cGRhdGUoKTsNCj4gIAkJYnJlYWs7DQo+
ICAJfQ0K
