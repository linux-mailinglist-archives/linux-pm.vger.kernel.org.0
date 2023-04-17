Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845336E5052
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 20:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDQSkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 14:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQSkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 14:40:23 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF146AF
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 11:40:22 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a26so2732344uak.5
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681756821; x=1684348821;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDcTWIyirmo+yE7wUM1JKiiq4P9AP1X56Jfg4GHpDqw=;
        b=UQTNZ/ZwirAaCYzzThL+au97VkUTmWHe7+tQYSQmiJHWWel2wxmpX4IiDJ9xGedgTf
         RDfxuW3UPTOh6D60TZ0aztp8Ham71gEcoZZAC96lOnnW3xijvKkUedsUNQFEjTNo6iqR
         v6ZuckvqjCmcHfOf9gyE1uJ8X3WCTX4qKshyqHwqj+m7TERT7AZltqaibuHWLoVxaRjB
         dacmXI3cODLOOTkDeGpCSZ7xsGkrmnuZ94PTawunoeojAC3bAuC7GDbxI6NfIK1w+o4A
         UhdijxXg06qbhJW8DGKShdY9p7UaDXnzYbt+V7w9I8S/iAHNM3pNoK26nDfKJJmw1qDv
         w6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756821; x=1684348821;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDcTWIyirmo+yE7wUM1JKiiq4P9AP1X56Jfg4GHpDqw=;
        b=byKoGZ2gOukcKl7iLwCtkJOB3TCCKu/wzGL+sHU5XraGZA603AE/oOCZqpZV2Y820J
         lD6CqwVTf5jZQdp/QCAQBLCvk4lqI3M4qh+efUV0ZCcsf2smUY8lsmPZkS+mwmcsm8q5
         iKp7pq4XCA/8Wk+5BoiMdwdJb+kQn1EnYuKA5CY51HNe0t3RKoSzPgs/BgvHNppey8/I
         JPIO+is2iRdXeJs6q6ujjPepQzLBWc8M+MXpO4wQIbRkE2qRtd8k+j6ohTKaapWdFA+X
         eKLjQE3LbKKVgjgU7COZfnwqx9rf+5Es9y6uOZNlzE8tIiuO9/w02my5SeIZ/KPLX4JN
         fKFg==
X-Gm-Message-State: AAQBX9e1j6R1uZvV9CdIP2hbcM4EvefJKEYMg70s05OfHS1jLmUGcDw+
        eDjidSTkIWisE3y9482nL9ceeymD5C7hf746Jw4=
X-Google-Smtp-Source: AKy350a9fJIzY0qHfC1wDrCjTL/lR780q7Wn1YKfF4vfHAe+aCTtduJEiszCxfvBGtrQemI0siMoZAI6mysBFXepwBA=
X-Received: by 2002:a1f:91d5:0:b0:42d:7181:7c63 with SMTP id
 t204-20020a1f91d5000000b0042d71817c63mr8726004vkd.1.1681756821403; Mon, 17
 Apr 2023 11:40:21 -0700 (PDT)
MIME-Version: 1.0
Sender: mellisabamba40@gmail.com
Received: by 2002:ab0:6999:0:b0:689:a8c0:29ff with HTTP; Mon, 17 Apr 2023
 11:40:21 -0700 (PDT)
From:   =?UTF-8?Q?=D0=BB_Denis_Malo?= <denismalo92@gmail.com>
Date:   Mon, 17 Apr 2023 20:40:21 +0200
X-Google-Sender-Auth: 1McVn5jv_q8kZwfBz83UGFoW_Ws
Message-ID: <CAFrrkaqrisX8Wzw-K5fddK2VA9Z5h01PbNNJ1Jhoai4CPRFK7w@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Dear,

Be informed that we have received an approved payment file from
FEDERAL MINISTRY OF FINANCE in conjunction with International Monetary
Fund (IMF) compensation for scam victims and your email address is
among the listed victim's.

I write to inform you that we will be sending you $ 5000.00 USD daily
from our office here as we have been given the mandate to transfer
your full compensatory payment of $ 800,000.00 USD by the
International Monetary Fund (IMF) and FEDERAL MINISTRY OF FINANCE.
Your Personal Identification Number given by the I.M.F Team is
CPP0920TG. Here is the payment information that we shall be using to
forward your daily remittance.

Sender's Name:Cynthia Eden.
Amount: $5,000.00USD
City: Lome
Country: Togo

NOTE: The MTCN will be sent to you upon your response and confirmation
of your receiver information to avoid wrong transfer.  We await your
urgent response to enable us proceed with the payment.

Our branch manager Miss Cynthia Eden will direct you specifically on the
procedure.


Your Faithfully,

Miss Mellissa  Bamba
