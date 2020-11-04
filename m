Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A602A645C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgKDMbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 07:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbgKDMbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:31:12 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2570C0613D3;
        Wed,  4 Nov 2020 04:31:00 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id h6so26889466lfj.3;
        Wed, 04 Nov 2020 04:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cew1soZk1XASupH7dwq/caRetrJ0uHAR8HCptDadf8c=;
        b=LfXyVPEtfpXgR9J8wIk46ktN1WAZkahCjkFy/LG/o0YvZ/Fsx/J9vYbjn16MkHgySX
         3A5RRt4Ow8GFmpg8GWYEp6UrN/GejIBDSrk3zJp/pwM5JW+ArHCAHYNdPuR49PH1Titw
         ZHJNKQPVm7BzWibq/9gWRE1YVsRWQK6QQ6XGBS0w4Qtpjlb7dt87/mHP9+Y203TyOenL
         jy9iU/GWLzPSbilKNrn5jmHD8+ete6KepeV5w4WHiccvztwX56dMHlPLYxWTkeAyYy+5
         F5VFvXOWcDiP5reKtT7TGQNFqBnGeIVTPgVZa323x1swgU6t7xdKVrN/Hf9VXs8gmc7+
         3SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cew1soZk1XASupH7dwq/caRetrJ0uHAR8HCptDadf8c=;
        b=FZoiTN7mkEhSX+0tp7UFeIJLwqY/FUt+35Cs/sgpm957arnsWcdjRCspzUX437gQR6
         s7Mtwb7wAHoGinnqauEhubvWKUtljm84q954Wf1ZzA0szJC4VCeGbXc/b/f0EYukklmm
         lDCBflv2UE0RM93AswouUf5aqRr4fHeLfVgxJPTMc+5Anu9fCSgte+HSb7iBZSGumQmc
         Cl8Dk15EFNd5pSHzNWtArkLszaCcZIVsIUfNcK0bDk94JUSGdzTJXKJTvWQHWm0fywd+
         vaJcrlzc6XDyw+1TZNLReUOfafIzx1htv+BNbQbwgdBrpDEMTFOIS50+Goa0WM8c5M5T
         SHxQ==
X-Gm-Message-State: AOAM530OD7b8UuYqQETRMnM6nyiST2VFa43hKgyUZrNUnz5mOVBJEy9v
        tUZWo5UIr/jHt18lGoRotVEQWg0QlUo4rHXjoNs=
X-Google-Smtp-Source: ABdhPJwbljLbmGINjYP5ZDhTsTHpKQFVgmLi8i6cP+h39Jj5QK/knuA2x4caVeXMBNMC4GrHkatQvIY7ixI5O221vWQ=
X-Received: by 2002:ac2:5614:: with SMTP id v20mr3175684lfd.542.1604493059295;
 Wed, 04 Nov 2020 04:30:59 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5@eucas1p1.samsung.com>
 <20201104103657.18007-1-s.nawrocki@samsung.com> <20201104103657.18007-4-s.nawrocki@samsung.com>
In-Reply-To: <20201104103657.18007-4-s.nawrocki@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 4 Nov 2020 21:30:22 +0900
Message-ID: <CAGTfZH1DpHZpXYZfLcXgQ4Kig2t_0ftqWSLfoCZHGJzQm40gdg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] MAINTAINERS: Add entry for Samsung interconnect drivers
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Wed, Nov 4, 2020 at 7:37 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Add maintainers entry for the Samsung interconnect drivers, this currentl=
y
> includes Exynos SoC generic interconnect driver.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v7:
>  - new patch.
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b..4bbafef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9156,6 +9156,13 @@ F:       include/dt-bindings/interconnect/
>  F:     include/linux/interconnect-provider.h
>  F:     include/linux/interconnect.h
>
> +SAMSUNG INTERCONNECT DRIVERS
> +M:     Sylwester Nawrocki <s.nawrocki@samsung.com>
> +M:     Artur Swigo=C5=84 <a.swigon@samsung.com>
> +L:     linux-pm@vger.kernel.org
> +S:     Supported
> +F:     drivers/interconnect/samsung
> +
>  INVENSENSE ICM-426xx IMU DRIVER
>  M:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>  L:     linux-iio@vger.kernel.org
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
