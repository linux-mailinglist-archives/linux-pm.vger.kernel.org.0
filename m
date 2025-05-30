Return-Path: <linux-pm+bounces-27841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5CAC89BB
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655241BA45A1
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EB38B;
	Fri, 30 May 2025 08:08:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8E1D9663;
	Fri, 30 May 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592493; cv=none; b=K8uBlXmUttXvzPFXnNkB8iaTaAgIK/QnOkpjMV7Rx5A0X6yqR0CmYsXqaC28IR9adES1mjPnBzATEsX6BMx2JUQgmtgfEICfYADROD8DJS0JCf8YDjVopyO7Xf+fodD3XiXQmPU/z3Vl9Bt4mlJYEeTsjlv16VvRD/DTxUt523c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592493; c=relaxed/simple;
	bh=6tCwL2u6KuPKr/TaecQfjUqpAzt2QIbqc/AOFOxhOf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSelu/iwPqziiRgu4GmopUgbVmAOMcU5jyPCNfM+fE3qmZ+33+OW5Hrh2tqSO9UO5unumsAXUZPPbzjzllrtoEZrvKIC4rV+J2f9fptBIsOpXpB7xd8pjrYT81v5m5F6QTsg16wXEqxpy076VByQQWgoQF+jdRudmoXoAl0dmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87e37ab3c70so571823241.1;
        Fri, 30 May 2025 01:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748592488; x=1749197288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GikN2gdrNYhKG8oqhbkwJBiHi9aqCl1oQYrPKglurbU=;
        b=PmQ9j59ZeBQMrbVHqo5PBc+GFAmKzmbCz/wQAxLqy+9wU2GI254MfeB039TlzwgvyQ
         2yo2uq08XDgvqlDFdQTirJHyvPKva40jK3HDIFPaLYLZ/ySLwnyEvUvjju16+xv+V4C9
         l36KJOXH7LOhW1D1S6nlTcvYbtzQhwCuvjmL53MSAgwJ/oHfeEhWskk6LKgaxjWzQDLG
         S/WS+kBo7h5sU6RBtnjtzgfaU2Y4y7tSGAcSI8kttWAG2+PUZWR4T69XLvSU1KnmIGFz
         iEipPUmH4cK8XM/0eiKnHfzjkXdMxMW0FNnV+gufmOVixzL1BFHNUbF3oeFAcQqJ25Ub
         FnWA==
X-Forwarded-Encrypted: i=1; AJvYcCUxevDwWi6NFrhm7HOFtPqpFQGaaDDwapkdWKqP34lZjBrvztdQZKgkHeNhNK85rTZOcayEX0pJ3QoFZZxSnvM3GV4=@vger.kernel.org, AJvYcCVcU5o0ugbN57+/6uAHK3nQ5LlCm2Dv6LgFhHziyLwB0qn9O6b1CdKio9fdOiq1NWmfDdn21O97W1s=@vger.kernel.org, AJvYcCVcailjDvrV/SWMCUaoNbz+lV045gpumP15ZHdreZgfdiHr+iZ1ymPn7TS/K5SI5uo8wcR6qZ+wTjp42t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLhQwA5oG7IK8hq3fTFR6Qx+m9GeYbYOIqnoGzr00gqiIDRtl
	011Fw/Fq5tUE3U0aXfSpGrNlO9mRfk6InJ2reEsnoZrTzhVr/VHCvDqpMzbW9HrN
X-Gm-Gg: ASbGncu0MEaWOVBbLkz+Q0e0bUaTBZ2cBf9o/TXdenoBxuSEmOrbP+JT9v1jLQfu+bc
	6NwPBz8faGWTFyb6bXpHH537EnAsoU4PeDO4gv+evTpXZQA6Z74UFntrEPR0tcoA5ZAoFbAuOi8
	dg8EjY+2BesdYxfeKCJpiUW/HW2hYUGCCiJndopcCWBA8sJZKa1lowKXBGxK/YKKbFVXlDV6LLi
	sXR/AVRqSW+Rk4GiUzaSlHRM56w0YArAW7pF+gngff3MWL7PKAVleKnRLqOr2OmEB8hQHNOSgnS
	cODgwdQNMO8SDoxXBH1LIfv+cDrDV8oYmabzSUz+vaV8oCBXvjBQRnHfCF+nitgS4xU+7XFQvtE
	1imu4D39/3nTzrMtheRn0ZDDx
X-Google-Smtp-Source: AGHT+IEbrOoe4iL9jCNmTlAwrBaFqHWmLJH8lw3I10AhdMH9beDqejxmn3W0q/HunTFNjZPE0vhueQ==
X-Received: by 2002:a05:6102:3963:b0:4e4:5a1f:1414 with SMTP id ada2fe7eead31-4e5ac1ec663mr5249521137.12.1748592487861;
        Fri, 30 May 2025 01:08:07 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e6444294a6sm2478372137.3.2025.05.30.01.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 01:08:06 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e5aa697e7eso1118754137.1;
        Fri, 30 May 2025 01:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn2Dw7G38+w5Nu4WMikY8lWp13Vh+gDyfVJXdWQBwWuiwOL52st8Gy+NWvVptU4jE85HAElDNYzmT+pugf9t9dNJA=@vger.kernel.org, AJvYcCVWLLYoR/1jQIfiQLY4f3pYnfIsRNik6k5YjeHSLH5Kjm3s82a/CW6YtS1MC5hzu6Byoehe6+uQmc4=@vger.kernel.org, AJvYcCW2DRbnB/7k4xbmGwyQOdx5qLUtGjt/PAd0Qi7N5nHNkdx1YmJjVtU1pxzXuU89tatOTAmVBfc0fE1zaLQ=@vger.kernel.org
X-Received: by 2002:a05:6102:821:b0:4e2:b21b:2cbc with SMTP id
 ada2fe7eead31-4e5ac082e79mr5514782137.3.1748592485899; Fri, 30 May 2025
 01:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529101305686S2ehGmiFg5bnKwSa__96W@zte.com.cn> <6eca9bc9-ac12-4aec-85c7-66397f70fca0@kernel.org>
In-Reply-To: <6eca9bc9-ac12-4aec-85c7-66397f70fca0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2025 10:07:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVojqSZVg9xCQBUaonTsaDZ5ORsh_ttueOrhKgr10omiw@mail.gmail.com>
X-Gm-Features: AX0GCFuMwjrh6D-uoATe2WLWzQS7eI4m-tnyK-8gdH6v7YKT3QMk4tB_kj_UBT4
Message-ID: <CAMuHMdVojqSZVg9xCQBUaonTsaDZ5ORsh_ttueOrhKgr10omiw@mail.gmail.com>
Subject: Re: pmdomain: renesas: rcar: Use str_on_off() helper in
 rcar_sysc_power() and rcar_gen4_sysc_power()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shao.mingyin@zte.com.cn, ulf.hansson@linaro.org, magnus.damm@gmail.com, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, 
	yang.tao172@zte.com.cn, ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 29 May 2025 at 08:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 29/05/2025 04:13, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >
> > Remove hard-coded strings by using the str_on_off() helper function.
> >
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> > ---
> >  drivers/pmdomain/renesas/rcar-gen4-sysc.c | 3 ++-
> >  drivers/pmdomain/renesas/rcar-sysc.c      | 3 ++-
>
> Stop sending such trivial patches one driver per patch, but entire
> subsystem in one patch. That's a lot of churn, considering this was
> rejected:

Was it? I only see my Rb, and a review comment asking for more...

> https://lore.kernel.org/all/20250114203547.1013010-1-krzysztof.kozlowski@linaro.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

