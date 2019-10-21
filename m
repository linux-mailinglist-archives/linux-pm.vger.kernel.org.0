Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB63BDE214
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJUC0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:26:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfJUC0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:26:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so7413253pff.6
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PchkhkHkpHWC0kYmoj4khLkCE0HnDurJCIn5TTAejAE=;
        b=LynjyfctcGM82RPOYFgGlFv88Sy3AMQg7CFkCAguUJ1u6cRIXDI39p36h3Zk4ROoub
         PAR5KXyqX9Sga7DJm2HnNe252W1N3cdzeBRs+KnehKNxkco8+RVgnks2kr8IcxUf+0yj
         mDU4HpTZut+dqVBwxr4IQkr+bjo5IKzZPgvydCXme2aDho0jBUpWFg2JSGQlYU4zVkGE
         u2QrcJVwJyEq6wzOA7P2FWU19m4/BXdZEqA4dW88CvjoYCRgY+ppP7l903mFOoOqVYdK
         9TQEmaJswaqB0XK7E32BqzZr7GLr/8zzy9STDDELUvn2KqhAeALjmvY+2CwHH9GcvVKa
         GL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PchkhkHkpHWC0kYmoj4khLkCE0HnDurJCIn5TTAejAE=;
        b=kTDdJy21FCygCWA4kKrJ7UB+Pkgsby3zPdLngb2p4kZl0hWp2g00PM4qzgwnWdwj7R
         6jbPVT+RDm2ta62S1oqz4CJ3ZNZMhitJnYn8K50zHWQg02Nd6kgdscY5xFWYDjNVPq6Y
         ZO0Kz8cDlyR2NlIY2pFCoVD64p4kjFdVLDhyo+nyFuIE91HGLM/7F+byAx1LuvTGaj+R
         wBl/Odq4asFNP/VPN7ULAVf8vVZungVLjyfsrpBfYyTEhvn3Y6436V3qE89uWE6UN5aL
         NBB1wfesgSmDKZMkNtyc9SoFRvHuiiB8ffVFEHvAM7oM2T1/wDPbvQa3HvGKlpV7O4o0
         afCQ==
X-Gm-Message-State: APjAAAWhH2eYN5SXJahcecVOaQLdpcY6avI7wAoZq00DTBOHrppcTpat
        /UTXLGZjiK8DiP6IW9BFX3Fhqg==
X-Google-Smtp-Source: APXvYqw0axn98Wbwcx34cJEfU2QUrsT2CWYt5o94Oi2ai9+QBXc30btlQrDjfUux1NoyVk8QLTB1cw==
X-Received: by 2002:a63:2889:: with SMTP id o131mr23130858pgo.444.1571624814098;
        Sun, 20 Oct 2019 19:26:54 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id o42sm12916748pjo.32.2019.10.20.19.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:26:53 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:56:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 35/46] cpufreq: pxa3: move clk register access to clk
 driver
Message-ID: <20191021022650.jgzfmzr6xyjkfalj@vireshk-i7>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-35-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-35-arnd@arndb.de>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 17:41, Arnd Bergmann wrote:
> The driver needs some low-level register access for setting
> the core and bus frequencies. These registers are owned
> by the clk driver, so move the low-level access into that
> driver with a slightly higher-level interface and avoid
> any machine header file dependencies.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c         |  3 --
>  drivers/cpufreq/pxa3xx-cpufreq.c         | 64 +++++++++++++-----------

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
