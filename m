Return-Path: <linux-pm+bounces-958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A450080ED10
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DA41C20CA3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28961685;
	Tue, 12 Dec 2023 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="sPMb4p1d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547D115
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 05:16:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so42767165e9.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702386984; x=1702991784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXxhQ5e/8QVdF34DlnTqCnedNIr6zdJHDPH+rQPlrZo=;
        b=sPMb4p1dYxsXwSNxnLkpWsz8coG2SJMv6yhdf4NPe5gEz7btD6ex7uVbJwn0BZvEOK
         J+naJ8ZLLvSrWJ+0SwK+TBSQxHaaf5iQ87WxufhHeFcJdA3o+ANu/OnbwG1U5uW0H7Ru
         7IfYZc3lLNofqhKZZwhaFma/bjvjxmKuNtXjlAJtfeMUse5Op9S83WiM8ahUUYMk4VtK
         lCP71qLuqh01BEniMu/X/a3kx3aYaJ98DjOTsMMHqxIU68EXt3kN4f8wugFx/UexhlLc
         ifzoYFwDMsHj2S2r60Xh1J9rXEgo6IzJcNS3iuSZfoXJNt2srF08Nm/n/sk/LhUS8iU8
         JJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386984; x=1702991784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXxhQ5e/8QVdF34DlnTqCnedNIr6zdJHDPH+rQPlrZo=;
        b=KnDtgqK8Pkr4VHDghMhZYH365Gxd4Bg4GePwBNakpfMx/lwE3RIfAtR382pGVFggBa
         X9nU0YXnIILYIBH2ZLoGbgoOZQS3ruSJQK9JbgPanFznlnWK5+lQAm6sJ5qQ1H3nfu96
         EBlnmsfjvgxYSW0iM8KVFmF2NYeKotnJxXwUs899T/MGSMziPB6HeE6EBI4hA9vi0G4z
         W4Gq0Yy52/XvkUilEoKPfZA0LNeO273fsRJIKX0BPWLhj+YRt8UlVB81OC6PkPDueuQo
         qFDHwZ610IuNQhxydpL6mQeS9wf5G2UCN2P7KH/bSQ4uTAQ98NfBqgjrqGoSd2viAHlx
         EU5w==
X-Gm-Message-State: AOJu0YyeSMXUB29yLqm3c/9bGcLVEv+ioIn9MVJxJdF1XhFWhg30/TLX
	BfYG+HluwdzdlUG7N2lX67mymw==
X-Google-Smtp-Source: AGHT+IEUQNnVrh37Nbjc5DxK1DytPyg7lGQIOmoxLrCkwcQ84feYRReIAQ51Tjbj+ZIWyhVoFaeIUQ==
X-Received: by 2002:a05:600c:3105:b0:40c:46eb:e6ad with SMTP id g5-20020a05600c310500b0040c46ebe6admr1729816wmo.175.1702386984024;
        Tue, 12 Dec 2023 05:16:24 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm6258392wmq.12.2023.12.12.05.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:16:23 -0800 (PST)
Date: Tue, 12 Dec 2023 13:16:22 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20231212131622.2dpcd7k2r5gny5ki@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-8-qyousef@layalina.io>
 <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com>
 <20231210204032.fficzltp2gq66pne@airbuntu>
 <CAJZ5v0iKwcwkUBYaKkSkz0sPoHxrG_5pD295v_Z0jFDhR4FRFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iKwcwkUBYaKkSkz0sPoHxrG_5pD295v_Z0jFDhR4FRFA@mail.gmail.com>

On 12/11/23 21:20, Rafael J. Wysocki wrote:

> I understand the motivation, but counter-arguments are based on the
> experience with the cpufreq governors predating schedutil, especially
> ondemand.  Namely, at one point people focused on adjusting all of the
> governor tunables to their needs without contributing any code or even
> insights back, so when schedutil was introduced, a decision was made
> to reduce the tunability to a minimum (preferably no tunables at all,
> but it turned out to be hard to avoid the one tunable existing today).
> Peter was involved in those discussions and I think that the point
> made then is still valid.
> 
> The headroom formula was based on the observation that it would be a
> good idea to have some headroom in the majority of cases and on the
> balance between the simplicity of computation and general suitability.
> 
> Of course, it is hard to devise a single value that will work for
> everyone, but tunables complicate things from the maintenance
> perspective.  For example, the more tunables there are, the harder it
> is to make changes without altering the behavior in ways that will
> break someone's setup.

Okay thanks for the insights Rafael! I hope the matter is open for debate at
least. I do agree and share the sentiment and if there's another way to avoid
the tunable I'm all for going to try it out. I just personally failed to see
how can we do this without delegating. And the current choice of 25% headroom
is too aggressive for modern hardware IMHO. I'm not sure we can pick a value
that will truly work for most use cases. In mobile world, it is really hard to
cover all use cases. Different OEMs tend to focus on different use cases and
design their systems to optimally work for those. And those use cases don't
necessarily hit the same bottlenecks on different systems.

If we consider all the possible systems that Linux gets incorporated in, it is
even harder to tell what's a sensible default.

And generally if there's indeed a default that works for most users, what
should we do if we fall into the minority where this default is not suitable
for us? I think we need to handle this still. So we need a way somehow even if
this proposal doesn't hit the mark. Although again, I hope the matter is open
for debate.

The only ultimate solution I see is userspace becoming fully uclamp aware and
tell us their perf requirements. Then this value will be NOP as we have direct
info from the use cases to help us give them the performance they need when
they need it. And if their usage ends up with bad perf or power, we can at
least shift the blame for their bad usage :-) /me runs

But this is years from hitting the critical mass. We need to get to a point
where we can enable uclamp config by default as not all distros enable it
still.

Anyway, looking forward to learning more on how we can do better.


Thanks!

--
Qais Yousef

