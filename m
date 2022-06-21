Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C05534EE
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352081AbiFUOtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352058AbiFUOtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 10:49:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033026571
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655822976; x=1687358976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8QgY7+lLdxTiwuMHcsaRXVauH/rCkhkGTuDyGMGV/zI=;
  b=jkQGNsrTglWmLYpHHt8l7fcZxHX8xvoqkFhq4sp7EN741M3fE+K8Y/6c
   DXjlBKcE5Ti5eWe/JT1FSGN8JfHvAvci1U2Kd2+4EaRzscOpZtSZ4xEdy
   gphhjc5sZST3uKtdiTF/iUui1lFhJ8u2kJ/VsYuyNu6fw/fAOhAdON59/
   CXkMVg5EaQ1frfFhPkoT/lG02teOWIJ5ErfEV72s/xM1hZ6FzFSwrsF08
   WFs5xKU7dzSB2I+1EzLwtxditBsLyYfQu/sI+01oV8Q3hjYIfcDjJpr0K
   AFnAzdpSxZj2zNE+ODfk1uK8OEqtAUrp1D23BkYfTRrJWDkysQ7qhJ+GZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="366459609"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="366459609"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="689971431"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 07:49:35 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 07:49:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 07:49:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 07:49:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 07:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U71fJwQXyGDt3TV1NCIJ8+JCDElKhX2/7rLVMT3MZHrVSiPG0+FpS2G0FP3B6VvBc+nooBhBMnRd8vIWb6z2lXML5MY9tywuze4FS8ELcnk10/aOi+8k1IczSKs1p8+cl6JID8vBgMZgirT338QHrhNIuGUsclNBD7mOjDT+qnd0xKCbHTmFCaYuKMnE2VIAiBL+zJqrZFW/vpIUpHU+m1MGJbhseIVrPKbq3dgeYMG2g1oN2vPbL1VXKl4KNVW3x1YBvLdaLD3KdOc9WQl8N15PkaSTkzirio0WFNWbfY5ACqU89t4Dk8ZZF3lSezTxtoK37sDD0EZzFOzHp5VFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QgY7+lLdxTiwuMHcsaRXVauH/rCkhkGTuDyGMGV/zI=;
 b=Wu19XU4Dneq8Tl4UujThkafptbtWaTzU0VciiOf4396Eq5n2aDbKeyc99+VMFhZ6wJzj10A38PaZ4bbhljYvkq52vkktMmIKM3iBH9K2YMLqOUriKeQlllAZD63dyW5jM2JywPZ61uMBDcB8qBF2nWHio/nhuCRSuUh7mcU/JRKgG4x5pQjbmkFr4uBOGGBEpSbm9cBn5PWLiLmBmuv9pQam7F4HDJNi81OGoKkx229Vy3ebGuFI817rO622g64eJDmoEFHPb9L4oZL1m59crjQfVs70c40eRLHsm5b8tb487Jq7kLJ7psYnpkQAwkY8jrJZYi626ppQvWEO/F2gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR1101MB2184.namprd11.prod.outlook.com
 (2603:10b6:910:24::20) by BN7PR11MB2788.namprd11.prod.outlook.com
 (2603:10b6:406:b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 14:49:11 +0000
Received: from CY4PR1101MB2184.namprd11.prod.outlook.com
 ([fe80::98e7:1f5c:1b36:496e]) by CY4PR1101MB2184.namprd11.prod.outlook.com
 ([fe80::98e7:1f5c:1b36:496e%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 14:49:11 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     "Sworo, George D" <george.d.sworo@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Topic: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_P
Thread-Index: AQHYdf2RRmZYSs+P7k+R6doV1hQL4K1HeRQAgAB+DgCAABIPAIASBe7g
Date:   Tue, 21 Jun 2022 14:49:11 +0000
Message-ID: <CY4PR1101MB2184428049D89C064419CE8FBBB39@CY4PR1101MB2184.namprd11.prod.outlook.com>
References: <20220601192216.9174-1-george.d.sworo@intel.com>
         <CAJZ5v0j8kahM+=VDg0Dj3mZjhw9W+cq6y-TU0M3QF4mNxYn-bQ@mail.gmail.com>
         <13a8ee34a67ec8a59e926c91894365e8d512d260.camel@intel.com>
 <de55f764d1f91594d2abd61b9058ccbe45cf8035.camel@intel.com>
In-Reply-To: <de55f764d1f91594d2abd61b9058ccbe45cf8035.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dda7ca65-96ef-4903-96da-08da53953401
x-ms-traffictypediagnostic: BN7PR11MB2788:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB2788DE30E1C2B1789DEF5A16BBB39@BN7PR11MB2788.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bs6aPntfrYccyQyH9GmOR0k+J95cLyRzLIAmaORN2+kz8HeIRoyCSny88aIHpbrdlu+5nVZyk+Uf+l4srzGxBh9NZgxIciA8pUead8WgVyksIJ7Ke76DCeKTfcCdd8ZMIeykFrD541fF89oU0q4xS5mtzSZrBTdUTyyOlPsjhAJJplCf0Uf6KVTdorb3uzZTWeIbJBOB716apo5tNYdXqpnHqzQ//t5lDV6TMTL9NgDqPWTQbAhvC6MlpfPHeCiyZV7aQMguggPDPebcyBQyW+w7leNJbuGbRjgr0hshl9mojScxrtJW0MrA1fVaqeNR3+NkVDU6YZ174DwGfBdzxT0CiarCQUoyaoE5tJScG1GW+iDOZw5PNsYI29KPoBsIL0ThRejQ9eV3ncmLRJc90f49im6T3ep/8Z3aHZuzaRmwHKkdXDmr3cnI6NPAjmrAAKw+u87sedd7u1xtAXf4HtRw6XaTObVLuA9XMmfId7sgZ418wHRZYb8cPEaL+nqe4CPUIBG+0L4JarwACfRVqjOVWTkNfKnTe5uggC2hc6e91kIYbFdgsjvyPQ4QFOi6Vx4lGMeMq0dWicgdPejWPuI/Nq+2FSVNm/kCwlJ+w5qJL2062Mq8NVBKZhi/vmHp51NYgtBG502t04HciuQ9v7Pih2yyov3l8lJS0G7f+nNKg61deFuOr8VJnBZMvqcd/Vf94r9AcT1BrFhjnWWufA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(39860400002)(396003)(376002)(478600001)(5660300002)(8936002)(38100700002)(66556008)(66946007)(110136005)(76116006)(71200400001)(66476007)(8676002)(4326008)(52536014)(6506007)(9686003)(64756008)(7696005)(38070700005)(316002)(122000001)(53546011)(86362001)(26005)(83380400001)(82960400001)(66446008)(186003)(2906002)(55016003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emxNQS9ENzBaaEJ6ZUJsak95RklQU2NaR1RpQmpNN1h6aTZQdEJMTEQwU1Fq?=
 =?utf-8?B?VTRXY0h3ZjRNaEN1VkdubWh0YUIvUkhIMG42U0QyVXY0YjVQTEZRcXBjTm5o?=
 =?utf-8?B?MWtVaVdlY21wODYxMGlhUkF6MVFTYWp3eTM4Tk9JMGxCSnIvOGlpM0RIWUJH?=
 =?utf-8?B?eDU0dFQ2MC83YTZyalJsMndVUnNQWUNoYU5BbVE1S091L2dJRFF1WmphQ0Fn?=
 =?utf-8?B?c2ZBdndkaWl1RG1NVWlaVllkNURrRGhJSUsvY2RjQjBvR1d4U3pmN1FOVC9I?=
 =?utf-8?B?OW1zMDdyS2czYkRWaCtSbHJnQnIvZFJNVVh4c29pUVBkakFPbldnUnlQVmQr?=
 =?utf-8?B?SFZoY0pmWTI4T085c1ZNbUY0WkZCMlVwMHFXYVJ0anQ3NEIyekdicFZ0OTla?=
 =?utf-8?B?N0RFcUhNbEI2KzZBbTB3YUkvd2w5bWsyWUJBMDd2b3VWZUoxUFBIUmJ6YzIy?=
 =?utf-8?B?L25nSU5IbFk2cTU2Z0tteHdxUmxoQjhrSFN1dHVnbDdqV0xQUW1JbENNY0JR?=
 =?utf-8?B?eVc5QStiSWVhS2V0STFKSnVVaFRCYlpheFViZXR3cFlhSWhITi93YnhyV3F5?=
 =?utf-8?B?Y1RGRGs3QWk2UExieVMzaTdLNFJVVVNaVVl1YVVzZHZ2alcxUHhXOGp4UnhC?=
 =?utf-8?B?WFp0NGhSQ3JCejMxOTlXRUxWL2lKcXpEdFoyQ1d6aDFpWUtyN0FJY1VJNG4r?=
 =?utf-8?B?enNlWXN6WEhJeTBpMWE4bksxRXc4MVhFREtycVU4dVJ5ZVcrM0liMSsvem01?=
 =?utf-8?B?SWFOOW0yQjBVdWNscDlMRjY1T3VPNjFUS2FQdWU4VldyaDhWUElLbGh6S0Fz?=
 =?utf-8?B?OXoyOG0vNUhZd1VrMm1SSHExSUZ6b1luSjY2dXBrVW42aE4raFN6NDJ6Mys2?=
 =?utf-8?B?VkV4NzhOLzhuT1N1eFlTM1dackppOGlLZUZjNzhKRFJRaW1RMmc0SHBxT09E?=
 =?utf-8?B?YkJGclc1VDkrOVlySzdva0JHbjdUYXQ0bE1tQkdDNVByVlZQWEJJbnFnbGh2?=
 =?utf-8?B?MUtKZzVrTTBrMkhTajB0RVZVRHdhS0dQa2VmUFJLcURvM1c1Q05KTUhmaVpt?=
 =?utf-8?B?Skp3ZHZIQnVuNU90RjlNYjRRY0M4Tk9ScStZVGpFZUdLZTFkVWxZb3pYcmtW?=
 =?utf-8?B?ZmFrbmtPUSt1a3VodUJaN0EwcmV0eTNBSmRYdlFmeVRjdlNoVUd2bmFKTmNr?=
 =?utf-8?B?bTRQUHhUdG9uc3BvU2xNaWdMYjZDQkx5WDYvQSt2enZPUXo0dE5ocTA5b3Uz?=
 =?utf-8?B?RnBQeEx5VXBWWEFqdHYxZm1qTFcrTUExL0NKU1htOGxnYlRBcm42UGprWnQ2?=
 =?utf-8?B?YzdnV0kzTnhxeVAwL0d3b1dRdXkyZGlVbngrblhQaHBPMmFOYTZzWTd6d0xD?=
 =?utf-8?B?UlpwMGdiODJRVFRvQ0drTWJVVUFGREJ1RksrSEtpU1VYekdlQXErWWlCSERj?=
 =?utf-8?B?ZFlreFo3b2xhQVFqMnZTcVJYb0RzSDBhbzhyY2l4SlVMOFFzNGxxVjAyaTRa?=
 =?utf-8?B?ZnlHV2FFcmttaTBBcWZ0NGNnd2VXR3ZzRWN5UWEvQUhDRERSZkQwTnNjY1Bm?=
 =?utf-8?B?MVdRSlFwdGNjcU96M0sxTXpvT1dHRkRWUEVDUVRXdVZ4V0pCeW5GUWtJQ3k2?=
 =?utf-8?B?K2MvUUp3eHhBUGg2TFJZNXJBMUl1SlcwaTFFWnhYSFdLUDBwY1RQQWVNcHVT?=
 =?utf-8?B?STQ2Q0EybHBlT3FqUU5KYVU2OStPL2oxVElPTGZtR0lzanQvMlIwNkd1QkhV?=
 =?utf-8?B?dmhEdm1HQURwdzFVdVBRZTA1Yk5qUXlFS3VEU29xWlBPT2RPQWlaRmhuVWpX?=
 =?utf-8?B?Rm1xMnZLQ1RhaW1hTkNTSjJrVkZOS2VJNjQ5UU5jUUJBQjBRSk1TVTNVcU5r?=
 =?utf-8?B?NUQxUVQ5SEUxc0VhQTVzZXJiY01wR05WRmlaWlQ5bERVb2YwTUdzUjFKYm5E?=
 =?utf-8?B?YkJDM2tPTHJSWGVhUUt2M1Q5ZTBkaElIbjBSVW10bDZxUk1PMUI4NElWMGpa?=
 =?utf-8?B?b0laNVhUY1ZoTUhBOUE5a2hySTRpblFlK0Vwb3ZyL0ZkT0hCczU4UkRYa0NU?=
 =?utf-8?B?ZlpEVGtsdlREWk1ZeUw3SGtNbTVKUTNSMDZEYWJGa2xxelFSR0J1WVFjaHZl?=
 =?utf-8?B?eXYxWS85OHovRzB2N3JYcENWVXpxRGRkYXpFbUdodHV0VFpjbjhLaHJjemlL?=
 =?utf-8?B?NElQV094V2FTeFZCOFVYMndFM0tFZDl4ZjF2ZTVQUlVaRnRpYmNRWVg4anZk?=
 =?utf-8?B?ZC8rc1VtM1BBVDBaZ0dMSkFaQWk0ajE1MmpjRHFhQ3A1S0dXQkhxZURuTDF3?=
 =?utf-8?B?dUdDM2lFTVlYY0dORCtiU0NzTnZXUEVSalo0MHU0TWxvWUdXdzBTbkZ4TGpo?=
 =?utf-8?Q?cDdd5UJKadJ4CS8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda7ca65-96ef-4903-96da-08da53953401
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 14:49:11.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvEOMW90A4miGriUUiidCGQcDX7O3CCfsNDkJBLqxTVDiN//mwq+FFun7t8iMfoH8LRSkkztLn1ou/lcFkvTRho6y9pwULvcN8Vti5XB+0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3dvcm8sIEdlb3JnZSBE
IDxnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxMCwgMjAy
MiA5OjAyIEFNDQo+IFRvOiBaaGFuZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPjsgc3Jpbml2
YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207DQo+IHJhZmFlbEBrZXJuZWwub3JnDQo+IENj
OiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcG93ZXJj
YXA6IGludGVsX3JhcGw6IEFkZCBzdXBwb3J0IGZvciBSQVBUT1JMQUtFX1ANCj4gDQo+IE9uIEZy
aSwgMjAyMi0wNi0xMCBhdCAxMDoyNiArMDgwMCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyMi0wNi0wOSBhdCAyMDo1NSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+
ID4gPiBSdWksIFNyaW5pdmFzLCBzaG91bGQgSSB0YWtlIHRoaXMgb25lPw0KPiA+DQo+ID4gU29y
cnkgdGhhdCBJIG1pc3NlZCB0aGlzIG9uZS4NCj4gPg0KPiA+IEdlb3JnZSwNCj4gPg0KPiA+IEhh
dmUgdGhpcyBwYXRjaCBiZWVuIHRlc3RlZCB5ZXQ/DQo+IHllcy4gVGhpcyBpcyB0ZXN0ZWQgb24g
UlBMIFNPQy4gVGhhbmtzDQo+ID4gSSBoYXZlIHRoZSBzYW1lIHBhdGNoIGludGVybmFsbHksIGl0
IHNob3VsZCB3b3JrIGJ1dCBJIGhhdmVuJ3QgZ290DQo+ID4gY2hhbmNlIHRvIHRlc3QgaXQgeWV0
Lg0KPiA+DQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0KPiA+ID4gT24gV2VkLCBKdW4gMSwgMjAyMiBh
dCA5OjIyIFBNIDxnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiBGcm9t
OiBHZW9yZ2UgRCBTd29ybyA8Z2VvcmdlLmQuc3dvcm9AaW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+
ID4gPiBBZGQgUkFQVE9STEFLRV9QIHRvIHRoZSBsaXN0IG9mIHN1cHBvcnRlZCBwcm9jZXNzb3Ig
bW9kZWwgaW4gdGhlDQo+ID4gPiA+IEludGVsDQo+ID4gPiA+DQo+ID4gPiA+IFJBUEwgcG93ZXIg
Y2FwcGluZyBkcml2ZXIuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEdlb3JnZSBE
IFN3b3JvIDxnZW9yZ2UuZC5zd29yb0BpbnRlbC5jb20+DQoNCkhpIEdlb3JnZSwgDQpUaGFuayB5
b3UgZm9yIHRoaXMgcGF0Y2guIA0KSSBoYXZlIHRlc3RlZCB0aGlzIG9uIFJhcHRvciBMYWtlIHN5
c3RlbSBhbmQgaXQgd29ya3MuIA0KDQpUZXN0ZWQtYnk6IFN1bWVldCBQYXduaWthciA8c3VtZWV0
LnIucGF3bmlrYXJAaW50ZWwuY29tPiANCg0KVGhhbmtzLA0KU3VtZWV0LiANCg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDEgKw0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+
ID4gYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ID4gaW5kZXgg
YTljOTlkOWU4YjQyLi4yMWQ2MjRmOWY1ZmIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
cG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3Bvd2Vy
Y2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+ID4gQEAgLTExMDksNiArMTEwOSw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCByYXBsX2lkc1tdDQo+ID4gPiA+IF9faW5pdGNv
bnN0ID0gew0KPiA+ID4gPiAgICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFMREVS
TEFLRV9MLCAgICAgICAgICZyYXBsX2RlZg0KPiA+ID4gPiBhdQ0KPiA+ID4gPiBsdHNfY29yZSks
DQo+ID4gPiA+ICAgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX04s
ICAgICAgICAgJnJhcGxfZGVmDQo+ID4gPiA+IGF1DQo+ID4gPiA+IGx0c19jb3JlKSwNCj4gPiA+
ID4gICAgICAgICBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChSQVBUT1JMQUtFLCAgICAgICAg
ICAmcmFwbF9kZWYNCj4gPiA+ID4gYXUNCj4gPiA+ID4gbHRzX2NvcmUpLA0KPiA+ID4gPiArICAg
ICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJBUFRPUkxBS0VfUCwgICAgICAgICZyYXBs
X2RlZg0KPiA+ID4gPiBhdQ0KPiA+ID4gPiBsdHNfY29yZSksDQo+ID4gPiA+ICAgICAgICAgWDg2
X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoU0FQUEhJUkVSQVBJRFNfWCwgICAgJnJhcGxfZGVmDQo+
ID4gPiA+IGF1DQo+ID4gPiA+IGx0c19zcHJfc2VydmVyKSwNCj4gPiA+ID4gICAgICAgICBYODZf
TUFUQ0hfSU5URUxfRkFNNl9NT0RFTChMQUtFRklFTEQsICAgICAgICAgICAmcmFwbF9kZWYNCj4g
PiA+ID4gYXUNCj4gPiA+ID4gbHRzX2NvcmUpLA0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAyLjE3LjENCj4gPiA+ID4NCg==
