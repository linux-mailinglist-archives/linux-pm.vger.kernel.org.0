Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260052B09C1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKLQVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 11:21:22 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:32903 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgKLQVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 11:21:21 -0500
Received: by mail-ej1-f67.google.com with SMTP id 7so8687281ejm.0;
        Thu, 12 Nov 2020 08:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/FN38YKs3U5dDP8XDvk7Aai2br8IWt2qA1Mn0hfMr0=;
        b=ppd0/57F/cZ4O1sTiM7kjbdBg7vtkQYnLBRGCXOEB4b4Usp/QyOqMiMqRrJLyuwYlh
         8f4DUZ6n2BYkyYm3fhaKwMZHEjefcdkf77g81Pt1g+Eo34IS19oz7G7sRmCnzG25Cm1Q
         dTg5UgQIImf45dP1i2owyyNo6hiDfTvl0CVIDslrNvuJWd0aIgCv/3NUwEk0gHL68j+H
         al3uMpYunB37j7STrW7PLwpyACcw3UgOA2/HEg0TUAlNaAJS/Z1bP+9TV73r4+LIzUka
         0PlgA+3eIels19yB0T4xfzdu7X4dDGvcCSKbtGgRHdVOaXxm/6Xltq83nlGUCv3mNk/4
         tD8w==
X-Gm-Message-State: AOAM533j9OCKKU9rJghj9vZHUm15vQOpiFE3Mrhm3cCxf491cFcCDxZr
        cg4x/YXYAE51IZC3dp/7V4XBzAhgYrk=
X-Google-Smtp-Source: ABdhPJxX91+qenOnJf5yqNQqr2xjxcTergOwox0iZEA+wSbh8d9LZ1oTeCAMEjZCvrUmWRVch4OZ+A==
X-Received: by 2002:a17:906:158e:: with SMTP id k14mr32003ejd.496.1605198078122;
        Thu, 12 Nov 2020 08:21:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p26sm800026eja.13.2020.11.12.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:21:16 -0800 (PST)
Date:   Thu, 12 Nov 2020 17:21:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        inki.dae@samsung.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/5] MAINTAINERS: Add entry for Samsung interconnect
 drivers
Message-ID: <20201112162114.GA75637@kozik-lap>
References: <20201112140931.31139-1-s.nawrocki@samsung.com>
 <CGME20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f@eucas1p1.samsung.com>
 <20201112140931.31139-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112140931.31139-4-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 12, 2020 at 03:09:29PM +0100, Sylwester Nawrocki wrote:
> Add maintainers entry for the Samsung SoC interconnect drivers, this
> currently includes the Exynos generic interconnect driver.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v9:
>  - add linux-samsung-soc ML,
>  - fixed Artur's last name spelling,
>  - whole entry moved to maintain alphabetical order,
>  - added missing traling '/' to directory path.
> 
> Changes since v7:
>  - new patch.
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
