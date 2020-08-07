Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC023E6E8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 06:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGE5m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 00:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHGE5m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 00:57:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20892C061756
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 21:57:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so489635plr.7
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKSuRZnH7B8qwd05Kn2/tUaiHF4PaG/VCbDqHCt8jc8=;
        b=OjdveiZ5BMzMt4uuuBFfbVyKjxX6XK2+AGeN6VCnojt4THMeCzJT0uoWCWUfuKZUNT
         U2tctUfwtrU11T1yawCmWqczY0+tTEFo8wHCthmuevSco7dxSco6nitoSK2whpBy9jMl
         RsY1NoVjR7dHTR9SvOS3XvJAG4jbBt9xg95/AiM33vpXDzIg09ca/ZDnOkmV0VNYiy86
         IW8iBivM1FBJTzvuYi0zObHF53ambZhfBAhxD0Ab9jIvT9upu+crAr0kb4OuIaE0ftUl
         Doul1zkdXMBaLdhTEgLYq/nJlbzn3w9Ojw87XLwYYXhRux1fGvjOQ0v956I1dXJwGGnu
         VNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKSuRZnH7B8qwd05Kn2/tUaiHF4PaG/VCbDqHCt8jc8=;
        b=bt0td7+xhQ0u3tjh2bSjbq7JP7LeZ/IjBA1hMKjmMVgnQGufS9LOhWvAs7PSVIvPrS
         w3qohrtZO8THSNLl9aN0Su5zij1nbt9vpmjRW1cjXzgPgVnYuFx3piQh4rvKxSJ3YGAh
         gdTj9rW3LbaXUKqnyXKxKBoaDL9LxdjxEpqTJCt2SQ3z9hOGgpbNscpsXNWAteVI2s0G
         i0GoqiUb0zOyqXklScFJZvUD5y6y67zPuhTDPOsuSxwgfNeKpYaek9d6ui50PjbfM6Iu
         6MbX/K/jQ9I5Ryw8ml7qR9/K9NOjGcBgrtH9Y1VCQtJuIBbT88YFIlF/ntnmDHf5RUV8
         iWDg==
X-Gm-Message-State: AOAM531H6p6N3X+EjlQqW8pwRgezIBqDL9Yd4/E+CY/zOdoxgaZCX0M+
        5vGNjZuGG3i+76+L2RIFa/zrGQ==
X-Google-Smtp-Source: ABdhPJzuYLI2KYeV5yyGVoEvDb+KX0w0VZv7SeXrBF18U5ssl8L0wVqq9k258KyhPf3jdnGkhtWKRg==
X-Received: by 2002:a17:90a:c7:: with SMTP id v7mr11862593pjd.139.1596776261665;
        Thu, 06 Aug 2020 21:57:41 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id f63sm8326666pjk.53.2020.08.06.21.57.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 21:57:41 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:27:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 36/41] cpufreq: s3c2412: use global
 s3c2412_cpufreq_setrefresh
Message-ID: <20200807045735.xnury5wtxst3vfyl@vireshk-mac-ubuntu>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-36-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-36-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-08-20, 20:20, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are two identical copies of the s3c2412_cpufreq_setrefresh
> function: a static one in the cpufreq driver and a global
> version in iotiming-s3c2412.c.
> 
> As the function requires the use of a hardcoded register address
> from a header that we want to not be visible to drivers, just
> move the existing global function and add a declaration in
> one of the cpufreq header files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/cpufreq/s3c2412-cpufreq.c            | 23 --------------------
>  include/linux/soc/samsung/s3c-cpufreq-core.h |  1 +
>  2 files changed, 1 insertion(+), 23 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
