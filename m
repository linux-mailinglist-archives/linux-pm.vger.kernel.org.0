Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBD4BA941
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244990AbiBQTIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 14:08:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiBQTII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 14:08:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AD2B254;
        Thu, 17 Feb 2022 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645124872; x=1676660872;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=BNYxqqD7bPZfGBYCkDAwvD8+5AQzgshv+aeAhohkf0c=;
  b=LEw7mbUtvr21WkVSgj+YL7oN4VSXfajYa8PYk5CtiYtuUukzuHajMXlx
   Hmz5HEG+g8Tvh2ve5PKG0SgBT1+ZG9RzwuXiwyb+HHkfBNtuNG68QhkMI
   SD7TvrjuqDshMBGL7wxP4AdaxrrcVujizRyCNJV7WH2XkClG6tIqtO4o+
   pxS/JUBUbV3F5UWgu/lJLfcKO/hh7xn6eHhK7Mf9DzNxq0dvwv4WJFjhS
   5EmYs3uuRaSoD5p44YNZBX5tc0jnW11qMzSCYc6PjzVgmkI3asgtX/a3B
   6rj99UdivlwJNXQ6RmmN/p+e3ehdQL34pkamxnSJf7cHna+CA2qTewr7a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234482827"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="234482827"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="488593358"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 11:07:51 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 11:07:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 11:07:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 11:07:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu/39fqsmF1QOLNXooXcw7dMYSiZ/QWhnx+VmoxkgJ0VHivhMNOEvSerHNJ61tT8nVfUeo9sRrqGOSd3qZn8yViB6GHu5zHVduyvBqpu7jVsVc94BeTR0mNMpIbceVaYEq+9B2emyQ2sazKwEaLkZcf+N+v+tKJRM0pkCZGF0HtloeL+/4HfvwTlKkzA/juduA6Rt+Qybv1IjVCKcAMSKVUrBl3WGdYNUXM7mcVxVzungHwT+K4+tOHbTQcFCICup6LZLTzgh2ae3I2pgHlIZ315ctLer8rYIgjtAqcy6GZwM/Z9q14m0Tv1y58vdZDpQkHeHJWmsypzJg48mSIjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNYxqqD7bPZfGBYCkDAwvD8+5AQzgshv+aeAhohkf0c=;
 b=dnJeQ3TNKfSrqVXAZqMym8/9/URPze+566L87OZAemVMJ2n9PGdF9DsJTF0gysSHuBJVrrSrs//Ujf1xte0Ei/3oLZvT5aeJzuxG2VpdYNbCGVcfYhxRTlJzfYHJT5kJn2mcwr9AIfmjDivW0JGdXVQRgpmT8o6zhimqOxXhyis+aSX/UdnYzHrc+S26/VpHtRG9QzUynSi+eSvYICuPuOHM3yG8D8QEhUJW20/OeJdJbWNnS/VFrdI0McL4auNQRePaktDvVc8Mu828dHklp3or6JkVnoXNXzXW3azwEACz3DvVfHy1NQ+SlYMQyCUpxaxAawzvNSY7TgjCFZCBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Thu, 17 Feb 2022 19:07:49 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::53c:25cb:8a4c:536a]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::53c:25cb:8a4c:536a%3]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 19:07:48 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Subject: [GIT PULL]: tools/power/x86/intel-speed-select pull request for
 5.18-rc1
Thread-Topic: [GIT PULL]: tools/power/x86/intel-speed-select pull request for
 5.18-rc1
Thread-Index: AQHYJDGn2EvexG8Vt0aocRk1kU4IsQ==
Date:   Thu, 17 Feb 2022 19:07:48 +0000
Message-ID: <3aaa74cc6e0714cfc8ba4f729efbe8cc5b443eba.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 (3.42.3-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00862e5c-8922-4d2c-6e08-08d9f248c9f8
x-ms-traffictypediagnostic: CY4PR11MB1624:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1624A32E72E7237E97139916E4369@CY4PR11MB1624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUUUzP78z6XRubsLnNAWQX4Epv5Wu/Hz2CoZ4xD7RM7CW/XRLA84dQXeCtWDBD/J0p8XbKfx/kETPgF1LM2JBKbLMcr8DeX/fsuEHV1IN9uzWg9zv2EPVozv7ovbVxUjxM942N42UrmHMLmCM+SE0sru1BQqUNr9XriGbgaSeaYBN99qCS2Ofwb3bkKS0CqiJb5ikqrArGajr+qoYX2S6rn0mSoPoPiMwNjea2RJXSfZcbWxkVrjquEyZ485WpJmsX4i6CeFDW8QlYBRWSxMkrPe0t5P+7KAok8Ga7GstX76ApOhrwku2EUk+p263bH8yady5UxxdpHtXVg2T6B1rGKTE1obi89nuHMIjqcJlaQB4oW4Jdjb/z9hKlkHLtDeUMNzDEtlkkdKlbI4dvhQY74JCaSqdUoucYh6ugeEk8M9+/aEA3i451OB1OfeLO/U0v0wFLXHrQzjXNrSuT+d+XSs1yPDMCfF24yNWhRwQ0C11Zm0jvDZlnLQKm88Rv8NH3gUtgOpltaaOaec1y4IW/Kvp///YtvO5a9Jid09i+A9eIQhVdV7jdW3i5lSCdfI1KJA3YiQFHSQArn8KNSe0Hudn4fKYprVFdIOjJQ8DQlBjLesGgOffr1QtkNeKi3cp9sPhsTIAcGLPvDsybi42dIJ+KxAfSMfJ0dnuIgrej9GDCCKrEzdPAOY3/7EsoahYDpMZ+K+MsBlM3yWhCxFfKFCBjYQqG+HRQOoZ2g6TaHncGJu0cMCOHUYhlC5KnjvGfkKq0idNhp//AAPqIN2G/K9t3q3D3K/GwAGzk1N8bMT/EBilD4tbJjlNsGHCTXwtueKMh9bUATh4qN7aC2GkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(82960400001)(2616005)(71200400001)(122000001)(86362001)(8676002)(2906002)(54906003)(508600001)(6506007)(8936002)(36756003)(966005)(38070700005)(316002)(83380400001)(38100700002)(186003)(26005)(6486002)(91956017)(76116006)(64756008)(6916009)(66946007)(66476007)(6512007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXQ1c1ErSHBRUVdCVWUvS3RkTHE3Wi9rcUY0U2twMzhrdC9KQ2xLZThPSjdK?=
 =?utf-8?B?am9kVHJleFBxbERDZlpacUtJTW0yRlI3TFFHN0JiWk42SXNnV0xMZ1VIdUR4?=
 =?utf-8?B?TEJJY3NIdjhlQjR3Y2drQ1JEUUFqMUJ3WGhSU005TWtVRWh5Zjc5dVRSM25v?=
 =?utf-8?B?eTJUb2x0U3d5anJlNFdCQWl5R3M0VVB4RXIzWjdURFZCYWVvZXR1K05pbVps?=
 =?utf-8?B?YkZZK2pVMUlhdEQ0bUUwYytCMGtHRi9MbzdVL2E5OXJ4dU1GUXNtTDVKZDJK?=
 =?utf-8?B?OEV4Y3hDcC9Fa3E0QlB1Wk50RThMSHBUZU50ejZkZTNrdzVMSDBBS29rSmc0?=
 =?utf-8?B?ajRKU0lJblJxSHNwNFRna1FnQ3BtU2w2QjEwWlg4UkJrTkhOSnZyMWRTMllY?=
 =?utf-8?B?bXZ3WXhhclQ2MGxzNStuMWF1Z3YvYWpKZ3ZaNmdPL0FnWitLSUdUZUdBUkhv?=
 =?utf-8?B?ZkUzeTFHbEIzVlBQV0JrZzlyRDlrbFp2TytOZWNmV3kwcFYxSXFUTjAvc1Zx?=
 =?utf-8?B?elc3cFFJYTU0Nk54RUUycWQ4WjVxV2twTDVYVVlqalVTa0hVR09HZ3Z5ZVhi?=
 =?utf-8?B?NHlXN2ozWDlSMDdUOTJIM25FbEY1UVUrNUdzc3U2TjIwMjFPN1N1QmJFT0FI?=
 =?utf-8?B?ME5pWms3ZWYvbHU1WkI3ampsYjhYM3F3WjNjSnp3TTdpdzM3djViMnQ2eHQx?=
 =?utf-8?B?R3FSN0F1QlVLRk5jaEpYZVE0eFBOaTBlQm5NbDRrZG11RFkrYmMxKzRoQnlK?=
 =?utf-8?B?aDVuSlRpRE5hM0lWcGdGMWhoNFRPV1F2WUxRTGtTN1JYSVFiQWpMMnBmd1V3?=
 =?utf-8?B?NDNyZjFqOEw2eG5jT1JiWVg0WUo1QnNZVVRsK0M1LzZzUmZheGR4Z1NIamw4?=
 =?utf-8?B?VGNaRitnc2JxWm91YkpXL3V3dHN0eVJjRU9Ub0Z3WHZIQWdYeXBZV1A2dUE1?=
 =?utf-8?B?b25NVCtjdTlsTnFjVFc4ZnZWL2lWUDFROXVQdW5aaEYyVXVZUHhwcEN3ZERE?=
 =?utf-8?B?c0tDUUlaYkNyZUUwcVhWb1ZNMXF2UWd0cVJYZzRzOHBuVzdZTkNkU3VaLzVz?=
 =?utf-8?B?VnlTSUM4VFptL1o0d1hwMFJvQUZGNFVHcnFldFdTUkVjOXRMamVDUE96cWZE?=
 =?utf-8?B?Qk5IaUVSeU9CZGZxUUNOT2d5bVRDZklxb2FKZGV2VTZwQ0VKV3ZJUXBTdVVl?=
 =?utf-8?B?SGNkNkFzUlNWQkRMZFVWUGdaQjJ0RFhLdVBLdjR1clpZN05tSDJyeUIvWjNw?=
 =?utf-8?B?SVZ6eitoTmJyNm1PUXRFRGJUdGgzK1hZdDRVSkZDY0ZLS2U1VWErYW1XY25N?=
 =?utf-8?B?cGM3S1hrSG5ZNkwxbnlTT2FkZ1JxVVE1R3QwUHBLbFFBZVE4R2ZaWHp1UHFz?=
 =?utf-8?B?TElMK2d0dVhvSmM2MzJQUWg3YVRVMzZQcE4xTjhqNkRkNWdMSXN4SnpmbXV5?=
 =?utf-8?B?Q1BRZXh2MlpXSGt4c1RqZThtZUg0VllBOFZHdkJRejFpYUFuNjFqcVdsd21v?=
 =?utf-8?B?QWM0WEZKd0ZCNkR4d0lRR1hZY2ZiWXVucWwvcTlZUE10WDRDazVJQnduditj?=
 =?utf-8?B?ckw4M1pHa3NXVmpyRUpKNHVqTjBpOWg4bEJ1UHo2Sy9TVEc0cmFRTmlVSU1v?=
 =?utf-8?B?YWk0azFVVW5wUGdxVUZVR1N1VUtuUE9sanJzSFlRZjdmdTVpVW1qTkZQSFFD?=
 =?utf-8?B?bVBmdmNhdmNtaThsYUsxamVHMUh1RkxRTENhMGUxQTRVdHlGSkZWTzRPamJr?=
 =?utf-8?B?V1JHQk0wNlp0eXVrU3YyNzV6RFhnMysyM05JMXczS1ZFMHVEZTNNSkZqVmNM?=
 =?utf-8?B?cncvbUt4c2JHajJDME5KanRmWWpJK3A1dkdIQXBQdDV3NU8zTDZWRWFHQmpC?=
 =?utf-8?B?Uitqc1JOTWp3RkJ1M0pBY1VEUStsSG5hcSs5Y0RjZ1VYRWxtZy85YkZoQjJ1?=
 =?utf-8?B?R1hNSWlob3pidU5WVGlqRExBNHIwYXZXcFF2VGp2cXkvWFoyMmNaZlNkVHl1?=
 =?utf-8?B?Q2RYelVwQW9aVGdKU001c3d5LytKVXc4RGsyb3h3WldpOG1GSVM2NjdRMVBU?=
 =?utf-8?B?QXFIa0EwRDNwRFBOZ3RKMW8wUkxOdDBDdGRMVlBndFRkVzBGa2U1TW9uT2hm?=
 =?utf-8?B?UnN3djA0dE5zUXEvK1pZZk9qUjlJcno1SnJ3WWVSa3lMdTBjQ0ZUQ1RkMDND?=
 =?utf-8?B?blNVcXMzTnpkSzBVbFEwSDdmWFhYRjBLQUdHaG1GT0RmRmlKUDJoQ2w1aG1z?=
 =?utf-8?Q?9Bex3fqlCwg1NiyfS/w3UAHvmBMKQpXck77FgT3tYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4791C0EA83E11241949B1ACE2FB29B8F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00862e5c-8922-4d2c-6e08-08d9f248c9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 19:07:48.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0g2wvNplYpsE6pXD+Z0bTJGwAnfAULExabxdkIrCV70K3I5aijhVY5+oK8I0dNyd7A4njgLncUKVAmI8LBGTgBhu/8oS3YXKGavmgEAInE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgUmFmYWVsLA0KDQpDaGFuZ2VzIG9uIHRvcCBvZiANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JhZmFlbC9saW51eC1wbS5naXQNCnRoZXJtYWwtaGZp
DQoNCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KYzk1YWEyYmFiOTc0Mzk0
ODA5ZWRlYTI4NjkwZjY1MDRhMTU3OTFiNjoNCg0KICB0aGVybWFsOiBpbnRlbDogaGZpOiBJTlRF
TF9IRklfVEhFUk1BTCBkZXBlbmRzIG9uIE5FVCAoMjAyMi0wMi0xMA0KMjA6NTg6MjQgKzAxMDAp
DQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8v
Z2l0aHViLmNvbS9zcGFuZHJ1dmFkYS9saW51eC1rZXJuZWwuZ2l0IGludGVsLXNzdC10aGVybWFs
DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0bw0KZjM4NzRlOTZmYWQ1OTZjZDJjMjQ0
MTgwMmJlN2UxZDBjOWZhODY3NzoNCg0KICB0b29scy9wb3dlci94ODYvaW50ZWwtc3BlZWQtc2Vs
ZWN0OiB2MS4xMiByZWxlYXNlICgyMDIyLTAyLTE3DQoxMDo1NzozOCAtMDgwMCkNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KU3Jpbml2YXMgUGFuZHJ1dmFkYSAoMyk6DQogICAgICB0b29scy9wb3dlci94ODYvaW50ZWwt
c3BlZWQtc2VsZWN0OiBPT0IgZGFlbW9uIG1vZGUNCiAgICAgIHRvb2xzL3Bvd2VyL3g4Ni9pbnRl
bC1zcGVlZC1zZWxlY3Q6IEhGSSBzdXBwb3J0DQogICAgICB0b29scy9wb3dlci94ODYvaW50ZWwt
c3BlZWQtc2VsZWN0OiB2MS4xMiByZWxlYXNlDQoNCiB0b29scy9wb3dlci94ODYvaW50ZWwtc3Bl
ZWQtc2VsZWN0L0J1aWxkICAgICAgICAgfCAgIDIgKy0NCiB0b29scy9wb3dlci94ODYvaW50ZWwt
c3BlZWQtc2VsZWN0L01ha2VmaWxlICAgICAgfCAgMTAgKystDQogdG9vbHMvcG93ZXIveDg2L2lu
dGVsLXNwZWVkLXNlbGVjdC9oZmktZXZlbnRzLmMgIHwgMzA5DQorKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KKysr
KysrKysrKysrDQogdG9vbHMvcG93ZXIveDg2L2ludGVsLXNwZWVkLXNlbGVjdC9pc3N0LWNvbmZp
Zy5jIHwgIDU0ICsrKysrKysrKysrKy0tLQ0KIHRvb2xzL3Bvd2VyL3g4Ni9pbnRlbC1zcGVlZC1z
ZWxlY3QvaXNzdC1kYWVtb24uYyB8IDI0NA0KKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiB0b29scy9wb3dlci94ODYvaW50
ZWwtc3BlZWQtc2VsZWN0L2lzc3QuaCAgICAgICAgfCAgMTMgKysrKw0KIDYgZmlsZXMgY2hhbmdl
ZCwgNjE3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0b29scy9wb3dlci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0L2hmaS1ldmVudHMuYw0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy9wb3dlci94ODYvaW50ZWwtc3BlZWQtc2VsZWN0L2lzc3QtZGFl
bW9uLmMNCg0KVGhhbmtzLA0KU3Jpbml2YXMNCg==
