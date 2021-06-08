Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9439F95B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhFHOli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhFHOlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:41:36 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D1C061574
        for <linux-pm@vger.kernel.org>; Tue,  8 Jun 2021 07:39:42 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id d13so206327vkl.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9JL6GQBrbia5ZUKjbw1dPoYLRps1kdBbTif5jsryJ0=;
        b=jllCO/Oy8PYSQ3Asp/fe59Ithm6VaXNkW9IAlpj87+vwQTDPOXcKNWR2G8AJuRWxbv
         vhU7lfM8EmkEV9Rp6q2dBxdPlqwJiN4HPhBLZNdVd3yBREfjRUKL1oLy7TS5CKXQ8AvJ
         by4gLGiYR9XJAJ9DhhWTztfCCKlOaQriBO8zzaoQ79NM+ULaa2gA4f12ogsM9yNG+zsh
         w6sUCuN05zJaRpEz08adFBUACHr5Gy1IPkW1fDshK6Vc49Q7fP/dxsJVKOqtJa95LAVN
         EhXxkGd7ahI09xQfqRdKk5HmdLkfBlhCooSaqHlfk91R3c0vLBNiflx84oPtt/tqd6d9
         mhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9JL6GQBrbia5ZUKjbw1dPoYLRps1kdBbTif5jsryJ0=;
        b=ccYqsfyai7f+ZZXDZX++FeTnVEjxemrRprjDwO7k8yRcRTgb5bJTkDGeZNTBRAX/0J
         QQbs9G3m03NiBzvIympX0HjKlGbcJDqcnDs44hf4Vi2AthvdkSlu9o+bpO8LiHkkGqgu
         wO54xEPD04gt9QKX8dbxzGPwSVM1WHBIPjp6PzaThv8pz3Ic4Nf89yllJWLVuXWL9nmD
         Ne34u4onNvczZ8MZihv2wwJO7UO//vwQ9bS24rjdwjpFlJR3/t1RNkQIYo5DJ8W/nqiD
         vTlzjn4X5C+S/1NXL5AKbW7mvN2Iy5Oopt4ebTJM3OK5/z0p0E9dGm9u/t/nMahE+7yL
         EWkw==
X-Gm-Message-State: AOAM532NXNzrN2Hqm0fMj/zp4whqFE4hxaeN2ejbW87iDu908vsBqYGl
        QSUMaks89Ii1kNU9oNnlmg6VGfPN1Q6PbVxwCFSujA==
X-Google-Smtp-Source: ABdhPJycWh+LxfYgKSTARsn0up26wJdWuTT+FZiXXVdYBc2xqimAfmf8I1zNbp3q2gT1Jy7SxgAa93VQC7VzP0ZOEg4=
X-Received: by 2002:a1f:4ec1:: with SMTP id c184mr260560vkb.8.1623163180279;
 Tue, 08 Jun 2021 07:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org> <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
 <YL9oMVqox7GVASen@gerhold.net> <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
 <20210608142019.GG4200@sirena.org.uk>
In-Reply-To: <20210608142019.GG4200@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 16:39:03 +0200
Message-ID: <CAPDyKFrhx6SKuwjG0w8_sW7+1YpL09onV1vVJY4f+6Y4Dwz3oQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Jun 2021 at 16:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 08, 2021 at 04:08:55PM +0200, Ulf Hansson wrote:
>
> > Honestly, I am not sure about what the regulator-fixed-domain intends
> > to model, but I assume it's something that fits well to be modelled as
> > a plain regulator, to start with.
>
> > Perhaps Mark can chime in and spread some light over this?
>
> IIRC it's for situations where there's a device that's normally built as
> a separate chip that got built into a bigger SoC and wants to rear end
> something onto a power domain, I guess especially if the power domain
> doesn't cover the whole of a Linux device.

Alright, thanks for explaining!

Certainly something that should not be mixed up with a regular power
rail for shared resources (aka power-domain). Maybe it's worth trying
to extend the description in the DT binding a bit, so it doesn't get
abused?

Kind regards
Uffe
