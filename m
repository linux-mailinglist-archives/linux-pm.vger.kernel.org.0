Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BACC5C30E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGASc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:32:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38058 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:32:57 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so31070570ioa.5;
        Mon, 01 Jul 2019 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XH2Sgqd3f1qItnFcP6aNN21WN2gIql8Aj/n31a7/ks=;
        b=qSJb48epcJ44fqai80lK1au6m1JjSIdQZrDhYdZlBLTLfvHPyVP6yCEJzlYUU8rsl8
         DetRS296GhrTsYU1MdFOJ9PkVvw1oLqwmw5bOm5ArkivRkbE0kwsCW3UtF4LCkI5BNYr
         n7UQIk++RH6FRVFQlcIVkhtnrg2bYzpdPz8s61m5626G1S4JcyFm4aauzopw6/rM8kcG
         ThDIFcnEHeQhOPlN5bRtwmkgZgkeLkhamFfl9nkspVNRdTeDvAqMTsscfKrkWjbf+vWQ
         A8wtFx7ny8j6KeimI7tdOHKFhhZSqmhyPpdLhpWDXGXO4Ab4iAlQHbS5RoyCEhv152Uu
         dpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XH2Sgqd3f1qItnFcP6aNN21WN2gIql8Aj/n31a7/ks=;
        b=MnOCldSXSN8LTBV9F2GEVVBd49L7AJOZR+Di4GNSaWJvLkG0bIsgbUqZSV4KfXBBZs
         du53P8Crq8E2YECwSNKCvykES/EAtB4cPCSjhXXlTNA7GcCilWVhdSrslIMq91FAngYN
         ex0ypNhM2QExcRWUF0jim0WgBauR9gC82gxEKe54Y2v28s6/RhNl1kM5Halb73XnV+nE
         nHrY2rVgSMPqYGh78IyiOjZ89+yhxNIE2/+gSi0N9wkwPCLKmbDF7BV7d4wH7WBF7Sh9
         hXsGOmSH+zQMMCLvhzkjGk3UGgJxuBYdmSmJpijxHuCGgl+rJETfKu2QYgNtpWlhE4VI
         cqaA==
X-Gm-Message-State: APjAAAWBgfMmX3VF/4TWZzQFmTDDaxfKf5RLZqN2gZrmlVY22Bipv8iM
        meypgYJkFDMs1kbE28R2+CdeOHqNOwksah/uh40=
X-Google-Smtp-Source: APXvYqyNjLQuWt7u4TbYn6Fr5VCbbvpJLZC25VDlMbo81qPC93k/t2OonplTOmmtRgVMNBB6dy+vXcl1rFN2GtPGtaY=
X-Received: by 2002:a6b:b987:: with SMTP id j129mr25537368iof.166.1562005976714;
 Mon, 01 Jul 2019 11:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-4-robdclark@gmail.com>
In-Reply-To: <20190630150230.7878-4-robdclark@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 1 Jul 2019 12:32:46 -0600
Message-ID: <CAOCk7NqS+0Z8JOaeCX+f+t8aKno14bi++N8EX4-1XA0AKd2rZg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 3/5] drm/msm/dsi: split clk rate setting and enable
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        aarch64-laptops@lists.linaro.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>,
        Allison Randal <allison@lohutok.net>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-clk@vger.kernel.org,
        Chandan Uddaraju <chandanu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 30, 2019 at 9:03 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Prep work for the following patch.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
