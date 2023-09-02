Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997EA7907DB
	for <lists+linux-pm@lfdr.de>; Sat,  2 Sep 2023 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbjIBMtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Sep 2023 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347378AbjIBMtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2023 08:49:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABF10F3
        for <linux-pm@vger.kernel.org>; Sat,  2 Sep 2023 05:49:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-269304c135aso2089069a91.3
        for <linux-pm@vger.kernel.org>; Sat, 02 Sep 2023 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693658988; x=1694263788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AW9SiUYVqHU6gW9QOW3GIP5QwEKPh+27Ixy8DvS3Y44=;
        b=CFndiFgk1kqQqOOE/E61wSsTEaLIm7JH3/N28UoxZRqYE6sBpF459qeXEAjEEJjgeu
         iZR/XweUsmnHeX5XvdEjnAwI7BqYyyotsr5ILgBygsVYtU2R/gza6TN09FIVUsDQxk4V
         Wm129RUdiOrEt069i6VezEQYGhnwfZMlsBvlbdaAc9ZrMf2Ae1ZiUuMSkmgW4oxZDlKd
         1Yaits/dHcMWF4gnXvPsSIMkT+uBXODBw71P11Q3oQCsdWtuneDkwsPl9JJrX4kGSCew
         Jh92lY0VUvoW3WezjJ6CZ2sbE/f/kwgSv8nOJLH0n+TKKhMxJ74EadegGqUMFHtN3wRn
         O/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693658988; x=1694263788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW9SiUYVqHU6gW9QOW3GIP5QwEKPh+27Ixy8DvS3Y44=;
        b=TPMvLCT62u+u827hlNNEmHRvvdlgjWS2lqRCO0yDF6dloM7sn4G5l/9GtLiJnRD198
         gnjumbiiaWMnDIhLzaLCtVoQjG1Z1Lz0HKIkWvIS3k9wVZjyd+wNRkaeZkWR2Ir2sG6y
         pGLNEZV4OR3pQX9gAS+ErYWWILa3Np6wtm8bIyXnoCYyR14NTMggMAhsKbpq/Gb8mTUu
         oqAKTt8aRMajyI4G0c3paxiXwYb9ZMjb7IlmEouyeGFlVPfehuEKBGlvKjjd4qsCUWaX
         LzTZxcBLR3LQ1sCxXwrg8anu5p+xbqwILiZ83SGXJxcIuOI1MTVIbHfAFEF5FCZWW/bK
         5vaQ==
X-Gm-Message-State: AOJu0Yxy9e2ciYQwbMRa9JiEvrpOgv68WZ7M53yJFOJg7i6Vkcz6g5SU
        b0t3qmOejTHr5xEfJtmMurYDl0e6RtGtisZq2KhRRA==
X-Google-Smtp-Source: AGHT+IFDRS9ZM1b0vV6N2s1IcuMRb6QLQJGFFuAGZLmjG60YfWA2e7cGTR6Esh/hH6bpB1lww/HhRGyd8M/o6jFSaCY=
X-Received: by 2002:a17:90a:d486:b0:26b:280b:d24c with SMTP id
 s6-20020a17090ad48600b0026b280bd24cmr4549024pju.42.1693658987992; Sat, 02 Sep
 2023 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org> <20230902-clip-shortly-c9af45460915@spud>
In-Reply-To: <20230902-clip-shortly-c9af45460915@spud>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 2 Sep 2023 14:49:36 +0200
Message-ID: <CAKfTPtCeAHtuasp2r7ZXwrapP5cE16GEJS5_DRB4amAbHYUKgA@mail.gmail.com>
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
To:     Conor Dooley <conor@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2 Sept 2023 at 12:57, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Sep 01, 2023 at 03:03:11PM +0200, Vincent Guittot wrote:
>
> > +#ifdef arch_scale_freq_ref
> > +/**
> > + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> > + * has been used to correlate frequency and compute capacity.
> > + * @cpu: the CPU in question.
>
> Copy-pasting fail? That's not what your parameter is called.

Yes, I forgot to change parameter and its description

>
> > + *
> > + * Return: the reference CPU frequency.
> > + */
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
