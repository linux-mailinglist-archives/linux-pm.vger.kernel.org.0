Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF61D8E4D
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgESDi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 23:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgESDi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 23:38:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B187C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:38:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c75so4769800pga.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HbECGHJEdvdN8YNW8INOGfDjhhM54ND4yC7cLSL5yw=;
        b=RF9X2bUH8eMboVhtHPpTWd/b4BKaYiwLpGLus4sGAGD4wJCGQ5Jd/Mh/4iFnKUmWYd
         z9ZA3gIPZMEcJjdvYsDUo/FSkxR4ihZOhTQehu3jJqJVnGpReFTk9PCykJtKvcMxukBS
         BMOpCfvGcT4uO8UrK4U944FkRNhra8JQIcmCz7Bjod6PrStm5cRN43B5VifZNGw0t7oU
         PWhElFoFsUEYaoGaWIlB9tW67TeMPCWL1s9ceSO7R1PPgxRNP5hRnDs8ribEtLBdAs6/
         dNt6EKFlgDFjDljmDJICfB2By7gvbBShnEQVABmQyGhp9Zl31FaB4aJMFSg4grBsq3mQ
         U+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HbECGHJEdvdN8YNW8INOGfDjhhM54ND4yC7cLSL5yw=;
        b=Hca+EHCcBYTHMVa66gpXTA6qvxy6xvIrA+0P/nX0kSC5gPUVphL5OhjW+h5AnbLmA3
         StpfHyM4OtvCln1lA/ZvcPZIpLK4v6GuWBEFDBmRD1p+a7npcRT4kAnmYWSEYvHFJgEF
         w7TPYUWjCXfAawbIiB0uLood+dBt8lqlUSFIRr3SKgWOrYfIS2oTYpcKV1BGHfaJGR8/
         Vs3Wzf+ZIl2CiWfq9ifIazP2q1W6QLD8Jks7mZPxT0xm3fBWiYWCqTGK/mxNopCIWnAp
         bmRvxjXEcHstxGMahm7O8NwHkfNnk9m9l0GxXSVDi2P3m1Nt9fHqaz/XkQYVriOwWwvy
         7MPA==
X-Gm-Message-State: AOAM532rXbrJHR7dyF7quqrVidC4PMjyAYd2acPVHrJE/YTOd+/m1C3M
        p7pCETzZfIaoA44DqosE1Cd5cQ==
X-Google-Smtp-Source: ABdhPJytEgqmajG8WtQBVpWAN1lARB6alQPrs93I3c6ZaFtJ6kTlh5tN9yVIC+56/+Pmqr4Ql4RiQA==
X-Received: by 2002:aa7:9252:: with SMTP id 18mr20204271pfp.17.1589859505824;
        Mon, 18 May 2020 20:38:25 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z190sm9945289pfb.1.2020.05.18.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:38:25 -0700 (PDT)
Date:   Mon, 18 May 2020 20:37:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200519033703.GX2165@builder.lan>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
 <20200518184010.GF2165@builder.lan>
 <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 18 May 20:31 PDT 2020, Viresh Kumar wrote:

> On 18-05-20, 11:40, Bjorn Andersson wrote:
> > It most certainly does.
> > 
> > With INTERCONNECT as a bool we can handle its absence with stub
> > functions - like every other framework does. But as a tristate then
> > every driver with a call to the interconnect api needs an entry in
> > Kconfig to ensure the client driver must be a module if the interconnect
> > framework is.
> 
> This patch has been pushed to linux-next a few days back.
> 

Thanks Viresh, I had missed that.

Regards,
Bjorn
