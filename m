Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2920254A3E5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbiFNBzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 21:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350061AbiFNBzD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 21:55:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063831533
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 18:55:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m25so8083968lji.11
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3cen5UaSuX82MKO9ajMGtvkdC1kiOlsqYqhDQbbgkJ0=;
        b=gpHiHZ4zbol0lSe1+PvPomuZlj/Atf5XniZJg7UySpWqyXBs3+lbsW2uWrqbkDJnwj
         UvjKwKDV3q/lMc+suQ25QFYpFR/v1KvA3C/NTpkk0YQLPuaiAJ8WizpEkrUB1HlRZqmp
         rom+kkPveImW1UYU2eBvefXiWXjF3IVX5OZAHfi4V9BrrV7w3gHow0EY1INIVO7G1pYS
         ellOsUtSA+vhUgKJdoZU5LdxYS2kCg/+Ppu1GSBhWgwv65DnM/ue/xEvSkNlIE5fbMdU
         JXHkkpbD59o61r2i/T95oCcp0IAYATct8Ip4bpcVJ5U5DugxZroXHb3xMqSRYdAevhHz
         H41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3cen5UaSuX82MKO9ajMGtvkdC1kiOlsqYqhDQbbgkJ0=;
        b=8GHX7ek9zH0vz6qTubFy/h18Bq/8557s6ufT5bTn+iY1AsBzLRL6UJi5pQynesKfmc
         X2L/6J35WkzIjCyT4qolphaxx/otWMkxVSaz+ZQLT/foFEefxkdRKNCv+IjUhN2/Wrk7
         teXooc/2pb3crcBjnT32HORJIFqKcpIS2/m6RkVW0SeQcm7Qnxjwucc+pLdBnEY05wqr
         NYaDxWQbzrqKfI8CW5YD7coQ+Z/Xew6AXw9nEoQZ3+Uo7x5aIb7hwpzOa2LAy0ALdB9Z
         CeG/QV6HTqx922PqHeWm7x6BCpkiNCw6CD8ePJHEFvC8Ig7oZdF1r7GBp/YRaul9DK/E
         fxuw==
X-Gm-Message-State: AJIora9VrkOMYZ/40J4sGtFf6ZGVCFGp6jQOmhZdbwHsFvm0r3dif38S
        G0fV+CaV2ONDi76E1zhIDfa+6Z+MXF0lO6JFoilg/rb4
X-Google-Smtp-Source: AGRyM1vCKXE0fs0LPg5NTSylUfQ4YtolKWDSLRqPfVVNvJz+emHz//51rNU/5hnLkxE8/lwOCk7fR8C8mfhg/EyIDOg=
X-Received: by 2002:a2e:99cb:0:b0:255:7194:8089 with SMTP id
 l11-20020a2e99cb000000b0025571948089mr1171410ljj.307.1655171700361; Mon, 13
 Jun 2022 18:55:00 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 13 Jun 2022 19:54:49 -0600
Message-ID: <CAMMLpeTRZnpQ8b6puhHeKaDgzW12ZM_g3nAWjVP71HbSaeHktQ@mail.gmail.com>
Subject: How to identify the primary battery (for Wine)
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Huw Davies <huw@codeweavers.com>, linux-pm@vger.kernel.org,
        Wine Devel <wine-devel@winehq.org>
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

Hi Sebastian,

I've been working to improve battery status reporting for applications
running on Wine on Linux. However, we Wine developers are not sure
what the best way is to determine which battery is the computer's
primary battery. Could you take a look at
https://gitlab.winehq.org/wine/wine/-/merge_requests/134 and leave a
comment there or on the wine-devel mailing list?

Thanks in advance,

-Alex
