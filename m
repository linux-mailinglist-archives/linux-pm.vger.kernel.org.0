Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE131FED50
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgFRIPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 04:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgFRIPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 04:15:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087EC06174E
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 01:15:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so5062543wro.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VFAtsOIUbu3lSU/HEGGn9hrUEMDItq984a8uDB0vTG4=;
        b=OeeHyY+YKwWr2fRsYI11CjIJOMFFkdCm85UynZj7MpMoE9cp+TT0NoE8bPVmdKNSzf
         QTIAlb3B23TkGeN9VzxVOhsSJ1N47FjHc0HndFsFSgJunxiS3u/Xh0o6KkKOngoTOzQK
         mzSxMd7ej+ALbFugboPDoWizoX/iKpXRGYPK3I0cDW7KYMWWo/cVVI1DplpNBfOTrIFJ
         DFKek/jSOY2zOffnNr75HeaTp4uUyeotKBquwFBZwQTL7NIrn/D+1UUorehTACtmSScG
         6RsxLv6wCrP/2KFNpXHu95CoxXxBW3VT/5dUcI4iHiTz4sZF8UAEIQVnrQPCBO+p7cdT
         5kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VFAtsOIUbu3lSU/HEGGn9hrUEMDItq984a8uDB0vTG4=;
        b=ZT6RBuS42k8xBchtijcbteVrtcDp9wxZolZQC/Yea6/4XifPaK6bBVPH2w0h/TxdpO
         AihM9L29Elg2Vn9jXx9THtHq6gUwRUszafyHgYkBi08gHDi80JVd8utv+n/skFlXzUyA
         rI3WOus00sQAr70f6VMPS18V8N+yuLv1HvKxV32nFmTewQfhuS+jv34rgchxfrLEBg4Y
         24tNef1DS8QFuRiDXq+8qb2zmEOQm6eyqoK604LJivSBtzExTSO1f0OLVfF4yUTRyoWD
         65wYUYqnPBvy9MWVjULMhBpS7zKZhb6sXMBVJtZ9FQqlM6nHwcsn0619GuXnD9knZ3fj
         JVFQ==
X-Gm-Message-State: AOAM532TQiBXPDKHXPUrW2HVEWCL/OZKwP/MpKtnekJMN4L2b3k+/D8h
        +A957cMEbHUUHpGZkfcvRXTqZw==
X-Google-Smtp-Source: ABdhPJw7v4a6RUSX4JeAquXGtY8pIltUKnas1QX4AmwEVUOoZpZugP52IHFdKrlL7jAb5gwUMH7j6A==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr3485714wru.182.1592468119418;
        Thu, 18 Jun 2020 01:15:19 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id h203sm2112690wme.37.2020.06.18.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:15:18 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:15:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mfd: add support for the Khadas System control
 Microcontroller
Message-ID: <20200618081517.GA2608702@dell>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
 <20200608091739.2368-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608091739.2368-3-narmstrong@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 08 Jun 2020, Neil Armstrong wrote:

> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
> 
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
> 
> This implements a very basic MFD driver with the fan control and User
> NVMEM cells.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

A patch-level change log makes reviewing easier.

>  drivers/mfd/Kconfig            |  21 +++++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/khadas-mcu.c       | 142 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/khadas-mcu.h |  91 +++++++++++++++++++++
>  4 files changed, 255 insertions(+)
>  create mode 100644 drivers/mfd/khadas-mcu.c
>  create mode 100644 include/linux/mfd/khadas-mcu.h

Nicely done.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
