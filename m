Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6162575B7
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHaIow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHaIop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 04:44:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4014C061573
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 01:44:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a8so2710229plm.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRJYDAyveACX46Lr396yykK8uV/AaFMfwoz36CHmrS4=;
        b=C5CwCT72qPzLfBzqemlPScZPWg98V0m6dm1i3SJVyBV2B44dIqewYO2bBFZ82CtQV7
         LCziMiasTjzxSSG5/0w7337Dvkb9t+KWXcb1rdRTIisbpQhYE2eVQWN1DNjqy5MlPMpE
         a0dcXss6UpG1QvNUQk+qT0mbFTKigcuA4z0r8ftiOgPtSrOyMI7ksp6GYs+NmqFwlTMj
         tW8muvYk5/Tgi1tl0ljEU0eFM+kz2U/NB87Ybzh76zNVB0GSgXglDGxrJB/KIwtTDtqU
         u91l8vdCPoXy5fnuX9J2s0wTs4IC5KWSgqqYEWq31a/qNvsBAgTQbdUA8jNkhBs3RqAK
         EVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRJYDAyveACX46Lr396yykK8uV/AaFMfwoz36CHmrS4=;
        b=MZKZgpCSpU2WLW02rp64p27STU8XurrWzKtLZRQwvAVPawX9EPlxwwOHY/ZvhaBDDw
         W0e8qgql1/q1Zxs6U1vnmJHgihONQL38Wqix4Z4hc6SoMIRstu7kaY5sJsBfezrr3LDl
         FsCcj+Bbz9epSGf4/+J1OiaoPKzkJODC2WlJqjwBgtEPYw+8VeM6u3ip6S44YhqNpYG3
         Y4Eib/osbDj0OMvloz7SH3QLSsEszly3baMFHLcL9rcVkGzYa4JRUdMXUjslDs+LQ+Zz
         TRjSljJ85xFBxd7mdpNepeSPZ9GUyMuIgvWIMNR6JZN/1rPcy64m5ABRKRWkPw+trAHR
         BTjA==
X-Gm-Message-State: AOAM533LNswkT9oBaUOkUijr/7hUwiiDdJaoYNpcMWz3d3s2uCNWqnbF
        tA1yBYW+F6H8j/o1ujr3CRTPFg==
X-Google-Smtp-Source: ABdhPJyOOR4bbqMjSPPbjsyBe0p+IjO4CvEXT8z5BLWVAnT19nhB5HGRmi0FINZ3syRLYb9mSdpMkQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr292473plk.209.1598863483604;
        Mon, 31 Aug 2020 01:44:43 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id o30sm6895855pgc.45.2020.08.31.01.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 01:44:43 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:14:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     rjw@rjwysocki.net, lgirdwood@gmail.com, broonie@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: dt: delay the clk/regulator check
Message-ID: <20200831084441.uvw4jx4cbfh5y3e6@vireshk-i7>
References: <20200831084858.2398-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831084858.2398-1-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-20, 16:48, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> cpufreq_init could be used to do check clk/regulator check,
> there is no need to duplicate the work in resources_available.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Hi can you please see if this happens on linux-next as well ? The
routine resources_available() isn't there anymore.

-- 
viresh
