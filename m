Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76355E9F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 04:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFZCdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 22:33:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726442AbfFZCdu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 22:33:50 -0400
X-UUID: 8e71112a79744f0a83ede56d40963069-20190626
X-UUID: 8e71112a79744f0a83ede56d40963069-20190626
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 126400136; Wed, 26 Jun 2019 10:33:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Jun 2019 10:33:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Jun 2019 10:33:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test_power: Add CURRENT and CHARGE_COUNTER properties
Date:   Wed, 26 Jun 2019 10:33:40 +0800
Message-ID: <20190626023340.27492-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CFBAF083ABB497CE6F86A02071AE9317F7859796289DCDD363CD138D366143862000:8
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
