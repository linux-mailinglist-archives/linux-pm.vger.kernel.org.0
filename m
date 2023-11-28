Return-Path: <linux-pm+bounces-363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC57FBB59
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B91C213D3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3A57892;
	Tue, 28 Nov 2023 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS+2sAKa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA25A0;
	Tue, 28 Nov 2023 05:22:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc34b6890so19769405ad.1;
        Tue, 28 Nov 2023 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177754; x=1701782554; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30VypmY2CFZ8lvqagGC6jaet2OpETydP+u6D3TSu8fI=;
        b=gS+2sAKa2JBYPVICquPPt+xxjHgT5NonnAOR9Cqy8i7FTINvDQVAf/A0/FGQgetPCV
         AUN0lka06G7EFwylo9Mg/Nllkm9BmB6SB7coVFP/fXq1Mgmg3CyhFS3hDmx6BPgZkLTk
         Wto9aTndWnNpv9uAFjhsqvj6+p3PFabmTqwsaZkTAlx+66FRZal1lwVNZBqZJnEJPvsz
         64mnZpQYzEMsLcwwioi8z4o+IoY+VZr/lRwuOKmpBsL6fVoHVbLg5WJW8/3pDXVQoBNa
         1+6zjBO/TxGrtwoT9RYlhJA4a1C6rrzR9knhZ9JzkLIJ9mLHdife8X7V/c1Eabx2mky1
         lDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177754; x=1701782554;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30VypmY2CFZ8lvqagGC6jaet2OpETydP+u6D3TSu8fI=;
        b=esnAz3IWr4MPwVkAk2tfURXRFB/EDbvo4uNK7q0Lenk4NBNGE5nliOpf+glX9qCF3o
         TzwGlNFEdAOz5UMTwJJ54zsZBPWG7WVnfnW/vw9/SZgOMD6aYwKuhMltjsCXIUmXadER
         sURfYzffcaMPM4CVZOfcy+rXV93F7/JHXGYfuiOFv+6mcS0iYh/3H7SwZAHblDSkOCVh
         iStQbsuIIXmokrv+Xnqj0rwSCU281fEkRk6d8a3aQgni7eSVt3xwISFgJp8QopMY8bcP
         lEGfUgQv7iSiGPkbCTNX2rT8Aoaz+GJj4+7yhTQoBd4fFyD+8mQi+SkTt4T74BWIudnk
         6rNA==
X-Gm-Message-State: AOJu0YwK8iNoxLWw7wf00JspSo9K76MbgW4qrwmaIJW766yi0DQkAY/y
	mHBmivqMnXDNAVOPjHUYrNMJtcdIK6qIAA==
X-Google-Smtp-Source: AGHT+IH3JFeDBdC18l8j/Q+NB48Ja1KZVkzEIv229wi7jf8qWZFdPd/OFYbLqFjShGbgQBekqvZ+4w==
X-Received: by 2002:a17:902:ead2:b0:1cf:a53f:200f with SMTP id p18-20020a170902ead200b001cfa53f200fmr16674842pld.32.1701177753559;
        Tue, 28 Nov 2023 05:22:33 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001cfbd011ca9sm5767276plf.113.2023.11.28.05.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:22:33 -0800 (PST)
Message-ID: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
Date: Tue, 28 Nov 2023 20:22:27 +0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Power Management <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ramses VdP <ramses@well-founded.dev>
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Intel hybrid CPU scheduler always prefers E cores
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I come across an interesting bug report on Bugzilla [1]. The reporter
wrote:

> I am running an intel alder lake system (Core i7-1260P), with a mix of P and E cores.
> 
> Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems to have a strong preference for the E cores, and single threaded workloads are consistently scheduled on one of the E cores.
> 
> With Linux 6.4 and before, when I ran a single threaded CPU-bound process, it was scheduled on a P core. With 6.5, it seems that the choice of P or E seemed rather random.
> 
> I tested these by running "stress" with different amounts of threads. With a single thread on Linux 6.6 and 6.7, I always have an E core at 100% and no load on the P cores. Starting from 3 threads I get some load on the P cores as well, but the E cores stay more heavily loaded.
> With "taskset" I can force a process to run on a P core, but clearly it's not very practical to have to do CPU scheduling manually.
> 
> This severely affects single-threaded performance of my CPU since the E cores are considerably slower. Several of my workflows are now a lot slower due to them being single-threaded and heavily CPU-bound and being scheduled on E cores whereas they would run on P cores before.
> 
> I am not sure what the exact desired behaviour is here, to balance power consumption and performance, but currently my P cores are barely used for single-threaded workloads.
> 
> Is this intended behaviour or is this indeed a regression? Or is there perhaps any configuration that I should have done from my side? Is there any further info that I can provide to help you figure out what's going on?

PM and scheduler people, is this a regression or works as intended?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218195

-- 
An old man doll... just what I always wanted! - Clara

