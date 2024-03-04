Return-Path: <linux-pm+bounces-4632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9586FA65
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 08:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A161F21912
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C07B667;
	Mon,  4 Mar 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g16hHZIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0913AED
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535663; cv=none; b=bBTKmSfPcpR7SLnbRzpNY2x25VGObPuH4BdjOMoCukFlJuxdkDhljhuHKfbcXf4mRf+ti3DqAFc8T2+rtg+imOGYV3KKsLXixqlPz8N/KxBJ4vi+oFKGtlToZZlHfGfEDrPQ90dBpxoppe/M9WQaTb19ONuvsGgv8R/Rqoep6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535663; c=relaxed/simple;
	bh=upBZ3X4KyzBhefJvfJWbA3FwdXqEK3kl16bErZwbfYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYsU5STH7o6ZFuHhjblerV0kFptDmR84trk2zjlMqkhCzuHiFkJ9l/dsXEcpIGRBPIuk9Z1EFgdLs+1oQ6f6zVJQUGBwSERYjByPcrScyqC68kNABJk/SefsRf+JPbTOF4q+EMJo737+ZMlDwOqmu38EiIQwrI+HVBiNzWtnWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g16hHZIQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd178fc492so2991085ad.2
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709535661; x=1710140461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gERSIBQAtMeYIzaUm04+6jDxHIyp8hzEX/WUtLzEWU=;
        b=g16hHZIQDA4PqYQXY7Kbd8IzvSji9ISNB6ubabcWDg1arkEdJD43ZflBq1Xlt9soDV
         e1RhBYdbSYxHUo6aVdTsmApVsOkkDl6AK7gc7tXIek9XHl13ntFgGIq3svtt1lMYuj3B
         EyGIcCIBdsWquCXRqZo+jOqVbKagmryu0OKKq9eXEUr1+Xie/O17ETCffAhknhZ43YXc
         AYi9wwpFIroGMESjvOyckZsK8HF8ZYTCU8zS1GgNKu6ASE9qhTvYUZYGt47Z2sJNDJOe
         Pa48LqJx+NfuDGBPtqNLicpolsAkPiuC5z/3BYPdbHXyWepgvp7PdPtTW7ukpGf+gynq
         JqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535661; x=1710140461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gERSIBQAtMeYIzaUm04+6jDxHIyp8hzEX/WUtLzEWU=;
        b=mBZhXhKnZEGTbIUoIbWdQGB2BQo5u0+61UavBHUH//wnGZqWjSDGAvfsntWfoyC2gu
         UBidGlyw1lUwWpXMyI7tlvibGwYdTLVaXlGtGNzECv0xtDFeMSX/K8zbrQPhF3hjPDB9
         vEIyrDHj6RbENLhRRu/JEcrvtki4cbSz53u+20JQJtDFZeO04nFLHDtOkJf7Aau0mLcn
         lb1q5vv4P1l5piG4kFjJaXOMDfvlTzMASXz3DFZCzleXcwb0hC+ZGs0vyhPrag7/I8Kj
         5zxpLLnoBomFqITq0TXuIfMcP96OevPC1r7fdQx/mPONqJIjkHL5r2R7ZP989ZmI8xv4
         P9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUFqBQCoPGNad978Rrl+YNOa+Gqu6o+pc16sR1RPw8o1Mm+QIC2toJHtxsSHcd27FjHDdT3E992DmHaNVxlWii4TmdyXm9js/A=
X-Gm-Message-State: AOJu0YxcJb9bUjy/qyFghlMnVhnJspS03pSKrcq2wzf4wUnz45vXPX3v
	uu4+KnHKIDAl1jUYZ5scG4TrfUCXDYm7EwQu/TWWzCrE3Tz5MUkBNaqoX2HFOz0=
X-Google-Smtp-Source: AGHT+IEkpf0f5HD53mpwoT/e2x1p6+nsLCC+7Oq38TcI/bj0FDtTuR+h843J2e7GJbLWWhkRw6bwyw==
X-Received: by 2002:a17:902:ec83:b0:1db:f952:eebf with SMTP id x3-20020a170902ec8300b001dbf952eebfmr8764554plg.44.1709535661270;
        Sun, 03 Mar 2024 23:01:01 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001db8145a1a2sm7715773plp.274.2024.03.03.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:01:00 -0800 (PST)
Date: Mon, 4 Mar 2024 12:30:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Message-ID: <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-1-pierre.gondois@arm.com>

On 22-02-24, 14:56, Pierre Gondois wrote:
> policy's fields definitions:
> `transition_delay_us`:
> The minimum amount of time between two consecutive freq. requests
> for one policy.
> `transition_latency`:
> Delta between freq. change request and effective freq. change on
> the hardware.
> 
> cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
> value if available. Otherwise a value is induced from the policy's
> `transition_latency`.
> 
> The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
> Values matching the definition are available through the SCMI
> specification.
> Add support to fetch these values and use them in the scmi-cpufreq
> driver.

How do we merge this series ? I can only pick the last commit.

-- 
viresh

