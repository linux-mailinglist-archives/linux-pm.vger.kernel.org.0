Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8317D065
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfGaV7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:59:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42966 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfGaV7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:59:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so32597783pff.9
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=IlRwSSoXPkPO8ZlfGQyrA2PVh0oI2jbeG8M+xqYWNuc=;
        b=n3A6uLscWmFreF939tyOlPubPIYDf44Y3GSbMd5VGwmGbOLz9PMLsYyy6hnO/F5hv7
         HRy2Eq8dQckDsTk18S0fC9yE3YBQk2EeHDpNnOb5HFGvC/FFwabnJ4NyZjZOxhGFbpDJ
         KsRbZRE0bAvaZy7+ZMWdBaHcQQyv7phuAIuXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=IlRwSSoXPkPO8ZlfGQyrA2PVh0oI2jbeG8M+xqYWNuc=;
        b=r51TulvPmuLyvVEMTeCqsT46V8n68eCaT+LbirMHx0vJZYyhxUfE/lPr5wsHRhy2uT
         uQSN8Bs6UXzFUrp/zFib/vfM3Pa8sD6ZE4PrInsD/0Kb7JbnCeEARHB7tSwOTGKElRMW
         McI1jafC3+QgM1OXSFWvnhC3+y/vVdUoHQ9gauolrfm9NPsJTq5J3s3PmDCV0kUkNuem
         q1hveGDuwLHY2lgnO6r+lYhk1vUxMme/xTaS5XZ1WMopTucq9NYkcDcrya19YXlUlzTy
         8fQjUeYcctLnj3hysBtNZ9UZBnt6L+IO/V5abJcXATxey62GDVbMe/Ef5DqUMZD0/8Sq
         TI0A==
X-Gm-Message-State: APjAAAU+l7XMiN03uW4Zc3BtaqEdbET+XOQODLZ1ijvGeoYg7GS8ZOrQ
        S7wUXjy7SGdIsliFJBmbxgy9Gw==
X-Google-Smtp-Source: APXvYqxRyvbUZhJsewElOw/jGc81nEj+n2gFMTff3FnLVzjQbJ+uJcjTMouUatne6W5Kncq5F9kkXQ==
X-Received: by 2002:a63:184b:: with SMTP id 11mr55358650pgy.112.1564610374310;
        Wed, 31 Jul 2019 14:59:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i14sm108093300pfk.0.2019.07.31.14.59.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 14:59:33 -0700 (PDT)
Message-ID: <5d420f45.1c69fb81.35877.3d86@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731215514.212215-1-trong@android.com>
References: <20190731215514.212215-1-trong@android.com>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 14:59:32 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-07-31 14:55:14)
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
> +       int id;
> +
> +       id =3D ida_alloc(&wakeup_ida, GFP_KERNEL);
> +       if (id < 0)
> +               return id;
> +       ws->id =3D id;
> +
> +       dev =3D device_create_with_groups(wakeup_class, parent, MKDEV(0, =
0), ws,
> +                                       wakeup_source_groups, "ws%d",

I thought the name was going to still be 'wakeupN'?

> +                                       ws->id);
> +       if (IS_ERR(dev)) {
> +               ida_free(&wakeup_ida, ws->id);
> +               return PTR_ERR(dev);
> +       }
> +
> +       ws->dev =3D dev;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> +
> +/**
> + * wakeup_source_sysfs_remove - Remove wakeup_source attributes from sys=
fs.
> + * @ws: Wakeup source to be removed from sysfs.
> + */
> +void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> +{
> +       device_unregister(ws->dev);
> +       ida_simple_remove(&wakeup_ida, ws->id);

Should be ida_free()?

> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
> +
> +static int __init wakeup_sources_sysfs_init(void)
> +{
> +       wakeup_class =3D class_create(THIS_MODULE, "wakeup");
> +
> +       return PTR_ERR_OR_ZERO(wakeup_class);
> +}
> +
> +postcore_initcall(wakeup_sources_sysfs_init);

Style nitpick: Stick the initcall to the function it calls by dropping
the extra newline between them.

