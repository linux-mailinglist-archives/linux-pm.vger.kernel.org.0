Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA41DC908
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgEUIwj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 04:52:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728389AbgEUIwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 04:52:39 -0400
X-UUID: eea90d1380b540bfb2d3f2d6437f50f9-20200521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:From:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:Message-ID:Subject; bh=Ntq+xnZqQIn/7PE5MMeGwbIxDp+MLU6cQe0dH7iWCZU=;
        b=U+FaTvltahZ7khZZtzciTGjMw2cZP8cOg2BL98HP1W7g5hyOid75Bmg0LrszMbJtAAxkfHtinTC2SXMb5srzC76X1Z7gdg9IzMdrRlqsl9tS5oBEWIwCw4A6ypqd2JE4FA2ICmwR3itSyFk8/m9lRlcMk+gnZ8c9+Y+p97FVTFs=;
X-UUID: eea90d1380b540bfb2d3f2d6437f50f9-20200521
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <andrew-sh.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1294609958; Thu, 21 May 2020 16:52:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 16:52:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 May 2020 16:52:34 +0800
Subject: Re: [PATCH 09/12] devfreq: add mediatek cci devfreq
Message-ID: <1590051155.14062.3.camel@mtksdaap41>
SubjeTo: Mark Brown <broonie@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 21 May 2020 16:52:35 +0800
In-Reply-To: <20200520123135.GD4823@sirena.org.uk>
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
         <20200520034307.20435-10-andrew-sh.cheng@mediatek.com>
         <20200520123135.GD4823@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
From:   <andrew-sh.cheng@mediatek.com>
X-MTK:  N
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMDUtMjAgYXQgMTM6MzEgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFdlZCwgTWF5IDIwLCAyMDIwIGF0IDExOjQzOjA0QU0gKzA4MDAsIEFuZHJldy1zaC5DaGVu
ZyB3cm90ZToNCj4gDQo+ID4gKwljY2lfZGYtPnByb2NfcmVnID0gZGV2bV9yZWd1bGF0b3JfZ2V0
X29wdGlvbmFsKGNjaV9kZXYsICJwcm9jIik7DQo+ID4gKwlyZXQgPSBQVFJfRVJSX09SX1pFUk8o
Y2NpX2RmLT5wcm9jX3JlZyk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJaWYgKHJldCAhPSAt
RVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlkZXZfZXJyKGNjaV9kZXYsICJmYWlsZWQgdG8gZ2V0IHJl
Z3VsYXRvciBmb3IgQ0NJOiAlZFxuIiwNCj4gPiArCQkJCXJldCk7DQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArCX0NCj4gPiArCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoY2NpX2RmLT5wcm9jX3Jl
Zyk7DQo+IA0KPiBUaGUgY29kZSBhcHBlYXJzIHRvIHJlcXVpcmUgYSByZWd1bGF0b3IgKGFuZCBJ
J20gZ3Vlc3NpbmcgdGhlIGRldmljZQ0KPiBuZWVkcyBwb3dlcikgc28gd2h5IGlzIHRoaXMgdXNp
bmcgcmVndWxhdG9yX2dldF9vcHRpb25hbCgpPw0KDQpIaSBNYXJrLA0KDQpEbyB5b3UgbWVhbiwg
d2h5IG5vdCB1c2UgcmVndWxhdG9yX2dldF9leGNsdXNpdmUoKSBvciByZWd1bGF0b3JfZ2V0KCk/
DQpCZWNhdXNlIGNjaSBhbmQgY3B1IGxpdHRlciBjb3JlIHNoYXJlZCBidWNrLCBpdCBjYW5ub3Qg
dXNlDQpyZWd1bGF0b3JfZ2V0X2V4Y2x1c2l2ZSgpLg0KQmVjYXVzZSBib3RoIGNjaSBhbmQgY3B1
IHdhbnQgdG8gdHVuZSB2b2x0YWdlLCBpdCBjYW5ub3QgdXNlDQpyZWd1bGF0b3JfZ2V0KCksIG90
aGVyd2lzZSBpdCB3aWxsIGdldCBkdW1teSByZWd1bGF0b3IgZXZlbiB0aGlzIGJ1Y2sNCmRvZXNu
J3QgcmVnaXN0ZXIuYXMgcmVndWxhdG9yLg0KDQpCUiwNCkFuZHJldy1zaC5DaGVuZw0K

