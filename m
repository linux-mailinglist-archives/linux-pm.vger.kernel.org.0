Return-Path: <linux-pm+bounces-120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB97F5C62
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CAC1C20DE9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDD224F5;
	Thu, 23 Nov 2023 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhf24aQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C91B6;
	Thu, 23 Nov 2023 02:34:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so1013218a12.1;
        Thu, 23 Nov 2023 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700735643; x=1701340443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKQtp18JQp0c7NBbEbV2rdtJ3WRW+N/V6u+CJnl4oQQ=;
        b=mhf24aQtwm9yCORnHXcU9aHiAuz7m8dPidrjXq/5o9spnKZXN9gtUXEQhgf8kYEV4e
         jBjUcjA1zyf9MHyokUFLN6sIkYSpmZ5MPT25OUzp4pPa6Pw4IgDwdRmYGrkyW4DAo1r9
         yxRdSpKcUREuKlaMYnERFSTCKxApBAkMazo4P2LKAF6aVnfglwla18IRF9ACRLb/vNVb
         Am+JnObtAu3xgMNUoxZrgi53ixuMu96OT11vVOSUdyQmglaP3VLlz6fi214mQK3WduIn
         LlpmafGqym/BSa1rMzHif2NVdnDgJr938Oblh5fhYuWBsLx4cTTQ5Fdpo179wLt8rU3w
         /rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735643; x=1701340443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKQtp18JQp0c7NBbEbV2rdtJ3WRW+N/V6u+CJnl4oQQ=;
        b=LNAxinuu3+7YpLOoSqdGJT0TDJXVOFNibQN9U8JEHsGm1sl79vm+ne5LIe77TZf46D
         W2VxbnyXcngNFL3yw3pVCN4QeV98LgSNcPkbTMiYmDJOtBbZM3EmANw9GQYROqUwRLq8
         8J6Aq/xA7dQsMqviApnHjtGiHzic+frc1yAnhBcAj6UPz6sQ8fXen3udzwS9/GMPw8mB
         vl2HjXtsSPJifXJ7pXNmCGhaD2LeYEAQCHbQUtDw8D2BK/s3Onsa07K72yRuTUPGcGea
         wCdoBjZFnFephi42l8yjZ3COybpVyQQfA2wliUApW1GYr9MTl4V5GpVKYHkb9ryxhnbK
         C8FQ==
X-Gm-Message-State: AOJu0YymBK28BD+vzxFikC1vF70JyHBNG0KzKgRD9nFKubol72W+OfND
	e4OVHn6NMQ6VOzj5cVId0BY=
X-Google-Smtp-Source: AGHT+IHsuDtDlKW8ZHcAOngvbmoPlDZUP/co7CvQCsWrOLYZqFMmlR3FfRJVAUEecENHdbKTPiLqwA==
X-Received: by 2002:a05:6402:705:b0:548:656c:5371 with SMTP id w5-20020a056402070500b00548656c5371mr2365856edx.16.1700735643164;
        Thu, 23 Nov 2023 02:34:03 -0800 (PST)
Received: from gmail.com (1F2EF67D.nat.pool.telekom.hu. [31.46.246.125])
        by smtp.gmail.com with ESMTPSA id d9-20020a50fe89000000b00544f8271b5fsm490373edt.8.2023.11.23.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:34:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 23 Nov 2023 11:34:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	viresh.kumar@linaro.org, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v4 2/2] sched/schedutil: Rework iowait boost
Message-ID: <ZV8qmKccdVeVhVt9@gmail.com>
References: <20231122133904.446032-1-vincent.guittot@linaro.org>
 <20231122133904.446032-3-vincent.guittot@linaro.org>
 <CAJZ5v0iBO9LUs7xJKF0w1sOTM2ted5KxK4idwyCjBReyEYw+mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iBO9LUs7xJKF0w1sOTM2ted5KxK4idwyCjBReyEYw+mw@mail.gmail.com>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Wed, Nov 22, 2023 at 2:39 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Use the max value that has already been computed inside sugov_get_util()
> > to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> > which is not used anymore.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> Or if you want me to pick up this series, please let me know.

I picked this series up into the scheduler tree, as there's quite a few 
changes to the main interface with sched/core.c and sched/sched.h here.

Thanks,

	Ingo

