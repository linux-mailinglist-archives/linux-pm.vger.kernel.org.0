Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661943F6ADE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhHXVNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXVNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 17:13:14 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C1EC061757
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 14:12:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso49769934ott.13
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=VvJ41OUQjcIqP2/V4RRgvKQKaUvc+Q8/8VHMdF1do8Q=;
        b=a0llSe0VINrc71feDG/BpuGjlsKvKo1iN5416uQ31/w+N0ksxUtZ2meejEL/ITGZ/d
         bJ3OvkrKH+YluSXZMocEAT8uHOzSCUb+SdTwx5+9DPC7LsEsKDFETFXq5jnAc36l2T6Y
         vfciSWjKmqrl9mr7EVpRx7xmCEzgFsXnO6QcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=VvJ41OUQjcIqP2/V4RRgvKQKaUvc+Q8/8VHMdF1do8Q=;
        b=sPyBhk6OseSYfOMSkQeModTIfxhUp8LCsBvQMeLsb4v8RbLNskk6EAmTBezSMIpjN4
         beOjGro+rsKnigys8SrVUnkg94dTc312ojmPF39mO/hfv6peHKTnIBBGP71JWCLVhDiz
         kEJhC6GUN5kig3qm9Ea0YyifIsWxdTlyP3qoeYRG5kTMOWEoRBNTBM3/08JPZidJAsuT
         Ifr+9DZZwicd+5ZrrstUQTbJN9gMNcwp0N6XLe42foQiQeRYNkBGJNFpIUPAIJ4gAMC9
         KkJIF6esj+VuNfF14HwuSYWDozGZHhMKdB6oIiJ0URUFYSp3xvzy85A7VIr3AAa5A9uT
         QOgQ==
X-Gm-Message-State: AOAM5330eOEm7wfkzrycNfW7eprI7uiKaV7dEKu49C18m3btMCKnS/uM
        29aTO+ov5+aiN4cb173f/c7LzQ1Fi/7i84WR6vS8Dw==
X-Google-Smtp-Source: ABdhPJx08FQcEL2UXtCAGxTVtKc6L4YcEdQ26f3P0zd41icoXQklXAOtrjA3tbBpHCVb7lXrokHsBMM4SWrlwn2irUI=
X-Received: by 2002:a05:6808:181a:: with SMTP id bh26mr4480953oib.166.1629839549674;
 Tue, 24 Aug 2021 14:12:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Aug 2021 14:12:29 -0700
MIME-Version: 1.0
In-Reply-To: <YSU8djt765o81YiQ@google.com>
References: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
 <CAE-0n52Rp9QGUYeP==YdXEJAwbtHtZX=5b3gaR-smLMFybsf6A@mail.gmail.com> <YSU8djt765o81YiQ@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 24 Aug 2021 14:12:29 -0700
Message-ID: <CAE-0n52SDVCqyp64cWd0uw1F4NRO3N8dT5LNOO+eh-zvWpffoQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom: spmi-adc-tm5: Don't abort probing if a
 sensor is not used
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Matthias Kaehlcke (2021-08-24 11:37:42)
> On Mon, Aug 23, 2021 at 06:50:04PM -0500, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2021-08-23 13:47:30)
> > > adc_tm5_register_tzd() registers the thermal zone sensors for all
> > > channels of the thermal monitor. If the registration of one channel
> > > fails the function skips the processing of the remaining channels
> > > and returns an error, which results in _probe() being aborted.
> > >
> > > One of the reasons the registration could fail is that none of the
> > > thermal zones is using the channel/sensor, which hardly is a critical
> > > error (if it is an error at all). If this case is detected emit a
> > > warning and continue with processing the remaining channels.
> > >
> > > Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> >
> > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> Thanks for the review!
>
> > Should we also disable the 'charger-thermistor@0' node in
> > sc7180-trogdor.dtsi on lazor boards, instead of the thermal zone, or in
> > addition to the thermal zone? It isn't used so there's not much value in
> > exposing it.
>
> I wouldn't do it instead of disabling the thermal zone, a TZ without a
> sensor doesn't seem very useful.
>
> IIUC the thermistor nodes would need to be deleted, not disabled.
> Currently the nodes don't have labels, so either the labels would need
> to be added, or the deletion would have to look something like this:
>
> &pm6150_adc {
>         /delete-node/ charger-thermistor@4f;
> };
>
> &pm6150_adc_tm {
>         /delete-node/ charger-thermistor@0;
> };
>
> If the change is done for Lazor it should also be done for PomPom and
> CoachZ.
>
> I don't see a strong need to delete the ADC nodes with the clutter it
> adds, but I'm open to it if you prefer :)

The driver will be present in system memory when it is never used. I was
mostly noticing that adc_tm5_get_dt_data() calls
of_get_available_child_count() and bails probe if there aren't any child
nodes. In this case, the only child node is charger-thermistor, so probe
for this driver would fail if the thermistor was removed. So at that
point, I wonder if we should disable the thermal zone node (already
done) and then also the adc node (sadly called adc-tm). This way we
don't eat up kernel memory to describe a device that isn't used and a
driver that wastes time probing and then fails to probe anyway.
