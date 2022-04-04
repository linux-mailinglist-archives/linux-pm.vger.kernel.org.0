Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6ED4F0F64
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbiDDGdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 02:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiDDGdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 02:33:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE6237EB
        for <linux-pm@vger.kernel.org>; Sun,  3 Apr 2022 23:31:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w21so7533014pgm.7
        for <linux-pm@vger.kernel.org>; Sun, 03 Apr 2022 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+VXxsT6THaGvtYBQ2XPCpo4cTnwoiIggmrcpY+1QP8=;
        b=l8M2qPfzkgUF7BhuhabG62rYPwc0UwvNUguXqYtqYr+rSNCSia8pkiydfHtVZgBS/F
         rSfPdwoOhpmst13t8L49sqd19WFzHiUQwi17pXyDnNR2tQCeG7uLLP0L2+vgu7JBHriF
         szcHDpYs6tuUxFnv1ioqAFMLebG+UIDEfXHT/Cxa4ZdUVy5OTPvJO8Nss2fz0zz1UBcL
         JmS9mk7i+qdpwLyYdlevEWAQpXReIZJsiy2hJYLciZ6CZH884gXXeiTganj+uuTjyHN+
         xGbd08rvPhXzFx3kAW8KosiABNC/Cackt6kXj3aV1x45cCrvLwOTvGBVp3Khy645spAh
         T5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+VXxsT6THaGvtYBQ2XPCpo4cTnwoiIggmrcpY+1QP8=;
        b=fFNTQNdu5sieItW4sUwzohr74zQ1T8mKE4m7Njw38mIUaoj4efbw77LRVdpEJUmxwb
         9+rIiRkjIId3v8m3+qd7sZTFr/ps3gprtcNuagCK3yfXPM+DJMpy84F9jfuYXIHH0ZxU
         jkDSBbe4GQHF3vmDDZIb/pHn1cmTf4PnBvlO/8j/tr1ECGfYxnhkaI0eYp6su1crRcOY
         zS22nwsRjQ5rnHyDryVW+DaLNDaFBql4bAkruUK9sl/BJZV3k+UmHX48gs3H/vEaOHoM
         DTicmRWXd6gPnRA1uZcdT5hC+KW14dqVJVsrbOWHj5WpEgVqSxvLZhdxMBRCHyxABGK9
         9MwA==
X-Gm-Message-State: AOAM53093Moisw6bKnEV5pmyvm0Jh7XR5L9QqN5jGiGhZLRWewGNgexo
        RoaIzUk7FXK+Um8/jR/RgNZCSQ==
X-Google-Smtp-Source: ABdhPJxxYHaGmwkaFtLwFUWBTwEQ9DsmKkJ8Qos8ZSN9eMn2uWvNwYsD5oWRgUBZjZKlX0oafKAU/Q==
X-Received: by 2002:a05:6a00:21c2:b0:4fe:81f:46c7 with SMTP id t2-20020a056a0021c200b004fe081f46c7mr3433106pfj.5.1649053870710;
        Sun, 03 Apr 2022 23:31:10 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm11597109pfh.143.2022.04.03.23.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:31:10 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:01:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Message-ID: <20220404063108.kwvq3lpqs32vkyqu@vireshk-i7>
References: <20220401120325.820763-1-krzysztof.kozlowski@linaro.org>
 <20220404062618.jtqlb4cfkerctpas@vireshk-i7>
 <bf02f917-2c3d-f098-0d34-fbe664d40433@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf02f917-2c3d-f098-0d34-fbe664d40433@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-04-22, 08:28, Krzysztof Kozlowski wrote:
> I understand this is not a proper use case, but it is easy to trigger
> (UFS driver adds opps manually, DTS also adds one). Maybe you prefer to
> handle it differently - exit with ERRNO? Because NULL pointer exception
> in case of proper, but unexpected DTB is not a good way to handle it.

Yeah, sure. I agree that we can return a proper error in that case.
Will look forward to that patch :)

-- 
viresh
