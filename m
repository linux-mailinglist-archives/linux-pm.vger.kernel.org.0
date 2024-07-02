Return-Path: <linux-pm+bounces-10387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F303B9249C6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 23:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EDD1C22BD8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536C201265;
	Tue,  2 Jul 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxUFwnKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C711CE0A1;
	Tue,  2 Jul 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954750; cv=none; b=R9uuzizBpYITjzM1bF7UmjKsibv4yOa8ZEVbUuxXVkepWMciTnswikEXmHL0Cwpj5GE+Eb55EFikmMq/h3lQ5LP7+2rIGEHRykHyygx6aw2EPWQ/A5FLwmqRcLfJIcbbspECICMEb93i/fXhsstrExA0PNKNdbR03Dp09tNgmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954750; c=relaxed/simple;
	bh=50pxIjAYA+PSTf24f+Xa6MwNL5oYB80QnpIER/2Z94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D36qQfz/M9JtENj5ZHHosjKnaNP8xMjN3s8HdnyDgS/FwxLcDuI18s4+XI52HuvaxBDqZjEgSkvFtdOa7/nG6s+2xPDLK1L3k9Ge9lqgK1zR1y0BYrCOfwwXdQRJNXVHwBwVo1fj+epD4Zg4jBBfBE7+bqOiXRsnpeD8uftt67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxUFwnKB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so2801987a91.1;
        Tue, 02 Jul 2024 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954748; x=1720559548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iony3ImHNNZSo/A8ERibxy5kdhCM8Iq7KPKtZvCa59w=;
        b=YxUFwnKBR0Q31lIukIbK3og8iTn88e1Fb/oKEKAKgPSya/p8+Twk/GTW7RI5BrJ5jt
         8O/UhOF/yYO7cNP+R5MeoJy4Xg4/ph2y75Eicgp5yL8TD/eMg+ltG7KLt2kQr2LlsO9t
         JYqDMgbdHNgHyYd/YPEWqAcV2FMovcQ4ODN/4OuxQ6whFAE7RKMtgjmZPuN2pvZL7ZrH
         0iFiWzwAfnOZQKoxZQAZSA4YOEFexIncGtKLbYV7oPYdQA4qAf9h8+DhUrT5yutOdatK
         c9oZO+IoNlsTzI/8xmfdp8K/DTwOuo+2xmcNndqqCGNK/TYezANkjDiZh77dqbpi+Y26
         7hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954748; x=1720559548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iony3ImHNNZSo/A8ERibxy5kdhCM8Iq7KPKtZvCa59w=;
        b=cTMXYkkg/1trAw7jtdcLKe76gHtBsvhqqNWmlQ/IJKwwCXQMAragmGuuEjjMIfeoq1
         3wHq+o0X4vYQhAXyBTaSW7lWnXSnDPzRa4bwvnAEXe8tfJJKXRZ8vtepo/3nqYeLq+ZS
         unbJAI1SWvpdNW3nnhzZL6ceEZQJsZXuZlWtMb2vBns2YIEHZkgzEnxRvzWINiuZdfG3
         x1FRpwPxz9rz+2o+RjKKzgFNkgufar74XrXCXVST77Os1R0A6VQ1NYBlxtBJx5D6B+/m
         aR+SgbdjWCUn0HJGCt0KL3YtuDpMYppZDpZP2DyTkMynAWqrt2eD3fIeNaP5l+KarjIj
         VmxA==
X-Forwarded-Encrypted: i=1; AJvYcCVciHB0MoWavdXHxSLrkuk2GahAboW9RuIjcwn/EzP9F1JlZ/ZH1Ty1ESvEsphv5x4h7XgBKdT+lBhVOP2xfr/neutvmZzNvF0sj3WfABp3nzOgB9g6gig1LARFoQHKbopJ9xoP3Bo=
X-Gm-Message-State: AOJu0Yx2YYUcQdmdEFehplVbaaQ32J1yyJ6eC1Q+E+LehxvgAmDS4RQJ
	RhwUNz5RbfbL4zDaoXgidFu0rHZunT6HopEMAsECbeZflXpB51Ju
X-Google-Smtp-Source: AGHT+IFLlwCns/7n4EroZ2tnRF78fWZtZ7BFKCMgWQzgPaRLFFwKydxj+WmRQh9Lnb8JKmEKPEjibQ==
X-Received: by 2002:a17:90a:e508:b0:2c8:bcab:e103 with SMTP id 98e67ed59e1d1-2c93d77a630mr6616993a91.42.1719954748368;
        Tue, 02 Jul 2024 14:12:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e8196sm9391616a91.49.2024.07.02.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:12:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 11:12:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <ZoRtOuAWBb27RXBc@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
 <ZoQs384bAMuaeDEs@slm.duckdns.org>
 <940a41d0-2660-4a7a-ad07-581b3ac24cca@arm.com>
 <ZoQ_XuXn1Y2Kp3Ba@slm.duckdns.org>
 <20208c07-1ea8-43a0-a499-51c9fd63b037@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20208c07-1ea8-43a0-a499-51c9fd63b037@arm.com>

Hello,

On Tue, Jul 02, 2024 at 09:41:30PM +0100, Hongyan Xia wrote:
...
> Actually, if we are okay with changing the sched_class struct and touching
> the code of other classes, I wonder if a cleaner solution is just to
> completely remove sched_class->uclamp_enabled and let each class decide what
> to do in enqueue and dequeue, so instead of
> 
> 	uclamp_inc/dec();
> 	p->sched_class->enqueue/dequeue_task();
> 
> we can just
> 
> 	p->sched_class->enqueue/dequeue_task();
> 		do_uclamp_inside_each_class();
> 
> and we export uclamp_inc/dec() functions from core.c to RT, fair and ext.
> For RT and fair, just
> 
> 	enqueue/dequeue_task_fair/rt();
> 		uclamp_inc/dec();
>
> For ext, maybe expose bpf_uclamp_inc/dec() to the custom scheduler. If a
> scheduler wants to reuse the current uclamp implementation, just call these.
> If not, skip them and implement its own.

That does sound a lot better. Mind writing up a patchset?

Thanks.

-- 
tejun

