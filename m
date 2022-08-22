Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C659BC1F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiHVI7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiHVI7l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 04:59:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306BB2AE07
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 01:59:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so19753999ejc.10
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EZfKgE77YBTzBrupqzxE99IS/mXEEB8u38VtqqxvpYU=;
        b=pWAdDAbmSSjN7EWLV0Wq6GgxXC4meMMCTap4c9GEg0BLOt1hc6S2nxO7v8FdCowPfm
         NoCmDL60c4lW3Ze2HvsN8YRdg/x4iIJ1U+ALmJ6JBiOg+H3YhOUkIOwJv7LpGCvHuJO7
         VAfTeI/PAPG+IuX4jC+Pucc9jy5sN4B/6eQRaXZdm6hdYdMJnnYurvrEtqLEmt1llz9O
         huccbOHTlY5zS20nb5yKOGFEaUeTY+z1wZYS7Vo4gHJlZ5/gxJKcoK4QSc0RqCZWV6Tp
         +Gzl3FGvqV87oU0cBeULjosGkleY2Sv3WdSMpr3SgDTWYHiDiNpuX3voyENeTd8V1TiF
         5X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EZfKgE77YBTzBrupqzxE99IS/mXEEB8u38VtqqxvpYU=;
        b=wmGjvey/k39yOMhoX2xVVFpMVPavPzVdBPW2fZzSp0+xhgZeSLugc17U8Mhxtocbi/
         D7mGQjPSHmbfbUbzgxNYoQETXZh64Htamxcs4aWYZDXfvxujU8goY5xqDiuZfffoYTE/
         BFjlEin08DmGZGdUmDRfZsDkrevoGfz1KpwPJiDnLkPnT4JwnYOrf6hQUfNIC6zhNk/D
         nHfbDtuCmXnxIOB5MHJ5gdm3uVjCugHxYBN5901KhVSxeuzHtoWpPjXuYohSWB7E9OII
         6HJvBxmDYc9jT+4MZpolzkSB1yYxsyrMrMgIdxchMoAeDsIGCE9kG5tfEqt+ecUF/oMG
         tWxA==
X-Gm-Message-State: ACgBeo2BxVDqRtKv0nfsRUhPPYke1gSVaj8UYg9yYFhoXc8J3cXLYhCY
        p903DjZlXjBUpTuefTjkB5joJ9Gx1/2RgAYWUQLFsQ==
X-Google-Smtp-Source: AA6agR4JLflnKxIkBPaAD/b7sEnFMlkJhMHmjlK/Hy8EucLdPVvfeQTFnxvpLF4Bvn3j9E0BUqPY4+/tv2ihaL9RDOs=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr12505355ejs.190.1661158777492; Mon, 22
 Aug 2022 01:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220807192038.1039771-1-jic23@kernel.org> <20220807192038.1039771-6-jic23@kernel.org>
In-Reply-To: <20220807192038.1039771-6-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2022 10:59:26 +0200
Message-ID: <CACRpkdbvEPxhvLRQXxqViPZ+O1Szwp7voU7bhA8r0=h55pmYcQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 7, 2022 at 9:10 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> As these exports are only relevant to core module and users in the
> bus specific modules, move them out of the main kernel namespace.
>
> Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that
> brings by allowing the compiler to remove unused struct dev_pm_ops
> and callbacks without needing explicit __maybe_unused markings.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
