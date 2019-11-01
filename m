Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76250EC40E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfKANwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:52:14 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45926 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfKANwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:52:14 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA1DlJRj003539;
        Fri, 1 Nov 2019 09:52:05 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwh5skcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 09:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STvhtj1yIxU+ZbDDhaOKx65l+J6u1ngbFTEUI1Kj712E3vvakAN+v1eiwoWdrM/141GHH/a0mnkQzf04135nCoVD0LmrCGDjTm2EePaOPRBpUQdZmGJ7EtUKGPYGsbsHtNQa7pVJI1MA1hKXqYWyUBZvZ7TG0uzKiwWA0L5rJcDTbBsOzm85AB54MT9vftAKl2Gh23un87wcdEX6ff/jQOsUlFlBMtKf+M3X7Y59XyyjCoTH8xFBjxC06Dmw31y+ySo5mcYzkr8RQ9x2bHV4d9Sa11CM7r/p2iwWrnMI6eswqmtIAS5b+0FKG6XZZLBaTrSkxEUNCPePqAudVNJC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqjz81NXufaxJxlsDBH2S3peDBDPDjFRdOS3RRvpoZo=;
 b=Kg3rocGBXM0NdcRSwfSOyOTaouw9j7mcE9Oz96UcE066XjTmLZBK3lJPfG1bJSqrExKtVOq92kVvl5WsMgozZ/1qAjB4JUkDQEVGqg9HIhsqQl/GeykrPPswBdPC24XLN4nxv3ZPfi5bzKUKwnW70wVLyo/90wshuv751K7WKJdYsbKBMufZfHO3T3f44wCBm7kn2b4YZJ5WasvxRoVD6mHtVwKVjjMqwo2l7Dp3s6JSMBW6Fk2ugTQD1A77/75o50uvUquE4zrKGvOAWNMarvDQqyoXk5uHfZcmYgRUccp6c1kBbCxArKFuJ9Xem2jM8ziz5hudELZNV5naeGeecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqjz81NXufaxJxlsDBH2S3peDBDPDjFRdOS3RRvpoZo=;
 b=DMm3DVUy6sLCENerqKFtdhfLyL+RMEbusTcnCIeDuc5N4Y0SxSCLupQ0fdZVpuVSdBM+OorLtGhKV4l+vm6BB+k0E4G7duVBKZtPTZOulejsc7wacF4IPgTYolWD3dfjKdt0kcFxhBVNi1VQ4NG21sIwlQOokYanTggoTpo5rsw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5208.namprd03.prod.outlook.com (20.180.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 13:52:02 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 13:52:02 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3][RESEND] adp5061: Add support for battery charging
 enable
Thread-Topic: [PATCH v3][RESEND] adp5061: Add support for battery charging
 enable
Thread-Index: AQHVgCKU61ApHx17CkqcGfq0pqtOsadZNqcAgB1AJYA=
Date:   Fri, 1 Nov 2019 13:52:02 +0000
Message-ID: <0676d4f49624a60a6cb596eea8e9962b3dce531c.camel@analog.com>
References: <20191011105649.22357-1-alexandru.ardelean@analog.com>
         <201910140646.Ch4WbSsG%lkp@intel.com>
In-Reply-To: <201910140646.Ch4WbSsG%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5f3da06-8e93-49bd-6d97-08d75ed2ac7d
x-ms-traffictypediagnostic: CH2PR03MB5208:
x-ms-exchange-purlcount: 5
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB52083931EACB329182607FC1F9620@CH2PR03MB5208.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(99286004)(4326008)(316002)(2501003)(2616005)(5640700003)(6306002)(2906002)(476003)(966005)(229853002)(6512007)(3846002)(66946007)(14454004)(25786009)(36756003)(66446008)(54906003)(66066001)(66476007)(66556008)(64756008)(6116002)(1730700003)(486006)(11346002)(446003)(118296001)(76116006)(4001150100001)(81156014)(186003)(6916009)(76176011)(305945005)(7736002)(26005)(6506007)(5660300002)(86362001)(102836004)(81166006)(6436002)(6246003)(6486002)(478600001)(71200400001)(71190400001)(256004)(8676002)(2351001)(5024004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5208;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vHLYCYb0LBShElxCXw/oL9LySoE5jTdZ30kH68vSPWd++X0vBCyMhyQ9GlTaQdXBlmZT5LP5QUcLFSODCgrBxI0WbDvcy0Vjao6P3YxaOuQ3tYZL7gVVUMxp7bRhS2sSMAFvRfZkO1dOeQkZNrZVKxtXAWun+dlrgsl+FN6CBM30Fazgqf9NmlRppdbp1KMkwfUWMGtCuLXR+iZ+pfOaE/jtcZJgCWvPd8DpMSbVQCfFiE7mlZsoh8q+P+B3M0IkUNZ3vc1Jh62gtISZ8ps0KuOO0CLy8R/EqY3iYIp/30gH/Jc7UHlenUWI5LPi7phSlQKtRLlZmnqOwivKJE62AwmOrIKxAWMQk7HqJoTco1J689OUlhMTF/U1EGgvppGwSKJU4/hclRqBE7Ibc9FUI3A/XLJPkrOW+u7PlRolw4lTdYlM3prVgQjGgaD6kIH+ki95kdvWWNI+6rjHxKYoz1NznFkdXyvr+gbeU5H1jo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5B196BCB609AD4EB79B982A28BC9585@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f3da06-8e93-49bd-6d97-08d75ed2ac7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:52:02.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4k0//tByBzfKuKSulQ3EMCk7DnzjdZFDguRWPKY9YpVmgBdItMKUlyyGohLb5nA931gCxuCS9THonawn5AAXxojo0Z4YG872zCIf379e4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5208
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_05:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE5LTEwLTE0IGF0IDA3OjEwICswODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90
ZToNCj4gW0V4dGVybmFsXQ0KPiANCj4gSGkgQWxleGFuZHJ1LA0KPiANCg0KUGhldy4NCk15IGJh
ZCBoZXJlLg0KRWl0aGVyIEkgaGF2ZSBiYXNlZCBpdCBhbiBvbGRlciB0cmVlIHByb2JhYmx5LCBv
ciB0aGUgQVJNIGNvbXBpbGVycyBkaWQgbm90DQpjYXRjaCB0aGlzLg0KVGhlIHg4Nl82NCBjb21w
aWxlciBzZWVtcyBwcmV0dHkgbml0cGljay15IFt3aGljaCBpcyBnb29kWy4NCldpbGwgZml4Lg0K
DQoNCj4gSSBsb3ZlIHlvdXIgcGF0Y2ghIFlldCBzb21ldGhpbmcgdG8gaW1wcm92ZToNCj4gDQo+
IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gcG93ZXItc3VwcGx5L2Zvci1uZXh0XQ0KPiBbY2Fu
bm90IGFwcGx5IHRvIHY1LjQtcmMyIG5leHQtMjAxOTEwMTFdDQo+IFtpZiB5b3VyIHBhdGNoIGlz
IGFwcGxpZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBwbGVhc2UgZHJvcCB1cyBhIG5vdGUgdG8N
Cj4gaGVscA0KPiBpbXByb3ZlIHRoZSBzeXN0ZW0uIEJUVywgd2UgYWxzbyBzdWdnZXN0IHRvIHVz
ZSAnLS1iYXNlJyBvcHRpb24gdG8NCj4gc3BlY2lmeSB0aGUNCj4gYmFzZSB0cmVlIGluIGdpdCBm
b3JtYXQtcGF0Y2gsIHBsZWFzZSBzZWUgDQo+IGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vYS8z
NzQwNjk4Ml0NCj4gDQo+IHVybDogICAgDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS8wZGF5LWNpL2xp
bnV4L2NvbW1pdHMvQWxleGFuZHJ1LUFyZGVsZWFuL2FkcDUwNjEtQWRkLXN1cHBvcnQtZm9yLWJh
dHRlcnktY2hhcmdpbmctZW5hYmxlLzIwMTkxMDE0LTAzNTQ1Ng0KPiBiYXNlOiAgIA0KPiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zcmUvbGludXgtcG93
ZXItc3VwcGx5LmdpdA0KPiBmb3ItbmV4dA0KPiBjb25maWc6IHNwYXJjNjQtYWxsbW9kY29uZmln
IChhdHRhY2hlZCBhcyAuY29uZmlnKQ0KPiBjb21waWxlcjogc3BhcmM2NC1saW51eC1nY2MgKEdD
QykgNy40LjANCj4gcmVwcm9kdWNlOg0KPiAgICAgICAgIHdnZXQgDQo+IGh0dHBzOi8vcmF3Lmdp
dGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtdGVzdHMvbWFzdGVyL3NiaW4vbWFrZS5jcm9z
cw0KPiAtTyB+L2Jpbi9tYWtlLmNyb3NzDQo+ICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5j
cm9zcw0KPiAgICAgICAgICMgc2F2ZSB0aGUgYXR0YWNoZWQgLmNvbmZpZyB0byBsaW51eCBidWls
ZCB0cmVlDQo+ICAgICAgICAgR0NDX1ZFUlNJT049Ny40LjAgbWFrZS5jcm9zcyBBUkNIPXNwYXJj
NjQgDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
DQo+IFJlcG9ydGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+
IEFsbCBlcnJvci93YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiANCj4gICAg
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgva29iamVjdC5oOjIwOjAsDQo+ICAg
ICAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L21vZHVsZS5oOjE3LA0KPiAgICAg
ICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9wb3dlci9zdXBwbHkvYWRwNTA2MS5jOjk6DQo+
ID4gPiBkcml2ZXJzL3Bvd2VyL3N1cHBseS9hZHA1MDYxLmM6NzM4OjQ0OiBlcnJvcjogaW5pdGlh
bGl6YXRpb24gZnJvbQ0KPiA+ID4gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1p
bmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10NCj4gICAgIHN0YXRpYyBERVZJQ0VfQVRUUihjaGFy
Z2luZ19lbmFibGVkLCAwNjQ0LA0KPiBhZHA1MDYxX2dldF9jaGFyZ2luZ19lbmFibGVkLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gICAgaW5j
bHVkZS9saW51eC9zeXNmcy5oOjEwNDoxMDogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAn
X19BVFRSJw0KPiAgICAgIC5zaG93ID0gX3Nob3csICAgICAgXA0KPiAgICAgICAgICAgICAgXn5+
fn4NCj4gPiA+IGRyaXZlcnMvcG93ZXIvc3VwcGx5L2FkcDUwNjEuYzo3Mzg6ODogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvDQo+ID4gPiAnREVWSUNFX0FUVFInDQo+ICAgICBzdGF0aWMgREVW
SUNFX0FUVFIoY2hhcmdpbmdfZW5hYmxlZCwgMDY0NCwNCj4gYWRwNTA2MV9nZXRfY2hhcmdpbmdf
ZW5hYmxlZCwNCj4gICAgICAgICAgICBefn5+fn5+fn5+fg0KPiAgICBkcml2ZXJzL3Bvd2VyL3N1
cHBseS9hZHA1MDYxLmM6NzM4OjQ0OiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3INCj4g
J2Rldl9hdHRyX2NoYXJnaW5nX2VuYWJsZWQuc2hvdycpDQo+ICAgICBzdGF0aWMgREVWSUNFX0FU
VFIoY2hhcmdpbmdfZW5hYmxlZCwgMDY0NCwNCj4gYWRwNTA2MV9nZXRfY2hhcmdpbmdfZW5hYmxl
ZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
ICAgIGluY2x1ZGUvbGludXgvc3lzZnMuaDoxMDQ6MTA6IG5vdGU6IGluIGRlZmluaXRpb24gb2Yg
bWFjcm8gJ19fQVRUUicNCj4gICAgICAuc2hvdyA9IF9zaG93LCAgICAgIFwNCj4gICAgICAgICAg
ICAgIF5+fn5+DQo+ID4gPiBkcml2ZXJzL3Bvd2VyL3N1cHBseS9hZHA1MDYxLmM6NzM4Ojg6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0KPiA+ID4gJ0RFVklDRV9BVFRSJw0KPiAgICAgc3Rh
dGljIERFVklDRV9BVFRSKGNoYXJnaW5nX2VuYWJsZWQsIDA2NDQsDQo+IGFkcDUwNjFfZ2V0X2No
YXJnaW5nX2VuYWJsZWQsDQo+ICAgICAgICAgICAgXn5+fn5+fn5+fn4NCj4gICAgZHJpdmVycy9w
b3dlci9zdXBwbHkvYWRwNTA2MS5jOjczOTo2OiBlcnJvcjogaW5pdGlhbGl6YXRpb24gZnJvbQ0K
PiBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVy
LXR5cGVzXQ0KPiAgICAgICAgICBhZHA1MDYxX3NldF9jaGFyZ2luZ19lbmFibGVkKTsNCj4gICAg
ICAgICAgXg0KPiAgICBpbmNsdWRlL2xpbnV4L3N5c2ZzLmg6MTA1OjExOiBub3RlOiBpbiBkZWZp
bml0aW9uIG9mIG1hY3JvICdfX0FUVFInDQo+ICAgICAgLnN0b3JlID0gX3N0b3JlLCAgICAgIFwN
Cj4gICAgICAgICAgICAgICBefn5+fn4NCj4gPiA+IGRyaXZlcnMvcG93ZXIvc3VwcGx5L2FkcDUw
NjEuYzo3Mzg6ODogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvDQo+ID4gPiAnREVWSUNFX0FU
VFInDQo+ICAgICBzdGF0aWMgREVWSUNFX0FUVFIoY2hhcmdpbmdfZW5hYmxlZCwgMDY0NCwNCj4g
YWRwNTA2MV9nZXRfY2hhcmdpbmdfZW5hYmxlZCwNCj4gICAgICAgICAgICBefn5+fn5+fn5+fg0K
PiAgICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9hZHA1MDYxLmM6NzM5OjY6IG5vdGU6IChuZWFyIGlu
aXRpYWxpemF0aW9uIGZvcg0KPiAnZGV2X2F0dHJfY2hhcmdpbmdfZW5hYmxlZC5zdG9yZScpDQo+
ICAgICAgICAgIGFkcDUwNjFfc2V0X2NoYXJnaW5nX2VuYWJsZWQpOw0KPiAgICAgICAgICBeDQo+
ICAgIGluY2x1ZGUvbGludXgvc3lzZnMuaDoxMDU6MTE6IG5vdGU6IGluIGRlZmluaXRpb24gb2Yg
bWFjcm8gJ19fQVRUUicNCj4gICAgICAuc3RvcmUgPSBfc3RvcmUsICAgICAgXA0KPiAgICAgICAg
ICAgICAgIF5+fn5+fg0KPiA+ID4gZHJpdmVycy9wb3dlci9zdXBwbHkvYWRwNTA2MS5jOjczODo4
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4gPiA+ICdERVZJQ0VfQVRUUicNCj4gICAg
IHN0YXRpYyBERVZJQ0VfQVRUUihjaGFyZ2luZ19lbmFibGVkLCAwNjQ0LA0KPiBhZHA1MDYxX2dl
dF9jaGFyZ2luZ19lbmFibGVkLA0KPiAgICAgICAgICAgIF5+fn5+fn5+fn5+DQo+ICAgIGNjMTog
c29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiANCj4gdmltICs3MzggZHJp
dmVycy9wb3dlci9zdXBwbHkvYWRwNTA2MS5jDQo+IA0KPiAgICA3MzcJDQo+ICA+IDczOAlzdGF0
aWMgREVWSUNFX0FUVFIoY2hhcmdpbmdfZW5hYmxlZCwgMDY0NCwNCj4gYWRwNTA2MV9nZXRfY2hh
cmdpbmdfZW5hYmxlZCwNCj4gICAgNzM5CQkJICAgYWRwNTA2MV9zZXRfY2hhcmdpbmdfZW5hYmxl
ZCk7DQo+ICAgIDc0MAkNCj4gDQo+IC0tLQ0KPiAwLURBWSBrZXJuZWwgdGVzdCBpbmZyYXN0cnVj
dHVyZSAgICAgICAgICAgICAgICBPcGVuIFNvdXJjZSBUZWNobm9sb2d5DQo+IENlbnRlcg0KPiBo
dHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwva2J1aWxkLWFsbCAgICAgICAgICAgICAgICAg
ICBJbnRlbA0KPiBDb3Jwb3JhdGlvbg0K
