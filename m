Return-Path: <linux-pm+bounces-8584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473878FB918
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004E72841A9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9A148858;
	Tue,  4 Jun 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W4CGU0Pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771A148FE0
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518824; cv=none; b=uUB8Hditx9JjkjLBIdsUMRTD/RG7WEU0Qm7ldUP6ImTYvGb/QMybGljHsD77K2m7mggIx4yX1UYcNnkoJsSHZlfOXjdF8/6gXKiGQNzKnSDz5MAhntLvTYDAf/EGiXe2IqzS7dIUzQ4xKtFfwYa7RAsi/4jbgCld5KjN3wgdmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518824; c=relaxed/simple;
	bh=0sjG0tqlKzolcqbhmchRyBzY61TASS8q3u0cZwwqMg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NvKRYvu+7EEhj8p2BysztD+Bc151PYxrVJCuF7323R7VOi00e0yxZhsTR3K2RkgIXLmCSW8jj4G8n0b/ZuKecfoNCmTvqvjgtEorJNcgTGxh8CESlYRdYIqoLITDTDZpTv4MEeSjGIyTPV2IT+FBmWbgcvaTAQmRfetZMWlHgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W4CGU0Pv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ae4d4abeb8so24939966d6.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717518821; x=1718123621; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ3fzqU7zIJSZIaEHoz1dBE+4a5Pc5bbz++LUqESkpE=;
        b=W4CGU0PvWe/ITnumQkYU1g/tLCgPrrs8LgoWafFHEbNHSikDAL7mj1L0sThcFlxaon
         RbfpF9HrPWYvGkljVTsc9NqYQ44o2Pt80LKdnHRj6gqItfcyej8DgbNo6h0BJ92Rim7I
         PsdJyEgizl1Ig98QcYVpls5T+a9n30y19xIiv0b4MfV9nCKhMprf8XFRe16B9FfMEgMe
         WA/j8+apWSjeHi71d2CgQWc71rnuyLQV8fyeH8XsMg50HsywbZQwdqPbb2yTA5l1Z2B4
         8O2SffMxg24pUBR7UMVmktsGH850UndIF9+o32GGf9DljsUBbGXMCb/khhOHN6JvECnB
         B5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518821; x=1718123621;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ3fzqU7zIJSZIaEHoz1dBE+4a5Pc5bbz++LUqESkpE=;
        b=ZVz1wVij97pISr93TN8aH4gPZIzFraLmqEcJ3NZ1XKaB7mjDyiVOgH4GWH9574RrjH
         OEU4pAwVkx9bnVgLWyFjc+3oa8ZD2SYzEXGsJBrIVEiNkh7jIK0UnXuoNnHHbjp/Cn9+
         8HfA2b6UW6zlDYu7sOfV42A4vWIrYmy7GmHOlikZkF/TgagxYtzig4FOrP6GHSGXjBQd
         yDswV/u3wknVMd1kFPkAQb3mh7ZYsCppTSrP3l/4v6jFyczr+Lje/JHjywR5YFoU0hjX
         eqTpQVS8TJhxNtOhtoIAXjR5YMwWdeI29zHL883NsDr0BtedQXPSqCD7IsqJc2YzH6mz
         MY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqqdyfVb4hDJdkkW7Rn1sdqH8+7Oa8hCTXQGUNnaBBN4xImdreayYCDw4yTWmDO4fz/TB1BQIwJoactiINpiOKDAU2ouC3bYs=
X-Gm-Message-State: AOJu0YyjP2ed0iktTkxFg+fQuP3SKbJe5EaK/kWnFYdymwp8TiKrF2Tq
	6DXPE+hW8+/DnuoCRHHfE/C6Ei9lBZ2dc28JBQrGJ4K75QwKpueUNo93ewR8sZ8=
X-Google-Smtp-Source: AGHT+IHd2opDiMK9J56b4t8UYsWXPdl+c252CiMlGiyJylrxgyVHd1pODis8mm4KS0VPSIQYkVKiLw==
X-Received: by 2002:a05:6214:588a:b0:6af:4fb6:22fd with SMTP id 6a1803df08f44-6af4fb62450mr95965726d6.3.1717518821099;
        Tue, 04 Jun 2024 09:33:41 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73dfa8sm39997536d6.23.2024.06.04.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:33:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:33:39 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Julien Panis <jpanis@baylibre.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
In-Reply-To: <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
Message-ID: <359n7s98-08p8-177q-n51s-33rs215soqq2@onlyvoer.pbz>
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com> <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Jun 2024, AngeloGioacchino Del Regno wrote:

> Il 03/06/24 14:06, Julien Panis ha scritto:
> > This patch prevents from registering thermal entries and letting the
> > driver misbehave if efuse data is invalid. A device is not properly
> > calibrated if the golden temperature is zero.
> > 
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> 
> Fixes tag, please.

What should it refer to? This is arguably a robustness enhancement for a 
defficiency that has been there all along.


Nicolas

