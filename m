Return-Path: <linux-pm+bounces-374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC17FBC95
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A3AB2171E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241615ABB3;
	Tue, 28 Nov 2023 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/Xod48i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E767C1;
	Tue, 28 Nov 2023 06:19:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc35090b0so21159225ad.1;
        Tue, 28 Nov 2023 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701181164; x=1701785964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6XhNRARmqH+4x0OwGlgRfFmZJPzHtmJD0IS9paEElc=;
        b=h/Xod48iE+rQTOiopv7O9uNU46PbUTIP+qFhIrocbRocdql58bj86gTCakysGkthdv
         S8ISGsISLmra74nQDU/p3oPwiZnYxgTw7whmFj5RxzGLSLm0wzN7LFu/3O2tJi0Tddiy
         054USO/oQTGJz2qR8Eck7LaL7bsSi6OJdjs0/ABSsWqJD0Lq1QubfXQJC3yzf8HaoRh5
         vW4xZEWERag6J3iQ1LnRh0KG77BZbUQIE4jiOUdoEhJKCzm+EYd7d5UFpGAYG8zclsSZ
         tCFoGpkWBlpd4XxzGWwDagBJcBhSsYDQxazFcXCP35E02wxmqPTaXtcrayo0Qp9+uNWE
         hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181164; x=1701785964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6XhNRARmqH+4x0OwGlgRfFmZJPzHtmJD0IS9paEElc=;
        b=hB/0m8wtDU5F+mjPKqs/QuhZVHws6omq27qYn79zGHwvDor1fI2he4GXEaZWhtnOWS
         7r0ojg87C2+dAQYuwnpXFQLSbs1bY4O4vjvBgJv1GWwcozh6lVkWFXywbCHftUlBLPDn
         BqUJwkVIMM0p0gMa/j7ZXOAPfVJjc26cugSs0adu64Le2VDHz4gc6PuNtR1rLYQYcdtY
         wHVMIrMYc5ww39FTWNs5jsmivuAqSegVMoQe1fe4T5EZn+0ywXj0XjpknuINEB0/Au9S
         kd6LpYwADWt0XZUAIosgnXIWDOV7s8KqBOzx1cC3SxEUmI4VOrBPNYX1ilplEyT9+J2Q
         /rQA==
X-Gm-Message-State: AOJu0YzfxYB/kXmCYXF3valbF+6wRC0ZWqVR/zhVB0RZ0JGk9MWNgbEy
	ceG4DhyP21rfHGJuC41wA6I=
X-Google-Smtp-Source: AGHT+IGeC7mc0cJX07FMHsmska8S2jhN0dx43giDBl3kNLeg0J2yYUNXit5A04Bvwnt0hwj/iQjGxw==
X-Received: by 2002:a17:902:c1d5:b0:1cc:3829:8355 with SMTP id c21-20020a170902c1d500b001cc38298355mr13359009plc.12.1701181164472;
        Tue, 28 Nov 2023 06:19:24 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001cfaba4bfbdsm7781532plk.83.2023.11.28.06.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 06:19:24 -0800 (PST)
Message-ID: <9b424bac-b15c-476d-893e-9e6b54de70c3@gmail.com>
Date: Tue, 28 Nov 2023 21:19:18 +0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Power Management <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ramses VdP <ramses@well-founded.dev>, ricardo.neri-calderon@linux.intel.com
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
 <20231128140225.GS8262@noisy.programming.kicks-ass.net>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231128140225.GS8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/23 21:02, Peter Zijlstra wrote:
> On Tue, Nov 28, 2023 at 08:22:27PM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> I come across an interesting bug report on Bugzilla [1]. The reporter
>> wrote:
> 
> Thanks for forwarding, what happend in bugzilla staysi in bugzilla etc..
> 
> Did you perchance Cc the reporter?
> 

Yes, I CC'ed him.

-- 
An old man doll... just what I always wanted! - Clara


