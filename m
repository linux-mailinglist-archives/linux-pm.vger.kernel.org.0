Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C2163864
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgBSATS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 19:19:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36197 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgBSATR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 19:19:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so21453631otq.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xenh2Sb7watxNJKL24pMYing6QNd1CcZcrQqPV0Tmqc=;
        b=OtBOFvHpDvOG/VrUXyWUqM7/v93QMT690BDatQIdj4wKhYvlnn/TszCLy4WZEd0uH1
         PvT2NIC6GflEREjR7GMOwzt79s3Mq5OdV+wwBC4BvW6tLoFAzeeIi499q2VuSoOR4al1
         fVnCluY89EcQHTVt4DA+Yobkp/sG1FzVMy55Z0hFR9EeVlZj3Y3TxNQMqD36p/jt+592
         Sbj0PRujciQo2114ylm54UcukkvTu6eVlTAzUjU154FQmKb3BrTAzhceOHtUGkM4whJH
         TS9dvtMRhULVi7xu5/E5dHfcj7qF/OR1XODIJSnVr/ZV8FVWi8Ahxbe8aAuSBXhDCkw/
         Nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xenh2Sb7watxNJKL24pMYing6QNd1CcZcrQqPV0Tmqc=;
        b=F9jNrHxODppYjWFH+TmEfFhk5ZbTdhSv4pokyfx8x8MFMUSFvEfRtMIVfFP1SHt8vv
         zH7pT2iYU6/QhXPRHVQtvOhY7lDGvhYPDMf56zYwjVUruIHiy7dpj+CgKtay0D57PFLQ
         waRMucXam26AjIyzR4NX7DqUOmJgnOkqzBoEzmN9R4M6dS3qyCSWI6xQ8fy0IC/V1AxZ
         3jhjT4+fnYFEpjQhIT8uV7nUvHZG4kUEkm0fWkE/0Wm1b24fBbOaD6Q8eqon+79wpZ85
         a5pd6QTXN9B0mN9RVscEYpo4kgy+tCQ2/J4b0mBm33pwUGAT72146LKY7bOM3+irlTQy
         VHqA==
X-Gm-Message-State: APjAAAWrIa9LkG8XYRXTqPSOIzGUMQINI5mGLdt8n7laDviPhwkPS88k
        3bcYo6u06eBY+4Vo82wVNwzX6tftJcT1kcmDV9ietg==
X-Google-Smtp-Source: APXvYqyWeP93XV4oSanGCNVvzUTbLsEGnn0vejUafZA+l6yt+5W3qHMpIqtdSnnnzDUW6i7itjjql9xeMAeIzRuITjY=
X-Received: by 2002:a9d:634c:: with SMTP id y12mr4006764otk.12.1582071557097;
 Tue, 18 Feb 2020 16:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
In-Reply-To: <CAHp75VcPL7DYp9hjgMu+d=CE=g+V7ZxT9ZyXX-OjEW_JQ4m_nA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 16:19:05 -0800
Message-ID: <CALAqxLWtYfwCzDRVecWF8yRQSKQZh-N2g0SifageUaG0QhBGJg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 18, 2020 at 4:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wednesday, February 19, 2020, John Stultz <john.stultz@linaro.org> wrote:
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index b25bcab2a26b..9d916a7b56a6 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -237,13 +237,12 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>>
>>  static int __driver_deferred_probe_check_state(struct device *dev)
>>  {
>> -       if (!initcalls_done)
>> -               return -EPROBE_DEFER;
>
>
> Why to touch this? Can't you simple add a new condition here 'if (deferred_probe_timeout > 0)'... ?

I think that might work. I'll give it a spin later tonight and double check it.

The main thing I wanted to do is fix the logic hole in the current
code where after initcalls_done=true but before deferred_probe_timeout
has expired we just fall through and return 0, which results in an
ENODEV being returned from the calling function.

thanks
-john
