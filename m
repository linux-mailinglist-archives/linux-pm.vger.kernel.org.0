Return-Path: <linux-pm+bounces-7341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B48B7010
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 12:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24FD282EDB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1812C48A;
	Tue, 30 Apr 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgBKBiQ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762D12C461
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473785; cv=none; b=TurPv7ZN4cw0WvTkf8+EnoolG2azJyjsMLBfNpUJGjeB0FVqJPlJ2YdeF6Ehg3m0HqWK6rquw6JLNq/9PEk0/SLCw8rmtGn12LBgg+uSSH5zD52HuRgIAhOb4+LWSMQdTklcUj+VEbN1PYgnP6OxvHNjD1B8XINvO/77N43wiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473785; c=relaxed/simple;
	bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugsZ5mGrMgBo6RN1oYkyUi/09V6p5AYFB7DhW2eynmgOlkx/VIwuCs9V6OGUrrjgeT9kQUEEJ0CzuTpxm9tDKg5+vyE/y0VWOHwa7YyKQVkXb6C0TBnby/siCydijDaKVnkL3YsH3TYNpA/y72IgwitYHLg2qflGj0rPsBRQSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgBKBiQ6; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de477949644so6192222276.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714473782; x=1715078582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
        b=hgBKBiQ6ow/n8OZW3ZLET/e5Hlhn3WXBEFfOMuu1LD0jKqcTeKe3DQnDHvMn5Ha+hv
         kohrmOw0JGz8VMneREkRy/YguN5KgTG5BfhxT0RYzH/R2d8Cx+xiwxzWMufE1KYQ2fs4
         YK6VE0k1jqzNPzu3fAt1rsh+Nlhw5eoVsQlYN3XTdGL2zoHHgSTguXVhMYvj6+D032VC
         C8wDw8OSbZe9H32zt3sChUM5a9BhFs15BI0yejCo2lreTk0MZm2P78lzt9Jq95pUxpMr
         E9oaNLyy7pYrc+/g3gRfwmyK7jrD5Jx4X9ApMrAUw2TiyVZ4bRPZHPti0FBUMVp1Wbkd
         ktHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473782; x=1715078582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDUiNpXWuWH30nxODfULOQvMKXg/IncYMLO1roSxJVo=;
        b=Twr+Uh86+3LMEkXMBBahVE+wrd3wv9SKLCQ+cPENdim/R5rVtK/vT2T737sBsTjYGi
         3s6oA/9p4MpDXWOzCoEdKmLyvklGLW4X2cA14tShQ6rvDj6RUS1Tv/U3JRqVO8vC7tcw
         RIaQ3UH2ncpThXltDU7jExBgJEocClSvMlIwH1Rk0bJDIdmtNnEhg2y4a+WFhU4i3+cz
         ZOkflJCPRRWPKxQMkfK6IkUPAxhtixfIHR7YNHg3vm6InZEfjvO12X7yUt8QiiEo61Qo
         lo2BGq1zZDfo6NO+VtFnfnIO7eOSsVm2DyRvw+6m3u3PQxhff/prMTo6pZJ6ydkgRYSI
         dMcA==
X-Forwarded-Encrypted: i=1; AJvYcCVsqN2Znrfmwh1AKBof+lqpTvL8EuKwXq3HUr2YLynK9CTR4txbpegyDXkcXVMyloee7RQzHJQ8jjsbPwpGN6U/96U9m8/vXz0=
X-Gm-Message-State: AOJu0YyLp+33XgK91p8ggeOYDvAnvaZQXAmtfONUteCvdKWPgjk6VZrD
	UUEcCD21eyJWx7jfeUB3yk9z7eWcAGYbp12N5TW8yTcEeptohS+St83F7Pp7vcsWdZflYeeJCoW
	IrztGriDoZ/TUYfQE5scMhuXJRjNWscx0QI7shQ==
X-Google-Smtp-Source: AGHT+IEPt6rtIomeocZoEOGlgzQPp8Y2RtRShUwpjfR7KXDzI2eA6BTyMW7lGrhOyto4UkFzMQ4YDQUwAAgGlkTl4hE=
X-Received: by 2002:a25:9347:0:b0:de0:deb0:c363 with SMTP id
 g7-20020a259347000000b00de0deb0c363mr14176771ybo.31.1714473782698; Tue, 30
 Apr 2024 03:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429140531.210576-1-ulf.hansson@linaro.org> <20240430094411.HyS2Gecw@linutronix.de>
In-Reply-To: <20240430094411.HyS2Gecw@linutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Apr 2024 12:42:26 +0200
Message-ID: <CAPDyKFpMga4DweVoLdW80mvfGr8vrQ5yNMcU_wgqWQuoLdo6+w@mail.gmail.com>
Subject: Re: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 11:44, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-04-29 16:05:25 [+0200], Ulf Hansson wrote:
> > The hierarchical PM domain topology and the corresponding domain-idle-states
> > are currently disabled on a PREEMPT_RT based configuration. The main reason is
> > because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> > genpd and runtime PM can't be use in the atomic idle-path when
> > selecting/entering an idle-state.
> >
> > For s2idle/s2ram this is an unnecessary limitation that this series intends to
> > address. Note that, the support for cpuhotplug is left to future improvements.
> > More information about this are available in the commit messages.
> >
> > I have tested this on a Dragonboard 410c.
>
> Have you tested this with PREEMPT_RT enabled and if so, which kernel?

Yes, of course. :-) I should have mentioned this in the cover-letter, sorry.

I have used the linux-rt-devel.git, which had a branch based upon
v6.8-rc7 a while ago, that I used when I did my tests.

The series needed a small rebase on top of my linux-pm tree [1],
before I could post it though. I also tested the rebased series, but
then of course then not with PREEMPT_RT, but to make sure there are no
regressions.

Kind regards
Uffe

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next

