Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9612A7D28
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgKELgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 06:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgKELgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 06:36:45 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596EAC0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 03:36:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so1233306pgr.11
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 03:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nX6MrnGbrV8g0oNQ1XCMyTbppE1KSaLXnAch4lGiDo=;
        b=HLeCb5EqJWh64lCAkn7kCbHtBY8KOc7cLuKk05dTMBxyvtljLoNrlfG3UkuVkSHZVG
         ZLmN9tDU17kAbCI9yt3cUoCd3EvwDWoyiSqdVnDoCxNpeuVxDaFsYn94+Raq5eqv1Igm
         RVGfpdj1McszdTKHNOMwCetsTGgNSDBGBSOy5e12nWG5BhXH5bIDvOfOp60lTBPjJKlG
         0VGZG7dtN5JbkEM+aYFIMUpx+rFotlBuMkJXKhsZaUyV8IMa9yCokXHzkauFNP3wShlW
         bdKaOEvQRHvTQV8Dxlz4E4E/MoiytcoVGri+jOwLuIMuofWZVxEZiWqkYQmdkhqxICE+
         o1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nX6MrnGbrV8g0oNQ1XCMyTbppE1KSaLXnAch4lGiDo=;
        b=U989l5nW1iIH+XaVg0Jo8GIEzHqMWPAAMg7Ve+LtB53xOt49G9vXsMwVF9nkqojIym
         WQVbCynAnhJP2wP3t/zudYbAihTiWwNdjdub2zcv4mZSedOh9VJCjAZu+LpKDEz6/nNA
         q4aoVJ0hQxkJKK/0m3p1dUOOi2Xya3/ghBsCewP//vvHMyYKn9v97Z/+p8ye2JTCXIHo
         nfj8q/E+7J4oQW13L2pguEGjS445i3CDiwHoT64YHHtiUSOk4g+0Q1GLL2omikOw1OBX
         J3bvXupN9LghwsuZW+vCKVHqXzzqN23x+m5hBw4YrTY/y32TYgTw/is1jiz4JIQbjodk
         1pfw==
X-Gm-Message-State: AOAM533/APUAll+OhBF/+zQIPrTQc5pmuZ4JWt2UdbT++FBx/MFfOESS
        D9Yu77KZSC0XFgCkGItLSsd8nQ==
X-Google-Smtp-Source: ABdhPJykAJuGecKI0qUIgiERc0bqjbTR9lvBRzXdsizZqpBKWJRxDxQuQYfhRnU1PbWM/IriWuWsDw==
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id b1-20020aa795010000b02901553b11d5c4mr2076414pfp.76.1604576203874;
        Thu, 05 Nov 2020 03:36:43 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id k9sm2261001pfi.188.2020.11.05.03.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 03:36:43 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:06:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: Rearrange thermal_zone_device_set_polling()
Message-ID: <20201105113641.fnyugbdbhxovejuj@vireshk-i7>
References: <c024f35421c67d7b1a3a20bc280fb5131ce6db43.1604567599.git.viresh.kumar@linaro.org>
 <ce85bf38-c77c-c8f9-0bd6-f7c598078e7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce85bf38-c77c-c8f9-0bd6-f7c598078e7a@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 12:32, Daniel Lezcano wrote:
> On 05/11/2020 10:13, Viresh Kumar wrote:
> > Rearrange thermal_zone_device_set_polling() to make it more readable and
> > reduce duplicate code.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Hi Viresh,
> 
> I have a series where this function is reworked and conflicts with your
> changes. The delay is converted into jiffies at init time and no
> conversion happen in this function anymore.
> 
> Do you mind if we discard this patch ?

Discarded :)

-- 
viresh
