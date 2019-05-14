Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C581E1C3AE
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfENHN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 03:13:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfENHN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 03:13:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so8629307pfa.3
        for <linux-pm@vger.kernel.org>; Tue, 14 May 2019 00:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQPLHP05DqTegTE4TUsSF3/FbmYhNyo/2jB+YqeEkrI=;
        b=a4hZDKAvf2U8Toua66nWLCC4rtqeiHw+52aauyS6hdU9pTo2sSelpzKs56LSDfezND
         X6Ev/N4UprzvoP9j+EhrsDOY/OvUj6nrV6mP+hU7L6d25vL7CQJvzjVsp8j128EGi73s
         9rRJuh5eBSkh6+DwcDEbbna13+qK9sXI3hIUj3J4i0ni7+zRnTpGo/nZgeBEIAbG5uFq
         7Y3qQvWMy284c2y/zasJqA+6IRjJnL6Wka8V94+U2JunJf9JHe55sXhBEUiGNVjGaV41
         eYjMM3rKCKPNAJACWSEgSArOToAjuFPBNhgaWUGjKb2qOYHm9PQKPNi1LXKJAnHnnMr+
         Negg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQPLHP05DqTegTE4TUsSF3/FbmYhNyo/2jB+YqeEkrI=;
        b=rx2iHzBYHJqSz9dFQaOL9Fxy7M/abQfoh1GJTcGolgpLC02j6wQkg+Jh4cw9xmjvBa
         5/5owVoyS6HeAVr92bSNfSFv2Rzb3xXDRGoP8dwmchhMDaWeCDQzrzlNEszVKpkW4vRY
         rXiuyT4zXAy17CQ77/J+WF6sc0L3Vven3tHY1E5kjanbWZe/NUHEBe+XmxYaM+1wNflT
         dxb1tTLONyD0tYgRqdQ/gDl73I8U0yKyMo2tOPLVRlSykpju+NlxSN1kj0JnQdFiIyab
         hzuBINm9rbOZph/9SKKpyjuDIwweEVO3lq6jIo2tlm4dUVOpPmehUqniEDN6qIUm6Fnt
         N3Aw==
X-Gm-Message-State: APjAAAXDlSEEzNcf/agsjgeJU9gnNpY7ozPBXcyYywNKT2rOlgg2aU6w
        jBe9+51NUUw5aD0ZJ8rjVeBkLw==
X-Google-Smtp-Source: APXvYqxlwCtWVIeqSWNPyeiO1Zvjxtcd6+21+Dr/KyIW9UCRHmAKi1NUfC5srjjkBFwN/NXsOhfJ6A==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr36252780pgg.379.1557818007151;
        Tue, 14 May 2019 00:13:27 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id y14sm18254920pga.54.2019.05.14.00.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 00:13:26 -0700 (PDT)
Date:   Tue, 14 May 2019 12:43:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed
 grading
Message-ID: <20190514071322.avosfk4fzz2hzzx6@vireshk-i7>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557742902.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-05-19, 11:01, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
> registering cpufreq-dt.

Who will apply patches 3-5 ?

-- 
viresh
