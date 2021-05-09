Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1522C37796A
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhEIX42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 May 2021 19:56:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhEIX41 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 May 2021 19:56:27 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftGU-0007y6-0a; Mon, 10 May 2021 01:55:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: (subset) [PATCH v2 0/4] Rockchip thermal YAML and RK3568
Date:   Mon, 10 May 2021 01:55:06 +0200
Message-Id: <162060449717.1266480.11669057370287574016.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210506175514.168365-1-ezequiel@collabora.com>
References: <20210506175514.168365-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 6 May 2021 14:55:10 -0300, Ezequiel Garcia wrote:
> v2:
> * Convert to YAML
> * Fix rk322x.dtsi
> * Add comments as suggested by Daniel
> 
> Ezequiel Garcia (3):
>   ARM: dts: rockchip: Fix thermal sensor cells
>   dt-bindings: thermal: convert rockchip-thermal to json-schema
>   dt-bindings: rockchip-thermal: Support the RK3568 SoC compatible
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: rockchip: Fix thermal sensor cells
      commit: d5c24e20daf09587cbc221d40be1ba92673e8d94

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
