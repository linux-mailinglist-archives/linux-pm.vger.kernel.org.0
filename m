Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E97AF2CF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjIZS1k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 26 Sep 2023 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjIZS1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 14:27:34 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764A126
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 11:27:26 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57be74614c0so300687eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 11:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752845; x=1696357645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhC0uYVK2kytMZ9QlYozCMzFKnpkFHJU2B3NdKlzRjo=;
        b=amF1dbOFEjGzM5C+tJRFUCB33BlBKsH5+XnT+cdGTa11czMQj3d/1k02cy3ITBQPAe
         QXk1l3fpCG0lE3w1kzXL7QEoalxdqqtnkQsbY7FoojIx3DmlLzCz8JgpgCL1U+QfUVn8
         QZbl7VceMcqve0uhvhugkRTeyhJ2iWQOugRflPtoa/+ZpRfPiMUcgVuL7Up9Vqu7u3oJ
         AK2qV8zBIRX93s04U6JfI7fPdP9vGDoh7g41g7UA0JVoAlPTNHc2BNWV2rFf6P85hoaE
         hK1jy/ky5iqwAUD/GC7B1CKb4VstlelLOWQShKywiAggdCWU17l2K+5T58k9xVbY20ZJ
         95Iw==
X-Gm-Message-State: AOJu0YwVEDKgX63KzxzQjjcYRCt2HGUXfsp0y9zgnAV0zZNBGML6t781
        1eFvBbQscB/r4MUOdCjtc90IVa6ASrmGFiDtH0M=
X-Google-Smtp-Source: AGHT+IFiuT3AYEbHWFxtTc4HW8guzIMaizhJ1yZ5kTe53BeSimZ/KDH4kB+n/IkopOGQu4uGW85kcQPHfQsW7e8dvk0=
X-Received: by 2002:a05:6870:c587:b0:192:6fce:d3be with SMTP id
 ba7-20020a056870c58700b001926fced3bemr11164190oab.1.1695752845479; Tue, 26
 Sep 2023 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230925074058.149779-1-hch@lst.de>
In-Reply-To: <20230925074058.149779-1-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:27:14 +0200
Message-ID: <CAJZ5v0hHzYjB=f5C9VV8=MAG4YCZjjo6mqNAYv20DEV7DYOW7g@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: fix the kerneldoc comment for swsusp_check
 and swsusp_close
To:     Christoph Hellwig <hch@lst.de>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 25, 2023 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The comments for both swsusp_check and swsusp_close don't actually
> describe what they are doing.
>
> Just removing the comments would probably better, but as the file is
> full of useless kerneldoc comments for non-exported symbols this fits
> in better with the style.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/power/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 48ec6a8ef9c445..b9763f2f632b8a 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1513,7 +1513,7 @@ int swsusp_read(unsigned int *flags_p)
>  static void *swsusp_holder;
>
>  /**
> - * swsusp_check - Check for swsusp signature in the resume device
> + * swsusp_check - Open the resume device and check for the swsusp signature.
>   * @exclusive: Open the resume device exclusively.
>   */
>
> @@ -1567,7 +1567,7 @@ int swsusp_check(bool exclusive)
>  }
>
>  /**
> - * swsusp_close - close swap device.
> + * swsusp_close - close resume device.
>   * @exclusive: Close the resume device which is exclusively opened.
>   */
>
> --

Applied as 6.7 material, thanks!
