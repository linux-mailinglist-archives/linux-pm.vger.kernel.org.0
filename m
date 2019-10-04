Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61272CBC49
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfJDNwe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 09:52:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37711 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388806AbfJDNwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 09:52:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so6376670wro.4
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/NvVmuNoOB0cI3exs6clZvUlSAX7Buc7zqODPiW83oc=;
        b=BAWysBsPte1eDOFAueq6l7aDz/lo8WQ4I00OCGcelbXMKdAaHfz7FnmV8vaWJUtuJl
         XYSYy9P8BXBhxyBRaFO/SZb6sUBrhWoxzVUhi1BnayfEt6xfB1E5Syt3KiiCXlNIGXav
         5+xHo8reipGBqmVqZxoa2DV2l3RZ1j6EblIJkMIDZ1ZB4htJ3izRSLbDYNSGJZOzj17V
         Zcohv/yAKl9kPLc0stlmTD/HEXtMccfj5kHhf2ckYTm4pZ3pE2WiR7NYgy6LLP3LtgWU
         U4Lh1s3ay5tdxqXImbzaKSLyVkITdDOpt7NFl+N7jVXt3t+/EMW4I3u5+veWBLx/x9wj
         SNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/NvVmuNoOB0cI3exs6clZvUlSAX7Buc7zqODPiW83oc=;
        b=do1a0l+qfGLO8NPpjorJk6YU5JCY44UuwSKLzp9kVxGGnU6Q6z9B1Ya1p6ZGTZZoIA
         ezySNHQstRs7cZiUK6fHXG6iwUGQFBwDvm14z1ADvhjOUZYsQASRFS8fAjD/zvVRDYaP
         DwqTaGBNVaHs1sq7KohINjQQ7Log6idg/EIY0LBG9xjRw0+mg3YWJw4rMjELqfbttNLW
         ahdCHRxk+OfwaQoi4zs4HQCN/rdS48PAtPd1udoXh0lCP/ZhcT1nM6LRUggSBQh6AkVc
         ZpjIU6SWdSwXhIJDcbY5QnxO3QXVwTx9IcpM/YMh40jTfUg2X9kn4ZnIQIrdAs8JVsaJ
         ZCuQ==
X-Gm-Message-State: APjAAAVFE04x+zBVRW2muUCUPIsekubgcv9M1ztFB5qr8DDXyt6hT+mC
        gjN0R1BjD4zRXse42sFnLNFwig==
X-Google-Smtp-Source: APXvYqy2g3UP4Xetnx/eP45GILdnzIptbOKDy3NsV2tZHWR0IcpxUDP5HKAjTn9LSSeZcbJQp0Ux3g==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr11842704wrq.93.1570197151233;
        Fri, 04 Oct 2019 06:52:31 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id x5sm5230136wrt.75.2019.10.04.06.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 06:52:30 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:52:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
Message-ID: <20191004135229.GF18429@dell>
References: <20190930130246.4860-1-brgl@bgdev.pl>
 <20190930130246.4860-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190930130246.4860-2-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Sep 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for max77650 core mfd module to yaml.

MAX77650, MFD, YAML.

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
>  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml

Looks okay in principle, but needs a DT Ack.  Preferably from someone
who speaks YAML.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
