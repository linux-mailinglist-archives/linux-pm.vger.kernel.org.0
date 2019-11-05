Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B475EF6B9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbfKEH7h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 02:59:37 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35392 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbfKEH7h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 02:59:37 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iRtkO-0006JG-1g; Tue, 05 Nov 2019 08:59:28 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     amit.kucheria@verdurent.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: Re: [PATCH v1 2/3] thermal: rockchip: Support the RK3308 SoC in thermal driver
Date:   Tue, 05 Nov 2019 08:59:27 +0100
Message-ID: <6051603.qgEBi1WluI@diego>
In-Reply-To: <1572923846-23310-3-git-send-email-zhangqing@rock-chips.com>
References: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com> <1572923846-23310-3-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 5. November 2019, 04:17:25 CET schrieb Elaine Zhang:
> RK3308 SOC has two Temperature Sensors for CPU and GPU.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


