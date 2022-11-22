Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3A6343A0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiKVSaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 13:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiKVSaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 13:30:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691E5DBBD
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 10:30:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s8so24808165lfc.8
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 10:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htOJ3+h80iGHTX/DM158Lsa828egdTKuVIWm93EjKcs=;
        b=auaFAcRasq6x86ACxnuZ2cTGgKpmM7aDcF4FZDKN/zOCpUP23BlhlYz02vBVIAJbZW
         A4riOKAH7xw8ruOaX9BAJkq0KwJE51ypKpV6ZDIJmhLsIfO8CB6/6ZoZ18elNjXKPIve
         yZOWqXiu4w+fTH8FoxkdzjhfVz/cZDPIX5SbhQ9foFz100Z5wWKZPX5lLgU9XADwK9Dd
         cFutE/Yfnf+RCk4NGIatTwNha4mC07utZs06vdg/lQRyCnd7CI+UDDWji8evEocAbbz7
         J76FJzgX8oYqLqnvcyIcGbWYaJ2dvzaV59q/6b3kYdhxYHt9ADulj1Y+L70eWwe63F/2
         PRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htOJ3+h80iGHTX/DM158Lsa828egdTKuVIWm93EjKcs=;
        b=X9gEKJs3WlWArEEBFii3uEe0n3pcTxLiWdBCuOdwyx2YuxpiNHLND7d27Z4yAdN3pr
         IYyHLootgwo9M7tFsemrh3+ShFHeH+SvhRZKcwO3WsVAGLLFcB7aZOHirm5fGKbG2kMC
         7eNMiY/5aN+LmV6NDdbQqZtA3rhKg+51RcBF+rBcH/hAKg2/xSyXqd6030taMP+LtKRv
         PRD9c4gH4Yk5LQrnfsBGUbxqbcdu/fqjaD3zbg2M0RBYgfp8tQ7n8M0H0cdm5cBiv2IG
         GLw+4rcvXOq6+HI3i3/vmBZC3UJ4J6PmwND5nTakdCKcw99N9pPoN8/Fw4p6u+hgOCya
         elMg==
X-Gm-Message-State: ANoB5pnToKwUCyqZoCkj3JkPuwVGvMePKU4ZQIleJsVRdXZQ7HNyBmgH
        CZZsWmgtzmGE7fLbC34yy6g6rjsOgl9PR5Z2mvg=
X-Google-Smtp-Source: AA0mqf5128IBZO1b8tDRDeWkddQk1lYAmeAhmI0s4v4txrjz064DDPSuaQfhDJCehDwt52Tw7rBLIxF48GkDmhoSGa0=
X-Received: by 2002:a05:6512:786:b0:4a2:44c7:ee58 with SMTP id
 x6-20020a056512078600b004a244c7ee58mr7999411lfr.127.1669141798584; Tue, 22
 Nov 2022 10:29:58 -0800 (PST)
MIME-Version: 1.0
Sender: jw888502@gmail.com
Received: by 2002:ab3:6f52:0:b0:200:9879:f9aa with HTTP; Tue, 22 Nov 2022
 10:29:57 -0800 (PST)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Tue, 22 Nov 2022 10:29:57 -0800
X-Google-Sender-Auth: YCBmhLIy4a_h_2g-z6m9qE75MjY
Message-ID: <CA+hfTy=RzKzcsObp4apePsc-ouDtrRNDLK7nHM0kxf3=5TJAGg@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5325]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jw888502[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am Mrs
Doris David, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I'making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs Doris David,
