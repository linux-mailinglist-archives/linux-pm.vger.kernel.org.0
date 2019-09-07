Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05BAC985
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfIGVoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 17:44:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34422 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfIGVoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 17:44:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id g128so7842625oib.1;
        Sat, 07 Sep 2019 14:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lGLCZPFaINcLtxScVujk7xJFWveGfY1hBRQvY6nRng=;
        b=Nv043mDe4w5TLDvfBbAGEKjz/jiuhxwn1mTXZmv5epaQzhXuHkYqX5YwOW6RxavdRy
         sSdc60rLYApj5KxirFipp+Ft93kDIW6n0ODk35/3C/PLeVdL9uipIdZ9zUyQ4It56Ju8
         YX9icn4obIPLMbJUKeZlXyeyUhxC/53QKNaqECvPZILC2ybF877MXQVufUpXuzvEBMJp
         3Y9tzki2PdVxDVkFmuicF8HV1xLNAH6Vf05l6VSIzvOBuANKwOGJikFeL48n3B7vdwbW
         8GtoytM8xAMYerXuO8XeGp+gimh2g1W/z/xt2SGY4rKa2BjFNpCanuukV9DLVoUsuaK/
         9bGA==
X-Gm-Message-State: APjAAAUbHs4TDRNY9YuggXqzr2QYwTHNTyGXFAKrnjPrhap8IrmYO0IF
        TJGZFEr7k+SwKN2bB67Aj9B4zWrEyIFgrGw/7/Y=
X-Google-Smtp-Source: APXvYqxI2VNjRqYr3XshJRYdDTMSyilEDy5yw0MO4dyZyuT1tzoqTI8vdxbY2Z8Ycpywkny1Mrj5eKP33PK+bPSs9RQ=
X-Received: by 2002:aca:da86:: with SMTP id r128mr12645246oig.103.1567892644996;
 Sat, 07 Sep 2019 14:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <3087ddf7-b0cc-fdf1-4dd2-5d6c630bdbba@linuxfoundation.org>
In-Reply-To: <3087ddf7-b0cc-fdf1-4dd2-5d6c630bdbba@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 7 Sep 2019 23:43:53 +0200
Message-ID: <CAJZ5v0ieuq_LPaoM3Nfh8bdK+a-reHBPkFK+bArre-FcMEJD=g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.4-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,

On Fri, Sep 6, 2019 at 5:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following update for Linux 5.4-rc1 or 5.4-rc2 depending
> on your pull request schedule for Linus.
>
> This cpupower update for Linux 5.4-rc1 consists of bug fixes and
> German translation updates from Benjamin Weis.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:
>
>    Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux
> tags/linux-cpupower-5.4-rc1
>
> for you to fetch changes up to 87ce243206944a57383309dcbcdcc5750e6c905b:
>
>    cpupower: update German translation (2019-08-29 10:18:52 -0600)

Pulled, thanks!
