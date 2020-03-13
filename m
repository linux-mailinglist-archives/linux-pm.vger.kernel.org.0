Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F751843B7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCMJet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9371 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726776AbgCMJeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:46 -0400
X-UUID: d69af70e3c404db689fcbeda2af74603-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C2PWodz3tfyBIHdMG1iwzdeDsm+xbRlWsBEle44812Y=;
        b=jMDHoSuaDaZHuuzVML7jI+Id3gORA72q1BFNzSa+Xg+n5YELKTCtS03OzJ/3QgHN9QGsZV6nmwTDNhsFjFJyAM03oC4Y4D8T/PZuZOK3gvlo639vCthPD0DSnqDlcHNqqG5B5a84EOfA8s+LHs4/76wF4OvqztmTGRB690h7zaU=;
X-UUID: d69af70e3c404db689fcbeda2af74603-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 761692425; Fri, 13 Mar 2020 17:34:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:33:30 +0800
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
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 02/13] dt-bindings: soc: Add opp table on scpsys bindings
Date:   Fri, 13 Mar 2020 17:34:15 +0800
Message-ID: <1584092066-24425-3-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG9wcCB0YWJsZSBvbiBzY3BzeXMgZHQtYmluZGluZ3MgZm9yIE1lZGlhdGVrIFNvQy4NCg0K
U2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPg0KUmV2
aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICB8IDQyICsrKysrKysrKysr
KysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3Bz
eXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9z
Y3BzeXMudHh0DQppbmRleCAxYmFhYTZmLi5kMjJmMTFkIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQorKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQN
CkBAIC03MCw2ICs3MCwxMCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gbWZnXzJkLXN1cHBs
eTogUG93ZXIgc3VwcGx5IGZvciB0aGUgbWZnXzJkIHBvd2VyIGRvbWFpbg0KIC0gbWZnLXN1cHBs
eTogUG93ZXIgc3VwcGx5IGZvciB0aGUgbWZnIHBvd2VyIGRvbWFpbg0KIA0KKy0gb3BlcmF0aW5n
LXBvaW50cy12MjogUGhhbmRsZSB0byB0aGUgT1BQIHRhYmxlIGZvciB0aGUgUG93ZXIgZG9tYWlu
Lg0KKwlSZWZlciB0byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvcG93
ZXJfZG9tYWluLnR4dA0KKwlhbmQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL29w
cC9vcHAudHh0IGZvciBtb3JlIGRldGFpbHMNCisNCiBFeGFtcGxlOg0KIA0KIAlzY3BzeXM6IHNj
cHN5c0AxMDAwNjAwMCB7DQpAQCAtODIsNiArODYsMjcgQEAgRXhhbXBsZToNCiAJCQkgPCZ0b3Bj
a2dlbiBDTEtfVE9QX1ZFTkNfU0VMPiwNCiAJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNfTFRf
U0VMPjsNCiAJCWNsb2NrLW5hbWVzID0gIm1mZyIsICJtbSIsICJ2ZW5jIiwgInZlbmNfbHQiOw0K
KwkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmZHZmc3JjX29wcF90YWJsZT47DQorDQorCQlkdmZz
cmNfb3BwX3RhYmxlOiBvcHAtdGFibGUgew0KKwkJCWNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBv
aW50cy12Mi1sZXZlbCI7DQorDQorCQkJZHZmc3JjX3ZvbF9taW46IG9wcDEgew0KKwkJCQlvcHAs
bGV2ZWwgPSA8TVQ4MTgzX0RWRlNSQ19MRVZFTF8xPjsNCisJCQl9Ow0KKw0KKwkJCWR2ZnNyY19m
cmVxX21lZGl1bTogb3BwMiB7DQorCQkJCW9wcCxsZXZlbCA9IDxNVDgxODNfRFZGU1JDX0xFVkVM
XzI+Ow0KKwkJCX07DQorDQorCQkJZHZmc3JjX2ZyZXFfbWF4OiBvcHAzIHsNCisJCQkJb3BwLGxl
dmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfMz47DQorCQkJfTsNCisNCisJCQlkdmZzcmNfdm9s
X21heDogb3BwNCB7DQorCQkJCW9wcCxsZXZlbCA9IDxNVDgxODNfRFZGU1JDX0xFVkVMXzQ+Ow0K
KwkJCX07DQorCQl9Ow0KIAl9Ow0KIA0KIEV4YW1wbGUgY29uc3VtZXI6DQpAQCAtODksNCArMTE0
LDIxIEBAIEV4YW1wbGUgY29uc3VtZXI6DQogCWFmZTogbXQ4MTczLWFmZS1wY21AMTEyMjAwMDAg
ew0KIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtYWZlLXBjbSI7DQogCQlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BPV0VSX0RPTUFJTl9BVURJTz47DQorCQlvcGVyYXRp
bmctcG9pbnRzLXYyID0gPCZhdWRfb3BwX3RhYmxlPjsNCisJfTsNCisNCisJYXVkX29wcF90YWJs
ZTogYXVkLW9wcC10YWJsZSB7DQorCQljb21wYXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjIi
Ow0KKwkJb3BwMSB7DQorCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDw3OTMwMDAwMDA+Ow0KKwkJCXJl
cXVpcmVkLW9wcHMgPSA8JmR2ZnNyY192b2xfbWluPjsNCisJCX07DQorCQlvcHAyIHsNCisJCQlv
cHAtaHogPSAvYml0cy8gNjQgPDkxMDAwMDAwMD47DQorCQkJcmVxdWlyZWQtb3BwcyA9IDwmZHZm
c3JjX3ZvbF9tYXg+Ow0KKwkJfTsNCisJCW9wcDMgew0KKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8
MTAxNDAwMDAwMD47DQorCQkJcmVxdWlyZWQtb3BwcyA9IDwmZHZmc3JjX3ZvbF9tYXg+Ow0KKwkJ
fTsNCiAJfTsNCi0tIA0KMS45LjENCg==

