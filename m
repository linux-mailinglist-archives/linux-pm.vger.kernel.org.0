Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2BDFF9E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 10:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfJVIg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 04:36:59 -0400
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:1664
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731321AbfJVIg6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 04:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyI3KM6T57C76M8GK2rSV5SDRgJrvbxEvNwJPxJoV1UGILMOoJNo8IG0Y0jUVl/NWuaj72/QsWIdrKQIOazk/tQvRFJFsL5XO2It8Nj3zISbtJ0Coh9ZjtWcdmLtMKGkkEnsr8WtFWRVvNrr1k45GWXkCI+IyGIjHL1SYa6we3AsCv8/0X2nF/oxYAhvXmcnsCBYfDj8d3RMa39Of+3j2OLN9fHxd7Ie0jW1y+z3GQAvPzJt39mmlXYkY83M70xPYNMC0e8l+f990mVAwvv29v9QzaWwpCh6L6MC4sAwMB416IFX0x8xiEk3KyaZTl5psITxCknPpw1n0Iyi3BVC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stwmg0OizPp2+nyPdC+KT02MhX3t+bf4yKUhEqNkjgE=;
 b=d3U2y3CMLS8LWAm6EjdIknPeKLmpDAh6hhdkILX/KaQ46yedVph201nAFlEktjKNB8lYMV3XJ1qU7egciYWY1wBbMqU1c34ej7mUVg7158+WPllj4vlSZKFquqBt7CdA2l0SdeBWaHPA031/ov/w6o/9B+hjuYDBPbJer1DyCB+lcxsr6u3mdxB7YwS/g8yXePWGmUXOht4lSHM/gvU1mwEMn5VPmMGAB5/jXREKwhb46zyTxCzwr85oLLSJDKyUIgPy3slbElKPwpHjTvkW9ftucrEu/AYjCulaTPnUB73W+mjvx/qqUbxzJmDAREhpPfcTSPE6CFGBtEndXDPolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stwmg0OizPp2+nyPdC+KT02MhX3t+bf4yKUhEqNkjgE=;
 b=K1drMWADM3OgjX497twXlKim3NGToOdVKd9SUijgDseDXIURTUS3KDdvY0dpyN9vByAtVSHq7sv9WD0Sxs/dhhzOFJgvJms2TWJWbYct3QP8G+GhvVMfT9ZjtcfHAIgDEyOUEkKK0CdGIJvM0GmaTTJS+VKjRbvJRSXjA6JkX4s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 22 Oct 2019 08:36:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 08:36:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed
 grade value
Thread-Topic: [PATCH] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed
 grade value
Thread-Index: AQHViJMjrjphINO/nEKP49CFCN+2HqdmUvUAgAADUQA=
Date:   Tue, 22 Oct 2019 08:36:52 +0000
Message-ID: <DB3PR0402MB391687A3723E810119A58866F5680@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1571719179-23316-1-git-send-email-Anson.Huang@nxp.com>
 <20191022082400.7dsoo57mt7wfpqs7@vireshk-i7>
In-Reply-To: <20191022082400.7dsoo57mt7wfpqs7@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea30b8a5-e85e-496b-6fee-08d756cafd4d
x-ms-traffictypediagnostic: DB3PR0402MB3658:|DB3PR0402MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB365839A73F4318F9BB88A617F5680@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(6436002)(11346002)(64756008)(446003)(76176011)(6116002)(3846002)(6246003)(99286004)(476003)(44832011)(66946007)(76116006)(486006)(52536014)(66476007)(66066001)(66556008)(9686003)(26005)(102836004)(7696005)(86362001)(186003)(55016002)(6506007)(53546011)(66446008)(5660300002)(256004)(316002)(81156014)(8676002)(8936002)(54906003)(7736002)(305945005)(74316002)(14454004)(229853002)(4326008)(25786009)(81166006)(6916009)(33656002)(71190400001)(71200400001)(478600001)(2906002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7SDN1dgh/gcYXrSf8TK1Hl8XrR6d0/K97Ci3iaxBn85oSvibrdM/IBP8uvm+hzqtkFbtDR0GHjyC4wuErKe/8bWsdT0vGsO0jXkOjD/T04vFeCB3oNCxSRo+H92eHroCgGeChS8sMlC8apMVyM7r36iFa2lR6Eg1Qs4gP1VimX/N2W1KYxLItnZhAE9J//+fW7wWhevxDrZED3rNvC/30Nmh2sFNgUnL9N/ITcoG5/c2MNGe8rZRyV/PdRVQ46eEgRdJDODKv+dEgQN/32k+7N/7KLAkXbBiIfy737gV6MIRbyho3S6pP98SAEkMl8YYwF3fN9egrd53tI8R/z68WrdBS2GaCjKIhi/CywcZ/oaNb63Q1HMjOUul5BGp9Q/KCM9WzrQYiJgDfLq1qlS0GaZXVe6UstOWbXn1JzeQgQFn0CXNAAW4A39aJwZuyIq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea30b8a5-e85e-496b-6fee-08d756cafd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 08:36:52.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBy6pLcwIHG5tXBq9V9pWxbhx7vsJB9A/e10S18YWXHBxEQMsebZiWFrB639y06Did7VF0taAi0gbolN4I5S6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDIyLTEwLTE5LCAxMjozOSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gaS5NWDhNTiBoYXMgZGlmZmVyZW50IHNwZWVkIGdyYWRlIGRlZmluaXRpb24gY29tcGFyZWQg
dG8NCj4gPiBpLk1YOE1RL2kuTVg4TU0sIHdoZW4gZnVzZXMgYXJlIE5PVCB3cml0dGVuLCB0aGUg
ZGVmYXVsdCBzcGVlZF9ncmFkZQ0KPiA+IHNob3VsZCBiZSBzZXQgdG8gbWluaW11bSBhdmFpbGFi
bGUgT1BQIGRlZmluZWQgaW4gRFQgd2hpY2ggaXMgMS4yR0h6LA0KPiA+IHRoZSBjb3JyZXNwb25k
aW5nIHNwZWVkX2dyYWRlIHZhbHVlIHNob3VsZCBiZSAweGIuDQo+ID4NCj4gPiBGaXhlczogNWI4
MDEwYmE3MGQ1ICgiY3B1ZnJlcTogaW14LWNwdWZyZXEtZHQ6IEFkZCBpLk1YOE1OIHN1cHBvcnQi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQuYyB8IDIwICsrKysr
KysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvaW14
LWNwdWZyZXEtZHQuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2lteC1jcHVmcmVxLWR0LmMNCj4g
PiBpbmRleCAzNWRiMTRjLi4yNjUzMWYwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9pbXgtY3B1ZnJlcS1kdC5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2lteC1jcHVmcmVx
LWR0LmMNCj4gPiBAQCAtNDQsMTkgKzQ0LDE5IEBAIHN0YXRpYyBpbnQgaW14X2NwdWZyZXFfZHRf
cHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCW1rdF9zZWdtZW50
ID0gKGNlbGxfdmFsdWUgJiBPQ09UUF9DRkczX01LVF9TRUdNRU5UX01BU0spID4+DQo+ID4gT0NP
VFBfQ0ZHM19NS1RfU0VHTUVOVF9TSElGVDsNCj4gPg0KPiA+ICAJLyoNCj4gPiAtCSAqIEVhcmx5
IHNhbXBsZXMgd2l0aG91dCBmdXNlcyB3cml0dGVuIHJlcG9ydCAiMCAwIiB3aGljaCBtZWFucw0K
PiA+IC0JICogY29uc3VtZXIgc2VnbWVudCBhbmQgbWluaW11bSBzcGVlZCBncmFkaW5nLg0KPiA+
IC0JICoNCj4gPiAtCSAqIEFjY29yZGluZyB0byBkYXRhc2hlZXQgbWluaW11bSBzcGVlZCBncmFk
aW5nIGlzIG5vdCBzdXBwb3J0ZWQNCj4gZm9yDQo+ID4gLQkgKiBjb25zdW1lciBwYXJ0cyBzbyBj
bGFtcCB0byAxIHRvIGF2b2lkIHdhcm5pbmcgZm9yICJubyBPUFBzIg0KPiA+ICsJICogRWFybHkg
c2FtcGxlcyB3aXRob3V0IGZ1c2VzIHdyaXR0ZW4gcmVwb3J0ICIwIDAiIHdoaWNoIG1heSBOT1QN
Cj4gPiArCSAqIG1hdGNoIGFueSBPUFAgZGVmaW5lZCBpbiBEVC4gU28gY2xhbXAgdG8gbWluaW11
bSBPUFAgZGVmaW5lZA0KPiBpbg0KPiA+ICsJICogRFQgdG8gYXZvaWQgd2FybmluZyBmb3IgIm5v
IE9QUHMiLg0KPiA+ICAJICoNCj4gPiAgCSAqIEFwcGxpZXMgdG8gaS5NWDhNIHNlcmllcyBTb0Nz
Lg0KPiA+ICAJICovDQo+ID4gLQlpZiAobWt0X3NlZ21lbnQgPT0gMCAmJiBzcGVlZF9ncmFkZSA9
PSAwICYmICgNCj4gPiAtCQkJb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1tIikg
fHwNCj4gPiAtCQkJb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1uIikgfHwNCj4g
PiAtCQkJb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1xIikpKQ0KPiA+IC0JCXNw
ZWVkX2dyYWRlID0gMTsNCj4gPiArCWlmIChta3Rfc2VnbWVudCA9PSAwICYmIHNwZWVkX2dyYWRl
ID09IDApIHsNCj4gPiArCQlpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1t
IikgfHwNCj4gPiArCQkJb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1xIikpDQo+
IA0KPiBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUgc2hvdWxkIGNvbWUgcmlnaHQgYmVsb3cgdGhl
IGFib3ZlDQo+IG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSBoZXJlLCBpbnN0ZWFkIG9mIGEgbGVh
ZGluZyB0YWIuDQoNCkFoLCB5ZXMsIGZpeGVkIGluIFYyLg0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
