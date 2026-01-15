Return-Path: <linux-pm+bounces-40951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E08D286BF
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF9BB3008D6E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D4326949;
	Thu, 15 Jan 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZpr5nWl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435332693E
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509065; cv=none; b=a3746hDOoORG2aipFjCBlKBm00osGUDI9AlODL4ym0zAraYzlD+umRNp8Pf4HW0cBAKQo/AM7CdmMQL26poQue+f443ZHSM9MeR/HFj56P0y1eDAOcWd4Y7rjJ0BNJWKUXyOonl7ytlFuxa3M93qGGXsa1Ym4RAB8GR3NjtdrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509065; c=relaxed/simple;
	bh=1NZx+nSGZlD/KDx2WtJPg2pbocKPNvk9/9uU3LdoofI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL6qoyBqU1DzNTWShPLiBDmohYUPSjCkvCe5cFZmNzeGwi2hHpcLU9S2A4cO2QpIfd3PSgLqtMHTMCyxoQBjmMrDoc2PTJyxhLCaeG9ZVw5xWSc5OixEUy/d/wHqwdWyUtn3kAjOR19z7SMYUp/YBE+ywI/owg3iilyRJqHv8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZpr5nWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1EEC116D0
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768509064;
	bh=1NZx+nSGZlD/KDx2WtJPg2pbocKPNvk9/9uU3LdoofI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TZpr5nWlwyt/cx2rlA+d1RqbMtSeg9e+hBxaNQGEn3Fa9CoM0AdKwyr3NvwNWBIRS
	 kz5oE4l7gWtlqB55uK5kvCjM5IWw727OjGI3gLTiYtH+omGnAv+yFh4YFfEoXw1oHO
	 2hdZEGyCj93dC28GI7veE/tTOSjFlNlFlm/LnPfANjGcZMjzmcV7VL5ZMIkhbY7TGB
	 BEZBbFB8PdnDStjvZRgzqNYkMJPNhC513cJTeoXcIS5D+jQZ5i6mwOzv6dqNw39rdg
	 D/xie8kc3SsiVh4LWesxfvvWyIq3m8ow8id2pISKP7jkef5Z46LlbkzQNpKkoDGx7m
	 hUeSDgRiZl0lQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7cfd6f321b5so671214a34.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5H0bsKouFd+n3IZ9JYzhlSNdgZuwZ3pa+B9f++jn/tsINrEIL1H63kxjacZeOKJ+VlnsU2swROw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgc8RVkw0x+b58MrexdP+g+o20Lo0oZPEs5cSakzvhtg1LFh1
	3EBB4NY6F0dS9pv5FtpqFVpTbJoZ+PHnkQGPswjw087BhZPfWFAXyV3FjOqjiVwlaO1H8d/GvIK
	/pbxnXgJLrcXKZ8vuPQUK1CVJGDjNjoU=
X-Received: by 2002:a4a:ec4a:0:b0:660:fe2d:312e with SMTP id
 006d021491bc7-661179e4631mr392870eaf.51.1768509063664; Thu, 15 Jan 2026
 12:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115103700.177997-1-mrout@redhat.com>
In-Reply-To: <20260115103700.177997-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:30:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iB2fqiab2Uj7Et_+qztx208cFKHuS7e_Y9ATmgr09jyw@mail.gmail.com>
X-Gm-Features: AZwV_QhHN2UYfnJyUC_8NBfo3t-PKYAJTD9ZvuHxAMdOL1YorHlPW0OG6Lamqyk
Message-ID: <CAJZ5v0iB2fqiab2Uj7Et_+qztx208cFKHuS7e_Y9ATmgr09jyw@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix NULL pointer dereference in em_create_pd()
To: Malaya Kumar Rout <mrout@redhat.com>, lukasz.luba@arm.com
Cc: malayarout91@gmail.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:37=E2=80=AFAM Malaya Kumar Rout <mrout@redhat.co=
m> wrote:
>
> The get_cpu_device() function can return NULL if the CPU device is
> not registered. However, the code in em_create_pd() dereferences the
> returned pointer without checking for NULL, which can lead to a kernel
> panic during energy model initialization.
>
> Add a NULL check before dereferencing cpu_dev. If get_cpu_device()
> returns NULL, return -ENODEV and properly clean up allocated resources
> through the existing error path.
>
> This issue was found by code inspection. The same function is correctly
> handled with NULL checking in em_cpu_get() at line 555-557.
>
> Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in=
 Energy Model")
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  kernel/power/energy_model.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 11af9f64aa82..3971743d7e67 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -466,6 +466,10 @@ static int em_create_pd(struct device *dev, int nr_s=
tates,
>         if (_is_cpu_device(dev))
>                 for_each_cpu(cpu, cpus) {
>                         cpu_dev =3D get_cpu_device(cpu);
> +                       if (!cpu_dev) {
> +                               ret =3D -ENODEV;
> +                               goto free_pd_table;

No, you need to clear em_pd for the CPUs for which it has been set already.

Maybe it would be better to do this check upfront for all CPUs in the
mask.  Lukasz?

> +                       }
>                         cpu_dev->em_pd =3D pd;
>                 }
>
> --

