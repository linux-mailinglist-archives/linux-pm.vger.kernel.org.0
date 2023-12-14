Return-Path: <linux-pm+bounces-1120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878768126FE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 06:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE741C21361
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03463D9;
	Thu, 14 Dec 2023 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfo+1DlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6576F4
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6da3a585c29so813054a34.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702532217; x=1703137017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=jfo+1DlFqx8LsY6i/hotCzNlUYjU1w3ZXEtYZFQbSP0KXI4qUbKIo09XJC9c10Rbnn
         Xp+iJwynQIu/0QwwzampcgNBc8dMd9Atlmd0rMys28PeomYDn9A5QIVm6CXhw+hGGaF2
         fmfQJ9ILZa9yt+SwM0u2YRM1R3wt9FPsDH2jW0fd3sKaAPD1BYR+djeV4YYi2DegDjm+
         LKZwWWQqKZ1YEJZFOehxysgPGxHsMbIuV3MM7HuqZhDniw0Zuy/4Pyqb9BZ0P2VP0+pc
         tqGbya/ImWZpBQjcU1dbPOEj3Ugjk+3CHtu61HN1ButCzD9+ds0NqrehKojA4S8MKCR1
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702532217; x=1703137017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW/CLTesU9Nn+LDbwmg1S+LrWy0eO5LzJlVzZDN0NTk=;
        b=AG35A1PcbmyS0r+akEdfd/YsRKhS7AqaB10DB0ECHTBFTr2psppmIhi8RyuUfW+OVp
         qui9tVCbsMEMlbUBDP6bFlaXbEk3IWBzQEpjsozL3Pa7ASz30Ph6jrYEP5weAowEUAJ2
         ZThaoMA4Ef6Xo3nuOEqmJRPQqmVjUI45oP1YiZVEHdSpO70wQbCKKFVVgPzHnzOHxOkS
         FErFThlIMBpVF3IHaoL7WcC/VkvGacwqatEIFX5BmZZZQfMUDjsCcYrLFRbPaLgH/+/x
         dF8AZLUubzbLNuXt4ZrEa2BS5/T7kJhqBdyO9yQZSOzNZlNITzOQf8WO8IsJoKxNO65Z
         7+zg==
X-Gm-Message-State: AOJu0YyQmMfI9e+oI7HXQ9rIYolOTE5XWDd4yp+S2YBMbeww1WP2PUlZ
	FJyULEk+GHgqJWOandj4yiJkJg==
X-Google-Smtp-Source: AGHT+IH+QeozbSYX0p0iXQ2G4XEln4ZOmYJ/iRjOrOBzxt3QGNJfpEqpr0j+HhoTkIB2PwvvSueIuQ==
X-Received: by 2002:a05:6358:7e8d:b0:170:6d55:e82e with SMTP id o13-20020a0563587e8d00b001706d55e82emr12607996rwn.2.1702532217124;
        Wed, 13 Dec 2023 21:36:57 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id pv18-20020a17090b3c9200b0028b0424a4bcsm723845pjb.54.2023.12.13.21.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:36:56 -0800 (PST)
Date: Thu, 14 Dec 2023 11:06:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, catalin.marinas@arm.com,
	will@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20231214053653.hnyeormwu42un5sc@vireshk-i7>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
 <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8807b68133f4b3a72227122a9d9a05f3fbf9d8.camel@linux.intel.com>
X-Spam-Level: *

On 13-12-23, 16:41, Tim Chen wrote:
> Seems like the pressure value computed from the first CPU applies to all CPU.
> Will this be valid for non-homogeneous CPUs that could have different
> max_freq and max_capacity?

The will be part of different cpufreq policies and so it will work
fine.

-- 
viresh

