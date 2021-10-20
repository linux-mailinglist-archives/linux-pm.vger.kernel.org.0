Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5B4349E8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 13:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTLRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 07:17:44 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:14866
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229864AbhJTLRn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Oct 2021 07:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCuRsFRZPnZk2Ba6ppRmmzyEhZ3tqs0GthgvguK0omKzWaJa+Sfaep98Mw0FzQxJ5PvXCMjdwwJb57/+4097k7+iZvad/5R4KVa5sfoU7+XwHyXuU8Jgw4igoD4/0Qbgv2ZbvlY9lX65lHpF+wprK0aAiHdOmnU9TBMkyW/8LMxKl1Ese0CEidQFkP07+4vQkddHvg6OaPzNjeCM4vMeNwlCOwD/1P/xWrkOcD45g9k1qH5sQbrPZMsfmqVoZkjicZUN9592ccdL71i6wXswJgKSqCLVl1dKPAsFziOxVx+Wbk8LWZ3Mk4ggmBIeo3DX7g0JoZ+7ubeONKL7Ij1w4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9RDIh34pI8oWzj8osVTm9f+3qlasBpaVky5osghVlA=;
 b=fsKo6ySh3KRO/IcZAHtwF2lNK/CiLCoBxynRTDFN0dmVhca8AqxLSLSK3j2y3JoPXK32yR5OfCCgPPdv6ibzu4dy/8wRYsUoxI7sPqRMWoOwGErbrQ4wOH/VcY+WW6/TKzf6EG6EZHZARJh3DhFNdrZ5A8yE70sKfhGSonjPGq7xsrt01EJdVjUykMmAx3GCiIcyW5rn1AgfpLtFbCzwilgUtlwNdVthL+lkaAOnjF5kqyGWeCcE3gWCPOhfO2kbVmn7jagGO07fiImbj9ccOqQ6L8q+QnloVXZyDHuiwrcuKq9J3dMQM42hv3Ok6jpckJb6f/ks/36W3t6oCKjcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9RDIh34pI8oWzj8osVTm9f+3qlasBpaVky5osghVlA=;
 b=yCU4sgNZRLFgFfaWnx9msq0IWPuO6WY6HG2i4Ivj4laGpt9+E2zfYb/Ox8EqIbdW6jsUjc9q9Dil09qJoMCFXtvgZpJ9/QRQi7uFrRwPcmEbft572KL6anZ80pH+KIuJdR2QFsVEh7hjP8uUZD5VHS/g9/a0Y8PnmCpF3TnhxdU=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1160.namprd12.prod.outlook.com
 (2603:10b6:903:38::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 11:15:26 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 11:15:26 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: RE: [PATCH v2 03/21] ACPI: CPPC: Check online CPUs for determining
 _CPC is valid
Thread-Topic: [PATCH v2 03/21] ACPI: CPPC: Check online CPUs for determining
 _CPC is valid
Thread-Index: AQHXsrXNu+j3bIKZ3UKfLB7jf4MrMavargWAgAEaCdA=
Date:   Wed, 20 Oct 2021 11:15:26 +0000
Message-ID: <CY4PR1201MB024619C643621BAF76F9154DECBE9@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-4-ray.huang@amd.com>
 <CAJZ5v0ivJk-cVv0kHUeF1M7aWBZ9ziuUF-9=M_eF+WQ1vQJfgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ivJk-cVv0kHUeF1M7aWBZ9ziuUF-9=M_eF+WQ1vQJfgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-20T11:15:23Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=91a76963-94d3-4b5b-9c9f-57ff11095f67;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c4dd304-5a29-4044-f10e-08d993baeb1d
x-ms-traffictypediagnostic: CY4PR12MB1160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB11603450D3D7DAE80CF9238CECBE9@CY4PR12MB1160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtvxQocoAWkVVWXYhFZ1jbkdHQWlaN7Y2XMKrU188AGDAGzcklxL9mXEBJrzvTrqwOI1tieC8oQ6ub/Hbgdl2c7DYQzVu3iUH/kegHLXb1IOChUIBa70gIvsEBUZyX9sb38RgIa5wrx2oFYKrl+qd5RhlIOjJF4KnIyoLtoOP8ZJhXATpMvVGj8acfR+sN/oNKaNhVnnJaGUle7oFSEBt39iZ5Kj/hxnreH0eqkZTNLVqHt3rSBOCRjPigGi2Pf4R2rPpLLqwHQCSlCki2bp/A7pIOJ2ebpRN85/BJbU3Xo7sv1FKYGX5P463H3cgMeZbPADKZChWCXrwonqosdarsR+OCZhat1VpWKXLPpdbbVC+EdexnavJuH8AimVktgbHhJN7mdpKo9spmXUxfzI8MrgpOUiSOb9856tWa/K3te64H7TKZJaGjsFlCuI6kP+uKmNmCvqcK2DQqWzNCnIt1rA644Ru2ZVRDxQgYNUQ3mbHgQ2L3LvPa2Y0Dna+QEZfv9hmIFSZZmRLFyTcjVGIEtYUaV5ueehfALPZJV2sOVxuIfb48F9tVIBF618F8Nev9P+I/F+iYQYvbmPn5IPHTakzPNzPM9xjk4j+ioi+DXi3pZqwbmP93XhfRySnc+eE4qK3DmS+a6p7+ONsVJ53kDRTpTo/obeB9At72pVj5JVI19yUrgla8BpHuwg/Dw6Ox0Yx+KHu/VxGFP5z7WQHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(71200400001)(66476007)(186003)(66556008)(64756008)(55016002)(54906003)(66446008)(86362001)(9686003)(2906002)(26005)(316002)(38100700002)(8936002)(76116006)(33656002)(52536014)(4326008)(83380400001)(6916009)(6506007)(38070700005)(53546011)(66946007)(7416002)(7696005)(508600001)(122000001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGx1NFNYUGVSN1RkYWllWnRTNkdqVDc2c2JndGdpM253RjVGUHBlUmo4SUxr?=
 =?utf-8?B?VDZHWGNlSWVuREsxZVpnTHZ2M0VLK21YR2c3RjZhb3FhazV5aEJubmtIUUhJ?=
 =?utf-8?B?cmRVZkRodmR6ZUFHa3ZVNHJPRlZCQkxsb1BHb280NlhvbW9SblNjb1NKaXpu?=
 =?utf-8?B?Q09wSFdWNzNSb0d4Y2MzS3E5bkhMN2s0YlVjVDFBdElJVytnS2hQUHBabk5D?=
 =?utf-8?B?SW1HVHFCTWl2UWNnai8wemhON0VFSmIvTGZiQ0RqV3JIVCsxVzlQSXd5V0lW?=
 =?utf-8?B?bUlBU0pxZW9SNTRSQkI0ODl4a3Vpbk5YdTk3VE0zWmFqMTgvbTQ2WDluL0My?=
 =?utf-8?B?Vm9kRzV3YVljekJpTmVyelhyZ0lqN1BSdCs1V3dGU0VpTnhVTW9DOVJoWk1R?=
 =?utf-8?B?KzBDR2grODFOd2Q5UnBxYnE4Zi95ZVZkK2RHOUE3TTBTNXdydmphK3lXbDNR?=
 =?utf-8?B?ak5MRmE4QnZwR0hjc1ZlN3pyQUVyV1lTdU01OEZYM0M1eU5qOGFCL3dlK3ZR?=
 =?utf-8?B?OGN3Z0NFcFlqbUlzZTBHWTdlVjJUNkhiak1rYUptZTMyaURVd083UHFTY3B6?=
 =?utf-8?B?bzRvVmFmWlBqN0l2VG4vSnRrLzZ5K2FaRjVnMEpwK3dES3I1MGFMMHEzWXNn?=
 =?utf-8?B?WDl3WCtRcCsrWlViUzZ4dWpMWlp6TTBhL1Z2dk1jUm5iZmU2NU9kQnlnQnRG?=
 =?utf-8?B?R01ZK1Q1WXRVeTI0dlR2V3oybDhHYWpMYlpKVjNxdHNJQ2NJYjhhR0ZHVEtw?=
 =?utf-8?B?NlBZQWxBUmMrS3VRQktaZk9oMGYwblhGUlRaWHFUU3paQkxDRklGS0l2MWIv?=
 =?utf-8?B?OWZISllFNkJtdVVjUUtYVEQ3QnJxRDBSZHA2VzdGaWFuNk50VUFkUWptaUpU?=
 =?utf-8?B?TThjRzZmdTRpWXQrODlmcFhSeE9MejU5VFI5dzJqWXJqMUZqcUoyTTlFSDd0?=
 =?utf-8?B?UmlsZ2E2NUFKNkpQZm43WWhUc0NyUkNreWN6NkZZRk5NcURrUlovNDdkRkJq?=
 =?utf-8?B?RFlmRU9BNnk1WkJMQ2YyYVI4aG8wOFJ5aUtVMXd1UWlNRXF0KzkrUmFyellB?=
 =?utf-8?B?cFYzUitieXk0cGhaMFI2SkRWVGhvVFZjN01OSFAvSHJtWno0S3BJTWhjczFQ?=
 =?utf-8?B?Q0JPY21FZTdmd2VDMWhPWXFtWndsYmw0TmlHa01mM3ZVNkVlVGFad2Z1QmRF?=
 =?utf-8?B?c0lCcDVTT0tML0JVWmh2ei82M1hVYlo3aVpxVGFQZDRhRjRsYmZPWVFYWUVh?=
 =?utf-8?B?YzM1VU1NanpmdXhSSllPa3daTlI4c1FpOTBWZVZFZ29OUm1vL2p2ODd5eDVS?=
 =?utf-8?B?bmVaODdDOUlHMWVtOWhRK3B0ZkxuRi83Rnh6ZXpOVDZTWG9KdlFncEdtMlVN?=
 =?utf-8?B?SldwZnFnckFuM29xbC9RalBlU0dhNUY1cUZUNWxmUzd5M1hiK0UrVmVjalU1?=
 =?utf-8?B?Rk9OcEZTUmNJY0pVUXpUakZEMU1SMlo3dG95ZUYwZHY5R3J5b1ZhMHVZakxj?=
 =?utf-8?B?RzNmeHl1L25WZklQM0tCQkdPMEFkdEVVQ0QrVHl1TFhMcDJMUzJzd1haeldU?=
 =?utf-8?B?QlpHYmhJL3NGY2tvVXBsRTlnWnJsTnNuazJrY1JhYXo4SUM5bTdGMExHWW1N?=
 =?utf-8?B?bE40YUZqeFVxMEVmcXh0YVJPZ2g4cktjMFVRZFNOdlFXelo3dS9VTEdBUFI3?=
 =?utf-8?B?dHB4ZGs2Uk1HNkhkMWNNR1JxeFY5YVU0VDRxSU9Mc2h2bEhFUjg5RFVOWjRr?=
 =?utf-8?Q?6vI3yWWjM/ZKEmDH2QUQ0tFLfJsG//Q9ZJEq8Oy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4dd304-5a29-4044-f10e-08d993baeb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 11:15:26.5934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThQkgVjXid6GLAfOF7ncvRbqDby3aaX1bN6y+OoJbdXwTr5MfEr8JBzPM+2sn8tEXRwXPfAKRGPo5jAiHgvh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1160
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgT2N0b2JlciAyMCwgMjAyMSAxMjo1MyBBTQ0KPiBUbzogSHVhbmcsIFJheSA8UmF5
Lkh1YW5nQGFtZC5jb20+DQo+IENjOiBSYWZhZWwgSiAuIFd5c29ja2kgPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPjsgVmlyZXNoIEt1bWFyDQo+IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47
IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+Ow0KPiBCb3Jpc2xhdiBQZXRr
b3YgPGJwQHN1c2UuZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJ
bmdvDQo+IE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47IExpbnV4IFBNIDxsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc+Ow0KPiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGltb25j
aWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgRm9udGVub3QsIE5h
dGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBTdSwgSmluemhvdSAoSm9lKSA8Smlu
emhvdS5TdUBhbWQuY29tPjsNCj4gRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsg
TGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyB0aGUgYXJjaC94ODYgbWFpbnRhaW5lcnMgPHg4NkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDAzLzIxXSBBQ1BJOiBDUFBDOiBDaGVjayBvbmxpbmUgQ1BVcyBmb3IN
Cj4gZGV0ZXJtaW5pbmcgX0NQQyBpcyB2YWxpZA0KPiANCj4gT24gU3VuLCBTZXAgMjYsIDIwMjEg
YXQgMTE6MDYgQU0gSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4g
Pg0KPiA+IEFzIHRoaXMgaXMgYSBzdGF0aWMgY2hlY2ssIGl0IHNob3VsZCBiZSBiYXNlZCB1cG9u
IHdoYXQgaXMgY3VycmVudGx5DQo+ID4gcHJlc2VudCBvbiB0aGUgc3lzdGVtLiBUaGlzIG1ha2Vz
IHByb2JlaW5nIG1vcmUgZGV0ZXJtaW5pc3RpYy4NCj4gPg0KPiA+IFdoaWxlIGxvY2FsIEFQSUMg
ZmxhZ3MgZmllbGQgKGxhcGljX2ZsYWdzKSBvZiBjcHUgY29yZSBpbiBNQURUIHRhYmxlDQo+ID4g
aXMgMCwgdGhlbiB0aGUgY3B1IGNvcmUgd29uJ3QgYmUgZW5hYmxlZC4gSW4gdGhpcyBjYXNlLCBf
Q1BDIHdvbid0IGJlDQo+ID4gZm91bmQgaW4gdGhpcyBjb3JlLCBhbmQgcmV0dXJuIGJhY2sgdG8g
X0NQQyBpbnZhbGlkIHdpdGggd2Fsa2luZw0KPiA+IHRocm91Z2ggcG9zc2libGUgY3B1cyAoaW5j
bHVkZSBkaXNhYmxlIGNwdXMpLiBUaGlzIGlzIG5vdCBleHBlY3RlZCwgc28NCj4gPiBzd2l0Y2gg
dG8gY2hlY2sgb25saW5lIENQVXMgaW5zdGVhZC4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBKaW56
aG91IFN1IDxKaW56aG91LlN1QGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGlt
b25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3Bp
L2NwcGNfYWNwaS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3BwY19h
Y3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgaW5kZXgNCj4gPiBhNGQ0ZWViYmExZGEu
LjJlZmUyYmE5N2Q5NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCj4gPiBAQCAtNDExLDcgKzQxMSw3
IEBAIGJvb2wgYWNwaV9jcGNfdmFsaWQodm9pZCkNCj4gPiAgICAgICAgIHN0cnVjdCBjcGNfZGVz
YyAqY3BjX3B0cjsNCj4gPiAgICAgICAgIGludCBjcHU7DQo+ID4NCj4gPiAtICAgICAgIGZvcl9l
YWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsNCj4gPiArICAgICAgIGZvcl9lYWNoX29ubGluZV9jcHUo
Y3B1KSB7DQo+IA0KPiBTaG91bGRuJ3QgdGhpcyBiZSBmb3JfZWFjaF9wcmVzZW50X2NwdSgpPyAg
SW4gY2FzZSBhIENQVSBpcyBwcmVzZW50LCBidXQgbm90DQo+IG9ubGluZSB3aGVuIGNwcGNfY3B1
ZnJlcSBpcyBsb2FkZWQ/DQo+IA0KDQpPSywgZ290IGl0LCB0aGFua3MhIFdpbGwgdXBkYXRlIGl0
IGluIFYzLg0KDQpUaGFua3MsDQpSYXkNCg==
