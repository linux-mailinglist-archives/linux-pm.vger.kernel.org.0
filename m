Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572041C4D6C
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 06:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgEEEuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 00:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgEEEuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 00:50:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F202C061A10
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 21:50:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so714151pjz.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkTyRP9++ayfjZYQMfdoArBfF2pI6IvEWiERS/Grl6w=;
        b=A9AcnKK4K7fEn7hjBjS813qdWQFYS97uuMCLfZH0Dl2iHZdSMdYGSfJnrSWfuyuF9a
         u0XBCa5p3PFiNzKEpTxGTGUSdqT/C7kAGF69isRjUnGyYqoFvdxOq8pdCPLn1DpZtIQ+
         CsKDSD6FkGwjQcybqXwVIzgWsJLk/16ug3jIOu3siBnucodAdoAwuuDiyVan0DP4FLGZ
         pnq6BpyTIjyGikLFt9E6OqS2win15OOxLxfBrjAmLGmcN+Al2bSurFSY4GSV5hzE7+UD
         7IWMVO8R/btXpRm3TPuMfZ+22cTugAjcWpsK+XBuwjvj61YxYGxQp5mwuOqMrdTAZCSg
         qchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkTyRP9++ayfjZYQMfdoArBfF2pI6IvEWiERS/Grl6w=;
        b=KTBIT/4rEzspb+LKT6wOAICQhJ5+D2zqybR5XF4I8yKCp+GC9cL34vLAMt8szWBG+3
         jkHFQRfeE5NXifags8UnX8fUzcnJAqfy2nCvmEn6kIk9aIHFpaBIPuNo39lYMn669yI0
         KeR9u7qeTn1zXxrKLF9R6i09+XPhEAgGz8FkFXjtakBbdKx2/Kiuzrzvs+XBta1+DwRW
         UsWoI9VspqHMQDcqR4vg2ivIZ55L1xlKwpHnaLAfBYLM+aodIlsc/T3JDFrcPfxMAvpd
         IFKT04R6GBVpgz7+2vM0b+5kUx336s+9tHlcByg5xPF51/LLOjCAHVyEdM9rHd+9d0oo
         xxzA==
X-Gm-Message-State: AGi0PuY6RHEWiLC5hx23/0O+28fiE/MZR5mo79Ds/RnJQdMxl4H1diCq
        yXO/cwDIXhus5FHm2eN1sT51Ow==
X-Google-Smtp-Source: APiQypJNB+DyBBi5MOQHteql+Lah2HGYUGGbgurJ8eDGQV1dBGqHQVuS6LJ+VOxQsh5bJZAsUHGAaQ==
X-Received: by 2002:a17:90a:2606:: with SMTP id l6mr598821pje.188.1588654214717;
        Mon, 04 May 2020 21:50:14 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id x132sm707930pfc.57.2020.05.04.21.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 21:50:14 -0700 (PDT)
Date:   Tue, 5 May 2020 10:20:12 +0530
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
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504202243.5476-7-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-20, 01:52, Sibi Sankar wrote:
> Add support to parse optional OPP table attached to the cpu node when
> the OPP bandwidth values are populated. This allows for scaling of
> DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

What about using opp_set_rate instead ?

-- 
viresh
