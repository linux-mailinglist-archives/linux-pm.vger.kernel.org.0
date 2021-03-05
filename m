Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259F732F1CE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 18:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCERwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 12:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCERv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 12:51:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DEC061756
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 09:51:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e23so2195519wmh.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rnJYGQomaqM2KLEZejZ9PCfh5WaOV6NGzs0Iq6hBDM=;
        b=KVNVylvx0oblTCTcYBfug7t2qsp7LPHRdt2FUa1RWY1qLBePtW6qSbX9A3xKZjr/Rn
         B7jmk9Z4EutBXkh+iFr3dccxXiGLWJ4l+6fEmd9r4S/gqEyvyBED8aiK2b9PLrZ9aA4M
         7bhAmAk8R9IZ9pqAK12UxzomUPA17foRRsFlAc9JmQNPmSTrUR4fLDYudKNM4zCVnx5O
         SNdIiR2ff0CUdBAYY0WWEQ+su+oDuPvAtSsDc1EMQ8WIaFCWCc2ZE0vIhRNOHs7NxLv4
         yTVWSYMLfdZu13EQjUyhsFNyp8ui9mv+SxWr8ub0lAUJdgZ717WwZDB3035xHzS3rT1A
         hm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rnJYGQomaqM2KLEZejZ9PCfh5WaOV6NGzs0Iq6hBDM=;
        b=bAMx76JK22KaFrhqk3DvO5EGcX/nxTjSDZln4thMwTySPtajjRK9zC4R4w8oFeAR9j
         v3o5uRkTsstE34v46NqbwHAhgvJ1kqm9DHXYawAXnb5vBWf5gYdy9DgeIdoVnq6QPozz
         1q9WGyBl7vJLsSaZuequ/eGr2O+x33/jNc5X6+pQ4drqUInGl1//37bk7985MIENaAcy
         XPxEHkQkzHUKyZ2gaUaR01gkp1jtCZg4Qx0EWfMgoYg4KgHTYzV9KryrGCNIidMyXzQ6
         iv5DciL94vyBtpO1SbUM0niTImIQ+vzpscPVyB5UQhMObDyMiKEfTCu/IySJLazkppOf
         x+lw==
X-Gm-Message-State: AOAM5328VFJK69XbSy/Ee4lmlZtCNi1X3scBMaDhauopUuAufe4BHFm8
        uRyklNjbjemuaBu6xTEVPcPX9w==
X-Google-Smtp-Source: ABdhPJy28j2Gx/LoyWc0aLhJHKmcrpuXxR0yeFi7HwF9bcH9+ukuh6pi8+5JUt5PVim3LgvwnUxxrw==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr10257861wmc.9.1614966716339;
        Fri, 05 Mar 2021 09:51:56 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.googlemail.com with ESMTPSA id o2sm5796118wme.16.2021.03.05.09.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:51:55 -0800 (PST)
Subject: Re: [PATCH v2] drivers: thermal: Add NULL pointer check before using
 cooling device stats
To:     manafm@codeaurora.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607367181-24589-1-git-send-email-manafm@codeaurora.org>
 <483eabf92d011964d58c2321c9344ed2@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7486c27b-c6fb-4686-811c-85945ec5a273@linaro.org>
Date:   Fri, 5 Mar 2021 18:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <483eabf92d011964d58c2321c9344ed2@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/03/2021 18:24, manafm@codeaurora.org wrote:
> On 2020-12-08 00:23, Manaf Meethalavalappu Pallikunhi wrote:
> 
> Gentle reminder..

Thanks for the reminder, I'll pick it for the next -rc

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
