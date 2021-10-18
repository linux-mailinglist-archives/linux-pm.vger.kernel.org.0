Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5843263C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJRSXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 14:23:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhJRSXT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Oct 2021 14:23:19 -0400
Received: from p508fdda9.dip0.t-ipconnect.de ([80.143.221.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mcXFo-0001cz-Ne; Mon, 18 Oct 2021 20:20:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        amitk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rui.zhang@intel.com, linux-rockchip@lists.infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: thermal: allow more resets for tsadc node in rockchip-thermal.yaml
Date:   Mon, 18 Oct 2021 20:20:55 +0200
Message-Id: <163458113680.651054.7196028816120992133.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
References: <20210930110517.14323-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Sep 2021 13:05:14 +0200, Johan Jonker wrote:
> The tsadc node in rk356x.dtsi has more resets defined then currently
> allowed by rockchip-thermal.yaml, so fix that in the documentation.
> The driver now uses the devm_reset_control_array_get() function,
> so reset-names is no longer required, but keep it for legacy reasons.

Applied, thanks!

Fixed the patch subject to the regular prefixes.

[4/4] arm64: dts: fix resets in tsadc node for rk356x.dtsi
      commit: 5c9e66c6b75a754025c74bde7b7a6c52674d8aa1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
