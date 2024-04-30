Return-Path: <linux-pm+bounces-7350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884298B751C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB01F23081
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C613D29C;
	Tue, 30 Apr 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpxXjIY9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2213D272
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478460; cv=none; b=oHp05EwqvuBQwa9iuujK05bOTFsHnUaXCR7iUXeGOHVB/2W+TqE1vETsqVBJfaJ505AYyAq3khO9NmPF0IG1lDgN+wGXeS00mNsiiTfkVk7Blhgem6gOerSyuaROVRw7My4Q7P2bOS5YzMjJEEPrDtai2ZvdGWm/gzWgEFGfrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478460; c=relaxed/simple;
	bh=4i+oZELfhNBtH5dV47fRsrwUCxoVTACihHsZt/+Av6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed/bbY5teu+jbXWOx4gBbxnYA2d3APoRVdX2dnEtJcr99kwNdlffqTSu3segyyO1nzsBQ6GXO2R0EByOkEpAR4U4TnQZSA632QkmY0yRFIEcWDMdvfEozK/+sVUxL7diUgpwKwwpc7ZdDlKl1eXFGuVoWmCLSLHUhyJL6hIyF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpxXjIY9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-60585faa69fso3646581a12.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714478458; x=1715083258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z1myKdAdC7HyTTZzja4JHzqozZdoiE8OpsVv5HUH3I=;
        b=BpxXjIY9SXeeMvcA+8kpBAFTJg8aMorOMVAwa0JPkjpgxf1NLkBcmHjrtO8zSQ+u6l
         dxQEWNLKBKJw4ZtQ3Lh75+xLmXS4qoe56MfQP7XyTViq7AAikaXwrGIL6kJC0QD3ZOqa
         2zxSTum5ismBdU59R6UnmHeSqdbH/73k0oW4IINcFFgwvwZHI0LUEs9g43eceSLmnzjA
         h6OVG7sGlYbNxGWffSo7RLYt27vSjbcVwFzUZigckKgMT69Jj9WAWlg5FKKNrVSvqUqN
         AriE0W5TlTW9qPeDhSK0taVPjWkoRORCCO5oiXZ6b3ln/4oPIPGIU8+HeiZsaBrQsma9
         BpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478458; x=1715083258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Z1myKdAdC7HyTTZzja4JHzqozZdoiE8OpsVv5HUH3I=;
        b=oXhdksZopSPqwCEGRz26C1gVr4jx/3eoNcjki3QRYN7CP1zOLIXqrTu03urX8BxLUb
         /Os7pLLeyNjG0nffd2a2XBqaXwfcRUpg1wpWyEqtALwkAmWXTnIezUoK25fbApwMjb/4
         M1RO5lZLzJDScrlKrEqaj+t9zZ6Arcv9HL8MS1e2RSp49kk35m+WkvcresRH3Nca93VL
         ytRX7Kxwz/UB7H1zwLTt0rBtJzGtVGOPPKewfHTDdyPPDCTOKlZRrCn8SXvAWqqINaL7
         r9TeGQVyE9T43D92RDMPm4+1XY4sGCQ4IUNDtU33a4rQhoneYlOt9j8QnlnES2euJO/M
         zH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBqJ193lPwObv6E54I4adQLnI2gWMtJEmA+YSPy8zyKcdW4WhXUPAdFy5wd70kCa3nXCY957P4W1No/U2KAEeXykLoj9q/jK0=
X-Gm-Message-State: AOJu0YxijQlKSB2wQDzAhRlPEhACMqo9RbLcc/n543nUSH9wqH90ZlRm
	qgbTYGWZqg8vtKVdpRVYDeFEu+LqrBN7Pl/I/I4D5qtQk0swLrVh0y8pbNDNCUZV21QrWvq/mtr
	+RJcomy1g4/KHrp5G5Gh8yKqHeQPhMGVugJzQjk4/rtJQ6wcR9dcYOA==
X-Google-Smtp-Source: AGHT+IEuoO12CTIHP9MUVVJqpOCwqG+W7dUdh4INEBszG2ueQMsjN9KNncSH+zwGVhI1PcUMescz5bfhnoSrw19sGCs=
X-Received: by 2002:a17:90a:a00a:b0:2a5:df97:b with SMTP id
 q10-20020a17090aa00a00b002a5df97000bmr3997149pjp.18.1714478458032; Tue, 30
 Apr 2024 05:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
 <20240326091616.3696851-5-vincent.guittot@linaro.org> <95760e2b-ec38-4f04-8f86-e4f935d24a83@linaro.org>
In-Reply-To: <95760e2b-ec38-4f04-8f86-e4f935d24a83@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 30 Apr 2024 14:00:46 +0200
Message-ID: <CAKfTPtDhVfpvO46YWmMnVhJmiKUbNJt7d2cvmyXfPJ4g1YZkXg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Qais Yousef <qyousef@layalina.io>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

H Konrad,

On Tue, 30 Apr 2024 at 13:23, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 26.03.2024 10:16 AM, Vincent Guittot wrote:
> > Now that cpufreq provides a pressure value to the scheduler, rename
> > arch_update_thermal_pressure into HW pressure to reflect that it returns
> > a pressure applied by HW (i.e. with a high frequency change) and not
> > always related to thermal mitigation but also generated by max current
> > limitation as an example. Such high frequency signal needs filtering to be
> > smoothed and provide an value that reflects the average available capacity
> > into the scheduler time scale.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Qais Yousef <qyousef@layalina.io>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
>
> Hi, I'm not quite sure how, but this commit specifically breaks booting
> on Qualcomm platforms with EAS..

This is the fix:
https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/

>
> https://pastebin.com/raw/1Uh7u81x

Which platform is it ?
I tested it on dragonboard rb3 and it booted and run tests  even w/o the fix

>
> Konrad

