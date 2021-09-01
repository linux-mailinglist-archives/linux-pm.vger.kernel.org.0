Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C873FD29A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhIAE4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 00:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhIAE4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 00:56:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546CC061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:55:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1134365pjq.4
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mglupvGIB1Xr33jIOfESbjc4dQzLT/JuKDSfHnjbbIc=;
        b=JH9MIA8L31FDZrNIBZRajDzIV6BtfBcyd0wXMH7hfORoYLj4EzP7OmfBS4ilfIevKH
         ALFQuAmSAiO3TItMq4PJ1703np/8YLEc52KVNybMHynNCm8HOhcGLhP8WzKv/6L/CNhH
         8ZT+Zf8ZOilMgEed4ppxUHoRaW58kCt4EPr6Hk72p7/okUxVseDeB9t+LEZbXf63Ba+G
         P2XDd7F9RgxC6MrbC4EI6NCM+x9D5/iiEN0kvnIkVWz0JcpHV26Sw1boURMblCTjOmLO
         k+YOTd21ZjPLcJ8NTCWQ5Z/7wWwoyciTIQ+ezl2ZgODTRVk85SG17jzheUGORMqfq0jk
         QMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mglupvGIB1Xr33jIOfESbjc4dQzLT/JuKDSfHnjbbIc=;
        b=Ov38EIuqQXdmpl2Mq3Kp3IPbgYCVXP+ggt3wXa+CHMkeEnXWsNmMTf/lpQiBiZtJJm
         XneugxQrOM91dsemmpZpGsZD3AqY/sMCWQS7Qrx6K18anwwd47BqPHvnMIL13niILkvZ
         IiC9fC7rLDYLl+163USLPQG+txUxm6JC6rHXAz2nj8KLa7pKruBBhdiXGFmG32+OZRtv
         OXrVTxwnhlcERNHfwoPO7EyrcMW99P1P2qdr0I7CKhe2SRtOjfLr60oXTDUU78jtct4d
         XnRI/D9yI+G51sNj+52TkX7ktxCGmfkJchfeAQMOxhudj2jt7RUJ+KpxWOVd0xanONm0
         g5ig==
X-Gm-Message-State: AOAM5332D1BJJRvC6zT4R6oX/QgZj0M9AjyI6NlwhwqCds6lXTRHGM5a
        foBxFiWAcTHFL7MiA0Q5ppVSgbhZGfdDEQ==
X-Google-Smtp-Source: ABdhPJydRr5ToxoCcGU7P3xip7D6HQ+m4/MWh999r/Vj7VR1cFxegoBrtUckLZtitKRnpKw1AW9RyQ==
X-Received: by 2002:a17:902:e8c2:b029:123:25ba:e443 with SMTP id v2-20020a170902e8c2b029012325bae443mr8100489plg.29.1630472117916;
        Tue, 31 Aug 2021 21:55:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id n79sm18481217pfd.167.2021.08.31.21.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:55:16 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:25:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v6 5/7] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210901045515.tx6fi7mkip2uznsh@vireshk-i7>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-6-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630405453-275784-6-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 11:24, Vincent Donnefort wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c65a1d7385f8..4e901ebd104d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -664,13 +664,15 @@ struct governor_attr {
>  #define CPUFREQ_ENTRY_INVALID	~0u
>  #define CPUFREQ_TABLE_END	~1u
>  /* Special Values of .flags field */
> -#define CPUFREQ_BOOST_FREQ	(1 << 0)
> +#define CPUFREQ_BOOST_FREQ	 (1 << 0)

You are mixing tabs and spaces here, I am sure some tool complains
about it, but perhaps if space is before tab.

Either keep the new entry unaligned with the above ones or just add a
tab instead to keep things aligned. Add a tab to CPUFREQ_TABLE_END and
CPUFREQ_ENTRY_INVALID as well in case then.

-- 
viresh
