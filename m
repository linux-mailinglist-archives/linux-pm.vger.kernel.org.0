Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D287CB186
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjJPRqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 Oct 2023 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjJPRqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 13:46:43 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2839FD
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 10:46:41 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57f137dffa5so722216eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 10:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478401; x=1698083201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl4os4YCTUEv9MuBinBrGRjLi4bpa2Avh0gIybU4Wws=;
        b=w1lTQHO8Cw11g//YJc5cCgKwonmYReaEWr/qzRB+CQPPv+Kn/NjFx/A/AKl0+3mQwt
         9umKhrdiy0HYKKwUPYq0sJ1BGmoAXP9ZsRZcyJdaYylbLHrlHbrIi9qLkfvuJvDRlOCR
         I9RPFTFBVLaiEK1gEU4ZwYmGEzkFkgab6sY9Av3kC//pbUZ8JgFifpyAQ+n6u8UPN0QD
         7A9E3XflUCl+ZyQe2lHVH74I8VCVqguMxPtdVevLblIUa0FFDJ8S1ZejirHmCCgxpUaV
         D+CwK+I0lgMiFFNjrWx2Aox7Su0SheKYao0B2fv8J0KdfozG7TS7qMKzGQxsXNG8Zlmh
         Ipvg==
X-Gm-Message-State: AOJu0YxJq2MXOXaQ/sZiBGmaMiTX/jc0AJ67wy3jS4sfiTY1P6Me8Ce6
        0KbYjSB71GS3TBfvr76WFtlakkN2lLbf3OrRed8=
X-Google-Smtp-Source: AGHT+IEIs0rUex+j/+sqSHHN8F8Z5ErPKaWD4bei68FHRBud4HRMtcyJfM6AYvI/iW2ER1mSxaQkdQmgIdPAQfbEIwA=
X-Received: by 2002:a4a:d097:0:b0:57b:7e31:c12 with SMTP id
 i23-20020a4ad097000000b0057b7e310c12mr33944388oor.1.1697478400729; Mon, 16
 Oct 2023 10:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <734738ec-b72f-49b4-9a4e-6aaf2a44c9f3@linaro.org>
In-Reply-To: <734738ec-b72f-49b4-9a4e-6aaf2a44c9f3@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Oct 2023 19:46:24 +0200
Message-ID: <CAJZ5v0j4ceLwx3sh-AOPwtPk6_mya0TvtMRC+d_v0r_hk8jnsQ@mail.gmail.com>
Subject: Re: PM QoS performance aggregator
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 16, 2023 at 3:03 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> the kernel provides an API to specify latency timings for devices and
> CPUs. In addition, it allows to deal with the frequencies.
>
> However, the unit is Hz and that may not fit very well with some devices
> where the performance is an index. The devices can have different
> performance capping mechanisms under the hood (IOW the firmware).
>
> The pm QoS seems to not have an interface to describe constraints based
> on performance index.
>
> In the same page, the devices can also be requesting power values
> instead of performance indexes or frequencies. So having a power based
> pm QoS would make also sense IMO.
>
> Actually, performance indexes, power values, frequencies are just all
> values but in different units.
>
> Would it make sense to create a generic PM QoS constraint with values
> and units ?

All of the existing QoS types are frontends to the same underlying
mechanism and each of them is about using a specific unit, so it's a
matter of creating a new one for each new unit.

That said, using performance indices as QoS values directly is
fundamentally problematic IMV, because they are device-specific and
not portable in any way and letting user space operate them would be a
mistake.
