Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB449F1C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfFRLZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 07:25:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfFRLZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 07:25:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so7541018pga.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Acusobn0H7ivd+3Ff6plUS4gJZuqpT9ishJ0wNjK3Jw=;
        b=T9PWHo10Hob/6SbmVp1kh7KbimH0OWnb+jHmVV8Ri+dZc7WMk/fvAn/4dudCrva50r
         1ErmIXUWFbjk0ZsRYrW0NhA0bwwDJJmQ/kNwqA+M0z+qwxszTrz/Ym4lNOivt1p614Il
         dSHtisXiiVrMPHZVZPb4BX2+9tEkKb3n0NzOQrYPtFai+8AEGxNH3qzRLCUaEE4uXdYp
         Ipuf+lBW/pOArtOv5cWVyP+umUcQeHw3g0VyY154AbkRPmmeT1PghfuyeONbvfsLUmi9
         Jek2M4tU4fo9gqGVFHDjsZnioUkMQo8N3uubpPDFeIRJlDU+F89IDaRM/w9e79J67HLq
         lOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Acusobn0H7ivd+3Ff6plUS4gJZuqpT9ishJ0wNjK3Jw=;
        b=qjFL6O/azdlZwAAvFUfnMWndURBw/njSEa1BQNewFvQNKBU3fSdY0FRBaMJlkffCkG
         q62kwzkn1sCCqLZLlSWSF4dANPfKybnM4BwyTl00MJ3TqJbFRJ5KVBo5HOiKtUbFoIVG
         JCsnaY987746xQ6H2eiC5wx0lsHp3VeF+Nr3xSxs1sKCkpxYTdBS/W8Ni0amWSNN5FL/
         MG6QYYrfT/rwvk/UYR0zGeBIC0djIXTV2JrVIdgApiNkeaFLNB36kkv42ZJFBvRwLeaT
         k4TM1GzuODwq7ZaidB0d1iiI/ADybzDNoZMdscqwxeTJ4lWnn+RAzUAaPrKM4wPYi+0V
         YF+A==
X-Gm-Message-State: APjAAAW/BEnGK8FR/lDoDIxjUQP6yB8U/y1aB5WQdW5ANJmffv3rQHUc
        Nsyt0JuK8o++D1mbB0AS98Us3w==
X-Google-Smtp-Source: APXvYqyNWEaw8XRM9dbybMqObwjT29HEOH7etliEeUq3gJ/DoZogGurCxXw/e4swi+H3k8vboBCfpw==
X-Received: by 2002:a62:640e:: with SMTP id y14mr115409767pfb.109.1560857126458;
        Tue, 18 Jun 2019 04:25:26 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id q4sm1979188pjq.27.2019.06.18.04.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 04:25:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:55:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190618112522.4odrysf7wmxgjlb2@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
 <3504053.Rmt1Mul0J4@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3504053.Rmt1Mul0J4@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-06-19, 01:26, Rafael J. Wysocki wrote:
> On Monday, June 10, 2019 12:51:35 PM CEST Viresh Kumar wrote:
> > +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> > +				void *data)
> > +{
> > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> > +
> > +	return cpufreq_update_freq(policy);
> > +}
> > +
> > +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> > +				void *data)
> > +{
> > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> > +
> > +	return cpufreq_update_freq(policy);
> > +}
> 
> This is a bit convoluted.
> 
> Two different notifiers are registered basically for the same thing.
> 
> Any chance to use just one?

The way QoS is designed, it handles one value only at a time and we need two,
min/max. I thought a lot about it earlier and this is what I came up with :(

You have any suggestions here ?

-- 
viresh
