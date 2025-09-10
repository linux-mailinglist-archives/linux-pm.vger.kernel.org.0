Return-Path: <linux-pm+bounces-34358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0418EB51634
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 13:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2856C1C27BF5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21530F554;
	Wed, 10 Sep 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqiA+Gmq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8C28641D;
	Wed, 10 Sep 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505417; cv=none; b=ugRwe+NaUSUObH8j4h5THLz2af/+uAOAquRnfFbubzSBZcxcdsVOFYCWcl5qmFSAlLtCa4RsaaP0W3rg7QkrDl1tqsOWumJJowLbJx78FYO5HuvKaMq9peXCsxq7M0JJ279ifd2PdaCChbhK+RtFrf05dRJUCaT+GtoOH16eEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505417; c=relaxed/simple;
	bh=9ymga6d+xv8j2APww0Z/VEc6qtPLFWr7mQjdN8gX8RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4lZH8VA2OxsL9+ovSS26T2aT2GHMIO7jt8otRTix2g3gUUa7ximj9Q/SkY7iX+uVf4GgsXEJ8mIwUnJp+vMnurMsiykZWLOYwLXwfc6YCJW0B9AjCKtDH5guFkwJl34HZYncZ148EjWV04ji8e1JjJFL/+hdbOYrYdvXWF8b7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqiA+Gmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E04C4CEFA;
	Wed, 10 Sep 2025 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757505416;
	bh=9ymga6d+xv8j2APww0Z/VEc6qtPLFWr7mQjdN8gX8RM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YqiA+GmqqhYgg0itian0rbYsCFVPGM9Egu0JUmUqX093g1cVrdsg7s8kTUiBm7Qlu
	 grOO6lNJ3YlDyfajdDdYCfx6pkrTecHGyHU/c6J7qW0PaZ/5sE+j4UoL4YOAR4oFlr
	 92o8tpLBgz1IjiAKyjQ0WEEBqUbBOzXnAwppQaL2BOzHQd4BfINfZLckG2KeE1jZKe
	 8WJvRrmnwc5drlTICVo3H2q88Ujd24eUMyHYVn1Weyedms++nxfjlf3KMAcCjDwVsF
	 Jq8W22o1iUnU6MRIlgkQ+rBz/GUFJr+jTzJ0AdR5vni7Mi1YGVBq01WwNJaUFuwVuG
	 2XJsx9c8w9zKQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61ff7638f4eso2171407eaf.2;
        Wed, 10 Sep 2025 04:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXpiJEbD9zHIQp1KHw/XCF4miNg/TnlppabYOjAwn381/uJVpircMPuIJa7vxYOf7UHZcRmO7TGcc=@vger.kernel.org, AJvYcCWPh1wLMRfPXDB7hk7Y69WRUTb02rXiKZJMMj7kWCfEqMHJR5rCbkpnMVcAR/o34eBmFE7rwLEpV57f/Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBPYsDhlTWpBGeUcUvrwSES6011HgA6616wL1SQXMn9mFO/HC
	KLtIx2tSx+vhvUmJe26jdzgQ3Gr5ELw9yv+46VbfUgLFFHVw9lcumptdkj0o+PBIEDiJcdwCe0o
	doxgqN6PNPyxs0TZRbAw+IP76TPZ4FDE=
X-Google-Smtp-Source: AGHT+IEPM1a3/h0NZNKINJv3q89lj3PFZw+5DYNu3Jjh/KH0qG/1navRKm57c2tZ4rOPudorQm2yrVrFBAuExP2dVZ4=
X-Received: by 2002:a05:6820:509:b0:621:7820:a28 with SMTP id
 006d021491bc7-62178aa41fdmr6304612eaf.8.1757505415725; Wed, 10 Sep 2025
 04:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909094335.1097103-1-treapking@chromium.org>
In-Reply-To: <20250909094335.1097103-1-treapking@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 13:56:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNytfP8W2XSyBNLe8OsD=O9M7WWvhtxdwXA-5KxwKfbg@mail.gmail.com>
X-Gm-Features: Ac12FXwIdkUAXuV0Z_RMIKC4_3hVl_Mzmpc41M487V2P5XFC8LuYAr1_yA-4Te4
Message-ID: <CAJZ5v0jNytfP8W2XSyBNLe8OsD=O9M7WWvhtxdwXA-5KxwKfbg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Don't wait for SYNC_STATE_ONLY device links
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:44=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> and resume, and functions like device_reorder_to_tail() and
> device_link_add() doesn't try to reorder the consumers with such flag.
>
> However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> check this flag before triggering dpm_wait, leading to potential hang
> during suspend/resume.

Have you seen this happen or is it just a theory?

> Add DL_FLAG_SYNC_STATE_ONLY in dpm_wait_for_consumers() and
> dpm_wait_for_suppliers() to fix this.

The above sentence is incomplete AFAICS.

> Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STAT=
E_ONLY flag")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/base/power/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 2ea6e05e6ec90..3271f4af2cb65 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev=
, bool async)
>          * walking.
>          */
>         list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_nod=
e)
> -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))

This should use a check like device_link_flag_is_sync_state_only(),
which is different from the above one, for consistency with
device_reorder_to_tail().

>                         dpm_wait(link->supplier, async);
>
>         device_links_read_unlock(idx);
> @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev=
, bool async)
>          * unregistration).
>          */
>         list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_nod=
e)
> -               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT &&
> +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))

And same here.

>                         dpm_wait(link->consumer, async);
>
>         device_links_read_unlock(idx);
> --

