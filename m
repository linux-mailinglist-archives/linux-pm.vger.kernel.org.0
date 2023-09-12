Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E679D8E2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjILSoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 14:44:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AD10D3
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 11:44:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 813CF66072F9;
        Tue, 12 Sep 2023 19:44:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694544256;
        bh=amGMocaM6JTPSRmhEjakxJbtMoSQe+qtzDOR9wcNXKE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hIR3LifOqR8iiqGIj4knrmQn0IklksmSUMk6w8Ws0odWlnpVRnHpUCR0qYiG4z3Zr
         Ayv4ulxr9J6aYYPR7CK1iTSUKt7oCkmvLZJehXoHh2BXdZEGTv4qFftMC6GR7Q9ojD
         iFo4guJ85kAZu2Zm0TtenDwVs8O0vlwck8uV628dyasV6J5f9RLqs4mA46HnO18WAx
         cT5j6ILK7Dj36Hgvn196xu79Ii6EqXz8rR4aqd6Vh8us0qOnRzK3+DLfjDXNgunu9+
         W2uBz/UfcdIP9fEBHlK36gtt5p2XJM9yNsP1LFVNPdqZWgsgZNuUaa3nmZkPBQr9+S
         ZA6q6vgMw/9vg==
Received: by mercury (Postfix, from userid 1000)
        id D1B65106098A; Tue, 12 Sep 2023 20:44:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pm@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
Cc:     sre@kernel.org
In-Reply-To: <20230807131951.3443880-1-yangyingliang@huawei.com>
References: <20230807131951.3443880-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 0/5] power: reset: use builtin_platform_driver()
 to simplify code
Message-Id: <169454425383.496807.10808633873031554477.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:44:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 07 Aug 2023 21:19:46 +0800, Yang Yingliang wrote:
> The driver init function doesn't do anything special, so it can use the
> builtin_platform_driver() macro to eliminate boilerplate code.
> 
> Yang Yingliang (5):
>   power: reset: st-poweroff: use builtin_platform_driver() to simplify
>     code
>   power: reset: msm: use builtin_platform_driver() to simplify code
>   power: reset: xgene-reboot: use builtin_platform_driver() to simplify
>     code
>   power: reset: axxia-reset: use builtin_platform_driver() to simplify
>     code
>   power: reset: syscon-poweroff: use builtin_platform_driver() to
>     simplify code
> 
> [...]

Applied, thanks!

[1/5] power: reset: st-poweroff: use builtin_platform_driver() to simplify code
      commit: 70c81c37cf252798bef5fe047a57129ff6a2b31b
[2/5] power: reset: msm: use builtin_platform_driver() to simplify code
      commit: 4e579a5c68d88b340776c2270659de111f8923f6
[3/5] power: reset: xgene-reboot: use builtin_platform_driver() to simplify code
      commit: 764db16149ec6128da548aac54a16b651461fbc8
[4/5] power: reset: axxia-reset: use builtin_platform_driver() to simplify code
      commit: 6a7f7f27e2c766f36c6bd948a5de91ca2703c2a4
[5/5] power: reset: syscon-poweroff: use builtin_platform_driver() to simplify code
      commit: 5b69b5f209b7a6d21329b14b533b390fff6895d5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

