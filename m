Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E772A94C97
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfHSSV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 14:21:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfHSSV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 14:21:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so1628956pfn.10
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=jP/JQPgiqAwhWQodLXFsl9IKaLN+6gUU9OI6gGA5uas=;
        b=gHxmZzIyVuqmW6gvuv7zh2ZbslqcwvNtBNwHBaPPklw5C56nMIakO/vuigwOKP0dO+
         NhxDDASRUqAvrKZ52GXCqj8461rIFSCG69+jwIuvyUvfcKjWTA75lB91pT/T0owzTIo2
         bH2F6CztvO609JlSizcGnC3fhjF14lWJCQg8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=jP/JQPgiqAwhWQodLXFsl9IKaLN+6gUU9OI6gGA5uas=;
        b=DmZMgDpI5QcymYI10lN0A353S9dxlwuS//ISMqK/tKv6gOn04n1wx36OOxkYYR52MR
         CcB/n4MTCPxzzP8sKT6HKab1BTBDBFRLrhk1KcoFv9JgHzDHwQGpsGBhpv6BumCn4Ccp
         d25JDUEoBXciwACh32UdmgRT/GJJX7mokdLQ/wYNQ4GGdYys/dP9GBSqc8HsL/dpBEBs
         wfW72Hkmhl6moe73+C6/b/Ss2LWFxxQ7bpcj/1fcYLjQtBbz5juyO4P0HD+NSbVcw7Sf
         2c2GQgLB9OAs0bYnlxVmi3JQCasRwBumtrAy0rTcl6KdP74FVcEuyrsTqqVIfrVKjl+l
         5/Dg==
X-Gm-Message-State: APjAAAUZlcedxJzBdW33kS3fn0sAoVQXiV2KwBqZy5j2UAyw6C0klHEf
        dcWc39Qq92kfvDrfuhrhwfAaD7W8I5+lgw==
X-Google-Smtp-Source: APXvYqzgrtmFVvmKO/7WWQrhphfl8a0I8GR0ubDqk15rivjyHR6au16Dm+7k27bol5FZ98yJG+GIqg==
X-Received: by 2002:a63:2157:: with SMTP id s23mr21793454pgm.167.1566238915467;
        Mon, 19 Aug 2019 11:21:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm17035231pfo.15.2019.08.19.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 11:21:54 -0700 (PDT)
Message-ID: <5d5ae8c2.1c69fb81.25dd0.ca75@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819175457.231058-3-swboyd@chromium.org>
References: <20190819175457.231058-1-swboyd@chromium.org> <20190819175457.231058-3-swboyd@chromium.org>
Subject: Re: [PATCH v3 2/2] PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tri Vo <trong@android.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 11:21:54 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry, subject should be

PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()

Quoting Stephen Boyd (2019-08-19 10:54:57)
> These functions are just used by the PM core, and that isn't modular so
> these functions don't need to be exported. Drop the exports.
>=20
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Cc: Tri Vo <trong@android.com

Messed up the address here too. Should be

Cc: Tri Vo <trong@android.com>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/wakeup_stats.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> index bc5e3945f7a8..c7734914d914 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -182,7 +182,6 @@ int wakeup_source_sysfs_add(struct device *parent, st=
ruct wakeup_source *ws)
> =20
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
> =20
>  /**
>   * pm_wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs
> @@ -205,7 +204,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source =
*ws)
>  {
>         device_unregister(ws->dev);
>  }
> -EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
> =20
>  static int __init wakeup_sources_sysfs_init(void)
>  {
