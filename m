Return-Path: <linux-pm+bounces-31026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE5B093C5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41B05A1DAF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF72FE314;
	Thu, 17 Jul 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE/ocuFz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A359881E;
	Thu, 17 Jul 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776046; cv=none; b=ofqft7I6tc/5ujIOPWUAY0PbojV6x10bH1X3yGSvjtpCR6u3lfaJ52yw6i3YyPnah3Fc5WtceCVbBWXo1MZ4c65DpklOfJtTpxuWnMxDxg+luLzKZcyNISsCZQW6mUalt4HxbXBljGf353f4aFLHmgUzN4Dh5XZRYSz+E/ng8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776046; c=relaxed/simple;
	bh=j8lGJretA+xjmmX/bx4trYDH1LWpW8pfIBOFYQqkKM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXP3TjVtuCVO2/9EOfeKN1b43jau32jlqjTVQdm2gDwxBkUybr9ZCdtDMj6XKYlzANxu9zOVkq58gv0u9lgrmyIwFR5zeIsh5mkJs7znbnq0yeA2nt2e85LCOJmFucD6jGvEAJCIrQBYEa6BvXPGny/OSgt0kFHSiEsIlzv6FCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE/ocuFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D31C4CEE3;
	Thu, 17 Jul 2025 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776045;
	bh=j8lGJretA+xjmmX/bx4trYDH1LWpW8pfIBOFYQqkKM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FE/ocuFzvUolqbvPpFCXkzyOI/C54mxQIuzNyVSIA0Pa7ILkyrRtPcBSWYtDg/Spq
	 Uj/UOJ5S6vWyC4sR9okbnwUnNd2F02yrNhsabmZWsmFnzHFzfFIpgoFCk8dnllITYT
	 KvSDhsQwPvCCgbUdjH2ZuJO83qM1rJbN/VXoVfgZxeO6dIoJL0+sexnhWZJYibXKqs
	 TZz7aWtcarno91QTiD1JOjMxJEoNJWDb0zzltVguerOOSR0SxSPNOjD3DuSw4VMBw4
	 PtQ4qzzACHOsUH/XBbEF7prN7bpSFjNROYe2LaXq5MU19F3EQ8P5ZkG0jmaEKUMdkn
	 MrMyj2zqPIrhA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-615a02ebcc7so385550eaf.3;
        Thu, 17 Jul 2025 11:14:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK/yOkMzgMLFxQ0nyPVfQ07Txw8zgV+AdLWEM7h4pQFaS7PX4qZECOcXJslgy5Neo2dqgNI3U0ZoA5TzE=@vger.kernel.org, AJvYcCWt+bxyEuWWfHbq56F0BNXNa3Lli4Uw5JVFeiivp6a06NjSBcVFZGzgKWVjpgM1qav6Ws3KdTs5VS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPPCuhtGq44F15K7dXOqqAj2t+dK7R8tZI8azWfGiq3l5hrQM
	Neopj+S4xPY7RocAhqe2B52juHDjkNqJEJyykpviAqOMnPQT5MlL6SgX8eXGeKUO0bryrSzDN0u
	0htX7a0gO6Phfxc0MezyFM+3GHbu1flY=
X-Google-Smtp-Source: AGHT+IFqpAsI7op18i3dhaZ/Xg73o3mlXiyTzbn14TqjKbzqbGAKfKlKc2qn5u0HJmA2k23y4toVRjSZPNTJsAlN+cQ=
X-Received: by 2002:a4a:ee97:0:b0:615:b2c9:7ffd with SMTP id
 006d021491bc7-615b2c981abmr1641441eaf.0.1752776045145; Thu, 17 Jul 2025
 11:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085110.1468-1-pugaowei@oppo.com>
In-Reply-To: <20250717085110.1468-1-pugaowei@oppo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 20:13:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUqzT_+7VxmRqE_xAWzNCyfiUim-Hz9FaF7G0MuUb=bA@mail.gmail.com>
X-Gm-Features: Ac12FXy26PF0cVS8p6lyQC1qvFi6Qy__MLBJigUcRZYvj7XEF6ZjiDxa8O7MxNw
Message-ID: <CAJZ5v0jUqzT_+7VxmRqE_xAWzNCyfiUim-Hz9FaF7G0MuUb=bA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: queue policy->update work to a dedicated thread
To: Gaowei Pu <pugaowei@oppo.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:51=E2=80=AFAM Gaowei Pu <pugaowei@oppo.com> wrot=
e:
>
> We should ensure the low schedule latency of cpu frequency limits work
> to meet performance and power demands.

Why is the current arrangement insufficient?

> so queue the policy->update work to a dedicated thread.
>
> Remove the rt setting of the thread in patch v1 at Tim and
> Rafael J's request. However, it's will not meet everyone's request
> when we add a dedicated highpri workqueue to do the policy update work.

Why is it insufficient?

> Therefore, we keep the thread and will add a vendor hook in andorid aosp
> branch lately so we can customize the thread conveniently.

If you want to do something in the mainline kernel just for the
convenience of Android AOSP, with all due respect thereof, don't do
it.

This is not going to be considered for 6.17, so you may as well come
back with it when 6.17-rc1 is out.

Thanks!

