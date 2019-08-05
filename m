Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4337C82665
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfHEUyH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 16:54:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46113 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 16:54:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so17100036pfa.13
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=mOizxR/PNtnId+Sb+BWdRBtxpS3vclA2BEij6kTKhc8=;
        b=HhydXBbYUhnBCrtlHADL9265gD54RNeu8sSkPjhfmPHVn4fodfnXsJk0WLfGIKhXW0
         Xrk1mTEuqhM3krsxGA0FYu1Z0vilr383CdKoLuysJ82fAGxtJS2PTjyi9gL3KZ49Jv0Y
         ko9dloW7a/1csTI3JP2+Q7FlL3LARcyEnHqeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=mOizxR/PNtnId+Sb+BWdRBtxpS3vclA2BEij6kTKhc8=;
        b=F/mL8s42ONryZ8UmXIVZd5ShV34eTtaPtw3EQkyiW9oJ7zxGkxfUobqQT06CGAnaQ6
         h9msNH0M8aXmu2muzOrZxFhycKjubDEw6yGKpUvyWYzdOlOHZUMdHonFpDib8Y7x8BnY
         zYlsOT7fufl5fx1n9pwanwQzTDimqiQeD7BrCm8bNwALle+GXASsbrPGUZRMNSped7nS
         QNM1BUBKwV2dtjY6BGz7kcxRqUH9Wz1ErEGa7M/kFWd14UaGnOkZsfjHSxgT/D8cpw6F
         uH8d5yrLcvPL6a5BnzWCCdLg6To1l5RqpDxrjop7+p4ev/l0pg3kt+p6o6uJn0Q1iOVr
         i1yQ==
X-Gm-Message-State: APjAAAW40y2hK8fy1IGPaO7Bo9PMw2OK2Ufjp0bseMWLXIBw7QlqueAy
        aFstcGwQdqqZISnyEeNeer/3oA==
X-Google-Smtp-Source: APXvYqwTw5wwVacOL1oiThIgpQZ52CQCplagGiGwIjc3KW33ijXkRyTky5lafmhul/JFfor/u/XWJw==
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr19007172pjt.82.1565038446918;
        Mon, 05 Aug 2019 13:54:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g2sm136518281pfq.88.2019.08.05.13.54.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 13:54:06 -0700 (PDT)
Message-ID: <5d48976e.1c69fb81.a6781.3565@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-2-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-2-trong@android.com>
Subject: Re: [PATCH v7 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 13:54:05 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:46)
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ee31d4f8d856..3938892c8903 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -72,23 +72,6 @@ static struct wakeup_source deleted_ws =3D {
>         .lock =3D  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
>  };
> =20
> -/**
> - * wakeup_source_prepare - Prepare a new wakeup source for initializatio=
n.
> - * @ws: Wakeup source to prepare.
> - * @name: Pointer to the name of the new wakeup source.
> - *
> - * Callers must ensure that the @name string won't be freed when @ws is =
still in
> - * use.
> - */
> -void wakeup_source_prepare(struct wakeup_source *ws, const char *name)
> -{
> -       if (ws) {
> -               memset(ws, 0, sizeof(*ws));
> -               ws->name =3D name;
> -       }
> -}
> -EXPORT_SYMBOL_GPL(wakeup_source_prepare);
> -
>  /**
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
> @@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
>  struct wakeup_source *wakeup_source_create(const char *name)
>  {
>         struct wakeup_source *ws;
> +       const char *ws_name;
> =20
> -       ws =3D kmalloc(sizeof(*ws), GFP_KERNEL);
> +       ws =3D kzalloc(sizeof(*ws), GFP_KERNEL);
>         if (!ws)
> -               return NULL;
> +               goto err_ws;
> +
> +       ws_name =3D kstrdup_const(name, GFP_KERNEL);
> +       if (!ws_name)

Does this intentionally change this function to return an error if
'name' is NULL? Before, wakeup_source_prepare() would just assign
ws->name to NULL, but now it errors out. I don't see how it's good or
useful to allow NULL for the wakeup source name, but it is what it is.

> +               goto err_name;
> +       ws->name =3D ws_name;
> =20
> -       wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) =
: NULL);
>         return ws;
> +
> +err_name:
> +       kfree(ws);
> +err_ws:
> +       return NULL;
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_create);
> =20
