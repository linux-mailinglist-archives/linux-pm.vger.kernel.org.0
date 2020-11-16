Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1412B4117
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 11:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgKPK3G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 05:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKPK3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 05:29:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F4C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 02:29:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u12so10870344wrt.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 02:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmRBhZj7/1pxfeVgZYMcCYX2nwmFSv/2NvPyqCkbFzU=;
        b=RftIK7kde9WlaffU9j38KVk/J1NaQLQ8CtGJGBdkT6P0pW5BBCOZSJWa0IsAikZWXG
         LP6YzPgeM64MOgYeHsbLkqf7irgCQPXs6gB8XR9HmviYbDsS6B8NFD4iKj9H8O8HHFjr
         zX0YaqHR6UWwBE40vsDO9aM9BjUL1K7o+hSq5MpkHo7uJiAbo+8u69fZ2+dFHc/Btcf3
         TG23NOv0/v/5C32hSU7zxy6vFqfKJ71hhCLbfDzOIWexlhnDFrK0xcssVxKzorIR9om1
         kq8llc5d3qMDCEG5NzlwZJLL8eFweqXr6df0oS1FV2pp8RoAxw5PmDcF/2jbM/Evsjn6
         Qs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmRBhZj7/1pxfeVgZYMcCYX2nwmFSv/2NvPyqCkbFzU=;
        b=RirSf8cN3MBzODClYRrJhruT8k/RRdPjmhFk5lHDyTTIPeqQIt8iyfaezWUgatZ7qm
         Ulv2eU+PbvpXhf2wzmMvxsHNRm7UqAowGlAHpJvfnUrImDw124a/dQZmfibZqyUAma1H
         nw+QIn/BfGJQXiinnSJRSxmTxetvOETe7/kJwLwNliWOC8CuV83asTrr+r9vNzMLDQhP
         D+BxFIet1im3JL1UnhlD/CDkqiVEgwU8dJU7z78EOjkXdpJKHsfQpoSNEViQUHMmRnNA
         +QYEoeftpTjWEMVC6zW97C/lbGktk989RMHrCTEfflzgnkwCOvhyPNhq5oR64vP3Pcde
         2CZQ==
X-Gm-Message-State: AOAM533QQhYFQ3CyZ0KxpoOkvnpuGiygBbgIkjWScjimmZmnRR8uFTBN
        7suFMckVL1TVIl4kJwzWd5XzQg==
X-Google-Smtp-Source: ABdhPJx++ca5WSk2zevIOD5mCC/jI7JYS7KLm3+x6zUCHUrs4kWmF68X4YCcaDImcIZKjO0Vln2cOA==
X-Received: by 2002:adf:f208:: with SMTP id p8mr17519290wro.280.1605522544279;
        Mon, 16 Nov 2020 02:29:04 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id c8sm21329564wrv.26.2020.11.16.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:29:03 -0800 (PST)
Date:   Mon, 16 Nov 2020 10:29:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
Message-ID: <20201116102901.GO3718728@dell>
References: <20201104203403.24937-1-digetx@gmail.com>
 <20201104203403.24937-3-digetx@gmail.com>
 <20201113093747.GJ2787115@dell>
 <3ad644fd-cd03-a1e1-36d9-014304fdfcee@gmail.com>
 <20201116084837.GM3718728@dell>
 <0e795281-ca18-fca6-1585-a487bcfabb86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e795281-ca18-fca6-1585-a487bcfabb86@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Nov 2020, Dmitry Osipenko wrote:
> ...
> >>>> +	while (retries-- > 0) {
> >>>> +		ret = i2c_smbus_read_word_data(client, reg);
> >>>> +		if (ret >= 0)
> >>>> +			break;
> >>>> +
> >>>> +		msleep(A500_EC_I2C_ERR_TIMEOUT);
> >>>> +	}
> ...
> >>> I'm surprised there isn't a generic function which does this kind of
> >>> read.  Seems like pretty common/boilerplate stuff.
> >>
> >> I'm not quite sure that this is a really very common pattern which
> >> deserves a generic helper.
> > 
> > What?  Read from I2C a few times, then sleep sounds like a pretty
> > common pattern to me.
> 
> Maybe the read_poll_timeout() helper could be used for that, but I think
> the open-coded variant is much easier to perceive, don't you agree?

I haven't looked into it.  My comment was more general in nature.

As a general rule, helpers are better than open coding, but there are
always exceptions.  There may not even be a suitable helper for this
use-case.  As I say, the comment was more of a passing remark.

[...]

> >> These are the values which controller's firmware wants to see, otherwise
> >> it will reject command as invalid. I'll add a clarifying comment to the
> >> code.
> > 
> > Thanks.  Hopefully with a bit more information as to why the firmware
> > expects to see them.  Hopefully they're not random.
> 
> These are the firmware-defined specific command opcodes, I'll add
> defines for them to make it more clear, thanks.

That'll do.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
