Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14C55EFA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 04:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfFZCgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 22:36:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40411 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726623AbfFZCgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 22:36:42 -0400
X-UUID: f2c90382853b47018fe70e3f259df81e-20190626
X-UUID: f2c90382853b47018fe70e3f259df81e-20190626
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 654526010; Wed, 26 Jun 2019 10:36:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Jun 2019 10:36:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Jun 2019 10:36:26 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] test_power: Add CURRENT and CHARGE_COUNTER properties
Date:   Wed, 26 Jun 2019 10:36:26 +0800
Message-ID: <20190626023626.27603-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190625223537.6dlcooifqfs2rv2b@earth.universe>
References: <20190625223537.6dlcooifqfs2rv2b@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EA14E0A17234A27FDBB97C8C70D467965C7AACC2B838C3E3EB0727BD39C702C42000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Sebastian,

Thanks for your review and helpful suggestion,
Since our platform is relative simple, I just miss the part you refer to.

I will fix them in patch v2.


Thanks,
	Lecopzer
