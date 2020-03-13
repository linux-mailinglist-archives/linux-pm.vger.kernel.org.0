Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40B1843BF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCMJfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:35:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726652AbgCMJem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:42 -0400
X-UUID: f6085f581c4046c19a0df2d94e57a980-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MidtCNAIajigGXAw4rqwNT0zFAWiQXn5poURNmnBH+M=;
        b=u99Emqlc65OIXVqVjlVr0smg7ATjK4DBU6wjgCIe7gFEOMukRL6y5yfuvafLfATkZy9e4I5TSFzWllmZ6uCkGTaeChxcLGrGB1wkaW2oYrQYl2Uau3FU2W+APMSRYD7kbMwArnq8tY/+uH0pc2l7xgzmpDJdgDYxDJk10N4348Y=;
X-UUID: f6085f581c4046c19a0df2d94e57a980-20200313
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1363436086; Fri, 13 Mar 2020 17:34:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:32:16 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:40 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH V4 00/13] Add driver for dvfsrc, support for active state of scpsys
Date:   Fri, 13 Mar 2020 17:34:13 +0800
Message-ID: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIHBhdGNoc2V0cyBhZGQgc3VwcG9ydCBmb3IgTWVkaWFUZWsgaGFyZHdhcmUgbW9kdWxlIG5h
bWVkIERWRlNSQw0KKGR5bmFtaWMgdm9sdGFnZSBhbmQgZnJlcXVlbmN5IHNjYWxpbmcgcmVzb3Vy
Y2UgY29sbGVjdG9yKS4gVGhlIERWRlNSQyBpcw0KYSBIVyBtb2R1bGUgd2hpY2ggaXMgdXNlZCB0
byBjb2xsZWN0IGFsbCB0aGUgcmVxdWVzdHMgZnJvbSBib3RoIHNvZnR3YXJlDQphbmQgaGFyZHdh
cmUgYW5kIHR1cm4gaW50byB0aGUgZGVjaXNpb24gb2YgbWluaW11bSBvcGVyYXRpbmcgdm9sdGFn
ZSBhbmQNCm1pbmltdW0gRFJBTSBmcmVxdWVuY3kgdG8gZnVsZmlsbCB0aG9zZSByZXF1ZXN0cy4N
Cg0KU28sIFRoaXMgc2VyaWVzIGlzIHRvIGltcGxlbWVudCB0aGUgZHZmc3JjIGRyaXZlciB0byBj
b2xsZWN0IGFsbCB0aGUNCnJlcXVlc3RzIG9mIG9wZXJhdGluZyB2b2x0YWdlIG9yIERSQU0gYmFu
ZHdpZHRoIGZyb20gb3RoZXIgZGV2aWNlIGRyaXZlcnMNCmxpa2VzIEdQVS9DYW1lcmEgdGhyb3Vn
aCAzIGZyYW1ld29ya3MgYmFzaWNhbGx5Og0KDQoxLiBpbnRlcmNvbm5lY3QgZnJhbWV3b3JrOiB0
byBhZ2dyZWdhdGUgdGhlIGJhbmR3aWR0aA0KICAgcmVxdWlyZW1lbnRzIGZyb20gZGlmZmVyZW50
IGNsaWVudHMNCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA3NjYz
MjkvDQoNCkJlbG93IGlzIHRoZSBlbWkgYmFuZHdpZHRoIG1hcCBvZiBtdDgxODMuIFRoZXJlIGhh
cyBhIGh3IG1vZHVsZSAiRFJBTSBzY2hlZHVsZXIiDQp3aGljaCB1c2VkIHRvIGNvbnRyb2wgdGhl
IHRocm91Z2hwdXQuIFRoZSBEVkZTUkMgd2lsbCBjb2xsZWN0IGZvcmVjYXN0IGRhdGENCm9mIGRy
YW0gYmFuZHdpZHRoIGZyb20gU1cgY29uc3VtZXJzKGNhbWVyYS9ncHUuLi4pLCBhbmQgYWNjb3Jk
aW5nIHRoZSBmb3JlY2FzdA0KdG8gY2hhbmdlIHRoZSBEUkFNIGZyZXF1ZW5jeQ0KDQogICAgICAg
ICAgIElDQyBwcm92aWRlciAgICAgICAgIElDQyBOb2Rlcw0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0tLS0gICAgICAgICAgLS0tLQ0KICAgICAgICAgICAtLS0tLS0tLS0gICAgICAgfENQ
VSB8ICAgfC0tLT58VlBVIHwNCiAgLS0tLS0gICB8ICAgICAgICAgfC0tLS0tPiAtLS0tICAgIHwg
ICAgIC0tLS0NCiB8RFJBTSB8LS18RFJBTSAgICAgfCAgICAgICAtLS0tICAgIHwgICAgIC0tLS0N
CiB8ICAgICB8LS18c2NoZWR1bGVyfC0tLS0tPnxHUFUgfCAgIHwtLS0+fERJU1B8DQogfCAgICAg
fC0tfChFTUkpICAgIHwgICAgICAgLS0tLSAgICB8ICAgICAtLS0tDQogfCAgICAgfC0tfCAgICAg
ICAgIHwgICAgICAgLS0tLS0gICB8ICAgICAtLS0tDQogIC0tLS0tICAgfCAgICAgICAgIHwtLS0t
LT58TU1TWVN8LS18LS0tPnxWREVDfA0KICAgICAgICAgICAtLS0tLS0tLS0gICAgICAgIC0tLS0t
ICAgfCAgICAgLS0tLQ0KICAgICAgICAgICAgIC98XCAgICAgICAgICAgICAgICAgICAgfCAgICAg
LS0tLQ0KICAgICAgICAgICAgICB8Y2hhbmdlIERSQU0gZnJlcSAgICAgfC0tLT58VkVOQ3wNCiAg
ICAgICAgICAgLS0tLS0tLS0tLSAgICAgICAgICAgICAgIHwgICAgIC0tLS0NCiAgICAgICAgICB8
ICBEVkZTUiAgIHwgICAgICAgICAgICAgIHwNCiAgICAgICAgICB8ICAgICAgICAgIHwgICAgICAg
ICAgICAgIHwgICAgIC0tLS0NCiAgICAgICAgICAgLS0tLS0tLS0tLSAgICAgICAgICAgICAgIHwt
LS0+fElNRyB8DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAtLS0t
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAtLS0tDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8LS0tPnxDQU0gfA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLQ0KDQoyLiBBY3RpdmUgc3RhdGUgbWFuYWdl
bWVudCBvZiBwb3dlciBkb21haW5zWzFdOiB0byBoYW5kbGUgdGhlIG9wZXJhdGluZw0KICAgdm9s
dGFnZS9kcmFtIG9wcCByZXF1aXJlbWVudCBmcm9tIGRpZmZlcmVudCBwb3dlciBkb21haW5zDQoN
ClsyXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzQ0MDQ3Lw0KDQozLiBSZWd1YWx0b3IgZnJh
bWV3b3JrOiB0byBoYW5kbGUgdGhlIG9wZXJhdGluZyB2b2x0YWdlIHJlcXVpcmVtZW50IGZyb20g
dXNlciBvcg0KICAgY29zdW1lciB3aGljaCBub3QgYmVsb25nIGFueSBwb3dlciBkb21haW4NCg0K
Q2hhbmdlcyBpbiBWNDoNCiogQWRkIGFja2VkIFRBRyBvbiBkdC1iaW5kaW5ncyBwYXRjaGVzLiAo
Um9iKQ0KKiBEZWNsYXJhdGlvbiBvZiBlbWlfaWNjX2FnZ3JlZ2F0ZSBzaW5jZSB0aGUgcHJvdG90
eXBlIG9mIGFnZ3JlZ2F0ZSBmdW5jdGlvbg0KaGFzIGNoYW5nZWQgbWVhbndoaWxlLiAoR2Vvcmdp
KQ0KKiBVc2VkIGVtaV9pY2NfcmVtb3ZlIGluc3RlYWQgb2YgaWNjX3Byb3ZpZGVyX2RlbCBvbiBw
cm9iZS4gKEdlb3JnaSkNCiogQWRkIGR2ZnNyYyByZWd1bGF0b3IgZHJpdmVyIGludG8gc2VyaWVz
Lg0KKiBCdWcgZml4ZWQgb2YgbXQ4MTgzX2dldF9jdXJyZW50X2xldmVsLg0KKiBBZGQgbXV0ZXgg
cHJvdGVjdGlvbiBmb3IgcHN0YXRlIG9wZXJhdGlvbiBvbiBkdmZzcmNfc2V0X3BlcmZvcm1hbmNl
Lg0KDQpDaGFuZ2VzIGluIFYzOg0KKiBSZW1vdmUgUkZDIGZyb20gdGhlIHN1YmplY3QgcHJlZml4
IG9mIHRoZSBzZXJpZXMNCiogQ29tYmluZSBkdC1iaW5kaW5nIHBhdGNoIGFuZCBtb3ZlIGludGVy
Y29ubmVjdCBkdC1iaW5kaW5nIGRvY3VtZW50IGludG8NCmR2ZnNyYy4gKFJvYikNCiogUmVtb3Zl
IHVudXNlZCBoZWFkZXIsIGFkZCB1bml0IGRlc2NpcnB0aW9uIHRvIHRoZSBiYW5kd2lkdGgsIHJl
bmFtZSBjb21wYXRpYmxlDQpuYW1lIG9uIGludGVyY29ubmVjdCBkcml2ZXIuIChHZW9yZ2kpDQoq
IEZpeGVkIHNvbWUgY29kaW5nIHN0eWxlOiBjaGVjayBmbG93LCBuYW1pbmcsIHVzZWQgcmVhZHhf
cG9sbF90aW1lb3V0DQpvbiBkdmZzcmMgZHJpdmVyLiAoUnlhbikNCiogUmVuYW1lIGludGVyY29u
bmVjdCBkcml2ZXIgbXQ4MTgzLmMgdG8gbXRrLWVtaS5jDQoqIFJlbmFtZSBpbnRlcmNvbm5lY3Qg
aGVhZGVyIG10ayxtdDgxODMuaCB0byBtdGssZW1pLmgNCiogbXRrLXNjcHN5cy5jOiBBZGQgb3Bw
IHRhYmxlIGNoZWNrIGZpcnN0IHRvIGF2b2lkIE9GIHJ1bnRpbWUgcGFyc2UgZmFpbGVkDQoNCkNo
YW5nZXMgaW4gUkZDIFYyOg0KKiBSZW1vdmUgdGhlIERUIHByb3BlcnR5IGRyYW1fdHlwZS4gKFJv
YikNCiogVXNlZCBnZW5lcmljIGR0cyBwcm9wZXJ0eSAnb3BwLWxldmVsJyB0byBnZXQgdGhlIHBl
cmZvcm1hY2Ugc3RhdGUuIChTdGVwaGVuKQ0KKiBSZW1vdmUgdW5lY2Vzc2FyeSBkZXBlbmRlbmN5
IGNvbmZpZyBvbiBLY29uZmlnLiAoU3RlcGhlbikNCiogUmVtb3ZlIHVudXNlZCBoZWFkZXIgZmls
ZSwgZml4ZWQgc29tZSBjb2Rpbmcgc3R5bGUgaXNzdWUsIHR5cG8sDQplcnJvciBoYW5kbGluZyBv
biBkdmZzcmMgZHJpdmVyLiAoTmljb2xhcy9TdGVwaGVuKQ0KKiBSZW1vdmUgaXJxIGhhbmRsZXIg
b24gZHZmc3JjIGRyaXZlci4gKFN0ZXBoZW4pDQoqIFJlbW92ZSBpbml0IHRhYmxlIG9uIGR2ZnNy
YyBkcml2ZXIsIGNvbWJpbmUgaHcgaW5pdCBvbiB0cnVzdHpvbmUuDQoqIEFkZCBpbnRlcmNvbm5l
Y3Qgc3VwcG9ydCBvZiBtdDgxODMgdG8gYWdncmVnYXRlIHRoZSBlbWkgYmFuZHdpZHRoLg0KKEdl
b3JnaSkNCg0KVjM6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTExMTg4Njcv
DQpSRkMgVjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDY4MTEz
Lw0KUkZDIFYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvY292ZXIvMTAyODUz
NS8NCg==

