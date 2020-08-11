Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169FB2421C4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgHKVRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHKVRL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 17:17:11 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8FC061788
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:10 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v20so979683ual.4
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BG7YFgc3xmLmgJtfXAfxYxZdUYNfvRF7uBrIdBJOZI=;
        b=MnJEPmUXAhyAuhSs5WSnq12nq2fZhQVfRdLJq41xeZ5tIkmBvs19n3/rrZy4dJeTq/
         Hr2BSIgCS1jVawdeO9VFLOdTRY/rbv4HfKugrQwlxLCf8MhTQf9E6ckjXbcJo5mgFAqt
         EkNQ+Mt42h3Qy4XjFEI98lnv+39Lw1FIELg10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BG7YFgc3xmLmgJtfXAfxYxZdUYNfvRF7uBrIdBJOZI=;
        b=T96DpXEbnlMkq8I60c+/7m7ME2CpJoRd+BIxowXcXq+89oN5FiRUiaIrUlpCg0G3+G
         TqZh7D1yOHJcQ7v0GDA6Xqfo5rT54ojnL+1Y/VW14JqZ0iHj0Mq/GD/vNmMAfIN5p2rl
         tZ2DPiAIvFz/3NNagdwlIon9/D8dijdULzcprHBNh2wEC/saWDsuX8i+0rx4I72tO/Pg
         3r52hjld1pRIql35ap9iK3vNihI3zeNd5H4opV2we8wLstwZdNMnlXpAlay5h6yWqzf5
         c4LkUIzlTMS0fR+lKnm25zhMSNlkwqX0g8p+mirfW3Sk66xhIJCs9KCGw9c/HKFDBrMF
         qrHA==
X-Gm-Message-State: AOAM532wA6RhYhea0Qd2JDoyEvFiQSA9hG2BbbX2aEzAFCV1YDQ4v4+A
        9NRXCMG7LDxU/Z9ZIVDL8f25Y+Bqth0=
X-Google-Smtp-Source: ABdhPJzZsL7VappK2q04ZVuRtg2SPAZet6C3kegTivlBV+E7nvLpzsSn1FGmP+uKu6aLfv/DDb696w==
X-Received: by 2002:ab0:4264:: with SMTP id i91mr24661442uai.27.1597180629388;
        Tue, 11 Aug 2020 14:17:09 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id b21sm6361uap.15.2020.08.11.14.17.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:17:08 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id 1so43613vsl.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:08 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr26650661vsj.119.1597180627917;
 Tue, 11 Aug 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org> <20200811190252.10559-2-sibis@codeaurora.org>
In-Reply-To: <20200811190252.10559-2-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 14:16:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uo2LaMbT4nTbcFs2t0noCm_PzBi+TNPZ6HTBe8WraQBg@mail.gmail.com>
Message-ID: <CAD=FV=Uo2LaMbT4nTbcFs2t0noCm_PzBi+TNPZ6HTBe8WraQBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: aoss: Use GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Brown, Len" <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 12:03 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> All the power domains exposed as part of AOSS QMP driver require to stay
> powered on for suspend. They are powered on when the remote processors
> boots up and powered off on remote processor crash/shutdown. Mark the
> power domains with GENPD_FLAG_SUSPEND_ON to model this behavior.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index ed2c687c16b31..5a5b4bf928147 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -366,6 +366,7 @@ static int qmp_pd_add(struct qmp *qmp)
>                 res[i].pd.name = sdm845_resources[i];
>                 res[i].pd.power_on = qmp_pd_power_on;
>                 res[i].pd.power_off = qmp_pd_power_off;
> +               res[i].pd.flags = GENPD_FLAG_SUSPEND_ON;

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

This makes my patch [1] unnecessary.

[1] https://lore.kernel.org/r/20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid

-Doug
