Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4774B52D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGGQmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGQl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 12:41:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE85118
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 09:41:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b2886364so14932585ad.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688748118; x=1691340118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42eQ2KF4RjtZ7pN/DpoVrrvvjeXYIrEvuWgtzA9e/Cs=;
        b=kTQBxwwcB3pVSLib1y2yLavdFHqNixHOd7ZdQxjs1GFfScRe/lSC7XWdoMuVlQhp7Q
         cUmZIYiCmH6NoQEpIY36FWRYR8g/LUc6jOHVDcipAp2X096y6skbkzYvQZkWK9J1/ek1
         B92q4SsGXY75c/Nx6rZSp3jSu/XMsZtEBdHpmq+7EX9tDH0TdrCY9ig+VWyaU6jcUpmm
         eoX119urSJc4SeIzFz2ycKjLy8cn0ZKkWgtdx6//iHSZFbJNXEQNaS2DS0FOiOKEDbS9
         uTbitdv9SsRAgi8GS9O4/BzDEb7nwQEZ5jHXz4+UTo6pJlK9HwxWQnjGO4e2I1w1mBvk
         4feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748118; x=1691340118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42eQ2KF4RjtZ7pN/DpoVrrvvjeXYIrEvuWgtzA9e/Cs=;
        b=Fuc4ID4o/umVa0XCmTJlMMETm+ZQHAiZcRQMkrrkDhHYOfoFPOaWbyXsbSC1sIFIzn
         xuwvRQF35nlMd5IYnab+wk8ABoRNn5cHzixs6ygnPwfO7MsL4oGSrKoYWQPfJhjX3VjU
         iGwMuD9RlZQTW9FKJAV63IBq0UwsfLR47/KU/DL0IB2VLyIbTUjh9OmzCiFbNW7EC9zf
         wHl4ZHEnOCOaTRCc8C1b0UzOa3zv3GmC4w/YFkEBhl/cAwSLT4URXRPv4RjRUEUxRYny
         nKWTCChdNyTxMKOVqEtWz+0VmANx9jzkzxr6qdqPutFSiNB+cEqakF+BSGFezSg1vt5S
         0dNg==
X-Gm-Message-State: ABy/qLZtdlgcwAKHfzql8JjJYRocIqigc0OB/AhMOYs4PjnLGTjXeM+2
        wAuKQ+Rn4I0yhL02wZL+L/zZ
X-Google-Smtp-Source: APBJJlFQIAsp9Bp4FJQWq5abO8lNMwDlMdsoCVH/O7bzp1xlwwoD1mpqNtrgDVtVEclKzSwyabVnKQ==
X-Received: by 2002:a17:903:228d:b0:1b8:a3a6:df9c with SMTP id b13-20020a170903228d00b001b8a3a6df9cmr5125047plh.60.1688748118072;
        Fri, 07 Jul 2023 09:41:58 -0700 (PDT)
Received: from thinkpad ([117.216.120.82])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001b3d6c86ffdsm3491591plw.156.2023.07.07.09.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:41:57 -0700 (PDT)
Date:   Fri, 7 Jul 2023 22:11:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ajay Agarwal <ajayagarwal@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, mshavit@google.com, quangh@google.com
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
Message-ID: <20230707164149.GP6001@thinkpad>
References: <ZKYvpgs6p3S7nglh@google.com>
 <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 07, 2023 at 04:49:59PM +0200, Ulf Hansson wrote:
> + Manivannan
> 
> On Thu, 6 Jul 2023 at 05:06, Ajay Agarwal <ajayagarwal@google.com> wrote:
> >
> > Hello Linux PM experts
> > I have a question on PM domain. As per the current PM domain driver design, the genpd_finish_suspend turns OFF a power domain if it is not already turned OFF by runtime suspend.
> >
> > I have a usecase of a device having to stay ON during system suspend. This device will be used by a co-processor which is running its own OS. Thereby, it requires the power domain to stay turned ON, so genpd_finish_suspend should not be powering down the domain.
> >
> > I studied the code and found the flag `GENPD_FLAG_ACTIVE_WAKEUP` which can be set for the power domain. And device_set_wakeup_path can be invoked in the suspend() callback of the device. Together, these will prevent the genpd_finish_suspend from turning OFF the domain. See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.c#n1260
> 
> To solve the problem, this is exactly what I would have started to explore too.
> 
> >
> > But this flag is really intended to be used for devices which are capable of waking up the system from PM suspend. But my usecase does not involve a scenario of the device potentially waking up the system, it just needs to stay powered for the co-processor to be able to use it.
> 
> Sure, I understand your point. Maybe it's as simple as renaming the
> device_set_wakeup_path() and corresponding flag to something more
> generic.
> 
> Solving the problem that you are looking for, would probably be done
> along the lines of device_set_wakeup_path() and
> GENPD_FLAG_ACTIVE_WAKEUP anyway. And we really don't want to two
> solutions for one similar problem, if you get my point.
> 
> >
> > Can you suggest if I should go ahead with using the existing framework of `GENPD_FLAG_ACTIVE_WAKEUP`? Or add a new flag, say `GENPD_FLAG_RPM_ONLY` for this scenario?
> 
> Let's see what Rafael thinks, but renaming is an option (or add a
> wrapper function that calls device_set_wakeup_path()) that would work
> for me.
> 
> >
> > Thanks
> > Ajay
> 
> Note that, I have looped in Manivannan, who is working on a very
> similar problem. The problem can be summarized like this:
> 
> Depending if there is an nvme storage device added to the pcie
> interface, the nvmw storage must remain powered on during system
> suspend. For that reason, we also need the part from the PM core where
> propagation of the flag is done from child to parents.
> 
> It's been a couple of weeks ago since I chatted with Manivannan about
> this - and I suggested the approach you have been exploring too. Let's
> see if Manivannan has some more updates to share from his side around
> this.
> 

Thanks Ulf for looping me in. I worked around the issue at the hardware level
i.e., On the Qcom SoCs we can set the power domain in retention mode. So linux
genpd driver will not turn off those domains marked as retention and the
power management hardware (RPMh) will use a backup domain to preserve the state
of the domain even if it's parent domain goes down during system suspend. This
keeps the NVMe device ON during suspend and at the same time allows the SoC to
enter low power state.

I couldn't update you on the progress of this issue since I was out for a couple
of weeks.

But the solution I described above is pretty much Qcom specific, so it is indeed
useful to have a generic solution in genpd framework similar to
device_set_wakeup_path().

My suggestion would be to introduce a new helper instead of renaming the
existing device_set_wakeup_path() API, eventhough both are doing the same but
their purposes differ.

- Mani

> Kind regards
> Uffe

-- 
மணிவண்ணன் சதாசிவம்
