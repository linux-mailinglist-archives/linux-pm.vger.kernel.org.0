Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7942773F08
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjHHQlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjHHQkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 12:40:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B63A4EE
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:54:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcac140aaaso4523053a34.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510070; x=1692114870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVUMGFTGmIMs9gxfcxcS/lMOKLXcrXhxKdcNy5Sb/7k=;
        b=WQ4pE5FnmzVQjye3xLE3JL+yOo6Ug6M4LCOtu2zdp6OaIYA8agsznYIgKSC2lJs4IE
         3cTw2aMB6mL6So1uYmtyvGovPugiVmRaNVJGdGF8ihRcmt9zyA7TIm3zFICAYG5i3hEB
         yh/ERHnvJKb2hXfYSyY3f63ic40kAvE7CGpW/AK7e/49Bp2TZgkkNYPiXHjDPrUhdwF9
         63Z/hhEY+hmcZkhAepFlTTyHX1/Auxb4b+XLDw+MK3lYZDDp5Mlr05r/CWFsNwgE/0/S
         zzo4F1dONQ3/+jQN0iRy+zmw/ELXeA2ufyGHh+ar+uO/7ghyC25n3NECxK2MBKm14r0Q
         2ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510070; x=1692114870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVUMGFTGmIMs9gxfcxcS/lMOKLXcrXhxKdcNy5Sb/7k=;
        b=hEQum+R0z/M3O0v2B3fUwa+R7OK1qAnSYDX/QujVNFqqY5yyxbvIr7Cfa61Lcj/2pj
         yfi2Rb6dJAIZyJKqiQghg8jOY40euTGCNjj+yrqm4B7rqJFU2QUiP+X5ntEdzbAybD47
         xRBiAjfvEb6IahJhRxZ3YsViCTIIjA7lcRzuHreg12DpEQ9Kx2P4Tg9CXkGWu5UGeuK3
         uPvSkCYgXMwIyTDgZ8K9cZobsSQapCoVfSpLg73D3zKyPJaDn5pPdcW5QSBr1gLMWZJV
         j8vpx+pdmWRYsjM2d5bnJj8/i04xUhAq5WXCdALn58MHJcmJrCzgpTtrp3fcxPNbE1xB
         BmSA==
X-Gm-Message-State: AOJu0YwQxlqe6/OkXqLQIc0/llFtCH8XYV5Mr7/JSF6RriZp8IiUSbc+
        mc5UsNgosUcL1/3lM3uk2ikcOHc9hvT0BFVcevAqf0fwMGBarSH0wI0=
X-Google-Smtp-Source: AGHT+IFi15UXHlOjBafsncghPZ+CygvrFkHgT7nBLzL88m86kzLUpO8Z8UvMrvXkkHrJrBoiNDOqbizpom1bnSTUbwg=
X-Received: by 2002:a05:6902:30d:b0:d43:9eae:52b8 with SMTP id
 b13-20020a056902030d00b00d439eae52b8mr9684261ybs.10.1691504305098; Tue, 08
 Aug 2023 07:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
In-Reply-To: <20230703085555.30285-1-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 16:17:48 +0200
Message-ID: <CAPDyKFrp6WQYW7uKwPLrWROEiXHCjHd6Y1O9yitZ6fJE7EO7bg@mail.gmail.com>
Subject: Re: [RESEND v4 0/3] Use PSCI OS initiated mode for sc7280
To:     andersson@kernel.org, rafael@kernel.org
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, dianders@chromium.org,
        swboyd@chromium.org, wingers@google.com, daniel.lezcano@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bjorn, Rafael,

On Mon, 3 Jul 2023 at 10:56, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> This is resend of v4 with patch1 and patch2 Cced to stable kernel.
>
> Changes in v4:
> - Add missing s-o-b line and reviewed by in patch 1
> - Address ulf's comments for error handling in patch 2

This has been ready to be queued for quite a while and I have been
nagging you about it too. Sorry about that. :-)

To help out, I have queued up patch 1 and patch 2 for fixes, through
my new genpd tree [1].

Bj=C3=B6rn, please pick patch3 for v6.6.

Kind regards
Uffe

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git fixes

>
> Changes in v3:
> - Add new change to provide helper function dt_idle_pd_remove_topology()
> - Address ulf's comments for error handling
> - Add reviewed by ulf for devicetree change
>
> Changes in v2:
> - Add new change to Move enabling OSI mode after power domains creation
> - Fix compatible string to domains-idle-states for cluster idle state.
> - Update cover letter with some more details on OSI and PC mode
>   comparision
>
> The dependency [2] is now merged in trustedfirmware project.
>
> Stats comparision between OSI and PC mode are captured at [3] with
> usecase
> details, where during multiple CPUs online the residency in cluster idle
> state is better with OSI and also inline with single CPU mode. In PC
> mode
> with multiple CPUs cluster idle state residency is dropping compare to
> single CPU mode.
>
> Recording of this meeting is also available at [4].
>
> This change adds power-domains for cpuidle states to use PSCI OS
> initiated mode for sc7280.
>
> This change depends on external project changes [1] & [2] which are
> under review/discussion to add PSCI os-initiated support in Arm Trusted
> Firmware.
>
> I can update here once the dependency are in and change is ready to
> merge.
>
> [1] https://review.trustedfirmware.org/q/topic:psci-osi
> [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> [3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
> [4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum
>
> Maulik Shah (3):
>   cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
>   cpuidle: psci: Move enabling OSI mode after power domains creation
>   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
>  drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
>  drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
>  drivers/cpuidle/dt_idle_genpd.h       |  7 ++
>  4 files changed, 117 insertions(+), 51 deletions(-)
>
> --
> 2.17.1
>
