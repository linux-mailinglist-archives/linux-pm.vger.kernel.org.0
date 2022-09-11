Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F75B4C8D
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIKH6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIKH57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 03:57:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99E03AB3F
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 00:57:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b35so8635943edf.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=qZ1BuQJx28wMXvsoVBMqJc5IKl69IQm9ZUTwaee9k38=;
        b=WgtmVoxKYbKvYLatIH2oEI8qOXRR9PAzliGgj7jZqZZIJZ8nCi8KsueCgYszUMupU8
         UwSjTZEb99Dod7HitrRQPf5uqihg6BKmOgi0/+niEcemlke1m9SZPecYWFh0mWwqYEXc
         pDXSuaSUCjQNiP4QSfCOJmLf6Xbcamp5qjeWoI/ShH3b01Alt3C0YtjV3NYbX4Y7uE9v
         09gpFgwcLLEoKSMP/hXrBc7u9cISRnLrpkSrZz0jpIhK18QCgWSHAtVU7DaBMCVeA/B2
         grhB4ATtKtP4zSyZA/VRlqGzNCxyB8Ih0Z7nnIQPjYMtpBNQCCsqW3EX4SgsjbEp8XWf
         SUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qZ1BuQJx28wMXvsoVBMqJc5IKl69IQm9ZUTwaee9k38=;
        b=oXiJnKET2tlHSrvrvdlT6RllbNeKXtzS2Ilp7SoZsJ9tLr+KayjVYbtcHrg258lXW/
         GBRqEelTSV6fjiCA/I1Wt7XxVIbFaK21ZaHb+N6PNW3h0UAaeEIit8hnw/ift0SnHMIX
         O3B2bGtWWkNLF8kDYtGC3t0I+bbCMxQoYQJCYrz0+1C8lyypEmEvGLo3IXZfXmQO7rD6
         /7zWrS1wwBi5FBkeVgdKE2ljbReHKcMfigmCaw8j1638t8gsWwBhziE0yP/c6SWwd/xC
         IXm3ofqcRLnbytua+WGrUHlTdt6RG26sMTZ+7k0sB1+mbfJu58ScYm0JeNevOO+P5r10
         ChDQ==
X-Gm-Message-State: ACgBeo3ofsRAGnBd1W5SBjyrtIzanWzMqRuhVKYbMPpQKOPlmDWjJvrY
        QPKVrjcPUpOoQfPq7utFKTMIyK+es98BbDmf+N1w/WahOyM=
X-Google-Smtp-Source: AA6agR7+osthOjywaVGsAmf1PyC+ZtU4/m5wHWEsagoc3jvXaEaoEmgsSjVgRz4rqRsCvq3hNm6gXOMKQbc+fKrRI3A=
X-Received: by 2002:a05:6402:501d:b0:443:1c7:ccb9 with SMTP id
 p29-20020a056402501d00b0044301c7ccb9mr17954834eda.101.1662883077113; Sun, 11
 Sep 2022 00:57:57 -0700 (PDT)
MIME-Version: 1.0
From:   Xhivat Hoxhiq <xhivo97@gmail.com>
Date:   Sun, 11 Sep 2022 09:57:41 +0200
Message-ID: <CAGtpHi=f1+HCL+4kbfYGCC+qrLZasrpdT4peMF6t8-h-5h8KWA@mail.gmail.com>
Subject: Is Tigerlake Missing From intel_idle?
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

I noticed that there is no mention of Tigerlake in the intel_idle driver.
Is that by design or is it actually missing?

Thanks!
Xhivo
