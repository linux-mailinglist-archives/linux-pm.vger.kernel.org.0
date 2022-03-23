Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AF4E5114
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiCWLQO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCWLQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 07:16:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530517891B
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 04:14:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c62so1417118edf.5
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=dUe7qhgPgAm/FJ0I8YTXKo/MBKgxkZiGOZuYIorNHJuwIXN41Rxub8t8K83JnRc6v3
         6Ak5xlJw/EOLy17Ms2SN4E2QRY4gRiwRpE5CmFOEaDhWyerkp7epmbHd8BLO+HkjfKZn
         v8Cuf4P3KfEq/aHGx4ZNhNteHnIWhIGB5ZbWIvwZjpbwYL3BYTkAX2NONwiljhIt7gUg
         mfva8YihBWZ37stp/b0Q6HDOddE7/h7c1wFXvxBhiu0E2ZK3jRqnjEvKj8BkDR7LS0+a
         0o0V8jkaoEzxzxSDDBn9b+Iq/jdf1Q5ybddQpOEfEI4JkJ0KbT46MZJjNi6okQ+/5XO6
         q3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=ulQwuAwezTRvPjP/D2LF/SRua4kC03W6E9Ysg7eWB7ZLWqeKS10sFpccyRMbjNFTg3
         uft2BXTnCvPax/CXjdc0dNxqnRVN7GlFa1dYvO6Iz23JVCSoebEA2SKdDuDtDw3UCAQt
         EB8QAIgRRFiT0RIU5U4lmjyB6+iv1DqRzC73Hhv6est7MI32h3FPhLl/l6mx7P5DzIAg
         t4YmunKNusJMB8tmGoUL8s7+5SvF6ESFjzDc58tfrgRkTuv0iP8MfH+e+xSPCy1kzBAY
         WBU3ZnaDzEvfJ2dxQWkbtn6NPQSEuXxm4nrsjWdIvXOSSf+we2hjcIMQeJDCBwocG0QS
         jpFw==
X-Gm-Message-State: AOAM530sKzcsZYFwztBRHhxwebCF2mOHDXdVptar1uUIJTey+6qxJppJ
        B/B7xzfHK3GOp+ClfIT03F3jLwB5+TnvQw6OyFY=
X-Google-Smtp-Source: ABdhPJyIhGRgbl78afTUayMH/Rj6M5/123RmZtETc1xTmOZyFC7JrbcfckKQ2rXiScOI5XztLiLH9LtpVlsnp+Wuvps=
X-Received: by 2002:aa7:c6d3:0:b0:418:eebd:8760 with SMTP id
 b19-20020aa7c6d3000000b00418eebd8760mr35259344eds.50.1648034082935; Wed, 23
 Mar 2022 04:14:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:340f:0:0:0:0:0 with HTTP; Wed, 23 Mar 2022 04:14:42
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan09@gmail.com>
Date:   Wed, 23 Mar 2022 11:14:42 +0000
Message-ID: <CAMz+VjTV_ST-1X5GiCGaqT2K-XE0Lt8+HV8U4zdG69880nTHjA@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan09[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo Schatz, bitte hoffe du hast meine Nachricht bekommen
Ich brauche dringend eine Antwort
Danke
Michelle
