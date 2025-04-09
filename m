Return-Path: <linux-pm+bounces-25028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434FAA82E21
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 20:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107791B64DC8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270251D5CFB;
	Wed,  9 Apr 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moCdWLFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065B224FD;
	Wed,  9 Apr 2025 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221708; cv=none; b=du2gXNtN+WF6e2Ws4n69Kh+d+Cqf2D4cL/mpMff6ypeF3N/pPGY90nH+GJDV3Ut3bVwV04y3DO0x+FBn9anQHgzhplME20Pp0GrknAJQqh95RRC5Lvy2Td2GDQVpKKLnEAZrwc2ZdX7J+sU4T0RNFDP/lnJqt77jIjkwsLb5rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221708; c=relaxed/simple;
	bh=OpxRysdetPZmwEfzBmXkRut/QF4t+1PGcBGiiCDSQ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yk1AhdVG/8vQhejQ/BZKEqCOPJCgx+3oIpiJw0EysoJhsyiWcKd7k7VHYSnPSG4Qal3RNM4Y5i6tFVNyHx2lKDQKQRzJye23wOybg061I3VED6t8H04csPGdp4K7aC/gEcTfj2iKAHPkSj/yNIc/hXRlZj4OhUqOlDvZgRWl+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moCdWLFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55213C4CEED;
	Wed,  9 Apr 2025 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744221707;
	bh=OpxRysdetPZmwEfzBmXkRut/QF4t+1PGcBGiiCDSQ1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=moCdWLFYdYlSeYCIlF2OU+liWzwxznAcld/bsLsBL/7Ll25fehvHRUYGojqNqD8yQ
	 cluUF25QyDccI44w0UUKAVmYkVgeSCY87BH5yDZ6O3rJJQwYbnxQO+ID15T3z411M7
	 7O8ki8x7ihg7Bvjr5bvXAT+ZLaD8gTGKKsyas6iCJGch8rVc3umCvEOOI7FNkcNCMr
	 4IVFCZd8ocWRlt1S5lO0FjYuBcTWalAulHp6NHMvlsYo8zjLu7i9CKWIaerqyVgqq5
	 SxGMlKGsQeBiNklOgT1KJY0Iu7KSgYaWfV8DqGnm9lkVjKVt3RcO598Emk1RnAeMPN
	 vGq3xTSd2IoZw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso3789490fac.0;
        Wed, 09 Apr 2025 11:01:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg1hLIaUhFPkSEXWvpRztvSa7y2zOfDqZAtbU76UlihMtAeVg38j2yCkIARbhzDQQuT9UTxWpxMHQ=@vger.kernel.org, AJvYcCV0TzFGZSsIs9XE3cshjU24HcBdmAGeUJEXte9Iqkh4wyWyU/ZyfBTohLYUQ0AnoPKVUvnnrS+3ViHbcaLe@vger.kernel.org, AJvYcCXgHyS0BO9U/y38iiFz4xqMXsNw42mmPPfZ1TXGskoydjrZZGgbkoGeUkjyG+LJbfQ2PEZaob1DpPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/5a5ExzEkVIUIxOCTtNDPI3Al4l+9QXFPErv53HD9h2uz+eZ
	37UxlRVvcW32jIftVtQteI41MhRIDW8JP/FodL5kbCwsYIXiKtHZCNw83SD8VZqlbN/0PRHVWu4
	LIfo27rP2oTwuqkvAt/DMsDZDCss=
X-Google-Smtp-Source: AGHT+IH0aSAZCZRe9OeyBsWXZdS9tQHmmLmWe2pEmHF3WD9gqr8OOF07pgYid/iw+yqovePgljplLww09TJRyB536RY=
X-Received: by 2002:a05:6871:4004:b0:2c2:71f:2c0b with SMTP id
 586e51a60fabf-2d08dd69215mr1972904fac.11.1744221706546; Wed, 09 Apr 2025
 11:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com> <20250326-cross-lock-dep-v1-9-3199e49e8652@bootlin.com>
In-Reply-To: <20250326-cross-lock-dep-v1-9-3199e49e8652@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 20:01:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAArg413ydKJUsX5Lu4AgwsK7Mmm+VQr3PrYWaG1khpg@mail.gmail.com>
X-Gm-Features: ATxdqUGNVtbdm0qtuk7B2q6-vDlh_MFtMpWp0JmavlsZKB8UQ4CQ3rixuR7MbZs
Message-ID: <CAJZ5v0gAArg413ydKJUsX5Lu4AgwsK7Mmm+VQr3PrYWaG1khpg@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] clk: Make sure clock parents and children are
 resumed when necessary
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, 
	Ian Ray <ian.ray@gehealthcare.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:26=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Any pm_runtime_get() call will both wake up the core clock as well as
> its parents. But there are some cases which also require resuming the
> children clocks. One way to do that is to use the new
> pm_runtime_get_consumers() helper.
>
> It's been identified that the following situation may require resuming
> the children:
> - getting the rate
> - setting the rate
> - changing the parent (especially since it may produce rate changes)
> - putting the clock, which may involve reparenting as well
>
> In order to fix the ABBA locking situation between clock and power
> domains, let's disimburse these two locks by resuming the children
> outside of the prepare_lock in one function call by using this new
> helper.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/clk.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 339ebfa8cca729ffb84127e01a21f741bc270cb3..26af3a134fa7b9d7f4a77ff47=
3df7e79fd465789 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -119,6 +119,20 @@ static int clk_pm_runtime_get(struct clk_core *core)
>         return pm_runtime_resume_and_get(core->dev);
>  }
>
> +static int clk_pm_runtime_get_and_consumers(struct clk_core *core)
> +{
> +       int ret;
> +
> +       if (!core || !core->rpm_enabled)
> +               return 0;
> +
> +       ret =3D pm_runtime_resume_and_get(core->dev);
> +       if (!ret)
> +               pm_runtime_get_consumers(core->dev);

So here, you also need to take children into account directly.

> +
> +       return ret;
> +}
> +
>  static int clk_pm_runtime_get_if_active(struct clk_core *core)
>  {
>         int ret;
> @@ -141,6 +155,16 @@ static void clk_pm_runtime_put(struct clk_core *core=
)
>         pm_runtime_put_sync(core->dev);
>  }
>
> +static void clk_pm_runtime_put_and_consumers(struct clk_core *core)
> +{
> +       if (!core || !core->rpm_enabled)
> +               return;
> +
> +       pm_runtime_put_consumers(core->dev);

And here too.

> +
> +       pm_runtime_put_sync(core->dev);
> +}
> +
>  /**
>   * clk_pm_runtime_get_all() - Runtime "get" all clk provider devices
>   *
> @@ -2010,10 +2034,15 @@ unsigned long clk_get_rate(struct clk *clk)
>         if (!clk)
>                 return 0;
>
> +       if (clk_pm_runtime_get_and_consumers(clk->core))
> +               return 0;
> +
>         clk_prepare_lock();
>         rate =3D clk_core_get_rate_recalc(clk->core);
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         return rate;
>  }
>  EXPORT_SYMBOL_GPL(clk_get_rate);
> @@ -2605,6 +2634,10 @@ int clk_set_rate(struct clk *clk, unsigned long ra=
te)
>         if (!clk)
>                 return 0;
>
> +       ret =3D clk_pm_runtime_get_and_consumers(clk->core);
> +       if (ret)
> +               return ret;
> +
>         /* prevent racing with updates to the clock topology */
>         clk_prepare_lock();
>
> @@ -2618,6 +2651,8 @@ int clk_set_rate(struct clk *clk, unsigned long rat=
e)
>
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate);
> @@ -2648,6 +2683,10 @@ int clk_set_rate_exclusive(struct clk *clk, unsign=
ed long rate)
>         if (!clk)
>                 return 0;
>
> +       ret =3D clk_pm_runtime_get_and_consumers(clk->core);
> +       if (ret)
> +               return ret;
> +
>         /* prevent racing with updates to the clock topology */
>         clk_prepare_lock();
>
> @@ -2665,6 +2704,8 @@ int clk_set_rate_exclusive(struct clk *clk, unsigne=
d long rate)
>
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate_exclusive);
> @@ -2755,12 +2796,18 @@ int clk_set_rate_range(struct clk *clk, unsigned =
long min, unsigned long max)
>         if (!clk)
>                 return 0;
>
> +       ret =3D clk_pm_runtime_get_and_consumers(clk->core);
> +       if (ret)
> +               return ret;
> +
>         clk_prepare_lock();
>
>         ret =3D clk_set_rate_range_nolock(clk, min, max);
>
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate_range);
> @@ -2964,6 +3011,10 @@ int clk_set_parent(struct clk *clk, struct clk *pa=
rent)
>         if (!clk)
>                 return 0;
>
> +       ret =3D clk_pm_runtime_get_and_consumers(clk->core);
> +       if (ret)
> +               return ret;
> +
>         clk_prepare_lock();
>
>         if (clk->exclusive_count)
> @@ -2977,6 +3028,8 @@ int clk_set_parent(struct clk *clk, struct clk *par=
ent)
>
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_set_parent);
> @@ -3459,10 +3512,16 @@ static int clk_rate_set(void *data, u64 val)
>         struct clk_core *core =3D data;
>         int ret;
>
> +       ret =3D clk_pm_runtime_get_and_consumers(core);
> +       if (ret)
> +               return ret;
> +
>         clk_prepare_lock();
>         ret =3D clk_core_set_rate_nolock(core, val);
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(core);
> +
>         return ret;
>  }
>
> @@ -3518,11 +3577,18 @@ DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops,=
 clk_prepare_enable_get,
>  static int clk_rate_get(void *data, u64 *val)
>  {
>         struct clk_core *core =3D data;
> +       int ret;
> +
> +       ret =3D clk_pm_runtime_get_and_consumers(core);
> +       if (ret)
> +               return ret;
>
>         clk_prepare_lock();
>         *val =3D clk_core_get_rate_recalc(core);
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(core);
> +
>         return 0;
>  }
>
> @@ -3659,12 +3725,18 @@ static ssize_t current_parent_write(struct file *=
file, const char __user *ubuf,
>         if (!parent)
>                 return -ENOENT;
>
> +       err =3D clk_pm_runtime_get_and_consumers(parent);
> +       if (err)
> +               return err;
> +
>         clk_prepare_lock();
>         err =3D clk_core_set_parent_nolock(core, parent);
>         clk_prepare_unlock();
>         if (err)
>                 return err;
>
> +       clk_pm_runtime_put_and_consumers(parent);
> +
>         return count;
>  }
>
> @@ -4762,6 +4834,9 @@ void __clk_put(struct clk *clk)
>         if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>                 return;
>
> +       if (clk_pm_runtime_get_and_consumers(clk->core))
> +               return;
> +
>         clk_prepare_lock();
>
>         /*
> @@ -4784,6 +4859,8 @@ void __clk_put(struct clk *clk)
>
>         clk_prepare_unlock();
>
> +       clk_pm_runtime_put_and_consumers(clk->core);
> +
>         owner =3D clk->core->owner;
>         kref_put(&clk->core->ref, __clk_release);
>         module_put(owner);
>
> --
> 2.48.1
>

