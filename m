Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C883457A2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 07:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCWGLg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 02:11:36 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:7136
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhCWGLd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 02:11:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzK6Qrf/xDz667OZYesuYuJBBtRkp8Cnn/2fHmFmeMzUaFNqvUM+O9fUqNGWzPeUBWB+LibCewNJZPe6Zu56HOx+BCxTcJXZSrobcahVm5U4TD2F3SkWsmJH6kytMpi4hy6oy/nh/K4amXWqAdWRj3dmT3jcM0askgEESrcUDS/prpcc1hSLUpxVOEsqgJ9kA0DkVNmhbDt4szRgz93yUyA+y1rzlbf0V71LH7APBCFgFtWQ7VYRKjWbj7PNw6MeYkz2dMJlYxNvx16MdArEquOB4MqJ0yKgggFrZrdmEkDyfB4dQPHvj2srB5m/7B0x28U4AtWmGk9BaHlmpXQnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w0v8OPyZ/fRSHHEpIuTsEhyq9cnPeeCl4VMINWTAho=;
 b=M9oQ1ap3+FRDwhMQA2j+h0l6+s0YzArS0yol18c6obpnhzUf1HjqDNktfb1sr4OGmnk7cGWnWS4cqR3Hr4WNGd2Z7alB62UXJ1ND7xDStzGgVsDdh1xr06mR7MOHwFgvGZoBSIrWL8IlDVFLlDW+XcxkusTMuyFljgjnHtEM0RdmNOc4K4OzADnvEtBSmi52X11+NDF9kGhgbEcyoo8wSuzkbGeHS6n50TcC6Wxrp/YI9LL7WMsYEvo5Xkx0zgN0Q6i6QneIE63LvTp46DXJDY5lFrJpzCrX6l36VQ9py70ig4hqO/BNk37LH38dP4al8WWcSJ+cwQzvBwMoVHkEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w0v8OPyZ/fRSHHEpIuTsEhyq9cnPeeCl4VMINWTAho=;
 b=QFTTuheKAOqpagYmTneDo2tgdW3bla6gUCKDm5KFUUJbUgc6LmtGXJh3QLKrfdOiSjivxuq51AfZExOkuCFuYh8cTcaL9PgrzU2fonVyE0ybIWx0yUpZpzrXq2SuWRY03iIpYXWiG5ZDnHClFjQVWeERul+SKvcPqwjltlqG29k=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB8021.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 06:11:29 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 06:11:29 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
Thread-Topic: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
Thread-Index: AQHXH5JvbX3grE6Bo0WUL/BHYgW7IqqQ6RuAgAAM1wCAAB9NAA==
Date:   Tue, 23 Mar 2021 06:11:29 +0000
Message-ID: <AM6PR04MB4966CC15309EA6F0D78EC6BB80649@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
        <CGME20210323032617epcas1p162bd7e8bff584af99b6065a2f7c13325@epcas1p1.samsung.com>
        <CAA+hA=Sb+eXqaVFKtSgzM6RsnwufqEHcKrbnD_rmnDW3-qGJSQ@mail.gmail.com>
 <ffcd13a3-68cd-9b57-1fae-ac1b6624ddfe@samsung.com>
In-Reply-To: <ffcd13a3-68cd-9b57-1fae-ac1b6624ddfe@samsung.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a81376b8-6bec-4d0b-b1b6-08d8edc27f9e
x-ms-traffictypediagnostic: AS8PR04MB8021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB80216D080B4804185FBEE4AF80649@AS8PR04MB8021.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1ZljVSI8YCUXGtEsmhhDRMaEDoQ65oDGC8m5wFlHGmG2EZB0SyI/asVGxtQeGg2VIRIbQTmOjHMkfn2t/scFn8YlZAmx5KiW1+3f77iD5n8jiHa4xMg21+VP6ohrqhM1k+EoBGQFgBojO17gamnbai7+sc6TOrb6/zCwtT10dDA6ojryFbo4nREuoONDQYqngY/mRU7daoG3F0VAC/wO6gDUEzwFG6bkZp8FHXMAP+ZNnlW+nLF//0x8p/TMn8p7TY+Auzmo1uIqqALtECJoJQ/9Rz5Z79Yn+FHA7j64ItyfHoNakNHCQBrbjnBsh6vO/No5GFeZjLHxLt89Y+qgbDZ82pGXzqY3iElQD3p7mhi23fmxjS1fS37vGpMRK8/fjmkE6WQ2Q8o1/J1tbVdLFYCKtQAZv6QC38Ho2zZNeNYviBDUWOMIzez8Z0mmJpvkxnYnImMTRG/n+JLlfaXUGGeSGBd1e/l69nCqyxggcddyX/4Y9lLsXsV6lHPKxlt6YhiMmjJZ005ASQReI3u/RshCpfTg69+aWa0ZRzAUsy3LUHWzz5t4RwsqgeVwp5p2C3t+PrSwLaIsOyjEib7fzfzZaoRRoIH/f9uu3MZUt1nX5obyVcCXSoYbpzAUQRPzujnpIdbBUaixgQ9bm+KDMn1kOiPuGG6hGdhpvkT1Mz3k0kri3n5SN3psfcCzVbRljcDq/xcsVRlxGxzNks2iUG/oVOQwErxWQ2+UOseS58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(33656002)(5660300002)(6506007)(4326008)(66476007)(66446008)(83380400001)(66556008)(66946007)(9686003)(8936002)(8676002)(7696005)(110136005)(64756008)(54906003)(316002)(53546011)(38100700001)(86362001)(966005)(55016002)(26005)(71200400001)(44832011)(76116006)(478600001)(52536014)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dngxbDF4b2J6bDNoV0lxZ2FYdS85WkpxZWdPczEzRHF4N0FiYXhsL2xkMmUw?=
 =?utf-8?B?VUVGa1g4TmQwdzFUR2JFdkpqNXhuZ3BJSlJrdDNNMXRmdFMzTWVyNUMxaDQx?=
 =?utf-8?B?SmJzUzNSVXk5Qm52aGFSMXVZcEV1djFTb2RJREhwanZBOGhKZStUNnBVc0ZK?=
 =?utf-8?B?WDVnbXYrN1pSVnFVOEMvZGxaRHNNbE9KeXNZWktEOEVmNHZKVzRxTXltT2RP?=
 =?utf-8?B?WnRFVTFFNWRoZVRxdmJzQUVXN1N3UEpuL3NxNGJqVSt1bStkQVFGbmtjSGNn?=
 =?utf-8?B?Q1dZTVN0ckpKWTBMNHduaDkxNzZmaFdBaTFieFE4NWRybWlTa085UndpREl4?=
 =?utf-8?B?bFU5amZkZkR0bFZOR2VuTnFqVWMveHVucVhBWXZLaG40cXJtN3FudjVkd29J?=
 =?utf-8?B?SjZWU1VOWENnQ0ppazBFUEg0bjVqU0hkdlpaQmoxSUNpWjRJaHQyV25oV1Bz?=
 =?utf-8?B?V2dWbnIvcnd1d3pQZ3NTclora3U4NEFZT25ySXpBZ1BRUlgvYUdaZTRSSTJn?=
 =?utf-8?B?RlNsQlhWV1lNMmhHdExQQm41Q2Vpc1FaaUJhL2NSYlZNUkd0c29SUG52QXdC?=
 =?utf-8?B?dWJ6ZW5QN1VCM1Z4SXRqcnhIRkdBRmlBdklxdGhnVk1Ta3pKV1huZngxNTBY?=
 =?utf-8?B?Vjd4ZktIeklqdGRXOW1ERWdrUHhhM05XYm0xbVo5Z2R3TDBNRHBPNmIvdnBM?=
 =?utf-8?B?TWVKU0hzUkpHbnU0TmlrdGFOSGVvbFVJK0FnQ2lxcWRVWUlEUUFNVlJXNVR1?=
 =?utf-8?B?UENBSTFweHdXTCtpSm50b2J5V1MzY2FGbUlKcUhzbmdpV1U4NFlQVTVEbVdo?=
 =?utf-8?B?L2VpaUlpcXp0b285azcvaTVUZENmU2FDSElLZCtNN292OUJRTmdwdXRvRFhk?=
 =?utf-8?B?dC9qTjNwRGtmdFpXdkpTZDhscmJLQkRtMHV0bnZ5TE9EYWxYV3FBTnBrZlMv?=
 =?utf-8?B?S3lOdi90RTJvOXE5SGo0WmFhZlordWp6SXcxdnJoK2htL3NBOVRma3NhYjdp?=
 =?utf-8?B?QkFVS1ZBOVZ4WXQ3MjYyRTljUzdyelpNLy85WWNaSGdxa3c1QityQTh2bnRD?=
 =?utf-8?B?dStZZzdWejlXcCtYczQ1aUppTmZiVUlwWEdVeEUvUERkUWYyeDdkQVJLVm9J?=
 =?utf-8?B?YmRuYTNJaC9aRi9tdkRIS0s4Nms2NWdzUFhjdXNOempOSFQ2c3NnU01MZnB3?=
 =?utf-8?B?R1RoSFFHR1MzSWVvNDh0b2NZMVh1eks1R0l4REc3MkhFeWlRRDZEckdnMlFE?=
 =?utf-8?B?T2hzNWZRQ0JGNXdSbjJzc3o3Yk8zL0dxMVlneURTOTdZSEJNT01ZU25PS2RF?=
 =?utf-8?B?bzNhemxnQ2ZVcDdtZzNHR0hkU3JVb0ZIKzMwcEx3SHlRNll5KzU2ZHVnSExo?=
 =?utf-8?B?a3NyZGZiU0Q4TGEzb1YvOWJMRlFZT3Z3blBBcXYrUlM5bTlGODcydmVQZ1R1?=
 =?utf-8?B?akF1QTVRR3FtNFF2NTdDWUh0QkFQK2FJVWpMbW5QNDJaOWcvVjRKS1kyWVNV?=
 =?utf-8?B?cDMzUDdJOTVacVJQY08xekdnTDMvRm9OZTg3V05FRkYwTkpJMndjSnVNc0xY?=
 =?utf-8?B?OXZPSFAxQmRZOHJ3NkpVNkl1Yk02eStjbXd1ODA0Vm14S3VzMnY4Tm5kUnds?=
 =?utf-8?B?QVF6Z2JRVEdJSDBqVFNMU2dnSUdjTG9OTC9tak10VTYvV0F0ZE5kVU1qeU44?=
 =?utf-8?B?b2M3K2I2TEZqanM4QUVJMTV0dzlZT3FualplditLNzQ0VkhUNHdFdmdEV1dG?=
 =?utf-8?Q?71KGyxcvzecVIi9ZJpop9asc9jMqX7o/LEEWUdS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81376b8-6bec-4d0b-b1b6-08d8edc27f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 06:11:29.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cTePl9qcRArfdtP/j/Q3xwYqIEYry+CtLqkKGPBjbtjUd4S3KGhdLJtVeDWVfTBoXS+v97NtX++cejGpwsHEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTWFyY2ggMjMsIDIwMjEgMTI6MTEgUE0NCj4gDQo+IEhpLA0KPiANCj4gT24gMy8yMy8y
MSAxMjoyNSBQTSwgRG9uZyBBaXNoZW5nIHdyb3RlOg0KPiA+IEhpIENoYW53b28sDQo+ID4NCj4g
PiBPbiBUdWUsIE1hciAyMywgMjAyMSBhdCAxMToxMyBBTSBEb25nIEFpc2hlbmcgPGFpc2hlbmcu
ZG9uZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gQSBmZXcgc21hbGwgZml4ZXMgYW5k
IGltcHJvdmVtZW50cw0KPiA+Pg0KPiA+PiBDaGFuZ2VMb2c6DQo+ID4+IHYxLT52MjoNCj4gPj4g
ICogc3F1YXNoIGEgZmV3IHBhdGNoZXMNCj4gPj4gICogcmViYXNlIHRvIGRldmZyZXEtdGVzdGlu
Zw0KPiA+DQo+ID4gSSBoYXZlIHRvIHJlYmFzZSB0byBkZXZmcmVxLXRlc3RpbmcgaW5zdGVhZCBv
ZiBkZXZmcmVxLW5leHQgYmVjYXVzZQ0KPiA+IGJlbG93IHR3byBwYXRjaGVzIG9ubHkgZXhpc3Qg
aW4gZGV2ZnJlcS10ZXN0aW5nLg0KPiA+IDVjYzc1ZTkyNTJlOSAoZGV2ZnJlcS9kZXZmcmVxLXRl
c3RpbmcpIFBNIC8gZGV2ZnJlcTogQWRkDQo+ID4gZGV2ZnJlcV90cmFuc2l0aW9ucyBkZWJ1Z2Zz
IGZpbGUNCj4gPiBkYzllNTU3ODQ1YzEgUE0gLyBkZXZmcmVxOiBBZGQgbmV3IHVwX3RocmVzaG9s
ZCBhbmQgZG93bl9kaWZmZXJlbnRpYWwNCj4gPiBzeXNmcyBhdHRycyBNeSBwYXRjaCA1IG5lZWRz
IGNoYW5nZSBiYXNlZCBvbiBpdCBhY2NvcmRpbmcgdG8geW91cg0KPiA+IHN1Z2dlc3Rpb24uIFNv
IGkgaGF2ZSB0byByZWJhc2UgdG8gdGhhdCBicmFuY2guDQo+ID4NCj4gPiBIb3dldmVyLCBpIGZv
dW5kIGRldmZyZXEtdGVzdGluZyBjYW4ndCBidWlsZCB3aXRoIEdPVl9QQVNTVklFIGVuYWJsZWQu
DQo+ID4gUGF0Y2ggMSBmaXhlZCBpdC4gWW91IGNhbiBzcXVhc2ggdG8gdGhlIG9yaWdpbmFsIG9u
ZSB3aGVuIGFwcGx5Lg0KPiA+DQo+ID4gUGxlYXNlIGhlbHAgdGFrZSBhIGxvb2sgYXQgdGhpcyBu
ZXcgc2VyaWVzLg0KPiANCj4gUGxlYXNlIHJlYmFzZSB5b3VyIHBhdGNoZXMgZWl0aGVyIGRldmZy
ZXEtbmV4dCBvciBsaW51eC1uZXh0LmdpdCBCZWNhdXNlDQo+IGRldmZyZXEtdGVzdGluZyBicmFu
Y2ggaXMgbm90IG9mZmljaWFsLg0KDQpPa2F5LCB0aGVuIGhvdyBhYm91dCB0aGUgcGF0Y2ggNSBi
ZWxvdz8NCltQQVRDSCBWMiA1LzZdIFBNIC8gZGV2ZnJlcTogZ292ZXJub3I6IG9wdGltaXplIHNp
bXBsZW9uZGVtYW5kIGdldF90YXJnZXRfZnJlcQ0KDQpTaG91bGQgSSBhbHNvIHJlYmFzZSBpdCB0
byBkZXZmcmVxLW5leHQgb3IgZHJvcCBpdCBmaXJzdCBhbmQgdGhlbiByZXNlbmQgd2hlbiB5b3Vy
IHBhdGNoDQptZXJnZWQgaW50byBtYWlubGluZT8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1hcm0ta2VybmVsL3BhdGNoLzE2MTUyOTQ3MzMtMjI3NjEtMTAtZ2l0
LXNlbmQtZW1haWwtYWlzaGVuZy5kb25nQG54cC5jb20vDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
PiANCj4gPiBUaGFua3MNCj4gPg0KPiA+IFJlZ2FyZHMNCj4gPiBBaXNoZW5nDQo+ID4NCj4gPj4g
ICogZHJvcCB0d28gcGF0Y2hlcyB3aGljaCBhcmUgYWxyZWFkeSBpbiBkZXZmcmVxLW5leHQNCj4g
Pj4NCj4gPj4gRG9uZyBBaXNoZW5nICg2KToNCj4gPj4gICBQTSAvIGRldmZyZXE6IGZpeCBidWls
ZCBlcnJvciB3aGVuIERFVkZSRVFfR09WX1BBU1NJVkUgZW5hYmxlZA0KPiA+PiAgIFBNIC8gZGV2
ZnJlcTogVXNlIG1vcmUgYWNjdXJhdGUgcmV0dXJuZWQgbmV3X2ZyZXEgYXMgcmVzdW1lX2ZyZXEN
Cj4gPj4gICBQTSAvIGRldmZyZXE6IFJlbW92ZSB0aGUgaW52YWxpZCBkZXNjcmlwdGlvbiBmb3Ig
Z2V0X3RhcmdldF9mcmVxDQo+ID4+ICAgUE0gLyBkZXZmcmVxOiBiYWlsIG91dCBlYXJseSBpZiBu
byBmcmVxIGNoYW5nZXMgaW4gZGV2ZnJlcV9zZXRfdGFyZ2V0DQo+ID4+ICAgUE0gLyBkZXZmcmVx
OiBnb3Zlcm5vcjogb3B0aW1pemUgc2ltcGxlb25kZW1hbmQgZ2V0X3RhcmdldF9mcmVxDQo+ID4+
ICAgUE0gLyBkZXZmcmVxOiBpbXg4bS1kZHJjOiByZW1vdmUgaW14OG1fZGRyY19nZXRfZGV2X3N0
YXR1cw0KPiA+Pg0KPiA+PiAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1jbGFzcy1k
ZXZmcmVxIHwgIDUgKy0tDQo+ID4+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jICAgICAgICAg
ICAgICAgICAgICAgfCAzNyArKysrKysrLS0tLS0tLS0tLS0tDQo+ID4+ICBkcml2ZXJzL2RldmZy
ZXEvZ292ZXJub3IuaCAgICAgICAgICAgICAgICAgICAgfCAgMiAtDQo+ID4+ICBkcml2ZXJzL2Rl
dmZyZXEvZ292ZXJub3Jfc2ltcGxlb25kZW1hbmQuYyAgICAgfCAzMSArKysrKysrKysrLS0tLS0t
DQo+ID4+ICBkcml2ZXJzL2RldmZyZXEvaW14OG0tZGRyYy5jICAgICAgICAgICAgICAgICAgfCAx
NCAtLS0tLS0tDQo+ID4+ICA1IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDU0IGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiAyLjI1LjENCj4gPj4NCj4gPg0KPiA+DQo+
IA0KPiANCj4gLS0NCj4gQmVzdCBSZWdhcmRzLA0KPiBDaGFud29vIENob2kNCj4gU2Ftc3VuZyBF
bGVjdHJvbmljcw0K
