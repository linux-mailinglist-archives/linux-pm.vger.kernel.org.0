Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2612F4A9
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 07:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgACGoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 01:44:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:2077 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgACGoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2020 01:44:15 -0500
X-UUID: dccba4411d2f4006b8c35a4d53a4318a-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GEl2IJWtVb7X+Ga7VN/59GHFWgKdMGNmXSnRT3bIOoQ=;
        b=bTBT50Qw/+ulUSRpqsjyMDZXu/TpSdDXJKmnm5n1P802GGBzYpYXwHrYY+Eh259BiSIADUKfj3Zu5ErTOVi4KJ2zEkFuA5AV03NsYzo99gl4tXSHZNjUCNRCk0T2rWn+9Dl9+GG85Us8vp9JZY76J+HMkMRlmnBX7HjxHcOj2XQ=;
X-UUID: dccba4411d2f4006b8c35a4d53a4318a-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 905780266; Fri, 03 Jan 2020 14:44:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 14:43:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 14:44:09 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH v3,5/8] arm64: dts: mt8183: Increase polling frequency for CPU thermal zone
Date:   Fri, 3 Jan 2020 14:44:04 +0800
Message-ID: <20200103064407.19861-6-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200103064407.19861-1-michael.kao@mediatek.com>
References: <20200103064407.19861-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+DQoNCkV2YWx1YXRlIHRo
ZSB0aGVybWFsIHpvbmUgZXZlcnkgNTAwbXMgd2hpbGUgbm90IGNvb2xpbmcgYW5kIGV2ZXJ5DQox
MDBtcyB3aGVuIHBhc3NpdmUgY29vbGluZyBpcyBwZXJmb3JtZWQuDQoNClNpZ25lZC1vZmYtYnk6
IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPg0KU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDc4NTc1YzMxODNhNC4uMDQyZWY0OGYzZWZlIDEwMDY0NA0K
LS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTYwNSw4ICs2MDUsOCBA
QA0KIA0KIAkJdGhlcm1hbC16b25lcyB7DQogCQkJY3B1X3RoZXJtYWw6IGNwdV90aGVybWFsIHsN
Ci0JCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDEwMDA+Ow0KLQkJCQlwb2xsaW5nLWRlbGF5
ID0gPDEwMDA+Ow0KKwkJCQlwb2xsaW5nLWRlbGF5LXBhc3NpdmUgPSA8MTAwPjsNCisJCQkJcG9s
bGluZy1kZWxheSA9IDw1MDA+Ow0KIAkJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRoZXJtYWwgMD47
DQogCQkJCXN1c3RhaW5hYmxlLXBvd2VyID0gPDUwMDA+Ow0KIA0KLS0gDQoyLjE4LjANCg==

