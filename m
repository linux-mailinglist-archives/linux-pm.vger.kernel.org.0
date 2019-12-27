Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D404B12B26E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 08:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL0HZh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 02:25:37 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31976 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbfL0HZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 02:25:37 -0500
X-UUID: cc95fa33284c46f0bc9ef4dc1262f116-20191227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Cf2QhICm8jgqgV69uk2tL7NwWEZjvfxdhHJdjjhmiyA=;
        b=VaAGN2wH6YUGOQ604wyTPzkd0RXIkA5ZHShCGWuj1KhlMdOhaYWkYSRK7HdUI00qxycFDtd7m4ugqOOLy7wTIYC/jm0oiZJQqFhHQWs2uuOjF+sR6XJ+t5i4f3rW1bWEiYJMLVxWvQVIj6c0cr2QSiuH8flNMIUodoeQGRzicIg=;
X-UUID: cc95fa33284c46f0bc9ef4dc1262f116-20191227
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1228658762; Fri, 27 Dec 2019 15:25:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 27 Dec
 2019 15:25:14 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Dec 2019 15:25:58 +0800
Message-ID: <1577431473.32039.14.camel@mhfsdcap03>
Subject: Re: [PATCH 8/9] memory: mtk-smi: convert to
 devm_platform_ioremap_resource
From:   Yong Wu <yong.wu@mediatek.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
CC:     <ssantosh@kernel.org>, <paul@crapouillou.net>,
        <matthias.bgg@gmail.com>, <rogerq@ti.com>, <tony@atomide.com>,
        <lukasz.luba@arm.com>, <kgene@kernel.org>, <krzk@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <jroedel@suse.de>,
        <evgreen@chromium.org>, <rfontana@redhat.com>, <digetx@gmail.com>,
        <pdeschrijver@nvidia.com>, <john@phrozen.org>,
        <alexios.zavras@intel.com>, <sboyd@kernel.org>,
        <kstewart@linuxfoundation.org>, <info@metux.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Date:   Fri, 27 Dec 2019 15:24:33 +0800
In-Reply-To: <20191222185034.4665-8-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
         <20191222185034.4665-8-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CEF061E20910937DED535D5F798BA0EED8E7FC212D9D8E7E72D4D38ACE506EC52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTIyIGF0IDE4OjUwICswMDAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBV
c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgdG8gc2ltcGxpZnkgY29kZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPHRpbnkud2luZHp6QGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxMSArKystLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KUmV2aWV3ZWQt
Ynk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQo=

