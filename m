Return-Path: <linux-pm+bounces-6212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746989F44B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D331C2088F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118715E7E3;
	Wed, 10 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5q2o3oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00F158D76
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755802; cv=none; b=To8ZADUzkk9459Gm5rDJP/7kYTF/y3LpNi0Y+DCCGPQzJXK5ORaelxxZwOuKHwi2Mtb/fxSImdtCW6gMQreElY9Pzgty6/xEU0CCEXAwIiDoq7DUXa0S49T2MRSu4QuS7Ttxidg9b9pqJBNLQ6p/eS5YC7cfqD8NNoLJvnXfta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755802; c=relaxed/simple;
	bh=8zjJ6ZBa1WPpcfT5AqTQ2kfZwxMK33wI+BmE18967eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV/seVG7SrJjAufl13ooQur/vK44dlO1ysG6gFFEmk/ra/lgo8c/nIwX4u+wcVs3MewnABlUEqoOtxv29E1TwjiOIxLSXcqIJ6KEbbapEEE9vFjofmHc/oEkpG4xegZi3DNyQLt5MAnV0kFSzeb3+sp1zbsQ0lrnjHHUNELneoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5q2o3oi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecec796323so6296167b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712755800; x=1713360600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+ZKdreMATSwQqMGT62EKEHEgtqgyDRXS0nrvXJUw5Q=;
        b=W5q2o3oiVaMt5b0BdkNgqIY6lWwesK7W1BG48miUOeO+UTgt1ApPjGq6IlPhyL6zUK
         tFj/KnDBIM4aSjIdeaGi3bPZl3CqeTCf8xz5DIGb+bgvgqWYwVGlByGK74KPkcrQ6JUV
         2XcDnmpN8aTHilMz3MeBMyirnFe732diHSJGpjn7PX4fNyFEVn/KEhPm54ovxCJiUhBI
         axaGd7aBbbEoei6Rm4rd9MJOa+KdAvTMAGhW8eH2BxhMvq/HW1/FL0cuXpRR9WKSGRf/
         9Q7frzsFXXe/2zJ6POPfJnxfi36fruNQajhv4lcOM6gvH/WYR4fjlSyHEU3SUvZMPOWJ
         skTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755800; x=1713360600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+ZKdreMATSwQqMGT62EKEHEgtqgyDRXS0nrvXJUw5Q=;
        b=vMHkGd6+xTwKno/YF+2+dFzDvk5vulXzlhk3FUFXG7+rq7GxPmkuSL5AA8AqgPZqpD
         G9zCeykRIRrTBjhUE25GlqGAYDFoRO7FQLlKXh/uu01XtyNxoVMIpbRjLWJCurhv2AWM
         MxlY+nXB2D7BkdH603KYxOQqnqeG+eYb60yxaTl81hWnxMH7d9wYkW+4u1oVXfShweJu
         NmobwMMXG7tz4WulBMiqpUb+L1igH94Ks5KcDE2ggFWSx7EaVOiBNTU+nDO3ekyr1Hnl
         E0y8/HD93E18++Cp9hN4GnFAfhMY1laiRdQUKIjpHXnvhlU33O0rddD51uD3Q0WL5E0I
         WkoA==
X-Forwarded-Encrypted: i=1; AJvYcCUvw2M9UvV4LtDHJ9v0qICyY2rhwf12TF1YjAtZAYuLa30YSuEDD+dG9Md2lLyDlTljnsDFqR7Xzk6SQm6ZFeNl6B6BUm3n3Ao=
X-Gm-Message-State: AOJu0Ywi2BgTe9ThxZ5H3FY7kaTmh2rDgun0T9PfiOy6dnRq3kFVK4xR
	eDmy69FhIsiBTcW63EIWWO4a88PnPjTf/+mPRynpRTT6sZTMJDqGNygCtumVUZmyHu3zBWz/ezv
	fOG52/ORhe3uSOCUPM4GIjN+5c+8Sd9jBvt8KrQ==
X-Google-Smtp-Source: AGHT+IFkpir98n+iHWgeoq34noWYibeJrXfqpQ5TomXGbZcGlk3Jq5i5QFghljhQQlx6S174fWjHkA+6Y8JCP1KmxLQ=
X-Received: by 2002:a05:6a20:3c88:b0:1a7:58ca:cdf3 with SMTP id
 b8-20020a056a203c8800b001a758cacdf3mr3482363pzj.8.1712755800460; Wed, 10 Apr
 2024 06:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net> <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
 <20240410114609.GA40213@noisy.programming.kicks-ass.net> <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
In-Reply-To: <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Apr 2024 15:29:48 +0200
Message-ID: <CAKfTPtDbXZbCR9u8+Fm1d05Z+rAnxn4sx5WXbA_aKyRD5GDzfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Atul Kumar Pant <quic_atulpant@quicinc.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, kernel@quicinc.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:24, Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 4/10/24 13:46, Peter Zijlstra wrote:
> > Also, we'll be replacing the throttling code with DL servers 'soonish'
> > at which point all this will stop working anyway, since DL will preempt
> > anything FIFO, including your idle injection crud.

The DL server could make things better for idle injection as it will
let the idle RT threads running on the CPU as long as there is no cfs
thread enqueued whereas the current rt throttling force throttling RT
even if there is no enqueued cfs task. So as long as you have been
able to move things on other cpus, your idle rt thread should keep
running.

>
> +1
>
> also, given that the code spins with preempt disabled, with dl server it could
> even become a non-rt thread...
>
> FIFO RUNNING
>         DL_SERVER activates
>                 their loop
>                         disables preemption()
>                         run()
>                         enable preemption()
>         DL_SERVE throttled
> FIFO BACK
>
> So, there will be no need for this busy loop to be RT.
>
> Anyways, it breaks RT and DL if it keeps running for too long... It can
> also cause complaints like RCU stalls and loong wait on locks, e.g., on
> kworkers...
>
> -- Daniel
>
>
>
>
>

