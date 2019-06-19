Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F364B828
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFSMZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 08:25:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45918 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 08:25:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so19024328otq.12;
        Wed, 19 Jun 2019 05:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t636JR0WhKBOeLD0UwHYBIKxLtvPrJCBGRwoWUBCtFY=;
        b=fizbzBOfmYcQZQGreojAqxPK2D3h0RYGNlD6HW4e+a+0+cQzIQY2swEWzrymtXxqrW
         v2q4wTkUmpPjqgeV95riS488ty6kYdNZVpPHA5GOfbbBlnr+9Ao9kUeDQlvu9yJ4OhYf
         lq6R5Vox0iAFY3NmqWz5XgNymj/2+pTqs1h4sdjk9wfH5PAv/6QzLhTYroaNAEBsjc0N
         FEDtoSjwTY28rHeHItDDAoz/B3kNPiKm16jG7lQTCN0wQHHfRmAqI3lQwLGDZSlH88Fi
         xm52lKb0l3whfr07to+yA+JY4I5iszxq80j+jinfXWcgim2CxBZL1o9bY5WCO6BCpAM5
         w0Mg==
X-Gm-Message-State: APjAAAX4pWJSkrelwkFUq5CTfmusGXMpxRQieF3LR5ONmAjs/hqv4B59
        uFTv6wi/Jx3eQtf5gTAi+bSeCVtYJ4RInqpVI6k=
X-Google-Smtp-Source: APXvYqy02yoWKMqt5h/YXcJjrxDjMFc91cJ/bUD9qVVWG6Usl1FN1ytOlSfXptOi2wc94asLYWkrKF21cp3FkaNK5GI=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr45214408oto.118.1560947155377;
 Wed, 19 Jun 2019 05:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560944014.git.viresh.kumar@linaro.org> <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
In-Reply-To: <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 14:25:44 +0200
Message-ID: <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
Subject: Re: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier handler
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 1:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> cpufreq_notify_transition() is only called for has_target() type driver
> and not for set_policy type, and the check is simply redundant. Remove
> it.

Ah, OK

So this patch removes a check introduced by the previous one. :-)

Please merge them together.

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e59194c2c613..41ac701e324f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -359,7 +359,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>                  * which is not equal to what the cpufreq core thinks is
>                  * "old frequency".
>                  */
> -               if (has_target() && policy->cur && policy->cur != freqs->old) {
> +               if (policy->cur && policy->cur != freqs->old) {
>                         pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
>                                  freqs->old, policy->cur);
>                         freqs->old = policy->cur;
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
