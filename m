Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D6553A67
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbiFUTWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354010AbiFUTWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 15:22:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0212E681
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655839336; x=1687375336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZR/y1g+B0Jc10vVonmUID4WDElCeJyTp3e+5Ds4Zr1Q=;
  b=M2jORzIR37GkjtuFi3HpfP39Oo7j9XIId3ycUbNGCb8/twJr11x6+Npt
   fmvmbWztouiARKUzrVknjwPV4osfN9jLG6x97qdPVtAfy9y33QwKUhZBD
   CPGn1GfcvHU4EYJ6q/8khYDjnzL9UoggZ5J0ywG8qsoLmj1UwehmG8Kww
   Nob1yNxqF+hBEyyDn/A7ueyMuCZrUQw1u9rXi7unogimR5ZNrPm6Q7KGL
   j2HfNIMBLcB39q1azjwPRBUNbmnHw0N+IOEf5DaiS6DyKvCrX+YiwsiUy
   YnhUZPISG+W9BLh2vaS9OLbobnpNbtJEk6hZWE9JnxkiR5iagMJiZGVxq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263248520"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="263248520"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="764583548"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2022 12:22:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 12:22:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 12:22:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 12:22:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 12:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKOI8HqY6BXR1AGPT5LELBG1GTZRhDtDfzXoXVfyzad+Lf3GFrqNuvQhH93qhKAPM6ZXXooJ/M5iRlVfriU95Tuz+//g9fisoCVX7djsZJrAzTAoPG/KzNO1KEzbRUpjSlBrjKBmsJudlwxo2QNUHhtjLyNp6YubqIuCNVhAXtnztuCOoshFP6gXZO2pKCyEJ/WUt8hcU240yVWRBSHGObHLNbP8BadWx44pkU0OfrjhRstuLQQjSpxlkVczDmth+oWol77uTarOsCbljZllqEHQrCdZ3pUyEF7PeCmLH9RblnitDqdifKQRh5XLxy8tX8NIGJKlLVg53pdzVkUacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR/y1g+B0Jc10vVonmUID4WDElCeJyTp3e+5Ds4Zr1Q=;
 b=AjgplMY51zOboZIpWQ2+FPE6B0chZ/JIsF+mlH8QLP1eS4rCgf7EToO3TXLA6g8NR+qvzRXgDZ1k8yfMTpE0Wm/CT+Eaah2/FSywu0yI76/j5/pr21rRpmWItrMZMxe6rdCuruckW131HG6IU7fJ3PjEmp5wE++Uny8R9eo/YaeFVzPRty4siRmP6/MwVjtdxw/e+ZHzWiDJGbiUfQtr/yDmTuHPtq3E7i7wCR2qqImndwpPnFMa8qPWw6M8ueA6vKntBWaCrWh0pbhZdC4UbwXqLC7CBXutP7JH3NAvxTTHKGRu1WNzrsTWn7TdIDg6AP7rhn97AOWDPeVLORsZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by CH2PR11MB4325.namprd11.prod.outlook.com (2603:10b6:610:3e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Tue, 21 Jun
 2022 19:22:10 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::f4e2:4962:7d05:2965]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::f4e2:4962:7d05:2965%2]) with mapi id 15.20.5353.015; Tue, 21 Jun 2022
 19:22:10 +0000
From:   "Sworo, George D" <george.d.sworo@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Topic: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Index: AQHYdez4sg2jmwWTEkml1K+XDmCpS61HeTYAgAB+DgCAAA+SAIASCXKAgABMQwA=
Date:   Tue, 21 Jun 2022 19:22:09 +0000
Message-ID: <2883de49cd4a8698c8c3cd3104daa9fbbb3300cd.camel@intel.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
         <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
         <de55f764d1f91594d2abd61b9058ccbe45cf8035.camel@intel.com>
         <CY4PR1101MB2184428049D89C064419CE8FBBB39@CY4PR1101MB2184.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR1101MB2184428049D89C064419CE8FBBB39@CY4PR1101MB2184.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d968621e-9373-4293-b995-08da53bb56ae
x-ms-traffictypediagnostic: CH2PR11MB4325:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4325FAA680542CA965D6D015C0B39@CH2PR11MB4325.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpCS1/nPMsNe+ebQRQo1hTQIyt3UO+pAXySzxxSPBwA1IRwSn50RHhUqCO4ez88ouOrVHT3BTYrA8wldQtDGHH9gusU4yABv4mSXvUSYY7wIPIRuqqm9wq7VT1XY7gBhiG29mlFXwJDF2gcUXqUKYl6HJkF85DYEQ0heqDiArHwmiPYed3ZGirwmy/KNDr4G0UWpudNfT/OOlLc6llyUsPKjevYUepwuS0QJW0EefUd0Om0CHyf/0A6QBCKP4FfKnA5nr6yyeHdxTByoHIm4fZxE6zGyQZB8hvxs2YUPVTUPSl69Qqt0l9bfEwMn/OzRIpRM1X9WKd2aFgeat4PipMqAYETgGuCW+xRHiWnIpR7YWDGODc5uNk9FkGg7Q5rHoZvlbHVk6C1d3RipdXHSA4DMJqohAlr4mcqQeu37ywusPyOUquCqc0/U0rFAl6OXHfEEiXQpfUijyDdk0LPjqv5imHzmhdy0Iqg5UkdJP5nUdgVdOZ/HdIq0xfPxKJkFHNbVf7vWqqZb/SKhXLGYg68OZ0KcXiGc4HWQIH5oe6SL07gmBVeNtgNiu9sMY9RlCu1XZeKKaeAk88v6AV8/TvONsRIKOI8EPPRivudXEMypsFB+7uahPkjjyPaJCLMG5I656pWLHHM+HWyQ08Z+B9yvhuUFPM+17tVDZ+I9432Q/xMBrMFA2KlQ0sZv5fyyG9W6llgs7UryjGAWDFUNLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(396003)(346002)(39860400002)(136003)(38100700002)(86362001)(38070700005)(82960400001)(122000001)(186003)(316002)(2616005)(83380400001)(6512007)(26005)(8936002)(8676002)(2906002)(36756003)(66446008)(4326008)(76116006)(66946007)(64756008)(66476007)(66556008)(53546011)(41300700001)(71200400001)(6486002)(478600001)(5660300002)(6506007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vld5VG9UdC9yT1VDcjRLUFZIbjdlTDVpZjg1NEY5YytnK1I3TU1objhZME84?=
 =?utf-8?B?MThITVJYMllrK2FIam1CeU8waUozdjB0OU1IYnVJQXBwWW1NaW11TkpBRFU0?=
 =?utf-8?B?Ukt1SGpiaXpRK3lFdzJrcXZWUDdCTzhVaTlyckJvZnRVYXQyVnFaV0s4U1ZG?=
 =?utf-8?B?bCtpS2tWN2VtR1BJTGcyQTlDNnovazNNcmFJMVVZVXd5WWtsSGZTNmZmeXNF?=
 =?utf-8?B?WTRnVWNYQ2hrcWhWRllOL1prdFlhQ0syRWV1NjA5SEFmNTZqYitxQTdsbHRN?=
 =?utf-8?B?bEVHSm16dloybGZ3VkFENHVhUjk3V1B5aG51aGlGc09BbnNCUjNBaElPTklh?=
 =?utf-8?B?T01wbXlBMWVtL0RGdStHVWdoNFUrUU9IRDhIUnR6bFZwWFZjb05qaTBnZmhy?=
 =?utf-8?B?YkRGODhQdEhIZTRra3dCbldiN3hoYXZMb0hyWVpIbytyWTU5R1ZCbC9qeEFs?=
 =?utf-8?B?ODh1WkU2T1R3QW1IWG83Y2x2SHIyU2pTV0tsbUtHaGFVUUQveFpLV09NdG5J?=
 =?utf-8?B?Q29oTUdxRFlyeVpnTzR6WDA4M3NEVjd5UFUxZ3BJandNYm53bnQ0dHB6bTAz?=
 =?utf-8?B?cVVkQm9IeW5xUnJ3Q3oyZitlcGVIU2daYmplSVlsNFc5YUpaWTFyY2h5QSs5?=
 =?utf-8?B?UG1iNDF6TlE5SXpUeHRUeko5cTNVYmwyVExrOHhYQVRldGRCWHRUQjZMSS9h?=
 =?utf-8?B?WTFlMWoxWG42c3J5ZWN5THJyNkdIRk44eWFpQTljYmFTV3AzRFUxSnRsNmUz?=
 =?utf-8?B?LzBRSTFOZGZLdXdwZkVJQ0Z0YnVsbFNVblNxNXJwRWY4SXREZ2lFd051MnhE?=
 =?utf-8?B?WTJuQlRubUtGTnhOSGFNczVhT1dEYnRxbHl2bDRCaGFTbnAzOFNUTDhHcmov?=
 =?utf-8?B?RTQrbU14UHFESVFQKzRGMjViVEhhWXU3Wm1lOXNzVXZqUDJEL0hyR1FoUXFK?=
 =?utf-8?B?SjdqTTRKQktjME8vdE5LNU8ycUdoUWFHTGZhNER6azZEMlgxK3dLendGblhB?=
 =?utf-8?B?aURQNjNMaU85ZnpvSVNOaWVoQmdBWGdCYWpqeXQ0cHNiQnlPeS9UT2p5dUNT?=
 =?utf-8?B?QWV4VTYyQkU0MlMwZFBvUTRNUEw2WWlSUHgwZmMxZGRLd3ZHeWJVSDkxejNP?=
 =?utf-8?B?cGxsMko4RFlpM0NJV3phdWtoREhCdG4zakV2OXgzZCtYSmhMT1dWSVZjTzZX?=
 =?utf-8?B?OUZHNGxtNDVMRjMrdzhpRHZsY3ZiL2dCV01OM2pNVjI3bVRkKzJjYXFtZ3Y2?=
 =?utf-8?B?THdVc2JGLzA4U3Vtb0lJc0F1RE9aZDl4ZndxRkdmZlpHczZjSnUwRnR3SHpJ?=
 =?utf-8?B?Vjd6WFZLc01wdXNPTWZrbWxnQ2VtSkUwTXR0bVlNenplNDlSWXptTW5uZ3Fk?=
 =?utf-8?B?SlBNWE8rSjlqbEhaM0ZtOTNGekxlMFdpM3FjUEhWNEt5ZjJSenkxMVZYc3li?=
 =?utf-8?B?V05ocEcvbVhnS0dCTHBCOVBEYmdwd1VKajdUaFUvc3RzZEdXM05QVUdWOUx2?=
 =?utf-8?B?YU9jU3IrZGpyYTR3M0xHZDI4djlDNDJQNHR2VlhZeERGNUVsbWRkM1M3QmVx?=
 =?utf-8?B?L2p0YVJXWFFVaTRaK1luMlJDOXFyaHRDN3Fta2RNV1BwQUZMK1llVjJvKzlL?=
 =?utf-8?B?VkhUTzIwb2IvQ1Z4N2VyK0MwNTZvNWZoN2dhNmxaOUZBbW1RcXBzVDhZQjV0?=
 =?utf-8?B?RDRqREkwaHdPR0t0VUxvTFg5RmxHcWVERGNxc3FLTmdEc3ljSVc0UVUzN1JJ?=
 =?utf-8?B?Z0h2MDFkc2VjcVZ3eVVrQkVVcFR1aU5qaEExdEpFUkxmOTkraDZWQjdHMkRm?=
 =?utf-8?B?YXk5SFpUQWNiUUh1R01tQTVwS3MwTDR2cXdreDRVSzMwT3pkM0ZGMngxZDVk?=
 =?utf-8?B?dmdvWitNSTJmYjJFVkExY1VxcFFXV0ZBM2EzVkZ1U0JEaFRUWURqU3ZhRUsz?=
 =?utf-8?B?Q0tGOHR5WUs4MkxUVThuKzY5amtvc2pZYUlFRWxyZkFoMlpEWkRlNElFVmty?=
 =?utf-8?B?amVzdnFnVGZEMzh6S1FTVTY3Z2pkak9wTWJUZEtNc29DRDdnc0YxUlF4dC9X?=
 =?utf-8?B?N3lhaFRvbmhMd1FEZWp1ZUNWVFNzVkMxVFFES0lRaDNWd3N4ZkxidVozcW9C?=
 =?utf-8?B?b0VJZE9XMFM0cXZKemd1bk1YVVpSL1FRUWFzNU9COGZmelRpb1pYTXdlRHlr?=
 =?utf-8?B?TEtSUnA2RU5rbGhIZWhkcW01bmFzSFZMUmVLbEZ6cm1vNytuWjYwUTlTMGty?=
 =?utf-8?B?aDRYNTYrT045T1E0Tjk5L1Vhclo5N1k1TkZwQ2tMNGFzUFY2am1nZkFDRWJJ?=
 =?utf-8?B?dVhVSVpadFVVcHdBSHhyVjg5ZVovNk5NNEx5VE5NZ2dua3dVNDg2R3dNb2ZK?=
 =?utf-8?Q?S4hZbge9jsvGjFWOThst3b1m3JiHdZoYcs50/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5B0505D0C4B814DAB251BC378721FA0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968621e-9373-4293-b995-08da53bb56ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 19:22:10.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sANniMsVpPQdyZy/yglfmuLy/4ml7t/oFsAG/x/eG2sh2MgQxFLUAO8NpnCg7K1J0ohuHtRVhLUncvuQZuT4fmjIyksOy/XwQ7iHyVWYIrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIyLTA2LTIxIGF0IDE0OjQ5ICswMDAwLCBQYXduaWthciwgU3VtZWV0IFIgd3Jv
dGU6DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTd29ybywgR2Vv
cmdlIEQgPGdlb3JnZS5kLnN3b3JvQGludGVsLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIEp1bmUg
MTAsIDIwMjIgOTowMiBBTQ0KPiA+IFRvOiBaaGFuZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29t
PjsgDQo+ID4gc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207DQo+ID4gcmFmYWVs
QGtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVj
dDogUmU6IFtQQVRDSF0gcG93ZXJjYXA6IGludGVsX3JhcGw6IEFkZCBzdXBwb3J0IGZvcg0KPiA+
IFJBUFRPUkxBS0VfUA0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMi0wNi0xMCBhdCAxMDoyNiArMDgw
MCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDIyLTA2LTA5IGF0IDIwOjU1ICsw
MjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ID4gUnVpLCBTcmluaXZhcywgc2hv
dWxkIEkgdGFrZSB0aGlzIG9uZT8NCj4gPiA+IA0KPiA+ID4gU29ycnkgdGhhdCBJIG1pc3NlZCB0
aGlzIG9uZS4NCj4gPiA+IA0KPiA+ID4gR2VvcmdlLA0KPiA+ID4gDQo+ID4gPiBIYXZlIHRoaXMg
cGF0Y2ggYmVlbiB0ZXN0ZWQgeWV0Pw0KPiA+IHllcy4gVGhpcyBpcyB0ZXN0ZWQgb24gUlBMIFNP
Qy4gVGhhbmtzDQo+ID4gPiBJIGhhdmUgdGhlIHNhbWUgcGF0Y2ggaW50ZXJuYWxseSwgaXQgc2hv
dWxkIHdvcmsgYnV0IEkgaGF2ZW4ndA0KPiA+ID4gZ290DQo+ID4gPiBjaGFuY2UgdG8gdGVzdCBp
dCB5ZXQuDQo+ID4gPiANCj4gPiA+IHRoYW5rcywNCj4gPiA+IHJ1aQ0KPiA+ID4gPiBPbiBXZWQs
IEp1biAxLCAyMDIyIGF0IDk6MjIgUE0gPGdlb3JnZS5kLnN3b3JvQGludGVsLmNvbT4NCj4gPiA+
ID4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogR2VvcmdlIEQgU3dvcm8gPGdlb3JnZS5kLnN3b3Jv
QGludGVsLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGQgUkFQVE9STEFLRV9QIHRvIHRo
ZSBsaXN0IG9mIHN1cHBvcnRlZCBwcm9jZXNzb3IgbW9kZWwgaW4NCj4gPiA+ID4gPiB0aGUNCj4g
PiA+ID4gPiBJbnRlbA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFJBUEwgcG93ZXIgY2FwcGluZyBk
cml2ZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogR2VvcmdlIEQgU3dv
cm8gPGdlb3JnZS5kLnN3b3JvQGludGVsLmNvbT4NCj4gDQo+IEhpIEdlb3JnZSwgDQo+IFRoYW5r
IHlvdSBmb3IgdGhpcyBwYXRjaC4gDQo+IEkgaGF2ZSB0ZXN0ZWQgdGhpcyBvbiBSYXB0b3IgTGFr
ZSBzeXN0ZW0gYW5kIGl0IHdvcmtzLiANCj4gDQo+IFRlc3RlZC1ieTogU3VtZWV0IFBhd25pa2Fy
IDxzdW1lZXQuci5wYXduaWthckBpbnRlbC5jb20+IA0KPiANCj4gVGhhbmtzLA0KPiBTdW1lZXQu
IA0KPiANClRoYW5rcyBTdW1lZXQgZm9yIGNvbmZpcm1pbmchDQpAUmFmYWVsLCBsZXQgbWUga25v
dyBpZiB5b3UgaGF2ZSBmdXJ0aGVyIGNvbW1lbnRzDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
IGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDEgKw0KPiA+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiA+ID4g
Yi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ID4gPiBpbmRleCBh
OWM5OWQ5ZThiNDIuLjIxZDYyNGY5ZjVmYiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ID4gPiBAQCAtMTEwOSw2ICsxMTA5LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkDQo+ID4gPiA+ID4gcmFwbF9pZHNbXQ0K
PiA+ID4gPiA+IF9faW5pdGNvbnN0ID0gew0KPiA+ID4gPiA+ICAgICAgICAgWDg2X01BVENIX0lO
VEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX0wsICAgICAgICAgJnJhcGwNCj4gPiA+ID4gPiBfZGVm
DQo+ID4gPiA+ID4gYXUNCj4gPiA+ID4gPiBsdHNfY29yZSksDQo+ID4gPiA+ID4gICAgICAgICBY
ODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChBTERFUkxBS0VfTiwgICAgICAgICAmcmFwbA0KPiA+
ID4gPiA+IF9kZWYNCj4gPiA+ID4gPiBhdQ0KPiA+ID4gPiA+IGx0c19jb3JlKSwNCj4gPiA+ID4g
PiAgICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJBUFRPUkxBS0UsICAgICAgICAg
ICZyYXBsDQo+ID4gPiA+ID4gX2RlZg0KPiA+ID4gPiA+IGF1DQo+ID4gPiA+ID4gbHRzX2NvcmUp
LA0KPiA+ID4gPiA+ICsgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoUkFQVE9STEFL
RV9QLCAgICAgICAgJnJhcGwNCj4gPiA+ID4gPiBfZGVmDQo+ID4gPiA+ID4gYXUNCj4gPiA+ID4g
PiBsdHNfY29yZSksDQo+ID4gPiA+ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RF
TChTQVBQSElSRVJBUElEU19YLCAgICAmcmFwbA0KPiA+ID4gPiA+IF9kZWYNCj4gPiA+ID4gPiBh
dQ0KPiA+ID4gPiA+IGx0c19zcHJfc2VydmVyKSwNCj4gPiA+ID4gPiAgICAgICAgIFg4Nl9NQVRD
SF9JTlRFTF9GQU02X01PREVMKExBS0VGSUVMRCwgICAgICAgICAgICZyYXBsDQo+ID4gPiA+ID4g
X2RlZg0KPiA+ID4gPiA+IGF1DQo+ID4gPiA+ID4gbHRzX2NvcmUpLA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+ID4gDQo=
