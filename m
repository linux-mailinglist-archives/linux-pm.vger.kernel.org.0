Return-Path: <linux-pm+bounces-17002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D59BBDCD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4C5B22964
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF741C9DDF;
	Mon,  4 Nov 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PMURk49B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534518C926
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747505; cv=none; b=RsLxtb1IXMdI87KbL125o6mEHpk2o4bSstr7afqai1E1GUSpeBJ8mHqXgFk2bpdY/LG8VZVeB28X1ACS9NOx8XaWdktF2wVb/zF7iyI1fEJdfUYSRnnYy8d37lff/oEqAMgnh7/+ZJMs24l7H6D2rjijhmpoYwciDeSR3gNzY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747505; c=relaxed/simple;
	bh=GJMwmxY2QJv3siC9S1gXVcVWNI70z53QIzBszD+pYjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4VlPhik3UYso0zEJud0yx/MDSiqQYXRJ1c/oL/Fl4+dInFZr/caPeTU//gwecSrc9yabEHNc4ztjqAtn77WmHYwWsMG9uyFywbfstkS32kN115MRHn7/v4HBiNK8UZwwxdh2T5RfsVjfZP80VT+uujX2b6Z5ONctPYFC6hsDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PMURk49B; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720be27db74so3023309b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730747503; x=1731352303; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yD3GH1J0iNlguoAQJzDGR4fLjLQcEa8IFkCoKmA2t3Y=;
        b=PMURk49BuYQpejfrv268waENxhAtbYopLJ7tO13QHhpSQtA5bFSe6IPd1iEKkjgTMC
         Cu7Y16Z+L4Y6dTLQl/QanTka/LntIMgSzwBS1sxwzhLr7OCEU+9CQH7s5QDhe6hfPT6L
         5XqfmuS4RgIvV29AXWWvU1VXMlTEtYDo1p/gx61xHN63MieZ1X9Kr0xkPvtNblfQJxdf
         +v64OZQooNY+V1PsFUsBC2aeoaqvs01VJ6FiuOtkvat5VQ7wCkwHe+awjZuG7MREwiQW
         OMcYEfjTd04dtGMFub3x3CUv1GcMa2I7xUONWE69Gsfy8E6TvgbrVWVLmo653U3vWysa
         Fynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730747503; x=1731352303;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD3GH1J0iNlguoAQJzDGR4fLjLQcEa8IFkCoKmA2t3Y=;
        b=logy9ZO/Y6XzD8zZWRRpjo3waRMYPZ6I7Z1XGh/qcTtvX51siqBX9EmWSyytcbrsPM
         MDbx/PQ+Ie7bBRrz3Ctcph7YlUChdNxzkfodRyCBFWfzprIoqy5DS9vdN4MoxW3ZNWhu
         CN3UdDjIKNpujDVgyCV1J7iHDAqzZ7bnzsZfumz8Pzmta8DOZMqL3qnVfLmQO4WUrFYW
         Zg7A0YEsocD68dnRvuHjGKGvQEFzkZ6FJWpwxtbWApAgoQQ+8ViH7ly1pxmI2qvHqOZ1
         T71FGrvxLl2waYvvcK8CYenSU8gEmDpSe0m7qaVmdSUBK2zda7V3hzEFFxwce6rOOa09
         JCfA==
X-Forwarded-Encrypted: i=1; AJvYcCUB8lBdDDN42jX0ZvPMH7zrLJ6MtPDvD5juQ5/kYdO5zxidJbCthof/rTyb7F+dx+tazhD8NAqSmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lCeFfWusZ27CdvKkralLIRpx6O7qBQJEwcqFLcD5aQB0SRTs
	dYNtqAufKxg6/8b9KhB12mtdFIazJvw73e+KYywhqW+pSeYzxIAKsiA6DM7BBw4=
X-Google-Smtp-Source: AGHT+IGqCQyEM930jC+c3qeymfKxAzWzWDIDt/8CIo9XGMeeXcHgVl+iFmqzHFj25u//wA35k/KmZQ==
X-Received: by 2002:a05:6a00:2150:b0:71e:4fb7:3a87 with SMTP id d2e1a72fcca58-720c983b763mr18191351b3a.13.1730747502942;
        Mon, 04 Nov 2024 11:11:42 -0800 (PST)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc20e4c2sm8131771b3a.91.2024.11.04.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:11:42 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Vibhore
 Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power
 mode constraints
In-Reply-To: <20241101203248.oxddn7yea3us5nth@tables>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com>
 <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
 <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
 <20241101144445.56ejnuoxshqwns37@boots> <7hwmhnnf0f.fsf@baylibre.com>
 <20241101203248.oxddn7yea3us5nth@tables>
Date: Mon, 04 Nov 2024 11:11:42 -0800
Message-ID: <7h34k6olu9.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nishanth Menon <nm@ti.com> writes:

> On 08:35-20241101, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>> 
>> > On 11:11-20241031, Ulf Hansson wrote:
>> >> On Wed, 30 Oct 2024 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
>> >> >
>> >> > Ulf Hansson <ulf.hansson@linaro.org> writes:
>> >> >
>> >> > > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
>> >> > >>
>> >> > >> Hi Kevin Hilman,
>> >> > >>
>> >> > >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
>> >> > >> > The latest (10.x) version of the firmware for the PM co-processor (aka
>> >> > >> > device manager, or DM) adds support for a "managed" mode, where the DM
>> >> > >> > firmware will select the specific low power state which is entered
>> >> > >> > when Linux requests a system-wide suspend.
>> >> > >> >
>> >> > >> > In this mode, the DM will always attempt the deepest low-power state
>> >> > >> > available for the SoC.
>> >> > >> >
>> >> > >> > [...]
>> >> > >>
>> >> > >> I have applied the following to branch ti-drivers-soc-next on [1].
>> >> > >> Thank you!
>> >> > >>
>> >> > >> Ulf, based on your ack[2], I have assumed that you want me to pick
>> >> > >> this series up. Let me know if that is not the case and I can drop the
>> >> > >> series.
>> >> > >
>> >> > > Well, that was a while ago. The reason was because there was a
>> >> > > dependency to another series [2], when this was posted.
>> >> > >
>> >> > > If that's not the case anymore, I think it's better to funnel this via
>> >> > > my pmdomain tree. Please let me know how to proceed.
>> >> >
>> >> > The build-time dependency on [2] still exists, and since that was just
>> >> > queued up by Nishanth, I think this series should (still) go along with
>> >> > it to keep things simple.
>> >> >
>> >> > Kevin
>> >> 
>> >> Right, that makes perfect sense to me too. If we discover conflicts,
>> >> let's deal with them then.
>> >
>> >
>> > oops.. I missed this response. OK, I will let things be.
>> >
>> 
>> Oops, 0day bot found a build error in linux-next when CONFIG_PM_SLEEP is
>> not defined[1].  Need to respin to fix this.
>> 
>> v5 coming right up....
>> 
>> Kevin
>> 
>> [1] https://lore.kernel.org/all/CA+G9fYtioQ22nVr9m22+qyMqUNRsGdA=cFw_j1OUv=x8Pcs-bw@mail.gmail.com/
>
> Kevin,
>
> Unfortunately, I have chosen to drop the series. We are too late in
> the window to take the updated series and wait for new regression
> reports. On the flip side, this will clean up the flow for Ulf to take
> your V5 since the dependent series should ideally hit rc1 by then.
>
> Thanks for addressing the report fast.

OK, thanks Nishanth,

I'll work this series through Ulf's pmdomain tree for the next merge
window.

Kevin

