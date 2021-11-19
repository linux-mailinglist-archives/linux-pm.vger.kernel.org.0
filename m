Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99207457893
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhKSWWt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 17:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhKSWWt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 17:22:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD85C061574;
        Fri, 19 Nov 2021 14:19:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u3so49506980lfl.2;
        Fri, 19 Nov 2021 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Nzbg2EG61wjglaAUxjv2HbmVE4Xv+5yBzHM0E8IZsg=;
        b=SXIbbN0574L4wXm6E218LgP9PFCcdFNYniGzSbU9VNCAmx4rys3EGBHB0pZtHXsQ0v
         5DOopnAEeUruILLsRF8g4bP20PDOTcU0wmU2o0up/eJKzKA6q9hdklZxr3KyLgUaVEg6
         6NSTCmJbJVh0y+ODheunQOEBX0frGj3FLSGAzBDKJEhO3vX6sRomDc5UQQNySOi72gDN
         IASArMTWwqSSABu89oH+I5KnBR9FP8iJED9maZFRqpkjjAlK4XxhGKHSe3iLDPnnnq4Y
         n5JnG9/mFVvF3hLwZPZ1ZiLmpDiUAB6/DXuNO1OgWAuZUbkYFzJI29kVF7DOD9YHUn3M
         ctng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Nzbg2EG61wjglaAUxjv2HbmVE4Xv+5yBzHM0E8IZsg=;
        b=V/8FU6LqLkcn0Xigzkze/4prkZpIxCxjGNdvZOVg71hhxsUNUjYUGS3jyTC6c6SonX
         5DevVwmenRpXHrx3rwG9L1iwi61FTGxv9/hXRWttrlbNX/Gng7PBTIEf37nBJ6n3deIA
         tvLSkuIUYJPE61BAa47wb1pF5AOMgNjStlEj760bMLQ6GEV2wQ2EBVhSGJciDiD/Dmv4
         HMr0kJmIxUwCZYerY0btJcIfy6wX4SMWX4VTO+nfGlpxx/N/rCQg3F9YgYQSMFcABjv1
         qBrO37ctSSMwW6qws+HE43QWMPS9PpS8Wl80f87yF594Ss2D7+oKkd7DgUQqVDYdF7IA
         XCEQ==
X-Gm-Message-State: AOAM533ioegNT6EQlBib3NE7AAasTOPDQhDRcsMl9I0Y8988BNVPOmQw
        rXVQjWM+Z1d15fJRfFivrCc=
X-Google-Smtp-Source: ABdhPJwCGLjF1Tj7LtmDCAeHN04dyGLyvsGY7Z/Z0MX7Wq0wDJuM12LsICJS45mawjRFANUPQavgAA==
X-Received: by 2002:a19:c3d6:: with SMTP id t205mr36620216lff.441.1637360384991;
        Fri, 19 Nov 2021 14:19:44 -0800 (PST)
Received: from localhost.localdomain (dsl-trebng21-58c18a-64.dhcp.inet.fi. [88.193.138.64])
        by smtp.gmail.com with ESMTPSA id 76sm78150ljj.69.2021.11.19.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:19:44 -0800 (PST)
From:   Juuso Alasuutari <juuso.alasuutari@gmail.com>
To:     nafonten@amd.com
Cc:     Jinzhou.Su@amd.com, Xiaojian.Du@amd.com, alexander.deucher@amd.com,
        bp@suse.de, deepak.sharma@amd.com, ggherdovich@suse.cz,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mario.limonciello@amd.com, mingo@kernel.org,
        nathan.fontenot@amd.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, ray.huang@amd.com,
        skhan@linuxfoundation.org, steven@valvesoftware.com,
        viresh.kumar@linaro.org, x86@kernel.org
Subject: Re: [PATCH v4 16/22] cpupower: add the function to get the sysfs value from specific table
Date:   Sat, 20 Nov 2021 00:19:43 +0200
Message-Id: <20211119221943.92479-1-juuso.alasuutari@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <152fb29e-c558-ec2f-7ec6-65d7f62274b7@amd.com>
References: <152fb29e-c558-ec2f-7ec6-65d7f62274b7@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Nov 2021 14:38:58 -0600, Nathan Fontenot wrote:
> On 11/19/21 4:30 AM, Huang Rui wrote:
> > Expose the helper into cpufreq header, then cpufreq driver can use this
> > function to get the sysfs value if it has any specific sysfs interfaces.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
> >  tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
> >  2 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > index c3b56db8b921..02719cc400a1 100644
> > --- a/tools/power/cpupower/lib/cpufreq.c
> > +++ b/tools/power/cpupower/lib/cpufreq.c
> > @@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
> >  	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
> >  };
> >  
> > -
> > -static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> > -						 enum cpufreq_value which)
> > +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> > +						 const char **table,
> > +						 unsigned index,
> > +						 unsigned size)
> >  {
> >  	unsigned long value;
> >  	unsigned int len;
> >  	char linebuf[MAX_LINE_LEN];
> >  	char *endp;
> >  
> > -	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
> > +	if (!table && !table[index] && index >= size)
> 
> Should you validate the index before accessing table[index]
> 
>         if (!table && index >= size && !table[index])

The operator is wrong as well. I believe this is what was originally intended:

	if (!table || index >= size || !table[index])

- Juuso
