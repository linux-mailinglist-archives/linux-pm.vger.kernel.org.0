Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB91AEC9
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 04:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfEMCLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 22:11:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40990 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 22:11:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so3612726plt.8
        for <linux-pm@vger.kernel.org>; Sun, 12 May 2019 19:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igL0mz1un7RCV+tHwpoA79BJWPf2fle+iIkFIP1JHHM=;
        b=NCsgQxGQGYDCGwM3Zcgj2hITkUCTBtqXBOD2W59oWN6o7vd0JOh4bouZkHFZA5Pzal
         GGSTZDCQvyZFn909T8ch/U4uZp0FBKlMt1eXv8hr+j6y22hAvOWaLUkh9yJtjNV5eufl
         rYgpv2XD/Yb1Y6sApp8D7xOn0CPukLNvJHa3Kb+oAfvQDTyhGaWv7uZeSuFTCi5CrABc
         EcyN9JjhzWcoF3OaFf/Ob2X778pblm7kw8CikAD3kVTqJ3xe/J9tzYD0PUDqZbSBumgG
         qQYDwSuH5uc5oRJl6T10pZKuLkJPiHib7b5l+fNAE+HftKv0RmdfcTrZL9hCLF4E+201
         Vq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igL0mz1un7RCV+tHwpoA79BJWPf2fle+iIkFIP1JHHM=;
        b=cTQUaV5pU1FF+2DvjswcSye7fogbfW/NCQFM0o5M0HeEqNo4ptThuP9Qx48/clZGGT
         Nif5z/hO1R5yGK4yD2B9NTL+6qk/SFW2wnzY92g8yv9iTqmnEygWzIGcLlMFw5l6vlAO
         +RXTWgugCiTGxaaS7YPfXl87znBKfyfN4Ycaes8+zuzHOgHagm8vJIH5KWCCm6nZymY1
         HDEm4ElPDmtONwGnUP+3c2YsNTuSGrASyGos/lW22PqyuoZge1vmBTJKWPTVkhgfPL0v
         whMkrLPVp0yYl6UKHdjSst2ei+p0YqUF3LvjsaUaH2XNZPyrepE+PmhqG5aASS/uRGh+
         o/Tg==
X-Gm-Message-State: APjAAAWUvZn9WgOmu6GnqUwr8MXUzPx+GhZcfED6dbDNFeXJKjJU40tR
        MZB7Z7bQNRrx0UrJsSN9nDw=
X-Google-Smtp-Source: APXvYqwlMjS/h0L0nzCiVsqPqnscjgx/FYcVUvhimxJnVbFtylZCdyvLpk63fG96TsFSz+DxV7tbIA==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr28050689plt.337.1557713514050;
        Sun, 12 May 2019 19:11:54 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id l15sm12586988pgb.71.2019.05.12.19.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 19:11:53 -0700 (PDT)
Date:   Mon, 13 May 2019 10:11:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers
 in cpufreq_init_policy()
Message-ID: <20190513101140.00002e59.zbestahu@gmail.com>
In-Reply-To: <4262450.pcLMbF6iK3@kreacher>
References: <20190429072418.7860-1-zbestahu@gmail.com>
        <CAJZ5v0jLd9gnw_QuD-aK6fFpdDACbKXJOBugrCNtx1tfmBKi5w@mail.gmail.com>
        <20190429155640.00004adb.zbestahu@gmail.com>
        <4262450.pcLMbF6iK3@kreacher>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Apr 2019 10:37:45 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Monday, April 29, 2019 9:56:40 AM CEST Yue Hu wrote:
> > On Mon, 29 Apr 2019 09:37:27 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >   
> > > On Mon, Apr 29, 2019 at 9:24 AM Yue Hu <zbestahu@gmail.com> wrote:  
> > > >
> > > > From: Yue Hu <huyue2@yulong.com>
> > > >
> > > > In cpufreq_init_policy() we will check if there's last_governor for target
> > > > and setpolicy type. However last_governor is set only if has_target() is
> > > > true in cpufreq_offline(). That means find last_governor for setpolicy
> > > > type is pointless. Also new_policy.governor will not be used if ->setpolicy
> > > > callback is set in cpufreq_set_policy().
> > > >
> > > > Moreover, there's duplicate ->setpolicy check in using default policy path.
> > > > Let's add a new helper function to avoid it. Also update a little comment.
> > > >
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>    
> > > 
> > > Have you tested this with the intel_pstate driver (in the active mode)?  
> > 
> > No, just tested for ARM. It should be common logic from code perspective.  
> 
> But it is prudent to test changes on various configurations that may be affected.
> 
> Testing intel_pstate shouldn't be too difficult.

Hi Rafael,

Sorry for late test since i take time to emulate/find the board with Sandy brigdge
processor.

I'm sure intel_pstate setpolicy driver is working fine by tests containing policy init,
hotplug and changing scaling_governor.

Thx.

> 
> > Has any issue in this change?  
> 
> Not in principle, but I need to check the details.
> 
> In general I'm a bit hesitant to take changes that haven't been tested properly.
> 
> Thanks,
> Rafael
> 
> 
> 

