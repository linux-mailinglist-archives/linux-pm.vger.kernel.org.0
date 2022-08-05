Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3758AA15
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiHELZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbiHELZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 07:25:36 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A064C3
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 04:25:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 199so3319791ybl.9
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=ZUBBPCVRKEuFSuCPGHKTywKyH/kz5FoYQ4SPG9r/m/PmuP84AIk/zJgLwK68dCnegK
         XdD1C1BEYg+sKcGp1H3uUxsLXoN4gYzjgiVA2a5AFY9xpSyPn/BQpsirChHco6A4y9NN
         ql0Lbq3xix6hQeO6JH5QiBHNfJvSgucXv92qF8mnPyG8Vv5sRLGY25X2/U6VkiJBzK9p
         HRbyqwg4XSHh7d4ZXc4TmKaQr3kNcDmesLlTGC32vhNEtl8Xy1iiCE1WHsf6J4L3Bv7h
         XOzbsRryXD/Bhbb44WrOq+ans5GHNgSrPtAjJoNe8xDrew7DllBJKzFoJomSWAVYWYzf
         1Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=cWDiFtGXGdZzPq3f9RewDadIdj6czXDEAuDVCN+ickxZ1uQvgLi23F4yt0/vRhFxB/
         Cr7Y2wfjToBZMJOzfVMs73xs/Hm1tC/QIdyaU5JW2V4kUBaKNnyuwPdrMA/fIgVydK8D
         GmvjR1fhxdcUrJQOBQUBjQT6sJDLIwvTn2oqHFIyeHwLdaUsJvb7M5RfdeUnX8w2aOtj
         8s/fphHA/kRtMxddlwuSx9lP/me3wLMbqep67BNtUWNFtOk5Luq/U7MDoQuhd1zQEhZu
         XNuxY4oduym5v+aEmXMgSWBVuT5Ly4s9TlpYuu++MX6yMA7iMMIR1hQUvECcDzsfCBZo
         AGAQ==
X-Gm-Message-State: ACgBeo2+JfLtuTHzidkpvT8PYOa/V7q6ZhHCbDyCB5NxlNrGQm8TGZ48
        0jW9Xwl2Z1Pm1/6ZZA4BwaraTVVfy/+chs5Aa5o=
X-Google-Smtp-Source: AA6agR48+738mSZjy5LJrMtQ2AFxj8AYLjAyQoyHT8mCE7f1tV3P/VQ7Fs7G6sJY/M82Rd74OvkNynlB7eYjzgFo7eI=
X-Received: by 2002:a25:73d4:0:b0:67a:6ef2:f581 with SMTP id
 o203-20020a2573d4000000b0067a6ef2f581mr4581693ybc.100.1659698733114; Fri, 05
 Aug 2022 04:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5087:b0:2e8:760f:3500 with HTTP; Fri, 5 Aug 2022
 04:25:32 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <fralaimetals100@gmail.com>
Date:   Fri, 5 Aug 2022 12:25:32 +0100
Message-ID: <CA+5KX237D5i7Pv=idXVYwJwwPkQRyq=+5PDjBV-bEO4vYhu4TQ@mail.gmail.com>
Subject: Rowland
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fralaimetals100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fralaimetals100[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolandnyemih200[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Rowland Nyemih
