Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC17732F56
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245687AbjFPLC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjFPLB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:01:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBF30C1
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 03:56:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso499594276.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686912975; x=1689504975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2Zy7CoVcqMDXci8OmLm4vJBu+rnnNU0phz7Y/ATkHY=;
        b=VeWtNlBwXRH9Ch7y9OUM1BwWjuuflpYYIPrMfj7JErWYUr2W4MmNIcBad4zfjRqgNO
         +MRm0vJskSw4uAtrmfVb18aS9vIbwpCWg3qG7s1GBe5jZ0LyFTweLhadX2WMK6W5bwxL
         ZbwleeAeXbV79ZkXuJDIOErFb+gANsS92Hmsx2c38C2XuO7h/1+gLY/oipeZZ/5yw+nf
         nDwb5IovvVhaGL2jxj8tUKR2Rn5xy8MsylK94P/M6E2fzJJgvN2NYunK1eWagKXWdiqU
         7p7GUkIFxQaE7PKjB1ovnkfSoQtk8G4XjAPAxgI9g8KXjkBvERt0sM0oPfMzBvGU4vPO
         Winw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686912975; x=1689504975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2Zy7CoVcqMDXci8OmLm4vJBu+rnnNU0phz7Y/ATkHY=;
        b=eyDYnWsnk+5+BLXveBksbp+oLcSs5mB6uVvC27khnZZWUTJ27G/Av4C6a26MB3M5au
         wCwNg0/4Ymu0a5J5lkJMaFMeU0G6isUsJXasZrN3ts3AsKXX9LStrdsnq747G5LtHJhv
         dNQ5OJoo0hBEPdtAP+PMQwj3JeQnayz5LEzVAKp+jHJYHSuSJ8myA6IGnYCmKhWUc/+i
         sZKnZs/WDe0UDakpmI6OYdashKvcBl6MjUmHsz5+JfaX+0DBVr9VV2tEs2WRehrvmMa+
         4gqp5zOkoMGi7csMn6HhpQaiOlrBui0F2ulVPKQPBnMuodvVlSsyr3WNshP7+bHrDJPJ
         Y1xQ==
X-Gm-Message-State: AC+VfDxDZ4Ri195/QupVazy7NLjnm4mJdjBl0SJT7zOXVS5/MAqmp0LA
        rAABqkkFEuFV+MCv02h76+JPgrRJtxZNt4I6BaclGg==
X-Google-Smtp-Source: ACHHUZ5E+CaVkhJm2AG7yUy2sLJOiC4AvbjLzFg83siZWHq/g+J54sMfsssifxbK5idpZdHWRlU6wZg5slVckJkJETE=
X-Received: by 2002:a25:198a:0:b0:ba8:3613:76a8 with SMTP id
 132-20020a25198a000000b00ba8361376a8mr1598385ybz.41.1686912974945; Fri, 16
 Jun 2023 03:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <CAPDyKFqhVkMH42Vz0+a62j5kFh+R_CvGrcSU7hxoW__tjOhfLw@mail.gmail.com> <443b00b1-76b8-c31d-53d3-42e3592d26e8@quicinc.com>
In-Reply-To: <443b00b1-76b8-c31d-53d3-42e3592d26e8@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Jun 2023 12:55:39 +0200
Message-ID: <CAPDyKFp5L454WmTPo2eYnBuZ=ZMKEtinLgYU09n=J=3DA1FSJQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add provision to keep idle state disabled
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_mkshah@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Jun 2023 at 08:43, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>
> Thanks for response Ulf.
>
> On 6/12/2023 3:56 PM, Ulf Hansson wrote:
> > On Thu, 8 Jun 2023 at 10:56, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
> >>
> >> CPUidle already has CPUIDLE_FLAG_OFF to keep idle state disabled,
> >> Lets extend the support to set this flag using device tree.
> >>
> >> This allows to keep an idle state disabled and they can be enabled back using
> >> sysfs after certain point using below command.
> >>
> >> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
> >>
> >> This helps in cases where vendors want to keep cpuidle off until home
> >> screen comes up. In the past attempt was done at [1] but it was not considered
> >> safe option to export cpu_idle_poll_ctrl().
> >>
> >> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com/
> >
> > Before considering this, I don't recall if I ever received a reply to
> > my earlier suggestion to the above thread. So, let me repeat my
> > question.
> >
> > I am wondering if a similar improvement can be achieved by
> > modularizing the cpuidle-psci driver. If insmodding it after the
> > homescreen, we allow only ARM WFI during boot. This should achieve the
> > similar results as we get with $subject series, right?
> >
> > [...]
> >
> This will not work for targets which does not have DLKM support.

Right. I am not saying it's the perfect solution, but it seems like it
could potentially solve the problem for many cases.

If you want some help to turn the cpuidle-psci driver into a loadable
module, just reach out, I am happy to help.

[...]

Kind regards
Uffe
