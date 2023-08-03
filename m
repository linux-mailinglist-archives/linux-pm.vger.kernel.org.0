Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED38F76DC98
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 02:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHCAZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 20:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjHCAZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 20:25:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4E30E2
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 17:25:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86F296607118;
        Thu,  3 Aug 2023 01:25:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691022344;
        bh=kcaWvIF4OomCBgH6njNWz28itWXo/DorvbXtR8LpvIE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pu2hqRokbMc8lPvljzdYszT0ZGwDlzIbYfW2Y5HV902W6KKEqQ8YlVbYElho9rLvQ
         FfOCxOKXDr6/kxmGBj57FqFVi8b5U+AAugEHBtpBCJFHgwpCZHp3mzWLEWnTILz0TZ
         w0M1BM2b4TjxWMjIX5lh2TbpZjdR8+qmE43gF6bAZv9H7iZ6W4NXjkoVjI8DXFSxnO
         B9Z2HgFlPck1SY2SRO/UZgM6Z3h9m11Ij4/RGFwdfPL5Swd/H24uV8wfxyzmWs8H/a
         uJl5tYGmdsM37/3sKkw2BNo3zDmhJGYP5opMIEwUSItEp7TOjcZHDeppoIJ4Abi6U3
         j5ha00ootgbHQ==
Received: by mercury (Postfix, from userid 1000)
        id 6E6B810603F9; Thu,  3 Aug 2023 02:25:42 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, liwei391@huawei.com
In-Reply-To: <20230802023130.2516232-1-liaoyu15@huawei.com>
References: <20230802023130.2516232-1-liaoyu15@huawei.com>
Subject: Re: [PATCH -next] power: Fix uninitialized variable usage in
 smb2_status_change_work()
Message-Id: <169102234243.232087.4357428988536099183.b4-ty@collabora.com>
Date:   Thu, 03 Aug 2023 02:25:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 02 Aug 2023 10:31:30 +0800, Yu Liao wrote:
> smatch warnings:
>   drivers/power/supply/qcom_pmi8998_charger.c:565 smb2_status_change_work() error: uninitialized symbol 'usb_online'.
> 
> usb_online is used uninitialized whenever smb2_get_prop_usb_online()
> returns a negative value.
> 
> Thus, fix the issue by initializing usb_online to 0.
> 
> [...]

Applied, thanks!

[1/1] power: Fix uninitialized variable usage in smb2_status_change_work()
      commit: 13a0d1088c8fea1565e30a169188b59bdd77759e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

