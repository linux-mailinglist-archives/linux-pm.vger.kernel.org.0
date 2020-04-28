Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979E1BB504
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD1EQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 00:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgD1EQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 00:16:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EE0C03C1A9
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so565020pjb.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zcgS21itL78D0fddZORH8FPW/WTSqwnt4JvHvdMFx7M=;
        b=ufQlri23Hn5ru/QSTcDsigIaefd5C8Jo5G5DkNvJRr4nSLBva7mhaxr6KHKCH3qeTx
         /Bc79XJKqxu+ihH4ya/wTgZdOnZywUMQ1JP7qtjss5SWsvyAH7Su9xWwd49NLWmbd4hS
         5qxZMnb5z7V+twQp5imipUmU2MwThi/RgGG4LLd33jcXNPiI3vy1tgAjd6etrFwyYWwF
         P/AKKwj6SjqwCUMWQctIla27pnCn3KxHWUkk7i8YF/UbPyEBHrHtiKng33yKzHJuHywy
         nb3BfPt+Z520YNe/axeSo8pf1paBOXEafEZqqdtGssUlVesX3uOgJ+u4mn66VmcGpgHA
         pJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcgS21itL78D0fddZORH8FPW/WTSqwnt4JvHvdMFx7M=;
        b=F9Kxfsu34IrO5RbgEYIXQdszNo2QF/Rsv4sXnzPm7pZhTUTxEfy60R3AWA8lk2yzie
         PKjZgd5ZXS/5Min9xPXCdd1S9C65N9Cr8+4qxYmkmVunwWlu976LiuHA/H6uTwb2YVk2
         cfE8NldBGQzn31aBTotVSDyONqOuWuOzf0zdrDH9bqeoxpvjl0ShMyk0Mg/f/468kNs6
         kmpav5mPJebtul8zUH/zNFEh31I+VuvaZTeDCQAzrhbZTneCwlEzgq5AQuz67Nfs9UTB
         0yFDUJBPra5KfgIBOG9BkdIAWvF41iGo2gI6WGKchfETbW1UAxRJTqGhLjrHK87ykSyr
         yrTA==
X-Gm-Message-State: AGi0Pub0/gFpTh5ru+caCQoJSVPeTjkyAwGK7NGTL3M0N8myn9R4luLA
        il5ARdASi81TyLIL8fXrfhvn3Q==
X-Google-Smtp-Source: APiQypLHi61r4xiv8wVJwGtp90je7+VC7t1lXTr4tVyxSHVN84FrrQP9s5jjTw2j/zSh39NDp6sR0A==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr2630271pjj.119.1588047401459;
        Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id f30sm752667pje.29.2020.04.27.21.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:16:40 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:46:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Peng Fan <peng.fan@nxp.com>, kernelci@groups.io,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.dmesg.alert on imx8mn-ddr4-evk
Message-ID: <20200428041636.loakok7yfqg3hcsl@vireshk-i7>
References: <5ea44ff8.1c69fb81.f246c.d02d@mx.google.com>
 <8af4842d-d576-fd6f-ac6b-2ef3482742b7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af4842d-d576-fd6f-ac6b-2ef3482742b7@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-04-20, 14:00, Guillaume Tucker wrote:
> Please see the bisection report below about a boot failure.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

@Peng: I have dropped your patch now, please resend it once you have
fixed the issue.

-- 
viresh
