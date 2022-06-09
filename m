Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A170545315
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiFIRgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiFIRgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 13:36:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0692D9AF4
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 10:36:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1772184pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2022 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8d0a50vlXPwK/evqvKND5Qkww0VWt34LxBu4KEjcCqk=;
        b=mBWkbCkHm6C1SNvMBjj+j6cEPOa61p9SJsey0F0Cv9c6q64zIhkL2NWcUDWOWBgQSE
         3hvcY8aJJ5CE9js7qfPuSxMRdp+PwJ+RGcFhoobDiPqPhmjlwjveTOq6h9e9c9fvdKjJ
         xaqPS9/TTtxnbdCXlDqjOWrGzSa7YFugpey6R5VEvIrda02aLHk/NUCA4UTANscwIKHT
         lyoYQZOrkLJEe6gt0kjFfKNxD3I5RxjgWeCtZ8r4XiWuDAQ2omJVomah7Vr6YmV5+Yg8
         AaLInB+EnpNjsXX2WMHfsJCFn440O3yoSgojqFXjnc/9Ep134YTgCYC0qUWjvsQvAypi
         Pfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8d0a50vlXPwK/evqvKND5Qkww0VWt34LxBu4KEjcCqk=;
        b=ylW02gCEjXRC5jjQsHvpbZ6eaHErDfffHOZxnyxJ9JWVVfX62b23GXFbQ5TkfSUXWT
         kbJxtzwCw9wnx0ydzpKKAb4SKT4FsFe8FeotBc0iUw5G7BbIEHA4zW4lyJBaD9fXL/9V
         CffxdEjWGxjuDn1lAEgrmWK5XAmj4CTuXCLkF93ITRvke8HfOYh1ZTeZbSm8CJEtNVVZ
         fe07p/t5qy8QgaKliVPc2oEmPWTqUIvaPU9VF5Rjh9GnAVd37KnzK5p40N0opYfxhtjy
         m56lx5yeD8sdQ0ySFmUTPN0Eqh3sLYYsDC8QexUN7LOz29bccmSvXG4I/ALTSOKb8AKE
         S2Lg==
X-Gm-Message-State: AOAM532waaQj+F7+wBw2aoc2I4bj2XwxgVXTVrTUK+nqFvS/4IY2zfyE
        +7/xrAf+btgggT2vuJd/dj45jbl9EKDRuy6VdBA=
X-Google-Smtp-Source: ABdhPJz02t2j9WHMmwPEP/pEm3letWNMc0QFGa8k6GnQYlX9k85uJReaT5e6P5kplsIbD38vYJTJHBLZfFvX8QMg0C8=
X-Received: by 2002:a17:902:9a8d:b0:167:77c3:4c86 with SMTP id
 w13-20020a1709029a8d00b0016777c34c86mr23041488plp.122.1654796160118; Thu, 09
 Jun 2022 10:36:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: evelynjecob47@gmail.com
Sender: mrsashaalqaddfi117@gmail.com
Received: by 2002:a17:90a:f2d8:0:0:0:0 with HTTP; Thu, 9 Jun 2022 10:35:59
 -0700 (PDT)
From:   Evelyn Jacob <evelynjecob47@gmail.com>
Date:   Thu, 9 Jun 2022 10:35:59 -0700
X-Google-Sender-Auth: 2fZj3d1iQlwlnZYHAIF8X4cHw2Q
Message-ID: <CAE+vSYq=317B_dEYMgB57Jv9a7xZj+ZaVpVfr4FEmqqKq=GG_A@mail.gmail.com>
Subject: Ms.Evelyn
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FORM_SHORT,MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1034 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9748]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrsashaalqaddfi117[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsashaalqaddfi117[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [evelynjecob47[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.6 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greetings dearest

I'm a 75 year old woman. I was born an orphan and GOD blessed me
abundantly with riches but no children nor husband which makes me an
unhappy woman. Now I am affected with cancer of the lung and breast
with a partial stroke which has affected my speech. I can no longer
talk well. and half of my body is paralyzed, I sent this email to you
with the help of my private female nurse.

My condition is really deteriorating day by day and it is really
giving me lots to think about.  This has prompted my decision to
donate all I have for charity; I have made numerous donations all over
the world. After going through your profile, I decided to make my last
donation of Ten Million Five Hundred Thousand United Kingdom Pounds
(UK=C2=A310.500, 000, 00) to you as my investment manager. I want you to
build an Orphanage Home With my name (  Ms.Evelyn Jacob) in your
country.

If you are willing and able to do this task for the sake of humanity
then send me below information for more details to receive the funds.

1. Name...................................................

2. Phone number...............................

3. Address.............................................

4. Country of Origin and residence

 Ms.Evelyn Jecob  ,
