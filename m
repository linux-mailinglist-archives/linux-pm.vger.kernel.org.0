Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7796F6AFD4D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 04:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCHDPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 22:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCHDPh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 22:15:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4295E2B
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 19:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678245333; x=1709781333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aApnpwaRyXcZTPX8VxW4z9LWD339rruaTMYQul4fN4s=;
  b=UxB4qUbqju7qsjeuML9zmzJ4U8IF6x6ZDXXNHPGISy8hQDZOg9JMX7YD
   RN6ZqGEMscrGII5++jn7PIm5wgmzIJBoTS6W1ybdAd7t9M9k4daVLvCKN
   pIt2kAyb7tiqXlnSxGECnVv2dWES+S9Lv/T26ELh1hD17EMYjO6W8jBcs
   jpeDfYL70ncPn91RtBFO8/No3btJTfPP1qupksV7IG7XY9NtXTbL9PO24
   rpe8Ed8Sk2x5w4FsWwYrKFu2np96Pa3ilT6LbJjlVq/OOFe4t82xlsOH9
   1ivK8YoTqt47IsJkl/YghA7SslL7ICVftzLo1cO3kj4oX7kl0oL42mpxM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338367380"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="338367380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="786946069"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="786946069"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 07 Mar 2023 19:15:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 19:15:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 19:15:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 19:15:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpOpNOY/kId6zSUxWDcfdeRWJL9F0w/zR/eBRRFjpTDNXxvlo+Dj665jbIvtq47Pj5Cwi11CVf3AZPeLKN5OhKExGIwvQDAUVay9OYuTiQFQwWsfFImu667ne20n33MbF2vOlCLwsoODpgjLPgIKfWuj/rVrZvd0j6hvP3IDwUg4dmwjJTUEhoZdJ3T9DvsoqUY0k25oUXiwKcVuhG211m42Es09x5isEPrD7ThGRatZF9S6xI5UvrqHvb/UfwOV81wFZX6+JTCGxd4GYPueq+rTaON2Uph5hazNDt0uDm11dNNFs1RcrKEPSbKwdY/TeQ1yFrrrjCyldaU+NCtNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aApnpwaRyXcZTPX8VxW4z9LWD339rruaTMYQul4fN4s=;
 b=N8GUDI7uuxyKj85syrSQQtbtrCEMRBcpTKo+Vh6S+FQsF9ViBcmCQHB43xwv1cVzEzo1G2oKuovlwc4iFcQuQvrlEKXly/L0D/ConmcGUNXWTus8T87sH/PVEEGxNoj9x3hkJthkiTc4CCt/2K0nelVUbDa5kDubj/3uG9U6QIw2e2Hs+kWAkC/Eo4tobzxnT21KMbuKCWIp6XRy6WjRpvgjqN32ZRNdp8zrS1jyfICuVDl+eiQhlKe6M7dYv3ZdG1GUd5kjG//Sdk2cbuzkD9SWHZ7nCN65DFz/b/Ho4g9Tqz1BIEojuAl8cMR7ZUlLs6OpJMHXabUyGsJKwdTVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 03:15:30 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6134.024; Wed, 8 Mar 2023
 03:15:29 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "error27@gmail.com" <error27@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [bug report] thermal/x86_pkg_temp_thermal: Add support for
 handling dynamic tjmax
Thread-Topic: [bug report] thermal/x86_pkg_temp_thermal: Add support for
 handling dynamic tjmax
Thread-Index: AQHZUQlkZoIMlCPnnkqxieX05fR7P67wNmQA
Date:   Wed, 8 Mar 2023 03:15:29 +0000
Message-ID: <0ac7dd5f384dbb6045897b558afb6e91d20e32ed.camel@intel.com>
References: <add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain>
In-Reply-To: <add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: e82298e1-7be2-4d10-562e-08db1f835ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYTs04Qr0qFnOLUsji4lYaP6tVeLOqnpA2IAteiDFLCDbHiW2ybks1lzFIEu0vW5UKRGAAN01p5O6brRocmqpYR7/5RtE2irzY3NEM85sWoD7Fv6GTfYYKsQ14pFMfckD0tk6Q+HvQoD0MOFEuz0puv0GGJ+dp4qD8zwaTKGNg18tigCw9baT/wth0MmDMSdc1Wpx97lpF2NtJcXeJKL+FW/KhWUGNwSM4y4jpODCJCZOWpnrBMYW3+o3mRQgDMhzWHk5wpioO8+SgDIsuZFo25LprBanYj2XkU32M/YMNIhvo0p4Il5UbaVNTFfCF1cKcZy73BC9MDj7PrwDKPVh8MGOUD5Wie5HtW8jnoMPSYWHBaM+nr2hJCfKmhsFOb9wi17tPf+8e4jBX9sNv4AVR3CaPncprTT2DHBeRfqTZ9PFH2wV3CkcozZDkCBQB1NMoA6aqbNsnhW2T2tWbbCrq2hxHUmj/s+vKwVKdZnA/MqHtgk+SSgYMILrSdk5sE7vPmkTE18hO6ha5B0Cto5AXyfgzT1GaSyDfpZDD2gxre/HhvX/O2N5Am+/b2v92+0JhqSEaGioafzcBetB6hQQ4uaPrzqSRPGQzQFYSOUCjM2Dv0iss0LHhv/4eGD45eVTvYQniBFQqppfsPIyT/U6qHC37iI6hjRWXn25POd5ZaOs+lxImE9kYGUvMF8Z5viixjT8ulEOpcv3q7Fg5+Wew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(91956017)(122000001)(66946007)(66476007)(64756008)(82960400001)(66446008)(38100700002)(66556008)(8676002)(4326008)(6916009)(76116006)(8936002)(41300700001)(316002)(38070700005)(478600001)(5660300002)(86362001)(83380400001)(4744005)(6486002)(26005)(2906002)(71200400001)(6512007)(6506007)(186003)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUFxMEtZcDd6ZVRQYmdHa1N5QXdhcGhYVmh6WkNiUU5DVzZ0b2NCTFFOcTFt?=
 =?utf-8?B?NzhlWHhybHBkcSsrNGROc3R5dWpQTytheC8wMk5peE1sakxSdHdiRmptWmhm?=
 =?utf-8?B?UklxbnBBN0RiUm5kWWtTeVVPY1FERVlUTUZYa3E4Yjc2NEZ5NFNCR0hpc20r?=
 =?utf-8?B?TE1rQ3FQTTBaSTlxQXh6clNEYVNQYk1iYjJ6RUVwUlZ1clhlaTh1RkY2THBl?=
 =?utf-8?B?ckRwL2VpTWZwNitBYkJZSlcvcnl1YXErSlM4MnJDeTgzdTNqMGJyQmN0cjdp?=
 =?utf-8?B?R2h4VFV4VE5pcm1CVmxtYVdmbGgwSmJ6bGdLTW5UdTNXYVBpK1Y3OVY3aGFC?=
 =?utf-8?B?d3JHOXJBQ0ROS1AxOWNGbEJGTEEzVXh6czRLL09HVCtjYk0wRkhiUDN6SjFJ?=
 =?utf-8?B?cjZqN2VyeE1HRVRxUCs5bFE5VTZIeXdVSHhlc1BJdUFTWWQ3NHBtU0JRejVB?=
 =?utf-8?B?R2x3TVFpYW1EZXFIRkV6RkxlV0l6UFBBNFhtU3YyOVlhTEVMSndqTGg0TTZu?=
 =?utf-8?B?dXVvc0JwNTdvYjd1WjRLLzRiYzdBZUJLejRSVHZPQmRneUN1NytqYjFiUnNw?=
 =?utf-8?B?LzlEWUtwVFU1Q3hjVjlvWVdqZHBmTlNVdTVyUzkvU1AyYW1uRUlFOVk2Q0JO?=
 =?utf-8?B?UzV3ai9MbllRR2diRWR1WUMrTWI4dlRURlpsU25GMU5xR2RVbFFnZ1lJRU51?=
 =?utf-8?B?WDdxd0FmNUx5NTFVMmVnZjVGZWZKckdVMXdTUE5XR3NTa1B1c3JwWGJvN05Q?=
 =?utf-8?B?ektNYzdnWnY0YmJYcG4xT3AyVWs4L0xvZVFZbDFFWlJ0ZE5xSzQyVHR4Tm92?=
 =?utf-8?B?QTdZb0l2Z2JmREEwWWtCU3NDZkdVRCtvUFpvVFNWR3RONHA3eGtQMktIbTZI?=
 =?utf-8?B?QVlNZUJmaSt1VUZReEljMWFOL1lWM05ieW51Z282ZGxtRkd1VmlkN21tVC9v?=
 =?utf-8?B?eWdxcmFPRU9aT0NhSnJsNmV0M000QTNtVmJYb1NhejFpWFVYdEEyZnVwQTd2?=
 =?utf-8?B?Qk82Q0ZsS0x3RFZ6WnM3Yy9qWlZOQTNMWG5heGYzTXdrd2taaWtPbDB6aWJ2?=
 =?utf-8?B?TnNRSndIamlUVHFWb2VTaHhyZDhONndISFpNZVFrZXVyRTltNW1jTDRScXdH?=
 =?utf-8?B?VktjenFsZHJXeVRRc3ZkN2dGakVGbjBOVU02RFYzbm1UQUJ1b2FZZTZ1NXhy?=
 =?utf-8?B?aG1wTmpRZlhDandjN1hEL1o2aXRNZ25qZ0xwb0kvWFd3Zi84SURhM0J0dXpj?=
 =?utf-8?B?TElBSlRyUjVCTlBSOGEyT3NRblhUNnBXWWora2JHUGpTcFhNNnVVRUc3NER0?=
 =?utf-8?B?YzZ2d0NtRVkzNHBpR1d5dnJzWVpaMk5Db29HdEx3YWErV1BISCtubVRVN2xX?=
 =?utf-8?B?OHI4UVptOWo4SkdaY2cwc2E3bjhwdjlyZ29LaUJsSm92c0g0RG5CL1Nybjhq?=
 =?utf-8?B?WVR0Z09sUFVNSTVOOW5Ndkk1TjB5SmtIT3R3N21COEJaN21mYnUycVVucHV2?=
 =?utf-8?B?YTVSSFh5Q29GM2I0d2hycmNHdkh6aXVEQnFxTXdwRW55b3plNWRiNVFqUEhp?=
 =?utf-8?B?bE0xVmRZV1ZvWFBJRXhzRCtFQUlyL0Y3c0dHYXZzSGFhVkZIQUZBeVZkYXU3?=
 =?utf-8?B?akVyMDczeWF5YXorQlIxL09YK0daTHozNEVGK3Q3WHFmWXBpSW40TVBGZFBR?=
 =?utf-8?B?cW9hMGV2bEVncWU5M0lpVHNQUU1vWCtKanRZQzlOR3ZSVlZIeGZteXUxUURF?=
 =?utf-8?B?N0t6ZGM0dEpWVGp2V3B0bDhkUG9MOGtjYWllOWM3Um9ZeXlxcFlGYmZTUG9w?=
 =?utf-8?B?RFBkeDEvR05SWHM5dkRVbkRFVWZna1pSRkRVdmNQOUNEQllyc3RTSmR2Ymtv?=
 =?utf-8?B?N3VtNTZBcFV0OFM3d1hGczl5YVpaeXNKbElCTkRIR2JQb0cvU2RBbnNzV0VR?=
 =?utf-8?B?d05RNFVLKzl5VXl0NmQ4TDlwdjRZMTE5RC9Hb2tZeGoxZVc1OUl6dWZQQVcx?=
 =?utf-8?B?dmtiNkphY2hQNk1KZktKbUsrNERMYVRiYi9hOGFockhURitsTGFQUFRPOUZr?=
 =?utf-8?B?b0x3ME9XbC9Ub3hnbXE2eklMb0JQKzloMVdFL3kreTdReGlNV1JkcjhIK1l2?=
 =?utf-8?Q?kTy96Zn3p82kADb5Py4xfek/C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FD8321CAE01624693804E2D8CD32434@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82298e1-7be2-4d10-562e-08db1f835ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 03:15:29.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ak6ydk2UvbLDau/CO6xDwgLVAq6o9nuS+5Gopyn5BgnjuAAbOGqyGS6bL7/W4oqBuJ8sH3JXDq2g1OJ2SAsIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbiwNCg0KdGhhbmtzIGZvciB0aGUgcmVwb3J0Lg0KDQo+IFRoZSBwYXRjaCA1ODM3NGEz
OTcwYTA6ICJ0aGVybWFsL3g4Nl9wa2dfdGVtcF90aGVybWFsOiBBZGQgc3VwcG9ydA0KPiBmb3Ig
aGFuZGxpbmcgZHluYW1pYyB0am1heCIgZnJvbSBEZWMgMTksIDIwMjIsIGxlYWRzIHRvIHRoZSBm
b2xsb3dpbmcNCj4gU21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+IA0KPiAJZHJpdmVy
cy90aGVybWFsL2ludGVsL3g4Nl9wa2dfdGVtcF90aGVybWFsLmM6MTU5DQo+IHN5c19zZXRfdHJp
cF90ZW1wKCkNCj4gCXdhcm46IG5vIGxvd2VyIGJvdW5kIG9uICd0ZW1wJw0KPiANCkFjdHVhbGx5
LCB0aGlzIHByb2JsZW0gYWx3YXlzIGV4aXN0cy4gSSBoYXZlIHNlbnQgYSBwYXRjaCB0byBmaXgg
aXQuDQoNCk1heSBJIGtub3cgd2h5IGl0IGlzIGZvdW5kIG9ubHkgYWZ0ZXIgdGhlIHJlY2VudCBj
aGFuZ2U/DQoNCnRoYW5rcywNCnJ1aQ0KDQoNCg0KDQo=
