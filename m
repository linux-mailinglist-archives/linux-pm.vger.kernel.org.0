Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFB878A639
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjH1HBO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjH1HAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 03:00:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AC9E
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 00:00:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdca7cc28dso22597055ad.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206043; x=1693810843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKwZQRksaJoyl7gPeV+o2LaDNZErWZWMFIGrkd2LqsQ=;
        b=gDaUiYqBjsfaT9CzgOblSfkMkMt27KWNQdUjGnAlbCcj90W2rxcG0TbVdZLdB9LoAU
         cOwC5lq/AAp4EQt4drQj7/7tKbWguPq0AV9uvCSyigUziZRWwNjMERhHZarEs6wL5Z2A
         N1hD9yQgNkF00nBTGJbABwteCKCJAuqn9vupQWGPcw+Aiji5AN/kI8XLQjzlH53BMoZi
         g/zsWbAN3MPkxh9jk3l/m3s/Bj1YdFI5HNEt1we94inqHQYqA9tgoBzDfOXuwcdRsFff
         km/ZB/dQYMBSXh+pNBiB02GqYfPhRL9cUZ4Vtne+PPjNsHRrpBlo2TDMaq2ahfDcIyOS
         HP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206043; x=1693810843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKwZQRksaJoyl7gPeV+o2LaDNZErWZWMFIGrkd2LqsQ=;
        b=H5WhJf9YG0k3kDllGCeqXp1B3TlSWBC4jJW3VfwzMcYIbHtMRMpvUzmPrWM5mZi5OV
         hnP/bQG5YUxbODBISz2PZP97u15GDeUt5hrCWGSD740OFkBYsXSGNxU7EzM8FwFLZ68A
         Ys9//42nxXtaETWNnlsZDnoZPfgYyZOgGCI9TI1P7y1sJQhlkU5e1OYFuHRnIpedZzWR
         lWhCv82khV9sfHlkWpzSnKke97UitXlxKe6lFGFpAbVPdAUgOwG3KC3TCFA0lV/kuDGf
         xahnJbhg5vYHP/Fh4sbLGLOziE416DEa3bUcAk929KOBhsNdO4LVvN6dafYE8T6HhQbX
         UTEw==
X-Gm-Message-State: AOJu0Yweg7trwHFZRGIMZ5prJS8A1KUQQnpuKnFTIvKM2HfOr7ewq+dN
        mEZ6ZkF2OVgO7K09pH06XCE0FPCtutFmgeHVaGE=
X-Google-Smtp-Source: AGHT+IHGIn++iMysAZsS6Bo36FEUY2TFepWJugy9un9gSuV3YiVEPUoPb3ek2Scf0V01wulc+qCAKw==
X-Received: by 2002:a17:902:ea04:b0:1ab:11c8:777a with SMTP id s4-20020a170902ea0400b001ab11c8777amr30773100plg.13.1693206042819;
        Mon, 28 Aug 2023 00:00:42 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709029a9600b001c0c79b386esm6453315plp.95.2023.08.28.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:00:42 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:30:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix typo in the comment of
 cpufreq_register_notifier()
Message-ID: <20230828070040.fgnxrxjnqpobtbvi@vireshk-i7>
References: <20230826095455.1137604-1-liaochang1@huawei.com>
 <20230826095455.1137604-2-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095455.1137604-2-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-23, 09:54, Liao Chang wrote:
> Replace 'ron' with 'run'.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f8eb6dde57f2..c835ff117386 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2010,7 +2010,7 @@ EXPORT_SYMBOL_GPL(cpufreq_get_driver_data);
>   *
>   * Add a notifier to one of two lists: either a list of notifiers that run on
>   * clock rate changes (once before and once after every transition), or a list
> - * of notifiers that ron on cpufreq policy changes.
> + * of notifiers that run on cpufreq policy changes.
>   *
>   * This function may sleep and it has the same return values as
>   * blocking_notifier_chain_register().

Applied. Thanks.

-- 
viresh
