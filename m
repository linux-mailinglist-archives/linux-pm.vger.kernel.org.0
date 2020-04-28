Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92631BB953
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD1I4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgD1I4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 04:56:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E209C03C1A9
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 01:56:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so10346387pfc.12
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlWsWgzvjaY6Zm713YqzHXb7hr0bB1APBMwSRZ1R5jQ=;
        b=x9bXsXHqaZwzQh11fgkLu9FwrsX7MONN5jJgeHm5EGQz3imOH1hWREYUBEmY/8LhEs
         paVGxCfQASR13jlekWOmNiE/5ETm4L0wemAzcCxWQdPF8MEekG31DnWCniZ5y8tTZNo5
         Jjagg3er6eiTO97t9DMXhwrWbn84zjQCivHYbc5HGj8owg0nqMRKmUC+0D5edfgHxqiz
         Ad1h4ntdiHG9ZoeoQWAw/KwCbMyPVKKOraZwH6pd2Oooay0HJktN11ASNkZjrV3AKhMY
         XVPIm+B7w844ZulwJFCmp8gAx6a2bUpiq3A+kVh+NsGnFeSBlzazWSjUSB9o7Ny+yo1B
         F1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlWsWgzvjaY6Zm713YqzHXb7hr0bB1APBMwSRZ1R5jQ=;
        b=t1HVEJlFPAKXRJR1+5WKtclFi2feKB3Lron5N/NtjCzo8Bni9tOFB2bXRw0ZxSPiB+
         7NHBjKOwfCTXLAyXJx3OtXDHDERkXpq3PytPHEVYWukd4XxySje85nXBJfA/B6OOzA6l
         OQIU5QMdAlyrBlRLOn1Jd0Gd052SnCoRUVrPLfW890kHLXrHc9mZdqbQ4wbozFUW3te4
         Pf179iCeiS2OKbME0GZ6pJNV+FKf71w/TFQWcdRaM33z7xwdRsNtTIoYEnZZhCd9S9ND
         u2gnDqEhh3EfiFYwlg4lSmOvtdRVlGIdD5rTQkxKfmPB1Kz4RBxJ6SkbJRSsa8S0mJkX
         eedQ==
X-Gm-Message-State: AGi0PuZottuBGbIZJBAdQHDKor72mKj+yLuRZy1eiP9JvEA0fbiy8EVh
        Qe24ynQNRtqAKH9q8F1tP1xoIw==
X-Google-Smtp-Source: APiQypLfHyrNiZidn8JIOhptq3liNhjWyq1CmeTN5XT8QBCqjEeYVZJ6n/4C5fL/Y8PZ3RJyC65LBw==
X-Received: by 2002:a63:63c1:: with SMTP id x184mr12378474pgb.116.1588064201941;
        Tue, 28 Apr 2020 01:56:41 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id g22sm1498422pju.21.2020.04.28.01.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 01:56:41 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:26:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, rjw@rjwysocki.net,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: imx-cpufreq-dt: support i.MX7ULP
Message-ID: <20200428085639.6kt6qxxu44omajug@vireshk-i7>
References: <1588058460-11105-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588058460-11105-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-04-20, 15:21, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX7ULP's ARM core clock design is totally different compared
> with i.MX7D/8M SoCs which supported by imx-cpufreq-dt. It needs
> get_intermediate and target_intermedate to configure clk MUX ready,
> before let OPP configure ARM core clk.
>                                           |---FIRC
>      |------RUN---...---SCS(MUX2) --------|
> ARM --(MUX1)                              |---SPLL_PFD0(CLK_SET_RATE_GATE)
>      |------HSRUN--...--HSRUN_SCS(MUX3)---|
>                                           |---SRIC
> 
> FIRC is step clk, SPLL_PFD0 is the normal clk driving ARM core.
> MUX2 and MUX3 share same inputs. So if MUX2/MUX3 both sources from
> SPLL_PFD0, both MUXes will lose input when configure SPLL_PFD0.
> So the target_intermediate will configure MUX2/MUX3 to FIRC, to avoid
> ARM core lose clk when configure SPLL_PFD0.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Fix boot break. Tested on i.MX8MN DDR4 EVK.

Applied. Thanks.

-- 
viresh
