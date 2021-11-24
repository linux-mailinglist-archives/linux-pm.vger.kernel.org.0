Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18AF45CA15
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbhKXQe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 11:34:59 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36533 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348932AbhKXQe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 11:34:59 -0500
Received: by mail-ot1-f53.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so5130102otl.3;
        Wed, 24 Nov 2021 08:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClXsnWSXwelpafLarIuF6EqOtJknws1eom5YROE5yGw=;
        b=LIoL5DzD+psM4DFD69uWxrLQZ5izULLPmDqxcZV0nCv0bD8o1iLNPO437B9MS+OUnq
         FxxcH7CPok2baoMTeUCsMlzfEh6ly7h669ebS/Z7Vwj5PX4oo+mRJJmxjrUKq7dVMwG5
         6zBhsiYKa+03eexoBWF1chCmQJX0lP9jw4NG8j1Yfp1TUnefxPScOOliYx1JEwrU5V72
         6KSLFC/LIczha807eXIH7vjZij5ywYPo2Aj47FAHORyJtq5+lmmiZkg+vu+ab5Et+Cy2
         C89VYFYhP+lPe+2Ph+kItfaLo4XGBgOfn0JZmh9a/EvhuT6+PPVIAfUB3b99QoK+x3JC
         Ur5A==
X-Gm-Message-State: AOAM532OgRAKpoeSzcvWMV+8Q/+hy2N1sZ4KS6rLWLpiJZ99scbrlS6T
        47bFk43aKY86cOQWAs/BLJPpMyCfr0krqcLz1is=
X-Google-Smtp-Source: ABdhPJzL6+eLQFBJS+bp7zsgoa/9Q0gwD/MaJbda+fKUekCsnEhaops5rZTIYt9/O/65HM537Wa8QQGwXQymT3EPQOk=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr4144459otf.198.1637771508941;
 Wed, 24 Nov 2021 08:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20211113060618.220832-1-wangborong@cdjrlc.com>
In-Reply-To: <20211113060618.220832-1-wangborong@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 17:31:38 +0100
Message-ID: <CAJZ5v0itn3ndomA1deOMZiV5pKTOptq02iG08vXpuEw5tgK6gw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Fix typo in a comment
To:     wangborong@cdjrlc.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 13, 2021 at 7:07 AM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double word `these' in a comment is repeated, thus
> one of them should be removed.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 2e5670446991..c4922684f305 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -34,7 +34,7 @@
>   * 1) Energy break even point
>   * 2) Performance impact
>   * 3) Latency tolerance (from pmqos infrastructure)
> - * These these three factors are treated independently.
> + * These three factors are treated independently.
>   *
>   * Energy break even point
>   * -----------------------
> --

Applied as 5.17 material, thanks!
