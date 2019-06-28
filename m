Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8206E59D4C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1Nz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 09:55:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39076 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1Nz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 09:55:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so4030191lfo.6
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2019 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CD0Dro/10uh0YhFuXjsGP3VvYGuc/+fjYwhH1KYhLws=;
        b=Fgcg9151r7YwZPtCi7cLarJT3ZJd6rOMpdYh0wm/4ZyFNryTbCLRdLqjlHHn3SD/9V
         VqdCWxPMfqwK81G7bX6yrCulEAYBg84Jr89U1z4cpf8EpmJqMvZx/lTk9ptK3ZkmAfHM
         Me2uQRsrUZG0+6tDuESUn43ZUu3o6JgHmYvf9eWYAIbZWHVbSI+Ra2zdKUQMVOALIHGW
         LElG82voYlEwKXKE8b6FCR8E68RMnU+dc+vYenK8R1MLRaNN85WRgLkcLHZuTn9bknJs
         GHp47CtFBKgl7yHpjVa+wlYnU0XQJnf5U0qNSBNwUgUSPdkjUF8jKjrAh1zPDEk5SpCS
         y2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CD0Dro/10uh0YhFuXjsGP3VvYGuc/+fjYwhH1KYhLws=;
        b=TFaQFdep5p3QD4lchehwLkyeNqTu595Hs9bYfrUeW9wfCWOorytK9tQVaEkbRZEGUu
         oSoUoj1zhiBnvJvFym4+IYEBP1r/9DzSWoZlW5uKwL+oZdPypwdsuaKQw66zU5Lp4LsM
         dH9M91W46hyG1eiCIg5FDTNvzu1/uhrM2YyBC/GQHoZW0JN8pGMRw0C/Q3qJbHgPNx/v
         zjpJ42/Y9v4mPTp9KmsOvywwYCc3pDpRtUC6MeHjfewSMMRoL+ivX/45HAR2EEYCY8xi
         b0GRXh4yO3gubFO6O5d4ttSHQ4SMtd8Tnwi0y/UdcynlvW0EX8raO1YfQPwdMapqS55+
         8eIg==
X-Gm-Message-State: APjAAAXTqrxRUMFl4Wj2l65Lxx+msYO2zDKZpWpCD8uKG/Lwe/2POMwy
        HjAFgdYVvE2M542ea2p3UjZXjpROX9o=
X-Google-Smtp-Source: APXvYqwoCKqttWz2S48+v+xWM2ZATbNuNG8QYn3pnYCURMxYNKhkuDT0oZ+a05iZB9c8QdCKHI5b8g==
X-Received: by 2002:ac2:4303:: with SMTP id l3mr5150961lfh.107.1561730125453;
        Fri, 28 Jun 2019 06:55:25 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id s3sm733680lji.38.2019.06.28.06.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 06:55:24 -0700 (PDT)
Subject: Re: [PATCH 12/39] docs: interconnect.rst: add it to the driver-api
 guide
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-pm@vger.kernel.org
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <feb5e217face2ff3f2ccd5c3726192bf1250dd0d.1561724493.git.mchehab+samsung@kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <595111a4-c565-75e9-ab7e-b008274ce75c@linaro.org>
Date:   Fri, 28 Jun 2019 16:55:22 +0300
MIME-Version: 1.0
In-Reply-To: <feb5e217face2ff3f2ccd5c3726192bf1250dd0d.1561724493.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/28/19 15:30, Mauro Carvalho Chehab wrote:
> This is intented for Kernel hackers audience.

s/intented/intended/

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks!
Georgi

> ---
>  Documentation/driver-api/index.rst                          | 1 +
>  Documentation/{interconnect => driver-api}/interconnect.rst | 2 --
>  MAINTAINERS                                                 | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>  rename Documentation/{interconnect => driver-api}/interconnect.rst (99%)
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 2a0b57f12d1a..97bab578ea72 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -35,6 +35,7 @@ available subsections can be seen below.
>     spi
>     i2c
>     i3c/index
> +   interconnect
>     hsi
>     edac
>     scsi
> diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/driver-api/interconnect.rst
> similarity index 99%
> rename from Documentation/interconnect/interconnect.rst
> rename to Documentation/driver-api/interconnect.rst
> index 56e331dab70e..c3e004893796 100644
> --- a/Documentation/interconnect/interconnect.rst
> +++ b/Documentation/driver-api/interconnect.rst
> @@ -1,7 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -:orphan:
> -
>  =====================================
>  GENERIC SYSTEM INTERCONNECT SUBSYSTEM
>  =====================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55996c9f2e0a..524e2c4300dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8273,7 +8273,7 @@ INTERCONNECT API
>  M:	Georgi Djakov <georgi.djakov@linaro.org>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/interconnect/
> +F:	Documentation/driver-api/interconnect.rst
>  F:	Documentation/devicetree/bindings/interconnect/
>  F:	drivers/interconnect/
>  F:	include/dt-bindings/interconnect/
> 
