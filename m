Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0272FFD8F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAVHqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 02:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbhAVHpX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 02:45:23 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59CC06174A
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 23:44:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 15so3172515pgx.7
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 23:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsOsfvXpiifFLXlegh/tZbYtgjRVsk9m6U6bmV8qMcQ=;
        b=yiuBz5nYm4jnLEU58Ap39JBEPGGDz+nDYyX73LBgMZVpjytQdFLM7P0EuSdAUtzCOb
         SXqpC+Fh3iEI0BZaYjgT/YXWI8KOXIZy1xuTItxmVFze+Fs5HTxZBm9kjzXhzDIz6CDS
         DiT+Gk5hhvEYa61nGrtNASjjK9Kzf4uOsS6C1czhThY6JXJOfWm6Dz0VwNJJMLN5zn7A
         f7pGfqnr9wsfTT/Z4I0xuiDuXUOaGwJzUG2KXrNxdLcbVpm1j2iZ2hoJ77dfj4Ic0DhJ
         ec9Soc60ucP3pIyEQ5qS3EmJxyZPjRjyXROK0Ta6ZpWnMBRkNAND2wh6PwoO0mheun79
         D5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsOsfvXpiifFLXlegh/tZbYtgjRVsk9m6U6bmV8qMcQ=;
        b=DtbmMRg2rbtvjN36lXI4X5BUZ/tVkEmyuYuKjNgmp0/ifgQ0ULWcCLuHz23q3s+jIS
         ULqLXIUf8UiIQpZ6ViKYC5TY5zfw8D+IwGr8ymTecYNH1DjoPnoLdHIg6D2OjstyxmV7
         UE6swoQO5XoGu0Ca7vO3tGYffc4Iutk/cqeQi8+IxzdF7Oj+iErzMeEjur1C2vBzNVS3
         3vGQdqzvn09tpX01IRUddrnrOx7sB+cxtTfLrj2kjMtAzogLzJLlmzvFfTj13RBfEceT
         Amp04Qa6MDzFCXFu7Vw7VBsjdXyCWmXVPxJEEcjo6snV5t4ViHdiEVPcwdKlHIaVA1OT
         lJYw==
X-Gm-Message-State: AOAM532yQCqmzftcdJcSa4/wcEq73k4sb3l+M69XkPxU0xRBuSYx/s3s
        u7b5g4V3H3DJyuXw9oXQaUtigQ==
X-Google-Smtp-Source: ABdhPJy+b4tLQnyoXYqXfxi8lDGVFahPUVY+4nsWs7m+nzM5ltI6vFtBXkNHipN3c3Qmc2EDqPxxCA==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr3552068pfb.20.1611301482403;
        Thu, 21 Jan 2021 23:44:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id e5sm8317192pjs.0.2021.01.21.23.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 23:44:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:14:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210122074439.mq5wz5p3avenhnth@vireshk-i7>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
 <28ade070dd80f6f22d6e8fce5db5f0142b428fa9.1608030508.git.viresh.kumar@linaro.org>
 <20210113161855.GA32402@arm.com>
 <20210115074847.4a2udqcxbaoyrztv@vireshk-i7>
 <20210119190405.GA19274@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119190405.GA19274@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-21, 19:05, Ionela Voinescu wrote:
> I think it would improve clarity a lot by having a single topology
> function, with clear comments on which path is taken when.
> 
> In regards to them sharing code, there's not much code they could be
> sharing, as one just does some simple math on provided values.
> I attempted to have a single function for frequency invariance at some
> point [1], as the logic for the computation is the same, but I could
> never convince myself the clarity gained was worth the changes. But
> I really like this version of your code for this purpose as well.
> 
> But I'll leave that to your judgement.

Hmm, I don't really agree to merging those two paths into a single
routine unless we share something there. So I would like to skip that
for now :)

All other comments accepted.

Thanks.

-- 
viresh
