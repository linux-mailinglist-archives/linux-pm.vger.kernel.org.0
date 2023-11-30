Return-Path: <linux-pm+bounces-539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCD7FEC64
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544F5281DC6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570453A266;
	Thu, 30 Nov 2023 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txRT9eUa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E1910C9
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 01:57:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so711609a12.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701338262; x=1701943062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GKUjDUfFZBuJDqMk9wIf5InzkGujvf/hhx2Me3pUVQ=;
        b=txRT9eUazb/LNZD1dzq52jBzCMPdwKERBADBkpNSpWV2E7KuZwU6EduBTDZzCuWgPM
         sEPE9qYxG/3KHQELtTCdw5f69wNSJ6ujfG4qOYx6a2qTZTjwDGAu/kLkitvZjbrYW6hL
         8cw7avpJ0Dc9K3a715tgdgsN0OTnKmJzHxolyCrpByti3Bgci1WPZ2SJOjcx5GTjLP6K
         XMs42w3/RQHnbTW79kxeromhoSERuLh3QfyGIViNvALL/73TGIcpQz6zb9hiPXEA0rDb
         soSb1oitnBblVgsjjKZMtVssXziSKNeGABBGSs7yagF+neVtIJvLZgrDe70tMeZv6Iqv
         HaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338262; x=1701943062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GKUjDUfFZBuJDqMk9wIf5InzkGujvf/hhx2Me3pUVQ=;
        b=gq/22tN8fNaKbrv+JNRIBlpdL7p1N+e7o+Wfg0xHOT3j4TspONkiVd/GuT+9SfRbPQ
         p3wWDCzz6kEk5OIa42zXu69KodhWWYyQb94eTUuFgWEXdcKy0OjuRdINHpC0fwixKDYE
         EYfeEUJBw+4kidfjZPXaKFXpJRMyVHN20nkGVzfewAdPHf6nzRrR/roUX0CoDqeRMNYR
         BZw7sckwsYJGZ1iOAIxgHJ2JI5Cn32ZzVbePGswr/8Eb+2RmvxHotQKUUlMGmpMsABDg
         rxQ8NSnFAEMJjVKGH1r/zyX6B6cOKjrTX1g3jVNr3CpTm/sVsCUh9A+w3tGI1u6kOdo7
         7TcA==
X-Gm-Message-State: AOJu0YxTEjuP0uYAnmTDCXHk8QSTNWi/KmYzM66vrl7fA3Qz85ujEc6s
	lAMLeUpkodvpx6Rx4tmCFjqr8WKpGloDlBc60e6fcA==
X-Google-Smtp-Source: AGHT+IG4qEkSIJ504Yo38Pz2GRrAyEzoAa5jrCRG3buDq6H5FZQpoQPj3v49XCh89IDRO0xCqMqzXtfhveSHawkPSOE=
X-Received: by 2002:a17:906:680a:b0:a19:1a0b:edb8 with SMTP id
 k10-20020a170906680a00b00a191a0bedb8mr134151ejr.67.1701338260873; Thu, 30 Nov
 2023 01:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 10:57:03 +0100
Message-ID: <CAPDyKFowioLLUi+4wvxz-9d3YGnMN=_sXBkFtUvMLb+tfQCEgg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, 
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 15:53, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi,
>
> This patch series introduces support for prioritized device shutdown.
> The main goal is to enable prioritization for shutting down specific
> devices, particularly crucial in scenarios like power loss where
> hardware damage can occur if not handled properly.
>
> Oleksij Rempel (3):
>   driver core: move core part of device_shutdown() to a separate
>     function
>   driver core: introduce prioritized device shutdown sequence
>   mmc: core: increase shutdown priority for MMC devices
>
>  drivers/base/core.c    | 157 +++++++++++++++++++++++++++--------------
>  drivers/mmc/core/bus.c |   2 +
>  include/linux/device.h |  51 ++++++++++++-
>  kernel/reboot.c        |   4 +-
>  4 files changed, 157 insertions(+), 57 deletions(-)
>

Sorry for joining the discussions a bit late! Besides the valuable
feedback that you already received from others (which indicates that
we have quite some work to do in the commit messages to better explain
and justify these changes), I wanted to share my overall thoughts
around this.

So, I fully understand the reason behind the $subject series, as we
unfortunately can't rely on flash-based (NAND/NOR) storage devices
being 100% tolerant to sudden-power failures. Besides for the reasons
already discussed in the thread, the robustness simply depends on the
"quality" of the FTL (flash translation layer) and the NAND/NOR/etc
device it runs.

For example, back in the days when Android showed up, we were testing
YAFFS and UBIFS on rawNAND, which failed miserably after just a few
thousands of power-cycles. It was even worse with ext3/4 on the early
variants of eMMC devices, as those survived only a few hundreds of
power-cycles. Now, I assume this has improved a lot over the years,
but I haven't really verified this myself.

That said, for eMMC and other flash-based storage devices, industrial
or not, I think it would make sense to try to notify the device about
the power-failure, if possible. This would add another level of
mitigation, I think.

From an implementation point of view, it looks to me that the approach
in the $subject series has some potential. Although, rather than
diving into the details, I will defer to review the next version.

Kind regards
Uffe

