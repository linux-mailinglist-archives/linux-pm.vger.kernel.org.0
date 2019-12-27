Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7512B227
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 07:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL0GxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 01:53:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35514 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfL0GxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 01:53:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so14030275pgk.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 22:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D+tJQxVCKPg9Rb8jS+mkus5u9l3JL2diBZpHYaUBhgU=;
        b=UfubnGc5ZieYDJrua9hILu02gNJl8OLeeUO4liQPJWviXNh47yp5SIKsEQUjA+8dXg
         S+x/DXv4u4lUiW5VaaElly+9FVLVZcyQWcz4tuDqNCnMx+VGMn+x/G23TDvp2OL0TX2S
         gU6L4KTyGAofNFcj5oYj/stpsVeNIb7IFRtWAOBI9NzTsg5RCm8WiiYUFp3xGKnbecEG
         XXzeWRll+rPiAVvxwT7uALE3rESHHcCdCS/LtR9pvpMiVwsPx5iNAvUYWSIM7VDhIdCj
         LPXL9sxsq6FkMBlACzFWwuLVPPr0a8qi9gWscfzAY6nRS64xerjR1eq0i0yjtSb1GCqN
         bnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D+tJQxVCKPg9Rb8jS+mkus5u9l3JL2diBZpHYaUBhgU=;
        b=m+5HvCN8kx9KuRL0IOX93XaH7YifYfypQKAx9tTnEzuqmqSmExTKvIalKaWG0pqCEE
         nVKn5CgiK7VTOfII/DeEZQsLaV+rSfD8pR2t8nboi9X6CasmRnIfjb3AvIioyrQxaBfr
         mMGS6IOxgkh8/0/FjfAgdPtsZhdU5+yYo09u8C/Wz31djzsewW7NZlyHbzsHiRIZDLiZ
         QMhPGd+6jNZZbcd2XvCz7OuKiCcRYZ/hTplct5m006fxzZtuzgR8KR49i6HsCcyCjp7J
         cjWDvkpyRrYNPhgs47DmuZY1ULt3FG8vTs3ilVEJIFvasPNdpqZdnV7LHo5QPwhNj7R/
         35zA==
X-Gm-Message-State: APjAAAVHiJ8GJs40gG84gOnbj/bws9ORJJgmHOqfV39SzIjYh8BRjqvg
        FNrdfi2WnKZYzlc7Z1jnpr7Tdg==
X-Google-Smtp-Source: APXvYqw/f7yBMM9QmcJ7bi5ktc8XPVS2HIrEJ20Zpj/mkYQx4ERk06gyCsWLjUjBuMtrYpDSPZQeaA==
X-Received: by 2002:a63:455a:: with SMTP id u26mr53844216pgk.282.1577429582913;
        Thu, 26 Dec 2019 22:53:02 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c14sm12832361pjr.24.2019.12.26.22.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:53:02 -0800 (PST)
Date:   Thu, 26 Dec 2019 22:52:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/5] power: avs: qcom-cpr: remove set but unused variable
Message-ID: <20191227065248.GM1908628@ripper>
References: <20191223141934.19837-1-nks@flawful.org>
 <20191223141934.19837-5-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141934.19837-5-nks@flawful.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Dec 06:19 PST 2019, Niklas Cassel wrote:

> drivers/power/avs/qcom-cpr.c:896:35:
> warning: variable ‘prev’ set but not used
> 
> Detected when running make with W=1.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Niklas Cassel <nks@flawful.org>
> ---
>  drivers/power/avs/qcom-cpr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 232836a1ef27..484dd498f8b9 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -893,7 +893,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>  	int i;
>  	unsigned int step_volt;
>  	struct fuse_corner_data *fdata;
> -	struct fuse_corner *fuse, *end, *prev;
> +	struct fuse_corner *fuse, *end;
>  	int uV;
>  	const struct reg_sequence *accs;
>  	int ret;
> @@ -909,7 +909,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
>  	end = &fuse[desc->num_fuse_corners - 1];
>  	fdata = desc->cpr_fuses.fuse_corner_data;
>  
> -	for (i = 0, prev = NULL; fuse <= end; fuse++, fuses++, i++, fdata++) {
> +	for (i = 0; fuse <= end; fuse++, fuses++, i++, fdata++) {
>  		/*
>  		 * Update SoC voltages: platforms might choose a different
>  		 * regulators than the one used to characterize the algorithms
> -- 
> 2.24.1
> 
