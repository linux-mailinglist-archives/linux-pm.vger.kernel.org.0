Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A37E8191
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjKJSaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 13:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbjKJS2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 13:28:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572343F1E
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 09:19:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso358210166b.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699636780; x=1700241580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng5PxaHEUakeDJDrRTqAaFPDP7NquJ67qdCuJTYti9U=;
        b=P1w6LNW215qlv/aq0OAY7cGFT/JZZ/sKP1yfeLZ88yuwIH0RUJ8NklJZjss5bKvmH3
         9uB9D/SuX4/BjF97Vc+TyCBKmNEwqxgE9/lDn+ntZ+rbDz+YWgtvrwFzUbnYkT6eMc1/
         /OM1WeSPw5j4Y8QI2NUYTrTkRkR60o2Gn2xac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699636780; x=1700241580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng5PxaHEUakeDJDrRTqAaFPDP7NquJ67qdCuJTYti9U=;
        b=YfRvR34scEFKUxo5DsXzdNr6RxoNU7xWUSpwFZmhd6TQ9ZSG0SDrXd5W6LZlaiwmXl
         SSz+6zOr2nYJc/5nS+LghRq3p35Amh6no1XojffcAJYEQ1X8jHgoSGykuT9bJlbT17Jc
         N1GD20cBzg/ovH6N/RIqjB+JdZSbTLo5p+Pa3TKtSsdmAijc/Ah6YVJaAhNEpjqPqKdn
         O7AsKmt1bP0SP6HUjE0bnmONXuQM2e5s1pXDBcbLDmUg5SWF0mw1+cF6uoBICfs/24PB
         u0wNQWqwIMM+Yx90IYuKdgL7p+GfiZIeNFrmTJp/e3rVGr65Wt9nfpqUl1XVts6a394Z
         6fRQ==
X-Gm-Message-State: AOJu0YyPXwijSrtcslFCMJJOxuuBpC19lWmveLpBmXO4DDJu/Q3gSeHn
        Q3xbHaCn0qdGRWRAWazhcbfuEusCoq6zx5+A1Vn2l8j/
X-Google-Smtp-Source: AGHT+IFqhWnD+RUWDxdghVNuAHBAMLFlRXdCqmVfrjilGSYIlcfWPDcGP5IA8jH3Osbok0bpqo7lZg==
X-Received: by 2002:a17:907:84a:b0:9bf:5771:a8c8 with SMTP id ww10-20020a170907084a00b009bf5771a8c8mr6109307ejb.69.1699636780255;
        Fri, 10 Nov 2023 09:19:40 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090608d300b0099cc3c7ace2sm4252681eje.140.2023.11.10.09.19.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:19:40 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so3935837a12.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 09:19:39 -0800 (PST)
X-Received: by 2002:a05:6402:2805:b0:544:a26c:804c with SMTP id
 h5-20020a056402280500b00544a26c804cmr9296ede.16.1699636778871; Fri, 10 Nov
 2023 09:19:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
In-Reply-To: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 09:19:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
Message-ID: <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 7 Nov 2023 at 21:03, Len Brown <lenb@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

Even though this is a user-space tool, not kernel code per se, I
really want a signed tag..

And yes, I'm trying to get to that point even for kernel.org accounts. Please?

              Linus
