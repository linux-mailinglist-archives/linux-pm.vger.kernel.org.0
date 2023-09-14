Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6DB7A0983
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbjINPmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 11:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbjINPmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 11:42:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4399;
        Thu, 14 Sep 2023 08:42:04 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C472660727E;
        Thu, 14 Sep 2023 16:42:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694706122;
        bh=V7wDvDebdUM7F9vY7IpTpX+buKBL53iWsprspIKnXO8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LWcNGGCPfjXWC3vj0fWYgUy7s7Sd5U8POENlJ/RTGecu35D//MMAZkd/ET7oeN6R9
         NCUPbNfkMKdUhvvWjEzOmAvT8KE5jHLudh+7kEllRQxDFURx7lNLfvnMyi3mUCNBQu
         n55PAedpsLBC5VpNwhkGWS9fs5PVA7W9nIPzkZhRUYJmYG7vk3yxyE1LGjA4OmXlXF
         MB5M0A2ma9YSMmQh0TLUYRftPWWCzMjnv0p4Bn9XrwRaoWPOWuVeREbXMSVgMkoJqZ
         WQMKUYe1K9JsJmUNgCieBDtsOYgD73LtxvZiC6QHQJmFZZsoXPg3yL/vQwSZrmr4O/
         qqXz25fe5XCEw==
Received: by mercury (Postfix, from userid 1000)
        id 6AF3D106098B; Thu, 14 Sep 2023 17:42:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <687f64a4-4c6e-4536-8204-98ad1df934e5@moroto.mountain>
References: <687f64a4-4c6e-4536-8204-98ad1df934e5@moroto.mountain>
Subject: Re: [PATCH] power: supply: ucs1002: fix error code in
 ucs1002_get_property()
Message-Id: <169470612041.705375.8849721685240022082.b4-ty@collabora.com>
Date:   Thu, 14 Sep 2023 17:42:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 19 Jun 2023 12:44:17 +0300, Dan Carpenter wrote:
> This function is supposed to return 0 for success instead of returning
> the val->intval.  This makes it the same as the other case statements
> in this function.
> 
> 

Applied, thanks!

[1/1] power: supply: ucs1002: fix error code in ucs1002_get_property()
      commit: e35059949daa83f8dadf710d0f829ab3c3a72fe2

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

