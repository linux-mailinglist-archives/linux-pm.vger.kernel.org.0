Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685222DC266
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLPOl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 09:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgLPOl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 09:41:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BFC06179C
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 06:40:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g185so2669390wmf.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cNv9msuBa10TFyxrstRST9VstGrywWuFBx64QzPqIM4=;
        b=H0xqzFSFu3X6jKNKwr5nqgZoLDhNPsTMELDHMRBvpLg+ph3ztIC4oyd8/L3SNZAhXy
         T3pqX444aL++h0EgHpWbSYmQl+EE6xVqg+cw0FYaGtb34Tbrd0eaoZusfCjfn5BRb0Wr
         /PmnL+FumWIgidKTf43h0I8+17us0FoAwjlZkKFYdBzwgWtOfo6HOkqrWJttVPAx26wv
         +2Iv+Cu2Z/60l+HxgB2yv/3OSw+K7fw8l+GGdLXH9GHSZjKPk3UCXJP0NyCBfuxJHmBN
         glX+Mys2n34GiCcofv8RhhZq4benbbn/6kPmako8lZRL/HNBG6qoSaEJPZcw8WxTgsN/
         GQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cNv9msuBa10TFyxrstRST9VstGrywWuFBx64QzPqIM4=;
        b=qpOIMC1eZLijI4MoI2ckxGAwCXzp1qP0UCDzct/WBBAzfIExxOlU3+WGgYV7GKpHdQ
         ubh93zG4sNs1120ppugbZRnSyTuFrLpqn04PjuyhsV/Ljonkcz6iSceO3RDaRW9Pzb32
         MxFAz3vNH0q37pfbQDP8eJesscazcqjA1VabXKBAiuJzZXbG2Wfsx6qULhyGPHLxuyj6
         N6kvwhQHGwFwTgvkz5AgEoKLXS5ImNG+kmvO00NbrI7D/31Op3ufcqzN2bAYCWhEcRdT
         2M0tLGydxoRCLueDXsOcExddQJeupKATpECc/0bIh7HdYJVgIJnAgsoR1S9f+N/RZyWv
         4goA==
X-Gm-Message-State: AOAM533WbzUeEH1ngehcdOsrrolHSH626nWcrdMDIetMUzMagLY5seJ2
        StIKGUmzzg0rz7hTWLnhVTlz4w==
X-Google-Smtp-Source: ABdhPJzLtmlHNS5yFaylgc7KqV7K8o+uhMIJpLTvgTyx5y/o/urCJeF1QXsel0V0lQd+Bz1wGo2JcA==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr3705453wme.150.1608129647688;
        Wed, 16 Dec 2020 06:40:47 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id d9sm3599594wrc.87.2020.12.16.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:40:47 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:40:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Alex Levin <levinale@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add peripheral device charger
Message-ID: <20201216144045.GG207743@dell>
References: <20201215023120.2514920-1-dnojiri@chromium.org>
 <20201215214303.2825937-1-dnojiri@chromium.org>
 <20201215214303.2825937-2-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215214303.2825937-2-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 15 Dec 2020, Daisuke Nojiri wrote:

> This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---

When submitting subsequent patch versions, it's best practice to:

 - Submit it on its own i.e. not in reply-to the previous version
 - Indicate the version number in the subject line: [PATCH v2 1/2]
 - Apply a change-log - usually located just after the '---' marker
 
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
