Return-Path: <linux-pm+bounces-10789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B5592A8E2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CCFB20A12
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BD146A63;
	Mon,  8 Jul 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3TceRZu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED979FD;
	Mon,  8 Jul 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462834; cv=none; b=NM/8phQA4SyvOXn4B2JTL+4etja7Omka2/qUPuk0AATQsWMXOGUNMvdtd6q2YuWJn2+eNpni/nx6IgT3mL7T/Crgeqv0paXyLwC3L6JCN2C9WgQ3jMGZ+vGwSi37dfA9EyQm+fJk+qBv5/rwjFj0V8a0IX8iGT6mOHkGvVZ3gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462834; c=relaxed/simple;
	bh=0Ot1C3XCfv9H3+leeuLXAjpAiNRjVc9eAfmODEiiDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG9LwnDu/8KRulA8xMRlJvEl/a+nFx3ssU4gRoxE/sOC7q2Md+2byYCipqb/uSHoK/OWmEMgu7wayDWiLbIF/eVy8p5F35XuF/efPJL6rxDgyKLCFBFsKtRYrxmZg3oujMj+1T4KflDZlwGACpb/jKGYtsKKLYR/rgFkb6x8hOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3TceRZu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-707040e3018so2760234a12.1;
        Mon, 08 Jul 2024 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720462832; x=1721067632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vwQyNgx5l06JN6vKVkGLyfa4vRNR4YaNZWudr9WkWI=;
        b=H3TceRZup/gbnW2MvDxm8h+FZ3ELiyAzKJTCXWYoUax5GL+0kW+qEAX88K0iqnMAzN
         rdMLq1DIpkgiLrmXUs4q6/J7mfmqzfBPFKgmK5UIbVaHdyNtLm6/3x+FzsYUC+JBuYpi
         KVxo41k5pAufRIZMoRe8KO4S0fM1MUBOfwpdxmtnHqoJmRB5LU4xWw5eg3pzrif9dyN1
         sVK96eTMUjxjhgG6PoqNdEgoZz23Nq7ZOEG2hKtUNS6KlK0I5fP3pZiTCLE11QA85O7T
         ohjsgfjDy+nd3vP7uT9oOGeQSXGWWndAVsRZ9i+PYshkxnSrMQEpkkCT9n0PSrvqqzk/
         bB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462832; x=1721067632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vwQyNgx5l06JN6vKVkGLyfa4vRNR4YaNZWudr9WkWI=;
        b=bfOOdjLM/vLN1F+t3Hoitf4KkI18Nqv5HiR/5A8a6NK6qSnSpO1xpjYzsNey2O9WCv
         HIreDaak6h49uG7xDm2E2PBpj42CblMiQMJ8D230eiJcjFwtQ1q3MviiBY2BVGtv5Qk0
         5WE4t7JWmiFFR7lr5gfq9eLfUSsT3YzkdePmzS5bzwDD2d4BDlIsbMjSdBoPsKO2Al7o
         iF5wxucbByPIzzFTsbLegdRovqLPT375SNLg9NtmxKoyQ7wNbChN7z5EqHjVlFNNBmc+
         nxEC3lnn5Edz2tGhTdfhCIIdMZoBGnh/UOCzOBZM26xtlDE/uEF7OaqlWx+Uqoj7YYjm
         F1bw==
X-Forwarded-Encrypted: i=1; AJvYcCWp5kp97kICGGSAGRdGO0B5ZPwMQS3O8rdCyHJtt+mZ+521RN6DGCuxgUnTk05tovaVSH0MHYwXzFk8/IoB/HASsLTALcXOjzA8iPXwXKf0beDvrTil8WB+lzNRyH6JIY1F+z6FQNE=
X-Gm-Message-State: AOJu0YwxQPRzGaieA4yqfT/RVraOSiNFDa4b0Emtr+SAFfzbAsrmQfVU
	VU82BxMmLhYvMLWJVoTiP4cBDLtyWOBugdkPvzvfVxa0QANABTdc
X-Google-Smtp-Source: AGHT+IGrhAkN3YE/mZDFUIgozy1SbQ4lc6JYKiA8I+DDJenl3jj7q9rT0rcHmwsupEvVBxJTezmEag==
X-Received: by 2002:a05:6a21:1a7:b0:1c0:f20c:5ba5 with SMTP id adf61e73a8af0-1c2984d7a93mr222577637.51.1720462832521;
        Mon, 08 Jul 2024 11:20:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898e3csm180758b3a.3.2024.07.08.11.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:20:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:20:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
Message-ID: <Zowt7pVWFB-Of-me@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
 <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
 <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org>
 <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>

Hello, Vincent.

On Mon, Jul 08, 2024 at 08:37:06AM +0200, Vincent Guittot wrote:
> I prefer to minimize (if not remove) sched_ext related calls in the
> fair path so we can easily rework it if needed. And this will also
> ensure that all fair task are cleanly removed when they are all
> switched to sched_ext

Unless we add a WARN_ON_ONCE, if it doesn't behave as expected, the end
result will most likely be cpufreq sometimes picking a higher freq than
requested, which won't be the easiest to notice. Would you be against adding
WARN_ON_ONCE(scx_switched_all && !util) too?

Thanks.

-- 
tejun

