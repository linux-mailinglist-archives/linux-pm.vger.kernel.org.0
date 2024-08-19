Return-Path: <linux-pm+bounces-12434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9D956C72
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C51C212B9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D316C6B5;
	Mon, 19 Aug 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqaRB/he"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7D154C19;
	Mon, 19 Aug 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075408; cv=none; b=Y32XEDKSHp3tmjD2R3Jb8UjhSX3T2K7E+UCIxScKRnvc6CBrLR/KEtFNHtpxbyqNvKKMeKiQx0wynMZy6CubxG2EKMVAmyfv2ntnTg1M30ywfPyecWbaFgn3kFcEouP5bzGbz0CmBjwqIcCrZGH1C7/g3MWFr6eAt8w+a3UxdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075408; c=relaxed/simple;
	bh=WjhiTawlAIfuToCLmbnvKr5mf+reukg5NfmPH0NilqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+RcM07SVg2s+WGmbzPXJQXR4nzJc5XP/zgoT6/ikhHE5GXKnBPOltvD4CabpysnjyzKbpUmWm7InXnhzh0VH+aN3VhgibBTUZ06dDWBHupnEbFLw880pbKJO8UJE+TD8EVW91kNtIX1porFW5rxoo+D3jW1JMvEkKUWtnuqvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqaRB/he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5BEC4AF10;
	Mon, 19 Aug 2024 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724075407;
	bh=WjhiTawlAIfuToCLmbnvKr5mf+reukg5NfmPH0NilqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqaRB/hew/WcK84AMNulZ6tw3hgHRAwa5MomJWFqpf+VLIr3ZC1NZTek4GTxFvDkO
	 K+7lWVQCrMeM/nKK3lS9PRmEEcPRnIVd4yUPjWa8w4LBWSpFVpz4CXwfh2xjBQui+C
	 df3w6iKW2JfHS0Lqu3bSnhRqS3qmvaajF4agH6qtOL7qmyGybgDtd9M36jwgAaQEY0
	 lXLsY87pOt6mujSay7yfNezkJ9fR6iqJm5ucAhEru53gjKojnjc9H3L6u1mP6z0ixT
	 1unljzxS2RL3wZb81caw67KTbpILZO/0j1resdvJ41W8xuCod3KwZFqyZMl/Ri736v
	 j9YV2QFrxNimA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2635abdc742so544119fac.2;
        Mon, 19 Aug 2024 06:50:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdD4a/ehijq38KKzBANcyHM5eYOv6nXWB0U7r2TsiWA0ROYB0Tp3nfXOezI7+fUe2j/WFP4vta8EhueF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9HGY0N/fT3vnHvyeb1i/KKz0ECxsPiZ69j3ofPP7aJdwqabo
	5S+Kt6S1h9GtTI938JoUzjdi6VCqn1hS7Wf5XGuwVtnHeLUFRaRPXx4UiJGoMeT64dSPPkk3ZEN
	OY5Kh5bpbTj7d2x61txAfPC0IWkM=
X-Google-Smtp-Source: AGHT+IGcxvquucdhiO2i1h1zL1skFlN8Lo10S6HsHc6valnsvoyWSdQxP3XnhACp2aBS+6HQxuJddm5ENowjFXYUEuA=
X-Received: by 2002:a05:6871:548:b0:25e:b7e1:d20d with SMTP id
 586e51a60fabf-2701c09ff65mr5731197fac.0.1724075407157; Mon, 19 Aug 2024
 06:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6065927.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6065927.lOV4Wx5bFT@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:49:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2C2jbYeg=pTOTOwMFh+G4vkYn3tG5TzN+=r-7AYXLAA@mail.gmail.com>
Message-ID: <CAJZ5v0i2C2jbYeg=pTOTOwMFh+G4vkYn3tG5TzN+=r-7AYXLAA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: Introduce a debugfs-based testing facility
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:05=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce a facility allowing the thermal core functionality to be
> exercised in a controlled way in order to verify its behavior, without
> affecting its regular users noticeably.
>
> It is based on the idea of preparing thermal zone templates along with
> their trip points by writing to files in debugfs.  When ready, those
> templates can be used for registering test thermal zones with the
> thermal core.
>
> The temperature of a test thermal zone created this way can be adjusted
> via debugfs, which also triggers a __thermal_zone_device_update() call
> for it.  By manipulating the temperature of a test thermal zone, one can
> check if the thermal core reacts to the changes of it as expected.
>
> Concise "howto" documentation is included in one of the source files.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> In its current form, this is quite limited, but still quite useful at
> least for me.  In the future, it can be extended to allow "mock" test
> cooling devices to be registered and bound to trip points in "mock"
> test thermal zones, so that governor response can be tested at least
> in some scenarios.  On top of that, a test scripts can be developed
> for automated testing of the thermal core.  IOW, it's just a start.

Due to the lack of comments for the last 2 weeks I gather that this is
not controversial.

Since I want it in, I'll go ahead and put it into my linux-next
branch, but if there are any comments still, please let me know.

