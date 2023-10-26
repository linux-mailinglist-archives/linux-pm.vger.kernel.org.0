Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888697D84BE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjJZObJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjJZObI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 10:31:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3D1B1
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 07:31:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c77449a6daso7886675ad.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698330665; x=1698935465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyPzF6zImIluItqkN237S1HDHY3vs2wBArSwbVc/hzA=;
        b=z2dEkPdFfUlgbOE45z4yUdd/p2adlb/iOdWRpd+vaiDpn+D9rjuT/ONKaIae3IY7R9
         S2HOZOWACm/u59cenOkLecHRR/9yS17fPTf7U+w1oYzac/JAC9jHqnMdYhhgHYL6Ou14
         7e6b0WjSKjW4EZwtEJeS8VEZsnO3RrCb+R9Gb1NYYJc7iq7W9GGPweL+LuRWdSaa8KGV
         izPA0C88gnjevyA8WQYcEUJK4WZY/ovecw7ctYkyEhlhtky0AFoRlVupMhYPtlRdUcmw
         g3HTbL4WKZoTxIZAP3FLSIRFadR71HmAcOj+bf26TjKEoz9oOvMTCokxb4pf8dw3fGfN
         jU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330665; x=1698935465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyPzF6zImIluItqkN237S1HDHY3vs2wBArSwbVc/hzA=;
        b=dU5KXOdn9ilHmerw5K10rznhsPON92MCXltZg/Fcggs33uYKZ6SVevjOwOFM11kG23
         89/PeoF6kGDWgBd/7ulZi0rbtTUqAHoz5TA53GFQjaaNUVIFsEHkmX4KtJm4TsjChdJY
         YhqAg+qbwe4GBsdE6jl2k6b///epOKbcc2UKWCFT23kpCAcIXGIJsq8Z3JR+MllG5/2j
         tRLhWvP2hNJV6UiaovAeHPrQBDpMTMGwkONBM4jg5Au+KcQH+e/5zRACWgcI7gL1/11N
         HWBzkXm+G5wAGxgGrI99Mpktb+B+w4/IhSnVpz5Td4ig6CNp2dsmZtOO5/9l5l1RZuep
         8TpQ==
X-Gm-Message-State: AOJu0Yyta5F1fPZVAHf+6ZQH8gUvussynpXCP2TgstPZPvvfSCrZlGM8
        HNoi1c2NzBb398tSVnrqWBT8dRoODftM7/VwuagS+Q==
X-Google-Smtp-Source: AGHT+IEPrFg7ph9PvUTjEjTWPycx9rIXgHGj8Pm/PdzOH55g1dDMU1zMVGUh7AImWIiMYHZ2g2wRbWAImZmI9AfkT3Q=
X-Received: by 2002:a17:90a:1c8:b0:27d:6dd:fb7d with SMTP id
 8-20020a17090a01c800b0027d06ddfb7dmr19390459pjd.17.1698330665193; Thu, 26 Oct
 2023 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org> <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com> <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
In-Reply-To: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Oct 2023 16:30:53 +0200
Message-ID: <CAKfTPtC7vtCKXG4y+7TwtjRJKkzjhPQ1Wb61OXihTDPaetGeWg@mail.gmail.com>
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org,
        robert.moore@intel.com, lukasz.luba@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Oct 2023 at 13:19, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 24/10/2023 11:58, Vincent Guittot wrote:
> > On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
> >>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> >>> computing the arch_scale_freq_capacity().
> >>> This helps to keep everything aligned using the same reference for
> >>> computing CPUs capacity.
> >>>
> >>> The default value of the ratio ensures that arch_scale_freq_capacity()
> >>> returns max capacity until it is set to its correct value with the
> >>> cpu capacity and capacity_ref_freq.
>
> Nitpick: Could you mention that arch_max_freq_scale is the default value
> for this ratio? Took me a while to recreate the (not so simple) story
> for this change, i.e. make the connection between ratio and
> arch_max_freq_scale.

something like :
"
The default value of the ratio (saved in per_cpu(arch_max_freq_scale)
ensures that arch_scale_freq_capacity() returns max capacity until it
is set to its correct value with the cpu capacity and
capacity_ref_freq.
"

Or I can rename the variable per_cpu(arch_max_freq_ratio)

>
> init_cpu_capacity_callback()
>
>   freq_inv_set_max_ratio()
>
>     u64 ratio
>     ...
>     per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
>             ^^^^^^^^^^^^^^^^^^^
>
>
> static struct scale_freq_data amu_sfd = {
>         .set_freq_scale = amu_scale_freq_tick,
> }
>
> #define arch_scale_freq_tick topology_scale_freq_tick
>
> topology_scale_freq_tick()
>
>   sfd->set_freq_scale()
>
>
> amu_scale_freq_tick()
>
>   ...
>   scale *= this_cpu_read(arch_max_freq_scale)
>                          ^^^^^^^^^^^^^^^^^^^
>   ...
>   this_cpu_write(arch_freq_scale, (unsigned long)scale);
>
>
> #define arch_scale_freq_capacity topology_get_freq_scale
>
> topology_get_freq_scale(cpu)
>
>   return per_cpu(arch_freq_scale, cpu)
>
> [...]
>
