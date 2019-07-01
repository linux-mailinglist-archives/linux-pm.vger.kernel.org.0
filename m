Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D335C36C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGATF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 15:05:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46084 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 15:05:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so24756215edr.13;
        Mon, 01 Jul 2019 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaBxrrwWEMoWcE/TKYta3qQurdqfNb+UbR5U1Wpm70o=;
        b=VBB2XGeIB4/fvXrovvgQ9H45CCTnVVzGhLc8tfUT5hM1KiF1epOn11+rpPgaoAiBaw
         L2X4IRusSjkr8N98Y03yOtubmeAiQNWRLtYrTHrm69DOZbmxLiRTlylsWPaKjhOcE22i
         yhPCNF3jcLw6DvtdIOZGTrnqrbTj2ZBgKo+AloJb8Jff8J/FkXXiYNL9Sje6kDSbE951
         qNH8si8I5xASyFA0qRaJczNeqnE3r4290p1zaJ9BGwaJVPMDKQoj9EtdmZfBykus5L8E
         0r7VoUuNEeqep5NvcsKIrpw5Vboh/S/S4aB9utLluxGbyiLqn457LvG/vBemDYG892cb
         wZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaBxrrwWEMoWcE/TKYta3qQurdqfNb+UbR5U1Wpm70o=;
        b=b+VawKjxsRK8884AJADJsOr+Cdwp7ZwAJ8xg3T/qdwShUsKENamUOsMNY1g8dGVdl1
         OZG8D86gppR7x7vTGjB1XjdTjcp+Tbw5tVZE5P78x+olJH2nBxnLBwsB3atzLaMCI/Le
         mu+0w6hX3e8SMb5PUsYuql9v7aAR32dD8L2gh5b50XTrgg3YB3QBtG0/vrsUynDjx3+y
         1bp1whzY3FgnYnt7Be7wK3iJSfCR6VKW0I5WZfHkeQcgfup8QioAyZSP1YXe0/+SpDZW
         lIwh8dOz8VikIG0lUqjbKCtcqZof3UyLdR44EU25UntaUxMbx9rUZjX6uXgaqYIuUzT4
         uZ+w==
X-Gm-Message-State: APjAAAUsErpbm7gG3y6mhxEIL6ZsMZMDyiajyBZMEmUI95jR8VKeukz4
        S4zop9jqRufF7iWCGiWluBT0tIf1D1WD4m7vH+0=
X-Google-Smtp-Source: APXvYqxYbuvclvyrQ0SbXxpdlubN12DcA0TqYY/yihrddm5HorGF5u28XbFd2vGLRNP7JC3f0GMBXMvTn31wQhAzS5I=
X-Received: by 2002:a50:9468:: with SMTP id q37mr30825087eda.163.1562007955479;
 Mon, 01 Jul 2019 12:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190630150230.7878-1-robdclark@gmail.com> <20190630150230.7878-2-robdclark@gmail.com>
 <8736jpzk67.fsf@anholt.net>
In-Reply-To: <8736jpzk67.fsf@anholt.net>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 1 Jul 2019 12:05:40 -0700
Message-ID: <CAF6AEGs7n0w0y9067wWkE+fc6zWqqX+b80Yjr8pXDRrkLfKBFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: inherit clocks enabled by bootloader
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        aarch64-laptops@lists.linaro.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 1, 2019 at 11:25 AM Eric Anholt <eric@anholt.net> wrote:
>
> Rob Clark <robdclark@gmail.com> writes:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The goal here is to support inheriting a display setup by bootloader,
> > although there may also be some non-display related use-cases.
> >
> > Rough idea is to add a flag for clks and power domains that might
> > already be enabled when kernel starts, and which should not be
> > disabled at late_initcall if the kernel thinks they are "unused".
> >
> > If bootloader is enabling display, and kernel is using efifb before
> > real display driver is loaded (potentially from kernel module after
> > userspace starts, in a typical distro kernel), we don't want to kill
> > the clocks and power domains that are used by the display before
> > userspace starts.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Raspberry Pi is carrying downstream hacks to do similar stuff, and it
> would be great to see CCF finally support this.

yeah, both this and the multiple-possible-panel thing are a big source
of downstream hacks on basically every android device too.. :-/

it certainly would be nice to have upstream solutions for these
problems to give downstream hacks a reason not to exist

BR,
-R
