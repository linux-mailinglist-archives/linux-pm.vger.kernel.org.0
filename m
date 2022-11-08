Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0A620EC0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 12:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiKHLWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiKHLWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 06:22:09 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF44D5E4
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 03:22:08 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-36cbcda2157so130446937b3.11
        for <linux-pm@vger.kernel.org>; Tue, 08 Nov 2022 03:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=er+01UyBqq5yALeXUhYkq20dCtPK4kfDEL6xwUd6OX1xLy20ztdFPVUugdF8WeS456
         ZvzRIryPtmZtJc0G6cu7K3LGZR/jUnBGwQt38Fo0Zyp+6Y7YNKVjd4doeEcfpjMsbwPJ
         CkH35bEJZIQkk6cH2lrAcGUwgGT/dZwuulJmut9hSxO2vVsdEtYc6PnOC7QV3kwPzVbf
         DtqybJ42ilZgEHLvrkJKAJ2+crLKaWld7jOJaW8IBlByFPabKfwbq21HGZ4nPcf1lOvQ
         P/aCnwLExgaFT7m6JMzmF1kmfhR9x+iMji55oKg2VHAJS7wmkGekUnwZDvzQovIU3u9o
         u+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=JJ+rYGbAuXxzD5JjmSmEXxFxnR8q2wRn7yXU/FCoEkzI9PoDWlJKddGfzdCSgW251G
         hezoY1aIa5lQ/oWmR9y11UhBEnBD+ETSxQtcu19hd+4Y6IKQTJ+OVQ471rQSglUlLHBz
         SqzhzqofDyHra3r49TI24eZ6PVmjL8JVSu2+ik5E7fHl9WQTseBfspDfAcVZV+hDLtwg
         H3QLMruA4UwV9BNdJFep+Ic17lFB9iOqVxxuNIU1CziflIzmstsPfKpPz2eYW0nlXMop
         ENKIlXkI9AKiYDzqUtuT+403zPlKlohF0xT6kUgCZX6V46bzch296BbdJVbuIROpr7TD
         wHzQ==
X-Gm-Message-State: ANoB5pnbiFfD0rcNu1wXAgmm9ttsuaAtUra8gj/uNEz5FfE1G0bYlKXk
        YJQ1uIp8QRl6PVzi5SUMqPVvI+yEY/+sVQRVJrY=
X-Google-Smtp-Source: AA0mqf7s6cLMJ+jFWr1acfH8YtYExw8f3XjIKRBz7jsUlZXoKoLcbLartm0vx3oZfg7AKKmi6fwvspQ61yzbB26sDsQ=
X-Received: by 2002:a81:9845:0:b0:374:ae5f:a5be with SMTP id
 p66-20020a819845000000b00374ae5fa5bemr5049661ywg.177.1667906528181; Tue, 08
 Nov 2022 03:22:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a38a:b0:313:c983:1d7e with HTTP; Tue, 8 Nov 2022
 03:22:07 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik2@gmail.com>
Date:   Tue, 8 Nov 2022 03:22:07 -0800
Message-ID: <CAC9COZe_rZeJQQ2HU7v7uriYCoON1Xu_vFc68+RNzupoN9+uUQ@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik2[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hi

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

If you are interested for more details.....

Sincerely,
Kairi Andrew
