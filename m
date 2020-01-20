Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCF1422F4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 07:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgATGBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 01:01:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39323 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 01:01:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so12714011plp.6
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 22:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UjIP4NQICdFcbtsqro77Dl66gHMc15rDrDG54aElo8Q=;
        b=EtUWO1zUEShMQdEWiJeuBDXhGHZUXY15Uxej2fzFPDM89pMVi1z6TMPeHbX/4Mdqld
         x+JU6UizODXuHLcCh+umrIk9kTW/QspQIwGcRNYU3UNZ/9h+63Cf0S8LUcVhz533YPXn
         os3IRfMljjI4WAykqUNNmUCCOYQcXkramKBDydDlqGKrovx6m9T7AbO0utbZ0xzN4khn
         fp3OUz3ZB4uAKyBZzJOZQll0mCg+ayBQQKuljU8UBJlNxTTaIMNyHZOEAw1CqEqvZ+1L
         w3fu/e88vIoLkRLX92wvB4z6KA8DB1zZrpbHzGyEmjE0ZpVhDLSJKv1fea9BgqHGBjft
         dLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjIP4NQICdFcbtsqro77Dl66gHMc15rDrDG54aElo8Q=;
        b=tc8DzyB+piFV/wb23nQ4CGJmEAoD/yZBMATJWoZgaKVPce1RP2Ib78FsfCZlPdTzbk
         BTteXMee0uljlZA1eYkqduaWD67nRd49fatKP6fFHa00RnNgaMRpxB/HoyS0EI2EHYq0
         6QQx9y6S5z+lN3z8x1KyHQb16aDgTAKH+POjMqNdvZILK9Pfj4DWn7GgCMRpjltB+e8q
         OPphb4dlB5VcUd9ccaLurS+uK5k56wXkhuhNnsz5XrlYXGV43oqLXBYf7DPOr7JSr1xV
         C/QjkYoid1Wm07MYcaNtCb4pasxnbp7VogHWuPvQIdUCCeIjPNyFCGUHkwyPHIEuSGB4
         mdVQ==
X-Gm-Message-State: APjAAAVKhD9Pw/qDwNBt+E8lSozpmv5lAzFfNCEWcfdVDg8r+EukyAcp
        xkTqQqFL8iP0ieJqWohaZdtwGA==
X-Google-Smtp-Source: APXvYqzLP4aRq3CUThjZNYisaaB4VHdDdDEbNPmabr5sam3Oc5gm8d3NVjewGh5QPIsMmhCFol4zRA==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr13564913ply.125.1579500096261;
        Sun, 19 Jan 2020 22:01:36 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id x132sm37407277pfc.148.2020.01.19.22.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:01:35 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:31:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     mmayer@broadcom.com, rjw@rjwysocki.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy
 refcount
Message-ID: <20200120060134.izotrbzjvzk327zx@vireshk-i7>
References: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
 <20200120053250.igkwofqfzvmqb3c3@vireshk-i7>
 <20200120055822.GB5185@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120055822.GB5185@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-20, 13:58, chenqiwu wrote:
> On Mon, Jan 20, 2020 at 11:02:50AM +0530, Viresh Kumar wrote:
> > On 19-01-20, 15:09, qiwuchen55@gmail.com wrote:
> > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > 
> > > brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
> > > meanwhile, it also increments the kobject reference count to mark it busy.
> > > However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
> > > the kobject reference count back, which may lead to a potential stuck risk
> > > that the cpuhp thread deadly waits for dropping of kobject refcount when
> > > cpufreq policy free.
> > > 
> > > For fixing this bug, cpufreq_get_policy() is referenced to do a proper
> > > cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
> > > If the policy return NULL, we just return 0 to hit the code path of
> > > cpufreq_driver->get.
> > > 
> > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > ---
> > >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > index 77b0e5d..ee0d404 100644
> > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > @@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
> > >  
> > >  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
> > >  {
> > > -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > 
> > Why can't we just add a corresponding cpufreq_cpu_put() instead of all this ?
> > 
> 
> cpufreq_get_policy() does a proper cpufreq_cpu_get()/cpufreq_cpu_put(),
> meanwhile fills a policy copy for the user. It equals to using
> cpufreq_cpu_get() and a corresponding cpufreq_cpu_put() around access
> to the policy pointer. I think both methods are fine here.
> What do you think?

cpufreq_get_policy() does an extra memcpy as well, which isn't required at all
in your case.

-- 
viresh
