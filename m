Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3904BA9D6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbiBQTcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 14:32:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiBQTcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 14:32:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696495FF9;
        Thu, 17 Feb 2022 11:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645126316; x=1676662316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4gR7XG0ue55Vv+UuGxC5Xnn90Xaoap2pbfU0XWifnl8=;
  b=lYnyxTL+Sk2XP8t3p2q5mZBDpsQ0X6G6W9nXrSRDl5AqmkSSmnFdOs8c
   X4umeRBqG/KSTT9c4CBy35e6kVIqNLJ6mbd390P7qgb02JRqvXxlEqEQO
   Z2JGEc/M0Lp+AKCDFOaQ9M+ZRp/mEyOFULNyKLajrM+H/ue40wpvp9ieQ
   yx5QGeEi+KWDJycHOltLz5CSZW66jQKAwzKTgF4rMKuQmxnI3dF0hmKUl
   iKlWEWflQKGRVEsByxfEjMu4vOAvSO/zul74/8x2sW/KjARtnsC2snlgu
   oz135jDnMFhcSgY6KKrGf193gkWZt04fpCDNJhu8+7dOVRVktG5OFIbiN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238360580"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238360580"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="503656259"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 11:31:55 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 11:31:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 11:31:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 11:31:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ghk7MaSJwQYhyl8imFxSU+G5GdwaM23g3NbjbdEzTqPDS99dPakNf8K/sWZjhdzBsWa7Q7iaTxYnb0uQIjuYsOe1qilzwlWdGTwOBNEGx1MOhbQmjqH3WC4s2Ug46oqsAjyK5MJXe+qoldYcNcy271QnbNMeztV6JUrQ7j67rOa21f2hGb433K4GDhbiSWXjDqb5+OVjKfD1WTApK1FzDuqs4BZg1rzC3XATj9wYWY4k4nJi+nGjYhSWsj3w7ueGw8JF7XyJ/DornTSbNL9P4jdttuwVBG5EM/C61LUcxpgRdvpP82ge1KGZFVgUy0kiP044yfWSEasccD8BuSxACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gR7XG0ue55Vv+UuGxC5Xnn90Xaoap2pbfU0XWifnl8=;
 b=N+94Z8Zrzp7l4mKrFZrDDDntWLroa1oSEPjYZdZz0FQgLs6trx/ycNG1j4DX7uzD+ZBZykilzakc14Ubo0NH0NfinUIETaGCeam2xCR7bc2Fr2igxwgpEn98homTbvqA/BGRN2TRvWUg+kuV3wavYxLQz2Qi1GkeiR4wQnfxZT9tQfnOQnWRGOl27GdGnb76np7wFWuMY3vPnzCoH4w1OPYYReewHqhh31EVQxf9Q+mSFZtAuJ6cugdbcMiMEhrf4jQXIUTEW6qNhFDS70Vp19miy+9dVfbg7/HU0KRAuH7OPPfMR/NjnasMslbPtNTtu/afXGWKJoom91zCOzEjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 BL3PR11MB5697.namprd11.prod.outlook.com (2603:10b6:208:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 19:31:53 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::53c:25cb:8a4c:536a]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::53c:25cb:8a4c:536a%3]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 19:31:53 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [GIT PULL]: tools/power/x86/intel-speed-select pull request for
 5.18-rc1
Thread-Topic: [GIT PULL]: tools/power/x86/intel-speed-select pull request for
 5.18-rc1
Thread-Index: AQHYJDGn2EvexG8Vt0aocRk1kU4IsayYIMmAgAAA2gA=
Date:   Thu, 17 Feb 2022 19:31:53 +0000
Message-ID: <18bd2714095c76f2a525f0cee1b687743c4556f2.camel@intel.com>
References: <3aaa74cc6e0714cfc8ba4f729efbe8cc5b443eba.camel@intel.com>
         <CAJZ5v0j405cSudAq8fvTDO6fMxJECvvgjUba-hSVaJdwL1BCwQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j405cSudAq8fvTDO6fMxJECvvgjUba-hSVaJdwL1BCwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 (3.42.3-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f4737b3-5d97-41bc-c20d-08d9f24c2708
x-ms-traffictypediagnostic: BL3PR11MB5697:EE_
x-microsoft-antispam-prvs: <BL3PR11MB5697D68A9F01D7A4F77BACDCE4369@BL3PR11MB5697.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Too3/IfTVf1EHz49kWlAlle6ecDQCVQElJk45AjNALaBo9F/0xP7jPX4fYGgykbTlnuaZ7+Bc5YIGXoMI2P66K+FqnvhJOvsdwlAIw5QXzSxcERKs6t8S+sAqMb8cJr2dVyk2tiPAxbBecIgyGmOmsNwyXEJXM/paJ2KBeBDYdkPhFtg+aMxyT3b+1GGnJ4Crw+f69jp6FWuxe8+Tlb3h2JOhEYraGpSevrVT/xBFzeroRCHkj8m1wcA4v5uKZMV/bmHSQZ0/7qd52s3cgisTT+lu4dISRnnvFK5FtwnpnLGJ/ypu3HTlL7wQZ5s+URKiRjcy7dNkZiOAZ4mMw6pMxcTA1n+90+lziSonUyp6qHA3Kg/0lo3CwHJwiCnivB3Fd8wdhgDHEqHNKbyoe/lMS+fHLSkvkQi/Wcw8NuHjusXw43Ijqw0mHuI72WIIYSdDH6N8OfdKPpFdoKLNR7edwQvC/m1jjHEeeVgFacXboiO11TS27QPsO14VPl4BS518DAfF6uIGePTwO1OrzN3IYkTgA0Gn/RZ6hrN8riSS5SRNIDmCW38EcaA9+dqUVJU2moTosx+Bprxd21VjzsIjo5DZgK12wy5/J91RdalCc1AcqL+fcMoDMBk7GQUo64KgUfOEIiJNWr7otDh3QvV9g4x3gUb6EPTKl/PEEGFbDu80NIPj6PfWvJ4cl8/BNhBFWuPKLM/gGjFCEdXJn7WHe2p7R3/D9OQXAJBlmd5HfphzWnumhO1Jr1GlztUEoOYNu+EwgV1tFI/9zZTdqnbdiIvbZG43/+3b8Roq3Wu+DVbWSkmswar9vMzINTSCS4o+UdE3wsA5HH9gtUzrSausg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38070700005)(8936002)(38100700002)(91956017)(122000001)(5660300002)(82960400001)(86362001)(36756003)(316002)(66556008)(64756008)(66446008)(66476007)(66946007)(4326008)(71200400001)(53546011)(83380400001)(6916009)(54906003)(26005)(2616005)(6486002)(966005)(186003)(8676002)(6512007)(6506007)(76116006)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkxwcEwzd3FCOVRDdEo0ZHpxSzBlZnhWU2NhMEF4Tk90ekxWM1c0ZDRHYU9N?=
 =?utf-8?B?b1BVMVRRN0RXRWFGNXEvT29GcVJCK0ZpNFRlVVJ1L2k3NGZGcTdTbHNHTFFD?=
 =?utf-8?B?TWlrVmZFdXJEVFlCY3BlYnArdHM5M054Tnk4UXMwSE53ODFzei9XL3pBSlNw?=
 =?utf-8?B?Q0FGdjdGOHNwU0xObTk0ZzIrUHV0RmlIc2VLdzJFMmJ5TytRcmp1RTBzVmxp?=
 =?utf-8?B?UktoSHlYRm5TcE1QSHBET0QvZ084NWRId0dBUU42cjBHcHM0WU95c0V5R2Vu?=
 =?utf-8?B?cDdkY2w2WmJkeitVL2pUaWp6MWhDYlNFd0t3UENkVnNWVmxVaVpqZkdlL2d4?=
 =?utf-8?B?TG1UV3FUcXlYTklxeWpNa2VSS0RGRzF1SU4yak4rc0dZV1A2aGNtS25nSWhE?=
 =?utf-8?B?Z1JyaVU5RjBucEtqK3RJcUd1SEwxek9DendwNEEvTFlScWNIWnhIdTV0KzNv?=
 =?utf-8?B?VTg2aU9JUDdleFU0di9jTUZIYWExd3BIYzBhbndZZVpXM296a2hSY09XUkQ4?=
 =?utf-8?B?QnNmQUNqWXdSZW5iRWl0cXN0L3lVdEE2V0pDV1hHWFdLaGc2bG8yWkExY3Q2?=
 =?utf-8?B?SEhnVkcwMGRIYmlnbDQ5c0Z1RFB4bGVDMFBDeVRkMERhYll1bEtndjNNNkc3?=
 =?utf-8?B?RG15VWREczREeGgxTDV6a3VwZGdiOUhFYVM4aStaZzA3UkxFZ1ZFYm5LMmdn?=
 =?utf-8?B?d29uMndNQ2VyYmtKbkU1SCtxK2oyZGR1YTczamQwRUpuOFFVdWhvbnd0bGNZ?=
 =?utf-8?B?a0twbHBDWjRmR08xdWtrSTNrOXZIanB4ZUdNaFdPSERVNFlrUlRWUk5Kb2l1?=
 =?utf-8?B?aGl5T2ZHODhYQVRaaXFaWlFaRU9DWkdDNkp2Mm51bloxd3Jvd0toS2gzK3FR?=
 =?utf-8?B?aCtydnh5cHFkaWJIOCthK3BFTzZjdUJTbERHUHE0TFB4eEYveFVXWWw0NDBG?=
 =?utf-8?B?Wm9WUzNtZUMwdGttdERWL1Z2NEgvYWw4SE1WNVh0SWVMZEZTTHFYL1M0L2hG?=
 =?utf-8?B?aE1UTFZ0bmhxckQ2U3kvVEVXeU4rcVlLeWNsbGtIQ2gvNU90Vk5MVVhlOGpw?=
 =?utf-8?B?RnRUV3g2TDExKzBhS3FHSFlLZHNyem9aUU1xOWk5Z3ZMd1NOVVhwWUY3bjlw?=
 =?utf-8?B?LzRKblpKbVRURDkvREhLMTExSGhUR2d6bDlBdzNlcjRuY25FSnUweU9YdDFR?=
 =?utf-8?B?RVdRRXM4SGtCdUZYelh5OUxqY1h6UDMvRFhFeWk1cFNva3pZUEZ1M2JtNFJo?=
 =?utf-8?B?NWk5aC9vemlSWWNRNnBiWmNuRTBqSjFtemJIQTBubkxEYUR4N1ZObDhQeDl1?=
 =?utf-8?B?TWFmTGUydVl3aG1iOTMrdVdmTWQxU2M1QVM2c0lWb3M5SnhDb1RGQkw2eUJv?=
 =?utf-8?B?NHlqejh3QitlcWxKem5KYU1tNFlqSmZzMkg3SUovZjFldVY0Qjk0TEloSmhG?=
 =?utf-8?B?Y3RNcmc3cEhYdkQzekZGV3AxK2hmL3FQeW5ob0d0SngxOUlwYVM2VnpNV0FI?=
 =?utf-8?B?RUpqQjNTTmtZbEU3dWlFdWxVUlJCZ0tPQU5NK2F2cVU5RVY4aHI3WUl4Ynpi?=
 =?utf-8?B?NFV3T3pBQlhXTStVeDdjODRZV1ZJMytEeFdXbW0xMEZDcjh3Q1cyRWxmSndY?=
 =?utf-8?B?RzJFNThway9KT0hqMkpwYmUzc1NpVFNNRzRHeXR0N3Uzc1JlcTg0VjA4T0Vw?=
 =?utf-8?B?ZUZRbmxrOVlaTDd1M0xaZHZJM3lOV25Ra09PNU5YMXFBR1FJZURpS3Z1UXgv?=
 =?utf-8?B?UXNxRm5aMTBIYjNVdUdvbXFwOGVRNkk2d1NlRDQ3OGFpeHpzdVdyWS9McG00?=
 =?utf-8?B?UjJQYnZobUNMK0UxY2NVb0xXZCtuaGNRTVBha1ZlWE0vRkZrK0J2SklabWll?=
 =?utf-8?B?T0NJMjYrZUdsSXVFY3djWlVEaDRFZjdhbThaa1FXQWdLb3ZrMmZGMEEwdis0?=
 =?utf-8?B?SENWbGNXZ3JCWjc1T2d2L0tlQ0JIVURNOUpuZUJicldMTlNBUjE1bFdNN2Vp?=
 =?utf-8?B?dkUvY0pVKy9CQjlCbXpDTjFKay82eVJvT1h3QkhRbFZuYlM5UURibHFUbC9n?=
 =?utf-8?B?ZTlPVTdBL0VHRi84UW84c3V2RENVaWZTaHp1KzVwUXdqVlBxKy83MU5Ualp2?=
 =?utf-8?B?NmhUR2FsUzAxd3ZtbG9XZzZmWTM4eEk5WGZ5eUhkcE9NV0lwMnlRa0F5Vm9C?=
 =?utf-8?B?d2ZhaUc3eGp1SE5OZXlvVFBRMTB3dnZFeUwxU3NQaGtxcExTMVlWVHF5S29o?=
 =?utf-8?Q?ln6+yO/JFC6oVvHQ5Ku2QDwH9uG85aZy3ckZRT4auY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01A47AFCCEF0524C9F137C708E97BC46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4737b3-5d97-41bc-c20d-08d9f24c2708
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 19:31:53.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDU8Z7KjHnO29pImGKT0QRImVX+RiLcrmHAHHGvLGu+7Cp/JxhQnKc/w7W0ylo6/tM2HoMJPtRFkuaVwp4gCtU4zPt5/nYDLp0Mw/ZfBfUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTE3IGF0IDIwOjI4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBGZWIgMTcsIDIwMjIgYXQgODowNyBQTSBQYW5kcnV2YWRhLCBTcmluaXZh
cw0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhp
IFJhZmFlbCwNCj4gPiANCj4gPiBDaGFuZ2VzIG9uIHRvcCBvZg0KPiA+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JhZmFlbC9saW51eC1wbS5naXQNCj4g
PiB0aGVybWFsLWhmaQ0KPiA+IA0KPiA+IA0KPiA+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQNCj4gPiBjOTVhYTJiYWI5NzQzOTQ4MDllZGVhMjg2OTBmNjUwNGExNTc5MWI2Og0K
PiA+IA0KPiA+IMKgIHRoZXJtYWw6IGludGVsOiBoZmk6IElOVEVMX0hGSV9USEVSTUFMIGRlcGVu
ZHMgb24gTkVUICgyMDIyLTAyLTEwDQo+ID4gMjA6NTg6MjQgKzAxMDApDQo+ID4gDQo+ID4gYXJl
IGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+ID4gDQo+ID4gwqAgaHR0cHM6
Ly9naXRodWIuY29tL3NwYW5kcnV2YWRhL2xpbnV4LWtlcm5lbC5naXTCoGludGVsLXNzdC10aGVy
bWFsDQo+ID4gDQo+ID4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvDQo+ID4gZjM4NzRl
OTZmYWQ1OTZjZDJjMjQ0MTgwMmJlN2UxZDBjOWZhODY3NzoNCj4gPiANCj4gPiDCoCB0b29scy9w
b3dlci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0OiB2MS4xMiByZWxlYXNlICgyMDIyLTAyLTE3DQo+
ID4gMTA6NTc6MzggLTA4MDApDQo+ID4gDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IFNyaW5pdmFzIFBhbmRy
dXZhZGEgKDMpOg0KPiA+IMKgwqDCoMKgwqAgdG9vbHMvcG93ZXIveDg2L2ludGVsLXNwZWVkLXNl
bGVjdDogT09CIGRhZW1vbiBtb2RlDQo+ID4gwqDCoMKgwqDCoCB0b29scy9wb3dlci94ODYvaW50
ZWwtc3BlZWQtc2VsZWN0OiBIRkkgc3VwcG9ydA0KPiA+IMKgwqDCoMKgwqAgdG9vbHMvcG93ZXIv
eDg2L2ludGVsLXNwZWVkLXNlbGVjdDogdjEuMTIgcmVsZWFzZQ0KPiA+IA0KPiA+IMKgdG9vbHMv
cG93ZXIveDg2L2ludGVsLXNwZWVkLXNlbGVjdC9CdWlsZMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MiArLQ0KPiA+IMKgdG9vbHMvcG93ZXIveDg2L2ludGVsLXNwZWVkLXNlbGVjdC9NYWtlZmlsZcKg
wqDCoMKgwqAgfMKgIDEwICsrLQ0KPiA+IMKgdG9vbHMvcG93ZXIveDg2L2ludGVsLXNwZWVkLXNl
bGVjdC9oZmktZXZlbnRzLmPCoCB8IDMwOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiArKysrDQo+ID4g
KysrKysrKysrKysrDQo+ID4gwqB0b29scy9wb3dlci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0L2lz
c3QtY29uZmlnLmMgfMKgIDU0DQo+ID4gKysrKysrKysrKysrLS0tDQo+ID4gwqB0b29scy9wb3dl
ci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0L2lzc3QtZGFlbW9uLmMgfCAyNDQNCj4gPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+IMKgdG9vbHMvcG93ZXIveDg2L2ludGVsLXNwZWVkLXNlbGVjdC9pc3N0LmjCoMKgwqDC
oMKgwqDCoCB8wqAgMTMgKysrKw0KPiA+IMKgNiBmaWxlcyBjaGFuZ2VkLCA2MTcgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcG93
ZXIveDg2L2ludGVsLXNwZWVkLXNlbGVjdC9oZmktZXZlbnRzLmMNCj4gPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0b29scy9wb3dlci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0L2lzc3QtDQo+ID4gZGFl
bW9uLmMNCj4gDQo+IE1lcmdlZCBpbnRvIHRoZSB0aGVybWFsLWhmaSBicmFuY2ggYW5kIHB1c2hl
ZCBvdXQuDQpUaGFua3MuDQoNCj4gTmV4dCB0aW1lIEkgd291bGQgYXBwcmVjaWF0ZSBhZGRpbmcg
YSBjb25jaXNlIHN1bW1hcnkgb2YgdGhlIGNoYW5nZXMNCj4gdG8gdGhlIHB1bGwgcmVxdWVzdCwg
c28gdGhhdCBJIGNhbiBhZGQgaXQgdG8gdGhlIG1lcmdlIGNvbW1pdCBsb2cuDQo+IA0KU3VyZS4N
Cg0KVGhhbmtzLA0KU3Jpbml2YXMNCg0K
