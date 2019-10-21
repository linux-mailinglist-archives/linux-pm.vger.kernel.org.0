Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9824BDF7B1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJUVsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 17:48:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44988 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 17:48:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so12385588oie.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 14:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8QaESpfXxVdFrS81K6u9gOaZF1x48T+nD1zzVPhct4=;
        b=azV+OKKWpK5Hq6tFngdBs0Zb4V6jrIhsNCPx4FTU6a0doZYgoXMQd97wh2PTK6H95v
         MAFrle0Sa4zwn924mfvghFdye68ts+MCAXiT3yJQC53tCaNJgaSc3vh+n0Q+h9xXRAsS
         SKofi31mM7nguS8a0unsIiYNUf+9Nyu+yJDXQJ26a10wjxruROGDnuI8F0K6s9PLYwg+
         qSwrnFVSK8tPfp47remjJtgxTZAatn1YZq0I0cnsFSRTHp2jQ3Eo3iu/NZASDSsXYh+q
         MzxNJh8YkoNHUtbKb0pQB5wXP6zhFWocMBWMrnRTtFuNrI2k9IGANgefEpqMQxeNxKll
         qBEw==
X-Gm-Message-State: APjAAAUhG6FCQz6R7DFY+SwntAkPKU3DaIwR+3BUviJw9QC139b0A3va
        lQxxMSQdMB2NzyYctLLNPGSSNRetGY9qQAd1TJ0=
X-Google-Smtp-Source: APXvYqyYIU6Q0//+ImoCU1e0MLUd17bczU4tz/jW01XbXMcSDk043fUj3sQEaKYj+Xv0uUrbhV/dHdQ0WF8o0+X0/4k=
X-Received: by 2002:aca:d405:: with SMTP id l5mr176771oig.115.1571694482183;
 Mon, 21 Oct 2019 14:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
 <2847488.TR0R5COpHM@kreacher> <063b2b9e-19f1-e67a-1d54-b1a813364bb8@freesources.org>
 <3858a5b3-7e62-977e-0292-964c4dcfef5a@freesources.org>
In-Reply-To: <3858a5b3-7e62-977e-0292-964c4dcfef5a@freesources.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 23:47:49 +0200
Message-ID: <CAJZ5v0gNAONVcfvrUu4DBPBo=YzWW2NK-3774_Hv__p2JWmPgA@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before suspend
To:     Jonas Meurer <jonas@freesources.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 12:47 PM Jonas Meurer <jonas@freesources.org> wrote:
>
> Hi Rafael and linux-pm maintainers,
>
> sorry for the noise, but again: is there a chance to get a brief review
> of my patchset?
>
> Probably it was a bad idea to rename the build-time flag, right? Should
> I revert that part of the patch?

Sorry for the delay, I'll get to your patches in the next couple of days.

Thanks,
Rafael
