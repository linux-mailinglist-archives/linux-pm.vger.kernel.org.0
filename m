Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BB5351DD
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiEZQKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiEZQKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 12:10:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A85DA77
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 09:10:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3043b3f7d8fso10484887b3.8
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=hFH2SFkLGW2dUFtTh5SNzpwC8JRSdxtLPpsA3sh3OroiI/xz+Nsp9Ms/HuaRUUMVzv
         kZA1rj7l7+4thfHRFNfUA/OPYioTFDaen6ntsR8wv/PdBEhgd2D6A1ECD7WIxYYpweaW
         xP9/ISIOTN8oJKSVm01msoaIWy+gyagimKYbUxD9rA1FpKP9vONuqQYHbAP9c2V06MIC
         hI1+Hjx48SIiyk8Vga/VBzkoDvvM5FqvM6uOBYvef/c0A4ZK9YC4NZgpIPGHACLmfec2
         exdzG26REvxDcUR2qUAI1WAh6oRZ6kUwkLseUY9huelfjFjMtMkIBU3R5taLJAgVC6uC
         AR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=zQhzEHjqZSEWMxUALWxfIPycUR5FZVmF5sG1moBqaE7NssRKz9mP/ccJrWTld3bQFK
         JGpsevuENQ3V8EUY3PdBd1HQNF+yrNXzbNJ2jdvXaWJg645rreAaX3oaRVlG+lpR5nDs
         FNMecBttxzcPhtsLNb3jqn+RNHUNWKL89ezDzRcUzk953V4PP1qVuE0xW0EL5/69kjuA
         3Ixru9mT6IcivnSlnRgaEVcFRjtYu2nfnOLoGMhzDm7tXsviwX5rwV8T5V0hdQLlLo/Y
         Yg4vvu0rTIFihxSJRgW0HVqgFPL7O7FwPZgvc3DRm2cqC/uAc7IyG9PAzxaMAhiCnJbF
         oMwQ==
X-Gm-Message-State: AOAM532kdUz6C5a7KE44JYCFrHBe3ePn3TewWE6d3PXDUqcAlSpSRcO8
        KcoHMKSlydHvutw3YUEjxp8xAXV3ubONBUdBSzo=
X-Google-Smtp-Source: ABdhPJxe42JY53vFdm51W/+EkNjfLmn81ZvGZKw5Sfx+PqAWNYJv6LndF8HsG5CipdGGc2B9ulxUwPb3EuJFYhMBcTY=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr38104502ywc.208.1653581446949; Thu, 26
 May 2022 09:10:46 -0700 (PDT)
MIME-Version: 1.0
Sender: ibrahimvivane65@gmail.com
Received: by 2002:a05:7000:b902:0:0:0:0 with HTTP; Thu, 26 May 2022 09:10:46
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Thu, 26 May 2022 18:10:46 +0200
X-Google-Sender-Auth: 0oyEaPR6hNhs1eYLSO05iuuKOwA
Message-ID: <CAGCMmKeXT46mfp2pbh3zbG48myFj5aQmcFixeuy4aoe0gOtjeQ@mail.gmail.com>
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
