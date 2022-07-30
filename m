Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B825859FF
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jul 2022 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiG3KVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Jul 2022 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiG3KVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jul 2022 06:21:53 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09DD17587
        for <linux-pm@vger.kernel.org>; Sat, 30 Jul 2022 03:21:51 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 7so11932666ybw.0
        for <linux-pm@vger.kernel.org>; Sat, 30 Jul 2022 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=e/2GYziRMA8j610MCPuZGuSL/9FDnd3SHdoUReTPCuRdU4yqJJSi7rnss0Hg4s84g5
         QVk2xr46dAUr6+ywloAnQW5C5yzHP+l1yn+J5f8esOCPLwx8nVvL2LXRMUjhaIYTUG16
         G7aP78FyDc6ygvcjLglx6vYeSofalMTa92Z7KczguJO6u8uOxIji2LwDLsZzZIgpyeeT
         W1pemiuuaCVN5LtD3J8NGD5eTI4TkLpCpQH/tki8694gXFeLnRo3s4j0kMn+v7B5vqtd
         wJSihL/ikwiXDqs3zN+Epih+ocHbPbhxoJOIiXLn/fIisgTJfKNl0SjoUv/1bT27Dwi0
         COFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=4fbRxP/EzTA9Clpox58obfp0eofS6L5QQwh317g4Akm7+dBmJLAPwRjO9VyZ6ISLMH
         oHUaVpiiPgoMY2DNRIChMYMnZJ3fnXHEjHhI+N8OVv5EC8vaKxEpqjP2Xs9iU78i4ecZ
         jA4mniehMSJ1TPNZZUY4GWeQRCQnF3kgEP3GsPUD6sHUurqSaKC3rk5kcvT75VsrRTnK
         xeJ0uarJA5jyWJVwJo2TpYi9Lw1yEHTzRlQw4LvQ7XER7mkRA1P+9Br6OkhUgh2OQC9q
         O6J+jP9V7eHs1S1hIc8LtqnabuL6ZkaJv2i/y3T9ql/qkTSj4og+nivynt6TihewHNvL
         NMcQ==
X-Gm-Message-State: ACgBeo0mVwJPYNm8HeZYfdqzTup3LQwhFqXqNokE/XAlPqtwIhHsmfVi
        6knx7eIe2saWPiDQo1aX7ewfTiF1TYIcLBi2nyM=
X-Google-Smtp-Source: AA6agR6fn7bKXIlxVkqFDbyLyHp9pNO6f5wah0pEkTHvNsYK7WB9b21FoScbgMJI2SeuIwbyBfWFK4yXDWmpM69CWxA=
X-Received: by 2002:a25:a0c5:0:b0:676:d67c:1dc3 with SMTP id
 i5-20020a25a0c5000000b00676d67c1dc3mr1460451ybm.450.1659176510752; Sat, 30
 Jul 2022 03:21:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:378e:b0:2e8:83a:d0a2 with HTTP; Sat, 30 Jul 2022
 03:21:50 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan Bikram <susanbikram34@gmail.com>
Date:   Sat, 30 Jul 2022 03:21:50 -0700
Message-ID: <CAGsFf53FfwmFQZzrZUM2v7_K1v3=-ObQX7xx2EieHXT1YqgAkA@mail.gmail.com>
Subject: Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [susanbikram34[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [biksusan825[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [susanbikram34[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
