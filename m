Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9035721ADE
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jun 2023 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjFDWeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jun 2023 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jun 2023 18:34:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193BAF
        for <linux-pm@vger.kernel.org>; Sun,  4 Jun 2023 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685918059; x=1717454059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zYqv7y+hxmA8vO/ew+sbjtTcRYhnAG+iNSJKRame2Hw=;
  b=lCpFTreFJ+fBHrN7RlU26wZz7lIgzHVzGTSwOuyouk7uI/yQ/5QKx50B
   57oeBVjl2HYQ+bGiUr+7hvy3IbSl5wI/COPUj4nwSMWvlvr9yFzeczWpm
   0o+6LaNWMOLV8XSh7WtMn9wcp0MiDG977/SQvEat62ffhQB1sWvavqGku
   C/MtI4zUYJFqla808Yj8uhxJPGtBTDj9y7p+BaMPiI+i8eai0Ldo7VsQ2
   I+jpM8KMOL7P2aTQ238Ml42P5IugPwNk8dgQVrlWQO//DBAB74F+Oyw5k
   5lEVdW9dFWmy19h+/EgNqBICPMGKkam3volf8WzTEndOjrlwarvR0s4+c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="442609875"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442609875"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 15:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="955117839"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="955117839"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2023 15:34:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 15:34:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 15:34:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 15:34:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 15:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQwpFw6Eg8av0S8zcYp8ISQop0Qqd2R52xe2TvGjTcDyDMxJiugKlNbKwB9h9ngtt41dy9IUt5lslZM1PQ1lf4ytChU5KIRI2HPeTOGMhm22VycGjSiW1WyCYQPI1e2K96ZGYPjScLPJHSgBcT0gsE+6PwmcAe5XcXQSZQbbkbamhjuYALUe60PmB5CoFXQCGNBmPFP3H3jU9EFlj9rTputuVdfUk5y0U1JRe/gAct16Vvq6Pgw3/tS0a33jCixFHF7F4r13gSwgeU6eJYfUAAtdn4uD2+NL0uXj941CPns6iA2F7eKhQMDGZTIIWIkTmhfbISwZOizryoUAUG95Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYqv7y+hxmA8vO/ew+sbjtTcRYhnAG+iNSJKRame2Hw=;
 b=eXsAyjc+epRUU5E5mfi/ZR7UPXab3ZxZ0c7IE3iV9iKN0pQC0MeMfuTc0P3MxX2mJAwgtvomflWGE0sbjvosX8kBydtyHoJR5rJ4+SwPSq+gCX1sVfXYudXffj/f18lyyAKaMYjhqbQ9ZaftvovhvntX5pFmLnR01Ff63b7HDBg0UP4Rqbzo8sEejzIRuyO/aQnxizCIRB6FtIJ1nyKljGr6yRuEamGLX1axgjygsNDoW7CjGiYlMCzDEzBYCSmmmaTFJY77SGuflnLINQnwxeui9/Rcwa0903j8oIl8JxQKUqxDjdzSiLaGuHB3TbofcpyFLBGP/NL5RPVQlZANtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5719.namprd11.prod.outlook.com (2603:10b6:8:10::6) by
 PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Sun, 4 Jun 2023 22:34:17 +0000
Received: from DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::58cc:40e9:37bf:6621]) by DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::58cc:40e9:37bf:6621%4]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 22:34:15 +0000
From:   "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: RE: [PATCH 6/7] intel_idle: Add support for using intel_idle in a VM
 guest using just hlt
Thread-Topic: [PATCH 6/7] intel_idle: Add support for using intel_idle in a VM
 guest using just hlt
Thread-Index: AQHZlLbfyVMN+0L3wkGlHG/lVC2EEq960buAgABtY1A=
Date:   Sun, 4 Jun 2023 22:34:03 +0000
Deferred-Delivery: Sun, 4 Jun 2023 22:33:48 +0000
Message-ID: <DM8PR11MB571963A20668E8702E6F77EB924CA@DM8PR11MB5719.namprd11.prod.outlook.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
 <20230601182801.2622044-7-arjan@linux.intel.com>
 <CAJZ5v0h7VjEXaXzH1aiOP8PLdGLeYde6GkCbwJLLWLgx-Pnk4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7VjEXaXzH1aiOP8PLdGLeYde6GkCbwJLLWLgx-Pnk4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5719:EE_|PH0PR11MB5643:EE_
x-ms-office365-filtering-correlation-id: 70542866-817a-4feb-8b8a-08db654bd35a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UaSCP6TvuDcL2F+DcrEMTe7gEpLzDZIweAPYgrWrfLjYPAEu5trm4J3M2ykxzqAmmuURrfIgaO6t+q9XEL0mTD+nf+6yQBi6A8mmPEy9MhCPpkZiKKIWkk60yWV+AiTA2gQmfCj1hEYC2FceKtCNrrTcm5xjODrsVV/uMHhCaGWukpVfbpM8xXUY+isEDEGesL4cwKdp7TAOUa+ImvpWKI+8dq3lYVb+uBLNI6TO5NcDPS3AnIm326DwG0wVWqd0LHifGMY0RGCzOJFBrCd/F28urBluIJkuwl48nIZdXBI3PHN9etfRfV5CHDSVyOW8konSotIsTpRIKT6P36EqP+F3hW7Tx3au7OgUQ/exXsypXBcoMw6VEVI29omWQ3eViDlR++cvKbhukLb8KPvaUg1HfINrr7iROh5FyTXE9nAW7XgW0ax49JrY1sp9EQBxgrVjG3FPNYAZT7EqcKwCkFaN9uqSVa8GE6cvT2sR2E7hS31e7DgXYBCzF6IE958CjdUs3V2rpYWhnPG8HAJFS4ioSqwh4KPMdAp+hoePkgn3PVJMKBiM49DORtoysRNDrGd44ZsIX3DIP18EfIe8znRNc6sLFCvusbDnra0iTC3ObBSuYCoeXk04EgWwO1t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(38070700005)(2906002)(4744005)(86362001)(33656002)(5660300002)(52536014)(55016003)(83380400001)(6666004)(71200400001)(7696005)(186003)(26005)(6506007)(53546011)(9686003)(82960400001)(478600001)(110136005)(54906003)(76116006)(66446008)(122000001)(316002)(38100700002)(66476007)(64756008)(4326008)(66946007)(41300700001)(66556008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aytiNEZJQkRGbXBMSm9QOXJFdnF5ZUIwbENvcG51LytUVzRmNmNXY0llOTBn?=
 =?utf-8?B?eWVoSEpnZnZQUGRERmJIRStKK2JPU0M0MGoyeElJM2Z6UFV1ejhTOHc5ckEz?=
 =?utf-8?B?NG5pOGlwUVdpVEUrNjVnVHFJcmJyYTl0YWg3eFZxbkNjcXFodmZOSUNuOERE?=
 =?utf-8?B?bktkSHh6NjJOazh3NkdVMlF0SDR6MWp2djZKMUgvRnJEeFdPajdUZjcvNkU3?=
 =?utf-8?B?ZmZSOVh1N2Fsd09Cb2dzaS9FamN3RHV0b3dCUDY5RW1ENDgza1F0SC9UUXNk?=
 =?utf-8?B?WFdmcUxETmdlRUVES01ZWVBSNENDY2dNczBKc1pxLzlFcG1Ta2RBYlNDVlhX?=
 =?utf-8?B?MVhMYTlMVTgvQzk1UDFUQXlLdWtXNUh3SmNudGljak9oMzl1eTNmK0pqNXZS?=
 =?utf-8?B?U25qYTRVSkkvZC8ydUVJMTFwelFMVkZEcWF0R0hFOU1jVWExTHJVN0VvT1A3?=
 =?utf-8?B?bjhUU0hQelJMQ3VWNDgvRk1sajJZZUxkNk5wdnZCZDRMd3RVN3dkRW5OSTlv?=
 =?utf-8?B?b0hWN1NNK2dFSEtRd21NWkZ3L2xFKytkWTFRRmJsL0p6SlM3M0dSMm1LdUR3?=
 =?utf-8?B?OU9zMmo1STBMTms5eE5kMUlSeVUxVWlCQXVmYUVnckxoNXVsUnZMaW5ia0hh?=
 =?utf-8?B?aHlZcnJIMy9GQ3dwOWhoWGp0TnJKRzVnMXFUdCtqaVVJb3V3S3QzM0UvbDRG?=
 =?utf-8?B?U0ZOZnBSdnZVWEo3MnpiU0tQa3ZxMWdITHVaa2swbnEzNndLQ0xFNW9DVnZ1?=
 =?utf-8?B?OC9IS0hpc0c1b1FuVjV0aVEzZTBnRngxZ3VHNThMdkNUZG0zVWxkUzBVa1NS?=
 =?utf-8?B?TFZ3cUpjRDVaWDQvNnVoWTZpaW9xZmdtVHFmQUxYdGJaNE5IeDhZcVJUb0h2?=
 =?utf-8?B?bVQ1R0dnMTcrLzlTYTZtWlNiVnc0UGJLTVZndG5xejlLaVdWazRYUU5vMCsr?=
 =?utf-8?B?NllZanVhYTRXM1VUZ09tT3FWMHlwN0N3R0pBelpUS3ZIOXJlZ1pzWHlVMTkr?=
 =?utf-8?B?OEpXcVloV0VLcDRKaitMT25IS2FVaHNkNXZuWWNRMVhwdDZ4QTZYWDdLcnp6?=
 =?utf-8?B?bmpmM1hFaXR2bk04bEdhWlRKcE9LY3lFNFBSVTlocm9udmgyQzhPdUVISGJW?=
 =?utf-8?B?eExmZHA2Wk5nUGh1NGtja3B1WWhpcGo5NUMrS2crVndybVFKRUEvRW9DUkFn?=
 =?utf-8?B?UjJCZ05lUlJrQjVHTWJlMGN4eWhScytKUC9NeWNQUEZ6bHVmOHQzbisxTURU?=
 =?utf-8?B?L1pJeGRlYUVkcFJhaWEvSDZDcTkvR0lkMTBzT3BZZnRwQzYxUHZzekFxUFBY?=
 =?utf-8?B?K2Q2dVJBVEVnVmFGdkFUanp2NkpUdjhTbDh6SFlVdTdYTUN1Vlk2VVVzVncy?=
 =?utf-8?B?UnBVLzBMbG0xMk5rVW02SE1pWGQ1VmkyS0Z1RDN5eHkrWE9qdGovS21odjhD?=
 =?utf-8?B?ODJKSFBvc3ZPSHl3RjJCbzhCTkttUTkyVDkxaTZaZ0lMMFBWK3FrSXd4N1Fm?=
 =?utf-8?B?UnJ4QTFMOENzTXhCWDN3RVBDRzBpcUJvaU1BdTZ6Mkx5RWdCNWR0RExKdEgv?=
 =?utf-8?B?cWUyN3VGNW1aWmZheWVJaXZjTXFoVG8vM1FFMzZQU2x5OG5tYm5GcFNkRFZY?=
 =?utf-8?B?NDVjZ0ROUEwrdkV4LzQzTnBQdEIzeVJuVmJiSlhZUTV4UVA5YVJVNC8rNG5P?=
 =?utf-8?B?cDlwZDNUUHlFU1hQcDVOV2lLZk5hNFJhZjlBcUJxbWt3Nm1tSWhtUm9VTVFh?=
 =?utf-8?B?TnJETzJ6em81TXF2cUxjRjFPU1daOUI5NnNCYklpejJCeno1VHB6OEhVY2pV?=
 =?utf-8?B?U1lJUFB1QndweW9aNnBuMkl0TzlIV1BsSUE1bkxwdVdvVDl2YzlDcGo0N0lp?=
 =?utf-8?B?RzNsOEU3bVFRWlRxWlV4KzVqdXJoVkMwQW1JWnJDeFZTak1qZTdSbVBCNk83?=
 =?utf-8?B?U3dCMnpxeXNnUVZDamhYc2ZlYi9sZzVqcFRxTHVmeUhJMkpDdWoybjE1ODJo?=
 =?utf-8?B?U3ZLSWIzOEwwZ3RUQjZmL1AxWnN2UGdkdmhjem9HWVZqRUt6emx6eEpJYmV2?=
 =?utf-8?B?b0tWV1dnT1VxcGw0YVQ3dHhoaXUxQzlJZVBvQ2s3UXVlUXhmRXIvakFYcHpn?=
 =?utf-8?B?RjNNejNKSGphZGUwNDhidE5vMFRSdVB6MHpHdk51d2xpVllXUUtKT2FObklN?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70542866-817a-4feb-8b8a-08db654bd35a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 22:34:14.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+FxSTIWJbg0K7n4QRMzK/OUjcdCLLnVwBnQVAxJfwWw3oFREZ84ZfwVgmYW/xutdM5NzI/4mKcb/au+ZZc9GVwwPmN6GCDINclcB543kAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
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

PiANCj4gT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA4OjI44oCvUE0gPGFyamFuQGxpbnV4LmludGVs
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBcmphbiB2YW4gZGUgVmVuIDxhcmphbi52YW4u
ZGUudmVuQGludGVsLmNvbT4NCj4gPg0KPiA+IEluIGEgdHlwaWNhbCBWTSBndWVzdCwgdGhlIG13
YWl0IGluc3RydWN0aW9uIGlzIG5vdCBhdmFpbGFibGUsIGxlYXZpbmcgb25seSB0aGUNCj4gPiAn
aGx0JyBpbnN0cnVjdGlvbiAod2hpY2ggY2F1c2VzIGEgVk1FWElUIHRvIHRoZSBob3N0KS4NCj4g
DQo+IFdoYXQgaWYgaXQgaXMgYXZhaWxhYmxlPyAgSXQgY2FuIGJlIEFGQUlDUy4NCg0KaWYgaXQg
aXMgYXZhaWxhYmxlLCB0aGUgbm9ybWFsIGludGVsIGlkbGUgZHJpdmVyIGFzIGl0IGlzIHRvZGF5
IHdpbGwgYmUgdXNlZA0KKHRoaXMgaXMgb25seSBpbnN0YWxsaW5nIHRoZSBoYW5kbGVyIGluc2lk
ZSB0aGUgIm5vIG13YWl0IiBwYXRoKQ0KDQo+ID4gSW4gb3JkZXIgdG8gZG8gdGhpcywgYSBzaW1w
bGlmaWVkIHZlcnNpb24gb2YgdGhlIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9uDQo+ID4gZm9yIFZN
IGd1ZXN0cyBpcyBjcmVhdGVkLCBhbmQgdGhpcyB3aWxsIGJlIGNhbGxlZCBpZiB0aGUgQ1BVIGlz
IHJlY29nbml6ZWQsDQo+ID4gYnV0IG13YWl0IGlzIG5vdCBzdXBwb3J0ZWQsIGFuZCB3ZSdyZSBp
biBhIFZNIGd1ZXN0Lg0KPiANCj4gSXQgd2lsbCBjYXVzZSBpbnRlbF9pZGxlIHRvIGJlY29tZSB0
aGUgaWRsZSBkcml2ZXIgaW4gc29tZSBjYXNlcyBpbg0KPiB3aGljaCBBQ1BJIGlkbGUgaXMgdXNl
ZCBub3dhZGF5cyBpZiBJJ20gbm90IG1pc3Rha2VuLiAgV291bGRuJ3QgdGhhdA0KPiBiZSByZWdh
cmRlZCBhcyBhIHByb2JsZW0/DQoNCkFDUEkgaWRsZSB3aWxsIGV4cG9zZSAuLiBobHQgc2luY2Ug
bXdhaXQgaXMgbm90IGF2YWlsYWJsZS4NClNvIGV2ZW4gdGhlbiBpbnRlbF9pZGxlIGlzIGEgYmV0
dGVyIGNob2ljZSBpbiBteSB2aWV3DQoNCg==
