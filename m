Return-Path: <linux-pm+bounces-9335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B21F90B1AB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B26B1C2261E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6251A2571;
	Mon, 17 Jun 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJGJUEyu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F61A256D
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631043; cv=none; b=VNk8H6XWBU66u6CPpieeX+vBqj2B31ipMtBDfI2fK6krF5RRFvGntpISuDSBXA+42eHVn/CK3A7ucGTen/fhsJW0koQ5bvMcaWl18jSVC9FWOMAxBsYPUB1bbBHtCbc//9t8quMk8Rf4ifbTYCYt0ZpEDPhnnMl6yPif5Oulri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631043; c=relaxed/simple;
	bh=WqlLmqlvY4sp9jSatJLGgXPVRc8CV8G68GhhdU26S7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNSKYrgmGeB17+I5xC70QZLI2efBTy971ZsnGd52drrKzi0XBb26Ndr22MYXva031m4tpw37XOXFeEYId0XWhpFbeTpVa8F2LsSXsE274ec6H4yjxFsHvOf95O7tGtj0mA9SdtiwhrIccAALcd6KCWljYSXAaZqdqAL2uX5BhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJGJUEyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C778C4AF64
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718631043;
	bh=WqlLmqlvY4sp9jSatJLGgXPVRc8CV8G68GhhdU26S7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lJGJUEyubI2oEm0av4OqlEX64M6yfTo+MOcieNIYcTrAayXe6CxCjmmmnbEU6J9Qk
	 gAkvG4heATpGEAbFV2PxNPbP0ek9fZ6hSYxmqjchOuayDkE1EN04eQs17CrFUgW8eU
	 N188SXbVe1Xi9EU+zh5atGX/IM7PaCFPbj3m0aJTnzVayJK8E//46J6kx/l6M9dnlA
	 iE8Uiz7tITQ6600+f010ujC8vlEXDe6ru02VB3hOuUE4e8SVwIcBvhI8wAB/vovgi0
	 GmdOm2K2LRsLtVPHBE2eHIBxCK6FZQGhdR7Gfl/xdRxWgUOQMuCtUhGrpndJAYHjAv
	 7HczvuuoVvbXw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254925e6472so505563fac.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 06:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCZCwEldp6ns6HS25LMWHFJclHs6cIrhjq9cPGvBrcIHC0jmB8UfQe2xXPFa7bgvSbCAcy9xZqdSpqrgtruN4ZJXfK2IbSpQA=
X-Gm-Message-State: AOJu0Yy46hJ05cv/N9iYDI7JnRL4cv7XiqkpvKBvUWv5MGgQTIezgOJs
	azqiHFd5NSoU1aDuYgT5rGZ+lguZQRLPiYRwd7/m8qK4E4DigqDsYSFTmKhFZgfTNDYs6K5EvHP
	9hYdLmzmtG7gqHi0k2xpA+tQNNuc=
X-Google-Smtp-Source: AGHT+IHgGg0kfy17G8mIubjVyUBysFyyNA8pG3LVK74AIylR/pUOOR4OHa5WDJ4CjfPPizByyUSEnFSnZ+ktrboWxVc=
X-Received: by 2002:a05:6870:469f:b0:254:d417:351f with SMTP id
 586e51a60fabf-258429511admr10424676fac.1.1718631042350; Mon, 17 Jun 2024
 06:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e082c01-d0b4-46e4-bae3-0e7ea89be800@linaro.org>
In-Reply-To: <8e082c01-d0b4-46e4-bae3-0e7ea89be800@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 15:30:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iq=L6FpPeoemJ8NLL0w9wDPuZiFtO3doWiSEjs=z_w3w@mail.gmail.com>
Message-ID: <CAJZ5v0iq=L6FpPeoemJ8NLL0w9wDPuZiFtO3doWiSEjs=z_w3w@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v6.10-rc4
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Julien Panis <jpanis@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Jun 17, 2024 at 8:05=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the following changes since commit
> c3f38fa61af77b49866b006939479069cd451173:
>
>    Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.10-rc4
>
> for you to fetch changes up to 72cacd06e47d86d89b0e7179fbc9eb3a0f39cd93:
>
>    thermal/drivers/mediatek/lvts_thermal: Return error in case of
> invalid efuse data (2024-06-12 19:07:34 +0200)
>
> ----------------------------------------------------------------
> - Remove the filtered mode for mt8188 as it is not supported on this
>    platform (Julien Panis)
>
> - Fail in case the golden temperature is zero as that means the efuse
>    data is not correctly set (Julien Panis)
>
> ----------------------------------------------------------------
> Julien Panis (2):
>        thermal/drivers/mediatek/lvts_thermal: Remove filtered mode for
> mt8188
>        thermal/drivers/mediatek/lvts_thermal: Return error in case of
> invalid efuse data
>
>   drivers/thermal/mediatek/lvts_thermal.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

