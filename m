Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6636288166
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 06:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJIEnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 00:43:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgJIEnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 00:43:05 -0400
X-UUID: f1420bb577d648a68139800033ad5ee4-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ijk9zEMYAAMFlQhF4wPAOfPw0u7B12zhXrXvw8s3OT4=;
        b=qvJ2vFkrUbJIVMh2+kD2N/bY0oLWLJujRrk8dO+7li+pIuoNacv1ssPSdChpJwZNIf7gT2+/3GVKv4i3VMvoV4+tE68T/1zJZwUC41DUWyrmc2T97DQMeqjqjBLvUOC1Ajo1K552cKHhWmyFaPMwthJYdmxRGImYJFoQqWed3pQ=;
X-UUID: f1420bb577d648a68139800033ad5ee4-20201009
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1072511865; Fri, 09 Oct 2020 12:43:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 12:42:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 12:42:57 +0800
Message-ID: <1602218579.21446.57.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 9 Oct 2020 12:42:59 +0800
In-Reply-To: <20201009041912.nzhvubzmfox2twxg@vireshk-i7>
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
         <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
         <20201009041912.nzhvubzmfox2twxg@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9FC3C75B20CA1A3C7FC84E92EBC44B1270F1640D81729BFB725E74D47F77370C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTA5IGF0IDA5OjQ5ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDA4LTEwLTIwLCAyMDoxMywgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rv
ci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFJlZ2lzdGVyIENQ
VSBwb3dlciB0YWJsZSB0byBlbmVyZ3kgbW9kZWwgZnJhbWV3b3JrDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyB8ICAgNTAgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IEkgZG9uJ3Qgc2VlIHRoaXMgZmlsZSBp
biBtYWlubGluZS4gV2hhdCBhbSBJIG1pc3NpbmcgPw0KPiANCkhpLCBWaXJlc2g6DQoNClllcywg
SSBiYXNlIG9uIG15IHBhdGNoZXMgd2hpY2ggaXMgY3VycmVudGx5IHJldmlld2VkIGJ5IFJvYiBm
b3IgdGhlDQpEZXZpY2UgdHJlZSBwYXJ0Lg0KQXMgSSBtZW50aW9uZWQgaW4gY292ZXIgbGV0dGVy
Lg0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gTWVkaWF0ZWsgY3B1ZnJlcSBIVyBkcml2ZXIgcGF0
Y2ggc3VibWl0dGVkIGJ5DQpIZWN0b3IgWXVhbi4NCiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAy
MC85LzEwLzEzDQoNCkkgaGF2ZSBhc2tlZCB5b3VyIGFwcHJvdmFsIGZvciBzZW5kaW5nIG15IG5l
dyBwYXRjaGVzIGJhc2VkIG9uIGl0IGFuZA0KeW91IHNhaWQgaXQncyBva2F5IHRvIHlvdS4NCkkg
d2lsbCBzdG9wIHNlbmRpbmcgbmV3IHBhdGNoZXMgaWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLg0K
VGhhbmsgeW91IHNvIG11Y2guDQo=

