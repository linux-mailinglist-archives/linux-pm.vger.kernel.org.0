Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CDE2421C8
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgHKVR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHKVR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 17:17:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B1C06174A
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:25 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g11so3940241ual.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6METftXhKSKa4OJt8K+q8U+3V8Jq6aEorQMb99jfW0=;
        b=aediAnXzrsIsrvtUll1amabGwpepmtJ394qjWBNHZ0ZsjYESbfEhdOR9crzTm+iKoc
         C2znHUO5M7sdH7rb0Pkd1Ha0SusGVyHpnQlM7KjFQM0Ioa70gSeSag84l4BXHv84HhOb
         i+vQZuMhUFtXeL04J/JHVzYQlobEA10bxYqVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6METftXhKSKa4OJt8K+q8U+3V8Jq6aEorQMb99jfW0=;
        b=EJZIwGk4MPd6CgnaQUw9kzjfUN0lERnTxD007lB5PsQ3Y3Os1ZCC+BflFlKou4DIaK
         2lbJipmyBc9z4ILiWn0b1eC2XrSKp/aRHD8d9rVRNl/XJqZpv4cKhJBq7SsG/yhnQ64f
         VJwGCe9C38hjt1zm5DEv1ai+xLP2yvHTVuOn4/1s0g4DTy/BUotE3ASTNNxPMPrrX0Px
         nVQ7RkTx+O16m9MJpMG/YbjVZ7AkglsNvyFXGLLr0dxcopLBQsP8CqR0015aEjrj7Eat
         R8ZrRLip1Az6hT+onQ5vfLK55eOo0+tiYPILoC9wUj5LJFz9M3vwDSQef/UprZEeQVG9
         T7vA==
X-Gm-Message-State: AOAM533ataQ1bH4ugrOdVn6dA9ieqlGLoNWOTKkfG9nCBTwFuDPyezEx
        Esbv9BOzFRHwmjnxn+hpsbuiRbUKCso=
X-Google-Smtp-Source: ABdhPJx1LPNy/ILyJSwUhiCKtLDYfYpscD+76GiksYl6KtWrXL4Kh2nvQk5kzySPRmN2AJF8gtPvgw==
X-Received: by 2002:ab0:4d69:: with SMTP id k41mr8064508uag.131.1597180644716;
        Tue, 11 Aug 2020 14:17:24 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 67sm18599vsl.13.2020.08.11.14.17.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:17:23 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id p8so13683vsm.12
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 14:17:22 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr23572394vsa.121.1597180642357;
 Tue, 11 Aug 2020 14:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org>
In-Reply-To: <20200811190252.10559-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 14:17:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtPX19o-tdyPBT=07AgbT7kWKhjpuU4d22SQ5D0r=jog@mail.gmail.com>
Message-ID: <CAD=FV=VtPX19o-tdyPBT=07AgbT7kWKhjpuU4d22SQ5D0r=jog@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Brown, Len" <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 12:03 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This is for power domains which needs to stay powered on for suspend
> but can be powered on/off as part of runtime PM. This flag is aimed at
> power domains coupled to remote processors which enter suspend states
> independent to that of the application processor. Such power domains
> are turned off only on remote processor crash/shutdown.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/base/power/domain.c | 3 ++-
>  include/linux/pm_domain.h   | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
