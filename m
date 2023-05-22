Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504170B3D9
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 05:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEVDmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 May 2023 23:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEVDmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 May 2023 23:42:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA901C2
        for <linux-pm@vger.kernel.org>; Sun, 21 May 2023 20:42:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso2668827b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 21 May 2023 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684726953; x=1687318953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s9j2M1WNdnl0wS4KkpJmTBxkz0ogLnfExxOtrv4eeMc=;
        b=xUG/etby2OkzSe+4dY9MbvZoWlp4sVh5TQMOOdjJNfPrMYyXqYRyPWta4Z7z7TL1na
         r0Fs50sglqD7axI6u2nXCSckA82QVylrn4nL2VO4bCgz0/GdowZCGCrka2kIVySr+TtU
         715AKAYg4Ddsf01Lr6T5sVi0nzYXl/yqw5uR9haGE696jQ8vdX/RWWGERzf6RogYkTiz
         s8S3xoYS0Zp3+0NGR6xkZ7zmJk3vhjHcYKBESLh3U2mpqaVEwxUCLvVFJEZnyHthu+zj
         eChyV9RzWqSjUeS4l/IzO3I/BZhsGTHhBwH/SNw4tFS/cm6LDlmUv74LN+FKWzU9FMKi
         loLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684726953; x=1687318953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9j2M1WNdnl0wS4KkpJmTBxkz0ogLnfExxOtrv4eeMc=;
        b=JL0LKxaZr/hhxuEgR5cRbvuNIucK4h7ruIUkUfobpkMyXz2gWQmx4g14/jykwowE5j
         lqPvdcfS7f1XpFGsqoPpl0b43EsiLAqaFa7QpekhUy9g/Jh82Kj9VJYXmCQyq+7FGVUW
         fyKtwiHGdNWApXfjeaDejvn8TvHELXhLeRNrZa83wPRHezJSlaDn0PuFFAqwk+ARB/Lg
         6nWDktkIyLONYe9tliCbQ1lsIy4lOc1kJj7WfLc9izNMzCxWZMCNIlwK5WAdSlSv5PyO
         vV9+D2uSnneDFAdQsi9TeP6M9l3i02UtWlMsUIXcKM1V8Oq38Wl66pOod21w0sK7tOD8
         lCag==
X-Gm-Message-State: AC+VfDzx6YOnSlQCxLR2fYWEaMXO2N/KwzAGofgysNVk2bEBAdU6Nler
        UBGaF+M6QTQiwxkvdNAED9Hzow==
X-Google-Smtp-Source: ACHHUZ7v03JiUp496qOgpNNts2cT0VIZTgPMwg64SA0VFTWlboIElXtct8gUoFb8BRiU3vtdBwIDvw==
X-Received: by 2002:a05:6a00:2405:b0:640:f313:efba with SMTP id z5-20020a056a00240500b00640f313efbamr11427681pfh.19.1684726953284;
        Sun, 21 May 2023 20:42:33 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b0064d29d5c8e7sm3182645pfo.58.2023.05.21.20.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 20:42:32 -0700 (PDT)
Date:   Mon, 22 May 2023 09:12:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] OPP: rate-limit debug messages when no change in OPP is
 required
Message-ID: <20230522034230.zzxmtusrqtqkjnd5@vireshk-i7>
References: <20230520170035.2540438-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230520170035.2540438-1-adrian.larumbe@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-05-23, 18:00, Adrián Larumbe wrote:
> Otherwise, when enabling a debug build and dynamic debug in the kernel, it
> quickly floods the kernel ring buffer and makes debugging of other
> subsystems almost impossible, unless manually disabled.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 954c94865cf5..85cbc8de407c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1091,7 +1091,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  
>  	/* Return early if nothing to do */
>  	if (!forced && old_opp == opp && opp_table->enabled) {
> -		dev_dbg(dev, "%s: OPPs are same, nothing to do\n", __func__);
> +		dev_dbg_ratelimited(dev, "%s: OPPs are same, nothing to do\n", __func__);
>  		return 0;
>  	}

Applied. Thanks.

-- 
viresh
