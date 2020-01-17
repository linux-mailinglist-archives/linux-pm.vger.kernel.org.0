Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487D7140902
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAQLe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 06:34:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37155 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgAQLe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 06:34:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so22417067wru.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 03:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=evNHCWWR8VDQgkVk+W1DMeAHVIxkJQGWyaVBPtYnDrc=;
        b=oBGOm9JvQ2c/xRqP4pTi1fYT4Xeumb+8oGfQHcf95V0670qJ/7pQ7y3K2WG7YtLHNr
         VyjVpgrZFjiUcr8izrBXeqTrurwr6KnbGdtcbzwhRXGj5tHqowSJogHYzEWuicTLKVlI
         XPdZBH5SApp7zifRAvPMp23HYM2ZCB2mnYCHb4MA+iWYjA40RXVo4rIZvjdqK9SxJRGt
         EnISdUOZNFjodtS6vvsGwC24f38bRxelB2c6jbM+MVlj0gtS9KtCIyvlyvgw7FjvyIv8
         6sDFWcWIKeuo0wrRqSv0bJy5m3N3iftgPM9U7u3/05jsbtJ045OCH2Hd4Vq+C1l1fEpL
         PDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=evNHCWWR8VDQgkVk+W1DMeAHVIxkJQGWyaVBPtYnDrc=;
        b=iwM3ghWRgzEhgLO+/522+e2kTZ4Fl3TslgtHxTABK9TO+LdBxQQa2tcVre699Fq08u
         9OhKY8jCh2lyps8RrmgvZ0MPBIaMZaGrXfMJHy4qK3fBxvA8pIX0gS4thjqUDKDqseLs
         OeUK3LNvxzHuYmmTFMwb8BUzfPjomTagVbHsmmPrScBU++iJZI/fYay2dlLYiFkxflsP
         6+PH+1c0kPTd5hjYmUQRDjMoxt1ff34VLcFJhmynL9icZKpr+g5oY6w6MV7Y5LqkvDMW
         59MB6NBa4f5eW+t6ZwXXc7Jf3A8lz7552T2hE8yxDgzGuh2sYJ9QTnNxKti/gqTo7O47
         Nw0w==
X-Gm-Message-State: APjAAAWs3IN6ld/H1db9tazBDqhPvrzYnzBN6l8ORT4nRwKZC8jC8jX8
        b0w5HW7mJACmZ/GdKAWh27cC3w==
X-Google-Smtp-Source: APXvYqxHUoUVGRG19E3ieVqNqnW2+WCjFDV9O+aG5AQe2K9rCp3BeYzv7LTq4ZhJWMCqeroBuJrIKg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr2784294wrr.158.1579260896233;
        Fri, 17 Jan 2020 03:34:56 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id 60sm34545482wrn.86.2020.01.17.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:34:55 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:35:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200117113511.GJ15507@dell>
References: <20200117002820.56872-1-pmalani@chromium.org>
 <20200117002820.56872-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117002820.56872-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Jan 2020, Prashant Malani wrote:

> Add the cros-usbpd-notify driver as a subdevice on platforms that
> support the EC_FEATURE_USB_PD EC feature flag and don't have the
> ACPI PD notification device defined.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v7:
> - No changes.
> 
> Changes in v6:
> - No changes.
> 
> Changes in v5:
> - Updated the IS_ENABLED() check to check for CONFIG_OF instead of
>   !CONFIG_ACPI according to upstream comments.
> 
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
> 
>  drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied v6, since Patchwork can pick-up the Acks and there haven't
been any changes since then.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
