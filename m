Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B44D3A65
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiCITaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 14:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiCITaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 14:30:09 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0BE6877
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 11:29:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 11so2757380qtt.9
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7G/Vbkbc7NsJx5fFt/al9498lnauhqLTa0dXwnLiGE=;
        b=l8iH2X+dsdqMMvbWzPW4amMZXhWG0kmpX5kBgIn4reXKF2e6GA/wBZOVPs+1XeO/e0
         PCl1951jPNFeKgnojqAnyZ3PLdcUZkbyaXHtEhKHSavmKP1kNBgrZCdLQraabfidSwQj
         KknbHP2jh7Z4suTb3zCggoZB4WwIK81CHMQft12hbdLjpuTUVwdynRyY86TPWEYt2+ch
         W7kZ/7QHqQHj/qracTpY+LHdVtB3XSE6XMOiy4bPBltb0g1zJWvVUsAiegc8kXs5SgTZ
         WQLZ3R6X5aGIGHHhyBnxfauxmYUZagFthimyoRVMgbr2hUJDtLfnMGny09xd3NMgZ+Y4
         CcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7G/Vbkbc7NsJx5fFt/al9498lnauhqLTa0dXwnLiGE=;
        b=40rTvLkqxG1ZElloAgrr5rH+AuVlLakfxlIgiZRur3K5AjscnVxPPcQbTyHTtLd0dD
         qbtyxJ1G3fm5z0+BMx3TT3vpkRuwP98q2xwgtLQxye1XkPLNMG3W9acjxtBrKLTEJZ/L
         SQ1K0y1zKqkzQdwwoTeR0tmeO92z7Shtl0QVcq0Ki3vHwcWpNDCx9prdADJsmj4byAXU
         2T0/eZfzo/+wrAuazSIeKHdXCsQl1jWz8mlkmsJjQAXDQJoqNoQ/0y15T24u5qpP9JLY
         3bmgfcL7vgbnKzxOBN6EJejndaC/D9bHfsGeg/ZLOBNp3WXPoqf9XQ5WIW7MEJ/A+u+W
         ba/Q==
X-Gm-Message-State: AOAM533RfB0eJHelMxsx8N8s3hyl5DV3QDmlJT6cUJj20iIYeHjNDB4/
        qoGcV0h89DvmPM9fZyZuzfavr/8afxcGc/BDnySpMg==
X-Google-Smtp-Source: ABdhPJyPTjIu4MY6gA6N7QPNFd7nOPXtZFTxXgxQOMVeGxeEFvfj7zxyrIj6Zuk6McREuq/PHQ3NhnXzG0G48NZc0TM=
X-Received: by 2002:ac8:7d0a:0:b0:2e0:4e16:d3fb with SMTP id
 g10-20020ac87d0a000000b002e04e16d3fbmr1035820qtb.295.1646854148155; Wed, 09
 Mar 2022 11:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
 <20220307153050.3392700-4-dmitry.baryshkov@linaro.org> <YiaJ2cF6SkQo3Eqz@ripper>
In-Reply-To: <YiaJ2cF6SkQo3Eqz@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 9 Mar 2022 22:28:56 +0300
Message-ID: <CAA8EJprKvjzkgQMsB2XGJEariCyAFsE7D7vniS5E4++pipBiww@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpufreq: qcom-hw: provide online/offline operations
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Mar 2022 at 01:38, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Mon 07 Mar 07:30 PST 2022, Dmitry Baryshkov wrote:
>
> > Provide lightweight online and offline operations. This saves us from
> > parsing and tearing down the OPP tables each time the CPU is put online
> > or offline.
>
> Isn't that a slight understatement? Doesn't it also save us from e.g.
> ioremapping the memory, traversing DT to discover the policy's
> related_cpus and requesting the dcvs interrupt?
>
> I like the idea of getting these things out of the init/exit path. I do
> however think that we could move most of this to probe time, and thereby
> be able to rely on devm operations for many of these things.
>
> That said, I still like your idea of having a fast path for this...
>
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 580520215ee7..12b67f16b78f 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -424,10 +424,26 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
> >       return 0;
> >  }
> >
> > -static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> > +static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
> >  {
> > +     struct qcom_cpufreq_data *data = policy->driver_data;
> > +     struct platform_device *pdev = cpufreq_get_driver_data();
> > +     int ret;
> > +
>
> For backwards compatibility reasons it's valid to not have
> data->throttle_irq. This will however cause irq_set_affinity_hint() to
> return -EINVAL and we'll get a print.
>
> So you should handle that gracefully.

Ack.

>
> > +     ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
> > +                     data->irq_name, data->throttle_irq);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
> > +{
> > +     struct qcom_cpufreq_data *data = policy->driver_data;
> > +
> >       if (data->throttle_irq <= 0)
> > -             return;
> > +             return 0;
> >
> >       mutex_lock(&data->throttle_lock);
> >       data->cancel_throttle = true;
>
> This will mark the throttle as cancelled, you need to clear this as
> you're bringing the policy online again.

ack.

>
> > @@ -435,6 +451,12 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> >
> >       cancel_delayed_work_sync(&data->throttle_work);
> >       irq_set_affinity_hint(data->throttle_irq, NULL);
>
> You don't disable_irq(data->throttle_irq) here. I think
> qcom_lmh_dcvs_notify() will be unhappy if we get thermal pressure from a
> policy with no cpus?
>
> Note though that you can't enable it in online(), as it will be enabled
> in ready()...

And we can't just disable it here, as it might be enabled or might be
disabled. I think the simplest would be to call free_irq() here and
request_irq() to online().

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
> > +{
> >       free_irq(data->throttle_irq, data);
>
> As above, you should treat throttle_irq <= 0 gracefully.
>
> Regards,
> Bjorn
>
> >  }
> >
> > @@ -588,6 +610,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> >       .get            = qcom_cpufreq_hw_get,
> >       .init           = qcom_cpufreq_hw_cpu_init,
> >       .exit           = qcom_cpufreq_hw_cpu_exit,
> > +     .online         = qcom_cpufreq_hw_cpu_online,
> > +     .offline        = qcom_cpufreq_hw_cpu_offline,
> >       .register_em    = cpufreq_register_em_with_opp,
> >       .fast_switch    = qcom_cpufreq_hw_fast_switch,
> >       .name           = "qcom-cpufreq-hw",
> > --
> > 2.34.1
> >



-- 
With best wishes
Dmitry
