Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB1652C27
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 05:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiLUEsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 23:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUEsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 23:48:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BEEE1B
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 20:48:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id js9so14576250pjb.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 20:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNVq9wYnva/HPW3ThTI1Fu0L0uIDsvRYyulYsvw3yMw=;
        b=N46ClaEkZ5LdphwXlH2yEBShRVSJpXNciwMMS6UVV2V+NVN6hIY+SufeELGHmaDGyN
         C20fTIWM+vH6ZiG0kBqaqj93CmgognrVh3s0J4NdVoHHAx6kfH0XjugTgzoPwcwfuOru
         rviZoIIDtRlKxXfALdi7m/bAH8wDP+8txlEST8mXx7YRsDjBArmlzczB4oh1HwQOQRwb
         nfOT5fVrj/Jzl+5xumQjfv1+gLm561elFy7YDwFozQoLiIlUSayMkekUsbEd6nfIjk1p
         pQ7nW7Zktmy6rQH11WnZdpTSXuWWm+t3IRAdcP6VdnZagHNmXlMzgRnArKUorxw7d4MN
         i+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNVq9wYnva/HPW3ThTI1Fu0L0uIDsvRYyulYsvw3yMw=;
        b=OCk6zgZR40d7WBHDHiEM/ZIabQMJESatKQ6zxzDs41SDJo4y5CfxeQjti/lfXPM4Y3
         ntbQ4brK8VT3KQtMg3bKz/JVrnzOPbma0k2txx0ATOiSdDU7z8NQgqCiHjnR9jMRC6rT
         9CYkeb+d+/5GuNVHDW1XVG+zMeRhn1ODe/asd1mdTWwx5ykeIdyLwuyA5CQlqkkuaz6+
         mamELkv5BoYb0x8hSOZfntALjJbOYdK0v6sOgF1CA57ZXp4OCHYaHmyNl/PP7phA31fH
         ikV6q05zYyByG2Q33FoUv4DCgKZvv0ZpPL9iTDxHQBo9aNvOjJ/93Ss0WcAJSXd3dPdW
         puPw==
X-Gm-Message-State: AFqh2krbvW/mKz6u8ZOkOeBiufMMUoC391/+a5JBg4btcSaZAJSRLkbT
        jUVyvtR7Elag1Lo5UZVpfdueK8BpIQG+H+N7
X-Google-Smtp-Source: AMrXdXupM0KGFiZrNN7WUHbgR7SQIZup0DNgaE244EV3PgALNtrv+r8+DYIoQZi948KC4j2rzYH3fw==
X-Received: by 2002:a17:902:ee13:b0:187:c49:5a1a with SMTP id z19-20020a170902ee1300b001870c495a1amr697497plb.17.1671598129213;
        Tue, 20 Dec 2022 20:48:49 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00189348ab156sm10215121plg.283.2022.12.20.20.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:48:48 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:18:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, james.clark@arm.com,
        Ionela.Voinescu@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Add u64 casts to avoid overflowing
Message-ID: <20221221044833.ebh2timtn7uluqpm@vireshk-i7>
References: <20221220101225.3190672-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220101225.3190672-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-12-22, 11:12, Pierre Gondois wrote:
> The fields of the _CPC object are unsigned 32-bits values.
> To avoid overflows while using _CPC's values, add 'u64' casts.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh
