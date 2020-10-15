Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BC228F203
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgJOMYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 08:24:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727278AbgJOMYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 08:24:38 -0400
X-UUID: 53b883c7ee9d4505861ab6a741f4bcf4-20201015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wdjBNkijPYMMZHKUrWNsISffoBU51QFiBWSakN5H1mc=;
        b=tVO+S55dG4hdO3aOS5+rUpKx6oUoYjMG3xiE9gCuK2jAn5n0UslefEEm0yYd9+RdpqPP5oJ8uQwvIpr3RM3JWDlChJzoZ/LSMhmF5BRkNpmJYR9yDnOl4JB3pIKSmRQr3Sc8JWU9poYRLVqV6Sm6tT8MPiv1DLRGilr2NSzmHRs=;
X-UUID: 53b883c7ee9d4505861ab6a741f4bcf4-20201015
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 845224773; Thu, 15 Oct 2020 20:24:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Oct 2020 20:24:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Oct 2020 20:24:31 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v2] cpufreq: mediatek-hw: Register EM power table
Date:   Thu, 15 Oct 2020 20:24:26 +0800
Message-ID: <1602764667-29009-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 455D77DD171CE2BE108867FEFF583B5EC63FE1669ABAE732CA84722084A09EAA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UmVnaXN0ZXIgdG8gZW5lcmd5IG1vZGVsIGZyYW1ld29yayB3aXRoIENQVSBwb3dlciBlZmZpY2ll
bmN5IHRhYmxlLg0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gTWVkaWF0ZWsgY3B1ZnJlcSBIVyBk
cml2ZXIgcGF0Y2ggc3VibWl0dGVkIGJ5IEhlY3RvciBZdWFuLg0KIGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDIwLzkvMTAvMTMNCg0KDQpIZWN0b3IuWXVhbiAoMSk6DQogIGNwdWZyZXE6IG1lZGlh
dGVrLWh3OiBSZWdpc3RlciBFTSBwb3dlciB0YWJsZQ0KDQogZHJpdmVycy9jcHVmcmVxL21lZGlh
dGVrLWNwdWZyZXEtaHcuYyB8ICAgNTggKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ==

