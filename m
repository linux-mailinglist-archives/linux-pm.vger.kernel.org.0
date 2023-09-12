Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B329879D8FE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 20:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjILSre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbjILSra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 14:47:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3291705
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 11:47:26 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2437866072F9;
        Tue, 12 Sep 2023 19:47:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694544445;
        bh=RLTA2yYGyaVFSwgXj7BfKJslg6cqOJ4LWY3M4BMNziU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=dSTNTSaqX2nna4jSFCFO+jGjc04l2uoO8pz4ftKfAbMTPDLQbpYX5ueF6fGXTPh1l
         PDJrlDAE/xlTbhQAiyVidVDBNPDyHtOcwHMyDB0R5feQa75jQkfO3nfUIlODCKu3uR
         GpmEILTcFC3PHyZGfFdHAibA/04vaWn/gJ3bBlv7qUcSZTU5ZURcILEaECfJiyUlJ0
         8o6+qz4c5do8phZQvlcSPV1z0+2yeTeHSY8FC9ACkf7K3BxtRIeiLoPuDqHXk2w3LK
         n+g6oX3obLylF5IvioRl385hsPDAmu3ykjovoTBFpA0AJ+6BYibCB02qJgQ7PKX3Rv
         crcCAreSbmdUw==
Received: by mercury (Postfix, from userid 1000)
        id 52A3D106098A; Tue, 12 Sep 2023 20:47:22 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230731113959.1957820-1-ruanjinjie@huawei.com>
References: <20230731113959.1957820-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] power: supply: 88pm860x_battery: fix the return
 value handle for platform_get_irq()
Message-Id: <169454444231.501125.1249338411901996622.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:47:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 31 Jul 2023 19:39:59 +0800, Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0,
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> 

Applied, thanks!

[1/1] power: supply: 88pm860x_battery: fix the return value handle for platform_get_irq()
      commit: 6eca10a1c2e5c5edaf92d5a9d1bcf415456369b7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

