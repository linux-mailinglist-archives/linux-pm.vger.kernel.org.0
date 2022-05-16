Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4E5281F2
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiEPKZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 06:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiEPKZE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 06:25:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4BDEEE
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 03:25:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i20so15413517ion.0
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTo0qY4qQgxJkitwVcq8KgHfBlJlWID4iFoIHlxueiw=;
        b=Dru+4XMrLKy46CAqyjByKC4XWPFK0jI7p3XA5l6APRqrSdI96JioqoD0fQvTtDjqzJ
         Mom8RxPWUtGPP3N2x9FxhMXrKHLEGo8ZWpBxpJ6+WJYvspSkcZih8QXM362BZqBRwC+g
         NMINHuHxAR8LOm3RNBCtJ41enhyyORWyIqPAIEtywX1rCjC2JTaJlXY3NCJgCyxDfa9n
         f1J8ENAxM5i3H2V+YTS0MGpSiOlKnDUVNq3QKBx4o+vekhrE+nT1cg9LdnuA+7uYBEDp
         GRhHsaEqOuI5MwsFJuzFPDbEGympXbYEplB95NtWdooQT1TJag7QL4W9E3O+KkaLCQrk
         DnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTo0qY4qQgxJkitwVcq8KgHfBlJlWID4iFoIHlxueiw=;
        b=ztY5DVU07AhJj+frT6nD+E4BBcIzbqzbHRbzgfT+ofezm+hfhAuLj9677KtzufsTx1
         cOExKEr8XoYdX8mrBNjYPT9LVsoVr9gUdYA/8Aa2We/IPhKh4bo+YFZcrnpISJHT21Me
         WjO/gc2YW3PYReALnK+WGYfxrt0VefGK30sEBDm35GOuTQvzToXyeSTyZtc31T01KQKE
         C9g4bZqjaQa+4oGc40bCSrLDw7lIlrcN9BlZoPFb15zFsg0Orm022xzdmMQ6NwCdz9cl
         OtT+UCH84D0jhpBqJagNW+eYA8Gd024TDjHQGa5UegMXaGBdcIQIsO5ScUVbON9fAhh/
         nGog==
X-Gm-Message-State: AOAM532piBGWAAPb/w53k1rT497H0inzNbJ4oar44miSIYEq+kUFMy+M
        BhYRw1L5HuNw5va2Vi29pt+/tBWqM5ManlcSMQmHqw==
X-Google-Smtp-Source: ABdhPJxiwg+0C7eGGBCGUJ2Uvvu9Z4mJHyrzmaFOQeqpjtSlh1vTjwGP84gHeqkbo/KAnQd30xfguEZ8O0e+03cYWEE=
X-Received: by 2002:a05:6602:1591:b0:60f:6acc:6979 with SMTP id
 e17-20020a056602159100b0060f6acc6979mr7772505iow.173.1652696702110; Mon, 16
 May 2022 03:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030251.42323-1-schspa@gmail.com>
In-Reply-To: <20220516030251.42323-1-schspa@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 16 May 2022 11:24:50 +0100
Message-ID: <CAKohpo==gvvyd2HxL3sLTqXS-VbFeprkgAdSAjU3mnbq4Qn-Jg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] cpufreq: Abort show/store for half initialized policy
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 May 2022 at 04:03, Schspa Shi <schspa@gmail.com> wrote:
>
> If policy initialization fails after the sysfs files are created,
> there is a possibility that we may end up running show()/store()
> callbacks for half initialized policies, which may have unpredictable
> outcomes.
>
> Abort show/store in such a case by making sure the policy is active.
> Also inactivate the policy on such failures.
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
