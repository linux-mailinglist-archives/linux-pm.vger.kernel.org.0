Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF43597E3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIIbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhDIIbo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 04:31:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55BC061760
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 01:31:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so3767159pfn.6
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AZhNHoZOFUMSuzfm7DMfRA7NyyV8vCZ6ZiSx2uJqH0k=;
        b=bXf2ilxTZHqSNL0m4pVN8GFR9Mnkcytl0gPvwza5Xv8hQxAglOoIvq+6VQJBbh9IwR
         IHaOA0LaoyU4SGwehk00qZLi8xBvYXKMCR9Eml6KTBYhG+qn/LfDMpo3TRSqqg0B8gA5
         8pLUEZFMYpc6qyWbH8IN1+9tasOvucgfnws01l5kqOmXEGN4TrRX9PibBePlKjVKDmPr
         9oxTs+U/CjqbV07Z9WOVGvO0MHa06kf2/VcaOM5/YuqM92p2GmSPaboSq5TGHuhJsDMB
         WtdVYP2G2IWhxAktCU/vE3pIkbGxhl+e0cI2N7JWMAsG2cCurIXMUksveJnxXlNOf2Cn
         Z5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AZhNHoZOFUMSuzfm7DMfRA7NyyV8vCZ6ZiSx2uJqH0k=;
        b=OAFKlOI2B+gqVcKqXNxQ/RGE4QpIY45gLBquCOkbagws2Tft8zN2jgXNc0BYPhfbp1
         P41zS45vGrRipDx2dI4kpOx0L7G/2cvzM38D9t9QEXME295sQJm07ImVdZ5LKX2HOveN
         6PBW4+IfM7FU9IHSYa41aZO+4+uZF1/zh8Z7Gtnl0nrAL2qDU9JDxb4f4iAvLvd68loN
         4D7t7bv53zM7JoJltX/RP+rZFxJK5O5fmZt4N820coZJbOg1AT5OXAq5Jl69yQQ36tyM
         dVRHnofPW70WlCzmsHGIrKiVl9pBKqt+Gs25gpp9NoIZbDvtDYMeN4/UGn8LrsJvEX0I
         KeAw==
X-Gm-Message-State: AOAM533NEWYlDwuoLDpkKNn637wc2uany5b0RL4IqcaG5XgG8eb2cDkn
        1pMQ+LAxEV6vzvsUFGhd5Fljbw==
X-Google-Smtp-Source: ABdhPJz9Cn53MNnHoKjH01BoRMStoS9/GN3Jm0YsFhICMBO3H2nHYIWt2o0r5rHL1IKj53Gxf71Yww==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr11997716pgo.365.1617957090718;
        Fri, 09 Apr 2021 01:31:30 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id w75sm1659883pfc.135.2021.04.09.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:31:30 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:01:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing
 base CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210409083128.ggqclfaosovkkmxd@vireshk-i7>
References: <20210408114223.8471-1-pali@kernel.org>
 <CAKohpomAv8GbEz88HVf8iftWyLC_wNLYgTJMq72MHXO_E1FgRA@mail.gmail.com>
 <20210409082945.aa5yp5kiqg4gf6jt@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210409082945.aa5yp5kiqg4gf6jt@pali>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-04-21, 10:29, Pali Rohár wrote:
> On Friday 09 April 2021 13:19:11 Viresh Kumar wrote:
> > On Thu, 8 Apr 2021 at 17:12, Pali Rohár <pali@kernel.org> wrote:
> > 
> > You haven't sent patch 1/10 or something went wrong somewhere.
> > Please send it in reply to the cover letter, so everything appears connected.
> 
> Hello Viresh! I have written in cover letter that I have not resent
> patch 01/10 because it is DTS patch and was already applied into Gregory
> mvebu/dt64 tree.

Ahh, I am sorry about missing that. You should have created patches starting
from patch 2/10 in that case, so it would have been 00-09/09.

-- 
viresh
