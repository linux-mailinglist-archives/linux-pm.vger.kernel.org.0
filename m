Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E56BF035
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 18:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCQRxY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Mar 2023 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCQRxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 13:53:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57D3E1D5
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 10:53:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er8so11756620edb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679075595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvERMCVN4Wmso5JvL8vtaebl1nl7Lfcqf5asBd+56Jg=;
        b=BzvF7WQbmCzw6GI78Ue0kcZ8xlCFnyDVraL1PFRbW0TNtEG6lS0S1W1bOfrD7hwbTN
         jGTylJvBHGUf/9ap6WXxvc0cNlBuomQ1r/u2u7sT7B3p7V85HYvWwKqhDqC/j7h9eqHX
         AXcDoPGdr8n655cHzo1dn+MzHefrwVJdsvqmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvERMCVN4Wmso5JvL8vtaebl1nl7Lfcqf5asBd+56Jg=;
        b=qRqieevB/TtmG6VaygGiiKRkzgQ9pXYAavhH6c7GbEHV6Z8DJ5X8//RGBV1n1KtM+q
         A1+yAUnSfA4rJn8Cs7N1FupBYovEZLFguUzRBJZRHO1geICABtb/sPXNYs1o6/ntnD1k
         Rwk0fUsE2xb2umc3ddb5T7V21hIQ2aEnuc97Xn3cmFc4Cie+BxXbYX7a3/XCsDuiG1wX
         h2LcRQGHvDqqZUw245uv6r9o0Lerj3CD2Rd0jGyJVYBsxCBEt1CKnFSvSoRAdsA9Cr+1
         MerRQv3XSoarX6TqLMxvIucgCeAfP+bx3Vnh1d6IOog+1dcrauml4FfNk+GO3tW2E9V+
         /CVg==
X-Gm-Message-State: AO0yUKXsuvNJ2n+0OcDwRBYKlqcPsLULM/7oZg/P8gdmyr6jAjGJaenx
        o1rDbmxxI+y1IDOXtEG3RO1s4GWjxOUiIM7jnlEEig==
X-Google-Smtp-Source: AK7set8rLPyk/tbZEFyzAdygXG8pEBNLVLkpBW1RHz+6uSHhe/a7qU0b9yFookGKdDoLy4AeSBtYCA==
X-Received: by 2002:a17:906:1997:b0:8b1:77bf:3bdd with SMTP id g23-20020a170906199700b008b177bf3bddmr180827ejd.36.1679075594822;
        Fri, 17 Mar 2023 10:53:14 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm1375631edf.30.2023.03.17.10.53.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:53:13 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eh3so23417076edb.11
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 10:53:13 -0700 (PDT)
X-Received: by 2002:a50:c009:0:b0:4fb:4a9f:eb95 with SMTP id
 r9-20020a50c009000000b004fb4a9feb95mr2205587edb.2.1679075592691; Fri, 17 Mar
 2023 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKkJbY8WUhj43sFyboo985d1pQK-R41Xv38btRgWxro2RQ@mail.gmail.com>
In-Reply-To: <CAJvTdKkJbY8WUhj43sFyboo985d1pQK-R41Xv38btRgWxro2RQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 10:52:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZe7YUCEOt9S5bDLT2xf30Tx4V8bsSepsfrwt5vDUBgQ@mail.gmail.com>
Message-ID: <CAHk-=wgZe7YUCEOt9S5bDLT2xf30Tx4V8bsSepsfrwt5vDUBgQ@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat v2023.03.17
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 17, 2023 at 8:53=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> "Keeping happy users happy since 2010."

What's this? You don't care about the sad ones and trying to make them
happy too?

              Linus
