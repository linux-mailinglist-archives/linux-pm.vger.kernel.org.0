Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C8D19579
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 00:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIW51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 18:57:27 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:39064 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbfEIW51 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 18:57:27 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49IoNmJ031562;
        Thu, 9 May 2019 14:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=IeTBeHA0uEacTyVgidQx2gnKaUfAsfn3ajxXHNjD6LI=;
 b=oIC450kNQGbt1N2d/p3GCe627mC72lpPI0bVeHN9IDMDEsOVW4zXXrpnuubPiazAPPuP
 cRHWCXoBi6g4nftAFuHnA/yo/4qbsWENlCG5rKdVdEUlL+/s6yOX7GMLgJ8HsjUQ6xhY
 MNuiwNlw4bXZRn4UC+dvTfkV+KZ8b6IYx7MhKxsdqXKaIDn/y+h/fH2HgLm5snALsPo/
 k7MNYiWkiomqJmqlayrl+WM65hhffPtx6mRFXNjyDHOy/vByfwEcnVqzW/DMQ1shByiJ
 WGdGeBaFNQXhxKN0WiirUESx7iKGWvvHSKUdocH31hZAL4Y2o0muyhQhL7Sgn0sd6Km5 eg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2scbpeu3pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 May 2019 14:57:39 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49ImUs3047617;
        Thu, 9 May 2019 14:57:38 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2scp1dc9e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 14:57:38 -0400
X-LoopCount0: from 10.166.132.128
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1233852779"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>, <hch@lst.de>
CC:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <kbusch@kernel.org>, <keith.busch@intel.com>, <axboe@fb.com>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Topic: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Index: AQHVBdBS/xizqbOjGUOY5SKUREVH6KZh7T4AgAAD4gD//6zksIAAWSuA//+yBvCAAPthgIAACiqAgAAmlACAAAnmAIAAA8eAgAAJFgCAAADiAIAAGKaA///lboA=
Date:   Thu, 9 May 2019 18:57:34 +0000
Message-ID: <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
References: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
In-Reply-To: <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=860 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090108
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=921 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090108
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiA+DQo+ID4+PiBPdGhlcndpc2UgSSB0aGluayB3ZSBzaG91bGQgdXNlIGEgIm5vLW9wIiBzdXNw
ZW5kLCBqdXN0IGxlYXZpbmcgdGhlDQo+ID4+PiBwb3dlciBtYW5hZ2VtZW50IHRvIHRoZSBkZXZp
Y2UsIG9yIGEgc2ltcGxlIHNldHRpbmcgdGhlIGRldmljZSB0byB0aGUNCj4gPj4+IGRlZXBlc3Qg
cG93ZXIgc3RhdGUgZm9yIGV2ZXJ5dGhpbmcgZWxzZSwgd2hlcmUgZXZlcnl0aGluZyBlbHNlIGlz
DQo+ID4+PiBzdXNwZW5kLCBvciBzdXNwZW5kIHRvIGlkbGUuDQo+ID4+DQo+ID4+IEkgYW0gbm90
IHN1cmUgSSBnZXQgeW91ciBpZGVhLiBEb2VzIHRoaXMg4oCcbm8tb3DigJ0gc3VzcGVuZCBoYXBw
ZW4gaW4gTlZNZQ0KPiA+PiBkcml2ZXIgb3IgUE0gY29yZT8NCj4gPg0KPiA+IG5vLW9wIG1lYW5z
IHdlIGRvbid0IHdhbnQgdG8gZG8gYW55dGhpbmcgaW4gbnZtZS4gIElmIHRoYXQgaGFwcGVucw0K
PiA+IGJ5IG5vdCBjYWxsaW5nIG52bWUgb3Igc3R1YmJpbmcgb3V0IHRoZSBtZXRob2QgZm9yIHRo
YXQgcGFydGljdWxhcg0KPiA+IGNhc2UgZG9lcyBub3QgbWF0dGVyLg0KPiANCj4gT2ssIGJ1dCB3
ZSBzdGlsbCBuZWVkIHRvIGZpZ3VyZSBvdXQgaG93IHRvIHByZXZlbnQgdGhlIGRldmljZSBkZXZp
Y2UgZnJvbQ0KPiB0cmFkaXRpb24gdG8gRDMuDQoNClRoaXMgc28tY2FsbGVkIG5vLW9wIHdhcyBz
b21ldGhpbmcgdGhhdCB3ZSBoYWQgZXhwZXJpbWVudGVkIHdpdGggd2hpbGUgZGV2ZWxvcGluZw0K
dGhpcyBwYXRjaCwgYnV0IGZvdW5kIHRoYXQgaXQgd291bGQgbm90IGhlbHAgcG93ZXIgY29uc3Vt
cHRpb24gb24gYWxsIGRyaXZlcy4NCg0KVGhhdCdzIHdoeSB3ZSBoYXZlIGV4cGxpY2l0IGNhbGwg
dG8gZ28gaW50byBkZWVwZXN0IHBvd2VyIHN0YXRlIGluIGN1cnJlbnQgcGF0Y2guDQoNCj4gDQo+
ID4NCj4gPj4+IEFuZCBvZiBjb3Vyc2UgdGhhbiB3ZSBoYXZlIHdpbmRvd3MgbW9kZXJuIHN0YW5k
YnkgYWN0dWFsbHkgbWFuZGF0aW5nDQo+ID4+PiBydW50aW1lIEQzIGluIHNvbWUgY2FzZSwgYW5k
IHZhZ3VlIGhhbmR3YXZpbmcgbWVudGlvbnMgb2YgdGhpcyBiZWluZw0KPiA+Pj4gZm9yY2VkIG9u
IHRoZSBwbGF0Zm9ybXMsIHdoaWNoIEknbSBub3QgZW50aXJlbHkgc3VyZSBob3cgdGhleSBmaXQN
Cj4gPj4+IGludG8gdGhlIGFib3ZlIHBpY3R1cmUuDQo+ID4+DQo+ID4+IEkgd2FzIHRvbGQgdGhh
dCBXaW5kb3dzIGRvZXNu4oCZdCB1c2UgcnVudGltZSBEMywgQVBTVCBpcyB1c2VkIGV4Y2x1c2l2
ZWx5Lg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkga25vdyB0aGUgZGVmYXVsdCBwb3dlciBtYW5hZ2Vt
ZW50IG1vZGVzIGluIHRoZSBNaWNyb3NvZnQNCj4gPiBOVk1lIGRyaXZlciBpcyBleHBsaWNpdCBw
b3dlciBtYW5hZ2VtZW50IHRyYW5zaXRpb25zLCBhbmQgaW4gdGhlIEludGVsDQo+ID4gUlNUIGRy
aXZlciB0aGF0IGlzIGNvbW1vbmx5IHVzZWQgaXQgaXMgQVBTVC4gIEJ1dCBib3RoIGNvdWxkIHN0
aWxsDQo+ID4gYmUgY29taW5lZCB3aXRoIHJ1bnRpbWUgRDMgaW4gdGhlb3J5LCBJJ20ganVzdCBu
b3Qgc3VyZSBpZiB0aGV5IGFyZS4NCj4gPg0KPiA+IE1pY3Jvc29mdCBoYXMgYmVlbiBwdXNoaW5n
IGZvciBhZ2dyZXNzaXZlIHJ1bnRpbWUgRDMgZm9yIGEgd2hpbGUsIGJ1dA0KPiA+IEkgZG9uJ3Qg
a25vdyBpZiB0aGF0IGluY2x1ZGVzIE5WTWUgZGV2aWNlcy4NCj4gDQo+IE9rLCBJ4oCZbGwgY2hl
Y2sgd2l0aCB2ZW5kb3JzIGFib3V0IHRoaXMuDQo+IA0KDQpObywgY3VycmVudCBXaW5kb3dzIHZl
cnNpb25zIGRvbid0IHRyYW5zaXRpb24gdG8gRDMgd2l0aCBpbmJveCBOVk1FIGRyaXZlci4NCllv
dSdyZSBjb3JyZWN0LCBpdCdzIGV4cGxpY2l0IHN0YXRlIHRyYW5zaXRpb25zIGV2ZW4gaWYgQVBT
VCB3YXMgZW5hYmxlZA0KKGFzIHRoaXMgcGF0Y2ggaXMgY3VycmVudGx5IGRvaW5nIGFzIHdlbGwp
Lg0KDQoNCg==
