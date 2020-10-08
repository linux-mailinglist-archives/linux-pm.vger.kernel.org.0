Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE12873DA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgJHMNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 08:13:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59523 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725871AbgJHMNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 08:13:38 -0400
X-UUID: 02e867f5f2f248b5a018804d36fe8834-20201008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IpdSCtVXvatiQNKSBOzbfylxRIMTp0VU9q2nP356VtE=;
        b=uHOBksn+jl6VP42/4IgnuI576uy7eiBs1FxX8FXhStv2gk+TG9RetriOhzfEEhMjIqezzS9dudU4jwSsbTBJ/cv4lov1AnaSpJOXMKlx72cSM4zQfXuP3HStIMu4h84c+Q6TsDpygEiHZQdjy0b1C0DBsJ3mOlreXHFykPtINkg=;
X-UUID: 02e867f5f2f248b5a018804d36fe8834-20201008
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 903434589; Thu, 08 Oct 2020 20:13:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 20:13:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Oct 2020 20:13:25 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1] cpufreq: mediatek-hw: Register EM power table
Date:   Thu, 8 Oct 2020 20:13:23 +0800
Message-ID: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
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
dGVrLWNwdWZyZXEtaHcuYyB8ICAgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ==

