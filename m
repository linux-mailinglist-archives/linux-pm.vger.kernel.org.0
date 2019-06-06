Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130D836A59
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 05:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFFDIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 23:08:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44914 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFDIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 23:08:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so454187pgp.11
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2019 20:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=157Y1FSkEpgFHORp56rh1nI0WU8l5d95hEqCJnoZ1zQ=;
        b=S11yJqAQvNMNx/FLEr4GLL3lNC1xffvpUIhbLiWYBUpL9Hrn0RqPwY+PG/vnm5Dfm0
         SXXlfcidEPOgKIoLrxYaOeOP5S1gZu9hHtDOwcLg2OPDvjVnUIcnc8P4iT5694iOiNkH
         NyF3OcUXkW6G0JXJM40e8MGS3m/RnCugrTEUtAEOeUGwb6fahD/Gpsrha1/TZN/LbPb8
         1YLs6o9/3hFaSaho6fgLs++G09g38mvPzPK/X0XoGaWeCa0lm0CQkN8n4jN+obPv411s
         mu1w2VkfCo8L0wqb3t3NOZqgbw+13uRvrh23/k3/kqbGQHFOOttSC4/Uq8pTsxygSVSH
         EZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=157Y1FSkEpgFHORp56rh1nI0WU8l5d95hEqCJnoZ1zQ=;
        b=i7nQSS8ufqgWGlH/MOPfeO+OkExSWY9ywX4Fk27EDr6DbvC9jtJPSZBGWOLwUMmJgA
         Oeyy1n44q1DGPfbXWDCxVFmmmPP3QP3wol7wOHBhpbpHvnrt9/p2GJhOsZgLFpnz6itk
         5qxkfP0i04oswP49DD1V7rmqFv7NFbQPqDTmKoxWi/04BZnmGDsppSKdL9t1MEWIEP5+
         1ohWuS4tQE6zhm0D4xfp2l9K4QB34DX11f3tQcUiRYzA2HXcL6mYD3eb1EKujfAQuiVD
         EEczE6R+9D1+k38FYF3EEQI1d4OfbjjbTDxbDJZT1EIFU7Wzy1PmKtP5ohBQ8HeaIXb6
         R9fQ==
X-Gm-Message-State: APjAAAX0Zwvc3x+bFtvIXc1EGXLjP7FZ1tMCy4GO7zQI3SIEAlpoF0yr
        ExS5gAaE9bKPxv7uMwod6Zo6xg==
X-Google-Smtp-Source: APXvYqx8jN0DbcEzxR1c+CvAck59cwW4vwDnsu02/f7RDZiy8JeYL6Qeh0npBCnvbGQnn7ms24iGQA==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr8973487pfi.207.1559790521317;
        Wed, 05 Jun 2019 20:08:41 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id n37sm353110pjb.0.2019.06.05.20.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 20:08:40 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:38:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add imx7d speed grading and higher OPPs
Message-ID: <20190606030838.l45zjkdl6uycp75j@vireshk-i7>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-06-19, 13:37, Leonard Crestez wrote:
> Changes since v1:
>  * Remove the match list from imx-cpufreq-dt
>  * Split arch and cpufreq changes
> Link to v1: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=124427
> 
> Leonard Crestez (5):
>   cpufreq: imx-cpufreq-dt: Remove global platform match list

Added following to this patch:

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>

>   cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading

Applied the first two patches. Thanks.

-- 
viresh
