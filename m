Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9B46C1E4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 18:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhLGRhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 12:37:43 -0500
Received: from mail-os0jpn01on2108.outbound.protection.outlook.com ([40.107.113.108]:64129
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhLGRhm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Dec 2021 12:37:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPbkqsNSwuf9VDzXY6lMkMfa/RD2e81Gq/VPnUBuuHhHP45UHg608gJjuCoLSVX8H1q3Ov08veROsqo6cFdFI5PV3rsBhMSoCBnm1gr7CWgl1lsVK+kRH/clHX4VeoImC0rpS9UOFfp1j1+My7ibHV5WZgAxgKMIuHbyPmz41vFN1ZSSOSjUea0Droz0+uL4P01Y/fI/tFebQabV4gP9EWRM7j9SqXzF+63tCnwVEeRUAyExZX347ufkbpBYAT1l9PrNAL/Sh9ea//hOuF8iQYh4m06PZXTxy6HPNUfnju2PiCeCddR/ReD1NTcaGXgREZ1RLoEPhXj8iAj5G9DGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bun+kXiZUEOgx8l4PxdWGCLnSdIAWfFrh8c5rJiKhM=;
 b=X6Kd5LWosbttj4ccdTJTPdhTLP2bVo6SEfWzUDZr+dbcAHjK6b+jjhPGPDQBVZDq0wCKxQQfZ2r+U3aADPRIcHAum/4A8wY5cB2OOf3Nv5ItHksMTf6fvJjqvO26dXdm8/3dc025XrVaWAqvh29wvme/JPHRJ8fY4E2wA7cWg/XJpM9kneLExqx8yxDrNHotmgQ+G89OVfxArfy//rQfrnFeaPHHMN3k5KtSnJJW/llTMVchbpr5ECOZfA0EEMyD5jTxJoa+5tZP7bGP9iQeXDwWIaRTyKstkhG1J0LJvdXyhkqCAE2m0/3eTGQAhJS7Gzeluwi1rbA4rjFiWs5ttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bun+kXiZUEOgx8l4PxdWGCLnSdIAWfFrh8c5rJiKhM=;
 b=fN4fgRLgPZo200PNfS9eI7y+ls60N7YLmcIc1/Pe8NubblxglywUyv7GeB8D3ujUAbcl9D3wdMvIIsdjemjoIv2kPCdSE2WhBlGtb1qL9r7ZIgPJPYwodZdbZU6+f9RQO54cx2cgqOOTf+SlSW5iA7xpxOfmV8FEpIe3Gl0mzNk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2097.jpnprd01.prod.outlook.com (2603:1096:603:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 17:34:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 17:34:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] Add Thermal support for RZ/G2L
Thread-Topic: [PATCH v3 0/2] Add Thermal support for RZ/G2L
Thread-Index: AQHX5gMPuY1H34sK2keMXWyoq7N8Z6wnVNug
Date:   Tue, 7 Dec 2021 17:34:02 +0000
Message-ID: <OS0PR01MB5922FCA9FD67BAF659AE8BC7866E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211130155757.17837-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20211130155757.17837-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6903870-2781-46d9-b44f-08d9b9a7c29e
x-ms-traffictypediagnostic: OSAPR01MB2097:EE_
x-microsoft-antispam-prvs: <OSAPR01MB20979F55522F0EA5FD371C4D866E9@OSAPR01MB2097.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88tZKfRjPpjO565h6C3VjE02h2sgM2krdkOO4aV3LWLZst+OoMi0c79mzCEji1miAEvJpgbNpC/+/rRGKFafPCFN3eKDrzWN3fbiSjXAx7vLbAcGCb1F8yusqpyqv5AJoNk/eGi6+RlLRGruGeSvJ1zFcT/DKhrKlorsVE4/eJT8XPLlsyjQhkghSjKDGa/hNMIIxKAg379GmiIUPdeJxZzGEGXEdSvEUVBastnAB3AKsVY31u90+Ofax4DU4xeOxtxmowDCtcA6Ms2fOxq8f5SB6DO6A8AGpwEGt4ifBVOCNZ2V5WH02qmQwCOtAl9bGhGhuII3RS8jgOInK5IT83DyO8JZQ6KL+Dpd/0mxWymI0FkDRPPEelIIaa039jpWGKcd+Pqcxi8ut3Ig0Y8+4XxtYoFSyXovpAeIK1Bove6JA60BqxOM2I0T4ghaGIYkIcx6GLMRcLUiZcCi/Q96H4gmrUfJod6+vHvjCFBF/5dtIFDittVg2VtkVCv9We3vZ8mB3k0R3VaGlORdZG3pEDQ83qVFlmKCzPAmbycUxl6gWLptexhEzbh+Ty7BpjUsPeXI8mvZ5lmprlpxDlmpKFOOh1IuafD9cld7I38+Os0kuhw0sC9H/FchVW9/PWbRSaOxJtTEJyvoUbRRHT4N5opDJGofttJA+hC8VH24lPJwu+c0zxqFCa5TkkxwgkCYzQ+bShp5GK32YL6hyGLKpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6506007)(186003)(508600001)(8676002)(316002)(110136005)(9686003)(66946007)(76116006)(26005)(8936002)(2906002)(86362001)(64756008)(66556008)(66476007)(54906003)(66446008)(7416002)(52536014)(55016003)(38100700002)(4326008)(122000001)(33656002)(71200400001)(7696005)(38070700005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3lqbTU1TDFVNm5VK0RZUmxDcGZLeSt5WWFWWkxsS1dSZ1ZKR0FDVWZMb1pi?=
 =?utf-8?B?aU5nYlpwb09mS1gvaFFSMzNJb2QxN21aUjk5RXBwbVBBRy9EYzg5bEJzM3lI?=
 =?utf-8?B?L2lsZ05PZ0xLOStEck84VzVBTzUxUmxCd3E2RFJMVURRNndkeWFsbUNOL3My?=
 =?utf-8?B?eDNJTmxraGlwMVZrdkhoUEViWE83bmhwOFpCMDA2TDJxVW41OUp6Zy9BVita?=
 =?utf-8?B?WHMrd0NEV0I2YysvOEdwWDdscGl5Q2ZEQkswQWU5bGdTUlJDZnQ2TXJPditK?=
 =?utf-8?B?VUhTVjBuSGJWMUdUcHoyeUxNK3FFSzM0UmZXS1hUcyt3QWlOYnpYUjBJTm5t?=
 =?utf-8?B?Z3M3b1BxVFhhL2NtOEhBRE5aNUV0bkhCZ2YxelFEUWh5cEIvRWk3WEJ1ZEZm?=
 =?utf-8?B?bUtLSzd2bWhoVVJ4WWw5TDhoRXMxSkNsOGdBWlEybHVXWE9pSVVIRGY2UTdB?=
 =?utf-8?B?NkFBUXZGUFg2TjlXSlQ1dW1vYytKRXVGNkp3ZmZRNmttMTFEM010K2N0dWht?=
 =?utf-8?B?SEFIUThHaFVheFRUL2pGU05YWWp6VkFyN3VFbnJDTVJFWDJSQnZ5ckFUalA3?=
 =?utf-8?B?NFRISXQyenFXamRzbkttYUo5NmN6TllnY1hiNERXUVRNcCt0M2FkZ09VYklH?=
 =?utf-8?B?cUdXaGxXQ01BdzB1RHc5Ykp1WFgxS0VTcXg4eEVSZktqdEF6ZWlzemVaTVZI?=
 =?utf-8?B?NWc0TlhLSkpwLzYvNWplZTMxSWFXQXNab1BGa1Z0OWJFT3hmNzhhRmlQb1Zn?=
 =?utf-8?B?dUVzS2xPbGxjWWhZWWY0aDd0UUpVMnNGMHJsNVpJM3kveHZ5YkxYVWNZTU1j?=
 =?utf-8?B?eUpyYktKdGtiVExRMkRRZ1YvdTlCUy9uUnpCcjR0RE5GbG9CUUpWOFQvaDFz?=
 =?utf-8?B?SG5kT1AyY21EQld1eTV0QTAydVBzaEROaUltYWlNNzh2VmpGQkNybHNkcWNM?=
 =?utf-8?B?bjNMMkJ4eTZsRUFMTW9pbkk3ME9JQ09Pa2dCVUcySzI4emVYYWl3dlBrZ00y?=
 =?utf-8?B?SHlEQSszNXQ0Qy9BOTBkMzRxSTVwWG1oM0c1cUxZekRyMVUwdFJoUDkrVDY5?=
 =?utf-8?B?MWYvanZ5Lzd6NlB1SjBJNVpCby81Q0p1dlptcHg2OGg3T2ZaWmhhUkpocy9p?=
 =?utf-8?B?QXY3UnJSRElCTTVoZUUvWXQ1VzZTY3hYSkVMbXI4U3BnZnUrek02aldodjQz?=
 =?utf-8?B?SWlVWXNaZCtTVE50OTNpZS96WVhGUEpRalVqMlZkYXhyK09PZ2d4VXRTK1FR?=
 =?utf-8?B?amlPTlo4K0RxckNaQ0M4RXBXR2x0U0R1L0t5ZmR2eUloYTZWek9TWnpKNW9X?=
 =?utf-8?B?ODV5cVh3bXQvZE9sWVVEVkozZ1d0WUNHbnJFNXM5Ujh2K3pzdSt2QUs5ejBJ?=
 =?utf-8?B?YWYyVE1pcEIwSGkzdk9SZUhYd1FnanBPbWF5UUZQUUY1SmlNZmVHVjE2d2tj?=
 =?utf-8?B?S2lrN3Q5THVidktIMkQzSkE4Tm5OSGIvMUZuWXNKSmRJMk1rdlo3UkRJRWlQ?=
 =?utf-8?B?ZFVzSG9EMUhicUMxSmhIT3U4TmNuRnBCcXpyVksrRkxscDNXVEVPYUpJRkVw?=
 =?utf-8?B?TVJWY0N4b21Fa1psckppbUd6NUFCbi80NHNjS0h3dEhqTldsRnJoU3lkTVp4?=
 =?utf-8?B?M25GVmlEbXBKcVR6ZTgyZ0N1bVVqaldtVEdkSGRLRGRvZEtZWFlEYWx2ZGdO?=
 =?utf-8?B?WHA2TVR2MWtlTmUzN2UrQmRVdC9TR2E2dVJwcnhvdXdFQ3p4anp5TkY1MERx?=
 =?utf-8?B?Njc5NGlWMlNZQW5Nb05zQ2JxMUJtVjBJaDd4VlBmRUFjQmxnMG9ueDIrOWhF?=
 =?utf-8?B?bGdHdU0wUS9tYUVRTVoxNFJTVVBBSDcxT3BpZHovU3JMWFhxR3BXYVNDM0gy?=
 =?utf-8?B?UERBczdSaFRDd1IvR1hJQ1paKzR0RENtbkFwTm1rYXVnUEpBTlVWcTRPb1lI?=
 =?utf-8?B?L1FCRXA2ZnYzYVVyWXBKNGxwSndTS2JOS2ozY2ZxRTFEdGJrWnFwdlNsR1R2?=
 =?utf-8?B?N2xQMHdwNnZDNEFIN2JzbGZic2dPaytuV3lqM2dxeWF3bGEzZm1PNEh5OG5J?=
 =?utf-8?B?S25ad3dERXhoUmc5ZkpRV093cTFGcjh0S21kcy9xVlA5bzBtZENTaUpuM2NY?=
 =?utf-8?B?UlNIdXNDczZZNG1yTXljbzl3WFpmYVpNUCt6L2kxcHhRL1V4Ny9xNXNGL1Iv?=
 =?utf-8?B?SEI2dE1VZ2lHNjJEQ0VLQTF4ZWh1bE9zVkMxc2pwQU90cUYvODREMllLOFVZ?=
 =?utf-8?B?UjJpbmhPa2gxY0ttelcwTkJBeDRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6903870-2781-46d9-b44f-08d9b9a7c29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 17:34:02.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHKUtYa5YiPKZstn/0FYc8aZpjP/Df2O5EqZtzrjFTgf1tcP8c9p62RrXOxWhGgD/HGdeHQ7WSsS5LISUHv3mqfeK/GIAlOCyzflEygHM+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2097
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgQWxsLA0KDQpHZW50bGUgcGluZy4NCg0KQXJlIHdlIGhhcHB5IHdpdGggdGhlIHBhdGNoIHNl
cmllcz8gUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpSZWdhcmRzLA0KQmlqdQ0KDQo+IFN1YmplY3Q6
IFtQQVRDSCB2MyAwLzJdIEFkZCBUaGVybWFsIHN1cHBvcnQgZm9yIFJaL0cyTA0KPiANCj4gUlov
RzJMIFNvQyBpbmNvcnBvcmF0ZXMgYSB0aGVybWFsIHNlbnNvciB1bml0IChUU1UpIHRoYXQgbWVh
c3VyZXMgdGhlDQo+IHRlbXBlcmF0dXJlIGluc2lkZSB0aGUgTFNJLg0KPiANCj4gVGhlIHRoZXJt
YWwgc2Vuc29yIGluIHRoaXMgdW5pdCBtZWFzdXJlcyB0ZW1wZXJhdHVyZXMgaW4gdGhlIHJhbmdl
IGZyb20NCj4g4oiSNDDCsEMgdG8gMTI1wrBDIHdpdGggYW4gYWNjdXJhY3kgb2YgwrEzwrBDLiBU
aGUgVFNVIHJlcGVhdHMgbWVhc3VyZW1lbnQgYXQNCj4gMjAtwrVzIGludGVydmFscywgYW5kIGF1
dG9tYXRpY2FsbHkgdXBkYXRlcyB0aGUgcmVzdWx0cyBvZiBtZWFzdXJlbWVudC4NCj4gDQo+IFRo
ZSBUU1UgaGFzIG5vIGV4dGVybmFsIHBpbnMgYXMgd2VsbCBhcyBubyBpbnRlcnJ1cHRzLg0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXJpZXMgYWltcyB0byBhZGQgVFNVIGRyaXZlciBzdXBwb3J0IGZvciBS
Wi9HMkwgU29DLg0KPiB2Mi0+djM6DQo+ICAqIEFkZGVkIFJiIHRhZyBmcm9tIFJvYi4NCj4gICog
VXBkYXRlZCBjb21taXQgZGVzY3JpcHRpb24gd2l0aCB0ZWNobmljYWwgZGVzY3JpcHRpb24gb2Yg
dGhlIHNlbnNvcg0KPiAgKiBJbmNsdWRlZCBtYXRoLmggYW5kIHVuaXQuaCBmb3Igcm91bmRfdXAo
KSBhbmQgTUlMTElERUdSRUVfUEVSX0RFR1JFRQ0KPiAgKiBVcGRhdGVkIHRoZSBjb21tZW50cy4N
Cj4gdjEtPnYyOg0KPiAgKiBSZW1vdmVkIGNsayBwYXRjaCBhbmQgZHRzIHB0aGVzIGZyb20gdGhp
cyBzZXJpZXMNCj4gICogUmVtb3ZlZCBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQgZnJvbSBwcm9i
ZS4NCj4gDQo+IEJpanUgRGFzICgyKToNCj4gICBkdC1iaW5kaW5nczogdGhlcm1hbDogRG9jdW1l
bnQgUmVuZXNhcyBSWi9HMkwgVFNVDQo+ICAgdGhlcm1hbC9kcml2ZXJzOiBBZGQgVFNVIGRyaXZl
ciBmb3IgUlovRzJMDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3RoZXJtYWwvcnpnMmwtdGhlcm1hbC55
YW1sICAgICAgIHwgIDc2ICsrKysrKw0KPiAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3RoZXJtYWwvcnpnMmxfdGhlcm1h
bC5jICAgICAgICAgICAgICAgfCAyNDAgKysrKysrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDMyNiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcnpnMmwtDQo+IHRoZXJtYWwueWFtbA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC9yemcybF90aGVybWFsLmMNCj4g
DQo+IC0tDQo+IDIuMTcuMQ0KDQo=
