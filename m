Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911151785B5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgCCWhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 17:37:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34616 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWhU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 17:37:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id g6so83863oiy.1;
        Tue, 03 Mar 2020 14:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gv3fyBKvtyX+tFFlzrOXFcsjJxt1T00icp5fgfMvZ8=;
        b=oOfaQWgFCYaEFjIHZApWe2OSwRILLszc+u9Dbj6U1UC16VQ0ilatiPVZBOKkYwGzaB
         ROKNtAyhxhaNKbvhlPHqvGREysbnPpJVCcT39cTUufzI19TbcPP28iWz5TxyWMm8d9zM
         kJqV9bb5fANx5pTtrDeMYBY29ojjI998GsfOJWW47StCm7gEqnk45Y4zG5xQWYy5dLE0
         9ebX/9ccYKOxHNb5SvpGKLq64ZwMwHJ5gf3rZyg0OqjAiOhr39p4l5lLCdxMcjc9nkSI
         kv0dgJjG5jRlZyCtPWgXo1w7vqVxUG9JCcg/h6dAXIzjDUjMGa3vw/ZsxJy/rG7p7JKa
         JgEw==
X-Gm-Message-State: ANhLgQ0IQBhDGvLooqHspKZbsb314fA/rRD4EXj+q9C6pqvVbj0vL4W4
        spgaIDqsCHWwf/3u83oZzzwZ2hkvEI7aLTgxYIA=
X-Google-Smtp-Source: ADFU+vvpJF9FJZ0owkmiybjBXeW5H8spDqYBqmB6x8i0lxHazt7jMMW7Zcwju3ecqXf8Zbzf7H0hTR7QdHl10ZW3clg=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr566616oif.57.1583275038372;
 Tue, 03 Mar 2020 14:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20200226015813.987-1-cai@lca.pw>
In-Reply-To: <20200226015813.987-1-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 23:37:07 +0100
Message-ID: <CAJZ5v0gnirM5ZEQNUHTz9-_0y4Dx5_aZDzHuHchOw-iViin+ZA@mail.gmail.com>
Subject: Re: [PATCH -next v2] power/qos: annotate data races in pm_qos_*_value
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marco Elver <elver@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 26, 2020 at 2:58 AM Qian Cai <cai@lca.pw> wrote:
>
> The target_value field in struct pm_qos_constraints is used for lockless
> access to the effective constraint value of a given QoS list, so the
> readers of it cannot expect it to always reflect the most recent
> effective constraint value.  However, they can and do expect it to be
> equal to a valid effective constraint value computed at a certain time
> in the past (event though it may not be the most recent one), so add
> READ|WRITE_ONCE() annotations around the target_value accesses to
> prevent the compiler from possibly causing that expectation to be unmet
> by generating code in an exceptionally convoluted way.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: borrow the commit log from Rafael.
>
>  kernel/power/qos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 32927682bcc4..db0bed2cae26 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -52,7 +52,7 @@ static DEFINE_SPINLOCK(pm_qos_lock);
>   */
>  s32 pm_qos_read_value(struct pm_qos_constraints *c)
>  {
> -       return c->target_value;
> +       return READ_ONCE(c->target_value);
>  }
>
>  static int pm_qos_get_value(struct pm_qos_constraints *c)
> @@ -75,7 +75,7 @@ static int pm_qos_get_value(struct pm_qos_constraints *c)
>
>  static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
>  {
> -       c->target_value = value;
> +       WRITE_ONCE(c->target_value, value);
>  }
>
>  /**
> --

Applied as 5.7 material, thanks!
