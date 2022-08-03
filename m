Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBA5886C2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiHCFc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHCFc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 01:32:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CB2C673
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 22:32:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y127so26782594yby.8
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2022 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AxYxTW+mhbxHIf6UQf3IxPSko9k7acRAZPqZhSwcPbw=;
        b=eTi6tN0/wIBuNr4PXwwtS8Eo4mlstxjw1Penif/+qcCkP51imD8kaQdQIpuHu/tUql
         XiS04CWDdTNtaenqxDDSrL4zW4ksbrkqEl1GQYFlFA4P8cXwUfOv367V+U9GT6dJoML1
         39eEk0VTKNh1AydnJbX5tmuo7W36+EE9lCf6paQEaPTO/rwZTZMmsXxeeHMEvkfE5CPE
         wHKJKlLq1rMrezWn7bxm9lSSMcPJYD6EP0x7MWKA5XxvtqLuoAzfvW2REDAh/ay4WpTG
         cg5EKlTdJvwNanEKVdRr+vUrJomNBjnpsiffS+9TXGUsqcdGoUoEUHm6QATFvDXtydAu
         iJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AxYxTW+mhbxHIf6UQf3IxPSko9k7acRAZPqZhSwcPbw=;
        b=jRNIVp7xbDMhxI7VvquNJFr5p/qvmg2wWOhClHqKTiT0RGpfXZ3R5kwRk1xb6xitem
         1uCzBePkNyua5GI3l7ErrqAUzDuMyeh7DZuZvqZqy6MK+YcGP9s+PGIEbZPDsi6pMaXq
         NYjwde3gKjgjtZPFLwbRvtR6vHEOXmvHozxyHKgiAV/PcDdMugDRbMYv4wtOhEad3/4i
         00MredyaynaX4hP9LmNPDDBXZ6yXiQCWXIe9HNpBVkq8EBtMtZArkhCRUoNa488p7jcS
         ujPCsItlYPcvabbvV6Ib1RicbqgyLZeS5+WoIE8HX93C93M5nbQT2nmm04pab5Lgb4NH
         XqPg==
X-Gm-Message-State: ACgBeo2Gx1TuYAF0AqEIvZgtENU/4YrTlrA5qJUkTT2tWUJoMBn8bdo7
        ddmXtT/pUoyXh/Rg2FO44pU572lKdycrbwpJtmGYSg==
X-Google-Smtp-Source: AA6agR6NHDvBUXHePHA3eUfQS2EZ9G93onA6VcVGuMrpEx5CRj8UE2QfY4Qn6VJ1PhkjOXmKqMfdW3uuPTfToC8VpuE=
X-Received: by 2002:a05:6902:245:b0:670:a73b:f87d with SMTP id
 k5-20020a056902024500b00670a73bf87dmr18690720ybs.643.1659504775285; Tue, 02
 Aug 2022 22:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
 <20220724122424.2509021-6-bhupesh.sharma@linaro.org> <b5df1acd-d92d-782f-8fb7-41842611c788@somainline.org>
In-Reply-To: <b5df1acd-d92d-782f-8fb7-41842611c788@somainline.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 3 Aug 2022 11:02:44 +0530
Message-ID: <CAH=2NtztrMyPzvF9-9jsCnuM=40TmzXUvLBu_O5r_zRRtRwSiw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] thermal: qcom: tsens: Add reinit quirk support for
 sm6375 controller
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,

On Thu, 28 Jul 2022 at 19:42, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 24.07.2022 14:24, Bhupesh Sharma wrote:
> > tsens controller(s) on Qualcomm sm6375 SoC might start in
> > an unknown state or start with TSENS_EN indicating
> > a 'disabled' state when they enter linux world.
> >
> > In such cases, it is useful to try and reinit them via
> > trustzone [via scm call(s)], at the very start.
> >
> > Add hooks for the same in the qcom tsens driver.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Amit Kucheria <amitk@kernel.org>
> > Cc: Thara Gopinath <thara.gopinath@gmail.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> This sadly doesn't work.. the issue on 6375 is that the controller
> is in some weird state at boot and this bit that's higher up:
>
>         ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>         if (ret)
>                 goto err_put_device;
>         if (!enabled) {
>                 dev_err(dev, "%s: device not enabled\n", __func__);
>                 ret = -ENODEV;
>                 goto err_put_device;
>         }
>
> does not succeed.
>
> Moving the code added in the patch up or calling
> qcom_scm_tsens_reinit() or qcom_scm_tsens_reinit() and
> tsens_reenable_hw_after_scm(priv) directly before this enable
> check also fails. In fact, the latter crashes the platform..
>
> I don't want to block this series, so I suggest the 6375 part can
> be dropped for now.

Many thanks for testing the patchset. I agree.. let me drop this patch
from the v3 version and we can later target this sm6375 issue via a
separate patch.

Regards,
Bhupesh
