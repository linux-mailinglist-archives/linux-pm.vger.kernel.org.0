Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68602946A1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 04:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbgJUCmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 22:42:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58216 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406204AbgJUCmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 22:42:00 -0400
X-UUID: a457063f822147cea73cedba0c250a5e-20201021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CSIWOHWW2k4Oo3UJnDOr2pHEoV0FdN/U4oXEDqdqb88=;
        b=sxDFD1SU++hQNCnDprupw9n8xBuN8i3ZswaP6qXpBo9osNBcjqU79dG0HGWHQDf7YOMCoGm73xjsy3Xr8Y2nCKg5ZlxVZwQo4rtLM5UYxZyypjn45PNWv6FH4xuMK2LdV2IA7RjVaMC4HZyBnuYxzBRKuYu3P984ncUhAtR1Dio=;
X-UUID: a457063f822147cea73cedba0c250a5e-20201021
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2143814347; Wed, 21 Oct 2020 10:36:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Oct 2020 10:36:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Oct
 2020 10:36:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Oct 2020 10:36:42 +0800
Message-ID: <1603247803.20224.5.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>
Date:   Wed, 21 Oct 2020 10:36:43 +0800
In-Reply-To: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
X-TM-SNTS-SMTP: 1B414A6A3F0B5D498705D291968F6E6255C1E00CDD4FB37AB222F7A638D801F62000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIE1hbml2YW5uYW4NCg0KT24gVHVlLCAyMDIwLTEwLTIwIGF0IDIxOjA5ICswNTMwLCBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+IEFkZCBkZXZpY2V0cmVlIGRvY3VtZW50YXRpb24g
Zm9yICdxY29tLGZyZXEtZG9tYWluJyBwcm9wZXJ0eSBzcGVjaWZpYw0KPiB0byBRdWFsY29tbSBD
UFVzLiBUaGlzIHByb3BlcnR5IGlzIHVzZWQgdG8gcmVmZXJlbmNlIHRoZSBDUFVGUkVRIG5vZGUN
Cj4gYWxvbmcgd2l0aCBEb21haW4gSUQgKDAvMSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiAt
LS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sIHwg
NiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQo+IGluZGV4
IDEyMjJiZjE4MzFmYS4uZjQwNTY0YmYwMDRmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KPiBAQCAtMjkwLDYgKzI5MCwxMiBA
QCBwcm9wZXJ0aWVzOg0KPiAgDQo+ICAgICAgICAqIGFybS9tc20vcWNvbSxrcHNzLWFjYy50eHQN
Cj4gIA0KPiArICBxY29tLGZyZXEtZG9tYWluOg0KRG8geW91IG1pbmQgdG8gY2hhbmdlICJxY29t
LCBmcmVxLWRvbWFpbiIgdG8gY29tbW9uIG5hbWluZz8gb3IgZHJvcCB0aGUNCnByZWZpeC4gU28g
dGhhdCB3ZSBjYW4gdXNlIHRoaXMgQ1BVIG5vZGUgYW5kIG1hcCBpdCB0byBlYWNoIGZyZXEtZG9t
YWluLg0KVGhhbmtzIGEgbG90LiANCg0KPiArICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Jw0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsg
ICAgICBDUFVzIHN1cHBvcnRpbmcgZnJlcS1kb21haW4gbXVzdCBzZXQgdGhlaXIgInFjb20sZnJl
cS1kb21haW4iIHByb3BlcnR5DQo+ICsgICAgICB3aXRoIHBoYW5kbGUgdG8gYSBjcHVmcmVxX2h3
IG5vZGUgZm9sbG93ZWQgYnkgdGhlIERvbWFpbiBJRCgwLzEpLg0KPiArDQo+ICAgIHJvY2tjaGlw
LHBtdToNCj4gICAgICAkcmVmOiAnL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhh
bmRsZScNCj4gICAgICBkZXNjcmlwdGlvbjogfA0KDQo=

