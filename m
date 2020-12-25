Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1162E29AA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Dec 2020 06:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgLYFNz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Dec 2020 00:13:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgLYFNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Dec 2020 00:13:55 -0500
X-UUID: 6fb3980a203c41188ec138df5bec5aa1-20201225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NymtaQsb4oZZm5gLdklbpuzTSWgSwEAEXv7tkNvz7xM=;
        b=TqQ+SgiXml4sw71/XWcR4uXdxL3vM6+p8U6UCql75bng6YthtVu1pLcqyeQRb/JluRDET/c1pqu2V8InEft5FcGtRW7dH3RLq7hLyL1TyQbwIxhohIbS/19f1Cp+SHirVRom5EljTjjy1Z5e3sCejryonEAuuWYYRMnk7yt3OLg=;
X-UUID: 6fb3980a203c41188ec138df5bec5aa1-20201225
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1074196090; Fri, 25 Dec 2020 13:13:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Dec 2020 13:12:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 13:12:58 +0800
Message-ID: <1608873179.24775.1.camel@mtksdaap41>
Subject: Re: [PATCH V6 01/13] dt-bindings: soc: Add dvfsrc driver bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <linux-pm@vger.kernel.org>, James Liao <jamesjj.liao@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Georgi Djakov" <georgi.djakov@linaro.org>,
        Ryan Case <ryandcase@chromium.org>
Date:   Fri, 25 Dec 2020 13:12:59 +0800
In-Reply-To: <1608829305.386312.2966452.nullmailer@robh.at.kernel.org>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
         <1608790134-27425-2-git-send-email-henryc.chen@mediatek.com>
         <1608829305.386312.2966452.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2C62C8F5D17C2CB4C8FC8497F9967A51166F542B6D7A0761DDE0458A8C93F1922000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTI0IGF0IDEwOjAxIC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCAyNCBEZWMgMjAyMCAxNDowODo0MiArMDgwMCwgSGVucnkgQ2hlbiB3cm90ZToNCj4g
PiBEb2N1bWVudCB0aGUgYmluZGluZyBmb3IgZW5hYmxpbmcgZHZmc3JjIG9uIE1lZGlhVGVrIFNv
Qy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRp
YXRlay9kdmZzcmMueWFtbCAgIHwgNjggKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMueWFtbA0K
PiA+IA0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIGR0X2JpbmRpbmdf
Y2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+
IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy5leGFtcGxlLmR0czoxOToxODogZmF0
YWwgZXJyb3I6IGR0LWJpbmRpbmdzL3NvYy9tdGssZHZmc3JjLmg6IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkNCj4gICAgMTkgfCAgICAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9zb2MvbXRr
LGR2ZnNyYy5oPg0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuDQo+IG1ha2VbMV06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5saWI6MzQyOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL21lZGlhdGVrL2R2ZnNyYy5leGFtcGxlLmR0LnlhbWxdIEVycm9yIDENCj4gbWFrZTog
KioqIFtNYWtlZmlsZToxMzcwOiBkdF9iaW5kaW5nX2NoZWNrXSBFcnJvciAyDQo+IA0KPiBTZWUg
aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xNDIwMzgyDQo+IA0KPiBUaGlzIGNo
ZWNrIGNhbiBmYWlsIGlmIHRoZXJlIGFyZSBhbnkgZGVwZW5kZW5jaWVzLiBUaGUgYmFzZSBmb3Ig
YSBwYXRjaA0KPiBzZXJpZXMgaXMgZ2VuZXJhbGx5IHRoZSBtb3N0IHJlY2VudCByYzEuDQo+IA0K
PiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBz
ZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGlu
c3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3Rh
bGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdC4N
Cj4gDQpIaSBSb2IsDQoNClNvcnJ5IGZvciB0aGUgY2hlY2sgZXJyb3IsIEkgd2lsbCByZS1jaGVj
ayBhbmQgc3VibWl0IGFnYWluLg0KDQpUaGFua3MsDQpIZW5yeQ0K

