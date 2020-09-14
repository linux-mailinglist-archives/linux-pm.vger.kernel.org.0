Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBE2682ED
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINDHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:07:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726101AbgINDFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:08 -0400
X-UUID: 97479aa049b745d29a36f550cc59269e-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qBymKk2B0d56MBUuX1hhxF1oOlrZkobktKD1Mxr60CM=;
        b=LOwnzn/f2IBWb1u0l93sQygelWPh+i2U0sAZdNWUWpvEuVYvi4QoFG8zLzPcRDd84fCbVjXnXn8oyxEYCwEyrdDk6Myp2Njs0VyVWwXErdpCfP9u01yzg7qFxMtn5DSgK2/9U2U5bfkDwt4FUm6GR9Axg0PYpVSObwmz8eHTFaw=;
X-UUID: 97479aa049b745d29a36f550cc59269e-20200914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002533154; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:47 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:47 +0800
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
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 04/17] arm64: dts: mt8183: add performance state support of scpsys
Date:   Mon, 14 Sep 2020 11:04:31 +0800
Message-ID: <1600052684-21198-5-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIHBlcmZvcm1hbmNlIHN0YXRlIG9mIHNjcHN5cyBvbiBtdDgxODMgcGxh
dGZvcm0NCg0KU2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDIy
ICsrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRz
aSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IGQ4NWJh
ZTcuLjgyY2E5MjkgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNp
DQpAQCAtMTIsNiArMTIsNyBAQA0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC1jb250cm9s
bGVyL210ODE4My1yZXNldHMuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS5oPg0K
ICNpbmNsdWRlICJtdDgxODMtcGluZnVuYy5oIg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9zb2Mv
bXRrLGR2ZnNyYy5oPg0KIA0KIC8gew0KIAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4MyI7
DQpAQCAtMzQwLDYgKzM0MSwyNyBAQA0KIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KIAkJCSNz
aXplLWNlbGxzID0gPDA+Ow0KIA0KKwkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmR2ZnNyY19v
cHBfdGFibGU+Ow0KKwkJCWR2ZnNyY19vcHBfdGFibGU6IG9wcC10YWJsZSB7DQorCQkJCWNvbXBh
dGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12Mi1sZXZlbCI7DQorDQorCQkJCWR2ZnNyY192b2xf
bWluOiBvcHAxIHsNCisJCQkJCW9wcCxsZXZlbCA9IDxNVDgxODNfRFZGU1JDX0xFVkVMXzE+Ow0K
KwkJCQl9Ow0KKw0KKwkJCQlkdmZzcmNfZnJlcV9tZWRpdW06IG9wcDIgew0KKwkJCQkJb3BwLGxl
dmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfMj47DQorCQkJCX07DQorDQorCQkJCWR2ZnNyY19m
cmVxX21heDogb3BwMyB7DQorCQkJCQlvcHAsbGV2ZWwgPSA8TVQ4MTgzX0RWRlNSQ19MRVZFTF8z
PjsNCisJCQkJfTsNCisNCisJCQkJZHZmc3JjX3ZvbF9tYXg6IG9wcDQgew0KKwkJCQkJb3BwLGxl
dmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfND47DQorCQkJCX07DQorCQkJfTsNCisNCiAJCQlh
dWRpb0BNVDgxODNfUE9XRVJfRE9NQUlOX0FVRElPIHsNCiAJCQkJcmVnID0gPE1UODE4M19QT1dF
Ul9ET01BSU5fQVVESU8+Ow0KIAkJCX07DQotLSANCjEuOS4xDQo=

