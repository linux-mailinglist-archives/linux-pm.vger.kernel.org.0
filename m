Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A02697A4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINVW5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINVW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 17:22:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E022C06174A
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 14:22:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so899333ljj.12
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3Raf4UC9rPf9/2GIe2y0keKdeGhWb4NBqALKLPqApw=;
        b=XlZnKz9G6ag4oJchL/qYdMihrdnCJSGrMK2k4uKNZUz8h2Ur50bvs3KAXwwzSCfsWu
         5hK1CEXx20iItEGnGjkEIW/UEbebefnBx9aDPjsYIAhRTILgxN6xlQ3L8K039YxjzGrp
         m72maCaoZZwAoKcyd0QXUvLrcrs5GjaiEiweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3Raf4UC9rPf9/2GIe2y0keKdeGhWb4NBqALKLPqApw=;
        b=WF+OaYpIM7rpePSlqNeFlJGtGgPSFbbMCxIbO96Wa//gr71uLzXaaoQghwG2kcYjw/
         hLpZOaUdV4fpsQDTg3wspUStP4ESmH1w1WbrboScTietdZPerb/5E+orKYD9qX9OSm64
         3xMajqmlFif1Lyot1RkxvA4iif2wRQ3QEid8bPfNiqgraC8O4pxPpuYGOL4eddMqRllA
         6yZvBSm7wVmGMJ0VRA8pQ7VFtaaj5LsPGcd6HYKMj4+OA3LJZK2U2luEC8OpnKB+EBvT
         M2vL49erbGkBdgmQvIO+KzZmUb+tC8eoo2lKJPAayaMbOgwT3j8+P9LMR1yMSIBl9xku
         oVqA==
X-Gm-Message-State: AOAM530FaNAyiiwUF0dwj/iICOZh6tCaPmwUEu9UFsbAwRBPprHpIk/A
        oXloiiX6d1ths+h2d7W8C8csim3WeJTXIQ==
X-Google-Smtp-Source: ABdhPJxmOdjbx0s8y8FPaAJaf8TSg1baxa84gjctWQhU2MKcWw6rqVtlbrccz7CwAAetI1/Jr7/4og==
X-Received: by 2002:a2e:a412:: with SMTP id p18mr5061247ljn.274.1600118573261;
        Mon, 14 Sep 2020 14:22:53 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q17sm3903951lfd.37.2020.09.14.14.22.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 14:22:52 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u21so934009ljl.6
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 14:22:52 -0700 (PDT)
X-Received: by 2002:a2e:9497:: with SMTP id c23mr5361525ljh.124.1600118571616;
 Mon, 14 Sep 2020 14:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200914182112.513981-1-swboyd@chromium.org>
In-Reply-To: <20200914182112.513981-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Sep 2020 14:22:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft6=XxMs0z=oB3CyHETcg9Ahhrjw220JPfbhVWpA7aBZzA@mail.gmail.com>
Message-ID: <CAE=gft6=XxMs0z=oB3CyHETcg9Ahhrjw220JPfbhVWpA7aBZzA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: osm-l3: Mark more structures const
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These structures aren't modified at runtime. Mark them const so they get
> moved to read-only memory. We have to cast away const in one place when
> we store into the data member of struct icc_node. This is paired with a
> re-const of the data member when it is extracted in qcom_icc_set().
>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
