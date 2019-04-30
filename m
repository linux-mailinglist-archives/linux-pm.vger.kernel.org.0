Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E843EE7F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 03:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfD3BpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 21:45:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35134 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3BpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 21:45:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so5972279plp.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASNZVUhRZrmA+iSp3/q0nxg97+VU6XczQccNBvw4awA=;
        b=Fc2o+QqB5cfEg+pAFs/dJRc4yULS04M3TrsGv4USGCsgjTP06F06JrVAak85+rYuIS
         +4d88j+7W0guc2Xg4hggauPkjc4M6Asc918+13u5GDS7qkAqwPZHyKGLmb+3t9XjLSeK
         sDtY0aeIh6QGdgVt8fQfJcfM3vsWRoH7CUUDre8BXnQbfz9SQcBP1XICFPDVFVVanUQK
         z7bd+c5roCXF88O43xHcpqA5Q1Xd43QyB9Zxa3rNJWH/zwaDuuht5peYVKLceXYqnOni
         laZcGhJQUVco2qnXfaK8g4LYHg9/1/oc56POsTSI3yNlZcbQgl38ejaLoppptdApu5Yr
         L5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASNZVUhRZrmA+iSp3/q0nxg97+VU6XczQccNBvw4awA=;
        b=AK75Eml6vroZhVZyDoTwrn+WuQBxRjv0Rp869UkRTzUfGvrBUFDEjsSUHe4eOGWL2J
         mMYgSco6A96cvrb16Ne8oeOt/jnVZMcSKSpK9nJEK+BIP50REhJOR8L2YVXdi71pd2kl
         2GC8nVGk1ZeuEV1V+utUL40on5q3aScXOJVqyV62X4oEgElwYOM3BmAG48bMKdYLtSUh
         Ow8Nx219OH3WAALGhSVz3w30kzXeMW0qXOMQRHdO2DgE4jb/TDK7DxAbRB2d/eEVgEDY
         MgQZ2y/ngBRSc89NsWiCbMirjXgrO1yad847w/OE44iD7epJ5r981Pysf47PfvHVX40r
         emxg==
X-Gm-Message-State: APjAAAX1lpVetp5w2CDvRV+cpKKvN+KjyBnWSky7vbjq28wEGUWerGFu
        o2pn4/366aGw2xSp9PfVvYkWJqBECs8=
X-Google-Smtp-Source: APXvYqw39fRcrb16XMYrQrtK3Gb+1ySgiFOtIkWX5vMzvCDSSH1zk0+hnnO24SiFRyq75VCGY8YafQ==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr67185174plb.158.1556588715198;
        Mon, 29 Apr 2019 18:45:15 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id e186sm4660795pfa.150.2019.04.29.18.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:45:14 -0700 (PDT)
Date:   Tue, 30 Apr 2019 09:44:59 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers
 in cpufreq_init_policy()
Message-ID: <20190430094459.00001e20.zbestahu@gmail.com>
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
> 
> > Has any issue in this change?  
> 
> Not in principle, but I need to check the details.
> 
> In general I'm a bit hesitant to take changes that haven't been tested properly.

Ok, i will try to test it with intel_pstate driver later.

> 
> Thanks,
> Rafael
> 
> 
> 

