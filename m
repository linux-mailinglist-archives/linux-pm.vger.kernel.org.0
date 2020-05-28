Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A41E632E
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbgE1ODz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 10:03:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51528 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgE1ODy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 10:03:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SE3qOZ053937;
        Thu, 28 May 2020 09:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590674632;
        bh=j+jYUA7ka/3qyjpxH/nDKvWzSCPoUhZ1c6rVQDSScB8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=csRnMECVMfu7GrC4mbKtruH14oxp2yNBYNcPrRN9+BuAwBnO+yK+uSKajHV0I3v+2
         TnXbSyPvwExCPBGUtXdRcbpTJVQYO9GQCApPTB5G4NKeH/14JoNPVWdEbFBUIBOiYH
         Y4eIaHGOCxT3unsxGHv92wyMg91NJy6f6cr/6KJs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SE3q8T078279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 09:03:52 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 09:03:52 -0500
Received: from DFLE110.ent.ti.com ([fe80::c545:bde0:ab70:bae9]) by
 DFLE110.ent.ti.com ([fe80::c545:bde0:ab70:bae9%19]) with mapi id
 15.01.1979.003; Thu, 28 May 2020 09:03:51 -0500
From:   "Rivera-Matos, Ricardo" <r-rivera-matos@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Murphy, Dan" <dmurphy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sspatil@android.com" <sspatil@android.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Davis, Andrew" <afd@ti.com>, "sre@kernel.org" <sre@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v10 3/4] dt-bindings: power: Add the
 bindings for the bq2515x family of chargers.
Thread-Topic: [EXTERNAL] Re: [PATCH v10 3/4] dt-bindings: power: Add the
 bindings for the bq2515x family of chargers.
Thread-Index: AQHWNH0upizOK6Pkw0S1By7U4xiB96i92X4A//+vKWU=
Date:   Thu, 28 May 2020 14:03:51 +0000
Message-ID: <5936FE36-AF55-41EF-80DA-786A4111BAF2@ti.com>
References: <20200527231743.18066-1-r-rivera-matos@ti.com>
 <20200527231743.18066-4-r-rivera-matos@ti.com>,<20200528135312.GA4156923@bogus>
In-Reply-To: <20200528135312.GA4156923@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gT24gTWF5IDI4LCAyMDIwLCBhdCAwODo1MywgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIDI3IE1heSAyMDIwIDE4OjE3OjQyIC0wNTAw
LCBSaWNhcmRvIFJpdmVyYS1NYXRvcyB3cm90ZToNCj4+IFRoZSBCUTI1MTVYIGZhbWlseSBvZiBk
ZXZpY2VzIGFyZSBoaWdobHkgaW50ZWdyYXRlZCBiYXR0ZXJ5IG1hbmFnZW1lbnQNCj4+IElDcyB0
aGF0IGludGVncmF0ZSB0aGUgbW9zdCBjb21tb24gZnVuY3Rpb25zIGZvciB3ZWFyYWJsZSBkZXZp
Y2VzDQo+PiBuYW1lbHkgYSBjaGFyZ2VyLCBhbiBvdXRwdXQgdm9sdGFnZSByYWlsLCBBREMgZm9y
IGJhdHRlcnkgYW5kIHN5c3RlbQ0KPj4gbW9uaXRvcmluZywgYW5kIGEgcHVzaC1idXR0b24gY29u
dHJvbGxlci4NCj4+IA0KPj4gRGF0YXNoZWV0czoNCj4+IGh0dHA6Ly93d3cudGkuY29tL2xpdC9k
cy9zeW1saW5rL2JxMjUxNTAucGRmDQo+PiBodHRwOi8vd3d3LnRpLmNvbS9saXQvZHMvc3ltbGlu
ay9icTI1MTU1LnBkZg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpdmVyYS1NYXRv
cyA8ci1yaXZlcmEtbWF0b3NAdGkuY29tPg0KPj4gLS0tDQo+PiAuLi4vYmluZGluZ3MvcG93ZXIv
c3VwcGx5L2JxMjUxNXgueWFtbCAgICAgICAgfCA5MSArKysrKysrKysrKysrKysrKysrDQo+PiAx
IGZpbGUgY2hhbmdlZCwgOTEgaW5zZXJ0aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvYnEyNTE1eC55YW1s
DQo+PiANCj4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmlu
ZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51
eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBs
eS9icTI1MTV4LmV4YW1wbGUuZHQueWFtbDogY2hhcmdlckA2YjogJ2xvdy1wb3dlci1ncGlvcycg
ZG9lcyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVzOiAncGluY3RybC1bMC05XSsnDQo+IA0K
PiBTZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMjk5MjYxDQo+IA0KPiBJ
ZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUg
dGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSBkdC1zY2hlbWEgaXMgdXAgdG8g
ZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBnaXQraHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRy
ZWUtb3JnL2R0LXNjaGVtYS5naXRAbWFzdGVyIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNr
IGFuZCByZS1zdWJtaXQuDQpBQ0sNCj4gDQo=
