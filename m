Return-Path: <linux-pm+bounces-8797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719E900C25
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496CC1C2178D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1091411E6;
	Fri,  7 Jun 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdeN7wPh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0F13F440;
	Fri,  7 Jun 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786581; cv=none; b=DynNNJ9OsNfQT/KVKGvyvwmzQbTJ6YbmMnwkT0LIpD6659Xwzckl3x9WUNF0dHvZKqQqmGB1WqyNTsxfw8aGp/Oi6Z6bJjeaNJAhMu8+NSbkHIYgXqhgOWNgUNa9vBCPiQN2MCG/udlMPdKPFvjeO+a8p5TT/5g38X8kPUUAtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786581; c=relaxed/simple;
	bh=zNWgpa9VXBHQ6K/ORcFzW8pPuEGTlF88v/NSUrhSNik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjKQXwlTkXyo95vF91zMPuLNJBTpoYzLF6mwkeC56UeWo8W5c1dDC0uugebcSCjxzNNVELabk56qP85D9ZFQe4fnLXq1Su8BtPkLMWeDx2CBYXTPFtZyrz3uZRpqMoowgSTwt+zbRBeH9dyQfT4l0aNHUv/01ndjhq5Y4brlf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdeN7wPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89365C32786;
	Fri,  7 Jun 2024 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786580;
	bh=zNWgpa9VXBHQ6K/ORcFzW8pPuEGTlF88v/NSUrhSNik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VdeN7wPhFVJvSwlBdZ3Ii2k6lMz/62HnkZ/WtRZYJ/BOhlN4cQ9vIIrYM+/Oe4V1x
	 lujLHNiAZh6v5o3lssfTzE8jfyQPHhZba2DK45xlTn12DIezO3LPaLpoYDkWSy+tnC
	 mMHgKAXqFZCLd+ekxtU7h7WKXMR/nsSzrqxG5s2F0FQ9kaTTFK1cBle4BCWACB9kfQ
	 AsReA195TueIz2iS//B/hv+h/AEy7Vy5qbpKiShl0+ljwCzo4hDPOrGHE7bQl/wsoA
	 NWljPtvsL5f0lLzFLF05wslrBXTNFUqQZK3P9L3l/FHF/BDLEfIVaKqm2ofZyITyAz
	 c+qsv0lFstzeA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b97f09cde3so315064eaf.0;
        Fri, 07 Jun 2024 11:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPb601KzUtWLAO8MsR7xj5roULXPqyOMVdEVWb0x3cfVzcca9aJtso47hibV70bCTHhMDgL0/Ldhcr9SPfGBL4I0fm2+jt8WEHxyaIajoSpHxmYf15pjVlFZaU8Ye5WnnKWtwIBZw=
X-Gm-Message-State: AOJu0Yxwy9YpMiKk+/K8noKAXgXjyBpKYF9Nu4onrw9eQVq65dvooF5k
	u7dlbdVegGwTqG2KkoalwjropVCfOwPPRVbhO1co6dvdDJU6eH9g/Nx+6K9d8L5PfrT4rPYIxkw
	qir2L6ikxtxEWqId8CYuRUftDaJg=
X-Google-Smtp-Source: AGHT+IHf4cOCql64dvD/89u9az0s0VjnGJoR8BgxX3dokipl8Ufw9hkQTdZZa0ZbAbm3o3Pz9djck2RAX5oE5Gd4mAg=
X-Received: by 2002:a4a:cb84:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5baae9ee8bamr3205096eaf.1.1717786579837; Fri, 07 Jun 2024
 11:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d999005-4441-4b8a-b159-3d0ebc2ed9d9@arm.com>
In-Reply-To: <7d999005-4441-4b8a-b159-3d0ebc2ed9d9@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 20:56:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jU4A6mdrnzXde1TEvKnVYHg2ONa5hkKy8Oiy8izKAhag@mail.gmail.com>
Message-ID: <CAJZ5v0jU4A6mdrnzXde1TEvKnVYHg2ONa5hkKy8Oiy8izKAhag@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Cleanup after loadavg removal
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:55=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> The performance impact of loadavg was removed with commit a7fe5190c03f
> ("cpuidle: menu: Remove get_loadavg() from the performance multiplier")
> With only iowait remaining the description can be simplified, remove
> also the no longer needed includes.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/menu.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index b96e3da0fedd..783b5d1dacdc 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -14,8 +14,6 @@
>  #include <linux/ktime.h>
>  #include <linux/hrtimer.h>
>  #include <linux/tick.h>
> -#include <linux/sched.h>
> -#include <linux/sched/loadavg.h>
>  #include <linux/sched/stat.h>
>  #include <linux/math64.h>
>
> @@ -95,16 +93,11 @@
>   * state, and thus the less likely a busy CPU will hit such a deep
>   * C state.
>   *
> - * Two factors are used in determing this multiplier:
> - * a value of 10 is added for each point of "per cpu load average" we ha=
ve.
> - * a value of 5 points is added for each process that is waiting for
> - * IO on this CPU.
> - * (these values are experimentally determined)
> - *
> - * The load average factor gives a longer term (few seconds) input to th=
e
> - * decision, while the iowait value gives a cpu local instantanious inpu=
t.
> - * The iowait factor may look low, but realize that this is also already
> - * represented in the system load average.
> + * Currently there is only one value determining the factor:
> + * 10 points are added for each process that is waiting for IO on this C=
PU.
> + * (This value was experimentally determined.)
> + * Utilization is no longer a factor as it was shown that it never contr=
ibuted
> + * significantly to the performance multiplier in the first place.
>   *
>   */
>
> --

Applied as 6.11 material, thanks!

