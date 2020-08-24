Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE424FB6A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgHXKb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:31:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37055 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXKb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:31:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id y3so8118250wrl.4;
        Mon, 24 Aug 2020 03:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5xLQKYZI4cTxrUMmil7wS5imap+Bt2COqeo1cf8n/LM=;
        b=N/UgocIsOgBmrL+mAZIkdG1IEfTi3ls1nm+wuQEw3txfQ/KVm/OVEjZMrhkSRVfSdQ
         uiVXdVnwUfV6hlSa9zffsrHUuKblyuvzOQiv4MoPm8JaCZNr9YDNILQPk3knhnlpCeBH
         J1XKSza5ykN+iHxeru1FTZKrC/uwei5lUUWWfjaJrqP1IS3GICMrUp9RPgvhvp2r78I/
         9k3vNmua5n7d81qJf25DizkMCqBB0f4grw0WYYOy1K3T13LQsWsHSpObi/Pwdq1ujpVG
         ZEf8EhTurnbWl7tJ70biN9ymvHTm2/EmtinfAMA4tQnPTrdt7bEzfrC1UYrcO3bMAMB3
         NqvQ==
X-Gm-Message-State: AOAM531/ZAQe9B9+RfdTtGTsBYZnuDvqL4yQgYPBlJb9Uw1jMQEXfQaV
        Ls8u1i1Atd2aHqF5nhZtWL0=
X-Google-Smtp-Source: ABdhPJyn5rnoR81LuJKvJbEUHHChIoVEuMpVbYFRx+shF6dp99Pu2+sob1nRK1HuIR1Wj5ZBPFj8GQ==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr5016091wrn.74.1598265086281;
        Mon, 24 Aug 2020 03:31:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k15sm20428005wrp.43.2020.08.24.03.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:31:25 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:31:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
Message-ID: <20200824103123.GD25860@kozik-lap>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
 <20200807133143.22748-1-m.szyprowski@samsung.com>
 <159780685238.334488.5802955284004610550@swboyd.mtv.corp.google.com>
 <f4c87130-25a0-2195-9caa-be805d207c34@kernel.org>
 <fff07b05-f1f6-5333-a056-69ba6995ed4f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fff07b05-f1f6-5333-a056-69ba6995ed4f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 12:28:51PM +0200, Sylwester Nawrocki wrote:
> On 8/23/20 12:12, Sylwester Nawrocki wrote:
> > On 8/19/20 05:14, Stephen Boyd wrote:
> > > Quoting Marek Szyprowski (2020-08-07 06:31:43)
> > > > BPLL clock must not be disabled because it is needed for proper DRAM
> > > > operation. This is normally handled by respective memory devfreq driver,
> > > > but when that driver is not yet probed or its probe has been
> > > > deferred the
> > > > clock might got disabled what causes board hang. Fix this by calling
> > > > clk_prepare_enable() directly from the clock provider driver.
> > > > 
> > > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > 
> > > Can I pick this up for clk-fixes?
> > 
> > Sure, thanks for taking care of this.
> 
> OTOH, I planned to queue that patch for next merged window, together with a
> patch that depends on that one, since the fix is not for an issue
> introduced in the last merge window.
> I guess it's better to avoid pulling (part of) the clk-fixes branch to
> the clk/samsung tree for next merge window?

All current multi_v7 and some of exynos defconfig boots fail on Odroid
XU3-family, starting from v5.9-rc1. On kernelci and my boot systems. If
I understand correctly, this is a fix for this issue, so it should go as
fast as possible to v5.9 cycle.

Otherwise we cannot test anything. The current v5.9 RC is then simply broken.

Best regards,
Krzysztof

