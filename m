Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC8231E4C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgG2MOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 08:14:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgG2MOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 08:14:06 -0400
X-UUID: b37d913ab00a40ac96e0fe0e8144ee48-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yPbxH/LAift8thSoquf90ycyKk8MtgpBzntIYtyOZaM=;
        b=SCG9bOTnIGMuWIaS+z5rkbYD60D+I2U0wolxRaTXO87gMUTAq7vKG6FJuyJsoDTgYqCXOar5vMdhvAE7tZmlvu5Sor1KBz9ZuPWOF2qyeaZViLEiebo0Ug787ZtgoYEWoejiG1RCtk1kGeayiLRrdhHVbn9Cqe+MUv6RDNci2B8=;
X-UUID: b37d913ab00a40ac96e0fe0e8144ee48-20200729
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <lh.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1869565521; Wed, 29 Jul 2020 20:14:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 20:14:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 20:14:00 +0800
From:   lh lin <lh.lin@mediatek.com>
To:     Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     YJ Chiang <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        LH Lin <lh.lin@mediatek.com>
Subject: [PATCH] test_power: Fix battery_current initial value
Date:   Wed, 29 Jul 2020 20:14:00 +0800
Message-ID: <20200729121400.20960-1-lh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogTEggTGluIDxsaC5saW5AbWVkaWF0ZWsuY29tPg0KDQpTaW5jZSBkZWZhdWx0IGJhdHRl
cnlfc3RhdHVzIGlzIFBPV0VSX1NVUFBMWV9TVEFUVVNfRElTQ0hBUkdJTkcsDQp3ZSBzaG91bGQg
Y2hhbmdlIGRlZmF1bHQgYmF0dGVyeV9jdXJyZW50IHRvIGEgbmVnYXRpdmUgdmFsdWUuDQoNClNp
Z25lZC1vZmYtYnk6IExIIExpbiA8bGgubGluQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
cG93ZXIvc3VwcGx5L3Rlc3RfcG93ZXIuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvc3Vw
cGx5L3Rlc3RfcG93ZXIuYyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Rlc3RfcG93ZXIuYw0KaW5k
ZXggNjVjMjNlZjY0MDhkLi40ZjI5ZjBmMDk2ZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bvd2Vy
L3N1cHBseS90ZXN0X3Bvd2VyLmMNCisrKyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Rlc3RfcG93
ZXIuYw0KQEAgLTM0LDcgKzM0LDcgQEAgc3RhdGljIGludCBiYXR0ZXJ5X3RlY2hub2xvZ3kJCT0g
UE9XRVJfU1VQUExZX1RFQ0hOT0xPR1lfTElPTjsNCiBzdGF0aWMgaW50IGJhdHRlcnlfY2FwYWNp
dHkJCT0gNTA7DQogc3RhdGljIGludCBiYXR0ZXJ5X3ZvbHRhZ2UJCT0gMzMwMDsNCiBzdGF0aWMg
aW50IGJhdHRlcnlfY2hhcmdlX2NvdW50ZXIJPSAtMTAwMDsNCi1zdGF0aWMgaW50IGJhdHRlcnlf
Y3VycmVudAkJPSAxNjAwOw0KK3N0YXRpYyBpbnQgYmF0dGVyeV9jdXJyZW50CQk9IC0xNjAwOw0K
IA0KIHN0YXRpYyBib29sIG1vZHVsZV9pbml0aWFsaXplZDsNCiANCi0tIA0KMi4xOC4wDQo=

