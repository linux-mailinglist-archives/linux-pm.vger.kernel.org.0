Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D43EABD1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhHLUeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhHLUeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 16:34:06 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C23C061756
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 13:33:40 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u7so8427297ilk.7
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9UDRRG4q1idI206MNqvq77jJ/SQ1JDQ5Hwl3h3QBmc=;
        b=PG349MzRnm8flbAtjVx9mm08lRYtiHgnYq6jP5dFDvUEFvpq5tgupPqfvJPHXFS1rK
         zUx/LvMTF7WOkbgJwGpt5o/fiTDkHR0ShtOTm0y1X0eB5SLAm+EYKKpiHave3awT1bJV
         3yMoZ4MAtQtJdKuMxLsQbJLX8dey4A2oLUkM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9UDRRG4q1idI206MNqvq77jJ/SQ1JDQ5Hwl3h3QBmc=;
        b=d58cChFIe9xQ9rxOAST7ATnmi7e1n554jv7e+u+v4SPPAf+5bp3ys+sfSuSxV99rqQ
         +GdnuBTQKjw+4o7Ssarrkj6eRAHkzQxbF0BdehKLSRVBJeNcNv+fbk28E9qOmk+pImCp
         u9zBP6UiCBTTCEZzPMVDGNiyIhxYjbPRdtxnEU8xLbX3Sq6ut6ILhMt4wAlXgvB83Ovd
         0suJT6snWrc0co61Y54DYzcEbJ/XMXLfom8okRtHk8CtBaYH8phMLHvWxmLUtVIn1wbw
         NVW9K/zi7fSKXQPnloKp6k5gj4pSWtM7JsPm+kVvk7ctNdD3Fau6lHCNrnd8SzQ9m5MQ
         wbTw==
X-Gm-Message-State: AOAM531cXGP+bg2Yk/gh41I0tvuxQIodEKnKZPW1aoVbmNefgdIkVUz7
        gBzVWauPvfvlOl3Hj3IkcglP2H3MCmEAmw==
X-Google-Smtp-Source: ABdhPJynhJtpm7fVYyiembVf0ryR1TkIdN2hYRfXsmpZ6gtUenZPSDtQxDrUOjeWNl2SIY9GevXIog==
X-Received: by 2002:a05:6e02:611:: with SMTP id t17mr315215ils.216.1628800420263;
        Thu, 12 Aug 2021 13:33:40 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id c8sm2071153ilk.64.2021.08.12.13.33.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id r6so7384423ilt.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
X-Received: by 2002:a92:d304:: with SMTP id x4mr324759ila.82.1628800419387;
 Thu, 12 Aug 2021 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 13:33:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
Message-ID: <CAD=FV=UF1MMKg9Y0HD3xpZ36BVZyuzr3xkwXzeSz__T1XD1r=w@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 7:19 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> As remote cpufreq updates are supported on QCOM platforms, set
> dvfs_possible_from_any_cpu cpufreq driver flag.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>
> [v2]
>   * update the dvfs_possible_from_any_cpu always.
>
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859b..53d3898 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>
>         table[i].frequency = CPUFREQ_TABLE_END;
>         policy->freq_table = table;
> +       policy->dvfs_possible_from_any_cpu = true;
> +

Why is this in the qcom_cpufreq_hw_read_lut() function? Shouldn't it
be straight in qcom_cpufreq_hw_cpu_init()?

-Doug
