Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C147EDB9D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 07:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPGgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 01:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPGgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 01:36:33 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2046.outbound.protection.outlook.com [40.107.215.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FD181;
        Wed, 15 Nov 2023 22:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr3YZvcP+0SIM3YSykj+oS5j71BEVChODsp9cykvEiwoRtbwctHrubIWvk7ktUmEAzCy+/ki6VYmaiT/xkrCnepT89wxgiW1RmdaxE53wxop/efgu++aBPgL13BM4ezbiHAvltWjRx4//eu5JnWqZ8eM5uJCRcKJ0JexyYWKYYnGZI3f3wWYrjuCGmtkuX6tNimGFNeqr+K2B+UMZ4AadyVLGISgjvNUFhch9uD83WX2J5HgYjdRt0MDD1iQIX0xr8Z0FNCSECjFr2uGUElcIWprXJXB8GrgKXldAG9+3yfc44vhxrKQEZ7y3jxpv3hTe+nKHpU4Tar3pv7x92YfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyoLh6Zgdi9TEnMGbJTFMVKFvwJqx6pG+BoVyokiYaM=;
 b=MRexWKkEK0aFQHgQQgg7MA2K1VPkGkAQwKhgWlMp/47TOmVboWQl03gxEtCX6r2uXtMTUJlkagXhYw+aNmJ5xxU/CA4DndT8KSY+5jnzdMX2EdAtWdNqts1fZe2XajlALg91lLrEiy03NPc10iQ+svC9MMUc1cc3ayItDNz791FvRRIt+1otJgyX3DvMeggtkxYpIrlQ5OR/67+RtQdBydfiUyjxARW1kI/Q8YUGaDQ8g+FMGlLWKO26iS3vZjeIbcER8NTI+BIMeSsERuTesIw78tEYhMOIaAL2wv57J4UrDylaZ6WZJ5d6U7OETzMS/WCr1OiMSHX+sj3EXfIVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyoLh6Zgdi9TEnMGbJTFMVKFvwJqx6pG+BoVyokiYaM=;
 b=pn/fE4pbPsNAgQ/Cpy7O2E2spoRrBVxq/hUTQ3tqaJZ/8p+OhxATqkFq64L1rprdPVnqN5WQCcPsnQ89J9y28EkuBhNPbzgRfZrTpNb5okC6KPRfXMhP4P4Sm+NzKuyREWYPag0mQ6Gfb1Ot3kFig+6nlePChaCgJlpIK453GGg=
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com (2603:1096:101:56::11)
 by KL1PR02MB6898.apcprd02.prod.outlook.com (2603:1096:820:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 06:36:24 +0000
Received: from SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133]) by SEYPR02MB5653.apcprd02.prod.outlook.com
 ([fe80::164b:4e8c:754e:f133%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 06:36:23 +0000
From:   =?utf-8?B?6buE5YaN5ry+KEpveXlvdW5nIEh1YW5nKQ==?= 
        <huangzaiyang@oppo.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangzaiyang <joyyoung.wang@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gUGVyZm9ybWFuY2U6IGRldmZyZXE6?=
 =?utf-8?Q?_avoid_devfreq_delay_work_re-init_before?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIFBlcmZvcm1hbmNlOiBkZXZmcmVxOiBhdm9pZCBk?=
 =?utf-8?Q?evfreq_delay_work_re-init_before?=
Thread-Index: AQHaE7ktw9S+4MHEbkGRU6+y80L/AbB5wDqAgAAUYICAAXhpwIAAGc2AgAEdq1A=
Date:   Thu, 16 Nov 2023 06:36:23 +0000
Message-ID: <SEYPR02MB565398175FA093AC3E63EE7BA3B0A@SEYPR02MB5653.apcprd02.prod.outlook.com>
References: <20231110093457.458-1-huangzaiyang@oppo.com>
 <fe8f6f37-2534-6481-cc34-e561b3b7a510@quicinc.com>
 <SEYPR02MB5653E9452D4BC57B10384D54A3B2A@SEYPR02MB5653.apcprd02.prod.outlook.com>
 <SEYPR02MB5653EC6FA16817D2DF7022EAA3B1A@SEYPR02MB5653.apcprd02.prod.outlook.com>
 <fc71856a-4d67-1893-9f30-54f9e62aadeb@quicinc.com>
In-Reply-To: <fc71856a-4d67-1893-9f30-54f9e62aadeb@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR02MB5653:EE_|KL1PR02MB6898:EE_
x-ms-office365-filtering-correlation-id: 2e24760c-3eee-4632-d4a9-08dbe66e5a02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /osa73gqpAqIITynQ7zLzgPR+OTXq4XbvcPHCh0T89EL9HG2qI3O8BpGD11rxSE1O4JGFKHS/ujqGylIW4Wjom46oXT99qfOe2Yu8puUzj0j5iC2gvVLqSthxOQNEhGvmUKmqTW14llaKYJuSvwXJFRC/GdTya5xuHiNfWwlDz86BD7vdBAasF8UA9Mf5qQ6JJPEnP+O4cxeM94mwUPnCFP72fjFXM3DocVJ5c2FwFaO2+xQQp7VD6AyCd6DmersJCKu/x90tlf083FcIqi/AxTWCbi550QCSxekStlgWjRGf5MqNFKw+99eOlWeLTS0VJnNWGS8Rya1uoDgP8bAMHPTRtJa+a1n8rg+qvyKYfOZYNeqvQgknU7hwTsdn11wy7NuklRZMzySEhw5ki9AsnfuN3LjTSHysIivEX8Fzl4MZBgtr2Bi6Yyh09K2k6oA1sKVHtHmkxzM6GIaLY2VaJ398yr7G24fZqizpZlRvjnoU1FDHRtSGLXp7ojT4KN7LsK6MHga6Lpu90JdQO/yiO2Bro5u4+XByfZPUMdYqAZ4tM5joVJvjjAgBH1s7qnmP7hzPlOoKX/CcX9qY5+L5Q57zRKAVOn7nF5zL70+91Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB5653.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(76116006)(6506007)(7696005)(224303003)(8936002)(9686003)(38070700009)(66556008)(66476007)(26005)(30864003)(2906002)(52536014)(4326008)(33656002)(5660300002)(66446008)(64756008)(316002)(54906003)(85182001)(83380400001)(66946007)(41300700001)(110136005)(53546011)(71200400001)(55016003)(478600001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1NbTBPbDVibG8xcTVwd2FCU3JSekhsWkord0JJYXR1S3VtUEI4b3ltaWE1?=
 =?utf-8?B?aUk3YUZ5VDN2QVMzeVdzMmhWZGJpUnZJWnROd2FZZ3BwNDliK09sVEtNaFVr?=
 =?utf-8?B?Ync4K3hPSGhzeGUvaUhiWGkwTmh5NFBVU3I3WWFjKytzeW1IaW1nZHJxZldM?=
 =?utf-8?B?ZjhPdUJWeHcyclgyOUxZdlh2QzNSeE15UXRJR3VTWEllUnc0dDhUVk5OUUxG?=
 =?utf-8?B?VHc5UmtzcXlFcXpSQ25OZnlXUHVlNlhuZ3B0ZzdCRzJzYnUrdlNEVDFnMkFP?=
 =?utf-8?B?ZXUxUkdTSU1jWTdmM3RYaGtRR1RxdHpqN3VDMzRGOWVscFZYby8yb2ZXeWtL?=
 =?utf-8?B?VTlGZFNpTHFKU3ZFckZCWEx4ejlPS0JUdUVERnRiK1VJTlFlTWxSWllyVHJM?=
 =?utf-8?B?SUY0SnJ3KzlDSk11bzQ5bDRCU3BDWHFpR3NpWktTL0JwR2JMbjVYY1dwTUd5?=
 =?utf-8?B?d2hzYndqMVhISFNiT3lFa0VWb0RNVGVLQ2pCZDBXZXlsZElGRE9VRjEyR2sw?=
 =?utf-8?B?M0tLVkJTM3g2aVdqM3lWY1BzdkxaQjcwY0gzU2lkaHNDbm1QeGtwRU1WZkJU?=
 =?utf-8?B?MkMxRFpsTThtbmo5emR3OFdvTit0bk1HdHVieERhaDhtNTBSaDFlRE1Ia1M5?=
 =?utf-8?B?NUExazhLZ0pvVW83TVVnU2diVVZ6Tnp0RTNtcFR2UXg2RHBNa3lTSGd6cnlP?=
 =?utf-8?B?VUtHb1FtT3QwQVY4dm9LWGFPZ1F2dWFqRnB5RWcxK0wwd3JSK3ZpdmNYMkJH?=
 =?utf-8?B?VWtvc3V5ZDNTODRPd0ExQStmQU84d2sxMmVkbktJVHk0L3RiTWxOVEs0Y2lW?=
 =?utf-8?B?UG1tbWNNM2tyTnhkK3FwcTlEcE1HTlFramV0NDNCYjB5SjR3djJWUGtnWnBM?=
 =?utf-8?B?SVBIanAwN3dnSHZsc3lyeUpLNnZZTVhFVEYrOStWckw3eW1JeXVMK1FkbVZw?=
 =?utf-8?B?RUpJL1ZCZ3NxOUhpWFQwemlkT2gwZ1ZBY3RmU0ZZcUh0V0FiZzIzbDlxOXdt?=
 =?utf-8?B?RmVRbXpaTENwS1pKWXd2NkFOczd4OFd0L0xkeE12MkV1VFg5SE9TbWhDRTVW?=
 =?utf-8?B?dmRPVndaWjcvRmZEUEh5SjdSdUlFMWl4dHg3NmtyWU1mOHVrNHVhdUNVYVA1?=
 =?utf-8?B?bWh5NWtPT3VtcUlNM3JkV1pxSVd0MHlheFpaWm11N3VZWUhXZTU5aXNIU0V3?=
 =?utf-8?B?VFhZR3N6b2liYzAyV0VJZFk5N1hOMzQzT0tpZzBYeW1mcjZhTWo0SFdkTmFR?=
 =?utf-8?B?SGtGMEw3RGJ5b2FyQXFKOWJMV0ZaeUF2ajZwTFdaR2dicGlzQlFkN29QUzV2?=
 =?utf-8?B?bmx2WkpLTUdPNy9PUU5wcjFWcW9GRUNKL0ZvSzdiczcwSEVWU0w0Ny85cTRn?=
 =?utf-8?B?czFYUEJabFdWLzhuRE90SWlGNzhJTGlvUElOUmhUVDNialgyTGNiVkxtRG5U?=
 =?utf-8?B?TzkrN2NpeDVkN1NiU2R5aGpIaks0MUFaUjJaOHFKaVJSZ0N5VDI2V3IyMEVX?=
 =?utf-8?B?M0pWMENSRTA2TEJNaDNOUUlTYXlKRDgzUHZXUFVmR1Zpa2NiK3JYNEgrR014?=
 =?utf-8?B?bXBhdUdQNXFJVWduSmVFbk5PbXhJeVpWWDhrcFAzMTJjWGRweUZQelEvTUY1?=
 =?utf-8?B?ZUpPS0NSQzhPV2pGeTdLZGkrUHNRb1BYbzRsenBUTUVZbkxKYWlZL1hGdnJM?=
 =?utf-8?B?Y2xzYitlQ3JWOUtXbU5NU3RHOVNwU0tPUy9tT2F0RXZZekdtTmRhUExQZDEw?=
 =?utf-8?B?UTBwRW8rWEk3RTdvdHZ2dThVUUdneW1UNHFuQzhqM3ZXZnZDbng3S0ttT0FU?=
 =?utf-8?B?WDdXdWpkajRQRm1jeXhDeE9odThvU1pFV1hnbXNMaGkranp0NFllZVFHOFZN?=
 =?utf-8?B?eFUwSFhMR1EvckxVTjRySHFhSnhhR3BKQ2kxTkRYQUxQUGxQcDFEWWM4WjJi?=
 =?utf-8?B?RTQza2o2MFZXRjkxVmJiVzhrdW1QdjBCVk43RTRVdU53ZGZqcy9iQzVEcWJl?=
 =?utf-8?B?OVlYOHIvaGJyYnU1alNCNTdWQStDMDluZDkzejFKUStlV2hMdkZhSyt5eXRn?=
 =?utf-8?B?KytibHBNakw2Y1B6M1pFb0h1NHd4MThaTXdwSEhoK2tzb2hhMnRKQ3MwNTFL?=
 =?utf-8?Q?BMKrEwF20Zgu/m0Y8mkqiEoTR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5653.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e24760c-3eee-4632-d4a9-08dbe66e5a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 06:36:23.3876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ+9foIUiXjO28NTseWYOkqucYGaL6m1P8o1RpGu+g3+CGOGpxC23sS8VapwFhJHIcZvFoQpjdupjiA4pyFR3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PlRoZXJlIHN0aWxsIHNlZW1zIHRvIGJlIHByb2JsZW0gd2l0aCB0aGUgcGF0Y2ggWzFdLCB3b3Jr
IGlzIHF1ZXVlZCB0byBzb21lIGNwdSBidXQgbm90IGV4ZWN1dGluZyB3aGVyZSB0aGVyZSBjYW4g
YmUgcGFyYWxsZWwgY2FsbCBjYW4gY29tZSBmb3INCj5kZXZmcmVxX21vbml0b3Jfc3RhcnQoKSBh
bmQgdGhhdCBpcyBub3QgYmVpbmcgY2hlY2tlZCBhbmQgc2FtZSBjYW4gY29tZSBkdXJpbmcgY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgY2FsbC4gV2UgY2FuIHByb3RlY3QgdGhlIHNhbWUgd2l0
aCBiZWxvdyBwYXRjaCBhcHBsaWVkIG9uIHRvcCBvZiB0aGUgcGF0Y2ggZ2l2ZW4gb24gWzFdLg0K
Pg0KPlsxXQ0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNjk5OTU3NjQ4LTMxMjk5LTEt
Z2l0LXNlbmQtZW1haWwtcXVpY19tb2poYUBxdWljaW5jLmNvbS8NCg0KPmRpZmYgLS1naXQgYS9k
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBpbmRl
eCAwOWI5MzEwNDUyMWIuLmEyNWM3NGZjMzFkNyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL2RldmZy
ZXEvZGV2ZnJlcS5jDQo+KysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPkBAIC00ODgs
NiArNDg4LDkgQEAgdm9pZCBkZXZmcmVxX21vbml0b3Jfc3RhcnQoc3RydWN0IGRldmZyZXEgKmRl
dmZyZXEpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+DQo+ICAgICAgICAgbXV0ZXhfbG9j
aygmZGV2ZnJlcS0+bG9jayk7DQo+KyAgICAgICBpZiAoZGVsYXllZF93b3JrX3BlbmRpbmcoJmRl
dmZyZXEtPndvcmspKQ0KPisgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4rDQo+ICAgICAgICAg
c3dpdGNoIChkZXZmcmVxLT5wcm9maWxlLT50aW1lcikgew0KPiAgICAgICAgIGNhc2UgREVWRlJF
UV9USU1FUl9ERUZFUlJBQkxFOg0KPiAgICAgICAgICAgICAgICAgSU5JVF9ERUZFUlJBQkxFX1dP
UksoJmRldmZyZXEtPndvcmssIGRldmZyZXFfbW9uaXRvcik7IEBAIC01MDMsOCArNTA2LDggQEAg
dm9pZCBkZXZmcmVxX21vbml0b3Jfc3RhcnQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpDQo+ICAg
ICAgICAgICAgICAgICBxdWV1ZV9kZWxheWVkX3dvcmsoZGV2ZnJlcV93cSwgJmRldmZyZXEtPndv
cmssDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoZGV2ZnJlcS0+
cHJvZmlsZS0+cG9sbGluZ19tcykpOw0KPg0KPi0gICAgICAgZGV2ZnJlcS0+c3RvcF9wb2xsaW5n
ID0gZmFsc2U7DQo+ICBvdXQ6DQo+KyAgICAgICBkZXZmcmVxLT5zdG9wX3BvbGxpbmcgPSBmYWxz
ZTsNCj4gICAgICAgICBtdXRleF91bmxvY2soJmRldmZyZXEtPmxvY2spOw0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTChkZXZmcmVxX21vbml0b3Jfc3RhcnQpOw0KPkBAIC01MjksOCArNTMyLDggQEAg
dm9pZCBkZXZmcmVxX21vbml0b3Jfc3RvcChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkNCj4gICAg
ICAgICB9DQo+DQo+ICAgICAgICAgZGV2ZnJlcS0+c3RvcF9wb2xsaW5nID0gdHJ1ZTsNCj4tICAg
ICAgIG11dGV4X3VubG9jaygmZGV2ZnJlcS0+bG9jayk7DQo+ICAgICAgICAgY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCZkZXZmcmVxLT53b3JrKTsNCj4rICAgICAgIG11dGV4X3VubG9jaygmZGV2
ZnJlcS0+bG9jayk7DQoNClRoYW5rcyAsIEl0IHdvcmtzIHdlbGwgb24gbXkgc2lkZSENCg0KLWh1
YW5nemFpeWFuZw0KDQo+DQo+DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6
OiDpu4Tlho3mvL4oSm95eW91bmcgSHVhbmcpDQo+IOWPkemAgeaXtumXtDogMjAyM+W5tDEx5pyI
MTTml6UgMjE6MzcNCj4g5pS25Lu25Lq6OiBNdWtlc2ggT2poYSA8cXVpY19tb2poYUBxdWljaW5j
LmNvbT47IG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbTsNCj4ga3l1bmdtaW4ucGFya0BzYW1zdW5n
LmNvbTsgY3cwMC5jaG9pQHNhbXN1bmcuY29tDQo+IOaKhOmAgTogbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBodWFuZ3phaXlhbmcgPGpv
eXlvdW5nLndhbmdAZ21haWwuY29tPg0KPiDkuLvpopg6IOWbnuWkjTogW1BBVENIXSBQZXJmb3Jt
YW5jZTogZGV2ZnJlcTogYXZvaWQgZGV2ZnJlcSBkZWxheSB3b3JrIHJlLWluaXQNCj4gYmVmb3Jl
DQo+DQo+DQo+IE9uIDExLzEwLzIwMjMgMzowNCBQTSwgaHVhbmd6YWl5YW5nIHdyb3RlOg0KPj4g
RnJvbTogaHVhbmd6YWl5YW5nIDxqb3l5b3VuZy53YW5nQGdtYWlsLmNvbT4NCj4+DQo+PiBUaGVy
ZSBpcyBhIHRpbWVyX2xpc3QgcmFjZSBjb25kaXRpb24gd2hlbiBleGVjdXRpbmcgdGhlIGZvbGxv
d2luZyB0ZXN0IHNoZWxsIHNjcmlwdDoNCj4+ICcnJw0KPj4gd2hpbGUgdHJ1ZQ0KPj4gZG8NCj4+
ICAgICAgICAgICBlY2hvICJzaW1wbGVfb25kZW1hbmQiID4gL3N5cy9jbGFzcy9kZXZmcmVxLzFk
ODQwMDAudWZzaGMvZ292ZXJub3INCj4+ICAgICAgICAgICBlY2hvICJwZXJmb3JtYW5jZSIgPg0K
Pj4gL3N5cy9jbGFzcy9kZXZmcmVxLzFkODQwMDAudWZzaGMvZ292ZXJub3INCj4+IGRvbmUNCj4+
ICcnJw0KPj4NCj4+IFsxMzUxMS4yMTQzNjZdWyAgICBDM10gVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIGRlYWQwMDAwMDAwMDAxMmENCj4+
IFsxMzUxMS4yMTQzOTNdWyAgICBDM10gTWVtIGFib3J0IGluZm86DQo+PiBbMTM1MTEuMjE0Mzk4
XVsgICAgQzNdICAgRVNSID0gMHg5NjAwMDA0NA0KPj4gWzEzNTExLjIxNDQwNF1bICAgIEMzXSAg
IEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KPj4gWzEzNTExLjIx
NDQwOV1bICAgIEMzXSAgIFNFVCA9IDAsIEZuViA9IDANCj4+IFsxMzUxMS4yMTQ0MTRdWyAgICBD
M10gICBFQSA9IDAsIFMxUFRXID0gMA0KPj4gWzEzNTExLjIxNDQxN11bICAgIEMzXSBEYXRhIGFi
b3J0IGluZm86DQo+PiBbMTM1MTEuMjE0NDIyXVsgICAgQzNdICAgSVNWID0gMCwgSVNTID0gMHgw
MDAwMDA0NA0KPj4gWzEzNTExLjIxNDQyN11bICAgIEMzXSAgIENNID0gMCwgV25SID0gMQ0KPj4g
WzEzNTExLjIxNDQzMl1bICAgIEMzXSBbZGVhZDAwMDAwMDAwMDEyYV0gYWRkcmVzcyBiZXR3ZWVu
IHVzZXIgYW5kIGtlcm5lbCBhZGRyZXNzIHJhbmdlcw0KPj4gWzEzNTExLjIxNDQzOV1bICAgIEMz
XSBJbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAwNDQgWyMxXSBQUkVFTVBUIFNNUA0KPj4gWzEz
NTExLjIxNTQ0OV1bICAgIEMzXSBDUFU6IDMgUElEOiAwIENvbW06IHN3YXBwZXIvMyBUYWludGVk
OiBHIFMgICAgICBXICBPICAgICAgNS4xMC4xNjgtYW5kcm9pZDEyLTktby1nNjNjYzI5N2E3YjM0
ICMxDQo+PiBbMTM1MTEuMjE1NDU0XVsgICAgQzNdIEhhcmR3YXJlIG5hbWU6IFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBDYXBlIE1UUCwgV2hpdGVzd2FuIChEVCkNCj4+IFsxMzUxMS4yMTU0
NjBdWyAgICBDM10gcHN0YXRlOiA4MjQwMDA4NSAoTnpjdiBkYUlmICtQQU4gLVVBTyArVENPIEJU
WVBFPS0tKQ0KPj4gWzEzNTExLjIxNTQ3Ml1bICAgIEMzXSBwYyA6IGV4cGlyZV90aW1lcnMrMHg5
Yy8weDQyOA0KPj4gWzEzNTExLjIxNTQ3OF1bICAgIEMzXSBsciA6IF9fcnVuX3RpbWVycysweDFm
MC8weDMyOA0KPj4gWzEzNTExLjIxNTQ4M11bICAgIEMzXSBzcCA6IGZmZmZmZmMwMDgwMWJkZDAN
Cj4+IFsxMzUxMS4yMTU0ODddWyAgICBDM10geDI5OiBmZmZmZmZjMDA4MDFiZGYwIHgyODogZmZm
ZmZmZGI4N2IzMTY5OA0KPj4gWzEzNTExLjIxNTQ5M11bICAgIEMzXSB4Mjc6IGZmZmZmZmRiODc5
OTllNTggeDI2OiBmZmZmZmZkYjg3OTY2MDA4DQo+PiBbMTM1MTEuMjE1NDk5XVsgICAgQzNdIHgy
NTogMDAwMDAwMDAwMDAwMDAwMSB4MjQ6IGZmZmZmZjgwMDE3MzRhMDANCj4+IFsxMzUxMS4yMTU1
MDZdWyAgICBDM10geDIzOiAwMDAwMDAwMDAwMDAwMGUwIHgyMjogZGVhZDAwMDAwMDAwMDEyMg0K
Pj4gWzEzNTExLjIxNTUxMl1bICAgIEMzXSB4MjE6IDAwMDAwMDAxMDAzMjY1OGUgeDIwOiBmZmZm
ZmY4OWY3YTlhZTgwDQo+PiBbMTM1MTEuMjE1NTE4XVsgICAgQzNdIHgxOTogZmZmZmZmYzAwODAx
YmU1MCB4MTg6IGZmZmZmZmMwMDgwMWQwMzgNCj4+IFsxMzUxMS4yMTU1MjVdWyAgICBDM10geDE3
OiAwMDAwMDAwMDAwMDAwMjQwIHgxNjogMDAwMDAwMDAwMDAwMDIwMQ0KPj4gWzEzNTExLjIxNTUz
Ml1bICAgIEMzXSB4MTU6IGZmZmZmZmZmZmZmZmZmZmYgeDE0OiBmZmZmZmY4OWY3YTlhZWY4DQo+
PiBbMTM1MTEuMjE1NTM4XVsgICAgQzNdIHgxMzogMDAwMDAwMDAwMDAwMDI0MCB4MTI6IGZmZmZm
Zjg5ZjdhOWFlYTgNCj4+IFsxMzUxMS4yMTU1NDRdWyAgICBDM10geDExOiAwMDAwMDAwMDAwMDAw
MDIxIHgxMDogMDAwMDAwMDE0MDMyNjU4ZQ0KPj4gWzEzNTExLjIxNTU1MF1bICAgIEMzXSB4OSA6
IGZmZmZmZmMwMDgwMWJlNTAgeDggOiBkZWFkMDAwMDAwMDAwMTIyDQo+PiBbMTM1MTEuMjE1NTU2
XVsgICAgQzNdIHg3IDogZmZmZjcxNjQ2YzY4NzM1ZSB4NiA6IGZmZmZmZjg5ZjdhYWFlNTgNCj4+
IFsxMzUxMS4yMTU1NjNdWyAgICBDM10geDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAw
MDAwMDAwMDEwMQ0KPj4gWzEzNTExLjIxNTU2OV1bICAgIEMzXSB4MyA6IGZmZmZmZjg5ZjdhOWFl
ZjAgeDIgOiBmZmZmZmY4OWY3YTlhZWYwDQo+PiBbMTM1MTEuMjE1NTc1XVsgICAgQzNdIHgxIDog
ZmZmZmZmYzAwODAxYmU1MCB4MCA6IGZmZmZmZjgwNDU4MDQ0MjgNCj4+IFsxMzUxMS4yMTU1ODFd
WyAgICBDM10gQ2FsbCB0cmFjZToNCj4+IFsxMzUxMS4yMTU1ODZdWyAgICBDM10gIGV4cGlyZV90
aW1lcnMrMHg5Yy8weDQyOA0KPj4gWzEzNTExLjIxNTU5MV1bICAgIEMzXSAgX19ydW5fdGltZXJz
KzB4MWYwLzB4MzI4DQo+PiBbMTM1MTEuMjE1NTk2XVsgICAgQzNdICBydW5fdGltZXJfc29mdGly
cSsweDI4LzB4NTgNCj4+IFsxMzUxMS4yMTU2MDJdWyAgICBDM10gIGVmaV9oZWFkZXJfZW5kKzB4
MTY4LzB4NWVjDQo+PiBbMTM1MTEuMjE1NjEwXVsgICAgQzNdICBfX2lycV9leGl0X3JjdSsweDEw
OC8weDEyNA0KPj4gWzEzNTExLjIxNTYxN11bICAgIEMzXSAgX19oYW5kbGVfZG9tYWluX2lycSsw
eDExOC8weDFlNA0KPj4gWzEzNTExLjIxNTYyNV1bICAgIEMzXSAgZ2ljX2hhbmRsZV9pcnEuMzEy
MzArMHg2Yy8weDI1MA0KPj4gWzEzNTExLjIxNTYzMF1bICAgIEMzXSAgZWwxX2lycSsweGU0LzB4
MWMwDQo+PiBbMTM1MTEuMjE1NjM4XVsgICAgQzNdICBjcHVpZGxlX2VudGVyX3N0YXRlKzB4M2E0
LzB4YTA0DQo+PiBbMTM1MTEuMjE1NjQ0XVsgICAgQzNdICBkb19pZGxlKzB4MzA4LzB4NTc0DQo+
PiBbMTM1MTEuMjE1NjQ5XVsgICAgQzNdICBjcHVfc3RhcnR1cF9lbnRyeSsweDg0LzB4OTANCj4+
IFsxMzUxMS4yMTU2NTZdWyAgICBDM10gIHNlY29uZGFyeV9zdGFydF9rZXJuZWwrMHgyMDQvMHgy
NzQNCj4+IFsxMzUxMS4yMTU2NjRdWyAgICBDM10gQ29kZTogZDUwMzIwMWYgYTk0MDI0MDggZjkw
MDAxMjggYjQwMDAwNDggKGY5MDAwNTA5KQ0KPj4gWzEzNTExLjIxNTY3MF1bICAgIEMzXSAtLS1b
IGVuZCB0cmFjZSA1MTAwYmFkNzJhMzVkNTY2IF0tLS0NCj4+IFsxMzUxMS4yMTU2NzZdWyAgICBD
M10gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbiBpbiBp
bnRlcnJ1cHQNCj4+DQo+PiBUaGlzIGlzIGJlY2F1c2Ugd2hlbiBzd2l0Y2hpbmcgdGhlIGdvdmVy
bm9yIHRocm91Z2ggdGhlIHN5cyBub2RlLCB0aGUNCj4+IGRldmZyZXFfbW9uaXRvcl9zdGFydCBm
dW5jdGlvbiB3aWxsIHJlLWluaXRpYWxpemUgdGhlIGRlbGF5ZWQgd29yaw0KPj4gdGFzaywgd2hp
Y2ggd2lsbCBjYXVzZSB0aGUgZGVsYXkgd29yayBwZW5kaW5nIGZsYWcgdG8gYmVjb21lIGludmFs
aWQsDQo+PiBhbmQgdGhlIHRpbWVyIHBlbmRpbmcganVkZ21lbnQgY29udGFpbmVkIGluIHRoZSBk
ZWxheWVkIHdvcmsgd2lsbCBhbHNvIGJlY29tZSBpbnZhbGlkLCBhbmQgdGhlbiB0aGUgcGVuZGlu
ZyBpbnRlcmNlcHRpb24gd2lsbCBiZSBleGVjdXRlZCB3aGVuIHRoZSBxdWV1ZSBpcyBleGVjdXRl
ZC4NCj4+DQo+PiBTbyB3ZSByZW1vdmUgdGhlIGRlbGF5IHdvcmsnaW5pdGlhbGl6YXRpb24gd29y
ayB0byB0aGUNCj4+IGRldmZyZXFfYWRkX2RldmljZSBhbmQgdGltZXJfc3RvcmUgZnVuY3Rpb25z
LCBhbmQgdGhlIGRlbGF5IHdvcmsgcGVuZGluZyBqdWRnbWVudCBpcyBwZXJmb3JtZWQgYmVmb3Jl
IHRoZSBkZXZmcmVxX21vbml0b3Jfc3RhcnQgZnVuY3Rpb24gcGVyZm9ybXMgdGhlIHF1ZXVlIG9w
ZXJhdGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaYWlZYW5nIEh1YW5nIDxodWFuZ3phaXlh
bmdAb3Bwby5jb20+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCAz
NiArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMN
Cj4+IGluZGV4IGIzYTY4ZDU4MzNiZC4uOGFlNmY4NTNhMjFlIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEu
Yw0KPj4gQEAgLTQ4MywxOCArNDgzLDcgQEAgdm9pZCBkZXZmcmVxX21vbml0b3Jfc3RhcnQoc3Ry
dWN0IGRldmZyZXEgKmRldmZyZXEpDQo+PiAgICAgICAgICAgaWYgKElTX1NVUFBPUlRFRF9GTEFH
KGRldmZyZXEtPmdvdmVybm9yLT5mbGFncywgSVJRX0RSSVZFTikpDQo+PiAgICAgICAgICAgICAg
ICAgICByZXR1cm47DQo+Pg0KPj4gLSAgICAgICBzd2l0Y2ggKGRldmZyZXEtPnByb2ZpbGUtPnRp
bWVyKSB7DQo+PiAtICAgICAgIGNhc2UgREVWRlJFUV9USU1FUl9ERUZFUlJBQkxFOg0KPj4gLSAg
ICAgICAgICAgICAgIElOSVRfREVGRVJSQUJMRV9XT1JLKCZkZXZmcmVxLT53b3JrLCBkZXZmcmVx
X21vbml0b3IpOw0KPj4gLSAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gLSAgICAgICBjYXNlIERF
VkZSRVFfVElNRVJfREVMQVlFRDoNCj4+IC0gICAgICAgICAgICAgICBJTklUX0RFTEFZRURfV09S
SygmZGV2ZnJlcS0+d29yaywgZGV2ZnJlcV9tb25pdG9yKTsNCj4+IC0gICAgICAgICAgICAgICBi
cmVhazsNCj4+IC0gICAgICAgZGVmYXVsdDoNCj4+IC0gICAgICAgICAgICAgICByZXR1cm47DQo+
PiAtICAgICAgIH0NCj4+IC0NCj4+IC0gICAgICAgaWYgKGRldmZyZXEtPnByb2ZpbGUtPnBvbGxp
bmdfbXMpDQo+PiArICAgICAgIGlmIChkZXZmcmVxLT5wcm9maWxlLT5wb2xsaW5nX21zICYmDQo+
PiArICFkZWxheWVkX3dvcmtfcGVuZGluZygmZGV2ZnJlcS0+d29yaykpDQo+PiAgICAgICAgICAg
ICAgICAgICBxdWV1ZV9kZWxheWVkX3dvcmsoZGV2ZnJlcV93cSwgJmRldmZyZXEtPndvcmssDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoZGV2ZnJlcS0+cHJv
ZmlsZS0+cG9sbGluZ19tcykpOw0KPj4gICAgfQ0KPj4gQEAgLTgzMCw2ICs4MTksMTcgQEAgc3Ry
dWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAg
ICAgICAgICAgICAgICAgICBnb3RvIGVycl9kZXY7DQo+PiAgICAgICAgICAgfQ0KPj4NCj4+ICsg
ICAgICAgc3dpdGNoIChkZXZmcmVxLT5wcm9maWxlLT50aW1lcikgew0KPj4gKyAgICAgICBjYXNl
IERFVkZSRVFfVElNRVJfREVGRVJSQUJMRToNCj4+ICsgICAgICAgICAgICAgICBJTklUX0RFRkVS
UkFCTEVfV09SSygmZGV2ZnJlcS0+d29yaywgZGV2ZnJlcV9tb25pdG9yKTsNCj4+ICsgICAgICAg
ICAgICAgICBicmVhazsNCj4+ICsgICAgICAgY2FzZSBERVZGUkVRX1RJTUVSX0RFTEFZRUQ6DQo+
PiArICAgICAgICAgICAgICAgSU5JVF9ERUxBWUVEX1dPUksoJmRldmZyZXEtPndvcmssIGRldmZy
ZXFfbW9uaXRvcik7DQo+PiArICAgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAgIGRlZmF1
bHQ6DQo+PiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICIlczogVGFyZ2V0IGRldmZyZXEo
JXMpJ3MgcHJvZmlsZSB0aW1lciBoYXMgbm8gc2V0dGluZ3MgXG4iLCBkZXZmcmVxLT5nb3Zlcm5v
cl9uYW1lLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPj4gKyAgICAg
ICB9DQo+DQo+IFsuLl0NCj4NCj4+ICAgICAgICAgICBpZiAoIWRldmZyZXEtPnByb2ZpbGUtPm1h
eF9zdGF0ZSB8fCAhZGV2ZnJlcS0+cHJvZmlsZS0+ZnJlcV90YWJsZSkgew0KPj4gICAgICAgICAg
ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCj4+ICAgICAgICAgICAgICAg
ICAgIGVyciA9IHNldF9mcmVxX3RhYmxlKGRldmZyZXEpOyBAQCAtMTg2MCw2ICsxODYwLDE4DQo+
PiBAQCBzdGF0aWMgc3NpemVfdCB0aW1lcl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPj4gICAgICAgICAgIGRmLT5wcm9maWxlLT50aW1l
ciA9IHRpbWVyOw0KPj4gICAgICAgICAgIG11dGV4X3VubG9jaygmZGYtPmxvY2spOw0KPj4NCj4+
ICsgICAgICAgc3dpdGNoIChkZi0+cHJvZmlsZS0+dGltZXIpIHsNCj4+ICsgICAgICAgY2FzZSBE
RVZGUkVRX1RJTUVSX0RFRkVSUkFCTEU6DQo+PiArICAgICAgICAgICAgICAgSU5JVF9ERUZFUlJB
QkxFX1dPUksoJmRmLT53b3JrLCBkZXZmcmVxX21vbml0b3IpOw0KPj4gKyAgICAgICAgICAgICAg
IGJyZWFrOw0KPj4gKyAgICAgICBjYXNlIERFVkZSRVFfVElNRVJfREVMQVlFRDoNCj4+ICsgICAg
ICAgICAgICAgICBJTklUX0RFTEFZRURfV09SSygmZGYtPndvcmssIGRldmZyZXFfbW9uaXRvcik7
DQo+PiArICAgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAgIGRlZmF1bHQ6DQo+PiArICAg
ICAgICAgICAgICAgZGV2X2VycihkZXYsICIlczogVGFyZ2V0IGRldmZyZXEoJXMpJ3MgcHJvZmls
ZSB0aW1lciBoYXMgbm8gc2V0dGluZ3MgXG4iLCBkZi0+Z292ZXJub3JfbmFtZSwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPiBIZXJl
LCB0aGlzIGNhbiBjYXVzZSBpc3N1ZSByaWdodCwgYXMgaXQgaXMgbW9kaWZ5aW5nIHRoZSBkZWxh
eWVkIHdvcmsgZGF0YSBldmVuIGJlZm9yZSBzdG9wcGluZyB0aGUgY3VycmVudCBydW5uaW5nIGlu
c3RhbmNlcy4uDQo+DQo+IFNob3VsZCB0aGUgYWJvdmUgdGhpbmcgYmUgZG9uZSBhZnRlciBERVZG
UkVRX0dPVl9TVE9QID8NCj4gQnV0IGFnYWluIGl0IHdpbGwgYm9pbCBkb3duIHRvIHRoZSBzYW1l
IHRoaW5nIGFzIGl0IGlzIGN1cnJlbnRseSBub3cgLg0KPj4gICAgICAgICAgIHJldCA9IGRmLT5n
b3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZiwgREVWRlJFUV9HT1ZfU1RPUCwgTlVMTCk7DQo+PiAg
ICAgICAgICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAi
JXM6IEdvdmVybm9yICVzIG5vdCBzdG9wcGVkKCVkKVxuIiwNCj4gLS0+YWdyZWUsIHNlZW1zIGJl
dHRlciB0byBwdXQgdGhlc2UgY29kZXMgYWZ0ZXIgYWZ0ZXIgREVWRlJFUV9HT1ZfU1RPUCwgYXMg
Zm9sbG93Pw0KPiBAQCAtMTg1NiwxMCArMTg1Niw2IEBAIHN0YXRpYyBzc2l6ZV90IHRpbWVyX3N0
b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgIH0NCj4NCj4gLSAgICAgbXV0ZXhfbG9j
aygmZGYtPmxvY2spOw0KPiAtICAgICBkZi0+cHJvZmlsZS0+dGltZXIgPSB0aW1lcjsNCj4gLSAg
ICAgbXV0ZXhfdW5sb2NrKCZkZi0+bG9jayk7DQo+IC0NCj4gICAgICAgcmV0ID0gZGYtPmdvdmVy
bm9yLT5ldmVudF9oYW5kbGVyKGRmLCBERVZGUkVRX0dPVl9TVE9QLCBOVUxMKTsNCj4gICAgICAg
aWYgKHJldCkgew0KPiAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIiVzOiBHb3Zlcm5vciAl
cyBub3Qgc3RvcHBlZCglZClcbiIsIEBAIC0xODY3LDYgKzE4NjMsMjEgQEAgc3RhdGljIHNzaXpl
X3QgdGltZXJfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgfQ0KPg0KPiArICAg
ICBtdXRleF9sb2NrKCZkZi0+bG9jayk7DQo+ICsgICAgIGRmLT5wcm9maWxlLT50aW1lciA9IHRp
bWVyOw0KPiArICAgICBzd2l0Y2ggKGRmLT5wcm9maWxlLT50aW1lcikgew0KPiArICAgICBjYXNl
IERFVkZSRVFfVElNRVJfREVGRVJSQUJMRToNCj4gKyAgICAgICAgICAgICBJTklUX0RFRkVSUkFC
TEVfV09SSygmZGYtPndvcmssIGRldmZyZXFfbW9uaXRvcik7DQo+ICsgICAgICAgICAgICAgYnJl
YWs7DQo+ICsgICAgIGNhc2UgREVWRlJFUV9USU1FUl9ERUxBWUVEOg0KPiArICAgICAgICAgICAg
IElOSVRfREVMQVlFRF9XT1JLKCZkZi0+d29yaywgZGV2ZnJlcV9tb25pdG9yKTsNCj4gKyAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgIiVzOiBUYXJnZXQgZGV2ZnJlcSglcykncyBwcm9maWxlIHRpbWVyIGhhcyBubyBzZXR0
aW5ncyBcbiIsIGRmLT5nb3Zlcm5vcl9uYW1lLA0KPiArICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18pOw0KPiArICAgICAgIG11dGV4X3VubG9jaygmZGYtPmxvY2spOw0KPiArICAgICAgIGdv
dG8gb3V0Ow0KPiArICAgICB9DQo+ICsgICAgIG11dGV4X3VubG9jaygmZGYtPmxvY2spOw0KPiAr
DQo+ICAgICAgIHJldCA9IGRmLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZiwgREVWRlJFUV9H
T1ZfU1RBUlQsIE5VTEwpOw0KPiAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgIGRldl93
YXJuKGRldiwgIiVzOiBHb3Zlcm5vciAlcyBub3Qgc3RhcnRlZCglZClcbiIsDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KT1BQTw0KDQrmnKznlLXlrZDpgq7ku7blj4rlhbbpmYTk
u7blkKvmnIlPUFBP5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO6YKu5Lu25oyH5piO
55qE5pS25Lu25Lq677yI5YyF5ZCr5Liq5Lq65Y+K576k57uE77yJ5L2/55So44CC56aB5q2i5Lu7
5L2V5Lq65Zyo5pyq57uP5o6I5p2D55qE5oOF5Ya15LiL5Lul5Lu75L2V5b2i5byP5L2/55So44CC
5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM5YiH5Yu/5Lyg5pKt44CB5YiG5Y+R44CB5aSN
5Yi244CB5Y2w5Yi35oiW5L2/55So5pys6YKu5Lu25LmL5Lu75L2V6YOo5YiG5oiW5YW25omA6L29
5LmL5Lu75L2V5YaF5a6577yM5bm26K+356uL5Y2z5Lul55S15a2Q6YKu5Lu26YCa55+l5Y+R5Lu2
5Lq65bm25Yig6Zmk5pys6YKu5Lu25Y+K5YW26ZmE5Lu244CCDQrnvZHnu5zpgJrorq/lm7rmnInn
vLrpmbflj6/og73lr7zoh7Tpgq7ku7booqvmiKrnlZnjgIHkv67mlLnjgIHkuKLlpLHjgIHnoLTl
nY/miJbljIXlkKvorqHnrpfmnLrnl4Xmr5LnrYnkuI3lronlhajmg4XlhrXvvIxPUFBP5a+55q2k
57G76ZSZ6K+v5oiW6YGX5ryP6ICM5byV6Ie05LmL5Lu75L2V5o2f5aSx5qaC5LiN5om/5ouF6LSj
5Lu75bm25L+d55WZ5LiO5pys6YKu5Lu255u45YWz5LmL5LiA5YiH5p2D5Yip44CCDQrpmaTpnZ7m
mI7noa7or7TmmI7vvIzmnKzpgq7ku7blj4rlhbbpmYTku7bml6DmhI/kvZzkuLrlnKjku7vkvZXl
m73lrrbmiJblnLDljLrkuYvopoHnuqbjgIHmi5vmj73miJbmib/or7rvvIzkuqbml6DmhI/kvZzk
uLrku7vkvZXkuqTmmJPmiJblkIjlkIzkuYvmraPlvI/noa7orqTjgIIg5Y+R5Lu25Lq644CB5YW2
5omA5bGe5py65p6E5oiW5omA5bGe5py65p6E5LmL5YWz6IGU5py65p6E5oiW5Lu75L2V5LiK6L+w
5py65p6E5LmL6IKh5Lic44CB6JGj5LqL44CB6auY57qn566h55CG5Lq65ZGY44CB5ZGY5bel5oiW
5YW25LuW5Lu75L2V5Lq677yI5Lul5LiL56ew4oCc5Y+R5Lu25Lq64oCd5oiW4oCcT1BQT+KAne+8
ieS4jeWboOacrOmCruS7tuS5i+ivr+mAgeiAjOaUvuW8g+WFtuaJgOS6q+S5i+S7u+S9leadg+WI
qe+8jOS6puS4jeWvueWboOaVheaEj+aIlui/h+WkseS9v+eUqOivpeetieS/oeaBr+iAjOW8leWP
keaIluWPr+iDveW8leWPkeeahOaNn+WkseaJv+aLheS7u+S9lei0o+S7u+OAgg0K5paH5YyW5beu
5byC5oqr6Zyy77ya5Zug5YWo55CD5paH5YyW5beu5byC5b2x5ZON77yM5Y2V57qv5LulWUVTXE9L
5oiW5YW25LuW566A5Y2V6K+N5rGH55qE5Zue5aSN5bm25LiN5p6E5oiQ5Y+R5Lu25Lq65a+55Lu7
5L2V5Lqk5piT5oiW5ZCI5ZCM5LmL5q2j5byP56Gu6K6k5oiW5o6l5Y+X77yM6K+35LiO5Y+R5Lu2
5Lq65YaN5qyh56Gu6K6k5Lul6I635b6X5piO56Gu5Lmm6Z2i5oSP6KeB44CC5Y+R5Lu25Lq65LiN
5a+55Lu75L2V5Y+X5paH5YyW5beu5byC5b2x5ZON6ICM5a+86Ie05pWF5oSP5oiW6ZSZ6K+v5L2/
55So6K+l562J5L+h5oGv5omA6YCg5oiQ55qE5Lu75L2V55u05o6l5oiW6Ze05o6l5o2f5a6z5om/
5ouF6LSj5Lu744CCDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29u
ZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gT1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBm
b3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFu
eSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5j
bHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwg
cmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhl
IGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgZG8gbm90IHJlYWQsIGNvcHksIGRpc3RyaWJ1dGUs
IG9yIHVzZSB0aGlzIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5z
bWlzc2lvbiBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5
IHJlcGx5IGUtbWFpbCBhbmQgdGhlbiBkZWxldGUgdGhpcyBtZXNzYWdlLg0KRWxlY3Ryb25pYyBj
b21tdW5pY2F0aW9ucyBtYXkgY29udGFpbiBjb21wdXRlciB2aXJ1c2VzIG9yIG90aGVyIGRlZmVj
dHMgaW5oZXJlbnRseSwgbWF5IG5vdCBiZSBhY2N1cmF0ZWx5IGFuZC9vciB0aW1lbHkgdHJhbnNt
aXR0ZWQgdG8gb3RoZXIgc3lzdGVtcywgb3IgbWF5IGJlIGludGVyY2VwdGVkLCBtb2RpZmllZCAs
ZGVsYXllZCwgZGVsZXRlZCBvciBpbnRlcmZlcmVkLiBPUFBPIHNoYWxsIG5vdCBiZSBsaWFibGUg
Zm9yIGFueSBkYW1hZ2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gc3VjaCBtYXR0ZXIg
YW5kIHJlc2VydmVzIGFsbCByaWdodHMgaW4gY29ubmVjdGlvbiB3aXRoIHRoZSBlbWFpbC4NClVu
bGVzcyBleHByZXNzbHkgc3RhdGVkLCB0aGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGFy
ZSBwcm92aWRlZCB3aXRob3V0IGFueSB3YXJyYW50eSwgYWNjZXB0YW5jZSBvciBwcm9taXNlIG9m
IGFueSBraW5kIGluIGFueSBjb3VudHJ5IG9yIHJlZ2lvbiwgbm9yIGNvbnN0aXR1dGUgYSBmb3Jt
YWwgY29uZmlybWF0aW9uIG9yIGFjY2VwdGFuY2Ugb2YgYW55IHRyYW5zYWN0aW9uIG9yIGNvbnRy
YWN0LiBUaGUgc2VuZGVyLCB0b2dldGhlciB3aXRoIGl0cyBhZmZpbGlhdGVzIG9yIGFueSBzaGFy
ZWhvbGRlciwgZGlyZWN0b3IsIG9mZmljZXIsIGVtcGxveWVlIG9yIGFueSBvdGhlciBwZXJzb24g
b2YgYW55IHN1Y2ggaW5zdGl0dXRpb24gKGhlcmVpbmFmdGVyIHJlZmVycmVkIHRvIGFzICJzZW5k
ZXIiIG9yICJPUFBPIikgZG9lcyBub3Qgd2FpdmUgYW55IHJpZ2h0cyBhbmQgc2hhbGwgbm90IGJl
IGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBvciBtYXkgYXJpc2UgZnJvbSB0aGUg
aW50ZW50aW9uYWwgb3IgbmVnbGlnZW50IHVzZSBvZiBzdWNoIGluZm9ybWF0aW9uLg0KQ3VsdHVy
YWwgRGlmZmVyZW5jZXMgRGlzY2xvc3VyZTogRHVlIHRvIGdsb2JhbCBjdWx0dXJhbCBkaWZmZXJl
bmNlcywgYW55IHJlcGx5IHdpdGggb25seSBZRVNcT0sgb3Igb3RoZXIgc2ltcGxlIHdvcmRzIGRv
ZXMgbm90IGNvbnN0aXR1dGUgYW55IGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0
cmFuc2FjdGlvbiBvciBjb250cmFjdCwgcGxlYXNlIGNvbmZpcm0gd2l0aCB0aGUgc2VuZGVyIGFn
YWluIHRvIGVuc3VyZSBjbGVhciBvcGluaW9uIGluIHdyaXR0ZW4gZm9ybS4gVGhlIHNlbmRlciBz
aGFsbCBub3QgYmUgcmVzcG9uc2libGUgZm9yIGFueSBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdl
cyByZXN1bHRpbmcgZnJvbSB0aGUgaW50ZW50aW9uYWwgb3IgbWlzdXNlIG9mIHN1Y2ggaW5mb3Jt
YXRpb24uDQo=
