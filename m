Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698C079D951
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjILTIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjILTIY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 15:08:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7E912E;
        Tue, 12 Sep 2023 12:08:20 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD9D666072FE;
        Tue, 12 Sep 2023 20:08:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694545699;
        bh=k9DYozT5l7PivHowQJYTVyRYgjWYHwkHa0RiNqpwDd0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Uiwls1/86E0lOt4lSEP9i8YtiFuKm9FXhbauZSBK0VeKhAeDUtPKnXehozGMg2ea0
         RPTbvnAQPbDvixbKO/KzOnvKkX9JzSCAfvk9vxKiD4gNMLXBUpRdFPjB42u8m48qdy
         5s58yFWLmvB2C+hctYNVT3D8IXwvWmOS3zh3xYHvaGBcomRpiyWDZiqASYnNV9ptH8
         Lfr4Rg65x9xy/lfoo1jqjZsn1L2c91f6+6YXPQ81lTeNN3+IReewO1jjJdqDvSkKwR
         /dk8R+xhfdaoBo9BcrZMx1pUUNFttL7xMWYaXbd3yidJTLuhr5iCjDYpaYwHyWdJzx
         lrjEC91lXimgQ==
Received: by mercury (Postfix, from userid 1000)
        id 56D6C106098A; Tue, 12 Sep 2023 21:08:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230727113550.2599335-1-ruanjinjie@huawei.com>
References: <20230727113550.2599335-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v2] power: supply: Remove redundant
 dev_err_probe() for platform_get_irq_byname()
Message-Id: <169454569333.510054.8343708350305953046.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 21:08:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 27 Jul 2023 19:35:50 +0800, Ruan Jinjie wrote:
> There is no need to call the dev_err_probe() function directly to print
> a custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message
> in case of a failure.
> 
> 

Applied, thanks!

[1/1] power: supply: Remove redundant dev_err_probe() for platform_get_irq_byname()
      commit: 389405146ca11d24f85b3277121a58f98a926a28

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

