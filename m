Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873A5F7227
	for <lists+linux-pm@lfdr.de>; Fri,  7 Oct 2022 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiJGAHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Oct 2022 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiJGAHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2022 20:07:11 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC39E0C3
        for <linux-pm@vger.kernel.org>; Thu,  6 Oct 2022 17:07:08 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v68so2670495vsb.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Oct 2022 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9dYXaNE6QAaJBV4SvLG2MOZaYLWQPEhdj4RYdDWJ9Q=;
        b=anx8kIB2g6xAeYVEtbz1upJNeAhS8T4BThlK4BKBFEM7slwiFJz2rjCWHsMjZ93tHF
         Fzt4MbhuI3CwwUlauys3UJ9rjZrZiBV9rEVJkIVRtMZLQqvNHfM7Qs+pol6JrgWKMyyM
         5fRocapXnTwnl9ZAXWSnkEC0sYRIdbyWIGElV1CMuEnntoM9+FXE8BUSJy2WrrcnWojK
         UecsdweGkfunwdyKa0b60bXqiuhAu7B7eX9soKBXCovQ/u+WADXjqsPplEG7SjnmxR/t
         7yRtrfp8JBC6vqPFKUQhUTBx3UYxB/igSoIt7pvXL8T1yS5On9EQQZ4bjkBmtcflItZ2
         MYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9dYXaNE6QAaJBV4SvLG2MOZaYLWQPEhdj4RYdDWJ9Q=;
        b=QV2t5viv09GbFWN2Hs5dJpVr+ufiRUpbsx08GxJRZhuCok4NNpf+A6tOrzpEd5lnYl
         Xb35SF58XeTYnLr50cqcx2bxKPZwGQRt2qLyycT5+s3ttL7XU2xcJfzmUpYPal8gZJcG
         psOSrVEzdINsWSQNbaQ/4931gUshABa6gJVmYUQ1jc67VzrwfNzuMggSqRHguNAAfwWt
         4wNoqNg0AEzTK+x/XlrH7Wj+NoxKKdr+8FuTl65aRVI2pkM59rz6ZPT2X/rTzhb365Pj
         +cbO3VmrctW3z0PkJL7LNc3tK9RytdwS8tnX+1SoXdNK1pMBSZ3sMMSYg8vj96j0VF4T
         AhPw==
X-Gm-Message-State: ACrzQf1uNVzHTJ9N2l03K+hHDWekqQe0CvmmX0FxOi4TVrHwQznlChu6
        TM7L08QXhP9SG5Oou/QigiT9HU7FMdQUNFNp7wf6SQ==
X-Google-Smtp-Source: AMsMyM7o3geK5zIjt76w9cQ9kQAwo7K/ixsJWbyT4dinYMAVCpV3oqoSyLEjW7rJA0646vedn8g108e4M6d7APikXS0=
X-Received: by 2002:a67:fe11:0:b0:3a6:e59f:3def with SMTP id
 l17-20020a67fe11000000b003a6e59f3defmr1558597vsr.39.1665101227932; Thu, 06
 Oct 2022 17:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
In-Reply-To: <20221003144914.160547-1-kajetan.puchalski@arm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 6 Oct 2022 17:06:58 -0700
Message-ID: <CAAYoRsXgmwQXNzDPgVe=_cW=C8_7__GYHCyRKkfX=6dFY9dybw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 3, 2022 at 7:49 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi,
>
> At the moment, all the available idle governors operate mainly based on their own past performance
> without taking into account any scheduling information.

...

I tried V2 on my Intel i5-10600K, but there was little difference when
compared to V1 in terms of enormous increase in processor power
consumption for the periodic type tests I ran. However, sometimes the
power use would drop down to comparable to the normal teo or menu
governors for a short time, which V1 didn't do.

I would suggest a completely new governor for your
only 2 idle states, and of similar power use, scenario.
Incredibly simple:

If CPU utilization >= threshold
  select idle state 0
Else
  Select idle state 1
Endif

As previously mentioned, you are overriding
everything that teo does anyhow.

Note to other readers: I also sent Kajetan an off-list email with more
tests descriptions and web links to results graphs and such.

... Doug
