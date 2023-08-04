Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C1770BEB
	for <lists+linux-pm@lfdr.de>; Sat,  5 Aug 2023 00:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHDWZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Aug 2023 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHDWZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 18:25:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E1171B
        for <linux-pm@vger.kernel.org>; Fri,  4 Aug 2023 15:24:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so44141cf.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Aug 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691187896; x=1691792696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEVUnug0XTdb4dPdMLjEF/ofGP5YYyWfdy3u/O8Wzf8=;
        b=OMMHUVLRbKYAV066vqx5jT8L+xC5Q4BnwXT0BnT58qcpn1vDTjWKF7OPozJ+9IH+Uj
         GOltXB0xwpyEq0VpObguEutLDdep7KaPWC5EU2822yq2sfivcMxtycv4UtbxOQ7UdvfD
         XePU+sP2VboURrUU+ZV5hH4eoBvQ3rHLPtLKFVeQZ2ZNUxbLifds+ejWWd7fJhYWCHWB
         pBkSCk0Jch5aTb0YfEKVmxo21i/8rVP13KgEe/p9s5Op8i0LI0WizzqaceCjxd2WOqrI
         OgFGPZhTrkeSwCqsGFjo8Qf5spClfVaRNJuYaQjRtCX4xNlPNivxQ/5m0poCXrElXfAO
         dnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187896; x=1691792696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEVUnug0XTdb4dPdMLjEF/ofGP5YYyWfdy3u/O8Wzf8=;
        b=EKj5frOcPMJrSkniVduwmd9PSx3GtQ6ETWqsUhOkTIao/gBKwg5eLk+w6fIOtzfkhA
         1SFaE6u04Mg6Lu507s4mK9vBQQo1qBy/5OupZ3uD39640qzzciJ4wxmbG2nWU/4WGvIV
         j3crxvouBHItIWoqRipmEFYx/ruIHQJr3drxzWvpTH6PLYK+1OxSHa4XHVm3TjSKhEBo
         NLUWNUJNbjOFZDeSs3VFkdQswc3F88uf/3nnYpgmbLhJ1NN52zm22Gdhp9wUqg16ulEc
         8U/ClYd9g62TyU0owT3wgo29DnbXro6B5ypLDKahEq3XC0A41q1mnndB+bgbfhHu/8OP
         W38g==
X-Gm-Message-State: AOJu0YxP8Lxu1f7Fwk+dYdEH+IQntqInw0WX21g8I7tuGUVvNjryaR/M
        yn4jVVCMBgH9NfE3rrEw3sFzrnyhbhmn1dEtMl0aDw==
X-Google-Smtp-Source: AGHT+IGDwaOMDbEU32t+nK8Xx4mPpJHQEU1H18a76GaH12UIHXJE9DQYzvuV2ACNipagM4y0ilAvZqOG+1tmYX2LuSQ=
X-Received: by 2002:a05:622a:1983:b0:3f6:97b4:1a4d with SMTP id
 u3-20020a05622a198300b003f697b41a4dmr38444qtc.23.1691187896436; Fri, 04 Aug
 2023 15:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com> <20230731174613.4133167-3-davidai@google.com>
 <20230801093620.ggz25g3faxycp44q@vireshk-i7> <CAGETcx-Y2MONWPEWYHXsWtBxuFQP51wTCS30wJt+NYKD969BuA@mail.gmail.com>
 <20230803055157.6buxd5lcxjo4wrbk@vireshk-i7>
In-Reply-To: <20230803055157.6buxd5lcxjo4wrbk@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 4 Aug 2023 15:24:20 -0700
Message-ID: <CAGETcx9BNQmV6eJDKBMxpU7VZeDh7SYHrRNH5g1TCFrY9cPBUA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 2, 2023 at 10:52=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 02-08-23, 15:16, Saravana Kannan wrote:
> > This is mainly an optimization to reduce the latency of the "frequency
> > change" which has a huge impact on the performance (as can be seen
> > from the numbers in the cover letter).
> >
> > Setting this flag means that the vCPU thread triggering the MMIO
> > handling (on the host side) is the thread on which the host needs to
> > apply any uclamp settings. So this avoids the VMM having to look up
> > the right vCPU thread that corresponds to this CPU, and any
> > permissions issues wrt setting another threads uclamp, etc. This
> > becomes even more important if/when BPF support is added for handling
> > simple MMIO read/writes. Will Deacon has been working on the eBPF
> > part[1] and IIUC, not setting this flag adds a lot of extra overhead
> > on the BPF side.
> >
> > So, yeah, this flag is very helpful wrt reducing latency/simplifying
> > host side implementation and that's why we want it here.
> >
> > [1] - https://kvm-forum.qemu.org/2023/talk/AZKC77/
>
> Would be good to have a (big) comment in the code explaining that as
> it isn't obvious. Thanks.

Will do.

Thanks,
Saravana
