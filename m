Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CA2FC74F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbhATB7X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 20:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbhATBvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 20:51:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A6C061573;
        Tue, 19 Jan 2021 17:50:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o17so31971874lfg.4;
        Tue, 19 Jan 2021 17:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0Z7h9bg+7HGu4fSvr9LvhKp90jXWDcL2gI3AJjDonI=;
        b=PGIrOj1nZpTfvp1DDH1UrdhWcj3jN6bLf6XpM4jn5v3JiETzTYfZDPItRCvaY/rg88
         lhUy7AhJP0BxI2N+tH8VMhTx+wPZBpkcRwQwxZrMocxr0BOFE6rGt00BFUDkRzMQranR
         17lAqB+KTkOzDB2HrXel9dH5V+TxaRuDefQEeJylk6l+YirRWKDHV5q/Pa/3X3JqeutF
         f+rq+QFxtNIO7WowD4aA+S+YnZd0GDLjOMbU4hEVSD0V44SNwBUTXCfhhj9QWEiUIQkf
         wxgarM/uet9zKlGWXvi3A45DtPuniC9rrvzF9CdAzrZnvjI0dYm/jGpg13OoCeJ0ovXJ
         6sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0Z7h9bg+7HGu4fSvr9LvhKp90jXWDcL2gI3AJjDonI=;
        b=epRMZLaWIeMQcOQCU3h0o7Qzj1HN8Kxe9140nOUKrxTFF/XTC1W6ITJ/ZeiREgg7in
         4HFzo5u9n3S0NAQ+VbbyNjokbgLQfh5SiXBMAkeJ876ETLlmvEE9MrFpwrQzzySJOx22
         2SUtGUNaHdtHnnhXhzwBxAQynh2a0WihPbIzM5iYf4pCIAK0bJWwZvzuuLD5ZeY8JEcp
         uGxReU49UxMp/1+E5xMWREKOSbRaFt9twuuGdJLRH7TXPKEZi7v9jmwpcXGdssY3vG3+
         DBO8IXOu+gxYJTDgESVFDfKZ9TAAs39BI9S5cepMnrtAf2zGCFKRTxvoCedpbwROKCzf
         Naxg==
X-Gm-Message-State: AOAM532hqMSlzyRIfPp9oAC0q5sX/CQXRN6epiERzI+raFmXDwiT6Enc
        lBDON5g0dweR+2eVEz6+F3U=
X-Google-Smtp-Source: ABdhPJy0omEijItkCZZccB/DnERd8KPObDC8xwSGkB6x6hDvMCy3ohbpgdf7F9lGgntW5kFJjO07VA==
X-Received: by 2002:ac2:504e:: with SMTP id a14mr2832014lfm.285.1611107453983;
        Tue, 19 Jan 2021 17:50:53 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id o14sm56163lfi.92.2021.01.19.17.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:50:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/3] GENPD API improvements
Date:   Wed, 20 Jan 2021 04:50:07 +0300
Message-Id: <20210120015010.14191-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a continuation of [1], where Ulf Hansson suggested to factor out
GENPD patches into a separate series. This series is a prerequisite for
the power domain driver of NVIDIA Tegra SoCs.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

Changelog:

v4: - Updated the "Make set_performance_state() callback optional" patch.
      Now the case where one of intermediate domains doesn't implement
      the set_performance_state() callback is handled properly, thanks
      to Viresh and Ulf for catching this drawback and suggesting the fix.

    - Added more r-bs from Ulf Hansson and Viresh Kumar.

v3: - Added r-b from Ulf Hansson.

    - Added new patch "Make of_genpd_add_subdomain() to return -EPROBE_DEFER",
      which was suggested by Ulf Hansson.

    - Improved "Add "performance" column to debug summary" patch by
      correcting the formatting of debug output, which had a superfluous
      whitespace.

Dmitry Osipenko (3):
  PM: domains: Make set_performance_state() callback optional
  PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
  PM: domains: Add "performance" column to debug summary

 drivers/base/power/domain.c | 54 +++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 20 deletions(-)

-- 
2.29.2

