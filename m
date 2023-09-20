Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5F7A8CFB
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjITThz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 15:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITThz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 15:37:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342D94
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 12:37:48 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F54466071DC;
        Wed, 20 Sep 2023 20:37:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695238666;
        bh=4kCmyZjZfzjMm7zU+JoG32Hr77OlRyQxFWHIgzbNjBk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z4LxMaS61ajeWoWvezdudOaNgVyVUNx8qCKb7PzlFbdG5ZPBLOiuAVGzzkMwttaFS
         nslMw0NfeMNlWn4VAHxZsT16FdIDlkSfCCojXVoAlGIRUvIpal0sHo93KrgqgnbT2E
         ui/HEVEYj78UkezZ3IjxCiufAnXaqX3FpZMGEwvANUTKtloarLVJ0HEnkZf0cJCr07
         0F9J8ZSmRYKjrH1J7bm5aZCB3qKQ84wMpf8Ld/bcb7GbQQ0hNrLaSo0kKpdSVVb0LZ
         o9glZgDrRiU86gzBSkMZGX6dD1HLdgo27K1UeiRU36zg26lovKEBLwhyzpfagn7pJe
         YKSRxyvKPvdeQ==
Received: by mercury (Postfix, from userid 1000)
        id ADA6D106091E; Wed, 20 Sep 2023 21:37:42 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Cc:     linqiheng@huawei.com, sre@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Dan Carpenter <error27@gmail.com>
In-Reply-To: <20230920145644.57964-1-macroalpha82@gmail.com>
References: <20230920145644.57964-1-macroalpha82@gmail.com>
Subject: Re: [PATCH V2] power: supply: Fix additional refcount leak in
 rk817_charger_probe
Message-Id: <169523866268.1275007.8369404591354627765.b4-ty@collabora.com>
Date:   Wed, 20 Sep 2023 21:37:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 20 Sep 2023 09:56:44 -0500, Chris Morgan wrote:
> Dan Carpenter reports that the Smatch static checker warning has found
> that there is another refcount leak in the probe function. While
> of_node_put() was added in one of the return paths, it should in
> fact be added for ALL return paths that return an error.
> 
> Changes Since V1:
>  - Use devm_add_action_or_reset() to call of_node_put() instead of
>    calling it in every single error path from the probe() function.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Fix additional refcount leak in rk817_charger_probe
      commit: 488ef44c068e79752dba8eda0b75f524f111a695

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

