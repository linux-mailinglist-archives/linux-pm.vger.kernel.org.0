Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8731C4D7C
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 06:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgEEE4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 00:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEE4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 00:56:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81BC061A0F
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 21:56:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so719350pjz.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bcNjjam7owzFyIwJPvOejbVBTQ69maDzUfbwggZ2dA=;
        b=aLHlS6xiNMHuJwgtS5c5FBNg7bB7qF2DSLw7iTqBVNXqJfmgox5k3SxD7cxrmKdk6v
         l+kjTGGSZZKpT+CpQLlZN1qjlVBOya7XkibQvKsue/5dKzBH9vCbAJT8qr9Ma53x/3yI
         QXIwV7ZAU1/UFqF4a6EW2NLopHZvqG1Rpm8orjkIk7tClG4Q8UbHmh8MOlLqqN0yzsYZ
         Au7XZXV+dC9LVCS2NqNAnPzZ6jxJ22bARxfuvAPIT+7hPeuPDiMyHHV8G3Vs+JhdS+DR
         cufyrx/Hws7YY7h93HkE1ORrPU2aw1a3ulvVLWrVW3NIhMU4oQfjzxIrNxURG6M226Uu
         ucbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bcNjjam7owzFyIwJPvOejbVBTQ69maDzUfbwggZ2dA=;
        b=CuMEVsvwmfXE/yJkouZwDc0YnM5SNFfqOewdU0vY9V0AYNT9SxnFYdnzGaAm+crL72
         g1QbVAK7bT9DOS3JL+2OEnXtQDYM1N4p+l4ox81sNBQLk/NbmoReGQmRA7tlmL9RCSJj
         MAKWar8IBiC703a+4YXeRfEZ/Mg6SHByEL+3hnSe0q+uyLLspsez7xUVnH5hKcaoG7EG
         A02s9g9nmhphVH/tlDOJZ5o0rAaXkOQjlZQ7udoIS5OsoYAREC/fGgcpGSNJLW/c8i97
         zecdLdtNgg8jvjBR9yfe/BHTiqjsOtb4ADT1vJkw5trcX6sJz2l/ykFTS0htX40XVoYf
         pIxg==
X-Gm-Message-State: AGi0PuZgCecMHmy+FD1lnAz1ErkcunMMtYW6DM1aVhrda7+npDuKw4bf
        /Sh2kku/dVH8La1RGQnrTIxDCA==
X-Google-Smtp-Source: APiQypKz5PGkrZWTJbP3+f/TlvnG7+he8Ca87yIh/qmdt7h/HMYRPft82Ev9HjoCwI1XU0L+nqL4ug==
X-Received: by 2002:a17:90a:f197:: with SMTP id bv23mr677669pjb.3.1588654601713;
        Mon, 04 May 2020 21:56:41 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id h14sm721964pfq.46.2020.05.04.21.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 21:56:41 -0700 (PDT)
Date:   Tue, 5 May 2020 10:26:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 10/12] OPP: Add support for setting interconnect-tags
Message-ID: <20200505045639.i4nnplwaxlkful4o@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-11-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504202243.5476-11-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-20, 01:52, Sibi Sankar wrote:
> Add support for setting tags on icc paths associated with
> the opp_table.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/opp/of.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Maybe this should be part of Georgi's series ?

-- 
viresh
