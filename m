Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED597C6FD5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjJLN4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbjJLN4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 09:56:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25249BA
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 06:56:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so11876411fa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697119000; x=1697723800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0C0ORECBJTogxYQi5iDF0CcmtgNFNzkwmbMUlUi37Uw=;
        b=eY9jVRqtRQKzQnm8ospk9kjl9u0Rf3ng9X8hvqSbqkQu7SXC5E4oV97gld6FtglXDN
         bPmxyBKJT75Uv/LV83YTJ/MRmW1fohdstXqGjIFcHacnRGkMyEVdVmaNpHFrVwaA4uUy
         sCRrdT93/Wf+RtACLle4zFy+gR0RDPn1ufYmRoRbMvs8y0yksaviuTlBLlUkFHd4M6GF
         39hkbetutxWrmPk8UnFnykkvLWykJJL1DI0dbrqrUxwHWuKcmWWJP9EC1KWrGvecfwDS
         6QLwoD1amzSiPNOY/76nmGtpLvFjoc9d6ht5+LSg37Ajz6slgUBv70uHfHaJL1Z+z92T
         DYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119000; x=1697723800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C0ORECBJTogxYQi5iDF0CcmtgNFNzkwmbMUlUi37Uw=;
        b=X3WM967TJq+acnOg0TwrN/F948qZ2jpKRTRRx47yJ3iU1uc2JfBScBg6+TPoTQYlhX
         lVjC3k46BSa4K9a3UxBfU2Mu/PKLOjUGNY/hZ5r35dXCatdOn99C3S3vwLTUAXmbub3E
         97eA3Ux0oVFAvXrOa1CLp7/hIiZkDFQgjdf38kUu7G6EOhJS7g+qOqsiJfjB2MVhk2Ad
         i9quCx+jkscXG0P9mxYqPCEHyoX35MXt5gMDUH4SRC+Oswcp2IfYsomxvOcRrPbQ441X
         l+APBC9jlv015KxSxD75fc96ZGzJFGGR3ooIE5grXi+4MXNiZzBYtnjzb+faXIoBRfj5
         0S3A==
X-Gm-Message-State: AOJu0YyTaCZPeY/RxDJuZ6FbZzT5+mVuaxW3GYfLjpyL19nDs3AuDU68
        1My4i2lb/aFQEjCTZxBxBysaBA==
X-Google-Smtp-Source: AGHT+IGx31uLy8rL+rFIHO2SmgNtBeARAJKHgBIoVQQzrHsiObna4oUIOfKdc+mZ7sjdKbMaRYMjpQ==
X-Received: by 2002:a2e:9009:0:b0:2bf:fde1:2586 with SMTP id h9-20020a2e9009000000b002bffde12586mr21577889ljg.1.1697119000375;
        Thu, 12 Oct 2023 06:56:40 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id l22-20020a2e8356000000b002b70a64d4desm3572227ljh.46.2023.10.12.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:56:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.6-rc6
Date:   Thu, 12 Oct 2023 15:56:38 +0200
Message-Id: <20231012135638.52674-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.6-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e2ad626f8f409899baf1bf192d0533a851128b19:

  pmdomain: Rename the genpd subsystem to pmdomain (2023-09-13 11:09:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.6-rc1-2

for you to fetch changes up to 767881c470b3140c33795031c4e4d65572731c1c:

  pmdomain: imx: scu-pd: correct DMA2 channel (2023-10-05 00:28:52 +0200)

----------------------------------------------------------------
pmdomain:
  - imx: scu-pd: Correct the DMA2 channel

----------------------------------------------------------------
Peng Fan (1):
      pmdomain: imx: scu-pd: correct DMA2 channel

 drivers/pmdomain/imx/scu-pd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
