Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B74F3882D0
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 00:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbhERWkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhERWkh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 18:40:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A5C06175F
        for <linux-pm@vger.kernel.org>; Tue, 18 May 2021 15:39:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h16so13066450edr.6
        for <linux-pm@vger.kernel.org>; Tue, 18 May 2021 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEHzbSc3kHz/DuDcJaL+S6VOx+u35xoPcv8IKY7KC+A=;
        b=TaGtnXLRQlBbi4wI+FG9hnkn1p/+dOa7BxgKCDfqLNXSHMo14MsLMi/yvAqLjI1sLJ
         RX6SFlCXqLRtBoGLfrXqDun0xLvJ697IZ7TepKlthK/rURyH4w1C2fngDQQ6TN68gqax
         ztsJPWir5AQA43X/QzxA25u0Sot+qKsjEZ6JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEHzbSc3kHz/DuDcJaL+S6VOx+u35xoPcv8IKY7KC+A=;
        b=KpEvsY67qY7/A/fq7NAzDFsh+kG5ewO75aw3tbdsD3evepS8baPF+vTIljwL+IJ//f
         gOeyLrZtPUyGWyH/TgxEvFc7VGQmROe+8EGuYboYU1fnQMdFEvBaH1jPxdT7pwl+Keec
         GHTDOpp6lHNwwbqo0rcr1UhCWWRb0WuN5241XvdS+TeSixGmxE0rXVaVt4nUKpegfp4Z
         ej31Kj3LX692NMZuxWfGtHy2Pm0iL7c3NEQBvMVEEZSZekKDUchOWdBuop0FxSut76Ck
         rpD7cJQWyitGX9vgdRXtfYqvXftbntZv/pUPggqM4m8ezd8Y3wzk01J4InLyrNWBMLMC
         l01w==
X-Gm-Message-State: AOAM530zNK0J+znDAHCB1NkAYhmM2q/e/Q1W7bWQhiB9jVPfYqwX1YpJ
        8uePB+MIkOoQTpjtSp7ThZjcgjUwf8dLWw==
X-Google-Smtp-Source: ABdhPJwt7/9jZrdNANklsrJ3txm1plDMDTtrJxPnWFYJj+k8GpTh+Db/rR7PKZ+zRJUbQhrps2hoDA==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr10124877edd.234.1621377556720;
        Tue, 18 May 2021 15:39:16 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a22sm10357647ejs.84.2021.05.18.15.39.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 15:39:16 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id t15so13059924edr.11
        for <linux-pm@vger.kernel.org>; Tue, 18 May 2021 15:39:15 -0700 (PDT)
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr9740944edv.87.1621377555474;
 Tue, 18 May 2021 15:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210518161842.1.Ifec9c629767197bbd80312ebea93ec8bbfafbf06@changeid>
 <ccfe34ca-9487-1f6c-6ac2-18b8ac7cf57d@amd.com>
In-Reply-To: <ccfe34ca-9487-1f6c-6ac2-18b8ac7cf57d@amd.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 18 May 2021 16:39:04 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DS2LYrUBFgdyH5nRPhjyH9CGGWvY7dgCU=oQetaRf8oA@mail.gmail.com>
Message-ID: <CAHQZ30DS2LYrUBFgdyH5nRPhjyH9CGGWvY7dgCU=oQetaRf8oA@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: Add AMD Fam19h RAPL support
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Victor Ding <victording@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ah I should have tried rebasing on ToT.

Thanks!

On Tue, May 18, 2021 at 4:28 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 5/18/21 5:18 PM, Raul E Rangel wrote:
> > Commit a77259bdcb62 ("perf/x86/rapl: Add AMD Fam19h RAPL support") added
> > RAPL support for Fam 19h. This CL adds the missing powercap support.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
>
> ?  This change is already upstream:
>
> commit 8a9d881f22d7a0e06a46a326d0880fb45a06d3b5
> Author: Kim Phillips <kim.phillips@amd.com>
> Date:   Tue Oct 27 07:23:57 2020 +0000
>
>     powercap: RAPL: Add AMD Fam19h RAPL support
>
> Thanks,
>
> Kim
