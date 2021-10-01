Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9A41F4F9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355919AbhJAS3t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355914AbhJAS3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 14:29:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26783C06177D
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 11:28:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z24so42186444lfu.13
        for <linux-pm@vger.kernel.org>; Fri, 01 Oct 2021 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZL3HiHYhk83htmEa9pfWci+RswEhtW10ZF70CFAsps=;
        b=eTEbfE49kta/JBr5TxSOXnOSkMsvgwFphSljrp1cZGTHkx9dcn8MxBzKsditpPBcGv
         ddgPWulvGNYBuYQUY27qxescZoEfA1J0QQdCiNAG0cahKTZuLbCiDa/hyDEBhRTzTZxS
         T8kYQUqND1kEZZ8fqvyZA113HdWMkU8cn8D/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZL3HiHYhk83htmEa9pfWci+RswEhtW10ZF70CFAsps=;
        b=AlaBp+sYSnSItCBBlgKMNTJNv5o5o/12KT2HFQPdKaUF3w+DC5Yu08cYSw/DJ7l9Ws
         wcdbLY5IirFPVsKreFHY3lCPXdoOyEH5+koPTu6w/O7sI0sDNKQ7N5qGDxy6J2LMT5FW
         hu3gLSJ/73NSCBUzePKTcg0F6xCvMMPisW4EtSyE06J7EiGwvwE1I4Z6T8Yh5pRwr1rO
         atS9d2N01B4D85OV/raKoVrscokQy9bo9OlbAjtZh2yGF5PyCkQdR8ExRfuoVuPt4plB
         2G2Q8rGTQLlmguj88x4Mt1Rym8rwCs4lN4j9ajqV1bIIe45Dt4VrpU/wwR0dGOdwlRMu
         ehnA==
X-Gm-Message-State: AOAM532qYUp8I0nZm6ppWXY8jSv9nLwfbrbRSqJDes+EAeFGxrvC/4Q5
        fUo8bf10J6BRuVmpf1cSfqnzLPhNhdxWxYqxiBA=
X-Google-Smtp-Source: ABdhPJz6fDnC41Ycz2Yxf1LKb5keKlprEfZpXEEJ7Mem+ckHav9i2oZqKl/y53NreK/JO2P2l7Yn4g==
X-Received: by 2002:a2e:979a:: with SMTP id y26mr13484305lji.107.1633112881870;
        Fri, 01 Oct 2021 11:28:01 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 8sm741581ljr.10.2021.10.01.11.28.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:28:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y26so42348930lfa.11
        for <linux-pm@vger.kernel.org>; Fri, 01 Oct 2021 11:28:01 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr13249120ljc.249.1633112880766;
 Fri, 01 Oct 2021 11:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <11859976.O9o76ZdvQC@kreacher>
In-Reply-To: <11859976.O9o76ZdvQC@kreacher>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 1 Oct 2021 11:27:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUc1J_vf3VSin4Nw1dH95A=Li88kHzD=rhsWM3+fz0mA@mail.gmail.com>
Message-ID: <CAHk-=wiUc1J_vf3VSin4Nw1dH95A=Li88kHzD=rhsWM3+fz0mA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Update information in MAINTAINERS
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 1, 2021 at 10:14 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Update the information in MAINTAINERS accordingly.

Applied,

                Linus
