Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490C051E0CD
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444347AbiEFVNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444344AbiEFVNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 17:13:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C306F4A4
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 14:09:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id i17so8581204pla.10
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2022 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=eiAQXuEKXp5T9ck7zmwrtRg7mfdJz+b5e/qLZGNQ+P0jlbkGGyLUR+k8OQGunYV4w4
         eySbEB2zi6V5vmP5aMQ2aTjvhsXqeGeNCaXKDTmu3I7z4XL+pW4OvX3Z2jx3GwqegtS8
         B/6pQqBJhtaS+I9tjFoKAuGDb0fWMi+x5hlAUgBfIf2lwRC3GbJ/LCvb0cslojJTiXv6
         2QS4mYskP3yxkq5AQmzh0pubamLpiFgh3sSG6JGF7eC1+wjOyCOm6BXcKhHZRJyklGjh
         VQ+VoFh6DWjvUS0ZfFB0B0XD1LN754vsNH9vipO0KfrDO8JBq+TS26TOQQ3tNQJ6214C
         5a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=feKNTf/fqGH+NfVTZV9W3mug4uzZSuwuhFoQIvySjxiPvNLnYFiB0pEdu1lGSNXUrq
         bDc3WICjtfCeqUHAukc4Z22WkoXKf39txBqH672okpC5FVqj3DpH2/258Y9cgWNvu821
         wAiR+sLwuFYGHGzB6Ar6YOursc8X+gtG0aiROGDo1c/feF4n4WLsOlEDkcQ7akgHjpx8
         mQJlS0UjYeRhvGJX6ysKU8WRkBpSR3NM29vv/IRxQzRgvL52t7W8mazEDiMY9QJj4Afa
         GeyXllSQM02XjAPuQCuGnePTP0PJ86kynfj3pqB8hZGa5wE6x+mhydZJxxKMi2JqNKS9
         7hBA==
X-Gm-Message-State: AOAM530hb96Rf4CFi11PVcYMYMxnsGJYmS2QNgXsS41D22ha0uQ9b5nj
        j1efibBmWThpq2qNF0uMbppoHMjVX3ztPKj4Bg==
X-Google-Smtp-Source: ABdhPJzg0WuA2nWsf5GfojxJwV1671Vg7LfyIkyz0YR1vlLhPfyCappL8fPY+P0VDolj1UnA1lJoJRDRGks4K5ixmyY=
X-Received: by 2002:a17:90a:1944:b0:1d9:7cf8:5457 with SMTP id
 4-20020a17090a194400b001d97cf85457mr14365809pjh.112.1651871386691; Fri, 06
 May 2022 14:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:09:44 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:09:44 +0000
Message-ID: <CAD_xG_odZ2a17vwQOtf_G_N8RGEpabLVcAoVxBDgubah5+QYJA@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4845]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
