Return-Path: <linux-pm+bounces-4956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1B87C5DA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 00:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980DF282521
	for <lists+linux-pm@lfdr.de>; Thu, 14 Mar 2024 23:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680AAFC09;
	Thu, 14 Mar 2024 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZlgFMr3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE599FC0B
	for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458480; cv=none; b=JqGTghAXLVMdfn7w+/Og7aovJCuHDM1FF+NjILJ6tn1hKJbVpGCJ9l07w6bEh8yzFsCnb8W+dKg4+3KrAotk8YCBvAFDoY+ukzEi9ZRkiih0n70XN7FowdRF9sPoEq6ukJYl8mhjDfxijBeFuWwBRe2MDN21D94T4xlLltJSYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458480; c=relaxed/simple;
	bh=1nZ1koHEL3nJ3Z4WOjyBj9l6GAQC4q9nTZpHJxmXIvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4N6fQ9S6cNIS8xQM4H6uguem1FDZrwBw6fRmJN6FD9AIpH77vr1gUGvpWtgjew5scnn1Dz21OTUTS7Pf2AH6S5pqRAk0K29tLg/9sNFVbghwJJj2zLAb2PwjYfyaGH91xtT/RkCx8mcYg3NmuDIzQrDOKHW3Hv1bTeCIlISaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UZlgFMr3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3747e7f8cso309352b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710458476; x=1711063276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYkkAOiHkqIfOBWqACZEdL7PfJhzMKheJAaNem7Ve48=;
        b=UZlgFMr3Z+3EWLUE501NMd5nrNWGj5MPXd/ZJEfZlHiBQ+RjxydfbqPWdStUbTLFIy
         PiVphh6dbnjSzskoB+pVoJsV4zHlmrpCK1L5CtZgrMAYowFZNAekdsU0h2+lPIMcJPIv
         zyRu3D39pk0V4lQJiehfjyc7bpnSTfDG4gzA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458476; x=1711063276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYkkAOiHkqIfOBWqACZEdL7PfJhzMKheJAaNem7Ve48=;
        b=ZoyboXAZ1juFeScDnD+QfCg84xoxEFDg2Eo5bi7GdzR1ORbzxjQrK74p3Bq0gMPmnO
         2QatLuRxBW49BWXqNqEpX41Ce/xJ8zfF0OeQgwpCQaevBACLNgCVXK+hv1AzQCmPtT17
         k0hPrEA8Wac5zrduN19FIxNupwvoZlZL5EuEv4k+6LLZkgFTr4gtbIbIgrHmXz20HT/C
         WopA8Ruu63VcQWFfN9m4Bp/JiQC00PR9abudVIRqQUkDNKmtn9bDvq1iNXFuFeBReqR7
         5ARvz4CuV1tPP3nUKIVRfqDJnQnxj3L3FGEMRvzRrvvI3FW95xT36idyjgVm2w6TRJru
         87Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXT+gXsF80vlhb9H9+3RvEMyzr89Hm7nj387mSjDqtXPEBy0VQPzGtkcEIvdBB615+30SsQsrWIB2Hz3eCgby/p3EjcjtqV8L8=
X-Gm-Message-State: AOJu0YygJbntdOb3+2dtHpobI+qSZLyQjPBnFjS9aOWHFWxm8u2jbDiB
	TdXbGwdAxHCvMNGZJOek3q9qw5AYPPob/Deh3YmYR2RCHsRcgk9de6Z4FQodG0Arl2UMTxGkjqc
	=
X-Google-Smtp-Source: AGHT+IFdjCwHvZ2ZuFIrl1kgu/hZJRWCF0X0HfP73NcmwLwXlJXG0r8BLcM4Gq/PtQkeWw0G2rwU6w==
X-Received: by 2002:a05:6808:b08:b0:3c2:1d16:c389 with SMTP id s8-20020a0568080b0800b003c21d16c389mr2884435oij.19.1710458476577;
        Thu, 14 Mar 2024 16:21:16 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id ju7-20020a05622aa04700b0042f420962cdsm1293154qtb.94.2024.03.14.16.21.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:21:15 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ef8193ae6so66351cf.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 16:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiyvyrpn45J+oq39awtCuklaUaVIPb4LluxPln4vWDSlUIPswD78vouFHknEr6VYNEALR6EsZbw6EWRbSLsvw0BAMRaF6KnN8=
X-Received: by 2002:ac8:6618:0:b0:42e:ef12:8025 with SMTP id
 c24-20020ac86618000000b0042eef128025mr64373qtp.25.1710458474993; Thu, 14 Mar
 2024 16:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com> <20230703085555.30285-4-quic_mkshah@quicinc.com>
In-Reply-To: <20230703085555.30285-4-quic_mkshah@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Mar 2024 16:20:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Message-ID: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: andersson@kernel.org, ulf.hansson@linaro.org, swboyd@chromium.org, 
	wingers@google.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, sudeep.holla@arm.com, jwerner@chromium.org, 
	quic_lsrao@quicinc.com, quic_rjendra@quicinc.com, devicetree@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc.com=
> wrote:
>
> Add power-domains for cpuidle states to use psci os-initiated idle states=
.
>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 25 deletions(-)

FWIW, I dug up an old sc7280-herobrine board to test some other change
and found it no longer booted. :( I bisected it and this is the change
that breaks it. Specifically, I can make mainline boot with:

git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
domain-idle-states for cluster sleep
git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
power-domains for cpuidle states

(I get an ath11k crash after that, but that's easy to hack out since I
don't need WiFi)

I suppose the two options here are to either:

1. Track the problem down and figure out why the breaks boot and then
fix it. I'm personally not going to track this down, but if someone
wants me to test a patch I can do that.

2. Delete all the herobrine dts files.

So far we've been keeping the herobrine dts files alive because I
thought some graphics folks (Rob, Abhinav, Jessica, for instance) were
still using it. ...but Rob says he hasn't booted his in a while. No
idea if Abhinav and Jessica are using theirs. Any opinions? Is
herobrine hardware support near and dear to anyone these days?


-Doug

