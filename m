Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B989625556F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH1HiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1HiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 03:38:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F81C061264;
        Fri, 28 Aug 2020 00:38:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c15so209917lfi.3;
        Fri, 28 Aug 2020 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N3NLGVgqy7BKUy5QHEuQDQ+XUZ5L+RsFhhmOMWnxRlw=;
        b=AD6+hlPGZlRejaZMwyX32LZwofbV7Zf7//rodRwr/19Y/litIUt8jDAj+U+itQ8DNf
         0U/QHiayrS8U1+UQJKPh3/bz/3lmaaaelVDVB8EfbD5PULkyWMUEm3KZ81bLXwhgeZjq
         avig/ZfEIXwOUkJuLhp2YVGaGYmnpy42JeSLAOOgiQlzdWxGlGmeH9depL7rlkzRjhZ4
         UQ4Xm66vSHcL/fEpPfmKR+y2JmL7t0p4I/HntzA3R+OdDKUzqnj6Fpoa+GNq1Z60kxh6
         cJ5rLvILc+PMFSshL9gjOKd4GFXi1tEmcTLtwoib54znuy7Qmwp8NJnua+79a2We30W8
         VlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3NLGVgqy7BKUy5QHEuQDQ+XUZ5L+RsFhhmOMWnxRlw=;
        b=QUL5OVH0mt4U3vQEDLYk4n+c0c6T3JAJuvE6MgNPAn3WHX+S7x7tiDH3bJLeN3LMA9
         9CGmrkjCtVpWuVy0W2ToeIoe+vKCYM3QcRj6ULddO24mNfm8OgAQcyG4b8hoeW3CpMFG
         glAI+CAvB2mbL+vbUlpRrd3lQdjtETsU72nlaSKqwQbNgXKVY2qycyRE5J/i3Ca31WO7
         yemMMBKlhsZwEG7QaJGVJxZjLw+RMJUgHj8nfpwLUxECIYwVByFvruRSNgBMWPjEwUN8
         0T4VjCaWx2Nzd5frEo32fPgHzLJu8EI48zywpGXfJhd9e7AH8XkbShwyVAIMI3PdEzkL
         qIsA==
X-Gm-Message-State: AOAM532oN28zMwAlkOl9fAlo8wmMlRELlOi3ih9bqXlP3r6Jnw0LYKaO
        CGCeA54xjnwThbwga5FuVrMXjNyJcbI=
X-Google-Smtp-Source: ABdhPJz3GQE0MhPpOO33+v6UNBtGCoAU/sQ3hPL6ibPfROIHpcNmNEXFvGUqYxXD2j6It9YkZ+wqSw==
X-Received: by 2002:a19:c3d7:: with SMTP id t206mr163809lff.177.1598600295404;
        Fri, 28 Aug 2020 00:38:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id a26sm37302ljm.63.2020.08.28.00.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 00:38:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] opp: Allow opp-supported-hw to contain multiple
 versions
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d7d9bb48-a4ee-30ab-96f2-844d12b709f1@gmail.com>
Date:   Fri, 28 Aug 2020 10:38:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4d59ad206394e4f73ab7547c6cd99d95c032128.1598442485.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.08.2020 14:50, Viresh Kumar пишет:
> The bindings allow multiple versions to be passed to "opp-supported-hw"
> property, either of which can result in enabling of the OPP.
> 
> Update code to allow that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)

I checked that CPU DVFS works on Nexus 7 after applying this series just
like it worked before. Thanks!

Tested-by: Dmitry Osipenko <digetx@gmail.com>
