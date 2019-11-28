Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244A710CD04
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1QrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:47:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34096 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QrS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:47:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id w11so22725659ote.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEF8388JpCWdGO3Z924sD6jEvM1dtRC0Ytr2Lujvu4c=;
        b=dwPDA5V+mkVIHCoTwJauYbm3KJspHLKs3Tct8PXh5aYVO6cDq8BOsp/f5n4FHXvrtg
         TegpF+sCLqHgKS7WzPiQam/09x3AO/GNG1obOBivTNSIXR5tdc4ii3FeLq7Prcrw/mHh
         EGCtJDXXYaD7bC28AhSGXwRU/W1nXsmnwZkqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEF8388JpCWdGO3Z924sD6jEvM1dtRC0Ytr2Lujvu4c=;
        b=O6IMZiQTrZPEouDYTcJvYRne6meK4/wyBBaj7LSc7EYajrFCxGQVuhAQC9mmwPZIGH
         UCQv4XU2CL2BWi1oLR/p9YxPh/CPJ+VIdTb+jihOgbE6CoF0RYQzVvt1GAOoKHQRyEEf
         LAUMSUFGnXOAH2aVRnPPAVm5y5mMbxJJz/DOcEWSQObaXLCT0O67S0bVf6UzLarhMEnN
         TvCg/uPVtQEj/u46Irc4h/mh+XXdFAjgj6TYmrvvdsb5vK44LDeBaYvyddwKHvNcI/I0
         VdjxczphtUlbskHq07Ssg5K/PTfHHjBWcvsr5F7rU3kngFwkrf/XAllnODZ01l091BmO
         zHsw==
X-Gm-Message-State: APjAAAXOj3lWQXfeQChtMIjfu9aXfPqac+uRzK7HDymkYlASRPMcfS10
        waj/mQ6IeWbdfCPR791eovvr0IbnBVcL1y/56fOVDg==
X-Google-Smtp-Source: APXvYqwCryT1buetqq0JAH1U2u1s/YFyNlRbJhsnooRrprXXGE8iD+IQCtG6XEpiECoSOYxdWfWLcQiw4XK67k2HNJ0=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr8398542otr.281.1574959636929;
 Thu, 28 Nov 2019 08:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
In-Reply-To: <20191128160314.2381249-1-thierry.reding@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 28 Nov 2019 17:47:05 +0100
Message-ID: <CAKMK7uFEwChTesKdWAOfi3evLO=d0MsPDdK8gizH-jLk4uBdFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pavel Machek <pavel@ucw.cz>, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> This is a result of looking into a more formal way of doing what was
> proposed here:
>
>         http://patchwork.ozlabs.org/patch/1145363/
>
> The Tegra DRM driver is written such that runtime PM controls all
> aspects of bringing up and shutting down the hardware associated with a
> display pipeline. This works very nicely with the DRM/KMS atomic mode-
> setting framework that has very rigorous call sequences. There are also
> suspend/resume helpers for system sleep that are built on top of these
> generic helpers and that cause the same code sequences to be run as if
> users had simply chosen to disable all display pipelines at normal
> runtime.
>
> The current behaviour of the PM core to disallow runtime suspend/resume
> during system sleep gets in the way of this because the devices do not
> in fact runtime suspend/resume during that time. Most of the time this
> causes display outputs to malfunction upon resume.
>
> Now, there are good reasons for preventing runtime suspend during system
> sleep, as given in commit eea3fc0357eb ("PCI / PM: Detect early wakeup
> in pci_pm_prepare()") that originally introduced this mechanism. There
> can, however, also be cases, like the one described above, where it is
> safe to allow this. Add a flag and a set of helpers to set or clear that
> new flag so that drivers that know it will be safe to runtime suspend a
> device at system sleep time can mark the device as such.
>
> If a device has the flag set, the PM core will no longer take a runtime
> PM reference for it, thus allowing the device to runtime suspend at the
> expected time.

What about sprinkling tons of device_links all over this to make sure
system suspend/resume is done in the same order too? Slightly less
neat from a driver pov, but I think that should get the job done.
Maybe could even do a convenience function which converts a dt phandle
(or whatever that was called again) into a device_link?
-Daniel

> Thierry
>
> Thierry Reding (2):
>   PM / runtime: Allow drivers to override runtime PM behaviour on sleep
>   drm/tegra: Allow runtime suspend on system sleep
>
>  drivers/base/power/main.c    |  6 ++++--
>  drivers/base/power/runtime.c | 16 ++++++++++++++++
>  drivers/gpu/drm/tegra/dc.c   |  1 +
>  drivers/gpu/drm/tegra/dsi.c  |  1 +
>  drivers/gpu/drm/tegra/hdmi.c |  1 +
>  drivers/gpu/drm/tegra/hub.c  |  1 +
>  drivers/gpu/drm/tegra/sor.c  |  1 +
>  include/linux/pm.h           |  1 +
>  include/linux/pm_runtime.h   |  2 ++
>  9 files changed, 28 insertions(+), 2 deletions(-)
>
> --
> 2.23.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
