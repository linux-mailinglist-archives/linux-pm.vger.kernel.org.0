Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D621DA01
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgGMPYb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgGMPYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:24:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C368C08C5DB
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:24:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so13564268wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afnqfT3oD0CR8TigtxsCnMccPxC/B5Fda6MKL3/JHq0=;
        b=CRfh3o5Tbai1CjSe1WBYNY8NfM7P5/Tm6yd3mSK9V/fiET78/uNOwMuLV2/ip9+hGr
         6SuyVldlrtqXNeXNMrUsoucitsXFwhPAXHi5DghGvR8Q1PYUppNwHWmn2qKMPEjhmI+p
         6ekh0NQ6328T0VC7fRHm0x5yaY223Ch6vodN7OF1qmlgizTcZsfyyM4499+WcIfavh+9
         SSrrUG7TQkTl0S/chZmJZVzml48srfHXzGp9Dtp+LqqFJzfaPs39bAR3n9Au6rDbKAoM
         1qlbMvEUXa7amvUWiT4+r4HzeZz7YTg+fg7J3GDyKAMgYvvUXgXu9STNB/Bo/stXAjei
         HCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afnqfT3oD0CR8TigtxsCnMccPxC/B5Fda6MKL3/JHq0=;
        b=UFrZYj/A8KCi9ABdDI7C1z43m+CuhzhOUIfwo1Ibyaxi39tNn7juChrJJKk/O8GCPv
         ocq0Rt6ucpX80QUllcvZl5x/yUsjVTMj57oMXAqVqr7UXpMq2jE4bFH+LNpBqPGW+aiC
         ZVnEMH70SZvN7pe1UboaRfQtxS9tsBcrLyxFCTnRXjcsmLjbkSTtQWmEOSyGw42fDv9J
         oaRw+PV5YlpqezX/zMUZ/FFU8ct2dMXycxh9h1H5QQpb5w/4nti2TM9zVT5i83elRze7
         CRS3VU6xYKpLmFemql6mYtxGjyVH4SJcp35i7/DXXsP48h/znRVgONTitwkZORNW1hPv
         ljJg==
X-Gm-Message-State: AOAM531q7FxmjTSbOvkPNwHKt2MqWRtN1lDC/unGs8FJlxBN7zW9gKai
        iS7Hkciq7nAN/dc9Jrh6255z9M7bbuw=
X-Google-Smtp-Source: ABdhPJyVtae7/ERp+5ogODsI4jB0xc8+BSDko076ZXU+PjxArZEZAUeVpI8Y+xfzl/3v5ovR6SOGXQ==
X-Received: by 2002:a1c:2:: with SMTP id 2mr430140wma.79.1594653868801;
        Mon, 13 Jul 2020 08:24:28 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x5sm23688700wmg.2.2020.07.13.08.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 08:24:27 -0700 (PDT)
Subject: Re: [RFC PATCH] interconnect: qcom: add functions to query addr/cmds
 for a path
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        kbuild test robot <lkp@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:INTERCONNECT API" <linux-pm@vger.kernel.org>
References: <20200701042528.12321-1-jonathan@marek.ca>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <3063d037-a781-6327-ef88-37b626c552e1@linaro.org>
Date:   Mon, 13 Jul 2020 18:24:26 +0300
MIME-Version: 1.0
In-Reply-To: <20200701042528.12321-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/20 07:25, Jonathan Marek wrote:
> The a6xx GMU can vote for ddr and cnoc bandwidth, but it needs to be able
> to query the interconnect driver for bcm addresses and commands.

It's not very clear to me how the GMU firmware would be dealing with this? Does
anyone have an idea whether the GMU makes any bandwidth decisions? Or is it just
a static configuration and it just enables/disables a TCS?

I think that we can query the address from the cmd-db, but we have to know the
bcm names and the path. All the BCM/TCS information looks to be very low-level
and implementation specific, so exposing it through an API is not very good,
but hard-coding all this information is not good either.

Thanks,
Georgi

> 
> I'm not sure what is the best way to go about implementing this, this is
> what I came up with.
> 
> I included a quick example of how this can be used by the a6xx driver to
> fill out the GMU bw_table (two ddr bandwidth levels in this example, note
> this would be using the frequency table in dts and not hardcoded values).
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 20 ++++-------
>  drivers/interconnect/qcom/icc-rpmh.c  | 50 +++++++++++++++++++++++++++
>  include/soc/qcom/icc.h                | 11 ++++++
>  3 files changed, 68 insertions(+), 13 deletions(-)
