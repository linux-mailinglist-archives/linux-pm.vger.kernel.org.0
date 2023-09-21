Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEC7A9FC1
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjIUU1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjIUU11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:27:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57BB8FB38
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:46:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77410032cedso38728585a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318368; x=1695923168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F2iVUKRDazi3scGbQVKzP0TAbm4bJPvzK2OVT1wMEJk=;
        b=CWBMteytZxG5ibA+LGBIww7keVy1IntHzP8nxuUfB93E86L6V/hmUU1wsB5XXzPAEP
         qJccT3g/oJuwmPG5RB3GiOcm8uIz36OC1I8MA+L65qV5hb5io2kE4DaQt3GzSwof3kKN
         ST+anebU3ehbnHvFX+3fo/Me+L4O3rQ4dWENxwS5IKStU17OaFSvUjXcqKV7CrnOxs/T
         FfMt+vKcCXFnqjnmnnXJwt5x/+CysBNuMc5IuS/ys38AN3zFw6/ydwjxRf0oW6uJYesp
         D/ur8UIBr/AttBRGpALiAfbrkIkU8lfRyPGovj5FHo7AcCnatkMfjSAvzCmXABpYgptC
         qJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318368; x=1695923168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2iVUKRDazi3scGbQVKzP0TAbm4bJPvzK2OVT1wMEJk=;
        b=cCmk3iYF8jZnrZbwJYvmj0KpJaVpS/6U+KsdTm8hMTfeejTaENbhFhszxKyfcU35ao
         eAlatniqocxjbYQ+ICmme85zJ5IYtUa9T6FQvdXfqine/DL76JANj0SwDsnrRIWqRwYV
         Qkvj69B+Ei1RtaYHJCylkApGfv+K+trQt60WCYrwIC2OlDD5eOP3/5EHraidRTgerl2o
         KaWE69xbDfRiOvN1rbiyhKyqaLBFi48psJowKQ42MEs9KUSsvaKXw/0uNqMeLqNKldmm
         +4N+bGmWcjlFwoD/zLWD3XuJMctbQ3ePoHqnU4oJ8ZVl8OR1R8Iuiz9bGUp4nIxHmf/A
         knOw==
X-Gm-Message-State: AOJu0YwTaHgdPS1chmoR8NK7TK8nBwoFIxOnBW6lY75OrxlaK5qDQR7T
        alFpTsqH+KnbeAWu2OfjxTYQhAKnp1H7izvUCLkAaJNIWMgC+FehU5Q=
X-Google-Smtp-Source: AGHT+IGBGzSSuWFuR2CMHZuIrQTlTZeWSJ2mzK6C15pX7OZvwpMOeVL7zOjvauq3dqsE+276vjD7PnFCpmTJ4T71ZBo=
X-Received: by 2002:a5b:f91:0:b0:cf8:1070:82d3 with SMTP id
 q17-20020a5b0f91000000b00cf8107082d3mr5445675ybh.32.1695303482171; Thu, 21
 Sep 2023 06:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230919121605.7304-1-ulf.hansson@linaro.org> <20230921113328.3208651-1-sudeep.holla@arm.com>
 <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com> <20230921133343.h3chbszl2iuf2b55@bogus>
In-Reply-To: <20230921133343.h3chbszl2iuf2b55@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:37:25 +0200
Message-ID: <CAPDyKFrQAKhofKikc4xV5o=oqAoGOfD9XLiqHNUSBmeCmWE5-w@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Sept 2023 at 15:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 21, 2023 at 03:10:56PM +0200, Ulf Hansson wrote:
> > On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > To simplify with maintenance let's move the Arm SCMI power-domain driver
> > > to the new pmdomain directory.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Feel free to take it through your scmi tree!
> >
> > Note that, we should move the Kconfig options too, but that requires
> > changes that I am carrying in my pmdomain tree. We can either wait
> > until the next cycle or you could send your pull-request to me this
> > time (instead of through arm-soc), then we can fix this as a late
> > minute change. The decision is yours.
> >
>
> OK. Lets us just delay SCMI Kconfig changes for the next cycle then. I assume
> you would have other changes merged by then. Or may be as a fix as it would
> be hardlt 10-15 line with 2 Kconfig options. Let me know if you disagree or
> have other ideas.

Let's delay, it's probably easier. Maybe a fix for rc1 would be best.

Kind regards
Uffe
