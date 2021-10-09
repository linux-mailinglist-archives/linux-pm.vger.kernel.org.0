Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2788B4279D2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhJIL57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhJIL56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:57:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F3C061570;
        Sat,  9 Oct 2021 04:56:02 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s17so8618856ioa.13;
        Sat, 09 Oct 2021 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=lf0J2x7cTW0V681xpgg+rg8P9M4v9XHUGE8oX+4G+6VamTNNYgqWDxw1Q/+d7b+AfO
         lHGZEdxk4DZI/+gCVnuUddsvxv4jQILk8aL9TcP00zQqaXwQZRjU1Jc9pMNBXuY15rhS
         ayRZCAumwL9XqHAGqkQhRq5OXoCmkvRP8X1XHPvpKvNfAFOXEHAmsahqgOHwLH42Qecw
         JumiPUdJbhiD2WNjUOP9cj7JuuGeX87d2ySVUVu27nUD24Uv1xn/P7VO6zEhhHjKHvuO
         8yVIdCgMECQXNi3dMNP342ZS32EH6A2EszcLTXtEIosV4Wb9zdV+r5Og7+6cadg2znwX
         ovrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=dZnGf2qwE0U2yuGL8FC/8qWMkqO4ekpUUPG339INNr27J8EQUI8eYFDjcWOOi+vAf+
         V0EQEM10JrzaIHa7eFcVJETbwBxz7pU70vLYG4dEBR6nTsEfVwz/E5K8/jEY34Gr/Wuf
         mBQf9Gsmoa8DGpog9BClj2UVI8PUexhazFO16Yw1OtskQsUfyyNkJwiumkxDR9RVPax3
         v4oMsrbQBo8LbxSmRQeGt+1U8jnuzPxtkR5cxkFtGcvp2gEfYAPr+2HY/hRZURZixS5R
         k4YgJLFc8M3/vGOJUiH+yWBsAPhq6QCvwtDFJUcKJFdYmc4TClfLWRZEpXozQ1odCYCz
         uFsw==
X-Gm-Message-State: AOAM531pPnKPAm/zWrvHVDvJvwaW1Aa03RG8aRhBX7guYsFaK23K2gdP
        ugLq/AEwHrqQKIYlYpGKDNniSpiZhRWFh3mJCng=
X-Google-Smtp-Source: ABdhPJzuxuEDEz7txpTLGoHI/LOWbtAev5KmP1m23NGfeBFzi3m5QJyaCH0g71DVhbJSbK5HiUOB48H8hXaOgdJNw9A=
X-Received: by 2002:a5e:a501:: with SMTP id 1mr11144744iog.187.1633780561458;
 Sat, 09 Oct 2021 04:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211009115031.18392-1-alistair@alistair23.me> <20211009115031.18392-4-alistair@alistair23.me>
In-Reply-To: <20211009115031.18392-4-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 9 Oct 2021 21:55:35 +1000
Message-ID: <CAKmqyKOOF4coGbqk8T4G9CdxTYsuopwOnqgLEJs-WggjtOrVgQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] capsules: symmetric_encryption/aes: Reduce code size
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, amitk@kernel.org,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 9, 2021 at 9:51 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sorry, I wrongly copied this patch. Just ignore this patch

Alistair
