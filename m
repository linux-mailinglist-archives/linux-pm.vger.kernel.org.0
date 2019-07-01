Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D45C2A4
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGASIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:08:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45051 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfGASIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:08:49 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so30813262iob.11;
        Mon, 01 Jul 2019 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uy3GzDC/3O8U5MnHDFB01vcThhGk4+LpUii33EoT0mU=;
        b=CpRQXslQJ4GcU66JWYXcgsogIOovk4Oj5BbQvT1mVf4Dt4EhIA8xkGp8g5r/aT6MwC
         2veX2Qf67yFZ9At1kXc2JXytLmodk0droxpumi42GNd8fRqrcbQ/bLLUWXO9GzyqUMMy
         iyw5xGUu/UeKDlul40NjhRVv2XG3/+FL2LW3Qo6YEooqmR5W7AClmwrQ/FgyHGoBL0Yx
         PCL7voVxS3VCUx0ml2exh075XNYbgTY1e8lKa/wm4SfSeV4yb2otxX66LMcgBzbH2bV8
         hyPnoAjhw3rljtZIgVgulRBpu/b+CeiJLRVSEXJbt+EcT0CMZVhv4Xmh9I7IzoBgvQrV
         je1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uy3GzDC/3O8U5MnHDFB01vcThhGk4+LpUii33EoT0mU=;
        b=bckOwN4uUa80O5561+ZceR7eYtif609Ig8K9MTx8RIsrPH+DrGXPLdiCciuX7YceeV
         YUbfj0UpNwSIU7Ig6dk2m6HBBNDU+rzuXr5rpCgd8WU5tN6kwECpc0Ka+5yCRKYOBU/0
         A/0JQB9wMMc90LBy7YT7D6ZaiPwJFJBJls3JDinNF0eO0Bp4EGZscFq1vvZaTgj3z14B
         JVmb1xW4Kd287wG73wTjRBEy9U4Of9BAjXdRPIqHss5bsM61PD5X/kZ6u90SvhORk/qP
         G4lfTn45H97IibkvIBxsNOxYTT0gs25vgLqHcFkEPUb2102CR6T4LR+XIVV0GvSVNSia
         Z1wQ==
X-Gm-Message-State: APjAAAUmleflRW6nsi8NJTcjJ1YF0KYJODFjFHFHGbcTMmEhIb9efqjw
        Hzaf+sRCZKzvldNwJpdvQ3sNoOcTM/qS0ibWN/c=
X-Google-Smtp-Source: APXvYqxgBnVoTGZWK95i22k6Cou8FFFimKn7TGZnM12vGsyAr9w5HBXwXBtcghJbIHbdMWpoLX5nmxpLrurw/H/MjRc=
X-Received: by 2002:a6b:3b89:: with SMTP id i131mr16212349ioa.33.1562004528091;
 Mon, 01 Jul 2019 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-3-robdclark@gmail.com>
In-Reply-To: <20190630150230.7878-3-robdclark@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Mon, 1 Jul 2019 12:08:38 -0600
Message-ID: <CAOCk7NpOK60ipDzD1Sn+VT_eO3jFikVJ0kCO4T18UBZOGcCFaA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 2/5] genpd/gdsc: inherit display powerdomain
 from bootloader
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        aarch64-laptops@lists.linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 30, 2019 at 9:02 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Mark power domains that may be enabled by bootloader, and which should
> not be disabled until a driver takes them over.
>
> This keeps efifb alive until the real driver can be probed.  In a distro
> kernel, the driver will most likely built as a module, and not probed
> until we get to userspace (after late_initcall)
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
