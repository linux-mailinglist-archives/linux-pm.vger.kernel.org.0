Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7522E830
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0ItF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0ItF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:49:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8EFC061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 01:49:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c15so1877117edj.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/V1tQA7MqQfKt4h9sViNsgkSyjbVHQAmfZFznk32RE=;
        b=Q2sdqvZWBOfRDAkP37pekS7elYAaOeQ4HMc6Gg+v0IB5nFobNJACeCqWsCxMjQGNL0
         rjLC/O6Ja8UkvKnw0ND1i7oUQcGJ3GG5pMQzFD9q27byvGAu6+NoCXU8MczXzpCoaLjx
         ABKQ8s0Nw3w9thEonOld4DDNnyAwdBsOw8YJpZ8CrBvVRDDK/M/V4jL7IkNZwqjvYgto
         na9YVa/Jseuj4/z1ijuy8ANtJ4v4WDC22t+u+9G/erN2B3z3093/lTeg2PcKTH2XYNKZ
         nSQbIN1sBmOViMMPN4oS0lx3SxD1y5yFUPxWX4M2dHb1svUgRbLk/YU4W7xQsdJcZDCm
         c9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/V1tQA7MqQfKt4h9sViNsgkSyjbVHQAmfZFznk32RE=;
        b=mvCHA+nMRLC0Dg5laVKcd/DxkwqVedsY+SlNThMK93i0UfggtxHY+T4ehuyoVWcDC5
         Qbdi7HTCOKx93soEFG+nZf5a6FQCgNUqb4YhFJBHil0dxxEJVPt/ZPA02525xDFMEt4+
         MJW/ZfJTrdfLMQHU2XLG/7ERwRsEZtcsJFiSnkNYaCIlva3ObIQm6O/geatCjSByVhHP
         gcm3BV+1ptyOf0fYGTLCs1jJodIra+k8F/nbAZItSGtM9GmjHPDF9HuHydEfGuwiJhHT
         jVGsdgOVJqsJNpQvxbD8eqB8bRxY2xDZvrVF8w2+cYrjjYseN/4L/e6Y1r8Piqp2Fh7d
         UQzA==
X-Gm-Message-State: AOAM530FjuE0qN6iuLQ4dC8MrZ8dy4FeuVISmwkUVE0MRKZJrtfDoR0C
        sZAcB83ZCx+LmPIFsxGYY5HGt8qzo+1WM83XSzarPw==
X-Google-Smtp-Source: ABdhPJwU3wXbWUKs7gxR574E1ZfQ2DR05JFJCQ0/aGE9lAdTXHl858ZCW0l+a3BSfczHMm+p0bh73X5e1+tkh/eWJbo=
X-Received: by 2002:aa7:c9c2:: with SMTP id i2mr1980313edt.326.1595839743209;
 Mon, 27 Jul 2020 01:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200629144926.665-1-shawn.guo@linaro.org> <6615ee72-d222-b16b-df72-0f5117c3e7f5@linaro.org>
 <CAMS8qEWNrU64p1YeS2+G=aSj27eYgvdpEGGMb9syXmKYJciUUQ@mail.gmail.com> <46b2420e-4c67-e9c8-f1fe-08c8c742f960@linaro.org>
In-Reply-To: <46b2420e-4c67-e9c8-f1fe-08c8c742f960@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 27 Jul 2020 16:48:52 +0800
Message-ID: <CAAQ0ZWSVqwg=bcz_xmp43LtjTvrNukYtE3KodAJOJ7ie+3dbEQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add msm8939 tsens support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 4:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/07/2020 14:25, Konrad Dybcio wrote:
> > Tested-by: Konrad Dybcio <konradybcio@gmail.com> /* on Asus Z00T smartphone */
> > Acked-by: Konrad Dybcio <konradybcio@gmail.com>
> >
> > Sorry for being (very) late with that, but I've been doing some
> > 630/36/60 stuff. In case anyone's interested in the progress, I'll
> > leave it there. [1]
>
> In the future, when resending the same patches, please add a new
> revision and on the same mailing lists.

Noted.  Thanks, Daniel.

Shawn
