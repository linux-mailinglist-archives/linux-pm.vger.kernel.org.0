Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F218F43A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCWMPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:15:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45754 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727401AbgCWMPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 08:15:49 -0400
X-UUID: ebcb65c8de9a423d82d3780f683f4b53-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wxu/rJjKNum6u7NU44aKieD1zc3Y+wnpPlval5gEFNw=;
        b=azDZ7UXtLWoEyREFg4MhpmsOwv1FesvpT5dD9uJlt9p5/b+C0PosyEaEgPElTU0i5J9jqWbnUis0zGpoCkZIYqrwkao5/ITbDGiS0eM5/cxyTe3FbJ6InuD2YWY3qYspegvFhd3dKevXlPhLqrXHisC3daXn3AgENQdhABjS72E=;
X-UUID: ebcb65c8de9a423d82d3780f683f4b53-20200323
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1871207188; Mon, 23 Mar 2020 20:15:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 20:15:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Mar 2020 20:15:38 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <michael.kao@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v4,5/7] thermal: mediatek: mt8183: fix bank number settings
Date:   Mon, 23 Mar 2020 20:15:35 +0800
Message-ID: <20200323121537.22697-6-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200323121537.22697-1-michael.kao@mediatek.com>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TVQ4MTgzX05VTV9aT05FUyBzaG91bGQgYmUgc2V0IHRvIDENCmJlY2F1c2UgTVQ4MTgzIGRvZXNu
J3QgaGF2ZSBtdWx0aXBsZSBiYW5rcy4NCg0KRml4ZXM6IGE0ZmZlNmI1MmQyNyAoInRoZXJtYWw6
IG1lZGlhdGVrOiBhZGQgc3VwcG9ydCBmb3IgTVQ4MTgzIikNClNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgS2FvIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIc2luLVlp
IFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQotLS0NCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3Ro
ZXJtYWwuYyB8IDUgKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyBi
L2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQppbmRleCA3NmUzMDYwM2Q0ZDUuLjZiN2Vm
MTk5M2Q3ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jDQorKysg
Yi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KQEAgLTIxMSw2ICsyMTEsOSBAQCBlbnVt
IHsNCiAvKiBUaGUgdG90YWwgbnVtYmVyIG9mIHRlbXBlcmF0dXJlIHNlbnNvcnMgaW4gdGhlIE1U
ODE4MyAqLw0KICNkZWZpbmUgTVQ4MTgzX05VTV9TRU5TT1JTCTYNCiANCisvKiBUaGUgbnVtYmVy
IG9mIGJhbmtzIGluIHRoZSBNVDgxODMgKi8NCisjZGVmaW5lIE1UODE4M19OVU1fWk9ORVMgICAg
ICAgICAgICAgICAxDQorDQogLyogVGhlIG51bWJlciBvZiBzZW5zaW5nIHBvaW50cyBwZXIgYmFu
ayAqLw0KICNkZWZpbmUgTVQ4MTgzX05VTV9TRU5TT1JTX1BFUl9aT05FCSA2DQogDQpAQCAtNDk3
LDcgKzUwMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3RoZXJtYWxfZGF0YSBtdDc2MjJf
dGhlcm1hbF9kYXRhID0gew0KICAqLw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3RoZXJtYWxf
ZGF0YSBtdDgxODNfdGhlcm1hbF9kYXRhID0gew0KIAkuYXV4YWRjX2NoYW5uZWwgPSBNVDgxODNf
VEVNUF9BVVhBRENfQ0hBTk5FTCwNCi0JLm51bV9iYW5rcyA9IE1UODE4M19OVU1fU0VOU09SU19Q
RVJfWk9ORSwNCisJLm51bV9iYW5rcyA9IE1UODE4M19OVU1fWk9ORVMsDQogCS5udW1fc2Vuc29y
cyA9IE1UODE4M19OVU1fU0VOU09SUywNCiAJLnZ0c19pbmRleCA9IG10ODE4M192dHNfaW5kZXgs
DQogCS5jYWxpX3ZhbCA9IE1UODE4M19DQUxJQlJBVElPTiwNCi0tIA0KMi4xOC4wDQo=

