Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5D186596
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 08:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgCPHYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 03:24:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44565 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729638AbgCPHYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 03:24:36 -0400
X-UUID: edeebb8b7704427090312173cae9ccee-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SME2J3snLnpUKDZ+/mhvA9A9BXydvq2FK3+5529r+Aw=;
        b=TEuM7M9480zmjH6HOjHEjnQC2v3iyUJKS1vHVOqQ4N0JqI67LVIPLJaknbBtkI2O81gvICQ8uvzTf+4E+LinJUlyXkSk9Tx+P65Y8EIo8p7w1npEbYmKrdygg1GCWKL9liNej+Y4IFX/SXNL9pnT+VRrChi6TPagiBGz9snH55Q=;
X-UUID: edeebb8b7704427090312173cae9ccee-20200316
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 628648822; Mon, 16 Mar 2020 15:24:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 15:22:50 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 15:21:29 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 0/3] PM / AVS: SVS: Introduce SVS engine
Date:   Mon, 16 Mar 2020 15:23:14 +0800
Message-ID: <20200316072316.7156-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FAAF471B3CEBE181E2299E54C03D13A8F639F8379D2227AA0B0EE8D05A49E7012000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MS4gU1ZTIGRyaXZlciB1c2UgT1BQIGFkanVzdCBldmVudCBpbiBbMV0gdG8gdXBkYXRlIE9QUCB0
YWJsZSB2b2x0YWdlIHBhcnQuDQoyLiBTVlMgZHRzIG5vZGUgcmVmZXJzIHRvIENQVSBvcHAgdGFi
bGUgWzJdIGFuZCBHUFUgb3BwIHRhYmxlIFszXS4NCjMuIFNWUyBhbmQgdGhlcm1hbCBkdHMgdXNl
IHRoZSBzYW1lIHRoZXJtYWwgZWZ1c2UgWzRdLg0KNC4gU1ZTIGR0cyBuZWVkcyBQTUlDIHJlZ3Vs
YXRvciBbNV0uDQogDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTE5
MzUxMy8NClsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMzA0OTM1Lw0K
WzNdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE0MjMwMDkvDQpbNF0gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTMxNjQ5NS8NCls1XSBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMjg0NjE3Lw0KDQpwZW5kaW5nIGRpc2N1c3Npb24g
b24gdjc6DQotIFNWUyBzdWItbm9kZSBhcmNoaXRlY3R1cmUgcGVuZGluZyBkaXNjdXNzaW9uIGlu
IGJlbG93IHBhdGNoLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEx
NzU5OTQvDQoNCmNoYW5nZXMgc2luY2UgdjY6DQotIHN2c19pc3JfaGFuZGxlcigpIGZ1bmN0aW9u
IGlzIG1lcmdlZCBpbnRvIHN2c19pc3IoKS4NCi0gSW4gc3ZzX2lzcigpLCB3ZSBmaW5kIHdoaWNo
IGJhbmsgZmlyZXMgaW50ZXJydXB0IGZpcnN0IGFuZCBjaGVjayB0aGlzIGJhbmsNCmlzIHN1c3Bl
bmRlZCBvciBub3Qgc2Vjb25kbHkuDQotIFVzZSBtZW1kdXBfdXNlcl9udWwoKSBpbnN0ZWFkIG9m
IGNvcHlfZnJvbV91c2VyKCkuDQotIFVzZSBVMzJfTUFYIGluc3RlYWQgb2YgIih1MzIpLTEuDQot
IFNWUyBuZWVkcyB0byBkbyByZXN1bWUgYWZ0ZXIgdGhlcm1hbCByZXN1bWUgaW4gc3lzdGVtIHN1
c3BlbmQgZmxvdy4NClRoZXJlZm9yZSwgY2hhbmdlIFNWUyBwbV9vcHMgdG8gcHJlcGFyZS9jb21w
bGV0ZS4NCi0gQWRkIGhpZ2ggdGVtcGVyYXR1cmUgdm9sdGFnZXMgY29tcGVuc2F0aW9uIGNvZGVz
Lg0KLSBBZGQgaXJxZmxhZ3MgaW4gInN0cnVjdCBzdnNfcGxhdGZvcm0iIGZvciBzdXBwb3J0aW5n
IGRpZmZlcmVudCBTVlMgSFcgc2V0dGluZy4NCi0gU2V0IHNpZ25lZC1vZmYgdm9sdGFnZXMgdG8g
c3lzdGVtIHdoZW4gc3lzdGVtIHN1c3BlbmQuDQotIEFkZCBTVlMgSFcgcmVzZXQgZmxhZyBmb3Ig
ZnV0dXJlIFNWUyBIVyBzdXBwb3J0Lg0KLSBDb2Rpbmcgc3R5bGUgcmVmaW5lbWVudC4NCg0KUm9n
ZXIgTHUgKDMpOg0KICBkdC1iaW5kaW5nczogc29jOiBhZGQgbXRrIHN2cyBkdC1iaW5kaW5ncw0K
ICBhcm02NDogZHRzOiBtdDgxODM6IGFkZCBzdnMgZGV2aWNlIGluZm9ybWF0aW9uDQogIFBNIC8g
QVZTOiBTVlM6IEludHJvZHVjZSBTVlMgZW5naW5lDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9wb3dlci9tdGstc3ZzLnR4dCAgICAgfCAgIDc2ICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My1ldmIuZHRzICAgfCAgIDE2ICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My5kdHNpICAgICAgfCAgIDQxICsNCiBkcml2ZXJzL3Bvd2VyL2F2cy9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDEwICsNCiBkcml2ZXJzL3Bvd2VyL2F2cy9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL3Bvd2VyL2F2cy9tdGtf
c3ZzLmMgICAgICAgICAgICAgICAgICAgfCAyMDc0ICsrKysrKysrKysrKysrKysrDQogaW5jbHVk
ZS9saW51eC9wb3dlci9tdGtfc3ZzLmggICAgICAgICAgICAgICAgIHwgICAyMyArDQogNyBmaWxl
cyBjaGFuZ2VkLCAyMjQxIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL210ay1zdnMudHh0DQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcG93ZXIvYXZzL210a19zdnMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2xpbnV4L3Bvd2VyL210a19zdnMuaA0KDQo=

