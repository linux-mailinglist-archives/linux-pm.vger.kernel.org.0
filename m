Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD21CEBDF
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 06:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgELEVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 00:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELEVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 00:21:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD5C05BD09
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 21:21:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so5753289pfn.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdjYh0oULyLJ5bKtvUfrpKY/2RKuAj8/Dl3bei8f6k4=;
        b=y43K56Dfg/lBfYBZTCGXMXhFb6d7tRa60kQPwF899DRyGef9/q2FtoD2Jfq/ZCrVs1
         E0CsaE1tM4k+NHsP3W/LVLuDD8mlF297aj4IGgmlAHHeEivD1jDFVAR1q9h1rl2SDAvM
         9/cPC/FiLdFYHFKgi7ae0Z8DRv/RNIA+lHtIKXm2D1vj5LfFZf5zqIptDJK+gY9tYbTf
         Vk/HwtggQJ1bpYthbTPDcWSa4ot8Qg7ubveZ36oooDLWPNrYNCCzT4zidKfYn3nwmuAR
         8IPu2ZXkbSD/pi9lotIhEeGy7uu7WiLk3rLRM5E3S1BiLTZv+6lfB8g/yVYDPPkD40e4
         VPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdjYh0oULyLJ5bKtvUfrpKY/2RKuAj8/Dl3bei8f6k4=;
        b=FJnMMxzAcz0fNTdNmbP1+ggfpoqxPj/ltQUQVElwnloe076RrTNzuO6ppYmnSY2UHx
         n1+ABMLhnTZqa5wlaIPQ1qiA6TvvqC6IkjL26qLxKkBEh/dPvT051+g+w2nSmfvZjtCE
         0KH8vmOTWHueQvFrnWABwbbQe9EymTvBRD9crOLUB+IbX0fOnEvQ+nw3OIbAU4fhQEgk
         9hdMR0z8UON9oEoHI0kvJafBpIMScXugC1OEAoXInGLet8437wI5QuQ69i7u3meJezzF
         cJ3JQ0u/Ra34kkvRWT5ZKGHXEYzMgbqNGRLecD4l9+gN29zfb5hHhmhp2X411AqHXjT8
         I9tg==
X-Gm-Message-State: AGi0PuZBnb5LlY95hglVAKNkm0rPhNnXrK9ytrGMbwOIOzkybU8xoQTt
        0Z43UsAQ9FKScDQ59WtvCYxaAA==
X-Google-Smtp-Source: APiQypKjWODnYY86agN2yEWC9uxMVeLfVAM2apbPJioRbCX8VaeEXSRQ0fMmHf5BAc6q+ja5I8RfmQ==
X-Received: by 2002:a65:4c41:: with SMTP id l1mr18142702pgr.43.1589257272699;
        Mon, 11 May 2020 21:21:12 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 1sm10749022pff.180.2020.05.11.21.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:21:12 -0700 (PDT)
Date:   Tue, 12 May 2020 09:51:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/14] thermal core include cleanups
Message-ID: <20200512042110.drvrtnwj5tynnkqo@vireshk-i7>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-20, 17:54, Amit Kucheria wrote:
> I noticed some remnants from when thermal core could be modular. While
> cleaning that up, I fixed up the includes to be sorted alphabetically and
> included export.h in files that were using EXPORT_SYMBOL* or THIS_MODULE
> while at the same time removing inclusion of module.h from core files.
> 
> Finally, the names of the source files for the governors and core have some
> inconsistencies and the last couple of patches rename them.
> 
> Build and boot tested on some ARM boards.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
