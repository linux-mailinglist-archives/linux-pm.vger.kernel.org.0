Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0053C6BF8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhGMIaW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbhGMIaV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 04:30:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08895C0613EE
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 01:27:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t5so15493230wrw.12
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JdIzo+ab8yZqCyfLG0HPkhJJ6bitQEDJ6d4nqk25OPQ=;
        b=O+kRR/cmVS41VVx2Wakn3RdyNFwzpIoUGLOGubOc+/gPh6FPjVUq1uC5mJLyoSmmsw
         MvgBdfjp93P+6S3AgtIUcIhWz3IX64CA28w1vxlucNXOjjAbNTJaTIwP2vGiGwwKGMX1
         b31bomYcsNpAZXZ/POXNXE42CS90iLtefbH7Lh7Zm8eXoSNtATHK6f6A33Z45x00EjAg
         2J++HZNb8K3LV57R0nI9rE2zIPxadBNhyyJkwziN8uWuiARRQEQSTE3hO7YekPxibugJ
         C9BbNI4fZ2zEYhStmCyWQudMAc1XCLvFZcDZqIkUd4HaHfitb+Rwevcvh9j7a7+pQLht
         zXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JdIzo+ab8yZqCyfLG0HPkhJJ6bitQEDJ6d4nqk25OPQ=;
        b=fPGAa9zuWIjN2hPA4r689+xqDv2Z0RX4ppFU+5Auxmq9+daqPyLJmLWl25wVOld0Qx
         zGNwHpE3aD2v5Ozv1AwaR9EZLRUgLfVdJjUncUiea19QJk/CAh4NABrK8WO3AurYw219
         AzUn1hk6FezAPrpQ5Ez9EDrDsxwyVnI4KzyIp4T5u63iEMmfMcnwljIbXAihdRIcMC6O
         RXI4JuApaSOp319tOY9+w6k2yMlxHNJk7vbaM8Z30nK7xvh57eBm0ffILftRecq8Kf+5
         2kVr9qvb1t/Qaew+CaUBvRao4TW7XGSVpvOZGOHddv8q7Q1gF2Ymi6Yyw1H61bj5bZrx
         CxTw==
X-Gm-Message-State: AOAM533gNBRQrz8T7WxSs8ruHyvEsCMV2jNlF5eEBbcx+Z+JqlgKafOX
        Aq939Z48tHwhIeHJHSrjKQZVOw==
X-Google-Smtp-Source: ABdhPJxX61/8iSRjrv+VUN01zzjLCcUznSlAHWn/+AydT831LyyUV8RrgPGbBKxykNmuLCFeXdAmvQ==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr4121510wrs.394.1626164850460;
        Tue, 13 Jul 2021 01:27:30 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id n41sm1579655wms.26.2021.07.13.01.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:27:29 -0700 (PDT)
Date:   Tue, 13 Jul 2021 09:27:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, lars@metafoo.de, sre@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 0/2] mfd: rn5t618: Extend ADC support
Message-ID: <YO1Ob18YsDdEMfuf@google.com>
References: <20210712212111.18896-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210712212111.18896-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Jul 2021, Andreas Kemnade wrote:

> Add iio map to make voltage_now related channels accessible to power
> driver.
> 
> Changes in v3:
> - use scale functions
> - add acks
> 
> Changes in v2:
> - use iio_map instead of devicetree to allow mapping which does not
>   block future extension by devicetree.
> 
> 
> *** BLURB HERE ***

Doh!

> Andreas Kemnade (2):
>   iio: adc: rn5t618: Add iio map
>   power: supply: rn5t618: Add voltage_now property
> 
>  drivers/iio/adc/rn5t618-adc.c        | 23 +++++++++++++++++
>  drivers/power/supply/Kconfig         |  2 ++
>  drivers/power/supply/rn5t618_power.c | 38 ++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)

Not sure I get this.

Firstly, the cover-letter is marked as MFD, but no MFD changes occur.
Secondly, I am only in receipt of the 0th patch which seems odd.  IMHO
patch sets should be sent threaded and all parties should see
discussion on all patches regardless of whether they maintain them or
not, since the overall conversation is often useful/relevant to all.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
