Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E0F827E1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHEX3I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 19:29:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45354 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHEX3I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 19:29:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so37064681plr.12
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=wiloosTmjjcp4t7af0k+zFA/+KwYN5hZVuPSy0bPbrI=;
        b=GdnnKcweqVjIAEhLjUJNZNvqAep6YhW4RCIOksr4IDGFPqFlHO2IEreaXiUu3OzvL/
         Ag7GsiKXIZ6ylTXI00xXEtujmVXoaUw1m6Ov7RMSt9CIx0vwd1vIrNfVGGH2rKhbOisy
         KwdKzXb3TioAZW2MZIzoBE0/nHalWXsEJp0D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=wiloosTmjjcp4t7af0k+zFA/+KwYN5hZVuPSy0bPbrI=;
        b=FjkPyrBUwEClam8uIizdIY7CIT5b+iWhX+DVtx52uoj4AgO0r5XyCSEhun2o0Po5EB
         /XIyeqcpi97RVdcQ+lfpJUsoOxF8AtilGWY2bLj1mvTYxAccpkjCiqun6Q3v+cUXPf0X
         vumohRbKGP2T2s6tFGH2eGsL4jg9GRqwF+cqa9bbakChO2hHEaAeptTcRMZ1VjeXmJ+B
         4pVvS6s6hdZBxjL2Q0UataytxvODGjvQyQLRL8iiaiO2tnaAfGf9vQ3LFqWClbg68Lqi
         a6Dpe4gNS592H1fMs3z19k/amPRsOCFRn49uFbw4YChhm46rGF0xSvMJ3WiBuyjj/tAv
         u7JQ==
X-Gm-Message-State: APjAAAUMUhWQEL8DilY9t29G2ZIbzrpKonFLS2pxbVXdJkVHDWG8/USX
        k3xF/ygy3zQY0sTv5yiJv+CZ2Q==
X-Google-Smtp-Source: APXvYqxdlxKuGLuRWMULvIxTV2Gvzb8gRLweOO0FZS+Ubf3PDNdl9GD7vHZB4gQibtBFBJr3/zSE6Q==
X-Received: by 2002:a17:902:b909:: with SMTP id bf9mr204057plb.309.1565047747318;
        Mon, 05 Aug 2019 16:29:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p65sm84534701pfp.58.2019.08.05.16.29.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 16:29:06 -0700 (PDT)
Message-ID: <5d48bbc2.1c69fb81.62114.5473@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-4-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-4-trong@android.com>
Subject: Re: [PATCH v7 3/3] PM / wakeup: Show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 16:29:05 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:48)
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> new file mode 100644
> index 000000000000..3a4f55028e27
> --- /dev/null
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -0,0 +1,161 @@
[...]
> +/**
> + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> + * @parent: Device given wakeup source is associated with (or NULL if vi=
rtual).
> + * @ws: Wakeup source to be added in sysfs.
> + */
> +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source =
*ws)
> +{
> +       struct device *dev;
> +
> +       dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, =
0), ws,
> +                                       wakeup_source_groups, "wakeup%d",
> +                                       ws->id);
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
> +       ws->dev =3D dev;
> +       pm_runtime_no_callbacks(ws->dev);

Does this only avoid adding runtime PM attributes?

I thought we would call device_set_pm_not_required() on the device here.
Probably requiring a bit of copy/paste from device_create_with_groups()
so that it can be set before the device is registered. Or another
version of device_create_with_groups() that does everything besides call
device_add().

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> +
