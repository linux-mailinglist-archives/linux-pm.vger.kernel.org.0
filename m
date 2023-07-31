Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9253F76A4F5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGaXqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 19:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGaXqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 19:46:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD6E63
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 16:46:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31758eb5db8so5255573f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847200; x=1691452000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKy5jhge1ThZxYuKVzWR6NJXyjCfAL7R6EKNS/gYYcg=;
        b=PCgctvhZtvsnjctsCDCFhXav7VCXmOB5xbGlS8l7E9REFtdcMSOR7cxfAA+zXVY0sZ
         SqBR9icyH3nE7TbNcqSxbumY5HxPX4Ta9Pz5QiC/PPIhq/cDCRRNcYv8ffQ2414xiYWp
         PS90IfWZlT+F5lt07KbB7gIHdOPeX5hXdliCY+Skk84XMO7ENKfrZzSFI1bXhwHRqAmx
         od21aTQgIW2PBX79HDpa/owrTjtzpOLeFSyb4muQlDI+nywYUnP6aUoFFZHUTsFMaJHk
         HxIZG7v43Zac9j40XrGAp+MYl6v23tdBzathXt3renda96sZ5Q7AuSca2afihM6SBuqT
         TDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847200; x=1691452000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKy5jhge1ThZxYuKVzWR6NJXyjCfAL7R6EKNS/gYYcg=;
        b=KSYsixTSbwF0fEI8qhB9B6M05NIsmQEOhcbD4rFu6aMkIghopFNtGR3cyuy/2XIBy2
         8wcgFrIOvRZudDx2PuGtdYeSEDtgKSLz+3vHzc38uR7uDUU5E7qv6WU+fPvzElBcAmhd
         ZAr4WY1L26VU9+uNyDyHpRB8igk/5C/WYrSbXLv7c1Tr7T6H64saWHus5xe+ZG44rHan
         4w69peQ7hzpgy63bhJIDE0vybVoM3cQ0Gm0uega2spcAzucY3qNYA6Sm90SnJLFTspb+
         IlGou7hN1SNfUtdjbMSH9VkuU3SEjd7ZXX2FgEs42Q2K+b8Yrz2CyygvbrF6C8KIA0WY
         jigw==
X-Gm-Message-State: ABy/qLaSiP6hFoL3y4CT5r6kOUGWDSUEu2iZK6VyZDOqbF6mxgHmCaph
        5kYi8Gj9jyEfBcZbiJ1iidvOZSvqUMTAUhhjGTJAqg==
X-Google-Smtp-Source: APBJJlFGUYIU+wOyt1NBLOOIcQwBc7lzgzRFhGFfyCA0DxnJ2P7PbcDice062zz9wvT80OQ0qNPZVDUe4QhSBJUH2bQ=
X-Received: by 2002:adf:e291:0:b0:317:67bf:3376 with SMTP id
 v17-20020adfe291000000b0031767bf3376mr905138wri.57.1690847200504; Mon, 31 Jul
 2023 16:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <afac2810-f93e-eda5-975e-041ac4b908b5@infradead.org>
In-Reply-To: <afac2810-f93e-eda5-975e-041ac4b908b5@infradead.org>
From:   David Dai <davidai@google.com>
Date:   Mon, 31 Jul 2023 16:46:29 -0700
Message-ID: <CABN1KCJ0dfVBGdL0dd=ES2gmFJEgm89ArBsXWDC4hE4TZehk=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

Thanks for reviewing,

On Mon, Jul 31, 2023 at 3:02=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 7/31/23 10:46, David Dai wrote:
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index f429b9b37b76..3977ca796747 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -217,6 +217,21 @@ config CPUFREQ_DT
> >
> >         If in doubt, say N.
> >
> > +config CPUFREQ_VIRT
> > +        tristate "Virtual cpufreq driver"
> > +     depends on OF
> > +     select PM_OPP
> > +        help
>
> The 4 lines above should be indented with one tab (not 8 spaces).

Ok.

>
> > +       This adds a virtualized cpufreq driver for guest kernels that
> > +       read/writes to a MMIO region for a virtualized cpufreq device t=
o
>
>           reads/writes to an MMIO region

Will fix these, thanks!
David

>
> > +       communicate with the host. It sends frequency updates to the ho=
st
> > +       which gets used as a hint to schedule vCPU threads and select C=
PU
> > +       frequency. If a VM does not support a virtualized FIE such as A=
MUs,
> > +       it updates the frequency scaling factor by polling host CPU fre=
quency
> > +       to enable accurate Per-Entity Load Tracking for tasks running i=
n the guest.
> > +
> > +       If in doubt, say N.
>
> --
> ~Randy
