Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6246E6E8CA4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjDTIXi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjDTIXc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 04:23:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C454692
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978988; x=1713514988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NBsoYWOymLu8I+GfLGHPWZe22TZ9SIeXT7M2F9WeO58=;
  b=daVWTBi/8tKiLkZjywLe2EXNnv/3uYE6h5uS8MKSpfv0rSoRqhvHrQEc
   xZth+DzaXsWzxJxwUlw4YIjTdX7+UltXelb8pEIPjnmAvhCDpCnSrRnOQ
   3meDgz7ieNGROqtW7Dbt613gOG4CTSXy9cBKjsaEVXt2G12Y8WtiOyMJO
   1WvblI7HP61YCpHE7kwaYsJb+JIo6OP9L6GjyEQlfF0KDQ8qOsdG8xoMx
   mjq65VA+MTYQ5OS5K+WURW9cIdpej0Piy812+M8ewsNsfQ8r1IwadyXYL
   BoRmilorBTGnXCEatdqOOYbtflBIrEr50EukNuEsXnLJz03xWEgTO4ObZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431949719"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="431949719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691815682"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691815682"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 01:23:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:23:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:23:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:23:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWlXAx065VTBsUEmaJbR0uaerUMowhVBb9+LkcLDdCIV1IrN5GO+Vyjm0Hjq7JXtl1CY2bSW1iOtvUmwAiut5G2DSefjxsegLuk4yBVN2a8wd5se1MsJ5PKOUwvmFeKkYOiJfKN88H5grfYjJkr85cIeUCl/1dG7DUPzxDp/cobir0sSAqhNkS9AXzn6BjK05Nj1Dblz9jI5MEroQ6YnZ1mZkeikyqXejEvw+EmjmW5pJrugDCbksX+qpnueUEEYYAPEuQ3g86+jwQMcyg21iCBc3ZVin76vDc8A70r+y7t7qYf2zcID0/Y8nrN51mP/xI704TigflJfn3FVIXaUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBsoYWOymLu8I+GfLGHPWZe22TZ9SIeXT7M2F9WeO58=;
 b=SfsHdbXaB0UTdQVpri8ApGkvfsmxdfv1q2zlhlcIe/OkEMM8HhadBRMDr0kmo5uFugUD9eV5TqUbR0rcRikzyHniGoeMGOR0H40XtyQbhbOpXvQ9SdR+vOQGYAtFOl+NfM2OCHQ/Q6BUR+K1KoOwbdZnHmEWykGVcJQdBndeXNuGo141D6mk3ub163KrBNeKmp7LM1euK5MF+6qS0Ek+pDrDD+TAbT//7qz+x574ac6HdbpVqfwgVBkzIVhqrFymIXKVrMOUXKckhBAI7yZCDjQNNItYMMZ26y1TCDlyBeBzLIWOtv4JDbOeQjO411jvGLUON7mw9btVMS1r03/aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com (2603:10b6:a03:3ef::16)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:23:00 +0000
Received: from SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da]) by SJ0SPRMB0033.namprd11.prod.outlook.com
 ([fe80::fcba:364d:1990:e7da%6]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 08:23:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 5/7] intel_idle: fix confusing message
Thread-Topic: [PATCH 5/7] intel_idle: fix confusing message
Thread-Index: AQHZcs0D/uPG4IAx3UiIqhg5t/jyR68z3QYA
Date:   Thu, 20 Apr 2023 08:22:59 +0000
Message-ID: <7b6d517969d58857057ae803bf9c9d88714add89.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-6-dedekind1@gmail.com>
In-Reply-To: <20230419143947.1342730-6-dedekind1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0033:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 4e5a70dd-7663-402c-3e60-08db417873f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5U5BWCPTLt3WmLDO2tq10n9r/9LjYlqNw+wRCLr4q6dHylre0SYtKb0nXq45jNyE7NDoSli7oGgWvJa5m3kKSVC9I6wi/earknnn0Ej3nzc5WDVZRXRGR/ILIEiB6hKbWSbWlOt4m+6dK/t7f7fepxCE3ygylni96ncOJmoYmxuEAl/SFHLFcaFzlUp008U5DDIQS0tX8Gh+94Led+4DwWxuLPtlcsPDjTQ0mOoGt43L+T84DS1k72hZoo/xnwokrOrzbta3NOUUyvGUkY7/GL6TCvpI96K6Y5PM67HF8noHREOyfTOkvFcSEAgngheg8I3sMHHzUKsr21age9e8evZFazlK0praEPqfb2e5/eqY99uanIi2ynNm9xVDz1CDOE9M/Hy//M01ydzVmqe6Rfy6Eyfg0PxvaChKqYheq+2QX4f7FC5yXGoY4i+2gzrgArJa9DlLpahy/JDwX7PpMLodW49/r8J1jmLlNSfkJlLoJgB5G5ufOUBZAh/eeGoiom5ezU+xOsa6HrHq297GAd56ZTWp89uYfJ8hNwZ90YRWn1Mi/4finc9dvh60IR6JjF93UcfQQVswQPEw1YxM0DNOZzqjpJfJHWR20K20Vox7bJF9VLeEsP29jD6iKZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(36756003)(186003)(26005)(6506007)(82960400001)(38100700002)(122000001)(6512007)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(478600001)(6486002)(71200400001)(86362001)(38070700005)(15650500001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRHWDJUZlhBNGx2WXRRcFY3NXRhMVNES1hzcTJjZmkwdkN3dm1ibjl6UXV3?=
 =?utf-8?B?SG9RNlh4dlFwUGhqckRNNklwUVdyS0d3VGU2U2FpeElPV3RqYjkvTXVQbTdF?=
 =?utf-8?B?OG5hZFpaWmZuZ3A5QlI0bWZiOFVGV1krK0prb1Zpa3ZldnEwNkpMOG1kQnE2?=
 =?utf-8?B?MTdpUjlFZXY2WmF3dUIrVXFSRjZ6UWVZYUE2WTR0WUFuZ3lzUTA0aVFadjFV?=
 =?utf-8?B?ZGtoRnlCamRWSGEwT2xYaFlCdFFPK0g4K3FiNUdIbit3L3gyTFRNNUJvUkpu?=
 =?utf-8?B?TXFtM3AyNjg5Y1BRTVl2TkFzZ3dvZGVnWkVxbFpwM2x1MmExd0dneU9jV1ZY?=
 =?utf-8?B?UUlWNG5ROE9mTlhqU0NMZ0tlUXptT3lVWnZlTjJOWnlWQXVoQzlCNXdCWDVI?=
 =?utf-8?B?emp4cW0vOGJYTGhPaHlGWlJiallQTjV2dWpiUEUzT0FxYWQwVnk4WkVRNEtw?=
 =?utf-8?B?OHkrckhydk8va1FyWkV4NnNRZ1JoaUdudGtIVm03UGFLWlpVdVc0NWlrZVNn?=
 =?utf-8?B?SktvWmRTUXNFajVDQTRnS2piUmZyamR5a0N6OVI3cGVVS0E4R3ZzSU9SVDlq?=
 =?utf-8?B?VytUbE5uS1NlVVd1UTJ0WWI0enExR3lpUExycTMySXpUSGJJc2QvUzkrRVMv?=
 =?utf-8?B?Vlh4SUZCR3J6cnJaNERNMzJiWU1weXVlSXhySzVOMi9GV2ZsSU9hbXBsL2pD?=
 =?utf-8?B?dzRkcDRsTUN6QXNyMkJOczlMN01TVnplMDk5QUJyTWpMNGJ0NUFFckdHaHAz?=
 =?utf-8?B?dFI4dk9yL2lrN2I1WkdOVTIyQy91aytzdm9IOXBuWDRUbWJCWS9aQk5uWW80?=
 =?utf-8?B?UzFTT3pRb2JyOVhTd3VEc1hwalBIbjZyNGpaUFVHQ2J2dTRlR1FsWXowMGEw?=
 =?utf-8?B?dC9qT1AyNWFYRW9iTllLejgrTHVtd3Z5UUV6c2U0RjgvcHlTdWVKZGdRL3Ry?=
 =?utf-8?B?WE5tdEIzZlNIY29UV2tvOGh0Q2h6UDZ5bjVvS3p6NXYyQkNPdmVTeEh6MnBC?=
 =?utf-8?B?U1ZidTM1Rkg3VnZUaFFWdld2czAxemdEbnRPcEhKQVJmN2FJcytHZS83ZENh?=
 =?utf-8?B?WVhyV1RwWlhyODZBY0c2dWRPVGUxS1htcFoxN3ZUZC9kdE93ekN0cVRXU2xO?=
 =?utf-8?B?N2NwdTlhemdKaVZISVBDc1RMSzQzWlZyZFpjV1h1UzZraWVNNDVKTFFiSjRR?=
 =?utf-8?B?RGtYTHB3WDVPbXpaRTJnVmJWN0FHWXlrUTNlbFJvSGc5Y0xydm0yQkNNVExq?=
 =?utf-8?B?WmhJcGtuR2N4cTMwdlo3MTEzcUhuTHBHM0prMFBmSnZMVVRjSlY1STdKUW8y?=
 =?utf-8?B?REw4clVnc0t1STFmWGM4YzZQVitvQUlxQUliSkZaMGZVY0lXWFdRZDh0QWRX?=
 =?utf-8?B?VG1GVk1ZUWlvTlRPaEFINjR2MnNZRjhzb0thUkwraFpRSHhUVGdVNHFkbS9u?=
 =?utf-8?B?ZERIZlhTUFhsS3lTK3N5Mzl0NXowaThlbkVGK1g4UUNnYlh2NUlFcnY5eFdi?=
 =?utf-8?B?SytONDgxeWRMY1hCdldnREF0TldHbVBSSHVLU2xNUEtTMDI4bTNIdTRRdXd6?=
 =?utf-8?B?Y0lUMjduOTd4bHZ1TElyRVRwZXFuRDd4L2owRHl5MXdOT2tFcXNEOXg4Q3FW?=
 =?utf-8?B?Y1FuOW9RTFlLS01DWWh5RXVzYXhpaEIvd3Z5L1FXL2RnNEFEekZldEtUNkps?=
 =?utf-8?B?RG1aOEpPSzY4TGtNVnhncm5aVmN6SHVDK0ZQLzFST055U1doUngyMDFUbXpJ?=
 =?utf-8?B?ZFo2TUpnOUFDSWRuN3RGRERMbHhQaFJmTTNiSHFzcGdzbkRReWRHa1ZQaEI4?=
 =?utf-8?B?YlVuMC9uM3d0THE5M2pRYVcrblFaLzZPUUcwRk15OWRuYUo3TkZhMlQ0MEN4?=
 =?utf-8?B?QXNZZmsxU04vQ2JhUEdUSWhITGxOSVVuMkZLczdaT0J0bjFidzlMakZIQ2Rv?=
 =?utf-8?B?RGx2d3VRMlY4NTFjaFJwNUxIUzUvWjVxWWVycThvTjVHUGVSMjgvMm83NzRD?=
 =?utf-8?B?UEhlamdZOG5oQjdoMFBUZCtEN2tReHRPMnhlVDRhaWNOTjJkTW1tdUN4K2sr?=
 =?utf-8?B?SitjQ0czVFJnUDhQTUlaV3grREs0RkxhREltZ2ppRWJwOXJLZnRGUi90OFFS?=
 =?utf-8?Q?6AMkb02GD0zk/fXQCMavVK5U1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90C455AF4E11524084FA32790AE02C3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a70dd-7663-402c-3e60-08db417873f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:22:59.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzPpT8tHxCILr0i/PxtAG2xY3PVpDLHz3XSNfRhzJHJ5fpC1OwgYklcGbWVjy/NLuDY/Vy6C6PfqPPbPQCMRlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
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

T24gV2VkLCAyMDIzLTA0LTE5IGF0IDE3OjM5ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBGcm9tOiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVs
LmNvbT4NCj4gDQo+IEJ5IGRlZmF1bHQsIGFsbCBub24tUE9MTCBDLXN0YXRlcyBhcmUgZW50ZXJl
ZCB3aXRoIGludGVycnVwdHMNCj4gZGlzYWJsZS4NCj4gVGhlcmUgYXJlIDIgd2F5cyB0byBtYWtl
ICdpbnRlbF9pZGxlJyBlbnRlciBDLXN0YXRlcyB3aXRoIGludGVycnVwdHMNCj4gZW5hYmxlZDoN
Cj4gICAxLiBNYXJrIHRoZSBDLXN0YXRlIHdpdGggdGhlICdDUFVJRExFX0ZMQUdfSVJRX0VOQUJM
RScgZmxhZy4NCj4gICAyLiBVc2UgdGhlICdmb3JjZV9pcnFfb24nIG1vZHVsZSBwYXJhbWV0ZXIu
DQo+IA0KPiBUaGUgZm9ybWVyIGlzIHRoZSAicHJvcGVyIiB3YXkgb2YgZG9pbmcgaXQsIGl0IGlz
IHBlci1DLXN0YXRlIGFuZA0KPiBwZXItcGxhdGZvcm0uIFRoZSBsYXR0ZXIgaXMgZm9yIGRlYnVn
Z2luZyBwdXJwb3NlcyBvbmx5Lg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCAnaW50ZWxfaWRs
ZScgcHJpbnRzIHRoZSAiZm9yY2VkIGludGVsX2lkbGVfaXJxIg0KPiBtZXNzYWdlIGluIGJvdGgg
Y2FzZXMsIGV2ZW4gdGhvdWdoIHRoZSBmb3JtZXIgY2FzZSBkb2VzIG5vdCBuZWVkZWQNCj4gdGhp
cyBtZXNzYWdlLCBiZWNhdXNlIG5vdGhpbmcgaXMgZm9yY2VkIHRoZXJlLiBUaGlzIHBhdGNoIGFk
ZHJlc3Nlcw0KPiB0aGUNCj4gcHJvYmxlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydGVtIEJp
dHl1dHNraXkgPGFydGVtLmJpdHl1dHNraXlAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCj4gLS0t
DQo+ICBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgNSArKystLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KPiBp
bmRleCAxZGUzNmRmMTVkNWEuLmJmZjBkMTdhZWRhNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
ZGxlL2ludGVsX2lkbGUuYw0KPiArKysgYi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+IEBA
IC0xOTEyLDggKzE5MTIsOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQNCj4gaW50ZWxfaWRsZV9pbml0
X2NzdGF0ZXNfaWNwdShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikNCj4gIAkJCSAqLw0KPiAg
CQkJV0FSTl9PTl9PTkNFKHN0YXRlLT5mbGFncyAmDQo+IENQVUlETEVfRkxBR19JUlFfRU5BQkxF
KTsNCj4gIAkJCXN0YXRlLT5lbnRlciA9IGludGVsX2lkbGVfaWJyczsNCj4gLQkJfSBlbHNlIGlm
ICgoc3RhdGUtPmZsYWdzICYgQ1BVSURMRV9GTEFHX0lSUV9FTkFCTEUpIHx8DQo+IC0JCQkgICBm
b3JjZV9pcnFfb24pIHsNCj4gKwkJfSBlbHNlIGlmIChzdGF0ZS0+ZmxhZ3MgJiBDUFVJRExFX0ZM
QUdfSVJRX0VOQUJMRSkgew0KPiArCQkJc3RhdGUtPmVudGVyID0gaW50ZWxfaWRsZV9pcnE7DQo+
ICsJCX0gZWxzZSBpZiAoZm9yY2VfaXJxX29uKSB7DQo+ICAJCQlwcl9pbmZvKCJmb3JjZWQgaW50
ZWxfaWRsZV9pcnEgZm9yIHN0YXRlICVkXG4iLA0KPiBjc3RhdGUpOw0KPiAgCQkJc3RhdGUtPmVu
dGVyID0gaW50ZWxfaWRsZV9pcnE7DQo+ICAJCX0NCg==
