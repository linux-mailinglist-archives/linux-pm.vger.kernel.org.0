Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADD6D135B
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 01:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjC3Xha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 19:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjC3Xh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 19:37:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C127AB5
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 16:37:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso21520425pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680219448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eDo3aJDVwLeCDAqSFj4/6qZNCE8g3cOEBacnGbW7bI=;
        b=pGoqpRn+ct/S38sH8FxamWuu4EFHgodhZnA86Ne+b+EusZcEX3oP1I0Y0fydMifcNb
         /O797XnqSOtMyMTliBYfarywfU/anDymn6QrgRqSr4WtrKf6cEIcFtcAZQXUH41RDQEG
         JwjyQPaU0PgpuQgaxVKrVHQIEgcjkluooP8mIW9mODu/ZMdfl4NKk+z5vbEwtXUkvCE0
         hwjXeaiDDiZrrl/1mCCBn26yjFkmOb5N6NnSFHV4FiFEyegxLObz6e26W/pSEC2uL4AG
         5i4kS+T0FAL2ACo1WPPL/ulfLMKUAhbSb5ut5TVJVOkcPJsaBiks+/K7FG0lpHqaGlhX
         UwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eDo3aJDVwLeCDAqSFj4/6qZNCE8g3cOEBacnGbW7bI=;
        b=X3ysAbWu7KbQ9GyQpNzbLsuTvzdTdvnVcPn2YPj4mTkRdBbJoLQlNVvJCiYDtQaa2d
         HtB4/OZFfrSvOKrHhHDvgjijF0L+ZR8p4x66MrHVF4wQjrrHH0ESXIf+xWNixCEA95d6
         gJWCKe7oo7oY0jjPQaba/T269wjcjhK9eh0t2ClmKSpPh6tvr+/yYcLMNm5msvkmSNMO
         Q/VhjS2TBQt29+/uE55SaF0AmOLkkNswBmjw5qs+ZReWJ+Yr9o7+6HRTNXde6mC1MtBR
         9ubyBDZC/aLkRtH+nGZgGhcvmKJOg3QMeSAUi1RFP5ybBAL4XCKpXnap/u33sWwfIkS8
         Qv1w==
X-Gm-Message-State: AAQBX9eDxByzJJ5bIIGTjHK2Da2WqT6vST78iuVUsEXeMLX81+4ZA+MG
        slGsm+8utmF1K9+0MEXyQw4A7L3qD8S0qPmNr1XCtA==
X-Google-Smtp-Source: AKy350aRhbVD0HVeNG0Zc+8z0dVv4kK0sd6xAZDKd+CWn9FN2aXR2UVptE7G4oHVXkeVHOCPhRuCkhQxTInkuAFeNeE=
X-Received: by 2002:a17:902:b196:b0:19f:36ab:c34 with SMTP id
 s22-20020a170902b19600b0019f36ab0c34mr8867229plr.10.1680219448157; Thu, 30
 Mar 2023 16:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <ZCYZRIbPh+f3v26v@linux.dev>
In-Reply-To: <ZCYZRIbPh+f3v26v@linux.dev>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Mar 2023 16:36:52 -0700
Message-ID: <CAGETcx_P27-=wkAkCETTR2Q0edA01M5jArS_t-zZFn61YM9Muw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Improve VM DVFS and task placement behavior
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 30, 2023 at 4:20=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Thu, Mar 30, 2023 at 03:43:35PM -0700, David Dai wrote:
>
> [...]
>
> > David Dai (6):
> >   sched/fair: Add util_guest for tasks
> >   kvm: arm64: Add support for get_cur_cpufreq service
> >   kvm: arm64: Add support for util_hint service
> >   kvm: arm64: Add support for get_freqtbl service
> >   dt-bindings: cpufreq: add bindings for virtual kvm cpufreq
> >   cpufreq: add kvm-cpufreq driver
>
> I only received patches 2-4 in my inbox (same goes for the mailing lists
> AFAICT). Mind sending the rest? :)

Oliver,

Sorry about that. Actually even I'm not cc'ed in the cover letter :)

Is it okay if we fix this when we send the next version? Mainly to
avoid some people responding to this vs other responding to a new
series (where the patches are the same).

We used a script for --to-cmd and --cc-cmd but looks like it needs
some more fixes.

Here is the full series to anyone who's wondering where the rest of
the patches are:
https://lore.kernel.org/lkml/20230330224348.1006691-1-davidai@google.com/T/=
#t

Thanks,
Saravana
