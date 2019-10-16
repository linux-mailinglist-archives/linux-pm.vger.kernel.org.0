Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509E0D9799
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbfJPQjF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 12:39:05 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43446 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406386AbfJPQjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 12:39:04 -0400
Received: by mail-pf1-f169.google.com with SMTP id a2so15052590pfo.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uj62At7arnilFOJJbl5N7a5EkMRk8gmjDj29tsswWIE=;
        b=rBya5PBO6sZHChGDQpT99l/deboFxP1XaW8i/9Ff0L5lelkWO7f2RuzRS3/wLiXWVb
         XjdRwrYeSFsiAoPnxaDseJgPW0UZlbFWO5u33OaphuTGKfM2k7rEFGs8wPKGYjYIE49h
         dORi5YyWTorA+d6D6zuQRS+tX15uEph0kH8P5A2mxeJLAIjUm3w6yQJ6yGrHKsH+OVDE
         TlP3iEvahZXKpwACmvuRDomjXkvEREPVhWSABCM+nEe2wRs+zIvkicRGDPQep9OMWLF9
         YI3u2S5W/FmHu/LpjWTcKfjs+P2CCCQ4Hqi4PYUuRYqGerDiMmRFcFHJDVsMeWEGscu6
         C3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uj62At7arnilFOJJbl5N7a5EkMRk8gmjDj29tsswWIE=;
        b=lUia1sJtw4cXwb1xrog1E+tRh8OSDxfKtsZj40RA+T/1i4bhHD9RgTuP5dbxwHpcwX
         zuoLAQJEN8/P2x28rdjEqbpmZNI+SsYya1ewFnj/4npEJN8pr6g+NsIJHQy8+egmT0FC
         PS631Rep0uSDav4FyqFFvrwtWDE64x5gxdAh0LBqVp13S73YHlal850Sh7rvO0C7ZTJ7
         fjJmavGg1sgGUS8l3UTsooROZrHcGqYmyO24MxQy6qa9w3k8BFxBiTJhMQfZL6NP0uij
         IeioJs214Yj+oDm1KFfMAyKeQtKTZj87+IewkzoNjrlIWQByyvzpqCRMwL3uPkWyeW4M
         dOFw==
X-Gm-Message-State: APjAAAV5nzwp5COAOgfaByeKEXUIDybNM6+XbJrzz2oFdnK0E0gyU1Om
        X1OpHgO5R4btWKdRXV3FjoLy+Q==
X-Google-Smtp-Source: APXvYqy7cm/gQHTfBaihNUxg/kpuNUjJHhY1iUPuIbJzt/XJ4Le3qA+lNeFhKinPwgh0xJasS1A49w==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr6266957pjs.87.1571243941981;
        Wed, 16 Oct 2019 09:39:01 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z4sm29661708pfn.45.2019.10.16.09.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:39:01 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH v7 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Date:   Wed, 16 Oct 2019 09:39:00 -0700
Message-ID: <7hwod4fxwb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Eduardo,

Guillaume La Roque <glaroque@baylibre.com> writes:

> This patchs series add support of New Amlogic temperature sensor and minimal
> thermal zone for SEI510 and ODROID-N2 boards.

[...]

> Guillaume La Roque (7):
>   dt-bindings: thermal: Add DT bindings documentation for Amlogic
>     Thermal
>   thermal: amlogic: Add thermal driver to support G12 SoCs
>   arm64: dts: amlogic: g12: add temperature sensor
>   arm64: dts: meson: g12: Add minimal thermal zone
>   arm64: dts: amlogic: g12a: add cooling properties
>   arm64: dts: amlogic: g12b: add cooling properties
>   MAINTAINERS: add entry for Amlogic Thermal driver

This has now been thorougly reviewed/tested.

I've queued all the "arm64: dts:" patches via my amlogic tree for v5.5.
Can you please queue up the driver, bindings and MAINTAINERS patch?

Thanks,

Kevin
