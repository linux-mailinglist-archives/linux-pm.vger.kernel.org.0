Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577251973C5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 07:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgC3FTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 01:19:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727706AbgC3FTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 01:19:25 -0400
X-UUID: 0f20d00ab22441028f7c2718f3f30338-20200330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PiWLw0TeG7GcgBMd5OgryJCpKyO8lgrXQHDKaqgPG58=;
        b=H51wOSB4E8IfmA8XEkPuCE4rb6zVrbPrgRG7NerAS16eswoZuZgmsBARj6W8ThUSXXAKCZSRNlHf77IQsb1QfsjsVqVy/q4wIKsHIie6dIkpwrxtcPhdUfv/zkse4bpy1kBhyRdQzj5lKUEL6gxH2Rw8LIgDyt6AsteDnWyAONc=;
X-UUID: 0f20d00ab22441028f7c2718f3f30338-20200330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 5589251; Mon, 30 Mar 2020 13:19:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Mar 2020 13:19:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Mar 2020 13:19:11 +0800
Message-ID: <1585545553.32635.10.camel@mtksdaap41>
Subject: Re: [PATCH V4 11/13] dt-bindings: regulator: add DVFSRC regulator
 dt-bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Viresh Kumar" <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nicolas Boichat" <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "Mike Turquette" <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Mon, 30 Mar 2020 13:19:13 +0800
In-Reply-To: <20200324203833.GL7039@sirena.org.uk>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
         <1584092066-24425-12-git-send-email-henryc.chen@mediatek.com>
         <20200324203833.GL7039@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTWFyaywNCk9uIFR1ZSwgMjAyMC0wMy0yNCBhdCAyMDozOCArMDAwMCwgTWFyayBCcm93biB3
cm90ZToNCj4gT24gRnJpLCBNYXIgMTMsIDIwMjAgYXQgMDU6MzQ6MjRQTSArMDgwMCwgSGVucnkg
Q2hlbiB3cm90ZToNCj4gDQo+ID4gKy0gcmVndWxhdG9yIDogVGhlIERWRlNSQyByZWd1bGF0b3Ig
aXMgbW9kZWxsZWQgYXMgYSBzdWJkZXZpY2Ugb2YgdGhlIERWRlNSQy4NCj4gPiArCUJlY2F1c2Ug
RFZGU1JDIGNhbiByZXF1ZXN0IHBvd2VyIGRpcmVjdGx5IHZpYSByZWdpc3RlciByZWFkL3dyaXRl
LCBsaWtlcw0KPiA+ICsJdmNvcmUgd2hpY2ggaXMgYSBjb3JlIHBvd2VyIG9mIG10ODE4My4gQXMg
c3VjaCwgdGhlIERWRlNSQyByZWd1bGF0b3INCj4gPiArCXJlcXVpcmVzIHRoYXQgRFZGU1JDIG5v
ZGVzIGJlIHByZXNlbnQuIHNoYWxsIGNvbnRhaW4gb25seSBvbmUgb2YgdGhlDQo+ID4gKwlmb2xs
b3dpbmc6ICJtZWRpYXRlayxtdDgxODMtZHZmc3JjLXJlZ3VsYXRvciINCj4gDQo+IFdoeSBkbyB3
ZSBldmVuIG5lZWQgYSBjb21wYXRpYmxlIGhlcmUgLSBpdCdzIG5vdCBhZGRpbmcgYW55IG5ldw0K
PiBpbmZvcm1hdGlvbiB0byB0aGUgcGFyZW50IG10ODE4MyBub2RlLCB0aGUgY29tcGF0aWJsZSBp
cyBtYWlubHkgZm9yIHRoZQ0KPiB3YXkgTGludXggZGl2aWRlcyB0aGluZ3MgdXAgcmF0aGVyIHRo
YW4gYSBkZXNjcmlwdGlvbiBvZiB0aGUgaGFyZHdhcmUuDQo+IFdlIGNvdWxkIGp1c3Qgc2F5IHRo
YXQgdGhlIHJlZ3VsYXRvciBub2RlIGFsd2F5cyBoYXMgYSBwYXJ0aWN1bGFyIG5hbWUNCj4gaW5z
dGVhZC4NClNvcnJ5LCBub3QgcXVpdGUgc3VyZSB3aGF0IHlvdSBtZWFuLCBiZWNhdXNlIEkgdGhp
bmsgRFZGU1JDIGlzIGENCnJlZ3VsYXRvciBwcm92aWRlciB0aGF0IGNhbiBwcm92aWRlIHZjb3Jl
IHZvbHRhZ2UgY29udHJvbCBvbiBtdDgxODMsIGFuZA0KaXQgY2FuIHByb3ZpZGUgbW9yZSBwb3dl
ciBjb250cm9sIGluIHRoZSBuZXh0IGdlbmVyYXRpb24gTWVkaWF0ZWsgU09DLg0KSGVyZSBJIGFk
ZCBhIHN1Yi1ub2RlIHRvIGRlc2NyaWJlIGl0LiBPciBzaG91bGQgSSBtb3ZlIHRoaXMgbm9kZSB0
bw0KcmVndWxhdG9yIGZvbGRlcj8gDQoNCj4gDQo+IEl0J3MgYWxzbyBub3QgcXVpdGUgdHJ1ZSB0
aGF0IGl0IGNvbnRhaW5zICJvbmx5IiB0aGUgY29tcGF0aWJsZSAtIGl0DQo+IGFsc28gYWxsb3dz
IHRoZSByZWd1bGF0b3IgY29uc3RyYWludHMgdG8gYmUgZGVmaW5lZC4NCg0K

