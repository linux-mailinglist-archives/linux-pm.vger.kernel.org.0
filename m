Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E035F125D8C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLSJYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:24:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5072 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbfLSJYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:24:41 -0500
X-UUID: ec4b4557ab774d8ebf923fab24d03b70-20191219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kMoZXDieEORztJ/hucM7IpRP4DRg2oBPqKa9JoCjaBs=;
        b=ilU1fcMchb4Jb6k/gMAo0yj5LOapSUEZk10ZynTDlQbfqYbKeq6I42ix/5Sr/aDNBLm7dOEXEu89WF/ms5Ji8zD3utjVeeTiV2AI1SWYoixb4d2wISfFje9ukDqRI/J96xnUzsNY+AdbU+qNJ9TrYbAa/IpcfDwU6eXgoTT6tRI=;
X-UUID: ec4b4557ab774d8ebf923fab24d03b70-20191219
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 340960230; Thu, 19 Dec 2019 17:24:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Dec 2019 17:24:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Dec 2019 17:24:37 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND] thermal: mediatek: add suspend/resume callback
Date:   Thu, 19 Dec 2019 17:24:30 +0800
Message-ID: <20191219092431.8935-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TG91aXMgWXUgKDEpOg0KICB0aGVybWFsOiBtZWRpYXRlazogYWRkIHN1c3BlbmQvcmVzdW1lIGNh
bGxiYWNrDQoNCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDEzNCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KDQo=

