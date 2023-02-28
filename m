Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A26A5F62
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1TNM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1TNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 14:13:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D56A55
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 11:13:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f13so44384482edz.6
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=MGy5sEmNu+jh1k+6nJc9DKK9iT1TACwZ56Wx0wM8QyLNIB5Qw6VFdyQiKJFrIVk7Q9
         MITGDrPGJzLqQbF1oakXWr0xi5R3qPWv7BZZ+ODdqTQSJCSXBIu44nFtnkPnTHz47K+y
         OXWMB8HZNJEFL+aKtBwbr30doS8nVpzRTtpfNQOftEW9FB3+NX7jE/a7V57lUPshHXMv
         uBA/2VsfA0LERRc6YjcLvr92aM056thkPTtinQSloOvgPMR2OeNVUYkUoFnMc5yUuL5W
         zElsu+kmyXr17Q5VN2VU73yQGu1SlKKrPTmUas/bggSjZVPQxSRl3hUzRoIMu5wgMcWK
         304g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=iajzfoF1bLjSVzaajjvPbakYqxvbrvO78DtsxjWmz5dwiANtM8JoxONBQvUhqE4L/R
         bjt+pjWOih/lHoFUSIv9J8cnYfkIBb93Nay9CgxlaLpesZ5qZSUSXarL1RYg2AHYPZeN
         TTdJ08Zn2dx8YcVdfVsNDlO9riPoH23DjjksJ8UCpqOdTPaVAnhOjNzP+XRkODFy5iEG
         RBk5qr/CH0b9cknN4qJd3WOaWqusEQO0NDAPCEj2aP+stlo1hjcZ2Mobb26ecMR7OJ4H
         kpbnP6PNmJeac2KHwr1VmlSTWlk2512lqRXLShHrPKT9g1+qxsSWbyg6ZlIJi3T+fsoe
         jVbQ==
X-Gm-Message-State: AO0yUKVOzVyObCXFzZO4nnOed3lR3N/C95nYQJtaitxgRmOs0f+j5wMu
        MevaY058j4TYanhK1EWfq/FrMo0T2UsCMua7kFM=
X-Google-Smtp-Source: AK7set9jOFJayVOI9nSxcyGj8fCokkpvMW/KvKDYvLhwxCEtqf3kSiUkOlfxLjiAsucT3H6mmPrln5z8uOOAzhlDjuk=
X-Received: by 2002:a50:9f05:0:b0:4ac:cdd8:fbb5 with SMTP id
 b5-20020a509f05000000b004accdd8fbb5mr2358066edf.3.1677611589021; Tue, 28 Feb
 2023 11:13:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:701:b0:8b1:6e81:b190 with HTTP; Tue, 28 Feb 2023
 11:13:08 -0800 (PST)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <thankgod07062@gmail.com>
Date:   Tue, 28 Feb 2023 11:13:08 -0800
Message-ID: <CA+wdF_GSaJNXXZvPke2u6jA5obj7O_56C-1QyNR=B=H_dhf30Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5212]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [thankgod07062[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [thankgod07062[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fiona.hill.2023[at]outlook.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hello friend did you receive my message i send to you?please get back to me
