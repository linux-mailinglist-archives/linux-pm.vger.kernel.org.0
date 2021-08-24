Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632A3F6923
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhHXSi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhHXSi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 14:38:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF5C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 11:37:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fs6so1392997pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tv/nPc8c3b2qEEOTOUCkzBCA/UiZaoRBnN+t+aCQOu4=;
        b=NKUmxzcATIKvEt/jjhKnjVZN2Cfmdjm8h5j/1Lq/MhWpLUmgL0Bkf+gpFWP6l6+1f2
         q9PADEOVGFuBGZ8YcqmJRxYaIiahEmsY6ObaxXyltz1dBlYDnteopN0uN12HO7i3mHzF
         R+XG9lmLbjGy1/LPQjpHEg9wUTDnkX16Jispg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tv/nPc8c3b2qEEOTOUCkzBCA/UiZaoRBnN+t+aCQOu4=;
        b=S9h7zNILFxmMaEmHWNUVxWghkRlKSiW2st7tct7RifH+1gNy8Irp8B8Ze8bpFwNk2a
         BlXNr9HGARiBdDsV/jdYyZcsHXZwq2DSp1ug/3FnsiE1SMVWjIYgZ2UARdksPAqV836m
         rALwb7R+VrWgifyXHg6sSQEMPZgu/bRVHTQf3OeisHBKSrNxD06Zhc79qK1WYgClWglu
         iW9sA3iIz310cSZzeD0/VrVgd3caCsOvCi6lcagxhnHfJ5pArhkeRD/qiatB4PmxXSlr
         V7VG36UeA1QgLM7rqens0wxD7YKrD8j+GDs52xUHpxPTVagf/AnQ58BQH8eZn3AN8fgs
         SrqA==
X-Gm-Message-State: AOAM531cbP2cwNQT454VfJUU5/C7PA7AC5g4OSbVMWPj+y2lbje8gp8k
        9COV8fiNfP2Z5vCd6wHqzFOeRA==
X-Google-Smtp-Source: ABdhPJzTmCLJO0i02apqzlEk3S7QLFHlA5GXZgG4/wXfDOzlCYW6C29KqFcaYGzh7WDyP99s9zWX/w==
X-Received: by 2002:a17:902:b190:b029:12d:487:dddc with SMTP id s16-20020a170902b190b029012d0487dddcmr5054694plr.24.1629830264572;
        Tue, 24 Aug 2021 11:37:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:476b:8ddf:c945])
        by smtp.gmail.com with UTF8SMTPSA id y19sm19393870pfr.137.2021.08.24.11.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:37:44 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:37:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: spmi-adc-tm5: Don't abort probing if a
 sensor is not used
Message-ID: <YSU8djt765o81YiQ@google.com>
References: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
 <CAE-0n52Rp9QGUYeP==YdXEJAwbtHtZX=5b3gaR-smLMFybsf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n52Rp9QGUYeP==YdXEJAwbtHtZX=5b3gaR-smLMFybsf6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 06:50:04PM -0500, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2021-08-23 13:47:30)
> > adc_tm5_register_tzd() registers the thermal zone sensors for all
> > channels of the thermal monitor. If the registration of one channel
> > fails the function skips the processing of the remaining channels
> > and returns an error, which results in _probe() being aborted.
> >
> > One of the reasons the registration could fail is that none of the
> > thermal zones is using the channel/sensor, which hardly is a critical
> > error (if it is an error at all). If this case is detected emit a
> > warning and continue with processing the remaining channels.
> >
> > Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the review!

> Should we also disable the 'charger-thermistor@0' node in
> sc7180-trogdor.dtsi on lazor boards, instead of the thermal zone, or in
> addition to the thermal zone? It isn't used so there's not much value in
> exposing it.

I wouldn't do it instead of disabling the thermal zone, a TZ without a
sensor doesn't seem very useful.

IIUC the thermistor nodes would need to be deleted, not disabled.
Currently the nodes don't have labels, so either the labels would need
to be added, or the deletion would have to look something like this:

&pm6150_adc {
        /delete-node/ charger-thermistor@4f;
};

&pm6150_adc_tm {
        /delete-node/ charger-thermistor@0;
};

If the change is done for Lazor it should also be done for PomPom and
CoachZ.

I don't see a strong need to delete the ADC nodes with the clutter it
adds, but I'm open to it if you prefer :)
