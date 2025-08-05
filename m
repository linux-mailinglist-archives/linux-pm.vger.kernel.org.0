Return-Path: <linux-pm+bounces-31930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D551DB1AD5B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75877ACEDA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED521A420;
	Tue,  5 Aug 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTKiDSbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085621A443
	for <linux-pm@vger.kernel.org>; Tue,  5 Aug 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369900; cv=none; b=NswmNMsq7bEJ8og4VX/gdMieZb5Oq7VNEe9Oox9Pcvi+vZkS0xuZP9h6quFpb2Fco1076tnLoUfXaKhWzhOMMY7p7jPglfuIPYhuJOMDJgwxCII0tDUUkbh4GxrxA12O1H7sj/G7ORhVgSxSvdiyPHCTmxbZI0EBQbWCUeDqs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369900; c=relaxed/simple;
	bh=3PZdbfIvTgDh6oXznLdZrAfYCAxiqm8VHBY099ZhKvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds3orrvhTA8dHIcaj0J3lmLcS5C90rWaq2kAXCicVw9GFU7tY4EVTMLDk9MuHkH9BGdKOuZ1H+Adwn7SNIMGRIpYHCH8ozxkisZjsXrtdUGRDk6wnh2IeoFTau93K52z7WZkkphC6Bhdus8V2h3t1Yun/AQAbVH/QYXHib9KhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTKiDSbf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0673b0a7cso334161cf.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754369898; x=1754974698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsRyVRJD8Es/gVJT/DgtUphiwIWfxJmiAoGaX7ab8fg=;
        b=nTKiDSbfbbm/dCekwyXKyd1ZJH+xTdgobX+8v/ODW9eBysFYb07dK2/+MiQjQkgoyj
         IP76TbtT/XkwHtT5x+QbIHOd21bBbvrFWfwda90EWdO/Mf4YvsXDcLfcYRrWclQfo6Ta
         H/Vb22fq7dRJq6AZBwOadW7qN+EmjDsQ0GrrBdUGrwETveCEB+Rux2qjWtnAOdJxyunr
         HMQ9UjpdwEwwHWSn2Fwhzg0vpgpA6WXnpd8BDczrWbbp1+9FBw5ynkkCA+H615f/mu50
         g3vDZkBD5JohYzm932sj6J1Lu3td/OE3biAQdiZk8SlxSrMHibUN89HZkJTT148qM3JB
         Oi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754369898; x=1754974698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsRyVRJD8Es/gVJT/DgtUphiwIWfxJmiAoGaX7ab8fg=;
        b=PwdjSLLbYGFUjHX5ygc1rFd87rB5AvIpDmYZmBSeaFF+xlxHkccl/QCN9JT+wpJC8p
         tSU8QYkMYaN8IaqqoiXJQjC7Ac7k/8+EZaRbYW9BTU+ug4Ss9jxtKWf9NhVWV6LXbrug
         MR1etVm0MTtVBs/SFSlbFRsSQECvxbOGeX4qjVlivrdqdB279syxbY25bqk1gXe9ufcu
         xwMFGQJa4w0gluZ9QM3Y/GZTKSeUhTWOMnYm09fxUhtzdP/aGwQ9AiZJk1oKVnX38m7P
         49BVqOdURSsJXJ6KzrVo9Pn+qPPgQKJ+gGKSg5B8QKKWYj3XEMgyj6mmL3nTJf2cBOeN
         ETZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvu+Pbz3FXiUKMQvqPoC4ooXXGq8hYoLgHgnXp/1sbmBeOjD12apUCYlFLp2wz1Kqe2ku+p0u8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1uESVqzLHgblUopb26IcGLv3LO50yzRvWA8aWgQK4J97TBfF
	OQ/ghi0kmOx7Wkjj1kyJvfcP92R6J+upt/deP1RSzlxc84mw0KVWBfQH6JfjM2xWjyfqN6qtzP9
	VSmdF+hasAPuc2Jkx3un1efIHXvjuMakU5NYLN5kk
X-Gm-Gg: ASbGncvj/AKwU9R9QZqne/hwE9pWyEdRIH4GXaZUkCK1WWNJqRXBqMCNPTPXxTollsv
	qhUkZX6huhfqKfr9ZGftc/ipqivtlfHgFVBLI2I5jsEpmL0FiI1e9Z8adjUAb9IcQiF7JxIUU9n
	PNt34WAimQF6aEkcnNVkpvy6rGqoMbL4H8NtjESU+lTFEoO4sG8wKbp0K+E5S28DtZmG9YONqzD
	OK/Nw==
X-Google-Smtp-Source: AGHT+IHF7LACRx6CUYFvTR4STh+sJ0W20jCtRgbftCjbI3+A8IvKYyDvaKI1kDWYFQyHdN4wIO80jJ089UrccrLUHsE=
X-Received: by 2002:a05:622a:4e:b0:4b0:83a3:9bac with SMTP id
 d75a77b69052e-4b084ffef47mr1208681cf.17.1754369897478; Mon, 04 Aug 2025
 21:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7> <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com> <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
 <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com> <CAFivqmJyYJ+d+TH4qYBKf_5t-AqWZuzgk2H_4nHmynTjoUHnYQ@mail.gmail.com>
In-Reply-To: <CAFivqmJyYJ+d+TH4qYBKf_5t-AqWZuzgk2H_4nHmynTjoUHnYQ@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 4 Aug 2025 21:58:04 -0700
X-Gm-Features: Ac12FXz8zwL_C0_-xnsUm0ufCiX6T_i7jVIErwFm3t5yDb1t9o9c5UB7mipfcrI
Message-ID: <CAFivqm+4Mir8hgGw-HMLdW=dBYuUw1wJ4xG4a+WAtqfG1vYKXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, lihuisong@huawei.com, zhenglifeng1@huawei.com, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 18:12, Prashant Malani <pmalani@google.com> wrote:
>
> On Sun, 3 Aug 2025 at 23:21, Jie Zhan <zhanjie9@hisilicon.com> wrote
> > On 01/08/2025 16:58, Prashant Malani wrote:
> > > This begs the question: why is this work function being scheduled
> > > for CPUs that are in reset or offline/powered-down at all?
> > > IANAE but it sounds like it would be better to add logic to ensure this
> > > work function doesn't get scheduled/executed for CPUs that
> > > are truly offline/powered-down or in reset.
> > Yeah good question.  We may discuss that on your thread.
>
> OK.
> Quickly looking around, it sounds having in the CPPC tick function [1]
> might be a better option (one probably doesn't want to lift it beyond the
> CPPC layer, since other drivers might have different behaviour).
> One can add a cpu_online/cpu_enabled check there.

Fixed link:
[1] https://elixir.bootlin.com/linux/v6.13/source/drivers/cpufreq/cppc_cpufreq.c#L125

