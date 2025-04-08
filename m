Return-Path: <linux-pm+bounces-24922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C3A7F471
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 07:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2510B3B3BC7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D5253F22;
	Tue,  8 Apr 2025 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn7nsySc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCB21516C
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091710; cv=none; b=Omgn3nlrDxoTjqyO9bRHl5S8xGa5lmXjeFPwQVykSEg/+lOzDzwC5jlWUHsdx5OyB4MyIWzLXYl9g84Q1ywIeTQi0pOpcSvhjSf68YtczsVPEdlKVQXm+m7zkZaoITjEI6hGYdeFMyKNM653dtjWtx2UaBdQFnpe0vz8nxzFdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091710; c=relaxed/simple;
	bh=EufmTM1zhzstYC870JF6VYLrqWC1C32Ol14xs1Bdbk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEEEoEIU2A3QkbrbSTRhEzaZLOIk4s320SJNCOk3si3x0Nrbh1zojhKfkFEAB2O2CoCTYKJu9XhmQiTw4HkmnETb6lQayoHkvWxLmx028z1QMUmgYohYceSDLGmfxM00rINXTd80rcKILWM7T5fUcA30vZ/O7l2qGVWhdzMRXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hn7nsySc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so4350056b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 22:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744091708; x=1744696508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NB0nHoebXQJILemQcp89vOlxV4NeZBSLk4VRg3eTpU=;
        b=Hn7nsyScn9UBTXghNDxMP3oaTlyb3ApH0kJG3zL+Wm4+uJfJBboOPfrG1uIcasuWXP
         9J5+0hHiRqfPEcpVUdh9/8LV0Hipu4JHMUal4lJANhQAkl28lIb0LAxHum8nWqxlVLQ6
         Tg/w4l5iIY92RI8NvZY4wFQyUje1jOEZqLwEh/PVXdJeq5zjn5GCHMsEWv3TxBwLIt7/
         JUiUKF0EOvf3Gz5K2zqzIhVCxn3Qz3k0pI+8W6DZp0FJ49Z1lVbHRRwdyPJovqKoLNM0
         o6z3EWwFOZMP4xJpUjnwN0s9ysnUUGfWaw8ga8HxwJfXTbJQdKDSqkyGbpvjo0Vh47QE
         01TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744091708; x=1744696508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NB0nHoebXQJILemQcp89vOlxV4NeZBSLk4VRg3eTpU=;
        b=cQ6i782rSLSmXjYwL1T5AP0+hycx/EjvetLk5EMxpr9DG0APbLUzlBQt+nPZjSdYug
         zeTrp97UlwZt34ayj5cLqgsI6xjF+ckTA8dYcHK55Wv5rnADAyAVRAbJ+SK6B5IgBpN+
         fFj3l/9PhXvZKOHDaZKdjJeQPdqvN7o7u6c7AT9yAw6cGWxRukCpFCXEZccyfGDx9g5v
         fGN5Xxmf0ppbJtui9cj+gaQc7NNr665b40/DAxkcAYhUGgrdU7yXuxIIUoEy28o5Xamf
         NE2Ujfjoek4caO9pgCvblw7q7h3tWBU8i6w4TU9t3/6q3XHs4WHIJDJXB/PzJZ+RZISP
         CmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvkKEU87Pkd76t86v/2E/sWoxrcOEIeO7m+tHAcP/B3Z3KiUdQesEBiziI/u5rw1EK4yvS25cj4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbJXosWXQS8u5d4RIeiBPIVi41SnRmnR53h34h573JN1Ck21F
	tmW6TUyzF/xY9xUaRdJksWCHGPjeMFj3XLTOsX762agSYx4IpQpeYOabYLuFunM=
X-Gm-Gg: ASbGncsgz1XqDWASmfq0Ki6z4j3947Pfy7bAcA8y4WW5dosw5DaiN0+BxTlSW6Q7ftu
	wcfnYMaxnMxjz5JwFyicO8s8n6Bk1xaqRARXDyuHav2oQVO43/0+7wGWGYeEita9pCo8w3UPQjX
	sn96IdloobKQJQLMP8/zQIP6xaLda1ttyakfaS7jRFSm/9oaF1AR4J3BkT2pRsDFnlDn80PY3Qw
	Oj/lT7mTTXrPgVUjguCZwi+kY7BN7Eo+xuGLPqRTj3L8+6vw5iVXipEZ0PpQvEtJpAvD8oGiydP
	RF78a+8p/I9orrXmgmzHcNDd7XShH40Oe3Qo7TOwIHK8EQ==
X-Google-Smtp-Source: AGHT+IH8/8MnEU5W15/zDVbhBHdpldSTqXJSklAXnGqc4WwlEqny15brb73QCGi2KHBhsKrotrm3cw==
X-Received: by 2002:a05:6a21:6f01:b0:1f5:7353:c303 with SMTP id adf61e73a8af0-20107efef49mr21361016637.11.1744091707768;
        Mon, 07 Apr 2025 22:55:07 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0985sm9951195b3a.104.2025.04.07.22.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:55:07 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:25:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, cristian.marussi@arm.com,
	rafael@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: scmi: Fix null-ptr-deref in
 scmi_cpufreq_get_rate()
Message-ID: <20250408055505.oked4a3drsym46wz@vireshk-i7>
References: <20250405055447.73925-1-bsdhenrymartin@gmail.com>
 <20250407-wondrous-turtle-of-foundation-e92250@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-wondrous-turtle-of-foundation-e92250@sudeepholla>

On 07-04-25, 12:30, Sudeep Holla wrote:
> On Sat, Apr 05, 2025 at 01:54:47PM +0800, Henry Martin wrote:
> > cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> > in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
> > this case, which results in a NULL pointer dereference.
> > 
> > Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.
> > 
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index c310aeebc8f3..c735f39245bf 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -37,11 +37,17 @@ static struct cpufreq_driver scmi_cpufreq_driver;
> >  
> >  static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
> >  {
> > -	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> > -	struct scmi_data *priv = policy->driver_data;
> > +	struct cpufreq_policy *policy;
> > +	struct scmi_data *priv;
> >  	unsigned long rate;
> >  	int ret;
> >  
> > +	policy = cpufreq_cpu_get_raw(cpu);
> > +	if (!policy)
> 
> How about `if (unlikely(!policy))` instead ?

Henry, this change applies to all the patches you have sent. Also please send
them as a single series, as they are related changes.

-- 
viresh

