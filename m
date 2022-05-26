Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A905351E0
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiEZQNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiEZQNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 12:13:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F10169B72
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 09:13:34 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q184so3612810ybg.11
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=RFKJ2fylOz2dttyjX0OdlQasifQ7WSx+TI76GYq5hpG+xujMfG63SpH2d1JNlW4t+D
         zdw6gKB5k+YSthsSMxPummKcNt7n/NI+s+ZFkwto83WNJkAbDNlYAZsit+GpBv1KaqTw
         A84XGVwLiVs9F1hbtkrJWNQHoYNZbP2biDjkGTN3QOIJ8lkO4kgZ78dDBAvJ/OlTkzD2
         SFZgm9PenROGuf54S8wrECIfUiHSWGQq3+BN0duWdvUEhuC8zonflnCUPr/XfBlOasaH
         ZhBfRQDHvWr8GZKrtc8wLuXXo4JjmnSxFIwFH/U8Caxv0teKyjWe/euoMKoYR8XZV4UU
         m42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=6AD9UiRm3Vq7uskeJzKF5TrVKEzUDWVUuFprBRMVrmlgW8IzM88PhHsxgeEoJHySj0
         FifYRBnB8JsoNnpNl28shwGnnq/an15P2YzKZEkHoRAWv8cXAkWTA68ruXawrvUYJ/eI
         accZX3La3qTrNB9PjzjGeNfN+Y1BuxepbjeUObi3G9srvDI76XIhOIV+M1knvfD0/S87
         CNKMB+WoDdaiV350aokCqS1ewMs+2BV02WWsCur9FbdB5j7sRrvXv/Szc0yTQ/diNVHL
         KoaT0wa+wr8M1+1D5rEFRG87aIu+CWzZp/f3sKgNgVPATg1ajgBx20YJlcZTD3nKdaJd
         ZW1A==
X-Gm-Message-State: AOAM530AOjUfvT93KhHQy3rawSy90fguno7L9n3FxqRAvpPsPBnWgVzb
        5FyrOva6LHSNq8OC42uxIxxoXYCbK6klA8eitQU=
X-Google-Smtp-Source: ABdhPJxn/BID20RVPewk6/wN0FFAttx163LpHyfc4ReDqalDIvYSFc5QWza+LkpwEBYQQ3UIX+iCbgAu5gnfUR1Ecg8=
X-Received: by 2002:a25:7485:0:b0:64f:5cfb:4372 with SMTP id
 p127-20020a257485000000b0064f5cfb4372mr29319954ybc.403.1653581613043; Thu, 26
 May 2022 09:13:33 -0700 (PDT)
MIME-Version: 1.0
Sender: ibrahimvivane65@gmail.com
Received: by 2002:a05:7000:b902:0:0:0:0 with HTTP; Thu, 26 May 2022 09:13:32
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Thu, 26 May 2022 18:13:32 +0200
X-Google-Sender-Auth: muQNnj8sgFpH0Fg1OOus1R4Gt5c
Message-ID: <CAGCMmKdSVCcPQQynDVQ-xoUUQa-hh9-8eG1eZNwrjpTVKyAeeA@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of($
11,000,000.00) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
