Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6784742BFF9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhJMMat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 08:30:49 -0400
Received: from mail-sn1anam02on2076.outbound.protection.outlook.com ([40.107.96.76]:62563
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231145AbhJMMas (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Oct 2021 08:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCg244B9lPz5m69jR5Vb4xbGBvn76GZMoT6t7qmKHrX8/2W+vv9fm2x+QymlyuB/x4YhJx7UTJStqMASsq2MMAhteO9CslidCfyeFz0lVlal9QZ2cly7YRnfGX63W07fg+Pfot0QxylJVJXzjUG5Dd65u66AloHawH8/aBrJFkixJNuEUnyWfSXnAtYlLbjf7H9c7nIRLRJ4LUPwVrvcZqmk5MNYILR/GUyFYR9q8f43/sEaVKhXf2lt6cozuQJ/rdq2xAH7ldFQXFSWNVDkFW3oUQ1lPV7BYmMDG2r/NlU/qJXHbyBpB8jdZallIUTlegGoCvXZ+vxTbFJnjuBxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhBHF7Cj5SokPNKBb/S1vvlqgxIV/QwqBRyYoRpWOgg=;
 b=bRWTdwIxtI20maJAoNWdN0dQ55ab+bWYrFTg34BcVNlFpFeDD6xlgIzcSJrf1QdBFSQYZ66D4HPN/CJplqMYnxrLI38LKWYCsRmXVfwmDvCmUyihRUUxqqYcUVND9PE5Jf/FQmp9+Umos6xAxJqwCJeulYjpKXv7fuVCnEAA81v80dY1jUVibD4xKdR+7//f8Oi6Bf9ssdR+UVWRKAY3tETG2Z5dfeEjyBoVhSjbd/bNLa76HuoOXZYI6uLgXO01iP0CDNLhn5mnJfsykzkdDH3N46MSiQtsbaE4d6AZc6q4oMp7DGuNIx0iXfItsE385CeYhP8CSfVkv+r/GgfHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhBHF7Cj5SokPNKBb/S1vvlqgxIV/QwqBRyYoRpWOgg=;
 b=RSb5M5znyXcfcdepW7XCkymNmUbDaxKsyVFK5AuFH99552xqwcIWN1sOJV2DRgk9vvQC6iej5GlRUs2YoIXHXc8QUZ+98QZtYrC48KbY8HssPvqs/t4kRgVE+M82zDxMnZLK5e199jk6MHFmBVL5adrLgIDDu1Q+xvf9XfQIYdA=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 12:28:40 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 12:28:40 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Topic: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
Thread-Index: AQHXsrXQs9OizRhBckanMP3pgJaGBKu5sOcAgBc3XFA=
Date:   Wed, 13 Oct 2021 12:28:40 +0000
Message-ID: <CY4PR1201MB024689BB0BD000BD0F3DFADFECB79@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-5-ray.huang@amd.com>
 <ff0fb071-78fd-87cf-bd6d-c89c25e09d4f@amd.com>
In-Reply-To: <ff0fb071-78fd-87cf-bd6d-c89c25e09d4f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T12:28:37Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=10061baa-3c00-4f15-be61-6a583cedac09;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8478683-216a-47fa-9552-08d98e44fd0d
x-ms-traffictypediagnostic: CY4PR12MB1287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB128770F7B1770990BD608E77ECB79@CY4PR12MB1287.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MxnxG99RwrXIxTrYc4FnMx6cXvNsLWItUduXRfkf+Ir2Y9uNJQSe2KXrOUwLf562jKX6jmfFb95leg+IU8LIPotwkqDlADfnSkQYsfCEbFB5KXwQAKsDT4eR9bsOEXxFvhhmEaxu9Sfcy0AqUYbe7Q7MNDdfLgpwz+KFdDYuBskraX/j8CTgGklRdiXKnqvRKTCvl3iu4PNKaZA0I++rlVtog+YNQ8XH5Rwcr+gXAb7NYowyHFDnpZTSl6fFywDLxc8FJSxRMioUNnRwrEQ3tH+ckWKMrGJOP/xs3Wk5pciePp5TVdP5ZT2A18fuLzIKmOP/27ROzw27OPq6Az7wRVESdR/bv8+mJJAHNXelaQI/QHiwHxZPhPJcMOsbf/ZxnXOk10KO/N+6Ai2szxazgcnUMW2D4ZjWXVcIN6onZb9QdsjogOPApXgAOQUOkyzhOg/gNAOHm1rnLugkP4Dxubp1jwr/fc+0Lonn/oFgo+2ivTaRZnv6K8CXzlX2F6VR+N/BiBHYdzPhIPjxQEXRK2d40J0TlrNCfkDsBuAbkvVQ8Bh4Tyn5xqd4ljOL23yzFHtkqoFtKcoJJ9f53yeKGHIZUhK30e/mKz/l9WahoaYxD9w1sT6p//IM1wY3O6el/sq47ohqoK07sAvGT6bAY9PYgVXJ6KNlQ3683vAJ8nS9pz84MU/UiKKqoVj/jFT60arCkAb4OYvfy4S4aiItg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(2906002)(52536014)(186003)(26005)(86362001)(54906003)(5660300002)(71200400001)(76116006)(122000001)(66556008)(66476007)(66946007)(7696005)(64756008)(38100700002)(66446008)(8936002)(4326008)(55016002)(8676002)(38070700005)(6506007)(508600001)(83380400001)(53546011)(33656002)(9686003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlV0WmpJNDQ5bm5uNU1EN3lFaUJYUFZPY1lzcUFFdS80R3NvQWFRM3RDN0Va?=
 =?utf-8?B?aEx2UDExdC8wemczMnRSTjNXVW9IYXAyeVR2RkIvQ0liWjJORWdDaVB4ZWtF?=
 =?utf-8?B?MktQVVBkcnIwRmRyTU1melFuRkhGUzhneFNiSE8wbW5sRGFvam81Mjg4bHZ2?=
 =?utf-8?B?V0FGbHBUTmFlK3R4VW9WaGVsWDBaWmpxSnAwZFU2WGtXai9mZnM4Zk1pKytm?=
 =?utf-8?B?NEVQcCtlYVF0YkRYdU9oajVOenRteGY2Mm1uOTNzMzU5VUlYNjgvUG9LUER6?=
 =?utf-8?B?OWVwZnRKa3FiOUhLWXJ2VDZyRFlEUXRvcjhqQTJla0pDZUxwTm90R3dBUUU5?=
 =?utf-8?B?b2k1aGx2Ni9XMGt1ZEF0RmU3S004SmxvN2Q3RW1IaGFuejN2c3B6UWl3VEZX?=
 =?utf-8?B?c3AvMHhzaEpXbTJDTGtTSDZsV2pWY3JRdEtRcGxsMDYxUE1JdDNveXM5SnJQ?=
 =?utf-8?B?blQzR3ZBaFJhWWNqU1cwMmpZZFQ4ei9FNW1WZjRja0ZuYTJPWVZyV0pYR0p2?=
 =?utf-8?B?WHRnVDl3OXg5ZTJ2RUh6Y1RETVIwc2YvRm11UCtYbnBCSmFpMXAvbmdVQmVN?=
 =?utf-8?B?TEp3dEtNTnBUY1lmY1AxN3IySUpKRVAvcUJQTXRZTDNBem0rKzIyaVFOZk1O?=
 =?utf-8?B?L1RSdFFyZGNHb1h6bVR4LzNUSjNEaU9QK29IcU5FM0FrcTZoTFYreDYvY0Jj?=
 =?utf-8?B?VDhSL29QbGtGdmdveEFRWW9CUE9hZmw1dVZ4azZZK1RGTVhjc1JXTG9taEhY?=
 =?utf-8?B?WEFUNHA2RWlaVW4zeTF5N2RWVzQ5cE9DYUFpNzNUNVQyM1c1ZC9oTmp3M2pp?=
 =?utf-8?B?WUx0dWluOWp2WmZuWnh5NGxzeDNZeGZXQ0xER2VHWHppb0NLRS9mVXI3V2ZE?=
 =?utf-8?B?UFpvUjJvUTZxSHJTU0pFWkxTcWd2UVpUelVTa1pGalEvVkdONzZsUStzMlFO?=
 =?utf-8?B?WGNSUHBkQ21ZUWhUVjR6Y1FHWmxQVzlUS0hLTUJxSi9jNUpsRmlZOGttcWJ0?=
 =?utf-8?B?S1dkamRDYnFmZ24rUnRsMGVrTXlGSzFhRTQ3WW83MERZNWVHVTE0UVhvOVda?=
 =?utf-8?B?MmhBU3BhY2N6dTV0Umk2RWJ1UkV0TGZpLzhzcFI1WWlSdmNEZzZzTFRRN3oy?=
 =?utf-8?B?bUErRlJTRTFYbUV2RWFsOFEwTGVpa1hzd3l0bHNZNW41WTdLVTZjSVoyV2NG?=
 =?utf-8?B?NzRyYlZIRlM5ZTRXVU9VUGdvUGZ2UnpvREZmbEE2aE1ZcGtkQjRsV0FTZlpv?=
 =?utf-8?B?bUhtTGNOTFNuV1NCMEpiMVZyQlJQQk9MUEF3Sk9hak41WFZqNUhwVlkvOThn?=
 =?utf-8?B?WWxtRHFzcUVENnM4WlYwQlJNc0FhMlQwRTdPeit3aWFNbmNiNVBOV2RMNWFF?=
 =?utf-8?B?bXBnVkpMRWFJakI2ZEJDSTF5bm9QTjRqaVR5TktFajRCcGtib20zZHBOSWla?=
 =?utf-8?B?b2FtZ0pWM2VWOEl0VWVhU2V2YjhkT3VhL1BIRzNkRFJZaUxXM0N6dzlOcjc4?=
 =?utf-8?B?eXZYU0hVNHdzc04rQ2RBYUVtSnIvc1R0UlVQL3cxSlFmMWY0QytoV1dkWnRu?=
 =?utf-8?B?b2toc3R2KzBXZ3RJV1Q4RDRuV0FWNHBxc0Jmb0g1MTUzd2U4VDdxS3pxRFEw?=
 =?utf-8?B?aXpQQldzSWFURWxyeWo4cjBXS3A5QjhMdnpQd0xjTURrNFk0OHB6TU00eVBJ?=
 =?utf-8?B?L0p2QVkvbmNRN0NLM0d6cVkzT3lhcFdZa0RtVVFUMnFkVFhzK0lMQXhTeWI5?=
 =?utf-8?Q?qzxoAHsiUWPeaoyjt0kK5FBXzlUvf5b7suJOw1X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8478683-216a-47fa-9552-08d98e44fd0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 12:28:40.2372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpCXvOKa7ayDMG/eQ9b3oVGYCoDVDDf956vTqF9tlYs9h/9nJiGK3yIrzFjoIJWAFYaIDoe7iEDVOtlWL79u4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgYWxsLA0KDQpTb3JyeSB0byBsYXRlIHJlc3Bv
bnNlLCBJIGFtIGp1c3QgYmFjayBmcm9tIHZhY2F0aW9uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhhbi5Gb250ZW5vdEBhbWQu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyMSAxOjA2IEFNDQo+IFRv
OiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IFJhZmFlbCBKIC4gV3lzb2NraQ0KPiA8
cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBs
aW5hcm8ub3JnPjsNCj4gU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IEJv
cmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT47DQo+IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPjsNCj4gbGludXgtcG1A
dmdlci5rZXJuZWwub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
TGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgU3UsIEpp
bnpob3UgKEpvZSkgPEppbnpob3UuU3VAYW1kLmNvbT47DQo+IER1LCBYaWFvamlhbiA8WGlhb2pp
YW4uRHVAYW1kLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHg4NkBrZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMjFdIEFDUEk6IENQUEM6IGFkZCBj
cHBjIGVuYWJsZSByZWdpc3RlciBmdW5jdGlvbg0KPiANCj4gT24gOS8yNi8yMDIxIDQ6MDUgQU0s
IEh1YW5nIFJ1aSB3cm90ZToNCj4gPiBGcm9tOiBKaW56aG91IFN1IDxKaW56aG91LlN1QGFtZC5j
b20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgZnVuY3Rpb24gdG8gZW5hYmxlIENQUEMgZmVhdHVyZS4g
VGhpcyBmdW5jdGlvbg0KPiA+IHdpbGwgd3JpdGUgQ29udGludW91cyBQZXJmb3JtYW5jZSBDb250
cm9sIHBhY2thZ2UNCj4gPiBFbmFibGVSZWdpc3RlciBmaWVsZCBvbiB0aGUgcHJvY2Vzc29yLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmluemhvdSBTdSA8SmluemhvdS5TdUBhbWQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyB8IDQ4DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9hY3BpL2NwcGNfYWNwaS5oIHwg
IDUgKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVycy9hY3BpL2Nw
cGNfYWNwaS5jDQo+ID4gaW5kZXggMmVmZTJiYTk3ZDk2Li5iMjg1OTYwYzM1ZTcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3Bp
L2NwcGNfYWNwaS5jDQo+ID4gQEAgLTEyMjAsNiArMTIyMCw1NCBAQCBpbnQgY3BwY19nZXRfcGVy
Zl9jdHJzKGludCBjcHVudW0sIHN0cnVjdA0KPiBjcHBjX3BlcmZfZmJfY3RycyAqcGVyZl9mYl9j
dHJzKQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGNwcGNfZ2V0X3BlcmZfY3Rycyk7
DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIGNwcGNfc2V0X2VuYWJsZSAtIFNldCB0byBlbmFibGUg
Q1BQQyBvbiB0aGUgcHJvY2Vzc29yIGJ5IHdyaXRpbmcgdGhlDQo+ID4gKyAqIENvbnRpbnVvdXMg
UGVyZm9ybWFuY2UgQ29udHJvbCBwYWNrYWdlIEVuYWJsZVJlZ2lzdGVyIGZlaWxkLg0KPiA+ICsg
KiBAY3B1OiBDUFUgZm9yIHdoaWNoIHRvIGVuYWJsZSBDUFBDIHJlZ2lzdGVyLg0KPiA+ICsgKiBA
ZW5hYmxlOiAwIC0gZGlzYWJsZSwgMSAtIGVuYWJsZSBDUFBDIGZlYXR1cmUgb24gdGhlIHByb2Nl
c3Nvci4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzLCAtRVJSTk8gb3Ig
LUVJTyBvdGhlcndpc2UuDQo+ID4gKyAqLw0KPiA+ICtpbnQgY3BwY19zZXRfZW5hYmxlKGludCBj
cHUsIHUzMiBlbmFibGUpDQo+IA0KPiBUaGlzIHNob3VsZCB0YWtlIGEgYm9vbCBpbnN0ZWFkIG9m
IHUzMiBmb3IgZW5hYmxlLCB5b3UgY2FuIG9ubHkgZW5hYmxlDQo+IG9yIGRpYWJsZSBjcHBjLiBU
aGUgb25seSBjYWxsZXIgSSBzZWUgaXMgaW4gcGF0Y2ggNy8yMSBpbiB3aGljaCB0aGUNCj4gZW5h
YmxlIGFyZyBpcyBhbHJlYWR5IGEgYm9vbCB0aGF0J3MgY29udmVydGVkIHRvIGEgdTMyLiBUaGlz
IGFsc28gYWxsb3dzDQo+IGZvciB0aGUgcmVtb3ZhbCBvZiB0aGUgZW5hYmxlIHZhbHVlIGNoZWNr
Lg0KPiANCg0KWWVzLCB0aGUgYm9vbCB0eXBlIHNob3VsZCBiZSBiZXR0ZXIgdGhhbiB1MzIgaGVy
ZS4gV2lsbCB1cGRhdGUgaXQgaW4gVjMuIA0KDQo+IFlvdSBzaG91bGQgY29uc2lkZXIgbWVyZ2lu
ZyB0aGlzIHBhdGNoIHdpdGggcGF0Y2ggNy8yMS4gVGhpcyBwYXRjaCBhZGRzDQo+IHRoZSBjcHBj
X3NldF9lbmFibGUoKSByb3V0aW5lIGJ1dCBoYXMgbm8gdXNlcnMuIFRoZSBvbmx5IGNhbGxlciBJ
IGZpbmQgaXMNCj4gaW4gcGF0Y2ggNy8yMS4NCj4gDQoNCkkgYW0gbG9va2luZyBiYWNrIGFnYWlu
LCB0aGlzIHBhdGNoIGlzIHRvIHByb3ZpZGUgdGhlIG5ldyBoZWxwZXIgaW4gY3BwY19hY3BpIGxp
YnJhcnkgdW5kZXIgQUNQSSBzdWJzeXN0ZW0uDQpIb3dldmVyLCBwYXRjaCA3IGlzIHRvIGVuYWJs
ZSB0aGUgc2hhcmVkIG1lbW9yeSBBUElzIGluIGFtZC1wc3RhdGUgZHJpdmVyLg0KVGhleSBhcmUg
YWN0dWFsbHkgdGhlIGRpZmZlcmVudCBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbnMuIEkgcHJlZmVy
IHVzaW5nIHRoZSBzZXBhcmF0ZWQgcGF0Y2ggaGVyZS4gICANCg0KVGhhbmtzLA0KUmF5DQo=
