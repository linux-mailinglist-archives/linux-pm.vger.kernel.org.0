Return-Path: <linux-pm+bounces-17747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC69D2217
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1082842A4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB58199240;
	Tue, 19 Nov 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGWFi6go"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69E19AD87;
	Tue, 19 Nov 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007072; cv=none; b=Kg5TRgxiM6DWdEZpAOJV/O7UnTYJaztktBwHx7/JMvbfRkez+X3YDOFMWhLMw/XysvKsaS2wEegbXy2qJFw25qDGzct+pfxPIP1joTldqLHGVAN8Q8zMUK38FLXSynyCGiLGsX/pi/KKUbrB6OStdhixsJhMrILN2yUlU/ui2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007072; c=relaxed/simple;
	bh=SSFrsugzHrwV7I8EAYW4jQnuw3s/TZvSVJYaUz2JnhE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnGncvsMkmyA1SwdqPsQ+uAdegOWlcrF2vRMHuiApCIytqg/T2REn0bGiA1sCsu0FUd4djujhO1wxN00HiIn6bV3mEjmMgKNkZlGlP4mR5H0wJSzmY1EQQ1+VNLKZcKwEwmfZYuLcIrXVLoMrKCVuurtvJf6fibcgwPLt5P18SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGWFi6go; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so35987985e9.1;
        Tue, 19 Nov 2024 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732007069; x=1732611869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BNqf9m6iqTU7RuKTbFV0njVYNBBhWO2mYJKSI9yTu68=;
        b=eGWFi6goqLEU7ofNeYRlB+gyee2UvX4RddqQ3vtTH4ifG2HjB/PUIW4ROUDX0yniQ5
         5qrYRseQnXnV+3Sf3iQeqcRzLaBeskEoAH3/m8fGgmY1urK+5Djp4bArRByHOxQzmzZD
         qnO9Mlro8VU7JUDLzczkv3iLlaNk/q/c4G3Y8Qeehm+ifLPF8XQ85nM6wYV1Vskfevei
         Q0rLpQifdTlbbKtDdbKvN2xibsV83RTe75vVBrbG6ZNYDpRU70gW9lC54YCLgsCwiRBH
         D7CSUoCXO+fumk4jesOmfhxceIG8rK5aJ8NSiJEtCMHtqnRpGm/8DMt2G5nPRZIlfuTZ
         PQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732007069; x=1732611869;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNqf9m6iqTU7RuKTbFV0njVYNBBhWO2mYJKSI9yTu68=;
        b=h+YxGnzeIcIHSc2F2eOP7MT4oC9BeytX9h4h/vef/QKcx8rrr4CnsCMzbU+J3ZsZBd
         utn7p/PYTY587jrsKEkxXVCSwYXHssWv0/yOBdy9maH2WvdrYhoTgvi1pSSFDcqT7uVt
         UzP0AoHH//4idY5ZMdqSJPy5HAeJw85oK23fQLjJpl1viMexQkFq4v1eww6V+bpT+SZq
         RLdlSZRTLaym38e3PIuzPVE6POOWApwcqvRzsvKDtzOES7BXWRgsOOPX094J3bTVD6S5
         RptJv5p3doqccuxPbC8LF76sJIJCETbndrjMdYvwAvbw6jbZzaYghKROUvXzREhqNQlt
         OZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVakHkrJC0cXCmahOECCenvXV/15A24W2AXQ+6EmF6OFCvj6Ib/TV5VoTeo6Zo2XKoMlepertm7gCY=@vger.kernel.org, AJvYcCXZZFpARrENnD6vl2+h5g+MozL+ZdDfiGP4mIMWV+twuP//FeE2R+OZfzwyT7yksHNVXLE/snmW9Jd0xJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd78SRNzj7WRKIyghcu8u+skpOCFE111fBqxtjuHZZv2AE09YG
	QYDhedxNotdYhakvx8bONFAnvFyLDmm/DcYu0G5qZI23UKzK0grQdUiO+w==
X-Google-Smtp-Source: AGHT+IEilfb4AZZybJ9Noir1r3u+ZGxvNHb3ufYX5oH5CgGVuT4yj85PejmJghrCqMUc3uKY2ukdtw==
X-Received: by 2002:a5d:64cc:0:b0:382:30a5:c377 with SMTP id ffacd0b85a97d-38230a5c594mr8290338f8f.32.1732007068905;
        Tue, 19 Nov 2024 01:04:28 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38242eef982sm7148949f8f.8.2024.11.19.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:04:28 -0800 (PST)
Message-ID: <673c549c.5d0a0220.3a3476.517a@mx.google.com>
X-Google-Original-Message-ID: <ZzxUm5megd6nRXU1@Ansuel-XPS.>
Date: Tue, 19 Nov 2024 10:04:27 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
 <20241119072054.64hi347qmv7ng3un@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119072054.64hi347qmv7ng3un@vireshk-i7>

On Tue, Nov 19, 2024 at 12:50:54PM +0530, Viresh Kumar wrote:
> On 17-10-24, 21:07, Christian Marangi wrote:
> > Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
> > frequency scaling with SMC APIs.
> > 
> > All CPU share the same frequency and can't be controlled independently.
> > Current shared CPU frequency is returned by the related SMC command.
> > 
> > Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> > driver is needed with OPP v2 nodes declared in DTS.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Fix kernel bot error with missing slab.h and bitfield.h header
> > - Limit COMPILE_TEST to ARM64 due to smcc 1.2
> 
> Hi,
> 
> Sorry for delay at my side to review this driver.
> 
> Now that I looked at it, I don't see a lot of special stuff happening in the
> driver. There are many other platforms with similar situation. What we have done
> for all them, which rely on OPPs coming from DT, is to add a clk for the CPUs
> and do all this magically smcc stuff from clk_get_rate() and clk_set_rate().
> Once that is done, you should be able to reuse the cpufreq-dt driver as is.
> 
> So a CPU clk is the only missing thing in your case I guess.
>

Hi Viresh,

thanks a lot for the follow-up. I will see what I can do, 2 main problem
I see is that, contrary to other driver, for this Airoha SoC, there are
no parents or no clock to enable... It's really just entirely handled by
ATF and smccc call.

And also the SMCCC requires an index and not the clock itself. This was
handy for a cpufreq driver as it passed the OPP index, problematic for a
clock driver as set_rate pass the clock. So I guess I will have to
define the OPP phandle also in the clock node struct. (and map it?)

The main problem in doing that is the performance hit on having to cycle
every time the OPPs to find the correct index...

(yes they really implemented this thing with the ATF specifically with
the cpufreq scenario in mind)

Wonder if you have any hint on any of this.

-- 
	Ansuel

