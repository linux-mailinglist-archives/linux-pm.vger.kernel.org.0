Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3A21D97D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgGMPFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgGMPFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:05:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C0CC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:05:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so13503302wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oiboPTPqwVO4JgtYtWK4CJdioCjS3KbJnil5x5FVkTw=;
        b=dzyZXPHsj2U/pjstHiSykgblFxzOQdyfoUEQbYWR5PVPKbxSGVD9WpYxksR5D57HPj
         PCDFzEw++5SEB9FgGjlCizkTOSUiJ4eKxOJdrb04C4L4GitUcoGUO1G/9f50hJnkyDN+
         09w7I+somCl4Dm1zmEWVRXj/WGB1bk+CRCIIZkDbsqGCHmG2E++Wl73n0motRgn9NC87
         hYHQqHIZx7K8CiqGEWlIcVZu8w0NfwSMZBKwbRhyYz215Kex60NqWJwQOCqe23NmUZvp
         EpUd+59Zo9CYTJyiPjF45Sy3ZFRSy8b+4rPWwpE2nKY77b3FB94754AZnw4pOUiI0mVE
         P5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiboPTPqwVO4JgtYtWK4CJdioCjS3KbJnil5x5FVkTw=;
        b=E7uw2QiDyfCa8hB1wQ/zkRhIvYqM3fTyoBVw55HQP3VmdNkcnsEsZMkZJnH7MZX0//
         gmo/O784kUk+mSqc3MD2sKX2WCc2B3lNQvEC98DiY9UM8t68AX67BFYxbLZBoq+oTO5W
         ptY2ktdYHwRznqlious71bs/lf/DlJQAgGEsTz29vnAdgclh1owprwGWC7G6qumVKXTI
         r+dM0u8+E8UFcp5SJsHhDHZ+YaR2B1Nkf/nfGya77E3AAsswFpO23pGhRU2Nq4r6bQXL
         Q5jthanXzMso3G8Zg+lH6SXdzQt+c54KnrBBrGHFNPrNrITxhHmuSVDYwkkzl85GUvYu
         lOGw==
X-Gm-Message-State: AOAM530lOS5DWf3lZ+fF9iHakLDlqhpkpqxTwh0oBeB8oWZ/5dP/w36I
        1XNoY7aIcYAqvZXKtYgcPCkJY68g1Mg=
X-Google-Smtp-Source: ABdhPJxlV1Y+ChfOJ9d2Mf8H1wVW+rJXbjsfI6pW1FejCHHIaG/6vXI/ntNGCfLQVF+HOqoV/1XYGQ==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr379407wma.76.1594652749513;
        Mon, 13 Jul 2020 08:05:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:501b:b12d:3463:93f8? ([2a01:e34:ed2f:f020:501b:b12d:3463:93f8])
        by smtp.googlemail.com with ESMTPSA id x11sm21068530wmc.26.2020.07.13.08.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 08:05:48 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] dt-bindings:thermal:Add cold trip point type
To:     Thara Gopinath <thara.gopinath@linaro.org>, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <20200710135154.181454-2-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <08503e0c-c8db-6d03-9692-5339dadf6c4f@linaro.org>
Date:   Mon, 13 Jul 2020 17:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710135154.181454-2-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/07/2020 15:51, Thara Gopinath wrote:
> Extend thermal trip point type property to include "cold" trip type
> indicating point in the temperature domain below which a warming action
> must be intiated.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index f78bec19ca35..1689d9ba1471 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -87,6 +87,7 @@ Required properties:
>  	"active":	A trip point to enable active cooling
>  	"passive":	A trip point to enable passive cooling
>  	"hot":		A trip point to notify emergency
> +	"cold":		A trip point to enable warming
>  	"critical":	Hardware not reliable.
>    Type: string


thermal.txt should have been removed. Perhaps, a patch is missing. The
thermal.txt has been converted into 3 yaml schema.

The change should be in thermal-zones.yaml.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
