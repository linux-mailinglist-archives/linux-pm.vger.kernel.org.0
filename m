Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C635ADB35
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 00:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiIEWK4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Sep 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiIEWKz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2022 18:10:55 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CF53D3D
        for <linux-pm@vger.kernel.org>; Mon,  5 Sep 2022 15:10:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso6935310otb.6
        for <linux-pm@vger.kernel.org>; Mon, 05 Sep 2022 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=HG/qGKKFC9VUQk6wJ5xw/QeYCmIiXvg/dNPYtzP+tWM=;
        b=CWfFDGl6cSEEUo+Y+sb4jlNeS/tkCfVfmzh1EFWGMqIYsuFkvmcaG6yH7eAoDfq3Hc
         x8m5EM20r+hAr9TYhpbuFsb1Pyzv0Dm4/rcF7hSkptzDniMg9vNfafFiEAg3+kSrA0Gc
         s6Rb+EaA1WhfimQzJhThtUUnwfnM15vjbMlM2d6ARmRsS97tvwtVBf9nuYaKPBsQGFHi
         iGSGHFW2wDZIV5bSktzOYfC5T15ZWkw5HYIQqMIwlj2ZKz2hgmXhaM3Y85/P4ArqPBr3
         TjNCIV1Q6OBbLm7nPwRxugaKONrY1f0iHchzqy4deIa/V5j3YCXtyPAGw83dqNF0UbUv
         mkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HG/qGKKFC9VUQk6wJ5xw/QeYCmIiXvg/dNPYtzP+tWM=;
        b=eKXHNPyteWF76ROJIMYqzk1twBBQhHxFbqZ8SIfaWeLQ78DkD3Y1mYOjWZDETv/fu1
         VTnV7FaNscRyHnCUDkFCwp9owTdwAcZYJVPfsSvznDhEP2K5iNl9BMx6zFfyQ2coHGQe
         a27fkMb9OuY32pP1r1MdWMucNSS03iYRxBoP09gweeQsiX+9l25bYzZg2ihFabrSAj+Z
         XHUzkM4i77TPUq0QeO508Lx9XZD+avZFbDPPo07P02uwBp7RCFqn7lk32975AwU+CZHx
         w+OHVAi52oE3Ux2SQo2yKmFWNTHmVumsUlodNacBmot/fuWsN9I2zyrASuiLKR8wcTpg
         CsWA==
X-Gm-Message-State: ACgBeo1cyGMmrOzohlg5PJdRQO4qS0L64QkFZL8p+LKZgEbzLoElPlMD
        Dj1kI/gEOLEYln8AkK0vBxk5zKockrqnJOaxmvA=
X-Google-Smtp-Source: AA6agR4/O3QUBB0c6HTS9BS1/92LZpD1l+PYcCeyXjD/GqsM7tn+MzlY0AmpzJt7Ta4uIJBkWRwrmxO7uC0HEkbSLJA=
X-Received: by 2002:a9d:798d:0:b0:638:fe2a:963f with SMTP id
 h13-20020a9d798d000000b00638fe2a963fmr21086057otm.240.1662415852901; Mon, 05
 Sep 2022 15:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:60c6:b0:ad:7df3:95b2 with HTTP; Mon, 5 Sep 2022
 15:10:52 -0700 (PDT)
Reply-To: Mrschantal1985@proton.me
From:   Mrs chanta B <ww.noralove534924@gmail.com>
Date:   Mon, 5 Sep 2022 22:10:52 +0000
Message-ID: <CA+zZfmirZZD5imwbCrp43YFCYOWqqwefyKWiyr+g33Aq9ynk_A@mail.gmail.com>
Subject: Dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_50,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ww.noralove534924[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ww.noralove534924[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.7 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear friend

Greetings, I am Mrs. Chantal. I got your contact information from a
reputable business/professional directory. I have a business proposal
worth the sum of 6.2 million dollars, Kindly notify me if interested.

Thanks
Mrs Chantel
