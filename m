Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36B124F3FB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgHXI0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 04:26:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHXI0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 04:26:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id y3so7744775wrl.4;
        Mon, 24 Aug 2020 01:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwnSSERLhwr59xH9xxkGQsLVrHFbS0iVSLa9oXTssQk=;
        b=YvAiqwspAmuXiL5s6NXaoIOF7kqM7eENiu4/xt+fLd5D0OmZaKtebJTGgoLIo/5N1G
         CF+bhSSlDsu/ThNuuejVpQqF9KkKVUIMIZCZpE/4FGYL1QIRar4OOhap+hy76ICDJp8v
         6KBGfSEk8HkSISwzz1QTBU8fSRZio8pJVyD/pFqfRouhtYy0PzicuYHb5oSBYwIBKcby
         8YiCoqdhR9O/AAt+DQoj4YgxKtfKMQUb5aZ6HBAyuqsq6ywE4DzyhK/+Xqoa2fr0Fb9L
         MTRQYRG2UFP2iopBMCVrmwwLmcIZ/9Er5W4l3oTPtLLd0tOZ6M9U5U/Hu/i3HBTue276
         W8IQ==
X-Gm-Message-State: AOAM530Q/NvyXjvs0PMm0aISfz8THiPYt1+jbKq2+VNJbhNGuuoGJp8w
        4fRmw4MTn8Z+LIvvNopJXU0=
X-Google-Smtp-Source: ABdhPJyfwbFUcMPFowdfSohjmf5Een0Qin2LUBTL30LqpiJthvHEC+F/P+baWuv3HPZCiDCL8xSSCg==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr4769908wro.421.1598257597768;
        Mon, 24 Aug 2020 01:26:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m1sm22173394wmc.28.2020.08.24.01.26.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 01:26:37 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:26:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] cpuidle: big.LITTLE: enable driver only on
 Peach-Pit/Pi Chromebooks
Message-ID: <20200824082635.GA15030@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p2ad165b545f265bec88a06270d55fce76@eucas1p2.samsung.com>
 <20200616081230.31198-3-m.szyprowski@samsung.com>
 <db3315ef-1ca8-14b5-486a-9cc5a02150a8@samsung.com>
 <20200817153908.GA13144@kozik-lap>
 <f46e7041-f75e-8d97-e967-2ac458aaaf2e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f46e7041-f75e-8d97-e967-2ac458aaaf2e@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 10:15:42AM +0200, Daniel Lezcano wrote:
> On 17/08/2020 17:39, Krzysztof Kozlowski wrote:
> > On Wed, Jun 24, 2020 at 12:05:46PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> On 6/16/20 10:12 AM, Marek Szyprowski wrote:
> >>> This driver always worked properly only on the Exynos 5420/5800 based
> >>> Chromebooks (Peach-Pit/Pi), so change the required compatible string to
> >>> the 'google,peach', to avoid enabling it on the other Exynos 542x/5800
> >>> boards, which hangs in such case. The main difference between Peach-Pit/Pi
> >>> and other Exynos 542x/5800 boards is the firmware - Peach platform doesn't
> >>> use secure firmware at all.
> >>>
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>
> >> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > 
> > This patch waited on list for almost two months and was not picked up.
> > Therefore I'll take it for v5.10.
> 
> It happens some patches can fall into the cracks, especially when we are
> fully busy with a peak of work. Also, we have filters in our mailers
> which are not perfect. A gentle ping is enough to ask to pay attention
> to the series.
> 
> I can understand that is annoying, but preemptively pick the patch is
> not adequate.

I apologize if my message was harsh or sounded rude. That was not my
intention.

I understand that patches soometimes got missed. That's life. This patch
here is quite simple, non-intrusive, got independent ack. Also in the
past SoC-specific drivers were sometimes going through SoC tree (so in
this case - mine for Samsung).  Patch also blocks the dependant DT
change (for entire cycle). Therefore I guessed that it won't be a
problem and it is just simpler to apply it.

If it is an issue, I can drop it and rebase my branch.

Best regards,
Krzysztof

