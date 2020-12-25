Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8912E29AD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Dec 2020 06:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgLYFOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Dec 2020 00:14:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50926 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgLYFOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Dec 2020 00:14:54 -0500
X-UUID: 586174e26871477880197deee357d3f7-20201225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KgeZmFxf9ZEZvqNx6WjQdn790TCyZKDbfVixiX7OE0Q=;
        b=r48Sr84TREdx1GVg9DtFCzW2dS5AIEd6OsYrjToU+ncMYWegwIdPCshccYvsGSW4EtCVjKNYicB3w4V1wojpQ0jRfADWMCkNBybYCkP+3mT9citywl+p2ljYXz2puaXdYJKwAD4jQP8ArI9DbzrPWJipSauNlf63EAIvPtPQtR8=;
X-UUID: 586174e26871477880197deee357d3f7-20201225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1206600739; Fri, 25 Dec 2020 13:14:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Dec 2020 13:14:04 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 13:14:04 +0800
Message-ID: <1608873245.24775.2.camel@mtksdaap41>
Subject: Re: [PATCH V6 03/13] soc: mediatek: add driver for dvfsrc support
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        DTML <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Fan Chen" <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 25 Dec 2020 13:14:05 +0800
In-Reply-To: <CAAOTY__whne=DuaSv4rOv8f1qTebjqDOVjD5YGYw6eBkkWKmUw@mail.gmail.com>
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
         <1608790134-27425-4-git-send-email-henryc.chen@mediatek.com>
         <CAAOTY__whne=DuaSv4rOv8f1qTebjqDOVjD5YGYw6eBkkWKmUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F345F721F12B5EE58BF45EC2F3987B08119EA1B5D0B332A9788DD00BA98585C62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTI0IGF0IDIyOjMzICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
SGkgQ0ssDQo+IEhpLCBIZW5yeToNCj4gDQo+IEhlbnJ5IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlh
dGVrLmNvbT4g5pa8IDIwMjDlubQxMuaciDI05pelIOmAseWbmyDkuIvljYgyOjA55a+r6YGT77ya
DQo+ID4NCj4gPiBBZGQgZHZmc3JjIGRyaXZlciBmb3IgTVQ2ODczL01UODE4My9NVDgxOTINCj4g
DQo+IFNlcGFyYXRlIHRoaXMgcGF0Y2ggZm9yIGVhY2ggU29DLg0KT0ssIHRoYW5rcy4NCkhlbnJ5
DQo+IA0KPiBSZWdhcmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEhlbnJ5IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgIHwgIDEyICsNCj4gPiAgZHJp
dmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5jICAgICAgIHwgNTM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19kdmZz
cmMuaCB8ICAzNSArKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA1ODYgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWR2ZnNyYy5j
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGtf
ZHZmc3JjLmgNCj4gPg0KDQo=

